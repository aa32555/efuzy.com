ZAA02GSEND1 ;PG&A,ZAA02G-SEND,1.36,MODEM TRANSFER (Terminal Emulation Control);1DEC94 4:42P;;;30JAN98  16:26
 ;PG&A, 1984
BEG D:'$D(ZAA02G) INIT^ZAA02GDEV S LOS=^ZAA02G("OS") D OSS^ZAA02GSEND2
 S:0 A=^ZAA02G("ERROR")_"=""ERR^ZAA02GSEND1""",@A K TR,CP,PR,XT
 S ZAA02GSENDG=$S($D(^%ZAA02GSEND)#2:^%ZAA02GSEND,1:"^ZAA02GSEND")
BEG1 W ZAA02G("F") D DEV G:D="" END D ENTRY G T4
DEV R !,"What is the modem device # ",D Q:D=""  G:"Tt"'[$E(D) DEV1 I $D(TELNET) S MODEM=TELNET Q
 S ip="192.168.0.11",port=23 S:$D(@ZAA02GSENDG@("IP")) ip=^("IP") W !,"Enter IP address (",ip," or ?) " R nt,! D:nt="?" IPlist G:nt="?" DEV S:nt'="" ip=nt,(@ZAA02GSENDG@("IP"),^("IP",ip))=ip s:ip[":" port=$p(ip,":",2),ip=$P(ip,":") k nt
IP G IP1:^ZAA02G("OS")="M11"
IP2 S MODEM=56,nt=1 C 56 O 56:(:2):"TCP" U 56 S %lddb=$KEY
IP3 U 56:(%lddb) W /SOCKET(ip,port) I $ZC&($ZB=-8) H 2 G IP3
 I $ZC H 2 G IP2
 G IP4
IP1 S MODEM="|TCP|23" C MODEM O MODEM:(ip:port:"MA")
IP4 S TELNET=MODEM F L="LECHOF","LECHON","LTERMON","LTERMOF","LECHOFN" S @L="I DV'=TELNET "_@L
 U MODEM W $C(255,251,24),! I 1 Q
IPlist S nt="" F J=1:1 S nt=$O(@ZAA02GSENDG@("IP",nt)) Q:nt=""  S nt(J)=nt W !,J,?5,nt
 W !!,"Select one (1-",J-1," or return to exit)-" R nt,!! S:nt="" nt="?" I nt]"",$D(nt(nt)) S nt=nt(nt)
 K D Q
DEV1 O D::0 E  W "  Device is busy - try later",! H 2 S D="" Q
 S MODEM=D Q
END I $D(MODEM) W !,"Leave connection open? (N) - " R A#1 I A=""!("Yy"'[A) C MODEM K TELNET
 C:$D(TP) TP K %A,%B,%C,D,%E,XT,TP,CP,CPX,CPI Q
 ;
 ;
ENTRY D:'$D(ZAA02G) INIT^ZAA02GDEV K XW
 I $D(XT)=0 S XT="" ; I ZAA02G["PC" D IBM^ZAA02GINIT2 S PP=CH D DEC^ZAA02GINIT2 S DD=CH,XT="S A=$TR(A,DD,PP)"
 S:$D(TR)=0 TR=$C(20) W !!,"Terminal Mode - Press Control ",$C($A(TR)+64)," to exit",!! D O0 W !!,"Exit Terminal Mode",! Q
O0 S IT=2000,XW="" S:MODEM["TCP" XW="W *-3" D TERMON,O1,TERMOF K TRM,T,S,XLT,CTR,IT,XW Q
O1 U D W *17 I ^ZAA02G("OS")'="DTM" F I=1:1 H 0 D O2 Q:A[TR
 I ^ZAA02G("OS")="DTM" F  U 0 R A:0 X XT,T Q:A[TR  U D W A R A:0 X XT,TRM S B=A U 0 W A
 Q
O2 S CTR=$H U D R A:0 X XT,TRM S B=A U 0 W A R A:1 X XT,T Q:A[TR  Q:A_B=""  U D W A X XW
 F J=1:1:IT U 0 R A:0 X XT,T H 0 Q:A[TR  U D W A X XW S:A'="" J=1 R A:0 X XT,TRM S B=A H 0 U 0 W A S:$L(A)+$L(B) J=1
 S:$P($H,",",2)-$P(CTR,",",2)<10 IT=IT+2000 Q
T4 X ^ZAA02G("TERM-ON"),^ZAA02G("WRAP-OFF"),^ZAA02G("ECHO-OFF") D HEAD^ZAA02GSEND4 W ZAA02G("HI") S %C=1,%R=3 W @ZAA02GP,"Capture=",$S($D(CP):CP,1:"") S %C=74-$L(MODEM) W @ZAA02GP,"Modem=",MODEM,!
 S %R=4,%C=1 W @ZAA02GP,"Printer=",$S($D(TP):TP,1:"") I "PSM,DTM,MSM"[^ZAA02G("OS") S A="A="_$S(^("OS")="PSM":"$ZD",^("OS")="MSM":"$ZU(0)",1:"$P($ZJOB($J),""|"",4)"),@A,A="Directory="_A,%C=80-$L(A) W @ZAA02GP,A,!
 W !,"Enter -   C to toggle Capture Mode",?45,"P to toggle Printer Mode"
 W !?10,"S to Set escape character",?45,"T to enter Terminal Mode",!?10,"R to send or receive Routines",?45,"G to send or receive Globals"
 W !?10,"D to Dial a Number",?45,"M to change Modems",!?10,"E to Edit Script",?45,"X to eXecute Script",!?10,"L to downLoad remote ZAA02GSEND",?45,"B to change BAUD rate",!
 W ?10,"U to change Directory",?45,"K for Kermit transfers",!,?10,"Q to Quit ZAA02GSEND",?45,"O for cOmpare routines",!!,">>"
T5 R A#1 S:A?1L A=$C($A(A)-32)
 I A="" X ZAA02G("T") S ZF=$P(^ZAA02G(.3),"\",$A(^ZAA02G(.3,ZAA02G,0),$F(^(0),ZF))+2) S:ZF="EX" A="Q"
 G T5:A="" X ^ZAA02G("ECHO-ON"),^ZAA02G("TERM-OFF")
 I A'="T" G @$P("ER,ER,PR,CP^ZAA02GSEND4,ST^ZAA02GSEND4,END,ROU,GLO,RDIAL^ZAA02GSEND4,UCI^ZAA02GSEND4,MOD,EDIT^ZAA02GSEND7,RUN,DWNLD,BAUD,KERM,CMP^ZAA02GSEND4",",",$F("PCSQRGDUMEXLBKO",A)+1)
 D ENTRY G T4
ER W *7 G T4
RUN D RUN^ZAA02GSEND6 S D=MODEM G T4
ROU W ! D OS^ZAA02GSEND S TYPE="R" D DIRECT^ZAA02GSEND G T4
GLO W ! D OS^ZAA02GSEND S TYPE="G" D DIRECT^ZAA02GSEND G T4
DWNLD W ! R "Are you sure you want to send ZAA02GSEND2? (Y or N) " R A#1 G T4:A="",T4:"Yy"'[A D OS^ZAA02GSEND,PRIME^ZAA02GSEND2 G T4
BAUD D CBAUD^ZAA02GSEND7 G T4
KERM D KERM^ZAA02GSENDA G T4
MOD R !,"Enter New Modem Number - ",D,! G T4:D="" C MODEM S MODEM=D G DEV
CPX I $L(CPX)+$L(A)>250 S @CP@(CPI)=CPX_$E(A,1,250-$L(CPX)),CPX=$E(A,250-$L(CPX)+1,255),CPI=CPI+1 Q
 S CPX=CPX_A
CPX1 I CPX[$C(13,10) S @CP@(CPI)=$P(CPX,$C(13,10)),CPX=$P(CPX,$C(13,10),2,255),CPI=CPI+1 G CPX1
 Q
RESTART G RESTART^ZAA02GSEND
TERMOF S DV=MODEM,A=ZAA02G(1),ZAA02G(1)=1 D LOFF S DV=0,ZAA02G(1)=A D:$G(QT)'=0 LOFF Q
TERMON D TERM S (D,DV)=MODEM,A=ZAA02G(1),ZAA02G(1)=0 D LON S ZAA02G(1)=A,DV=0 D:$G(QT)'=0 LON Q
TERM S A=" S:ZF=$C(26) ZF=$C(3) S:$C(0,255)'[ZF A=A_ZF" G:^ZAA02G("OS")="MSM" TMSM S (TRM,T)=ZAA02G("T")_A
 D:^ZAA02G("OS")="DTM" DTM^ZAA02GSEND4 Q
TMSM S TRM="S ZF=$S($ZB>31&($ZB<128):$C(0),1:$C($ZB#256))"_A S:$D(TELNET) TRM="S ZF=$C(0) D:A[$C(255) NEG^ZAA02GSEND1"
 I ZAA02G'["VT" S T="S ZF=$S($ZB\256:$C(27,$ZB\256),$ZB=127:$C(27,126),$ZB=8:$C(127),$ZB>31:$C(0),1:$C($ZB#256)) X:$ZB=0&(A=$C(0)) ""R *ZF:0 S ZF=$S(ZF<1:$C(0),1:$C(27,ZF))"" S:$D(XLT(ZF)) ZF=XLT(ZF) "_A D MSM^ZAA02GSEND4 Q
 S T="S ZF=$S($ZB#256=27:$C(27,$ZB\256),$ZB>31&($ZB<127):$C(0),1:$TR($C($ZB#256),$C(8),$C(127))) S:$D(XLT(ZF)) ZF=XLT(ZF) "_A D MSMV^ZAA02GSEND4 Q
LON Q:$G(TELNET)=DV  B 0 I ^ZAA02G("OS")="PSM" U DV:(:"SI") Q
 I ^ZAA02G("OS")="MSM" U DV:(0::::1+4+4096+262144+8388608+(DV=0*64):(DV>0*64)+1048576:::$C(13,8,127)) Q
 X LTERMON,LECHOF S ZAA02G(1)=ZAA02G(1)+.01 I ^ZAA02G("OS")="DTM" U:DV'=0 DV:IXXLATE=0 U:DV=0 0:VT=1
 Q
LOFF Q:$G(TELNET)=DV  B 1 I ^ZAA02G("OS")="PSM" U DV:(:"") Q
 I ^ZAA02G("OS")="MSM" U DV:(0::::1+1048576:8388608:::$C(13)) Q
 I DV=0,^ZAA02G("OS")="DTM" U 0:VT=0
 S ZAA02G(1)=ZAA02G(1)\1 X LECHON,LTERMOF Q
ERR U 0 S DV=0 X LECHON S B="B="_^ZAA02G("ERRORR"),@B I $D(TELNET),B["DSCON"!(B["NOPE") W !,"No Connection to telnet port" K TELNET
 E  W !,B
 R !,"press RETURN to continue " R A#1 G BEG
NEG F  Q:A'[$C(255)  S J=$E($P(A,$C(255),2),1,2) D
 . I $A(J)<251 S J=$E(J,1,$A(J)=250*2+1)
 . E  I $L(J)<2 U D R B#2-$L(J):5 S J=J_B Q:$L(B)'=2  S A=$P(A,$C(255))
 . S A=$P(A,$C(255)_J)_$P(A,$C(255)_J,2,99)
 . I $L(J)=2 U 0 W:0 "<",$P("WILL,WON'T,DO,DON'T",",",$A(J)-250),"-",$A(J,2)," (",$P("Binary,Echo,Reconnect,Suppress GA,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25",",",$A(J,2)+1),") >",! D NEG1
 Q
 U D W $C(255,251,24,255,253,1),! W:1 $C(255,253,3,255,250,24,0)_"VT340"_$C(255,240),! Q
NEG1 U D I $A(J)=251,$C(1,3)[$E(J,2) W $C(255,253,$A(J,2)),! Q
 W $C(255,252,$A(J,2)),! Q
