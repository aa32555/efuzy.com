ZAA02GSCRAT1 ;PG&A,ZAA02G-SCRIPT,2.10,RESTORE OPTIONS;16MAR93 3:52P;;;Wed, 15 Oct 2008  09:58
 ;Copyright (C) 1992, Patterson, Gray & Associates, Inc.
REC ; RESTORE FROM ARCHIVE
 S HD="R E S T O R E   D O C U M E N T",%R=1,%C=20,C=43-$L(HD),C=$J("",C\2)_HD_$J("",C\2) W @ZAA02GP,ZAA02G("HI"),C,!!,ZAA02G("CS")
 S %R=5,%C=21,X="" W @ZAA02GP,"Document #: " S %C=33,FNC="EX" X ^ZAA02GREAD Q:X=""   S DOC=X
 I $D(@ZAA02GSCR@("TRANS",X)) W !!?20,"This document is available - you should be able to access it " G RECE
 I $D(@ZAA02GSCR@("DIR",99,10000000-X))=0 W !!,?20,"Not a VALID Document number" G RECE
 W "  ",$TR($P(^(10000000-X),"`",4,5),"~`","  ")
RECENT D FINDFILE^ZAA02GSCRAT I FILE="" S %R=8,%C=20 W @ZAA02GP,"File not found" G RECE
 W !!!?20,"wait while searching archive file..." W FILE
 S %R=13,%C=19,SC="@ZAA02GP,B" D RESTORE
 U 0 I ER'=0 W "  ","Error encountered during search - EOF or read error" C DV G RECE
RECE S %R=20,%C=38 W @ZAA02GP,"PRESS RETURN" R X G REC
RESTORE S ER=0 D FILESETR^ZAA02GSCRAT E  S ER="CAN'T ACCESS FILE" C:$D(DV) DV Q
 S $ZT="FILEEND^ZAA02GSCRAT1"
 S (N,T)=0,ER=0 U DV R A,A,A F J=1:1 U DV R A X ZC Q:ER  I $E(A,1,4)="****" S B=$E(A,5,13),T=T+1 I B U 0 W:$G(SC)]"" @SC Q:+B=DOC  D QKR:B+100<DOC
 U DV R A S @ZAA02GSCR@("TRANS",DOC)=$P(A,"*",4,99),@ZAA02GSCR@("PARAM","ARCHIVE","RESTORE",DOC)=$H
 F J=1:1 U DV R A X ZC G:ER RECER Q:$E(A,1,2)'="**"  S B=$P(A,"*",3),@("@ZAA02GSCR@(""TRANS"",DOC,"_$S(B?1N:$P(".011,""STATS"";.01;.011;.015;.02;.03",";",B),1:$P(A,"*",3))_")=$P(A,""*"",4,99)")
 S @ZAA02GSCR@("TRANS",DOC,.011,"Restore")=$H
 S @ZAA02GSCR@("TRANS",DOC,10)=A I $D(^(.011)) S $P(^(.011),"`",16)=$P(^(.011),"`",16)_"I"
 F J=20:10 U DV R A X ZC G:ER RECER Q:$E(A,1,4)="****"  S @ZAA02GSCR@("TRANS",DOC,J)=A
 U 0 C DV Q
FILEEND ;
RECER S ER="Error encountered during restore operation" C DV Q
QKR I B+1000<DOC,^ZAA02G("OS")="MSM" U DV:(FILE:"R":500000:1) Q
 I B+100<DOC,^ZAA02G("OS")="MSM" U DV:(FILE:"R":30000:1) Q
 Q
 ;
HIST S Y="10,8\RHLGW200\1\ARCHIVE HISTORY\ From       To        Date     Time        File         ",Y(0)="\EX\\$P(DX,"","");7`$P(DX,"","",2);7`DT;8`T;5`$P(DX,"","",4);20"
 S ZAA02GPOPALT="D HIST1^ZAA02GSCRAT1" D ^ZAA02GPOP Q
HIST1 S TO1=$P(TO,",",2),TO=$P(TO,",") F J=1:1 S:TO1="" TO=$O(@ZAA02GSCR@("PARAM","ARCHIVE","HISTORY",TO)) S:TO>0 TO1=$O(@ZAA02GSCR@("PARAM","ARCHIVE","HISTORY",TO,TO1)) Q:TO_TO1=""  I TO1 S TO=TO_","_TO1,DX=^(TO1) D DATE Q
 Q
DATE N Y S K=TO>21608+305+TO,Y=4*K+3\1461,D=K*4+3-(1461*Y)+4\4,M=5*D-3\153,D=5*D-3-(153*M)+5\5,M=M+2,Y=M\12+Y+140,M=M#12+1,K="/" S:ZAA02G("d") K=M,M=D,D=K,K="." S Y=Y*100+M*100+D,DT=$E(Y,4,5)_K_$E(Y,6,7)_K_$E(Y,2,3) K K,M,D
 S T=$P(TO,",",2)\60,T=$E(T\60+100,2,3)_":"_$E(T#60+100,2,3)  Q
 ;
 ;
ALL D SETUP^ZAA02GWP
