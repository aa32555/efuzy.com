ZAA02GSCMRB1 ;PG&A,ZAA02G-MTS,1.20,BIOPSY ENTRY SCREEN;06JAN94  22:26;08MAR2002  14:58;;08FEB2002  09:04
 ;Copyright (C) 1995, Patterson, Gray and Associates Inc.
 ;
POP D:$D(ZAA02GX)+$D(ZAA02GY)'=2 FUNC^ZAA02GDEV X ^ZAA02G("ECHO-OFF")
 S %R=3,%C=1,B="",$P(B,ZAA02G("HL"),77)="" W @ZAA02GP,ZAA02G("CS")," ",ZAA02G("G1"),ZAA02G("HI"),ZAA02G("TLC"),B,ZAA02G("TRC") F %R=%R+1:1:23 S %C=2 W @ZAA02GP,ZAA02G("VL") S %C=79 W @ZAA02GP,ZAA02G("VL")
 S %R=%R+1,%C=2 W @ZAA02GP,ZAA02G("G1"),ZAA02G("BLC"),B,ZAA02G("BRC"),ZAA02G("G0")
 S %R=3,%C=31,W=0 W @ZAA02GP,ZAA02G("LO"),"Biopsy Results Screen"
 I '$D(@ZAA02GSCMD@("XDIR",SCr,2,"LAP")) D LABSET
 I '$D(BLD) F J=1:1:$L(OMAMMO,";") S A=$P(OMAMMO,";",J) I $E(A)="L" S ST(0,"AC")=$G(ST(0,"AC"))_","_A I $D(@ZAA02GSCMD@("XDIR",SCr,2,A)) S SD(0,^(A))=""
 I $D(ST(0,"AC")) S ST(0,"AC")=$E(ST(0,"AC"),2,99)
 I OMAMMO["AGE," S INP("AGE")=+$P(OMAMMO,"AGE,",2)
 W ZAA02G("LO") F J=1:1 S A=$P("5,5,PATIENT;6,9,DOB;5,40,STUDY;7,4,ACCT/MR#;6,40,AGE;7,40,REFER",";",J) Q:A=""  S %R=+A,%C=$P(A,",",2) W @ZAA02GP,$P(A,",",3),":"
 W ZAA02G("HI") F J=1:1 S A=$P("5,14,PATIENT;6,14,DOB;5,47,DS;7,14,MR;7,21,STM;6,47,AGE;7,47,CONSULT",";",J) Q:A=""  S %R=+A,%C=$P(A,",",2) W @ZAA02GP,$G(INP($P(A,",",3)))
 ; X "N (INP) W  R CCC"
 S %R=10 D LINE
POP1 S TS=0,Z=0
 S T="RESULTS (optional):,11,4;Codes,,26,XXL,33,40,PD" D TT
 ;
 S T="FINAL ANALYSIS:,13,4;Benign,,26,FAB;High Risk,,46,FAH;Malignant,,67,FAM;Refused Follow Up,14,26,FAR;Lost to Follow Up,,46,FAL;Deceased,,67,FAD;Physician deferred biopsy,15,26,FAP" D TT
 S T="NOTES:,17,4;1),,26,XX1,29,40,PD;2),18,26,XX2,29,40,PD;3),19,26,XX3,29,40,PD" D TT
 S %R=21,%C=26 W @ZAA02GP,"Press HELP key for listing of pathology codes"
 S DUP="BHMRLDP"
 ;S %R=18 D LINE S Z=0
 S C=X,A="" I $D(BLD) K BLD G POP
 I $D(ERR) S D=ERR,Z=W K ERR G ERR
LOOP F C=C:0:TS W:C'=A ZAA02G("HI"),TS(C) D RD W ZAA02G("LO"),TS(C) S C=C+$S(ZF="E":99,ZF="F":1,ZF=9:1.1,ZF="A":-1,ZF="B":1,ZF=1:1,ZF="":0,"OP5Y"[ZF:200,1:0),A="" S:C<1 C=TS I C["." F C=C-.1:1:TS Q:$D(TS(C))
 I TS+5>C S C=1 G LOOP
 I C>200 D:ZF="Y" HLP S X=C-200 G POP1
 ;S A="Z" I $G(EDIT)'=1 F Z=0:1:0 I $D(ST(Z)) F D="CDEL,@OH1","FL,@CB1","GHL,@GD1","BA,CB","CFGL,@IJL1" I 'Z!(D[1) S T=0 F J=1:1:$L(D)+1 S C=$E(D,J) S:C?1A T=$E($O(ST(Z,C)))=C*$E(1248,J)+T I C=",",$P(D,",",2)'[$C(T+64) G ERR
 G:$G(ST(0,"AC"))?.P END D LAB I  S ST(0,"AC")="" G END
 S D="A" G ERR
 ;
END X ^ZAA02G("ECHO-ON") K LNG,TS,TT,T,Y,SS,SR,SP,SY,ZAA02GX,ZAA02GY,DUP Q
ERR I Z'=W S ERR=D,W=Z G POP1
 S A="Z" F J=1:1:$L(D) S C=$E(D,J) Q:C=","  W $G(ZAA02G("BO")),TS($A(C)-64),$G(ZAA02G("BF")) S:A]C A=C
 S C=$A(A)-64,A="" G LOOP
TT F J=1:1:$L(T,";") I $P(T,";",J)]"" S D=$P(T,";",J),%C=$P(D,",",3) S:$P(D,",",2) %R=$P(D,",",2) S C=$P(D,","),M="M="_ZAA02GP,@M D @$S(J=1:"TT1",1:"TT2")
 Q
TT1 S TS=TS+1,TS(TS)=M_C,L=$C(TS+64) S:%C=4 TS(TS+.1)="" W ZAA02G("LO"),M_C Q:'$D(BLD)  S @ZAA02GSCMD@("XDIR",SCr,1,L)=","_C Q
TT2 S A=$F($TR(C,"ABCDEFGHIJKLMNOPQRSTUVWXYZ1234","\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\"),"\"),I=$E(C,A-1),SS(L_I)=M_$E(C,1,A-2)_ZAA02G("HI")_I_ZAA02G("LO")_$E(C,A,255)
 W $S($D(ST(Z,L_I)):ZAA02G("RON")_$S(ZAA02G["DTM":$P(SS(L_I),ZAA02G("HI"))_$E($P(SS(L_I),ZAA02G("HI"),2))_$P(SS(L_I),ZAA02G("LO"),2),1:SS(L_I)),1:SS(L_I)),ZAA02G("ROF")
 I $P(D,",",5) S SR(L_I)=%R_","_$P(D,",",5,7),SY=$G(SY)+1,SY(SY)=L_I,%C=$P(D,",",5),LNG=$P(D,",",6) W @ZAA02GP,ZAA02G("HI"),ZAA02G("UO"),$E($G(ST(Z,L_I))_SP,1,LNG),ZAA02G("UF")
 Q:'$D(BLD)  S A=$P(D,",",4),@ZAA02GSCMD@("XDIR",SCr,1,L_I)=A_","_C W:A="" "missing code-",L,I R:A="" ccc I A]"" S @ZAA02GSCMD@("XDIR",SCr,2,A)=L_I Q
LINE Q:'$L(B)  S %C=2 W @ZAA02GP,ZAA02G("HI"),ZAA02G("G1"),ZAA02G("LI"),B,ZAA02G("RI"),ZAA02G("G0") Q
RD R A#1 I A="" X ZAA02G("T") S ZF=$E(XX,$F(XX,ZF)) Q
RD2 S:A?1L A=$C($A(A)-32) S ZF="",L=$C(C+64)_A I '$D(SS(L)) W *7 Q
 I $G(EDIT)=1 D ^ZAA02GSCMRC S ZF=5,X=C Q
 I $D(ST(W,L)) G RD1:$D(SR(L)) K ST(W,L) S SD(W,L)=""
 E  S ST(W,L)="",M=$P(DUP,";",C) F T=0:0 Q:M'[A  S T=$L($P(M,A),","),D=$P(M,",",T),M=$P(M,",",T+1,9) F J=1:1:$L(D) S X=$C(C+64)_$E(D,J) I $E(D,J)'=A,$D(ST(W,X)) K ST(W,X) W SS(X) S SD(W,X)=""
RD1 D RDX S RX="" I $D(SR(L)),$D(ST(W,L)) S D=SR(L),%C=$P(D,",",2),LNG=$P(D,",",3),%R=+D,X=ST(W,L) D @$P(D,",",4) S ST(W,L)=X I X="" K ST(W,L) S SD(W,L)="" D RDX
 I $G(RX)?1A S A=RX G RD2
 Q
RDX W ZAA02G("LO"),$S($D(ST(W,L)):ZAA02G("RON")_$S(ZAA02G["DTM":$P(SS(L),ZAA02G("HI"))_$E($P(SS(L),ZAA02G("HI"),2))_$P(SS(L),ZAA02G("LO"),2),1:SS(L)),1:SS(L)),ZAA02G("ROF") Q
PDN S TRM="ABCDEFGHIJKLMNOPQRSTUVWXYZ",CHR="1234567890"_TRM
 S FNC="TB,EX,UK,DK,CR" X ^ZAA02G("ECHO-ON"),^ZAA02GREAD,^ZAA02G("ECHO-OFF")
PDN1 S ZF=$S(FNC="TB":9,FNC="EX":"E",FNC="HL":"Y",FNC="?":"Y",1:"") Q
PD S Y=LNG_",80\HU\HUS\\TB,EX,UK,DK,CR,HL\?" D READ^ZAA02GRDL S FNC=ZAA02GF W ZAA02G("UF") G PDN1
PDD S Y="8\HU\HUS\\TB,EX,UK,DK,CR\" D READ^ZAA02GRDD S FNC=ZAA02GF,X=$P(X,"\",2) W ZAA02G("UF") G PDN1
 ;
LAB S D=0 F  S D=$O(ST(0,D)) Q:D'?.N  K ST(0,D)
 S D=1,T=$TR(ST(0,"AC"),"; ",","),%R=18,%C=20 F J=1:1:$L(T,",") S C=$P(T,",",J) D:C]"" LAB1
 I D=1
 Q
LAB1 I '$D(@ZAA02GSCMD@("DICT",3,C)) W @ZAA02GP,C,"  NOT FOUND" S D=0,%R=%R+1 Q
 I $D(@ZAA02GSCMD@("XDIR",SCr,2,C)) S A=^(C)
 E  D LAB2
 S ST(0,A)="" Q
LAB2 F A=1:1:399 I '$D(@ZAA02GSCMD@("XDIR",SCr,1,A)) S ^(A)=C,@ZAA02GSCMD@("XDIR",SCr,2,C)=A Q
 Q
LABSET N A,B,C,D S D="" F  S D=$O(@ZAA02GSCMD@("DICT",1,26,D))  Q:D=""  S C=$P(^(D),"^",4) I C]"",'$D(@ZAA02GSCMD@("XDIR",SCr,2,C)) D LAB2
 Q
 ;
HLP N TY,X,Y,A,B S Y="10,12\RHLY\1\Pathology Result Codes",Y(0)="10\EX"
 S A="" F  S A=$O(@ZAA02GSCMD@("DICT",1,26,A)) Q:A=""  S B=^(A),A($P(B,"^",2)_" ")=$P(B,"^",4)
 S A="" F J=1:1 S A=$O(A(A)) Q:A=""  S Y(J)=A_$J("",55-$L(A))_A(A),B(J)=A(A)
 D ^ZAA02GPOP I X'[";EX" S X=B(X) I $G(ST(0,"AC"))'[X S ST(0,"AC")=$G(ST(0,"AC"))_","_X S:$E(ST(0,"AC"))="," ST(0,"AC")=$E(ST(0,"AC"),2,99)
 X ^ZAA02G("ECHO-OFF") Q
