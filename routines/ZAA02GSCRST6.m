ZAA02GSCRST6 ;PG&A,ZAA02G-SCRIPT,2.10,STATS - COMPOSITE;2DEC94 5:02P;;;18JAN95  23:24
 ;Copyright (C) 1984, Patterson, Gray & Associates, Inc.
 ;
REP S (SC,CT)="" K ^ZAA02GTSCR($J)
 F I="",1:1:9 S SI="^ZAA02GSCR"_I I $D(@SI) F Y=BM:1:EM S:$E(Y,5,6)=13 Y=Y+88 F J=1:1 S SC=$O(@SI@("STATS",Y,SC)) Q:SC=""  F J=1:1 S CT=$O(@SI@("STATS",Y,SC,T1,CT)) Q:CT=""  X EX S:$T ^ZAA02GTSCR($J,CT,SI)=""
 S CT="" F J=1:1 S CT=$O(^ZAA02GTSCR($J,CT)) Q:CT=""  D REPT G DONE:J=999
 I TR D:LN>LNM NEXT G DONE:J=999 I '$D(CTX)!(CT["-") W ?22+OFF,"=========  =========  =========  =========  =========",!?14+OFF,"TOTAL",?20+OFF,$J(TW,11),$J(TL,11,0),$J(TR,11),$J(TL\TR,11),$J(TL*600\('TM+TM),11),!
 G END^ZAA02GSCRST
DONE G DONE^ZAA02GSCRST
REPT K MN,R,W,L,T S (TT,A,SI)="" F I=1:1 S SI=$O(^ZAA02GTSCR($J,CT,SI)) Q:SI=""  F M=BM:1:EM S B1=$S(M=BM:BD,1:1),B2=$S(M=EM:ED,1:31) I B2'<B1 F J=1:1 S SC=$O(@SI@("STATS",M,SC)) Q:SC=""  D R1
 Q:+TT=0
 ;
 D:LN+2>LNM NEXT Q:J=999  S LN=LN+2,CONT=CT W !?OFF,CT,!
 S (W,L,R,SI,MN)=""
 F J=1:1:999 S SI=$O(W(SI)) Q:SI=""  I R(SI) D R0
 D:LN+2>LNM NEXT Q:J=999
 W ?22+OFF,"---------  ---------  ---------  ---------  ---------",!?9+OFF,$S(HD'["I N":"Sub",1:"   ")," Total",?20+OFF,$J(W,11),$J(L,11,0),$J(R,11),$J(L\('R+R),11),$J(L*600\('MN+MN),11),! S TM=TM+MN,TW=TW+W,TL=TL+L,TR=TR+R,LN=LN+2,CONT=""
REPTE Q
R0 W ?3+OFF W $E($P(@SI@("PARAM","BASIC"),"|"),1,17)
 W ?20+OFF,$J(W(SI),11),$J(L(SI),11,0),$J(R(SI),11),$J(L(SI)\R(SI),11),$J(L(SI)*600\('MN(SI)+MN(SI)),11,0),! S LN=LN+1 D:LN>LNM NEXT S W=W+W(SI),L=L+L(SI),R=R+R(SI),MN=MN+MN(SI) Q
R1 I $D(@SI@("STATS",M,SC,T1,CT))=0 S:$E(M,5,6)>12 M=M+87 Q
 S E="+0" F J=1:1 S A=$O(@SI@("STATS",M,SC,T1,CT,A)) Q:A=""  D R2:A'="TOTAL"
 Q
R2 S Z=^(A,1),C="C="_$P(Z,"+",B1,B2)_E Q:$L(C)=2
 S Z=^(2),L="L="_$P(Z,"+",B1,B2)_E,Z=^(3),W="W="_$P(Z,"+",B1,B2)_E,Z=^(4),B="B="_$P(Z,"+",B1,B2)_E,Z=^(5),S="S="_$P(Z,"+",B1,B2)_E,Z=^(6),R="R="_$P(Z,"+",B1,B2)_E,Z=^(7),MN="MN="_$P(Z,"+",B1,B2)_E,@C,@L,@W,@B,@S,@R,@MN,TT=TT+R,@LF,@WF
 S:'$D(R(SI)) (R(SI),W(SI),L(SI),MN(SI))=0 S MN(SI)=MN(SI)+MN,R(SI)=R(SI)+R,W(SI)=W(SI)+CC,L(SI)=L(SI)+LL Q
 ;
HEAD S PG=PG+1 I DEVICE=1 S LN=2,%R=3,%C=1 W @ZAA02GP,ZAA02G("CS") S %C=30 W @ZAA02GP,ZAA02G("LO"),"DATES: ",ZAA02G("HI"),BEG," - ",END S %C=50 W !!
 I DEVICE>1 D TOP
 W ?2+OFF,"User/Location        # Chars    # Lines   # Reports  LN/Report   LN/Hour",!?2+OFF,"------------------  ---------  ---------  ---------  ---------  ---------",! S LN=LN+2 I CONT'="" W ?OFF,CONT," (cont)",! S LN=LN+1
 Q
TOP S LN=5 X:$D(HDRX) HDRX X:$D(B(4))+$D(LC)>1 "F AA=2:1:LC+B(4)*6 W !" W !?OFF,DT S AA=$P(@ZAA02GSCR@("PARAM","BASIC"),"|"),C=80-$L(AA) W ?C\2+OFF,AA,?73+OFF,"Page ",PG,! S C=80-$L(HD) W ?C\2+OFF,HD,!
 S AA="DATES: "_BEG_" - "_END,C=80-$L(AA) W ?C\2+OFF,AA,!! Q
 ;
NEXT I DEVICE=1,PG>0 S %R=24,%C=20 W @ZAA02GP,"Press RETURN to continue - EXIT to quit " R C#1 X ZAA02G("T") S:$E(XX,$F(XX,ZF))="E" J=999 G HEAD:J'=999 Q
 W:LN'=999 # G HEAD
