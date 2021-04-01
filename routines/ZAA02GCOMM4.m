ZAA02GCOMM4 ;PG&A,ZAA02G-COMM,1.36,PHONELIST;2015-11-24 16:53:31;23FEB2005  08:53;;10OCT2000  08:49
 ;Copyright (C) 1986, Patterson, Gray and Associates, Inc.
DIAL K M ; I $D(@ZAA02GCOMMG@("DIAL"))=0 W *13,"No numbers are stored in ",ZAA02GCOMMG S M="" H 2 Q
 S %T=ZAA02GCOMMG_"(""DIAL"")"
D0 W ZAA02G("F"),*13,"Telephone Directory " W:$D(MM) " - ",MM F I=$X:1:79 W "-"
 K A S A="" F I=1:1 S A=$O(@%T@(A)) Q:A=""  S A(I)=A
 W !! S A=I\2,I=I-1 F I=1:1:A W I,?5,A(I) W:$D(A(I+A)) ?40,I+A,?45,A(A+I) W !
D1 W !,"A)dd, E)dit, D)elete, M)ove or #> ",ZAA02G("CL") X @ZAA02G@("TERM-OFF") R A X @ZAA02G@("TERM-ON") S:A?1L A=$C($A(A)-32) G DE:A="",D4:A="E",D5:A="A",D7:A="D",D8:A="M" I $D(A(A))=0 W "  ???" H 1 G D1
 S M=@%T@(A(A)) I M["NX" S %T=$P(%T,")")_","""_A(A)_""")",MM=A(A) G D0
 U 0 D HEAD S %R=1,%C=25 W @ZAA02GP,"PLEASE WAIT WHILE DIALING"
 S Y="Dialing,Number,Logon Info,Type of System,Script" S X=A(A)_"\"_M S %R=3 F J=1:1:5 S %C=1 W @ZAA02GP,ZAA02G("LO"),$P(Y,",",J),":" S %C=20 W @ZAA02GP,ZAA02G("HI"),$P(X,"\",J) S %R=%R+1
 S %C=1 W @ZAA02GP,ZAA02G("LO"),ZAA02G("G1") K A S J=ZAA02G("HL"),J=J_J_J_J F I=1:1:20 W J
 W ZAA02G("G0"),ZAA02G("HI") Q
D4 K TRM,LNG,PAT R !,"Enter selection to Edit - ",A G:A="" D1 I $D(A(A))=0 W " ???" G D1
 S M=A(A)_"\"_@%T@(A(A)) D D6 S X=$P(M,"\") K:$D(@%T@(A(A)))<10 @%T@(A(A)) S:X'="" @%T@(X)=$P(M,"\",2,9) G D0
D5 S M="" D D6 S X=$P(M,"\") S:X'="" @%T@(X)=$P(M,"\",2,9) G D0
D6 W ZAA02G("F"),!!,"Please enter/edit the following information:" S Y="NAME\PHONE #\LOGON INFO (optional)\TYPE OF SYSTEM (optional)\ZAA02G-COMM SCRIPT (optional)"
 S %R=6,%C=1 F J=1:1:5 W @ZAA02GP,ZAA02G("LO"),$P(Y,"\",J),":" S %C=30 W @ZAA02GP,ZAA02G("HI"),$P(M,"\",J) S %R=%R+1,%C=1
 S %R=6,%C=30 F J=1:1:5 S X=$P(M,"\",J) X ^ZAA02GREAD S $P(M,"\",J)=X,%R=%R+1
 Q
D7 R !,"Enter selection to Delete - ",A I $D(A(A))=0 W " ???" G D1
 K @%T@(A(A)) W "...deleted" H 2 G D1
D8 R !,"Enter selection to move ",A I $D(A(A))=0 W " ???" G D1
 W !,"What is the new heading of ",A(A)," - " R B S @ZAA02GCOMMG@("DIAL",B,A(A))=@%T@(A(A)) G D1
 ;
DE K A,MM S M="" Q
 ;
HEAD W:ZAA02G["VT" *15 W ZAA02G("F") S %R=1,%C=2 I $D(ZAA02G("a"))=0 W ZAA02G("LO"),@ZAA02GP,ZAA02G("RON")," P ",ZAA02G("RT")," G ",ZAA02G("RT")," & ",ZAA02G("RT")," A " S %C=69 W @ZAA02GP,"  ZAA02G-COMM  ",ZAA02G("ROF"),!
 E  S A=$P(ZAA02G("a"),"`"),I=$P(ZAA02G("a"),"`",2),%C=18 W @ZAA02GP,I,*13," ",ZAA02G("HI"),A,"P ",I,A,"G ",I,A,"& ",I,A,"A ",I S %C=68 W @ZAA02GP,A,"ZAA02G-WRITER ",I,!
 W ZAA02G("G1") S J=ZAA02G("HL"),J=J_J_J_J F I=1:1:20 W J
 W ZAA02G("G0") Q
 ;
UCI S C=31 I LOS="MSM" W !! S C=0 F V=0:1:5 F U=1:1:30 S B=$ZU(U,V) I B]"" W ?5,C+1,?8,B,! S C=C+1,A(C)=V*32+U
 R !!,"Enter new UCI (namespace) number - ",U G:U="" T4 I U>0,U'>C X $S(LOS="PSM":"ZC U",LOS="M3":"ZN U",LOS="MSM":"V 2:$J:A(U):2",1:"I 0") K A G T4
 W !!," INVALID UCI # - NO CHANGE MADE" K A G T4
T4 G T4^ZAA02GCOMM1
CP I $D(CP) W !!,"CAPTURE MODE OFF - ",$S(CPI=1:"NO ",1:""),"DATA CAPTURED IN ",CP K CP,CPX,CPI,CPC S:$D(XT) XT=$P(XT," D CPX")_$P(XT," D CPX",2) G T4
 R !," ENTER GLOBAL REFERENCE - ",A G T4:A="" S:$E(A)'="^" A="^"_A S CPI=1 I $D(@A)>1 W "  GLOBAL ALREADY DEFINED - WILL ADD TEXT TO END" S CPI=$ZO(@A@(""))+1
 S CPC="" F J=0:1:31 S CPC=CPC_$C(J)
 S:'$D(XT) XT="" S CP=A,XT=XT_" D CPX",CPX="" G T4
ST S:'$D(TR) TR=$C(20) W !!,"Current Terminal Mode Escape Character is Control ",$C($A(TR)+64),!!,"Press the Control Character that you want to change it to - " R *A,!!
 I A=13 W "no change" G T4
 I A=0!(A>32) W "must be a control character - try again" G ST
 S TR=$C(A) W "changed to Control ",$C(A+64) G T4
PR I $D(TP) C TP W !!,"PRINTING TURNED OFF - PRINTER ",TP," CLOSED" K TP S XT=$P(XT," U TP W B")_$P(XT," U TP W B",2) H 2 G T4
 R !," ENTER PRINTER # - ",A G T4:A="" O A::0 E  W "  printer busy" G PR
 S:'$D(XT) XT="" S TP=A,XT=XT_" U TP W B" G T4
 ;
RDIAL D ZAA02GCOMM4 G:M="" T4 U 0 I $D(@ZAA02GCOMMG@("DIALINIT",MODEM))#10 S SCR=^(MODEM),QT=1 D RUNQ^ZAA02GCOMM6 H 1
 I $P(M,"\",4)]"" S SCR=$P(M,"\",4) I $D(@ZAA02GCOMMG@("SCR",SCR))#10 D RUNQ^ZAA02GCOMM6 H 1 U 0 G T4
 U MODEM W:$P(M,"\")]"" $S($D(@ZAA02GCOMMG@("DIALPREFIX",MODEM))#10:^(MODEM),$D(@ZAA02GCOMMG@("DIALPREFIX"))#10:^("DIALPREFIX"),1:"ATDT"),$P(M,"\"),*13 U 0 D ENTRY^ZAA02GCOMM1 U 0 G T4
 ;
CMP W !! D OSP^ZAA02GCOMM2 W "Local system=",LOS," Remote system=",OS,!
 S DIRECT="L",TYPE="R" D UTIL^ZAA02GCOMM X LRSEL S RT=$O(@UTIL@("")),%N=RT]""
 G T4:%N=0 S %JJ=%J U MODEM F  R A:1 I  U 0 Q
 S %W="S" ; W ! R "Long or Short Listing - (LS) ",%W,!
 W !! S RTT=0
ROUT S:0 $ZE="G ERROR^ZAA02GCOMM4" S CL=ZAA02G("CL"),LINE4=$P($T(LINE4),";",2,255),LINE1=$P($T(LINE1),";",2,255),LINE2=$P($T(LINE2),";",2,255),LINE6=$P($T(LINE6),";",2,255),LINE=$P($T(LINE),";",2,255)
 S XR=$P(XR,"A")_"$P(%L,"""" """",2,255)"_$P(XR,"A",2),LXR=$P(LXR,"A")_"$P(%L,"" "",2,255)"_$P(LXR,"A",2),LINE4=LINE4_LXR,LINE1=LINE1_XR_""",*13,!"
 S DV=MODEM X:DV'=56!(DV'["TCP") @ZAA02G@("ECHO-OFF") U 0
 X $P($T(SEARCH)," ",2,256) W *13,"           ",!,"USE ""."" SYNTAX WITH %RSEL",!,"Press RETURN to continue " R %C#1
EXIT K %,%C,%F,%I,%JJ,%K,%L,%N,DV,%P,RT,RTT,RTC,%SS,%W,%X,%SF,LIN,MORE,DO,%PU G T4
SEARCH F  X LINE Q:RTC=""  X LINE1 F  X LINE4 U 0 Q:RT=""  W *13,RT,$J("",20-$L(RT)) S B="" U DV X "F %=1:1:999 R *A:6 Q:A<0  I A=1 R A#3:2 R:A>0 B#A:2 Q" U 0 K:%T=+B ^UTILITY($J,RT) I %T'=+B X LINE6
LINE ;S RTC="" Q:RTT=""  F %=1:1:8 S RTT=$O(@UTIL@(RTT)) Q:RTT=""  S RTC=RTC_RTT_","
LINE6 ;W $S(B["*"&(+B=0):"missing",B["*":"different",1:"error"),"  ",B,! I %W="L" X LINE2
LINE4 ;S RT=$P(RTC,","),RTC=$P(RTC,",",2,99) Q:RT=""  S %T=0 F %N=1:1 S %A="%L=$T(+"_%N_"^"_RT_")",@%A Q:%L=""  S %T=%T+
LINE1 ;U DV W "F %O=1:1 S RT=$P(""",RTC,""","","",%O) Q:RT=""""  S %T=0 F %N=1:1 S %A=""%L=$T(+""_%N_""^""_RT_"")"",@%A W:%L="""" $C(1),$E(1001+$l(%T)+$L(RT),2,4),%T,""*"",RT,"""" Q:%L=""""  S %T=%T+
LINE2 ;S %T=0 ZL @RT S %L=$T(+1) U DV W "S %A=""%L=$T(+""_1_""^",RT,")"",@%A W %L,$C(13)",*13 R A,B,C U 0 W "LOCAL:",!,%L,!,"REMOTE:",!,B,! R CCC
LINE5 ;S %T=0 ZL @RT S %L=$T(+1) U DV W "S %A=""%L=$T(+1)"",@%A W %L,$C(13)",*13 R A,B,C,C U 0 W "LOCAL:",!,%L,!,"REMOTE:",!,C,! R CCC
ERROR U 0 I $ZE["INRPT" W !,"* * * ABORT * * *",! G EXIT
 I $ZE["NOPGM" W "new program",! ZC %PU G ROUT
 W !,$ZE,! G ROUT
 ;
MSM K XLT S XLT=2 G MSM2
MSMV K XLT S XLT=3 G MSM2
DTM K XLT N C,D,E,F S D=2 F E=1:1:25 S:E=16 D=3 S C=$P($G(@ZAA02G@(.1,ZAA02G,D)),"`",E) I $L(C) S C="C=$C("_C_")",@C,F=$P($T(MSM2+(E+1)),";",2) I $L(F) S F="F=$C("_$P(F,":")_")",@F,XLT(C)=F
 F E=1:1:6 S D=$P("INK,DLK,UK,DK,RK,LK",",",E) S C=$G(@ZAA02G@(0,ZAA02G,D)) I $L(C) S F=$P($T(VZAA02GY+E),";",2) I $L(F) S F="F=$C("_$P(F,":")_")",@F,XLT(C)=F
 S T=ZAA02G("T")_" S:$D(XLT(ZF)) ZF=XLT(ZF) "_A
 Q
MSM2 F J=2:1 S A=$P($T(MSM2+J),";",2,3) Q:A=""  S B="B=$C("_$P(A,":",XLT)_"),C=$C("_$P(A,":")_")",@B,XLT(B)=C
 Q
 ;27,91,54,126:27,81:27,26
 ;27,91,53,126:27,73:27,25
 ;27,91,50,52,126:27,119:27,44
 ;27,91,50,53,126:27,88:27,45
 ;27,91,50,54,126:27,36:27,46
 ;27,91,49,56,126:27,34:27,38
 ;27,91,49,55,126:27,86:27,37
 ;27,91,51,52,126:27,38:27,54
 ;27,91,51,50,126:27,148:27,52
 ;27,91,50,56,126:27,32:27,48
 ;27,91,51,49,126:27,84:27,51
 ;27,91,49,57,126:27,35:27,39
 ;27,91,50,49,126:27,37:27,41
 ;27,91,50,48,126:27,89:27,40
 ;27,79,83:27,117:16
 ;27,91,49,126:27,33:27,21
 ;27,91,50,57,126:27,40:27,49
 ;27,91,51,51,126:27,92:27,53
 ;27,91,50,51,126:27,41:27,43
 ;27,79,80:23:23
 ;27,91,52,126:27,39:27,24
 ;27,79,82:27,71:27,33
 ;27,79,81:27,79:1
 ;27,91,65:27,17:27,17
 ;27,91,66:27,18:27,18
 ;27,91,67:27,19:27,19
 ;27,91,68:27,20:27,20
 ;27,91,50,126:27,82:27,22
 ;27,91,51,126:27,126:27,23
 ;
VZAA02GY ;
 ;27,91,65
 ;27,91,66
 ;27,91,67
 ;27,91,68
