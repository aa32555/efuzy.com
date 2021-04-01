ZAA023 
READ N i,c,f,A,B,C,I,L,R,T,Z,CC,R,PA,PR,YY,ZF,RON,ROF S:'$D(ZAA02G("MENU")) ZAA02G("MENU")=^ZAA02G("MENU") S HK=ZAA02G("MENU")=0
 S RON=ZAA02G("RON")_" ",ROF=ZAA02G("ROF") S:$D(ZAA02G("a")) RON=$P(ZAA02G("a"),"`",1),ROF=$P(ZAA02G("a"),"`",2)_$C(8)
 S (CC,%C)=+Y,R=+$P(Y,",",2),%R=$S(R:R,1:24),PA=$P(Y,"\",2),f="CR,"_$P(Y,"\",3),PR=$P(Y,"\",4),I=$P(Y,"\",5),Y=$P(Y,"\",6)
 S YY=$TR(Y,"abcdefghijklmnopqrstuvwxyz ","ABCDEFGHIJKLMNOPQRSTUVWXYZ"),C=$L(Y,","),%C=%C+$L(PR)+1,Z="",T="C(i)="_ZAA02GP F i=1:1:C S B=$P(Y,",",i),Z=Z_"  "_B,@T,%C=%C+$L(B)+2
 S:'I!(I>C) I=1 S L=$L(Z)+$L(PR),%C=CC W @ZAA02GP W:PR]"" PR W:PA["H" ZAA02G("HI") W Z," "
M1 W C(I)_HI_RON_$P(Y,",",I)_ROF
M2 R c#1 I c]"" S:c?1L c=$C($A(c)-32) G M6:c'=" " D M4 S I=I+1 S:I>C I=1 G M1
M3 X ZAA02G("T") S ZAA02GF=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2) G:f[ZAA02GF M5 D M4 S I=$S(ZAA02GF="RK":I+1,ZAA02GF="LK":I-1,1:I) S:I>C I=1 S:I<1 I=C G M1
M4 W C(I)_HI_" "_$P(Y,",",I)_" " Q
M5 S X=I,%C=CC Q:PA["D"  W @ZAA02GP,$J("",L) Q
M6 D M4 S A=$F($P(YY,",",I,99),","_c) I A>1 S I=I+$L($E($P(YY,",",I,99),1,A),",")-1 G M7:HK,M1
 S A=$F(YY,","_c) I A>1 S I=$L($E(YY,1,A),",") G M7:HK,M1
 I $E(YY)=c S I=1 G M7:HK,M1
 G M1
M7 G M1:$L(YY,","_c)>2 S ZAA02GF="CR" G M5
