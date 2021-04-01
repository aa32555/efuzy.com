%ZAA02GEDP1 ;;%AA UTILS;1.24;UTIL: PRINT ROUTINE DIRECTORY;16MAY91  09:55
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
        N (ZAA02G,ZAA02GP,ZAA02GX,ZAA02GY,TID,d,ci,bl,ct,gl,lm,rm,rt,sr,tl,SF,tCL,tHI,tLO,pBL,agl,pgl,ugl,wgl,sgl)
SRC S ACT="Print Directory",SET="234" D ^ZAA02GEDRL G EXIT:'$D(GS),EXIT:'$D(@GS)
DEV D ^ZAA02GEDDV I $D(DEV) D PRINT C:DEV'=0 DEV
EXIT I $D(GS),GS]"",$D(@GS) K @GS
        Q
PRINT N G,NL,NB,DE S (LN,PG)=0
        U 0 S %R=bl+2,%C=lm-1 W @ZAA02GP,tLO,"Printing "_tHI_"DIRECTORY"_tLO_" from "_tHI_SRC_tLO_tCL
        U DEV D HDR S R="" F I=0:0 S R=$O(@GS@(R)) Q:R=""  S X=^(R) D ONE
        D TRAIL U 0 Q
ONE S DT=$P($P(X,"`",6),"\",2),NL=$P(X,"`",4),NB=$P(X,"`",5)+CPL,DE=$E($P(X,"`",3),1,RM-LM-41),LN=LN+1 D:LN>ULP TRAIL,HDR W !?LM,R,$J("",10-$L(R)),$J(NL,4),$J(NB,7),"   ",DE,?RM-$L(DT),DT Q
TRAIL I DEV=0 S Z="",$P(Z,$C(13,10),ULP+2-LN)="" W Z,!,?LM,"Press any key to continue..." R *x W ZAA02G("F"),!
        I DEV'=0 S Z="",$P(Z,$C(13,10),ULP+3-LN)="" U DEV W Z,!!,?LM,"AA UTILS "_SW_"  Copyright (C) 1990 PG&A",?RM-$L(PG)-5,"Page "_PG,#
        K x,Z Q
HDR W !,?LM,SITE,?(RM-$L(PDT)-8),"Printed "_PDT,!,?LM,"Directory from "_SRC,!,?LM,$TR($J("",W)," ","=")
        W !,?LM,"Routine  Lines  Bytes   Description",?RM-13,"Last Modified",!?LM,$TR($J("",W)," ","=") S PG=PG+1,LN=5 Q
        ;
