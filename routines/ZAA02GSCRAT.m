ZAA02GSCRAT ;PG&A,ZAA02G-SCRIPT,2.10,ARCHIVE OPTIONS;01NOV94  04:06;29SEP2005  08:42;;Wed, 15 Oct 2008  15:20
 ;Copyright (C) 1992, Patterson, Gray & Associates, Inc.
 ;
SETUP S HD="A R C H I V E   T R A N S C R I P T S",%R=1,%C=20,C=43-$L(HD),C=$J("",C\2)_HD_$J("",C\2) W @ZAA02GP,ZAA02G("HI"),C,!!,ZAA02G("CS")
 S SIZE=$S($D(@ZAA02GSCR@("PARAM","ARCHIVE","SIZE")):^("SIZE"),1:1000)
 D DATES I ZAA02Gform["C-TIMEOUT" K BEG Q
 Q:'$D(BEG)  D DATE^ZAA02GSCRER S DATE=DT,TIME=TM D PATH S FILE=PATH,COUNT=99999 S:SIZE>0 COUNT=SIZE
 S B="" F J=1:1 S B=$O(@ZAA02GSCR@("PARAM","ARCHIVE","RESTORE",B)) Q:B=""  K ^(B),@ZAA02GSCR@("TRANS",B) ; cleanup restored docs
 I BEG]"" S DT=$P(BEG,"/",3)*100+BEG*100+$P(BEG,"/",2),END=$S($D(@ZAA02GSCR@("DIR",98,DT)):^(DT),$O(^(DT)):^($O(^(DT))),1:"")
 S BEG=$O(@ZAA02GSCR@("TRANS","")) S:END="" END=@ZAA02GSCR@("PARAM","NEXT")-1
 S %R=4,%C=20 W @ZAA02GP,*13,ZAA02G("CS"),@ZAA02GP I BEG<END W "Archiving Reports - ",BEG," to ",END
 E  W "Nothing to Archive - Press RETURN " R A#1 G END
 W !!?19,"Do you want to continue (Y or N) - " R A#1 S:A?1L A=$C($A(A)-32) G:A'="Y" END S %R=6 W @ZAA02GP,ZAA02G("CS")
 S (BFILE,N,T)="",NE=BEG-1 F  S NB=NE+1 D ARC G:ER END Q:$O(@ZAA02GSCR@("TRANS",NE))=""  Q:$O(^(NE))'<END
 S @ZAA02GSCR@("PARAM","ARCHIVE","HISTORY",+$H,$P($H,",",2))=BEG_","_END_","_$S($D(TRANS):TRANS,1:"??")_","_BFILE
 S @ZAA02GSCR@("PARAM","ARCHIVE","SIZE")=SIZE
 S %R=12,%C=68 W @ZAA02GP,"done",ZAA02G("CS")
 S %R=14,%C=20 W @ZAA02GP,"Total Transcripts Archived     - ",T,!?19,"Total Number of Bytes Archived - ",N,!!?19,"Archive completed - Press RETURN  " R C#1
END K NB,NE,PATH,BFILE,FILE,DATE,TIME,B,T,END,DT,D,C,ZC,ER,BEG,HD,DV Q
 ;
ARC S %R=8,%C=20 W @ZAA02GP,"Please waiting while Archiving......",ZAA02G("CS")
 S %R=11,%C=1 D WR Q:ER  U 0 S %R=8,%C=56 W @ZAA02GP,"done"
 S %R=10,%C=20 W @ZAA02GP,"Please wait while Verifying Archive File...",FILE,ZAA02G("CS") D VERIFY Q:ER
 S %R=11,%C=64 W @ZAA02GP,"done"
 S @ZAA02GSCR@("PARAM","ARCHIVE","DIR",NE+1)=NB_","_NE_","_$S($D(TRANS):TRANS,1:"??")_","_FILE_","_DATE_","_TIME_","_$H_","_COUNT
 S %R=12,%C=20 W @ZAA02GP,ZAA02G("CS"),"Please wait while Purging Archived Records......" S %R=14,%C=30 D WRP
 Q
 ;
WR S K=NB-1 I COUNT>1 F J=1:1:COUNT S C=K,K=$O(@ZAA02GSCR@("TRANS",K)) Q:K=""  Q:K>END
 S:K=""!(K>END) K=C S NE=K,FILE=PATH_NB_".DOC" D FILESETW Q:ER  S:$G(BFILE)="" BFILE=FILE
 U DV W "*****ZAA02G-SCRIPT ARCHIVE*****",!,"*****",DATE,"-",TIME,"-",$H,!,"*****",NB,":",NE,! X ZC Q:ER
 S B=NB-1 F  S B=$O(@ZAA02GSCR@("TRANS",B)) D WR2 G:ER ERROR Q:B=NE
 U DV W !,"****",!!! C DV U 0 W @ZAA02GP,ZAA02G("CS") Q
WR2 Q:$D(@ZAA02GSCR@("TRANS",B))#2=0  U 0 W:B["00" @ZAA02GP,$TR(^(B),"~`","  ") S LAST=B
 U DV W "****",B,!,"***",@ZAA02GSCR@("TRANS",B),!
 S J=0 F K=1:1 S J=$O(@ZAA02GSCR@("TRANS",B,J)) Q:J=""  Q:J>.03  I $D(^(J))#2,^(J)]"" W "**",J,"*",^(J),!
 S J="" F K=1:1 S J=$O(@ZAA02GSCR@("TRANS",B,.011,J)) Q:J=""  I $D(^(J))#2,^(J)]"" W "**.011,",$S(+J=J:J,1:""""_J_""""),"*",^(J),!
 S C=.03,D=$O(@ZAA02GSCR@("TRANS",B,.03)) Q:D=""  I ^(D)[$C(1) F J=1:1 S C=$O(^(C)) Q:C=""  W $P(^(C),$C(1),4),!
 E  F J=1:1 S C=$O(^(C)) Q:C=""  W ^(C),!
 W ! X ZC Q
 ;
WRP S B=NB-1 F  S B=$O(@ZAA02GSCR@("TRANS",B)) W:B["00" @ZAA02GP,B K:1 @ZAA02GSCR@("TRANS",B) Q:B=NE
 Q
 ;
DATES S SCR="ZAA02GSCRIPT",SNL=14,REFRESH="3:22",ZAA02Gform="0;;;N"
 D ^ZAA02GFORM Q
FILESETW S ER=0 I ^ZAA02G("OS")="MSM" S DV=51 O 51::0 G:'$T BUSY O 51:(FILE:"W") S ZC="S ER=$ZC" X ZC Q
 I ^ZAA02G("OS")="M3" S DV=51 O 51:(FILE:"W") S ZC="S ER=$ZC" X ZC Q
 I ^ZAA02G("OS")="DTM" S DV=10 O 10:(mode="W":file=FILE) S ZC="S ER=$ZC" Q
 I ^ZAA02G("OS")="DSM4" S DV=FILE,ZC="S ER=$ZC" O DV Q
 I ^ZAA02G("OS")="M11" S DV=FILE,ZC="S ER=ER" O FILE:("NW") Q
 Q
FILESETR S ER=0 I ^ZAA02G("OS")="MSM" S DV=51 O 51::0 G:'$T BUSY O 51:(FILE:"R") S ZC="S ER=$ZC" X ZC Q
 I ^ZAA02G("OS")="M3" S DV=51 O 51:(FILE:"R") S ZC="S ER=$ZC" X ZC Q
 I ^ZAA02G("OS")="DTM" S DV=10 O 10:(mode="R":file=FILE) S ZC="S ER=$ZC" Q
 I ^ZAA02G("OS")="DSM4" S DV=FILE,ZC="S ER=$ZC" O DV Q
 I ^ZAA02G("OS")="M11" S DV=FILE,ZC="S ER=ER",$ZT="M11END^ZAA02GSCRAT" O FILE:("R") Q
 Q
M11END S ER=1 Q
VERIFY S %R=12,%C=38 D FILESETR F J=1:1 U DV R A X ZC Q:ER  S N=N+$L(A) I $E(A,1,4)="****" Q:A="****"  S B=$E(A,5,13),T=T+1 I B,B["00" U 0 W @ZAA02GP,B
 C DV G VERROR:B'=LAST,VERROR:ER
 U 0 S ER=0 Q
BUSY S MESS="ARCHIVE DEVICE IS BUSY" G FX
ERROR S MESS="ARCHIVE DEVICE ERROR-"_ER G FX
VERROR S MESS="ARCHIVE VERIFY ERROR" G FX
FX S %R=20,%C=20 W @ZAA02GP,MESS," - CHECK SYSTEM AND TRY AGAIN" R A I 0
 Q
PATH S PATH=$G(@ZAA02GSCR@("PARAM","ARCHIVE","PATH")) I PATH]"","/\"'[$E(PATH,$L(PATH)) S PATH=PATH_$S(PATH["/":"/",1:"\")
 Q
REC G ^ZAA02GSCRAT1
HIST G HIST^ZAA02GSCRAT1
ARCH N (ZAA02G,ZAA02GP,DOC,ZAA02GSCR,ERR) D FINDFILE I $L(FILE) W:$D(ZAA02G) *13,"Restoring document from archive....please wait...",ZAA02G("CL") D RESTORE^ZAA02GSCRAT1 Q
 I '$D(ZAA02G) S ERR="ARCHIVE FILE ERROR" Q
 S Y="20,10\RLYW300\1\",Y(1)="TRANSCRIPT FILE HAS BEEN ARCHIVED FOR THIS*",Y(2)="RECORD.*",Y(3)="*"
 S Y(4)="     FILE: "_FILE_"    "_$P(FILE,",",5)_"*",Y(5)="*",Y(6)="THIS FILE COULD NOT BE ACCESSED AT THIS TIME*"
 S Y(0)="\EX\\\\PRESS RETURN" D ^ZAA02GPOP S DOC="" Q
 ;
FINDFILE S FILE=$O(@ZAA02GSCR@("PARAM","ARCHIVE","DIR",DOC))
 Q:FILE=""  S FILE=^(FILE) I DOC>FILE&($P(FILE,",",2)+1>DOC) S FILE=$P(FILE,",",4) Q
 I ^ZAA02G("OS")="MSM" G FINDMSM
 I ^ZAA02G("OS")="M3" G FINDM3
 I ^ZAA02G("OS")="M11" G FINDM11
 S FILE="" Q
FINDM3 S F=$P(FILE,",",4),P="" S:F["\" P=$P(F,"\",1,$L(F,"\")-1),F=$P(F,"\",$L(F,"\")) S:F[":" P=$P(F,":")_":",F=$P(F,":",2)
 S LF="",F=$ZOS(12,P_"\*.DOC",255) I $P(F,"^")="" S FILE="" Q
 F  S FILE(+$P(F,"^"))=$P(F,"^"),F=$ZOS(13,F) Q:$P(F,"^")=""
 S F=$O(FILE(DOC+1),-1) I F="" S FILE="" Q
 S FILE=P_"\"_FILE(F) K P Q
 ;
FINDMSM S F=$P(FILE,",",4),P="" S:F["\" P=$P(F,"\",1,$L(F,"\")-1),F=$P(F,"\",$L(F,"\")) S:F[":" P=$P(F,":")_":",F=$P(F,":",2)
 S LF="",F=$ZOS(12,P_"\*.DOC",0) I $P(F,"^")="" S FILE="" Q
 F  Q:F>DOC  S LF=F,F=$ZOS(13,F) Q:$P(F,"^")=""
 S FILE=P_"\"_$P(LF,"^") K LF,P Q
 ;
FINDM11 X $P($T(FINDM11+1),";",2,9),$P($T(FINDM11+2),";",2,9),$P($T(FINDM11+3),";",2,9) Q
 ;K ^ZAA02GTSCR($J) S P=$P(FILE,",",4),P=$P(P,"/",1,$L(P,"/")-1) S:P]"" P=P_"/" S F=P_"SCRA"_$J_".TXT"
 ;S:1 $ZT="M11EN^ZAA02GSCRAT" S A=$ZF(-1,"ls -1 "_P_" > "_F),FILE="" C F O F F  U F R A I A["DOC" S ^ZAA02GTSCR($J,+A)=A
 ;C F U 0 S F=$ZF(-1,"rm "_F_" > """""),F="" F  S A=F,F=$O(^ZAA02GTSCR($J,F)) I F>DOC!(F="") S FILE=P_^(A) Q
M11EN Q
 ;
ALL S F=$ZOS(12,"C:\MSM43\*.DOC",0) I $P(F,"^")="" S F="" Q
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
