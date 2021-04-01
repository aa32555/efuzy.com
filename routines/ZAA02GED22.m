%ZAA02GED22 ;;%AA UTILS;1.24;EDIT: CONTROL (INSERT MODE FOR DUMBEST DEVICES);5NOV91 10:50A
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
DSP(%R,s) S z=$P(^(s),d,2) Q:z=""  S L=$L(z,fs)-1,F=0 W @ZAA02GP,eHI_ZAA02G("RON") F i=1:1:L S F=$F(z,fs,F),%C=F-$L(fs)+1 W @ZAA02GP,fs
        W ZAA02G("ROF")_eLO K L,F,i,z Q
PO S %R=r,fc=$S(s#1:ct+lm-1,1:lm) S:c<fc c=fc S %C=c W @ZAA02GP
RD S (ch,fk)="" R ch#1 I ch="" X ZAA02G("T") S fk=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2)
EV I ch]"" S l=$P(^(s),d,2),l=$E(l_$J("",rm-$L(l)),1,c-lm)_ch_$E(l,c-lm+1,511),(%C,c)=c+1,cx=cx+1 W $E(l,c-lm+1,rm-lm+1),@ZAA02GP G:$E(l,rm)]""!(tb+2>c) WR D SET
FK G RD:fk?." ",@fk:"RK,LK,CR,UK,DK,IC,DC,RU,IL,DL,TB,EF,PU,PD,FP,GE,SU,SD,GO,RE,CT,CP,ST,OT,GW,HL,FM,EX"[fk W *7 G RD
WR I $E(l,c-lm+1)]"" D WI G FK:fk]"",PO
        I $E(l,rm)="" S $P(^(s),d,2)=l G FK
        I $E(l)=ci G:(tb+1)>c FK S x=$P(l," ",$L(l," ")) S:$E(x)=" " x=$E(x,2,511) S x=ci_x,$P(^(s),d,2)=$P(l," ",0,$L(l," ")-1),%C=$L(l)+lm-$L(x),cx=cx+1 W @ZAA02GP,tCL D INS^ZAA02GED04(r+1,s,0,x) S c=$L($P(^(s),d,2))+lm G PO
        S %R=r,%C=rm+1 W @ZAA02GP," " S ch=$E(l,$L(l)),$P(^(s),d,2)=$E(l_$J("",rm-$L(l)),1,$L(l)-1),cx=cx+1 D INS^ZAA02GED04(r+1,s,1,ch) S c=fc+1 G PO
WI S S=s,R=r,C=c,W=rm-lm+1,%C=rm+1 W @ZAA02GP,tCL I s#1!($E(l)=ci)!(tb+1<c&(c>($F(l," ")-1))) D WU G W1
        S t=$P(l," "),l=$P(l," ",2,511) F i=1:1:$L(l) Q:$A(l,i)>32
        S l=t_$J("",tb-$L(t)-2)_" "_$E(l,i,511),%C=lm W @ZAA02GP,$E(l,1,W)_tCL D WU K i,t
W1 G:l="" W2 S x=$O(^(s)) I x\1'=(s\1) D INS^ZAA02GED04(%R+1,s,1,l) G W2
        S s=x,l=$J("",ct-1)_l_$E($P(^(s),d,2),ct,511),%R=%R+1,%C=lm W:%R'>bl @ZAA02GP,$E(l,1,W) D WU G:l]"" W1
W2 S r=R,c=C,s=S I c>(rm+1) D NL S r=R+1,c=fc+1 s:r>bl r=bl
        W @ZAA02GP S fc=$S(s#1:lm+ct-1,1:lm) K x,C,R,S,W Q
WU S $P(^(s),d,2)=$E(l,1,W),l=$E(l,W+1,511) Q
LK S c=c-1 W ZAA02G("L") G:c'<fc PO D PL S c=rm G PO
RK S c=c+1 W ZAA02G("RT") G:c'>rm PO D NL S c=fc G PO
GW S c=fc G PO
TB S x=$O(tbx(c-1)) I 'x!(x+lm-1>rm) S c=lm G DK
        S c=x+lm-1 G PO
RU S l=$P(^(s),d,2),fc=$S(s#1:ct+lm-1,1:lm) D RUB^ZAA02GED13 S %R=r,%C=c W @ZAA02GP G EV
CR D CUT^ZAA02GED04 S c=lm,s=$O(^(s)) S:r<bl r=r+1 G PO
DK D NL G PO
UK D PL G PO
PD D NP G PO
PU D PP G PO
GE D EN G PO
DC D DEL^ZAA02GED02 G PO
IC S (@ugl@(TID,"MODE"),im)=0,MODE=$E(MODE,1,$L(MODE)-$L(eLO)-3)_"OFF"_eLO,l=$D(@gl@(s)) W MODE G PO^ZAA02GED00
EF D ERAS^ZAA02GED02 G PO
SU D SU^ZAA02GED09 G PO
SD D SD^ZAA02GED09 G PO
GO D SRCH^ZAA02GED08 G PO
RE D JOIN^ZAA02GED04 G PO
CT D CUT^ZAA02GED04 G PO
CP D ^ZAA02GED05 G PO
ST D TABSET^ZAA02GED09 G PO
HL S bs=+^(ts),HN=1000 D ^ZAA02GEDH,NP G PO
FM D ^ZAA02GEDRX G PO
OT D ^ZAA02GEDOT G PO
EX Q
NL S x=s,s=$O(^(s)) S:s="" s=x+10000\1,^(s)=x S fc=$S(s#1:lm+ct-1,1:lm),bc=$S(fc>lm:" ",1:""),r=r+1 Q:r'>bl  S bs=s,ts=$O(^(ts)),r=bl I sr S %R=bl,%C=lm W !,@ZAA02GP,eLO_$P(^(s),d,2) D:fs]"" DSP(r,s) Q
        S %R=tl,%C=lm W @ZAA02GP,@ZAA02G("DT") S %R=bl W @ZAA02GP,@ZAA02G("IL"),@ZAA02GP,$P(^(bs),d,2) D:fs]"" DSP(%R,s) Q
PL S x=+^(s) Q:'x  S s=x,fc=$S(s#1:lm+ct-1,1:lm),bc=$E($P(^(s),d,2)),r=r-1 Q:r'<tl  S r=tl,ts=s,bs=+^(bs)
        I sr S (%R,r)=tl,%C=lm W @ZAA02GP,@ZAA02G("IL"),@ZAA02GP,eLO_$P(^(s),d,2)
        E  S %R=bl,%C=lm W @ZAA02GP,@ZAA02G("DT") S %R=tl W @ZAA02GP,@ZAA02G("IL"),@ZAA02GP,$P(^(s),d,2)
        D:fs]"" DSP(%R,s) Q
NP W eLO S (x,ts)=$O(@gl@(bs)) S:'x (x,ts)=bs+10000\1,^(x)=bs F %R=tl:1:bl S bs=$O(@gl@(bs)) S:bs="" bs=x+10000\1,^(bs)=x_d S x=bs,%C=lm-1 W @ZAA02GP," ",$P(^(bs),d,2),tCL S:%R=r s=bs D:fs]"" DSP(%R,bs)
        Q
PP W eLO S x=+^(ts) Q:'x  F %R=bl:-1:tl Q:'^(x)  S x=+^(x)
        I %R'=tl S ts=$O(^(0)) F %R=tl:1:bl S x=$O(^(ts)) S:x="" x=ts\1+10000,^(x)=ts_d S ts=x
        S bs=+^(ts) F %R=bl:-1:tl S ts=+^(ts),%C=lm W @ZAA02GP,$P(^(ts),d,2),tCL S:%R=r s=ts D:fs]"" DSP(%R,ts)
        Q
IL I s#1 W *7 G RD
        D INS^ZAA02GED04(r,+^(s),0,"") S c=fc G PO
DL D DEL^ZAA02GED01(r,s),DSP(%R,bs):fs]"" G PO
FP S bs=0,r=tl D NP S c=lm G PO
SET S i=255 G SE:$E(l)=ci,SE:$O(^(s))\1=(s\1) F i=$L(l)-10:-10:0 Q:$E(l,i,511)'?." "
        F i=i+10:-1:0 Q:$E(l,i)'=" "
SE S $P(^(s),d,2)=$E(l,1,i) Q
EN S l=$P(^(s),d,2) F i=$L(l):-1:1 Q:$A(l,i)>32
        S c=i+lm K l Q
        ;
