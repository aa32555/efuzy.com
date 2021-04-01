ZAA02GSCMR2 ;PG&A,ZAA02G-SCRIPT,1.30,PATIENT INFO ENTRY SCREEN;06JAN94  22:26;3JAN94 5:16P;;29DEC94 8:53A [ 02/05/95   6:08 AM ]
 ;Copyright (C) 1994, Patterson, Gray and Associates Inc.
 ;
POP K BLD S:'$G(@ZAA02GSCMD@("XDIR","HA")) BLD=1 S %C=1,%R=2,SP="",$P(SP,$S(ZAA02G["PC":".",1:" "),60)="" W @ZAA02GP,ZAA02G("CS")
 D:$D(ZAA02GX)+$D(ZAA02GY)'=2 FUNC^ZAA02GDEV
 S TR="ABCDEFG"
 K ST,SR I $D(MAMMO) F J=1:1:$L(MAMMO,";") S A=$P(MAMMO,";",J) I A]"" S D=$P(A,","),ST($TR($E(D),TR,123456)_$E(D,2))=$P(A,",",2)
 S %R=2,%C=2,B="",$P(B,ZAA02G("HL"),77)="" W @ZAA02GP,ZAA02G("LO"),ZAA02G("ROF"),ZAA02G("L"),@ZAA02GP,ZAA02G("G1"),ZAA02G("TLC"),B,ZAA02G("TRC") F %R=%R+1:1:23 S %C=2 W @ZAA02GP,ZAA02G("VL") S %C=79 W @ZAA02GP,ZAA02G("VL")
 S %R=%R+1,%C=2 W @ZAA02GP,ZAA02G("G1"),ZAA02G("BLC"),B,ZAA02G("BRC"),ZAA02G("G0")
 S TS=0,%R=2,%C=25 W @ZAA02GP,ZAA02G("LO"),"Patient Information Worksheet"
XX ;
 S T="ETHNICITY:,4,4;White,4,17;Black,4,25;american Indian/eskimo,4,33;Asian/Pacific islander,4,57" D TT
 S T="Other,5,17;Hispanic,5,31" D TT
 S T="ONSET OF:,7,4;Menarche,7,17,1;First pregnancy,7,30,2;meNopause,7,50,3;Hysterectomy,7,64,4" D TT
 S T="Ovaries removed,8,17,5" D TT
 S T="Contraceptives,9,17,6;Estrogen,9,35,7;Progesterone,9,47,8;Tamoxifen,9,63,9" D TT
 S YY="7,26,2,PDN;7,46,2,PDN;7,60,2,PDN;7,76,2,PDN;8,33,2,PDN;9,32,2,PDN;9,44,2,PDN;9,60,2,PDN;9,73,2,PDN"
 S T="HISTORY-L:,11,4;Aspiration,11,17;Needle Biopsy,11,29;Lumpectomy,11,44;Mastectomy,11,56;Radiation,11,68" D TT
 S T="HISTORY-R:,12,4;Aspiration,12,17;Needle Biopsy,12,29;Lumpectomy,12,44;Mastectomy,12,56;Radiation,12,68" D TT
 S T="RISK:,14,4;family,14,17;- No History,14,26;Weak,14,42;Intermediate,14,50;Very strong,14,66" D TT
 S T="personal - Breast cancer,15,17;Uterine/Ovarian,15,44;High risk lesion,15,62" D TT
 S T="Post-menopausal,16,28;Late child bearing,16,46" D TT
 S T="PROBLEMS:,18,4;palpable Abnormality,18,17;Discharge,18,40;difficult Exam,18,52;Implant,18,69" D TT
 S T="Skin thickening,19,17;Lump,19,34;Nipple retraction,19,40;Pain,19,59;Other cancer,19,65" D TT
 S T="IMPLANTS:,21,4;Silicone,21,17;Aug. Mammo,21,27;Pre-pectoral,21,39;Retro-pectoral,21,53;saLine,21,69" D TT
 S T="Combination,22,17;Unknown,22,30" D TT
 W ZAA02G("HI"),ZAA02G("UO") F B=1:1:$L(YY,";") S D=$P(YY,";",B),%C=$P(D,",",2),LNG=$P(D,",",3),%R=+D W @ZAA02GP,$E($G(ST(SY(B)))_SP,1,LNG)
 W ZAA02G("UF") X ^ZAA02G("ECHO-OFF") S DUP="WBIAO;;;NWIV;"
 F C=1:0:TS W ZAA02G("HI"),TS(C) D RD W ZAA02G("LO"),TS(C) S C=C+$S(ZF="E":99,ZF="F":1,ZF=9:1,ZF="A":-1,ZF="B":1,ZF=1:1,1:0) S:C<1 C=1
 X ^ZAA02G("ECHO-ON") S MAMMO="",A="" F J=1:1 S A=$O(ST(A)) Q:A=""  S MAMMO=MAMMO_$E(TR,$E(A))_$E(A,2)_$S($L(ST(A)):","_ST(A),1:"")_";"
 K TS,TT,T,Y,SS,ST,SR,SP,SY,ZAA02GX,ZAA02GY,TR Q
TT F J=1:1:$L(T,";") S D=$P(T,";",J),%C=$P(D,",",3),%R=$P(D,",",2),C=$P(D,","),M="M="_ZAA02GP,@M D @$S(C?4.UP:"TT1",1:"TT2")
 Q
TT1 S TS=TS+1,TS(TS)=M_C,L=TS W M_C Q:'$D(BLD)  S @ZAA02GSCMD@("XDIR","H"_$C(TS+64))=C Q
TT2 S B=$F($TR(C,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","\\\\\\\\\\\\\\\\\\\\\\\\\\"),"\"),I=$E(C,B-1),SS(L_I)=M_$E(C,1,B-2)_ZAA02G("HI")_I_ZAA02G("LO")_$E(C,B,255) W $S($D(ST(L_I)):ZAA02G("RON"),1:""),SS(L_I),ZAA02G("ROF")
 I $P(D,",",4) S SR(L_I)=$P(D,",",4),SY($P(D,",",4))=L_I
 Q:'$D(BLD)  S @ZAA02GSCMD@("XDIR","H"_$C(TS+64)_I)=C Q
RD R A#1 I A="" X ZAA02G("T") S ZF=$E(XX,$F(XX,ZF)) Q
 S ZF="" S:A?1L A=$C($A(A)-32) I '$D(SS(C_A)) W *7 Q
 I $D(ST(C_A)) K:ST(C_A)="" ST(C_A)
 E  S ST(C_A)="",D=$P(DUP,";",C) I D[A S D=$P(D,",",$L($P(D,A),",")) F J=1:1:$L(D) I $E(D,J)'=A,$D(ST(C_$E(D,J))) K ST(C_$E(D,J)) W SS(C_$E(D,J))
 W ZAA02G("LO"),$S($D(ST(C_A)):ZAA02G("RON"),1:""),SS(C_A),ZAA02G("ROF")
 I $D(SR(C_A)),$D(ST(C_A)) S D=$P(YY,";",SR(C_A)),%C=$P(D,",",2),LNG=$P(D,",",3),%R=+D,X=ST(C_A) D @$P(D,",",4) S ST(C_A)=X
 Q
PDN S CHR="1234567890"
 S FNC="TB,EX,UK,DK,CR" X ^ZAA02GREAD X ^ZAA02G("ECHO-OFF")
PDN1 S ZF=$S(FNC="TB":9,FNC="EX":"E",1:"") Q
PD S Y=LNG_",80\HU\HUS\\TB,EX,UK,DK,CR\" D READ^ZAA02GRDL S FNC=ZAA02GF W ZAA02G("UF") G PDN1
LOAD K C S A="" F J=3:1 S A=$O(^PIW(A)) Q:A=""  S B=" "_^(A),C(J)="" F L=1:1:$L(B,"  ") S D=$P(B,"  ",L) I D'?." " D L1
 S C="" F J=1:1 S C=$O(C(C)) Q:C=""  K:C(C)="" C(C) I $D(C(C)) S C(C)=" S T="""_C(C)_""" D TT"
 X "ZL ZAA02GSCMR2 P XX S C=0 F J=1:1 S C=$O(C(C)) ZS:$L(C)=0  Q:$L(C)=0  ZI C(C)"
 Q
L1 F K=1:1 I $E(D,K)'=" " S D=$E(D,K,99) Q
 F K=$L(D):-1 I $E(D,K)'=" " S D=$E(D,1,K) Q
 S C(J)=C(J)_D_","_J_","_($F(B,D)-$L(D)+2)_";"
 Q
