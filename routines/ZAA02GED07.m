%ZAA02GED07 ;;%AA UTILS;1.24;EDIT: MARK TEXT;24APR91  16:39
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
POS S m=0 W eLO G P1
MARK S m=1 W eHI
P1 S:'$D(^(s)) s=$O(^(s)) S l=$P(^(s),d,2)
PO S %R=r,fc=$S(s#1:ct+lm-1,1:lm),c=$S(c<fc:fc,1:c),%C=c W @ZAA02GP
RD S (ch,fk)="" R ch#1 X ZAA02G("T") I ch]"" G RK:ch=" " W *7 G RD
        S fk=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2) G:"RK,LK,CR,UK,DK,RU,TB,PU,PD,FP,GE,GW,CP,EX"[fk @fk W *7 G RD
RK S c=c+1 I m W $E(l,c-lm) G:c'>rm PO D NL S c=fc G PO
        W ZAA02G("RT") G:c'>rm PO D NL S c=fc G PO
RU ;
LK I m,s=s1,c'>c1 W *7 G RD
        S c=c-1 I m W $C(8)_eLO_$E(l,c-lm+1)_eHI
        W ZAA02G("L") G:c'<fc PO S c=rm D PL G GE
DK D NL G PO
UK I m,s'>s1 W *7 G RD
        D PL G PO
CR S c=lm D NL G PO
EX ;;
CP Q
PD D NP G PO
PU I m,ts'>s1 W *7 G RD
        D PP G PO
TB S x=$O(tbx(c)) G:'x!(x-2>rm) RD I m W $E(l,c-lm+1,x+lm-3)
        S c=x+lm-1 G PO
GE S l=$P(^(s),d,2) X "F i=$L(l):-1:1 Q:$E(l,i)'="" """ I m,c+lm<rm W eHI_$E(l,c-lm+1,i+lm)
        S c=i+lm G PO
GW S c=fc G PO
NL I m S %R=r D DSP(s,0)
        S x=s,s=$O(^(s)) S:s="" s=x+10000\1,^(s)=x S l=$P(^(s),d,2),fc=$S(s#1:lm+ct-1,1:lm),bc=$S(fc>lm:" ",1:""),c=$S(c<rm:c,1:fc),r=r+1,%R=r,%C=c
        I r'>bl Q:'m  D DSP(s,c) Q
        S bs=s,ts=$O(^(ts)),r=bl,l=$P(^(s),d,2) I sr S %R=bl W @ZAA02GP,! D DSP(s,c) Q
        S %R=tl,%C=lm W @ZAA02GP,@ZAA02G("DT") S %R=bl W @ZAA02GP,@ZAA02G("IL") D DSP(s,c) Q
PL S x=+^(s) Q:'x  I m s %R=r D DSP(s,1)
        S s=x,fc=$S(s#1:lm+ct-1,1:lm),c=$S(c'>fc:fc,1:c),l=$P(^(s),d,2),bc=$E(l),r=r-1
        I r'<tl Q:'m  S %R=r S:s=s1&(c<c1) c=c1 D DSP(s,c) Q
        S r=tl,ts=s,bs=+^(bs) I sr S (%R,r)=tl,%C=lm,l=$P(^(s),d,2) W @ZAA02GP,@ZAA02G("IL") D DSP(s,c) Q
        S %R=bl,%C=lm W @ZAA02GP,@ZAA02G("DT") S %R=tl,l=$P(^(s),d,2) W @ZAA02GP,@ZAA02G("IL") D DSP(s,c) Q
NP W $S('m:eLO,bs'<s1:eHI,1:eLO) S (x,ts)=$O(^(bs)) S:'x (x,ts)=bs+10000\1,^(x)=bs
        F %R=tl:1:bl S bs=$O(^(bs)) S:bs="" bs=x+10000\1,^(bs)=x_d S x=bs,%C=lm-1,l=$P(^(bs),d,2) D DSP(bs,-c) S:%R=r s=bs
        S l=$P(^(s),d,2) W:m eHI Q
PP S x=+^(ts) Q:'x!(ts'>s1&m)  S bs=x
        F %R=bl:-1:tl Q:'^(ts)  S ts=+^(ts),l=$P(^(ts),d,2) D DSP(ts,-c) S:%R=r s=ts
        I %R=tl S l=$P(^(s),d,2) G PP1
        S bs=0 D NP S r=tl,s=ts,l=$P(^(s),d,2)
PP1 Q:'m!(s'<s1)  F s=s:0 S s=$O(^(s)),r=r+1 Q:s'<s1
        S l=$P(^(s),d,2),%R=r,c=$S(c<c1:c1,1:c),%C=lm-1 D DSP(s,c) Q
FP I m W *7 G RD
        S bs=0,r=tl D NP S c=lm G PO
DSP(s,c) N L,H S %C=lm-1 W @ZAA02GP," "
        I 'm W eLO_l_tCL Q
        I c>0,s'<s1 G DSP1
        I s<s1 W eLO_l_eHI_tCL Q
        I c<0,%R>r W eLO_l_eHI_tCL Q
        I c<0,%R=r S c=-c G DSP1
        I s>s1 W eHI_l_tCL Q
        W eLO_$E(l,1,c1-lm)_eHI_$E(l,c1-lm+1,511)_tCL Q
DSP1 I s=s1 S L=c1-lm,H=c-lm,H=$S(H<L:L,1:H) W eLO_$E(l,1,L)_eHI_$E(l,L+1,H)_eLO_$E(l,H+1,511)_eHI Q
        W eHI_$E(l,1,c-lm)_eLO_$E(l,c-lm+1,511)_eHI_tCL Q
        ;
