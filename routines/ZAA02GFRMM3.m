ZAA02GFRMM3 ;PG&A,ZAA02G-FORM,2.62,MAINTENANCE (XREF);1MAR89 10:44A;;;22FEB95  21:06
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
 ; Scans screen series and compiles xref of fields
T1 K ^ZAA02GF($J) S %R=3,%C=1 W:'$D(qt) @ZAA02GP,ZAA02G("CS"),!?5 S A="" F J=1:1 S A=$O(SCR(A)) G:A="" TP D T2
 Q
 ;
T2 G:$D(SCR(A))>1 T2A S B=0 F J=1:1 S B=$O(^ZAA02GDISP(A,B)) Q:B=""  D T3
 Q
T2A S B=0 F J=1:1 S B=$O(SCR(A,B)) Q:B=""  D T3
 Q
 ;
T3 S C=">" W A,"-",B,?$X+20\20*20+5 W:$X>60 !?5 F J=1:1 S C=$O(^ZAA02GDISP(A,B,C)) Q:C=""  S F=^(C),D=$P(F,"`",2) I C'[">",$P(F,"`",3)'="" S G=$P(F,"`",4),G=+$P(G,",",3) S:$D(^ZAA02GF($J,D,G))=0 ^(G)="" S ^(G)=^(G)_A_"-"_B_";"_C_"\"
 Q
TP S %R=20,%C=5 W:'$D(qt) @ZAA02GP,"Enter Output Device (0 = screen) : " R DV S LN=20 I DV O DV U DV S LN=55
XX S A="" D TPH  F I=1:1 S A=$O(^ZAA02GF($J,A)) Q:A=""  S B="" D TPH:$Y+4>LN W !!,A,!! F J=1:1 S B=$O(^ZAA02GF($J,A,B)) Q:B=""  D TP1
 I DV W # C DV G EXIT
 X "F I=$Y:1:21 W !" W !?5,"Press RETURN to continue " R X
EXIT K A,B,C,D,E,F,G,DV,SCR,I,J Q
TP1 I $Y>LN D TPH
 W ?3,B S C=^(B)
 F K=1:1:$L(C,"\")-1 S G=$P(C,"\",K),D=$P($P(G,";",2),"\"),X=$P(G,"-"),Y=+$P(G,"-",2),T=^ZAA02GDISP(X,Y,D) W ?9,$P(G,";"),?21,D,?31,$P(T,"`"),?38,$P(T,"`",5),?45,$P(T,"`",6),?71,$S($P(T,"`",20)="Y":"D.O.",1:$P(T,"`",20)),!
 Q
TPH I 'DV,A'="" X "F I=$Y:1:21 W !" W !?5,"Press RETURN to continue " R X
 W !,#,*13,"ZAA02GFORM Global Xref",! F J=1:1:19 W "----"
 W "---",! W:DV !! W "Piece     Screen     Name    Mand.  Length   Pattern Match         Input Type" I A'="",B'="",$O(^ZAA02GF($J,A,B))'="" W !!,A,!!
 Q
