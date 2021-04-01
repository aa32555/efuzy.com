%ZAA02GED03 ;;%AA UTILS;1.24;EDIT: INSERT CHARACTER;24APR91  16:30
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
INSRT N INS,xs,xr,xc,sx S xs=s,xr=r,xc=c,(INS,sx)=0
        W pBL_tHI_"Insert Text:  "_tLO_"Enter desired text, press "_tHI_"RETURN"_tCL
        D MOVE G EX:'$T  S r=xr,c=xc,s=xs\1
PO S %R=r,%C=c,fc=$S(s#1:ct+lm-1,1:lm) W @ZAA02GP,eHI
RD R ch#rm-c+2 I ch]"" S l=$P(^ZAA02GEDTMP($J,1,s),d,2),l=$E(l_$J("",rm-$L(l)),1,c-lm)_ch_$E(l,c+$L(ch)-lm+1,511),c=c+$L(ch) G:$L(l)>(rm-lm+1) WR S $P(^(s),d,2)=l
        X ZAA02G("T") S fk=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2) G:"RU,CR,EX"[fk @fk G RD
WR S %R=r,%C=rm+1 W @ZAA02GP," " S ch=$E(l,$L(l)),$P(^(s),d,2)=$E(l_$J("",rm-$L(l)),1,$L(l)-1) D INS(r+1,s,1,ch) S sx=sx+1,c=fc+1 G PO
RU I r=xr,c'>xc G EX
        S l=$P(^ZAA02GEDTMP($J,1,s),d,2),l=$E(l,0,c-lm-1),c=c-1,$P(^(s),d,2)=l I $S(c>ct:1,s#1:0,c>lm:1,1:0) W $C(8,32,8) G RD
        S %C=1 W @ZAA02GP,@ZAA02G("DT") S %R=bl W:'sr @ZAA02GP,@ZAA02G("IL") S x=$O(@gl@(bs)) S:x="" x=bs\1+10000,^(x)=bs_d S bs=x W @ZAA02GP,eLO_$P(^(bs),d,2)
        S (%R,r)=r-1,(%C,c)=rm W @ZAA02GP,$C(32,8)_eHI G RD
CR D FIX S cx=cx+1 G EXIT
EX S %R=xr,%C=xc,s=xs W @ZAA02GP,eLO_$E($P(@gl@(s),d,2),xc-lm+1,511)_tCL S %C=lm
        F i=0:0 S s=$O(^(s)) Q:s=""!(s\1'=(xs\1))  S %R=%R+1 W:%R'>bl @ZAA02GP,$P(^(s),d,2)_tCL
        I sx S bs=s,INS=0 F %R=%R+1:1:bl W @ZAA02GP,$P(^(bs),d,2)_tCL S bs=$O(^(bs))
        I INS S %R=%R+1 I %R<bl W @ZAA02GP,@ZAA02G("DT") S %R=bl,%C=lm,bs=$O(^(bs)) W:'sr @ZAA02GP,@ZAA02G("IL") W @ZAA02GP,$P(^(bs),d,2)
        S r=xr,c=xc
EXIT W pBL_tCL_eLO K ^ZAA02GEDTMP($J,1) S s=xs,xs=$D(@gl@(s)) K l,ch Q
MOVE K ^ZAA02GEDTMP($J,1) N N,O,S,tmp S %R=r,%C=c,l=$P(@gl@(s),d,2),tmp=$E(l,c-lm+1,511) Q:$TR(tmp," ","")=""
        W @ZAA02GP,tCL S N=s\1,^ZAA02GEDTMP($J,1,N)=0_d_$E(l,1,c-lm),O=N,N=N+.8,^(N)=O_d_$J("",ct-1)_tmp,O=N,S=s
        F i=0:0 S S=$O(@gl@(S)) Q:S=""!((S\1)'=(s\1))  S N=N+.01,^ZAA02GEDTMP($J,1,N)=O_d_$P(^(S),d,2),O=N
        I 1 Q:r+1>bl  Q:$TR(tmp," ","")=""
        I 'sr S %R=bl W @ZAA02GP,@ZAA02G("DT")
        S %R=r+1,%C=lm,INS=1,bs=$S(bs:+@gl@(bs),1:0) W @ZAA02GP,@ZAA02G("IL"),@ZAA02GP,eLO_$J("",ct-1)_$E(tmp,1,rm-lm-ct+2)
        I 1 Q
FIX N S,r,c,o,cn,mx,t S S=xs,mx=rm-lm+1,cn=0
        F i=0:0 S S=$O(@gl@(S)) Q:S=""!(S\1'=(s\1))  K ^(S)
        S s=xs,c=xc,o=+@gl@(s),l=$P(^ZAA02GEDTMP($J,1,s\1),d,2),S=xs\1,%R=xr,%C=lm
FIX1 S S=$O(^ZAA02GEDTMP($J,1,S)) G:S="" FIX2 S cn=cn+1,L=$E($P(^(S),d,2),ct,511) I $L(l)+$L(L)<mx S l=l_L G FIX1
        S p=mx-$L(l),l=l_$E(L,1,p) D FIX3 S @gl@(s)=o_d_l W:%R'>bl @ZAA02GP,eLO_l_tCL S %R=%R+1,cn=cn-1,o=s,s=s+.1,l=$J("",ct-1)_$E(L,p+1,511) G FIX1
FIX2 I l]"",$TR(l," ","")]"" D FIX3 S @gl@(s)=o_d_l W:%R'>bl @ZAA02GP,eLO_l_tCL S %R=%R+1 I 1
        E  S s=o,cn=cn+1
        S S=$O(@gl@(s)) I S]"" S $P(^(S),d)=s
        I cn,%R'>bl S r=%R F i=1:1:cn S %R=r W @ZAA02GP,@ZAA02G("DT") S %R=bl,%C=lm S:bs]"" bs=$O(@gl@(bs)) W:'sr @ZAA02GP,@ZAA02G("IL") W:bs]"" @ZAA02GP,eLO_$P(^(bs),d,2)
        S l="" I sx F i=1:1:sx S xs=$O(^(xs))
        Q
FIX3 I '(s#1),$P(l," ")]"",$E(l)'=ci S t=$P(l," "),t=t_$J("",tb-$L(t)-2),l=$P(l," ",2,511),l=t_" "_$E(l,$F(l,$E($TR(l," ","")))-1,511)
        Q
INS(ro,fr,cn,in) N j,l,n,nx,nl,pd,new S nx=$O(^ZAA02GEDTMP($J,1,fr)),(fc,nl)=1,(l,pd)="" S:nx="" nx=fr\1+10000,^(nx)=fr_d
        I cn S new=fr+.1,pd=$J("",ct-1),fc=lm+ct-1 S:$D(^(new)) l=$P(^(new),d,2),nl=0
INS1 E  S new=0,n=(nx\1)-(fr\1),j=$S(n>10000:10000,n>1000:1000,n>100:100,n>10:10,n>1:1,1:0) D:'j RENUM^ZAA02GED04 G:'j INS1 S new=nx-j
        S $P(^(nx),d)=new,^(new)=fr_d_pd_in_$E(l,$L(pd)+$L(in)+1,511),(%C,c)=fc,s=new I nl,'sr S %R=bl W @ZAA02GP,@ZAA02G("DT")
        S:ro'>bl r=ro S:nl bs=+@gl@(bs) S %R=r
        I nl&sr W @ZAA02GP,@$S(ro'>bl:ZAA02G("IL"),1:"$C(13,10)")
        I nl&'sr W @ZAA02GP,@ZAA02G("IL")
        W @ZAA02GP,$E($P(^ZAA02GEDTMP($J,1,s),d,2),fc-lm+1,511)_tCL
        Q
        ;
