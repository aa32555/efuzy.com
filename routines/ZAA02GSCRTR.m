ZAA02GSCRTR ;PG&A,ZAA02G-SCRIPT,2.10,SELECT A TRANSCRIPT;31OCT94  13:35;;;Fri, 18 Mar 2016  16:45
 ;Copyright (C) 1992, Patterson, Gray & Associates, Inc.
BEG S:'$D(TOP) TOP=3 S %R=TOP,%C=1 W @ZAA02GP,ZAA02G("HI"),ZAA02G("CS") L
R4 S DX="AY",(DOC,CC)="",%R=TOP,%C=4,MM=""
 S YY=$S($D(YX):YX,$G(@ZAA02GSCR@("PARAM","TR"))]"":^("TR"),1:"Job#,7\Patient,10\Acc #,7\PV,3\Refr,6\Proc1,5\Proc2,5\  DOS,8,/\Typed,5,/\Time,5,:\SC,2\TR#,3\St,4")
 W @ZAA02GP,ZAA02G("LO") S %C=1 F I=1:1:13 S Y=$P(YY,"\",I),ll(I)=$P(Y,",",2) W @ZAA02GP,$P(Y,",") S %C=%C+$P(Y,",",2)+1,MM=MM_$E($TR("--/--/------------------------","/",$P(Y,",",3)_"-"),1,$P(Y,",",2))_" "
 S to=$S($G(Timeout):Timeout,1:300) S:'$D(SDIR) SDIR="@ZAA02GSCR@(""DIR"",99)" I $D(OFP) D FP
 I $D(FDOC) S %R=20 G 6
R5 K PAGE,IN S %C=1,%R=TOP+1 W @ZAA02GP,$S($D(OC):$E($TR(M,"`"," "),1,79),1:MM)
 I $D(OC) S %R=TOP+2 W @ZAA02GP,"wait...(press SPACE BAR to cancel search) "
 D FT
TOP S I="",PP=0,NE=3-TOP+16
LEV S CN=0,%C=1,%R=TOP+2,Y=ZAA02G("CL") K IA W @ZAA02GP,ZAA02G("HI") S AB="R CC:0 I CC="" "" S (I"_$S($G(FP)]"":",FP",1:"")_")="""""
LEV1 I $G(FP)="" S (II,I)=$O(@SRC@(I),$G(DIRE,1)) X AB G FK:I="" X E G:'$T LEV1 S CN=CN+1,IA(CN)=II I CN=1,'$D(PAGE(PP)) S PAGE(PP)=I
LEV2 I $G(FP)]"" S:I="" FP=$O(@SRC) X AB G:I="" FK:FP="",FK:FP]EP S (II,I)=$O(@SRC@(I)) G LEV2:I="" X E G:'$T LEV2 S CN=CN+1,IA(CN)=II,IB(CN)=FP I CN=1,'$D(PAGE(PP)) S PAGE(PP)=FP_","_I
 G LEV3:'$D(@SDIR@(II)) I $D(FIND) S:$S($G(FP)]"":$P(FIND,",",3)](FP_I),1:$P(FIND,",",3)>I) $P(FIND,",")=CN+1 I $P($G(FIND),",",2)>PP G LEV1:CN<NE S PP=PP+1 G LEV
 S j=^(II) X:$D(YXL) YXL
 W Y,$S($D(INX(II)):ZAA02G("UO")_$$LEV4(j)_ZAA02G("UF")_ZAA02G("HI"),1:$$LEV4(j)),! G LEV1:CN<NE S CN=NE+1 S:$O(@SRC@(I),$G(DIRE,1))="" CN=$S($G(FP)="":NE,$O(@SRC)="":NE,$O(@SRC)]EP:NE,1:CN) G FK
LEV3 K IA(CN),IB(CN) S CN=CN-1 G LEV1
LEV4(X) F m=2,3,6,7 I $L($P(X,"`",m))'=ll(m) S $P(X,"`",m)=$E($P(X,"`",m)_"                            ",1,ll(m))
 Q $E($TR($P(X,"`",1,13),"`~","  "),1,79)
 ;
ASK S J=1,%C=1,N=CN S:CN-1=NE N=NE X ZAA02G("ECHO-OFF") I $G(FIND) S J=+FIND  S:'$D(IA(J)) J=1 K FIND
A3 S X=$D(@SDIR@(0)) G A1
A0 S j=^(II) X:$D(YXL) YXL
 W @ZAA02GP,$S($D(INX(II)):ZAA02G("UO")_$$LEV4(j)_ZAA02G("UF")_ZAA02G("HI"),1:$$LEV4(j))
A1 S %R=TOP+J+1,II=IA(J) I $D(CCT) S C=CC K CCT G A4:C'="",A5
 D @DX R C#1:to G:'$T TO I C'="" G A4
A5 X ZAA02G("T") S C=$E(XX,$F(XX,ZF)) R CC#1:0 S:$T CCT=J#2 I C'="",$T(@C)'="" G @C
 W *7 G A1
A4 S:C?1L C=$C($A(C)-32) G @$S(C=" ":"B",C="E":"E",C="N":"O",C="P":"P",C="F":6,C="S":7,C="I":"G",C="X":"X",C'?1N:"ERR",1:"SEL")
AY W @ZAA02GP,ZAA02G("RON") S j=^(II) X:$D(YXL) YXL W $$LEV4(j),ZAA02G("ROF") Q
 ;
A S J=$S(J>1:J-1,1:N) G A0
G G:'$D(INX) A0 X $S($D(INX(II)):"K INX(II)",1:"S INX(II)=1")
B S J=$S(J<N:J+1,1:1) G A0
O G:CN-1'=NE ERR S PP=PP+1 G LEV
P I PP S PP=PP-1,I=PAGE(PP) S:I["," FP=$P(I,","),I=$P(I,",",2) S I=I-1 S:$G(DIRE)<0 I=I+2 G LEV
 G A1
Q I PP G TOP
 G A1
 ;
Y G HLP^ZAA02GSCRTR2
X D:$G(TRANS)["mp" EDITCTR^ZAA02GSCRTR2 G A1
TO S Timeout=$g(Timeout)_",Y"
E K OFP,FIND G EXIT
 ;
ERR W *7 G A1
CLEAR S %R=TOP+2,%C=1 W @ZAA02GP,ZAA02G("LO"),ZAA02G("CS") Q
 ;
FK I CN<1 W ZAA02G("CS") S CC=$S(CC=" ":"Search Canceled",1:"No Entries Found - Check Criteria"),%C=80-$L(CC)\2,%R=TOP+4 W @ZAA02GP,CC R CC:2 K FP,EP G EXIT:'$D(OFP),6
 F %R=CN+TOP+2:1:21,24 W @ZAA02GP,Y
 S L=$S('$D(ZAA02G(9)):"Function Keys\EXIT  SELECT  FIND  OTHER  \INSERT_CHAR  \NEXT  \PREVIOUS  FIRST",1:@ZAA02G(9)@(29))
 I CC=" " S %R=21,%C=30 W @ZAA02GP,ZAA02G("RON"),"Search Canceled",ZAA02G("ROF")
 S A="["_$P(L,"\")_": "_ZAA02G("HI")_$P(L,"\",2)_$S($D(INX):$P(L,"\",3),1:"")_$S(CN-1=NE:$P(L,"\",4),1:"")_$S(PP:$P(L,"\",5),1:"")_ZAA02G("LO")_" ]"
 S %R=24,%C=($L(ZAA02G("HI"))*2+80-$L(A)\2) W @ZAA02GP,ZAA02G("LO"),*13,Y,@ZAA02GP,A,ZAA02G("HI") G ASK
 ;
CL D CLEAR G TOP
1 S FIND=J D PRNT^ZAA02GSCRTR2 S PP=PP+1 G P
FP S FP=$P(OFP,$C(1)),SRC=$P(OFP,$C(1),2),EP=$P(OFP,$C(1),3),E=$P(OFP,$C(1),4),M=$P(OFP,$C(1),5),OC=$P(OFP,$C(1),6) Q
SEL S:C C=10-C
SEL1 F I=J+1:1:N I IA(I)[C,$E(IA(I),$L(IA(I)))=C S J=I G A0
 I J<1 S J=1 G A1
 S J=0 G SEL1
 ;
F ;
FOUND S DOC=OF*IA(J)+OF1,FIND=","_PP_","_$G(IB(J))_IA(J)
 I $D(@ZAA02GSCR@("TRANS",DOC))<11 D ARCH^ZAA02GSCRAT G R4:DOC="",R4:'$D(@ZAA02GSCR@("TRANS",DOC))
 S X=^(DOC) I $P(ZAA02GSCRP,";",3)'=1,"U"'[$P(^(DOC,.011),"`",21) D PROTGEN^ZAA02GSCRVW G:DOC="" R4
 I $G(TRANS)]"",$P(X,"`",13)["H",$G(@ZAA02GSCR@("PARAM","SECURE",$P($P(X,"`",12),"~"))),$G(TRANS)'=$P($P(X,"`",12),"~") G BUSY2
 G:$D(COPY) EXIT L @ZAA02GSCR@("TRANS",DOC):0 G:'$T BUSY
 I '$D(TRANS) L  I $P(X,"`",13)["H" G BUSY
 I $D(^ZAA02GSCR("LOCK",+$H,DOC)) S B=^(DOC) G BUSY
EXIT I $D(M),+M K OFP
 K A,AB,I,II,TOP,NE,CN,IA,IB,PAGE,PP,TJ,OC,L,II,OF,OF1,FP,EP,E,l,u,SM,M,MM,CC,CCT,DX,SDIR,YX,XE,to K:$G(DOC)="" OFP X ZAA02G("ECHO-ON") Q
BUSY S %C=1,%R=TOP,Y="18,10\RL\1\\\Transcript is currently being edited.*,*,*,Return to lookup,Enter document anyway" W @ZAA02GP,ZAA02G("CS") D POP G R4:Y=4,EXIT
BUSY2 S %C=1,%R=TOP,Y="18,10\RL\1\\\Transcript is on hold with restricted access" W @ZAA02GP,ZAA02G("CS") D POP G R4
POP N (ZAA02G,ZAA02GP,Y) D ^ZAA02GPOP S Y=X Q
ACCT S SRC="^ZAA02GACT(ID,""TRANS"")",E="S II=10000000-I I 1",OF=-1,OF1=10000000,EP="zzzzz" G BEG
ALL S SRC="""DIR"",99)" G ALT
RV S SRC="""DIR"",12,""R"")" G ALT ;11
MAMMOOLD S SRC="""DIR"",12,TSU)",XE="S:E'["",12,"" E=E_""I $D(@ZAA02GSCR@(""""DIR"""",12,""""M"""",II))""" G ALT
MAMMO S SRC="@ZAA02GSCM@(""EXAM"")",E="S II=10000000-I I 1",OF=-1,OF1=10000000,EP="zzzzz",DIRE=-1 G BEG
UL S SRC="""DL"",1)" G ALT
INC S SRC="""DIR"",12,""I"")" G ALT
HOLD S SRC="""DIR"",12,""H"")" G ALT
PV S SRC="""DIR"",4,PRV)" G ALT
MR S SRC="""DIR"",3,MR)" G ALT
TR S SRC="""DIR"",11,TR)",TR=$TR(TRANS,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ") ;10
ALT K DIRE S SRC="@ZAA02GSCR@("_SRC,E="I 1",OF=-1,OF1=10000000,EP="zzzzz" G BEG
7 S DX="A"_$E($S($D(AUT):"YSYYYYYYY",1:"YXZFUESY"),$F("YXZFUESY",$E($G(DX),2)))_"^ZAA02GSCRTR1" S:DX["AY" DX="AY" G A3
6 K FIND G ^ZAA02GSCRTR1
 ;
FT S Y=$S('$D(ZAA02G(9)):"Type\Number\or use\ARROWS\to move selector - \RETURN\to make selection\",1:@ZAA02G(9)@(28))
 S %R=22,%C=80-$L($P(Y,"\",1,7))\2 W @ZAA02GP,ZAA02G("LO"),$P(Y,"\"),ZAA02G("HI")," ",$P(Y,"\",2)," ",ZAA02G("LO"),$P(Y,"\",3),ZAA02G("HI")," ",$P(Y,"\",4)," ",ZAA02G("LO"),$P(Y,"\",5)," ",ZAA02G("HI"),$P(Y,"\",6)," ",ZAA02G("LO"),$P(Y,"\",7) Q
