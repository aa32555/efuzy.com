%ZAA02GED06 ;;%AA UTILS;1.24;EDIT: COPY/MOVE;16MAY91  11:40
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
ADD I $S(tgl'=gl:1,ts'=xts:1,1:0) S bs=$S($D(@gl@(xts)):+^(xts),1:0),m=0 D NP^ZAA02GED07 G ADD1
        S:type="M" r2=bl S S=s1,%C=lm,x=$D(@gl@(S)) S:'x S=$O(^(S)) S:'S S=s1\1+10000,^(S)=s1_d W eLO
        F %R=xr:1 W @ZAA02GP,$P(^(S),d,2)_tCL Q:%R'<r2  S x=$O(^(S)) S:x="" x=S\1+10000,^(x)=S_d S S=x
ADD1 S x=$D(@gl@(0)),m=0,r=xr,c=xc,s=$S($D(^(xs)):xs,1:$O(^(xs))) W pBL_eLO_"Move to insert point and push "_eHI_"COPY/MOVE" D POS^ZAA02GED07
        I fk="EX" S mk=0 S:type'="M" r2=r1-1 Q:type'="M"  S s=$S($D(^(s1)):s1,1:$O(^(s1))),c=c1 s:s="" s=s1\1+10000,^(s)=s1_d
        W pBL_"Inserting..."_tCL,@ZAA02GP S c1=$P(@cgl,"`",2),r1=r,s1=s,xc=c,xr=r,xs=s,xts=ts,cx=1,pd=$J("",c-lm) G ADD3:+@cgl>1
        S l=$P(@gl@(s),d,2),l=$E(l_pd,1,c-lm)_$S(c<tb&(c1'<tb):$J("",tb-1),1:"")_@cgl@(1)_$E(l,c-lm+1,511),N=s\1,L=""
        F S=N-.001:0 S S=$O(@gl@(S)) Q:S=""!(S\1'=N)  S L=L_$E($S(s=S:l,1:$P(^(S),d,2)),$S(S#1:ct,1:1),511)
        D FIX Q
ADD3 S r2=bl,x=$D(@gl@(0)),N=s\1,o=+^(N),L="" F S=N-.001:0 S S=$O(^(S)) Q:S=""!(S=s)  S L=L_$E($P(^(S),d,2),$S(S#1:ct,1:1),511)
        S l=$P(^(S),d,2),L=L_$E(l_pd,$S(S#1:ct,1:1),c-lm)_$S(c<tb&(c1'<tb):$J("",tb-1),1:"")
        S l=$E(l,$S(c=lm:1,1:c-lm+1),511) F S=S:0 S S=$O(^(S)) Q:S=""!(S\1'=N)  S l=l_$E($P(^(S),d,2),$S(S#1:ct,1:1),511) K ^(S)
        S L=L_@cgl@(1) D FIX
        F S=1:0 S S=$O(@cgl@(S)) Q:S=""  S L=@cgl@(S)_$S($O(^(S))="":l,1:"") D INS,FIX
        Q
INS N n,new,fr,nx,I S nx=$O(@gl@(N+.99)) G INS1:nx]"" S (nx,fr)=N F I=0:0 S nx=$O(^(N+.99)) Q:nx=""  S fr=nx
        S nx=N+10000\1,^(nx)=fr_d
INS1 S fr=+^(nx) D:nx-fr<2 RENUM^ZAA02GED04 S N=0,n=(nx\1)-(fr\1),n=$S(n>10000:10000,n>1000:1000,n>100:100,n>10:10,1:1) S N=fr\1+n
        S $P(^(nx),d)=N,^(N)=fr_d
        Q
FIX N mx,s,mx,o,S,tg,cn S s=N,mx=rm-lm+1,o=+@gl@(N),pd=$J("",ct-1),cn=0
        I $E(L)'=ci S tg=$P(L," ") S tg=tg_$J("",tb-$L(tg)-2),L=$P(L," ",2,511),L=tg_" "_$E(L,$F(L,$E($TR(L," ","")))-1,511)
        F S=N-.001:0 S S=$O(^(S)) Q:S=""!(S\1'=N)  S cn=cn+1 K ^(S) ;Delete continuation lines
FIX1 I $L(L)<mx S ^(s)=o_d_L,L="",S=$O(^(s)),S=$S(S:S,1:s\1+10000),$P(^(S),d)=s S:cn<1 r2=bl Q
        S ^(s)=o_d_$E(L,1,mx),o=s,s=s+.1,L=pd_$E(L,mx+1,511),cn=cn-1 G FIX1
        Q
DELETE G DEL2:s1'=s2 S l=$P(@tgl@(s1),d,2),l=$E(l,1,c1-lm)_$E(l,c2-lm+1,511),N=s1\1,L=""
        F S=N-.001:0 S S=$O(^(S)) Q:S=""!(S\1'=N)  S L=L_$E($S(s1=S:l,1:$P(^(S),d,2)),$S(S#1:ct,1:1),511)
        D FIX S:'$D(@gl@(xs)) (s,xs)=$O(@gl@(xs)) Q
DEL2 S fr=+@gl@(s1) S:c1>lm $P(^(s1),d,2)=$E($P(^(s1),d,2),1,c1-lm) K:c1'>lm ^(s1)
        F S=s1:0 S S=$O(^(S)) Q:S=""!(S'<s2)  K ^(S)
        I S=s2 S $P(^(S),d)=fr,l=$J("",$S(S#1:ct,1:0))_$E($P(^(S),d,2),c2-lm+1,511),N=s2\1,L=""
        F S=N-.001:0 S S=$O(^(S)) Q:S=""!(S\1'=N)  S L=L_$E($S(s2=S:l,1:$P(^(S),d,2)),$S(S#1:ct,1:1),511)
        I L]"" S @gl@(N)=fr_d D FIX I 1
        E  K ^(s2) S S=$O(^(s2)) S:S="" S=s2\1+10000 S $P(^(S),d)=fr
        S:'$D(@gl@(xs)) (s,xs)=$O(@gl@(xs)) Q
        ;
