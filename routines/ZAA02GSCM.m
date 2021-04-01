ZAA02GSCM ;PG&A,ZAA02G-MTS,1.20,MAMMOGRAPHY MENU;2FEB94 3:40P;25FEB2003  21:17;;Mon, 08 DeC 2008  14:27
C ;Copyright (C) 1995, Patterson, Gray & Associates, Inc.
BEG I $D(ZAA02G("ECHO-ON"))+$D(XX)<2 D ^ZAA02GSCMPW Q:'$D(TRANS)
 S:'$D(TEST)=99*0 A=^ZAA02G("ERROR")_"=""^ZAA02GSCMEC""",@A D ENTRY
EXIT S A=^ZAA02G("ERROR")_"=""""",@A K FX,XF,XSL,VA,L,DIR,XX,NE,J,N,DOC,HP,ZAA02GWPD,X,Y,TR,A,C,I,P,TC,TRANS,INP,A W ZAA02G("F") X ^ZAA02G("TERM-OFF"),^ZAA02G("WRAP-ON") Q
ENTRY D HEAD D:'$D(ZAA02GSCM) DATABASE D TC Q:TSU<0
T0 L
 S Y="Patient Records\Enter Pathology Results\Letters\Follow-up List\Reports\Utilities\Quit\;PELFRUQ;"_TSL_"  T R A C K I N G   S Y S T E M"
 S (TC,%C,J)=30,TR=9,HP=102 D SEL G:J'<NE ENTRY D @$P("T9\BIO^ZAA02GSCMR1\TB1\TB2\T3\T4","\",J) G T0
 ;
T1 S Y="Provider\Referral\Site\Technologist\Grand Total\Quit\;PRSTGQ;S T A T I S T I C S"
 S TC=30,TR=9,HP=2 K TYPS D SEL I J'<NE K BEG,END Q
 S TYPS=J D T2 G T1
 ;
T2 S Y="Interpretation Report\Recommendation Report\Biopsy Report\Detection Report\Examination Reason Report\Overview\Overview2\Overview3\Procedures/Pathology 1\"
 S Y=Y_"Number of Exams\Procedures/Pathology 2\Statistics Dump\Quit\;IRBDEO23PN4SQ;"_TSL_"  S T A T I S T I C S"
 S TC=25,TR=8,HP=2 D SEL Q:J'<NE  D @($P("SUMM\SUMM\SUMM\SUMM\SUMM\SUMM\SUMM\SUMM\SUMM\SUMM\SUMM\DUMP","\",J)_"^ZAA02GSCMST") G T2
 ;
T3 S Y="Follow-up Report\Statistics and QA Reports\Patient Listing\Biopsy Recommendation Report\Mammo Interpretation Summary\Letter Summary Report\ZAA02G-MTS Report Generator\Quit\;FSPBMLTQ;"_TSL_"   R E P O R T S"
 S TC=28,TR=8,HP=2 D SEL Q:J'<NE  D @$P("FLUP^ZAA02GSCMST\T1\PAT^ZAA02GSCMST\BIOP^ZAA02GSCMST\MIS^ZAA02GSCMST\LET^ZAA02GSCMST\^ZAA02GSCMQ1","\",J) G T3
 ;
T4 S Y="Worksheets\Print Options\Mammography Codes Printout\Input Screens\NMD Diskette Creation\Configuration\Quit\;WPMINCQ;U T I L I T I E S"
 S TC=30,TR=9,HP=2 D SEL Q:J'<NE  D @$P("PW^ZAA02GSCMC\T8\DICT^ZAA02GSCMST\T6\NA\T5","\",J) G T4
 ;
T5 S Y="Letter Definition\Automatic Letter Parameters\Configuration Parameters\Dictionary Maintenance\Site Definition\Quit\;LACDSQ;C O N F I G U R A T I O N"
 S TC=30,TR=9,HP=2 D SEL Q:J'<NE  D @$P("^ZAA02GSCMRD\CONF^ZAA02GSCMC\CONF1^ZAA02GSCMC\^ZAA02GSCMMS\^ZAA02GSCMC\","\",J) G T5
 ;
T6 S Y="Patient Information Screen\Exam Worksheet Screen\Biopsy Results Screen\Quit\;PEBQ;I N P U T   S C R E E N S"
 S TC=30,TR=9,HP=2 D SEL K TYPM Q:J'<NE  S TYPM=J D T7 G T6
 ;
T7 S Y="Test Screen\Edit Dictionary Text\Verify Letter Creation\Quit\;TEVQ;"_$P($P($T(T6),"""",2),"\",TYPM)
 S TC=30,TR=9,HP=2 D SEL Q:J'<NE  D @$P("^ZAA02GSCMR1\E^ZAA02GSCMR1\L^ZAA02GSCMR1","\",J) G T7
 ;
T8 S Y="Monitor Print Queue\Delete Print Job\Halt Printer\Start Printer\Batch Control\Redirect Printer\Quit\;MDHSBRQ;P R I N T   O P T I O N S"
 S TC=30,TR=9 D SEL Q:J'<NE  D @$P("^ZAA02GSCRPQ\REMOVE^ZAA02GSCRPR\H^ZAA02GWPPS\S^ZAA02GWPPS\BATCH^ZAA02GSCRPR\REDIR^ZAA02GSCRPR","\",J) G T8
 ;
T9 S Y=$P($G(@ZAA02GSCM@("PARAM","INPUT")),"\",7,8) G:$D(^("NOZAA02GSCR")) TA I Y["S"!(Y["A") S Y=TRTYPE N TRTYPE S TRTYPE=Y,$P(TRTYPE,"\")=-1 G MAMMO^ZAA02GSCRER
 S Y="Completed Records\Incomplete Records\Quit\;CIQ;P A T I E N T   R E C O R D S"
 S TC=30,TR=9,HP=2 D SEL Q:J'<NE  D @$P("COMP^ZAA02GSCMU1\INCOMP^ZAA02GSCMU1","\",J) G T9
 ;
TA S Y="Edit Patient Records\Create Patient Records\Quit\;ECQ;P A T I E N T   R E C O R D S"
 S TC=30,TR=9,HP=2 D SEL Q:J'<NE  D @$P("ED^ZAA02GSCMU1\CR^ZAA02GSCMU1","\",J) G TA
 ;
TBL S %R=3,%C=3 W @ZAA02GP,ZAA02G("CS") S %R=6,%C=30 W @ZAA02GP,"Select Site Codes for ",TITL S %R=7 W @ZAA02GP,"Use Select key for more than one selection"
TB K SC S Y="",(A,B)="" F J=2:1 S A=$O(@ZAA02GSCMD@("SITEC",A)) Q:A=""  S Y=Y_A_$J("",4-$L(A))_","
 I J=3 S SC("All")="" Q
 S Y="30,9\TM1HA\8\\\All,"_Y,Y(0)="\PU,PD,EX"
E D ^ZAA02GPOP Q:X=""  Q:X[";EX"  F J=1:1:$L(X,",") I $P(X,",",J)]"" S SC($P(Y($P(X,",",J))," "))=""
 Q
TB1 S TITL="Letters" D TBL Q:'$D(SC)  D T1^ZAA02GSCML Q
TB2 S TITL="Follow Up" D TBL Q:'$D(SC)  D FLUP^ZAA02GSCML Q
 ;
TC S (Y,B,A,J)="" F  S A=$O(@ZAA02GSCMD@("ST",A)) Q:A=""  S:$D(^(A))#2 Y=Y_^(A)_"\",J=J+1,B=B_$S(J<10:J,1:$C(55+J)),B(J)=A
 S:Y="" Y="Mammography\",B=B_1,B(1)="M"
 S Y=Y_"Quit\;"_B_"Q;T Y P E   O F   T R A C K I N G",YY=Y
 S TSU="",TC=30,TR=9,HP=2 D SEL S TSU=$G(B(J),-1) Q:TSU<0  K YY
 S TS=@ZAA02GSCM,TSL="",YY=$TR(TS,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ") F J=1:1:$L(YY) S TSL=TSL_$E(YY,J)_" "
 K YY Q
 ;         ;
STUDY(X) I X="M" Q "Mammo"
 I X="R" Q "MRI"
 N Y I $D(@ZAA02GSCMD@("DICT",3,"TS"_X)) S Y=$P($G(@ZAA02GSCMD@("DICT",1,101,$P(^("TS"_X),",",2))),"^",2) S:Y]"" X=Y
 Q X
NA S %R=24,%C=1 W @ZAA02GP,"OPTION NOT AVAILABLE",ZAA02G("CL"),*7 H 2 Q
DATABASE S ZAA02GSCMD="^ZAA02GSCMD" I $D(^ZAA02GSCMD("ST","M","PARAM","DATABASE")) S ZAA02GSCMD=^("DATABASE")
 S ZAA02GSCM=ZAA02GSCMD_"(""ST"",TSU)",TSU="M" I '$D(ZAA02GSCR) D DATABASE^ZAA02GSCRPW
 Q
SEL Q:J=99  S %R=1,%C=19 W @ZAA02GP,$J("",50) S %R=3,%C=1 W @ZAA02GP,ZAA02G("CS")
 S %R=5,%C=82-$L($P(Y,";",3))\2 W @ZAA02GP,ZAA02G("HI"),$S(ZAA02G["PC":ZAA02G("UO"),1:""),$P(Y,";",3),ZAA02G("UF")
 S C="  "_ZAA02G("LO"),%R=TR,%C=TC,L=$P(Y,";",2),NE=$L(L) F I=1:1:NE S %R=I+TR W @ZAA02GP,ZAA02G("HI"),$E(L,I),C,$P(Y,"\",I) W:$P(Y,"\",I)="" $P(YY,"\",I)
 S I="",%R=24,%C=7,X="[ Select *option* and press *RETURN*, use *HELP KEY* for on-line help ]"
 W @ZAA02GP,ZAA02G("LO") F J=1:2:$L(X,"*") W $P(X,"*",J),ZAA02G("HI"),$P(X,"*",J+1),ZAA02G("LO")
 I $D(CONFIG) S %R=1,%C=82-$L(CONFIG)\2 W @ZAA02GP,ZAA02G("HI"),CONFIG
 I $O(^ZAA02GWP(.901,""))'="" S (A,C)="" X "F J=1:1 S C=$O(^(C)) Q:C=""""  S A=A_C_"" """ S %R=22,%C=55-$L(A)\2 W @ZAA02GP,ZAA02G("RON")," Printing Suspended on: ",A,ZAA02G("ROF")
 S %C=1,%R=TR+1 W @ZAA02GP,*13
 ;
ASK S J=1,%C=TC-4 X ZAA02G("ECHO-OFF")
A1 S %R=TR+J,X=$P(Y,"\",J) S:X="" X=$P(YY,"\",J) W @ZAA02GP,ZAA02G("HI"),"==> ",$E(L,J),"  ",X,@ZAA02GP,"==> "
A2 R C#1 X ZAA02G("T") S A=ZF I C'="" S:C?1L C=$C($A(C)-32) I L[C D A3 S J=$F(L,C)-1 G A1:ZAA02G("MENU"),DONE
 I A=ZAA02G("UK") D A3 S J=$S(J>1:J-1,1:NE) G A1
 I C=" "!(A=ZAA02G("DK")) D A3 S J=$S(J<NE:J+1,1:1) G A1
 I ZF=$C(13) G DONE
 G:XX'[A A2 S C=$E(XX,$F(XX,A)) I "9E"[C S J=$S(C=9:99,1:NE+1) G DONE
 I C="Y" D HELP^ZAA02GSCRHP G SEL
 G A2
A3 W $C(8,8,8,8),"    ",ZAA02G("HI"),$E(L,J),ZAA02G("LO"),"  ",X Q
DONE K TR,TC,Y,L,X,C,NM X ZAA02G("ECHO-ON") Q
HEAD W ZAA02G("F") S %R=1,%C=2 I $D(ZAA02G("a"))=0 W ZAA02G("LO"),@ZAA02GP,ZAA02G("RON")," P ",ZAA02G("RT")," G ",ZAA02G("RT")," & ",ZAA02G("RT")," A " S %C=70 W @ZAA02GP,"  ZAA02G-MTS  ",ZAA02G("ROF"),!
 E  S A=$P(ZAA02G("a"),"`"),I=$P(ZAA02G("a"),"`",2),%C=18 W @ZAA02GP,I,*13," ",ZAA02G("HI"),A,"P ",I,A,"G ",I,A,"& ",I,A,"A ",I S %C=68 W @ZAA02GP,A,"ZAA02G-MTS ",I,!
 W ZAA02G("G1") S J=ZAA02G("HL"),J=J_J_J_J F I=1:1:20 W J
 W ZAA02G("G0") Q
