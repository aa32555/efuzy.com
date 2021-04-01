ZAA02GSCMREL ;PG&A,ZAA02G-MTS,1.20,CAT 0-V PROMEDICA;;20NOV2002  11:47;;24MAR2005  11:34
 ;Copyright (C) 1996, Patterson, Gray and Associates Inc.
 ;
POP D:$D(ZAA02GX)+$D(ZAA02GY)'=2 FUNC^ZAA02GDEV X ^ZAA02G("ECHO-OFF")
 S %R=6,%C=9,B="",$P(B,ZAA02G("HL"),62)="" W @ZAA02GP,ZAA02G("G1"),ZAA02G("HI"),ZAA02G("TLC"),B,ZAA02G("TRC") F %R=%R+1:1:22 W @ZAA02GP,ZAA02G("VL"),$J("",61),ZAA02G("VL")
 S %R=%R+1 W @ZAA02GP,ZAA02G("G1"),ZAA02G("BLC"),B,ZAA02G("BRC"),ZAA02G("G0")
 S %R=6,S=$G(INP("PATIENT"))_"  DOB: "_$G(INP("DOB")),%C=-$L(S)\2+40,W=0,NOCLR=1 W @ZAA02GP,ZAA02G("LO"),S
POP1 S (S,Z,W,SY,TS)=0
 S T="STUDY:,8,11;Bilateral,,25,TSB;Left,,40,TSL;Right,,55,TSR;Sonogram,9,25,TSU;u/s Asp,,40,TSC;u/s Core,,55,TSc;sTereotactic,10,25,TST" D TT
 S DUP="BL,BR,BS,BA,BC,BT,LS,LA,LC,LT,RS,RA,RC,RT,;123450;NF,NP,NU,NC,NA,NT,NS,NM,NV"
 S T="CATEGORY:,12,11;1 (neg),,25,ABN;2 (benign),,37,ABB;3 (prob benign),,51,ABP;4 (susp),13,25,ABS;5 (malig),,37,ABM;0 (incomplete),,51,ABA" D TT
 S T="RECOMMEND:,15,11;Normal,,25,RCN;Flup (mo),,39,RCF,49,2,PDN;Prior films,,56,RCO;Ultrasound,16,25,RCU;u/s Core biopsy,,39,RCJ;u/s Aspiration,,56,RCS;sTereotactic,17,25,RCR;Surgical biopsy,,39,RCB;Mri,,56,RCm;"
 S T=T_"addnt Views,18,25,RCi" D TT
 S T="OTHER (n/r):,20,11;Tech,,25,OBT,30,2,PDU;called MD,,42,XXC,54,17,PD;mult prob Alert,21,25,XXM;called Pat.,,42,XXP,54,17,PD" D TT
 S C=X,A="" I $D(BLD) K BLD G ZAA02GSCMREL
 S %R=23,%C=25 W @ZAA02GP,"Press F10 when complete, F1 to cancel"
 I $D(ERR) S D=ERR,Z=W K ERR G ERR
LOOP F C=C:0:TS W:C'=A ZAA02G("HI"),TS(C) D RD W ZAA02G("LO"),TS(C) S C=C+$S(ZF="E":99,ZF="F":1,ZF=9:1.1,ZF="A":-1,ZF="B":1,ZF=1:1,ZF="":0,"OP5Y"[ZF:200,1:0),A="" S:C<1 C=TS I C["." F C=C-.1:1:TS Q:$D(TS(C))
 I TS+5>C S C=1 G LOOP
 I C>200 S X=C-200 G POP1:ZF=5,HLP:ZF="Y",POP1
 G:$G(EDIT)=2 END S A="Z"
 F D="A" I $E($O(ST(0,D)))'=D G ERR
 I $D(ST(0,"AS"))+$D(ST(0,"AD")) F D="B","C" I $E($O(ST(0,D)))'=D G ERR
 I $D(ST(0,"B1"))!($D(ST(0,"B2"))),$D(ST(0,"CN"))+$D(ST(0,"CL"))=0 S D="B" G ERR
 I $D(ST(0,"CN")),($D(ST(0,"B1"))+$D(ST(0,"B2")))=0 S D="C" G ERR
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
PDU S Y=LNG_"\HUF\HUS\\TB,EX,UK,DK,CR\" D READ^ZAA02GRDF S FNC=ZAA02GF W ZAA02G("UF") G PDN1
PDT S Y="8,80\HU\HUS\\TB,EX,UK,DK,CR\" D READ^ZAA02GRDD S X=$P(X,"\",2),FNC=ZAA02GF W ZAA02G("UF") G PDN1
