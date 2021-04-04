%ZAA02GED09
RUN S %R=bl+2,%C=lm-1,Y="RON\ROF\EX\\"_(rm-lm-3)_"\\\\\\Run: ",X=$S($D(@ugl@(TID,"RUN"))#2:^("RUN"),1:"D ^"_rt) D ^ZAA02GEDRS S:X="" ZAA02GF="EX" I ZAA02GF="EX" G POP^ZAA02GED
	S @ugl@(TID,"RUN")=X W ZAA02G("F"),tLO_"Running "_tHI_rt_tLO_"...",! S ZAA02G(1)=1 X ZAA02G("EON"),ZAA02G("TOF"),ZAA02G("WON")
	K (X,TID) S V=@ZAA02G("G")@("ERROR"),@(V_"=""RUNERR^ZAA02GED09""") X X
BACK S V=@ZAA02G("G")@("ERROR"),@(V_"=""""") D ANYKEY G ^ZAA02GED
RUNERR S V=@ZAA02G("G")@("ERRORR") W !!,@V G BACK
ANYKEY W !!,"Press any key to continue..." R *C Q
TABSET N t,C1,C2 s t=c-lm+1 Q:t<11  I $D(tbx(t)),t=$O(tbx("")) Q
	I $D(tbx(t)) K tbx(t) S (C1,C2)=ZAA02G("HL") D MARKS
	E  S tbx(t)="",C1=ZAA02G("TI"),C2=ZAA02G("BI") D MARKS
	Q
MARKS S %C=c F %R=tl-1,bl+1 W @ZAA02GP,ZAA02G("G1")_$S(%R<tl:C1,1:C2)_ZAA02G("G0")
	Q
SD N xs,o,O,s1,s2,S,N,x S xs=s,N=s\1
	F I=0:0 Q:s=N  D PL
	S s1=s Q:$O(^(s))=""  F I=0:0 D NL Q:s\1'=N
	S s2=s F I=0:0 S x=$O(^(s)) Q:x=""!(x\1'=s2)  D NL
	D SWP1
	Q
SU N xs,o,O,s1,s2,S,N,x S xs=s,N=s\1
	F I=0:0 Q:s=N  D PL
	Q:'^(s)  S s1=s F s=s:0 D PL S n=s\1 Q:n'=N&(n=s)
	S s2=s D SWP2
	Q
NL S s=$O(^(s)) Q:s'>bs&(s]"")  S:s="" s=bs\1+10000,^(s)=bs_d S ts=$O(^(ts)),bs=s,r=r-1
	I sr S %R=bl,%C=lm W @ZAA02GP,! Q
	S %R=tl,%C=lm W @ZAA02GP,@ZAA02G("DT") S %R=bl W @ZAA02GP,@ZAA02G("IL"),@ZAA02GP
	Q
PL S x=+^(s) Q:'x  S s=x,r=r-1 Q:r'<tl  S r=tl,ts=s,bs=+^(bs) I sr S (%R,r)=tl,%C=lm W @ZAA02GP,@ZAA02G("IL"),@ZAA02GP,eLO_$P(^(s),d,2) Q
	S %R=bl,%C=lm W @ZAA02GP,@ZAA02G("DT") S %R=tl W @ZAA02GP,@ZAA02G("IL"),@ZAA02GP,$P(^(s),d,2) Q
	Q
SWP S x=s1 F I=0:0 S s1(x)=$P(^(x),d,2) K ^(x) S x=$O(^(x)) Q:x\1'=s1
	S x=s2 F I=0:0 S s2(x)=$P(^(x),d,2) K ^(x) S x=$O(^(x)) Q:x\1'=s2
	Q
SWP1 S (O,o)=+^(s1) D SWP
	S s=s1,^(s)=o_d_s2(s2) F x=s2:0 S x=$O(s2(x)) Q:x=""  S o=s,s=s+.1,^(s)=o_d_s2(x)
	S o=s,s=s2,^(s)=o_d_s1(s1) S:s1=xs xs=s S:bs=s1 bs=s
	F x=s1:0 S x=$O(s1(x)) Q:x=""  S o=s,s=s+.1,^(s)=o_d_s1(x) S:x=xs xs=s
	S:s>bs bs=s G SWP3
SWP2 S (O,o)=+^(s2) D SWP
	S s=s2,^(s)=o_d_s1(s1) S:s1=xs xs=s F x=s1:0 S x=$O(s1(x)) Q:x=""  S o=s,s=s+.1,^(s)=o_d_s1(x) S:x=xs xs=s
	S o=s,s=s1,^(s)=o_d_s2(s2) F x=s2:0 S x=$O(s2(x)) Q:x=""  S o=s,s=s+.1,^(s)=o_d_s2(x)
SWP3 S o=s,s=$O(^(s)) S:s="" s=o\1+10000 S $P(^(s),d)=o,%C=lm,s=O,cx=cx+1
	F %R=r:0 S x=s,s=$O(^(s)) S:s="" s=s\1+10000,^(s)=x_d Q:s>o  W @ZAA02GP,$P(^(s),d,2)_tCL S %R=%R+1
	S:%R>bl bs=x F s=$O(^(O)):0 Q:s'<xs  S s=$O(^(s)),r=r+1
	Q
MG80 N l,n,s,L,N,S,W,pad W pBL_"Please wait..."_tCL
	S rm=79,$P(@gl,"`",3)=rm,W=rm-lm+1 G:$O(@gl@(0))="" DSP
	S s=$O(@gl@(0)),l=$P(^(s),d,2),S=s\1,(n,N,L)=0,pad=$J("",ct-lm+1)
L80 I 'n,$E(l)'=ci S tg=$P(l," ") I tg]"" S l=$P(l," ",2,511),l=$E(l,$F(l,$E($TR(l," ","")))-1,511),l=tg_$J("",tb-$L(tg)-2)_" "_l
L81 S ^(S+N)=L_d_$E(l,1,W),l=pad_$E(l,W+1,511),L=S+N,N=N+.1,s=$O(^(s)),n=s#1 I s\1=S S l=l_$E($P(^(s),d,2),ct-lm+2,511) G L81
L82 I l'=pad S ^(S+N)=L_d_$E(l,1,W),l=pad_$E(l,W+1,511),L=S+N,N=N+.1 G L82
	G:s="" DSP S l=$P(^(s),d,2),n=s#1,S=s\1,N=0 G L80
MG132 N i,l,n,s,x,L,N,S,W,pad W pBL,"Please wait..."_tCL
	S rm=131,$P(@gl,"`",3)=rm,W=rm-lm+1 G:$O(@gl@(0))="" DSP
	S s=$O(^(0)),l=$P(^(s),d,2),S=s\1,(n,N,L)=0,pad=$J("",ct-lm+1)
L132 I 'n,$E(l)'=ci S tg=$P(l," ") I tg]"" S l=$P(l," ",2,511),l=$E(l,$F(l,$E($TR(l," ","")))-1,511),l=tg_$J("",tb-$L(tg)-2)_" "_l
L1321 I $L(l)'<W S ^(S+N)=L_d_$E(l,1,W),l=pad_$E(l,W+1,511),L=S+N,N=N+.1
	S s=$O(^(s)) I s\1=S S l=l_$E($P(^(s),d,2),ct-lm+2,511) G L1321
	S ^(S+N)=L_d_$E(l,1,W),(L,x)=S+N F i=0:0 S x=$O(^(x)) Q:x=""!(x\1'=S)  K ^(x)
	G:s="" DSP S l=$P(^(s),d,2),n=s#1,S=s\1,N=0 G L132
DSP X $S(W<80:ZAA02G(80),1:ZAA02G(132)) D SETUP^ZAA02GED,NP^ZAA02GED00 Q
	;
	;