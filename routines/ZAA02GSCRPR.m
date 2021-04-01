ZAA02GSCRPR ;PG&A,ZAA02G-SCRIPT,2.10,SELECT A DOCUMENT IN PRINT QUEUE;21NOV94 8:03A;;;30SEP2002  10:35
 ;Copyright (C) 1984, Patterson, Gray & Associates, Inc.
 Q:$O(^ZAA02GWP(.9,""))=""  S %R=3,%C=20 W @ZAA02GP,ZAA02G("HI"),ZAA02G("CS") S %R=1 W @ZAA02GP,$J("",46) S %C=84-$L(Y)\2 W @ZAA02GP,Y
 S Y="2,3\TRHLG1S\1\\Job #     Printer    Batch   Order   Copies   Status     Bin    Time"
 S Y(0)="\EX\\+$P(^(S2),"","""""",2);7`S;9`$P(^(S2),$C(92),11);3`S2;7`$P(^(S2),$C(92),3);4`$P(""Printing,,Error"","","",$P(^(S2),$C(92),9));10`$P(^(S2),$C(92),6);1`$P(^(S2),$C(92),8);8"
 S ZAA02GPOPALT=$P($T(ALTPOP),";",2,99)
 D ^ZAA02GPOP S DOC=$S(X[";EX":"",1:X) Q
ALTPOP ;S S=$P(TO,""|""),S2=$P(TO,""|"",2) F jj=1:1 S:S2="""" S=$O(^ZAA02GWP(.9,S)) S:S="""" TO="""" Q:TO=""""  S:$L(S) S2=$O(^ZAA02GWP(.9,S,S2)) I $L(S2) S TO=S_""|""_S2 Q
 ;
EXIT K DAT,CN,CRT,IA,SEL,SEL1,DES,PWD,DV,PP X ZAA02G("ECHO-ON") Q
 ;
REMOVE S Y="REMOVE JOB FROM PRINT QUEUE" D ZAA02GSCRPR I $G(DOC)'="" K ^ZAA02GWP(.9,$P(DOC,"|"),$P(DOC,"|",2)) S %R=3,%C=1 W @ZAA02GP,ZAA02G("CS"),ZAA02G("HI") S Y=$S('$D(ZAA02G(9)):"Document Removed from Print Queue",1:@ZAA02G(9)@(33)),%C=80-$L(Y)\2,%R=12 W @ZAA02GP,Y," " H 2
 Q
 ;
RESTART D ZAA02GSCRPR G:DOC="" ^ZAA02GWPPM
 S DV=$P(DOC,"|"),B=$P(DOC,"|",2) G:'$D(^ZAA02GWP(.9,DV,B)) ^ZAA02GWPPM S C=^(B) ; I +$P(C,"\",9)'=3 G ^ZAA02GWPPM
 S $P(C,"\",4)=1,$P(C,"\",9)=0,^(B)=C L ZAA02GWP(DV):0 I  S TDV=DV,%R=3,%C=1 W @ZAA02GP,ZAA02G("CS") S %R=8 D START^ZAA02GWPP9
 G ^ZAA02GWPPM
 ;
REPRINT S %R=1,%C=20 W @ZAA02GP,ZAA02G("HI")," R E P R I N T    S I N G L E    P A G E  ",!!,ZAA02G("CS")
 K INP D ALL^ZAA02GSCRTR Q:DOC=""  S %R=22 W @ZAA02GP,ZAA02G("CS")
 S %C=27,X="",CHR="12345677890-ALL," W @ZAA02GP,ZAA02G("LO"),"Reprint Page(s) - ",ZAA02G("HI") S %C=45 X ^ZAA02GREAD Q:X=""  S FPG=X
 S Y=$P(@ZAA02GSCR@("TRANS",DOC),"`",13),Y=$E($TR(Y,"P~ ")_"P~  ",1,4),$P(^(DOC),"`",13)=Y,$P(@ZAA02GSCR@("DIR",99,10000000-DOC),"`",13)=Y
 S PRINT=1 D PR1^ZAA02GSCRER2 K PRINT Q
 ;
REDIR S %R=1,%C=20 W @ZAA02GP,ZAA02G("HI"),"     R E D I R E C T   P R I N T E R     ",!!,ZAA02G("CS")
 I $O(^ZAA02GDEVR(""))'="" S (A,C)="" X "F J=1:1 S C=$O(^(C)) Q:C=""""  S A=A_C_"">""_^(C)_""  """ S %R=4,%C=60-$L(A)\2 W @ZAA02GP,ZAA02G("RON")," Print Redirection: ",A,ZAA02G("ROF")
 D GETY^ZAA02GSCRDV S Y="5,7\RLDVHY\3\Select Printer to Redirect\\"
 S Y(0)="\EX" D ^ZAA02GPOP Q:X[";EX"   S DV=X Q:DV=""
 K:0 Y(DV) S Y="45,7\RLDVHY\3\Redirect "_DV_" to Printer\\"
 S Y(0)="\EX" D ^ZAA02GPOP S:X[";EX" X="" G:X="" REDIR
 I DV=X Q:'$D(^ZAA02GDEVR(DV))  K ^ZAA02GDEVR(DV) S:$O(^(""))=""&($G(^ZAA02G("GETPRINTER"))["ZAA02GDEVR") ^ZAA02G("GETPRINTER")=$P(^ZAA02G("GETPRINTER"),"^(VDV) ",2,9) Q
 S %R=6,%C=20 W @ZAA02GP,ZAA02G("CS"),ZAA02G("LO"),"Printer ",ZAA02G("HI"),DV,ZAA02G("LO")," is redirected to printer ",ZAA02G("HI"),X,"  " H 3
 S ^ZAA02GDEVR(DV)=X S:$G(^ZAA02G("GETPRINTER"))'["ZAA02GDEVR" ^ZAA02G("GETPRINTER")="S:$D(^ZAA02GDEVR(VDV)) VDV=^(VDV) "_$G(^ZAA02G("GETPRINTER"))
 Q
BATCH S %R=1,%C=20 W @ZAA02GP,ZAA02G("HI"),"  P R I N T   B A T C H   O P T I O N S  ",!!,ZAA02G("CS")
 K C S (A,B)="",D=1 F J=1:1 S A=$O(^ZAA02GWP(.9,A)) Q:A=""  S C=0 F J=0:0 S B=$O(^ZAA02GWP(.9,A,B)) I B?1.AN1"_".E!(B="") S:C'=$P(B,"_")&(C'=0) C(D)=A_","_C_" - "_$P($G(@ZAA02GSCR@("PARAM","BATCH",C)),"\")_","_J,D=D+1 S:C'=$P(B,"_") J=0,C=$P(B,"_") S J=J+1 Q:B=""
 I $O(C(""))="" W !!!!!?30,"NO BATCHES IN QUEUE" H 3 Q
 W !!?8,"To force a batch to start printing now - Select Batch and",!?8,"Press RETURN.  Press EXIT to return without starting."
 S Y="3,9\RHLG1S\1\\Printer              Batch              Scheduled Start  # Reports"
 S Y(0)="\EX\C\$P(C(TO),"","");9`$P(C(TO),"","",2);25`$G(@ZAA02GSCR@(""PARAM"",""BATCH-STATUS"",$P(C(TO),"",""),$P($P(C(TO),"","",2),"" "")));15`$P(C(TO),"","",3);6"
 D ^ZAA02GPOP I X[";EX" K C Q
 S X=C(X),@ZAA02GSCR@("PARAM","BATCH-START",$P(X,","),$P($P(X,",",2)," "))=$H,@ZAA02GSCR@("PARAM","BATCH-STATUS",$P(X,","),$P($P(X,",",2)," "))="Started"
 K C,A,B,C Q
