ZAA02GFORM2 ;PG&A,ZAA02G-FORM,2.62,LIST EDIT - NO CHK;11AUG95 4:41P;;;16OCT97  23:03
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
SETUP S a=^(I_".2"),get=$P(a,"`",2),a=$P(a,"`",3),np=$P(a,",",2),mx=$P(a,",",5)-np+1,wo=$P(a,",",6)["W",ju1=$P(a,",",7)["j",ju=($P(a,",",7)["J"),a=$P(Y,"`",3),cr=$S('n:+a,1:li(I,dv)),lm=$P(a,",",2)-2,mg=$P(Y,"`",5),xo=$P(Y,"`",2),xd=$P(Y,"`",4)
 S xo=xd_" "_xo_" S @e@(.001*ls+I)=D"
 I mx>np W l24,"        Multiples  -  Use Line and Page Scroll Keys  -  TAB to Get Out"
 S (ls,lp,RX)=0,le="" W ro X get,dm
 S W=$S(l<ln:l+1,1:ln) D:$S(ro="":0,ro=ZAA02G("HI"):0,rf[ro:0,1:1) REFR S %R=cr+ls-lp,%C=lm+W+1 W @ZAA02GP G RD ;RD2
M S (ls,lp)=0,W=1 G 240
K S W=$L(X) S:W<ln W=W+1 G 240
L S W=mg X get S W=$L(X)
W X get I $L(X)>W S W=$F(X," ",W) S:'W W=$L(X)+2 X:$E(X,W)=" " "F W=W:1 Q:$E(X,W)'="" """  S W=W G:W<mg 240
0 I ju,mx=ls S:W>mg W=mg G:W=mg 240 S W=1 G RD
1 I ju1 X get I X?." " S W=ls X "F ls=ls:1:mx X get I X'?."" ""  Q" S ls=W E  G OTH
 W:E=5 *7 S ls=ls+1,W=1 G:ls-lp=np SCUP X get S W=1 G 240
RD R B#mg-W+1 X ZAA02G("T") I B'="" X get S J=W+$L(B) G:J>mg WRAP S X=$E(X_$J("",250-$L(X)),1,W-1)_B_$E(X,J,255),W=J D ST
RD2 S E=$E(xx,$F(xx,ZF)) I E?1.AN G @E
 I ZF=$C(1) D ENTRY^ZAA02GFRME2 G 240
 W *7 G RD
6 S W=W-1 I W'<1 W ZAA02G("L") G RD
 G:ls=0 3 S W=mg,ls=ls-1 G:ls<lp SCDN G 240
2 S RX="1TB" G EXIT
4 S ls=ls+1 G:ls-lp=np SCUP W ZAA02G("D") G RD
3 I ls=0 G RD:I=1 S RX=-1 G EXIT
 S ls=ls-1 G:ls<lp SCDN W ZAA02G("U") G RD
5 S W=W+1 G 0:W>mg W ZAA02G("RT") G RD
7 G RD:W=1 W *8,*32,*8 X get S X=$E(X,1,W-2)_" "_$E(X,W,255),W=W-1 D ST G RD
WRAP S X=$E(X_$J("",100),1,W-1)_B,NX="" S l=$L(X," ")-1 S:'l l=l+1 S l=$L($P(X," ",1,l))+2
 I wo S NX=$E(X,l,255),X=$E(X,1,l-2),%R=cr+ls-lp,%C=lm+l W @ZAA02GP,$E(sp,2,mg-l+3) X xo
 I 'wo S W=mg X xo W *8 G RD
 S W=1+$L(NX),ls=ls+1,%R=cr+ls-lp,%C=lm+2 I ls-lp<np W *7,@ZAA02GP,NX X get S X=NX_$E(X,W,255) X xo G RD
 I lp+1<mx X get S X=NX_$E(X,W,255) X xo G SCUP
 W *7 S ls=ls-1,W=mg G 230
I X get G INCUT:$L(X)'<mg S X=$E(X,1,W-1)_" "_$E(X,W,255) G 220
J X get S X=$E(X,1,W-1)_$E(X,W+1,255) G 220
A S X=$E(X,1,W-1) G 220
E S E=$F(xx,ZF),E=$E(xx,E+1) G ER:1234'[E,OTH:E=4 S lp=$S(E=1:lp+np,E=2:lp-np,1:0) S:lp<0 lp=0 S:lp'<mx lp=mx-1 S ls=lp,W=1 D REFR G 240
X ;
Y ;
Z D CALC^ZAA02GFORM0 D REFR G 220
DER Q:$P(ZAA02Gform,"~",2)["C"  S RX=0 D @$S($P(Y,"`",7)<2:"ERR",1:"ERR^ZAA02GFORM3") W ro G ER:'RX X xo D REFR Q
ERR Q:l23=""  D ER^ZAA02GFORM4 Q
ER W *7 G 240
U G:$P(Y,"`",8)="" ER S l=ls,ls=$S(ls:ls-1,1:0) X get S J=X,X=$P(Y,"`",8),X=$S(X=I:J,1:$P(@e@(X),ee)),X=$E(X,1,ln),ls=l,l=0 G 220
F S k=ls F J=ls+1:1:mx+np-2 S ls=J X get S ls=ls-1 X xo
 S ls=$S(J-mx-np+2:ls,1:J),X="" X xo S ls=k D REFR G 240
D S J=ls,ls=mx+np-2 X get I X'="" S ls=J G ER
 F J=ls-1:-1:J S ls=J X get S ls=ls+1 X xo
 S ls=J,X="" X xo D REFR G 240
220 D ST
230 X xd S %R=cr+ls-lp,%C=lm+2 W @ZAA02GP,D
240 S %R=cr+ls-lp,%C=lm+W+1 W @ZAA02GP G RD
B G 240:mx-2<lp S ls=ls+1
SCUP S lp=lp+1 I lp<mx D REFR G 240
 S lp=lp-1,ls=ls-1 G OTH:ju,240
C G 240:lp=0 S ls=ls-1
SCDN S lp=lp-1 I lp'<0 D REFR G 240
 G M
REFR S x2=X,%C=lm+2,k=ls,ls=lp F %R=cr:1:cr+np-1 X:'$D(@e@(.001*ls+I)) get,xd,"S @e@(.001*ls+I)=D" W @ZAA02GP,@e@(.001*ls+I) S ls=ls+1
 S ls=k,X=x2 Q
INCUT G ER
H S go="ZAA02GFORM2" X get D HELP^ZAA02GFORM3 S W=1 D REFR I RX S X=$P(X,"`") X xo G 3:RX<0,OTH:RX<900,1
 G 230
OTH S RX=1 G EXIT
ST I X[" " S %=$TR(X," ",""),%=$E(%,$L(%)),X=$E(X,1,$L($P(X,%,1,$L(X,%)-1)_%))
 X xo Q
EXIT X le ;  I $P(@e@(.001*ls+I),ee)=X Q:ln["c" ; no meaning here
 I $P(Y,"`",16)]"" X $P(Y,"`",16) E  S ert=4 G DER
 W rf S %R=cr,%C=lm+2,ed0=0 F ls=0:1:np-1 S D=@e@(.001*ls+I) W @ZAA02GP,D S %R=%R+1,ed0=$E(D)'=ee+ed0
 I ed0=0 F ls=ls+1:1:mx X get I X]"" S ed0=1 Q
 S $P(@e,2,I#100)=ed0>0
 K ed0,mx,lp,get,xd,xo,cc,cr,ju,k,np,x2 W:$L(l23) l23,ZAA02G("CS"),m24,ro Q
