int random_number_splash;
char * splash() {
    random_number_splash=rand()%14;
    char * msgs[13] = {
        "Whoops, what a fine mess you're in!",
        "Time past hourmin:54? Reboot :)",
        "42",
        "Wow, compilation successful! Didn't expect that!",
        "Ach, an environment with no Python, no clang, no Go. I love it already!",
        "StackOverflow was useless in this project.",
        "Welcome to NerdOS. Enjoy your stay :)",
        "That beautiful feeling when your code compiles, yet that scary feeling when your code compiles first time",
        "Favourite gcc flag? Mine is -w.",
        "Life! Don't talk to me about life! - Marvin TPA",
        "Light mode = BSOD. Don't argue",
        "Guess the emoji - ⌨️",
        "90% bug free!"
    };
    return msgs[random_number_splash-1];
}