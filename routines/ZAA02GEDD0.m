%ZAA02GEDD0 ;;%AA UTILS;1.24;UTIL: DELETE ROUTINE;09MAY91  10:45
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
        N (ZAA02G,ZAA02GP,ZAA02GX,ZAA02GY,TID,d,ci,bl,ct,gl,lm,rm,rt,sr,tl,SF,tCL,tHI,tLO,pBL,agl,pgl,ugl,wgl,sgl)
LOAD S ACT="Purge",SET="2" D ^ZAA02GEDRL G EXIT:'$D(GS),EXIT:'$D(@GS) S GFR=$P(GFR,"(")_"(R)"
ASK W pBL,tLO_"Purge selected routines from "_tHI_SRC_tLO_"?  Please confirm:"_tLO_tCL
        S %R=bl+2,%C=lm+$L(SRC)+47,Y="RON\ROF\EX\\3\NY\No;Yes",X=0 D ^ZAA02GEDYN G:'X!(ZAA02GF="EX") EXIT
        S R="" F I=0:0 S R=$O(@GS@(R)) Q:R=""  S V=$P(^(R),"`",2) D KILL
EXIT W pBL_tCL I SF S $P(@gl,"`",8,11)=tl_"`"_lm_"`0`0" D:'$D(UTL) SETUP^ZAA02GED,NP^ZAA02GED00 S SF=0
        Q
KILL D MSG H 1 K @GFI@(R),@GFR Q
MSG W pBL_tLO_"Purging "_tHI_R_tLO_" from "_tHI_"WORKFILE "_tLO_tCL S pc=rm-$L(R)-23 Q
        ;
