%ZAA02GEDL3
FIND N C,I,L,S,T,W,Y,BR,CN,NK,NO,PG,TR,US,UD,FR S W=rm-lm+1,SF=1,OS=ZAA02G("OS")
	S T="S E L E C T   R O U T I N E" D ^ZAA02GEDHD K T S %R=3,%C=3 W @ZAA02GP,tLO_"Routine   First Line Contents"
	I OS="PSM",R["/" D INITPSM
	S PG=1,(X,NK,PG(1))=$P(R,"?"),TR=5,BR=22,NO=0 D FETCH I '$D(US) S R="" Q
	S NO=1 G SELECT
FETCH S NK=PG(PG),CN=0 K US,UD,LST I PG=1,NK]"",$$EXIST(NK) G F2
F1 S NK=$$NEXT(NK) I NK=""!($E(NK,1,$L(X))]X) D CLEAR K Y Q
F2 S:CN=(BR-TR) LST=NK I CN=(BR-TR+1) S:LST]"" PG(PG+1)=LST K Y Q
	S Y=$$FL(NK),Y=$E($P(Y," ",2,511),1,(rm-lm-15))
	S CN=CN+1,%R=TR+CN-1,%C=3,US(CN)=NK,UD(CN)=NK_$J("",10-$L(NK))_Y W @ZAA02GP,tLO_UD(CN)_tCL G F1
SELECT S %R=bl+2,%C=rm-lm-62\2+1 W pBL_tCL,@ZAA02GP,tLO_"[Point to desired routine, press "_tHI_"RETURN."_tLO_"  Press "_tHI_"EXIT"_tLO_" to abort]"
ASK S %R=TR+NO-1,%C=1,NK=US(NO) W @ZAA02GP,tLO_"=>"_tHI_UD(NO),@ZAA02GP,"=>"
AS R C#1 I C="" X ZAA02G("T") S ZAA02GF=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2) G:"UK,DK,PU,PD,CR,EX"[ZAA02GF @ZAA02GF W *7 G AS
	G DK:C=" ",AS
UK W @ZAA02GP,tLO_"  "_UD(NO) S NO=NO-1 G:NO'<1 ASK S NO=CN X:PG>1 "S PG=PG-1 D FETCH S NO=CN" G ASK
DK W @ZAA02GP,tLO_"  "_UD(NO) S NO=NO+1 G:NO'>CN ASK S NO=1 G:'$D(PG(PG+1)) ASK
PD G:'$D(PG(PG+1)) AS S PG=PG+1 D FETCH S:NO>CN NO=CN G SELECT
PU G:PG<2 AS S PG=PG-1 D FETCH G SELECT
EX W @ZAA02GP,tLO_"  "_UD(NO) S (R,V)="" Q
CR S R=US(NO) D LOCK G:'OK SELECT Q
CLEAR S %C=1 F %R=CN+TR:1:BR W @ZAA02GP,tCL
	Q
LOCK D LKCHK^ZAA02GEDL1 Q:OK  W pBL_tLO_"Routine "_tHI_R_tLO_" is already owned by "_$S(U?1.N:"device ",U["$":"device ",1:"user ")_tHI_U_tLO_tCL
	S %R=bl+2,%C=rm-16 W @ZAA02GP,"...press any key" X ZAA02G("EOF") R *C X ZAA02G("EON") K C Q
LKCHK S OK=1 Q:$D(NOLOCK)!(rgl="")  L @rgl@(R) I $D(@rgl@(R)),^(R)'=TID S U=^(R),OK=0
	E  S @rgl@(R)=TID
	L  Q
EXIST(N) N D I OS="MSM"!(OS["DSM") S D=$D(^ (N))>0 Q D
	I OS="DTM" S D=$L($ZRSOURCE(N))>0 Q D
	I OS="PSM" S D=$D(^UTILITY("R",N))>0 Q D
	I OS="M3" S D=$ZM(2,"R",N)]"" Q D
	I OS="M11" S D=$D(^ROUTINE(N))>0 Q D
	I OS="CCSM" S %ZGD=$ZGD,$ZGD=$ZRD,D=$D(@("^"_R)),$ZGD=%ZGD K %ZGD Q D>0
	Q 1
NEXT(N) I OS="MSM"!(OS["DSM") S N=$O(^ (N)) Q N
	I OS="PSM" S:N="" N=0 S N=$O(^UTILITY("R",N)) Q N
	I OS="M3" S N=$O(^$R(N)) Q N
	I OS="M11" S N=$O(^ROUTINE(N)) Q N
	I OS="DTM" S N=$ZRNEXT(N) Q N
	I OS="CCSM" S:N="" N="A" S %ZGD=$ZGD,$ZGD=$ZRD,N=$O(@("^"_N)),$ZGD=%ZGD K %ZGD Q N
	Q ""
FL(N) X "ZL @N S Y=$T(+1)" I OS="DTM",Y="",$ZRSOURCE(N)="" S Y=" [SOURCE CODE UNAVAILABLE]"
	Q Y
INITPSM N R,S,X,%J,%X S R="R",S=1,%J=$I,%X="" W pBL,tHI_"Initializing Routine Directory" S %R=bl+2,%C=rm-14 W @ZAA02GP,tLO,"...please wait" D INIT^%DSET Q
	;
	;