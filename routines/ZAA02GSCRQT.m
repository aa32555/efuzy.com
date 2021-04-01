ZAA02GSCRQT ;PG&A,ZAA02G-SCRIPT,2.10,QUICK TYPE;20JAN95 1:25P;;;31JAN95 8:56A
 ;Copyright (C) 1994, Patterson, Gray & Associates, Inc.
 ;
SCAN S UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ",LC="abcdefghijklmnopqrstuvwxyz" K ^ZAA02GTWD
 S R=0 F J="",1:1:8 S A="^ZAA02GSCR"_J I $D(@A) D SCAN1
 W !!,R," REPORTS",! G SCAN2
SCAN1 S B="" F J=1:1 S B=$O(@A@("TRANS",B)) Q:B=""  S R=R+1,C=.03 F J=1:1 S C=$O(@A@("TRANS",B,C)) Q:C=""  S D=$TR($P(^(C),$C(1),4),UP,LC) F K=1:1:$L(D," ") S E=$P(D," ",K) S:E?5.L ^ZAA02GTWD(E)=$S($D(^ZAA02GTWD(E)):^(E),1:0)+1
 Q
SCAN2 S A="" F J=1:1 S A=$O(^ZAA02GTWD(A)) Q:A=""  I ^ZAA02GTWD(A)<5 K ^ZAA02GTWD(A)
 ;         ;
 S A="" F J=1:1 S A=$O(^ZAA02GTWD(A)) Q:A=""   F L=1:1:$L(A) S B=$E(A,1,L) D SCAN3
 Q
SCAN3 S F=A=B,E=B,N=1 F J=1:1 S B=$O(^ZAA02GTWD(B)) Q:$E(B,1,L)'=E  S N=N+^(B) I ^(B)>F S F=^(B),M=B
 Q:'F  S:F*3>N ^ZAA02GWD(E)=M W A," > ",E," > ",M," ",$J(F/N,0,3),! Q
