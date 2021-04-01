ZAA02GSCMST7 ;PG&A,ZAA02G-MTS,1.20,REPORTS-BRIEF PHYSICAN SUMMARY;2DEC94 4:57P;;;Wed, 15 Sep 2010  07:52
 ;Copyright (C) 1995, Patterson, Gray & Associates, Inc.
 ;
SUMM K SC,^ZAA02GTSCM($J) F SI=1:1:$L(SITEC,",") S SC=$P(SITEC,",",SI) S:SC]"" SC(SC)=""
 S T1="PROV",STATC="STATS",TS="MAMMOGRAPHY"
 F J=1:1 S A=$P("ABB,ABM,ABN,ABP,ABS,ABO,ABA",",",J) Q:A=""  S CD(A)=""
 S HD="MAMMO INTREPRETATION SUMMARY BY PROVIDER"
 I DEVICE=1 S %R=1,%C=20 W @ZAA02GP,$J("",49) S %C=82-$L(HD)\2 W @ZAA02GP,ZAA02G("HI"),HD
 S (CT,CD,AG)="" D RP0
 D PRINT S TR=LN'=999 K TT,CT,SI,SC,BM,EM,BD,ED,AG,C,D,CD,T1,T2,F,L,D1,D2,D3,D4,D5,D6,M,N,LT,TY K:1 ^ZAA02GTSCM($J) G END^ZAA02GSCMST
 ;
RP0 I T1="SITEC" S SC="NA" F Y=BM:1:EM S:$E(Y,5,6)=13 Y=Y+88 S B1=$S(Y=BM:BD,1:1),B2=$S(Y=EM:ED,1:31) F J=1:1 S CT=$O(@ZAA02GSCM@("STATS",Y,"NA",T1,CT)) Q:CT=""  I $D(SC(CT)) S D2=CT D RP1
 I T1'="SITEC" F SI=1:1:$L(SITEC,",") S SC=$P(SITEC,",",SI) F Y=BM:1:EM S:$E(Y,5,6)=13 Y=Y+88 S B1=$S(Y=BM:BD,1:1),B2=$S(Y=EM:ED,1:31) F J=1:1 S CT=$O(@ZAA02GSCM@("STATS",Y,SC,T1,CT)) Q:CT=""  S D2=CT D RP1
 Q
RP1 F J=1:1 S CD=$O(@ZAA02GSCM@("STATS",Y,SC,T1,CT,CD)) Q:CD=""  I $D(CD(CD)) S D=$G(^ZAA02GTSCM($J,D2,CD)) D RP2 I D]"" S ^ZAA02GTSCM($J,D2,CD)=D
 Q
RP2 S J=$G(@ZAA02GSCM@("STATS",Y,SC,T1,CT,CD,0)) F J=1:1 S AG=$O(^(AG)) Q:AG=""  Q:AG>9  S C=^(AG),C="C="_$P(C,"+",B1,B2)_"+0" Q:$L(C)=2  S @C I C S D=D+C
 Q
 ;
HEAD S PG=PG+1 I DEVICE=1 S LN=2,%R=3,%C=1 W @ZAA02GP,ZAA02G("CS") S %C=5 W @ZAA02GP,ZAA02G("LO"),"DATES: ",ZAA02G("HI"),BEG," - ",END S %C=40 W @ZAA02GP,ZAA02G("LO"),"SITE: ",ZAA02G("HI"),SITEC S %C=55 W @ZAA02GP,ZAA02G("LO"),"STUDY: ",ZAA02G("HI"),TSU,!!
 I DEVICE>1 D TOP W !
 I TYPE=3 W ?7+OFF,"Physician",?22+OFF,"Total  %   Cat1&2  %    Cat 3  %   Cat4&5  %    Cat 0  %" W !?2+OFF,"__________________ ______ ___  ______ ___  ______ ___  ______ ___  ______ ___",!
 I TYPE=1 W ?7+OFF,"Physician",?22+OFF,"Total      Cat1&2       Cat 3      Cat4&5       Cat 0   " W !?2+OFF,"__________________ ______    ________    ________    ________    ________    ",!
 I TYPE=2 W ?7+OFF,"Physician",?22+OFF,"Total  %   Cat1&2  %    Cat 3  %   Cat4&5  %    Cat 0  %" W !?2+OFF,"__________________       ____        ____        ____        ____        ____",!
 S LN=LN+2 I CONT'="" W ?OFF,CONT," (cont)",! S LN=LN+1
 Q
TOP S LN=5 X:$D(HDRX) HDRX X:$D(B(4))+$D(LC)>1 "F AA=2:1:LC+B(4)*6 W !" W $G(bd),!?OFF,DT S AA=$P($G(@ZAA02GSCR@("PARAM","BASIC")),"|"),C=80-$L(AA) W ?C\2+OFF,AA,?73+OFF,"Page ",PG,! S C=80-$L(HD) W ?C\2+OFF,HD,!
 S AA="DATES: "_BEG_" - "_END_"    SITE: "_$E(SITEC,1,25)_"  STUDY: "_TS,C=80-$L(AA) W ?C\2+OFF,AA,$G(BDO),!! Q
 ;
NEXT I DEVICE=1,PG>0 S %R=24,%C=20 W @ZAA02GP,"Press RETURN to continue - EXIT to quit " R C#1 X ZAA02G("T") S:$E(XX,$F(XX,ZF))="E" J=999 G HEAD:J'=999 Q
 I LN'=999 W # G HEAD
 Q
 ;
PRINT D HEAD I DEVICE>1 W ! S LN=LN+1
 S (T1,T2,T3,T4,D,TT)="" F  S CT=$O(^ZAA02GTSCM($J,CT)) Q:CT=""  S T1=T1+$G(^(CT,"ABN"))+$G(^("ABB")),T2=T2+$G(^("ABP")),T3=T3+$G(^("ABS"))+$G(^("ABM")),T4=T4+$G(^("ABA"))
 S TT=T1+T2+T3+T4
 I LN>LNM D NEXT
 W ?2+OFF," TOTAL",?19+OFF S D=TT,S=TT D PR4 S D=T1 D PR4 S D=T2 D PR4 S D=T3 D PR4 S D=T4 D PR4
 S LN=LN+1 W ! I DEVICE>1 S LN=LN+1 W !
 F  S CT=$O(^ZAA02GTSCM($J,CT)) Q:CT=""  D PR3
 Q
PR3 D:LN>LNM NEXT Q:J>900   W ?2+OFF,$E($S($D(^PVG(CT)):$P(^(CT),":",2),1:CT),1,17),?19+OFF
 K D S (T,D)="" F  S D=$O(^ZAA02GTSCM($J,CT,D)) Q:D=""  S T=T+^(D)
 S D=T,S=TT D PR4
 S D=$G(^("ABN"))+$G(^("ABB")),S=T D PR4
 S D=+$G(^("ABP")) D PR4
 S D=$G(^("ABS"))+$G(^("ABM")) D PR4
 S D=+$G(^("ABA")) D PR4
 S LN=LN+1 W ! I DEVICE>1 S LN=LN+1 W !
 Q
 ;
PR4 W:13[TYPE $J(D,8) W:TYPE=2 $J("",8) W:23[TYPE $J($S('S:0,1:D*100/S),4,0) W:TYPE=1 $J("",4)
