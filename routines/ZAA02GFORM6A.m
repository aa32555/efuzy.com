ZAA02GFORM6A ;PG&A,ZAA02G-FORM,2.62,LIST EDIT;10NOV95 6:07P
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
M I ls>-1,ef D DONE E  G RD
 S (ls,lp)=0,W=1 G 240
K S W=$L(X) S:W<ln W=W+1 G 240
U G:$P(Y,"`",8)="" ER S ef=1,X=$P(@e@($P(Y,"`",8)),ee),W=1 G 230
U1 G 230
L S W=mg,W=$L(X)
W I $L(X)>W S W=$F(X," ",W) S:'W W=$L(X)+2 X:$E(X,W)=" " "F W=W:1 Q:$E(X,W)'="" """  S W=W G:W<mg 240
 S W=1 D DONE E  G 240
0 I ju,mx=ls G 240
1 W:E=5 *7 S ls=ls+1,W=1 G SCUP:ls-lp=np,240
RD0 W @ZAA02GP S W=1
RD R B#mg-W+1:to G:'$T TOUT X ZAA02G("T") I B]"" S J=W+$L(B),X=$E(X_$J("",250-$L(X)),1,W-1)_B_$E(X,J,255),W=J,ef=1 G:J>mg 6
RD2 S E=$E(xx,$F(xx,ZF)) G:E'?1.AN ER I $S(E="F":0,ef:"1243MEBCY"[E,1:0) D DONE E  G 230
 S:"AIJ7"[E ef=1 G @E
 D:ZF=$C(1) ENTRY^ZAA02GFRME2 D:ZF=$C(2) CALC^ZAA02GFORM0
ER W *7 G 241
6 I W'=1 S W=W-1 W ZAA02G("L") G RD
 I ef D DONE E  G 241
 G:ls=0 3 S W=mg,ls=ls-1 G SCDN:ls<lp,240
2 S RX="1TB" G EXIT
4 S ls=ls+1 G SCUP:ls-lp=np,240
3 I ls=0 G:I=1 RD S RX=-1 G EXIT
 S ls=ls-1 G SCDN:ls<lp,240
5 I W'<mg D:ef DONE G 0:$T G 241
 S W=W+1 W ZAA02G("RT") G RD
7 G RD:W=1 W *8,*32,*8 S X=$E(X,1,W-2)_" "_$E(X,W,255),W=W-1 G RD
I G INCUT:$L(X)'<mg S X=$E(X,1,W-1)_" "_$E(X,W,255) G 230
J S X=$E(X,1,W-1)_$E(X,W+1,255),%C=lm+1+W,%R=cr+ls-lp W $E(X,W,255),$E(sp,2),@ZAA02GP G RD
A S X=$E(X,1,W-1) G 230
E S E=$F(xx,ZF),E=$E(xx,E+1) G ER:1234'[E,OTH:E=4 S lp=$S(E=1:lp+np,E=2:lp-np,1:0) S:lp<0 lp=0 S:lp'<mx lp=mx-1 S ls=lp,W=1 D REFR G 240
Z D CALC S J=W+$L(B),X=$E(X_$J("",250-$L(X)),1,W-1)_B_$E(X,J,255),W=J,ef=1 D REFR G 230
CALC N X D CALC^ZAA02GFORM0 S B=X Q
 G ER
ERR Q:l23=""  D ER^ZAA02GFORM4 Q
TOUT S RX=9998 G EXIT
 ;
F D F^ZAA02GFORM6,REFR G 240
D G D^ZAA02GFORM6
D0 D REFR G 240
230 S %R=cr+ls-lp,%C=lm+2 W @ZAA02GP,$E(X_sp,1,$L(X)<ln+ln) S %C=lm+1+W W @ZAA02GP G RD
240 S X=$P(@e@(.001*ls+I),ee)
241 S %R=cr+ls-lp,%C=lm+W+1 W @ZAA02GP G RD
B G 240:mx-2<lp S ls=ls+1
SCUP S lp=lp+1 I lp<mx D REFR G 240
 S lp=lp-1,ls=ls-1 G OTH:ju,240
C G 240:lp=0 S ls=ls-1
SCDN S lp=lp-1 I lp'<0 D REFR G 240
 G M
REFR S x6=X,%C=lm+2,k=ls,ls=lp F %R=cr:1:cr+np-1 X:'$D(@e@(.001*ls+I)) get,xd,"S @e@(.001*ls+I)=D" W @ZAA02GP,@e@(.001*ls+I)  S li(I,dv,%R-cr)=.001*ls+I,ls=ls+1
 S ls=k,X=x6 K x6 Q
REFRV S %C=lm+2,k=ls,ls=lp W ro F %R=cr:1:cr+np-1 W @ZAA02GP,@e@(.001*ls+I) S ls=ls+1
 S ls=k Q
INCUT W *7 G 241
X I 'g W *7 G RD
 S del=1 G OTH
Y G:'g X S del="" ;G OTH
OTH S RX=1
EXIT G EXIT^ZAA02GFORM6
DONE N ZF X le I X[" " S %=$TR(X," ",""),%=$E(%,$L(%)),X=$E(X,1,$L($P(X,%,1,$L(X,%)-1)_%))
 I $P(@e@(.001*ls+I),ee)=X Q:ln["c"
 I X="" W @ZAA02GP,$J("",+$P(Y,"`",12)) G D1
 I $TR(ln,"UL","")'=ln S:ln["L" X=$TR(X,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz") S:ln["U" X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 G:$P(Y,"`",6)="" D1 I @$P(Y,"`",6)
 E  S ert=4 G DER
D1 I $P(Y,"`",16)]"" S ert=4,x0=X X $P(Y,"`",16) E  S X=x0 G DER
SAVE S ef=$A(@ty,I#100)\16#2,%R=cr+ls-lp,%C=lm+2 X xd,put W @ZAA02GP,D S @e@(.001*ls+I)=D I 1 Q
DER I $P(ZAA02Gform,"~",2)="C" S E="EXIT" Q
 S RX=0,ln=$TR(ln,"c","") D @$S($P(Y,"`",7)<2:"ERR",1:"ERR^ZAA02GFORM3")
RET W ZAA02G("Z"),ro
 S E=$S('RX:241,RX=1:1,RX<1:3,1:"EXIT") I RX G SAVE
 Q
T0 G KW
T1V D KW W *7,"DONE" I  X $P(Y,"`",17)
 Q
TV1 X $P(Y,"`",17) Q:X=""!'$T
KW S go="ZAA02GFORM6A" D KW^ZAA02GFORM4 Q
H S go="ZAA02GFORM6A" G H6^ZAA02GFORM4
HS D SAVE G 1
