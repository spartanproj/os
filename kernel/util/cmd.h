void checktype() {
	bool toclear=false;
	bool q=true;
	bool playing=false;
	int toss;
	int ucounter=0;
	if (typed[0]=="o" && typed[1]=="n" && q==true && typed[2]=="ENTER") {
			q=false;
			printrn=true;
			debug=true;
			printf("Ok, debugging on!\n");
			mse_nl();
			toclear=true;
		} else if (typed[0]=="o" && typed[1]=="f" && typed[2]=="f" && typed[3]=="ENTER" && q==true) {
			q=false;
			printf("Ok, no debugging\n");
			mse_nl();
			toclear=true;
		} else if (typed[0]=="s" && typed[1]=="o" && typed[2]=="m" && typed[3]=="e" && typed[4]=="ENTER" && q==true){
			printf("Ok, some debugging on!\n");
			mse_nl();
			q=false;
			debug=true;
		}
		 if (typed[0]=="e" && typed[1]=="c" && typed[2]=="ENTER"){ 
			printf("HI!");
			mse_nl();
			printf("\n");
			counter=0;
			toclear=true;
		} else if 
(typed[0]=="e" && typed[1]=="c"&&typed[2]=="h"&&typed[3]=="o" && typed[4]=="ENTER") {
			for (int k=5;previoustyped[k]!="\0"&&typed[k]!="ENTER";k++) {
				printf(previoustyped[k]);
			}
			// printf("hello from echo!");
			mse_nl();
			printf("\n");
			counter=0; // reset stor FEATURE (its like not a bug (defo deliberate))
			toclear=true;
		} else if (typed[0]=="l" && typed[1]=="o"&&typed[2]=="g"&&typed[3]=="i" && typed[4]=="n" &&typed[5]==" " && typed[6]=="p" && typed[7]=="a"&&typed[8]=="s"&&typed[9]=="s"&&typed[10]=="ENTER") {
			printf("Logged in as sudo\n");
			mse_nl();
			sudo=true;
			toclear=true;
		} else if(typed[0]=="h"&&typed[1]=="l"&&typed[2]=="t"&&typed[3]=="ENTER") {
			if (sudo==true) {
				printf("HALTING");
				panic("processes halted by sudo","hlt",1);
				return;
			} else {
				printf("You no sudo...\n");
			} toclear=true;
		} else if (typed[0]=="g" && typed[1]=="u" && typed[2]=="i" && typed[3]=="ENTER") {
			printf("Boot into text based GUI");
			toclear=true;
			gui();
		} else if (typed[0]=="q" && typed[1]=="ENTER") {
			quitgui=true;
			toclear=true;
		} else if (typed[0]=="e"&&typed[1]=="d"&&typed[2]=="i"&&typed[3]=="t"&& typed[4]=="ENTER") {
			text_edit();
			toclear=true;
		} else if (typed[0]=="t" && typed[1]=="i" && typed[2]=="c" && typed[3]=="ENTER") {
			tic();
			toclear=true;
			printf("\n\n");
			setclr(10,0);
			printf("Type your commands below.\n");
			mse_nl();
			setclr(defcol(),0);
		}
		else if (typed[0]=="L-CTRL"&&typed[1]=="L-ALT"&& typed[2]=="t") {
			panic("end","hlt",1);
			return;
		}  else if (typed[0]=="r" && typed[1]=="a" && typed[2]=="n" && typed[3]=="d" && typed[4]=="ENTER") {
			char buff[15];
			itoa(rand(),buff,10);
			printf(buff);
			printf("\n");
			toclear=true;
		} else if (typed[0]=="c" && typed[1]=="o" && typed[2]=="i" && typed[3]=="n" && typed[4]=="ENTER") {
			playing=true;
			toss=rand()%2;
			
			printf("Enter your number (0 or 1)\n");
			toclear=true;
		} else if (typed[0]=="0" && typed[1]=="ENTER" && playing==true) {
			setclr(5,0);
			printf("toss was....\n");
			printn(toss);
			printf("\n");
			setclr(defcol(),0);
			if(toss==0) {
				printf("You win! Good job!\n");
				playing=false;
			} else {
				printf("Not this time...\n");
				playing=false;
			}
			toclear=true;
		} else if (typed[0]=="1" && typed[1]=="ENTER" && playing==true) {
			setclr(5,0);
			printf("toss was....\n");
			printn(toss);
			printf("\n");
			setclr(defcol(),0);
			if(toss==1) {
				printf("You win! Good job!\n");
				playing=false;
			} else {
				printf("Not this time...\n");
				playing=false;
			}
			toclear=true;
			
		} else if (typed[0]=="h" && typed[1]=="i" && typed[2]=="s" && typed[3]=="ENTER") {
			printf(root.o0.contents);
			printf(" ");
			printf(root.o1.contents);
			printf(" ");
			printf(root.o2.contents);
			printf(" ");
			printf(root.o3.contents);
			printf(" ");
			printf(root.o4.contents);
			printf(" ");
			printf(root.o5.contents);
			printf(" ");
			printf(root.o6.contents);
			printf(" ");
			printf(root.o7.contents);
			printf(" ");
			printf(root.o8.contents);
			printf(" ");
			printf(root.o9.contents);
			toclear=true;
		} else if (typed[0]=="2" && typed[1]=="1"&& typed[2]=="ENTER") {
			int lastnum=comp(0);
			for (int y=0;y<1024;y++) {
				typed[y]="\0";
			}
			int typedno=0;
			while (1) {
				if (typed[0]=="0") {
					break;
				} else if (typed[0]!="\0"){
					typedno++;
					lastnum++;
					for (int y=0;y<1024;y++) {
						typed[y]="\0";
					}
				}
				if (typedno>=3) {
					typedno=0;
					break;
				}
			}
			int x;
			while (lastnum<21) {
				lastnum=comp(lastnum);
				while (1) {
					if (typed[0]=="0") {
						break;
					} else if (typed[0]!="\0"){
						typedno++;
						lastnum++;
						for (int y=0;y<1024;y++) {
							typed[y]="\0";
						}
					}
					if (typedno>=3) {
						typedno=0;
						break;
					}
				}
				printn(lastnum);
				break;
				if (lastnum>=21) {break;}
			}
			printf("hmm");
			toclear=true;

			toclear=true;
		} else if (typed[0]=="i" && typed[1]=="n" && typed[2]=="f" && typed[3]=="o" && typed[4]=="ENTER") {
			printf("\n");
			printf(info.contents);
			toclear=true;
		} else if (typed[0]=="w" && typed[1]=="r" && typed[2]=="i" && typed[3]=="t" && typed[4]=="ENTER") {
			int up=strnum(previoustyped[5]);
			writefs("",'w',up);
			for (int k=6;previoustyped[k]!="\0"&&typed[k]!="ENTER";k++) {
				writefs(previoustyped[k],'a',up);
			}
			printf("Done!");
			mse_nl();
			printf("\n");
			toclear=true;
		} else if (typed[0]=="r" && typed[1]=="e" && typed[2]=="a" && typed[3]=="d" && typed[5]=="ENTER") {
			char buffe[1024];
			bool yes=true;
			if (typed[4]=="0") printf(root.o0.contents);
			else if (typed[4]=="1") printf(root.o1.contents);
			else if (typed[4]=="2") printf(root.o2.contents);
			else if (typed[4]=="3") printf(root.o3.contents);
			else if (typed[4]=="4") printf(root.o4.contents);
			else if (typed[4]=="5") printf(root.o5.contents);
			else if (typed[4]=="6") printf(root.o6.contents);
			else if (typed[4]=="7") printf(root.o7.contents);
			else if (typed[4]=="8") printf(root.o8.contents);
			else if (typed[4]=="9") printf(root.o9.contents);
			else {yes=false;}
			if (yes==true) {
				printf("\n");
			}
			toclear=true;
			
		} else if (typed[0]=="d" && typed[1]=="u" && typed[2]=="m" && typed[3]=="p" && typed[4]=="ENTER") {
			dump();
			toclear=true;
		} else if (typed[0]=="p" && typed[1]=="a" && typed[2]=="n" && typed[3]=="i" && typed[4]=="c" && typed[5]=="ENTER" ) {
			panic("Testing purposes.","Initiated by user",1);
		} else if (typed[0]=="t" && typed[1]=="i" && typed[2]=="m" && typed[3]=="e" && typed[4]=="ENTER") {
			printdate();
			toclear=true;
		} else if (typed[0]=="s" && typed[1]=="l" && typed[2]=="e" && typed[3]=="e" && typed[4]=="p" && (typed[7]=="ENTER" || typed[8]=="ENTER")) {
			char buffer[10];
			memcpy(buffer,typed[6],3);
			int buf7=0;
			int buf6=atoi(typed[6])*10;
			if (typed[7]!="ENTER") {
				buf7=atoi(typed[7]);
			} else {
				buf6=atoi(typed[6]);
			}
			int time=buf6+buf7;
			printn(time);
			for (int t=time-1;t>0;t--) {
				sleep(1);
				printn(t);
			}
			toclear=true;
		}  else if (typed[0]=="l" && typed[1]=="s" && typed[2]=="ENTER") {
			printlist();
			toclear=true;
		}
		if (toclear==true) {
			toclear=false;
			for (int y=0;y<1024;y++) {
				typed[y]="\0";
			}
		}
}