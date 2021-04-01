ZAA02GCOMM2 ;PG&A,ZAA02G-COMM,1.36,OS CONTROL;2015-11-24 16:53:31;Thu, 02 Apr 2015  09:35;;07MAY2000  17:24
 ;Copyright (C) 1983, Patterson, Gray and Associates, Inc.
OSP D OS2 I OS G OS1
 U 0 F J=1:1 S I=$P($T(OSTYPE+J),";",2) Q:I=""  W J,?3,I,!
OS W !,"What OS is at the other end? (1-",J-1,") " R OS,! Q:OS=""  I OS<1!(OS'<J) W *7 G OS
OS1 U 0 S I=$P($T(OSTYPE+OS),";",3,9),ECHOOFF=$P(I,";",2),ECHOFN=$P(I,";",7),XR=$P($P(I,";",3),"`",L),LXR=$P(LXR,"`",OS),ECHOON=$P(I,";",4),RSEL=$P(I,";",5),GSEL=$P(I,";",6),OS=$P(I,";")
 S:XR=""!$D(OCRC) (XR,LXR)="$L(A)"
 Q
OS2 D OSS
 S DV=MODEM,OS=0,B="" X LECHOF U MODEM
 W *13,"W $C(1),*46,$E(1000+$L($ZV),2,4),$ZV",*13 W:MODEM["TCP" *-3 F J=1:1 R *A:5 Q:'$T  I A=1 R *A I A=46 R A#3 S B="" I A>0 R B#A Q
 S OS=$S(B["DSM-1":2,B["DSM":3,B["MSM":9,B["M/S":4,B["Cache":11,B["DTM":6,B["V1.":10,B["M3":1,B["ISM":4,B["Open M":4,B["UNIMP":4,B["<SYNTAX>":4,1:0) G:OS OS3
OS3 Q
OSS S LOS=@ZAA02G@("OS") I LOS="M11",$ZV["Cache" S LOS="M11C"
 F L=1:1 S I=$P($T(OSTYPE+L),";",3,99) Q:I=""  I LOS=$P(I,";") Q
 S LECHOF=$P(I,";",2),LXR=$P(I,";",3),LECHON=$P(I,";",4),LRSEL=$P(I,";",5),LGSEL=$P(I,";",6),LECHOFN=$P(I,";",7)
 I @ZAA02G@("TERM-ON")["0:" S LTERMON=$P(@ZAA02G@("TERM-ON")," 0:")_" DV:"_$P(@ZAA02G@("TERM-ON")," 0:",2),LTERMOF=$P(@ZAA02G@("TERM-OFF")," 0:")_" DV:"_$P(@ZAA02G@("TERM-OFF")," 0:",2,99)
 I @ZAA02G@("TERM-ON")["$I:" S LTERMON=$P(@ZAA02G@("TERM-ON")," $I:")_" DV:"_$P(@ZAA02G@("TERM-ON")," $I:",2),LTERMOF=$P(@ZAA02G@("TERM-OFF")," $I:")_" DV:"_$P(@ZAA02G@("TERM-OFF")," $I:",2,99)
 I LOS="DTM" S LTERMON="U DV X @ZAA02G@(""TERM-ON"")",LTERMOF="U DV X @ZAA02G@(""TERM-OFF"")"
 I $D(TELNET) F L="LECHOF","LECHON","LTERMON","LTERMOF","LECHOFN" S @L="I DV'=TELNET "_@L
 Q
 ;
PRIME S:$D(TIME)=0 TIME="F JJ=1:1:500" S DV=MODEM X LECHOF U MODEM W "S DV=0 ",ECHOOFF," "
 I OS="UM" W "S FN=""ZAA02GCOMM.m"" O FN:(""Type=file"":""Write"":""Truncate"":""Create"") F I=1:1 U """" R X Q:X=""""  U FN W X,!",*13
 I OS="UM" F I=0:1 U 0 W "." U MODEM S A=$T(ZAA02GCOMM2+I) W:A]"" A,*13 X TIME I A="" W *13,"C FN U """":""ECHO""",*13 G PEND
 I OS="DTM" W "S S="""" F J=1:1 R A S:A'="""" $P(S,$C(10),J)=A I A="""" ZS ZAA02GCOMM2:S Q",*13 F I=0:1 R A:0 U 0 W "." W:A'="" "[",A,"]",! U MODEM S A=$T(ZAA02GCOMM2+I) W A,*13 X TIME I A="" G PEND
 I OS="GTM" W "S FN=""ZAA02GCOMM.m"" O FN:(WRITE:NEWV) F I=1:1 U """" R X Q:X=""""  U FN W X,!",*13 F I=0:1 U 0 W "." U MODEM S A=$T(ZAA02GCOMM2+I) W:A]"" A,*13 X TIME I A="" W *13,"C FN U 0:ECHO",*13 G PEND
 I OS'="CCSM" W "ZR  ZL  ",*13 F I=0:1 U 0 W "." U MODEM S A=$T(ZAA02GCOMM2+I) W A,*13 X TIME I A="" W "ZS ZAA02GCOMM2",*13 G PEND
 I OS="CCSM" W "S %NAM=""ZAA02GCOMM2"" K ^ZAA02GTEMP F J=1:1 R A S:A'="""" ^ZAA02GTEMP(J)=A I A="""" S %GLB=""^ZAA02GTEMP"" D ^%RSAVE Q",*13 F I=0:1 U 0 W "." U MODEM S A=$T(ZAA02GCOMM2+I) W A,*13 X TIME I A="" G PEND
PEND W:$D(TELNET) ! F J=1:1 U MODEM R A:2 Q:'$T  U 0 W "[",A,"]",!
 Q
SELM3 S %J=$J I %x'["UTIL" K ^UTILITY($J) S %a="" F  S @%x Q:%a=""  S ^UTILITY($J,%a)=""
 Q
GETOS S I="M3,DSM,DSM4,M11,CCSM,DTM,,GTM,MSM,PSM,M11C",I=$L($P(I,LOS),","),I=$P($T(OSTYPE+I),";",3,99) Q
OSTYPE ;
 ;M3;M3;U DV:(0:"S");$ZX(A)```$ZX(A,1)``$ZX(A,2)```$ZX(A,2)``$ZX(A,1);U DV:(0:"");S %c="R" D SELE^%M3,SELM3^ZAA02GCOMM2;S %c="G" D SELE^%M3,SELM3^ZAA02GCOMM2;U DV:(0:"S")
 ;DSM;DSM;U DV:(0::::1:16384);```````````;U DV:(0:::::1);D ^%RSEL S %J=$J;D ^%GSEL S %J=$J;U DV:(0::::1:16384)
 ;DSM - V4.0;DSM4;U DV:NOECHO;```````````;U DV:ECHO;D ^%RSEL{RT=$O(%UTILITY(RT));D ^%GSEL{RT=$O(%UTILITY(RT));U DV:NOECHO
 ;Intersystems;M11;U DV:(0:"ST":$C(8,9,127));$ZC(A)```$ZC(A)````;U DV:(0:"");D ^%RSET S %J=%JO;D ^%GSET S %J=%JO;U DV:(0:"S")
 ;CCSM;CCSM;O DV:("MR":0:"EC":1:"XO":1);```````````;U DV:("EC":0);
 ;Datatree;DTM;U DV:EM=0;$ZCRC(A,0)`````$ZCRC(A,0)```;U DV:EM=1;w $$^%rselect{RT=$O(^%RSET($J,RT));w $$^%gselect{RT=$O(^%GSET($J,RT));U DV:(EM=0:IXXLATE=0)
 ;PLUS FIVE;UM;U "":"NOECHO";```````````;U "":"ECHO"
 ;GREYSTONE;GTM;U DV:NOECHO;```````````;U DV:ECHO
 ;MSM;MSM;U DV:(0::::1:16384:::$C(8,13,127));$ZCRC(A,1)````````$ZCRC(A,1)```;U DV:(0:::::1);D ^%RSEL S %J=$J;D ^%GSEL S %J=$J;U DV:(0::::1:16384)
 ;PSM;PSM;U DV:(0:"ST");$ZX(A)```$ZX(A,1)``$ZX(A,2)```$ZX(A,2);U DV:(0:"");S S=1 D ^%DSET;S S=2 D ^%DSET;U DV:(0:"S")
 ;Intersystems;M11C;U DV:(0:"ST":$C(8,9,127));$ZC(A)```$ZC(A)````;U DV:(0:"");D RSEL^ZAA02GCOMM;D ^%SYS.GSET S %J=%JO K ^UTILITY(%J) M ^UTILITY(%J)=^CacheTempJ(%J);U DV:(0:"S")
 ;
CONR S TRY=0,DV=0
CON1 S TRY=TRY+1 F I=1:1:9 R A:0
 S LOS=$G(LOS,$G(^ZAA02G("OS")," ")),VER="" S:LOS="M11" LOS=LOS_$S($ZV["Cache":"C",1:"") I LOS="M11C"!(LOS="M3") S VER="FAST2"
 I '$D(SINGLE),'$D(NODUAL),VER="FAST2" D RCV5S S VER=$S(C:"",1:"FAST2-"_port)
 W $C(1),$E(1011+$L(VER),2,4),"CONNECTV2.0",VER
 S A="" F I=0:1:4 R C:4 S A=A_C Q:$L(C,"*")>2
 I A'?1"*".E1"*" G CON1:TRY<6
 Q:TRY=6  S C=$P(A,"*",2),TYPE=$P(C,"\",2),DIRECT=$P(C,"\",3),XR=$P(C,"\",4),OS=$P(C,"\"),ECHOON=$P(C,"\",5),ECHOOFF=$P(C,"\",6),SEL=$P(C,"\",7),ECHOFN=$P(C,"\",9),MODEM=0
 I TYPE'["F",$D(TCPP) C TCPP K TCPP
 I TYPE["F",'$D(TCPP) S TYPE=$TR(TYPE,"F")
 S A=OS S:$D(TCPP) A=A_"+" W $C(1),$E(1000+$L(A),2,4),A
 S UTIL="^UTILITY(%J)" I SEL["{" S UTIL=$P(SEL,"{",2),SEL=$P(SEL,"{")
 G ^ZAA02GCOMM3:TYPE["G",REMRCV:DIRECT["L",REMXMT^ZAA02GCOMM
 ;
REMRCV S O=OS D ROURCV X RRCV C:$D(TCPP) TCPP Q
ROURCV S (TRCA,TRC,TRCB)="I 1"
 I $G(VER)["FAST2",TYPE["F" S RRCV=$P($T(RCV5),";",2,255) U TCPP Q
 S RCV=$P($T(RCV),";",2,255),RCV1=$P($T(RCV1),";",2,255),RCV2=$P($T(RCV2),";",2,255),TM=90,RT="" I MODEM=0 S (TRCA,TRC,TRCB)="I $T"
 S STOR="F K=1:1:+C S A=C(K) S:RT="""" RT=A I A["" "" "
 I O="DTM" S STOR=STOR_"S J=J+1,$P(S,$C(10),J)=A",RRCV="S J=0 F I=0:1 X RCV S:RT="""" S="""",J=0 X STOR Q:RT=""""  I A="""" ZS @RT:S:$S($D(DTMFLAGS):DTMFLAGS,1:0) X TRCB S RT=A" Q
 I O="PSM" S STOR=STOR_"ZI A",RRCV="F I=0:1 ZR:RT=""""  X RCV,STOR Q:RT=""""  I '$L(A) ZS @RT X TRCB S ^UTILITY(""R"",RT)=A,RT=A" Q
 S STOR=STOR_"ZI A",RRCV="S J=0 F I=0:1 ZR:RT=""""  X RCV,STOR Q:RT=""""  I '$L(A) ZS @RT X TRCB S RT=A" Q
 Q
RCV5S F port=5030:1:5099 s C=1 D  Q:'C
 . I LOS="M11C" D
 .. I $D(TCPP) C TCPP
 .. S TCPP="|TCP|"_port O TCPP:(:port:"S"):2 I  U TCPP S C=$ZA#8>4 Q
 . I LOS="M3" D
 .. I $D(TCPP) C TCPP
 .. S TCPP="TCP" O TCPP:("/"_port:"") S C=0 Q  ;U:0 TCPP S C=$ZC Q
 U 0 K:C TCPP Q
RCV5 ;F  R X#3 S C=$S(OS="M3":$ZC,1:$ZA#8>3),L=+X X:'L "W 999,! C TCPP U 0" Q:'L  G ERRD^ZAA02GCOMM2:C R RT#L ZR  F  R X#3 S C=$S(OS="M3":$ZC,1:$ZA#8>3),L=+X ZS:'L @RT X:'L TRCB Q:'L  G ERRD^ZAA02GCOMM2:C R X#L ZI X
ERRD Q
 ;
RCV ;F K=1:1 X RCV1 S X=N=D,DT=$E("NY",X+1)_" "_M,IN=0 I I!X X:'X "F  R MM:2 Q:'$T" W $C(1),$E(1000+$L(DT),2,4),DT,! X TRC Q:X
RCV1 ;S (B,C)=0 X RCV2 S DT=MM,IN=1,TM=5 X TRC K C S C=$P(MM,",",2),N=$P(MM,",",3),M=+MM,D=0,RXR="D=D+"_XR Q:$L(MM,",")<3  F B=1:1:C X RCV2 S A=MM,@RXR,C(B)=A,DT=A X TRCA
RCV2 ;S rL=-1 F rT=1:1 R *MM:I<3*20+5 Q:MM<0  I MM=1 S MM="" R rL#3:5 Q:'rL  R MM#rL:5 Q
RCV2A ;S rL=-1 F rT=1:1 R *MM:I<3*20+5 S:MM<0 B=C Q:MM<0  I MM=1 S MM="" R rL#3:5 Q:'rL  R MM#rL:5 S:$L(MM)'=rL B=C Q
