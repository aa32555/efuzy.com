%ZAA02GED11 ;;%AA UTILS;1.24;EDIT: CONTROL (INSERT MODE);31MAY91  09:56
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
DSP(%R,s) S z=$P(^(s),d,2) Q:z=""  S L=$L(z,fs)-1,F=0 W @ZAA02GP,eHI,$G(ZAA02G("R1"),ZAA02G("RON")) F i=1:1:L S F=$F(z,fs,F),%C=F-$L(fs)+1 W @ZAA02GP,fs
        W ZAA02G("ROF")_eLO K L,F,i,z Q
BG W @ZAA02G("ION")
PO S %R=r,fc=$S(s#1:ct+lm-1,1:lm) S:c<fc c=fc S %C=c W @ZAA02GP
RD S (ch,fk)="",cl=rm-c+2 R ch#cl I $L(ch)'=cl X ZAA02G("T") S fk=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2)
EV I ch]"" S l=$P(^(s),d,2),l=$E(l_$J("",rm-$L(l)),1,c-lm)_ch_$E(l,c-lm+1,511),c=c+$L(ch),cx=cx+1 G:$E(l,rm)]""!(tb+2>c) WR D SET
FK G:"RK,LK,CR,UK,DK,IC,DC,RU,IL,DL,TB,EF,PU,PD,FP,GE,SU,SD,GO,RE,CT,CP,ST,OT,GW,HL,FM,EX"[fk @fk W:fk]" " *7 G RD
WR I $E(l,c-lm+1)]"" D WI G FK:fk]"",PO
        I $E(l,rm)="" S $P(^(s),d,2)=l G FK
        I $E(l)=ci G:(tb+1)>c FK S x=$P(l," ",$L(l," ")) S:$E(x)=" " x=$E(x,2,511) S x=ci_x,$P(^(s),d,2)=$P(l," ",0,$L(l," ")-1),%C=$L(l)+lm-$L(x),cx=cx+1 W @ZAA02GP,tCL D INS^ZAA02GED04(r+1,s,0,x) S c=$L($P(^(s),d,2))+lm G PO
        S %R=r,%C=rm+1 W @ZAA02GP," " S ch=$E(l,$L(l)),$P(^(s),d,2)=$E(l_$J("",rm-$L(l)),1,$L(l)-1),cx=cx+1 D INS^ZAA02GED04(r+1,s,1,ch) S c=fc+1 G PO
WI S S=s,R=r,C=c,W=rm-lm+1,%C=rm+1 W @ZAA02G("IOF"),@ZAA02GP,tCL I s#1!($E(l)=ci)!(tb+1<c&(c>($F(l," ")-1))) D WU G W1
        S t=$P(l," "),l=$P(l," ",2,511) F i=1:1:$L(l) Q:$A(l,i)>32
        S l=t_$J("",tb-$L(t)-2)_" "_$E(l,i,511),%C=lm W @ZAA02GP,$E(l,1,W)_tCL D WU K i,t
W1 G:l="" W2 S x=$O(^(s)) I x\1'=(s\1) D INS^ZAA02GED04(%R+1,s,1,l) G W2
        S s=x,l=$J("",ct-1)_l_$E($P(^(s),d,2),ct,511),%R=%R+1,%C=lm W:%R'>bl @ZAA02GP,$E(l,1,W) D WU G:l]"" W1
W2 S r=R,c=C,s=S I c>(rm+1) D NL S r=R+1,c=fc+1 s:r>bl r=bl
        W @ZAA02GP,@ZAA02G("ION") S fc=$S(s#1:lm+ct-1,1:lm) K x,C,R,S,W Q
WU S $P(^(s),d,2)=$E(l,1,W),l=$E(l,W+1,511) Q
LK S c=c-1 W ZAA02G("L") G:c'<fc PO W @ZAA02G("IOF") D PL S c=rm G BG
RK S c=c+1 W ZAA02G("RT") G:c'>rm PO W @ZAA02G("IOF") D NL S c=fc G BG
GW S c=fc G PO
TB S x=$O(tbx(c-1)) I 'x!(x+lm-1>rm) S c=lm G DK
        S c=x+lm-1 G PO
RU S l=$P(^(s),d,2),fc=$S(s#1:ct+lm-1,1:lm) D RUB^ZAA02GED13 S %R=r,%C=c W @ZAA02GP G EV
CR W @ZAA02G("IOF") D CUT^ZAA02GED04 S c=lm,s=$O(^(s)) S:r<bl r=r+1 G BG
DK W @ZAA02G("IOF") D NL G BG
UK W @ZAA02G("IOF") D PL G BG
PD D NP G PO
PU D PP G PO
GE D EN G PO
DC W @ZAA02G("IOF") D DEL^ZAA02GED02 G BG
IC W @ZAA02G("IOF") S (@ugl@(TID,"MODE"),im)=0,MODE=$E(MODE,1,$L(MODE)-$L(eLO)-3)_"OFF"_eLO,l=$D(@gl@(s)) W MODE G PO^ZAA02GED00
EF W @ZAA02G("IOF") D ERAS^ZAA02GED02 G BG
SU W @ZAA02G("IOF") D SU^ZAA02GED09 G BG
SD W @ZAA02G("IOF") D SD^ZAA02GED09 G BG
GO W @ZAA02G("IOF") D SRCH^ZAA02GED08 G BG
RE W @ZAA02G("IOF") D JOIN^ZAA02GED04 G BG
CT W @ZAA02G("IOF") D CUT^ZAA02GED04 G BG
CP W @ZAA02G("IOF") D ^ZAA02GED05 G BG
ST W @ZAA02G("IOF") D TABSET^ZAA02GED09 G BG
HL W @ZAA02G("IOF") S bs=+^(ts),HN=1000 D ^ZAA02GEDH,NP G BG
EX W @ZAA02G("IOF") Q
OT W @ZAA02G("IOF") D ^ZAA02GEDOT G BG
FM W @ZAA02G("IOF") D ^ZAA02GEDRX G PO
NL S x=s,s=$O(^(s)) S:s="" s=x+10000\1,^(s)=x S fc=$S(s#1:lm+ct-1,1:lm),bc=$S(fc>lm:" ",1:""),r=r+1 Q:r'>bl  S bs=s,ts=$O(^(ts)),r=bl I sr S %R=bl,%C=lm W !,@ZAA02GP,eLO,$$CM(s) D:fs]"" DSP(r,s) Q
        S %R=tl,%C=lm W @ZAA02GP,@ZAA02G("DT") S %R=bl W @ZAA02GP,@ZAA02G("IL"),@ZAA02GP,$$CM(bs) D:fs]"" DSP(%R,s) Q
PL S x=+^(s) Q:'x  S s=x,fc=$S(s#1:lm+ct-1,1:lm),bc=$E($P(^(s),d,2)),r=r-1 Q:r'<tl  S r=tl,ts=s,bs=+^(bs)
        I sr S (%R,r)=tl,%C=lm W @ZAA02GP,@ZAA02G("IL"),@ZAA02GP,eLO,$$CM(s)
        E  S %R=bl,%C=lm W @ZAA02GP,@ZAA02G("DT") S %R=tl W @ZAA02GP,@ZAA02G("IL"),@ZAA02GP,$$CM(s)
        D:fs]"" DSP(%R,s) Q
NP W @ZAA02G("IOF"),eLO S (x,ts)=$O(@gl@(bs)) S:'x (x,ts)=bs+10000\1,^(x)=bs F %R=tl:1:bl S bs=$O(@gl@(bs)) S:bs="" bs=x+10000\1,^(bs)=x_d S x=bs,%C=lm-1 W @ZAA02GP," ",$$CM(bs),tCL S:%R=r s=bs D:fs]"" DSP(%R,bs)
        W @ZAA02G("ION") Q
PP S x=+^(ts) Q:'x  F %R=bl:-1:tl Q:'^(x)  S x=+^(x)
        I %R'=tl S ts=$O(^(0)) F %R=tl:1:bl S x=$O(^(ts)) S:x="" x=ts\1+10000,^(x)=ts_d S ts=x
        W @ZAA02G("IOF"),eLO S bs=+^(ts) F %R=bl:-1:tl S ts=+^(ts),%C=lm W @ZAA02GP,$$CM(ts),tCL S:%R=r s=ts D:fs]"" DSP(%R,ts)
        W @ZAA02G("ION") Q
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
CM(X) Q:'$D(ZAA02G("COF")) $P(^(X),d,2)
        I X'["." S cM=$P(^(X),d,2)
        E  S cM="" F cl=X:-.1:X\1 S Cm=$P(^(cl),d,2) X "F mm=1:1:$L(Cm) Q:$E(Cm,mm)'="" """ S $E(Cm,1,mm-1)=$TR($J("",mm-1)," ",$C(1)),cM=$S(cl=X:$C(3),1:"")_Cm_cM
        S X=$$CMX(cM) F cM=$L($P(X," "))+1:1:$L($P(X,";")) Q:$E(X,cM)?1A.E
        S cl=$S(cM>1:ZAA02G("C1")_$E(X,1,cM-1)_ZAA02G("COF"),1:" "),X=$E(X,cM,999) F cM=1:1:$L(X," ") I $P(X," ",cM)'="" D
        . S Cm=$P(X," ",cM),$P(X," ",cM)=ZAA02G("C4")_$P(Cm,":")_ZAA02G("COF")_ZAA02G("HI")_$S(Cm[":":":"_$P(Cm,":",2,99),1:"") I $P(X," ",cM+1)'="" S cM=cM+1 S:"DdGg"[$E(Cm) $P(X," ",cM)=ZAA02G("C1")_$P(X," ",cM)_ZAA02G("COF")_ZAA02G("HI")
        S X=$TR(cl_X_cm,$C(1)," ") S:X[$C(3) X=$P(X,$C(3),2,9) Q X
CMX(X) F Cm=2:2:$L(X,"""") I $P(X,"""",Cm)[" " S $P(X,"""",Cm)=$TR($P(X,"""",Cm)," ",$C(1))
        S cm="" F Cm=2:1:$L(X,";") I $L($P(X,";",1,Cm-1),"""")#2=1 S cm=";"_$P(X,";",Cm,999),X=$P(X,";",1,Cm-1) Q
        Q X
        ;
