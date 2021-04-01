ZAA02GSCRST2 ;PG&A,ZAA02G-SCRIPT,2.10,STATS - DOWNLOAD;17NOV94  20:53;;;5DEC94 12:34P
C ;Copyright (C) 1984, Patterson, Gray & Associates, Inc.
 ;
 ;
A S DEVICE=1 D REP Q
TOP S LN=5 W:$Y>4 # X:$D(HDRX) HDRX X:$D(B(4))+$D(LC)=2 "F AA=2:1:LC+B(4)*6 W !" W !?OFF,DT S AA=$P(@ZAA02GSCR@("PARAM","BASIC"),"|"),C=80-$L(AA) W ?C\2+OFF,AA,?73+OFF,"Page ",PG,! S C=80-$L(HD) W ?C\2+OFF,HD,!
 S AA="DATES: "_BEG_" - "_END,C=80-$L(AA) W ?C\2+OFF,AA,!! Q
 ;
INIT S LF=$P(@ZAA02GSCR@("PARAM","BASIC"),"|",4),WF=$P(^("BASIC"),"|",2) Q
END I $D(TR),TR=0 S %R=10,%C=18 W @ZAA02GP,"No statistical data found for dates specified"
 I $D(TR),TR S %R=12,%C=18 W @ZAA02GP,"Statistics were downloaded into sheet - ",SHT,SN
 S %R=24,%C=34 W @ZAA02GP,"Press RETURN " R C#1
DONE Q
 ;
REP D SETUP1^ZAA02GSCRST
 S CT="" D INIT K ^ZAA02GTSCR($J),TR
 F SI=1:1:$L(SITEC,",") S SC=$P(SITEC,",",SI) F Y=BM:1:EM S:$E(Y,5,6)=13 Y=Y+88 F J=1:1 S CT=$O(@ZAA02GSCR@("STATS",Y,SC,T1,CT)) Q:CT=""  X EX S:$T ^ZAA02GTSCR($J,CT)=""
 S CT="" F J=1:1 S CT=$O(^ZAA02GTSCR($J,CT)) Q:CT=""  D REPT
 I TR W "      ==========  ==========  ==========  ==========",!?9+OFF,"TOTAL",?14+OFF,$J(TW,12),$J(TL,12,0),$J(TR,12),$J(TL\TR,12),!
 G END
REPT K R,W,L,T S (TT,A)="" W !!,CT,!! F M=BM:1:EM S B1=$S(M=BM:BD,1:1),B2=$S(M=EM:ED,1:31) F SI=1:1:$L(SITEC,",") S SC=$P(SITEC,",",SI) D R1:B2'<B1
 Q:+TT=0
 ;
REPTE Q
R1 I $D(@ZAA02GSCR@("STATS",M,SC,T1,CT,"TOTAL"))=0 S:$E(M,5,6)>12 M=M+87 Q
 S E="+0" D R2
 Q
R2 F B1=B1:1:B2 I +$P(@ZAA02GSCR@("STATS",M,SC,T1,CT,"TOTAL",1),"+",B1)'=0 D R3
 ;
R3 S Z=^(1),C="C="_$P(Z,"+",B1,B2)_E Q:$L(C)=2  S Z=^(2),L="L="_$P(Z,"+",B1,B2)_E,Z=^(3),W="W="_$P(Z,"+",B1,B2)_E,Z=^(4),B="B="_$P(Z,"+",B1,B2)_E,Z=^(5),S="S="_$P(Z,"+",B1,B2)_E,Z=^(6),R="R="_$P(Z,"+",B1,B2)_E,@C,@L,@W,@B,@S,@R,TT=TT+R
 W B1," ",R,"  ",C,"  ",L,!
 ;
NEW S DIR="PR" I '$D(^ZAA02GCALC(DIR)) S ^ZAA02GCALC("PR")="ZAA02G-SCRIPT PRODUCTION REPORTS",^ZAA02GCALC(98,DIR)=^ZAA02GCALC(DIR)
 F I=1:1 Q:$D(^ZAA02GCALC(DIR,I))=0
 S SHT=I D DATE^ZAA02GCAL18
 S ^ZAA02GCALC(DIR,SHT)=NM_"`Super`"_DAT_"```",^ZAA02GCALC(98,DIR,SHT)=^ZAA02GCALC(DIR,SHT)
 Q
DATA ;
 ;3;;
