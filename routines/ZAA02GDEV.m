ZAA02GDEV 
	D:$D(^ZAA02G)=0 INITX K ZAA02G D INIT
BEG W !!!,"ZAA                                Device Maintenance Options",! X "F I=1:1:26 W ""===""" W "="
	W !!?5,"1. Select Terminal Type for an I/O Port",!?5,"2. Create and Edit New Device Type",!?5,"3. Edit Function Key Definitions",!
WHICH R " ? ",A Q:A=""  I A<1!(A>3) W " ???",! G WHICH
	W ! G DEV^ZAA02GDEV3:A=1 I A=3 D ^ZAA02GDEV3,INIT G ZAA02GDEV
	W !
NAME W *13,"Enter Device name (""*"" = wildcard, ? for List) > " R DV G BEG:DV="",LIST:DV["?" I $L(DV)>15 W "  15 character maximum",*7 H 2 S I=$L(DV)+22 D ERASE G NAME
	I DV'["*" G NEW:$D(^ZAA02G(0,DV))=0,EDIT
	S DV=$P(DV,"*"),N=$O(^ZAA02G(0,DV)) I N=""!($E(N,1,$L(DV))'=DV) W " ???" D ERASE G NAME
	I $E($O(^(N)),1,$L(DV))'=DV S DV=N G EDIT
	G LIST
NEW R " New Device? (No)> ",*Y S I=$S(Y=89:"es",Y=78:"o",Y=13:"No",1:"  ???") W I I Y'=89 H 2 S I=$L(DV)+$L(I)+20 D ERASE G NAME
EDIT W !!!!,"ZAA" S X="*** "_DV_" ***" W ?(^ZAA02G("Col")-$L(X)/2),X S X="Device Definition" W ?(^ZAA02G("Col")-$L(X)),X,! X "F I=1:1:26 W ""===""" W "="
	S H="" S:$D(^ZAA02G(0,DV,"V")) H=^("V") W !!,"Is this device a Video terminal or a Printer? (V or P) > " I H'="" S H=$E("PV",H+1) W "(",H,") "
SEQ1 R E#1 I H=""&(E=""!("PV"'[E))!(H'=""&(E'="")&("PV"'[E)) W "  ???",*7 S I=6 H 2 D ERASE G SEQ1
	G ^ZAA02GDEV1
OK W !!?5,"O.K.  (Yes)> "
O1 R *X G EDIT:X=78 I X=13!(X=89) W !! G NAME
	W "  ???",*7 H 2 S I=6 D ERASE G O1
EXIT K NC,CN,CT,C,XC,Q,D,O,SB,T,X,I,H,DV,D,C,A,B,E Q
ERASE X "F I=I:-1:1 W $C(8,32,8)" Q
	W ! Q
	;
LIST W !! S N="" F I=0:0 S N=$O(^ZAA02G(0,N)) Q:N=""  W N,$J("",19-$L(N)) W:$X>70 !
	W !! G NAME
	;
INIT K ZAA02G S ZAA02G(3)=$S($D(ZAA02GUSER):ZAA02GUSER,1:$I) K:$D(^ZAA02G("$I")) ^ZAA02G(ZAA02G(3)) I $D(^ZAA02G(ZAA02G(3))),$D(^ZAA02G(0,^(ZAA02G(3))))=0 K ^ZAA02G(ZAA02G(3))
INIT2 D ^ZAA02GINIT:$D(^ZAA02G(0))=0 S ZAA02G=$O(^ZAA02G(0,"")) I $O(^(ZAA02G))="" S ^ZAA02G(ZAA02G(3))=ZAA02G G INIT1
	I $I'=1,ZAA02G["PC" S ZAA02G=$O(^ZAA02G(0,ZAA02G)) I $O(^(ZAA02G))="",ZAA02G["VT" S ^ZAA02G(ZAA02G(3))=ZAA02G G INIT1
	I $D(^ZAA02G(ZAA02G(3))) G INIT1
	D VT I A'="",$D(^ZAA02G(0,A)) S ^ZAA02G(ZAA02G(3))=A G INIT1
	S A=$O(^ZAA02G(0,ZAA02G)) I A["VT",$O(^(A))="" S ^ZAA02G(ZAA02G(3))=ZAA02G G INIT1
	W !!,"This device is not defined to the ZAA Toolkit",!! S (A,AA)=ZAA02G(3) D DEV1^ZAA02GDEV3 S ZAA02G(3)=AA G INIT2
INIT1 S ZAA02G=$S($D(ZAA02GDEVICE):ZAA02GDEVICE,1:^ZAA02G(ZAA02G(3))),ZAA02G("d")=$S('$D(^("DATEF")):0,1:^("DATEF")),ZAA02G("T")=^("TERMST"),ZAA02G(1)=0,ZAA02GP=^(0,ZAA02G,"P") F ZAA02GI=0:1:5 I $D(^(ZAA02GI)) X ^(ZAA02GI)
	S:$D(^ZAA02G(0,ZAA02G,"a")) ZAA02G("a")=^("a"),ZAA02G("RON")="",ZAA02G("ROF")="",ZAA02G("UO")="",ZAA02G("UF")=""
	W ^("SET") H:$L(^("SET"))>20 2 X:$D(^ZAA02G(.1,ZAA02G,1)) ^(1) K ZAA02GI
	Q
	;
FUNC D INIT:'$D(ZAA02G) S ZAA02GY=^ZAA02G(.3),ZAA02GX=^(.3,ZAA02G,0) Q
	;
VT S A="",ZAA02G(1)=1 X ^ZAA02G("TERM-OFF"),^ZAA02G("ECHO-OFF") W *27,"[c" F J=0:1:70 R *B:2 Q:'$T  S:J A=A_$C(B) X ^ZAA02G("TERMST") S:ZF'="" A=A_ZF Q:B=99  Q:$E(A,$L(A))="c"
	X ^ZAA02G("ECHO-ON") S A=$TR(A,$C(0),""),A=$S(A["1;8c"&($D(^ZAA02G(0,"MSMPC COLOR"))):"MSMPC COLOR",A["42c"&$D(^ZAA02G(0,"3153")):"3153",A["?63;2c"&$D(^ZAA02G(0,"VT220T")):"VT220T",A["?":"VT220",A?.E1";".E1"c":"VT220",1:"") Q
	Q
INITX
	I '$D(^ZAA02GREAD) D
	. S ^ZAA02GREAD="D:$D(ZAA02G)=0 INIT^ZAA02GDEV N ZAA02Gi,ZAA02Gj S ZAA02Gi=0 F ZAA02Gj=0:0 X ^ZAA02GREAD(ZAA02Gi) Q:ZAA02Gi=99"
	. S ^ZAA02GREAD(0)="S ZAA02Gi=10,ZAA02Gl=$S($D(ZAA02GCC):ZAA02GCC,1:1),ESC=0,ZAA02Gf="""" S:$D(FNC) ZAA02Gf=FNC,FNC="""" X:$D(PROMPT) ^(2) S:$D(LNG)=0 LNG=79-%C S:ZAA02Gl>LNG ZAA02Gl=LNG"
	. S ^ZAA02GREAD(1)="S ZAA02Gi=3 F ZAA02Gj=0:0 R ZAA02GC#1:TIM S:'$T ZAA02Gi=16 Q:ZAA02GC=""""  S:$D(UC) ZAA02GC=$S(ZAA02GC?1L:$C($A(ZAA02GC)-32),1:ZAA02GC) S:$D(TRM) ESC=TRM[ZAA02GC S:ESC ZAA02Gi=""CR"" S:CHR'=""""&(CHR'[ZAA02GC) ZAA02Gi=7 Q:ZAA02Gi'=3  S:ZAA02Gl'<LNG ZAA02Gi=6 Q:ZAA02Gi'=3  W ZAA02GC S X=$E(X,1,ZAA02Gl-1)_ZAA02GC_$E(X,ZAA02Gl+1,255),ZAA02Gl=ZAA02Gl+1"
	. S ^ZAA02GREAD(2)="W @ZAA02GP,ZAA02G(""LO""),PROMPT,ZAA02G(""HI""),X S %C=%C+$L(PROMPT)"
	. S ^ZAA02GREAD(3)="X ZAA02G(""T"") S ZF=$P(^ZAA02G(.3),""\"",$A(^ZAA02G(.3,ZAA02G,0),$F(^(0),ZF))+2),ZAA02Gi=$S(ZF="""":7,ZAA02Gf[ZF:17,$D(^ZAA02GREAD(ZF)):ZF,1:7)"
	. S ^ZAA02GREAD(6)="S:ZAA02Gl>LNG ZAA02Gi=7 Q:ZAA02Gi=7  W ZAA02GC S X=$E(X,1,ZAA02Gl-1)_ZAA02GC_$E(X,ZAA02Gl+1,255),ZAA02Gl=ZAA02Gl+1,ZAA02Gi=$S($D(AUTO)#2=0:1,AUTO:""CR"",1:1)"
	. S ^ZAA02GREAD(7)="W *7 S ZAA02Gi=1"
	. S ^ZAA02GREAD(10)="S ZAA02Gi=1,ZAA02Gc=%C,%C=%C+ZAA02Gl-1 W @ZAA02GP,ZAA02G(""HI"") S %C=ZAA02Gc,X=X_$J("""",LNG-$L(X)),TIM=$S($D(TIM):TIM,1:99999) X ^ZAA02G(""TERM-ON""),^ZAA02G(""WRAP-OFF""),^ZAA02G(""ECHO-OFF"") S:$D(CHR)=0 CHR="""" S:$D(RX) RX=0"
	. S ^ZAA02GREAD(13)="S:X="""" ZAA02Gi=20 I X'="""" X:$D(PAT) ""I $L(PAT) S ZAA02Gi=19 I @PAT S ZAA02Gi=13"" X:ZAA02Gi=13 ""I $D(MAX),X>MAX S ZAA02Gi=19"" X:ZAA02Gi=13 ""I $D(MIN),X<MIN S ZAA02Gi=19"" S:ZAA02Gi=13 ZAA02Gi=20"
	. S ^ZAA02GREAD(16)="S RX=-1,ZAA02Gi=20"
	. S ^ZAA02GREAD(17)="S FNC=ZF,ZAA02Gi=""CR"""
	. S ^ZAA02GREAD(19)="S X=ZAA02Gc,(ZAA02Gi,ZAA02Gl)=1,ESC=0 S:$D(RX) RX=0 W *7,@ZAA02GP"
	. S ^ZAA02GREAD(20)="X ^ZAA02G(""ECHO-ON""),^ZAA02G(""TERM-OFF""),^ZAA02G(""WRAP-ON"") S:$D(ZAA02GCC) ZAA02GCC=ZAA02Gl K PROMPT,MAX,MIN,LNG,CHR,PAT,TRM,UC,ZF,TIM,ZAA02Gj,ZAA02Gc,ZAA02Gl,ZAA02Gf S ZAA02Gi=99"
	. S ^ZAA02GREAD("CR")="S ZAA02Gc=X,ZAA02Gi=13 S:ESC RX=ZAA02GC I $E(X,$L(X))="" "" F ZAA02Gj=0:0 S ZAA02Gj=$F(X,"" "",ZAA02Gj) Q:'ZAA02Gj  I $E(X,ZAA02Gj,255)?."" "" S X=$E(X,1,ZAA02Gj-2) Q"
	. S ^ZAA02GREAD("DC")="W $E(X,ZAA02Gl+1,256),"" "" S X=$E(X,1,ZAA02Gl-1)_$E(X,ZAA02Gl+1,256)_"" "",ZAA02Gi=1 W @ZAA02GP,$E(X,1,ZAA02Gl-1)"
	. S ^ZAA02GREAD("DK")="S ZAA02Gi=""CR"" S @$S(ZAA02Gf[ZF:""ZAA02Gf=ZF"",$D(RX):""RX=2"",1:""ZAA02Gi=7"")"
	. S ^ZAA02GREAD("EF")="S X=$E(X,0,ZAA02Gl-1)_$J("""",LNG-ZAA02Gl+1),ZAA02Gc=%C,%C=%C+ZAA02Gl-1,ZAA02Gi=1 W @ZAA02GP,$J("""",LNG-ZAA02Gl+1),@ZAA02GP S %C=ZAA02Gc K ZAA02Gc"
	. S ^ZAA02GREAD("IC")="X $S($E(X,LNG)'="" "":""W *7"",1:""W """" """",$E(X,ZAA02Gl,LNG-1) S X=$E(X,1,ZAA02Gl-1)_"""" """"_$E(X,ZAA02Gl,LNG-1) W @ZAA02GP,$E(X,1,ZAA02Gl-1)"") S ZAA02Gi=1"
	. S ^ZAA02GREAD("LK")="X $S(ZAA02Gl>1:""S ZAA02Gl=ZAA02Gl-1,ZAA02Gi=1 W ZAA02G(""""L"""")"",$D(RX):""S RX=4,ZAA02Gi=""""CR"""""",1:""S ZAA02Gi=1"")"
	. S ^ZAA02GREAD("RK")="X $S(ZAA02Gl<LNG:""W ZAA02G(""""RT"""") S ZAA02Gl=ZAA02Gl+1,ZAA02Gi=1"",$D(RX):""S RX=5,ZAA02Gi=""""CR"""""",1:""S ZAA02Gi=1"")"
	. S ^ZAA02GREAD("RU")="S ZAA02Gi=1 I ZAA02Gl>1 S X=$E(X,1,ZAA02Gl-2)_"" ""_$E(X,ZAA02Gl,256),ZAA02Gl=ZAA02Gl-1 W *8,"" "",*8"
	. S ^ZAA02GREAD("TB")="S ZAA02Gi=""CR"" S @$S(ZAA02Gf[ZF:""ZAA02Gf=ZF"",$D(RX):""RX=3"",1:""ZAA02Gi=7"")"
	. S ^ZAA02GREAD("UK")="S ZAA02Gi=""CR"" S @$S(ZAA02Gf[ZF:""ZAA02Gf=ZF"",$D(RX):""RX=1"",1:""ZAA02Gi=7"")"  
	I '$D(^ZAA02G) D
	. S ^ZAA02G("Col")=160     
	. S ^ZAA02G("Row")=100
	. S ^ZAA02G="D:'$D(ZAA02G) INIT^ZAA02GDEV W:ZAA02G(""CSR"")]"""" @ZAA02G(""CSR"") S ZAA02G(1)=1 X ^ZAA02G(""TERM-OFF"") W:$L($P($G(^ZAA02G(.1,ZAA02G,7)),""\"",4)) @$P(^(7),""\"",4)"
	. S ^ZAA02G(0)="64951,47030"
	. S ^ZAA02G(0,"VT220",0)="S ZAA02G(""C"")=(^ZAA02G(""Col"")),ZAA02G(""R"")=(^ZAA02G(""Row"")),ZAA02G(""SET"")=$C(27,41,48),ZAA02G(""H"")=$C(27,91,72),ZAA02G(""U"")=$C(27,91,65),ZAA02G(""D"")=$C(27,91,66),ZAA02G(""RT"")=$C(27,91,67),ZAA02G(""L"")=$C(27,91,68)"
	. S ^ZAA02G(0,"VT220",1)="S ZAA02G(""F"")=$C(27,91,50,74,27,91,72),ZAA02G(""CL"")=$C(27,91,75),ZAA02G(""CS"")=$C(27,91,74),ZAA02G(""IN"")=$C(27,91,64),ZAA02G(""DL"")=$C(27,91,80),ZAA02G(""IL"")=""$C(27,91,76)"",ZAA02G(""DT"")=""$C(27,91,77)"""
	. S ^ZAA02G(0,"VT220",2)="S ZAA02G(""RON"")=$C(27,91,48,55,109),ZAA02G(""ROF"")=$C(27,91,50,55,109),ZAA02G(""HI"")=$C(27,91,49,109),ZAA02G(""LO"")=$C(27,91,50,50,109),ZAA02G(""UO"")=$C(27,91,48,52,109),ZAA02G(""UF"")=$C(27,91,50,52,109)"
	. S ^ZAA02G(0,"VT220",3)="S ZAA02G(""Z"")=$C(27,91,59,49,109),ZAA02G(""P"")=""$C(27,91)_%R_"""";""""_%C_""""H"""""",ZAA02G(""G1"")=$C(14),ZAA02G(""G0"")=$C(15),ZAA02G(""HL"")=$C(113),ZAA02G(""VL"")=$C(120),ZAA02G(""TLC"")=$C(108),ZAA02G(""TRC"")=$C(107)"
	. S ^ZAA02G(0,"VT220",4)="S ZAA02G(""BLC"")=$C(109),ZAA02G(""BRC"")=$C(106),ZAA02G(""TI"")=$C(119),ZAA02G(""RI"")=$C(117),ZAA02G(""BI"")=$C(118),ZAA02G(""LI"")=$C(116),ZAA02G(""X"")=$C(110),ZAA02G(""SR"")=""$C(27,91)_%R_"""";""""_%C_""""r"""""""
	. S ^ZAA02G(0,"VT220",5)="S ZAA02G(""CSR"")=""$C(27,91,114)"",ZAA02G(""UK"")=$C(27,91,65),ZAA02G(""DK"")=$C(27,91,66),ZAA02G(""RK"")=$C(27,91,67),ZAA02G(""LK"")=$C(27,91,68),ZAA02G(""INK"")=$C(27,91,50,126),ZAA02G(""DLK"")=$C(27,91,51,126)"
	. S ^ZAA02G(0,"VT220","BF")=$C(27)_"[25m"
	. S ^ZAA02G(0,"VT220","BI")="v"
	. S ^ZAA02G(0,"VT220","BLC")="m"
	. S ^ZAA02G(0,"VT220","BO")=$C(27)_"[5m"
	. S ^ZAA02G(0,"VT220","BRC")="j"
	. S ^ZAA02G(0,"VT220","C")=^ZAA02G("Col")
	. S ^ZAA02G(0,"VT220","C1")=$C(27)_"[31m"
	. S ^ZAA02G(0,"VT220","C2")=$C(27)_"[32m"
	. S ^ZAA02G(0,"VT220","C3")=$C(27)_"[33m"
	. S ^ZAA02G(0,"VT220","C4")=$C(27)_"[34m"
	. S ^ZAA02G(0,"VT220","C5")=$C(27)_"[35m"
	. S ^ZAA02G(0,"VT220","CL")=$C(27)_"[K"
	. S ^ZAA02G(0,"VT220","COF")=$C(27)_"[38m"
	. S ^ZAA02G(0,"VT220","CON")=$C(27)_"[6m"
	. S ^ZAA02G(0,"VT220","CS")=$C(27)_"[J"
	. S ^ZAA02G(0,"VT220","CSR")="$C(27,91,114)"
	. S ^ZAA02G(0,"VT220","CX")=^ZAA02G("Col")
	. S ^ZAA02G(0,"VT220","D")=$C(27)_"[B"
	. S ^ZAA02G(0,"VT220","DK")=$C(27)_"[B"
	. S ^ZAA02G(0,"VT220","EX")=$C(27)
	. S ^ZAA02G(0,"VT220","DL")=$C(27)_"[P"
	. S ^ZAA02G(0,"VT220","DLK")=$C(27)_"[3~"
	. S ^ZAA02G(0,"VT220","DT")="$C(27,91,77)"
	. S ^ZAA02G(0,"VT220","F")=$C(27)_"[2J"_$C(27)_"[H"
	. S ^ZAA02G(0,"VT220","G0")=$C(15)
	. S ^ZAA02G(0,"VT220","G1")=$C(14)
	. S ^ZAA02G(0,"VT220","H")=$C(27)_"[H"
	. S ^ZAA02G(0,"VT220","HI")=$C(27)_"[1m"
	. S ^ZAA02G(0,"VT220","HL")="q"
	. S ^ZAA02G(0,"VT220","IL")="$C(27,91,76)"
	. S ^ZAA02G(0,"VT220","IN")=$C(27)_"[@"
	. S ^ZAA02G(0,"VT220","INK")=$C(27)_"[2~"
	. S ^ZAA02G(0,"VT220","L")=$C(27)_"[D"
	. S ^ZAA02G(0,"VT220","LI")="t"
	. S ^ZAA02G(0,"VT220","LK")=$C(27)_"[D"
	. S ^ZAA02G(0,"VT220","LO")=$C(27)_"[22m"
	. S ^ZAA02G(0,"VT220","P")="$C(27,91)_%R_"";""_%C_""H"""
	. S ^ZAA02G(0,"VT220","R")=^ZAA02G("Row")
	. S ^ZAA02G(0,"VT220","R1")=$C(27)_"[41m"
	. S ^ZAA02G(0,"VT220","R2")=$C(27)_"[42m"
	. S ^ZAA02G(0,"VT220","R3")=$C(27)_"[43m"
	. S ^ZAA02G(0,"VT220","RI")="u"
	. S ^ZAA02G(0,"VT220","RK")=$C(27)_"[C"
	. S ^ZAA02G(0,"VT220","ROF")=$C(27)_"[27m"
	. S ^ZAA02G(0,"VT220","RON")=$C(27)_"[07m"
	. S ^ZAA02G(0,"VT220","RT")=$C(27)_"[C"
	. S ^ZAA02G(0,"VT220","SET")=$C(27)_")0"
	. S ^ZAA02G(0,"VT220","SR")="$C(27,91)_%R_"";""_%C_""r"""
	. S ^ZAA02G(0,"VT220","TI")="w"
	. S ^ZAA02G(0,"VT220","TLC")="l"
	. S ^ZAA02G(0,"VT220","TRC")="k"
	. S ^ZAA02G(0,"VT220","U")=$C(27)_"[A"
	. S ^ZAA02G(0,"VT220","UF")=$C(27)_"[24m"
	. S ^ZAA02G(0,"VT220","UK")=$C(27)_"[A"
	. S ^ZAA02G(0,"VT220","UO")=$C(27)_"[04m"
	. S ^ZAA02G(0,"VT220","V")=1
	. S ^ZAA02G(0,"VT220","VL")="x"
	. S ^ZAA02G(0,"VT220","X")="n"
	. S ^ZAA02G(0,"VT220","Z")=$C(27)_"[;1m"
	. S ^ZAA02G(0,"VT220","fof")=$C(27)_"\?"
	. S ^ZAA02G(0,"VT220","foft")="S P4=$A(JJ)>159*-32+$A(JJ)-33,P1=$A(JJ,2)>159*-32+$A(JJ,2)-33,P2=$A(JJ,3)>159*-32+$A(JJ,3)-33,P3=$A(JJ,4)>159*-32+$A(JJ,4)-33"
	. S ^ZAA02G(0,"VT220","fon")=$C(27)_"P1}"
	. S ^ZAA02G(0,"VT220","fost")="S X=$C(P4>94*32+P4+33,P1>94*32+P1+33,P2>94*32+P2+33,P3>94*32+P3+33)"
	. S ^ZAA02G(.1,"VT220",1)="W *27,"" F"",*27,""[?7;8h"",*27,""[?1;4;68l"",*27,""[4l"",*27,""*<"",*27,"")0"",*27,""}"""
	. S ^ZAA02G(.1,"VT220",2)="27,91,54,126`27,91,53,126`27,91,50,52,126`27,91,50,53,126`27,91,50,54,126`27,91,49,56,126`27,91,49,55,126`27,91,51,52,126`27,91,51,50,126`27,91,50,56,126`27,91,51,49,126`27,91,49,57,126`27,91,50,49,126`27,91,50,48,126`27,79,83"
	. S ^ZAA02G(.1,"VT220",3)="```````````````27,91,49,126`27,91,50,57,126`27,91,51,51,126`27,91,50,51,126`27,79,80`27,91,52,126`27,79,82```27,79,81`1`5`6"
	. S ^ZAA02G(.1,"VT220",5)="NEXT SCREEN`PREV SCREEN`F12`F13`F14`F7`F6`F20`F18`HELP`F17`F8`F10`F9`PF4"
	. S ^ZAA02G(.1,"VT220",6)="```````````````FIND`DO`F19`F11`PF1`SELECT`PF3`INSERT HERE`REMOVE`PF2`Ctrl A`Ctrl E`Ctrl F"
	. S ^ZAA02G(.1,"VT220",7)="S ZAA02G(""C"")=^ZAA02G(""Col"") W *27,*91,""?3h""\S ZAA02G(""C"")=^ZAA02G(""Col"") W *27,*91,""?3l""\$C(27)_""[4h""_$C(27)_""[?7l""\$C(27)_""[4l""_$C(27)_""[?7h"""
	. S ^ZAA02G(.3)="ER\\\\\\\\\\TB\\\\CR\\\\\\\\\\\\\\ES\\\\\RU\UK\DK\RK\LK\IC\DC\PD\PU\FP\SU\SD\IL\DL\EF\ST\HL\OT\CP\BO\FM\EK\GO\RE\CT\EX\GW\SE\HK\XX\YY\GE\HO\ZZ\WW"
	. S ^ZAA02G(.3,"VT220",0)=$C(0,13,13,9,9,27,27,27,127)_" "_$C(27)_"[A!"_$C(27)_"[B"""_$C(27)_"[C#"_$C(27)_"[D$"_$C(27)_"[2~%"_$C(27)_"[3~&"_$C(1)_"@"_$C(5)_"A"_$C(6)_"B"_$C(8)_" "_$C(27)_"[6~'"_$C(27)_"[5~("_$C(27)_"[24~)"_$C(27)_"[25~*"_$C(27)_"[26~+"_$C(27)_"[18~,"_$C(27)_"[17~-"_$C(27)_"[34~."_$C(27)_"[32~/"_$C(27)_"[28~0"_$C(27)_"[31~1"_$C(27)_"[19~2"_$C(27)_"[21~3"_$C(27)_"[20~4"_$C(27)_"OS5"_$C(27)_"[1~6"_$C(27)_"[29~7"_$C(27)_"[33~8"_$C(27)_"[23~9"_$C(27)_"OP:"_$C(27)_"[4~;"_$C(27)_"OR<"_$C(27)_"OQ?"
	. S ^ZAA02G(0)="S ZAA02G(""C"")=(^ZAA02G(""Col"")),ZAA02G(""R"")=(^ZAA02G(""Row"")),ZAA02G(""SET"")=$C(27,41,48),ZAA02G(""EX"")=$C(27),ZAA02G(""H"")=$C(27,91,72),ZAA02G(""U"")=$C(27,91,65),ZAA02G(""D"")=$C(27,91,66),ZAA02G(""RT"")=$C(27,91,67),ZAA02G(""L"")=$C(27,91,68)"
	. S ^ZAA02G(1)="S ZAA02G(""F"")=$C(27,91,50,74,27,91,72),ZAA02G(""CL"")=$C(27,91,75),ZAA02G(""CS"")=$C(27,91,74),ZAA02G(""IN"")=$C(27,91,64),ZAA02G(""DL"")=$C(27,91,80),ZAA02G(""IL"")=""$C(27,91,76)"",ZAA02G(""DT"")=""$C(27,91,77)"""
	. S ^ZAA02G(2)="S ZAA02G(""RON"")=$C(27,91,48,55,109),ZAA02G(""ROF"")=$C(27,91,50,55,109),ZAA02G(""HI"")=$C(27,91,49,109),ZAA02G(""LO"")=$C(27,91,50,50,109),ZAA02G(""UO"")=$C(27,91,48,52,109),ZAA02G(""UF"")=$C(27,91,50,52,109)"
	. S ^ZAA02G(3)="S ZAA02G(""Z"")=$C(27,91,59,49,109),ZAA02G(""P"")=""$C(27,91)_%R_"""";""""_%C_""""H"""""",ZAA02G(""G1"")=$C(14),ZAA02G(""G0"")=$C(15),ZAA02G(""HL"")=$C(113),ZAA02G(""VL"")=$C(120),ZAA02G(""TLC"")=$C(108),ZAA02G(""TRC"")=$C(107)"
	. S ^ZAA02G(4)="S ZAA02G(""BLC"")=$C(109),ZAA02G(""BRC"")=$C(106),ZAA02G(""TI"")=$C(119),ZAA02G(""RI"")=$C(117),ZAA02G(""BI"")=$C(118),ZAA02G(""LI"")=$C(116),ZAA02G(""X"")=$C(110),ZAA02G(""SR"")=""$C(27,91)_%R_"""";""""_%C_""""r"""""""
	. S ^ZAA02G(5)="S ZAA02G(""CSR"")=""$C(27,91,114)"",ZAA02G(""UK"")=$C(27,91,65),ZAA02G(""DK"")=$C(27,91,66),ZAA02G(""RK"")=$C(27,91,67),ZAA02G(""LK"")=$C(27,91,68),ZAA02G(""INK"")=$C(27,91,50,126),ZAA02G(""DLK"")=$C(27,91,51,126)"
	. S ^ZAA02G("DATEF")=0
	. S ^ZAA02G("ECHO-OFF")="use $principal:(noecho:escape)"
	. S ^ZAA02G("ECHO-ON")="use $principal:(echo:escape)"
	. S ^ZAA02G("ERROR")="$ET"
	. S ^ZAA02G("ERRORR")="$ZSTATUS"
	. S ^ZAA02G("EXT")="$TR,511"
	. S ^ZAA02G("GETPRINTER")="S:$D(^ZAA02GDEVR(VDV)) VDV=^(VDV) S VDV=$S($G(^LPT(VDV))]"""":^(VDV),1:VDV)"
	. S ZAA02G("INIT")="K ZAA02G W:$D(^ZAA02G($I))=0 !!,""Device not defined to the Toolkit - Use ^ZAA02GDEV"",!! Q:$D(^($I))=0  S ZAA02G=^($I),ZAA02G(1)=0,ZAA02G(""T"")=^(""TERMST""),ZAA02GP=^(0,ZAA02G,""P"") X ""F ZAA02GI=0:1:5 I $D(^(ZAA02GI)) X ^(ZAA02GI)"" W ZAA02G(""SET"") K ZAA02GI,ZAA02G(""SET"")"
	. S ^ZAA02G("MARGIN")=0
	. S ^ZAA02G("MENU")=0
	. S ^ZAA02G("OS")="M11"
	. S ^ZAA02G("PAD")=$C(0)
	. S ^ZAA02G("REST")="S ZAA02G(1)=1 X ^ZAA02G(""TERM-ON"")"
	. S ^ZAA02G("SAD","GREF")=""_$C(1)
	. S ^ZAA02G("TERM-OFF")="S ZAA02G(1)=ZAA02G(1)-1 U:'ZAA02G(1) 0:(term=$C(13):width="_^ZAA02G("Col")_":escape:length="_^ZAA02G("Row")_")"
	. S ^ZAA02G("TERM-ON")="use 0:(term=$C(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,20,21,22,23,24,25,26,28,29,31,127):width="_^ZAA02G("Col")_":escape:length="_^ZAA02G("Row")_") S ZAA02G(1)=ZAA02G(1)+1"
	. S ^ZAA02G("TERMST")="S ZF=$S($ZB?1C.E:$ZB,1:$C(0))"
	. S ^ZAA02G("TERP")=3
	. S ^ZAA02G("TERP",1)=$C(19,19,19,19,19,19,19,19,19,19)_"C"_$C(19)_"S3"_$C(19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,3,3,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19)
	. S ^ZAA02G("WRAP-OFF")="U $principal:(nowrap:escape)"
	. S ^ZAA02G("WRAP-ON")="U:'ZAA02G(1) $principal:(wrap:escape)"
	. S ^ZAA02G("XLAT")=9
	. S ^ZAA02G("XLAT",1)=$c(2,0)_"Q"_$c(1,129,2,0)_"I"_$c(1,130,2,0)_"w"_$c(1,131,2,0)_"?"_$c(1,132,2,0)_"X"_$c(1,133,2,0)_"="_$c(1,134,2,0)_"V"_$c(1,135,2,0)_"A"_$c(1,136,2,0,15,1,137,2,0)_";"_$c(1,138,2,0)_"T"_$c(1,139,2,0)_">"_$c(1,140,2,0)_"@"_$c(1,141,2,0)_"Y"_$c(1,142,2,0)_"O"_$c(1,143,2,0)_"<"_$c(1,144,2,0)_"C"_$c(1,145,2,0)_"\"_$c(1,146,2,0)_"D"_$c(1,147,2,0)_"B"_$c(1,148,2,0)_"G"_$c(1,149,2,0)_"["_$c(1,150,2,0)_"H"_$c(1,151,2,0)_"P"_$c(1,152,2,0)_"K"_$c(1,153,2,0)_"M"_$c(1,154,2,0)_"R"_$c(1,155,2,0)_"S"_$c(1,156,4,27)_"[6~"_$c(1,158,4,27)_"[5~"_$c(1,159,5,27)_"[24~"_$c(1)_"?"_$c(5,27)_"[25~"_$c(1)_"?"_$c(5,27)_"[26~"_$c(1)_"?"_$c(5,27)_"[18~"_$c(1)_"?"_$c(5,27)_"[17~"_$c(1)_"?"_$c(5,27)_"[34~"_$c(1)_"?"_$c(5,27)_"[32~"_$c(1)_"?"_$c(5,27)_"[7~"_$c(1)_"?"_$c(5,27)_"[31~"_$c(1)_"?"_$c(5,27)_"[19~"_$c(1)_"?"_$c(5,27)_"[21~"_$c(1)_"?"_$c(5,27)_"[20~"_$c(1)_"?"_$c(3,27)_"OS"_$c(1)_"?"_$c(4,27)_"[1~"_$c(1)_"?"_$c(5,27)_"[29~"_$c(1)_"?"_$c(5,27)_"[33~"_$c(1)_"?"_$c(5,27)_"[23~"_$c(1)_"?"_$c(3,27)_"OP"_$c(1)_"?"_$c(4,27)_"[4~"_$c(1)_"?"_$c(3,27)_"OR"_$c(1)_"?"_$c(3,27)_"OQ"_$c(1)_"?"_$c(3,27)_"[A"_$c(1)_"?"_$c(3,27)_"[B"_$c(1)_"?"_$c(3,27)_"[D"_$c(1)_"?"_$c(3,27)_"[C"_$c(1)_"?"_$c(4,27)_"[2~"_$c(1)_"?"_$c(4,27)_"[3~"_$c(1)_"?"_$c(3,27)_"Ot"_$c(1)_"?"_$c(3,27)_"Ow"_$c(1)_"?"_$c(3,27)_"Op"_$c(1)_"?"_$c(3,27)_"On"_$c(1)_"?"_$c(3,27)_"Or"_$c(1)_"?"_$c(3,27)_"Os"_$c(1)_"?"_$c(3,27)_"Ov"_$c(1)_"?"_$c(3,27)_"Ol"_$c(1)_"?"_$c(3,27)_"Om"_$c(1)_"?"_$c(3,27)_"Ou"_$c(1)_"?"_$c(3,27)_"Oy"_$c(1)_"?"_$c(3,27)_"OM"_$c(1)_"?"_$c(3,27)_"Oq"_$c(1)_"?"_$c(3,27)_"Ox"_$c(1)_"?"
	D INIT^ZAA02GDEV 
	M ZAA02G=^ZAA02G
	Q
	;  
TEST
	D INIT K X,Y
	S B="Apples,Apricots,Bananas,Grapes,Grapefruit,Melons,Oranges,Peaches,Strawberries,Tangerines" W ZAA02G("F")
	F I="60\BLRWH\1\Sample\\","50\TLWH\2\\\","9\RBLW\5\\\","8\TRWH\1\\\" S Y=I_B D ^ZAA02
	S Y="25,4\TLRW\3\Multiple Selection\\"_B S (X(3),X(5),X(7))="" D ^ZAA02 K X
	X ^ZAA02G("WRAP-OFF") S %C=27,%R=11 W ZAA02G("HI"),@ZAA02GP,"THESE ARE 5 EXAMPLES OF PULL-DOWN OR POP-UP MENUS.",ZAA02G("LO") S %C=1,%R=13 F I=0:1:5 S %R=%R+1 W @ZAA02GP,$P($T(TEXT+I),";",2,9)
BEG1    R A W ZAA02G("F") S %R=20,%C=30 W @ZAA02GP,ZAA02G("LO"),"( You use the cursor keys, space bar, or first ",!?31,"character to move the selector - then press ",!?31,"RETURN to make the selection. )",ZAA02G("HI")
	F I=1,2 S %R=10,%C=32 W ZAA02G("UO"),@ZAA02GP,"POP-UP - REVERSE VIDEO - ",I," COLUMN",ZAA02G("UF") S Y="10\BLRH\"_I_"\Sample "_I_"\\"_B D POP
	S (%R,%C)=20 W @ZAA02GP,ZAA02G("CS")
	F I=1,3 S %R=10,%C=32 W ZAA02G("UO"),@ZAA02GP,"PULL-DOWN - REVERSE VIDEO - ",I," COLUMN",ZAA02G("UF") S Y="10\TLRH\"_I_"\\\Pick Fruit*,*,"_B D POP
	F I=1,2 S %R=10,%C=32 W ZAA02G("UO"),@ZAA02GP,"POP-UP - NORMAL VIDEO - ",I," COLUMN",ZAA02G("CL"),ZAA02G("UF") S Y="30\BLH\"_10_"\Pick One\\"_B D POP
	F I=2 S %R=10,%C=32 W ZAA02G("UO"),@ZAA02GP,"POP-UP - REVERSE VIDEO - NO LINES - ",I," COLUMN",ZAA02G("UF") S Y="15\RB\"_1_"\Pick One\\"_B D POP
	Q
	;
POP 
	D:$D(ZAA02G)=0 INIT
	S %R=12,%C=32 W @ZAA02GP,"Y = """,$E(Y,1,40),"..." D ^ZAA02 X ^ZAA02G("WRAP-OFF") Q
	;
IN      ;
	S r=$C(27)_"["_31_";1m"
	S rr=$C(27)_"["_31_";1;5;7m"
	S rb=$C(27)_"["_37_";1;7m"
	S e=$c(27)_"[0m"
	S black=$C(27)_"[30;1m"
	S red=$C(27)_"[31;1m"
	S green=$C(27)_"[32;1m"
	S yellow=$c(27)_"[33;1m"
	S blue=$C(27)_"[34;1m"
	S magenta=$C(27)_"[35;1m"
	S cyan=$C(27)_"[36;1m"
	S white=$c(27)_"[37;1m"
	S reset=$c(27)_"[0m"
	;
	S blackdbg=$C(27)_"[40m"
	S reddbg=$C(27)_"[41m"
	S greendbg=$C(27)_"[42m"
	S yellowdbg=$c(27)_"[43m"
	S bluedbg=$C(27)_"[44m"
	S magentadbg=$C(27)_"[45m"
	S cyandbg=$C(27)_"[46m"
	S whitedbg=$c(27)_"[47m"
	;
	S blacklbg=$C(27)_"[40;1m"
	S redlbg=$C(27)_"[41;1m"
	S greenlbg=$C(27)_"[42;1m"
	S yellowlbg=$c(27)_"[43;1m"
	S bluelbg=$C(27)_"[44;1m"
	S magentalbg=$C(27)_"[45;1m"
	S cyanlbg=$C(27)_"[46;1m"
	S whitelbg=$c(27)_"[47;1m"
	;
	S bold=$c(27)_"[1m"
	S ul=$C(27)_"[4m"
	S reversed=$C(27)_"[7m"
	;
	S clrsend=$C(27)_"[0J"
	S clrsstrt=$C(27)_"[1J"
	S clrsall=$C(27)_"[2J"
	;
	S clrlend=$C(27)_"[0K"
	S clrlstrt=$C(27)_"[1K"
	S clrlall=$C(27)_"[2K"
	;
	Q
	;
	;
BEGX D INIT X ^ZAA02G("TERM-ON"),^ZAA02G("WRAP-OFF"),^ZAA02G("ECHO-OFF")
	S TP=$P(Y,"\",2),TC=$S(TP["F":1,1:$P(Y,"\",3)),TF=Y+(Y<1),TT=$P($P(Y,"\"),",",2),TDP=$P(Y,"\",5)'=""*-1+23-$S('TC:22,TP["C":%R,+TT:TT,1:1) S:TC="" TC=1
	S TQN="Y",(TMM,TO,TA)=0,TEN="~",TS="S TX=Y(TO)",TMN=99999,TFK="",TOV=$S(TP["O":$C(+$P(TP,"O",2)),1:"*")
	I $D(Y(0)) S ZF=Y(0) D MF S TMN=$P(ZF,"\",9),TDP=$S(ZF<TDP&ZF:+ZF,1:TDP),TFK=$P(ZF,"\",2)
	I TS["`",TS'["""`" S TW=$P(Y(0),"\",4),TSP=$J("",^ZAA02G("Col")),TS="S TX=",TM=$S(TP["G":"_TVL_",1:"_") S:TM["T" TVL=ZAA02G("G1")_ZAA02G("VL")_ZAA02G("G0")_" " S TB="S:$L(TQ)+$L(TS)>255 TSX=$E(TS,1,$L(TS)-1),TS=""X TSX S TX=TX_"" S TS=TS_TQ"
	I  F TJ=1:1:$L(TW,"`") S:TJ>1 TSP(TJ)=TN S TI=$P(TW,"`",TJ),TN=$P(TI,";",2) Q:TI=""  S TQ="$E("_$S(TN["R":"$J("_$P(TI,";")_",",1:"$E("_$P(TI,";")_",1,")_(+TN)_")_TSP,1,"_(TJ<$L(TW,"`")+TN)_")"_$S(TJ<$L(TW,"`"):TM,1:"") X TB
	I TP["K" S TS=TS_" S:$D(TH) TZ=TC(TJ+1)-%C-1,TX=$E($J("""",TZ-$L(TX)\2)_TX_$J("""",TZ),1,TZ-1)"
	I TP["F" S TC(1)=TF,TW=^ZAA02G("Col")-TF-TF,TDP=TDP-(TP["L")-($P(Y,"\",4)'="")-($P(Y,"\",5)'=""*2)
	I TP["M",$D(X) S TJ=$P(X,";") K X S X=TJ F TJ=1:1 S ZF=$P(X,",",TJ) Q:ZF=""  S X(ZF)=""
	I TP["w" S TS=TS_" S:TX[""|"" TX(TO)=TX,TX=$TR(TX,""|"")"
	S:TDP<0 TDP=1 I $D(ZAA02ALT) S TQF="S TQ="""_ZAA02ALT_"""" K ZAA02ALT G OTH
	I 0'[TO,$D(@TQN@(TO)) S TO=$TR($S(+TO=TO:TO-1E-9,1:$E(TO,1,$L(TO)-1)_$C($A(TO,$L(TO))-1)_"~"),"`","_")
	S TQF="S TQ=""S TO=$O(@TQN@(TO)) S:TO"_$S(TEN?.N:">",1:"]")_"TEN TO=""""""""""" I TQN'="Y",$O(Y(0)) S TB=$O(Y(0)) I $D(Y(1))#2,Y(1)["\" D CMF
	G OTH:TQN'="Y",OTH:TP["Y" S TB=$P(Y,"\",6) F TA=1:1:$L(TB,",") S Y(TA)=$P(TB,",",TA)
	S:TDP*TC<TA TA=0
OTH S TN=TO G ^ZAA021
MF S TQN=$S($P(ZF,"\",3)]"":$P(ZF,"\",3),1:TQN),TS="S TX="_$S($P(ZF,"\",4)]"":$P(ZF,"\",4),1:"@TQN@(TO)"),TMO=$P(ZF,"\",7),TEN=$P(ZF,"\",8) K:TMO="" TMO
	S TO=$P(ZF,"\",5) S:TO_TQN="Y" TO=0 S:TEN="" TEN="~" Q
MFX S TQM=$O(Y(TQM)) Q:TQM=""  S ZF=Y(TQM) D MF X TQ Q
CMF S $P(TQF,"""",6)=" I TO="""""""" D MFX^ZAA02",TQM=0 S:$P(Y(1),"\",10)["R" TQF=$P(TQF,"S TQ=")_"S TQM="""""" D MFX^ZAA02 S TQ="_$P(TQF,"S TQ=",2,99)
	;
	;