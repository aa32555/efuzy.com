ZAA02GFRME3A ;PG&A,ZAA02G-FORM,2.62,FORMS EDITOR;12OCT94  21:59;;;06MAY2004  15:49
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;put={1=write to disk;2=paint;3=paint fields only}
CTL N (qt,CT,GR,ZAA02G,ZAA02GG,ZAA02GP,SCR,SN,SP,put,scope) ;W:'$d(qt) !,put B  ;
 S (n,n(0),home,rd)=0,v=""
 F RR0=0:0 S RR0=$O(@ZAA02GG@(.2,RR0)) Q:'RR0  F CC0=0:0 S CC0=$O(@ZAA02GG@(.2,RR0,CC0)) Q:'CC0  S I=$P(^(CC0),"\",2) I I[">" S Y=^ZAA02GDISPL("~",$I,0,I),v=I D G
 K n,n(0),home,rd,v Q
 ;
G N scope S g(I)=$P(Y,"`",1,6),scope=I,n=n+1,rd=($P(Y,"`",2)-$P(Y,"`",1)+1)_"+"_rd,home="0+"_home
 F n(n)=1:1:$P(Y,"`",5) S:n(n)>1 home=(home+rd)_"+"_$P(home,"+",2,99) S $P(v,".",n+1)=n(n) D SWPFD
 S n=n-1,Y="",home=$P(home,"+",2,99),rd=$P(rd,"+",2,99),v=$P(v,".",1,n+1)
 Q
 ;
SWPFD N CC,RR I put<3 D GRAPHICS
 I put>1 W:'$d(qt) ZAA02G("Z") F RR=0:0 S RR=$O(@ZAA02GG@(.2,RR)) Q:'RR  F CC=.9:0 S CC=$O(@ZAA02GG@(.2,RR,CC)) Q:'CC  S I=$P(^(CC),"\",2),Y=^ZAA02GDISPL("~",$I,0,I) I I'[">" D GI
 F RR=0:0 S RR=$O(@ZAA02GG@(.2,RR)) Q:'RR  F CC=.9:0 S CC=$O(@ZAA02GG@(.2,RR,CC)) Q:'CC  S I=$P(^(CC),"\",2),Y=^ZAA02GDISPL("~",$I,0,I) I I[">" D G
 Q
 ;
GRAPHICS W:'$d(qt) ZAA02G("Z"),ZAA02G("LO") S D=$P(g(scope),"`",2)-g(scope)+1,C=$P(g(scope),"`",5)
 F RR=+g(scope):1:+$P(g(scope),"`",2) I $D(@ZAA02GG@(RR)) F CC=.9:0 S CC=$O(@ZAA02GG@(RR,CC)) Q:'CC  S A=^(CC) S:put=2 E=$S($P(A,"`",2)#2:ZAA02G("G1")_CT(+A)_ZAA02G("G0"),1:$P(A,"`",1)) S %C=CC,@("%R=RR+"_home) W:put=2 @ZAA02GP,E I put=1 D PUTGR
 Q
 ;
PUTGR S ^ZAA02GDISPL("~",$I,GR,%R,%C)=A S:'$D(^ZAA02GDISPL(GR,">",%R)) ^(%R)="" S ^(%R)=^(%R)_$C(%C) I %R=RR S ^ZAA02GDISPL(GR,scope,RR,CC)=A
 Q
 ;
GI S $P(v,".",1)=I,Y=^ZAA02GDISPL("~",$I,0,I),B=$P(Y,"`",3),@("%R="_home_"+B"),%C=$P(B,",",2),B=$E(I_SP,1,$P(Y,"`",5)) W:'$d(qt) @ZAA02GP,B
 I $E($P(Y,"`",21))="V" F %R=%R+1:1:$P($P(Y,"`",21),",",2)-1+%R W:'$d(qt) @ZAA02GP,B
 Q
 ;
 ;
