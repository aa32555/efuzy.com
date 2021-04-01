ZAA02GSCRVW1 ;PG&A,ZAA02G-SCRIPT,2.10,ZAA02G-VIEW - PART 2;07NOV94  21:24;19MAR2002  22:29;;Tue, 28 Jan 2014  16:34
C ;Copyright (C) 1991, Patterson, Gray & Associates, Inc.
 ;
AUTH S (A,I)="" I $D(@ZAA02GSCR@("TRANS",DOC,.011,"eS")) S A=^("eS")
 S Y=$O(@ZAA02GSCR@("TRANS",DOC,.02)) I Y F  S Y=$O(^(Y)) Q:Y=""  I $G(^(Y))["???" S I=1 Q
 K Y,B S R="",X=2,S=0,Y(1)="*"
 S G="D=$S(K=""ALL"":K,1:$P($G(@ZAA02GSCR@(""PROV"",K)),""\"",3))"
 F L=2,3 S B=$P(A,"\",L) F J=1:1:$L(B,",") S K=$P(B,",",J) I K]"",'$D(B(K)) S:K=AUT R=L_","_J S:K'["*" S=S+1 S @G,Y(X)=$J("",6)_$S(X=2:"Signers: ",1:$J("",9))_D_"*" S:K["*" Y(X)=Y(X)_$J("",50-$L(Y(X)))_"Signed" S B($P(K,"*"))="",X=X+1
 S Y="15,8\DVYRL\1\Authentication Options\\",Y(0)="\EX",Y(X)="*"_B,X=X+3 I I S Y(X-2)="MISSING INFORMATION - Cannot Authenticate report*"
 E  S Y(X-2)="Authenticate report"_$S("SY"[$E(A):"",1:"*")
 S Y(X-1)="Mark report incomplete - return with note(s)"
 I $P(R,",",2)>1 S:S>1 Y(X)="Override other signatures - release for distribution",X=X+1
 I $P(ZAA02GSCRP,";",3)=2,$G(DUZC)]"",$P($G(@ZAA02GSCR@("PROV",DUZC)),"\",13)="Y" S Y(X)="Edit Report - then sign and release",X=X+1
 I $P(ZAA02GSCRP,";",3)=4 S Y(X)="Print Report - indicate changes on hardcopy",X=X+1
 S Y(X)="Return to Queue without authenticating" D ^ZAA02GPOP S:X[";EX" X="" S X=$E(X)
 I X="M" D INC,INCE G AUTX
 I X="E" D AUEDIT S S=1 D AUTS G AUTX
 I X="O" S S=1 D AUTS G AUTX
 I X="P" D INC G PRINT^ZAA02GSCRVW
 I X="A" D AUTS
AUTX D HEAD^ZAA02GSCRVW G DIS^ZAA02GSCRVW
AUEDIT N R,S S INQ="X",ZAA02GWPD=ZAA02GWPB,TL=TOPP+2 D DIS1^ZAA02GSCRVW Q
AUTS S A=$G(@ZAA02GSCR@("TRANS",DOC,.011,"eS")) S:$P(R,",")<2 $P(R,",")=2 S:$P(R,",",2)<1 $P(R,",",2)=1
 S B=$P(A,"\",+R) I $G(DUZC)]"" S:B="ALL" B=DUZC S:$G(@ZAA02GSCR@("PARAM","PROXY SIGN")) B=DUZC
 S:B="" B=AUT
 S $P(B,",",$P(R,",",2))=$P(B,",",$P(R,",",2))_"*"_$TR($H,",","-"),$P(A,"\",+R)=B
 I S=1 S $P(A,"\",4)=$H_","_$P(A,"\",4)
 S $P(A,"\")=$E("SPPPP",S),@ZAA02GSCR@("TRANS",DOC,.011,"eS")=A,INP("eS")=A
 S B="" F  S B=$O(@ZAA02GSCR@("DIR",48,B)) Q:B=""  K ^(B,-(10000000-DOC))
 I S>1,+R=2,$P(A,"\",3)]"",$P(A,"\",3)'["*",ZAA02GSCRP'["a" S @ZAA02GSCR@("DIR",48,$P(A,"\",3),-(10000000-DOC))=""
 S K=$P(@ZAA02GSCR@("TRANS",DOC),"`",13),K1=$P(^(DOC),"`",14),K=$E($S(S=1:$TR(K,"E~ "),1:$TR(K,"~"))_"~   ",1,4)_"`"_$TR($P(^(DOC),"`",14),"SA")_"A"
 S $P(^(DOC),"`",13,14)=K,$P(@ZAA02GSCR@("DIR",99,10000000-DOC),"`",13,14)=K
 I S=1 D PRAUT
 Q
PRAUT S DV="" X:$G(@ZAA02GSCR@("PARAM","ES-PRINTER"))]"" ^("ES-PRINTER")
 S TRANS=$P($G(@ZAA02GSCR@("TRANS",DOC,.011)),"`",5)
 I DV="" S DISTR=$P($G(@ZAA02GSCR@("TRANS",DOC,.011)),"`",15),P=1 D PR^ZAA02GSCRSP Q:DV=""
 S INP("JUST-SIGNED")=1 D PR00^ZAA02GSCRER2 K INP("JUST-SIGNED") Q
 ;
INC D DATE^ZAA02GSCRER
 S A=$G(@ZAA02GSCR@("TRANS",DOC,.011,"eS"))
 F L=2,3 S B=$P(A,"\",L) F J=1:1:$L(B,",") S K=$P(B,",",J) I K]"" K @ZAA02GSCR@("DIR",48,K,-(10000000-DOC))
 S K=$E($TR($P(@ZAA02GSCR@("TRANS",DOC),"`",13),"IEP~ ")_"I~  ",1,4),$P(^(DOC),"`",13)=K,$P(@ZAA02GSCR@("DIR",99,10000000-DOC),"`",13)=K
 S @ZAA02GSCR@("DIR",12,"I",10000000-DOC)="",@ZAA02GSCR@("TRANS",DOC,.011,"INCOMP")=$S($G(X)["ESINCAUD":"New Audio",1:"Set")_" by "_$G(USER)_" "_DT_" "_TM  Q
INCE S INQ="R",ZAA02GWPD=ZAA02GWPB,TL=TOPP+2 D DIS1^ZAA02GSCRVW S X="" K INQ S ZAA02GWPD=ZAA02GWPB D INSRT Q
 ;
INSRT K A Q:'$D(@ZAA02GWPD@(.0161))  S A="" F  S A=$O(@ZAA02GWPD@(.0161,A)) Q:A=""  S A(-A)=""
 F  S A=$O(A(A)) Q:A=""  D INSRT1
 K @ZAA02GWPD@(.0161) Q
INSRT1 S B=.03 F J=1:1:-A S B=$O(@ZAA02GWPD@(B)) Q:B=""
 Q:B=""  S C=$O(^(B)) S:C="" C=B+10 S C=$J(C-B/14,0,6),@ZAA02GWPD@(B+C)=B_$C(1,1,1),B=B+C
 F J=1:1:10 I $D(@ZAA02GWPD@(.0161,-A,J)) S @ZAA02GWPD@(B+C)=B_$C(1,1,1)_"    *** CHANGE NOTE "_J_". "_$P(^(J),"|"),B=B+C
 S @ZAA02GWPD@(B+C)=B_$C(1,1,1),B=B+C,C=$O(@ZAA02GWPD@(B)) Q:C=""  S $P(@ZAA02GWPD@(C),$C(1))=B Q
 ;
 ;
 ; COPIED FROM ZAA02GSCRER3 - NOT USED
ADD G:$D(MOD) ADDEND S ODOC=DOC,OSET="" D ADDSET K INQ D SET^ZAA02GSCRER1
 F A=.01,.03,.015 S @ZAA02GWPD@(A)=$G(@ZAA02GSCR@("TRANS",ODOC,A))
 S @ZAA02GSCR@("TRANS",ODOC,.011,"LOCKED")="ADDEND,"_DOC_","_$H,@ZAA02GSCR@("TRANS",DOC,.011,"LOCKED")="ADDENDUM TO ,"_ODOC_","_$H,@ZAA02GSCR@("PARAM","ADDEND",DOC)=ODOC
 S C=0,REP="ADDENDUM1",REPD=ZAA02GSCR_"(110)" I $D(@REPD@(REP)) D CP^ZAA02GSCRER1
 S A=.03,GET="B=^(A)",B=$O(@ZAA02GSCR@("TRANS",ODOC,.03)) I B S:^(B)[$C(1) GET="B=$P(^(A),$C(1),4)" F J=1:1 S A=$O(@ZAA02GSCR@("TRANS",ODOC,A)) Q:A=""  S @GET,C=C+100,@ZAA02GWPD@(C)=C-100_$C(1,1,1)_B
 S REP="ADDENDUM2",REPD=ZAA02GSCR_"(110)" I $D(@REPD@(REP)) D CP^ZAA02GSCRER1
 K GET S @ZAA02GWPD@(.0162)=C
 S A=.03,C="" F  S A=$O(^(A)) Q:A=""  I $P(^(A),$C(1),4)="*" S C=A
 I C S @ZAA02GWPD@(.0162)=C_","_$O(^(C))
ADDEND D ADDSET,FETCH^ZAA02GSCRER S REP=INP("TEMPLATE") D TOP^ZAA02GSCRER,NEW^ZAA02GSCRER1,ADDEDIT K MOD S ZAA02G("MENU")=0 G MNU^ZAA02GSCRER
ADDEDIT N DT,ED I $D(@ZAA02GWPD@(.0162)) S C=^(.0162),A=+$G(^(C)),C=$P(C,",",2) I A F  K ^(A) S A=$O(^(A)) Q:A=""  Q:A=C
 I A S $P(^(A),$C(1))=C
 S TL=3,BL=22,WO="",MG=$S($D(@ZAA02GWPD@(.01)):^(.01),1:76),NM=DOC,ZAA02GWPOPT="NC,AT,OT1,2,3,4,5,6,8,9,10,14,15,16,18,INNX,",HLPR="^ZAA02GSCRH",W=1 D ENTRY^ZAA02GWPV6,ADDSET
 S E="" I $D(@ZAA02GWPD@(.0162)) S C=^(.0162),E=$P(C,",",2)
 E  S B=$O(@ZAA02GWPD@(.03)) F  S D=B,B=$O(^(B)) Q:B=""
 S (A,B)="" F J=.001:.001 S B=$O(@ZAA02GWPD@(.0162,B)) Q:B=""  S @ZAA02GWPD@(C+J)=C_$C(1,1,1),C=C+J F J=J+.001:.001 S A=$O(@ZAA02GWPD@(.0162,B,A)) Q:A=""  S @ZAA02GWPD@(C+J)=C_$C(1,1,1)_^(A),C=D+J
 S A=$O(@ZAA02GWPD@(C)) Q:A=""  S $P(^(A),$C(1))=C-.001
 Q
ADDSET S ZAA02GWPD="@ZAA02GSCR@(DIR,DOC)",DIR="TRANS" Q
 ;
