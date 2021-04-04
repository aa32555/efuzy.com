%ZAA02GEDL2
SRC S Y=(lm+25)_","_(bl+2)_"\H\EX\Load from: \\WORKFILE,ARCHIVE,MUMPS" W tLO D ^ZAA02GEDPL I ZAA02GF="EX" S R="" K X,Y,DL W pBL_tCL Q
	S GFR=$P(wgl_"(R,V)/"_agl_"(R,V)/OS/","/",X),GFI=$P(wgl_"(0)/"_agl_"(0)/","/",X),SRC=$P("WORKFILE/ARCHIVE/MUMPS","/",X),DTC=0 D DATE:R[">"!(R["<"),FIND W:R="" pBL_tCL Q
DATE I R["<" S D=$P(R,"<",2),R=$P(R,"<"),OP="<" D ANSI Q
	E  S D=$P(R,">",2),R=$P(R,">"),OP=">" D ANSI S:DTC DTC=DTC+99999 Q
ANSI I "T+,T-"[$E($TR(D,"t","T"),1,2) S @("DTC="_(+$H)_$E(D,2,99)) S DTC=DTC*100000 Q
	N m,d,y,o S:'$D(ZAA02G("d")) ZAA02G("d")=0 I ZAA02G("d")=0 S m=+D-3,d=$P(D,"/",2),y=$P(D,"/",3)
	E  S d=+D,m=$P(D,"/",2)-3,y=$P(D,"/",3)
	Q:(m+d+y)<-2  D:'y GETYR S:y<100 y=y+1900 S o=$S(y<1900:-14916,y<2000:21608,1:58132),y=$E(y,3,4) S:m<0 m=m+12,y=y-1 S DTC=1461*y\4,DTC=153*m+2\5+DTC+d+o,DTC=DTC*100000 Q
GETYR N X,m,d,o S X=+$H,o=$S(X<21609:14915,1:-21609),X=X+o,y=4*X+3\1461,d=X*4+7-(1461*y)\4,m=5*d-3\153,d=5*d+2-(153*m)\5,m=m+3 S:m>12 m=m-12,y=y+1 S y=$S(o=14915:y+1800,1:y+1900) Q
FIND G:GFR="OS" ^ZAA02GEDL3 N C,I,L,S,T,W,Y,BR,CN,NK,NO,PG,TR,US,UD,FR S W=rm-lm+1,X=$P(R,"?"),SF=1
	S T="S E L E C T   R O U T I N E" D ^ZAA02GEDHD K T
	S %R=3,%C=3 W @ZAA02GP,tLO_"Routine   Bytes       Changed       Description"
	S PG=1,(NK,PG(1))=X,TR=5,BR=22,NO=0 D FETCH I '$D(US) S R="" Q
	S NO=1 G SELECT
FETCH S NK=PG(PG),CN=0 K US,UD,LST I PG=1,NK]"",$D(@GFI@(NK)) G F2
F1 S NK=$O(@GFI@(NK)) I NK=""!($E(NK,1,$L(X))]X) D CLEAR K Y Q
F2 S:CN=(BR-TR) LST=NK I CN=(BR-TR+1) S:LST]"" PG(PG+1)=LST K Y Q
	S Y=^(NK),V=$P(Y,"`",2),SZ=$P(Y,"`",5),DT=$P($P(Y,"`",6),"\",2) I DTC S IF="S OK="_(+$P(Y,"`",6))_OP_DTC X IF G:'OK F1
	S CN=CN+1,%R=TR+CN-1,%C=3,US(CN)=NK,UD(CN)=NK_$J("",10-$L(NK))_$J(SZ,5)_"   "_DT_$J("",18-$L(DT))_$E($P(Y,"`",3),1,41)
	W @ZAA02GP,tLO_UD(CN)_tCL G F1
SELECT S %R=bl+2,%C=rm-lm-62\2+1 W pBL_tCL,@ZAA02GP,tLO_"[Point to desired routine, press "_tHI_"RETURN."_tLO_"  Press "_tHI_"EXIT"_tLO_" to abort]"
ASK S %R=TR+NO-1,%C=1,NK=US(NO) W @ZAA02GP,tLO_"=>"_tHI_UD(NO),@ZAA02GP,"=>"
AS R C#1 I C="" X ZAA02G("T") S ZAA02GF=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2) G:"UK,DK,PU,PD,CR,EX"[ZAA02GF @ZAA02GF W *7 G AS
	G DK:C=" ",AS
UK W @ZAA02GP,tLO_"  "_UD(NO) S NO=NO-1 G:NO'<1 ASK S NO=CN X:PG>1 "S PG=PG-1 D FETCH S NO=CN" G ASK
DK W @ZAA02GP,tLO_"  "_UD(NO) S NO=NO+1 G:NO'>CN ASK S NO=1 G:'$D(PG(PG+1)) ASK
PD G:'$D(PG(PG+1)) AS S PG=PG+1 D FETCH S:NO>CN NO=CN G SELECT
PU G:PG<2 AS S PG=PG-1 D FETCH G SELECT
EX W @ZAA02GP,tLO_"  "_UD(NO) S (R,V)="" Q
CR S R=US(NO),V=$P(@GFI@(R),"`",2) D LOCK G:'OK SELECT Q
CLEAR S %C=1 F %R=CN+TR:1:BR W @ZAA02GP,tCL
	Q
LOCK D LKCHK^ZAA02GEDL1 Q:OK  W pBL_tLO_"Routine "_tHI_R_tLO_" is already owned by "_$S(U?1.N:"device ",U["$":"device ",1:"user ")_tHI_U_tLO_tCL
	S %R=bl+2,%C=rm-16 W @ZAA02GP,"...press any key" X ZAA02G("EOF") R *C X ZAA02G("EON") K C Q
LKCHK S OK=1 Q:$D(NOLOCK)!(rgl="")  L @rgl@(R) I $D(@rgl@(R)),^(R)'=TID S U=^(R),OK=0
	E  S @rgl@(R)=TID
	L  Q
	;
	;