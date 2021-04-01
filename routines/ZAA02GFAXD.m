ZAA02GFAXD ;PG&A,ZAA02G-FAX,1.36,UTILITY;14JUN95 1:21P [ 08/22/96   9:33 AM ];;;14SEP2006  14:01
 ;Copyright (C) 1991-1994, Patterson, Gray and Associates Inc.
 ;
 ;
DECODE ;DECODE X
 S (OX,A)=X,M=1,K=0,L=$L(X)
DE1 I W F K=M+3:1:L S A=$E(X,M,K) I $D(^ZAA02GFAXC(.2,A)) S:^(A)<64 Y=Y_(ZZ+^(A))_"+",W=0,ZZ=0 W:0 A,"=",^(A)," " Q:'W   S M=K+1,ZZ=^(A) G DE1
 I W S X=$E(X,M,999) Q
 S YY="YY="_Y_Y2,@YY W:0 "(",YY,") " I YY>1727 S X=$E(X,K+1,999),Z=0,W=1,Y1=Y1+1,Y(Y1)=Y_0,Y="",Y2=0 Q
 S M=K+1 F K=M+1:1:L S A=$E(X,M,K) I $D(^ZAA02GFAXC(.3,A)) S:^(A)<64 Y=Y_(ZZ+^(A))_"+",W=1,ZZ=0 W:0 A,"-",^(A)," " Q:W  S ZZ=^(A) G DE1
 I W S M=K+1,ZZ=0 G DE1:$L(Y)<500 S Y1=Y1+1,Y(Y1)=Y_0,Y2="Y2="_Y_Y2,@Y2,Y="" G DE1
DE3 S X=$E(X,M,999) Q
 ;
PR ; O 13 U 13 W !!!!!!!!!!!!,*27,"3",*2
 S (W(0),W(1))="" S $P(W(0),$C(128),130)="",$P(W(1),$C(0),130)=""
 S C=268,(Y,X,AA)="",W=1,(ZZ,Z,Y2,Y1)=0 F J=1:1 S:AA="" C=$O(^TESTFAX(101,C)) S:C'=""&(AA="") AA=^(C) Q:C_AA=""  D P2
 Q
P2 F JJ=1:1:$L(AA) S:$A(AA,JJ)=16 JJ=JJ+1 S X=X_^ZAA02GFAXC(0,4,$A(AA,JJ)) D:$L(X)>400 P3
 F JJ=1:1 Q:X'[1  D P3
 S AA="" Q
P2A S (ZZ,Z,Y1,Y2)=0,(X,Y)="",W=1 S AA=AA_$C(0) G P2
 ;
P4 F JJ=1:1:$L(AA) S X=X_^ZAA02GFAXC(0,4,$A(AA,JJ)) D:$L(X)>400 DECODE
 F JJ=1:1 Q:X'[1  D DECODE
 Q
P3 I 'Z S:X'[1 X="0000000" S:X[1 XX=X,X=$E(X,$F(X,1),999),Z=1
 D DECODE Q
 Q
P5 S Y1=Y1+1,Y(Y1)=Y W ! U 0 W Y,!,YY," ",Y1," ",JJ," ",C S (Y,Y1)="",Y2=0 Q
 W *27,"Z",*1728#256,*1728\256 S W=0 F K=1:1:Y1 S Y=Y(K) F J=1:1:$L(Y,"+")-1 S A=$P(Y,"+",J),W=W+1#2 W $E(W(W),1,A#128) F N=1:1:A\128 W $E(W(W),1,128)
 S (Y,Y1)="",Y2=0 Q
 ;
T S Y1=0,MM="" F KK=1:1 S MM=$O(^ZAA02GFAXC("FX",2,MM))  Q:MM=""  S Y1=0,AA=^(MM),(ZZ,Z,Y2)=0,(X,Y)="",W=1 I AA'="" D P2 S:'Y1 Y(0)=Y_0 W !,MM,?9,@Y(Y1),?15,Y1,?25,Y(Y1),! R CCC ;S YX(KK)=Y(1)
 Q
F R "FONT-",FNT,!,"CODE-",KK,! Q:KK=""  S Y1=0,AA=^ZAA02GFAXF(FNT,.3,KK),(ZZ,Z,Y2)=0,Y="",W=1 I AA["," S X="0100110101"_$P(AA,",",2),TL=$P(AA,",",3)+AA W !,KK,?10,AA D P3 S @("TL="_Y_"+TL") W ?49,Y,?70,TL,!
 G F
XX R "TYPE- (S, Q or O) ",T,! S G=$S(T="S":"^ZAA02GFAXS(FX)",T="O":"^ZAA02GFAXO(FX)",1:"^ZAA02GFAXI(FX,PG)") R "FAX #-",FX,!,"DETAIL? ",DT,! I DT'="Y" R "BEGIN DSPLY-",BG,!
 S (Y5,KA)=""
 I G["PG" R "Page-",PG,! S:'PG PG=1
 I T="O" D INIT1^ZAA02GFAXH F KK=1:1 S KA=$O(@G@(KA)) Q:'KA  S LX=$P(^(KA),";",5,99),L=$P(^(KA),";",4)_"0000000",Y5=+^(KA) D LS S AA=LX,(Y1,ZZ,Z,Y2)=0,(X,Y)="",W=1 D:AA'="" P4 D XX0
 I T'="O" F KK=1:1 S KA=$O(@G@(KA)) Q:'KA  W:0 !,KA S AA=^(KA)_$C(0),(Y1,ZZ,Z,Y2)=0,(X,Y)="",W=1 D:AA'="" P2 D XX0
 Q
XX0 S:Y1=2&(Y]"") Y(3)=Y_0,Y1=3,Y(2)=$P(Y(2),"+",1,$L(Y(2),"+")-1) S:Y1=1&(Y]"") Y(2)=Y_0,Y1=2,Y(1)=$P(Y(1),"+",1,$L(Y(1),"+")-1) S:Y1=0 Y(1)=Y_0,Y1=1 S Y3="Y3="_Y(1),@Y3 S:Y1>1 Y3="Y3="_Y3_"+"_Y(2),@Y3 S:Y1>2 Y3="Y3="_Y3_"+"_Y(3),@Y3
 D XX1:DT="Y",XX2:DT'="Y"
 Q
XX1 W !,KK,?6,Y3,?12,Y5,?20,Y1,?25,Y(1) W:Y3'=1728 *7 W:Y1>1 "+",Y(2) W:Y1=3 "+",Y(3) R !,CC Q
XX2 R CC#1 W ! Q:BG>Y3  S X=0 F Y4=1:1:Y1 S Y=Y(Y4) F J=1:1:$L(Y,"+") S X=X+$P(Y,"+",J) I X>BG S Y=X-BG_"+"_$P(Y,"+",J+1,500),M=J S:$L(Y)<100&(Y4<Y1) Y=Y_"+"_$E(Y(Y4+1),1,100) G XX4
XX4 G:Y(1)=0 XX4 F J=1:1:$L(Y,"+") S X=$P(Y,"+",J),W=$S(M#2:" ",1:$C(219)),M=M+1 F L=1:1:X W W G:$X>78 XX3
 I Y3<Y1,$X<78 S Y=Y(2) F J=1:1:$L(Y,"+") S X=$P(Y,"+",J),W=$S(J#2:" ",1:$C(219)) F L=1:1:X W W G:$X>78 XX3
XX3 Q
 ;
Y ; CODE Y ARRAY (1+2+3+...Z format)
 D INIT1^ZAA02GFAXH S (L,LX,A)=""
 F Z=0:0 S A=$O(YX(A)) S L=EOL Q:A=""  S X=YX(A) D Y1 S ^ZAA02GFAXC("FX",5,A)=LX,LX="" W OL,!
 Q
Y1 F I=1:1:$L(X,"+")-1 S Y=$P(X,"+",I) S:I#2 L=L_$S(Y<64:^ZAA02GFAXC(0,0,Y),1:^ZAA02GFAXC(0,0,Y\64*64)_^(Y#64)) S:I#2=0 L=L_$S(Y<64:^ZAA02GFAXC(0,1,Y),1:^ZAA02GFAXC(0,1,Y\64*64)_^(Y#64)) D:$L(L)>200 LS
 S L=L_"000000000",OL=L D LS D:LX[$C(16) LE^ZAA02GFAXH1 Q
LS F i=1:8:$L(L)\8*8 S LX=LX_$C(B($E(L,i,i+3))+C($E(L,i+4,i+7)))
 S L=$E(L,$L(L)>7*(i+8),999) Q
 ;
FT ; FOOTER CONV
 N XX S FNT=10 D INIT1^ZAA02GFAXH,GETFNT^ZAA02GFAXH1 S C=0,(Y,X,AA)="",W=1,(ZZ,Z,Y2,Y1)=0,ZAA02GFAXS="^ZAA02GFAXC(""FX"")",PG=1,FXL=0,TXL=$L(TXT),TXW=1728-(TXL*8)\2
 F J=1:1 S:AA="" C=$O(^ZAA02GFAXC("FX",1,C)) S:C'=""&(AA="") AA=^(C) Q:C_AA=""  W "." D P2
 S TXR=1,A="" F J=1:1 S A=$O(Y(A)) Q:A=""  S X=Y(A),D=$L(X,"+")-2,X=$P(X,"+",1,D),D="CVR="_X_"+0",@D,MG=1728-(TXL*8+TXW+CVR),L=EOL D FT1
 Q
FT1 I X]"" F I=1:1:$L(X,"+") S Y=$P(X,"+",I) S:I#2 L=L_$S(Y<64:^ZAA02GFAXC(0,0,Y),1:^ZAA02GFAXC(0,0,Y\64*64)_^(Y#64)) S:I#2=0 L=L_$S(Y<64:^ZAA02GFAXC(0,1,Y),1:^ZAA02GFAXC(0,1,Y\64*64)_^(Y#64))
 N EOL W "." S EOL=L D LN1^ZAA02GFAXH1 S TXR=TXR+1 S:TXR>9 TXT=$J("",TXL),TXR=9
