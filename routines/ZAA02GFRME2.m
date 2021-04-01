ZAA02GFRME2 ;PG&A,ZAA02G-FORM,2.62,FORMS EDITOR, PART 3;13APR95 10:58A
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
EDIT W:'$d(qt) ZAA02G("F") D HEAD S xx=^ZAA02GDISP(95,ZAA02G,4),LLT="G" K NSB
DP K ST D:LLT="G" SET,G0 D XXX,PULL G:X=0 END S C=A(X)
DP1 S %C=25,%R=1,(OST,ST)=^ZAA02GDISP(SCR,SN,C),scope=^(C,0),ROW=$P(ST,"`",3),COL=$P(ROW,",",2) W:'$d(qt) @ZAA02GP,$P(ST,"`",11),ZAA02G("LO"),"    Position: ",ZAA02G("HI"),$S(+ROW:"R"_(+ROW)_" C"_COL,1:"Not Used")
 K PST I C["^" S X=$E(C,2,99) I $D(^ZAA02GSCHEMA(X)) S PST=",1,2,"
 D INITG:C[">",E1^ZAA02GFRME5 Q:'$D(xx)  K PST I ST'=OST D:RX=9 NOCHG I $D(ST) S ^ZAA02GDISP(SCR,SN,C)=ST K ST D:C[">" DONEG
 S %R=1,%C=25 W:'$d(qt) @ZAA02GP,$J("",35) D ERASE G DP
ERASE S %R=24,%C=25 W:'$d(qt) @ZAA02GP,ZAA02G("CL") S %C=33 F %R=3:1:24 W:'$d(qt) @ZAA02GP,ZAA02G("CL")
 Q
SORT S L=L+1 N A S A=B N B S B="" F J=1:1 S B=$O(X(A,B)) Q:B=""  S:M#18=0 PG(PG)=M,PG=PG+1 S M=M+1,Y(M)=$E(". . . . .",2,L*2)_B I $E(B)=">" D SORT
 S L=L-1 Q
NOCHG S %R=24,%C=26 W:'$d(qt) @ZAA02GP,ZAA02G("CL"),*7,ZAA02G("RON")," SAVE THESE CHANGES? (Y OR N) - ",ZAA02G("ROF") R %R#1 S:%R?1L %R=$C($A(%R)-32) Q:%R="Y"  G:%R'="N" NOCHG K ST Q
END K A,LL,LLT,HD,SD,NE,EC,ST,OST,DD,HELP,H,HD,HD1,NSB,COPY Q
ENTRY Q:'$D(^ZAA02GDISP(0,"DEBUG"))  W:'$d(qt) ZAA02G("F"),ZAA02G("Z") S C=$P(Y,"`",11) D ENTRY1 S tt=1,td=22 D REFR^ZAA02GFORM4 Q
ENTRY1 N (SCR,SN,ZAA02G,ZAA02GP,C) S QTF=0 D HEAD,SET,G0,DP1 S %R=24,%C=67 W:'$d(qt) @ZAA02GP,"PRESS RETURN" R A#1 I A="S" S %R=18,%C=1,C=$P(^ZAA02GDISP(SCR,SN,C),"`",14) W:'$d(qt) @ZAA02GP,ZAA02G("CS"),$G(^ZAA02GDISP(SCR,SN,C)),!,$G(^(C+.1)),!,$G(^(C+.2)),! R A#1
 Q
 ;
SET S LL="47,47,10,47,1*,10,1*,47,6*,47,47,47,47,47,1*,47,47,47,47,47,47",DD="3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22",SD="2,4,5,6,1,8,13,7,20,25,9,17,12,23,22,16,10,15,21,24",NE=20,EC=28
 S HD="Reference (Global,Local);$Piece(X;Length (1-80);Pattern Match (X?--);Mandatory (R, Y, or N);Ditto Field;Tab Stop (Y or N);Help Ref/Error Ref;Display Only & Input Mode;Table Para.\Mnemonic Ref.;  ""   Lookup-Reference;*"
 S HD1=";;;;;;;;;;*;  ""   Reference;  ""   Text Length & Ref.;  ""   Menu Parameters;Process Ack? (Y,C,N);Validation Code;Fetch Transform;Put Transform;If Multiple-Give Parameters;Alternate Input Driver;3;4",LLT="",COPY="COPY^ZAA02GFRME2"
 Q
 ;
G0 D ^ZAA02GFRME5 S HELP="^ZAA02GFRMEA" Q
 ;
INITG S LL="0,40,1*,40,40,20,1*,40,40,40,40,40",DD="4,6,7,8,10,11,13,14,16,17,19,20",SD="5,6,7,8,9,17,10,12,15,16,18,19",NE=12,EC=28
 S HD="Number to Display;Maximum # of Groups;Tab Stop (Y or N);Existence Test;Put Group Count Reference;Put $P(X...);Dense (Y/N)?;Number Mandatory;Pre-Remove eXecute;Pre-Insert eXecute;Pre-Group eXecute;Post Group eXecute"
 S HELP="EDIT^ZAA02GFRMEA1" S %R=3,%C=1 W:'$d(qt) @ZAA02GP,ZAA02G("CS") N ST D ^ZAA02GFRME5
 S LLT="G" Q
 ;
DONEG S %R=3,%C=1 W:'$d(qt) @ZAA02GP,ZAA02G("CS") D SET,G0 Q
 ;
HEAD S (%R,%C)=1 W:'$d(qt) @ZAA02GP,ZAA02G("LO"),"Field Attributes" S %R=1,%C=74-$L(SCR_SN) W:'$d(qt) @ZAA02GP,"Form: ",ZAA02G("HI"),SCR,"-",SN S %R=2,%C=1 W:'$d(qt) @ZAA02GP,ZAA02G("LO"),ZAA02G("G1") S J=ZAA02G("HL"),J=J_J_J_J F I=1:1:20 W:'$d(qt) J
 W:'$d(qt) ZAA02G("G0") Q
PULL S (%R,SR)=3,(%C,SC)=45,A=PG(PG) S:'$D(NSB) NSB=1_","_PG W:'$d(qt) @ZAA02GP,ZAA02G("HI"),ZAA02G("G1"),ZAA02G("TLC") F I=1:1:16 W:'$d(qt) ZAA02G("HL")
 K TB S TY=" ",TJ="X="_ZAA02GP,%C=SC,B=ZAA02G("RT")_" " W:'$d(qt) ZAA02G("TRC") F I=1:1:18 S A=$O(Y(A)) Q:A=""  S %R=%R+1,@TJ,M=Y(A) W:'$d(qt) X,ZAA02G("VL"),ZAA02G("G0")," " S TB(I)=X_B_M_" ",TY=TY_$E($TR(M,"."),1,4)_"\ ",A(I)=$TR(M,". ") W:'$d(qt) M,$J("",15-$L(M)),ZAA02G("G1"),ZAA02G("VL")
 S NB=$S(A="":I-1,1:I),%R=%R+1 W:'$d(qt) @ZAA02GP,ZAA02G("BLC") F I=1:1:16 W:'$d(qt) ZAA02G("HL")
 W:'$d(qt) ZAA02G("BRC"),ZAA02G("G0") F %R=%R+1:1:23 W:'$d(qt) @ZAA02GP,ZAA02G("CL")
 S %R=24,%C=25 W:'$d(qt) @ZAA02GP,ZAA02G("LO"),"Function Keys: ",ZAA02G("HI") W:$D(PG(PG+1)) "NEXT, " W:PG>1 "PREV, FIRST, " W:'$d(qt) "DEL LINE, EXIT",ZAA02G("CL")
SEL X ^ZAA02G("ECHO-OFF") S TG=" " F X=+NSB:1:NB W:'$d(qt) ZAA02G("RON"),TB(X) R B#1 X ZAA02G("T") W:'$d(qt) ZAA02G("ROF"),TB(X) S:B="" I=$E(xx,$F(xx,ZF)) G:B="" SEL1:I=1,SEL3:I="E",SEL4:I="F" D:B?1AN SEL2 I I=3 S X=X-2 I X<0 S X=NB-1
 S NSB=1_","_PG G SEL
SEL1 W:'$d(qt) ZAA02G("ROF"),ZAA02G("HI") X ^ZAA02G("ECHO-ON") S %C=35 F %R=%R:-1:SR W:'$d(qt) @ZAA02GP,ZAA02G("CL")
 W:'$d(qt) ZAA02G("HI") S NSB=X_","_PG K TB,TG,TY,TJ,LB Q
SEL2 S TG=TG_B,TJ=$F(TY,TG) I TJ S X=$L($E(TY,1,TJ-1),"\")-1,ZF="" Q
 I $L(TG)>2 S TG=" " G SEL2
 S TG=" " Q
SEL3 S ZF=$E(xx,$F(xx,ZF)+1) I ZF=4 S X=0 Q
 I ZF=1 G:$D(PG(PG+1))=0 SEL S PG=PG+1,NSB=1_","_PG G PULL
 I ZF=2 G:PG=1 SEL S PG=PG-1,NSB=1_","_PG G PULL
 G:PG=1 SEL S PG=1,NSB=1_","_PG G PULL
SEL4 S ST=^ZAA02GDISP(SCR,SN,A(X)) G:$P(ST,"`",3)'="" SEL S %R=24,%C=25 W:'$d(qt) @ZAA02GP,"Do you want to delete field ",A(X)," (Y or N) ",ZAA02G("CL") R ST#1 I "yY"[ST K ^(A(X)) W:'$d(qt) "...done" D XXX
 G PULL
XXX K A,X,PG,STM,Y S A=">" F I=0:1 S (B,A)=$O(^ZAA02GDISP(SCR,SN,A)) Q:A=""  S:$P(^(A),"`",3)="" B=B_"." S X(^(A,0),B)=""
 S B=SCR_"-"_SN,(M,L)=0,PG=1 D SORT S PG=$S($D(NSB):$P(NSB,",",2),1:1) Q
COPY S %R=24,%C=24,X=SCR_"-"_SN W:'$d(qt) @ZAA02GP,*13,ZAA02G("CL"),@ZAA02GP,ZAA02G("LO"),"Copy from FORM: ",ZAA02G("HI"),X S %C=40 X ^ZAA02GREAD Q:X=""  Q:X'?1.E1"-"1.E
 S %C=55,x=X W:'$d(qt) @ZAA02GP,ZAA02G("LO"),"from FIELD: ",ZAA02G("HI") S %C=66,X="" X ^ZAA02GREAD Q:X=""  I $D(^ZAA02GDISP($P(x,"-"),$P(x,"-",2),X)) S x=^(X),$P(x,"`",11)=C,$P(x,"`",3)=$P(ST,"`",3),ST=x
 K x D ERASE Q
 Q
