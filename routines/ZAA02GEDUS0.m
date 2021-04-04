%ZAA02GEDUS0 
	N (ZAA02G,ZAA02GP,ZAA02GX,ZAA02GY,TID,d,ci,bl,ct,gl,lm,rm,rt,sr,tl,SF,tCL,tHI,tLO,pBL,ugl,wgl,agl,pgl,sgl)
STR S %R=bl+2,%C=lm-1,Y="RON\ROF\EX\\60\\\\\\Search for string: \1",X="" W pBL_tCL D ^ZAA02GEDRS G:X=""!(ZAA02GF="EX") EXIT S STR=X
SRC S ACT="Search",SET="234" D ^ZAA02GEDRL G EXIT:'$D(GS) I GS]"",$D(@GS)=0 G EXIT
DEV D ^ZAA02GEDDV G:'$D(DEV) EXIT S TM=LM+4,TW=RM-TM+1,LN=99,(R,PG,ZAA02GF)="" I DEV=0 W ZAA02G("F"),tLO,"Searching..."
RTN S R=$O(@GS@(R)) I R="" U DEV D TRAIL G EXIT
	S Z=^(R),V=$P(Z,"`",2),RR="^"_R_$J("",11-$L(R))_"Saved: "_$P($P(Z,"`",7),"\",2)_"   Modified: "_$P($P(Z,"`",6),"\",2)_"  ;"_$E($P(Z,"`",3),1,W-63)
	I DEV'=0 U 0 S %R=bl+2,%C=lm-1 W @ZAA02GP,tLO,"Searching "_tHI_R_tLO_" from "_tHI_SRC_tLO_tCL
	S (LC,S)="" F I=0:0 S S=$O(@GFR@(S)) Q:S=""  S:$E(^(S))'=ci&($TR(^(S)," ","")]"") LC=LC+1 I ^(S)[STR S X=^(S) D LINE Q:ZAA02GF
	G EXIT:ZAA02GF,RTN
EXIT U 0 I $D(DEV),DEV'=0 C DEV
	I $D(GS),GS]"",$D(@GS) K @GS
	Q
LINE I RR]"" D:ULP-LN<4 TRAIL,HDR Q:ZAA02GF  U DEV W !,?LM,RR,! S LN=LN+2 S RR=""
	I $E(X)=ci!($TR(X," ","")="") S TT=$J("",16),L=X G PL
	S T=$P(X," "),L=$P(X," ",2,511),n=9-$L(T) s:n<0 n=0 F i=1:1:n Q:$E(L,i)'=" "
	S L=$E(L,i,511),TT=$J("+"_LC,4)_"   "_T_$J("",8-$L(T))_" "
PL D:ULP-LN<2 TRAIL,HDR Q:ZAA02GF  U DEV W !,?TM,TT,$E(L,1,TW-$L(TT)-1) S LN=LN+1,L=$E(L,TW-$L(TT),511),TT=$J("",18) G PE:L="",PL
PE Q:LN'<ULP  U DEV W ! S LN=LN+1 Q
TRAIL I 'PG S PG=PG+1 U 0 Q
	S Z=pBL S:DEV'=0 Z="",$P(Z,$C(13,10),TLP-LN-3)="" U DEV W Z,*13,?LM,"AA UTILS "_SW_"  Copyright (C) 1990 PG&A"
	I DEV=0 W ?RM-17,"...press any key" R Z#1 I Z="" X ZAA02G("T") S ZAA02GF=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2),ZAA02GF=ZAA02GF="EX"
	E  W ?RM-$L(PG)-5,"Page "_PG,#
	S PG=PG+1 U 0 K Z Q
HDR Q:ZAA02GF  N XC,XL S LN=0 I DEV=0 W ZAA02G("F"),*13
	E  U DEV W ! S LN=LN+1
	W ?LM,SITE,?(RM-$L(PDT)-8),"Printed "_PDT
	W !,?LM,"Source: ",SRC,?RM-$L(STR)-17,"Searching for: `"_STR_"'" W !,?LM,$TR($J("",W)," ","=") S LN=LN+2 Q
	;
	;