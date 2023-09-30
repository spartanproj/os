#ifndef TTY_H
#include <stdio.h>
#endif
#define TEDIT_V "0.1.0-bl"
#define TEDIT_TAB 4
#define TEDIT_QUIT_TIME 2
typedef struct {
    int size;
    char * chars;
    int RenderSize;
    char * render;
    unsigned char * hl;
    char * selected;
    int idx;
    int open_comment
} Tedit_EditorRow;
typedef struct {
    int cx,cy,rx,RowOffset,ColumnOffset,screenrows,screencols,numrows,dirty;
    Tedit_EditorRow * row;
    char * filename;
    char StatusMsg[80];
} Tedit_GlobalConfig;
Tedit_GlobalConfig editor;
int CharsToRender(Tedit_EditorRow * row,int cx) {
    int rx=0;
    for (int j=0;j<cx;j++) {
        if (row->chars[j]=='\t') rx+=(TEDIT_TAB-1)-(rx%TEDIT_TAB);
        rx++;
    }
    return rx;
}
int RenderToChars(Tedit_EditorRow *row, int rx) {
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
void DrawStatusBar(void) {
    setclr(BLACK,WHITE);
    char status[80];
    printf(editor.filename);
    printf(" - ");
    printn(editor.numrows);
    printf("lines ");
    if (editor.dirty) printf("(modified)");
    printf("\n");
    printf(editor.StatusMsg);
}
void refresh(void) {
    ScrollScreen();
    TildeColumn();
    DrawStatusBar(); // also second bar
    
}
int CallTedit(void) {

}