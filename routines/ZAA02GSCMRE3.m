ZAA02GSCMRE3 ;PG&A,ZAA02G-MTS,1.20,ENTRY SCREEN;06JAN94  22:26;6JAN95 5:43P;;16OCT95 10:02A
 ;Copyright (C) 1995, Patterson, Gray and Associates Inc.
 ;
POP D:$D(ZAA02GX)+$D(ZAA02GY)'=2 FUNC^ZAA02GDEV
 S %R=2,%C=2,B="",$P(B,ZAA02G("HL"),77)="" W @ZAA02GP,ZAA02G("LO"),ZAA02G("ROF"),ZAA02G("L"),@ZAA02GP,ZAA02G("G1"),ZAA02G("TLC"),B,ZAA02G("TRC") F %R=%R+1:1:23 S %C=2 W @ZAA02GP,ZAA02G("VL") S %C=79 W @ZAA02GP,ZAA02G("VL")
 S %R=%R+1,%C=2 W @ZAA02GP,ZAA02G("G1"),ZAA02G("BLC"),B,ZAA02G("BRC"),ZAA02G("G0")
 S TS=0,%R=2,%C=25 W @ZAA02GP,ZAA02G("LO"),"Mammography Examination Screen"
 S T="REASON:,4,4;Baseline,,20,,XRB;Follow-up,,34,,XRF;Special View,,48,,XRS;Diagnostic,,65,,XRD" D TT
 S T="MAMMOGRAM:,5,4;Bilat,,20,,XXB;R,,27,,XXR;L,,30,,XXL;CC,,35,,XXC;MLO,,42,,XXM;oTher,,51,,XXT" D TT
 S T="Composition:,6,6;Very dense,,20,,BA4;Dense,,33,,BA3;Average,,41,,BA2;Fatty,,51,,BA1;Implants,,62,,IBI" D TT
 S T="MASS - Shape:,7,6;Round,,20,,MAR;Lobulated,,29,,MAL;Oval,,41,,MAO;Irregular,,51,,MAX;Arch distort,,62,,MAA" D TT
 S T="Density:,8,8;High,,20,,MCH;Low,,30,,MCL;Equal,,39,,MCE;Fat containing,,50,,MCF" D TT
 S T="Margins:,9,8;Ill-defined,,20,,MBI;Spiculated,,32,,MBS;Well defined,,43,,MBD;Microlobulated,,56,,MBM;Obscured,,71,,MBU" D TT
 S T="Sp Cases:,10,8;Asymmetric,,20,,MFB;Focal asymm.,,32,,MFF;Intramammary nodes,,46,,MFN;Tub/sol duct,,66,,MFT" D TT
 S T="Lesion 1:,11,6;L,,20,,MDL;R,,22,,MDR;B,,24,,MDB;Anterior,,26,,MDA;Middle,,35,,MDM;Posterior,,42,,MDP;Central,,52,,MDC;Subareolar,,60,,MDS;ax.-Tail,,71,,MDT" D TT
 S T="Lesion 2:,12,6;L,,20,,MDL;R,,22,,MDR;B,,24,,MDB;Anterior,,26,,MDA;Middle,,35,,MDM;Posterior,,42,,MDP;Central,,52,,MDC;Subareolar,,60,,MDS;ax.-Tail,,71,,MDT" D TT
 S T="Ca++ - Distr.:,13,6;Diffused,,20,,CBD;Linear,,30,,CBL;Segmented,,38,,CBS;Grouped/clustered,,49,,CBG;Regional,,68,,CBR" D TT
 S T="Benign:,14,9;Crs,,20,,CAC;Eggshl,,24,,CAE;Milk,,31,,CAM;Punc,,36,,CAP;Skin,,41,,CAS;Vasc,,46,,CAV;Dyst,,51,,CAD;Lrg-rod,,56,,CAL;spHr,,64,,CAH;Rnd,,69,,CAR;sUt,,73,,CAU" D TT
 S T="Other:,15,9;Amorphous/indistinct,,20,,CAA;Heterogeneous,,44,,CAH;Fine,,61,,CAF" D TT
 S T="Findings:,16,6;Hematoma,,20,,AAH;Nipple retraction,,31,,AAN;skin-Lesion,,51,,AAL;Skin thickeng,,65,,AAS;arch.-Dist,17,20,,AAD;Trabecular-thick,,33,,AAT;Post-surg-scar,,51,,AAP;Axil.-adeno,,67,,AAA" D TT
 S T="Changes:,18,6;No change,,20,,CDN;compl-Rem,,32,,CDR;Partially-rem,,44,,CDP;Inc size,,60,,CD+;dec Size,,71,,CD-;inc-#-Calc,19,20,,CDI;Dec-#-calc,,32,,CDD;Less defined,,45,,CDX;More defined,,60,,CDO" D TT
 S T="ASSESSMENT:,20,4;Neg,,20,,ABN;Benign,,25,,ABB;Prob-benign,,33,,ABP;Suspicious,,46,,ABS;Malignant,,58,,ABM;Incomplete,,69,,ABA" D TT
 S T="RECOMMENDATIONS:,21,4;Normal-screen,,20,,RCN;Bx,,35,,RCE;Aspiration,,39,,RCA;Flup,,51,,RCF;bX considered,,57,,RCB" D TT ;;Spot,20,72,," D TT
 S T=";Histology,22,20,,RCH;needLe,,31,,RCL;Take action,,39,,RCT;addntl-Proj,,52,,RCP;Magn,,65,,RCM;Ultra,,71,,RCU" D TT
 ;        Diffused  Linear  Segmented  Grouped/clustered  Regional
 ;        Crs Eggshl Milk Punc Skin Vasc Dyst Lrg-rod SpHr Rnd sUt
 ;        Amorphous/indistinct    Heterogeneous    Fine
 ;        Hematoma   Nipple retraction   skin-Lesion   Skin thickeng
 ;        Arch.-dist   Trabecular-thick  Post-surg-scar  Axil.-adeno
 ;        No change   compl-Rem   Partially-rem   Inc size   Dec size
 ;        Inc-#-calc  Dec-#-calc   Less defined   More defined
 ;        Neg.  Benign  Prob-benign  Suspicious  Malignant  Incomplete
 ;        Normal-screen  Bx  Aspiration  Flup  bX considered  Spot
 ;        Histology  Needle  Take action  addntl-Proj  Magn  Ultra
 ;
 ;2345678901234567890123456789012345678901234567890123456789012345678
 ;        2         3         4         5         6         7
 S T="OTHER:,23,4;Tech,23,20,1,OBT;Follow-up in (mo),23,48,2,OBF;Age 40,23,70,,OBA" D TT
 S YY="23,25,20,PD;23,66,2,PDN"
 S DUP="BFSD;RLB;VDAF;RLOIA;HLEF;ISWMO;AFIT;;;GSRDL;CEMPSVDLSRU;AHF;HNLSDTPA;;NBPSMI;NBAFXHLTPMU;FA"
 W ZAA02G("HI"),ZAA02G("UO") I $L(YY) F B=1:1:$L(YY,";") S D=$P(YY,";",B),%C=$P(D,",",2),LNG=$P(D,",",3),%R=+D W @ZAA02GP,$E($G(ST(SY(B)))_SP,1,LNG)
 W ZAA02G("UF") X ^ZAA02G("ECHO-OFF") S C=1,A=""
LOOP F C=C:0:TS W:C'=A ZAA02G("HI"),TS(C) D RD W ZAA02G("LO"),TS(C) S C=C+$S(ZF="E":99,ZF="F":1,ZF=9:1.1,ZF="A":-1,ZF="B":1,ZF=1:1,1:0),A="" S:C<1 C=TS I C["." F C=C-.1:1:TS Q:$D(TS(C))
 I TS+5>C S C=1 G LOOP
 S A=0 F C="P","O","B","A" I $E($O(ST(C)))'=C W $G(ZAA02G("BO")),TS($A(C)-64),$G(ZAA02G("BF")) S A=$A(C)-64
 I A S C=A G LOOP
 X ^ZAA02G("ECHO-ON") K LNG,TS,TT,T,Y,SS,SR,SP,SY,ZAA02GX,ZAA02GY Q
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
