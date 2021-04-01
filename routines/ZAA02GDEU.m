ZAA02GDEU(P) ;;;PG&A,ZAA02G-CONFIG,2.20,(Subroutine);05FEB91  17:43
        ;;Copyright (C) 1990 Patterson, Gray and Associates, Inc. ;
        ;;All rights reserved. ;
CHK Q:P=""  Q:$T(@P)=""  D @P F i=1:1:U+1 L +@P@(i):0 I  Q
        I i>U L -@P@(i) W ZAA02G("F"),!!,"Access to "_N_" is limited to "_U_" user"_$S(U=1:"",1:"s"),*7 H 3
        E  S ZAA02G("PR")=P_"("_i_")" K i,N
        I $D(ZAA02G("PR"))
        Q
CLR L -@ZAA02G("PR") K ZAA02G("PR") Q
ZAA02GWP S U=9,N="ZAA02G-WRITER" Q
ZAA02GCALC S U=9,N="ZAA02G-CALC" Q
ZAA02GGU S U=9,N="ZAA02G-GUARDIAN" Q
ZAA02GI S U=9,N="TOOLKIT I" Q
ZAA02GFORM S U=9,N="ZAA02G-FORM" Q
ZAA02GGRAPH S U=9,N="ZAA02G-GRAPH" Q
ZAA02GMAIL S U=9,N="ZAA02G-MAIL" Q
ZAA02GED S U=9,N="AA UTILS" Q
        ;
