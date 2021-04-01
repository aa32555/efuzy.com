ZAA02GSCRIPT ;PG&A,ZAA02G-SCRIPT,2.10,MAIN MENU;16NOV94  22:07;;;25OCT2000  14:05
C ;Copyright (C) 1991-1996, Patterson, Gray & Associates, Inc.
BEG I $D(ZAA02G("ECHO-ON"))+$D(XX)+$D(TRANS)'=3 D ^ZAA02GSCRPW G:'$D(TRANS) EXIT S:'$D(TEST) A=^ZAA02G("ERROR")_"=""^ZAA02GSCREC""",@A D HOLD
 D HEAD
TITLE L  S Y="Edit Old Transcript\Create New Transcript\Print Options\Line Counts\Word Processing\Incomplete Reports\Reports on HOLD\Other Options\Supervisor Functions\Quit\;ECPLWIROSQ;T R A N S C R I P T I O N   S Y S T E M"
 S (TC,%C)=28,TR=8,HP=102 I TRTYPE<2 S:ZAA02GSCRP'["r" $P(Y,";",2)=$TR($P(Y,";",2),"S") S $P(Y,"\",8,9)=$S(ZAA02GSCRP["r":"Setup\",1:"")_"Quit"
SELECT D SEL I J'<NE K TRANS G EXIT:$D(ZAA02GPWD),BEG
 D @$P("ED^ZAA02GSCRER\^ZAA02GSCRER\T8\IND^ZAA02GSCRST\WP\INC^ZAA02GSCRER\HOLD^ZAA02GSCRER\T6\T1","\",J) G BEG
 ;
EXIT S A=^ZAA02G("ERROR")_"=""""",@A K FX,XF,XSL,VA,L,DIR,XX,NE,J,N,DOC,HP,ZAA02GWPD,X,Y,TR,A,C,I,P,TC,TRANS,INP,A W ZAA02G("F") X ^ZAA02G("TERM-OFF"),^ZAA02G("WRAP-ON") Q
 ;
T1 S Y="Edit Transcripts\Review Transcripts\Communications\Production Reports\Today's Totals\Incentive Pay\Spreadsheets\Mammography Tracking System\Letters Module\Utility Functions\Quit\;ERCPTISMLUQ;S U P E R V I S O R   F U N C T I O N S"
 S TC=30,TR=7 D SEL I J'<NE Q
 D @$P("ALL^ZAA02GSCRER\RV^ZAA02GSCRER\TC\T4\^ZAA02GSCRST3\^ZAA02GSCRNI\CALC\MAMMO\^ZAA02GSCRL\T2\","\",J) G T1
 ;
T2 S Y="Report Templates\System Files\Printer Setup\Configuration\Fax Operations\Archive Operations\Quit\;RSPCFAQ;U T I L I T Y    F U N C T I O N S"
 S TC=30,TR=8 D SEL Q:J'<NE  D @$P("^ZAA02GSCRRD\^ZAA02GSCRMS\^ZAA02GWPPD\T9^ZAA02GSCRMS\TA\T7","\",J) G T2
 ;
T4 S Y="Provider Reports\Site Reports\Report Type Reports\Transcriptionist Reports\Composite Transcriptionists Reports\Departmental Reports\Ad Hoc Reports\Quit\;PSRTCDAQ;P R O D U C T I O N   R E P O R T S"
 S TC=26,TR=8 D SEL Q:J'<NE  D @($P("PROV\SITES\TYP\USER\COMP\TRSITE\AD","\",J)_"^ZAA02GSCRST") G T4
 ;
T6 S Y="Change Work Type:INC^ZAA02GSCRMS\Print Macros:MACROS^ZAA02GSCRMU\List Report Templates:REPORTS^ZAA02GSCRSP\Default Printer:DEF^ZAA02GSCRSP\Select Entity:CONFIG1^ZAA02GSCRPW\Word Processing Keys:WP^ZAA02GSCRMS\Quit\;CPLDSWQ;O T H E R   O P T I O N S"
 I $D(@ZAA02GSCR@("PARAM","OPTIONS")) S Y=^("OPTIONS")
 I $D(^ZAA02GMAIL) D MENU^ZAA02GSCRML
 S YY=Y,TC=30,TR=9 D SEL S Y=YY K YY Q:J'<NE  D @$P($P(Y,"\",J),":",2) Q:'$D(TRANS)  G T6
T7 G:TRTYPE<3 NA S Y="Archive Transcripts\Restore Single Transcript from Archive\List Archive History\Quit\;ARLQ;A R C H I V E   O P E R A T I O N S"
 S TC=26,TR=9 D SEL Q:J'<NE  D @$P("^ZAA02GSCRAT\REC^ZAA02GSCRAT\HIST^ZAA02GSCRAT","\",J) G T7
T8 S Y="Print Transcript\Monitor Print Queue\Delete Print Job\Halt Printer\Start Printer\Choose Single Page Reprint\Batch Control\Redirect Printer\Quit\;PMDHSCBRQ;P R I N T   O P T I O N S"
 S TC=30,TR=9 D SEL Q:J'<NE  D @$P("PRR^ZAA02GSCRER\^ZAA02GSCRPQ\REMOVE^ZAA02GSCRPR\H^ZAA02GWPPS\S^ZAA02GWPPS\REPRINT^ZAA02GSCRPR\BATCH^ZAA02GSCRPR\REDIR^ZAA02GSCRPR","\",J) G T8
TA S Y="ZAA02G-FAX Utility\Fax Parameters\Print Fax Log\Error Printout\Quit\;TFPEQ;F A X   O P E R A T I O N S"
 S TC=30,TR=9 D SEL Q:J'<NE  D @$P("FAXU^ZAA02GSCRFX\FAX^ZAA02GSCRMS\FAX^ZAA02GSCRST\FAXE^ZAA02GSCRST","\",J) G TA
TB S Y="Download Queue\Transcriptionist's Parameters\Communications Parameters\Quit\;UDFCQ;R e m o t e   S e t u p"
 S TC=28,TR=9 D SEL Q:J'<NE  D @$P("^ZAA02GSCRCM\USER^ZAA02GSCRMS\COMM^ZAA02GSCRMS","\",J) G TB
TC S Y="Uploaded Documents\Download Queue\Communications Parameters\Quit\;UDCQ;C O M M U N I C A T I O N S"
 S TC=28,TR=9 D SEL Q:J'<NE  D @$P("^ZAA02GSCRCM\NA\COMM^ZAA02GSCRMS","\",J) G TC
NA S %R=24,%C=1 W @ZAA02GP,"OPTION NOT AVAILABLE",ZAA02G("CL"),*7 H 2 Q
WP S GTF=$P(TRTYPE,"\",3) N (ZAA02G,ZAA02GP,GTF,TRANS) G ^ZAA02GWP
CALC G:'$D(^ZAA02GCALC) NA N (ZAA02G,ZAA02GP) D ^ZAA02GCALC G HEAD
S D S^ZAA02GSCRPW G BEG
MAMMO G:ZAA02GSCRP'["W" NA D ENTRY^ZAA02GSCM,HEAD Q
HOLD Q:'$D(TRANS)  S B=0,A=$O(@ZAA02GSCR@("DIR",12,"H",0)),A="" F  S A=$O(^(A)) Q:A=""  I $G(^(A))=TRANS S B=B+1
 I B S %R=10,%C=22 W @ZAA02GP,"You currently have ",B," document",$s(B>1:"s",1:"")_" on hold",*7 H 1 W *7 H 2
 Q
SEL Q:$G(J)=99  S %R=1,%C=18 W @ZAA02GP,$J("",50) S %R=3,%C=1 W @ZAA02GP,ZAA02G("CS")
 S %R=5,%C=84-$L($P(Y,";",3))\2 W @ZAA02GP,ZAA02G("HI"),$S(ZAA02G["PC":ZAA02G("UO"),1:""),$P(Y,";",3),ZAA02G("UF")
 S C="  "_ZAA02G("LO"),%R=TR,%C=TC,L=$P(Y,";",2),NE=$L(L) F I=1:1:NE S %R=I+TR W @ZAA02GP,ZAA02G("HI"),$E(L,I),C,$P($P(Y,"\",I),":")
 S I="",%R=24,%C=7,X="[ Select *option* and press *RETURN*, use *HELP KEY* for on-line help ]" S:$D(ZAA02G(9)) X=@ZAA02G(9)@(3)
 W @ZAA02GP,ZAA02G("LO") F J=1:2:$L(X,"*") W $P(X,"*",J),ZAA02G("HI"),$P(X,"*",J+1),ZAA02G("LO")
 I $D(CONFIG) S %R=1,%C=82-$L(CONFIG)\2 W @ZAA02GP,ZAA02G("HI"),CONFIG
 I $O(^ZAA02GWP(.901,""))'="" S (A,C)="" X "F J=1:1 S C=$O(^(C)) Q:C=""""  S A=A_C_"" """ S %R=21,%C=55-$L(A)\2 W @ZAA02GP,ZAA02G("RON")," Printing Suspended on: ",A,ZAA02G("ROF")
 I $O(^ZAA02GDEVR(""))'="" S (A,C)="" X "F J=1:1 S C=$O(^(C)) Q:C=""""  S A=A_C_"">""_^(C)_""  """ S %R=23,%C=59-$L(A)\2 W @ZAA02GP,ZAA02G("RON")," Print Redirection: ",A,ZAA02G("ROF")
 I $D(^ZAA02GMAIL) S:$P(TRTYPE,"\",8)]"" ZAA02GID("M")=$P(TRTYPE,"\",8) D ^ZAA02GMANQ I $D(ZAA02GM) S %R=22,%C=+ZAA02GM W @ZAA02GP,$P(ZAA02GM,";",2,9) K ZAA02GM
 S %C=1,%R=TR+1 W @ZAA02GP,*13
 ;
ASK S J=1,%C=TC-4 X ZAA02G("ECHO-OFF")
A1 S %R=TR+J,X=$P($P(Y,"\",J),":") W @ZAA02GP,ZAA02G("HI"),"==> ",$E(L,J),"  ",X,@ZAA02GP,"==> "
A2 R C#1 X ZAA02G("T") S A=ZF I C'="" S:C?1L C=$C($A(C)-32) I L[C D A3 S J=$F(L,C)-1 G A1:ZAA02G("MENU"),DONE
 I A=ZAA02G("UK") D A3 S J=$S(J>1:J-1,1:NE) G A1
 I C=" "!(A=ZAA02G("DK")) D A3 S J=$S(J<NE:J+1,1:1) G A1
 I ZF=$C(13) G DONE
 I C="." S %R=22,%C=1 W @ZAA02GP,"DEVICE: ",$I,"   TYPE: ",ZAA02G
 G:XX'[A A2 S C=$E(XX,$F(XX,A)) I "9E"[C S J=$S(C=9:99,1:NE+1) G DONE
 I C="Y" S HP=2 D HELP^ZAA02GSCRHP G SEL
 G A2
A3 W $C(8,8,8,8),"    ",ZAA02G("HI"),$E(L,J),ZAA02G("LO"),"  ",X Q
DONE K TR,TC,Y,L,X,C,NM X ZAA02G("ECHO-ON") Q
HEAD W ZAA02G("F") S %R=1,%C=2 I $D(ZAA02G("a"))=0 W ZAA02G("LO"),@ZAA02GP,ZAA02G("RON")," P ",ZAA02G("RT")," G ",ZAA02G("RT")," & ",ZAA02G("RT")," A " S %C=67 W @ZAA02GP,"  ZAA02G-SCRIPT  ",ZAA02G("ROF"),!
 E  S A=$P(ZAA02G("a"),"`"),I=$P(ZAA02G("a"),"`",2),%C=18 W @ZAA02GP,I,*13," ",ZAA02G("HI"),A,"P ",I,A,"G ",I,A,"& ",I,A,"A ",I S %C=68 W @ZAA02GP,A,"ZAA02G-SCRIPT ",I,!
 W ZAA02G("G1") S J=ZAA02G("HL"),J=J_J_J_J F I=1:1:20 W J
 W ZAA02G("G0") Q
