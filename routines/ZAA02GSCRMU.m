ZAA02GSCRMU ;PG&A,ZAA02G-SCRIPT,2.10,MACROS PRINT;20JAN95 1:25P;;;11JUL96  17:15
 ;Copyright (C) 1994, Patterson, Gray & Associates, Inc.
 ;
MACROS ; PRINTS MACROS
 S Y="30,12\RHLDS\2\Select Macro File\",Y(0)="\EX\^ZAA02GWP(105)\TO" D ^ZAA02GPOP Q:X[";EX"  S A=X
 K X S Y="33,10\RLDS\2\Select Printer",Y(0)="\EX\^ZAA02GWP(96)\TO" D ^ZAA02GPOP Q:X[";EX"   S DV=X Q:DV=""
 S %R=3 W @ZAA02GP,ZAA02G("CS") S %R=10,%C=20 W @ZAA02GP,"Macro Printout is Queued to Printer ",DV H 1
 K Y S DOC="^REPORTS" S Y("XECUTE")="D M^ZAA02GSCRMU",Y("A")=A D QUEUE^ZAA02GSCRSP K Y H 1 Q
M S B(1)=6,B(2)=10,B(3)=.1,B(4)=.5,PG=1 D INIT^ZAA02GWPPC1 S A=@VDOC@("A"),OFF=1 D DATE^ZAA02GSCRER
 I +DVP=4 S REPORT="MC" D ^ZAA02GSCRST9
 S M=$P(^ZAA02GWP(105,A),",",3) D M1 S DONE=1 Q
M1 K C S B="" F C=0:1 S:C#55=0 C(C)=B S B=$O(^ZAA02GWP(105,A,B)) Q:B=""
 S D=-1 F K=1:1 Q:D=""  S C=$O(C(D)),D=$O(C(C)) Q:C=""  D M3 S E=C(C),F="" S:D'="" F=C(D) F J=1:1:55 W !?OFF S E=$O(^ZAA02GWP(105,A,E)) Q:E=""  S X=E D M2 I F'="" S F=$O(^ZAA02GWP(105,A,F)) I F'="" S X=F D M2
 K C Q
M2 S N=^ZAA02GWP(105,A,X),B=$O(^ZAA02GWP("~G",M,N)),N=$P($G(^(N)),$C(1),4) S:$E(N)="." N=$S(B="":"",1:$P(^(B),$C(1),4)) W $J("",2),$E(X,1,8),$J("",8-$L(X))," ",$E(N,1,25) W:$X<(OFF+40) ?40+OFF Q
 ;
M3 W:K>1 # X:$D(HDRX) HDRX
 X:$D(B(4))+$D(LC)=2 "F AA=2:1:LC+B(4)*6 W !" W !!?OFF,DT S AA=A S:$P(^ZAA02GWP("~G",M),"\")'=A AA=AA_" - "_$P(^(M),"\")
 W ?73+OFF,"Page ",PG,!?OFF,TM,?80-$L(AA)\2+OFF,AA,! S PG=PG+1
 Q
