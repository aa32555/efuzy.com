ZAA02GSCRST4 ;PG&A,ZAA02G-SCRIPT,2.10,STATS - GRAPH;5DEC94 2:45P;;;03JAN2000  11:49
 ;Copyright (C) 1994, Patterson, Gray & Associates, Inc.
BEG I DEVICE=1 S %R=3,%C=1,MAR="3,1\23,80" W @ZAA02GP,"wait..."
 I DEVICE>1 S MAR="1,1\26,82",PG=1
 G:EX'="I 1" R3 S CT="" K ^ZAA02GTSCR($J)
 F SI=1:1:$L(SITEC,",") S SC=$P(SITEC,",",SI) F Y=BM:1:EM S:$E(Y,5,6)=13 Y=Y+88 F J=1:1 S CT=$O(@ZAA02GSCR@("STATS",Y,SC,T1,CT)) Q:CT=""  S ^ZAA02GTSCR($J,CT)=""
 S CT="" F J=1:1 S CT=$O(^ZAA02GTSCR($J,CT)) Q:CT=""  D R0 S ^ZAA02GTSCR($J,CT)=CC_","_LL_","_R_","_MN
 G END:J=1
GRX K Y,X S (Y,CT,X)="" F J=1:1 S CT=$O(^ZAA02GTSCR($J,CT)) Q:CT=""  S C=^(CT),LL=$P(C,",",2),X(-J/100-LL)=$TR($E(CT,1,4),",",".")
 S CT="" F J=1:1:12 S CT=$O(X(CT)) Q:CT=""  S:CT<0 Y(J)=-CT\1,X=X_X(CT)_","
 S Y=MAR_"\RBG1LY\          TOTAL LINES:  "_BEG_" - "_END_"\"_X D GRPH
 K Y,X S (Y,CT,X)="" F J=1:1 S CT=$O(^ZAA02GTSCR($J,CT)) Q:CT=""  S C=^(CT),R=$P(C,",",3),X(-J/100-R)=$TR($E(CT,1,4),",",".")
 S CT="" F J=1:1:12 S CT=$O(X(CT)) Q:CT=""  S:CT<0 Y(J)=-CT\1,X=X_X(CT)_","
 S Y=MAR_"\RBG1LYV\        TOTAL REPORTS:  "_BEG_" - "_END_"\"_X D GRPH
 K Y,X S (Y,CT,X)="" F J=1:1 S CT=$O(^ZAA02GTSCR($J,CT)) Q:CT=""  S C=^(CT),LL=$P(C,",",2),MN=$P(C,",",4),MN=-J/100-(LL*600\(MN+.1)) I MN<800 S X(MN)=$TR($E(CT,1,4),",",".")
 S CT="" F J=1:1:12 S CT=$O(X(CT)) Q:CT=""  S:CT<0 Y(J)=-CT\1,X=X_X(CT)_","
 S Y=MAR_"\RBG1LYV\         HOURLY RATE:  "_BEG_" - "_END_"\"_X D GRPH
END W:DEVICE>1 # K MAR,C,W,L,R,A,MN,B,S,Z,T,X,Y Q
GRPH I DEVICE=1 D ^ZAA02GGRAPH R CCC Q
 W:$Y>40 # I $Y<5 D TOP
 D HPDJ^ZAA02GGRAP Q
R0 S (C,W,L,R,A,MN,B,S,T)=0 F SI=1:1:$L(SITEC,",") S SC=$P(SITEC,",",SI) F M=BM:1:EM S B1=$S(M=BM:BD,1:1),B2=$S(M=EM:ED,1:31) D R1:B2'<B1
 Q
R1 I $D(@ZAA02GSCR@("STATS",M,SC,T1,CT))=0 S:$E(M,5,6)>12 M=M+87 Q
 I T1'="TR" F J=1:1 S A=$O(@ZAA02GSCR@("STATS",M,SC,T1,CT,A)) Q:A=""  D R2:A'="TOTAL"
 I T1="TR" S A="TOTAL" I $D(@ZAA02GSCR@("STATS",M,SC,T1,CT,A)) D R2
 Q
R2 S Z=^(A,1),C="C="_$P(Z,"+",B1,B2)_"+"_C
 S Z=^(2),L="L="_$P(Z,"+",B1,B2)_"+"_L,Z=^(3),W="W="_$P(Z,"+",B1,B2)_"+"_W,Z=^(4),B="B="_$P(Z,"+",B1,B2)_"+"_B,Z=^(5),S="S="_$P(Z,"+",B1,B2)_"+"_S,Z=^(6),R="R="_$P(Z,"+",B1,B2)_"+"_R
 S Z=^(7),MN="MN="_$P(Z,"+",B1,B2)_"+"_MN,@C,@L,@W,@B,@S,@R,@MN,@LF,@WF Q
 ;
R3 K ST S CT=$G(CTX),J=0 Q:CT=""  F M=BM:1:EM S B1=$S(M=BM:BD,1:1),B2=$S(M=EM:ED,1:31) F DY=B1:1:B2 D R4 S @LF I LL S ST(M*100-DY)=LL_","_R_","_T,J=J+1
 Q:'J
 K Y,X S (Y,CT,X)="" F J=1:1 S CT=$O(ST(CT)) Q:CT=""  S C=ST(CT),Y(J)=+C,X=X_$E(CT,5,6)_","
 S X=X_"\"_CTX,Y=MAR_"\RBG1LY\          TOTAL LINES:  "_BEG_" - "_END_"\"_X D GRPH
 K Y S (Y,CT)="" F J=1:1 S CT=$O(ST(CT)) Q:CT=""  S C=ST(CT),Y(J)=$P(C,",",2)
 S Y=MAR_"\RBG1LYV\        TOTAL REPORTS:  "_BEG_" - "_END_"\"_X D GRPH
 K Y S (Y,CT)="" F J=1:1 S CT=$O(ST(CT)) Q:CT=""  S C=ST(CT),LL=$P(C,","),MN=$P(C,",",3),MN=LL*60\(MN+.1) I MN<800 S Y(J)=MN
 S Y=MAR_"\RBG1LYV\         HOURLY RATE:  "_BEG_" - "_END_"\"_X D GRPH
 Q
R4 S E="+0" I $D(@ZAA02GSCR@("STATS",M,SC,T1,CT))=0 S:$E(M,5,6)>12 M=M+87 Q
 Q:$D(@ZAA02GSCR@("STATS",M,SC,T1,CT,"TOTAL",1))=0  D R5
 Q
R5 S Z=^(1),C="C="_$P(Z,"+",DY)_E Q:$L(C)=2  S Z=^(2),L="L="_$P(Z,"+",DY)_E,Z=^(3),W="W="_$P(Z,"+",DY)_E,Z=^(4),B="B="_$P(Z,"+",DY)_E,Z=^(5),S="S="_$P(Z,"+",DY)_E,Z=^(6),R="R="_$P(Z,"+",DY)_E,Z=^(7),T="T="_$P(Z,"+",DY)_E_"*.1"
 S @C,@L,@W,@B,@S,@R,@T Q
 ;
TOP S LN=5 X:$D(HDRX) HDRX X:$D(B(4))+$D(LC)=2 "F AA=2:1:LC+B(4)*6 W !" W !?OFF,DT S AA=$P(@ZAA02GSCR@("PARAM","BASIC"),"|"),C=80-$L(AA) W ?C\2+OFF,AA,?73+OFF,"Page ",PG,! S C=80-$L(HD) W ?C\2+OFF,HD,!
 S AA="DATES: "_BEG_" - "_END_"   SITE: "_SITEC,C=80-$L(AA) W ?C\2+OFF,AA,! S PG=PG+1 Q
 ;
