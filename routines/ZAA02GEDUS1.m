%ZAA02GEDUS1 
	N (ZAA02G,ZAA02GP,ZAA02GX,ZAA02GY,TID,d,ci,bl,ct,gl,lm,rm,rt,sr,tl,SF,tCL,tHI,tLO,pBL,agl,pgl,rgl,ugl,wgl,sgl)
STR S %R=bl+2,%C=lm-1,Y="RON\ROF\EX\\"_(rm-lm-16)_"\\\\\\Replace string: ",X="" W pBL_tCL D ^ZAA02GEDRS G:X=""!(ZAA02GF="EX") EXIT S STR=X
REP S %R=bl+2,%C=lm-1,Y="RON\ROF\EX\\"_(rm-lm-14)_"\\\\\\With string: ",X="" W pBL_tCL D ^ZAA02GEDRS G:X=""!(ZAA02GF="EX") EXIT S REP=X
SRC S ACT="Search",SET="234" D ^ZAA02GEDRL G EXIT:'$D(GS),EXIT:GS="",EXIT:$D(@GS)=0
DEV D ^ZAA02GEDDV G:'$D(DEV) EXIT S TM=LM+4,TW=RM-TM,LN=99,(R,PG)="" D DATE^ZAA02GEDS0 S CDT=DT
	S OS=ZAA02G("OS"),CKP="CK=CK+"_$P($T(@OS),";;",2),CKM="CK=CK-"_$P($T(@OS),";;",2)
RTN S (R,RT)=$O(@GS@(R)) G:R="" DONE S Z=^(R),V=$P(Z,"`",2),GXR=GFR,SC=SRC
	I TYP>2,$D(@wgl@(R)) S GXR=wgl_"(R,V)",SC="WORKFILE",Z=@wgl@(0,R),V=$P(Z,"`",2)
	S RR="^"_R_$J("",11-$L(R))_"Source: "_SC_$J("",13-$L(SC))_"   Modified: "_$P($P(Z,"`",6),"\",2)_"  ;",RR=RR_$E($P(Z,"`",3),1,W-$L(RR))
	I DEV'=0 U 0 S %R=bl+2,%C=lm-1 W @ZAA02GP,tLO,"Searching "_tHI_R_tLO_" from "_tHI_SRC_tLO_tCL
	S OK=1,GX=GXR,(CX,LC,S)="" F I=0:0 S S=$O(@GX@(S)) Q:S=""  S:$E(^(S))'=ci&($TR(^(S)," ","")]"") LC=LC+1 I ^(S)[STR S X=^(S) D CHNG Q:'OK
	I CX S $P(IR,"`",5)=NB,$P(IR,"`",9)=CK,@wgl@(0,R)=IR,@wgl@(R,NV)=$P(IR,"`",3,99)
	G RTN
DONE U DEV D TRAIL
EXIT U 0 I $D(DEV),DEV'=0 C DEV
	I $D(GS),GS]"",$D(@GS) K @GS
	Q
CHNG Q:$E(X)=ci!($TR(X," ","")="")  I RT]"" D COPY Q:'OK  D:LN'<(ULP-3) TRAIL,HDR U DEV W !,?LM,RR,! S LN=LN+2,RT="",CX=1
	S NB=NB-$L(X)-1,@CKM,TY="OLD" D LINE S F=0 F i=0:0 S F=$F(X,STR,F) Q:F<1  S X=$E(X,0,F-$L(STR)-1)_REP_$E(X,F,511)
	S NB=NB+$L(X)+1,@CKP,TY="NEW",@wgl@(R,NV,S)=X D LINE Q:LN'<ULP  U DEV W ! S LN=LN+1 Q
LINE S T=$P(X," "),L=$P(X," ",2,511),n=9-$L(T) s:n<0 n=0 F i=1:1:n Q:$E(L,i)'=" "
	S L=$E(L,i,511),TT=TY_":  "_$J("+"_LC,4)_"   "_T_$J("",8-$L(T))_" "
PL D:LN>ULP TRAIL,HDR U DEV W !,?TM,TT,$E(L,1,TW-$L(TT)) S LN=LN+1,L=$E(L,TW-$L(TT)+1,511),TT=$J("",24) Q:L=""  G PL
	Q
TRAIL I 'PG S PG=PG+1 U 0 Q
	I DEV=0 S Z="",$P(Z,$C(13,10),ULP+2-LN)="" W Z,!,?LM,"Press any key to continue..." R *x W ZAA02G("F"),!
	I DEV'=0 S Z="",$P(Z,$C(13,10),ULP+3-LN)="" U DEV W Z,!!,?LM,"AA UTILS "_SW_"  Copyright (C) 1990 PG&A",?RM-$L(PG)-5,"Page "_PG,#
	U 0 K x,Z S PG=PG+1 Q
HDR U DEV W !,?LM,SITE,?(RM-$L(PDT)-8),"Printed "_PDT
	W !,?LM,"Source: ",SRC,?RM-$L(STR)-11,"Replace: '"_STR_"'"
	W !,?RM-$L(REP)-8,"With: '",REP,"'"
	W !,?LM,$TR($J("",W)," ","=") S LN=4 Q
COPY I rgl]"",$D(@rgl@(R)) S ID=^(R),OK=0 D:LN>ULP TRAIL,HDR U DEV W !,?LM,"^"_R,?LM+11,"Routined is owned by device/user ",ID K ID Q
	N pc,C,E,S,X,FL,LC,LN,NL,OV,PC D:DEV'=0 MSG S IR=$S($D(@wgl@(0,R)):^(R),1:"3`0```0"),OV=$P(IR,"`",2),NV=OV+1 S:NV>IR NV=1 S $P(IR,"`",2)=NV K @wgl@(R,NV)
	S (S,CK,FL,NB,NL,LC)="" F I=0:0 S S=$O(@GX@(S)) Q:S=""  S X=^(S),LC=LC+1 D PUT
	S $P(IR,"`",3,9)=DE_"`"_NL_"`"_NB_"`"_CDT_"`"_CDT_"`"_TID_"`"_CK,@wgl@(0,R)=IR,@wgl@(R,NV)=$P(IR,"`",3,99)
	W:DEV'=0 @ZAA02GP,tLO_tCL S GX=wgl_"(R,NV)",X=$D(@GX@(1)) Q
PUT I $E(X)=ci!($TR(X," ","")="") S @wgl@(R,NV,LC)=X G PND
	I 'FL,$P(X," ")]"" S FL=LC,DE=$P(X,";",2)
	S NL=NL+1,NB=NB+$L(X)+1,@CKP,@wgl@(R,NV,LC)=X
PND I DEV'=0 S pc=pc-1 D:'pc MSG U 0 W "."
	Q
PSM ;;$ZX(X,1)
M11 ;;$ZC(X)
DTM ;;$ZCRC(X,1)
CCSM ;;$ZCRCX(X)
MSM ;;$ZCRC(X,1)
DSM ;;$L(X)
MSG U 0 S pc=rm-lm-$L(R)-20 W pBL,tLO_"Saving "_tHI_R_tLO_" to "_tHI_"WORKFILE "_tLO_tCL Q
	;
	;