ZAA02GINTSCR ;PG&A,ZAA02G-CONFIG,2.25;20MAR91  16:07;;;20SEP97  10:16
 ;;Copyright (C) 1988,90,91 Patterson, Gray and Associates, Inc.
 ;NOTE:  Requires ZAA02Gs, ZAA02GGLOB, ZAA02GROUT
BEGIN L +@ZAA02GGLOB@(ZAA02Gs):1 E  L +@ZAA02GGLOB@(ZAA02Gs) L -@ZAA02GGLOB@(ZAA02Gs) Q
 N b,p,A,B,D,E,F,G,H,I,J,K,L,M,P,R,V,X,Y,Z,%C,%R,G0,G1,VD,TYP,ZAA02Gc
 S %R=24,%C=1 W @ZAA02GP,ZAA02G("LO")_"Compiling screen"_ZAA02G("CL") S %C=66 W @ZAA02GP,"...Please Wait" S %C=17 W @ZAA02GP,ZAA02G("HI")
 D:'$D(@ZAA02GGLOB@(ZAA02Gs,1)) @ZAA02GROUT S %R=24,%C=17 W @ZAA02GP,ZAA02G("LO")_" for "_ZAA02G,ZAA02G("HI"),ZAA02G("CL")
 S TYP=$P(@ZAA02GGLOB@(ZAA02Gs),"\",5) I TYP=1 D T1 G DONE
 S ZAA02Gc="~"_ZAA02Gs D FETCH,T2 K @ZAA02GGLOB@(ZAA02Gc)
DONE L -@ZAA02GGLOB@(ZAA02Gs) S %R=24,%C=1 W @ZAA02GP,ZAA02G("CS") S A=$D(@ZAA02GGLOB@(ZAA02Gs,0,ZAA02G,1)) K ZAA02GGLOB,ZAA02GROUT Q
FETCH K @ZAA02GGLOB@(ZAA02Gc) F I=1:40:400 I $D(@ZAA02GGLOB@(ZAA02Gs,I)) S VD="`"_(I\20),J=I\40 X "F J=I:1:I+19 Q:'$D(@ZAA02GGLOB@(ZAA02Gs,J))  S M=^(J) F L=1:3:$L(M) S K=$E(M,L,L+2),%R=$A(K)-31,%C=$A(K,2)-31,@ZAA02GGLOB@(ZAA02Gc,%R,%C)=$E(K,3)_VD" W "."
 F I=21:40:400 I $D(@ZAA02GGLOB@(ZAA02Gs,I)) S VD="`"_(I\20),J=I\40 X "F J=I:1:I+19 Q:'$D(@ZAA02GGLOB@(ZAA02Gs,J))  S M=^(J) F L=1:3:$L(M) S K=$E(M,L,L+2),%R=$A(K)-31,%C=$A(K,2)-31,@ZAA02GGLOB@(ZAA02Gc,%R,%C)=$A(K,3)-32_VD" W "."
 Q
 ;
T1 K @ZAA02GGLOB@(ZAA02Gs,0,ZAA02G) S D=1,%R=.9,(B,NXT)="" D INIT
 S B=B_Z S:Z'[ZAA02G("HI") Z=Z_ZAA02G("HI"),B=B_ZAA02G("HI") F I=1:40:400 I $D(@ZAA02GGLOB@(ZAA02Gs,I)) S A=$P(";LO;RON;LO,RON;UO;UO,LO;UO,RON;UO,LO,RON",";",I\40+1) D XX D TEXT S B=B_Z
 S:G0]"" B=B_G1 F I=21:40:400 I $D(@ZAA02GGLOB@(ZAA02Gs,I)) S A=$P(";LO;RON;LO,RON;UO;UO,LO;UO,RON;UO,LO,RON",";",I\40+1) D XX D LINE S B=B_Z
 S:G0]"" B=B_G0 I B'="" S @ZAA02GGLOB@(ZAA02Gs,0,ZAA02G,D)=B
 K B,CT,D,Y Q
 ;
TEXT F J=I:1:I+19 Q:$D(@ZAA02GGLOB@(ZAA02Gs,J))=0  S M=^(J) W "." F L=1:3:$L(M) S K=$E(M,L,L+2) D:$E(K,1,2)'=NXT XY S B=B_$E(K,3),NXT=$E(K)_$C($A(K,2)+1) I $L(B)>230 D CONT
 Q
LINE F J=I:1:I+19 Q:$D(@ZAA02GGLOB@(ZAA02Gs,J))=0  S M=^(J) W "." F L=1:3:$L(M) S K=$E(M,L,L+2) D:$E(K,1,2)'=NXT XY S B=B_C($A(K,3)-32),NXT=$E(K)_$C($A(K,2)+1) I $L(B)>230 D CONT
 Q
CONT S @ZAA02GGLOB@(ZAA02Gs,0,ZAA02G,D)=B,B="",D=D+1 Q
XY S %R=$A(K)-31,%C=$A(K,2)-31,@P,B=B_p Q
XX S Y="" Q:A=""  F J=1:1:$L(A,",") S Y=Y_ZAA02G($P(A,",",J))
 Q:TYP>1  S B=B_Y D:$L(B)>230 CONT Q
 ;
T2 D INIT F I=0:1:7 S A=$P(";LO;RON;LO,RON;UO;UO,LO;UO,RON;UO,LO,RON",";",I+1) D XX S b(I)=Y
 I TYP=2 S Y=ZAA02G("CL") F %R=1:1:24 S %C=1,@P,@ZAA02GGLOB@(ZAA02Gs,0,ZAA02G,%R)=p_Y,^(%R+.1)="" D:$D(@ZAA02GGLOB@(ZAA02Gc,%R)) S1
 I TYP=3 F %R=1:1:24 I $D(@ZAA02GGLOB@(ZAA02Gc,%R)) S (@ZAA02GGLOB@(ZAA02Gs,0,ZAA02G,%R),^(%R+.1))="" D S1
 Q
 ;
S1 S (%C,V,G,L)="",F=1
 F J=1:0 S %C=$O(@ZAA02GGLOB@(ZAA02Gc,%R,%C)) Q:%C=""  Q:%C>39  D:F'=%C S2 S F=%C+1,C=^(%C),D=$P(C,"`"),E=$P(C,"`",2),H=E\2 S:H'=V G=G_L_b(H) S V=H,G=G_$S(E#2:G1_C(D)_G0,1:D),L=Z I $L(G)>200 D S3
 D S3 S ^(%R)=@ZAA02GGLOB@(ZAA02Gs,0,ZAA02G,%R)_G,G="" W "."
 I %C S %C=39 F J=1:0 S %C=$O(@ZAA02GGLOB@(ZAA02Gc,%R,%C)) Q:%C=""  D:F'=%C S2 S F=%C+1,C=^(%C),D=$P(C,"`"),E=$P(C,"`",2),H=E\2 S:H'=V G=G_L_b(H) S V=H,G=G_$S(E#2:G1_C(D)_G0,1:D),L=Z I $L(G)>200 D S3
 D S3 S @ZAA02GGLOB@(ZAA02Gs,0,ZAA02G,%R+.1)=G_Z W "." Q
S2 I F+6<%C S @P,G=G_p Q
 I V<2 S G=G_$J("",%C-F) Q
 S G=G_Z_$J("",%C-F),(L,V)="" Q
S3 Q:R=""  Q:G'[R  S W="",K=$F(G,R),D=$L(W)-$L(R) F J=0:0 S G=$E(G,0,K-$L(R)-1)_W_$E(G,K,256) S K=$F(G,R,K+D) Q:K<1
 Q
INIT S P="p="_ZAA02GP,Z=ZAA02G("Z"),G1=ZAA02G("G1"),G0=ZAA02G("G0"),R=G0_G1 F I=1:1:11 S A=$P("TLC,HL,TRC,VL,BRC,BLC,X,TI,RI,BI,LI",",",I) S C(I)=ZAA02G(A)
 Q
