ZAA02GFORM8A ;PG&A,ZAA02G-FORM,2.62,GROUP CONTROL;31MAR95 1:23P
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
REFR S x1=g_";"_v_";"_I N Y D LOAD S g=$P(x1,";"),v=$P(x1,";",2),I=$P(x1,";",3) K x1 Q
 ;
LOAD I lp>$G(@$P(g(g),"`",4)) S ful=$S(lp>$g(@$P(g(g),"`",5)):$G(@$P(g(g),"`",5)),1:lp) X ^ZAA02GDISP(SCR,SN,^ZAA02GDISP(SCR,SN,g,0))
 F n(n)=$P(g(g),"`",4):1:lp S $P(v,".",n)=n(n) F I=g_"01":1:$P(g(g),"`",3) S Y=^ZAA02GDISP(SCR,SN,I) D @$P(Y,"`",19)
 K ful Q
 ;
WO Q:$D(@e@(I))
 E  X ^ZAA02GDISP(SCR,SN,I_".2"),$P(Y,"`",4) S @e@(I)=D,$P(@e,2,I#100)=$E(D)'=ee
 Q
 ;
GO S n=n+1,(n(n),lp)=1,g=I D LOAD S n=n-1,I=g,g=g\100,v=$P(v,".",1,n) Q
 ;
LO Q:$D(@e@($P(Y,"`",15)-1*.001+I))
LIST S f=$P(Y,"`",4),j=$P(^ZAA02GDISP(SCR,SN,I_".2"),"`",2)
 F ls=0:1:$P(Y,"`",15)-1 X j,f S @e@(.001*ls+I)=D
 Q
 ;
