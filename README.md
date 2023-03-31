## os
### Authored by [werdl](https://github.com/werdl)
#### x86 OS that can do some things
- maybe ARM but not rn 
- will just have to rewrite some asm
#### FAQ
Q: Why AGPL?<br>
A: Source code should be available<br>
Q: Why x86?<br>
A: Because ARM asm is hard<br>
Q: Keyboard input isn't working!! oh no!<br>
A: it works on my machine...
   actually the reason is probably your keyboard.
try running with qemu-system-i386<br>
Q: the makefile isn't working!! help!!!<br>
A: do you have everything installed?
   If you do, try modifying the makefile a bit.<br>
#### Things it can do
- print
- input (halway through processing)
- kernel panic 😎
- kernel print
- IDT
- memory allocation that is there but I haven't used...
#### Plans
- libc
- keyboard 
- shell
- text based GUI
- "port" a rewritten [`Rosemary`](http://github.com/werdl/rosemary)
#### Compiling
##### You will need:
- a gcc cross compiler (and binutils) for i386 or i686((here)[https://wiki.osdev.org/GCC_Cross-Compiler]'s how to get that)
- qemu-system-i386 (`sudo apt install -y qemu-system-i386` or the package manager on your distro (check the internet if you're not on Linux or it's not working.))
- patience
##### Steps:
- `git clone` this repo
- install to your dir of choice.
- run `make && make run` to compile and run it. Then ctrl-c in your terminal to clean everything up.
##### I don't have make!
- Just copy the commands in one by one
- If you are on Windows, I recommend you try WSL or Cygwin.
