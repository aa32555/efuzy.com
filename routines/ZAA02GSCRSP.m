ZAA02GSCRSP ;PG&A,ZAA02G-SCRIPT,2.10,START PRINTER;14NOV94  22:02;7NOV94 12:03P;;18JUN2007  15:51
 ;Copyright (C) 1991, Patterson, Gray & Associates, Inc.
 ;
 ; PRNT entry point - enter with DOC,DIR,DV,CP (Y(x) optional)
 ;
PRNT S PG=$S($D(FPG):FPG,1:"ALL") K FPG S:'$D(CP) CP=1 S TDV=DV,Z=0
 S PG=$TR(PG,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 I $G(^ZAA02GSCR("PARAM","DEVICE-TRANSLATION"))]"" X ^("DEVICE-TRANSLATION")
P0 L +ZAA02GWP("CONTROL") F NQ=0:1 I $O(^ZAA02GWP(.9,TDV,NQ))'?1.N S NQ=NQ+1 L -ZAA02GWP("CONTROL") Q
 D TIME S ^(NQ)="\"_DOC_"\"_CP_"\\"_PG_"\"_$S($D(BIN):BIN,1:"")_"\\"_TM_"\"_($G(LIST)]""*2)_"\"_$G(LIST)_"\\"_$H
 I $D(Y)>2 S B="" F I=1:1 S B=$O(Y(B)) Q:B=""  S ^ZAA02GWP(.9,TDV,NQ,B)=Y(B)
 I $D(COPY) S A="" F J=1:1 S A=$O(@DOC@(A)) Q:A=""  S B=$D(@DOC@(A)) S:B=1 ^ZAA02GWP(.9,TDV,NQ,"DOC",A)=@DOC@(A) M:B>1 ^ZAA02GWP(.9,TDV,NQ,"DOC",A)=@DOC@(A)
 I  I COPY=2 S A=$O(^ZAA02GWP(.9,TDV,NQ,"DOC",.03)) I A K ^(A)
 D START K BIN,CP,PG,TM Q
 Q
 ;
QUEUE N (DV,CP,PG,DOC,Y,ZAA02GSCR,FPG) D PRNT Q
QUEUER N (DV,CP,PG,DOC,Y,ZAA02GSCR,FPG) S COPY=1 D PRNT Q  ; copies in document
 ;
TIME S B=$P($H,",",2),H=B\3600-1#12+1,M=B#3600\60 S TM=H_":"_$E("0"_M,$L(M),3)_" "_$S(B>43199:"PM",1:"AM") Q
 ;
START S VDV=TDV I $P($G(^ZAA02GWP(96,VDV)),"\",15)'="N",$G(^LPT(VDV))'["PASS" L +ZAA02GWP(VDV):0 Q:'$T  D SET J:1 ^ZAA02GWPPC L -ZAA02GWP(VDV) Q
 D PASS
 Q
PASS N (ZAA02G,ZAA02GP,VDV) S (TDV,DP)=VDV W *27,"[5i" D Q1^ZAA02GWPPC U 0 W *27,"[4i" Q
 ;
SET S B=","_TDV_",",^ZAA02GWP(.9)=$S($D(^ZAA02GWP(.9))#2=0:B,^(.9)[B:B_$P(^(.9),B)_","_$P(^(.9),B,2,9),1:B_$E(^(.9),2,100)) Q
 ;
GETPRNT Q:'$D(ZAA02GP)  S %R=24,%C=1 W @ZAA02GP,ZAA02G("CL") S %C=30,X="" W @ZAA02GP,"Select Printer - " S %C=47 X ^ZAA02GREAD I X]"",'$D(^ZAA02GWP(96,X)) W "  NOT VALID PRINTER" H 2 G GETPRNT
 S DV=X S:DV=0 DV="" Q
 ;
DEFDV S:'$D(INP("DIST")) INP("DIST")=0 I $D(DISTR),DISTR]"",$D(@ZAA02GSCR@("PARAM","DIST",DISTR)) S INP("DIST")=DISTR
 S:'$D(P) P=0 S DV="" I P=1,$D(@ZAA02GSCR@("PARAM","DIST",INP("DIST"))) S Y=$O(^(INP("DIST"),"")) I Y S DV=$P(^(Y),"\",2) Q:DV]""
 I DV="",P=1,$D(@ZAA02GSCR@("PARAM","DEVICE")) X ^("DEVICE")
 I DV="",P=1,$D(@ZAA02GSCR@("PARAM","SITERULES")) D
 . S SITE=$G(INP("SITEC")) I SITE="" Q:'$G(DOC)  S SITE=$P($G(@ZAA02GSCR@("TRANS",DOC,.011)),"`",6) Q:SITE=""
 . S DV=$G(@ZAA02GSCR@("PARAM","SITERULES",SITE))
 S ZAA02GSCRT=$S($D(@ZAA02GSCR@("PARAM","USER FILE")):^("USER FILE"),1:ZAA02GSCR)
 S:P=0 P=1 I DV="",P<3,$G(TRANS)]"" S DV=$P($P($G(@ZAA02GSCRT@("PARAM","USER",TRANS)),"\",10,11),"\",P)
 I DV="",P<3 S DV=$P($P(@ZAA02GSCR@("PARAM","BASIC"),"|",7,9),"|",P)
 K ZAA02GSCRT Q
 ;
PR D DEFDV I DV="" D GETPRNT I DV]"" D GETDIST
 I DV]"" I $G(@ZAA02GSCR@("PARAM","PRINTQ"))]"" X ^("PRINTQ")
 Q
 ;
GETDIST Q:$G(DISTR)=" "  I $G(@ZAA02GSCR@("PARAM","SINGLECOPY"))="Y" S DISTR=" " Q
 I $G(@ZAA02GSCR@("PARAM","AI-DISTR"))=$G(DISTR) Q
 S %R=24,%C=1 W @ZAA02GP,ZAA02G("CS") K X,Y S Y="20,24\QHP1U\*\\\Normal Distribution,Single Copy" D ^ZAA02GPOP S:X=2 DISTR=" " Q
 ;
RPTCHG S %R=22,%C=1,A=$S($P(OT,"`")'=$P(REP,"`"):1,1:2) W @ZAA02GP,ZAA02G("CS") S %C=10 W @ZAA02GP,ZAA02G("LO"),"Old Report: ",ZAA02G("HI"),$E($P(OT,"`",A),1,60),!?9,ZAA02G("LO"),"New Report: ",ZAA02G("HI"),$E($P(REP,"`",A),1,60),ZAA02G("LO")
 S %R=24 W @ZAA02GP,"Do you want to",ZAA02G("HI")," erase",ZAA02G("LO")," the previous report? (",ZAA02G("HI"),"Y",ZAA02G("LO")," or ",ZAA02G("HI"),"N",ZAA02G("LO"),") - ",ZAA02G("HI") S %C=63,X="",CHR="YN",LNG=1,UC=1 X ^ZAA02GREAD
 I X="Y"
 E  S @ZAA02GWPD@(.03)=@ZAA02GSCR@(106,INP("TEMPLATE"),.03)
 K @ZAA02GWPD@(.011,"NOMAMMO") S OT=INP("TEMPLATE") Q
 Q
 ;
REPORTS ; PRINTS REPORTS
 S Y="30,8\RHLD\1\Select Type of Listing\\Titles Only,Complete Master Printout,Selected Reports Only,Parameter Listing Only",Y(0)="\EX" D ^ZAA02GPOP Q:X[";EX"  S TYP=X
 K Z I TYP=3 D R31S G:X[";EX" REND S X="" F J=1:1 S X=$O(X(X)) Q:X=""  S Z(X)=X(X)
 K X S Y="33,10\HLDV\2\Select Printer\\" S X="" F J=1:1 S X=$O(^ZAA02GWP(96,X)) Q:X=""  S Y=Y_X_","
 S Y=$E(Y,1,$L(Y)-1),Y(0)="\EX" D ^ZAA02GPOP Q:X[";EX"   S DV=X Q:DV=""  S %R=3 W @ZAA02GP,ZAA02G("CS") S %R=10,%C=20 W @ZAA02GP,"Report Template Listing is Queued to Printer ",DV H 1
 K Y I TYP=3 S X="" F J=1:1 S X=$O(Z(X)) Q:X=""  S Y("R"_J)=Z(X)
 S DOC="^REPORTS",Y("XECUTE")="D R^ZAA02GSCRSP",Y("ZAA02GSCR")=ZAA02GSCR,Y("TYP")=TYP D QUEUE^ZAA02GSCRSP
REND K Y,TYP,X,Z Q
R S TYP=@VDOC@("TYP"),ZAA02GSCR=@VDOC@("ZAA02GSCR")
 I TYP=1 D R1 W # S DONE=1 Q
 S B(1)=6,B(2)=11,B(3)=.8
 I TYP=2 D R21
 I TYP=3 D R31
 I TYP=4 D R41
 Q
R1 S B(1)=6,B(2)=11,B(3)=.2 D INIT^ZAA02GWPPC1 S LTM=B(3)*B(2)*$S($D(LMG):0,1:1) S:LTM<0 LTM=0
 W !!!?25+LTM,"REPORT TEMPLATE LISTING",!!
 K C,B S (B,K)=0 D:'$D(@ZAA02GSCR@(106,0)) RB106^ZAA02GSCRINT S A=100 S:$D(@ZAA02GSCR@("PARAM","MNEMONIC")) A=^("MNEMONIC")="F"*-50+100
 F C=0:0 S:C#55=0 C(C\55)=B S B=$O(@ZAA02GSCR@(106,0,B)) Q:B=""  S:B'?.E1U.E C=C+1 I C=A D R2 K C S C=0
 D:C R2 Q
R2 S E=C(0),F=$S($D(C(1)):C(1),1:""),K=K+1 W:K>1 #!!!?18+LTM,"REPORT TEMPLATE LISTING - (Continued)",?60+LTM,K,!! F J=1:1:55 W !?LTM S E=$O(@ZAA02GSCR@(106,0,E)) Q:E=""  S X=E D R3 I F'="" S F=$O(@ZAA02GSCR@(106,0,F)) I F'="" S X=F D R3
 K C Q
R3 S N=@ZAA02GSCR@(106,0,X) I A=100 W $J("",2),$E(X,1,8),$J("",8-$L(X))," ",$E(N,1,25) W:$X<(LTM+40) ?40+LTM Q
 W $J("",5),$E(X,1,65) Q
 ;
R21 S A=$G(DVP(.2)) S:A="" A=.9 S A=$O(@ZAA02GSCR@(106,A)) I A="" S DONE=1 Q
 S DVP(.2)=A
R22 S Repn=A,ZAA02GWPD=ZAA02GSCR_"(106,Repn)",$P(^ZAA02GWP(.9,DP,XDC),"\",3,4)="2\1",HD="REPORT TEMPLATE: "_A,FR="R23^ZAA02GSCRSP;*C\" Q
R23 I I_C'="" W !,"    (Report continues)",! Q
 S G=$G(@ZAA02GWPD@(.01))_"\"_$G(^(.03)) W:$Y>54 # W !?LTM,"---------------------------------------------------------------------------",!
 S C="WID,1,4;CPI,3,4;LM,4,4;TM,5,4;BM,11,4;1ST HEAD/FOOT,14,16;2+ HEAD/FOOT,15,16;TYP,16,4;NOTES,17,8;DIST,18,5;SITE,21,5"
 S D=0 F J=1:1 S B=$P(C,";",J) Q:B=""  W ?D+LTM,$P(B,",") S D=D+$P(B,",",3)
 W ! S D=0 F J=1:1 S B=$P(C,";",J) Q:B=""  W ?D+LTM,$E("-------------------",1,$P(B,",",3)-1) S D=D+$P(B,",",3)
 W ! S D=0 F J=1:1 S B=$P(C,";",J) Q:B=""  W ?D+LTM,$E($P(G,"\",$P(B,",",2)),1,$P(B,",",3)-1) S D=D+$P(B,",",3)
 S (I,C)="" Q
 ;
R31 S JJ=$G(DVP(.2)) S:JJ="" JJ=1 I $D(@VDOC@("R"_JJ))  S A=^("R"_JJ),DVP(.2)=JJ+1 G R22
 S DONE=1 Q
 ;
R31S K X S Y="25,9\RHM1ALSTD\8\Report Templates",Y(0)="13\EX\@ZAA02GSCR@(106)\TO\.9\Use the Select Key for more than one\\"
 D ^ZAA02GPOP Q
 ;
R41 S B(1)=6,B(2)=11,B(3)=.2 D INIT^ZAA02GWPPC1 S LTM=B(3)*B(2)*$S($D(LMG):0,1:1) S:LTM<0 LTM=0
 S (B,K)=0 D:'$D(@ZAA02GSCR@(106,0)) RB106^ZAA02GSCRINT
 S C="WID,1,4;CPI,3,4;LM,4,4;TM,5,4;BM,11,4;1ST HEAD/FOOT,14,16;2+ HEAD/FOOT,15,16;TYP,16,4;NOTES,17,8;DIST,18,5;SITE,21,5"
 F S=1:1 S K=$O(@ZAA02GSCR@(106,K)) Q:K=""  D R41H:S=1,R41B I S=50 W # S S=0
 Q
R41H W !!!?20+LTM,"REPORT TEMPLATE PARAMETER LISTING",!!
 S D=0 F J=1:1 S B=$P(C,";",J) Q:B=""  W ?D+LTM,$P(B,",") S D=D+$P(B,",",3)
 W ! S D=0 F J=1:1 S B=$P(C,";",J) Q:B=""  W ?D+LTM,$E("-------------------",1,$P(B,",",3)-1) S D=D+$P(B,",",3)
 Q
R41B S G=$G(@ZAA02GSCR@(106,K,.01))_"\"_$G(^(.03))
 W ! S D=0 F J=1:1 S B=$P(C,";",J) Q:B=""  W ?D+LTM,$E($P(G,"\",$P(B,",",2)),1,$P(B,",",3)-1) S D=D+$P(B,",",3)
 Q
 ;         ;
DEF ; CHANGE DEFAULT PRINTER FOR TRANSCRIPTIONISTS
 K Y S Y="" F J=4:1 S Y=$O(^ZAA02GWP(96,Y)) Q:Y=""  S Y(J)=Y
 S ZAA02GSCRT=$S($D(@ZAA02GSCR@("PARAM","USER FILE")):^("USER FILE"),1:ZAA02GSCR)
 S Y(J)="No Default",Y="30,4\TRHLDY\1\Select Default Printer\\",Y(2)="*Current Default = "_$P($G(@ZAA02GSCRT@("PARAM","USER",TRANS)),"\",10),Y(1)="*",Y(3)="*"
 S Y(0)="\EX" D ^ZAA02GPOP Q:X[";EX"  I $D(@ZAA02GSCRT@("PARAM","USER",TRANS)) S $P(^(TRANS),"\",10)=$S(Y(X)="No Default":"",1:Y(X))
 K ZAA02GSCRT Q
