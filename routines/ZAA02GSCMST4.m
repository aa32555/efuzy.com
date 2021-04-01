ZAA02GSCMST4 ;PG&A,ZAA02G-MTS,1.20,REPORTS-STATS BY AGE;2DEC94 4:57P;06MAR2002  12:20;;Wed, 26 Jul 2017  16:32
C ;Copyright (C) 1995, Patterson, Gray & Associates, Inc.
 ;
SUMM K SC,^ZAA02GTSCM($J) F SI=1:1:$L(SITEC,",") S SC=$P(SITEC,",",SI) S:SC]"" SC(SC)=""
 S T6=0 S:T1>5 T6=1,T1=T1-5 I T1=5 K SC  S SC("TOTAL")=""
 S HD=$P("Interpretation,Recommendation,Biopsy,Detection,Reason of Exam,Statistical Overview,Overview2,Overview3,Procedure/Pathology 1,Number Exams,Procedure/Pathology 1,,Patient Outcome Data",",",T2)
 S HD=HD_" Summary by "_$P("Provider,Referral,Site,Technologist,Age",",",T1)
 I DEVICE=1 S %R=1,%C=20 W @ZAA02GP,$J("",49) S %C=82-$L(HD)\2 W @ZAA02GP,ZAA02G("HI"),HD
 S (CT,CD,AG)="",D1=T1 S T1=$P("PROV,REF,SITEC,TECH,SITEC",",",T1) D RP0
 D:1 ^ZAA02GSCMST6 S TR=LN'=999 K TT,CT,SI,SC,BM,EM,BD,ED,AG,C,D,CD,T1,T2,T6,F,L,D1,D2,D3,D4,D5,D6,M,N,LT,TY,^ZAA02GTSCM($J+1) G END^ZAA02GSCMST
 ;
RP0 I T2=13 D   Q
 . S BDT=BM*100+BD-19000000,EDT=EM*100+ED-19000000
 . S L=$P("4,3,5,0,5",",",D1) S:L L="B1=$P(B,"";"","_L_")" S:L=0 L="B1=$P($P(B,"";OBT,"",2),"";"")"
 . I D1=5 S L="B1=""TOTAL"""
 . S J="" F  S J=$O(@ZAA02GSCM@("EXAM",J)) Q:J=""  S B=^(J) I $P(B,";",2)'<BDT,$P(B,";",2)'>EDT S @L S B=$P(B,";",9,99) D
 .. S C=$TR($E($P(B,";AB",2)),"NBPSMKAIH","123456044")+3,D="TS"_$E($P(B,";TS",2)_"?") S:B1="" B1="??" S $P(^ZAA02GTSCM($J,T1,B1,D),"+",C)=$P($G(^ZAA02GTSCM($J,T1,B1,D)),"+",C)+1,$P(^ZAA02GTSCM($J,T1,B1,"EXAMS"),"+",C)=$P($G(^ZAA02GTSCM($J,T1,B1,"EXAMS")),"+",C)+1
 I T1="SITEC" S SC="NA" F Y=BM:1:EM S:$E(Y,5,6)=13 Y=Y+88 S B1=$S(Y=BM:BD,1:1),B2=$S(Y=EM:ED,1:31) F J=1:1 S CT=$O(@ZAA02GSCM@("STATS",Y,"NA",T1,CT)) Q:CT=""  I $D(SC(CT)) S D2=CT D RP1
 I T1'="SITEC" F SI=1:1:$L(SITEC,",") S SC=$P(SITEC,",",SI) F Y=BM:1:EM S:$E(Y,5,6)=13 Y=Y+88 S B1=$S(Y=BM:BD,1:1),B2=$S(Y=EM:ED,1:31) F J=1:1 S CT=$O(@ZAA02GSCM@("STATS",Y,SC,T1,CT)) Q:CT=""  S D2=CT D RP1
 Q
RP1 F J=1:1 S CD=$O(@ZAA02GSCM@("STATS",Y,SC,T1,CT,CD)) Q:CD=""  S D=$G(^ZAA02GTSCM($J,T1,D2,CD)) D RP2 I D]"" S ^ZAA02GTSCM($J,T1,D2,CD)=D
 Q
RP2 S J=$G(@ZAA02GSCM@("STATS",Y,SC,T1,CT,CD,0)) F J=1:1 S AG=$O(^(AG)) Q:AG=""  S J=$S(AG<4:3,AG>9:AG,AG>7:8,1:AG) S C=^(AG),C="C="_$P(C,"+",B1,B2)_"+0" Q:$L(C)=2  S @C I C S $P(D,"+",J)=$P(D,"+",J)+C
 Q
 ;
HEAD S PG=PG+1 I DEVICE=1 S LN=2,%R=3,%C=1 W @ZAA02GP,ZAA02G("CS") S %C=5 W @ZAA02GP,ZAA02G("LO"),"DATES: ",ZAA02G("HI"),BEG," - ",END S %C=38 W @ZAA02GP,ZAA02G("LO"),"SITE: ",ZAA02G("HI"),SITEC S %C=55 W @ZAA02GP,ZAA02G("LO"),"STUDY: ",ZAA02G("HI"),TS,!!
 I DEVICE>1 D TOP W !
 I T2'=13 D
 . I 'T6 W ?13+OFF,"Category",?39+OFF,"<40  40-49 50-59 60-69 70-79  80+  Total" W:DEVICE>1.1 *13 S $X=0 W:DEVICE<2 ! W ?3+OFF,"__________________________________ _____ _____ _____ _____ _____ _____ _____",! Q
 . I $G(^ZAA02GSCMD("ST","M","PARAM","REPORT-BY-TYPE")) W ?13+OFF,"Category",?38+OFF," Screen   Diagn    Total" W:DEVICE>1.1 *13 S $X=0 W:DEVICE<2 ! W ?3+OFF,"__________________________________ ________ ________ ________",! Q
 . W ?13+OFF,"Category",?38+OFF," Screen   Diagn   AddnEval  Other    Total" W:DEVICE>1.1 *13 S $X=0 W:DEVICE<2 ! W ?3+OFF,"__________________________________ ________ ________ ________ ________ ________",! Q
 I T2=13 W ?3+OFF,"Type",?25+OFF,"Birads:  0     1     2     3     4     5     6   Total" W:DEVICE>1.1 *13 S $X=0 W:DEVICE<2 ! W ?3+OFF,"____________________________ _____ _____ _____ _____ _____ _____ _____ _____",!
 S LN=LN+2 I CONT'="" W ?OFF,CONT," (cont)",! S LN=LN+1
 Q
TOP S LN=5 X:$D(HDRX) HDRX X:$D(B(4))+$D(LC)>1 "F AA=2:1:LC+B(4)*6 W !" W $G(bd),!?OFF,DT S AA=$P($G(@ZAA02GSCR@("PARAM","BASIC")),"|"),C=80-$L(AA) W ?C\2+OFF,AA,?73+OFF,"Page ",PG,! S C=80-$L(HD) W ?C\2+OFF,HD,!
 S AA="DATES: "_BEG_" - "_END_"    SITE: "_$E(SITEC,1,25)_"  STUDY: "_TS,C=80-$L(AA) W ?C\2+OFF,AA,$G(BDO),!! Q
 ;
NEXT I DEVICE=1,PG>0 S %R=24,%C=20 W @ZAA02GP,"Press RETURN to continue - EXIT to quit " R C#1 X ZAA02G("T") S:$E(XX,$F(XX,ZF))="E" J=999 G HEAD:J'=999 Q
 W:LN'=999 # G HEAD
 ;
