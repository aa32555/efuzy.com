ZAA02GSCRPQ ;PG&A,ZAA02G-SCRIPT,2.10,PQUEUE;19NOV94 4:24P;;;08APR97  20:20
 ;Copyright (C) 1984, Patterson, Gray & Associates, Inc.
 ;
MQUEUE S %R=3,%C=1 W @ZAA02GP,ZAA02G("CS")
 S Y=$S('$D(ZAA02G(9)):"       P R I N T   Q U E U E   S T A T U S       \Job #\Printer\Batch\Order\Copies\Status\Bin\Time\Queue is empty\Press RETURN to continue",1:@ZAA02G(9)@(34))
 S %R=1,%C=84-$L($P(Y,"\"))\2 W @ZAA02GP,ZAA02G("HI"),$P(Y,"\")
MA I $O(^ZAA02GWP(.9,""))="" S %R=5,%C=80-$L($P(Y,"\",10))\2 W @ZAA02GP,ZAA02G("CS") S %R=10 W @ZAA02GP,$P(Y,"\",10) D MQEND Q
 S %R=3,%C=1
 W @ZAA02GP,ZAA02G("CS"),ZAA02G("LO"),*13,$C(13),?2,$P(Y,"\",2),?16,$P(Y,"\",3),?25,$P(Y,"\",4),?33,$P(Y,"\",5),?41,$P(Y,"\",6),?52,$P(Y,"\",7),?66,$P(Y,"\",8),?73,$P(Y,"\",9),!,"--------------  -------  -----  -------  ------  ---------------  ---  --------",!!
 S A="" W ZAA02G("HI"),$C(13),*13 S %R=5
MD S A=$O(^ZAA02GWP(.9,A)) I A="" D MQEND Q:$T  G MA
 S B="",S=0
MN S B=$O(^ZAA02GWP(.9,A,B)) G:B="" MD S %R=%R+1,C=^(B),S=S+1,D=$P(C,"\"),I=$P(C,"\",2) W:D="" $S(I[",":+$P(I,""",""",2),1:I) I D'="" W D,$E(I,1,5),?5 I $D(^ZAA02GWP(98,D,I)) W $E($P(^(I),"\"),1,10)
 W ?16,A,?27,$P(C,"\",11),?32,$E(B,1,7),?43,$P(C,"\",3),?49 I $P(C,"\",9) W $P("Printing,List Pro,Error,Printing List,Dialing",",",+$P(C,"\",9)) W:$P(C,"\",3)>1 " copy ",$P(C,"\",4)
 E  I $D(^ZAA02GWP(.901,A)) W "SUSPENDED "
 E  I B["_",$D(@ZAA02GSCR@("PARAM","BATCH-STATUS",A,$P(B,"_"))) W ^($P(B,"_"))
 W ?65,$P(C,"\",6),?71,$P(C,"\",8),! I +$P(C,"\",9)=3 W ?20,"ERROR: ",$E($P(C,"\",9),3,60),! S %R=%R+1
 G MN:%R<22 D MQEND G MN
MQEND W ZAA02G("CS") S %R=24,%C=80-$L($P(Y,"\",11))\2 W @ZAA02GP,$P(Y,"\",11)," " R C#1:15 S %R=5 W @ZAA02GP,! Q
 Q
