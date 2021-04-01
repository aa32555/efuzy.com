ZAA02GCOMM1 ;PG&A,ZAA02G-COMM,1.36,MODEM TRANSFER (Terminal Emulation Control);1DEC94;Thu, 16 Aug 2012  10:50;;13OCT2000  14:05
 ; ADS Corp. Copyright
 ;PG&A, 1984
BEG I $ZV["M3" S A=$ZN ZN 1 D INIT^ZAA02GDEV ZN A S ZAA02G="^%T",ZAA02GCOMMG="^[1]ZAA02GSEND"
 I $ZV'["M3" D:'$D(ZAA02G) INIT^ZAA02GDEV S ZAA02G="^ZAA02G",ZAA02GCOMMG=$S($D(^%ZAA02GSEND)#2:^%ZAA02GSEND,1:"^ZAA02GSEND")
 S LOS=@ZAA02G@("OS") D OSS^ZAA02GCOMM2
 S:0 A=@ZAA02G@("ERROR")_"=""ERR^ZAA02GCOMM1""",@A K TR,CP,PR,XT
BEG1 W ZAA02G("F") D DEV G:D="" END D ENTRY G T4
DEV R !,"What is the modem device # (Use T for Telnet) ",D Q:D=""  G:"Tt"'[$E(D) DEV1 I $D(TELNET),$D(ip),$D(LVOPEN) S MODEM=TELNET Q
 S ip="",port=23 S:$D(@ZAA02GCOMMG@("IP")) ip=^("IP") W !,"Enter IP address (",ip," or ?) " R nt,! I nt]"",nt'="?" S (@ZAA02GCOMMG@("IP"),^("IP",nt))=nt
 I nt="" G DEV:ip="" S nt=$G(@ZAA02GCOMMG@("IP",ip))
 I nt="?" D IPlist G:nt="?" DEV S @ZAA02GCOMMG@("IP")=nt(nt),nt=ip
 S ip=nt s:ip[":" port=$p(ip,":",2),opt=$p(ip,":",3),ip=$P(ip,":") k nt       e
IP G IP1:@ZAA02G@("OS")="M11",IP2:@ZAA02G@("OS")="MSM"
 S MODEM="TCP" C MODEM O MODEM:(ip_"/"_port:"F") U MODEM S J=$ZC U 0 G:'J IP4 W !,$S(J=10065:"No connection to IP",1:"IP-ERROR: "_J),! G DEV
IP2 S MODEM=56,nt=1 C 56 O 56:(:2):"TCP" U 56 S %lddb=$KEY
IP3 U 56:(%lddb) W /SOCKET(ip,port) I $ZC&($ZB=-8) H 2 G IP3
 I $ZC H 2 G IP2
 G IP4
IP1 S MODEM="|TCP|23" C MODEM O MODEM:(ip:port:"")
IP4 S TELNET=MODEM F L="LECHOF","LECHON","LTERMON","LTERMOF","LECHOFN" S @L="I DV'=TELNET "_@L
 U MODEM W:$G(port)>5000 $C(255,251,24,1,1),! I 1 Q
IPlist S nt="" F J=1:1 S nt=$O(@ZAA02GCOMMG@("IP",nt)) Q:nt=""  S nt(J)=nt
 S I=J-1\4+1 F J=1:1:I W:$D(nt(J)) !,J,?3,nt(J)," " W:$D(nt(I+J)) ?20,I+J," ",?23,nt(I+J)," " W:$D(nt(I+I+J)) ?40,I+I+J," ",?43,nt(I+I+J)," " W:$D(nt(I*3+J)) ?60,I*3+J," ",?63,$E(nt(I*3+J),1,64-$X+16)
 W !!,"Select one (1-",J-1," or return to exit)-" R nt S:nt="" nt="?" I nt]"",$D(nt(nt)) S ip=@ZAA02GCOMMG@("IP",nt(nt)) W "  ",ip
 W !! Q
DEV1 O D::0 E  W "  Device is busy - try later",! H 2 S D="" Q
 S MODEM=D Q
END I $D(MODEM) W !,"Leave connection open? (N) - " R A#1 I A=""!("Yy"'[A) C MODEM K TELNET,Neg,LVOPEN
 E  S LVOPEN=1
 I $ZV["M3" S I=$ZM(20,$J,$J_" - M3-Lite Terminal")
 C:$D(TP) TP K %A,%B,%C,D,%E,XT,TP,CP,CPX,CPI Q
 ;
 ;
ENTRY D:'$D(ZAA02G) INIT^ZAA02GDEV K XW
 I $ZV["M3",MODEM="TCP" S I=$ZM(20,$J,$J_" - "_$G(ip)_" - M3-Lite Terminal")
 I $D(XT)=0 S XT="" ; I ZAA02G["PC" D IBM^ZAA02GINIT2 S PP=CH D DEC^ZAA02GINIT2 S DD=CH,XT="S A=$TR(A,DD,PP)"
 U 0 S:$D(TR)=0 TR=$C(20) W !!,"Terminal Mode - Press Control ",$C($A(TR)+64)," to exit",!! D O0 W !!,"Exit Terminal Mode",! Q
O0 S IT=2000,XW="" S:MODEM["TCP|" XW="W *-3" D TERMON,O1,TERMOF K TRM,T,S,XLT,CTR,IT,XW Q
O1 U D W:'$D(TELNET) *17 I @ZAA02G@("OS")'="DTM" F  H 0 D O2 Q:A[TR
 I @ZAA02G@("OS")="DTM" F  U 0 R A:0 X XT,T Q:A[TR  U D W A R A:0 X XT,TRM S B=A U 0 W A
 Q
O2 U D R A:0 X XT,TRM S B=A U 0 W A R A:1 X XT,T Q:A[TR  G:A_B="" O2 U D I A]"" W A X XW
 S CTR=$H F J=1:1:IT U 0 R A:0 X XT,T H 0 Q:A[TR  U D W:A]"" A X XW S:A'="" J=1 R A:0 X XT,TRM S B=A H 0 U 0 W A S:$L(A)+$L(B) J=1
 S:$P($H,",",2)-$P(CTR,",",2)<10 IT=IT+2000 Q
T4 X @ZAA02G@("TERM-ON"),@ZAA02G@("WRAP-OFF"),@ZAA02G@("ECHO-OFF") D HEAD^ZAA02GCOMM4 W ZAA02G("HI") S %C=1,%R=3 W @ZAA02GP,"Capture=",$S($D(CP):CP,1:"") S %C=74-$L(MODEM) W @ZAA02GP,"Modem=",MODEM,!
 S %R=4,%C=1 W @ZAA02GP,"Printer=",$S($D(TP):TP,1:"") I "M3,DTM,MSM"[@ZAA02G@("OS") S A="A="_$S(^("OS")="M3":"$ZN",^("OS")="MSM":"$ZU(0)",1:"$P($ZJOB($J),""|"",4)"),@A,A="Namespace="_A,%C=80-$L(A) W @ZAA02GP,A,!
 W !,"Enter -   C to toggle Capture Mode",?45,"P to toggle Printer Mode"
 W !?10,"S to Set escape character",?45,"T to enter Terminal Mode",!?10,"R to send or receive Routines",?45,"G to send or receive Globals"
 W !?10,"D to Dial a Number",?45,"M to change Modems",!?10,"E to Edit Script",?45,"X to eXecute Script",!?10,"L to downLoad remote ZAA02GCOMM",?45,"B to change BAUD rate",!
 W ?10,"U to change Directory",?45,"K for Kermit transfers",!,?10,"Q to Quit ZAA02GCOMM",?45,"O for cOmpare routines",!!,">>"
T5 R A#1 S:A?1L A=$C($A(A)-32)
 I A="" X ZAA02G("T") S ZF=$P(@ZAA02G@(.3),"\",$A(@ZAA02G@(.3,ZAA02G,0),$F(^(0),ZF))+2) S:ZF="EX" A="Q"
 G T5:A="" X @ZAA02G@("ECHO-ON"),@ZAA02G@("TERM-OFF")
 I A'="T" G @$P("ER,ER,PR,CP^ZAA02GCOMM4,ST^ZAA02GCOMM4,END,ROU,GLO,RDIAL^ZAA02GCOMM4,UCI^ZAA02GCOMM4,MOD,EDIT^ZAA02GCOMM7,RUN,DWNLD,BAUD,KERM,CMP^ZAA02GCOMM4",",",$F("PCSQRGDUMEXLBKO",A)+1)
 D ENTRY G T4
ER W *7 G T4
RUN D RUN^ZAA02GCOMM6 S D=MODEM G T4
ROU W ! D OS^ZAA02GCOMM S TYPE="R" D DIRECT^ZAA02GCOMM D FRC G T4
FRC U:MODEM="TCP" MODEM:(:"F") U 0 Q
GLO W ! D OS^ZAA02GCOMM S TYPE="G" D DIRECT^ZAA02GCOMM D FRC G T4
DWNLD W ! R "Are you sure you want to send ZAA02GCOMM2? (Y or N) " R A#1 G T4:A="",T4:"Yy"'[A D OS^ZAA02GCOMM,PRIME^ZAA02GCOMM2 G T4
BAUD D CBAUD^ZAA02GCOMM7 G T4
KERM D KERM^ZAA02GCOMMA G T4
MOD R !,"Enter New Modem Number - ",D,! G T4:D="" C MODEM S MODEM=D G DEV
CPX I $L(CPX)+$L(A)>250 S @CP@(CPI)=CPX_$E(A,1,250-$L(CPX)),CPX=$E(A,250-$L(CPX)+1,255),CPI=CPI+1 Q
 S CPX=CPX_A
CPX1 I CPX[$C(13,10) S @CP@(CPI)=$P(CPX,$C(13,10)),CPX=$P(CPX,$C(13,10),2,255),CPI=CPI+1 G CPX1
 Q
RESTART G RESTART^ZAA02GCOMM
TERMOF S DV=MODEM,A=ZAA02G(1),ZAA02G(1)=1 D LOFF S DV=0,ZAA02G(1)=A D:$G(QT)'=0 LOFF Q
TERMON D TERM S (D,DV)=MODEM,A=ZAA02G(1),ZAA02G(1)=0 D LON S ZAA02G(1)=A,DV=0 D:$G(QT)'=0 LON Q
TERM S A=" S:ZF=$C(26) ZF=$C(3) S:$C(0,255)'[ZF A=A_ZF" G:@ZAA02G@("OS")="MSM" TMSM S (TRM,T)=ZAA02G("T")_A I $g(opt)'["NO-NEG" S:$D(TELNET) TRM=TRM_" D:A[$C(255) NEG^ZAA02GCOMM1"
 D:@ZAA02G@("OS")="DTM" DTM^ZAA02GCOMM4 Q
TMSM S TRM="S ZF=$S($ZB>31&($ZB<128):$C(0),1:$C($ZB#256))"_A S:$D(TELNET) TRM="S ZF=$C(0) D:A[$C(255) NEG^ZAA02GCOMM1"
 I ZAA02G'["VT" S T="S ZF=$S($ZB\256:$C(27,$ZB\256),$ZB=127:$C(27,126),$ZB=8:$C(127),$ZB>31:$C(0),1:$C($ZB#256)) X:$ZB=0&(A=$C(0)) ""R *ZF:0 S ZF=$S(ZF<1:$C(0),1:$C(27,ZF))"" S:$D(XLT(ZF)) ZF=XLT(ZF) "_A D MSM^ZAA02GCOMM4 Q
 S T="S ZF=$S($ZB#256=27:$C(27,$ZB\256),$ZB>31&($ZB<127):$C(0),1:$TR($C($ZB#256),$C(8),$C(127))) S:$D(XLT(ZF)) ZF=XLT(ZF) "_A D MSMV^ZAA02GCOMM4 Q
LON Q:$G(TELNET)=DV  B 0 I @ZAA02G@("OS")="M3" U DV:(:"SI") Q
 I @ZAA02G@("OS")="MSM" U DV:(0::::1+4+4096+262144+8388608+(DV=0*64):(DV>0*64)+1048576:::$C(13,8,127)) Q
 X LTERMON,LECHOF S ZAA02G(1)=ZAA02G(1)+.01 I @ZAA02G@("OS")="DTM" U:DV'=0 DV:IXXLATE=0 U:DV=0 0:VT=1
 Q
LOFF Q:$G(TELNET)=DV  B 1 I @ZAA02G@("OS")="M3" U DV:(:"") Q
 I @ZAA02G@("OS")="MSM" U DV:(0::::1+1048576:8388608:::$C(13)) Q
 I DV=0,@ZAA02G@("OS")="DTM" U 0:VT=0
 S ZAA02G(1)=ZAA02G(1)\1 X LECHON,LTERMOF Q
ERR U 0 S DV=0 X LECHON S B="B="_@ZAA02G@("ERRORR"),@B I $D(TELNET),B["DSCON"!(B["NOPE") W !,"No Connection to telnet port" K TELNET
 E  W !,B
 R !,"press RETURN to continue " R A#1 G BEG
NEG D NEG2 Q
 S ^MARK("NEG")=A D NEG2 S ^MARK("RSP")=rsp,^MARK("NEGA")=A Q
NEG2 S rsp="" F Jj=1:1 Q:A'[$C(255)  S J=$E($P(A,$C(255),2),1,2) D
 . I $A(J)<251 S J=$E(J,1,$A(J)=250*2+1)
 . E  I $L(J)<2 U D R B#1:5 S A=A_B,J=J_B I $L(J)<2 R B#1:5 S A=A_B,J=J_B
 . S A=$P(A,$C(255)_J,2,99)
 . I $L(J)=2 U 0 W:$G(SHOW) "<",$P("WILL,WON'T,DO,DON'T",",",$A(J)-250),"-",$A(J,2)," (",$P("Binary,Echo,Reconnect,Suppress GA,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,",",",$A(J,2)+1),") >",! D NEG1
 I '$D(Neg) S Neg=1 S:0 rsp=rsp_$C(255,251,24,255,253,1) S:0 rsp=rsp_$C(255,253,3) S:rsp[$C(255,251,24) rsp=rsp_$C(255,250,24,0)_"VT340"_$C(255,240) U D W rsp,!
 Q
NEG1 I $A(J)=251,$C(1,3)[$E(J,2) S rsp=rsp_$C(255,253,$A(J,2)) Q
 I $A(J)=253 S rsp=rsp_$C(255,251,$A(J,2)) Q
 S rsp=rsp_$C(255,252,$A(J,2)) Q
A S a="test"
 s a="s d=""file"" o d:("""_a_""") u d x:$zc ""u 0 w """"file "_a
 s a=a_" missing"""" h 5 q"" u d zl  c d u 0 g +1" Q
