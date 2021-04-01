ZAA02GSCMIN ;PG&A,ZAA02G-MTS,1.20,SITE INIT;02NOV94  11:35;;;Wed, 16 Oct 2013  10:51
 ;
 ;
DEVICE ; COPY PRINTER DEVICE CHARACTERISTICS TO ANOTHER
 R "FROM DEVICE-",DV,!,"TO DEVICE-",DT,!
 S ^ZAA02GWP(96,DT)=^ZAA02GWP(96,DV) F J=1,3 I $D(^ZAA02GWP(96,DV,J)) S ^ZAA02GWP(96,DT,J)=^(J)
 I $D(^ZAA02GWP(96.1,DV)) S ^ZAA02GWP(96.1,DT)=^(DV)
 Q
 ;
REPORTS ; DISPLAY/MODIFY REPORT TEMPLATE SETTINGS
 S C="WIDTH,.01,1;LPI,.03,1;CPI,.03,2;L-MARGIN,.03,3;T-MARGIN,.03,4;B-MARGIN,.03,10;2+ T-MARGIN,.03,9;1ST HEAD/FOOT,.03,13;2+ HEAD/FOOT,.03,14;TYPE,.03,15;NOTES,.03,16;DIST,.03,17;SITE,.03,19"
 W "DISPLAY/MODIFY REPORT TEMPLATE SETTINGS",!!,"Select one",! F J=1:1 S B=$P(C,";",J) Q:B=""  W ?4,J,".  ",$P(B,","),?20,$P(B,",",2),?25,$P(B,",",3),!
 R "?? ",A,! Q:A=""  I A<1!(A'<J) W *7 G REPORTS
 S T=$P(C,";",A)
REPS1 R "Display or Modify (DM) ? ",D,! S MM="I 1",M=1 G REPDP:D="D",REPS1:D'="M"
REPMO R "Modify Options",!?5,"1. Change All",!?5,"2. Change from X to Y",!?5,"3. Prompt for each",!?5,"4. Enter Custom Criteria",!,"?? ",M,! G:M<1!(M>4) REPMO
 I M=1 R !,"Change All to - ",C,!  S MM="S $P(^($P(T,"","",2)),""\"",$P(T,"","",3))=C W ?30,""change to - "",C"
 I M=2 R !,"Change From - ",F,!," To - ",C,! S MM="I $P(^($P(T,"","",2)),""\"",$P(T,"","",3))=F S $P(^($P(T,"","",2)),""\"",$P(T,"","",3))=C W ?30,""change to - "",C"
 I M=3 S MM="R ?30,""Change? (N) - "",F I F=""Y"" R "" To - "",C S $P(^($P(T,"","",2)),""\"",$P(T,"","",3))=C W ?40,"" changed"""
 I M=4 R !,"Enter Criteria - ",MM,!
REPDP S A=0 W # F J=1:1 S A=$O(@ZAA02GSCMD@(106,A)) Q:A=""  W A W:$X<20 $E($G(A),1,50) W !,?5,$P(T,",")," = ",$P($G(^(A,$P(T,",",2))),"\",$P(T,",",3)) X MM W ! I M=1,$Y>22 W "press return to continue" R CC,!! W #
 R !!,"END",!!,"Do you want to rebuild Index ? - ",A,! I A="Y" S DIR=106 D RBDIR^ZAA02GSCMRD
 Q
 ;
SCAN ; SCANS "TRANS" FOR NON-TRACKING REPORTS
 I '$D(^ZAA02GSCMD5) S A="" F  S A=$O(^ZAA02GSCMD("ST",A)) Q:A=""  M ^ZAA02GSCMD5("ST",A,"PARAM")=^ZAA02GSCMD("ST",A,"PARAM")
 S ZAA02GSCR="^ZAA02GSCR",ZAA02GSCMD="^ZAA02GSCMD5",ZAA02GSCM="^ZAA02GSCMD5(""ST"",TSU)"
 S DIR="TRANS",ZAA02G=1,(USER,TRANS)="MG" D DATE^ZAA02GSCRER
 S DOC="" F  S DOC=$O(^ZAA02GSCR("TRANS",DOC),-1) Q:DOC=""  D
 . S B=$P($G(^(DOC,.011)),"`",1,4) I B["mammo"!(B[".bre")!(B["mam.")!(B["stere")!(B["G020") I '$D(^(.011,"BIRADS")) D SCAN1 Q
 Q
SCAN1 W !,DOC," ",B," "
 Q
 S NMAM="ABN;TSB;RCN",TSU="M"
 I B["sono" S TSU="U",NMAM="ABN;RCN"
 I B["mr" S TSU="R",NMAM="ABN;RCN"
 I B["stere" S TSU="T",NMAM="ABN;RCN"
 D FETCH^ZAA02GSCRER
 R "Normal-(Y/Q/N)-",NO Q:NO="Q"
 I NO'="Y" D
 . S C="" I $D(^ZAA02GSCR("TRANS",DOC,.0115,5)) F J=5:1 Q:'$D(^(J))  S C=C_^(J)
 . S:C["\pard" C=$P(C,"\pard",2,99)
 . E  S J=.03 F  S J=$O(^ZAA02GSCR("TRANS",DOC,J)) Q:J=""  S C=C_" "_$P(^(J),$C(1),4)
 . W C,! R "NMAM-",NO I NO'="" S NMAM=NO
 S PREMIER="SCAN3^ZAA02GSCMIN" D PREMIER^ZAA02GSCMR
 I $D(^ZAA02GSCR("TRANS",DOC,.011,"BIRADS")) S B=^("BIRADS") K ^("BIRADS") S ^ZAA02GSCMD("SCAN",DOC)=$H_","_B
 Q
 ;
SCAN3 S:MAMMO'[NMAM MAMMO=MAMMO_";"_NMAM Q
 ;
MAMMO ; ADD MAMMO FLAG TO ALL ZAA02GSCRIPT REPORTS WITH THE WORD MAMMO
 S A=.9 F J=1:1 S A=$O(@ZAA02GSCR@(106,0,A)) Q:A=""  I A["mammo",$D(@ZAA02GSCR@(106,A,.03)) S $P(^(.03),"\",20)="Y" W "."
 Q
 ;
SETUP S ZAA02GSCMD="^ZAA02GSCMD",ZAA02GSCM="@ZAA02GSCMD@(""ST"",TSU)",ZAA02GSCR="^ZAA02GSCR",ZAA02GSCRP=";;2",TSU="M" Q
REBUILD ; REBUILDS STATS, XREFS, AND LETTERS MODULES FROM EXAM RECORDS
 S REBUILD=9 G RB0
REBUILDL S REBUILD=1 ; REBUILD ALL LETTERS ALSO
RB0 D:'$D(ZAA02GSCM) SETUP S TRANS=0,TSU="" K DELETE,MRCHECK
 S tsu="" F  S (TSU,tsu)=$O(@ZAA02GSCM) Q:tsu=""  D RB2
 S tsu="" F  S (TSU,tsu)=$O(@ZAA02GSCM) Q:tsu=""  S (DT,DOC)="",TS=TSU F  S TSU=tsu,DOC=$O(@ZAA02GSCM@("EXAM",DOC),-1) Q:DOC=""  D RB1
 Q
RB1 K INP I '$D(@ZAA02GSCR@("TRANS",DOC)) K @ZAA02GSCM@("EXAM",DOC) Q
 I '$D(@ZAA02GSCR@("TRANS",DOC,.011))    ; archived?
 I  S yy=@ZAA02GSCM@("EXAM",DOC),INP("MR")=$P(yy,";"),(INP("ADMDR"),INP("CONSULT"))=$P(yy,";",3),INP("PROVIDER")=$P(yy,";",4),INP("SITEC")=$P(yy,";",5),yy=19000000+$P(yy,";",2),INP("DS")=$E(yy,5,6)_"/"_$E(yy,7,8)_"/"_$E(yy,3,4)
 E  D
 . D FETCH^ZAA02GSCRER S yy=$G(@ZAA02GSCR@("TRANS",DOC,.011)) Q:yy=""
 . S TS="" F T="TEMPLATE","TEMPLATE2" I $G(INP(T))]"",$P($G(@ZAA02GSCR@(106,INP(T),.0113)),"\",20)]"" S TS=TS_$TR($P(^(.0113),"\",20),"YN","M")
 . I TS'[TSU,TS]"" W !,"  template doesn't match EXAM ",TSU," should be ",TS,!
 . I TS]"",$D(@ZAA02GSCR@("TRANS",DOC,.011,"TRACK")) I $G(^("TRACK"))'=TS S ^("TRACK")=TS
 I $G(INP("MR"))="" Q
 D M1^ZAA02GSCMR
 W:1 @ZAA02GSCM@("EXAM",DOC),! ; I +^(DOC)=123 R CCC
 Q
RB2 K @ZAA02GSCM@("STATS"),^("XP") K:1 ^("DIR") K:REBUILD'=9 ^("LETMR"),^("LETTYP")
 Q
 ;
ZAA02GSCMO ; CLEANUP ^ZAA02GSCMO AFTER FULL COPY
 F J=1:1 S A=$P("STATS,XP,EXAM,TEXAM,DIR,LETHIST,LETMR,LETTYP,XDIR",",",J) Q:A=""  K ^ZAA02GSCMO(A)
 K ^ZAA02GSCMO(106,0),^ZAA02GSCMO("DICT",0),^(2),^(3) Q
 ;
BR ;SEARCH ^BR FOR WORDS
 R "Enter word(s) to search for - ",A,! Q:A=""  S (B,C)="",A=$ZU(A) F  S B=$O(^BR(B)) Q:B=""  F  S C=$O(^BR(B,C)) Q:C=""  I $ZU(^(C))[A W B,?5,C,?10,^(C),! R CCC
 W !! G BR
 ;
TECH ; BUILD TECH STATS
 S TSU="" F  S TSU=$O(^ZAA02GSCMD("ST",TSU)) Q:TSU=""  I $D(^ZAA02GSCMD("ST",TSU,"EXAM")) S ZAA02GSCM=$NA(^ZAA02GSCMD("ST",TSU)) D TECH3
 Q
 ;
TECH3 S A="" F  S A=$O(@ZAA02GSCM@("STATS",A)) Q:A=""  K ^(A,"NA","TECH")
 S DOC="" D UP F  S DOC=$O(@ZAA02GSCM@("EXAM",DOC)) Q:DOC=""  D
 . S R=^(DOC),K=$P(R,";"),T=$P($P(R,"OBT,",2),";"),DT=$P(R,";",2),DM=DT#100,YR=DT\100+190000,K1=$P(K,"/",2),K=+K S:K1="" K1=1
 . I T="",$G(^ZAA02GSCR("TRANS",DOC,.011,"FDY"))["W1" S W=^("FDY"),WK=$G(^WRKFLW(1,$P(W,"|",3),K,K1,$P(W,"|",4))) I WK]"" S T=$P($P(WK,"`",14),"  ") I T]"" D
 .. I @ZAA02GSCM@("EXAM",DOC)'["OBT," S ^(DOC)=^(DOC)_";OBT,"_T
 . W "." S:T="" T="NA" D TECH1
 Q
TECH1 S T=$TR(T,LC,UP),A=$P(R,";",5,99),AG=+$P(R,"AGE,",2),AG=$S(AG<1:"NA",1:AG\10)
 F J=1:1:$L(A,";") S B=$E($P(A,";",J),1,3) I B]"" D TECH2
 S B="EXAMS" D TECH2 Q
TECH2 S $P(^(AG),"+",DM)=$P($G(@ZAA02GSCM@("STATS",YR,"NA","TECH",T,B,AG)),"+",DM)+1
 Q
 ;
DIR ; REBUILD DIR SECTION OF ^ZAA02GSCMD
 S DOC="" F  S DOC=$O(@ZAA02GSCM@("EXAM",DOC)) Q:DOC=""  S REC=^(DOC) F J=1:1:5 S W=$P("MR,DST,REF,PROV,SITEC",",",J),T2=$P(REC,";",J) S:T2]"" @ZAA02GSCM@("DIR",W,T2,$P(REC,";",2),DOC)=""
 Q
STEVE S DOC="" F  S DOC=$O(^ZAA02GSCMD("EXAM",DOC)) Q:DOC=""  S REC=^(DOC) D
 . I '$D(^ZAA02GSCR("TRANS",DOC)) K ^ZAA02GSCMD("EXAM",DOC) Q
 . S TR=^(DOC,.011)
 Q
 ;
COPY ; COPIES TEST SYSTEM OVER - COMBINES ZAA02GSCR & ZAA02GSCMD
 S (A,B)="" F  S A=$O(@ZAA02GSCM@("EXAM",A)) Q:A=""  D COP1 Q:B=""
 Q
COP1 S B=1 I $D(^ZAA02GSCR6("TRANS",A)) Q
 F  S B=$O(^ZAA02GSCR6("TRANS",B)) Q:B=""  Q:'$D(@ZAA02GSCM@("EXAM",B))
 Q:B=""  S @ZAA02GSCM@("EXAM",B)=@ZAA02GSCM@("EXAM",A) K ^(A) W A,">",B,"  "
 Q
 ;
CLEAN ; CLEANUP LETTERS BEFORE A CERTAIN DATE
 R "DATE-(YYMMDD)-",DT,! S (T,M)=""
 F  S T=$O(@ZAA02GSCM@("LETTYP",T)) Q:T=""  W !,"LETTER - ",T R C I C="Y" D
 . S A="" F  S A=$O(@ZAA02GSCM@("LETTYP",T,A)) Q:A=""  Q:A'<DT  F  S M=$O(@ZAA02GSCM@("LETTYP",T,A,M)) Q:M=""  K ^(M),@ZAA02GSCM@("LETMR",M,A,T) W "."
 Q
RESCH ; RESCHEDULE LETTERS FOR A NEW TIME PERIOD
 R "Letter Type -",T,!,"Number of days - ",DY,!
 S (A,M)="",T="T"_T
 F  S A=$O(@ZAA02GSCM@("LETTYP",T,A)) Q:A=""  F  S M=$O(@ZAA02GSCM@("LETTYP",T,A,M)) Q:M=""  S DT=$$DJ(A),DT2=$$DJ(+^(M)) W DT-DT2," " I DT-DT2'=DY D
 . W "." S R=^(M) K ^(M) S DT=$$DT(DT2+DY),@ZAA02GSCM@("LETTYP",T,DT,M)=R,B=@ZAA02GSCM@("LETMR",M,+R,T,A) K ^(A) S ^(DT)=B
 Q
REQUEUE ; REQUEUE LETTERS FOR A PARTICULAR DAY
 R "Tracking - ",TS,!,"Letter Type - (ALL) ",TY,!,"Julian Date to Requeue - ",DT,!
 S (A,M)="",TY="T"_TY,G="^ZAA02GSCMD(""ST"","""_TS_""",""LETHIST"")",G1=G
 S ZAA02GSCM="^ZAA02GSCMD(""ST"","""_TS_""")",ZAA02GSCR="^ZAA02GSCR"
 F  S G=$Q(@G) Q:G'["LETHIST"  I +$P(@G,",",2)=DT D
 . S T=$QS(G,6) I TY'="T",TY'=T Q
 . S Y=$QS(G,7),MR=$QS(G,4),QD=$QS(G,5),DOC=$P(@G,","),SC=$P($G(^ZAA02GSCMD("ST",TS,"EXAM",DOC)),";",3)
 . I '$D(^ZAA02GSCMD("ST",TS,"LETMR",MR,QD)) S TSU=TS,DST=QD,MAMMO=$G(@ZAA02GSCM@("EXAM",DOC)) Q:MAMMO=""  D LINE^ZAA02GSCMR
 . S ^ZAA02GSCMD("ST",TS,"LETMR",MR,QD,T,Y)=DOC_","_(+$H)_"RC"
 . S ^ZAA02GSCMD("ST",TS,"LETTYP",T,Y,MR)=QD_","_DOC_","_SC
 . W "." K @G
 Q
DT(D) S k=D>21608+305+D,Y=4*k+3\1461,d=k*4+3-(1461*Y)+4\4,m=5*d-3\153,d=5*d-3-(153*m)+5\5,m=m+2,Y=m\12+Y-60,m=m#12+1,Y=Y*100+m*100+d K d,m,k Q Y
DJ(T) S y=T\10000,m=T#10000\100-3,d=T#100 G JULIAN1
JULIAN S m=+T-3,d=$P(T,"/",2),y=$P(T,"/",3) I (m+d+y)<-2 S T="" Q
JULIAN1 S:y<200 y=y+1900 S o=$S(y<1900:-14917,1:21608),y=y>1999*100+$E(y,3,4) S:m<0 m=m+12,y=y-1 S T=1461*y\4,T=153*m+2\5+T+d+o K m,y,o,d Q T
 ;
RESTORE ; RESTORE DOC # ON LETHIST
 S (A,B,C,D)=""
 F  S A=$O(@ZAA02GSCM@("EXAM",A)) Q:A=""  S DT=$P(^(A),";",2),MR=$P(^(A),";") I MR]"",DT]"" F  S B=$O(@ZAA02GSCM@("LETHIST",MR,DT,B)) Q:B=""  F  S C=$O(@ZAA02GSCM@("LETHIST",MR,DT,B,C)) Q:C=""  I ^(C)<1 S $P(^(C),",")=A W "."
 Q
 ; to be finished
FIXAB S (A,B,C,D)=""
 I '$D(ZAA02GSCM) S ZAA02GSCM="^ZAA02GSCMD(""ST"",""M"")"
 F  S A=$O(@ZAA02GSCM@("EXAM",A),-1) Q:A=""  I $G(^(A))[";AB;"+1 D
 . ; S ^(A)=$P(^(A),";AB;")_";"_$P(^(A),";AB;",2,9)
 . S DT=$P(^(A),";",2),MR=$P(^(A),";"),E=$E($P(^(A),";AB",2)) I MR]"",DT]"" S B=$G(@ZAA02GSCM@("LETMR",MR,DT)) Q:B=""  I $P(B,"`",9)=";" W B,! S $P(B,"`",9)=E W B,! S ^(DT)=B
 Q
FIXU S (TSU,A,B,C,D)=""
 F  S TSU=$O(^ZAA02GSCMD("ST",TSU)) Q:TSU=""  S ZAA02GSCM="^ZAA02GSCMD(""ST"",TSU)" D
 . F  S A=$O(@ZAA02GSCM@("EXAM",A)) Q:A=""  D
 .. S E=^(A),B=$P($G(^ZAA02GSCR("TRANS",A,.0113),$G(^ZAA02GSCR("TRANS",A,.03))),"\",20) I B'=TSU D
 ... W !,A," ",B,?20 Q:B=""
 ... I $D(^ZAA02GSCMD("ST",B,"EXAM",A)) W "ALREADY DEFINED" Q
 ... S $P(E,":",6)=B,^ZAA02GSCMD("ST",B,"EXAM",A)=E K @ZAA02GSCM@("EXAM",A) R CCC
 Q
 ;
RCLASS ; REBUILD CLASS STATS
 K (ZAA02GSCM,ZAA02GSCR,ZAA02GSCRP) D DATE^ZAA02GSCRER D UP
 S PARAM=$G(@ZAA02GSCM@("PARAM","INPUT"))
 S DOC="" F  S DOC=$O(@ZAA02GSCM@("EXAM",DOC)) Q:DOC=""  D RCLASS1:$P(^(DOC),";",8)]""
 Q
UP S UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ",LC="abcdefghijklmnopqrstuvwxyz" Q
RCLASS1 S OREC=^(DOC) Q:'$D(@ZAA02GSCR@("TRANS",DOC))  D FETCH^ZAA02GSCRER
 S (OMAMMO,MAMMO)=$P(OREC,";",9,99),(ODST,DST)=$P(OREC,";",2),DM=DST#100,YR=DST\100 S:YR<9000 YR=YR+10000 S YR=YR+190000
 S AG=$P(MAMMO,";AGE,",2),AG=$S(+AG=0:"NA",1:AG\10) D CLASS^ZAA02GSCMR
 S $P(@ZAA02GSCM@("EXAM",DOC),";",8)=$P(NREC,";",8)
 Q
 ;
RCF ; REMOVE RCF CODE > 11 MONTHS
 S A="" F  S A=$O(@ZAA02GSCM@("EXAM",A)) Q:A=""  I ^(A)["RCF" S B=^(A) I $P(B,"RCF,",2)>11 S C=$L($P(B,"RCF"),";"),$P(B,";",C,C+1)=$P(B,";",C+1) W B,! S ^(A)=B
 Q
 ;
C99 ; CLEANUP FOLLOW-UP LIST & LETTERS WITH BIOPSY RESULTS ENTERED
 K D S D("T99")="",D="" F  S D=$O(@ZAA02GSCM@("PARAM","LETTERS",D)) Q:D=""  I $P($P(^(D),"\",4),"/",2)["FA" S D("T"_D)=""
 S A="" F  S A=$O(@ZAA02GSCM@("EXAM",A)) Q:A=""  I ^(A)[";FA" W A,?10,^(A),! S MR=$P(^(A),";") D C999
 Q
C999 S B=MR,(C,E,D)="" F  S D=$O(D(D)) Q:D=""  F  S C=$O(@ZAA02GSCM@("LETMR",MR,C)) Q:C=""  F  S E=$O(@ZAA02GSCM@("LETMR",B,C,D,E)) Q:E=""  K @ZAA02GSCM@("LETTYP",D,E,B) W D," ",B,"   "
 Q
COTH ; CLEANUP PARTICULAR LETTERS BASED UPON CODE CONDITIONS
 S TYPE="T9"
 S (C,D)="" F  S C=$O(@ZAA02GSCM@("LETTYP",TYPE,C))  Q:C=""  F  S D=$O(@ZAA02GSCM@("LETTYP",TYPE,C,D)) Q:D=""  S F=^(D),A=$P(F,",",2) I $G(@ZAA02GSCM@("EXAM",A))["RC",$G(^(A))["AB" W ^(A),! D COTH9
 Q
COTH9 W @ZAA02GSCM@("LETTYP",TYPE,C,D),@ZAA02GSCM@("LETMR",D,+F,TYPE,C) Q
 ;
COMB ; COMBINE STEREO PATH RESULTS WITH MAMMO
 S (A,B,C)="" F  S A=$O(@ZAA02GSCM@("EXAM",A)) Q:A=""  S R=^(A),MR=$P(R,";"),R=$P(R,";",9,99) I R[";FA",R'[";TSS",R'["TSB" I MR'="" D
 . W !,"MR=",MR,! F  S B=$O(@ZAA02GSCM@("DIR","MR",MR,B)) Q:B=""  F  S C=$O(@ZAA02GSCM@("DIR","MR",MR,B,C)) Q:C=""  I C'=A,$G(@ZAA02GSCM@("EXAM",C))'[";FA" W !,R,!,^(C),! I ^(C)["TSB"!(^(C)["TSS") D  W ^(C),!
 . . S E=$P($P(R,";FA",2),";") S ^(C)=^(C)_";FA"_E
 . . I R[";L" F K=2:1:$L(R,";L") S E=$P($P(R,";L",K),";") S ^(C)=^(C)_";L"_E
 Q
 ;
COMBPATH ; RESOLVE PATH RESULTS TO THE APPROPRIATE
 S BIO=$G(@ZAA02GSCM@("PARAM","BIOPSY CODES")) D
 . S EX=" " F A=1:1:$L(BIO,",") S B=$P(BIO,",",A) I B]"" S EX="!(E["";"_B_""")"_EX
 S EX="I "_$E(EX,2,9999)
 S (A,B,C)="" F  S A=$O(@ZAA02GSCM@("EXAM",A),-1) Q:A=""  S R=^(A),MR=$P(R,";"),E=$P(R,";",9,99) X EX I  S MR=$P(R,";") I E'[";FA",MR'="" D
 . F  S B=$O(@ZAA02GSCM@("DIR","MR",MR,B),-1) Q:B=""  F  S C=$O(@ZAA02GSCM@("DIR","MR",MR,B,C)) Q:C=""  I C'=A S D=$P($G(@ZAA02GSCM@("EXAM",C)),";",9,99) I D[";FA" D
 .. S T=$P(R,";",2) D JULIANX^ZAA02GSCMR S DT=T S T=$P(^(C),";",2) D JULIANX^ZAA02GSCMR S DT=DT-T I DT>300!(DT<-300) Q
 .. W !,DT,!,R,!,^(C),! S CC="Y" I DT>90!(DT<-90) R CC#1 I CC="Y"
 .. Q:CC'="Y"
 .. S M=";FA"_$P($P(D,";FA",2),";") F L=2:1:$L(D,";L") S M=M_";L"_$P($P(D,";L",L),";")
 .. S MAMMO=R_M,M=0 I MAMMO'[";ABA" X $G(@ZAA02GSCM@("PARAM","STATS CLASSC")) S M=1+M+$E("-366000",$F("BHMRLD",$E($P(MAMMO,";FA",2))))
 .. S $P(MAMMO,";",8)="TY"_M,@ZAA02GSCM@("EXAM",A)=MAMMO,C=9999999,B=1
 .. W MAMMO,!!
 Q
 ;
SEARCH ; SEARCH EXAM RECORDS FOR CERTAIN DATA FIELDS
 K A S (A,B)="" F  R "Search for-",A,! Q:A=""  S A(A)=""
 S C=$O(A("")) F  S A=$O(@ZAA02GSCM@("EXAM",A)) Q:A=""  I ^(A)[C S R=^(A) D
 . F  S B=$O(A(B)) I B=""
 Q
 ;
PREMIER ; CONVERT DATABASE TO PREMIER MULTI-LEVEL FORMAT
 D:'$D(ZAA02GSCM) SETUP I $D(@ZAA02GSCM@("PARAM")) W "Already converted" Q
 W !,"Please wait - this may take a while..." H 1
 F I="DIR","PARAM","LETTYP","LETMR","LETHIST","STATS","XP" W I,"..." H 1 M @ZAA02GSCMD@("ST","M",I)=@ZAA02GSCMD@(I) K @ZAA02GSCMD@(I)
 S @ZAA02GSCMD@("ST","M")="Mammography" D DICT,VBSYS
 W "STATT..."
 S A="STATT" F  S A=$O(@ZAA02GSCMD@(A)) Q:A'["STATT"  D
 . S E=$P(A,"STATT",2),@ZAA02GSCMD@("ST",E)=$$STUDY^ZAA02GSCM(E)
 . M @ZAA02GSCMD@("ST",E,"STATS")=@ZAA02GSCMD@(A) K @ZAA02GSCMD@(A) M:E'="M" @ZAA02GSCMD@("ST",E,"PARAM")=@ZAA02GSCMD@("ST","M","PARAM")
 W "EXAMS..."
 S I="" F  S I=$O(@ZAA02GSCMD@("EXAM",I)) Q:I=""  S R=^(I) I $P(R,";",5,99)[";TS" S E=$E($P($P(R,";",5,99),";TS",2)) I E]"" D
 . S E=$TR(E,"RLBSAP","MMMMMM") K ^(I) S @ZAA02GSCMD@("ST",E,"EXAM",I)=R
 . I E'="M",$D(@ZAA02GSCR@("TRANS",I,.03)) S $P(^(.03),"\",20)=E
MP W "TEMPLATES..."
 S A=.9 F  S A=$O(@ZAA02GSCR@(106,A)) Q:A=""  S:$P($G(@ZAA02GSCR@(106,A,.03)),"\",20)="Y" $P(^(.03),"\",20)="M" S:$P($G(@ZAA02GSCR@(106,A,.03)),"\",20)="N" $P(^(.03),"\",20)=""
 Q
 ; FIX INCORRECT TRACKING FROM INTERFACE
FIXINT S A="" F  S A=$O(^ZAA02GSCMD("ST","M","EXAM",A),-1) Q:A=""  S R=^(A) I $D(^ZAA02GSCR("TRANS",A,.03)) S C=$P(^(.03),"\",20) I C]"",C'="M",C'="Y",$G(^(.011,"TRACK"))]"",^("TRACK")'=C D
 . S D=$P(R,";",2),MR=$P(R,";")
 . W MR," ",D," ",^("TRACK")," ",C," ",!,R,! S $P(R,";",6)=C W R,!
 . S ^ZAA02GSCR("TRANS",A,.011,"TRACK")=C,^ZAA02GSCMD("ST",C,"EXAM",A)=R K ^ZAA02GSCMD("ST","M","EXAM",A) S ^ZAA02GSCMD("FIXINT",A)=R
 . S L="" F  S L=$O(^ZAA02GSCMD("ST","M","LETMR",MR,D,L)) Q:L=""  S SD=$O(^(L,"")) S ^ZAA02GSCMD("ST",C,"LETTYP",L,SD,MR)=^ZAA02GSCMD("ST","M","LETTYP",L,SD,MR),$P(^(MR),",",4)=C K ^ZAA02GSCMD("ST","M","LETTYP",L,SD,MR)
 . F TY="LETMR","LETHIST" M ^ZAA02GSCMD("ST",C,TY,MR,D)=^ZAA02GSCMD("ST","M",TY,MR,D) K ^ZAA02GSCMD("ST","M",TY,MR,D)
 .
 Q
 ;
 ; FIX INCORRECT STUDY CODES IN OLD REPORTS
FIX2 S E="" F  S E=$O(^ZAA02GSCMD("ST",E)) Q:E=""  I E'="M" S A="" F  S A=$O(^ZAA02GSCMD("ST",E,"EXAM",A)) Q:A=""  D
 . I $D(^ZAA02GSCR("TRANS",A,.03)),$P(^(.03),"\",20)'=E S $P(^(.03),"\",20)=E W E,"."
 Q
DICT I $D(^SCRIPT(0,"ZAA02GSCMD","DICT")) M ^ZAA02GSCMD("DICT")=^SCRIPT(0,"DICT") D DIR^ZAA02GSCMD
 Q
 ;
START D SETUP I $D(^ZAA02GSCMD) W "setup aborted" Q
 I $D(^SCRIPT(0,"ZAA02GSCMD")) D  Q
 .  M ^ZAA02GSCMD=^SCRIPT(0,"ZAA02GSCMD") D DIR^ZAA02GSCMD
 . D VBSYS
 . W " setup completed - now create letters and setup letter parameters" Q
 W "^SCRIPT global missing - setup aborted" Q
 ;
VBSYS S R="" F J=1:1:12 I $G(^ZAA02GVBSYS("CODE","FIELDS","TRACKING-M2",J))["Tech:1:" S R=$E($P(^(J),"Tech:1:",2)) Q
 W "OPTIONS:",!,"1. Tech Required (Y/N)-(Currently is ",$S(R="Y":"Required",R="N":"Not Required",1:"Not Defined"),")-" R P(1),!
 F J=1:1 S A=$P($T(VBSYSD+J),";",2,99) Q:A=""  S B=$P(A,";"),C=$P(A,";",2),D=$P(A,";",3) D
 . I A["*" D FILL
 . I C'="LIST" S:'D ^ZAA02GVBSYS("CODE",C,B)=$TR($P(A,";",4,99),"`",$C(230)) S:D ^ZAA02GVBSYS("CODE",C,B,+D)=$S(D["+":^ZAA02GVBSYS("CODE",C,B,+D),1:"")_$TR($P(A,";",4,99),"`",$C(230))
 . I C="LIST" S ^ZAA02GSCR("CODE",C,B)=$TR($P(A,";",4,99),"`",$C(230))
 D DENSE
 I $D(^ZAA02GSCMDD) D
 . I $G(^ZAA02GSCMDD)>$G(^ZAA02GSCMD("DICT")) K ^ZAA02GSCMD("DICT") M ^ZAA02GSCMD("DICT")=^ZAA02GSCMDD
 W "Done",!
 Q
 ;
FILL S A=$P(A,"*")_$TR($G(P(+$P(A,"*",2))),"&","-")_$E($P(A,"*",2,99),$L(+$P(A,"*",2))+1,99999)
 G:A["*" FILL Q
 ;
VBSYSD ;
 ;TRACKING-M1;LIST;;TRACKING-M1`0`&Code`&Description`1
 ;TRACKING-M1;FIELDS;;General:6|
 ;TRACKING-M1;FIELDS;1;Study^Choose Type of Study|Bilateral Dx:B`Left Dx:L`Right Dx:R`Screening:S`Addn Views:A`Followup:F`Outside Films:O||``Y`N^^``N`N||1
 ;TRACKING-M1;FIELDS;2;Category^Choose one of the categories|1-Neg:1`2-Benign:2`3-Prob Benign:3`4-Susp:4`5-Malig:5`6-Known Malig:6`0-Incomplete:0`M-Marker Plcmnt:M||``Y`N^^``Y`N||2
 ;TRACKING-M1;FIELDS;3;Recommendations^Choose normal or select|Normal:N`Select:S||`N^4`Y`N^^``N`N||3
 ;TRACKING-M1;FIELDS;4;||Sono:20:N:::::"^"`MRI:20:N:::::"^"`Biopsy:20:N:::::"^"`Surg Eval:20:N:::::"^"`Addnt Studies:20:N:::::"^"`Prior Films:20:N:::::"^"`Flup (Month):4:N:1:2:::|``Y`N^^``N`N||4
 ;TRACKING-M1;FIELDS;5;Other^This one is optional||Tech:1:*1:1:5::TE:"^"`Problem Indicated:1:N:1:15:::"^"`Called MD:1:N:1:20:::"^"`Reviewed outside films:1:N:1:15:::|``Y`N^^``N`N||5
 ;TRACKING-M1;FIELDS;6;Breast Composition|Fatty:F`Scattered:S`Heterogeneous:H`Extreme:E||``Y`N^^``N`N||6
 ;TRACKING-M2;LIST;;TRACKING-M2`0`&Code`&Description`1
 ;TRACKING-M2;FIELDS;;General:8|
 ;TRACKING-M2;FIELDS;1;Reason^Choose one of the categories|Screening:S`Diagnostic:D`Followup:F`Additional:A||``Y`N^^``N`N||1
 ;TRACKING-M2;FIELDS;2;Study^Choose Bilateral, Left or Right|Bilateral:B`Left DX:L`Right DX:R`Screening:N`Sono:S`MRI:M`Stereotactic:T`U/S Core:C||``Y`N^^``Y`N||2
 ;TRACKING-M2;FIELDS;3;BIRADS^Choose one of the categories|1-Neg:1`2-Benign:2`3-Prob Benign:3`4-Suspicious:4`5-Prob Malignant:5`6-Known Malignancy:6`0-Incomplete:0`M-Marker Plcmnt:M||``Y`N^^``N`N||3
 ;TRACKING-M2;FIELDS;4;Recommendations^Choose normal or select|Normal:N`Select:S||`N^5:6`Y`N^^``N`N||4
 ;TRACKING-M2;FIELDS;5;||Sono:20:N:::::"^"`MRI:20:N:::::"^"`Stereotactic:20:N:::::"^"`U/S Aspiration Biopsy:20:N:::::"^"`U/S Core Biopsy:20:N:::::"^"`Surgical Biopsy:20:N:::::|``Y`N^^``N`N||5
 ;TRACKING-M2;FIELDS;6;||Surg Eval:20:N:::::"^"`Clinical Corr:20:N:::::"^"`Addnt Study:20:N:::::"^"`Prior Films:20:N:::::"^"`Flup (Mo):4:N:1:2:::|``Y`N^^``N`N||6
 ;TRACKING-M2;FIELDS;7;Other^This one is optional||Tech:1:*1:1:5::TE:"^"`Problem Indicated:1:N:1:15:::"^"`Called MD:1:N:1:20:::"^"`Reviewed outside films:1:N:1:15:::|``Y`N^^``N`N||7
 ;TRACKING-M2;FIELDS;8;Breast Composition|Fatty:F`Scattered:S`Heterogeneous:H`Extreme:E||``Y`N^^``N`N||8
 ;TRACKING-M4;LIST;;TRACKING-M4`0`&Code`&Description`1
 ;TRACKING-M4;FIELDS;;General:8|
 ;TRACKING-M4;FIELDS;1;Study^Choose one of the categories|Screening:S`Bilateral DX:B`Left DX:L`Right DX:R`Ultrasound:U||``Y`N^^``N`N||1
 ;TRACKING-M4;FIELDS;2;BIRADS^Choose one of the categories|1-Neg:1`2-Benign:2`3-Prob Benign:3`4-Suspicious:4`5-Prob Malignant:5`6-Known Malignancy:6`0-Incomplete:0`M-Marker Plcmnt:M||``Y`N^^``Y`N||2
 ;TRACKING-M4;FIELDS;3;Recommendations^Choose normal or select|Normal:N`Select:S||`N^4:5:6`Y`N^^``N`N||3
 ;TRACKING-M4;FIELDS;4;||Flup (Mo):4:N:1:2:::"^"`Sono:20:N:::::"^"`MRI:20:N:::::"^"`Mammo:20:N:::::"^"`Prior Films:20:N:::::|``Y`N^^``N`N||4
 ;TRACKING-M4;FIELDS;5;||Stereotactic:20:N:::::"^"`U/S Aspiration Biopsy:20:N:::::"^"`U/S Core Biopsy:20:N:::::"^"`Surgical Biopsy:20:N:::::"^"`MRI Biopsy:20:N:::::|``Y`N^^``N`N||5
 ;TRACKING-M4;FIELDS;6;||Surg Eval:20:N:::::"^"`Clinical Corr:20:N:::::"^"`Addnt Views:20:N:::::|``Y`N^^``N`N||6
 ;TRACKING-M4;FIELDS;7;Other^This one is optional||Tech:1:*1:1:5::TE:"^"`Problem Indicated:1:N:1:15:::"^"`Called MD:1:N:1:20:::"^"`Reviewed outside films:1:N:1:15:::|``Y`N^^``N`N||7
 ;TRACKING-M4;FIELDS;8;Breast Composition|Fatty:F`Scattered:S`Heterogeneous:H`Extreme:E||``Y`N^^``Y`N||8
 ;TRACKING-M5;LIST;;TRACKING-M5`0`&Code`&Description`1
 ;TRACKING-M5;FIELDS;;General:6|
 ;TRACKING-M5;FIELDS;1;Study^Choose Type of Study|Bilateral Dx:B`Left Dx:L`Right Dx:R`Screening:S`Addn Views:A`Followup:F`Outside Films:O||``Y`N^^``N`N||1
 ;TRACKING-M5;FIELDS;2;Category^Choose one of the categories|1-Neg:1`2-Benign:2`3-Prob Benign:3`4-Susp:4`5-Malig:5`6-Known Malig:6`0-Incomplete:0`M-Marker Plcmnt:M||``Y`N^^``Y`N||2
 ;TRACKING-M5;FIELDS;3;Recommendations^Choose normal or select|Normal:N`Select:S||`N^4`Y`N^^``N`N||3
 ;TRACKING-M5;FIELDS;4;||Sono:20:N:::::"^"`MRI:20:N:::::"^"`Biopsy:20:N:::::"^"`PEM:20:N:::::"^"`PET/CT:20:N:::::"^"`CT:20:N:::::"^"`Addnt Studies:20:N:::::"^"`Flup (Month):4:N:1:2:::|``Y`N^^``N`N||4
 ;TRACKING-M5;FIELDS;5;Other^This one is optional||Tech:1:*1:1:5::TE:"^"`Problem Indicated:1:N:1:15:::"^"`Called MD:1:N:1:20:::"^"`Reviewed outside films:1:N:1:15:::|``Y`N^^``N`N||5
 ;TRACKING-M5;FIELDS;6;Breast Composition|Fatty:F`Scattered:S`Heterogeneous:H`Extreme:E||``Y`N^^``Y`N||6
 ;TRACKING-U1;LIST;;TRACKING-U1`0`&Code`&Description`1
 ;TRACKING-U1;FIELDS;;General:3|
 ;TRACKING-U1;FIELDS;1;Category^Choose one of the categories|1-Neg:1`2-Benign:2`3-Prob Benign:3`4-Susp:4`5-Malig:5`6-Known Malig:6`0-Incomplete:0||``Y`N^^``Y`N||1
 ;TRACKING-U1;FIELDS;2;Link^Original Mammogram||Mammogram Document #:1:N:1:10:::"^"|``Y`N^^``N`N||2
 ;TRACKING-U1;FIELDS;3;Other^This one is optional||Tech:1:*1:1:5::TE:"^"`Called MD:1:N:1:20:::"^"|``Y`N^^``N`N||3
 ;TRACKING-U2;LIST;;TRACKING-U2`0`&Code`&Description`1
 ;TRACKING-U2;FIELDS;;General:5|
 ;TRACKING-U2;FIELDS;1;Study^Choose Bilateral, Left or Right|Bilateral:B`Left:L`Right:R||``Y`N^^``N`N||1
 ;TRACKING-U2;FIELDS;2;Category^Choose one of the categories|1-Neg:1`2-Benign:2`3-Prob Benign:3`4-Susp:4`5-Malig:5`6-Known Malig:6`0-Incomplete:0||``Y`N^^``Y`N||2
 ;TRACKING-U2;FIELDS;3;Recommendations^Choose normal or select|Normal:N`Select:S||`N^4`Y`N^^``N`N||3
 ;TRACKING-U2;FIELDS;4;||Sono:20:N:::::"^"`MRI:20:N:::::"^"`Biopsy:20:N:::::"^"`PEM:20:N:::::"^"`PET/CT:20:N:::::"^"`CT:20:N:::::"^"`Addnt Studies:20:N:::::"^"`Flup (Month):4:N:1:2:::|``Y`N^^``N`N||4
 ;TRACKING-U2;FIELDS;5;Other^This one is optional||Tech:1:*1:1:5::TE:"^Y`Problem Indicated:1:N:1:15:::"^"`Called MD:1:N:1:20:::"^"`Reviewed outside films:1:N:1:15:::|``Y`N^^``N`N||5
 ;TRACKING-R2;LIST;;TRACKING-R2`0`&Code`&Description`1
 ;TRACKING-R2;FIELDS;;General:5|
 ;TRACKING-R2;FIELDS;1;Study^Choose Bilateral, Left or Right|Bilateral:B`Left:L`Right:R||``Y`N^^``N`N||1
 ;TRACKING-R2;FIELDS;2;Category^Choose one of the categories|1-Neg:1`2-Benign:2`3-Prob Benign:3`4-Susp:4`5-Malig:5`6-Known Malig:6`0-Incomplete:0||``Y`N^^``Y`N||2
 ;TRACKING-R2;FIELDS;3;Recommendations^Choose normal or select|Normal:N`Select:S||`N^4`Y`N^^``N`N||3
 ;TRACKING-R2;FIELDS;4;||Sono:20:N:::::"^"`MRI:20:N:::::"^"`Biopsy:20:N:::::"^"`PEM:20:N:::::"^"`PET/CT:20:N:::::"^"`CT:20:N:::::"^"`Addnt Studies:20:N:::::"^"`Flup (Month):4:N:1:2:::|``Y`N^^``N`N||4
 ;TRACKING-R2;FIELDS;5;Other^This one is optional||Tech:1:*1:1:5::TE:"^"`Problem Indicated:1:N:1:15:::"^"`Called MD:1:N:1:20:::"^"`Reviewed outside films:1:N:1:15:::|``Y`N^^``N`N||5
 ;TRACKING-R4;LIST;;TRACKING-R4`0`&Code`&Description`1
 ;TRACKING-R4;FIELDS;;General:6|
 ;TRACKING-R4;FIELDS;1;BIRADS^Choose one of the categories|1-Neg:1`2-Benign:2`3-Prob Benign:3`4-Suspicious:4`5-Prob Malignant:5`6-Known Malignancy:6`0-Incomplete:0`M-Marker Plcmnt:M||``Y`N^^``Y`N||1
 ;TRACKING-R4;FIELDS;2;Recommendations^Choose normal or select|Normal:N`Select:S||`N^3:4:5`Y`N^^``N`N||2
 ;TRACKING-R4;FIELDS;3;||Flup (Mo):4:N:1:2:::"^"`Sono:20:N:::::"^"`MRI:20:N:::::"^"`Mammo:20:N:::::"^"`Prior Films:20:N:::::|``Y`N^^``N`N||3
 ;TRACKING-R4;FIELDS;4;||Stereotactic:20:N:::::"^"`U/S Aspiration Biopsy:20:N:::::"^"`U/S Core Biopsy:20:N:::::"^"`Surgical Biopsy:20:N:::::|``Y`N^^``N`N||4
 ;TRACKING-R4;FIELDS;5;||Surg Eval:20:N:::::"^"`Clinical Corr:20:N:::::"^"`MRI Biopsy:20:N:::::|``Y`N^^``N`N||5
 ;TRACKING-R4;FIELDS;6;Other^This one is optional||Tech:1:*1:1:5::TE:"^"`Problem Indicated:1:N:1:15:::"^"`Called MD:1:N:1:20:::"^"`Reviewed outside films:1:N:1:15:::|``Y`N^^``N`N||6
 ;TRACKING-P4;LIST;;TRACKING-P4`0`&Code`&Description`1
 ;TRACKING-P4;FIELDS;;General:3|
 ;TRACKING-P4;FIELDS;1;Procedure|Aspiration:A`Core Biopsy:C`Stereotactic:S`MRI Biopsy:M`Ductogram:D||``Y`N^^``N`N||1
 ;TRACKING-P4;FIELDS;2;Recommendations^Choose normal or select|Routine Followup:N`Select:S||`N^3`Y`N^^``N`N||2
 ;TRACKING-P4;FIELDS;3;||Flup (Mo):4:N:1:2:::"^"`Sono:20:N:::::"^"`MRI:20:N:::::"^"`Mammo:20:N:::::"^"`Path Pending:20:N:::::"^"`Surg Eval:20:N:::::"^"`Clinical Corr:20:N:::::|``Y`N^^``N`N||3
 ;TRACKING-P5;LIST;;TRACKING-P5`0`&Code`&Description`1
 ;TRACKING-P5;FIELDS;;General:2|
 ;TRACKING-P5;FIELDS;2;Recommendations^Choose normal or select|Routine Followup:N`Select:S||`N^2`Y`N^^``N`N||1
 ;TRACKING-P5;FIELDS;3;||Flup (Mo):4:N:1:2:::"^"`Sono:20:N:::::"^"`MRI:20:N:::::"^"`Mammo:20:N:::::"^"`Surg Eval:20:N:::::"^"|``Y`N^^``N`N||2
 ;
 ;
DENSE D INITLC^ZAA02GVBW S P1="SYS",P2="MDENSE",B="" F J=1:1:3 S B=B_$P($T(DENSEDT+J),";",2,99)
 I '$D(^ZAA02GWP(105,"sys","mdense")) D MACROF2^ZAA02GVBTER2
 Q
 ;
 ;
DENSEDT ;
 ;Your mammogram shows that your breast tissue is dense. Dense breast tissue is very common and is not abnormal.  However, dense breast tissue can make it harder to find cancer on a mammogram and may also
 ; be associated with an increased risk of breast cancer.  This information about the result of your mammogram is given to you to raise your awareness.  Use this information to talk to your doctor
 ; about your own risks for breast cancer.  At that time, ask your doctor if more screening tests might be useful, based on your risk.  A report of your results was sent to your physician.
