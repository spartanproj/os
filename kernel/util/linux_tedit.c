#include <string.h>
#include <unistd.h>
#include <termios.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <time.h>
#include <stdarg.h>
#include <fcntl.h>
#define TEDIT_V "0.1.0"
#define TEDIT_TAB 4
#define TEDIT_QUIT_TIME 2
#define HIGHLIGHT_NUMS (1<<0)
#define HIGHLIGHT_STRING (1<<1)
struct AppendBuffer {
    char * b;
    int len;
};
#define AB_INIT {NULL,0}
void AppendAB(struct AppendBuffer * ab,char * s,int len) {
    char * new=realloc(ab->b,ab->len+len);
    if (new==NULL) return;
    memcpy(&new[ab->len],s,len);
    ab->b=new;
    ab->len+=len;
}
void FreeAB(struct AppendBuffer * ab) {
    free(ab->b);
}
typedef struct {
    char * filetype;
    char ** filematch;
    char ** keywords;
    char * SingleLineCommentStart;
    char * MultilineEnd;
    char * MultilineStart;
    int flags;
} SyntaxInfo;
typedef struct {
    int size;
    char * chars;
    int RenderSize;
    char * render;
    unsigned char * hl;
    char * selected;
    int idx;
    int HL_OPEN_COMMENT;
} EditorRow;
struct GlobalConfig {
    int cx;
    int cy;
    int rx;
    int RowOffset;
    int ColumnOffset;
    int screenrows;
    int screencols;
    struct termios _orig;
    int numrows;
    EditorRow *row;
    char * filename;
    char StatusMsg[80];
    time_t StatusTime;
    int dirty;
    SyntaxInfo * syntax;
};
enum HighlightColors {
    HL_NORMAL=0,
    HL_NUMBER,
    HL_MATCH,
    HL_STRING,
    HL_COMMENT,
    HL_KEYWORD1,
    HL_KEYWORD2,
    HL_KEYWORD3,
    HL_BRACKET,
    HL_COMPARISON,
    HL_MLCOMMENT
};
struct GlobalConfig editor;
char * CHighlightingExtemsopms[]={".c",".h",".cpp",".cxx",",hpp",".hxx",NULL};
char * CHighlightingKeywords[]={
    "switch","while","for","break","continue","return","if","else","case",
    "struct|","union|","typedef|","static|","const|","#define|","class|","enum|",
    "int%","long%","float%","double%","char%","unsigned%","signed%","void%","bool%"
};
char * PythonKW[]={
            "for","while","break","continue","def","return","import","from"
            "int|","float|","double|","str|","bool|","range|",
            "if%","elif%","else%","match%","case%"
        };
char * PythonExt[]={
            ".py"
};
SyntaxInfo HighlightDatabase[] = {
    {
        "C",
        CHighlightingExtemsopms,
        CHighlightingKeywords,
        "//",
        "*/",
        "/*",
        HIGHLIGHT_NUMS | HIGHLIGHT_STRING
    },
    {
        "Python",
        PythonExt,
        PythonKW,
        "#",
        "\"\"\"",
        "\"\"\"",
        HIGHLIGHT_NUMS | HIGHLIGHT_STRING
    }
};
#define HighlightDBEntries (sizeof(HighlightDatabase)/sizeof(HighlightDatabase[0]))
void TildeColumn(struct AppendBuffer * ab);
void SaveFile(void);
void SetStatusMsg(const char *fmt,...);
#define ctrl(k) ((k) & 0x1f)
int CharsToRender(EditorRow * row,int cx) {
    int rx=0;
    for (int j=0;j<cx;j++) {
        if (row->chars[j]=='\t') rx+=(TEDIT_TAB-1)-(rx%TEDIT_TAB);
        rx++;
    }
    return rx;
}
int RenderToChars(EditorRow *row, int rx) {
  int cur_rx = 0;
  int cx;
  for (cx = 0; cx < row->size; cx++) {
    if (row->chars[cx] == '\t')
      cur_rx += (TEDIT_TAB - 1) - (cur_rx % TEDIT_TAB);
    cur_rx++;
    if (cur_rx > rx) return cx;
  }
  return cx;
}
void ScrollScreen(void) {
    editor.rx=editor.cx;
    if (editor.cy<editor.numrows) editor.rx=CharsToRender(&editor.row[editor.cy],editor.cx);
    if (editor.cy<editor.RowOffset) editor.RowOffset=editor.cy;
    if (editor.cy>editor.RowOffset+editor.screenrows) editor.RowOffset=editor.cy-editor.screenrows-1;
    if (editor.cx<editor.ColumnOffset) editor.ColumnOffset=editor.rx;
    if (editor.cx>=editor.ColumnOffset+editor.screencols) editor.ColumnOffset=editor.rx-editor.screencols+1;
}
void DrawStatusBar(struct AppendBuffer * ab) {
    AppendAB(ab,"\x1b[7m",4);
    char status[80],rstatus[80];
    int len=snprintf(status,sizeof(status),"%.20s - %d lines %s",editor.filename?editor.filename:"[New File]",editor.numrows,editor.dirty?"(modified)":"");
    int rlen=snprintf(rstatus,sizeof(rstatus),"%s line %d",editor.syntax?editor.syntax->filetype:"No Filetype",editor.cy+1);
    if (len>editor.screencols) len=editor.screencols;
    AppendAB(ab,status,len);
    while (len<editor.screencols) {
        if (editor.screencols-len==rlen) {
            AppendAB(ab,rstatus,rlen);
            break;
        } else {
            AppendAB(ab," ",1);
            len++;
        }
    }
    AppendAB(ab,"\x1b[m",3);
    AppendAB(ab,"\r\n",2);
}
void DrawSecondBar(struct AppendBuffer * ab) {
    AppendAB(ab,"\x1b[K",3);
    int msglen=strlen(editor.StatusMsg);
    if (msglen>editor.screencols) msglen=editor.screencols;
    if (msglen && time(NULL)-editor.StatusTime<5) AppendAB(ab,editor.StatusMsg,msglen);
}
void refresh() {
    ScrollScreen();
    struct AppendBuffer _ab = AB_INIT;
    AppendAB(&_ab, "\x1b[?25l", 6);
    AppendAB(&_ab,"\x1b[H", 3);
    TildeColumn(&_ab);
    DrawStatusBar(&_ab);
    DrawSecondBar(&_ab);
    char buf[32];
    snprintf(buf, sizeof(buf), "\x1b[%d;%dH", (editor.cy-editor.RowOffset) + 1,( (editor.rx-editor.ColumnOffset) + 1));
    AppendAB(&_ab, buf, strlen(buf));
    AppendAB(&_ab, "\x1b[?25h", 6);
    write(STDOUT_FILENO, _ab.b, _ab.len);
    FreeAB(&_ab);
}
// VT100
void SetStatusMsg(const char *fmt,...) {
    va_list ap;
    va_start(ap, fmt);
    vsnprintf(editor.StatusMsg, sizeof(editor.StatusMsg), fmt, ap);
    va_end(ap);
    editor.StatusTime = time(NULL);
}
void die(const char * msg) {
    refresh();
    perror(msg);
    exit(1);
}
void NormalMode(void) {
    if (tcsetattr(STDIN_FILENO,TCSAFLUSH,&editor._orig)==-1) die("tcsetattr");
}
void RawMode(void) {
    if (tcgetattr(STDIN_FILENO, &editor._orig)==-1) die("tcgetattr");
    atexit(NormalMode);
    struct termios raw = editor._orig;
    raw.c_iflag &= ~(BRKINT | ICRNL | INPCK | ISTRIP | IXON);
    raw.c_oflag &= ~(OPOST);
    raw.c_cflag |= (CS8); // bitmask
    raw.c_lflag &= ~(ECHO | ICANON | IEXTEN | ISIG);
    raw.c_cc[VMIN] = 0;
    raw.c_cc[VTIME] = 1;
    // raw mode flags
    if (tcsetattr(STDIN_FILENO,TCSAFLUSH,&raw)==-1) die("tcsetattr");
}
enum SpecialKeys {
    BKSP=127,
    ARROW_LEFT = 4242, // H2G2 (value is not important, just out of char type range)
    ARROW_RIGHT,
    ARROW_UP,
    ARROW_DOWN,
    PAGE_UP,
    PAGE_DOWN,
    HOME_KEY,
    END_KEY,
    DELETE_KEY,
    INSERT_KEY
};
int ReadKey(void) {
    int retcode;
    char cur;
    while ((retcode = read(STDIN_FILENO, &cur, 1)) != 1) {
        if (retcode == -1 && errno != EAGAIN) die("read");
    }
    if (cur == '\x1b') {
        char seq[3];
        if (read(STDIN_FILENO, &seq[0], 1) != 1) return '\x1b';
        if (read(STDIN_FILENO, &seq[1], 1) != 1) return '\x1b';
        if (seq[0] == '[') {
            if (seq[1] >= '0' && seq[1] <= '9') {
                if (read(STDIN_FILENO, &seq[2], 1) != 1) return '\x1b';
                if (seq[2] == '~') {
                    switch (seq[1]) {
                        case '1': return HOME_KEY;
                        case '2': return INSERT_KEY;
                        case '3': return DELETE_KEY;
                        case '4': return END_KEY;
                        case '5': return PAGE_UP;
                        case '6': return PAGE_DOWN;
                        case '7': return HOME_KEY;
                        case '8': return END_KEY;
                    }
                }
            } else {
                switch (seq[1]) {
                    case 'A': return ARROW_UP;
                    case 'B': return ARROW_DOWN;
                    case 'C': return ARROW_RIGHT;
                    case 'D': return ARROW_LEFT;
                    case 'H': return HOME_KEY;
                    case 'F': return END_KEY;
                }
            }
        } else if (seq[0] == 'O') {
            switch (seq[1]) {
                case 'H': return HOME_KEY;
                case 'F': return END_KEY;
            }
        }
        return '\x1b';
    } 
    return cur;
}
int IsSeperator(int c) {
    return isspace(c) || c=='\0' || strchr(",.()+-/*+~%<>[];",c)!=NULL;
}
void UpdateSyntax(EditorRow * row) {
    row->hl=realloc(row->hl,row->RenderSize);
    memset(row->hl,HL_NORMAL,row->RenderSize);
    if (editor.syntax==NULL) return;
    char ** keywords=editor.syntax->keywords;
    char * scs=editor.syntax->SingleLineCommentStart;
    char * mcs=editor.syntax->MultilineStart;
    char * mce=editor.syntax->MultilineEnd;
    int ScsLen=scs?strlen(scs):0;
    int MceLen=scs?strlen(mce):0;
    int McsLen=scs?strlen(mcs):0;
    int prevsep=1;
    int prevdig=0;
    int instring=0;
    int incomment=(row->idx > 0 && editor.row[row->idx - 1].HL_OPEN_COMMENT);
    for (int i=0;i<row->RenderSize;i++) {
        
        unsigned char PreviousHighlight=i>0?row->hl[i-1]:HL_NORMAL;
        if (ScsLen && !instring) {
            if (!strncmp(&row->render[i],scs,ScsLen)) {
                memset(&row->hl[i],HL_COMMENT,row->RenderSize-i);
                break;
            }
        }
        if (McsLen && MceLen && !instring) {
            if (incomment) {
                row->hl[i] = HL_MLCOMMENT;
                if (!strncmp(&row->render[i], mce, MceLen)) {
                    memset(&row->hl[i], HL_MLCOMMENT, MceLen);
                    i += MceLen-1;
                    incomment = 0;
                    prevsep = 1;
                    continue;
                } else {
                    continue;
                }
            } else if (!strncmp(&row->render[i], mcs, McsLen)) {
                memset(&row->hl[i], HL_MLCOMMENT, McsLen);
                i += McsLen-1;
                incomment = 1;
                continue;
            }
        }
        if (editor.syntax->flags & HIGHLIGHT_STRING) {
            if (instring) {
                row->hl[i]=HL_STRING;
                if (row->render[i]=='\\'&&i+1<row->RenderSize) {
                    row->hl[i+1]=HL_STRING;
                    i++;// extra
                    continue;
                }
                if (row->render[i]==instring) instring=0;
                prevsep=1;
                continue;
            } else {
                 if (row->render[i]=='"' || row->render[i]=='\'') {
                    instring=row->render[i];
                    row->hl[i]=HL_STRING;
                    continue;
                 }
            }
        }
        if (editor.syntax->flags & HIGHLIGHT_NUMS) {
            if (((isdigit(row->render[i]) || (prevdig && row->render[i]=='x')) && (prevsep || PreviousHighlight == HL_NUMBER)) ||
            (row->render[i] == '.' && PreviousHighlight == HL_NUMBER)) {
                row->hl[i]=HL_NUMBER;
                prevsep=0;
                continue;
            }
        }
        if (prevsep) {
            int j;
            for (j=0;keywords[j];j++) {
                int jlen=strlen(keywords[j]);
                int kw2=keywords[j][jlen-1]=='|';
                int kw3=keywords[j][jlen-1]=='%';
                if (kw2 || kw3) jlen--;
                int KW_CONST=kw2?HL_KEYWORD1:HL_KEYWORD2;
                if (kw3) KW_CONST=HL_KEYWORD3;
                if (!strncmp(&row->render[i],keywords[j],jlen) && IsSeperator(row->render[i+jlen])) {
                    memset(&row->hl[i],KW_CONST,jlen);
                    i+=jlen-1;
                    break;
                }
            }
            if (keywords[j] != NULL) {
                prevsep = 0;
                continue;
            }
        }
        if (strchr("[](){}",row->render[i])!=NULL && !instring) {
            memset(&row->hl[i],HL_BRACKET,1);
        }
        if (strchr("<>=!",row->render[i])!=NULL && !instring) {
            memset(&row->hl[i],HL_COMPARISON,1);
        }
        prevsep=IsSeperator(row->render[i]);
        prevdig=isdigit(row->render[i]) || ((prevdig) && row->render[i]=='x');
    }
    int changed=(row->HL_OPEN_COMMENT!=incomment);
    row->HL_OPEN_COMMENT=incomment;
    if (changed && row->idx+1<editor.numrows) UpdateSyntax(&editor.row[row->idx+1]);
}
int SyntaxToColor(int hl) {
    switch (hl) {
        case HL_NUMBER: return 31;
        case HL_MATCH: return 34;
        case HL_STRING: return 35;
        case HL_COMMENT: return 36;
        case HL_MLCOMMENT: return 36;
        case HL_KEYWORD1: return 33;
        case HL_KEYWORD2: return 32;
        case HL_KEYWORD3: return 96;
        case HL_BRACKET: return 92;
        case HL_COMPARISON: return 93;
        default: return 37;
    }
}
void SelectSyntaxHighlighter(void) {
    editor.syntax=NULL;
    if (editor.filename==NULL) return;
    for (unsigned int j=0;j<HighlightDBEntries;j++) {
        SyntaxInfo * s=&HighlightDatabase[j];
        unsigned int i=0;
        while (s->filematch[i]) {
            char * p=strstr(editor.filename,s->filematch[i]);
            int patlen=strlen(s->filematch[i]);
            if (p!=NULL) {
                if (s->filematch[i][0] != '.'|| (p[patlen]=='\0')) {
                    editor.syntax=s;
                    for (int fr=0;fr<editor.numrows;fr++) {
                        UpdateSyntax(&editor.row[fr]);
                    }
                    return;
                }
            }
            i++;
        }
    }
    editor.syntax=NULL;
    return;
}
void UpdateRow(EditorRow * row) {
    int tabs=0;
    for (int i=0;i<row->size;i++) {
        if (row->chars[i]=='\t') tabs++;
    }
    free(row->render);
    row->render=malloc(row->size+1+tabs*(TEDIT_TAB-1));
    int idx=0;
    for (int j=0;j<row->size;j++) {
        if (row->chars[j]=='\t') {
            row->render[idx++]=' ';
            while (idx % TEDIT_TAB != 0) row->render[idx++] = ' ';
        } else {
            row->render[idx++]=row->chars[j];
        }
    }
    row->render[idx]=0;
    row->RenderSize=idx;
    UpdateSyntax(row);
}
void NewRow(int at, char * s,size_t len) {
    if (at<0 || at > editor.numrows) return;
    editor.row=realloc((void *)editor.row,sizeof(EditorRow)*(editor.numrows+1));
    memmove(&editor.row[at+1],&editor.row[at],sizeof(EditorRow)*(editor.numrows-at));
    for (int j = at + 1; j <= editor.numrows; j++) editor.row[j].idx++;
    editor.row[at].idx=at;
    editor.row[at].size=len;
    editor.row[at].chars=malloc(len + 1);
    memcpy(editor.row[at].chars,s,len);
    editor.row[at].chars[len]='\0';
    editor.row[at].RenderSize=0;
    editor.row[at].render=NULL;
    editor.row[at].hl=NULL;  
    editor.row[at].HL_OPEN_COMMENT=0;  
    UpdateRow(&editor.row[at]);
    editor.numrows++;
    editor.dirty++;
}
void FreeRow(EditorRow * row) {
    free(row->render);
    free(row->chars);
    free(row->hl);
}
void DeleteRow(int at) {
    if (at<0 || at>=editor.numrows) return;
    FreeRow(&editor.row[at]);
    memmove(&editor.row[at], &editor.row[at + 1], sizeof(EditorRow) * (editor.numrows - at - 1));
    for (int j = at; j < editor.numrows - 1; j++) editor.row[j].idx--;
    editor.numrows--;
    editor.dirty++;
}
void RowInsertChar(EditorRow * row, int at, int c) {
    if (at<0 || at>row->size) at=row->size;
    row->chars=realloc(row->chars,row->size+2);
    memmove(&row->chars[at + 1], &row->chars[at], row->size - at + 1);
    row->size++;
    row->chars[at]=c;
    UpdateRow(row);
    editor.dirty++;
}
void RowDeleteChar(EditorRow * row, int at) {
    if (at<0 || at>=row->size) return;
    memmove(&row->chars[at], &row->chars[at + 1], row->size - at);
    row->size--;
    UpdateRow(row);
    editor.dirty++;
}
void RowAppendString(EditorRow * row,char * s, size_t len) {
    row->chars = realloc(row->chars, row->size + len + 1);
    memcpy(&row->chars[row->size], s, len);
    row->size += len;
    row->chars[row->size] = '\0';
    UpdateRow(row);
    editor.dirty++;
}
void DeleteChar(void) {
    if (editor.cy==editor.numrows) return;
    if (editor.cx==0 && editor.cy==0) return;
    EditorRow *row = &editor.row[editor.cy];
    if (editor.cx > 0) {
        RowDeleteChar(row, editor.cx - 1);
        editor.cx--;
    } else {
        editor.cx=editor.row[editor.cy-1].size;
        RowAppendString(&editor.row[editor.cy-1],row->chars,row->size);
        DeleteRow(editor.cy);
        editor.cy--;
    }
}
void InsertChar(int c) {
    if (editor.cy==editor.numrows) NewRow(editor.numrows,"",0);
    RowInsertChar(&editor.row[editor.cy],editor.cx,c);
    editor.cx++;
}
void InsertNewline(void) {
    if (editor.cx==0) NewRow(editor.cy,"",0);
    else {
        EditorRow * row=&editor.row[editor.cy];
        row=&editor.row[editor.cy];
        row->size=editor.cx;
        row->chars[row->size]='\0';
        UpdateRow(row);
    }
    editor.cy++;
    editor.cx=0;
}
char * PromptUser(char * prompt, void (*callback)(char *, int)) {
    size_t bufsize=128;
    char * buf=malloc(bufsize);
    size_t buflen=0;
    buf[0]='\0';
    while (1) {
        SetStatusMsg(prompt,buf);
        refresh();
        int c=ReadKey();
        if (c == DELETE_KEY || c == ctrl('h') || c == BKSP) {
            if (buflen != 0) buf[--buflen] = '\0';
        } else if (c=='\x1b') {
            SetStatusMsg("Cancelled Prompt");
            if (callback) callback(buf,c);
            free(buf);
            return NULL;
        } else if (c=='\r') {
            if (buflen!=0) {
                SetStatusMsg("");
                if (callback) callback(buf,c);
                return buf;
            }
        } else if (!iscntrl(c) && c<128) {
            if (buflen==bufsize-1) {
                bufsize*=2;
                buf=realloc(buf,bufsize);
            }
            buf[buflen++]=c;
            buf[buflen]='\0';
        }
        if (callback) callback(buf,c);
    }
}
void MoveCursor(int key) {
    EditorRow * row=(editor.cy>=editor.numrows)?NULL:&editor.row[editor.cy];
    switch (key) {
        case ARROW_LEFT:
            if (editor.cx!=0) editor.cx--;
            else if (editor.cy>0) editor.cy--, editor.cx=editor.row[editor.cy].size;
            break;
        case ARROW_RIGHT:
            if (row && editor.cx<row->size) editor.cx++;
            else if (row && editor.cx==row->size) editor.cy++,editor.cx=0;
            break;
        case ARROW_UP:
            if (editor.cy!=0) editor.cy--;
            break;
        case ARROW_DOWN:
            if (editor.cy<editor.numrows+1) editor.cy++;
            break;
    }
    row=(editor.cy>=editor.numrows)?NULL:&editor.row[editor.cy];
    int rowlen=row?row->size:0;
    if (editor.cx>rowlen) {
        editor.cx=rowlen;
    }
}
void FindStrCallback(char * query, int key) {
    static int LastMatch=-1;
    static int direction=1;
    static int SaveHighlightLine;
    static char * SavedHighlight=NULL;
    if (SavedHighlight) {
        memcpy(editor.row[SaveHighlightLine].hl,SavedHighlight,editor.row[SaveHighlightLine].RenderSize);
        free(SavedHighlight);
        SavedHighlight=NULL;
    
    }
    if (key == '\r' || key == '\x1b') {
        LastMatch=-1;
        direction=1;
        return;
    } else if (key == ARROW_RIGHT || key == ARROW_DOWN) {
        direction = 1;
    } else if (key == ARROW_LEFT || key == ARROW_UP) {
        direction = -1;
    } else {
        LastMatch = -1;
        direction = 1;
    }
    if (query==NULL) return;
    if (LastMatch == -1) direction = 1;
    int current = LastMatch;
    for (int i=0;i<editor.numrows;i++) {
        current+=direction;
        if (current==-1) current=editor.numrows-1;
        else if (current==editor.numrows) current=0;
        EditorRow * row=&editor.row[current];
        char * match=strstr(row->render,query);
        if (match) {
            LastMatch=current;
            editor.cy=current;
            editor.cx=RenderToChars(row,match-row->render);
            editor.RowOffset=editor.numrows;
            SaveHighlightLine=current;
            SavedHighlight=malloc(row->RenderSize);
            memcpy(SavedHighlight,row->hl,row->RenderSize);
            memset(&row->hl[match - row->render], HL_MATCH, strlen(query));
            break;
        }
    }
}
void FindStr(void) {
    char * query=PromptUser("Search: %s (ESC to cancel)",FindStrCallback);
    if (query) {
        free(query);
    }
}
void ProcessKey(void) {
    static int QuitTimes=TEDIT_QUIT_TIME;
    int cur=ReadKey();
    switch (cur) {
        case '\r':
            InsertNewline();
            break;
        case BKSP:
        case ctrl('h'):
        case DELETE_KEY:
            DeleteChar();
            break;
        case ctrl('q'):
            if (editor.dirty && QuitTimes>0) {
                SetStatusMsg("Unsaved Changes, press Ctrl-Q %d more time%s to quit.",QuitTimes,QuitTimes==1?"":"s");
                QuitTimes--;
                return;
            }
            refresh();
            for (int j=0;j<editor.screencols+1;j++) {
                printf("\n");
            }
            exit(0);
            break;
        case ARROW_UP:
        case ARROW_DOWN:
        case ARROW_LEFT:
        case ARROW_RIGHT:
            MoveCursor(cur);
            break;
        case PAGE_UP:
        case PAGE_DOWN:
            {
                if (cur==PAGE_UP) editor.cy=editor.RowOffset;
                else if (cur==PAGE_DOWN) {
                    editor.cy=editor.RowOffset+editor.screenrows-1;
                    if (editor.cy>editor.numrows) editor.cy=editor.numrows;
                }
            }
            break;
        case HOME_KEY:
            editor.cx=0;
            break;
        case INSERT_KEY:
            
        case END_KEY:
            if (editor.cy<editor.numrows) editor.cx=editor.row[editor.cy].size;
            break;
        case ctrl('l'):
        case '\x1b':
            break;
        case ctrl('s'):
            SaveFile();
            break;
        case ctrl('f'):
            FindStr();
            break;
        default:
            InsertChar(cur);
            break;
    }
    QuitTimes=TEDIT_QUIT_TIME;
}
int CursorPosition(int * rows, int * cols) {
    char buf[32];
    unsigned int i = 0;
    if (write(STDOUT_FILENO, "\x1b[6n", 4) != 4) return -1;
    while (i < sizeof(buf) - 1) {
        if (read(STDIN_FILENO, &buf[i], 1) != 1) break;
        if (buf[i] == 'R') break;
        i++;
    }
    buf[i] = '\0';
    printf("\r\n&buf[1]: '%s'\r\n", &buf[1]);
    if (sscanf(&buf[2], "%d;%d", rows, cols) != 2) return -1;
    ReadKey();
    return -1;
}
int WinSize(int * rows, int * columns) {
    struct winsize ws;
    if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &ws) == -1 || ws.ws_col == 0) {
        if (write(STDOUT_FILENO, "\x1b[999C\x1b[999B", 12) != 12) return -1; // fallback
        ReadKey();
        return CursorPosition(rows,columns);
    } else {
        *columns = ws.ws_col;
        *rows = ws.ws_row;
        return 0;
    }
}
void TildeColumn(struct AppendBuffer *ab) {
    int y;
    for (y = 0; y < editor.screenrows-2; y++) {
        int filerow = y + editor.RowOffset;
        char buf[32];
        snprintf(buf,32,"%d",filerow+1);
        AppendAB(ab, "\x1b[32;1m", 8);
        AppendAB(ab,buf,strlen(buf));
        AppendAB(ab, "\x1b[30;0m ", 8);
        if (filerow >= editor.numrows) {
            if (editor.numrows == 0 && y == editor.screenrows / 3) {
                char welcome[80];
                int welcomelen = snprintf(welcome, sizeof(welcome),
                "Tedit editor -- version %s", TEDIT_V);
                if (welcomelen > editor.screencols) welcomelen = editor.screencols;
                int padding = (editor.screencols - welcomelen) / 2;
                if (padding) {
                    AppendAB(ab, "~", 1);
                    padding--;
                }
                while (padding--) AppendAB(ab, " ", 1);
                AppendAB(ab, welcome, welcomelen);
            } else {
                AppendAB(ab, "~", 1);
            }
        } else {
            int len = editor.row[filerow].RenderSize - editor.ColumnOffset;
            if (len < 0) len = 0;
            if (len > editor.screencols) len = editor.screencols;
            char *c = &editor.row[filerow].render[editor.ColumnOffset];
            unsigned char *hl = &editor.row[filerow].hl[editor.ColumnOffset];
            int CurrentColor=-1;
            int j;
            for (j = 0; j < len; j++) {
                if (iscntrl(c[j])) {
                    char sym=(c[j]<=26) ? '@'+c[j]:'?';
                    AppendAB(ab, "\x1b[7m", 4);
                    AppendAB(ab, &sym, 1);
                    AppendAB(ab, "\x1b[m", 3);
                } else if (hl[j] == HL_NORMAL) {
                    if (CurrentColor!=-1) {
                        AppendAB(ab, "\x1b[39m", 5);
                        CurrentColor=-1;
                    }
                    AppendAB(ab, &c[j], 1);
                } else {
                    int color = SyntaxToColor(hl[j]);
                    if (color!=CurrentColor) {
                        CurrentColor=color;
                        char buf[16];
                        int clen = snprintf(buf, sizeof(buf), "\x1b[%dm", color);
                        AppendAB(ab, buf, clen);
                    }
                    AppendAB(ab, &c[j], 1);
                }
            }
            AppendAB(ab, "\x1b[39m", 5);
        }
        AppendAB(ab, "\x1b[K", 3);
        AppendAB(ab, "\r\n", 2);
    }
}
char * RowsToString(int * buflen) {
    int totlen=0;
    for (int j=0;j<editor.numrows;j++) {
        totlen+=editor.row[j].size+1;
    }
    *buflen=totlen;
    char * buf=malloc(totlen);
    char * p=buf;
    for (int j=0;j<editor.numrows;j++) {
        memcpy(p,editor.row[j].chars,editor.row[j].size);
        p+=editor.row[j].size;
        *p='\n';
        p++;
    }
    return buf;
}
void OpenFile(char * filename) {
    free(editor.filename);
    editor.filename=strdup(filename);
    SelectSyntaxHighlighter();
    FILE * fp=fopen(filename,"r");
    if (!fp) die("fopen");
    char * line=NULL;
    size_t linecap=0;
    ssize_t linelen;
    while ((linelen = getline(&line, &linecap, fp)) != -1) {
        while (linelen > 0 && (line[linelen - 1] == '\n' || line[linelen - 1] == '\r')) linelen--;
        NewRow(editor.numrows,line, linelen);
    }
    free(line);
    fclose(fp);
    editor.dirty=0;
}
void SaveFile(void) {
    if (editor.filename == NULL) {
        editor.filename=PromptUser("Save as %s:",NULL);
        if (editor.filename==NULL) {
            SetStatusMsg("Aborted Save Operation");
            return;
        }
        SelectSyntaxHighlighter();
    }
    int len;
    char *buf = RowsToString(&len);
    int fd = open(editor.filename, O_RDWR | O_CREAT, 0644);
    if (fd != -1) {
        if (ftruncate(fd, len) != -1) {
            if (write(fd, buf, len) == len) {
                close(fd);
                free(buf);
                SetStatusMsg("%d bytes written to disk", len);
                editor.dirty=0;
                refresh();
                return;
            }
        }
        close(fd);
    }
    free(buf);
    SetStatusMsg("I/O error: %s",strerror(errno));
    editor.dirty=0;
    refresh();
}
void init(void) {
    editor.cx=0;
    editor.cy=0;
    editor.rx=0;
    editor.RowOffset=0;
    editor.ColumnOffset=0;
    editor.numrows=0;
    editor.row=NULL;
    editor.screenrows-=2;
    editor.filename=NULL;
    editor.dirty=0;
    editor.StatusMsg[0]='\0';
    editor.syntax=NULL;
    if (WinSize(&editor.screenrows,&editor.screencols)==-1) die("WinSize");
}
int main(int argc, char ** argv) {
    RawMode();
    init();
    if (argc>=2) {
        OpenFile(argv[1]);
    }
    SetStatusMsg("Ctrl-Q to Quit");
    while (true) {
        refresh();
        ProcessKey();
    }
    return 0;
}
