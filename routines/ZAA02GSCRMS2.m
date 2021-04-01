ZAA02GSCRMS2 ;PG&A,ZAA02G-SCRIPT,2.10,DOCUMENT XFRS;19FEB96 1:59P;;;30JUL2004  11:34
 ;Copyright (C) 1993, Patterson, Gray & Associates, Inc.
 ;
 ;
 ; CALLED FROM ZAA02GSCRMS1 FOR EACH DOCUMENT TO BE SENT
 ;
 N (ZAA02GSCR,ZAA02GWPD,DOC,DIR,XFR,XDC,DP)
 F J=1:1 Q:XFR=""  S A=$P(XFR,"`"),XFR=$P(XFR,"`",2,9) I A]"" S T=$P(A,",") Q:T'?1A.ANP  D @T Q
 Q
 ;
FAX ;format - FAX,fax #,delay,fax preamble/fax conclusion,fax header 2+/fax footer,cover options,FAXTO
 ; delay can equal HH:MM;HH:MM to set multiple times
 Q:'$D(@ZAA02GSCR@("PARAM","FAX"))  Q:$P(^("FAX"),"\",13)'="Y"
 S ZAA02GWPB=ZAA02GWPD N ZAA02GWPD S ZAA02GWPD=ZAA02GWPB,ROUT="QUEUE^ZAA02GFAXQ",FAXTOF=$P(A,",",2) Q:FAXTOF=""  S DELAY=$P(A,",",3) I DELAY'[":" S DELAY=DELAY+($P($H,",",2)\60)*60\90+($H*1000)
 E  S DELAY=$TR(DELAY,";",",") D DELAY S DELAY=DELAY\90+($H*1000)
 X:$G(@ZAA02GSCR@("PARAM","FAXTOF_LOGIC"))]"" ^("FAXTOF_LOGIC")
 S FAXPARAM="`"_$P(^ZAA02GFAXC("FAX"),"\",3)_"`"_$G(^ZAA02GWP(.9,DP,XDC,"PATIENT"))_"`"_$P(A,",",7)_"`"_$TR(FAXTOF,"FAX","")_"``"_($P(A,",",3)>1*2+1)_"`"_DELAY_"`"_$E($P(A,",",6)_"N")_"```Y`````"_(+$P(DOC,""",""",2))
 S HD=$P(A,",",4),FT=$P(HD,"/",2),HD=$P(HD,"/"),HD1=$P(A,",",5),FT1=$P(HD1,"/",2),HD1=$P(HD1,"/")
 S doc=DOC D CP^ZAA02GSCRFX S DOC=doc k doc
 D SETFAX^ZAA02GSCRFX Q
 ;
 ; PROCESS BATCHES IN PRINT QUEUE
PREBAT S XDC="",XDC(0)=""
PREB1 S XDC=$O(XDC(0,XDC)) I XDC="" K:$O(XDC(0,""))="" XDC,DOC C:'$D(skipopen) VDV S XDC="" H 20 G Q1^ZAA02GWPPC
 S X=$O(^ZAA02GWP(.9,DP,XDC_"_")) I $P(X,"_")'=XDC K XDC(0,XDC) G PREB1
 I '$D(ZAA02GSCR) G:'$D(^ZAA02GWP(.9,DP,X,"ZAA02GSCR")) PREB1 S ZAA02GSCR=^("ZAA02GSCR")
 I $D(@ZAA02GSCR@("PARAM","BATCH-START",DP,XDC)) K ^(XDC) G PREB2
 D:'$D(XDC(1,XDC)) PREB3 G:'$D(XDC(1,XDC)) PREB1 X XDC(1,XDC) G:'$T PREB1
PREB2 I $P($G(@ZAA02GSCR@("PARAM","BATCH",XDC)),"\",5)="Y" S XDC=X D PREBR S XDC=$P(XDC,"_")
 K XDC(0,XDC),XDC(1,XDC),@ZAA02GSCR@("PARAM","BATCH-STATUS",DP,XDC) S XDC(0)=XDC,XDC=XDC_"_" G CONTROL^ZAA02GWPPC
PREB3 S X=$G(@ZAA02GSCR@("PARAM","BATCH",XDC)) I X="" S XDC(1,XDC)="I 1" Q
 I $P(X,"\",3)]"" S XDC(1,XDC)="I $H*86400+$P($H,"","",2)>"_($P(X,"\",3)*60+$P(XDC(0,XDC),",",2)+(XDC(0,XDC)*86400)) G PREB4
 I $P(X,"\",4)="" Q  S XDC(1,XDC)="I 0" Q
 S TM=$P($H,",",2)\60,TM=$E(TM\60+100,2,3)_"."_$E(TM#60+100,2,3)
 F J=1:1:$L($P(X,"\",4),",") I $TR($P($P(X,"\",4),",",J),":",".")>TM S TM=$P($P(X,"\",4),",",J),TM=TM*60+$P(TM,".",2)*60 S XDC(1,XDC)="I $P($H,"","",2)>"_TM Q
PREB4 I $D(XDC(1,XDC)) S TM=$P(XDC(1,XDC),">",2)#86400\60,TM=$E(TM\60+100,2,3)_":"_$E(TM#60+100,2,3),@ZAA02GSCR@("PARAM","BATCH-STATUS",DP,XDC)="START AT "_TM
 Q
PREBR D DATE^ZAA02GSCRER S B(1)=6,B(2)=11,B(3)=.5,B(4)=.9,PG=1,(B,I)="" D DEVSET^ZAA02GWPPC,INIT1^ZAA02GWPPC1 I +DVP=4 S REPORT="BR" D ^ZAA02GSCRST9
 S A=XDC_"_" D PREBH F JJ=1:1 S A=$O(^ZAA02GWP(.9,DP,A)) Q:$P(A,"_")'=XDC  W ?2,$J(JJ,3),?6,$E($G(^(A,"PATIENT")),1,24),?31,$E($G(^("MR")),1,14),?46,$E($G(^("PROVIDER")),1,16),?63,$E($G(^("PROC1")),1,6),?72,$G(^("DOC")),! I JJ#50=0 W # D PREBH
 W # Q
PREBH X:$D(HDRX) HDRX W !?2,DT,?30 W:'$D(REPORT) "PRINTER BATCH REPORT" W ?75,"Page ",PG,!?2,"Batch: ",XDC,?75,TM,!!! S PG=PG+1
 W ?2,"SEQ.",?14,"PATIENT",?36,"MR #",?49,"PROVIDER",?65,"TYPE",?73,"JOB #",!
 W ?2,"--- ------------------------ -------------- ---------------- -------- --------",!! Q
 ;
DELAY N TM S TM=$P($H,",",2)\60,TM=$E(TM\60+100,2,3)_"."_$E(TM#60+100,2,3)
 F J=1:1:$L(DELAY,",") I $TR($P(DELAY,",",J),":",".")>TM S TM=$P(DELAY,",",J),DELAY=TM*60+$P(TM,".",2)*60 Q
 I DELAY[":" S TM=$P(DELAY,","),DELAY=TM*60+$P(TM,".",2)*60+90000
 Q
 ;
 ; FILE PROVIDES PRINT IMAGE TO THE FILE
 ;  NOTE - Only 1 copy per document
 ;
FILE Q:'$D(DOC)  S FTY="PRN" D SETFILE,FILE1 Q:$D(skipopen)  U VDV Q
FILE1 S $ZT="FILEERR^ZAA02GSCRMS2" N RTN,skipopen,VDV,DVP,DVPO S FINE="END"
 D OPEN,START1^ZAA02GWPPC D FEND Q
 ;
FEND C VDV K FINE S FL=.03 Q
SETFILE D P4^ZAA02GSCRMS1 S NDOC=+$P(DOC,""",""",2),FILE=$G(PATH)_NDOC_"."_FTY Q
FILEERR S ^ZAA02GWP(.94,$H)=$ZE_";"_$G(FILE)_";"_$G(VDV) Q
 ;
 ; FILEA PROVIDES ASCII ONLY PRINT IMAGE TO THE FILE
 ;
FILEA Q:'$D(DOC)  S FTY="TXT" D SETFILE,FILEA1 Q:$D(skipopen)  U VDV Q
FILEA1 S $ZT="FILEERR^ZAA02GSCRMS2" N RTN,skipopen,VDV,DVP,DVPO S FINE="END",DVP=0,DVPO=""
 D OPEN D START1^ZAA02GWPPC D FEND Q
 ;
 ; FILEAH PROVIDES ASCII ONLY PRINT IMAGE TO THE FILE
 ;  with PID header
 ;
FILEAH Q:'$D(DOC)  S FTY="TXT" D SETFILE,FILEAH1 Q:$D(skipopen)  U VDV Q
FILEAH1 S $ZT="FILEERR^ZAA02GSCRMS2" N RTN,skipopen,VDV,DVP,DVPO S FINE="END",DVP=0,DVPO=""
 D OPEN
 F J="PATIENT","MR","DOB" W $G(@VDOC@(J)),"|"
 W ! F J=1:1:3 S A=$G(@VDOC@($P("PROVIDER,CONSULT,SITEC",",",J))) W A," ",$P($S(A]"":$G(@("^"_$P("PVG,RFG,PSG",",",J)_"(A)")),1:""),":",2),"|"
 F J="DS","PROC1" W $G(@VDOC@(J)),"|"
 W ! D START1^ZAA02GWPPC D FEND Q
 ;
 ; FILEH PROVIDES HL7 OUTPUT TO A FILE
 ;  with HL7 HEADER
 ;
FILEH Q:'$D(DOC)  S FTY="HL7" D SETFILE,FILEH1 Q:$D(skipopen)  U VDV Q
FILEH1 S $ZT="FILEERR^ZAA02GSCRMS2" N RTN,skipopen,VDV,DVP,DVPO S FINE="END",DVP=0,DVPO=""
 D OPEN
 S SEX=$G(@VDOC@("SEX")) I SEX="" S MR=$G(@VDOC@("MR")) I MR S SEX=$P($G(^PTG(+MR,$S(MR["/":$P(MR,"/",2),1:1))),":",10)
 F J=1:1 S RECD=$P($T(REPDATA+J),";",2,99) Q:RECD=""  S HL7(J)="" F L=1:1:$L(RECD,";") S A=$P(RECD,";",L),B=$P(A,",",3,9),C=$P(A,",",2),A=$P(A,",") S B="B="_$S(B="":"A",$E(B)="$":B,1:"$G(@VDOC@("""_B_"""))"),@B,$P(HL7(J),"|",C)=B
 F J=1:1:J-1 W HL7(J) W:$E(HL7(J),1,3)'="OBX" !
 D REP,FEND
 Q
REPDATA ;
 ;MSH,1;^~\&,2;,4,SITEC;,7,$$DT("DT");,10,NDOC;P,11;2.1,12
 ;PID,1;1,2;,4,MR;,6,$$NAME("PATIENT");,8,$$DT("DOB");,9,SEX
 ;OBR,1;,4,NDOC;,8,$$DT("DD");,9,$$DT("DT");,17,$$REFR("CONSULT");P,26;,33,$$PROV("PROVIDER");,36,TR
 ;OBX,1;5,2;TX,3
 ;
GET(Y) S X=$S($D(@Y):Y,1:$G(@VDOC@(Y))) Q
NAME(X) D GET(X) S:X[", " X=$P(X,", ")_","_$P(X,", ",2,9) Q $TR(X,", ","^^")
PROV(X) D GET(X) S X=$P($G(^PVG(X)),":",2)_"^"_X
 Q X
REFR(X) D GET(X) S X=$P($G(^RFG(X)),":",2)_"^"_X
 Q X
DT(X) D GET(X) I X'["/" Q:$L(X)=8 $E(X,5,6)_"/"_$E(X,7,8)_"/"_$E(X,1,4) Q $E(X,3,4)_"/"_$E(X,5,6)_"/19"_$E(X,1,2)
 Q X
 ;
REP I '$D(XS) S XS=$C(27),XSL=5 I $D(@ZAA02GWPD@(.015)) S ZAA02G=^(.015),XS=$E(^ZAA02G(0,ZAA02G,"UO")),XSL=$L(^("UO"))
 S A=.03 I 1 S D=$O(@ZAA02GWPD@(A)) Q:D=""  I ^(D)[$C(1) F I=1:1 S A=$O(@ZAA02GWPD@(A)) Q:A=""  S B=$P(^(A),$C(1),4) D REPR1 I 1
 E  F I=1:1 S A=$O(@ZAA02GWPD@(A)) Q:A=""  S B=^(A) D REPR1
 Q
REPR1 F L=1:1:$L(B,XS) S B=$P(B,XS)_$E($P(B,XS,2,99),XSL,255)
 W B,"~",! Q
 ;
OPEN S RTN="^ZAA02GWPP3"
 I ^ZAA02G("OS")="M3" S VDV="FILE" O VDV:(FILE:"NW") U VDV Q
 I ^ZAA02G("OS")="M11" S VDV=FILE O VDV:("NW") U VDV Q
 Q
