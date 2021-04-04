%ZAA02GED02
DEL N m,xr,xc,xs,c1,c2,pad,t,cn X ZAA02G("EOF")
	W pBL_tHI_"Delete Text:  "_tLO_"Use cursor keys to mark text, press "_tHI_"RETURN"_tCL
	S (%R,xr)=r,(%C,xc)=c,xs=s,m=1,m(m)=s_"`"_c,l=$P(^(s),d,2) W @ZAA02GP,eHI G RK
DC1 R ch#1 I ch="" X ZAA02G("T") S fk=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2) G:"RU,DC,RK,LK,CR,EX"[fk @fk
	W *7 G DC1
RU ;
DC ;
RK I c>rm S n=$O(^(s)) G:n=""!((n\1)>(s\1)) DC1 S s=n,l=$P(^(s),d,2),l=l_$J("",rm-lm-$L(l)+1),r=r+1,c=ct+lm-1,fc=ct+lm,m=m+1,m(m)=s I r>bl D NL S xr=xr-1
	S %C=c,%R=r W @ZAA02GP,eHI
	S ch=$E(l,c-lm+1),$P(m(m),"`",3)=c,c=c+1 W $S(ch=" ":".",1:ch) G DC1
LK W ZAA02G("L")_eLO_$E(l,c-lm)_ZAA02G("L")_eHI
	S c=c-1 I c<fc G DC1:m=1 S m=m-1,s=+m(m),l=$P(^(s),d,2),(%R,r)=r-1,c=rm+1,%C=c W @ZAA02GP
	S $P(m(m),"`",3)=c-1 G EX:c=xc&(r=xr),DC1
CR G:c=xc&(r=xr) EX S cn=xr,pad=$J("",ct-lm+1),mx=rm-lm+1 I m=1 S x=+m(1),c1=$P(m(1),"`",2),c2=$P(m(1),"`",3),l=$P(^(s),d,2),$P(^(s),d,2)=$E(l,1,c1-lm)_$E(l,c2-lm+2,511) G CR1
	S s=+m(1),c1=$P(m(1),"`",2),c2=$P(m(m),"`",3),l=$P(^(s),d,2),$P(^(s),d,2)=$E(l,1,c1-lm),x=+m(m),l=$P(^(x),d,2),$P(^(x),d,2)=pad_$E(l,c2-lm+2,511) F i=2:1:(m-1) S $P(^(+m(i)),d,2)=pad
CR1 S (s,n)=+m(1),T=$P(^(s),d,2)
	I '(s#1),$E(T)'=ci S t=$P(T," "),t=t_$J("",tb-$L(t)-2),T=$P(T," ",2,511),T=t_" "_$E(T,$F(T,$E($TR(T," ","")))-1,511)
CR2 S n=n+.1 I $D(^(n)) S l=$P(^(n),d,2),T=T_$E(l,ct,511) G CR2:$L(T)<mx S $P(^(s),d,2)=$E(T,1,mx),T=pad_$E(T,mx+1,511),s=s+.1,cn=cn+1 G CR2
	S $P(^(s),d,2)=T,n=+^(s) S:T]pad n=s,s=$O(^(s)) I (s\1)=(m(1)\1) F i=s:.1:s\1+.9 K ^(i) S cn=bl
	S s=$O(^(n)),$P(^(s),d)=n
	S %C=lm,s=$S($D(^(+m(1))):+m(1),1:+$O(^(+m(1)))),(x,bs)=+^(s) W eLO F %R=xr:1:bl S bs=$O(@gl@(bs)) S:bs="" bs=x+10000\1,^(bs)=x_d S x=bs W:%R'>cn @ZAA02GP,$P(^(bs),d,2)_tCL
	X ZAA02G("EON") S r=xr,c=xc,cx=cx+1 W VERS_tCL_MODE Q
EX S %R=xr F i=1:1:m S s=+m(i),c1=$P(m(i),"`",2),c2=$P(m(i),"`",3),%C=c1 S:'%C %C=lm W @ZAA02GP,eLO_$E($P(^(s),d,2),c1-lm+1,c2-lm+1) S %R=%R+1
	X ZAA02G("EON") S r=xr,c=xc,s=xs W VERS_tCL_MODE Q
ERAS N i,m,o,cn,xr,xc,xs,N X ZAA02G("EOF") S xs=s,(%R,xr)=r,(%C,xc)=c,cn=0,N=s\1 W eHI
	F i=0:0 S l=$P(@gl@(s),d,2) W @ZAA02GP,$E(l,$S(s=xs:c-lm+1,1:1),511) S s=$O(^(s)) Q:s=""!(s\1'=N)  S %R=%R+1,cn=1,%C=lm D NL:%R>bl
	W pBL_tHI_"Erase to END-OF-LINE:  "_tLO_"Press "_tHI_"ERASE"_tLO_" to confirm"_tCL
ER1 R m#1 I m="" X ZAA02G("T") S fk=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2) G:"EF,EX"[fk @("ER"_fk)
	W *7 G ER1
EREF S $P(^(xs),d,2)=$E($P(^(xs),d,2),1,c-lm) F s=xs:0 S s=$O(^(s)) Q:s=""!(s\1'=N)  K ^(s)
	S:s="" s=xs\1+10000 S $P(^(s),d)=xs,%C=c,%R=r W @ZAA02GP,tCL
	I cn S bs=xs,%C=lm-1 F %R=r+1:1:bl S o=bs,bs=$O(^(bs)) S:bs="" bs=o\1+10000,^(bs)=o_d W @ZAA02GP," "_$P(^(bs),d,2)_tCL
	X ZAA02G("EON") W VERS_tCL_MODE S s=xs,cx=cx+1 Q
EREX S %C=c,%R=r W eLO F s=xs:0 S l=$P(^(s),d,2) W @ZAA02GP,$E(l,$S(s=xs:c-lm+1,1:1),511) S s=$O(^(s)),%C=lm,%R=%R+1 Q:s=""!(s\1'=N)
	X ZAA02G("EON") W VERS_tCL_MODE S s=xs Q
NL S r=r-1,fc=$S(s#1:lm+ct-1,1:lm),bc=$S(fc>lm:" ",1:""),bs=s,ts=$O(^(ts)) I sr S %R=bl,%C=lm W !,@ZAA02GP,eLO_$P(^(s),d,2) Q
	S %R=tl,%C=lm W @ZAA02GP,@ZAA02G("DT") S %R=bl W @ZAA02GP,@ZAA02G("IL"),@ZAA02GP,eLO_$P(^(s),d,2)
	Q
	;
	;