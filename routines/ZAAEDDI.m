ZAAEDDI
%ZAAEDDI ;;%ZAA-WORKS;1.24;SUBR: DEVICE INITIALIZATION;Tue, 14 Oct 2008  06:20
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
FUNC M ZAA=^ZAA(0,"VT220") D INIT^ZAA02,IN^ZAA02 S ZAAP=ZAA02GP Q 
INIT S GL="^ZAA" Q
INIT2 G:$D(@GL@($I)) INIT1 Q:'$D(@GL)  S ZAA=$O(@GL@(0,"")) I $O(^(ZAA))="" G INIT3
        D VT I A'="",$D(@GL@(0,A)) G INIT3
        S A=$O(@GL@(.1,ZAA)) I A["VT",$O(^(A))="" G INIT3
        D DEV Q:'$D(@GL@($I))  G INIT2
INIT1 S ZAA=@GL@($I)
INIT3 S ZAA("d")=$S('$D(@GL@("DATEF")):0,1:^("DATEF")),ZAA("T")=^("TERMST"),ZAAP=@GL@(0,ZAA,"P"),ZAA(1)=0 S:$D(^("a")) ZAA("a")=^("a"),ZAA("RON")="",ZAA("ROF")="",ZAA("UO")="",ZAA("UF")="" F ZAAI=0:1:5 I $D(^(ZAAI)) X ^(ZAAI)
        W ^("SET") H:$L(^("SET"))>20 2 X:$D(@GL@(.1,ZAA,1)) ^(1) K ZAAI
        Q
GLOBAL N ER S ER=0
G1 S GL=$S($zv["M3"&($D(^%T)):"^%T",$D(^%ZAA):"^%ZAA",$D(^ZAA):"^ZAA",1:"") I GL="" Q:ER  D ^ZAAINIT S ER=1 G G1
        Q
VT S A="",ZAA(1)=0 X @GL@("ECHO-OFF") W *27,"[c" F J=0:1:60 R *B:2 Q:'$T  S:J A=A_$C(B) X @GL@("TERMST") S:ZF'="" A=A_ZF Q:B=99  Q:$E(A,$L(A))="c"
        X @GL@("ECHO-ON") S A=$TR(A,$C(0),""),A=$S(A["?62":"VT220T",A["?63":"VT220T",A["?64":"VT220T",A["?":"VT100",A?.E1";".E1"c":"VT220T",1:"")
        I A="VT220T",'$D(@GL@(0,A)),$D(@GL@(0,"VT220")) S A="VT220"
        I $I=1,@GL@("OS")="MSM",$D(^%T(0,"MSMPC COLOR")) S ZAA="MSMPC COLOR"
        S ZAA=A Q
DEV S A=$I W !!,"This device has not been defined to the PG&A Toolkits.",!!
DEV1 W "Select your terminal from the following list..."
DEV2 S B="" F I=1:1 S B=$O(@GL@(0,B)) Q:B=""  W !,$J(I,2),") ",B S I(I)=B
        W !
DEVT R !,"Which one are you? ",B G:B="?" DEV1 I B>0,B<I S ^%T(A)=I(B) W "  ...now defined as ",I(B),!! K ZAA Q
        I B'="" W " ???" G DEVT
        W ! Q
