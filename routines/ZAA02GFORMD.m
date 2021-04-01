ZAA02GFORMD ;PG&A,ZAA02G-FORM,2.62, 1987;23DEC96 12:04P;;;10MAR99  14:51
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
 X ^ZAA02G("ECHO-OFF") N m,y,d,o S:"Tt"'[B&(B'?1N) X=$P(@e@(I),ee)
 S:X?." " X=" " S:X?1N!(X?1" ") X=$E(X_" /  /    ",1,ln) W p,X,p,$E(X,1,l)
 G @RX:B="",EXT:B'?1N,RD
RD G:X["T" RT S:X?." " X="" I X?.1N S:X="" X=" " S X=$E(X_" /  /    ",1,ln) W p,X,p,$E(X,1,l)
 R B#1:to G:'$T TOU1 I B]"" G:B'?1N EXT W B S X=$E(X_$J("",ln),1,l)_B_$E(X,l+2,99),l=14[l+1+l W:36[l ZAA02G("RT") G RD:+ln'=l,6:ln'["A",1
RB X ZAA02G("T") S j=$E(xx,$F(xx,ZF)) I j?1.AN,$T(@j)]"" G @j
 I ZF=$C(1) D ENTRY^ZAA02GFRME2 W p
ER W *7 G RD
RT R B#1:to G:'$T TOU1 I B]"" G:$S(l=1:"+-"'[B,1:B'?1N) ER W B S X=$E(X_$J("",ln),1,l)_B_$E(X,l+2,99),l=1+l,RX="1234567890" G RT:+ln'=l,6:ln'["A",1
 G RB
E S RX=99 G DONE
X ;
Y ;
D ;
W ;
F G ER
K G:ln["P" RD S l=$L(X) W p,X I l<ln S l=l+1
 E  W ZAA02G("L")
 S:l l=l-1 G RD
M S RX=I*-1+1 G DONE
Z D CALC^ZAA02GFORM0 W m24,ro G U1
6 I l S l=l-1 W:ln'["P" ZAA02G("L") I X'["T",25[l S l=l-1 W:ln'["P" ZAA02G("L")
 G RD
5 I l+1<ln S l=l+1 W:ln'["P" ZAA02G("RT") I X'["T",25[l S l=l+1 W:ln'["P" ZAA02G("RT")
 G RD
TB S RX=$A(tab(g),I#100)-32 S:RX<0 RX=100 S RX=RX_"TB" Q
2 D TB G DONE
1 S RX=1 G DONE
7 G:l=0 RD X:X'["T"&(36[l) "S l=l-1 W:ln'[""P"" ZAA02G(""L"")" S X=$S(l=$L(X):$E(X,1,l-1),1:$E(X,1,l-1)_" "_$E(X,l+1,99)),l=l-1 W:ln'["P" *8," ",*8 G RD
A S X=$E(X,1,l) W $E(sp,2,ln-l+1),p,X G RD
S S X="",l=0 U 0:(:"S") D ZAA02GFORMD W !!,X,! Q
4 S RX=1 G DONE
3 S RX=-1
DONE Q:X["T"  S:X?.P X="" S x0=X,xd=0 I X D ANS S xd=X D CAL I X'=x0 S X=x0 G ER
 I X="" G D1:$A(ty(g),I#100)#16<8 S ert=2 G DER
 I $P(@e@(I),ee)=X,$A(ty(g),I#100)\16=0,$P(Y,"`",16)="" X ^ZAA02G("ECHO-ON") Q
 G:$P(Y,"`",6)="" D1 I @$P(Y,"`",6) G D1
 S ert=3 G DER
D1 I $P(Y,"`",16)]"" S x0=X X $P(Y,"`",16) E  S ert=4,X=x0 G DER
SAVE X $P(Y,"`",4),$P(Y,"`",2) S @e@(I)=D X ^ZAA02G("ECHO-ON") Q
ERR Q:l23=""  D ER^ZAA02GFORM4 Q
TOU1 S RX=9998 Q
DER Q:$P(ZAA02Gform,"~",2)["C"  S RX=0 D @$S($P(Y,"`",7)<2:"ERR",1:"ERR^ZAA02GFORM3")
RET W ZAA02G("Z"),ro,p W:ln'["P" $E(X_sp,1,$L(X)<ln+ln),p S l=0 G RD:'RX,SAVE
B ;
C S go="ZAA02GFORM1" G SCUPDN^ZAA02GFORM3
U G:$P(Y,"`",8)="" ER S X=$P(@e@($P(Y,"`",8)),ee)
U1 S l=0 W p,X,$E(sp,2,ln+1-$L(X)),p G RD
J G:$E(X,l+1,99)["/" ER S X=$E(X,1,l)_$E(X,l+2,ln)_$S(ln'<$L(X):"",1:$E(sp,2)_$E(X,ln+1,999)) W:ln'["P" $E(X,l+1,ln),$E(sp,2),p,$E(X,1,l) G RD
I G ER:$E(X,ln)'="",ER:$E(X,l,99)["/" I l<$L(X) W:ln'["P" " ",$E(X,l+1,ln),p,$E(X,1,l) S X=$E(X,1,l)_" "_$E(X,l+1,ln) G RD
 W:ln'["P" p,$E(X,1,l) S l=$L(X) G RD
H S go="ZAA02GFORMD" G ^ZAA02GFORM4
 ;
EXT G @$P("ER,ER,II,DD,PP,PP,PP,PP,PP,PP,TT,TT",",",$F("+-MmDdYyTt",B)+1)
PP I X="  /  /  " S X=$H D CAL S $P(X,"/",2)="01" S:"Yy"[B $P(X,"/")="01" W p,X
 W p X "F l=1:1:$S(""Mm""[B:0,""Dd""[B:3,1:6) W ZAA02G(""RT"")" S:l=1 l=l-1 G RD
II I 'X S X=+$H G I1
 S z=X,m=+X,d=$P(X,"/",2),y=$P(X,"/",3),@$S(l<3:"m=m+1",l<6:"d=d+1",1:"y=y+1"),X=m_"/"_d_"/"_y D ANS
I1 D CAL W p,X,p,$E(X,1,l) G RD
DD I 'X S X=+$H G I1
 S z=X,m=+X,d=$P(X,"/",2),y=$P(X,"/",3),@$S(l<3:"m=m-1",l<6:"d=d-1",1:"y=y-1"),X=m_"/"_d_"/"_y D ANS G I1
TT S l=1 S X="T" W p,$J("",ln),p,"T" D RT S X="X=$H+"_(+$E(X,2,10))_"+0",@X,xd=X D CAL W p,X G DONE
ANS S m=+X-3,d=$P(X,"/",2),y=$P(X,"/",3),X="" Q:(m+d+y)<-2  I $E(y,1)=" " S X=$H D CAL S y=$P(X,"/",3)
 I y<100 S:y<20 y=y+2000 s:y<100 y=y+1900 I $D(ln),ln>9 S $P(x0,"/",3)=y W p,x0,p,$E(x0,1,l)
 S:m<0 m=m+12,y=y-1 S X=(y-1840*1461\4)+d+(153*m+2\5)-306 S:X'<21609 X=X-1 Q
CAL I 'X S X="  /  /  "_$S(ln=10:"  ",1:"") Q
CAL1 S X=X>21608+305+X,y=4*X+3\1461,d=X*4+3-(1461*y)+4\4,m=5*d-3\153,d=5*d-3-(153*m)+5\5,m=m+2,y=m\12+y+1840,m=m#12+1,X=y*100+m*100+d,X=$E(X,5,6)_"/"_$E(X,7,8)_"/"_$S(ln<10:$E(X,3,4),1:$E(X,1,4)) Q
GOODDATE N m,d,y,o D CAL1 Q
