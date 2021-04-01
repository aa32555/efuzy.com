ZAA02GSCMST2 ;PG&A,ZAA02G-MTS,1.20,REPORTS - TECH DUMP;2DEC94 4:57P;;;Tue, 24 Mar 2009  16:19
 ;Copyright (C) 1995, Patterson, Gray & Associates, Inc.
C ;
 ; COMMA (TAB) DELIMITED DUMP
 S BM=$P(BEG,"/",3)-1900*100+BEG*100+$P(BEG,"/",2),EM=$P(END,"/",3)-1900*100+END*100+$P(END,"/",2),CM=$C(9),E="",LN=0
 K T S T("T99")="Follow Up List" F J=1:1:25 S T("T"_J)="T"_J
 S B="" F  S B=$O(@ZAA02GSCM@("PARAM","LETTERS",B))  Q:B=""  Q:B=99  S T("T"_B)=$S($P(^(B),"\",6)]"":$P(^(B),"\",6),1:"T"_B)
 W $TR("DATE,SITE,BIRADS,PATH,PROVIDER,JOB,PATIENT,ACCOUNT#,DOB,PAT PHONE,REFERRAL,RAW DATA,LETTERS SENT,LETTERS QUEUED",",",CM),!
 F Y=BM-1:0:EM S Y=$O(@ZAA02GSCM@("DIR","DST",Y)) Q:Y=""  Q:Y>EM  F  S E=$O(@ZAA02GSCM@("DIR","DST",Y,Y,E)) Q:E=""  D
 . S LN=LN+1 I LN>55 S LN=1
 . S B=$G(@ZAA02GSCM@("EXAM",E)),C=$G(@ZAA02GSCR@("TRANS",E,.011))
 . S D=$P(B,";",2) I $L(D)'=7 S D=D_"000000" W $E(D,3,4),"/",$E(D,5,6),"/",$E(D,1,2),CM
 . E  W $E(D,4,5),"/",$E(D,6,7),"/",$E(D,2,3),CM
 . W $P(B,";",5),CM
 . S T1=$E($P($P(B,";",9,99),";AB",2)) W:T1?1A "BIRADS-",$F("ANBPSM",T1)-2 W CM,$E($P($P(B,";",9,99),";FA",2)),CM
 . W $P(B,";",4),CM,E,CM,$P(C,"`",8),CM,$P(C,"`",9),CM,$P(C,"`",10),CM
 . S D=$P(B,";") I D'="" S D=$$PATTEL^ZAA02GSCMIF(D) I D]"" W D
 . W CM S D=$P(B,";",3) W $S(D="":"",1:D_"  "_$$REFNAME^ZAA02GSCMIF(D))
 . W $P(B,";",9,99)
 . W CM S (A,D)="" F  S A=$O(@ZAA02GSCM@("LETHIST",+$P(B,";"),+$P(B,";",2),A)) Q:A=""  F  S D=$O(@ZAA02GSCM@("LETHIST",+$P(B,";"),+$P(B,";",2),A,D)) Q:D=""  I $E(A)="T" D
 .. W $E($G(T(A)),1,22)," ( sent on ",$$DT(D),") "
 . W CM S (A,D)="" F  S B=$O(@ZAA02GSCM@("LETMR",+$P(B,";"),+$P(B,";",2),A)) Q:A=""  I A'="T99" F  S D=$O(@ZAA02GSCM@("LETMR",+$P(B,";"),+$P(B,";",2),A,D)) Q:D=""  D
 .. W $E($G(T(A)),1,22),"( created ",$$DT(D),") "
 . W !
 G END^ZAA02GSCMST
 Q
DT(X) Q:$L(X)'=7 $E(X,3,4)_"/"_$E(X,5,6)_"/"_$E(X,1,2)
 Q $E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 ;
 ;  TECHNOLOGISTS SCAN
TECH S (CT,CD)=""
 D REP1 K TT,CT,SI,SC,BM,EM,BD,ED,AG,C,D,CD,T1 Q
 ;
REP1 D:LN>2 NEXT W "Statistics by Mammo Tech",!! S LN=LN+2
 F J=1:1 S CT=$O(^ZAA02GTSCM($J,T1,CT)) Q:CT=""  D REP3
 Q
REP4 D:LN>LNM NEXT W ?OFF+3,CD,?OFF+7 S TT=$G(@ZAA02GSCMD@("DICT",3,CD)) I TT]"" W " ",$E($P(@ZAA02GSCMD@("DICT",1,+TT,$P(TT,",",2)),"^",2),1,22)
 S TT=0 W ?OFF+30 F J=3:1:8 W $J(+$P(C,"+",J),7) S TT=TT+$P(C,"+",J)
 W $J(TT,7),! S LN=LN+1 Q
 ;
HEAD S PG=PG+1 I DEVICE=1 S LN=2,%R=3,%C=1 W @ZAA02GP,ZAA02G("CS") S %C=10 W @ZAA02GP,ZAA02G("LO"),"DATES: ",ZAA02G("HI"),BEG," - ",END S %C=50 W @ZAA02GP,ZAA02G("LO"),"SITE: ",ZAA02G("HI"),$E(SITEC,1,25),!!
 I DEVICE>1 D TOP
 W ?13+OFF,"Code",?32,"<40   40-49  50-59  60-69  70-79   80+   Total",!?3+OFF,"--------------------------  ------ ------ ------ ------ ------ ------ ------",! S LN=LN+2 I CONT'="" W ?OFF,CONT," (cont)",! S LN=LN+1
 Q
TOP S LN=5 X:$D(HDRX) HDRX X:$D(B(4))+$D(LC)>1 "F AA=2:1:LC+B(4)*6 W !" W !?OFF,DT S AA=$P($G(@ZAA02GSCR@("PARAM","BASIC")),"|"),C=80-$L(AA) W ?C\2+OFF,AA,?73+OFF,"Page ",PG,! S C=80-$L(HD) W ?C\2+OFF,HD,!
 S AA="DATES: "_BEG_" - "_END_"    SITE: "_SITEC,C=80-$L(AA) W ?C\2+OFF,AA,!! Q
 ;
NEXT I DEVICE=1,PG>0 S %R=24,%C=20 W @ZAA02GP,"Press RETURN to continue - EXIT to quit " R C#1 X ZAA02G("T") S:$E(XX,$F(XX,ZF))="E" J=999 G HEAD:J'=999 Q
 W:LN'=999 # G HEAD:J'=999
