ZAA02GSCMRE4 ;PG&A,ZAA02G-MTS,1.20,ENTRY SCREEN-REGIONAL;03DEC95  17:13;22AUG95  23:12;;11MAR97  11:30 [ 04/16/97  10:23 AM ]
 ;Copyright (C) 1995, Patterson, Gray and Associates Inc.
 ;
POP D:$D(ZAA02GX)+$D(ZAA02GY)'=2 FUNC^ZAA02GDEV X ^ZAA02G("ECHO-OFF")
 S %R=2,%C=1,B="",$P(B,ZAA02G("HL"),77)="" W @ZAA02GP,ZAA02G("CS")," ",ZAA02G("G1"),ZAA02G("HI"),ZAA02G("TLC"),B,ZAA02G("TRC") F %R=%R+1:1:23 S %C=2 W @ZAA02GP,ZAA02G("VL") S %C=79 W @ZAA02GP,ZAA02G("VL")
 S %R=%R+1,%C=2 W @ZAA02GP,ZAA02G("G1"),ZAA02G("BLC"),B,ZAA02G("BRC"),ZAA02G("G0")
 S %R=2,%C=25,W=0 W @ZAA02GP,ZAA02G("LO"),"Mammography Examination Screen"
POP1 S TS=0,Z=W,SY=1
 S T="LOCATION:,3,4;siZe,,20,MZZ,25,3,PDN;L,,29,MLL;R,,31,MLR;B,,33,MLB;clOck,,36,MLO,42,2,PDN;1,,45,ML1;2,,47,ML2;3,,49,ML3;4,,51,ML4;Ant,,54,MLA;Mid,,58,MLM;Post,,62,MLP;Cen,,68,MLC;Sub,,72,MLS;axT,,76,MLT" D TT
 D PG2
 S T="MASS -  Shape:,4,4;Round,,20,MAR;Irregular,,28,MAX;Lobulated,,40,MAL;Arch distort,,52,MAA;Oval,,67,MAO" D TT
 S T="Density:,5,10;High,,20,MCH;Low,,30,MCL;Equal,,39,MCE;Fat containing,,50,MCF" D TT
 R A:0 X ZAA02G("T") S ZF=$E(XX,$F(XX,ZF)) G:ZF="E" END
 S T="Margins:,6,10;Ill-defined,,20,MBI;Spiculated,,33,MBS;Well defined,,45,MBD;Microlob.,,59,MBM;Obscured,,70,MBU" D TT
 S T="Sp Cases:,7,9;Asymm,,20,MFB;Focal,,27,MFF;duct Ect,,34,MFE;Intramam nodes,,44,MFN;Tubular,,60,MFT;asymm Dens,,69,MFD" D TT
 S T="CA++ - Distr.:,8,4;Diffuse,,20,CBD;Segmented,,29,CBS;Linear,,40,CBL;Grouped/clustered,,48,CBG;Regional,,67,CBR" D TT
 S T="Benign:,9,11;eGg,,20,CAE;Mlk,,24,CAM;Rnd,,28,CAR;spH,,32,CAx;Ben,,36,CAB;Crs,,40,CAC;L-rd,,44,CAL;Fat,,49,CAN;Skn,,53,CAS;Dys,,57,CAD;Vas,,61,CAV;Pun,,65,CAP;suT,,69,CAU;sEc,,73,CAX" D TT
 S T="Other:,10,12;Gran,,20,CAG;Pleo,,26,CAQ;Amor,,32,CAA;Various,,38,CAW;Heter,,47,CAH;Branch,,54,CAJ;Fine,,62,CAF;Casting,,68,CAI" D TT
 S T="ASSOC FINDNGS:,11,4;Hematoma,,20,AAH;Nipple retraction,,31,AAN;skin-Lesion,,51,AAL;Skin thickeng,,65,AAS;arch.-Dist,12,20,AAD;Trabecular,,32,AAT;Post-surg-scar,,44,AAP;Axill,,60,AAA;Inc density,,67,AAI" D TT
 S T="CHANGES:,13,4;No change,,20,CDN;compl-Rem,,32,CDR;Partially-rem,,44,CDP;Inc size,,60,CD+;dec Size,,71,CD-;inc-#-Calc,14,20,CDI;Dec-#-calc,,32,CDD;Less defined,,45,CDX;More defined,,60,CDO" D TT
 S DUP="LRB,AMP,O13,O24,CST;RLOIA;HLEF;;AFIT;DLSGR;;;;;SDPTFR;BLRPO;VDMAF;NBSIPM;NF,NB,NH,NL,NM,NX,NE,NO,ND,NU,NA,NC,NP,NS,NT,NY,NI,NG"
 S %R=15 D LINE S (SY,Z)=0
 S T="REASON:,16,4;Screen,,20,RAS;Diag,,29,RAP;add'l-Prior,,36,RAA;-This study,,47,RAV;Follow-up,,61,RAF;Review,,73,RAO" D TT
 S T="STUDY:,17,4;Bilateral,,20,TSS;Left,,32,TSL;Right,,39,TSR;Post Mastectomy,,47,TSP;uncOoperative,,64,TSI" D TT
 S T="TISSUE DENS.:,18,4;Very dense,,20,BA4;Dense,,33,BA3;Moderate,,41,BA5;Average,,52,BA2;Fatty,,62,BA1" D TT
 S T="ASSESSMENT:,19,4;Neg,,20,ABN;Benign,,25,ABB;Suspicious,,33,ABS;Incomplete,,45,ABA;Prob-benign,,57,ABP;Malignant,,70,ABM" D TT
 S T="RECOMMENDATIONS:,20,4;Norm,,20,RCN;Flup (mo),,26,RCF,36,2,PDN;Bx,,40,RCB;Hist,,44,RCH;needLe,,50,RCL;Magn,,58,RCM;u/s-eXam,,64,RCU;stEreo,,73,RCR" D TT
 S T=";Old films,21,20,RCO;Decision,,31,RCD;U/s-fna,,41,RCS;Aspir,,50,RCA;Clinical,,57,RCC;Proj,,67,RCP;Spot,,73,RCG" D TT
 S T=";Take action,22,20,RCT;Y/s core,,33,RCJ;Galactogram,,43,RCI;excIsional biopsy,,56,RCE" D TT
 S T="OTHER:,23,4;Tech,,20,OBT,25,12,PD;Previous Films,,40,XXF,55,20,PD" D TT
 F T=1,11 S TS(T+.1)=""
 S C=X,A="" I $D(BLD) K BLD G ZAA02GSCMRE4
 I $D(ERR) S D=ERR,Z=W K ERR G ERR
LOOP F C=C:0:TS W:C'=A ZAA02G("HI"),TS(C) D RD W ZAA02G("LO"),TS(C) S C=C+$S(ZF="E":99,ZF="F":1,ZF=9:1.1,ZF="A":-1,ZF="B":1,ZF=1:1,ZF="":0,"OP5Y"[ZF:200,1:0),A="" S:C<1 C=TS I C["." F C=C-.1:1:TS Q:$D(TS(C))
 I TS+5>C S C=1 G LOOP
 I C>200 S X=C-200 G POP1:ZF=5,HLP:ZF="Y",PG
 G:$G(EDIT)=2 END S A="Z"
 F Z=0:1:5 I $D(ST(Z))!'Z F D="BCD,@G","FGH,@CE","BFIA,@IJLNM","KLM,G","NO,C" I 'Z!(D[1) S T=0 F J=1:1:$L(D)+1 S C=$E(D,J) S:C?1A T=$E($O(ST(Z,C)))=C*$E(1248,J)+T I C=",",$P(D,",",2)'[$C(T+64) G ERR
 F Z=0:1:5 I $D(ST(Z))!'Z F D="NN,FGHIJA" S C=$P(D,",",2) I $D(ST(Z,$P(D,","))) F J=1:1:$L(C) S T=$E(C,J) I $E($O(ST(Z,T)))=T S D=$E(D) G ERR
 F Z=0:1:5 I $D(ST(Z))!'Z F D="A" I $O(ST(Z,D))[D,$D(ST(Z,"AL"))+$D(ST(Z,"AR"))+$D(ST(Z,"AB"))=0 G ERR
END X ^ZAA02G("ECHO-ON") K LNG,TS,TT,T,Y,SS,SR,SP,SY,ZAA02GX,ZAA02GY,DUP Q
ERR I Z'=W S ERR=D,W=Z G POP1
 S A="Z" F J=1:1:$L(D) S C=$E(D,J) Q:C=","  W $G(ZAA02G("BO")),TS($A(C)-64),$G(ZAA02G("BF")) S:A]C A=C
 S (C,A)=$A(A)-64 W $G(ZAA02G("BO")),ZAA02G("HI"),TS(C),$G(ZAA02G("BF")) G LOOP
TT F J=1:1:$L(T,";") I $P(T,";",J)]"" S D=$P(T,";",J),%C=$P(D,",",3) S:$P(D,",",2) %R=$P(D,",",2) S C=$P(D,","),M="M="_ZAA02GP,@M D @$S(J=1:"TT1",1:"TT2")
 Q
TT1 S TS=TS+1,TS(TS)=M_C,I=$C(TS+64) W ZAA02G("LO"),M_C Q:'$D(BLD)  S @ZAA02GSCMD@("XDIR",SCr,1,I)=","_C Q
TT2 S A=$F($TR(C,"ABCDEFGHIJKLMNOPQRSTUVWXYZ1234","\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\"),"\"),L=$E(C,A-1),SS(I_L)=M_$E(C,1,A-2)_ZAA02G("HI")_L_ZAA02G("LO")_$E(C,A,255),L=I_L S:SY SY(L)=""
 D RDX I $P(D,",",5) S SR(L)=%R_","_$P(D,",",5,7),%C=$P(D,",",5),LNG=$P(D,",",6) W @ZAA02GP,ZAA02G("HI"),ZAA02G("UO"),$E($G(ST(Z,L))_SP,1,LNG),ZAA02G("UF")
 Q:'$D(BLD)  S A=$P(D,",",4),@ZAA02GSCMD@("XDIR",SCr,1,L)=A_","_C W:A="" "missing code-",L R:A="" ccc I A]"" S @ZAA02GSCMD@("XDIR",SCr,2,A)=L Q
 Q
PG S Z=9,C=1 D PG3 S (W,Z)=$S(ZF="P":-1,1:1)+W#5 D PG3,PG2 G LOOP
PG2 S %R=3 W ZAA02G("HI") F %C=14:1:18 W @ZAA02GP,$S(%C-14=Z:ZAA02G("RON")_(%C-13)_ZAA02G("ROF"),'$D(ST(%C-14)):" ",1:%C-13)
 Q
PG3 S L="" F J=1:1 S L=$O(ST(W,L)) Q:L=""  I $D(SY(L)) D RDX I $D(SR(L)) S D=SR(L),%C=$P(D,",",2),LNG=$P(D,",",3),%R=+D,X=$G(ST(Z,L)) W @ZAA02GP,$E(X_SP,1,LNG)
 Q
HLP S C=X  S EDIT=$G(EDIT)_"A",TYPSS=TYPS,TYPS="" G END
 ;
LINE Q:'$L(B)  S %C=2 W @ZAA02GP,ZAA02G("HI"),ZAA02G("G1"),ZAA02G("LI"),B,ZAA02G("RI"),ZAA02G("G0") Q
RD R A#1 I A="" X ZAA02G("T") S ZF=$E(XX,$F(XX,ZF)) Q
RD2 S:A?1L A=$C($A(A)-32) S ZF="",L=$C(C+64)_A I '$D(SS(L)) W *7 Q
 I $G(EDIT)=2 D ^ZAA02GSCMRC S ZF=5,X=C Q
 S Z=$S($D(SY(L)):W,1:0) I $D(ST(Z,L)) G RD1:$D(SR(L)) K ST(Z,L) S SD(Z,L)=""
 E  S ST(Z,L)="",M=$P(DUP,";",C) F T=0:0 Q:M'[A  S T=$L($P(M,A),","),D=$P(M,",",T),M=$P(M,",",T+1,99) F J=1:1:$L(D) S X=$C(C+64)_$E(D,J) I $E(D,J)'=A,$D(ST(Z,X)) K ST(Z,X) W SS(X) S SD(Z,X)="" D:$D(SR(X)) RDY
RD1 D RDX S RX="" I $D(SR(L)),$D(ST(Z,L)) S D=SR(L),%C=$P(D,",",2),LNG=$P(D,",",3),%R=+D,X=ST(Z,L) D @$P(D,",",4) S ST(Z,L)=X I X="" K ST(Z,L) S SD(Z,L)="" D RDX
 I $G(RX)?1A S A=RX G RD2
 Q
RDY S Y=SR(X),%C=$P(Y,",",2),LNG=$P(Y,",",3),%R=+Y W @ZAA02GP,$J("",LNG) Q
RDX W ZAA02G("LO"),$S($D(ST(Z,L)):ZAA02G("RON")_$S(ZAA02G["DTM":$P(SS(L),ZAA02G("HI"))_$E($P(SS(L),ZAA02G("HI"),2))_$P(SS(L),ZAA02G("LO"),2),1:SS(L)),1:SS(L)),ZAA02G("ROF") Q
PDN S TRM="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxzy",CHR=TRM_"1234567890"
 S FNC="TB,EX,UK,DK,CR" X ^ZAA02G("ECHO-ON"),^ZAA02GREAD,^ZAA02G("ECHO-OFF")
PDN1 S ZF=$S(FNC="TB":9,FNC="EX":"E",1:"") Q
PD S Y=LNG_",80\HU\HUS\\TB,EX,UK,DK,CR\" D READ^ZAA02GRDL S FNC=ZAA02GF W ZAA02G("UF") G PDN1
