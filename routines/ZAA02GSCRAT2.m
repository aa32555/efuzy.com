ZAA02GSCRAT ;PG&A,ZAA02G-SCRIPT,2.10,ARCHIVE OPTIONS;01NOV94  04:06;;;05NOV97  18:16
 ;Copyright (C) 1992, Patterson, Gray & Associates, Inc.
SETUP S HD="A R C H I V E   T R A N S C R I P T S",%R=1,%C=20,C=43-$L(HD),C=$J("",C\2)_HD_$J("",C\2) W @ZAA02GP,ZAA02G("HI"),C,!!,ZAA02G("CS")
 D DATES I ZAA02Gform["C-TIMEOUT" K BEG Q
 Q:'$D(BEG)  S COUNT=99999,NEW=1 D DATE^ZAA02GSCRER S DATE=DT,TIME=TM D PATH S FILE=PATH S:SIZE>0 COUNT=SIZE
 ; S FILE=PATH_"ZAA02GARCH"_$E($S($D(@ZAA02GSCR@("PARAM","ARCHIVE","NEXTFILE")):^("NEXTFILE"),1:1)+100,2,3)
 S B="" F J=1:1 S B=$O(@ZAA02GSCR@("PARAM","ARCHIVE","RESTORE",B)) Q:B=""  K @ZAA02GSCR@("TRANS",B) ; cleanup restored docs
 I BEG]"" S DT=$P(BEG,"/",3)*100+BEG*100+$P(BEG,"/",2),BEG=$O(@ZAA02GSCR@("TRANS","")),END=$S($D(@ZAA02GSCR@("DIR",98,DT)):^(DT),$O(^(DT)):^($O(^(DT))),1:@ZAA02GSCR@("PARAM","NEXT"))
 E  S BEG=$O(@ZAA02GSCR@("TRANS",""))
 S %R=4,%C=20 W @ZAA02GP,*13,ZAA02G("CS"),@ZAA02GP,"Archiving Reports - ",$O(@ZAA02GSCR@("TRANS",""))," to ",END,!!?19,"File(s) Starting with - ",FILE
 W !!?19,"Do you want to continue (Y or N) - " R A#1 S:A?1L A=$C($A(A)-32) G:A'="Y" END S %R=6 W @ZAA02GP,ZAA02G("CS")
 S %R=8,%C=20 W @ZAA02GP,"Please waiting while Archiving......"
 S TYPE="WR2",LASTB="",%R=11,%C=1 D WR G END:ER U 0 S %R=8,%C=56 W @ZAA02GP,"done"
 S %R=10,%C=20 W @ZAA02GP,"Please wait while Verifying Archive File......",ZAA02G("CS") D VERIFY G VERROR:B'=LAST,VERROR:ER
 S %R=10,%C=65 W @ZAA02GP,"done" S @ZAA02GSCR@("PARAM","ARCHIVE","HISTORY",+$H,$P($H,",",2))=BEG_","_END_","_$S($D(TRANS):TRANS,1:"??")_","_FILE
 S @ZAA02GSCR@("PARAM","ARCHIVE","DIR",END+1)=BEG_","_END_","_$S($D(TRANS):TRANS,1:"??")_","_FILE_","_DATE_","_TIME_","_$H_","_COUNT
 S %R=12,%C=20 W @ZAA02GP,ZAA02G("CS"),"Please wait while Purging Archived Records......" S %R=14,%C=30 D WRP
 S %R=12,%C=68 W @ZAA02GP,"done",ZAA02G("CS")
 S %R=15,%C=20 W @ZAA02GP,"Total Transcripts Archived     - ",T,!?19,"Total Number of Bytes Archived - ",N,!!?19,"Archive completed - Press RETURN  " R C#1
END K PATH,FILE,DATE,TIME,B,T,END,DT,D,C,ZC,ER,BEG,HD,DV Q
 ;
NEXT G NEXTR:TYPE'="WR2"
 ;
NEXTW I NEW S FILE=PATH_B_".DOC" D FILESETW Q:ER  D SET Q:ER  S NEW=0,CT=0
 S CT=CT+1 I CT>COUNT U DV W !!,"****",! C DV S NEW=1 G NEXT
 Q
 ;
NEXTR I NEW S FILE=PATH_B_".DOC" D FILESETR Q:ER  R H1,H2,H3 X ZC Q:ER  S NEW=0
 Q
 ;
SET S C=COUNT I C>1 S K=B F C=1:1:COUNT S K=$O(@ZAA02GSCR@("TRANS",K)) Q:K=""  Q:K>END
 U DV W "*****ZAA02G-SCRIPT ARCHIVE*****",!,"*****",DATE,"-",TIME,"-",$H,!,"*****",B,":",K,! X ZC Q
 ;
WR S B="" F J=1:1 S B=$O(@ZAA02GSCR@("TRANS",B)) Q:B=""  Q:B>END  D NEXT G:ER ERROR D @TYPE G:ER ERROR
 U DV W !,"****",!!! C DV U 0 W @ZAA02GP,ZAA02G("CS") Q
WR2 Q:$D(@ZAA02GSCR@("TRANS",B))#2=0  U 0 W:B["00" @ZAA02GP,$TR(^(B),"~`","  ") S LAST=B
 U DV W "****",B,!,"***",@ZAA02GSCR@("TRANS",B),!
 S J=0 F K=1:1 S J=$O(@ZAA02GSCR@("TRANS",B,J)) Q:J=""  Q:J>.03  I $D(^(J))#2,^(J)]"" W "**",J,"*",^(J),!
 S J="" F K=1:1 S J=$O(@ZAA02GSCR@("TRANS",B,.011,J)) Q:J=""  I $D(^(J))#2,^(J)]"" W "**.011,",$S(+J=J:J,1:""""_J_""""),"*",^(J),!
 S C=.03,D=$O(@ZAA02GSCR@("TRANS",B,.03)) Q:D=""  I ^(D)[$C(1) F J=1:1 S C=$O(^(C)) Q:C=""  W $P(^(C),$C(1),4),!
 E  F J=1:1 S C=$O(^(C)) Q:C=""  W ^(C),!
 W ! X ZC Q
 ;
WRP S B="" F J=1:1 S B=$O(@ZAA02GSCR@("TRANS",B)) Q:B=""  Q:B>END  W:B["00" @ZAA02GP,B K:1 @ZAA02GSCR@("TRANS",B)
 Q
 ;
DATES S SCR="ZAA02GSCRIPT",SNL=14,REFRESH="3:22",ZAA02Gform="0;;;N"
 D ^ZAA02GFORM Q
FILESETW I ^ZAA02G("OS")="MSM" S DV=51 O 51::0 G:'$T BUSY O 51:(FILE:"W") S ZC="S ER=$ZC" X ZC Q
 I ^ZAA02G("OS")="DTM" S DV=10 O 10 O 10:(FILE:"W") S ZC="S ER=$ZC" Q
 I ^ZAA02G("OS")="DSM4" S DV=FILE,ZC="S ER=$ZC" O DV Q
 I ^ZAA02G("OS")="M11" S DV=FILE,ZC="S ER=ER" O FILE:("W") Q
 Q
FILESETR I ^ZAA02G("OS")="MSM" S DV=51 O 51::0 G:'$T BUSY O 51:(FILE:"R") S ZC="S ER=$ZC" X ZC Q
 I ^ZAA02G("OS")="DTM" S DV=10 O 10 O 10:(FILE:"R") S ZC="S ER=$ZC" Q
 I ^ZAA02G("OS")="DSM4" S DV=FILE,ZC="S ER=$ZC" O DV Q
 I ^ZAA02G("OS")="M11" S DV=FILE,ZC="S ER=ER",$ZT="M11END^ZAA02GSCRAT" O FILE:("R") Q
 Q
M11END S ER=1 Q
VERIFY S %R=12,%C=38,(N,T)=0 D FILESETR F J=1:1 U DV R A X ZC Q:ER  S N=N+$L(A) I $E(A,1,4)="****" Q:A="****"  S B=$E(A,5,13),T=T+1 I B,B["00" U 0 W @ZAA02GP,B
 U 0 S ER=0 Q
BUSY S MESS="ARCHIVE DEVICE IS BUSY" G FX
ERROR S MESS="ARCHIVE DEVICE ERROR-"_ER G FX
VERROR S MESS="ARCHIVE VERIFY ERROR" G FX
FX S %R=20,%C=20 W @ZAA02GP,MESS," - CHECK SYSTEM AND TRY AGAIN" H 5 I 0
 Q
PATH S PATH=$G(@ZAA02GSCR@("PARAM","ARCHIVE","PATH")) I PATH]"",$E(PATH,$L(PATH))'="\" S PATH=PATH_"\"
 Q
REC G ^ZAA02GSCRAT1
HIST G HIST^ZAA02GSCRAT1
ARCH N (ZAA02G,ZAA02GP,DOC,ZAA02GSCR) D FINDFILE I $L(FILE) D RESTORE^ZAA02GSCRAT1 Q
 S Y="20,10\RLYW300\1\",Y(1)="TRANSCRIPT FILE HAS BEEN ARCHIVED FOR THIS*",Y(2)="RECORD.*",Y(3)="*"
 D FINDFILE I $L(FILE) S Y(4)="     FILE: "_FILE_"    "_$P(FILE,",",5)_"*",Y(5)="*"
 S Y(0)="\EX\\\\PRESS RETURN" D ^ZAA02GPOP S DOC="" Q
 ;
FINDFILE S FILE=$O(@ZAA02GSCR@("PARAM","ARCHIVE","DIR",DOC))
 Q:FILE=""  S FILE=^(FILE) I $P(FILE,",",9)=""!($P(FILE,",",9)>99) S FILE=$P(FILE,",",4) Q
 I ^ZAA02G("OS")="MSM" G FINDMSM
 Q
FINDMSM S F=$P(FILE,",",4),P="" S:F["\" P=$P(F,"\",1,$L(F,"\")-1),F=$P(F,"\",$L(F,"\")) S:F[":" P=$P(F,":")_":",F=$P(F,":",2)
 S LF="",F=$ZOS(12,P_"\*.DOC",0) I $P(F,"^")="" S FILE="" Q
 F  Q:F>DOC  S LF=F,F=$ZOS(13,F) Q:$P(F,"^")=""
 S FILE=P_"\"_$P(LF,"^") K LF,P Q
 ;
ALL S F=$ZOS(12,"D:\*.DOC",0) I $P(F,"^")="" S F="" Q
 F  D ALL1 S F=$ZOS(13,F) Q:$P(F,"^")=""
 Q
ALL1 S FILE=$P(F,"^") W !,FILE,?15,"Restore? " R A Q:A'="Y"  D FILESETR
 F J=1:1 U DV R A Q:$E(A,1,5)'="*****"
ALL2 S DOC=$P(A,"****",2) Q:DOC'?1.N  U 0 W "."
 U DV R A S @ZAA02GSCR@("TRANS",DOC)=$P(A,"*",4,99)
 F J=1:1 U DV R A X ZC G:ER ALLER G:$E(A,1,4)="****" ALL2 Q:$E(A,1,2)'="**"  S B=$P(A,"*",3),@("@ZAA02GSCR@(""TRANS"",DOC,"_$S(B?1N:$P(".011,""STATS"";.01;.011;.015;.02;.03",";",B),1:$P(A,"*",3))_")=$P(A,""*"",4,99)")
 S @ZAA02GSCR@("TRANS",DOC,10)=A
 F J=20:10 U DV R A X ZC G:ER ALLER Q:$E(A,1,4)="****"  S @ZAA02GSCR@("TRANS",DOC,J)=A
 G ALL2
ALLER U 0 W "ERROR - DOCUMENT ",DOC R CCC Q
