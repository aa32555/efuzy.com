ZAA02GS ;PG&A,ZAA02G-SEND,1.30,ROUTINES;04/24/95;Ver 2.11;MG
 ;Copyright (C) 1983, Patterson, Gray and Associates, Inc.
 ;
 K (ZAA02G,ZAA02GP,TIME) D ^ZAA02GSEND1 Q
DIRECT R !,"Is this a local or remote transmission (L or R) ? ",DIRECT#1,! S:DIRECT?1L DIRECT=$C($A(DIRECT)-32) I DIRECT?1U,"LR"[DIRECT S:DIRECT="L" RSEL=LRSEL,GSEL=LGSEL G CONNECT
 Q:DIRECT=""  W " ???",*7 G DIRECT
CONNECT W !,"wait while connecting to remote site..." S DV=MODEM X LECHOF W:LOS="PSM" *-1 D CLEAR W "S DV=0 ",ECHOFN," D CONR^ZAA02GSEND2",*13
 U 0 W ! F I=1:1:18 U MODEM R A:3 X:$E(A)="C"&($L(A)<7) "R B:3 S A=A_B" U 0 W !,"[",A,"]" Q:A["CONNECT"  I I=18 W !!
 S TRC=$P($T(TRC)," ",2,99),TRCA=$P($T(TRCA)," ",2,99),TRCB=$P($T(TRCB)," ",2,99),LRT=""
 U MODEM W "*",OS,"\",TYPE,"\",DIRECT,"\",XR,"\",ECHOON,"\",ECHOOFF,"\",$S(TYPE="R":RSEL,1:GSEL),"\",$S($D(XX):$A(XX),1:20),"\",ECHOFN,"\*",*13 R C I C["CONNECT" R C
 U 0 I C'=OS W !!,"....unable to make connection...you may need to download ZAA02GSEND to remote site." H 2 Q
 U 0 S S=1 G:TYPE="G" LOCXMT^ZAA02GSEND3:DIRECT="L",LOCRCV^ZAA02GSEND3 G LOCRCV:DIRECT="R",LOCXMT
TRC U 0 S %R=%R-4#20+5,%C=IN*39+1 W @ZAA02GP,*13,ZAA02G("CS"),@ZAA02GP,$E(DT,1,38) U MODEM
TRCA S DT=$S($D(C(0)):C(0),1:"") X:B=1 TRC U 0 W "." U MODEM
TRCB U 0 W:LRT="" ZAA02G("F"),!!!,"---------------SEND------------------  -----------------RECEIVE-----------------" S:$L(LRT)>230 LRT=$P($E(LRT,$L(LRT)-230,255),",",2,199) S:RT]"" LRT=LRT_RT_"," W ZAA02G("H"),LRT,ZAA02G("CL") U MODEM
REMXMT W "Y",*13 X ECHOON,SEL,ECHOOFF W *20 S %N=$O(^UTILITY(%J,0))'=""
 D XF S M=0,RT=0,NM=0,BB="D=D+"_XR,(TRC,TRCB,TRCA)="H 0"
 X "F ER=0:0:4 S LN=NM,LR=RT,RT=$O(^UTILITY(%J,RT)),NM=NM+1 Q:RT=""""  ZL @RT K C S (A,C(1))=RT,D=""A=""_XR,@D,C=1_"",""_A X XFR,XFR1"
 S D="A="_XR,A="",@D,C=1_","_A,C(1)="" X XFR Q
LOCXMT X:'$D(RESTART) LRSEL S %N=$O(^UTILITY(%J,0))'=""
 W !! D XF S (ER,M)=0,BB="D=D+"_LXR S:$D(RESTART)=0 RT=0,NM=0 K C
 I %N X "F ER=0:0:4 S LN=NM,LR=RT,RT=$O(^UTILITY(%J,RT)),NM=NM+1 Q:RT=""""  ZL @RT X TRCB K C S (A,C(1))=RT,D=""A=""_LXR,@D,C=1_"",""_A X XFR,XFR1"
 U 0 I ER=9 S %R=24,%C=10 W @ZAA02GP,"TOO MANY ERRORS - TRANSFER CANCELLED ON - ",RT," - PRESS RETURN" R A#1 Q
 S D="A="_LXR,A="",@D,C=1_","_A,C(1)="" X XFR I %N S %R=24,%C=20 U 0 W @ZAA02GP,"ROUTINE TRANSFER COMPLETED - PRESS RETURN",*7 H 1 W *7 H 1 W *7 R A#1
 G EXIT
RESTART S RESTART=1,RT=LR,NM=LN G CONNECT
CLEAR F J=1:1 R A:1 Q:A=""&('$T)
 Q
COPY K ^UTILITY($J) S A=99 F J=1:1 S A=$O(^%RSET($J,A)) Q:A=""  S ^UTILITY($J,A)=""
 Q
COPY1 K ^UTILITY($J) S A=99 F J=1:1 S A=$O(^%GSET($J,A)) Q:A=""  S ^UTILITY($J,A)=""
 Q
LOCRCV U MODEM R A Q:A'="Y"  K C S O=LOS,XR=LXR,(LRT,RT)="" D ROURCV^ZAA02GSEND2 D REMSEL U 0 X TRCB U MODEM X RRCV Q
REMSEL U 0 W !,"Please answer the selection questions from the remote site:",!!,ZAA02G("RON")
LOCR1 S D=MODEM,XT="I B[TR S J=200,A=B,B=""""",B="" D ENTRY^ZAA02GSEND1 W ZAA02G("ROF"),!! S DV=MODEM X LECHOF Q
 ;
OS ; I ^ZAA02G("OS")="MSM" U MODEM D INIT^ZAA02GDEV U 0
 D:$D(ZAA02G)<11 INIT^ZAA02GDEV D OSP^ZAA02GSEND2 Q:OS=""  I $G(QT)'=0 U 0 W !,"Operating System Codes:  Local=",LOS,"  Remote=",OS,!!
 ;
EXIT Q
 ;
 ;
XF S XFR=$P($T(XFR),";",2,255),X1=$P($T(X1),";",2,255),XFR1=$P($T(XFR1),";",2,255),XFR2=$P($T(XFR2),";",2,255) Q
XFR ;S M=M+1 F ER=0:1:9 S DT=M_","_C_$C(13),IN=0 X TRC W DT X XFR2 R B:20 S DT=B,IN=1 X TRC Q:B[("Y "_M)  X "F KK=1:1 R B:2 S DT=B X TRC Q:B[(""Y ""_M)  Q:'$T" Q:B[("Y "_M)
XFR1 ;K C S (C,D)=0,C(0)=RT F K=1:1 Q:ER>8  S A=$T(+K),C=C+1,C(C)=A,@BB I K#15=0!'$L(A)!($S<1300)!$D(SINGLE) S C=C_","_D X XFR S (C,D)=0,C(0)=RT_"+"_K Q:'$L(A)
XFR2 ;F B=1:1:+C S DT=C(B) S:$L(DT)<255!(OS'="PSM") DT=DT_$C(13) W DT X TRCA
X1 ;S A="Aborted - No Response from remote site",$ZE="W A F ZAA02GI=1:1:3 W *7 H 1",**
 ;
