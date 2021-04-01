ZAA02GFAXD3 ;PG&A,ZAA02G-FAX,1.36,DEVICE TESTS;21MAR94 11:03A;;;06SEP2006  17:08
 ;Copyright (C) 1991-1994, Patterson, Gray and Associates Inc.
 ;
BEG S YY="TEST FAX/MODEM COMMUNICATION`Device responds correctly - TYPE=`Press RETURN`DEVICE DOES NOT RESPOND  -  CHECK COMMUNICATION LINES`DEVICE IS BUSY  -  Test cannot be run`Device`Press Return"
 I $D(ZAA02G(9)) S YY=@ZAA02G(9)@(20)
 S Y=$S('$D(ZAA02G(9)):"Please Wait\This may take a few seconds",1:@ZAA02G(9)@(22)) S Y="25,11\WHRL\1\\\"_$P(Y,"\")_"*,*,"_$P(Y,"\",2) D ^ZAA02GFAXU2
 S Y="20,10\W60HRL\1\"_$P(YY,"`")_"\\" S FAXP=$S($D(^ZAA02GFAXC("FAX")):^("FAX"),1:"") G:$P(FAXP,"\")_$P(FAXP,"\",7)="" NODEV
 S OS=^ZAA02G("OS")
 F I=1:6:59 I $P(FAXP,"\",I)'="" S FAX=$P(FAXP,"\",I) D CHECK
 S Y(0)="\EX" G POP
CHECK I $D(TEST) W !,"FAX=",FAX,!,Y,!
 S Y=Y_FAX_$J("",18-$L(FAX))_"*" O FAX::2 E  S Y=Y_$P(YY,"`",5)_"," Q
 S DV=FAX D NOECHO^ZAA02GFAXC
ST S ER=1,DD="DATA" K BAUD S MFR="" D SEND U 0 C FAX S Y=Y_$P(YY,"`",OK*-2+4)_" "_$TR($P(MFR,"\",5),",","-")_"," Q
END K Y,YY,FAX,FAXP,BAUD,DV Q
TT S TEST=1 G BEG
NODEV S Y="15,10\DHRL\1\"_$S('$D(ZAA02G(9)):"TEST FAX/MODEM COMMUNICATION\\*,No Device has been specified in Device Configuration,*,Please Configure System first - then try again",1:@ZAA02G(9)@(21)) G POP
POP D ^ZAA02GFAXU2 G END
 ;
 ;
SEND F SN=1:1 S SCR=$P($T(@DD+SN),";",2,99) Q:SCR=""  D INQ X $P(SCR,"\",6-OK) Q:'OK
 Q
 ;
INQ S OK=0,X1=$P(SCR,"\"),DN=$P(SCR,"\",2),IT=$P(SCR,"\",3),T=$P(SCR,"\",4) X:$D(TEST) "U 0 W SCR,! U DV" ; F J=1:1 R A:1 Q:'$T
 I X1["*" S X1=$P(X1,"*")_DT($E($P(X1,"*",2)))_$E($P(X1,"*",2,9),2,255)
 S DATA="" F J=1:1:IT W:X1["$C" @X1 W:X1'["$C" X1,*13 S T1=$P($H,",",2)+T F K=1:1 Q:$P($H,",",2)>T1  R A:T X:$D(TEST) "U 0 W A,! U DV" S:$L(DATA)+$L(A)<250 DATA=DATA_A_"\" G INQ1:DATA[DN
 Q
INQ1 S OK=1 Q
 ;
DATA ; TEST FOR DEVICE TYPE
 ;ATQ0\OK\2\1\\
 ;ATHE1V1\OK\2\1
 ;AT+FMFR?\OK\2\1\S MFR=DATA,SN=5 I DATA["Rock"+(DATA["ROCK")+(DATA["Multi-")+(DATA["Ever")+(DATA["E-TE")+(DATA["Prac")=0 S SN=3
 ;ATZ\OK\1\2
 ;
T S YY=$S('$D(ZAA02G(9)):"Test Fax\Enter Fax Number for Test Fax\Test of ZAA02G-FAX\Whomever\test\This is a short ZAA02G-FAX test\TEST FAX SENT",1:@ZAA02G(9)@(5))
 S Y="40,10\RHLD\1\"_$P(YY,"\")_"\\*,"_$P(YY,"\",2)_"*,*,  #*",Y(0)="\EX",CHR="1234567890,W ",X="" D ^ZAA02GFAXU2 Q:X["EX"  Q:X=""
 S FAXPARAM="ZAA02G-FAX``"_$P(YY,"\",3)_"`"_$P(YY,"\",4)_"`"_X_"``1``P```N`````"_$P(YY,"\",5),ZAA02GWPD="^ZAA02GFAXC(""TEST"")",^ZAA02GFAXC("TEST",1)=$P(YY,"\",6) D QUEUE^ZAA02GFAXQ
 S Y="38,11\RW\1\\\*,"_$P(YY,"\",7)_"*,*" D ^ZAA02GFAXU2 H 2 Q
