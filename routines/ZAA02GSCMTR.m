ZAA02GSCMTR ;PG&A,ZAA02G-MTS,1.20,SELECT A LETTER;31OCT94  13:35;;;26OCT2006  10:30
 ;Copyright (C) 1995, Patterson, Gray & Associates, Inc.
BEG S:'$D(TOP) TOP=3 K INX S %R=TOP,%C=1 W @ZAA02GP,ZAA02G("HI"),ZAA02G("CS") L
R4 S DX="AY",(DOC,CC)="",%R=TOP,%C=4,MM="",YY=$S($D(YX):YX,$G(@ZAA02GSCM@("PARAM","TR"))]"":^("TR"),1:"  Send,8,/\    Patient,15\ Acc #,11\Prov,4\ Refr,6\Procedr,7\  Exam,8,/\Site,4\Assess,6\")
 I $D(FLUP) S $P(YY,"\")=" Notes,8",$P(YY,"\",8,9)=" FLUP Recomm,13"
 W @ZAA02GP,ZAA02G("LO") S %C=1 F I=1:1:12 S Y=$P(YY,"\",I) W @ZAA02GP,$P(Y,",") S %C=%C+$P(Y,",",2)+1,MM=MM_$E($TR("--/--/------------------------","/",$P(Y,",",3)_"-"),1,$P(Y,",",2))_" "
 S:'$D(SDIR) SDIR="@ZAA02GSCM@(""LETMR"")" I $D(OFP) D FP
 I $D(FDOC) S %R=20 G 6
R5 K PAGE,IN S %C=1,%R=TOP+1 W @ZAA02GP,$S($D(OC):$TR(M,"`"," "),1:MM)
 I $D(OC) S %R=TOP+2 W @ZAA02GP,"wait...(press SPACE BAR to cancel search) "
 S Y=$S('$D(ZAA02G(9)):"Use\ARROWS\to move selector - \RETURN\to make selection\",1:@ZAA02G(9)@(28))
 S L=$S('$D(ZAA02G(9)):"Function Keys\EXIT  SELECT  FIND  INSERT_CHAR  \NEXT  \PREVIOUS  FIRST",1:@ZAA02G(9)@(29))
 S %R=22,%C=80-$L($P(Y,"\",1,7))\2 W @ZAA02GP,ZAA02G("LO"),$P(Y,"\"),ZAA02G("HI")," ",$P(Y,"\",2)," ",ZAA02G("LO"),$P(Y,"\",3),ZAA02G("HI")," ",$P(Y,"\",4)," ",ZAA02G("LO"),$P(Y,"\",5)," ",ZAA02G("HI"),$P(Y,"\",6)," ",ZAA02G("LO"),$P(Y,"\",7)
TOP S I="",PP=0,NE=3-TOP+16
LEV S CN=0,%C=1,%R=TOP+2,Y=ZAA02G("CL") K IA,IC,iD W @ZAA02GP,ZAA02G("HI") S AB="R CC:0 I CC="" "" S (I"_$S($D(FP):",FP",1:"")_")="""""
LEV2 S:I="" FP=$O(@SRC) X AB G:I="" FK:FP="",FK:FP>EP
 S I=$O(@SRC@(I)) G LEV2:I="" S II=^(I) G:'$D(@SDIR@(I,+II)) LEV2 I $D(SC),'$D(SC("All")),'$D(SC($P(II,",",3))) G LEV2
 S CN=CN+1,II=+II,IA(CN)=I_","_II_","_FP I CN=1,'$D(PAGE(PP)) S PAGE(PP)=FP_","_I
 I '$D(FLUP) S D=19000000+FP,IC(CN)=$E(D,5,6)_"/"_$E(D,7,8)_"/"_$E(D,3,4),D=IC(CN)_$G(@SDIR@(I,II)) G LEV3
 S IC(CN)="" I $O(@ZAA02GSCM@("LETHIST",I,FP,"")) F J=1:1:8 S IC(CN)=IC(CN)_$TR($D(^(J))>0*J,123456780,"12345678 ")
 S REC=$P(@SRC@(I),",",2) I REC S REC=$G(@ZAA02GSCM@("EXAM",REC)) S:REC="" CN=CN-1 G:REC="" LEV2 S J=1 F  S J=$F(REC,";RC",J) Q:J<1  S iD($E(REC,J)_" ")=""
 S IC(CN)=$E(IC(CN)_"        ",1,8),J=$O(iD("")),IE(CN)=$$FL(J) K iD(J)
 S D=IC(CN)_$G(@SDIR@(I,II)) S:$D(IE(CN)) $P(D,"`",8,9)=IE(CN)
LEV3 X E I '$T G:$D(iD) LEV41 S CN=CN-1 G LEV2
 I $D(FIND) S:$S($D(FP):$P(FIND,",",3)](FP_I),1:$P(FIND,",",3)>I) $P(FIND,",")=CN+1 I $P($G(FIND),",",2)>PP G LEV2:CN<NE S PP=PP+1 G LEV
LEV5 W Y,$S($D(INX(FP,I)):ZAA02G("LO")_$TR(D,"`~","  ")_ZAA02G("HI"),1:$TR(D,"`~","  ")),! I CN<NE G LEV2:'$D(iD) S CN=CN+1 G LEV4
 S CN=NE+1 S:$O(@SRC@(I))="" CN=$S('$D(FP):NE,$O(@SRC)="":NE,$O(@SRC)]EP:NE,1:CN) G FK
LEV4 S D="       `       ""       `  ""  ~     `    `      `       `         `"
LEV41 S J=$O(iD("")),$P(D,"`",8)=$$FL(J) K iD(J) G LEV3
FL(J) N x S x=$P(",Cyst Aspir,Addntl Proj,Magnif.,Normal,Decision/Bx,Excis. Bx,Clin Correl,Ultrasound,FLUP,Biopsy,Core Biopsy,Histology,Take Action,Cytologic Anal,U/S FNA,Old Films,Stereo,Spot,U/S Core Bx",",",$F("APMNDECUFBLHTYSORGJ",$E(J)))
 I x="FLUP" S x=x_"("_$$DTX(+$P(REC,"RCF,",2))_")"
 Q:x]"" x  S x=$P(",MRI,Galactogram,Addntl Views",",",$F("mIi",$E(J)))
 Q:x]"" x  Q "RC"_$E(J)
 ;
DTX(X) N M S M=$P(REC,";",2) S M=X*100+M S:M#10000>1299 M=M+10000-1200
 Q M\100#100_"\"_(M#100)_"\"_$E(M\10000#100+100,2,3)
 ;
ASK S J=1,%C=1,N=CN S:CN-1=NE N=NE X ZAA02G("ECHO-OFF") I $G(FIND) S J=+FIND  S:'$D(IA(J)) J=1 K FIND
A3 S X=$D(@SDIR@(0)) G A1
A0 D AD W @ZAA02GP,$S($D(INX(OJ3,OJ)):ZAA02G("LO")_$TR(D,"`~","  ")_ZAA02G("HI"),1:$TR(D,"`~","  "))
A1 S %R=TOP+J+1,OJ=$P(IA(J),","),OJ3=$P(IA(J),",",3),OJ2=$P(IA(J),",",2),LJ=J I $D(CCT) S C=CC K CCT G A4:C'="",A5
 D @DX R C#1 I C'="" G A4
A5 X ZAA02G("T") S C=$E(XX,$F(XX,ZF)) R CC#1:0 S:$T CCT=J#2 I C'="",$T(@C)'="" G @C
 W *7 G A1
A4 G @$S(C=" ":"B",C="E":"E",C="N":"O",C="P":"P",C="F":6,C="S":7,C="I":"G",C="X":"X",C'?1N:"ERR",1:"SEL")
AY D AD W @ZAA02GP,ZAA02G("RON"),$TR(D,"`~","  "),ZAA02G("ROF") Q
AD S D=IC(LJ)_$G(@SDIR@(OJ,OJ2)) S:$D(IE(LJ)) $P(D,"`",8,9)=IE(LJ) Q
 ;
A S J=$S(J>1:J-1,1:N) G A0:$D(IA(J)),A
G X $S($D(INX(OJ3,OJ)):"K INX(OJ3,OJ)",1:"S INX(OJ3,OJ)=1")
B S J=$S(J<N:J+1,1:1) G A0:$D(IA(J)),B
O G:CN-1'=NE ERR S PP=PP+1 G LEV
P I PP S PP=PP-1,I=PAGE(PP) S:I["," FP=$P(I,","),I=$P(I,",",2) S I=I-1 G LEV
 G A1
Q I PP G TOP
 G A1
 ;
X I $D(^ZAA02GFAXS) D ZAA02GSCM^VD S C=$D(@SDIR@(0)) G A1
E K OFP,FIND G EXIT
 ;
ERR W *7 G A1
CLEAR S %R=TOP+2,%C=1 W @ZAA02GP,ZAA02G("LO"),ZAA02G("CS") Q
 ;
FK I CN<1 W ZAA02G("CS") S CC=$S(CC=" ":"Search Canceled",1:"No Entries Found - Check Criteria"),%C=80-$L(CC)\2,%R=TOP+4 W @ZAA02GP,CC R CC:2 K FP G EXIT:'$D(OFP),6
 F %R=CN+TOP+2:1:21,24 W @ZAA02GP,Y
 I CC=" " S %R=21,%C=30 W @ZAA02GP,ZAA02G("RON"),"Search Canceled",ZAA02G("ROF")
 S A="["_$P(L,"\")_": "_ZAA02G("HI")_$P(L,"\",2)_$S(CN-1=NE:$P(L,"\",3),1:"")_$S(PP:$P(L,"\",4),1:"")_ZAA02G("LO")_" ]"
 S %R=24,%C=($L(ZAA02G("HI"))*2+80-$L(A)\2) W @ZAA02GP,ZAA02G("LO"),*13,Y,@ZAA02GP,A,ZAA02G("HI") G ASK
 ;
Y D STATUS2^ZAA02GSCMU S PP=PP+1 G P
 G ERR S HP=8 D Y^ZAA02GSCMHP D CLEAR K IA G TOP
FP S FP=$P(OFP,$C(1)),SRC=$P(OFP,$C(1),2),EP=$P(OFP,$C(1),3),E=$P(OFP,$C(1),4),M=$P(OFP,$C(1),5),OC=$P(OFP,$C(1),6) K:FP="" FP Q
SEL S E="I $D(@SDIR@(I,FP,"_C_"))" K IA,IC S FP="" G TOP
 ;
F ;
FOUND ;S DOC=OF*IA(J)+OF1,FIND=","_PP_","_IA(J)
EXIT I $D(M),+M K OFP
 K A,AB,I,II,TOP,NE,CN,IA,IB,PAGE,PP,TJ,OC,iD,L,OJ,OJ2,OJ3,OF,OF1,FP,FPMR,IE,LJ,EP,E,l,u,SM,M,MM,CC,CCT,DX,SDIR,YX,INX K:$G(DOC)="" OFP X ZAA02G("ECHO-ON") Q
7 D PRINT^ZAA02GSCML:'$D(FLUP),NOTES^ZAA02GSCMU:$D(FLUP) S PP=PP+1 K INX G P
6 K FIND G ^ZAA02GSCMTR1
