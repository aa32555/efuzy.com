ZAA02GSCMST ;PG&A,ZAA02G-MTS,1.20,REPORTS;2DEC94 4:57P;;;Fri, 20 May 2016  09:10
 ;Copyright (C) 1995, Patterson, Gray & Associates, Inc.
C ;
 ;
DICT S HD="D I C T I O N A R Y  L I S T I N G",SET=2 D SETUP2,DICT^ZAA02GSCMST1 Q
DUMP S HD="S T A T I S T I C S  D U M P" D SETUP G:'$D(BEG) END S REPORT="DUMP^ZAA02GSCMST3",T1=TYPS G REP
SUMM S HD="S U M M A R Y   R E P O R T",T1=TYPS,T2=J D SETUP G:'$D(BEG) END S REPORT="^ZAA02GSCMST4" G REP
GEN S BEG=$P(BEG,"\",2),END=$P(END,"\",2),%R=3,%C=1 W @ZAA02GP,ZAA02G("CS") D DATE S REPORT="^ZAA02GSCMST5" G REP
PROV S HD="P R O V I D E R     S T A T I S T I C S" D SETUP G:'$D(BEG) END
 S T1="PROV",T2="Provider",EX="I 1" G REP
SITES S HD="S I T E    S T A T I S T I C S" D SETUP G:'$D(BEG) END
 S T1="SITEC",T2="Sites",EX="I 1" G REP
PAT S HD="P A T I E N T   L I S T I N G",SET=2 D SETUP G:'$D(BEG) END
 S SORT=4,TYPE=1,BSORT=1,REPORT="^ZAA02GSCMST5" G REP
FLUP S HD="P A T I E N T   F O L L O W - U P",SET=2 D SETUP G:'$D(BEG) END
 S TYPE=2,SORT=4,BSORT=1,REPORT="^ZAA02GSCMST5" G REP
MIS S HD="MAMMO INTREPRETATION SUMMARY BY PROVIDER" D SETUP G:'$D(BEG) END S REPORT="^ZAA02GSCMST7" G REP
LET S HD="L E T T E R  S U M M A R Y",SET=2 D SETUP G:'$D(BEG) END
 S TYPE=4,SORT=4,BSORT=2,REPORT="^ZAA02GSCMST5" G REP
BIRAD0 S HD="B I R A D S 0   R E P O R T",SET=2 D SETUP G:'$D(BEG) END
 S TYPE=5,SORT=5,BSORT=2,REPORT="^ZAA02GSCMST5" G REP
BIOP S HD="P A T I E N T   B I O P S Y   R E P O R T",SET=2 D SETUP G:'$D(BEG) END
 S TYPE=3,SORT=4,BSORT=1,REPORT="^ZAA02GSCMST5" G REP
CDTD S HD="T R A C K I N G   D A T A",SET=2 D SETUP G:'$D(BEG) END
 S TYPE=1,SORT=1,BSORT=1,REPORT="^ZAA02GSCMST2" G REP
 ;
SETUP I $D(VB) D VB2 Q
 D SETUP2,DATES I ZAA02Gform["C-TIMEOUT"!('$D(BEG))!($G(SC)="") K BEG Q
 S:'$D(END) END=DT S DV=0 I DEVICE>1 S:DEVICE=2 DV=$P(@ZAA02GSCR@("PARAM","BASIC"),"|",9) D:DEVICE=3!(DV="") GETPRNT^ZAA02GSCMSP I DV="" K BEG
 S %R=3,%C=1 W @ZAA02GP,ZAA02G("CS") I DEVICE=1 S %R=8,%C=35 W @ZAA02GP,"PLEASE WAIT"
 Q
SETUP1 S BM=$P(BEG,"/",3)*100+BEG,BD=$P(BEG,"/",2),EM=$P(END,"/",3)*100+END,ED=$P(END,"/",2),BEG=$P(BEG,"/",1,3),END=$P(END,"/",1,3)
 S (TW,TL,TR,TM,PG)=0,LNM=$S(DEVICE=1:20,1:60),OFF=$S(DEVICE=1:0,1:OFF),CONT="",LN=999,SITEC=$E(SC,2,999)
 I SITEC="" D
 . S (A,B)="" F  S A=$O(@ZAA02GSCM@("STATS",A)) Q:A=""  F  S B=$O(@ZAA02GSCM@("STATS",A,"NA","SITEC",B)) Q:B=""  I B'="TOTAL",'$D(SITEC(B)) S SITEC=SITEC_","_B,SITEC(B)=""
 . S SITEC=$E(SITEC,2,9999)
 Q
SETUP2 S %R=1,%C=18,C=48-$L(HD),C=$J("",C\2)_HD_$J("",C\2) W @ZAA02GP,ZAA02G("HI"),C,!!,ZAA02G("CS") Q
 ;
END I $G(VB) S B="" W:'$D(last) # Q
 I $D(TR),DEVICE=1,TR=0 S %R=3,%C=18 W @ZAA02GP,ZAA02G("CS") S %R=10 W @ZAA02GP,"No statistical data found for dates specified"
 I $D(TR),DEVICE=1,$G(J)<900 S %R=24,%C=34 W @ZAA02GP,"Press RETURN " R C#1
 I DEVICE>1,$E(DV)'=" " W #
DONE K TR,TL,TW,TM,W,L,R,B,C,S,LN,LNM,TYPE,REPORT,DEVICE,SITE,PG,T1,T2,OFF,CC,LL,WF,LF,ED,AA,SORT,BSORT,TYPE,DV,BD,bd,SET
 K RTITLE,FROM,DATA Q
 Q
 ;
DATES S SCR="ZAA02GSCM",SNL=$S($G(SET)=2:10,1:6),(TYPE,DEVICE,SITE)=1,REFRESH="3:22",ZAA02Gform="0;;;N"
 D ^ZAA02GFORM,DATE
 Q
TYPE S X=TYPE,%R=14,%C=31,Z="COUNTS,PERCENTAGES,COUNTS & PERCENTAGES" S:$G(SET)=2 Z="SUMMARY,DETAIL" D POP S TYPE=X Q
DEV S X=DEVICE,%R=16,%C=31,Z="TERMINAL,DEFAULT PRINTER,OTHER PRINTER" D POP S DEVICE=X Q
POP X ZAA02G("ECHO-OFF") S H=%C,G=$L(Z,",")
P1 S %C=X-1*2+H+$L($P(","_Z,",",1,X)),OX=X W @ZAA02GP,ZAA02G("RON"),$S('$D(YY):"",$G(YY(X)):ZAA02G("HI"),1:ZAA02G("LO"))," ",$P(Z,",",X)," ",ZAA02G("HI"),ZAA02G("ROF")
 R C#1 I C'="" G P1
 X ZAA02G("T") S F=$E(XX,$F(XX,ZF)),D=$E(1313,$F("CD7",F))-2 S:F=7 YY(X)=$G(YY(X))+1#2 S X=X+D-1#G+1 I "FAEB"[F S X=OX,RX=$S(F="E":99,F="A":-1,1:1) X ^ZAA02G("ECHO-ON") Q
 W @ZAA02GP,$S('$D(YY):"",$G(YY(OX)):ZAA02G("LO")_ZAA02G("RON"),1:"")," ",$P(Z,",",OX)," ",ZAA02G("HI") G P1
 ;
REP I '$D(ZAA02GSCMD) S ZAA02GSCMD=ZAA02GSCM,TSU="M"
 S TS=$G(@ZAA02GSCM)
 I $D(%R),DEVICE>1 D QUEUE G DONE
 I $D(VB),DV]"" D QUEUE G DONE
 D SETUP1 G @REPORT
DATE S K=$S($P($H,",",2)<18000:$H-1,1:$H) D D1 S YM=$E(Y,1,6),DY=D I $P($H,",",2)<18000 S K=$H D D1
 S TM=$P($H,",",2)\60,TM=$E(TM\60+100,2,3)_":"_$E(TM#60+100,2,3) K K,Y,M,D Q
D1 S K=K>21608+305+K,Y=4*K+3\1461,D=K*4+3-(1461*Y)+4\4,M=5*D-3\153,D=5*D-3-(153*M)+5\5,M=M+2,Y=M\12+Y+1840,M=M#12+1,Y=Y*100+M*100+D,DT=$E(Y,5,6)_"/"_$E(Y,7,8)_"/"_$E(Y,1,4) Q
SITE ; SETUP SITE CODES FOR ALL BUT SITE
 G SITEX:$G(TYPS)=3 K SITEC S (SITEC,A,B)="",%C=32,%R=9 W ZAA02G("HI")
 F J=1:1 S A=$O(@ZAA02GSCM@("STATS",A)) Q:A=""  F J=1:1 S B=$O(@ZAA02GSCM@("STATS",A,B)) Q:B=""  I B'="NA",'$D(SITEC(B)) W @ZAA02GP,B S SITEC=SITEC_","_B,%C=%C+3+$L(B),SITEC(B)=""
 S SITEC=$E(SITEC,2,999) W ZAA02G("HI") I SITEC="" S SITEC="NA",SITEC("NC")="" W @ZAA02GP,"NA"
 Q
SITEX ; SETUP SITE CODES FOR SITE
 K SITEC S (SITEC,A,B)="",%C=32,%R=9 W ZAA02G("HI") F  S A=$O(@ZAA02GSCM@("STATS",A)) Q:A=""  F  S B=$O(@ZAA02GSCM@("STATS",A,"NA","SITEC",B)) Q:B=""  I B'="TOTAL",'$D(SITEC(B)) W @ZAA02GP,B S SITEC=SITEC_","_B,%C=%C+3+$L(B),SITEC(B)=""
 S SITEC=$E(SITEC,2,99) W ZAA02G("HI") I SITEC="" S SITEC="NA",SITEC("NC")="" W @ZAA02GP,"NA"
 Q
SITEC K YY S YY=1,X=SITE,Z=SITEC,%R=9,%C=31 I X["," F J=1:1:$L(X,",") S G=$P(X,",",J) S:G YY(G)=1
 S X=+X D POP S SITE=X,(X,G)="" F J=1:1 S G=$O(YY(G)) Q:G=""  S:YY(G) X=X_G_","
 S:X'="" SITE=X S SC="",X=SITE F J=1:1:$L(X,",") S G=$P(X,",",J) S:G SC=SC_","_$P(Z,",",G)
 W ZAA02G("HI") K YY Q
HEAD S PG=PG+1 I DEVICE=1 S LN=2,%R=3,%C=1 W @ZAA02GP,ZAA02G("CS") S %C=10 W @ZAA02GP,ZAA02G("LO"),"DATES: ",ZAA02G("HI"),BEG," - ",END S %C=50 W @ZAA02GP,ZAA02G("LO"),"SITE: ",ZAA02G("HI"),$E(SITEC,1,25),!!
 Q
QUEUE K Y S DOC="REPORTS" S Y("XECUTE")="D QUEUE1^ZAA02GSCMST",CP=1
 F J=1:1 S T=$P("ZAA02GSCMD,ZAA02GSCM,ZAA02GSCR,ZAA02GSCRP,BEG,END,DEVICE,HD,T1,T2,EX,CTX,TRANS,REPORT,OFF,DT,SITE,SC,SORT,BSORT,TYPE,STATC,TSU,TS,RESULTS",",",J) Q:T=""  S:$D(@T) A="A="_T,@A,Y(T)=A
 D QUEUE^ZAA02GSCMSP K Y Q:$D(VB)  S %R=3,%C=1 W @ZAA02GP,ZAA02G("CS") S %R=8,%C=20 W @ZAA02GP,"Report is queued to print on Printer - ",DV H 2 Q
QUEUE1 S A="" F J=1:1 S A=$O(@VDOC@(A)) Q:A=""  S B=A_"=@VDOC@(A)",@B
 D OPENDV^ZAA02GWPPC
 S B(2)=11,B(3)=.5,B(4)=.9 D INIT^ZAA02GWPPC1,^ZAA02GSCMST9:49[(+DVP) S bd=$G(BD)
 S DONE=1,OFF=0 G REP
 ;
VB S $ZE="",P=$TR($P(X,"|",8),$C(9),"|")
 S T=$P(P,"|",6),TYPS=$F("PRSTG",$E(T))-1 I T["Type" S TYPS=TYPS+5
 S T=$P(P,"|"),VB=1
 S Y="Follow-up Report\Patient Listing\Biopsy Recommendation Report\Interpretation Summary\Letter Summary Report\BIRADS 0 Report\Tab Delimited Tracking Data"
 S T2=0 F J=1:1 S I=$P(Y,"\",J) Q:I=""  I T[I S T2=J Q
 I T2 G @$P("FLUP\PAT\BIOP\MIS\LET\BIRAD0\CDTD","\",T2)
 S Y="Interpretation Report\Recommendation Report\Biopsy Report\Detection Report\Examination Reason Report\Overview\Overview2\Overview3\Procedure/Pathology 1\Number of Exams\Procedure/Pathology 2\Statistics Dump\Patient Outcome Data"
 S T2=0 F J=1:1 S I=$P(Y,"\",J) Q:I=""  I T[I S T2=J Q
 I T2 S J=T2 G DUMP:J=12,SUMM
 Q
VB2 S P=$TR($P(X,"|",8),$C(9),"|"),BEG=$P(P,"|",2),END=$P(P,"|",3),SC=$TR($P(P,"|",9),$C(0),",")
 S ^ZAA02GVBUSER(USER,"TRAN","MAMMO","LASTREP")=$TR($P($P(X,"|",8),$C(9),7,13),$C(9,0),"^^")
 S DEVICE=1.1,OFF=10,ZAA02GSCM="^ZAA02GSCMD(""ST"",TSU)",ZAA02GSCR="^ZAA02GSCR",ZAA02GSCRP=";;2",ZAA02GSCMD="^ZAA02GSCMD"
 S DV=""  I P2'=0,P2]"" S DV=P2
 S TYPE=$TR($P(P,"|",4),"CP","12"),T=$P(P,"|") S:TYPE=12 TYPE=3
 S TSU=$TR($P($P(T," - ",2)," "),"1234","cdip"),TS="Mammo"
 S:$P(SC,",",$L(SC))="" SC=$P(SC,",",1,$L(SC,",")-1) S SC=","_SC
 D DATE S B=""
 Q
 ;
 S B(2)=11,B(3)=.5,B(4)=.9 ; D INIT^ZAA02GWPPC1,^ZAA02GSCMST9:49[(+DVP) S bd=$G(BD)
 S DONE=1,OFF=0,TS="",DV="" D SETUP1,@REPORT S B="" Q
