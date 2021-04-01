ZAA02GFAXN ;PG&A,ZAA02G-FAX,1.36,INTERNATIONAL MESSAGES;10JAN96 4:41P
C ;Copyright (C) 1992, Patterson, Gray & Associates, Inc.
 ;
INIT ;Initialize global ^ZAA02GFAXC(99
 S FR="VT",TO="PC" D CHARSET^ZAA02GINIT2
 S CE="" R "Initialize VT for Multi-national or National character sets (M or N) - ",MD#1,! I MD="N" R "For what country - Germany, France, Italy (G,F or I) - ",MD#1,!!
 S CF=$C(64,91,92,93,96,123,124,125,126)
 I MD]"","GFI"[MD S CE=$S(MD="G":$C(167,196,214,220,96,228,246,252,223),MD="F":$C(224,176,231,167,96,233,249,232,126),MD="I":$C(167,176,231,233,249,224,242,232,236),1:"") W "7 bit National Mode",!! S ^ZAA02GFAXC(99)=MD
 E  S ^ZAA02GFAXC(99)=""
 S:CE="" (CE,CF)=" " S X="F ST=ST+1:1:99 S I=$T(@ST) Q:+I"
 S Y="W ""."" F K=1:1:6 S C=$P($T(@ST+K),"";;"",2,99) S:K=1 E=C S:C="""" C=E X Z S ^ZAA02GFAXC(99,1,K,ST)=$TR(C,CE,CF),^ZAA02GFAXC(99,0,K,ST)=$TR(C,CA,CB)"
 S Z="S A=C,C=$P(A,""%"") F L=2:1:$L(A,""%"") S D=$P(A,""%"",L),C=C_$C($A(D)+128)_$E(D,2,255)"
 S A=^ZAA02G("ERROR")_"=""TRAP^ZAA02GFAXN""",@A
 F %I=1:1:5 X "ZL @(""ZAA02GFAXN""_%I) W %I S ST=0 F J=1:1 X X Q:+I=0  X Y"
 Q
 ;
TRAP W:$ZE'["<NOPGM" !!,$ZE,! K:0  Q
 ;
FAX ;Load lines from global ^ZAA02GFAXC(99,0 into routines ZAA02GFAXNx
 K  S (CA,CB)=" ",LV=1 ; S FR="P",TO="VT",LV=0 D CHARSET^ZAA02GINIT2
 S (CC,CH)="",$P(CC,$C(1),65)="" F J=192:4:255 S CH=CH_$C(J,J+1,J+2,J+3)
 S C="S D=$TR(A,CH,CC),B=A,M=$F(D,$C(1)),A=$E(B,1,M-2) F J=1:1:$L(D,$C(1))-1 S L=$F(D,$C(1),M),A=A_""%""_$C($A(B,M-1)-128)_$E(B,M,$S(L=0:255,1:L-2)),M=L"
 S X="S Z(1)=P_"" ;PG&A,ZAA02G-FAX,1.23,INTERNATIONAL MESSAGES;17JUL92 12:11A""",Z(2)=$T(C),Z(3)=" ;",Z(4)="DATA ;;",G="^ZAA02GFAXC(99,LV)"
 S Z="ZR  F I=1:1:4 ZI Z(I) I I=4 F I=1:1 S N=$O(@G@(1,N))  S M='$L(N)!(CT>2000) ZS:M @P Q:M  W ""."" ZI N_"" ;;"" F K=1:1:6 S A=$S($D(@G@(K,N)):$TR(^(N),CA,CB),1:"""") X:$TR(A,CH)'=A C S:A=O A="""" W A,! ZI "" ;;""_A S CT=CT+$L(A) S:K=1 O=A"
 S (N,O)="" F %I=1:1 S P="ZAA02GFAXN"_%I W %I X X,"S CT=0,N=N-1 ZR  X Z" Q:N=""
 Q
 ;
MN ; Multi-national text edit
 R "ENTER LANGUAGE # (2-6) - ",NT,!,"wait..." Q:NT<2
 D INIT^ZAA02GDEV S (A,E)="",I=10,F=ZAA02G["VT",L=ZAA02G("LO"),H=ZAA02G("HI"),CC=$C(1,1,1) K ^ZAA02GTWP("MN",$I)
 F J=1:1 S A=$O(^ZAA02GFAXC(99,F,1,A)) Q:A=""  S D=^(A),B=$S($D(^ZAA02GFAXC(99,F,NT,A)):^(A),1:"") D MN1
 S $P(^ZAA02GTWP("MN",$I,10),$C(1))=.03,TL=2,BL=22,WO="",MG=128,ZAA02GWPD="^ZAA02GTWP(""MN"",$I)",NM="LANG - "_NT,ZAA02GWPOPT="OT"
 D ENTRY^ZAA02GWPV6 S CC=$C(1,1,1),F=ZAA02G["VT"
XX S A=.03 F J=1:1 S A=$O(^ZAA02GTWP("MN",$I,A)) Q:A=""  S B=$P(^(A),CC,2) D X1
 Q
X1 I $A(B)=27 S C=$P(B,"~",2),D=$P(B,"~",3),A=$O(^(A)) W "." I $A($P(^($O(^(A))),CC,2))=27 S A=$O(^(A))
 E  S:$E(B)'="+" $P(^ZAA02GFAXC(99,F,NT,C),"\",D)=B S:$E(B)="+" $P(^(C),"\",D)=$P(^ZAA02GFAXC(99,F,NT,C),"\",D)_$E(B,2,130)
 Q
MN1 F K=1:1:$L(D,"\") S C=$P(B,"\",K) I $P(D,"\",K)'="" D MN2
 Q
MN2 S:$L(C)>128 E="+"_$E(C,129,255),C=$E(C,1,128)
 S ^ZAA02GTWP("MN",$I,I)=I-10_CC_L_"~"_A_"~"_K_H,^(I+10)=I_CC_L_$E($P(D,"\",K),1,128)_H
 I $L($P(D,"\",K))>128 S ^(I+20)=I+10_CC_L_"+"_$E($P(D,"\",K),129,255)_H,I=I+10
 S ^(I+20)=I+10_CC_C,I=I+30 I E'="" S ^(I)=I-10_CC_E,E="",I=I+10
