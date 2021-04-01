ZAA02GFORM1 ;PG&A,ZAA02G-FORM,2.62, 1987;23JUN95 5:34P;;;21FEB96 11:54A
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
 S le="" W sa
DP S a=$A(@ty,I#100) I a G:a>31 RXI:a>127,^ZAA02GFORM8:a>63,LIST S RX="RD",B="" I a#8 S C=a,le="W l23E S le=""""" F j=1:1:3 W:C#2 md(j) S C=C\2 Q:'C
 W p(dv,I),ro,@e@(I) X ep I a<8 R B#1:to G:'$T TOUT I B="" X ZAA02G("T") S RX=$P("RB,RB,-1,1,1,0,TB,ESC,l,m",",",$F("34162ELM",$E(xx,$F(xx,ZF)))+1) I RX'="RB" D:RX?.A @RX G DPW
RSET S Y=^ZAA02GDISP(SCR,SN,I),(lnt,ln)=$P(Y,"`",5),p=p(dv,I),X=$P(@e@(I),ee),lnd=0 X dm
 I ln["," S:$P(ln,",",2)>ln lnt=$P(ln,",",2) X:lnt>ln ^ZAA02GDISP(SCR,SN,I_".2") I lnt=ln,$E(X)=" " X "F %I=1:1:$L(X) Q:$E(X,%I)'="" """ S X=$E(X,%I,255) W p,X,$J("",ln-$L(X)),p
 I B]"" S X=$E(X,1,l)_B_$E(X,l+2,255),l=l+1,RX="RD" D @$S(l<ln:$P(Y,"`",21),ln["A":1,1:6) G DPW
 I 'RX D @$P(Y,"`",21)
DPW X le W rf,p(dv,I),@e@(I),sa
DPD Q:$D(key)  S I=I+RX S:I<1 I=1 Q:I<(g*100+1)  G DP:I'>nb(g) Q:RX'[","  Q:g  S I=$P(RX,",",2) G DP
 ; 
RA G @RX
RD R B#ln-l:to G:'$T TOUT
RS I B]"" S X=$E(X,1,l+lnd)_$J("",l+lnd-$L(X))_B_$E(X,l+$L(B)+lnd+1,255),l=l+$L(B) I l'<ln G RDL:lnt>ln,1:ln["A",6
RD1 X ZAA02G("T")
RB S j=$E(xx,$F(xx,ZF)) I j?1.AN,$T(@j)]"" G @j
 I ZF=$C(1) D ENTRY^ZAA02GFRME2
 I ZF=$C(2) D REPORT^ZAA02GFORM8
ER W *7,p S l=0 G RD
RDL G:lnd+ln=lnt 1:ln["A",6 S lnd=lnd+1,l=l-1 W p,$E(X_$E(sp,$L(X)+1,255),lnd+1,ln+lnd),ZAA02G("L") G RD
E D ESC G DONE
EC G:RX="RB" RB I B="" R B#1:to G:'$T TOUT G RD1:B=""
 S X=B,l=1 W p,$E(sp,1,ln+1),p,X G RD
X G:'g ER S del=1 G E^ZAA02GFORM9
Y G:'g ER S RX=0,del=0 D DONE I $D(del) G E^ZAA02GFORM9
 G DER
D ;
F G ER
W G:ln["P" RD X "F l=$F(X,"" "",l+lnd+1):1:$L(X) Q:$E(X,l)'="" """ S l=l-1 G K1
K G:ln["P" RD S l=$L(X)
K1 S:l'<ln&(lnt>ln) lnd=l\ln*ln,l=l#ln S:lnd+ln>lnt lnd=lnt-ln,l=$L(X)-lnd-1#ln+1 W p,$E(X_$E(sp,$L(X)+1,255),lnd+1,lnd+ln),p,$E(X,lnd+1,lnd+l) w:0 l," ",lnd," ",$L(X) I l<ln G RD
 W ZAA02G("L") S l=l-1 G RD
M D m G DONE
Z D CALC^ZAA02GFORM0 W m24,ro G U1
6 I l S l=l-1 W:ln'["P" ZAA02G("L") G RD
 I lnd S lnd=lnd-1 W p,$E(X,lnd+1,ln+lnd),p
 G RD
5 I l+1<ln S l=l+1 W:ln'["P" ZAA02G("RT") G RD
 I lnt>ln,lnd+ln<lnt S lnd=lnd+1 W p,$E($E(X,lnd+1,lnd+ln)_sp,1,ln+1),ZAA02G("L")
 G RD
TB Q:$D(key)  S RX=$A(tab(g),I#100)-32 S:RX<0 RX=100 S RX=RX_"TB" Q
L D l G DONE
2 D TB G DONE
1 S RX=1 G DONE
7 G:lnd+l=0 RD S X=$S(l+lnd=$L(X):$E(X,1,l+lnd-1),1:$E(X,1,l+lnd-1)_" "_$E(X,l+lnd+1,255)) W:ln'["P" *8,$E(" "_$E(sp,2),lnd+l>$L(X)+1) G 6
m S RX=I*-1+1 Q
l Q:$D(key)  Q:I#100=1  F RX=I#100-1:-1 I $E(tab(g),RX)]$E(tab(g),RX-1) S RX=RX-I Q
 Q
A S X=$E(X,1,l) W:ln'["P" $E(sp,2,ln-l+1),p,X G RD
4 S RX=1 G DONE
3 S RX=-1
DONE S x0=X I X[" " S %=$TR(X," ",""),%=$E(%,$L(%)),X=$E(X,1,$L($P(X,%,1,$L(X,%)-1)_%))
 I X="" W p,rf,$J("",$P(Y,"`",12)) G D1:$A(@ty,I#100)#16<8!(RX<0) S ert=2 G DER
 I $TR(ln,"UL","")'=ln S:ln["L" X=$TR(X,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz") S:ln["U" X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 G:$P(Y,"`",6)="" D1 I @$P(Y,"`",6) G D1
 S ert=3 G DER
D1 I $P(@e@(I),ee)=x0 Q:ln["c"  ;I $P(Y,"`",16)="" Q
 I $P(Y,"`",16)]"" S x0=X,ert=4 X $P(Y,"`",16) E  S X=x0 G DER
SAVE S $P(@e,2,I#100)=X]"" X $P(Y,"`",4),$P(Y,"`",2) S @e@(I)=D Q
ERREP D ERR S ZF=0 G DP
TOUT S RX=9998 Q
DER S ln=$TR(ln,"c","") I $D(del) k del Q
 Q:$P(ZAA02Gform,"~",2)["C"  I RX'[",A" S RX=0 D @$S($P(Y,"`",7)<2:"ERR",1:"ERR^ZAA02GFORM3")
RET W ZAA02G("Z"),ro,p W:ln'["P" $E(X_sp,1,$L(X)<ln+ln),p S l=0 G RD:'RX,SAVE
ERR D ER^ZAA02GFORM4 Q
T1V D:X]"" KW I  X $P(Y,"`",17)
 Q
TV1 X $P(Y,"`",17) Q:X=""!'$T!(RX[",A")
KW S go="ZAA02GFORM1" D KW^ZAA02GFORM4 Q
B ;
C S go="ZAA02GFORM1" G SCUPDN^ZAA02GFORM3
U G:$P(Y,"`",8)="" ER S X=$P(@e@($P(Y,"`",8)),ee)
U1 S (lnd,l)=0 W p,$E(X_$E(sp,$L(X)+1,255),1+lnd,ln+lnd),p G RD
J S X=$E(X,1,l+lnd)_$E(X,l+2+lnd,255) W:ln'["P" $E(X_$E(sp,$L(X)+1,255),l+1+lnd,ln+lnd),p,$E(X_$E(sp,$L(X)+1,255),1+lnd,l+lnd) G RD
I I $E(X,lnt)'="" W *7 G RD
 I l<$L(X) S X=$E(X,1,l+lnd)_" "_$E(X,l+1+lnd,lnt) W:ln'["P" $E(X,l+lnd+1,ln+lnd),p,$E(X,1+lnd,l+lnd) G RD
 G RD
LIST S Y=^ZAA02GDISP(SCR,SN,I),ln=$P(Y,"`",5) D ^@$P(Y,"`",13) D RXE G DPD
RXE D:RX=5 TB Q
H S go="ZAA02GFORM1" G ^ZAA02GFORM4
RXI ; I $D(dog(I_" ")) D PAGES^ZAA02GFORM0A
 I RX<0,g,RX["P" F I=I+1:1 G:$A(@ty,I#100)<127 DP I I=nb(g) S I=g*100+1 Q
 I RX<0 F I=I-1:-1:g*100+1 I $A(@ty,I#100)<127 G DP
 I RX<0,I>0 S RX=+RX Q:g  G DP
 F I=I+1:1:nb(g) I $A(@ty,I#100)<127 G DP
 S RX=$S(ty'[",":800,1:1) Q
DT G ^ZAA02GFORMD
PW W:B'="" *8," ",*8 X ^ZAA02G("ECHO-OFF") D @RX X ^ZAA02G("ECHO-ON") Q
ESC S RX=$F(xx,ZF),RX=$E(xx,RX+1) I "124"[RX!(I>100&(RX=3)) S RX=RX/10+99 Q
 W *7 S RX=0 Q
