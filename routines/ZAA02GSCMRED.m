ZAA02GSCMRED ;PG&A,ZAA02G-MTS,1.20,QUANTUM;;;;03FEB98  09:01
 ;Copyright (C) 1996, Patterson, Gray and Associates Inc.
 ;
POP D:$D(ZAA02GX)+$D(ZAA02GY)'=2 FUNC^ZAA02GDEV X ^ZAA02G("ECHO-OFF")
 S %R=7,%C=9,B="",$P(B,ZAA02G("HL"),62)="" W @ZAA02GP,ZAA02G("G1"),ZAA02G("HI"),ZAA02G("TLC"),B,ZAA02G("TRC") F %R=%R+1:1:22 W @ZAA02GP,ZAA02G("VL"),$J("",61),ZAA02G("VL")
 S %R=%R+1 W @ZAA02GP,ZAA02G("G1"),ZAA02G("BLC"),B,ZAA02G("BRC"),ZAA02G("G0")
 S %R=7,%C=25,W=0,NOCLR=1 W @ZAA02GP,ZAA02G("LO"),"Mammography Examination Screen"
 ; I $E($O(ST(0,"")))'="A" S ST(0,"AB")=""
POP1 S (S,Z,W,SY,TS)=0
 S T="TECH:,8,11;Tech,,23,OBT,28,4,PD" D TT
 S T="STUDY:,10,11;Bilateral,,23,TSB;Left,,35,TSL;Right,,42,TSR" D TT
 S DUP=";BLR;SDF;;;NR,NB,NC,NS,NE,NA,NF,NU;NBPSHA"
 S T="TYPE:,12,11;Screening,,23,RAS;Diagnostic,,36,RAP;Follow-up,,50,RAF" D TT
 S T="ABNORM:,14,11;Asymmetric,,23,MFB;aRchit. distort.,,36,AAD;Calcifications,,55,NAF" D TT
 S T="MASS:,15,11;Sharp,,23,MDF;Obscured,,30,MDO;Indistinct,,40,MDI;sPiculated,,52,MDS;Mult.,,64,MEY" D TT
 S T="RECOMMEND:,17,11;Normal,,23,RCN;suRg consult,,31,RCE;Biopsy,,45,RCB;u/s Core biopsy,,54,RCJ" D TT
 S T=";Stereo core biopsy,18,23,RCR;nEedle aspir,,44,RCA;Addtn views,,59,RCi" D TT
 S T=";Flup (mo),19,23,RCF,33,2,PDN;Ultrasound,,38,RCU" D TT
 S T="CATEGORY:,21,11;Negative,,23,ABN;Benign,,33,ABB;Probably benign,,41,ABP;Suspicious,,58,ABS;Highly sugg.,22,23,ABM;Additional imaging,,39,ABA" D TT
 S C=X,A="" I $D(BLD) K BLD G ZAA02GSCMRED
 I $D(ERR) S D=ERR,Z=W K ERR G ERR
LOOP F C=C:0:TS W:C'=A ZAA02G("HI"),TS(C) D RD W ZAA02G("LO"),TS(C) S C=C+$S(ZF="E":99,ZF="F":1,ZF=9:1.1,ZF="A":-1,ZF="B":1,ZF=1:1,ZF="":0,"OP5Y"[ZF:200,1:0),A="" S:C<1 C=TS I C["." F C=C-.1:1:TS Q:$D(TS(C))
 I TS+5>C S C=1 G LOOP
 I C>200 S X=C-200 G POP1:ZF=5,HLP:ZF="Y",POP1
 G:$G(EDIT)=2 END S A="Z"
 F D="B","C","F","G" I $E($O(ST(0,D)))'=D G ERR
 I $D(ST(0,"GN"))!$D(ST(0,"GB")),'$D(ST(0,"FN")) S D="F" G ERR
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
HLP S C=X S EDIT=$G(EDIT)_"A",TYPSS=TYPS,TYPS="" G END
 ;
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
