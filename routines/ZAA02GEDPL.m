%ZAA02GEDPL ;;%AA UTILS;1.24;SUBR: MENUS;24APR91  14:56
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
INIT X ZAA02G("EOF") D READ X ZAA02G("EON") Q
READ N i,c,f,A,B,C,I,L,O,T,Z,CC,R,PA,PR,ST,ZF,IMB,RON,ROF S ST=$S($D(ZAA02G("M")):ZAA02G("M"),1:1)
        S (CC,%C)=+Y,R=+$P(Y,",",2),PA=$P(Y,"\",2),f="CR,"_$P(Y,"\",3),PR=$P(Y,"\",4),I=$P(Y,"\",5),Y=$P(Y,"\",6),C=$L(Y,",")
        S %C=%C+$L(PR)+1,Z="",T="C(i)="_ZAA02GP S:R %R=R S:'$D(%R) %R=24 F i=1:1:C S B=$P(Y,",",i),A=$E($TR(B," ","")) S:'$D(O(A)) O(A)=0 S O(A)=O(A)+1,O(A,i)="",Z=Z_"  "_B,@T,%C=%C+$L(B)+2
        S RON=ZAA02G("RON")_" ",ROF=ZAA02G("ROF"),IMB=0 s:'I!(I>C) I=1 S:$D(ZAA02G("a")) RON=$P(ZAA02G("a"),"`",1),ROF=$P(ZAA02G("a"),"`",2)_$C(8),IMB=1
        S L=$L(Z)+$L(PR),%C=CC W @ZAA02GP W:PR]"" PR W:PA["H" ZAA02G("HI") W Z_" "
M1 W C(I)_RON_$P(Y,",",I)_ROF
M2 R c#1 I c]"" S:c?1L c=$C($A(c)-32) G M6:c'=" " D M4 S I=I+1 S:I>C I=1 G M1
M3 X ZAA02G("T") S ZAA02GF=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2) G:f[ZAA02GF M5 D M4 S I=$S(ZAA02GF="RK":I+1,ZAA02GF="LK":I-1,1:I) S:I>C I=1 S:I<1 I=C G M1
M4 W C(I)_" "_$P(Y,",",I)_" " Q
M5 S X=I,%C=CC Q:PA["D"  W @ZAA02GP,$J("",L) Q
M6 G:'$D(O(c)) M2 D M4 I O(c)=1 S I=$O(O(c,"")),ZAA02GF="CR" G:ST M1 G M5
        S I=$O(O(c,I)) S:'I I=$O(O(c,I)) G M1
        ;
