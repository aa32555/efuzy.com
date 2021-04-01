ZAA02GSCRST1 ;PG&A,ZAA02G-SCRIPT,2.10,STATS - JOB DETAIL;2DEC94 5:08P;;;Wed, 19 Aug 2009  15:14
 ;Copyright (C) 1992, Patterson, Gray & Associates, Inc.
 ;
 S YY="Job#,7\Patient,13\Acc #,6\Prv,3\Proc1,5\ Date,5,/\Time,5,:\SC,2\TR#,3\St,4\"
 D LNG
 G TR:HD["I N D",ALL
LNG S R4="$E($P(^(J),""`"",2),1,13)_"" ""_$E($P(^(J),""`"",3),1,6)_"" ""_$E($P(^(J),""`"",4),1,3)_"" ""_$E($P(^(J),""`"",6),1,5)_"" ""_$P(^(J),""`"",9,13)" Q
BEG S R=1,(TOTC,TOTL,TOTT)=0,SD=BM*100+BD,EDT=EM*100+ED K PAGE S PP=0
R4 S (LI,DOC)="",I="",Y=$O(@ZAA02GSCR@("DIR",98,SD-1)) I Y'="" S LI=10000000-^(Y),Y=$O(^(EDT)) I Y'="" S I=10000000-^(Y)
 ;; W LI," ",I R CCC
 I DEVICE=1 S %R=3,%C=4,LNM=16 W @ZAA02GP,ZAA02G("LO"),*13 D HEAD
 S Y=$S('$D(ZAA02G(9)):"Press\NEXT SCREEN\or\PREV SCREEN\to page through report - \EXIT\to quit\",1:@ZAA02G(9)@(28))
LEV I DEVICE=1 S %R=22,%C=80-$L($P(Y,"\",1,7))\2 W @ZAA02GP,ZAA02G("LO"),$P(Y,"\"),ZAA02G("HI")," ",$E($P(Y,"\",2),1,15)," ",ZAA02G("LO"),$P(Y,"\",3),ZAA02G("HI")," ",$P(Y,"\",4)," ",ZAA02G("LO"),$P(Y,"\",5)," ",ZAA02G("HI"),$P(Y,"\",6)," ",ZAA02G("LO"),$P(Y,"\",7)
 S (NT,CN)=0 I DEVICE=1 S %C=1,%R=5 W @ZAA02GP,ZAA02G("HI"),*13
LEV1 S I=$O(@SRC@(I)) G TOT:I="",TOT:I>LI S J=10000000-I X E G:'$T LEV1 S CN=CN+1 I CN=1 D:DEVICE'=1 BEGP I '$D(PAGE(PP)) S PAGE(PP)=SD_","_I,NT=1
 G:'$D(@ZAA02GSCR@("TRANS",J)) LEV1
 W ?OFF,$P(^(J),"`")," ",@("$TR("_R4_",""`~"",""  "")"),?63+OFF
 I $D(^(J,.011,"STATS")) S A=^("STATS"),C=+A,L=$P(A,",",2),W=$P(A,",",3),B=$P(A,",",4),S=$P(A,",",5),R=$P(A,",",6),@LF,@WF,T=$P(A,",",7) S:NT TOTC=TOTC+CC,TOTL=TOTL+LL,TOTT=T*.1+TOTT W $J(T*.1,4,1),$J(CC,7,0),$J(LL,5,0)
 W ! G LEV1:CN<LNM G FK
 ;
ASK S J=1,%C=1,N=CN S:CN=17 N=16 X ZAA02G("ECHO-OFF") S X=$D(@ZAA02GSCR@("TRANS",0)) G A1
A1 S %R=24
A2 R C#1 I C'="" G A2
 X ZAA02G("T") S C=$E(XX,$F(XX,ZF)) I C'="",$T(@C)'="" G @C
 W *7 G A1
 ;
O G:CN'=17 ERR D CLEAR S PP=PP+1 G LEV
P G:'PP A1 D CLEAR S PP=PP-1,SD=+PAGE(PP),I=$P(PAGE(PP),",",2)-1 G LEV
Q I PP D CLEAR G BEG
 G A1
 ;
E G EXIT
 ;
ERR W *7 G A1
CLEAR S %R=5,%C=1 W @ZAA02GP,ZAA02G("LO"),ZAA02G("CS") Q
 ;
TOT Q:TOTC=0  I TOTL S I="Totals - "_$J(TOTT,5,1)_$J(TOTC,7,0)_$J(TOTL,5) W !?53+OFF,I
 I DEVICE>1 W # Q
FK I CN<1,TOTC=0 W !!!!!?30,"No entries found for ",TR,!!!!?35,"PRESS EXIT" R A G EXIT
 G ASK:DEVICE=1 W # S CN=0 G LEV1
 ;
Y S HP=8 D Y^ZAA02GSCRHP D CLEAR  G BEG
 ;
HEAD N J W ?OFF F J=1:1:$L(YY,"\") S A=$P(YY,"\",J) W $P(A,","),$J("",$P(A,",",2)-$L($P(A,","))+1)
 W ?63+OFF,"Min   Chars  Lns",!?OFF F J=1:1:$L(YY,"\") S A=$P(YY,"\",J) W $E("---------------------",1,$P(A,",",2))," "
 W ?63+OFF,"---- ------ ----",!! Q
 ;
EXIT I $D(JJ) Q:TR=""  S %R=3,%C=1 W @ZAA02GP,ZAA02G("CS") Q
 K CN,NT,TOTL,TOTC,PAGE,PP,L,I,J,LI,R5,R4,SRC,LF,WF,CC,LL X ZAA02G("ECHO-ON") X:$D(^ZAA02G(.1,ZAA02G,7)) $P(^(7),"\",2) Q
ALL S TR="",SRC="@ZAA02GSCR@(""DIR"","_(11)_",TR)",(SOTT,SOTC,SOTL)=0 F JJ=1:1 S TR=$O(@SRC) Q:TR=""  D ALT S SOTT=SOTT+TOTT,SOTC=SOTC+TOTC,SOTL=SOTL+TOTL
 S TOTT=SOTT,TOTC=SOTC,TOTL=SOTL G TOT:DEVICE>1,EXIT
TR K JJ S SRC="@ZAA02GSCR@(""DIR"","_(11)_",TR)",TR=$TR(TRANS,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
ALT S E="I 1" G BEG
 ;
BEGP S PG=PG+1,LN=5
 W:$Y>8 # W !,?OFF,DT S A=$P(@ZAA02GSCR@("PARAM","BASIC"),"|"),C=80-$L(A) W ?C\2+OFF,A,?73+OFF,"Page ",PG,! S C=80-$L(HD) W ?C\2+OFF,HD,!
 S A="DATES: "_BEG_" - "_END_"     SITE: "_SC,C=80-$L(A) W ?C\2+OFF,A,!! D HEAD Q
 ;
STATS R "MONTH (YYMM) - ",M,!,"TYPE (SITEC,PROV,TR,UNIT,TYPE) - ",C,!!
S1 W ?10 F J=1:1:7 S T(J)=0 W $J($P("C,L,W,B,S,R,T",",",J),8)
 S A="" F J=1:1 S A=$O(@ZAA02GSCR@("STATS",M,SC,C,A)) Q:A=""  S B="" F J=1:1 S B=$O(@ZAA02GSCR@("STATS",M,SC,C,A,B)) Q:B=""  W !,$J(A,5),$J(B,6) F L=1:1:7 S D="D="_@ZAA02GSCR@("STATS",M,SC,C,A,B,L),@D W $J(D,8) S T(L)=T(L)+D
 Q
 ;
QUEUE K Y S DOC="REPORTS" S Y("XECUTE")="D QUEUE1^ZAA02GSCRST1",Y("ZAA02GSCR")=ZAA02GSCR
 F J=1:1 S T=$P("BEG,END,DEVICE,HD,T1,T2,EX,CTX,TRANS,REPORT,OFF,DT,SITE,SC",",",J) Q:T=""  S:$D(@T) A="A="_T,@A,Y(T)=A
 D QUEUE^ZAA02GSCRSP K Y Q
QUEUE1 S A="" F J=1:1 S A=$O(@VDOC@(A)) Q:A=""  S B=A_"=@VDOC@(A)",@B
 D OPENDV^ZAA02GWPPC
 S B(2)=11,B(3)=.5,B(4)=.9 D INIT^ZAA02GWPPC1,^ZAA02GSCRST9:49[(+DVP)
 S DONE=1,OFF=8*$S($D(LMG):0,1:1) G REP^ZAA02GSCRST
