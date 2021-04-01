ZAA02GFORM8 ;PG&A,ZAA02G-FORM,2.62,GROUP CONTROL;23JUN95 5:39P;;;13AUG97 1:07P
 ;Copyright (C) 1994, Patterson, Gray & Associates, Inc.
 ;
BEG I 'g(I) S RX=$S(I=1:1,RX<0:-1,1:1) G NEXT:n D RESET G DPD^ZAA02GFORM1
 I n>0,@e[1 S:n(n)>$G(@$P(g(g),"`",5)) @$P(g(g),"`",5)=n(n)
 S g=I,I=I_"01",n=n+1,(dn(n),n(n))=1,$P(v,".",n)=1,$P(dv,".",n)=1 S:$P(g(g),"`",10)'="" @("$P(g(g),""`"",2)="_$P(g(g),"`",10))
 D:$L(l24) BOT S le=""
1 S ty=$S($D(ty(g,v)):"ty(g,v)",1:"ty(g)"),m=$S($D(m(g,v)):"m(g,v)",1:"m(g)") I RX["," S I=$P(RX,",",3),$P(RX,",")=$P(RX,",",4)-1,$P(RX,",",4)=1 G NEXT:RX
2 I n(n)>$G(@$P(g(g),"`",4)) S @$P(g(g),"`",4)=n(n)
 D ^ZAA02GFORM1
4 S:RX["TB" RX=1
 I @e[1 S:n(n)>$G(@$P(g(g),"`",5)) @$P(g(g),"`",5)=n(n) G 3
 I n(n)'>$G(@$P(g(g),"`",5)),$P(g(g),"`",6) D DENSE
 I n(n)>$G(@$P(g(g),"`",5)),$P(g(g),"`",6),RX>0,RX'?.E1P.E!(RX=99.4) G OUT
3 I RX["," D RX
 Q:RX>9997  I 1 D:@m MA E  S ert=1 D ERREP^ZAA02GFORM1 G 4
 G PAGE:RX["99."
 ;
NEXT I RX>0,RX<700,n(n)+RX'>$P(g(g),"`",2) G NXT
 I RX<0,n(n)+RX'<1 G PREV
 I $P(g(g),"`",8)]"",$P(g(g),"`",8)>$G(@$P(g(g),"`",5)) S ert=1 D ERR^ZAA02GFORM1 S RX=99_","_g_","_(g*100+1)_","_n(n)_",",I=1 D RESET G DPD^ZAA02GFORM1
 I n(n)>1,n(n)-dn(n)>0 D FIRST
 S lp=@e,I=g,g=g\100,n=n-1 I 'n D RESET S $P(@e,2,I)=lp[1,RX=$S(RX=800:1,I=1:0,1:RX) G DPD^ZAA02GFORM1
 S v=$P(v,".",1,n),dv=$P(dv,".",1,n),n(n)=$P(v,".",n),$P(@e,2,I#100)=lp[1,RX=$S($D(rx):rx,RX<0:-1,RX=100:1,RX=800:1,1:RX)
 S ty=$S($D(ty(g,v)):"ty(g,v)",1:"ty(g)"),m=$S($D(m(g,v)):"m(g,v)",1:"m(g)")
 ; W l24,v," ORX=",ORX," RX=",EX," I=",I R CCC
 G DPD^ZAA02GFORM1
 ;
NXT S n(n)=n(n)+RX,$P(v,".",n)=n(n),dn(n)=dn(n)+RX I dn(n)>g(g) S lp=$S(n(n)+g(g)>$P(g(g),"`",2):$P(g(g),"`",2)-g(g)+1,1:n(n)),x0=n(n)_";"_(n(n)-lp+1) D REFR G 1
 S $P(dv,".",n)=dn(n),I=g_"01" G 1
 ;
PREV S n(n)=n(n)+RX,$P(v,".",n)=n(n),dn(n)=dn(n)+RX,RX=RX_"P" I dn(n)<1 S x0=n(n)_";1",lp=n(n) D REFR G 1
 S I=g_"01",$P(dv,".",n)=dn(n) G 1
 ;
RX I $P(RX,",",2)=g S $P(RX,",")=$P(RX,",",4)-n(n),$P(RX,",",4)=1 Q
 S $P(RX,",")=800 Q
RESET S ty="ty(0)",m="m(0)",(n,g,v,dv)=0 W $G(l24) Q
BOT W l24,ZAA02G("Z"),"         Grouped Data - Use TAB, " W:g(g)<$P(g(g),"`",2) "FIRST, NEXT, PREVIOUS, " W "and EXIT keys" Q
 ;
MA S v=$P(v,".",1,n) F a=1:1:$L(@m,",") I $E(@e@($P(@m,",",a)))=ee W *7 S I=$P(@m,",",a) Q
 I '$T
 Q
 ;
PAGE S E=$P(RX,".",2) G:E=4 OUT
 I E=1,-dn(n)#g(g)+n(n)<$P(g(g),"`",2) S lp=-dn(n)#g(g)+n(n)+1,lp=$S(lp+g(g)>$P(g(g),"`",2):$P(g(g),"`",2)-g(g)+1,1:lp),x0=lp_";1" D REFR G 1
 I E=2,n(n)-dn(n)>0 S lp=n(n)-dn(n)+1,lp=$S(lp-g(g)>1:lp-g(g),1:1),x0=lp_";1" D REFR G 1
 I E=3,n(n)>1 D FIRST G 1
 W *7 S RX=0,I=g_"01" G 2
OUT S RX=800 G NEXT
SCDN S x0=n(n)_";1",lp=n(n) D REFR G 1
FIRST S x0="1;1",(n(n),lp)=1 D REFR Q
SAME S x0=n(n)_";"_dn(n),lp=n(n)-dn(n)+1 D REFR Q
 ;
REFR W rf D LOAD W sa S n(n)=+x0,$P(v,".",n)=+x0,dn(n)=$P(x0,";",2),$P(dv,".",n)=dn(n),I=g_"01" K x0 Q
 ;
LOAD I lp+g(g)-1>$G(@$P(g(g),"`",4)) S ful=lp+g(g)-1,ful=$S(ful>$G(@$P(g(g),"`",5)):$G(@$P(g(g),"`",5)),1:ful) I ful X ^ZAA02GDISP(SCR,SN,^ZAA02GDISP(SCR,SN,g,0))
 S dn(n)=0 F n(n)=lp:1:(lp+g(g)-1) S $P(v,".",n)=n(n),dn(n)=dn(n)+1,$P(dv,".",n)=dn(n),dp(g,dv)=v F I=g_"01":1:$P(g(g),"`",3) S Y=^ZAA02GDISP(SCR,SN,I) D @$P(Y,"`",19)
 K ful Q
 ;
WO I $D(@e@(I)) W p(dv,I),@e@(I)
 E  X ^ZAA02GDISP(SCR,SN,I_".2"),$P(Y,"`",4) S @e@(I)=D,$P(@e,2,I#100)=$E(D)'=ee W p(dv,I),D
 S dp(g,dv)=v Q
 ;
GO S n=n+1,(dn(n),n(n),lp)=1,g=I D LOAD W rf S n=n-1,I=g,g=g\100,v=$P(v,".",1,n),dv=$P(dv,".",1,n) Q
 ;
LO I '$D(@e@(I)) G LIST
 F ls=0:1:$P(Y,"`",14)-1 W p(dv,.001*ls+I),@e@(.001*ls+I) S li(I,dv,ls)=.001*ls+I
 S Y="" Q
 ;
LIST S f=$P(Y,"`",4),j=$P(^ZAA02GDISP(SCR,SN,I_".2"),"`",2),%R=li(I,dv),%C=$P($P(Y,"`",3),",",2)
 S del=0 F ls=0:1:$P(Y,"`",14)-1 X j,f W @ZAA02GP,D S @e@(.001*ls+I)=D,del=$E(D)'=ee+del,%R=%R+1,li(I,dv,ls)=.001*ls+I
 S Y="",$P(@e,2,I#100)=del>0 Q
 ;
DENSE S del=1 D ^ZAA02GFORM9 I RX=1,n(n)=$G(@$P(g(g),"`",5)) S RX=0
 Q
 ;
REPORT Q:'g  W l23,"group-",g," v-",v," dv-",dv," ed-",@e," count-",$G(@$P(g(g),"`",5))," load-",$G(@$P(g(g),"`",4)) Q
