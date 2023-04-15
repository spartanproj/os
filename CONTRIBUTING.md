### Contributing
- The C code here is not that easy, if you don't know C, then this probably isn't the place to learn it, sorry.
- Still here? Great!
- First set up the toolchain with cross compiler
- Then start coding.
- If you have push access then push, else pull request.
- If you are PRing, use the template.
### Coding style
- Tabs: 4
- Pointers: `type * name`
- Curly brackets: after `)`
```c
int function(char * input) {
	printf("Hello, world!");
}
```
- Iterators can have any name
- Try to ensure names are vaguely relevant
```c
int x = 0;
int x=0;
```
- Either is fine, but
```c
int x= 0;
```
- should be avoided
- Don't use unnecessarily complex or long practices
- Try to not add any flags as far as possible, to catch errors later down the line
- use comments only when it might not be obvious what is going on
### A good program
```c
int atoi(char * str) {
    int res = 0;
    for (int i=0;str[i]!='\0';i++) {
        res=res*10+str[i]-'0'; // string to int conversion
    }
    return res;
}
```
### A bad program
```c
int lkadghsflsdkj(char*ldkgjhlgdkjs) {
    int randomthingy= 0;
    for (int iasas =0;ldkgjhlgdkjs[iasasas]!= '\0';i ++) {
        randomthingy =randomthingy*  10+ ldkgjhlgdkjs[iasasa]      -'0';
    }
    return randomthingy;
}
```
https://discord.gg/R5bgPEkFMe - questions here
