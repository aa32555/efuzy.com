ZAA02GFRME8 ;PG&A,ZAA02G-FORM,2.62,FORMS EDITOR, PART 9;28APR95 2:36P;;;07MAY2004  07:54
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
CTL W:'$d(qt) ZAA02G("F"),ZAA02G("LO") I $P(^ZAA02GDISP(SCR,SN),"`",5)="Y" S wide=1 X $P(^ZAA02G(.1,ZAA02G,7),"\")
 D INIT I $D(^ZAA02GDISPL("~",$I)) D PAINT
 I $D(@ZAA02GS@(GR)),'$D(^ZAA02GDISPL("~",$I)) D BUILD
 S scope=GR,put=3 D ^ZAA02GFRME3A
 S scope=GR G ^ZAA02GFRME9
 ;
INIT K SP,PNT S $P(SP,".",ZAA02G("C")+1)="",P=ZAA02G("P")
 F I=1:1:11 S A=$P("TLC,HL,TRC,VL,BRC,BLC,X,TI,RI,BI,LI",",",I) S CT(I)=^ZAA02G(0,^ZAA02G($I),A)
 S (CS,RS)=1,CE=$S($D(wide):132,1:80),RE=24 D LIMITS
 S %R=23,%C=73,A="CUR="_ZAA02GP_"_""R""",@A,VIDON=ZAA02G("LO"),(E,VIDOF)=ZAA02G("Z"),%C=1,A="STL="_ZAA02GP,@A,STL=STL_ZAA02G("CL"),%R=24,A="STL1="_ZAA02GP,@A,STL1=STL1_ZAA02G("CL")
 K AA S TC=ZAA02G("T"),T=^ZAA02G($I)
 S XX="",J=2 F I="LK","RK","DK","UK" S XX=XX_ZAA02G(I)_J,J=J+1
 S XX=XX_$C(12)_"1",J=1 F I=19,6,7,13,16,21,8,17,10 S C="C=$C("_$P(^ZAA02G(.1,ZAA02G,I>14+2),"`",I)_")",@C,XX=XX_C_$E("ABCFGHIJK",J),J=J+1
 S J=1 F I="INK","DLK" S XX=XX_ZAA02G(I)_$E("DE",J),J=J+1
 F V=0:1:15 S VD(V)=$S(V\2#2:ZAA02G("LO"),1:ZAA02G("HI"))_$S(V\4#2:ZAA02G("RON"),1:ZAA02G("ROF"))_$S(V\8#2:ZAA02G("UO"),1:ZAA02G("UF"))_$S(V#2:ZAA02G("G1"),1:ZAA02G("G0"))
 Q
LIMITS K C,R S C(CS-1)=CE-CS+1,C(CE+1)=CS-CE-1,R(RS-1)=RE-RS+1,R(RE+1)=RS-RE-1 Q
 ;
PAINT Q:$d(qt)  S G1=ZAA02G("G1"),G0=ZAA02G("G0"),I="" F %R=1:1:ZAA02G("R") I $D(@ZAA02GG@(%R)) F %C=.9:0 S %C=$O(@ZAA02GG@(%R,%C)) Q:'%C  S A=^(%C),B=$P(A,"`",2) W:B'=I VD(+B) S I=B W @ZAA02GP,$S(B#2:CT(+A),1:$P(A,"`"))
 W ZAA02G("Z") F %R=0:0 S %R=$O(@ZAA02GG@(.2,%R)) Q:'%R  F %C=.9:0 S %C=$O(@ZAA02GG@(.2,%R,%C)) Q:'%C  S I=$P(^(%C),"\",2),Y=^ZAA02GDISPL("~",$I,0,I) I I'[">" S B=$P(Y,"`",3),%R=+B,%C=$P(B,",",2) W @ZAA02GP,$E(I_SP,1,$P(Y,"`",5))
 Q
 ;
BUILD S ^ZAA02GDISPL("~",$I)=GR D FETCH,G
 S A=" "
 F I=1:1 S A=$O(^ZAA02GDISP(SCR,SN,A)) Q:A=""  S B=^(A) I $P(B,"`",3)'="" S scope=$S($D(^(A,0)):^(0),1:GR) D PUT
 Q
 ;
PUT S E=$P(B,"`",5),Y=$P(B,"`",3),%R=+Y,%C=+$P(Y,",",2),@ZAA02GG@(.2,%R,%C)=E_"\"_A_"\",^ZAA02GDISPL("~",$I,0,A)=B,^(A,0)=scope D:$E(A)'=">" @$S($P(B,"`",21)]"":"LIST",1:"C6") Q
FETCH W:'$d(qt) E F I=1:40:400 I $D(@ZAA02GS@(GR,I)) S VD="`"_(I\20),J=I\40 W:'$d(qt) VD(I\20) D TXT W:'$d(qt) E
 F I=21:40:400 I $D(@ZAA02GS@(GR,I)) S VD="`"_(I\20),J=I\40 W:'$d(qt) VD(I\20) D LINE W:'$d(qt) E
 Q
TXT F J=I:1:I+19 Q:'$D(@ZAA02GS@(GR,J))  S M=^(J) F L=1:3:$L(M) S K=$E(M,L,L+2),%R=$A(K)-31,%C=$A(K,2)-31,@ZAA02GG@(%R,%C)=$E(K,3)_VD W:'$d(qt) @ZAA02GP,$E(K,3)
 Q
LINE W:'$d(qt) ZAA02G("G1") F J=I:1:I+19 Q:'$D(@ZAA02GS@(GR,J))  S M=^(J) F L=1:3:$L(M) S K=$E(M,L,L+2),%R=$A(K)-31,%C=$A(K,2)-31,@ZAA02GG@(%R,%C)=$A(K,3)-32_VD W:'$d(qt) @ZAA02GP,CT($A(K,3)-32)
 W:'$d(qt) ZAA02G("G0") Q
 ;
C6 W:'$d(qt) @ZAA02GP,$E(A_SP,1,E) S @ZAA02GG@(%R,%C)=$E(A_SP,1,E)_"`0*"_"`"_E_"\"_A Q
LIST S Y=$P(B,"`",21) Q:$E(Y)'="V"  S E=$E(A_SP,1,E)_"`0*"_"`"_E_"\"_A
 F %R=%R+$P(Y,",",2)-1:-1:%R S @ZAA02GG@(%R,%C)=E W:'$d(qt) @ZAA02GP,$P(E,"`")
 S $P(@ZAA02GG@(.2,%R,%C),"\",3)=$P(Y,",",2),^(%C)=@ZAA02GG@(%R,%C)_"\"_$P(Y,",",2)
 Q
 ;
G S %R=ZAA02G("R"),%C=1 W:'$d(qt) @ZAA02GP,ZAA02G("HI"),ZAA02G("RON"),"please wait.",ZAA02G("Z")
 F RR=0:0 S RR=$O(^ZAA02GDISPL(GR,">",RR)) Q:RR=""  S X=^(RR) W:'$d(qt) "." F CC=1:1:$L(X) K @ZAA02GG@(RR,$A(X,CC))
 S g=">" F B=0:0 S g=$O(^ZAA02GDISPL(GR,g)) Q:g=""  S scope=g W:'$d(qt) "." F RR=0:0 S RR=$O(^ZAA02GDISPL(GR,g,RR)) Q:'RR  F CC=0:0 S CC=$O(^ZAA02GDISPL(GR,g,RR,CC)) Q:'CC  S @ZAA02GG@(RR,CC)=$TR(^(CC),$C(1),"*")
 Q
 ;
