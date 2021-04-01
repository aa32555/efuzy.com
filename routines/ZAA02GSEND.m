ZAA02GSEND ;PG&A,ZAA02G-SEND,1.36,ROUTINES;6MAR96 3:32P;;;26JAN98  15:35
 ;Copyright (C) 1983, Patterson, Gray and Associates, Inc.
 ;
 K (ZAA02G,ZAA02GP,TIME,SINGLE,FREEPORT,%UTILITY,TELNET) S:$G(ZAA02G(1)) ZAA02G(1)=0 D ^ZAA02GSEND1 Q
DIRECT R !,"Is this a local or remote transmission (L or R) ? ",DIRECT#1,! S:DIRECT?1L DIRECT=$C($A(DIRECT)-32) I DIRECT?1U,"LR"[DIRECT S:DIRECT="L" RSEL=LRSEL,GSEL=LGSEL G CONNECT
 Q:DIRECT=""  W " ???",*7 G DIRECT
CONNECT W !,"wait while connecting to remote site..." S DV=MODEM U DV X LECHOF W:LOS="PSM" *-1 W $C(13),"S DV=0 "_ECHOFN_" D CONR^ZAA02GSEND2",$C(13) W:$D(TELNET) !
 U 0 W ! F C=1:1:4 D READ Q:A["CONNECTV2.0"  U 0 W !,"[",A,"]" G:C=4 CONER
 U 0 W !! S TRC=$P($T(TRC)," ",2,99),TRCA=$P($T(TRCA)," ",2,99),TRCB=$P($T(TRCB)," ",2,99),TRCC=$P($T(TRCC)," ",2,99),LRT="" D TRCCE
 U MODEM W "*",OS,"\",TYPE,"\",DIRECT,"\",XR,"\",ECHOON,"\",ECHOOFF,"\",$S(TYPE="R":RSEL,1:GSEL),"\",$S($D(XX):$A(XX),1:20),"\",ECHOFN,"\*",$C(13) W:$D(TELNET) ! D READ
 U 0 G:A'=OS CONER S S=1 D UTIL G:TYPE="G" LOCXMT^ZAA02GSEND3:DIRECT="L",LOCRCV^ZAA02GSEND3 G LOCRCV:DIRECT="R",LOCXMT
CONER W !!,"....unable to make connection...you may need to download ZAA02GSEND to remote site." H 2 Q
READ U MODEM S t=$P($H,",",2)+10 F I=1:1:99 R *A:4 Q:$P($H,",",2)>t  I A=1 R A#3:4 R A#A:10 Q
 Q
UTIL S UTIL="^UTILITY(%J)" G:$G(DIRECT)="L" UTILL I TYPE="R" S:RSEL["{" UTIL=$P(RSEL,"{",2),RSEL=$P(RSEL,"{") Q
 S:GSEL["{" UTIL=$P(GSEL,"{",2),GSEL=$P(GSEL,"{") Q
UTILL I TYPE="R" S:LRSEL["{" UTIL=$P(LRSEL,"{",2),LRSEL=$P(LRSEL,"{") Q
 S:LGSEL["{" UTIL=$P(LGSEL,"{",2),LGSEL=$P(LGSEL,"{") Q
TRC U 0 S %R=%R-4#20+5,%C=IN*39+1 W @ZAA02GP,*13,ZAA02G("CS"),@ZAA02GP,$E(DT,1,38) U MODEM
TRCA S DT=$S($D(C(0)):C(0),1:"") X:B=1 TRC U 0 W "." U MODEM
TRCB U 0 W:LRT="" ZAA02G("F"),!!!,"---------------SEND------------------  -----------------RECEIVE-----------------" S:$L(LRT)>230 LRT=$P($E(LRT,$L(LRT)-230,255),",",2,199) S:RT]"" LRT=LRT_RT_"," W ZAA02G("H"),LRT,ZAA02G("CL") X TRCC U MODEM
TRCCE S:DIRECT="R" TRCC="I 1" S %R=4,%C=1,rTC="rTC="_ZAA02GP,@rTC Q
TRCC W rTC,rT," ",rT\($P($H,",",2)-rTM+1),"---"
REMXMT W $C(1),"001Y" X ECHOON,SEL,ECHOOFF W *20 S %N=$O(@UTIL@(0))'=""
 D XF S (M,RT,NM,rT)=0,BB="D=D+"_XR,(TRC,TRCB,TRCA)="I $T",rTM=$P($H,",",2)
 X "F ER=0:0:4 S LN=NM,LR=RT,RT=$O(@UTIL@(RT)),NM=NM+1 Q:RT=""""  ZL @RT X XFR1"
 S D="A="_XR,A="",@D,C=1_","_A,C(1)="" X XFR Q
LOCXMT X:$D(RESTART) RESTART X:'$D(RESTART) LRSEL S %N=$O(@UTIL@(0))'=""
 W !! D XF S (ER,M,rT)=0,BB="D=D+"_LXR,rTM=$P($H,",",2) S:$D(RESTART)=0 (RT,NM)=0 K C
 I %N X "F ER=0:0:4 S LN=NM,LR=RT,RT=$O(@UTIL@(RT)),NM=NM+1 Q:RT=""""  ZL @RT X TRCB,XFR1"
 U 0 I ER=9 S %R=24,%C=10 W @ZAA02GP,"TOO MANY ERRORS - TRANSFER CANCELLED ON - ",RT G EXIT
 S D="A="_LXR,A="",@D,C=1_","_A,C(1)="" X XFR S %R=24,%C=20 U 0 W @ZAA02GP I %N W "ROUTINE TRANSFER COMPLETED",*7 H 1 W *7 H 1 W *7
 G EXIT
CLEAR F J=1:1 R A:1 Q:A=""&('$T)
 Q
LOCRCV D READ Q:A'="Y"  K C S O=LOS,XR=LXR,(LRT,RT)="" D ROURCV^ZAA02GSEND2 D REMSEL U 0 X TRCB U MODEM X RRCV Q
REMSEL U 0 W !,"Please answer the selection questions from the remote site:",!!,ZAA02G("RON")
LOCR1 S D=MODEM,XT="I B[TR S J=200,A=B,B=""""",B="" D ENTRY^ZAA02GSEND1 W ZAA02G("ROF"),!! S DV=MODEM X LECHOF Q
 ;
OS D:$D(ZAA02G)<11 INIT^ZAA02GDEV D OSP^ZAA02GSEND2 Q:OS=""  I $G(QT)'=0 U 0 W !,"Operating System Codes:  Local=",LOS,"  Remote=",OS,!!
 Q
EXIT I '$D(QT) W " - PRESS RETURN " R A#1
 Q
 ;
XF S SZB=1514,XFR=$P($T(XFR),";",2,255),X1=$P($T(X1),";",2,255),XFR1=$P($T(XFR1),";",2,255),XFR2=$P($T(XFR2),";",2,255),XFR3=$P($T(XFR3),";",2,255),XFR4=$P($T(XFR4),";",2,255) Q
XFR ;S M=M+1,DT=M_","_C,IN=0 X TRC W $C(1)_$E(1000+$L(DT),2,4)_DT,! X XFR2,XFR3 S DT=B,IN=1,B=B[("Y "_M) X TRC S SZB=SZB+$S('B:$S(SZB>500:-256,1:0),SZB<3000:32,1:0) Q:B  S ER=ER+1,A=1,K=K-C,M=M-1 H 1
XFR1 ;K C F K=0:0 S:'$D(C) (SZ,C,D)=0,C(0)=RT_"+"_K Q:ER>8  S A=$TR($T(+K),$C(9)," "),SZ=SZ+$L(A)+4,rT=rT+$L(A)+4 X:$L(A)>255 XFR4 S:SZ<SZB K=K+1,C=C+1,C(C)=A,@BB I SZ'<SZB!'$L(A)!($S<1300)!$D(SINGLE) S C=C_","_D_","_SZB X XFR Q:'$L(A)  K C
XFR2 ;F B=1:1:+C S DT=C(B) W $C(1)_$E(1000+$L(DT),2,4),DT,! X TRCA
XFR3 ;F  R *B:20 Q:B<0  I B=1 R B#3:10 X $S(B:"R B#B:10",1:"S B=""""") Q
XFR4 ;S C=C+1,E=A,A=$E(A,1,254),C(C)=A,@BB,A=" ***"_$E(E,255,511)
X1 ;S A="Aborted - No Response from remote site",$ZE="W A F ZAA02GI=1:1:3 W *7 H 1",**
 ;
