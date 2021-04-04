%ZAA02GED05
	N mk,xr,xc,xs,tgl,cgl,xts,xbs,type,SF,r1,r2,c1,c2,s1,s2 S xbs=bs,xts=ts,xr=r,xc=c,xs=s,(r1,r2)=r,s1=s,c1=c,SF=0 X ZAA02G("EOF")
	S Y=(lm-1)_","_(bl+2)_"\H\CP,EX\Select: \\COPY,MOVE,SAVE,RECALL,DISCARD" W pBL_tCL D READ^ZAA02GEDPL G EXIT:"EX"=ZAA02GF I ZAA02GF="CP" S X=rt,type="C" D RTN1 G CPY1
	S X=$P("CPY,MOV,SAV,REC,DIS",",",X),type=$E(X) G @X
CPY D RTN G EXIT:R=""
CPY1 D MARK,COPY:mk,ADD^ZAA02GED06:mk K:$D(cgl) @cgl G EXIT
MOV S s1=s,c1=c,tgl=gl,R=rt,SF=0 D MARK,COPY:mk,DELETE^ZAA02GED06:mk,ADD^ZAA02GED06:mk K:$D(cgl) @cgl G EXIT
SAV S s1=s,c1=c,tgl=gl,R=rt,NAM="" D MARK I 'mk K NAM G EXIT
SAV1 W pBL_tCL_tHI S %R=bl+2,%C=lm,Y="RON\ROF\EX\\15\\\\\1\Save to: ",X=NAM D READ^ZAA02GEDRS G EXIT:X=""!(ZAA02GF="EX")
	S NAM=X I $D(@lgl@(NAM)) D OKAY I 'OK K OK G SAV1
	S cgl=lgl_"(NAM)" D COPY K OK,NAM G EXIT
OKAY W *7,pBL_tHI_NAM_tLO_" already exists.  Do you want to overwrite it? "_tHI S %R=bl+2,%C=lm+47+$L(X),Y="RON\ROF\EX\\3\NY\No;Yes",X=0 D READ^ZAA02GEDYN S OK=$S(ZAA02GF="EX":0,1:X) K X,Y W pBL_tCL Q
REC W pBL_tCL_tHI S %R=bl+2,%C=lm,Y="RON\ROF\HL,EX\\15\\\\\1\Recall from: ",X="" D READ^ZAA02GEDRS I ZAA02GF="HL" S X="" D ^ZAA02GEDLIB X ZAA02G("EOF") G:X="" REC
	G EXIT:X=""!(ZAA02GF="EX") I '$D(@lgl@(X)) D ^ZAA02GEDLIB X ZAA02G("EOF") G:X="" REC
	S NAM=X,cgl=lgl_"(NAM)" D ADD1^ZAA02GED06 G EXIT
DIS W pBL_tCL_tHI S %R=bl+2,%C=lm,Y="RON\ROF\HL,EX\\15\\\\\1\Discard: ",X="" D READ^ZAA02GEDRS I ZAA02GF="HL" D ^ZAA02GEDLIB G:X="" DIS
	G EXIT:X=""!(ZAA02GF="EX") I '$D(@lgl@(X)) D ^ZAA02GEDLIB G:X="" DIS
	K @lgl@(X) G EXIT
RTN S %R=bl+2,%C=lm,Y="RON\ROF\EX\\15\\\\\\Routine: \\\\\1",X=rt,SF=$S($D(SF):SF,1:0) D READ^ZAA02GEDRS I X=""!(ZAA02GF="EX") S R="" D:SF RESTOR Q
RTN1 S R=X,c=xc,r=xr,m=0,SF=$S($D(SF):SF,1:0) I rt=R S tgl=gl,s1=s,c1=c Q
	S (tgl,GT)="^ZAA02GEDTMP($J,1)",@GT=@gl X ZAA02G("EON") D RTNL X ZAA02G("EOF") G:R="" RTN S s1=0 D:SF RESTOR Q
RTNL N cx,rt,T,V,X,Y,T,OS,GFR,MSG,SRC,NOLOCK S SF=0,NOLOCK=1,OS=ZAA02G("OS"),RTX="" D RTN1^ZAA02GEDL1 I R]"" D @$S(GFR="OS":"OS^ZAA02GEDL1",1:"GL^ZAA02GEDL1")
	W pBL_tCL S SF=1 Q
RESTOR D TL1 S %R=tl,%C=lm W @ZAA02GP,$P(@gl@(ts),d,2)_tCL D BL W ROU,VERS,MODE Q
MARK S mk=0 G MARK1:s1 S tl=tl+3 D TL S %R=bl+2,%C=lm-1,bs=0 W @ZAA02GP,eLO_"Move to beginning of block and press "_eHI_"COPY/MOVE"_tCL_eLO
	S s=$O(@tgl@(0)),bs=0,r=tl,c=lm,m=0 D NP^ZAA02GED07,POS^ZAA02GED07
	S s1=s,c1=c,r1=r G MARKE:fk="EX"
MARK1 S x=$D(@tgl@(s)),%R=bl+2,%C=lm-1 W @ZAA02GP,eLO_"Move to end of block and press "_eHI_"COPY/MOVE"_tCL D MARK^ZAA02GED07
	S s2=s,c2=c,r2=r G MARKE:fk="EX" S mk=1
MARKE I R'=rt S tl=tl-3,R=rt W ROU,VERS D TL1
	Q
TL S %R=tl-2,%C=lm-1 W @ZAA02GP,tLO_"From Routine: "_tHI_R_tLO_tCL
TL1 I sr S %R=tl,%C=bl W @ZAA02G("SR")
	S %R=tl-1,%C=lm-1,Z="",$P(Z,ZAA02G("HL"),rm-lm+2)="" W @ZAA02GP,tLO,ZAA02G("G1")_ZAA02G("TLC"),Z,ZAA02G("TRC") S t="" F i=0:0 S t=$O(tbx(t)) Q:t=""!(t>rm)  S %C=lm+t-1 W @ZAA02GP,ZAA02G("TI")
	W ZAA02G("G0") K Z Q
BL S %R=bl+1,%C=lm-1,Z="",$P(Z,ZAA02G("HL"),rm-lm+2)="" W @ZAA02GP,ZAA02G("G1")_ZAA02G("BLC"),Z,ZAA02G("BRC")
	S t="" F i=0:0 S t=$O(tbx(t)) Q:t=""!(t>rm)  S %C=lm+t-1 W @ZAA02GP,ZAA02G("BI")
	W ZAA02G("G0") Q
COPY N T,L,N,fl W pBL_"Copying..."_tCL S:'$D(cgl) cgl="^ZAA02GEDTMP($J,2)" K @cgl
	I s1=s2 S fl=c1<tb,L=$E($P(@tgl@(s1),d,2),c1-lm+1,c2-lm),S2=1,S=1 D COPY2 G COPY1
	S S2=1,fl=c1<tb,N=s1\1,L=$E($P(@tgl@(s1),d,2),c1-lm+1,511)
	F S=s1:0 S S=$O(@tgl@(S)) Q:S=""!(S'<s2)  D:S\1'=N COPY2 S L=L_$E($P(@tgl@(S),d,2),$S(S#1:ct,1:1),511)
	I S=s2 D:S\1'=N COPY2 S L=L_$E($P(@tgl@(S),d,2),$S(S#1:ct,1:1),c2-lm) D COPY2
COPY1 S @cgl=(S2-1)_"`"_c1_"`"_c2 Q
COPY2 N T I fl,L]"" S T=$P(L," "),L=$P(L," ",2,511),L=$E(L,$F(L,$E($TR(L," ","")))-1,511),L=T_" "_L
	S @cgl@(S2)=L,S2=S2+1,L="",fl=1,N=S\1 Q
EXIT X ZAA02G("EON") W eLO I $S(SF:1,ts'=xts:1,1:0) S bs=$S($D(@gl@(s)):+^(xts),1:0) D NP^ZAA02GED00 G EXIT1
	S (S,s)=s1,%C=lm,r2=$S(xbs=bs:r2,1:bl),x=$D(@gl@(S)) S:'x S=$O(^(S)) S:'S S=s\1+10000,^(S)=s_d W eLO
	F %R=r1:1 W @ZAA02GP,$P(^(S),d,2)_tCL Q:%R'<r2  S x=$O(^(S)) S:x="" x=S\1+10000,^(x)=S_d S S=x
EXIT1 D CHCK^ZAA02GED W VERS_tCL_MODE S c=xc,r=xr,s=xs Q
	;
	;