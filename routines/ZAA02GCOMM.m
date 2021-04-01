ZAA02GCOMM ;PG&A,ZAA02G-COMM,1.36,ROUTINES;6MAR96 3:32P;Fri, 23 Oct 2015  10:46;;21AUG2000  12:58
 ;Copyright (C) 1983, Patterson, Gray and Associates, Inc.
 ;
 ;  SET NODUAL=0 to disable Dual Channel
 I $D(TCPP) C TCPP K TCPP
 K (ZAA02G,ZAA02GP,TIME,SINGLE,FREEPORT,%UTILITY,TELNET,SHOW,ip,NODUAL) S:$G(ZAA02G(1)) ZAA02G(1)=0 D ^ZAA02GCOMM1 Q
DIRECT W !,$S(TYPE["R":"Routine",1:"Global")," Transfer selected",!!
 R "Is this a local or remote transmission (L or R) ? ",DIRECT#1,! S:DIRECT?1L DIRECT=$C($A(DIRECT)-32) I DIRECT?1U,"LR"[DIRECT S:DIRECT="L" RSEL=LRSEL,GSEL=LGSEL G CONNECT
 Q:DIRECT=""  W " ???",*7 G DIRECT
CONNECT W !,"wait while connecting to remote site..." S DV=MODEM U DV X LECHOF W $C(13),"S DV=0 "_ECHOFN_" D CONR^ZAA02GCOMM2",$C(13) W:$D(TELNET) !
 U 0 W ! F C=1:1:6 D READ Q:A["CONNECTV2.0"  G:C=6 CONER
 S VER=A
 U 0 W !! S TRC=$P($T(TRC)," ",2,99),TRCA=$P($T(TRCA)," ",2,99),TRCB=$P($T(TRCB)," ",2,99),TRCC=$P($T(TRCC)," ",2,99),TRCD=$P($T(TRCD)," ",2,99),LRT="" D TRCCE
 I VER["FAST2",'$D(NODUAL),'$D(SINGLE),OS="M11C"!(OS="M3") S port=$P(VER,"2-",2) S:port="" port=5030 D
 . W !,"Checking streaming channel (port-",port,") - " D XFR5S
 . W "local "_$S(C:"failed ("_C_")",1:"succeeded") I $D(TCPP) S TYPE=TYPE_"F"
 U MODEM W "*",OS,"\",TYPE,"\",DIRECT,"\",XR,"\",ECHOON,"\",ECHOOFF,"\",$S(TYPE["R":RSEL,1:GSEL),"\",$S($D(XX):$A(XX),1:20),"\",ECHOFN,"\*",$C(13) W:$D(TELNET) !
 U 0 W ! F C=1:1:4 D READ Q:A[OS  G:C=4 CONER
 G:A'[OS CONER
 I VER["FAST2",'$D(NODUAL),OS="M11C"!(OS="M3") W !?26,"remote "_$S(A["+":"succeeded",1:"failed")
 I A'["+" S TYPE=$TR(TYPE,"F") C:$D(TCPP) TCPP K TCPP
 S S=1 D UTIL G:TYPE["G" LOCXMT^ZAA02GCOMM3:DIRECT="L",LOCRCV^ZAA02GCOMM3 G LOCRCV:DIRECT="R",LOCXMT
FRC U:MODEM="TCP" MODEM:(:"") U 0 Q
CONER W !!,"....unable to make connection...you may need to download ZAA02GCOMM to remote site." H 2 Q
UTIL S UTIL="^UTILITY(%J)" G:$G(DIRECT)="L" UTILL I TYPE["R" S:RSEL["{" UTIL=$P(RSEL,"{",2),RSEL=$P(RSEL,"{") Q
 S:GSEL["{" UTIL=$P(GSEL,"{",2),GSEL=$P(GSEL,"{") Q
UTILL I TYPE["R" S:LRSEL["{" UTIL=$P(LRSEL,"{",2),LRSEL=$P(LRSEL,"{") Q
 S:LGSEL["{" UTIL=$P(LGSEL,"{",2),LGSEL=$P(LGSEL,"{") Q
READ W "[" U MODEM S t=$P($H,",",2)+10 F  U MODEM R *A:1 Q:$P($H,",",2)>t  Q:A=1  U 0 W $S(A<32:".",1:$C(A))
 I A=1 R A#3:4 R A#A:10
 U 0 W "]" Q
TRC U 0 S %R=%R-7#16+9,%C=IN*39+1 W @ZAA02GP,*13,ZAA02G("CS"),@ZAA02GP,$E(DT,1,38) U MODEM
TRCA S DT=$S($D(C(0)):C(0),1:"") X:B=1 TRC U 0 W:B#10=1 "." U MODEM
TRCB U 0 X:LRT="" TRCD S:$L(LRT)>470 LRT=$P($E(LRT,$L(LRT)-470,99999),",",2,199) S:RT]"" LRT=LRT_RT_"," W ZAA02G("H"),LRT,ZAA02G("CL") X TRCC U $S($G(TYPE)="RF":TCPP,1:MODEM)
TRCD W:LRT="" ZAA02G("F"),!!!!!!,"---------------SEND------------------  -----------------RECEIVE-----------------" I $D(TCPP) W !!,"*** Using dual channels ***"
TRCCE S:DIRECT="R" TRCC="I 1" S %R=7,%C=1,rTC="rTC="_ZAA02GP,@rTC Q
TRCC W rTC,rT," ",rT\($P($H,",",2)-rTM+1),"---"
REMXMT W $C(1),"001Y" X ECHOON,SEL,ECHOOFF W *20 S RT=$O(@UTIL@("")),%N=RT]""
 D XF U 0 R *M:3 S (M,RT,NM,rT)=0,BB="D=D+"_XR,(TRC,TRCB,TRCA)="I $T",rTM=$P($H,",",2)
 I $D(TCPP) U TCPP R *A
 X "F ER=0:0:9 S LN=NM,LR=RT,NM=NM+1,RT=$O(@UTIL@(RT)),ER=0 Q:RT=""""  ZL @RT K C S K=0 X XFR1"
 I XFR1["C(C)" S D="A="_XR,A="",@D,C=1_","_A,C(1)="" X XFR Q
 I XFR1'["C(C)" U TCPP W "000",! R A#3 C TCPP K TCPP
 Q
LOCXMT X:$D(RESTART) RESTART X:'$D(RESTART) LRSEL D FRC S RT=$O(@UTIL@("")),%N=RT]""
 W !! D XF S (ER,M,rT)=0,BB="D=D+"_LXR,rTM=$P($H,",",2) S:$D(RESTART)=0 (RT,NM)=0 K C
 I %N X "F ER=0:0:9 S LN=NM,LR=RT,NM=NM+1,RT=$O(@UTIL@(RT)),ER=0 Q:RT=""""  ZL @RT X TRCB K C S K=0 X XFR1"
 U 0 I ER=9 S %R=24,%C=10 W @ZAA02GP,"TOO MANY ERRORS - TRANSFER CANCELLED ON - ",RT G EXIT
 S RT="..end" X TRCB I XFR1["C(C)" S D="A="_LXR,A="",@D,C=1_","_A,C(1)="" X XFR
 I XFR1'["C(C)" U TCPP W "000",! R A#3 C TCPP K TCPP
 S %R=24,%C=20 U 0 W @ZAA02GP I %N W "ROUTINE TRANSFER COMPLETED",*7 H 1 W *7 H 1 W *7
 G EXIT
CLEAR F J=1:1 R A:1 Q:A=""&('$T)
 Q
LOCRCV D READ Q:A'="Y"  K C S O=LOS,XR=LXR,(LRT,RT)="" D ROURCV^ZAA02GCOMM2 D REMSEL U 0 X TRCB
 U MODEM W 1,! I $D(TCPP) U TCPP W 1,!
 X RRCV
 Q
REMSEL U 0 W !,"Please answer the selection questions from the remote site:",!!,ZAA02G("RON")
LOCR1 S D=MODEM,XT="I B[TR S J=200,A=B,B=""""",B="" D ENTRY^ZAA02GCOMM1 W ZAA02G("ROF"),!! S DV=MODEM X LECHOF Q
 ;
OS D:$D(ZAA02G)<11 INIT^ZAA02GDEV D OSP^ZAA02GCOMM2 Q:OS=""  I $G(QT)'=0 U 0 W !,"Operating System Codes:  Local=",LOS,"  Remote=",OS,!!
 Q
EXIT I '$D(QT) W " - PRESS RETURN " R A#1
 Q
 ;
XF S SZB=$S($G(OS)="MSM":400,1:3000),XFR=$P($T(XFR),";",2,99999),X1=$P($T(X1),";",2,99999),XFR2=$P($T(XFR2),";",2,99999),XFR3=$P($T(XFR3),";",2,99999)
 I LOS'="M11C"&(DIRECT="L")!(OS'="M11C"&(DIRECT="R")) S XFR1=$P($S(TYPE["F":$T(XFR5),1:$T(XFR1)),";",2,99999)
 E  S XFR1=$P($S(TYPE["F":$T(XFR5C),1:$T(XFR1C)),";",2,99999)
 Q:TYPE["F"  K TCPP Q
 ;
XFR ;S M=M+1,DT=M_","_C,IN=0 X TRC W $C(1)_$E(1000+$L(DT),2,4)_DT X XFR2,XFR3 S DT=B,IN=1,B=B[("Y "_M) X TRC S SZB=SZB+$S('B:$S(SZB>500:-256,1:0),SZB<510:0,SZB<900:32,1:0) Q:B  S ER=ER+1,A=1,K=K-C,M=M-1 H 1
XFR1 ;F  S:'$D(C) (SZ,C,D)=0,C(0)=RT_"+"_K Q:ER>8  S A=$TR($T(+K),$C(9)," "),SZ=SZ+$L(A)+4 S:A'[" "&$L(A)&K A=A_" " S:SZ<SZB K=K+1,C=C+1,C(C)=A,@BB I SZ'<SZB!'$L(A)!($S<1300)!$G(SINGLE) S C=C_","_D_","_SZB,rT=rT+SZ X XFR Q:'$L(A)  K C
XFR1C ;F  S:'$D(C) (SZ,C,D)=0,C(0)=RT_"+"_K Q:ER>8  S A=$TR($T(+K),$C(9)," "),SZ=SZ+$L(A)+4 S:A'[" "&$D(^ROUTINE(RT,0,K))&K A=A_" " S:SZ<SZB K=K+1,C=C+1,C(C)=A,@BB I SZ'<SZB!'$L(A)!($S<1300)!$G(SINGLE) S C=C_","_D_","_SZB,rT=rT+SZ X XFR Q:A=""  K C
XFR2 ;F B=1:1:+C S DT=C(B) W $C(1)_$E(1000+$L(DT),2,4),DT X TRCA
XFR3 ;W ! F  R *B:20 Q:B<0  I B=1 R B#3:10 X $S(B:"R B#B:10",1:"S B=""""") Q
XFR5 ;U TCPP W $E(1000+$L(RT),2,4),RT  F K=1:1 S A=$TR($T(+K),$C(9)," ") S:A'[" "&$L(A)&K A=A_" " W $E(1000+$L(A),2,4),A Q:A=""
XFR5C ;U TCPP W $E(1000+$L(RT),2,4),RT F K=1:1 S A=$TR($T(+K),$C(9)," ") S:A'[" "&K&$D(^ROUTINE(RT,0,K)) A=A_" " W $E(1000+$L(A),2,4),A Q:A=""
X1 ;S A="Aborted - No Response from remote site",$ZE="W A F ZAA02GI=1:1:3 W *7 H 1",**
 ;
XFR5S s C=1 I LOS="M11C" D
 . I $D(TCPP) C TCPP
 . S TCPP="|TCP|"_port O TCPP:(ip:port:"S"):5 I  U TCPP S C=$ZA#8>3 Q
 I LOS="M3" D
 . I $D(TCPP) C TCPP
 . S TCPP="TCP2" O TCPP:(ip_"/"_port:"") U TCPP S C=$ZB Q
 I C C TCPP K TCPP
 U 0 Q
RSEL I $ZV'["Cach" D ^%RSET S %J=%JO Q
 S %X="Routines",N="",%J=$J
S1 W !,"Include ",%X,"(s) > "
 R X S L=N,SET=$P($T(SET)," ",2,99) I N="",X'="." K ^UTILITY($J) S N=0
 G SELx:X="" I N="*" S %a="" F  S %a=$o(^$R(%a)) Q:%a=""  S ^UTILITY($J,%a)=""
 G LIST:X["^L",LAST:$E(X)=".",LIST:X["?"
 I $E(X)="-" S X=$E(X,2,99),SET=$P($T(DEL)," ",2,99)
 G ALL:X="*",SOME:X["*",RANGE:X["-" I $D(^$R(X))=0 W *7,"   ???" G S1
 X SET
S2 W:N>L "   ",N-L," selected" W:N<L "    ",L-N," deselected" G S1
SELx K L,X,SET,FL,I,R2 W !! Q:N="*"
 S %x="%a=$O(^UTILITY($J,%a))" Q
ALL W "  [ All ",%X,"s ]" K ^UTILITY($J) S N="*" G S1
SOME S X=$P(X,"*"),FL=X_"z" X:$D(^$R(X)) SET F  S X=$o(^$R(X)) G S2:X="",S2:X]FL X SET
RANGE S R2=$S($P(X,"-",2)="":"z",1:$P(X,"-",2)),X=$P(X,"-",1) I X]"",$D(^$R(X))'=0 X SET
 F  S X=$O(^$R(X)) G S2:X=""!(X]R2) X SET
 Q
SET S:$D(^UTILITY($J,X))=0 N=N+1 S ^(X)=""
DEL Q:$D(^UTILITY($J,X))=0  S N=N-1 K ^(X)
LAST S N=0 W "   using last selection" G S1
LIST W !!?5,%X,"s currently selected are...",!!?5 S X="" X "F I=0:1 S X=$O(^UTILITY($J,X)) Q:X=""""  W X,$E(""          "",$L(X)+1,10) W:$X>70 !?5" W !,I-1," total",! G S1
 ;
