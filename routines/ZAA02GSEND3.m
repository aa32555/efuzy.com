ZAA02GSEND3  ;;2014-07-10 17:23:46
ZAA02GSEND3 ;PG&A,ZAA02G-SEND,1.36,GLOBALS;3JAN95 5:27P;;;28JAN98  23:41
 ;Copyright (C) 1983, Patterson, Gray and Associates, Inc.
 ;
 G REMRCV:DIRECT="L",REMXMT
LOCXMT D INIT D:'$D(SGLOBAL) SELECT I $D(SGLOBAL) S %N=-1,(%G,%GN)=SGLOBAL S:%G[":" %GN=$P(%G,":",2),%G=$P(%G,":") D SYNTX
 I %N W !! U MODEM D LIST
 S %X="",CM=0 U MODEM D XFR U 0 W:%N !!,"GLOBAL TRANSFER COMPLETED",! G EXIT
REMXMT W:0 $C(1),"001Y" X ECHOON S GSEL=SEL D INIT,SELECT X ECHOOFF W *20 G EXIT:%N=0 D LIST
 S %X="",CM=0 D XFR
EXIT K RT,J,N,RTA,CC,CO Q
INIT S (CL,CC)=0,CM=1,(CA,CS,CT)="",CA="",$P(CA,"X",196)="" F J=0:1:31,127:1:180 S CS=CS_$C(J)
 F J=181:1:255 S CT=CT_$C(J)
 Q
SELECT U 0 R !,"Single or Multiple globals (S or M) > ",S G:S'="M" READ
 S %N=1 X GSEL Q
READ S %N=0 R !!,"Global> ^",%G Q:%G=""  G QUES:%G="?" D SYNTX I %T<0 W *7,"  Syntax Error." G READ
 I '$D(@%G) W *7,"  Not found." G READ
 R !!,"Change Name? (N):",%GN S:"N"[%GN %GN=$P(%G,"(") I %GN="Y" R "  TO: ^",%GN,! S:$E(%GN)'="^" %GN="^"_%GN
 S %N=-1 Q
SYNTX S:'($E(%G)="^") %G="^"_%G S %T=$S(%G'["(":0,$E(%G,$L(%G))=")":2,$P(%G,"(",2)]"":0,1:-1),%S=$P(%G,"(",2,99),%S=$P(%S,")"),%G=$P(%G,"(") Q
 ;
LIST S SIZE=300 I %N<0 D RDY Q
 S %GG=0 F %I=1:1 S %GG=$O(^UTILITY(%J,%GG)) Q:%GG=""  S (%GN,%G)="^"_%GG X:MODEM'=0 "U 0 W !!!,%GG,!" D SYNTX,RDY ;D ALL:LOS="PSM",RDY:LOS'="PSM"
 Q
RDY S %L=0,%K=9 F %I=1:1:10 S %I(%I)="",%A=$P(%S,",",%I) I %A'="" S:%A["*" %A=$P(%A,"*",1),%K=%I I %A'="" S:%I-1=%L %L=%I S:%A["""" %A=$P(%A,"""",2) S %I(%I)=%A
 S %S=%G_"(%I(1),%I(2),%I(3),%I(4),%I(5),%I(6),%I(7),%I(8),%I(9),%I(10)"
 S:%T>0 %T=%L S:%L=0 %L=1 I $L(%I(1)) S %A=$D(@($P(%S,",",1,%L)_")")) G I:%A=0 S %A=%I(%L) G J
 I $D(@%G)#10 S %D=@%G,%X=%GN D XFR S %X=%D,CM=1 D XFR
I S %A=$O(@($P(%S,",",1,%L)_")")),%I(%L)=%A I %A="" S %L=%L-1 G END:%T'<%L,I
J S %D=$D(^(%A)) G:%K=%L KK I %D=10 S %L=%L+1 G I
 I %D=11 D WRITE S %L=%L+1 G I
 D WRITE S %A=$O(^(%I(%L))),%I(%L)=%A G:$L(%A) J S %L=%L-1 G END:%T'<%L,I
KK D:$D(^(%A))#2 WRITE G I
 ;
END Q
QUES D ^%GL1 G READ
ALL S %A=%G I $D(@%A)#10 S %X=%GN,%Z=@%A D W2
ALL1 S %A=$ZZ(1,"","",@%A@("")) Q:%A=""  S %X=%A,%Z=@%A D W2 G ALL1
 ;
WRITE S %X=%GN_"(" F %I=1:1:%L S %XX=%I(%I) D:%XX["""" QUOTE S %X=%X_""""_%XX_""","
WR S (%XX,%X)=$E(%X,1,$L(%X)-1)_")",%Z=^(%A)
 ; I %Z[$C(1,1),$L(%Z,$C(1))=4,%GN["ZAA02G" S %Z=$P(%Z,$C(1),4)
W2 I $TR(%Z,CS_CT,"")=%Z D XFR S %X=%Z,CM=CL<SIZE D XFR Q
 S %X="{"_%X D XFR S A=$E(%Z,1,85) D CTL,XFR S A=$E(%Z,86,172) D CTL,XFR S A=$E(%Z,173,999),CM=CL<SIZE D CTL,XFR Q
 ;
QUOTE F %II=1:2:$L(%XX,"""")-1*2 S $P(%XX,$C(34),%II)=$P(%XX,$C(34),%II)_$C(34)
 Q
CTL I $TR(A,$C(123,125),"")'=A S %X=A,A="",M=$TR(%X,$C(88,123,125)," "_CA),(T,F)=0 F i=2:1:$L(M,"X") S F=$F(M,"X",F),A=A_$E(%X,T,F-2)_"{"_$E(%X,F-1),T=F
 I  S A=A_$E(%X,F,999)
 S %X="",M=$TR(A,"X"_CS," "_CA),(T,F)=0 F i=2:1:$L(M,"X") S F=$F(M,"X",F),G=$A(A,F-1),%X=%X_$E(A,T,F-2)_$C(123,$S(G>31:G-62,1:G+32)),T=F
 S A=%X_$E(A,F,999),%X="",M=$TR(A,"X"_CT," "_CA),(T,F)=0 F i=2:1:$L(M,"X") S F=$F(M,"X",F),%X=%X_$E(A,T,F-2)_$C(125,$A(A,F-1)-148),T=F
 S %X=%X_$E(A,F,999) Q
XFR I MODEM'=0,$G(QT)'=0 U 0 W "." I $X>78 W !,%XX
 S CC=CC+1,CC(CC)=%X,CL=CL+$L(%X) Q:CM  S CM=1
XFR1 U MODEM D XFR2 I rL>0,MM="Y" W $C(1),$E(1001+$L(CC)+$L(CL),2,4),CC,",",CL K CO S COL=CL,CO=CC F JJ=1:1:CC W $C(1),$E(1000+$L(CC(JJ)),2,4),CC(JJ) S CO(JJ)=CC(JJ)
 W ! I MM="Y" K CC S (CC,CL)=0 S:MODEM'=56 SIZE=2000 Q
 Q:'$D(CO)  R %XB:4 X:MODEM'=0 "U 0 W MM,%XB U MODEM " H 1 W $C(1),$E(1001+$L(CO_COL),2,4),CO,",",COL F JJ=1:1:CO W $C(1),$E(1000+$L(CO(JJ)),2,4),CO(JJ)
 W ! G XFR1
XFR2 S rL=-1 F rT=1:1 R *MM:10 Q:MM<0  I MM=1 S MM="" R rL#3:4 Q:'rL  R MM#rL:4 Q
 Q
 ;
REMRCV X ECHOFN W $C(1),"001Y" D RCV Q
LOCRCV I $D(RGLOBAL) U MODEM H 1 W "S",*13 H 1 W $P(RGLOBAL,":"),*13 H 1 X:RGLOBAL[":" "W ""Y"",*13 H 1 W $P(RGLOBAL,"":"",2)" W *13 H 1 G LOCR2
 U 0 W !,"Please answer the global selection questions from the remote site:",!!,ZAA02G("RON")
LOCR1 S D=MODEM,XT="I B[TR S J=200,A=B,B=""""",B="" D ENTRY^ZAA02GSEND1 W ZAA02G("ROF"),!!
 S DV=MODEM X LECHOFN U 0 W !!,"Wait for transmission to complete...",!!
LOCR2 U MODEM W $C(1),"001Y",! D RCV
 U 0 W !,"Transmission completed",! Q
 ;
RCV D XFR2 G:rL<0 RCVER K CC S CL=0,AB=MM F JJ=1:1:+AB D XFR2 G:rL<0 RCVER S CC(JJ)=MM,CL=CL+$L(CC(JJ))
 G:CL'=$P(AB,",",2) RCVER W $C(1),"001Y" F JJ=1:1:+AB D RC1
 W ! Q:R=""  G RCV
RCVER S:'$D(AC) AC=MM X:MODEM'=0 "U 0 W *94 U MODEM" X "F JJ=1:1 R A:5 Q:'$T" W $C(1),"001N",! G RCV
RC1 S R=CC(JJ) Q:R=""  S JJ=JJ+1,C=CC(JJ) I $E(R)'["{" S @R=C Q:MODEM=0   G RC2
 D RC3 S B=D,JJ=JJ+1,C=CC(JJ) D RC3 S B=B_D,JJ=JJ+1,C=CC(JJ) D RC3 S R=$E(R,2,511),@R=B_D Q:MODEM=0
RC2 U 0 W "." W:$X>78 !,R U MODEM Q
RC3 S D=$P(C,"}") F I=2:1:$L(C,"}") S E=$P(C,"}",I),D=D_$S($E(D,$L(D))'["{":$C($A(E)+148),$$RCC(D):"}"_$E(E),1:$C($A(E)+148))_$E(E,2,511)
 S C=D,D=$P(C,"{") F I=2:1:$L(C,"{") S E=$P(C,"{",I) S @$S("}"[$E(E):$S($E(E)="":"D=D_""{""_$P(C,""{"",I+1),I=I+1",1:"D=D_E"),$A(E)>63:"D=D_$C($A(E)+62)_$E(E,2,511)",1:"D=D_$C($A(E)-32)_$E(E,2,511)")
 Q
RCC(x) F i=$l(x):-1:0 i $e(x,i)'="{" Q
 Q $L(x)-i#2
T D INIT S A="ABC{DEF}GHI"_$C(230,123,125,0,1,2,3,64,162,238,123,194,16,181,254,255)_"{ABC",AA=A D CTL W %X,! S C=%X D RC3 W AA,!,D,!,AA=D Q
