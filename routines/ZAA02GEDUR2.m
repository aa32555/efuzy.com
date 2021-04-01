%ZAA02GEDUR2 ;;%AA UTILS;1.24;UTIL: SELECT ROUTINES FOR RELEASE;26APR91  10:43
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
BEG N I,R,CV,GS,NB,NL,NR,NV,PD,SF,ACT,GFI,GFR,SET,SRC,ZAA02GF,TPK,TPV,NOKILL I $D(@pgl@(PKG,PV)),$P(^(PV),"`",4) W *7 Q
        S CV=$S($D(@pgl@(PKG,PV,1))\10:PV,$P(PKR,"`",4)]"":$P(PKR,"`",4),1:"*"),D=$D(@pgl@(PKG,CV,1))\10,GS="^ZAA02GEDSEL($J)",(CL,CPL,CPN)=0 I $D(@pgl@(PKG,PV,0))#2 S CPN=+^(0),(CL,CPL)=$P(^(0),"`",2)
        K @GS D:D FETCH S TPK=PKG,TPV=PV
SELR S ACT="Release",SET="3",(CHG,NOKILL)=1 D ^ZAA02GEDRL S PKG=TPK,PV=TPV G EXIT:'$D(GS) I GS]"",$D(@GS)=0 G EXIT
        W pBL_tLO_"Saving routine list..."_tCL S (NR,NL,NB,R)="" K @pgl@(PKG,PV,1)
        F I=0:0 S R=$O(@GS@(R)) Q:R=""  S X=^(R),NR=NR+1,NL=NL+$P(X,"`",4),NB=NB+$P(X,"`",5),@pgl@(PKG,PV,1,R)="`"_$P(X,"`",2)
        S @pgl@(PKG,PV)=NR_"`"_NL_"`"_(CL*NR+NB),$P(PKR,"`",5)=PV
EXIT I $D(GS),GS]"" K @GS
        K CL,CPL,CPN,CNT,CHG,SIZ Q
FETCH W pBL_tLO_"Copying routine list from version "_tHI_CV_tCL
        S (CNT,SIZ,R)="" F I=0:0 S R=$O(@pgl@(PKG,CV,1,R)) Q:R=""  S Z=@agl@(0,R),CNT=CNT+1,SIZ=SIZ+$P(Z,"`",5),^ZAA02GEDSEL($J,R)=Z
        Q
        ;
