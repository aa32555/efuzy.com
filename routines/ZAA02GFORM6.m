ZAA02GFORM6 ;PG&A,ZAA02G-FORM,2.62,LIST EDIT;13OCT94  01:55
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
SETUP S a=^(I_".2"),get=$P(a,"`",2),a=$P(a,"`",3),ju=($P(a,",",7)["J"),np=$P(a,",",2),mx=$P(a,",",5)-np+1,a=$P(Y,"`",3),cr=$S('n:+a,1:li(I,dv)),lm=$P(a,",",2)-2,mg=$P(Y,"`",5)
 S gx="S X="_$P(Y,"`",10),put=$P(Y,"`",2),px="S "_$P(Y,"`",10)_"=X",xd=$P(Y,"`",4)
 S gx=get,px=put ; temp
 W l24,"        Multiples  -  Use Line and Page Scroll Keys  -  TAB to Get Out"
 X dm S ef=$A(@ty,I#100)\16#2,r5=0,W=$S(l<ln:l+1,1:ln)
 S lp=0,%C=lm+2,%R=cr-1 W ro G:$P(RX,",",5) RX I $S(ro="":0,ro=ZAA02G("HI"):0,rf[ro:0,1:1) F ls=0:1:np-1 S %R=%R+1 W @ZAA02GP,@e@(ls*.001+I)
 S RX=1,%R=cr,%C=lm+W+1,X=$P(@e@(I),ee),ls=0 W @ZAA02GP G RD^ZAA02GFORM6A
 ;
RX S (ls,lp)=$P(RX,",",5) D REFR^ZAA02GFORM6A G 240^ZAA02GFORM6A
 ;
EXIT S %C=lm+2,%R=cr-1,ed0=0 W rf F ls=0:1:np-1 S %R=%R+1 W @ZAA02GP,@e@(ls*.001+I) S ed0=$E(@e@(ls*.001+I))'=ee+ed0,li(I,dv,ls)=.001*ls+I
 I ed0=0 F ls=ls+1:1:mg-1 Q:'$D(@e@(ls*.001+I))  I $E(@e@(ls*.001+I))'=ee S ed0=1 Q
 S $P(@e,2,I#100)=ed0>0
 K ed0,mx,lp,get,xd,put,cc,cr,ju,k,np,x0,ef,gx,px,r5,x6 W l23,m24,ro Q
 ;
F S k=ls,X="" X xd F J=ls+1:1:mx+np-2 S ls=J X gx S ls=ls-1 S:$D(@e@(.001*ls+I)) @e@(.001*ls+I)=$S($D(@e@(.001*J+I)):@e@(.001*J+I),1:D) X px
 S ls=$S(J-mx-np+2:ls,1:J) D FILL S ls=k Q
D S J=ls,ls=mx+np-2 X get I X]"" S ls=J G RD^ZAA02GFORM6A
 F J=ls-1:-1:J S ls=J X gx S ls=ls+1 S:$D(@e@(.001*J+I)) @e@(.001*ls+I)=@e@(.001*J+I) X px
 S ls=J,ef=1 D FILL G D0^ZAA02GFORM6A
FILL S X="" X px,xd S @e@(.001*ls+I)=D Q  ;pass ls
 ;
 ;
SAVE G HS^ZAA02GFORM6A
