ZAA02GSCMRP2 ;PG&A,ZAA02G-MTS,1.20,PAT INFO SCREEN;06JAN94  22:26;6JAN95 5:43P;;16OCT95 10:04A
 ;Copyright (C) 1995, Patterson, Gray and Associates Inc.
 ;
POP D:$D(ZAA02GX)+$D(ZAA02GY)'=2 FUNC^ZAA02GDEV
 S %R=2,%C=1 W @ZAA02GP,ZAA02G("CS") S %C=2,B="",$P(B,ZAA02G("HL"),77)="" W @ZAA02GP,ZAA02G("LO"),ZAA02G("ROF"),ZAA02G("L"),@ZAA02GP,ZAA02G("G1"),ZAA02G("TLC"),B,ZAA02G("TRC") F %R=%R+1:1:23 S %C=2 W @ZAA02GP,ZAA02G("VL") S %C=79 W @ZAA02GP,ZAA02G("VL")
 S %R=%R+1,%C=2 W @ZAA02GP,ZAA02G("G1"),ZAA02G("BLC"),B,ZAA02G("BRC"),ZAA02G("G0")
 S TS=0,%R=2,%C=27 W @ZAA02GP,ZAA02G("LO"),"Patient Information Screen"
 I $D(MAMMO) F J=1:1:$L(MAMMO,";") S A=$P(MAMMO,";",J) I A]"" S D=$P(A,",") I D]"",$D(@ZAA02GSCMD@("XDIR",SCr,2,D)) S D=^(D),(ST(D),SM(D))=$P(A,",",2)
 ; S T="RECOMMENDATIONS:,21,4;Normal-screen,,20,,RCN;Bx,,35,,RCE;Aspiration,,39,,RCA;Flup,,51,,RCF;bX considered,,57,,RCB" D TT ;;Spot,20,72,," D TT
XX ;
 S T="ETHNICITY:,4,4;White,,17,,ET1;Black,,25,,ET2;american Indian/eskimo,,33,,ET3;Asian/Pacific islander,,57,,ET4" D TT
 S T="Other,5,17,,ET5;Hispanic,,31,,ETH" D TT
 S T="FAMILY HIST:,7,4;No history,,17,,RB0;Aunt...,,31,,RB1;Post-menopausal,,42,,RB2;pRe-Menopausal,,60,,RB3" D TT
 S T="BR. HIST-L:,9,4;Aspiration,,17,,PHLA;Needle bx,,29,,PHLN;Lumpectomy,,40,,PHLL;Mastectomy,,52,,PHLM;Radiation,,64,,PHLR;Other,,74,,PHLO" D TT
 S T="BR. HIST-R:,10,4;Aspiration,,17,,PHRA;Needle bx,,29,,PHRN;Lumpectomy,,40,,PHRL;Mastectomy,,52,,PHRM;Radiation,,64,,PHRR;Other,,74,,PHRO" D TT
 ; S T="BREAST HIST-R:,12,4;Aspiration,12,17;Needle Biopsy,12,29;Lumpectomy,12,44;Mastectomy,12,56;Radiation,12,68" D TT
 ; S T="personal - Breast cancer,15,17;Uterine/Ovarian,15,44;High risk lesion,15,62" D TT
 ; S T="Post-menopausal,16,28;Late child bearing,16,46" D TT
 S T="PROBLEMS:,12,4;palpable Abnormality,,17,,IAA;Bl disch,,40,,IAB;non-bl Disch,,51,,IAD;Exam,,65,,IAE;Implant,,72,,IAI" D TT
 S T=";Skin thickening,13,17,,IAK;Lump,,34,,IAL;Nipple abnor,,40,,IAN;Pain,,53,,IAP;Cancer,,58,,IAW;aXillary nodes,,65,,IAX" D TT
 ; S T="IMPLANTS:,21,4;Silicone,21,17;Aug. Mammo,21,27;Pre-pectoral,21,39;Retro-pectoral,21,53;saLine,21,69" D TT
 ; S T="Combination,22,17;Unknown,22,30" D TT
 ; S T="ONSET OF:,7,4;Menarche,7,17,1;First pregnancy,7,30,2;meNopause,7,50,3;Hysterectomy,7,64,4" D TT
 ;S T="Ovaries removed,8,17,5" D TT
 S T="OTHER:,15,4;Pregnant,,17,,OTAP;Fertility,,27,,OTAF;Nursing,,38,,OTAN;nursed Lately,,47,,OTAL;Children,,62,2,OTC" D TT
 S T=";Age of 1st preg,16,17,2,OTG;1st Period,,38,2,OTP;Last period,,59,4,OTL" D TT
 S T=";Menopausal,17,17,,OTAM;Hyster,,33,,OTAH" D TT
 S T=";Contraceptives,18,17,,OTMB;Estrogen,,35,,OTME;Fertility,,47,,OTMF;Other,,63,,OTMO" D TT
 ;
 S YY="23,25,20,PD;23,66,2,PDN"
 S DUP="BFSD;RLB;VDAF;RLOIA;HLEF;ISWMO;AFIT;;;GSRDL;CEMPSVDLSRU;AHF;HNLSDTPA;;NBPSMI;NBAFXHLTPMU;FA" R XXX
 W ZAA02G("HI"),ZAA02G("UO") I $L(YY) F B=1:1:$L(YY,";") S D=$P(YY,";",B),%C=$P(D,",",2),LNG=$P(D,",",3),%R=+D W @ZAA02GP,$E($G(ST(SY(B)))_SP,1,LNG)
 W ZAA02G("UF") X ^ZAA02G("ECHO-OFF") S C=1,A=""
LOOP F C=C:0:TS W:C'=A ZAA02G("HI"),TS(C) D RD W ZAA02G("LO"),TS(C) S C=C+$S(ZF="E":99,ZF="F":1,ZF=9:1.1,ZF="A":-1,ZF="B":1,ZF=1:1,1:0),A="" S:C<1 C=TS I C["." F C=C-.1:1:TS Q:$D(TS(C))
 I TS+5>C S C=1 G LOOP
 S A=0 F C="P","O","B","A" I $E($O(ST(C)))'=C W $G(ZAA02G("BO")),TS($A(C)-64),$G(ZAA02G("BF")) S A=$A(C)-64
 I A S C=A G LOOP
 X ^ZAA02G("ECHO-ON") K LNG,TS,TT,T,Y,SS,SR,SP,SY,ZAA02GX,ZAA02GY,TR Q
TT F J=1:1:$L(T,";") I $P(T,";",J)]"" S D=$P(T,";",J),%C=$P(D,",",3) S:$P(D,",",2) %R=$P(D,",",2) S C=$P(D,","),M="M="_ZAA02GP,@M D @$S(J=1:"TT1",1:"TT2")
 Q
TT1 S TS=TS+1,TS(TS)=M_C,L=$C(TS+64) S:%C=4 TS(TS+.1)="" W ZAA02G("LO"),M_C Q:'$D(BLD)  S @ZAA02GSCMD@("XDIR",SCr,1,L)=","_C Q
TT2 S B=$F($TR(C,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","\\\\\\\\\\\\\\\\\\\\\\\\\\"),"\"),I=$E(C,B-1),SS(L_I)=M_$E(C,1,B-2)_ZAA02G("HI")_I_ZAA02G("LO")_$E(C,B,255)
 W $S($D(ST(L_I)):ZAA02G("RON")_$S(ZAA02G["DTM":$P(SS(L_I),ZAA02G("HI"))_$E($P(SS(L_I),ZAA02G("HI"),2))_$P(SS(L_I),ZAA02G("LO"),2),1:SS(L_I)),1:SS(L_I)),ZAA02G("ROF")
 I $P(D,",",4) S SR(L_I)=$P(D,",",4),SY($P(D,",",4))=L_I
 Q:'$D(BLD)  S B=$P(D,",",5),@ZAA02GSCMD@("XDIR",SCr,1,L_I)=B_","_C W:B="" "missing code-",L,I R:B="" ccc I B]"" S @ZAA02GSCMD@("XDIR",SCr,2,B)=L_I Q
RD R A#1 I A="" X ZAA02G("T") S ZF=$E(XX,$F(XX,ZF)) Q
 S:A?1L A=$C($A(A)-32) S ZF="",L=$C(C+64)_A I '$D(SS(L)) W *7 Q
 I $D(ST(L)) G RD1:$D(SR(L)) K ST(L) S SD(L)=""
 E  S ST(L)="",D=$P(DUP,";",C) I D[A S D=$P(D,",",$L($P(D,A),",")) F J=1:1:$L(D) S X=$C(C+64)_$E(D,J) I $E(D,J)'=A,$D(ST(X)) K ST(X) W SS(X) S SD(L)=""
RD1 W ZAA02G("LO"),$S($D(ST(L)):ZAA02G("RON")_$S(ZAA02G["DTM":$P(SS(L),ZAA02G("HI"))_$E($P(SS(L),ZAA02G("HI"),2))_$P(SS(L),ZAA02G("LO"),2),1:SS(L)),1:SS(L)),ZAA02G("ROF")
 I $D(SR(L)),$D(ST(L)) S D=$P(YY,";",SR(L)),%C=$P(D,",",2),LNG=$P(D,",",3),%R=+D,X=ST(L) D @$P(D,",",4) S ST(L)=X I X="" K ST(L) S SD(L)=""
 Q
PDN S CHR="1234567890"
 S FNC="TB,EX,UK,DK,CR" X ^ZAA02GREAD X ^ZAA02G("ECHO-OFF")
PDN1 S ZF=$S(FNC="TB":9,FNC="EX":"E",1:"") Q
PD S Y=LNG_",80\HU\HUS\\TB,EX,UK,DK,CR\" D READ^ZAA02GRDL S FNC=ZAA02GF W ZAA02G("UF") G PDN1
