%ZAA02GED13
RUB S ru=0,pad=$J("",ct-1) D CHR
RU1 R ch#1 I ch="" X ZAA02G("T") S fk=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2) I fk="RU" D CHR G RU1
	I ch]"" S l=$E(l_$J("",rm-$L(l)),1,c-lm)_ch_$E(l,c-lm+1,511),$P(^(s),d,2)=l,cx=cx+1,ru=ru-1,c=c+1,ch="" I ZAA02G("ION")="" S %R=r,%C=c W $E(l,c-lm+1,rm-lm+1),@ZAA02GP
	S x=$O(^(s)) S:ru $P(^(s),d,2)=l,cx=cx+1 I ru,x\1=(s\1) S zs=s D UPD S s=zs K zs
	S:fk="RU" fk=" " K l,x,ru,pad Q
CHR I c=lm S:ru $P(^(s),d,2)=l,cx=cx+1,ru=0 D JOIN S %R=r,%C=c W @ZAA02GP Q
	I c=fc S:ru $P(^(s),d,2)=l,cx=cx+1,ru=0 D UPD S l=$P(^(s),d,2),fc=$S(s#1:ct+lm-1,1:lm)
	S %R=r,(%C,c)=c-1 I ZAA02G("DL")="" W @ZAA02GP,$E(l,c-lm+2,rm-lm+1)_tCL,@ZAA02GP
	E  W @ZAA02GP,ZAA02G("DL")
	S l=$E(l,0,c-lm)_$E(l,c-lm+2,511),ru=ru+1 Q
JOIN I ZAA02G("IOF")]"" W @ZAA02G("IOF")
	D PL^ZAA02GED11,EN S %R=r,%C=c,l="" W @ZAA02GP D JOIN^ZAA02GED04 S l=$P(^(s),d,2),fc=$S(s#1:ct+lm-1,1:lm) S:c<fc c=fc
	I ZAA02G("ION")]"" W @ZAA02G("ION")
	Q
UPD I ZAA02G("IOF")]"" W @ZAA02G("IOF")
	N S,N,nl I c=fc D:$O(^(s))\1'=(s\1)&($TR($P(^(s),d,2)," ","")="") DEL(r,s) D PL^ZAA02GED11 S c=rm+1
	G:'ru UPE S S=s,N=$O(^(s)) I N\1'=(S\1) G UPE
UP1 S nl=$P(^(N),d,2),l=l_$E(nl,ct,ct+ru-1),$P(^(S),d,2)=l,cx=cx+1,%C=lm I %R<bl W @ZAA02GP,l,tCL
	S %R=%R+1,l=pad_$E(nl,ct+ru,511),S=N,N=$O(^(S)) I N,N\1=(S\1) G UP1
	I l'=pad S $P(^(S),d,2)=l,cx=cx+1 W @ZAA02GP,l,tCL
	I l=pad,S\1=(s\1) D DEL(%R,S) S cx=cx+1
UPE S %R=r,%C=c,ru=0 I ZAA02G("ION")]"" W @ZAA02G("ION")
	W @ZAA02GP Q
EN S l=$P(^(s),d,2) F i=$L(l):-1:1 Q:$A(l,i)>32
	S c=i+lm Q
DEL(ro,sb) N n,p,x
	I ro=bl S bs=$O(^(bs))
	E  S x=$O(^(bs)) S:x="" x=bs\1+10000,^(x)=bs S bs=x
	S cx=cx+1,n=$O(^(sb)),p=+^(sb) K ^(sb) S:n="" n=p\1+10000 S $P(^(n),d)=p,s=n,fc=$S(s#1:lm+ct-1,1:lm)
	S %R=ro,%C=lm W @ZAA02GP,@ZAA02G("DT") S %R=bl W:'sr @ZAA02GP,@ZAA02G("IL") W @ZAA02GP,$P(^(bs),d,2) Q
	;
	;