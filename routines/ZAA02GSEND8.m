ZAA02GSEND8 ;PG&A,ZAA02G-SEND,1.36,ASCII TRANSFERS;19DEC95 12:19P;;;04SEP96  16:54
 ;Copyright (C) 1983, Patterson, Gray and Associates, Inc.
 ;
SASCII S %G=B,%N=-1 D OS^ZAA02GSEND S DIRECT="L",RSEL=LRSEL,GSEL=LGSEL G CONNECT
RASCII D OS^ZAA02GSEND S DIRECT="R"
CONNECT S ERR=1 W:QT !,"wait while connecting to remote site..." S DV=MODEM X LECHOF W:LOS="PSM" *-1 D CLEAR W "S DV=0 ",ECHOFN," D CONR^ZAA02GSEND2",*13
 U 0 W:QT ! F I=1:1:18 U MODEM R A:3 X:$E(A)="C"&($L(A)<7) "R B:3 S A=A_B" U 0 W:QT !,"[",A,"]" Q:A["CONNECT"  I I=18 W:QT !!
 ; S TRC="W ""TRC""",TRCA="W ""TRCA""",TRCB="W ""TRCB"""
 U MODEM W "*",OS,"\G\",DIRECT,"\",XR,"\",ECHOON,"\",ECHOOFF,"\",GSEL,"\",$S($D(XX):$A(XX),1:20),"\",ECHOFN,"\*",*13 R C I C["CONNECT" R C
 U 0 I C'=OS W:QT !!,"....unable to make connection...you may need to download ZAA02GSEND to remote site." H 2 G EXIT
 U 0 S S=1,ERR=2 G LOCXMT:DIRECT="L"
 ;
LOCRCV Q
LOCXMT D INIT^ZAA02GSEND3,SYNTX^ZAA02GSEND3 U MODEM D LIST^ZAA02GSEND3
 S %X="",CM=0 U MODEM D XFR^ZAA02GSEND3 R %XA:1 S ERR=0 U 0 W:QT !!,"GLOBAL TRANSFER COMPLETED",! G EXIT
 Q
CLEAR F J=1:1 R A:1 Q:A=""&('$T)
 Q
EXIT I 'ERR Q
 Q
INTER ; interrogation interface for Kermit
 N A S S=0 W "wait..."
 I ^ZAA02G("OS")="DTM" U 0:IXXLATE=0
 U MODEM N B S B="" W *13 F J=1:1:30 R *S:0 S:$L(B) B=B_$C(S) S:S=1 B=$C(1) Q:$A(B)=1&($L(B)>3)&($E(B,3)=" ")  Q:'$T
 U 0 I $A(B)=1 S OS="",S=0 S B=$P(B,$C(1),$L(B,$C(1))) S:$E(B,2)=" " S=$F("NSE",$E(B,3))-1 G INTER1
 D OS2^ZAA02GSEND2
INTER1 U 0 W *13,ZAA02G("CL"),ZAA02G("LO"),"Local System - ",ZAA02G("HI"),LOS,ZAA02G("LO"),"  Remote System - ",ZAA02G("HI"),$S(OS=0:"Unknown",OS'="":OS,1:$P("Not Active,KERMIT Ready to RECEIVE,KERMIT Ready to SEND,KERMIT sent ERROR",",",S+1)),!
 H 2 Q
