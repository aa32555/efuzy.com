%ZAA02GED01
DEL(ro,sb) N n,p
	I ro=tl S ts=$O(^(ts))
	I ro=bl S bs=$O(^(bs))
	E  S x=$O(^(bs)) S:x="" x=bs\1+10000,^(x)=bs S bs=x
	S cx=cx+1,n=$O(^(sb)),p=+^(sb) K ^(sb) S:n="" n=p\1+10000 S $P(^(n),d)=p,s=n,fc=$S(s#1:lm+ct-1,1:lm)
	S %R=ro,%C=lm W @ZAA02GP,@ZAA02G("DT") S %R=bl W:'sr @ZAA02GP,@ZAA02G("IL") W @ZAA02GP,$P(^(bs),d,2) Q
NEW S %R=bl+2,%C=lm-1,Y="RON\ROF\EX\\8\\X?1A.AN!(X?1""%"".AN)\\\\Routine Name: ",X="" W @ZAA02GP,tLO_tCL D ^ZAA02GEDRS K Y
	G:ZAA02GF="EX" POP^ZAA02GED I X]"",$D(@wgl@(X))!($D(@agl@(X))) S %C=rm-24 W @ZAA02GP,*7,tLO_"Routine already in system" H 2 G NEW
	I X]"" S R=X D LOCK^ZAA02GEDL2 G:'OK POP^ZAA02GED
	I rgl]"",rt]"",rt'=X K @rgl@(rt)
	K @gl S rt=X,@gl=rt_"`"_tl_"`"_lm_"`0`0`" K R,X,Y G DSPL^ZAA02GED
RUB N m,xr,xc,xs,c1,c2,pad,t,cn X ZAA02G("EOF") W pBL_tHI_"Rubout:  "_tLO_"Use cursor keys to mark text, press "_tHI_"RETURN"_tCL
	S (%R,xr)=r,(%C,xc)=c,xs=s,m=1,m(m)=s_"``"_(c-1),l=$P(^(s),d,2) W @ZAA02GP,eHI G LK
RU1 R ch#1 I ch="" X ZAA02G("T") S fk=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2) G:"RU,RK,LK,CR,EX"[fk @fk
	W *7 G RU1
RU ;
LK I c'>$S(s#1:ct+1,1:lm) S n=+^(s) G RU1:'n!(n\1'=(s\1)) S s=n,l=$P(^(s),d,2),l=l_$J("",rm-lm-$L(l)-1),r=r-1,c=rm+1,fc=$S(s#1:ct,1:lm),m=m+1,m(m)=s_"``"_rm D PL:r<tl S %R=r,%C=c W @ZAA02GP,eHI
	S ch=$E(l,c-lm),c=c-1,$P(m(m),"`",2)=c W ZAA02G("L")_$S(ch=" ":".",1:ch)_ZAA02G("L") G RU1
RK W eLO_$E(l,c-lm+1)_eHI
	S c=c+1 I c>rm G RU1:m=1 S m=m-1,s=+m(m),l=$P(^(s),d,2),(%R,r)=r+1,c=$S(s#1:ct,1:lm),%C=c W @ZAA02GP
	S $P(m(m),"`",2)=c G EX:c=xc&(r=xr),RU1
PL S fc=$S(n#1:lm+ct-1,1:lm),bc=$E($P(^(s),d,2)),r=tl,ts=s,bs=+^(bs),xr=xr+1
	I sr S (%R,r)=tl,%C=lm W @ZAA02GP,@ZAA02G("IL"),@ZAA02GP,eLO_$P(^(s),d,2) Q
	S %R=bl,%C=lm W @ZAA02GP,@ZAA02G("DT") S %R=tl W @ZAA02GP,@ZAA02G("IL"),@ZAA02GP,eLO_$P(^(s),d,2) Q
CR G EX:c=xc&(r=xr) S cn=r,pad=$J("",ct-lm+1),mx=rm-lm+1 I m=1 S x=+m(1),c1=$P(m(1),"`",2),c2=$P(m(1),"`",3),l=$P(^(s),d,2),$P(^(s),d,2)=$E(l,1,c1-lm)_$E(l,c2-lm+2,511) G CR1
	S s=+m(m),c1=$P(m(m),"`",2),l=$P(^(s),d,2),$P(^(s),d,2)=$E(l,1,c1-lm)
	S x=+m(1),c2=$P(m(1),"`",3),l=$P(^(x),d,2),$P(^(x),d,2)=pad_$E(l,c2-lm+2,511) F i=2:1:(m-1) S $P(^(+m(i)),d,2)=pad
CR1 S (n,s)=+m(m),T=$P(^(s),d,2)
	I '(s#1),$E(T)'=ci,$P(T," ")]"" S t=$P(T," "),t=t_$J("",tb-$L(t)-2),T=$P(T," ",2,511),T=t_" "_$E(T,$F(T,$E($TR(T," ","")))-1,511)
CR2 S n=n+.1 I $D(^(n)) S l=$P(^(n),d,2),T=T_$E(l,ct,511) G CR2:$L(T)<mx S $P(^(s),d,2)=$E(T,1,mx),T=pad_$E(T,mx+1,511),s=s+.1,cn=cn+1 G CR2
	S $P(^(s),d,2)=T,n=+^(s) S:T]pad n=s,s=$O(^(s)) I (s\1)=(m(1)\1) F i=s:.1:s\1+.9 K ^(i) S cn=bl
	S s=$O(^(n)),$P(^(s),d)=n
	S %C=lm,s=$S($D(^(+m(m))):+m(m),1:+$O(^(+m(m)))),(x,bs)=+^(s) W eLO F %R=r:1:bl S bs=$O(@gl@(bs)) S:bs="" bs=x+10000\1,^(bs)=x_d S x=bs W:%R'>cn @ZAA02GP,$P(^(bs),d,2)_tCL
	X ZAA02G("EON") S s=+m(m),r=xr-m+1,c=$P(m(m),"`",2),cx=cx+1 W VERS_tCL_MODE Q
EX S %R=xr F i=1:1:m S s=+m(i),c1=$P(m(i),"`",2),c2=$P(m(i),"`",3),%C=c1 S:'%C %C=lm W @ZAA02GP,eLO_$E($P(^(s),d,2),c1-lm+1,c2-lm+1) S %R=%R-1
	X ZAA02G("EON") S r=xr,c=xc,s=xs W VERS_tCL_MODE Q
	;
	;