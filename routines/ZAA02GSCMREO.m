ZAA02GSCMREO ;PG&A,ZAA02G-MTS,1.20,NEW REGIONAL RAD;;24FEB2003  22:20;;20JUN2006  09:48
 ;Copyright (C) 1996, Patterson, Gray and Associates Inc.
 ;
POP D:$D(ZAA02GX)+$D(ZAA02GY)'=2 FUNC^ZAA02GDEV X ^ZAA02G("ECHO-OFF")
 S %R=12,%C=3,B="",$P(B,ZAA02G("HL"),74)="" W @ZAA02GP,ZAA02G("G1"),ZAA02G("HI"),ZAA02G("TLC"),B,ZAA02G("TRC") F %R=%R+1:1:21 W @ZAA02GP,ZAA02G("VL"),$J("",73),ZAA02G("VL")
 S %R=%R+1 W @ZAA02GP,ZAA02G("G1"),ZAA02G("BLC"),B,ZAA02G("BRC"),ZAA02G("G0")
 S %R=12,S=$G(INP("PATIENT"))_"  DOB: "_$G(INP("DOB")),%C=-$L(S)\2+40,W=0,NOCLR=1 W @ZAA02GP,ZAA02G("LO"),S
POP1 S (S,Z,W,SY,TS)=0
 S T="REASON:,14,4;Screen,,18,RAS;Diag,,27,RAP;add'l-Prior,,34,RAA;-This study,,45,RAV;Follow-up,,59,RAF;Review,,71,RAO" D TT
 S T="STUDY:,15,4;Bilateral,,18,TSS;Left,,30,TSL;Right,,37,TSR;Post Mastectomy,,45,TSP;uncOoperative,,62,TSI" D TT
 S T="DENSITY:,16,4;Very dense,,18,BA4;Dense,,31,BA3;Moderate,,39,BA5;Average,,50,BA2;Fatty,,60,BA1" D TT
 S T="ASSESSMENT:,17,4;Neg,,18,ABN;Benign,,23,ABB;Suspicious,,31,ABS;Incomplete,,43,ABA;Prob-benign,,55,ABP;Malignant,,68,ABM" D TT
 S T="RECOMMEND:,18,4;Norm,,18,RCN;Flup (mo),,24,RCF,34,2,PDN;Bx,,38,RCB;mRi,,42,RCm;needLe,,48,RCL;Magn,,56,RCM;u/s-eXam,,62,RCU;stEreo,,71,RCR" D TT
 S T=";Old films,19,18,RCO;Decision,,29,RCD;U/s-fna,,39,RCS;Aspir,,48,RCA;Clinical,,55,RCC;Proj,,65,RCP;Spot,,71,RCG" D TT
 S T=";Take action,20,18,RCT;Y/s core,,31,RCJ;Galactogram,,41,RCI;excIsional biopsy,,54,RCE" D TT
 S T="OTHER:,21,4;Tech,,18,OBT,23,12,PD;Previous Films,,38,XXF,53,20,PD" D TT
 S DUP="SDPTFR;BLRPO;VDMAF;NBSIPM;NF,NB,NH,NL,NM,NX,NE,NO,ND,NU,NA,NC,NP,NS,NT,NY,NI,NG"
 S C=X,A="" I $D(BLD) K BLD G ZAA02GSCMREO
 I $D(ERR) S D=ERR,Z=W K ERR G ERR
LOOP F C=C:0:TS W:C'=A ZAA02G("HI"),TS(C) D RD W ZAA02G("LO"),TS(C) S C=C+$S(ZF="E":99,ZF="F":1,ZF=9:1.1,ZF="A":-1,ZF="B":1,ZF=1:1,ZF="":0,"OP5Y"[ZF:200,1:0),A="" S:C<1 C=TS I C["." F C=C-.1:1:TS Q:$D(TS(C))
 I TS+5>C S C=1 G LOOP
 I C>200 S X=C-200 G POP1:ZF=5,HLP:ZF="Y",POP1
 G:$G(EDIT)=2 END S A="Z"
 F D="A","B","C","E" I $E($O(ST(0,D)))'=D G ERR
 I $D(ST(0,"EB")),$D(ST(0,"C1"))+$D(ST(0,"C2")) S D="E" G ERR
END X ^ZAA02G("ECHO-ON") K LNG,TS,TT,T,Y,SS,SR,SP,SY,ZAA02GX,ZAA02GY,DUP Q
ERR I Z'=W S ERR=D,W=Z G POP1
 S A="Z" F J=1:1:$L(D) S C=$E(D,J) Q:C=","  W $G(ZAA02G("BO")),TS($A(C)-64),$G(ZAA02G("BF")) S:A]C A=C
 S (C,A)=$A(A)-64 W $G(ZAA02G("BO")),ZAA02G("HI"),TS(C),$G(ZAA02G("BF")) G LOOP
TT F J=1:1:$L(T,";") I $P(T,";",J)]"" S D=$P(T,";",J),%C=$P(D,",",3) S:$P(D,",",2) %R=$P(D,",",2) S C=$P(D,","),M="M="_ZAA02GP,@M D @$S(J=1:"TT1",1:"TT2")
 Q
TT1 S TS=TS+1,TS(TS)=M_C,I=$C(TS+64) W ZAA02G("LO"),M_C Q:'$D(BLD)  S @ZAA02GSCMD@("XDIR",SCr,1,I)=","_C Q
TT2 S A=$F($TR(C,"ABCDEFGHIJKLMNOPQRSTUVWXYZ123450","\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\"),"\"),L=$E(C,A-1),SS(I_L)=M_$E(C,1,A-2)_ZAA02G("HI")_L_ZAA02G("LO")_$E(C,A,255),L=I_L S:SY SY(L)=""
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
