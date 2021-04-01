ZAA02GFORM0 ;PG&A,ZAA02G-FORM,2.62,DISPLAY DATA;9AUG95 4:06P
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
BEG S SN=$P(SNL,",",snb)
 K b,c,d,dp,e,eg,g,ld,li,m,n,nb,nv,p,ty,keyr,dog,^ZAA02GF(JJ) S a=^ZAA02GDISP(SCR,SN),pp=$P(a,"`",2),C=$P(a,"`",3),wi=$P(a,"`",13)["N",to=$S($D(timeout):timeout,$P(a,"`",6):$P(a,"`",6),1:99999)
 S B=$P(a,"`",10),rf=ZAA02G("Z"),dc=B[".",sp=ee,$P(sp,$S(B[".":".",1:" "),132)="" S:B'["H" rf=rf_ZAA02G("LO") F I="RON","UO" I B[$E(I) S rf=rf_ZAA02G(I),dc=1
 I $P(a,"`",11)'="R" S dm="S l=0",ep="W p(dv,I)"
 E  S dm="S l=$L(X) I l'<ln S l=ln-1",ep="W p(dv,I),$P(@e@(I),ee) W:$P(@e@(I),ee,2)="""" ZAA02G(""L"")"
 I $D(wide),$P(a,"`",5)'="Y" X $P(^ZAA02G(.1,ZAA02G,7),"\",2) K wide
 I $P(a,"`",5)="Y" X:JJ'["." $P(^ZAA02G(.1,ZAA02G,7),"\") S wide=1
 S e=$S($P(a,"`",14)="Y":"^ZAA02GF(JJ,g,v)",1:"e(g,v)")
 S B=$P(a,"`",12),ro="" F I="RON","HI","UO" I B[$E(I) S ro=ro_ZAA02G(I)
 S (I,v,g)="",dc=$S(dc:$C(2),1:""),sa=ZAA02G("Z") G LOAD:C=""!($P(ZAA02Gform,";",2)["D") W:pp=""&'wi ZAA02G("F") X:pp]"" pp K pp G D1
 S ca="^ZAA02GDISPL("""_C_""",0,"""_^ZAA02G($I)_""")" D ^ZAA02GWINDO S C="",%R="",%C=1 W ZAA02G("LO") F I=1:1 S %R=$O(@ca@(%R)) Q:%R=""  S X=^(%R) X ZAA02GWI
 G LOAD
D1 G:$D(^ZAA02GDISPL(C,0,ZAA02G,0))=0 D2 F %R=$S($D(REFRESH):+REFRESH,1:1):1:$S($D(REFRESH):$P(REFRESH,":",2),1:24) I $D(^(%R)) W ^(%R),^(%R+.1)
 G LOAD
D2 F I=1:1 Q:$D(^(I))=0  W ^(I)
LOAD G:$P(ZAA02Gform,";",2)["S" EXIT^ZAA02GFORM I $D(^ZAA02GDISP(SCR,SN,.021)) G ^ZAA02GFORM0A
LOAD2 D LOAD1 S p="",nv=($D(nv)>1),RX=0 I $P(ZAA02Gform,";",2)["N",$D(dog) D DONLY^ZAA02GFORM0A
 I ZAA02Gform<2,nb(0),$P(ZAA02Gform,";",2)'["N" G EDIT^ZAA02GFORM
 G ECTL0^ZAA02GFORM:ZAA02Gform'>9&+ZAA02Gform,EXIT^ZAA02GFORM
 ;
LOAD1 S a=$P(^ZAA02GDISP(SCR,SN),"`",18),bn=0 G:a]"" ^@a X:^(SN,0)'=" ;" ^(0)
DISP S tab(0)=^ZAA02GDISP(SCR,SN,.03),ty(0)=^(.04),m(0)=^(.06),nb(0)=+^(.9) S:$D(^(.09)) p=^(.09),cp=^(.0901)
 W rf S ca="p(v,I)="_ZAA02GP,(n,n(0),g,nv,pi,v,dv)=0,I=$P(^ZAA02GDISP(SCR,SN,.9),",",2),w=^(.05)]"" K D
 F I=1:1:I Q:$D(^ZAA02GDISP(SCR,SN,I))=0  S Y=^(I),B=$P(Y,"`",3),%R=+B,%C=$P(B,",",2),@ca X ^(I_".2") I Y]"" X $P(Y,"`",4) S @e@(I)=D,$P(@e,2,I#100)=$E(D)'=ee W:X'=dc p(dv,I),D
 K ca,cp,lv,pi,v0,w Q
 ;
LIST S:n pi=pi+1,%R=$A(p,pi),%C=$A(cp,pi),li(I,v)=%R S j=$P(^(I_".2"),"`",2),f=$P(Y,"`",4),%R=%R-1 S:$P(Y,"`",15)>$P(Y,"`",14) dog(I_" ")=2
 S k=I,m=0 F ls=0:1:$P(Y,"`",14)-1 X j,f S I=.001*ls+k,@e@(I)=D,m=$E(D)'=ee+m,%R=%R+1 W:X'=dc @ZAA02GP,D I w S @ca,li(k,v,ls)=I
 I I<100 F ls=ls+1:1:$P(Y,"`",15)-1 X j,f S I=.001*ls+k,@e@(I)=D,m=$E(D)'=ee+m
 S I=k,Y="",$P(@e,2,I#100)=m>0 Q
 ;
GI S $P(v,".",n)=n(n),dp(g,v)=v
 F I=g_"01":1:$P(g(g),"`",3) S Y=^ZAA02GDISP(SCR,SN,I) X ^(I_".2") I Y]"" S pi=pi+1,%R=$A(p,pi),%C=$A(cp,pi),@ca X $P(Y,"`",4) S @e@(I)=D,$P(@e,2,I#100)=$E(D)'=ee W:X'=dc p(v,I),D
 Q
 ;
G S g=I,n=n+1 I '$D(g(g)) S nb(g)=$P(Y,"`",4),g(g)=$P(Y,"`",5,13),tab(g)=^ZAA02GDISP(SCR,SN,g,3),ty(g)=^(4),m(g)=^(6)
 I  S:$P(g(g),"`",2)["n(" $P(g(g),"`",10)=$P(g(g),"`",2),n(n)=1 S:'$P(g(g),"`",2) @("$P(g(g),""`"",2)="_$P(g(g),"`",2)) S:$P(g(g),"`",8)'?.N @("$P(g(g),""`"",8)="_$P(g(g),"`",8)) S:g(g)<$P(g(g),"`",2) dog(g_" ")=1
 F n(n)=1:1:+g(g) D GI
 S Y=$G(@$P(g(g),"`",5))>0,I=g,g=g\100,n=n-1 I n S v=$P(v,".",1,n)
 E  S v=0
 S $P(@e,2,I#100)=Y,Y="" Q
 ;
CALC I ^ZAA02GDISP(SCR,SN,.05)="" W *7 Q
 I $D(ESCAPE)+$D(^ZAA02GDISP(0,"ESCAPE")) S:'$D(ESCAPE) ESCAPE=^("ESCAPE")
 I  X ESCAPE X ^ZAA02G("TERM-OFF"),^ZAA02G("TERM-ON") Q:'to  S:'$D(tt) tt=1,td=24 D REFR^ZAA02GFORM4 W ro Q
 I '$D(^ZAA02GPC) W *7 Q
 D ZAA02GPC S tt=$S($D(ZAA02GRE):1,1:12),td=24-tt-1 D REFR^ZAA02GFORM4
 S X=$S($P(ZAA02GA,".",2)="":+ZAA02GA,1:ZAA02GA) K ZAA02GA,ZAA02GRE W ro Q
 ;
ZAA02GPC W ZAA02G("Z"),ZAA02G("RON") N (ZAA02G,ZAA02GA,ZAA02GP,ZAA02GRE) X ^ZAA02GPC Q
