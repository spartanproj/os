int cmp(char * typed, char * target, void (*call_back)()) {
    // if typed==target, call call_back() then return 1
    if (!memcmp(typed,target,strlen(target))) {
        call_back();
        return 1;
    } 
    return 0;
}
