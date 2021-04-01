ZAA02GSCMPO ;PG&A,ZAA02G-MTS,1.20,POLICY REVIEW;02NOV94  11:35;;;22NOV2006  11:25
 ;
 ;
POLICY W "Mammo Tracking Policy Report",!!
 D SETUP,REPORTS
 S TSU="" F  S TSU=$O(^ZAA02GSCMD("ST",TSU)) Q:TSU=""  I $D(@ZAA02GSCM@("EXAM")) D
 . W "TRACKING - ",$G(@ZAA02GSCM),!
 . I '$D(@ZAA02GSCM@("PARAM","INPUT")) W ?5,"not setup",! Q
 . S INPUT=^("INPUT"),BIO=$G(^("BIOPSY")),CLA=$G(^("STATS CLASS")),TR=$P(INPUT,"\",12),P1="TRACKING-"_TR
 . K D D TRDATA^ZAA02GVBMAMO,CODES
 . S I="" K CODES F  S I=$O(@ZAA02GSCM@("XP",I)) Q:I=""  S J=$P(I,",") I $E(J)'="L" S:"TY,AG,EX,FA"'[$E(J,1,2) CODES(J)=""
 . S I="" W ?5,"CODES USED-" F  S I=$O(CODES(I)) Q:I=""  W I,","
 . W !?5,"Popup-",TR,!
 . W ?5,"Class-",CLA,! D
 ..
 . W ?5,"Letters:" S I="" F  S I=$O(@ZAA02GSCM@("PARAM","LETTERS",I)) Q:I=""  D
 .. S A=^(I) Q:$E(A)'="Y"  W ?15,"T"_I,?19,$P(A,"\",2),?30,$P(A,"\",3),?35," ",$P(A,"\",4),!
 .. S C=$P(A,"\",4),B=$TR(C,"/",",") F J=1:1:$L(B,",") I $P(B,",",J)?3N,'$D(CODE($P(B,",",J))) W ?40,"** not used-",$P(B,",",J),!
 .. I $P(A,"\",3)>5,$P(C,"/")["RCB",$P(C,"/",2)'["FA" W ?40,"** Biopsy: missing Path code (/FA)",!
 .. I I=99,$P(C,"/",2)'["FA" W ?40,"** FLUP: missing Path code (/FA)",!
 .. I '$D(@ZAA02GSCM@("LETTYP","T"_I)) W ?40,"** Nothing Queued",!
 . W ! R CCC
 Q
 I E'="M" S A="" F  S A=$O(^ZAA02GSCMD("ST",E,"EXAM",A)) Q:A=""  D
 . I $D(^ZAA02GSCR("TRANS",A,.03)),$P(^(.03),"\",20)'=E S $P(^(.03),"\",20)=E W E,"."
 Q
 ;
CODES Q:$G(D)=""
 S D=$TR(D,"^-;",",,,") F I=1:1:$L(D,",") I $P(D,",",I)?2.A S CODE($P(D,",",I))=""
 Q
 ;
REPORTS ; DETERMINE TYPES OF TRACKING FROM THE REPORTS
 K REP
 S A=.9 F J=1:1 S A=$O(@ZAA02GSCR@(106,A)) Q:A=""  I $D(@ZAA02GSCR@(106,A,.03)),$P(^(.03),"\",20)'="" S B=$TR($P(^(.03),"\",20),"YN","M") S:B]"" REP(B)=""
 Q
 ;
SETUP S ZAA02GSCMD="^ZAA02GSCMD",ZAA02GSCM="@ZAA02GSCMD@(""ST"",TSU)",ZAA02GSCR="^ZAA02GSCR",ZAA02GSCRP=";;2" Q
 ;
RESCH ; RESCHEDULE LETTERS FOR A NEW TIME PERIOD
 R "Letter Type -",T,!,"Number of days - ",DY,!
 S (A,M)="",T="T"_T
 F  S A=$O(@ZAA02GSCM@("LETTYP",T,A)) Q:A=""  F  S M=$O(@ZAA02GSCM@("LETTYP",T,A,M)) Q:M=""  S DT=$$DJ(A),DT2=$$DJ(+^(M)) W DT-DT2," " I DT-DT2'=DY D
 . W "." S R=^(M) K ^(M) S DT=$$DT(DT2+DY),@ZAA02GSCM@("LETTYP",T,DT,M)=R,B=@ZAA02GSCM@("LETMR",M,+R,T,A) K ^(A) S ^(DT)=B
 Q
REQUEUE ; REQUEUE LETTERS FOR A PARTICULAR DAY
 R "Tracking - ",TS,!,"Letter Type - (ALL) ",TY,!,"Julian Date to Requeue - ",DT,!
 S (A,M)="",TY="T"_TY,G="^ZAA02GSCMD(""ST"","""_TS_""",""LETHIST"")",G1=G
 F  S G=$Q(@G) Q:G'["LETHIST"  I +$P(@G,",",2)=DT D
 . S T=$QS(G,6) I TY'="T",TY'=T Q
 . S Y=$QS(G,7),MR=$QS(G,4),QD=$QS(G,5),DOC=$P(@G,","),SC=$P($G(^ZAA02GSCMD("ST",TS,"EXAM",DOC)),";",3)
 . S ^ZAA02GSCMD("ST",TS,"LETMR",MR,QD,T,Y)=DOC_","_(+$H)_"RC"
 . S ^ZAA02GSCMD("ST",TS,"LETTYP",T,Y,MR)=QD_","_DOC_","_SC
 . W "." K @G
 Q
DT(D) S k=D>21608+305+D,Y=4*k+3\1461,d=k*4+3-(1461*Y)+4\4,m=5*d-3\153,d=5*d-3-(153*m)+5\5,m=m+2,Y=m\12+Y-60,m=m#12+1,Y=Y*100+m*100+d K d,m,k Q Y
DJ(T) S y=T\10000,m=T#10000\100-3,d=T#100 G JULIAN1
JULIAN S m=+T-3,d=$P(T,"/",2),y=$P(T,"/",3) I (m+d+y)<-2 S T="" Q
JULIAN1 S:y<200 y=y+1900 S o=$S(y<1900:-14917,1:21608),y=y>1999*100+$E(y,3,4) S:m<0 m=m+12,y=y-1 S T=1461*y\4,T=153*m+2\5+T+d+o K m,y,o,d Q T
 ;
 ;
SEARCH ; SEARCH EXAM RECORDS FOR CERTAIN DATA FIELDS
 K A S (A,B)="" F  R "Search for-",A,! Q:A=""  S A(A)=""
 S C=$O(A("")) F  S A=$O(@ZAA02GSCM@("EXAM",A)) Q:A=""  I ^(A)[C S R=^(A) D
 . F  S B=$O(A(B)) I B=""
 Q
 ;
 ;
 ; FIX INCORRECT STUDY CODES IN OLD REPORTS
FIX2 S E="" F  S E=$O(^ZAA02GSCMD("ST",E)) Q:E=""  I E'="M" S A="" F  S A=$O(^ZAA02GSCMD("ST",E,"EXAM",A)) Q:A=""  D
 . I $D(^ZAA02GSCR("TRANS",A,.03)),$P(^(.03),"\",20)'=E S $P(^(.03),"\",20)=E W E,"."
 Q
 ;
START D SETUP I $D(^ZAA02GSCMD) W "setup aborted" Q
 I $D(^SCRIPT(0,"ZAA02GSCMD")) D  Q
 .  M ^ZAA02GSCMD=^SCRIPT(0,"ZAA02GSCMD") D DIR^ZAA02GSCMD
 . D VBSYS
 . W " setup completed - now create letters and setup letter parameters" Q
 W "^SCRIPT global missing - setup aborted" Q
 ;
VBSYS F J=1:1 S A=$P($T(VBSYSD+J),";",2,99) Q:A=""  S B=$P(A,";"),C=$P(A,";",2),D=$P(A,";",3) D
 . I C'="LIST" S:'D ^ZAA02GVBSYS("CODE",C,B)=$TR($P(A,";",4,99),"`",$C(230)) S:D ^ZAA02GVBSYS("CODE",C,B,+D)=$S(D["+":^ZAA02GVBSYS("CODE",C,B,+D),1:"")_$TR($P(A,";",4,99),"`",$C(230))
 . I C="LIST" S ^ZAA02GSCR("CODE",C,B)=$TR($P(A,";",4,99),"`",$C(230))
 Q
 ;
VBSYSD ;
 ;TRACKING-M1;LIST;;TRACKING-M1`0`&Code`&Discription`1
 ;TRACKING-M1;FIELDS;;General:5|
 ;TRACKING-M1;FIELDS;1;Study^Choose Type of Study|Bilateral Dx:B`Left Dx:L`Right Dx:R`Screening:S`Addn Views:A`Followup:F`Outside Films:O||``Y`N^^``N`N||1
 ;TRACKING-M1;FIELDS;2;Category^Choose one of the categories|1-Neg:1`2-Benign:2`3-Prob Benign:3`4-Susp:4`5-Malig:5`6-Known Malig:6`0-Incomplete:0||``Y`N^^``Y`N||2
 ;TRACKING-M1;FIELDS;3;Recommendations^Choose normal or select|Normal:N`Select:S||`N^4`Y`N^^``N`N||3
 ;TRACKING-M1;FIELDS;4;||Sono:20:N:::::"^"`MRI:20:N:::::"^"`Biopsy:20:N:::::"^"`Surg Eval:20:N:::::"^"`Addnt Studies:20:N:::::"^"`Prior Films:20:N:::::"^"`Flup (Month):4:N:1:2:::|``Y`N^^``N`N||4
 ;TRACKING-M1;FIELDS;5;Other^This one is optional||Tech:1:Y:1:5::TE:"^"`Problem Indicated:1:N:1:15:::"^"`Called MD:1:N:1:20:::"^"`Reviewed outside films:1:N:1:15:::|``Y`N^^``N`N||5
 ;TRACKING-M2;LIST;;TRACKING-M2`0`&Code`&Discription`1
 ;TRACKING-M2;FIELDS;;General:6|
 ;TRACKING-M2;FIELDS;1;Reason^Choose one of the categories|Screening:S`Diagnostic:D`Followup:F||``Y`N^^``N`N||1
 ;TRACKING-M2;FIELDS;2;Study^Choose Bilateral, Left or Right|Bilateral:B`Left Mammo:L`Right Mammo:R`Sono:S`MRI:M`Stereotactic:T`U/S Aspiration:A`U/S Core:C||``Y`N^^``N`N||2
 ;TRACKING-M2;FIELDS;3;BIRADS^Choose one of the categories|1-Neg:1`2-Benign:2`3-Prob Benign:3`4-Suspicious:4`5-Prob Malignant:5`6-Known Malignancy:6`0-Incomplete:0||``Y`N^^``Y`N||3
 ;TRACKING-M2;FIELDS;4;Recommendations^Choose normal or select|Normal:N`Select:S||`N^4`Y`N^^``N`N||4
 ;TRACKING-M2;FIELDS;5;||Sono:20:N:::::"^"`MRI:20:N:::::"^"`Stereotactic:20:N:::::"^"`U/S Aspiration Biopsy:20:N:::::"^"`U/S Core Biopsy:20:N:::::"^"`Surgical Biopsy:20:N:::::"^"
 ;TRACKING-M2;FIELDS;5+;`Surg Eval:20:N:::::"^"`Addnt Studies:20:N:::::"^"`Prior Films:20:N:::::"^"`Flup (Month):4:N:1:2:::|``Y`N^^``N`N||5
 ;TRACKING-M2;FIELDS;6;Other^This one is optional||Tech:1:Y:1:5::TE:"^"`Problem Indicated:1:N:1:15:::"^"`Called MD:1:N:1:20:::"^"`Reviewed outside films:1:N:1:15:::|``Y`N^^``N`N||6
 ;TRACKING-U1;LIST;;TRACKING-U1`0`&Code`&Discription`1
 ;TRACKING-U1;FIELDS;;General:3|
 ;TRACKING-U1;FIELDS;1;Category^Choose one of the categories|1-Neg:1`2-Benign:2`3-Prob Benign:3`4-Susp:4`5-Malig:5`6-Known Malig:6`0-Incomplete:0||``Y`N^^``Y`N||1
 ;TRACKING-U1;FIELDS;2;Link^Original Mammogram||Mammogram Document #:1:N:1:10:::"^"|``Y`N^^``N`N||2
 ;TRACKING-U1;FIELDS;3;Other^This one is optional||Tech:1:N:1:5::TE:"^"`Called MD:1:N:1:20:::"^"|``Y`N^^``N`N||3
 ;TRACKING-U2;LIST;;TRACKING-U2`0`&Code`&Discription`1
 ;TRACKING-U2;FIELDS;;General:5|
 ;TRACKING-U2;FIELDS;1;Study^Choose Bilateral, Left or Right|Bilateral:B`Left:L`Right:R||``Y`N^^``N`N||1
 ;TRACKING-U2;FIELDS;2;Category^Choose one of the categories|1-Neg:1`2-Benign:2`3-Prob Benign:3`4-Susp:4`5-Malig:5`6-Known Malig:6`0-Incomplete:0||``Y`N^^``Y`N||2
 ;TRACKING-U2;FIELDS;3;Recommendations^Choose normal or select|Normal:N`Select:S||`N^4`Y`N^^``N`N||3
 ;TRACKING-U2;FIELDS;4;||Sono:20:N:::::"^"`MRI:20:N:::::"^"`Biopsy:20:N:::::"^"`Surg Eval:20:N:::::"^"`Addnt Studies:20:N:::::"^"`Prior Films:20:N:::::"^"`Flup (Month):4:N:1:2:::|``Y`N^^``N`N||4
 ;TRACKING-U2;FIELDS;5;Other^This one is optional||Tech:1:Y:1:5::TE:"^Y`Problem Indicated:1:N:1:15:::"^"`Called MD:1:N:1:20:::"^"`Reviewed outside films:1:N:1:15:::|``Y`N^^``N`N||5
 ;TRACKING-R2;LIST;;TRACKING-R2`0`&Code`&Discription`1
 ;TRACKING-R2;FIELDS;;General:5|
 ;TRACKING-R2;FIELDS;1;Study^Choose Bilateral, Left or Right|Bilateral:B`Left:L`Right:R||``Y`N^^``N`N||1
 ;TRACKING-R2;FIELDS;2;Category^Choose one of the categories|1-Neg:1`2-Benign:2`3-Prob Benign:3`4-Susp:4`5-Malig:5`6-Known Malig:6`0-Incomplete:0||``Y`N^^``Y`N||2
 ;TRACKING-R2;FIELDS;3;Recommendations^Choose normal or select|Normal:N`Select:S||`N^4`Y`N^^``N`N||3
 ;TRACKING-R2;FIELDS;4;||Sono:20:N:::::"^"`MRI:20:N:::::"^"`Biopsy:20:N:::::"^"`Surg Eval:20:N:::::"^"`Addnt Studies:20:N:::::"^"`Prior Films:20:N:::::"^"`Flup (Month):4:N:1:2:::|``Y`N^^``N`N||4
 ;TRACKING-R2;FIELDS;5;Other^This one is optional||Tech:1:Y:1:5::TE:"^"`Problem Indicated:1:N:1:15:::"^"`Called MD:1:N:1:20:::"^"`Reviewed outside films:1:N:1:15:::|``Y`N^^``N`N||5
