%ZAA02GEDUE2 ;;%AA UTILS;1.24;UTIL: EXPORT ROUTINES/GLOBAL;01MAY91  16:12
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
        I KILL K @FN S (NR,TB)=0
BEG I $O(@GS@(""))=0 G EXIT
        W pBL,tLO_"Copying routines"_tCL S %C=lm+16
        S R="" F I=0:0 S R=$O(@GS@(R)) Q:R=""  S X=^(R),V=$P(X,"`",2) S:'$D(@FN@(R)) NR=NR+1,TB=TB+$P(X,"`",5) W @ZAA02GP,tHI_R_tCL D COPY
        S @FN@(0)=DT_"`"_TY_"`"_NR_"`"_TB_"`"_$P(VERS," ",3)_"`"_CM
EXIT I $D(GS),GS]"" K @GS
        Q
COPY K:$D(@FN@(R)) ^(R) S RX=@GFR,@FN@(0,R)=$P(RX,"`",1,8),LC=1,S=""
        F I=0:0 S S=$O(@GFR@(S)) Q:S=""  S L=^(S) S:TY&($E(L)=ci) L="" S:'TY!(TY&(L]"")) @FN@(R,LC)=L,LC=LC+1
        Q
        ;
