%ZAA02GEDP0
	N (ZAA02G,ZAA02GP,ZAA02GX,ZAA02GY,TID,d,ci,bl,bs,ct,gl,lm,rm,rt,sr,tl,ts,SF,tCL,eHI,eLO,tHI,tLO,pBL,agl,pgl,ugl,wgl,sgl,UCI) S (r,fs)=""
SRC S ACT="List",SET="1234" D ^ZAA02GEDRL G EXIT:'$D(GS) I GS]"",$D(@GS)=0 G EXIT
DEV D ^ZAA02GEDDV G:'$D(DEV) EXIT
BEG S (PG,E)=0 D COPY I GFR=gl S PC=2,IR=$S($D(@wgl@(0,R)):^(R),1:"") D END,ONE G EXIT
DIR W pBL_tCL S %R=bl+2,%C=lm-1,Y="RON\ROF\EX\\3\NY\No;Yes\\\\Print directory first? ",X=0 D ^ZAA02GEDYN G:ZAA02GF="EX" EXIT
PRINT D PRINT^ZAA02GEDP1:X S PC=1,R="" F I=0:0 S R=$O(@GS@(R)) Q:R=""  S IR=^(R),V=$P(IR,"`",2) D ONE
EXIT I $D(DEV),DEV'=0 C DEV
	I $D(GS),GS]"",$D(@GS) K @GS
	Q
ONE U 0 S %R=bl+2,%C=lm-1 W @ZAA02GP,tLO,"Printing "_tHI_R_tLO_" from "_tHI_SRC_tLO_tCL
	K LI S (N,FL,LC)=0,MD=$P($P(IR,"`",6),"\",2) D HDR F I=0:0 D FETCH,OUT Q:S=""!(E&(S>E))
	D:LN TRAIL U 0 Q
FETCH S LI=$O(LI("")) I LI S T=$P(LI(LI)," "),L=$P(LI(LI)," ",2,511) K LI(LI) Q
	D GET I 'FL,T]"" D FIRST G FETCH
	F K=$L(L):-1:0 Q:$E(L,K)'=" "
	S L=$E(L,0,K) Q
GET S (T,L)="",S=$O(@GFR@(N+.9)),N=S\1 Q:S=""  G G2
G1 S S=$O(@GFR@(S)) I S=""!(S\1'=N) Q
G2 S X=$P(@GFR@(S),d,PC) I S#1 S L=L_$E(X,ct,511) G G1
	S T=$P(X," "),L=$P(X," ",2,511) G G1
FIRST N P,M,X,TID S (FL,LI)=1,LI(1)=T_" ;"
	F K="DES","MOD","FIL","TID","PKG","PV" I $D(@sgl@(0,"FMT",K)),^(K) S M=+^(K),P=$P(^(K),"`",2) S:'$D(LI(M)) LI(M)=" ;" D @K S $P(LI(M),";",P)=X S:M>LI LI=M
	I $D(LI(1)),$P(LI(1)," ;",2,9)="" S $P(LI(1)," ;",2,9)=$P(IR,"`",3)
	I CP F K=1:1:CP S LI=LI+1,LI(LI)=CP(K)
	Q
DES S X=$P(IR,"`",3) Q
MOD S X=$P(IR,"`",6) D DATE Q
FIL S X=$P(IR,"`",7) D DATE Q
TID S X=$P(IR,"`",8) Q
PKG S X=$S($D(PKG):PKG,1:"") Q
PV S X=$S($D(PX):PX,$D(PV):PV,1:"") Q
DATE S X=$P(X,"\",2),X=$P(X,"/",2)_$P("JAN/FEB/MAR/APR/MAY/JUN/JUL/AUG/SEP/OCT/NOV/DEC","/",+X)_$P(X,"/",3) Q
TRAIL I DEV=0 S Z="",$P(Z,$C(13,10),ULP+2-LN)="" W Z,!,?LM,"Press any key to continue..." R *x W ZAA02G("F"),!
	I DEV'=0 S Z="",$P(Z,$C(13,10),ULP+3-LN)="" U DEV W Z,!!,?LM,"AA UTILS "_SW_"  Copyright (C) 1990 PG&A",?RM-$L(PG)-5,"Page "_PG,#
	U 0 K x,Z Q
HDR U DEV W !,?LM,SITE,?(RM-$L(PDT)-9),"Printed: "_PDT,!,?LM,"Source: ",SRC,?(RM-LM-$L(R)+1\2+LM),R,?RM-$L(MD)-10,"Modified: "_MD,!,?LM,$TR($J("",W)," ","=") S LN=3,PG=PG+1 Q
OUT U DEV G O3:$E(T)=ci&(T?2P) I $E(T)=ci S T=T_" " G O2
	S n=9-$L(T) s:n<0 n=0 F i=1:1:n Q:$E(L,i)'=" "
	S L=$E(L,i,511),T=T_$J("",8-$L(T))_" "
O1 D:LN>ULP TRAIL,HDR W !,?LM,T,$E(L,1,W-$L(T)) S LN=LN+1,L=$E(L,W-$L(T)+1,511),T=$J("",11) Q:L=""  G O1
O2 D:LN>ULP TRAIL,HDR W !,?LM,T,$E(L,1,W-$L(T)-1) S LN=LN+1,L=$E(L,W-$L(T),511),T=ci Q:L=""  G O2
O3 S XC=$E(T,2),XL=$E(L,$F(L,$E($TR(L," ","")))-1,511),XL=$TR($J("",W-$L(XL)\2)," ",XC)_XL D:LN>ULP TRAIL,HDR W !,?LM,XL,$TR($J("",W-$L(XL))," ",XC) S LN=LN+1 K XC,XL Q
END N I,S S S="" F I=0:0 S S=$O(@GFR@(S)) Q:S=""  I $P(^(S),d,2)]"" S E=S
	Q
COPY S CP=0 I $D(CPY),$D(@CPY)#2 S CP=@CPY F I=1:1:CP S CP(I)=@CPY@(I)
	Q
	;
	;