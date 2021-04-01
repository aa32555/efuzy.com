ZAA02GSCMRB4 ;PG&A,ZAA02G-MTS,1.20,BIOPSY ENTRY SCREEN;06JAN94  22:26;6JAN95 5:43P;;20OCT95  12:06
 ;Copyright (C) 1995, Patterson, Gray and Associates Inc.
 ;
POP D:$D(ZAA02GX)+$D(ZAA02GY)'=2 FUNC^ZAA02GDEV X ^ZAA02G("ECHO-OFF")
 S %R=2,%C=1,B="",$P(B,ZAA02G("HL"),77)="" W @ZAA02GP,ZAA02G("CS")," ",ZAA02G("G1"),ZAA02G("HI"),ZAA02G("TLC"),B,ZAA02G("TRC") F %R=%R+1:1:23 S %C=2 W @ZAA02GP,ZAA02G("VL") S %C=79 W @ZAA02GP,ZAA02G("VL")
 S %R=%R+1,%C=2 W @ZAA02GP,ZAA02G("G1"),ZAA02G("BLC"),B,ZAA02G("BRC"),ZAA02G("G0")
 S %R=2,%C=31,W=0 W @ZAA02GP,ZAA02G("LO"),"Biopsy Results Screen"
POP1 S TS=0,%R=2,Z=0
 S T="ETHNICITY:,4,4;White,,17,ET1;Black,,25,ET2;american Indian/eskimo,,33,ET3;Asian/Pacific islander,,57,ET4;Other,5,17,ET5;Hispanic,,31,ETH" D TT
 S %R=6 D LINE
 S T="FAMILY HIST:,7,4;No history,,17,RB0;Aunt...,,31,RB1;Post-menopausal,,42,RB2;pRe-Menopausal,,60,RB3" D TT
 S %R=8 D LINE
 S T="BR. HIST-L:,9,4;Aspiration,,17,BHA;Needle bx,,29,BHN;Lumpectomy,,40,BHL;Mastectomy,,52,BHM;Radiation,,64,BHR;Other,,74,BHO" D TT
 S T="BR. HIST-R:,10,4;Aspiration,,17,BHa;Needle bx,,29,BHn;Lumpectomy,,40,BHl;Mastectomy,,52,BHm;Radiation,,64,BHr;Other,,74,BHo" D TT
 S T="other:,11,9;Chemo (yy),,17,BHC,28,2,PDN;Prev mammo,,32,BHD,43,10,PD;Where?,,55,BHW,62,16,PD" D TT
 S T="implants:,12,6;siLicone,,17,IBG;Saline,,28,IBS;Pre-pectoral,,37,IBP;Combo,,52,IBC;Retro,,60,IBR;Augment,,68,IBA" D TT
 S %R=13 D LINE
 R A:0 X ZAA02G("T") S ZF=$E(XX,$F(XX,ZF)) G:ZF="E" END
 S T="PROBLEMS:,14,4;palpable Abnormality,,17,IAA;Bl disch,,40,IAB;non-bl Disch,,51,IAD;Exam,,65,IAE;Implant,,72,IAI;Skin thick.,15,17,IAK;Lump,,30,IAL;Nipple abnorm,,36,IAN;Pain,,51,IAP;Cancer,,57,IAW;aXillary nodes,,65,IAX" D TT
 S %R=16 D LINE
 S T="OTHER-Preg:,17,4;number Times pregnant,,17,OTX,39,2,PDN;Children,,44,OTC,53,2,PDN;Age of 1st preg,,58,OTA,74,2,PDN" D TT
 S T=";Pregnant,18,17,OTP;Fertility program,,28,OTF;Nursing,,48,OTN;nursed Lately,,58,OTL" D TT
 S T=" Menses:,19,7;Age of 1st,19,17,OPG,28,2,PDN;Last (mm/dd/yy),,32,OPL,48,8,PDD;Meno,,58,OTM;Hyster (yy),,65,OTH,77,2,PDN" D TT
 S T="Contra:,20,8;Birth control pills,,17,OFC;Estrogen,,44,OFE;Fertility,,55,OFF;Other,,70,OFO" D TT
 ;
 S DUP="WBIAO;NA,NR,NP"
 ;S %R=18 D LINE S Z=0
 S C=X,A="" I $D(ERR) S D=ERR,Z=W K ERR G ERR
LOOP F C=C:0:TS W:C'=A ZAA02G("HI"),TS(C) D RD W ZAA02G("LO"),TS(C) S C=C+$S(ZF="E":99,ZF="F":1,ZF=9:1.1,ZF="A":-1,ZF="B":1,ZF=1:1,ZF="":0,"OP5"[ZF:200,1:0),A="" S:C<1 C=TS I C["." F C=C:1:TS+.1 I $D(TS(C)) S C=C-.1 Q
 I TS+5>C S C=1 G LOOP
 I C>200 S X=C-200 G POP1
 ;S A="Z" I $G(EDIT)'=2 F Z=0:1:0 I $D(ST(Z)) F D="CDEL,@OH1","FL,@CB1","GHL,@GD1","BA,CB","CFGL,@IJL1" I 'Z!(D[1) S T=0 F J=1:1:$L(D)+1 S C=$E(D,J) S:C?1A T=$E($O(ST(Z,C)))=C*$E(1248,J)+T I C=",",$P(D,",",2)'[$C(T+64) G ERR
END X ^ZAA02G("ECHO-ON") K LNG,TS,TT,T,Y,SS,SR,SP,SY,ZAA02GX,ZAA02GY,DUP Q
ERR I Z'=W S ERR=D,W=Z G POP1
 S A="Z" F J=1:1:$L(D) S C=$E(D,J) Q:C=","  W $G(ZAA02G("BO")),TS($A(C)-64),$G(ZAA02G("BF")) S:A]C A=C
 S C=$A(A)-64,A="" G LOOP
TT F J=1:1:$L(T,";") I $P(T,";",J)]"" S D=$P(T,";",J),%C=$P(D,",",3) S:$P(D,",",2) %R=$P(D,",",2) S C=$P(D,","),M="M="_ZAA02GP,@M D @$S(J=1:"TT1",1:"TT2")
 Q
TT1 S TS=TS+1,TS(TS)=M_C,L=$C(TS+64) S:%C=4 TS(TS+.1)="" W ZAA02G("LO"),M_C Q:'$D(BLD)  S @ZAA02GSCMD@("XDIR",SCr,1,L)=","_C Q
TT2 S A=$F($TR(C,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","\\\\\\\\\\\\\\\\\\\\\\\\\\"),"\"),I=$E(C,A-1),SS(L_I)=M_$E(C,1,A-2)_ZAA02G("HI")_I_ZAA02G("LO")_$E(C,A,255)
 W $S($D(ST(Z,L_I)):ZAA02G("RON")_$S(ZAA02G["DTM":$P(SS(L_I),ZAA02G("HI"))_$E($P(SS(L_I),ZAA02G("HI"),2))_$P(SS(L_I),ZAA02G("LO"),2),1:SS(L_I)),1:SS(L_I)),ZAA02G("ROF")
 I $P(D,",",5) S SR(L_I)=%R_","_$P(D,",",5,7),SY=$G(SY)+1,SY(SY)=L_I,%C=$P(D,",",5),LNG=$P(D,",",6) W @ZAA02GP,ZAA02G("HI"),ZAA02G("UO"),$E($G(ST(Z,L_I))_SP,1,LNG),ZAA02G("UF")
 Q:'$D(BLD)  S A=$P(D,",",4),@ZAA02GSCMD@("XDIR",SCr,1,L_I)=A_","_C W:A="" "missing code-",L,I R:A="" ccc I A]"" S @ZAA02GSCMD@("XDIR",SCr,2,A)=L_I Q
LINE Q:'$L(B)  S %C=2 W @ZAA02GP,ZAA02G("HI"),ZAA02G("G1"),ZAA02G("LI"),B,ZAA02G("RI"),ZAA02G("G0") Q
RD R A#1 I A="" X ZAA02G("T") S ZF=$E(XX,$F(XX,ZF)) Q
RD2 S:A?1L A=$C($A(A)-32) S ZF="",L=$C(C+64)_A I '$D(SS(L)) W *7 Q
 I $G(EDIT)=2 D ^ZAA02GSCMRC S ZF=5,X=C Q
 I $D(ST(W,L)) G RD1:$D(SR(L)) K ST(W,L) S SD(W,L)=""
 E  S ST(W,L)="",M=$P(DUP,";",C) F T=0:0 Q:M'[A  S T=$L($P(M,A),","),D=$P(M,",",T),M=$P(M,",",T+1,9) F J=1:1:$L(D) S X=$C(C+64)_$E(D,J) I $E(D,J)'=A,$D(ST(W,X)) K ST(W,X) W SS(X) S SD(W,X)=""
RD1 D RDX S RX="" I $D(SR(L)),$D(ST(W,L)) S D=SR(L),%C=$P(D,",",2),LNG=$P(D,",",3),%R=+D,X=ST(W,L) D @$P(D,",",4) S ST(W,L)=X I X="" K ST(W,L) S SD(W,L)="" D RDX
 I $G(RX)?1A S A=RX G RD2
 Q
RDX W ZAA02G("LO"),$S($D(ST(W,L)):ZAA02G("RON")_$S(ZAA02G["DTM":$P(SS(L),ZAA02G("HI"))_$E($P(SS(L),ZAA02G("HI"),2))_$P(SS(L),ZAA02G("LO"),2),1:SS(L)),1:SS(L)),ZAA02G("ROF") Q
PDN S TRM="ABCDEFGHIJKLMNOPQRSTUVWXYZ",CHR="1234567890"_TRM
 S FNC="TB,EX,UK,DK,CR" X ^ZAA02G("ECHO-ON"),^ZAA02GREAD,^ZAA02G("ECHO-OFF")
PDN1 S ZF=$S(FNC="TB":9,FNC="EX":"E",1:"") Q
PD S Y=LNG_",80\HU\HUS\\TB,EX,UK,DK,CR\" D READ^ZAA02GRDL S FNC=ZAA02GF W ZAA02G("UF") G PDN1
PDD S Y="8\HU\HUS\\TB,EX,UK,DK,CR\" D READ^ZAA02GRDD S FNC=ZAA02GF,X=$P(X,"\",2) W ZAA02G("UF") G PDN1
