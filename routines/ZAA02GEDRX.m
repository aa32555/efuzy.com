%ZAA02GEDRX ;;2014-07-10 17:23:46;1.24;SUBR: SYNTAX CHECK;29APR91  14:03
 ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc.
 ;;All rights reserved.
SYNTX Q  N i,L,M,N,R,S,W,X,BP,CC,EN,EP,ER,RR W pBL_tLO_"CHECKING LINE"_tCL S %R=bl+2,%C=rm-13 W @ZAA02GP,"...please wait"
 S R=r,S=s,N=S\1,W=rm-lm+1 I S#1 F i=0:0 S M=+^(S) Q:M\1'=N  S S=M,R=R-1
 S M=$$maxstr(ZAA02G("OS")),LL=$$fetch D CHECK^ZAA02GEDR1(LL) G:'ER EXIT F N=1:1:ER D SHOW(N)
EXIT W VERS,tCL,MODE S M=$D(@gl@(s)) K LL Q
SHOW(N) S X=ER(N),EN=+X,BP=$P(X,"|",2),EP=$P(X,"|",3),RR=R,CC=BP+lm-1
D1 I CC>rm S RR=RR+1,CC=CC-W+ct+lm-3,W=rm-ct Q:RR>bl  G D1
 W eHI_ZAA02G("RON") D DSP(RR,CC) W ZAA02G("ROF")_eLO,*7
 W pBL_tHI_EN_":  "_^ZAA02GEDSYN(0,EN)_tCL S %R=bl+2,%C=rm-17 W @ZAA02GP,tLO_"  ...press any key" R *X D DSP(RR,CC) Q
DSP(%R,%C) W @ZAA02GP F i=BP:1:BP+EP-1 W $E(LL,i) S %C=%C+1 I %C>rm S %R=%R+1,%C=ct-lm+1 Q:%R>bl  W @ZAA02GP
 Q
fetch() N i,L S L=$P(@gl@(S),d,2) F i=0:0 S S=$O(^(S)) Q:S=""!(S\1'=N)  S L=L_$E($P(^(S),d,2),ct,M-$L(L))
 Q L
maxstr(OS) Q:OS="DTM" 65530 Q:OS="M11" 511 Q 255
