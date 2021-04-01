ZAA02GSCRFX1 ;PG&A,ZAA02G-SCRIPT,2.10,FAX OPERATION REPORTS;29JUL97 4:26P;;;Wed, 14 Sep 2011  11:09
 ;Copyright (C) 1993, Patterson, Gray & Associates, Inc.
 ;
FAXER S FERR=1
FAXR ; FAX LOG 
 I $D(%R),DEVICE>1 S REPORT="FAXR^ZAA02GSCRFX1" G QUEUE^ZAA02GSCRST1
 S B=SC K SC F J=1:1:$L(B,",") I $P(B,",",J)]"" S SC($P(B,",",J))=""
 S BD=$P(BEG,"/",4),ED=$P(END,"/",4) S:ED="" ED=+$H S:ED-1<BD ED=BD
 S (TOTT,TOT)=0,LF=$P(@ZAA02GSCR@("PARAM","BASIC"),"|",4),PG=0,LNM=$S(DEVICE=1:19,1:50),OFF=$S(DEVICE=1:0,1:5),LN=LNM+1,CONT="",Y="" D FAXRH
 S B=ED D FAXRF S:Y="" Y=$O(^ZAA02GFAXQ("DIR","")) S ED=Y,B=BD-1 D FAXRF S:Y="" Y=L+1 S BD=Y I ED F Y=BD-1:-1:ED I $D(^ZAA02GFAXQ("DIR",Y)) D FAXRP G:J=999 FAXRE
 D:LN>LNM FAXRN G:TOT=0 FAXRM W ?42+OFF,"=====================================",!?42+OFF,"TOTAL:   ",TOT," faxes " I '$D(FERR) W TOTT\1," minutes"
 G FAXRD
 ;
FAXRF S Y=$O(^ZAA02GFAXQ("DIR","")) F Y=Y:300 S L=Y,Y=$O(^(Y)) Q:Y=""  I $P(^(Y),"\",28) Q:$P(^(Y),"\",28)'>B
 S Y=$S(Y="":L,1:Y-302) F Y=Y:10 S L=Y,Y=$O(^(Y)) Q:Y=""  I $P(^(Y),"\",28) Q:$P(^(Y),"\",28)'>B
 S Y=$S(Y="":L,1:Y-12) F Y=Y:0 S L=Y,Y=$O(^(Y)) Q:Y=""  I $P(^(Y),"\",28) Q:$P(^(Y),"\",28)'>B
 Q
 ;
FAXRH S PG=PG+1 I DEVICE=1 S LN=2,%R=3,%C=1 W @ZAA02GP,ZAA02G("CS") S %C=26 W @ZAA02GP,ZAA02G("LO"),"DATES: ",ZAA02G("HI"),$P(BEG,"/",1,3)," - ",$P(END,"/",1,3),!!
 I DEVICE>1 D FAXRT
 W ?OFF,"Report  PS   Patient            To            Fax #        Status     Time       Pg",!?OFF,"------- -- ------------------ ------------- -------------- ------ -------------- --",! S LN=LN+2 I CONT'="" W ?OFF,CONT," (cont)",! S LN=LN+1
 Q
FAXRT S LN=5 W:$Y>4 # W !?OFF,DT S AA=$P(@ZAA02GSCR@("PARAM","BASIC"),"|"),C=80-$L(AA) W ?C\2+OFF,AA,?73+OFF,"Page ",PG,! S C=80-$L(HD) W ?C\2+OFF,HD,!
 S AA="DATES: "_$P(BEG,"/",1,3)_" - "_$P(END,"/",1,3),C=80-$L(AA) W ?C\2+OFF,AA,!! Q
FAXRP S C=^(Y) S B=$P(C,"\",2) Q:B=""  I $P(C,"\",10)'=3,$D(FERR) Q
 S $P(C,"\",5)=$P($G(@ZAA02GSCR@("TRANS",B,.011)),"`",6)_"\"_$P($G(^(.011)),"`",8) I $P(C,"\",5)]"" Q:'$D(SC($P(C,"\",5)))
 S N=$$DT($P(C,"\",29)),J=$P(C,"\",7),$P(C,"\",7)=$P(J," ")_"/"_$E(N,3,4)_" "_$P(J," ",2)
 F J=1:1:8 W ?OFF,$E($P(C,"\",$P("2,5,6,14,4,3,7,10",",",J))_$J("",20),1,$P("7,2,18,13,14,6,14,1",",",J))," "
 W ! S TOT=TOT+1,C=$TR($P(C,"\",8)," ",""),TOTT=$P(C,":",2)/60+C+TOTT,LN=LN+1
 D:LN>LNM FAXRN Q
 ;
DT(D) N K,Y,M S K=D>21608+D+305,Y=4*K+3\1461,D=K*4+3-(1461*Y)+4\4,M=5*D-3\153,D=5*D-3-(153*M)+5\5,M=M+2,Y=M\12+Y+1840,M=M#12+1 Q Y*100+M*100+D
 ;
FAXRN I DEVICE=1,PG>0 S %R=24,%C=20 W @ZAA02GP,"Press RETURN to continue - EXIT to quit " R C#1 X ZAA02G("T") S:$E(XX,$F(XX,ZF))="E" J=999 G FAXRH:J'=999 Q
 W # G FAXRH
 ;
FAXRM I DEVICE=1,TOT=0 S %R=10,%C=18 W @ZAA02GP,"No data found for dates specified"
FAXRD I DEVICE=1 S %R=24,%C=34 W @ZAA02GP,"Press RETURN " R C#1
 I DEVICE>1,$E(DV)'=" " W # C DV
FAXRE K TOT,LN,LNM,BEG,END,TYPE,DEVICE,PG,REPORT,OFF Q
 ;
REPORT I DEVICE=1 D REPORTS K END,BEG,Y,A,B,C,TOT,TOTT,OFF,DEVICE,DV Q
 K Y S DOC="FAX LOG" S Y("XECUTE")="D REPORTQ^ZAA02GSCRFX1" F J=1:1 S T=$P("ZAA02GSCR,BEG,END,DEVICE,DV",",",J) Q:T=""  S:$D(@T) A="A="_T,@A,Y(T)=A
 D QUEUE^ZAA02GSCRSP K Y Q
REPORTQ S A="",DONE=1 F J=1:1 S A=$O(@VDOC@(A)) Q:A=""  S B=A_"=@VDOC@(A)",@B
REPORTS S OFF=$S(DEVICE=1:0,1:1),TOT=0,TOTT=0 W:$Y #
 S A="",B=$P(BEG,"/",4) F J=1:1 S C=A,A=$O(^ZAA02GFAXQ("DIR",A)) Q:A=""  I $P(^(A),"\",28)<B Q
 S B=$P(END,"/",4),D=$O(^("")) S:A="" A=C+1 F J=1:1:999 S A=A-1 Q:A<D  I $D(^ZAA02GFAXQ("DIR",A)) Q:$P(^(A),"\",28)>B   D REP1
 Q:J=999  I DEVICE=1&($Y<15)!(DEVICE>1) W !?20,"Total Faxes: ",TOT,"   Total Minutes: ",TOTT\60,!
 I DEVICE=1,$Y>1 G REP1N
 W # Q
REP1 D:$Y=0 REP1H S C=^(A) W ?1+OFF,$P(C,"\",6),?14+OFF,$P(C,"\",7),?27+OFF,$E($P(C,"\",13),1,24),?52+OFF,$P(C,"\",4),!
 W ?27+OFF,$E($P(C,"\",31),1,24),?52+OFF,$J($P(C,"\",2),10),?70+OFF,$P(C,"\",3),! S TOT=TOT+1,C=$TR($P(C,"\",8)," ",""),TOTT=C*60+$P(C,":",2)+TOTT
 I DEVICE=1 G:$Y>20 REP1N
 W:$Y>55 # Q
 ;
REP1N S %R=24,%C=20,J=1 W @ZAA02GP,"Press RETURN to continue - EXIT to quit " R C#1 X ZAA02G("T") S:$E(XX,$F(XX,ZF))="E" J=999 S $Y=0 Q
 ;
REP1H I DEVICE=1 S %R=3,%C=1 W @ZAA02GP,ZAA02G("CS")
