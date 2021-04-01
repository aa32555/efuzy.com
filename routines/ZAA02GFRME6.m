ZAA02GFRME6 ;PG&A,ZAA02G-FORM,2.62,PART 7;22AUG95 9:49A
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
 ;
STORE S PW=$P(^ZAA02GDISP(SCR,SN),"`",13)["N",T="",MXR=24,(MC,MR)=1 G S:'PW
 W:'$d(qt) "(partial window)"
 S MC=255,(MXC,MXR)=0,MR=$O(@ZAA02GG@(.9)) F J=MR:1:25 S %C=$O(@ZAA02GG@(J,"")) X:%C "S:%C<MC MC=%C F %C=$S(MXC>60:MXC,$O(^(60)):$O(^(60)),$O(^(40)):$O(^(40)),1:MXC):1 I $O(^(%C))="""" S MXC=%C Q" I $O(@ZAA02GG@(J))="" S MXR=J Q
 S $P(@ZAA02GS@(GR),"\",4)=MR_":"_MXR_":"_MC_":"_MXC_":"_T,LC=LC+2,T=""
S S LC=LC+17
S0 S T=$O(^ZAA02G(0,T)),%C=LC,%R=23 G DONE^ZAA02GFRME7:T="",S0:'^(T,"V") S LC=LC+$L(T)+2 S:LC>78 %R=24,%C=1,LC=$L(T)+2 W:'$d(qt) @ZAA02GP,T,"  ",ZAA02G("CS") K ^ZAA02GDISPL(GR,0,T) S ^(T,0)=PW,CL=$S('PW:^ZAA02G(0,T,"CL"),T["VT220":$C(27,91)_(MXC-MC+1)_"X",1:"")
 S G1=$S($D(^ZAA02G(0,T,"G1")):^("G1"),1:""),G0=$S($D(^("G0")):^("G0"),1:""),R=G0_G1 F I=1:1:11 S A=$P("TLC,HL,TRC,VL,BRC,BLC,X,TI,RI,BI,LI",",",I) S C(I)=^(A)
 F I=0:1:7 S A=$P(";LO;RON;LO,RON;UO;UO,LO;UO,RON;UO,LO,RON",";",I+1) D XX S b(I)=Y
 S P="X="_^ZAA02G(0,T,"P"),Z=^("Z"),Y=CL,H=0
 F %R=MR:1:MXR S %C=MC,@P,^ZAA02GDISPL(GR,0,T,%R)=X_Y,^(%R+.1)="" I $D(@ZAA02GG@(%R)) S V=0,G=Z,F=MC D S1
 G S0
S1 S %C="" F J=1:0 S %C=$O(@ZAA02GG@(%R,%C)) Q:%C=""  Q:%C>39  S C=^(%C) I C'["0*" D:F'=%C S2 S F=%C+1,D=$P(C,"`"),E=$P(C,"`",2),H=E\2 S:H'=V G=G_Z_b(H) S V=H,G=G_$S(E#2:G1_C(D)_G0,1:D) I $L(G)>200 D S3
 D S3 S ^(%R)=^ZAA02GDISPL(GR,0,T,%R)_G,G="" W:'$d(qt) "."
 I %C S %C=39 F J=1:0 S %C=$O(@ZAA02GG@(%R,%C)) Q:%C=""  S C=^(%C) I C'["0*" D:F'=%C S2 S F=%C+1,D=$P(C,"`"),E=$P(C,"`",2),H=E\2 S:H'=V G=G_Z_b(H) S V=H,G=G_$S(E#2:G1_C(D)_G0,1:D) I $L(G)>200 D S3
 D S3 S:H G=G_Z S ^ZAA02GDISPL(GR,0,T,%R+.1)=G Q
S2 I F+6<%C,CL'="" S @P,G=G_X Q
 I V<2 S G=G_$J("",%C-F) Q
 S G=G_Z_$J("",%C-F),V="" Q
S3 Q:R=""  Q:G'[R  S W="",K=$F(G,R),D=$L(W)-$L(R) F J=0:0 S G=$E(G,0,K-$L(R)-1)_W_$E(G,K,256) S K=$F(G,R,K+D) Q:K<1
 Q
 ;
XX S Y="" Q:A=""  F J=1:1:$L(A,",") S Y=Y_^ZAA02G(0,T,$P(A,",",J))
 Q
AA S A="" F I=1:1 S A=$O(G(A)) Q:A=""  W:'$d(qt) G(A),!
