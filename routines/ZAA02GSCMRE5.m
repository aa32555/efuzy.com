ZAA02GSCMRE5 ;PG&A,ZAA02G-MTS,1.20,ENTRY SCREEN-NASSAU;;;;07JAN97  21:35 [ 04/16/97  10:23 AM ]
 ;Copyright (C) 1996, Patterson, Gray and Associates Inc.
 ;
POP D:$D(ZAA02GX)+$D(ZAA02GY)'=2 FUNC^ZAA02GDEV X ^ZAA02G("ECHO-OFF")
 S %R=2,%C=1,B="",$P(B,ZAA02G("HL"),77)="" W @ZAA02GP,ZAA02G("CS")," ",ZAA02G("G1"),ZAA02G("HI"),ZAA02G("TLC"),B,ZAA02G("TRC") F %R=%R+1:1:23 S %C=2 W @ZAA02GP,ZAA02G("VL") S %C=79 W @ZAA02GP,ZAA02G("VL")
 S %R=%R+1,%C=2 W @ZAA02GP,ZAA02G("G1"),ZAA02G("BLC"),B,ZAA02G("BRC"),ZAA02G("G0")
 S %R=2,%C=25,W=0 W @ZAA02GP,ZAA02G("LO"),"Mammography Examination Screen"
 I $E($O(ST(0,"B")))'="B" S ST(0,"BB")=""
POP1 S (S,Z,W,SY,TS)=0
 S T="COMPARISON:,3,4;No change from study:,,20,CFN,42,8,PDT;Change from study:,,52,CFS,71,8,PDT" D TT
 S T="STUDY:,4,4;Bilateral,,20,TSB;Left,,32,TSL;Right,,39,TSR;Follow-up,,50,TSF" D TT
 S T="TISSUE DENS.:,5,4;Fatty,,20,BA1;Mild,,27,BA2;mOderate,,33,BA5;Dense,,43,BA4;Cystic,,52,BA6;Glandular,,60,BA7;dUctal,,71,BA8" D TT
 D PG2 S %R=6,SY=1,Z=W D LINE
 S T="ASYMMETRY:,7,4;Changed,,20,MFC;No change,,30,MFO;Found-but no prior study,,42,MFB" D TT
 S T="PRIOR SURGERY:,8,4;Mild,,20,BSM;mOderate,,27,BSO;mArked,,38,BSA" D TT
 S T="MASS:,9,4;Lobulated,,20,MDL;Elongated,,32,MDE;Spiculated,,44,MDS;Well defined,,57,MDW;Faint,,72,MDF;Poorly defined,10,20,MDI;partially Obscurred,,37,MDO;Calcified,,59,MDC" D TT
 S DUP="NC;LRB;FMOD;CNF;MOA;WP;DSCA;BAIS;LAS;ZC,LRB,OSI,OMA,EUX;NBPSH;NO,NL,NF,NA,NU,NC,NS,NE,NM"
 S T="C++ DISTR:,11,4;Diffuse,,20,CBD;Segmented,,30,CBS;Clustered,,42,CBG;scAttered,,54,CBs" D TT
 S T="TYPE:,12,8;Benign,,20,CAB;benign Appearing,,29,CAa;Indeterminate,,48,CAi;Suspicious,,64,CAs" D TT
 S T="OTHER FINDINGS:,13,4;Lymph node,,20,AAl;Axillary node,,33,AAa;Skin thickening,,49,AAS" D TT
 S T="LOCATION:,15,4;siZe-mm,,20,MZZ,28,3,PDN;size-Cm,,32,MZC,40,3,PDN;L,,47,MLL;R,,49,MLR;B,,51,MLB;clOck,,57,MLO,62,2,PDN;Superior,16,20,ML1;Inferior,,29,ML3;Medial,,38,ML4;lAteral,,45,ML2;cEntral,,55,MLC;sUbareola,,63,MLS;aXill,,73,MLT" D TT
 S %R=18 D LINE S (SY,Z)=0
 S T="ASSESSMENT:,19,4;Negative,,20,ABN;Benign,,30,ABB;Probably benign,,38,ABP;Suspicious,,55,ABS;Highly sugg.,,67,ABM" D TT
 S T="RECOMMENDATIONS:,20,4;Norm,,20,RCN;Old films,,26,RCO;cLinical corr,,37,RCC;Flup (mo),,53,RCF,63,2,PDN;Addnt views,,67,RCP" D TT
 S T=";Ultrasound,21,20,RCU;Mri,,32,RCm;u/s Core,,37,RCJ;Stereotactic,,48,RCR;surgical Eval,,63,RCE" D TT
 F T=1,4,10,11 S TS(T+.1)=""
 S C=X,A="" I $D(BLD) K BLD G ZAA02GSCMRE5
 I $D(ERR) S D=ERR,Z=W K ERR G ERR
LOOP F C=C:0:TS W:C'=A ZAA02G("HI"),TS(C) D RD W ZAA02G("LO"),TS(C) S C=C+$S(ZF="E":99,ZF="F":1,ZF=9:1.1,ZF="A":-1,ZF="B":1,ZF=1:1,ZF="":0,"OP5Y"[ZF:200,1:0),A="" S:C<1 C=TS I C["." F C=C-.1:1:TS Q:$D(TS(C))
 I TS+5>C S C=1 G LOOP
 I C>200 S X=C-200 G POP1:ZF=5,HLP:ZF="Y",PG
 G:$G(EDIT)=2 END S A="Z"
 F D="B","K","L" I $E($O(ST(0,D)))'=D G ERR
 S T=0 F D="CF","CM","CO","CD" S T=T+$D(ST(0,D))
 I 'T S D="C" G ERR ; density
 F Z=0:1:5 I $D(ST(Z)) F D="KN,DEFGHI" S C=$P(D,",",2) I $D(ST(Z,$P(D,","))) F J=1:1:$L(C) S T=$E(C,J) I $E($O(ST(Z,T)))=T S D=$E(D) G ERR ; neg assess
 S D="J",C="DEFGHI" F Z=0:1:5 S A=$E($O(ST(Z,"J")))="J" F J=1:1:$L(C)+1 S T=$E(C,J) S:T'="" A=A_($E($O(ST(Z,T)))=T) I T="" G ERR:A?1"1"."0",ERR:A?1"0".E1"1".E ; location
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
PG S Z=9,C=4 D PG3 S (W,Z)=$S(ZF="P":-1,1:1)+W#5 D PG3,PG2 G LOOP
PG2 S %R=15 W ZAA02G("HI") F %C=14:1:18 W @ZAA02GP,$S(%C-14=Z:ZAA02G("RON")_(%C-13)_ZAA02G("ROF"),'$D(ST(%C-14)):" ",1:%C-13)
 Q
PG3 S L="" F J=1:1 S L=$O(ST(W,L)) Q:L=""  I $D(SY(L)) D RDX I $D(SR(L)) S D=SR(L),%C=$P(D,",",2),LNG=$P(D,",",3),%R=+D,X=$G(ST(Z,L)) W @ZAA02GP,$E(X_SP,1,LNG)
 Q
HLP S C=X  S EDIT=$G(EDIT)_"A",TYPS="" G END
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
PDT S Y="8,80\HU\HUS\\TB,EX,UK,DK,CR\" D READ^ZAA02GRDD S X=$P(X,"\",2),FNC=ZAA02GF W ZAA02G("UF") G PDN1
