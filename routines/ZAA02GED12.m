ZAA02GED12 ;;%AA UTILS;Wed, 07 Mar 2012  22:21;EDIT: FIND STRING FUNCTIONS;Wed, 07 Mar 2012  22:24
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
STRG S %R=bl+2,%C=lm-1 W @ZAA02GP,tLO_"Find string: "_tCL S %C=rm-15 W @ZAA02GP,"string [/L] [/C]"
        S %C=14,Y="RON\ROF\EX\\40\\\\\\\1",X="" W tHI D ^ZAA02GEDRS S x=$D(@gl@(s)) I X=""!(ZAA02GF="EX") S fs="" K X,Y,ZAA02GF W pBL_tCL_VERS_MODE Q
        S TYPE=$E(X,$L(X)-1,$L(X))
        I TYPE="/C"!(TYPE="/c") S TYPE=1,REP=$E(X,1,$L(X)-2) G BACK:REP="",FIND
        I TYPE="/L"!(TYPE="/l") S TYPE=2,REP=$E(X,1,$L(X)-2) G BACK:REP="",FIND
        K TYPE S fs=X,bs=+@gl@(ts) W eLO D NP^ZAA02GED00 G BACK
FIND S %C=1,CNT=0 F %R=tl:1:bl W @ZAA02GP,tCL
        D SRCH S %R=bl+2,%C=lm-1 W @ZAA02GP,tLO_"Occurrences: "_tHI_CNT_tCL
        I CNT S %C=rm-48 W @ZAA02GP,tLO_"press any key to continue - J to Jump to each" R X#1 I "Jj"[X,$L(X),$O(sts("")) D
        . S lst=ts,ts="",fs=REP F  S ts=$O(sts(ts)) Q:ts=""  S bs=+@gl@(ts) D NP^ZAA02GED00 R X#1 Q:X=""  Q:"Jj"'[X
        S:ts="" ts=lst K sts,lst S bs=+@gl@(ts) D NP^ZAA02GED00
BACK K X,Y,CNT,TYPE W VERS_tCL_MODE Q
SRCH N C,E,I,J,K,L,P,S,W,X,CH,CM,CX,LC,LN,NB,NL,tRON,tROF D SAVE^ZAA02GED
        S W=rm-lm+1,CH=$E(REP),oL=$L(REP),tRON=ZAA02G("RON"),tROF=ZAA02G("ROF")
        S (N,NB,CX,LC)="" F I=0:0 D GET S:'CM LC=LC+1 D:TYPE=1!(TYPE=2&(T=1)) DSP D:T PUT I S="" Q
        Q
GET K L,SB S S=$O(@gl@(N+.9)),N=S\1,(CM,SB,T)=0,Z="" Q:S=""  G G2:TYPE=1,G22
G1 S S=$O(@gl@(S)) I S=""!(S\1'=N) K Z Q
G2 S SB=SB+1,SB(SB)=S,L(S)=$P(^(S),d,2) S:'T T=L(S)[CH I S#1=0,$E(L(S))=ci!($TR(L(S)," ","")="") S CM=1
        G G1
G21 S S=$O(@gl@(S)) I S=""!(S\1'=N) K Z Q
G22 S SB=SB+1,SB(SB)=S,L(S)=$P(^(S),d,2) I S#1=0,$E(L(S))=ci!($TR(L(S)," ","")="") S CM=1
        I 'T S:Z]"" Z=$E(Z,$L(Z)-$L(REP)+2,$L(Z)) S Z=Z_$E(L(S),$S(S#1:ct,1:1),$L(L(S))),T=Z[REP
        G G21
PUT N N,S S (J,T)="",N=1,ZB=SB
P1 Q:N>SB  S F=0,S=SB(N),S2=$O(L(S)),l=$L(L(S)),X=$S(S2:L(S)_$E(L(S2),ct,ct+oL-2),1:L(S)) I X'[REP S N=N+1 G P1
P2 S F=$F(X,REP,F) I 'F S N=N+1 G P1
        S B=F-oL,E=F-1,%R=bl-ZB+N,%C=lm+B-1,EE=0 S:E>W E=W,EE=F-1 W @ZAA02GP,tHI_tRON_$E(X,B,E)_tROF
        I EE S %R=%R+1,%C=lm+ct-1 W @ZAA02GP,tRON_$E(X,E+1,EE)_tROF
        S CNT=CNT+1 G P2
DSP N i,S,%R,%C S i=1,S=SB(i) I TYPE=2 D INS I $E(L(S))=" " D INS W @ZAA02GP,tHI_"+"_LC_tLO_$E(L(S),$L(LC)+2,511) S i=2
        F i=i:1:SB S S=SB(i) D INS W tLO_L(S)
        S sts(+$O(L("")))=""
        Q
INS S %C=lm I sr s %R=bl W @ZAA02GP,!,@ZAA02GP Q
        S %R=tl W @ZAA02GP,@ZAA02G("DT") S %R=bl W @ZAA02GP,@ZAA02G("IL"),@ZAA02GP Q
ASK I 'VERIFY S OK=1 Q
        N W,X,Y,%R,%C W pBL_tLO_"Replace? "_tCL S %R=bl+2,%C=lm+8,Y="RON\ROF\EX\\3\NY\No;Yes",X=0 D ^ZAA02GEDYN S OK=$S(ZAA02GF="EX":0,1:X) Q
        ;
