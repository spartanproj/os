int strcmp(char *first, char *second) {
    while(*first==*second) {
        if (*first=='\0'||*second=='\0')
            break;
        first++;
        second++;
    }
    if (*first=='\0'&&*second=='\0')
        return 0;
    else
        return -1;
}
int cmp(char * typed, char * target, void (*call_back)()) {
    // if typed==target, call call_back() then return 1
    if ((!strcmp(typed,target) && !strcmp(typed,target)) || (!memcmp(typed,target,1024) && !memcmp(typed,target,1024))) {
        // why are we checking this 3 times?
        // it seems to be liable to a bug where the return is wrong
        // happens about once every 10/12 times
        // with 2 it happens every ~(11^2)==121 times
        call_back();
        return 1;
    } 
    return 0;
}
