%ZAA02GED04
INS(ro,fr,cn,in,tp) N j,l,n,nx,nl,pd,new S:'$D(tp) tp=0 S xbs=bs,xts=ts,nx=$O(^(fr))
	I cn S new=fr+.1,pd=$J("",ct-1),fc=lm+ct-1,l="",nl=1 S:$D(^(new)) l=$P(^(new),d,2),nl=0 G INS2
	S fc=lm,nl=1,(pd,l)="" I nx="" S new=fr\1+10000 G INS2
	D:nx-fr<2 RENUM S n=(nx\1)-(fr\1),n=$S(n>10000:10000,n>1000:1000,n>100:100,n>10:10,1:1),new=$S(tp:fr\1+n,1:nx\1-n)
INS2 S:nx $P(^(nx),d)=new S ^(new)=fr_d_pd_in_$E(l,$L(pd)+$L(in)+$S($D(im):im=0,1:0),511),(%C,c)=fc,s=new,cx=cx+1
	I nl,'sr S %R=$S(ro'>bl:bl,1:tl) W @ZAA02GP,@ZAA02G("DT")
	S (%R,r)=$S(ro'>bl:ro,1:bl) I nl S:ro'>bl bs=+^(bs) S:ro>bl ts=$O(^(ts)),bs=$O(^(bs))
	I nl&sr W @ZAA02GP,@$S(ro'>bl:ZAA02G("IL"),1:"$C(13,10)"),@ZAA02GP
	I nl&'sr W @ZAA02GP,@ZAA02G("IL"),@ZAA02GP
	W @ZAA02GP,$E($P(^(s),d,2),fc-lm+1,511)_tCL
	Q
CUT N i,l,m,o,cn,xc,xr,xs,S,W S %C=c W @ZAA02GP,tCL
	S xr=r,xc=c,cn=0,l=$P(^(s),d,2),$P(^(s),d,2)=$E(l,1,c-lm)
	S l=$S(c<(lm+tb-1):"",$E(l)=ci:ci,1:" ")_$E(l,c-lm+1,511),l=$$FMT(l,0) I l="" S l=$J("",lm+tb-3)
	S S=s,m=0 F i=0:0 S S=$O(^(S)) Q:S=""!(S\1'=(s\1))  S m=m+1,m(m)=$E($P(^(S),d,2),ct,511),cn=cn+1 K ^(S)
	D INS(r+1,$$LAST(s\1),0,l,1) S xs=+^(s)
	S %R=r,%C=lm,W=rm-lm+1,o=xs,S=0
C2 S S=S+1 G:S>m C3 I $L(l)+$L(m(S))<W S l=l_m(S) G C2
	S p=W-$L(l),l=l_$E(m(S),1,p),^(s)=o_d_l W:%R'>bl @ZAA02GP,eLO_l_tCL
	S %R=%R+1,cn=cn-1,o=s,s=s+.1,l=$J("",ct-1)_$E(m(S),p+1,511) G C2
C3 S ^(s)=o_d_l W:%R'>bl @ZAA02GP,eLO_l_tCL S %R=%R+1,S=$O(^(s)) S:S $P(^(S),d)=s
	I cn,%R'>bl S r=%R F i=1:1:cn D BOTM S %R=r W @ZAA02GP,@ZAA02G("DT") S %R=bl,%C=lm W:'sr @ZAA02GP,@ZAA02G("IL") W @ZAA02GP,eLO_$P(^(bs),d,2)_tCL
	S s=xs,r=xr,c=xc,cx=cx+1 Q
BOTM S B=$O(^(bs)) S:B="" B=bs+10000\1,^(B)=bs S bs=B K B Q
LAST(s) S last=s F i=0:0 S nxt=$O(^(last)) Q:$P(nxt,".")'=$P(last,".")  S last=nxt
	Q last
JOIN N l,t,m,o,cn,xc,xr,xs,S,W,SS S xs=s,xr=r,xc=c,cn=0,W=rm-lm+1
	F i=0:0 S S=$O(^(s)) Q:$P(S,".")'=$P(s,".")  S s=S S:%R<bl %R=%R+1
	S o=+^(s),l=$P(^(s),d,2) I s=xs,c>tb,c>($L(l)+lm) S l=l_$J("",c-$L(l)-lm)
	S m=1,m(1)=$$FMT(l,s#1)
	S S=$O(^(s)),SS=S\1 F i=0:0 Q:S\1'=SS  D BUILDm K ^(S) S S=$O(^(S))
	S l=m(1),%C=lm,S=1 G C2
BUILDm S m=m+1,cn=cn+1,l=$P(^(S),d,2) I S#1=0,m(1)="" S l=$$FMT(l,0),m(1)=$E(l,1,W),m(2)=$E(l,W+1,511) Q
	I S#1=0,$$TAG(l)'="" S l=$P(l," ",2,511)
	S i=2 I $E(l)'=ci F i=1:1:$S(S#1:ct,1:tb) Q:$E(l,i)'=" "
	S m(m)=$E(l,i,511) Q
RENUM N I,N,S,xs,rx,ns,nts,nbs,nfr,nnx,nxts W pBL_eHI_"Renumbering..."_eLO_tCL K ^ZAA02GEDTMP($J,3) S xs=s,nts=ts,nfr=fr,(s,S,N)=0,nxts=$G(xts)
	F I=0:0 S s=$O(@gl@(s)) Q:s=""  S:s\1'=N S=S\1+10000,N=s\1 S ^ZAA02GEDTMP($J,3,S)=$P(^(s),d,2) S:s=nxts nxts=S S:s=ts nts=S S:s=xs ns=S S:s=bs nbs=S S:s=fr nfr=S\1+(fr#1) S:nx=s nnx=S S S=S+.1
	S rx=@gl K @gl S @gl=rx,(s,S)=0 F I=0:0 S S=$O(^ZAA02GEDTMP($J,3,S)) Q:S=""  S @gl@(S)=s_d_^(S),s=S
	K ^ZAA02GEDTMP($J,3) S ts=nts,s=ns,fr=nfr,nx=nnx,bs=nbs,rx=$D(@gl@(ts)) S:nxts xts=nxts
	W pBL_tCL Q
FMT(l,f) I f!($E(l)=ci) Q l
	I $TR(l," ","")="" Q ""
	S t=$$TAG(l) S:t]" " l=$P(l," ",2,511) F i=1:1:$L(l)+1 Q:$A(l,i)>32
	S l=t_$J("",tb-$L(t)-2)_" "_$E(l,i,511) Q l
TAG(l) N t S t=$P(l," ") I t?1.8AN!(t?1"%"1.7AN) Q t
	I t?1.8AN1"(".E1")"!(t?1"%"1.7AN1"(".E1")") Q t
	Q ""
	;
	;