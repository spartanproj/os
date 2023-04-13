# NerdOS
### Good luck with install (you'll need it)
#### To install: 
`curl https://raw.githubusercontent.com/spartanproj/os/master/install.sh -o install.sh;chmod +x install.sh;./install.sh` - This requires sudo access (also Debian based only)!
- If you want to install on a non-Debian based system, install these packages: `build-essential bison flex libgmp3-dev libmpc-dev libmpfr-dev texinfo nasm qemu`

### Authored by [werdl](https://github.com/werdl)

![Lines of code](https://sloc.xyz/github/spartanproj/os) ![License](https://badgen.net/github/license/spartanproj/os?color=red) ![Last commit](https://badgen.net/github/last-commit/spartanproj/os?color=orange)
![logo](https://user-images.githubusercontent.com/116349156/230002827-37baf026-b826-40c4-85a0-2b2b54621a1b.png)
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
- memory allocation
- A few basic commands, but mainly shells will be in userspace
- Tic tac toe & coin flip
- 21 Game
- 'filesystem' WIP

```mermaid
graph TD
subgraph Basics
A1[Print char *]-->B1[Print decimal];
B1-->C1[Print hex];
B1-->D1[Print any base];
C1-->D1;
B1-->E1[Random numbers];
F1[Memory];
G1[Kernel panic];
A1-->G1;
C1-->G1;
A1-->H1[User input];
H1-->I1[Games];
I1-->J1[21];
I1-->K1[Tic tac toe];
E1-->K1;
A1-->H1-->L1[Basic shell];
style A1 fill:green;
style B1 fill:green;
style C1 fill:green;
style D1 fill:green;
style E1 fill:green;
style F1 fill:green;
style G1 fill:green;
style H1 fill:green;
style I1 fill:green;
style J1 fill:#8B8000;
style K1 fill:green;
style L1 fill:green;
end
subgraph Filesystems
F1-->A;
F1-->B;
A[Journaling];
B-->C[FAT32];
B-->D[EXT2];
A-->B[Custom filesystem];
end
subgraph GUI
A1-->G;
E[Bitmaps];
F[Fonts];
B-->E;
E-->F;
E-->G[GUI];
F-->I;
I-->H[GUI Games];
E-->I[LibGUI];
end
subgraph Usability
I-->J[Porting things];
H-->J;
G-->J;
B-->L[LibC];
L-->Q[Rosemary];
J-->Q;
L-->P[Userspace];
end
L-->J;
subgraph External Storage
C-->M[USBs];
D-->M;

C-->O[Initrd];
O-->L;
L-->O;
O-->P;

end
style A fill:green;
style L fill:#8B8000;
style B fill:#8B8000;
style Filesystems fill:#626619
style Basics fill:#0a6127
```
![BSOD](img/bsod.png)
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
- run `make && make run && make clean` to compile and run it. Then ctrl-c in your terminal to clean everything up.
##### It isn't working...
- Establish if you are on an x86 computer (32-bit or 64-bit). If not, virtualise! It does not work on other architectures.
- You are on x86...
- If so, get out your nerd hat, read through the messages, and attempt to self-compile. If you cannot, then 
##### I don't have make!
- If you don't have make, get it. You will need a Unix env anyway so it will pay off
- If you are on Windows, I recommend you try WSL (Debian/similar) or Cygwin.
#### How does random work?
##### In a nutshell:
At compile time, a bash script is run that grabs the Unix epoch time using `date +%s`. This is then written into a little header file along with some other RNG stuff. **DO NOT CHANGE THE NUMBERS** unless you know what you are doing!
