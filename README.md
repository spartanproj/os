# NerdOS
### Good luck with install (you'll need it)
![logo](https://user-images.githubusercontent.com/116349156/230002827-37baf026-b826-40c4-85a0-2b2b54621a1b.png)
### Authored by [werdl](https://github.com/werdl)
![Lines of code](https://sloc.xyz/github/spartanproj/os) ![License](https://badgen.net/github/license/spartanproj/os?color=red) ![Last commit](https://badgen.net/github/last-commit/spartanproj/os?color=orange)
#### x86 OS that can do some things
- maybe ARM but not rn 
- will just have to rewrite some asm
#### FAQ
**Q**: Why AGPL?<br>
**A**: Source code should be available<br>
**Q**: Why x86?<br>
**A**: Because ARM asm is hard<br>
**Q**: Keyboard input isn't working!! oh no!<br>
**A**: it works on my machine...
   actually the reason is probably your keyboard.
try running with qemu-system-i386<br>
**Q**: the makefile isn't working!! help!!!<br>
**A**: do you have everything installed?
   If you do, try modifying the makefile a bit.<br>
#### Things it can do
- print
- input
- kernel panic 😎
- kernel print
- IDT
- print integers of any base
- random numbers (done with Unix system time)
- memory allocation that is there but I haven't used...
- A few basic commands, but mainly shells will be in userspace
#### Plans
- libc
- text based GUI
- "port" a rewritten [`Rosemary`](http://github.com/werdl/rosemary)
#### Compiling
##### You will need:
- A Unix-like environment (Windows no, BSD variants probably, MacOS maybe but hard, Cygwin yes, Linux yes, other old Unix variants (eg Irix) probably?? maybe source install for packages)
- a gcc cross compiler (and binutils) for i386 or i686 ([here](https://wiki.osdev.org/GCC_Cross-Compiler)'s how to get that)
- qemu-system-i386 (`brew install -y qemu-system-i386` or the package manager on your distro (check the internet if it's not working.))
- patience
##### Steps:
- `git clone` this repo
- install to your dir of choice.
- run `make && make run` to compile and run it. Then ctrl-c in your terminal to clean everything up.
##### I don't have make!
- If you don't have make, get it. You will need a Unix env anyway so it will pay off
- If you are on Windows, I recommend you try WSL (Debian/similar) or Cygwin.
#### How does random work?
##### In a nutshell:
At compile time, a bash script is run that grabs the Unix epoch time using `date +%s`. This is then written into a little header file along with some other RNG stuff. **DO NOT CHANGE THE NUMBERS** unless you know what you are doing!
