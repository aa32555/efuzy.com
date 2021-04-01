ZAA02GSCRAI2 ;PG&A,ZAA02G-SCRIPT,2.10,ACCOUNT INQUIRY - ZAA02GWP INTERFACE;21APR94 5:20P
C ;Copyright (C) 1991, Patterson, Gray & Associates, Inc.
BEG N Y S %R=TL-1,%C=1 W @ZAA02GP,ZAA02G("HI"),ZAA02G("CS") S Y=ZAA02G("HL"),Y=Y_Y W ZAA02G("G1"),Y F I=1:1:19 W Y,Y
 W ZAA02G("G0")
R4 S DOC="",%R=TL,%C=4,Y=$S('$D(ZAA02G(9)):"Doc#\Description\Author\Created\Updated",1:@ZAA02G(9)@(26))
 W @ZAA02GP,ZAA02G("LO") F I=1:1:5 S %C=$P("3,11,37,59,70",",",I) W @ZAA02GP,$P(Y,"\",I)
 S SEL="""==>""",SEL1=""""""
 S Y=$S('$D(ZAA02G(9)):"Type\Number\or use\ARROWS\to move selector - \RETURN\to make selection\No Documents found with keyword\Selected Document\Password\Document busy\Document Number\K\Keyword\B\Beginning\E\End\to look for\KBE",1:@ZAA02G(9)@(28))
 S L=$S('$D(ZAA02G(9)):"Function Keys\EXIT  HELP\NEXT SCREEN\FIND\PREVIOUS SCREEN  1ST SCREEN",1:@ZAA02G(9)@(29))
TOPP S I="",PP=0 I $D(FDOC) S %R=20 G FD
LEV S %R=22,%C=80-$L($P(Y,"\",1,7))\2 K IA W @ZAA02GP,ZAA02G("LO"),$P(Y,"\"),ZAA02G("HI")," ",$P(Y,"\",2)," ",ZAA02G("LO"),$P(Y,"\",3),ZAA02G("HI")," ",$P(Y,"\",4)," ",ZAA02G("LO"),$P(Y,"\",5)," ",ZAA02G("HI"),$P(Y,"\",6)," ",ZAA02G("LO"),$P(Y,"\",7)
 S (TG,TH)=" ",CN=0,%C=1,%R=TL+1 W @ZAA02GP
LEV1 S IA=$P(I,","),IB=$P(I,",",2) I IB="" S IA=$O(^ZAA02GACT(ID,IA)) G:IA="" FK
LEV2 S IB=$O(^ZAA02GACT(ID,IA,IB)) I IB="" S I=IA_","_IB G LEV1
 I '$D(^ZAA02GWP(IA,IB)) K ^ZAA02GACT(ID,IA,IB) G LEV2
 S I=IA_","_IB,CN=CN+1 I CN=1,'$D(PAGE(PP)) S PAGE(PP)=I
 S X=^(IB) W !,?3,I,?9,$E($P(X,"\"),1,25),?36,$E($P(X,"\",2),1,12),?55,$J($P(X,"\",3),11),$J($P(X,"\",6),11)
 S TH=TH_I_"\ ",IA(I)=CN G LEV1:CN<(19-TL) S CN=20-TL S:IA_IB="" CN=19-TL G FK
 ;
ASK S J=1,%C=1,N=CN S:CN=(20-TL) N=19-TL X ZAA02G("ECHO-OFF") I $D(FIND) S J=IA(FIND) K FIND
A1 S %R=TL+J+1 W @ZAA02GP,ZAA02G("HI"),@SEL,ZAA02G("LO")
A2 R C#1 I C'="" G @$S(C=" ":"B",C'?1.N:"ERR",1:"SEL")
 X ZAA02G("T") S TG=" ",C=$E(XX,$F(XX,ZF)) I C'="",$T(@C)'="" G @C
 W *7 G A1
 ;
A W *8,*8,*8,"   ",@SEL1 S J=$S(J>1:J-1,1:N) G A1
B W *8,*8,*8,"   ",@SEL1 S J=$S(J<N:J+1,1:1) G A1
O G:CN'=(20-TL) ERR D CLEAR S PP=PP+1,I=$P(TH,"\ ",19-TL) G LEV
P G:'PP A1 D CLEAR S PP=PP-1,I=PAGE(PP)-1 G LEV
Q I PP D CLEAR G TOPP
 G A1
 ;
E G EXIT
ERR W *7 G A1
CLEAR S %R=TL+2,%C=1 W @ZAA02GP,ZAA02G("LO"),ZAA02G("CS") Q
 ;
FK I CN<1 W !!?5,$P(Y,"\",8)," - " G 6
 S A="[ "_$P(L,"\")_":  "_ZAA02G("HI")_$P(L,"\",2) S:CN=(20-TL) A=A_"  "_$P(L,"\",3) S:CN=16!PP A=A_"  "_$P(L,"\",4) S:PP A=A_"  "_$P(L,"\",5) S A=A_ZAA02G("LO")_" ]"
 S %R=24,%C=($L(ZAA02G("HI"))*2+80-$L(A)\2) W @ZAA02GP,A G ASK
 ;
Y S HP=8 D HELP^ZAA02GWPV9 D CLEAR S FDOC=$E($P(TH,"\",J),2,9) K IA G TOPP
 ;
SEL S TG=TG_C,TJ=$F(TH,TG) I TJ S J=$L($E(TH,1,TJ-1),"\") W *8,*8,*8,"   ",@SEL1
 E  I $L(TG)>2 S TG=" " G SEL
 G A1
 ;
F S DOC=$E($P(TH,"\",J),2,9),DIR=$P(DOC,","),DOC=$P(DOC,",",2),X=^ZAA02GWP(DIR,DOC),DES=$P(X,"\",1),PWD=$P(X,"\",4),%R=24,%C=1 W @ZAA02GP,ZAA02G("LO"),$P(Y,"\",9)," [ ",ZAA02G("HI"),DIR,DOC,ZAA02G("LO")," ] ",ZAA02G("HI"),DES,ZAA02G("CL")
BUSY L ^ZAA02GWP(DIR,DOC):0 I '$T!($P(X,"\",10)'="") L  S %C=1 W @ZAA02GP,ZAA02G("CL"),$P(Y,"\",11) H 3 S DOC="" W *13,ZAA02G("CL") G FK
PWD G EXIT:PWD="" S %R=24,%C=59 W @ZAA02GP,ZAA02G("LO"),$P(Y,"\",10),": ",ZAA02G("HI"),ZAA02G("CL")
P1 S X="" X ZAA02G("ECHO-OFF") F I=0:0 R *C Q:C=27!(C=13)  S:$C(C)?1L C=C-32 I $L(X)<20 S X=X_$C(C)
 I X=""!(C=27) S DOC="" G EXIT
 I X'=$TR(PWD,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ") W *7 G P1
 ;
EXIT K CN,CRT,DAT,DES,IA,PAGE,PP,PWD,SEL,SEL1,TG,TH,TJ,KEY,KEY1,KEY2,KEY3 X ZAA02G("ECHO-ON") Q
 ;
FD1 F P=0:1 Q:'$D(PAGE(P))  I X'<PAGE(P) Q:X>PAGE(P)  S J=1,%C=5,PP=P+1 G P
 S:'$D(PAGE(P))&P P=P-1 S I=PAGE(P) F CN=1+1:1 S I=$O(@ZAA02GDOC@(I)) Q:I=""  S:CN=16 CN=1,P=P+1,PAGE(P)=I Q:X=I
 S:I'="" CN=16 S FIND=$S($D(^ZAA02GWP(DIR,X)):X,1:PAGE(P)),I=PAGE(P)-1 W @ZAA02GP,*13,ZAA02G("CS") G:P=PP&$D(IA) FK S PP=P D CLEAR G LEV
FD S X=FDOC,PAGE(0)=$O(@ZAA02GDOC@("")) K FDOC G FD1
