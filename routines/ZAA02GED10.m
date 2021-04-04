%ZAA02GED10
	S VFY=1,CNT=0
REPL W pBL_tLO_"Replace string: "_tCL S %R=bl+2,%C=lm+15,Y="RON\ROF\EX\\"_(rm-lm-14)_"\\\\\\\1",X="" D ^ZAA02GEDRS G:X=""!(ZAA02GF="EX") BACK S REP=X
WITH W pBL_tLO_"With string: "_tCL S %R=bl+2,%C=lm+12,Y="RON\ROF\EX\\"_(rm-lm-11)_"\\\\\\\1",X="" D ^ZAA02GEDRS G:ZAA02GF="EX" BACK S WTH=X
VERIF W pBL_tLO_"Verify each replacement? "_tCL S %R=bl+2,%C=lm+24,Y="RON\ROF\EX\\3\NY\No;Yes",X=0 D ^ZAA02GEDYN G BACK:ZAA02GF="EX" S VFY=X W pBL_tCL
	I VFY S %C=1 F %R=tl:1:bl W @ZAA02GP,tCL
	S CNT=0 D SRCH S bs=+@gl@(ts) D NP^ZAA02GED00
BACK W eLO_pBL_tCL Q:VFY  W pBL_tLO_"Replacements: "_tHI_CNT_eLO K VFY,CNT Q
SRCH N C,E,I,J,K,L,P,S,W,X,CH,CM,CX,LC,LN,NB,NL,PAD,tRON,tROF D SAVE^ZAA02GED
	S W=rm-lm+1,CH=$E(REP),oL=$L(REP),nL=$L(WTH),PAD=$J("",ct-1),tRON=ZAA02G("RON"),tROF=ZAA02G("ROF")
	S (N,CX,LC,NB,OK)="" F I=0:0 D GET S:'CM LC=LC+1 D:VFY DSP D:T PUT I S=""!(OK<0) Q
	S:CX $P(@gl,"`",11)=1,cx=1
	Q
GET K L,SB S S=$O(@gl@(N+.9)),N=S\1,(SB,T)=0 Q:S=""  G G2
G1 S S=$O(@gl@(S)) Q:S=""!(S\1'=N)
G2 S SB=SB+1,SB(SB)=S I S#1=0 S L(S)=$P(^(S),d,2),T=L(S)[CH,CM=0 S:$E(L(S))=ci!($TR(L(S)," ","")="") CM=1 G G1
	S L(S)=$P(^(S),d,2) S:'T T=L(S)[CH G G1
PUT N N,S S (J,T)="",N=1,ZB=SB
P1 Q:N>SB  S F=0
P11 S S=SB(N),S2=$O(L(S)),l=$L(L(S)),X=$S(S2:L(S)_$E(L(S2),ct,ct+oL-1),1:L(S)) I X'[REP S N=N+1 G P1
P12 S F=$F(X,REP,F) I 'F S N=N+1 G P1
	S B=F-oL,E=F-1,%R=bl-ZB+N,%C=lm+B-1,EE=0 S:E>W E=W,EE=F-1 I VFY W @ZAA02GP,tHI_tRON_$E(X,B,E)_tROF
	I EE,VFY S %R=%R+1,%C=lm+ct-1 W @ZAA02GP,tRON_$E(X,E+1,EE)_tROF
	D ASK Q:OK<0  S %R=bl-ZB+N,%C=lm+B-1 I 'OK W:VFY @ZAA02GP,tLO_$E(X,B,E) S:EE %R=%R+1,%C=lm+ct-1 W:VFY&EE @ZAA02GP,$E(X,E+1,EE) G P12
	S:'CX CX=1 S CNT=CNT+1,L(S)=$E(X,0,B-1)_WTH_$E(X,B+oL,511) I S2 S L(S2)=PAD_$E(L(S2),ct+oL,511)
	I S#1=0 D TAG:$P(X," ")'=$P(L(S)," ")
	D FIXUP:nL'>oL,FIXDN:nL>oL S F=F+nL-oL G P11
FIXDN N n,E,S,X,%R,%C S n=N,S=SB(n),X=L(S),L(S)=$E(X,1,W),X=$E(X,W+1,511),$P(@gl@(S),d,2)=L(S)
	S %R=bl-ZB+N,%C=lm+B-1,E=B+nL-1,EE=0 S:E>W EE=E-W,E=W
	I VFY W @ZAA02GP,tLO_tRON_$E(L(S),B,E)_tROF_tLO W:E<W tLO_$E(L(S),E+1,W) W tCL
	Q:X=""  S n=n+1 D FD2 I VFY S:%R<bl %R=%R+1 S %C=lm+ct-1 W @ZAA02GP,tRON_$E(L(S),ct,ct+EE-1)_tROF,tLO_$E(L(S),$S(EE:ct+EE,1:ct),511)_tCL
FD1 Q:X=""  S n=n+1 D FD2 I VFY S %R=bl-ZB+n,%C=lm W @ZAA02GP,L(S)_tCL
	G FD1
FD2 I n>SB S (S,SB(SB+1))=SB(SB)+.1,(ZB,SB)=SB+1,NS=$O(@gl@(S)),$P(^(S),d)=SB(SB-1),$P(^(NS),d)=S,L(S)="" D INS
	S S=SB(n),X=PAD_X_$E(L(S),ct,511),L(S)=$E(X,1,W),X=$E(X,W+1,511),$P(@gl@(S),d,2)=L(S) Q
FIXUP N n,E,S,X,EE,S2,%R,%C S n=N,C=oL-nL,S=SB(n),X=L(S)
	I $L(X)>W S S2=SB(n+1),L(S2)=PAD_$E(X,W+1,511)_$E(L(S2),ct,511),L(S)=$E(X,1,W),n=n+1
	S $P(@gl@(S),d,2)=L(S),%R=bl-ZB+N,%C=lm+B-1,E=B+nL-1,EE=0 S:E>W E=W,EE=B+nL-E
	I VFY W @ZAA02GP,tLO_tRON_$E(X,B,E)_tROF_tLO W:E<W $E(X,E+1,W) W tCL
	Q:N=SB  I EE D FU1 S %R=%R+1,%C=lm+ct-1,n=n+1 W:VFY @ZAA02GP,tRON_$E(L(S2),ct,ct+EE-1)_tROF,tLO_$E(L(S2),ct+EE,511)_tCL
	F n=n:1:SB D FU1 I VFY S %R=bl-ZB+n,%C=lm W @ZAA02GP,L(S)_tCL
	S BP=0 F SB=SB:-1:1 S S=SB(SB) Q:L(S)]""  S BP=+@gl@(S) K ^(S)
	I BP S S=SB(SB),NS=$O(@gl@(S)),$P(^(NS),d)=BP
	Q
FU1 S S=SB(n),X=L(S),LN=$L(X) I $TR(X," ","")="" S L(S)="" Q
	S:n<SB S2=SB(n+1),X=X_$E(L(S2),ct,ct+W-LN-1),L(S2)=PAD_$E(L(S2),ct+W-LN,511) S $P(@gl@(S),d,2)=X,L(S)=X Q
TAG N i,T,X S T=$P(L(S)," "),X=$P(L(S)," ",2,511) F i=1:1:9-$L(T)+nL-oL Q:$E(X,i)'=" "
	S L(S)=T_$J("",8-$L(T))_" "_$E(X,i,511) Q
DSP N i,S,%R,%C F i=1:1:SB S S=SB(i) D INS W tLO_L(S)
	Q
INS S %C=lm I sr s %R=bl W @ZAA02GP,!,@ZAA02GP Q
	S %R=tl W @ZAA02GP,@ZAA02G("DT") S %R=bl W @ZAA02GP,@ZAA02G("IL"),@ZAA02GP Q
ASK I 'VFY S OK=1 Q
	N W,X,Y,%R,%C W pBL_tLO_"Replace? "_tCL S %R=bl+2,%C=lm+8,Y="RON\ROF\EX\\3\NY\No;Yes",X=0 D ^ZAA02GEDYN S OK=$S(ZAA02GF="EX":-1,1:X) Q
DB(%R,%C,xX) S:'$D(XX) xX=%C W @ZAA02GP,xX,tCL R xX Q
	;
	;