ZAA02GFRME7 ;PG&A,ZAA02G-FORM,2.62,FORM EDITOR, PART 8;22AUG95 9:19A;;;06MAY2004  15:21
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
STORE S %R=23,%C=1 W:'$d(qt) @ZAA02GP,ZAA02G("CS"),"Storing Static Info....",! S (A,B)=.9 F I=1:1 S B=$O(@ZAA02GS@(GR,B)) Q:B=""  K ^(B)
 S put=1,scope=GR D ^ZAA02GFRME3A
 S J=1 F I=0:1:15 S E(I)=J,D(I)="",J=J+20
 S A=.9 F I=1:1 S A=$O(@ZAA02GG@(A)) Q:A=""  S B="",AA=$C(A+31) W:'$d(qt) "." F J=1:1 S B=$O(@ZAA02GG@(A,B)) Q:B=""  S C=^(B),D=$P(C,"`"),E=$P(C,"`",2) D:C'["0*" @(E#2)
 F I=0:1:15 I D(I)'="" S @ZAA02GS@(GR,E(I))=D(I)
 G 3
1 S D(E)=D(E)_AA_$C(B+31,D+32) I $L(D(E))>240 S @ZAA02GS@(GR,E(E))=D(E),E(E)=E(E)+1,D(E)=""
 Q
0 S D(E)=D(E)_AA_$C(B+31)_D I $L(D(E))>240 S @ZAA02GS@(GR,E(E))=D(E),E(E)=E(E)+1,D(E)=""
 Q
3 S T="",%C=1 W:'$d(qt) @ZAA02GP,"Compiling Static Info:  ",ZAA02G("CS") S LC=24 G ^ZAA02GFRME6 I $D(WI),WI'="",WI'?1N."\" G ^ZAA02GFRME6
CONV S T=$O(^ZAA02G(0,T)) G DONE:T="",CONV:'^(T,"V")
 D CONVERT G CONV
DONE D DATE S $P(@ZAA02GS@(GR),"\",3)=DT
EXIT X ^ZAA02G("ECHO-ON") K C,G0,G1,OC,R,T,TX,Y,YY,X,Z,NXT,AA,E,PW Q
DATE S K=$H>21608+305+$H,Y=4*K+3\1461,D=K*4+3-(1461*Y)+4\4,M=5*D-3\153,D=5*D-3-(153*M)+5\5,M=M+2,Y=M\12+Y+140,M=M#12+1,Y=Y*100+M*100+D,DT=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3) K K,Y,M,D Q
 ;
CONVERT S D=1,%R=23,NXT="",B="",%C=LC W:'$d(qt) @ZAA02GP,T,"  ",ZAA02G("CS"),! S LC=LC+$L(T)+3,%R=.9 K @ZAA02GS@(GR,0,T)
 S X="Y="_^ZAA02G(0,T,"P"),G0=$S($D(^("G0")):^("G0"),1:""),G1=$S($D(^("G1")):^("G1"),1:"") I G0="",T?2"VT"3N S G0=$C(15),G1=$C(14)
 F I=1:1:11 S A=$P("TLC,HL,TRC,VL,BRC,BLC,X,TI,RI,BI,LI",",",I) S C(I)=^(A)
 S E=^ZAA02G(0,T,"Z"),B=B_E S:E'[^("HI") E=E_^("HI"),B=B_^("HI") F I=1:40:400 I $D(@ZAA02GS@(GR,I)) S A=$P(";LO;RON;LO,RON;UO;UO,LO;UO,RON;UO,LO,RON",";",I\40+1) D XX D TEXT S B=B_E
 S:G0]"" B=B_G1 F I=21:40:400 I $D(@ZAA02GS@(GR,I)) S A=$P(";LO;RON;LO,RON;UO;UO,LO;UO,RON;UO,LO,RON",";",I\40+1) D XX D LINE S B=B_E
 S:G0]"" B=B_G0 I B'="" S @ZAA02GS@(GR,0,T,D)=B K B,CT,D,Y,E,A Q
TEXT F J=I:1:I+19 Q:$D(@ZAA02GS@(GR,J))=0  S M=^(J) W:'$d(qt) "." F L=1:3:$L(M) S K=$E(M,L,L+2) D:$E(K,1,2)'=NXT XY S B=B_$E(K,3),NXT=$E(K)_$C($A(K,2)+1) I $L(B)>230 D CONT
 Q
LINE F J=I:1:I+19 Q:$D(@ZAA02GS@(GR,J))=0  S M=^(J) W:'$d(qt) "." F L=1:3:$L(M) S K=$E(M,L,L+2) D:$E(K,1,2)'=NXT XY S B=B_C($A(K,3)-32),NXT=$E(K)_$C($A(K,2)+1) I $L(B)>230 D CONT
 Q
CONT S @ZAA02GS@(GR,0,T,D)=B,B="",D=D+1 Q
XY S %R=$A(K)-31,%C=$A(K,2)-31,@X,B=B_Y Q
XX S Y="" Q:A=""  F J=1:1:$L(A,",") S Y=Y_^ZAA02G(0,T,$P(A,",",J))
 S B=B_Y D:$L(B)>230 CONT Q
NR S scope=">" F I=1:1 S scope=$O(@ZAA02GG) Q:$E(scope)'=">"  D COPY
 S scope=GR Q
COPY S Y=^ZAA02GDISP(SCR,SN,scope),A=+$P(Y,"`",3),B=$P(Y,"`",4),D=B-A+1,C=+$P(Y,"`",5)
 F RR=A:1:B I $D(@ZAA02GG@(RR)) S ^ZAA02GDISPL(GR,scope,RR)="" F CC=0:0 S CC=$O(@ZAA02GG@(RR,CC)) Q:'CC  S E=^(CC),^(RR)=^ZAA02GDISPL(GR,scope,RR)_$C(CC) W:'$d(qt) "." F ls=1:1:C S %R=ls-1*D+RR,%C=CC,^ZAA02GDISPL("~",$I,GR,%R,%C)=E W:0 @ZAA02GP,$P(E,"`",1)
 Q
