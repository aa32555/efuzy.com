%ZAA02GEDH0
	S PG=1 D PAGE1
MENU S F="\\PU,PD,EX",Y="\Function:\\",Z="" I SE S:SE>1 F=F_",UK,DK",Y=Y_"SELECT,",Z=Z_"S" S Y=Y_"OPEN,",Z=Z_"O"
	S:SZAA02G&(Y'["CLOSE") Y=Y_"CLOSE,",Z=Z_"C" S:HN>1 Y=Y_"INDEX,",Z=Z_"I" S Y=Y_"QUIT",Z=Z_"Q"
	S Y=F_Y D M K Y S X=$S(ZAA02GF="CR":$E(Z,X),1:"") I ZAA02GF="EX"!(X="Q") S REFRESH=BR_":"_ER Q
	I SE,ZAA02GF="UK" D TOF S PS=PS-1 S:PS<1 PS=SE D TON G MENU
	I SE,ZAA02GF="DK"!(X="S") D TOF S PS=PS+1 S:'$D(SE(PS)) PS=1 D TON G MENU
	I ZAA02GF="PD",'END S PG=PG+1 D PGDN,C G MENU
	I ZAA02GF="PU",TP>1 S:PG>1 PG=PG-1 D PGUP,C G MENU
	I X="O",SE S X=$P(SE(PS),"|",4) I $D(@HG@(X,1)) S SZAA02G=SZAA02G+1,SZAA02G(SZAA02G)=HN_"|"_PG_"|"_PC_"|"_PP_"|"_PS_"|"_PGS,HN=X,PG=1 D ERAS,C,PAGE1 G MENU
	I X="C" S X=SZAA02G(SZAA02G),SZAA02G=SZAA02G-1,HN=+X,PG=$P(X,"|",2),PC=$P(X,"|",3),PP=$P(X,"|",4),PS=$P(X,"|",5),PGS=$P(X,"|",6),X=@HG@(HN),NM=$P(X,"|"),NL=$P(X,"|",3) D ERAS,C,PGH G MENU
	I X="I",HN'=1 K SZAA02G S SZAA02G=0,HN=1,PG=1,PS=0 D ERAS,C,PAGE1 G MENU
	G MENU
PAGE1 S X=@HG@(HN),NM=$P(X,"|"),NL=$P(X,"|",3),SP=TBR,PP=WH,(TP,PC,PGS)=1,PS=0 I TH<NL S PGS=NL\TH S:NL#TH PGS=PGS+1 S PC=1/PGS,PP=$J(WH*PC,0,0)
PGH S LSP=0,%R=BR+1,%C=LM W @ZAA02GP,tLO_"Topic:  "_tHI_NM_$J("",TW-$L(NM)-8)_tLO I PC=1 S %C=RM+3 W RON X "F %R=BR+1:1:ER-1 W @ZAA02GP,sp" W ROF
PGDN D PGI S %R=TBR-1 W tLO F I=TP:1:BP S X=$S($D(@HG@(HN,1,I)):^(I),1:""),%R=%R+1,WI=TW W @ZAA02GP,$$FMT(X)
	G:PC=1 PGE S %C=RM+3 I SP>LSP F %R=$S(LSP:LSP,1:BR+1):1:SP-1 W @ZAA02GP,sp
	S LSP=SP,EP=SP+PP-1 S:EP>(ER-1) EP=ER-1 W RON X "F %R=SP:1:EP W @ZAA02GP,sp" W ROF G PGE
PGUP D PGI S %R=TER+1 W tLO F I=BP:-1:TP S X=$S($D(@HG@(HN,1,I)):^(I),1:""),%R=%R-1,WI=TW W @ZAA02GP,$$FMT(X)
	G:PC=1 PGE S %C=RM+3 I SP<LSP S EP=$S(LSP:LSP,1:BR+1)+PP+1 S:EP>(ER-1) EP=ER-1 F %R=EP:-1:SP+PP W @ZAA02GP,sp
	S LSP=SP,EP=SP+PP-1 S:EP>(ER-1) EP=ER-1 W RON X "F %R=EP:-1:SP W @ZAA02GP,sp" W ROF
PGE S END=$D(@HG@(HN,1,BP))=0 S PS=$S('SE:0,PS=0&(SE>0):1,1:PS) D:PS TON Q
PGI K SE S SE=0,TP=(PG-1)*TH+1,BP=TP+TH-1,SP=$J(PG-1*(WH/PGS),0,0)+BR+1,%C=LM Q
FMT(X) S F=0 I X["~" S:X["~(" X=$$TR($$TR(X,"~(",U1),")~",U0) S:X["~<" X=$$TR($$TR(X,">~",tLO),"~<",tHI)
	F F=0:0 S F=$F(X,"{",F) Q:'F  S R="{"_$E(X,F,F+2) I R?1"{"2A1"}" S W=$$KEY($TR(R,"{}","")),X=$E(X,0,F-2)_W_$E(X,F+3,255)
	Q X_$J("",WI-$L(X))
TR(X,R,W) N B,E,N,S
TR1 Q:X'[R X S B=$P(X,R),E=$P(X,R,2,255),S=""
	I R="~<" S S=$P(E,tLO) I $D(@HG@(HN,0,S)) S N=^(S),SE=SE+1,SE(SE)=%R_"|"_$$L(B)_"|"_S_"|"_N
	S X=B_W_E,WI=WI+$L(W) G TR1
L(X) N L S L=$L(X) S:X[tHI L=L-($L(X,tHI)-1*lHI) S:X[tLO L=L-($L(X,tLO)-1*lLO) S:X[U1 L=L-($L(X,U1)-1*lU1) S:X[U0 L=L-($L(X,U0)-1*lU0) Q L
TON S X=SE(PS),%R=+X,%C=$P(X,"|",2)+LM,T=$P(X,"|",3) W @ZAA02GP,tHI_RON_T_ROF_tLO K T,X Q
TOF S X=SE(PS),%R=+X,%C=$P(X,"|",2)+LM,T=$P(X,"|",3) W @ZAA02GP,tHI_T_tLO K P,T,X Q
KEY(K) I "CR,TB,UK,DK,RK,LK,IO"[K Q $P("RETURN,TAB,Cursor UP,Cursor DOWN,Cursor RIGHT,Cursor LEFT,"_$I,",",$F("CTUDRLI",$E(K))-1)
	S x="PD,PU,FP,SU,SD,IL,DL,EF,ST,HL,OT,CP,BO,DO,EK,GO,RE,CT,EX,GW,SE,HK,IC,DC,GE,",n="" I x[K S p=$F(x,K_",")-1/3,t=5 S:p>15 t=6 S n=$P(^%T(.1,ZAA02G,t),"`",p)
	K x,p,t Q n
ERAS S %C=RM+3 F %R=BR+1:1:ER-1 W @ZAA02GP,sp
	Q
C S %C=LM,%R=ER-1 W @ZAA02GP,$J("",TW) Q
M N i,c,f,A,B,C,I,L,O,T,Z,CC,PA,PR,ZF,R0,R1 S (CC,%C)=LM,%R=ER-1,PA="HD",f="CR,"_$P(Y,"\",3),PR=$P(Y,"\",4),I=$P(Y,"\",5),Y=$P(Y,"\",6),C=$L(Y,",")
	S %C=%C+$L(PR)+1,Z="",T="C(i)="_ZAA02GP F i=1:1:C S B=$P(Y,",",i),A=$E($TR(B,sp,"")) S:'$D(O(A)) O(A)=0 S O(A)=O(A)+1,O(A,i)="",Z=Z_"  "_B,@T,%C=%C+$L(B)+2
	S R1=RON_sp,R0=ROF S:'I!(I>C) I=1 S:$D(ZAA02G("a")) R1=$P(ZAA02G("a"),"`",1),R0=$P(ZAA02G("a"),"`",2)_$C(8)
	S L=$L(Z)+$L(PR),%C=CC W @ZAA02GP W:PR]"" tLO_PR W:PA["H" tHI W Z_sp
M1 W C(I)_R1_$P(Y,",",I)_R0
M2 R c#1 I c]"" S:c?1L c=$C($A(c)-32) G:c'=sp M6 D M4 S I=I+1 S:I>C I=1 G M1
M3 X ZAA02G("T") S ZAA02GF=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2) G:f[ZAA02GF M5 D M4 S I=$S(ZAA02GF="RK":I+1,ZAA02GF="LK":I-1,1:I) S:I>C I=1 S:I<1 I=C G M1
M4 W C(I)_sp_$P(Y,",",I)_sp Q
M5 S X=I,%C=CC Q:PA["D"  W @ZAA02GP,$J("",L) Q
M6 G:'$D(O(c)) M2 D M4 I O(c)=1 S I=$O(O(c,"")),ZAA02GF="CR" G:ZAA02G("M") M1 G M5
	S I=$O(O(c,I)) S:'I I=$O(O(c,I)) G M1
	;
	;