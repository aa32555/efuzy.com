%ZAA02GEDHD ;;%AA UTILS;1.21;SUBR: DISPLAY SCREEN HEADER;24APR91  14:57
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
HEAD N W,X,Y,Z S X=ZAA02G("RT"),(Y,Z)="",W=rm-lm+2,$P(Y,ZAA02G("HL"),W\2+1)="",$P(Z,ZAA02G("HL"),W-(W\2)+1)=""
        S %R=1,%C=lm W ZAA02G("F"),@ZAA02GP,tLO_ZAA02G("RON")," P "_X_" G "_X_" & "_X_" A "
        I $D(T) S %C=rm-lm-$L(T)\2+lm W @ZAA02GP,ZAA02G("ROF")_tHI_T_tLO_ZAA02G("RON")
        S %C=rm-14 W @ZAA02GP,"   AA UTILS   ",ZAA02G("ROF"),!
        W ZAA02G("G1")_Y,Z_ZAA02G("G0") Q
TITLE N W S %R=1,%C=rm-lm-$L(T)\2+lm W @ZAA02GP,ZAA02G("ROF")_tHI_T Q
        ;
