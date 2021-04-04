%ZAA02GEDDI
FUNC D INIT:'$D(ZAA02G),GLOBAL:'$D(GL) Q:GL=""  S ZAA02G("G")=GL,ZAA02G("OS")=@GL@("OS"),ZAA02G("TON")=^("TERM-ON"),ZAA02G("TOF")=^("TERM-OFF"),ZAA02G("WON")=^("WRAP-ON"),ZAA02G("WOF")=^("WRAP-OFF"),ZAA02G("EON")=^("ECHO-ON"),ZAA02G("EOF")=^("ECHO-OFF")
	S ZAA02GY=@GL@(.3),ZAA02GX=@GL@(.3,ZAA02G,0),X=$S($D(@GL@(.1,ZAA02G,7)):^(7),1:""),ZAA02G(132)=$P(X,"\"),ZAA02G(80)=$P(X,"\",2),ZAA02G("ION")=$P(X,"\",3),ZAA02G("IOF")=$P(X,"\",4)
	K GL Q
INIT D GLOBAL Q:GL=""  K ZAA02G K:$D(@GL@("$I")) @GL@($I)
INIT2 G:$D(@GL@($I)) INIT1 Q:'$D(@GL)  S ZAA02G=$O(@GL@(0,"")) I $O(^(ZAA02G))="" G INIT3
	D VT I A'="",$D(@GL@(0,A)) G INIT3
	S A=$O(@GL@(.1,ZAA02G)) I A["VT",$O(^(A))="" G INIT3
	D DEV Q:'$D(@GL@($I))  G INIT2
INIT1 S ZAA02G=@GL@($I)
INIT3 S ZAA02G("d")=$S('$D(@GL@("DATEF")):0,1:^("DATEF")),ZAA02G("T")=^("TERMST"),ZAA02GP=@GL@(0,ZAA02G,"P"),ZAA02G(1)=0 S:$D(^("a")) ZAA02G("a")=^("a"),ZAA02G("RON")="",ZAA02G("ROF")="",ZAA02G("UO")="",ZAA02G("UF")="" F ZAA02GI=0:1:5 I $D(^(ZAA02GI)) X ^(ZAA02GI)
	W ^("SET") H:$L(^("SET"))>20 2 X:$D(@GL@(.1,ZAA02G,1)) ^(1) K ZAA02GI
	Q
GLOBAL N ER S ER=0
G1 S GL=$S($zv["M3"&($D(^%T)):"^%T",$D(^%ZAA02G):"^%ZAA02G",$D(^ZAA02G):"^ZAA02G",1:"") I GL="" Q:ER  D ^ZAA02GINIT S ER=1 G G1
	Q
VT S A="",ZAA02G(1)=0 X @GL@("ECHO-OFF") W *27,"[c" F J=0:1:60 R *B:2 Q:'$T  S:J A=A_$C(B) X @GL@("TERMST") S:ZF'="" A=A_ZF Q:B=99  Q:$E(A,$L(A))="c"
	X @GL@("ECHO-ON") S A=$TR(A,$C(0),""),A=$S(A["?62":"VT220T",A["?63":"VT220T",A["?64":"VT220T",A["?":"VT100",A?.E1";".E1"c":"VT220T",1:"")
	I A="VT220T",'$D(@GL@(0,A)),$D(@GL@(0,"VT220")) S A="VT220"
	I $I=1,@GL@("OS")="MSM",$D(^%T(0,"MSMPC COLOR")) S ZAA02G="MSMPC COLOR"
	S ZAA02G=A Q
DEV S A=$I W !!,"This device has not been defined to the PG&A Toolkits.",!!
DEV1 W "Select your terminal from the following list..."
DEV2 S B="" F I=1:1 S B=$O(@GL@(0,B)) Q:B=""  W !,$J(I,2),") ",B S I(I)=B
	W !
DEVT R !,"Which one are you? ",B G:B="?" DEV1 I B>0,B<I S ^%T(A)=I(B) W "  ...now defined as ",I(B),!! K ZAA02G Q
	I B'="" W " ???" G DEVT
	W ! Q
	;
	;