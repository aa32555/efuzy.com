%ZAA02GED00
DSP(%R,s) S z=$P(^(s),d,2) Q:z=""  S L=$L(z,fs)-1,F=0 W @ZAA02GP,eHI_$G(ZAA02G("R1"),ZAA02G("RON")) F i=1:1:L S F=$F(z,fs,F),%C=F-$L(fs)+1 W @ZAA02GP,fs
	W ZAA02G("ROF")_eLO K L,F,i,z Q
PO S %R=r,fc=$S(s#1:ct+lm-1,1:lm) S:c<fc c=fc S %C=c W @ZAA02GP
RD S ch="" R ch#rm-c+2 X ZAA02G("T") I ch]"" S l=$P(^(s),d,2),l=$E(l_$J("",rm-$L(l)),1,c-lm)_ch_$E(l,c+$L(ch)-lm+1,511),c=c+$L(ch),cx=cx+1 G:$L(l)>(rm-lm+1) WR D SET
	S fk=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2) G:"RK,LK,CR,UK,DK,IC,DC,RU,IL,DL,TB,EF,PU,PD,FP,GE,SU,SD,GO,RE,CT,CP,ST,OT,GW,FM,HL,EX"[fk @fk W *7 G RD
WR I $E(l)=ci S x=$P(l," ",$L(l," ")) S:$E(x)=" " x=$E(x,2,511) S x=ci_x,$P(^(s),d,2)=$P(l," ",0,$L(l," ")-1),%C=$L(l)+lm-$L(x),cx=cx+1 W @ZAA02GP,tCL D INS^ZAA02GED04(r+1,s,0,x) S c=$L($P(^(s),d,2))+lm G PO
	S %R=r,%C=rm+1 W @ZAA02GP," " S ch=$E(l,$L(l)),$P(^(s),d,2)=$E(l_$J("",rm-$L(l)),1,$L(l)-1),cx=cx+1 D INS^ZAA02GED04(r+1,s,1,ch) S c=fc+1 G PO
LK S c=c-1 W ZAA02G("L") G:c'<fc PO D PL S c=rm G PO
RK S c=c+1 W ZAA02G("RT") G:c'>rm RD D NL S c=fc G PO
GW S c=fc G PO
TB S x=$O(tbx(c)) I 'x!(x+lm-1>rm) S c=lm G DK
	S c=x+lm-1 G PO
GE D EN G PO
RU S l=$P(^(s),d,2) I c>fc,$TR($E(l,c-lm+1,999)," ","")="" W $C(8,32) S l=$E(l,0,c-3)_$E(l,c-1,511),$P(^(s),d,2)=l,(c,%C)=c-1,%R=r W @ZAA02GP,eLO_$E(l,c-1,rm)_tCL K l G PO
	I c=lm,$TR(l," ","")="",$O(^(s))\1'=(s\1) D PL,EN S %R=r,%C=c W @ZAA02GP D JOIN^ZAA02GED04 G PO
	I c=fc,$TR(l," ","")="",$O(^(s))\1'=(s\1) G:s#1=0 RD D DEL^ZAA02GED01(r,s),PL S c=rm+1 G RU
	D RUB^ZAA02GED01 G PO
DC D DEL^ZAA02GED02 G PO
IC I $D(im) S (@ugl@(TID,"MODE"),im)=1,MODE=$E(MODE,1,$L(MODE)-$L(eLO)-3)_"ON "_eLO,l=$D(@gl@(s)) W MODE G PO^ZAA02GED22:ZAA02G("ION")="",BG^ZAA02GED11
	D INSRT^ZAA02GED03 G PO
DK D NL G PO
UK D PL G PO
CR D NL S c=fc G PO
PD D NP G PO
PU D PP G PO
EF D ERAS^ZAA02GED02 G PO
SU D SU^ZAA02GED09 G PO
SD D SD^ZAA02GED09 G PO
GO D SRCH^ZAA02GED08 G PO
RE D JOIN^ZAA02GED04 G PO
CT D CUT^ZAA02GED04 G PO
CP D ^ZAA02GED05 G PO
OT D ^ZAA02GEDOT G PO
ST D TABSET^ZAA02GED09 G PO
HL S bs=+^(ts),HN=1000 D ^ZAA02GEDH,NP G PO
FM D ^ZAA02GEDRX G PO
EX Q
NL S x=s,s=$O(^(s)) S:s="" s=x+10000\1,^(s)=x S fc=$S(s#1:lm+ct-1,1:lm),bc=$S(fc>lm:" ",1:""),r=r+1 Q:r'>bl  S bs=s,ts=$O(^(ts)),r=bl I sr S %R=bl,%C=lm W !,@ZAA02GP,eLO_$$CM(s) D:fs]"" DSP(r,s) Q
	S %R=tl,%C=lm W @ZAA02GP,@ZAA02G("DT") S %R=bl W @ZAA02GP,@ZAA02G("IL"),@ZAA02GP,$$CM(bs) D:fs]"" DSP(%R,s) Q
PL S x=+^(s) Q:'x  S s=x,fc=$S(s#1:lm+ct-1,1:lm),bc=$E($P(^(s),d,2)),r=r-1 Q:r'<tl  S r=tl,ts=s,bs=+^(bs) I sr S (%R,r)=tl,%C=lm W @ZAA02GP,@ZAA02G("IL"),@ZAA02GP,eLO,$$CM(s) D:fs]"" DSP(%R,s) Q
	S %R=bl,%C=lm W @ZAA02GP,@ZAA02G("DT") S %R=tl W @ZAA02GP,@ZAA02G("IL"),@ZAA02GP,$$CM(s) D:fs]"" DSP(%R,s) Q
NP W eLO S (x,ts)=$O(@gl@(bs)) S:'x (x,ts)=bs+10000\1,^(x)=bs F %R=tl:1:bl S bs=$O(@gl@(bs)) S:bs="" bs=x+10000\1,^(bs)=x_d S x=bs,%C=lm-1 W @ZAA02GP," ",$$CM(bs),tCL S:%R=r s=bs D:fs]"" DSP(%R,bs)
	Q
PP W eLO S x=+^(ts) Q:'x  F %R=bl:-1:tl Q:'^(x)  S x=+^(x)
	I %R'=tl S ts=$O(^(0)) F %R=tl:1:bl S x=$O(^(ts)) S:x="" x=ts\1+10000,^(x)=ts_d S ts=x
	S bs=+^(ts) F %R=bl:-1:tl S ts=+^(ts),%C=lm W @ZAA02GP,$$CM(ts),tCL S:%R=r s=ts D:fs]"" DSP(%R,ts)
	Q
IL I s#1 W *7 G RD
	D INS^ZAA02GED04(r,+^(s),0,"") S c=fc G PO
DL D DEL^ZAA02GED01(r,s),DSP(%R,bs):fs]"" G PO
FP S bs=0,r=tl D NP S c=lm G PO
SET S i=255 G SE:$E(l)=ci,SE:$O(^(s))\1=(s\1) F i=$L(l)-10:-10:0 Q:$E(l,i,511)'?." "
	F i=i+10:-1:0 Q:$E(l,i)'=" "
SE S $P(^(s),d,2)=$E(l,1,i) Q
EN S l=$P(^(s),d,2) F i=$L(l):-1:1 Q:$A(l,i)>32
	S c=i+lm Q
CZ(X) Q:'$D(ZAA02G("COF")) $P(^(X),d,2)
	I X'["." S X=$P(^(X),d,2) D  Q X
	.  S Cm="",cm=0 F cM=$L($E(X,1,10)," "):1:$L(X," ") I $P(X," ",cM)_Cm'="" S Cm=$P(X," ",cM) S cm=cm+1#2 I Cm'="" S:cm $P(X," ",cM)=ZAA02G("C4")_Cm_ZAA02G("COF")_ZAA02G("HI")
	Q $P(^(X),d,2)
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