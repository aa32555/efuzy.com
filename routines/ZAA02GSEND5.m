ZAA02GSEND5 ;PG&A,ZAA02G-SEND,1.36,LOGON,DIALUP DISPATCH ROUTINE;12JUL96 3:08P;;;29FEB2000  17:09
 ;Copyright (C) 1984, Patterson, Gray and Associates, Inc.
BEG S ZAA02GSENDG=$S($D(^%ZAA02GSEND)#2:^%ZAA02GSEND,1:"^ZAA02GSEND")
 I $D(@ZAA02GSENDG@("XLOGIN")) X ^("XLOGIN") Q:$D(DONE)
 S:'$D(ZAA02G) ZAA02G(1)=0 X ^ZAA02G("ECHO-OFF")
 R D:20 Q:'$T  F J=1:1:5 R A:1 Q:'$T  S D=D_A Q:D["CARRIER"  Q:D["CONNECT"
 Q:D=""  Q:D["CARRIER"  R A:0,A:0,A:0
 ; I A'=""!$T D FILTER C $I H 2 H
 I '$D(@ZAA02GSENDG@("FILES")) G BEG1
 S $X=0 R "Do you want to Upload/Download Files via Kermit (Y or N) - ",A#1:20 G EXIT:A="" I "Yy"[A W A G SENDK
 G:"Nn"'[A EXIT W !!
BEG1 S $X=0 R "Enter Login Code - ",A#15:20 G:'$T EXIT2 R:A="" A#15:20 G EXIT2:A=""  S @ZAA02GSENDG@("LOG",+$H,$P($H,",",2))=A_$S($G(^ZAA02G("OS"))="MSM":","_$ZDEV($I),1:"")
 S B=$S($D(@ZAA02GSENDG@("LOGIN"))#2=0:"MUMPS",1:@ZAA02GSENDG@("LOGIN")) S UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ",LC="abcdefghijklmnopqrstuvwxyz",A=$TR(A,LC,UP) I A=$TR(B,LC,UP) G UCI
 I A="KERMIT" G SENDK
 I $D(@ZAA02GSENDG@("PASSWD",A))#2 X ^(A) Q
 W "  Invalid Code" G EXIT
UCI X ^ZAA02G("ECHO-ON") I $D(@ZAA02GSENDG@("LOGINROUTINE"))#2 G @^("LOGINROUTINE")
 W "Code accepted",!! S C=32,LOS=^ZAA02G("OS") I LOS="MSM" S C=0 F V=0:1:5 F U=1:1:30 S B=$ZU(U,V) I B]"" W !?5,C+1,?8,B S C=C+1,A(C)=V*32+U
 R !!,"Enter UCI number - ",U,!! G:U="" LCL I U>0,U<(C+1) X $S(LOS="PSM":"ZC U",LOS="MSM":"V 2:$J:A(U):2",1:"I 0") K A,C
 E  W " INVALID UCI # - NO CHANGE MADE"
LCL W #,!,"You are in PROGRAMMER MODE in UCI " X $S(LOS="PSM":"W $ZD",LOS="MSM":"W $ZU(0)",1:"") W !
 I LOS="PSM" X "ZU  V 168:$J:16" S $ZE="K  ZR  W !" X "*"
 I LOS="MSM" V 0:$J:$V(0,$J,2)\2*2+1:2 K  Q
 K  Q
EXIT X ^ZAA02G("ECHO-OFF") W *10,*10 X "F J=1:1:$X W *8" D FILTER C $I H
EXIT2 C $I H
 ;
FILTER I $A(A)=$C(27) G PRINT
 S A=^ZAA02G("OS") I "M11,PSM"[A W *-1 Q
 I A="DTM" U 0:ta=0 R *A:0 U 0:ta=1 Q
 R "",A:0,A:0,A:0 Q
LOG S Y="20\RHLS\3\ZAA02G-SEND LOGIN LOG",Y(0)="\EX\@ZAA02GSENDG@(""LOG"")\$$LOGD^ZAA02GSEND5(TO)" D ^ZAA02GPOP Q:X=""  Q:X[":EX"  S DT=X
 S Y="18,10\RHLSP3\3\LOG ON: "_$$LOGD(DT),Y(0)="\EX\@ZAA02GSENDG@(""LOG"",DT)\$$LOGT^ZAA02GSEND5(TO)" D ^ZAA02GPOP Q:X=""  Q:X[":EX"
 Q
LOGD(X) S K=X>21608+305+X,YR=4*K+3\1461,D=K*4+3-(1461*YR)+4\4,M=5*D-3\153,D=5*D-3-(153*M)+5\5,M=M+2,YR=M\12+YR+140,M=M#12+1,K="/" S:ZAA02G("d") K=M,M=D,D=K,K="." S YR=YR*100+M*100+D,X=$E(YR,4,5)_K_$E(YR,6,7)_K_$E(YR,2,3) K K,M,D Q X
LOGT(TM) S K=$S($D(@ZAA02GSENDG@("LOG",DT,TM))#2:^(TM),1:""),TM=TM\60,TM=$E(TM\60+100,2,3)_":"_$E(TM#60+100,2,3) Q TM_"  "_K
 ;
PRINT S B=$O(^PRINT(""),-1)+1,^PRINT(B,1)=$C(27)_A,C=2 F J=1:1 R A:5 Q:A=""!'$T  S ^PRINT(B,C)=A,C=C+1
 Q
 ;
RECEIVEK W !!!,"Ready to RECEIVE file(s) via KERMIT",!!,"You may start your transfer at any time within the next 2 minutes",!!
 S MODEM=0,ER=0,KP="",GLOB="^ZAA02GKERMIT("_(+$H)_","_$P($H,",",2)_")",FGLOB=GLOB D INIT^ZAA02GSENDA,REXE^ZAA02GSENDE
 Q:$G(ERR)  W !!,"TRANSFER COMPLETED" Q
 ;
SENDK ; SEND/RECEIVE KERMIT FILES
 W !!,"Upload or Download (U or D) - " R A#1 Q:A=""  W A G:"Uu"[A RECEIVEK G:"Ff"[A RKERMIT^ZAA02GFAXFXS I "Dd"'[A W " ??" H 1 G SENDK
 W A X ^ZAA02G("ECHO-ON") W !! S A="" F J=1:1 S A=$O(@ZAA02GSENDG@("FILES",A)) Q:A=""  W J,?3,A,?20,$P(^(A),"`"),! S A(J)=A_","_$P(^(A),"`",2)
 W !!,"Which File (1-",J-1,") - " R A I A="" W !!,"no file selected",!! G BEG
 I '$D(A(A)) W " ???" G SENDK
 W !!,"Make sure you select KERMIT for the download transfer",!!,"It will start momentarily - Start download on your computer",!! H 5
 S @ZAA02GSENDG@("LOG",+$H,$P($H,",",2))="Download - "_$P(A(A),",")
 S GLOB="^ZAA02GKERMIT("_(+$H)_","_$P($H,",",2)_")",@GLOB@(0,"FILE",1)=$P(A(A),","),^(1,0)=$P(A(A),",",2),MODEM=$I,SFL=0,KP="" D SENDGLO^ZAA02GSENDD
 H 5 W !!,$S('$G(ER):"DOWNLOAD COMPLETED",1:"TOO MANY ERRORS - DOWNLOAD CANCELLED") H 2 W "+++" H 2 W "ATH",*13 C 0 H
