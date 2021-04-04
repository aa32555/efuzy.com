%ZAA02GED08
SRCH S %R=bl+2,%C=lm-1,Y=%C_","_%R_"\H\EX\Find: \\STRING,REPLACE,LINE,END" W @ZAA02GP,tCL_tLO D ^ZAA02GEDPL
	I ZAA02GF'="EX" G @$P("^ZAA02GED12/^ZAA02GED10/LINE/END","/",X)
EXIT K X,Y W pBL_tCL,VERS,MODE Q
LINE S %R=bl+2,%C=lm-1,Y="RON\ROF\EX\\20\\\\\\Find line: ",X="" W @ZAA02GP,tLO_tCL D ^ZAA02GEDRS I X=""!(ZAA02GF="EX") K X,Y,ZAA02GF S x=$D(@gl@(s)) G EXIT
	D TAG,NP^ZAA02GED00:SF K X,Y,SF Q
TAG S FT=$P(X,"+"),FL=$P(X,"+",2),(LT,LC,xs,SF)=""
	I FT]"" F i=0:0 S xs=$O(@gl@(xs)) Q:xs=""  S T=$P($P($P(^(xs),d,2)," "),"(") I T]"",$E(T)'=ci,T=FT S LT=T Q
	I FL F i=0:0 S xs=$O(@gl@(xs)) Q:'xs  I xs=(xs\1) S L=$P(^(xs),d,2) I $TR(L," ","")]"",$E(L)'=ci S FL=FL-1 Q:'FL
	I xs W pBL_tCL,VERS,MODE S SF=1,bs=xs,r=tl-1,c=lm F i=1:1:(bl-tl\2) S bs=+@gl@(bs),r=r+1 Q:'bs
	E  W pBL_tLO_"Line "_tHI_X_tLO_" not found"_tCL,MODE
	K T,X,Y,FT,FL,LT,LC,i,xs Q
END S xs=bs F i=0:0 S xs=$O(@gl@(xs)) Q:'xs  I $TR($P(^(xs),d,2)," ","")]"" S bs=xs
	F i=1:1:bl-tl-2 S bs=+^(bs) Q:'bs
	K X,Y S r=tl,c=lm-1 D NP^ZAA02GED00 G EXIT
RESTORE(TR,BR) Q:'$D(ts)  Q:'$D(@gl@(ts))  W eLO S bs=+^(ts),x=$O(^(bs)) S:'x (x,ts)=bs+10000\1,^(x)=bs
	F %R=tl:1:bl S bs=$O(^(bs)) S:bs="" bs=x+10000\1,^(bs)=x_d S x=bs,%C=lm-1 I %R'<TR,%R'>BR W @ZAA02GP," ",$P(^(bs),d,2),tCL S:%R=r s=bs D:fs]"" DSP(%R,bs)
	Q
DSP(%R,s) S z=$P(^(s),d,2) Q:z=""  S L=$L(z,fs)-1,F=0 W @ZAA02GP,eHI_ZAA02G("RON") F i=1:1:L S F=$F(z,fs,F),%C=F-$L(fs)+1 W @ZAA02GP,fs
	W ZAA02G("ROF")_eLO K i,z,L,F Q
	;
OTHER k y S Y=(lm-1)_","_(bl+2)_"\H\EX\USER OPTIONS:\\",(YY,X)="" F J=1:1 S X=$O(@ugl@(0,"OTHER",X)) Q:X=""  S y(J)=X,Y=Y_$P(^(X),"`")_",",YY=YY_$E(^(X))
	S Y=Y_"QUIT",YY=YY_"Q" D ^ZAA02GEDPL Q:$E(YY,X)="Q"
	X $P(@ugl@(0,"OTHER",y(X)),"`",2,9) K YY,y G MENU^ZAA02GED
UCI S C=32 W *13 I ^%T("OS")="MSM" W *13 S C=0 F V=0:1:5 F U=1:1:30 S B=$ZU(U,V) I B]"" W C+1,") ",B,"    " S C=C+1,A(C)=V*32+U
	R "   UCI# ? ",U Q:U=""  I U>0,U'>C X $S(^%T("OS")="M3":"ZN U",^%T("OS")="PSM":"ZC U",^%T("OS")="MSM":"V 2:$J:A(U):2",1:"I 0") K A Q
	W *13," INVALID UCI # - NO CHANGE MADE" K A H 1 Q
	;
	;