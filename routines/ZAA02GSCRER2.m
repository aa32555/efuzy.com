ZAA02GSCRER2 ;PG&A,ZAA02G-SCRIPT,2.10,ADD/EDIT REPORT - ADS 2;18NOV94  01:35;03JUL2002  17:21;;Tue, 09 DeC 2014  14:23
 ;Copyright (C) 1992, Patterson, Gray & Associates, Inc.
REPORT D HEAD^ZAA02GSCRER S %C=26,%R=1 W @ZAA02GP,ZAA02G("HI"),"P R O D U C T I O N    S T A T S" S LF=$P(@ZAA02GSCR@("PARAM","BASIC"),"|",4),%R=5,%C=38 W !!,ZAA02G("CS"),@ZAA02GP,TRANS S %R=8,%C=26 W @ZAA02GP,ZAA02G("LO"),"Lines      # Reports      Minutes   Lines/Hour"
 S TIME=TIME+$P(OCOUNT,",",7)
 S %R=12,%C=1,R=1,@("C="_LF),R=$P(OCOUNT,",",6) W @ZAA02GP,ZAA02G("LO"),"Total for Transcript",ZAA02G("HI"),$J(C,9,0),$J(R,12),$J(TIME*.1,15,1),$J(C/('TIME+TIME*.1)*60,12,1)
 F J=1:1:7 S @$E("CLWBSRT",J)=$P(DCOUNT,",",J)
 S %R=10,%C=4,@("C="_LF) W @ZAA02GP,ZAA02G("LO"),"Changes this Edit",ZAA02G("HI"),$J(C,9,0),$J(R,12),$J(T*.1,15,1),$J(C/('T+T*.1)*60,12,1)
 K SC S SC="" F J=1:1 S SC=$O(@ZAA02GSCR@("STATS",YM,SC)) Q:SC=""  S SC(SC)=""
 S (C,L,W,B,S,R,T,SC)=0 F J=1:1 S SC=$O(SC(SC)) Q:SC=""  I $D(@ZAA02GSCR@("STATS",YM,SC,"TR",$TR(TRANS,LC,UP),"TOTAL",1)) F J=1:1:7 S @($E("CLWBSRT",J)_"="_$E("CLWBSRT",J)_"+"_(+$P(^(J),"+",DY)))
 S %R=14,%C=10,@("C="_LF) W @ZAA02GP,ZAA02G("LO"),"Total Today",ZAA02G("HI"),$J(C,9),$J(R,12),$J(T*.1,15,1),$J(C/('T+T*.1)*60,12,1)
 S (C,L,W,B,S,R,T,SC)=0 F J=1:1 S SC=$O(SC(SC)) Q:SC=""  I $D(@ZAA02GSCR@("STATS",YM,SC,"TR",$TR(TRANS,LC,UP),"TOTAL",1)) F J=1:1:7 S @($E("CLWBSRT",J)_"="_$E("CLWBSRT",J)_"+"_^(J))
 S %R=16,%C=9,@("C="_LF) W @ZAA02GP,ZAA02G("LO"),"Month Totals",ZAA02G("HI"),$J(C,9),$J(R,12),$J(T*.1,15,1),$J(C/('T+T*.1)*60,12,1) S %R=20,%C=35 W @ZAA02GP,"Press RETURN " S EXE="R CCC K EXE"
 Q
 ;
FAX ; called from ID block to indicate PHONE & AUTOFAX in consult2
 N opi,ov,og,oi,sox,ols,tru S x="" I X]"" D FAXINFO S x=FON S:AF x=x_"   AUTOFAX",INP("FAX")=X I AF
 E  I $D(INP("FAX")) K INP("FAX") I $D(DOC),DOC,$D(@ZAA02GSCR@("TRANS",DOC,.011,"FAX")) K ^("FAX")
 S opi="PDSP;AUTOFAX;x" X op
 I 1 Q
FAXA ; called from ID block to indicate AUTOFAX in margin
 S x=$J("",9) K INP("FAX") I X]"" D FAXINFO  I $G(AF) S x="AUTOFAX",INP("FAX")=X
 W ! F j=1:1:10 W ZAA02G("LK")
 W x K AF Q
 ;
FAXB ; called from ID block to indicate AUTOFAX in AUTOFAX field - multiple faxes - uses ID & IDX
FXB N X,I S:'$D(IDX) IDX=1 S x="",X=ID,$P(INP("FAX"),"\",IDX)="" I X]"" D FAXINFO  I $G(AF) S $P(INP("FAX"),"\",IDX)=X
 S X=INP("FAX"),x=0 F I=1:1:$L(X,"\") I $L($P(X,"\",I))>0 S x=x+1
 S x=$S(x<1:"",x=1:"AUTOFAX",1:"AUTOFAX ("_x_")"),opi="PDSP;AUTOFAX;x" X op K AF,ID,IDX,x K:$G(INP("FAX"))?.P INP("FAX") I 1 Q
FAXINFO D FAXINFO^ZAA02GSCRFX Q
NOC S %R=3,%C=1 W @ZAA02GP,ZAA02G("CS") S %R=12,%C=26 W @ZAA02GP,"N O   C H A N G E S   M A D E" H 1 Q
 ;
PR S %R=1,%C=20 W @ZAA02GP,ZAA02G("HI"),"    P R I N T   T R A N S C R I P T       ",!!,ZAA02G("CS")
 K INP,INX S INX=1 D ALL^ZAA02GSCRTR I DOC="" K INX Q
 D PR0 G PR
PR0 D PRP Q:DV=""  I $D(INX)<2 D PR00 Q
 S INX="",SDISTR=$G(DISTR) F J=1:1 S DOC="",INX=$O(INX(INX)) Q:INX=""  S DOC=10000000-INX,DISTR=$G(SDISTR) D PR00:$D(@ZAA02GSCR@("TRANS",DOC)) K INP
 K SDISTR Q
PR00 D PR3 X:$D(EXE) EXE Q
PR1 D PRP Q:DV=""  G PR3
PRP S %R=24,%C=1 W @ZAA02GP,ZAA02G("CS") S P=1 D DEFDV^ZAA02GSCRSP I DV]"" K Y S Y="10,24\QHP3UD\*\\\Default Printer,Select Printer,Quit" D ^ZAA02GPOP S P=X I X=3 S DV="" Q
 D PR^ZAA02GSCRSP Q:DV=""  S %R=24,%C=1 W @ZAA02GP,ZAA02G("CL") S %C=30 W @ZAA02GP,"Queued to Print" H 1 Q
PR3 S DIR="TRANS",XF=$C(1),TIME=0 K INP D DATE^ZAA02GSCRER,FETCH^ZAA02GSCRER I +OCOUNT=0,$D(TRTYPE) S ZAA02GWPD="@ZAA02GSCR@(DIR,DOC)",XF=$C(1),TIME=0 D:'$D(LC) PRUP D STATS
PR2 S Y=$P(@ZAA02GSCR@("TRANS",DOC),"`",13)
 I Y["I",$G(@ZAA02GSCR@("TRANS",DOC,.011,"INCOMP"))["Never P" S Y=$TR(Y,"I") K @ZAA02GSCR@("DIR",12,"I",10000000-DOC)
 I $E($G(INP("eS")))="Y",$G(DISTR)'=" ",Y'["I" S T=INP("eS") F J=2   S M=$P(T,"\",J) F I=1:1:$L(M,",") S A=$P(M,",",I) I A]"",A'["*" S:ZAA02GSCRP["a" A="ALL" D
 . I $TR(Y,"HI")'=Y  K @ZAA02GSCR@("DIR",48,A,-(10000000-DOC)) Q
 . S Y=$TR(Y,"E")_"E",@ZAA02GSCR@("DIR",48,A,-(10000000-DOC))=""
 S Y=$E($TR(Y,"P~ ")_"P~ ",1,4),$P(@ZAA02GSCR@("TRANS",DOC),"`",13)=Y,$P(@ZAA02GSCR@("DIR",99,10000000-DOC),"`",13)=Y
 I '$D(@ZAA02GSCR@("TRANS",DOC,.011,"IO")) S ^("IO")=""
 I $G(DISTR)]"" S:$G(DISTR)="*" INP("DISTR")="*" I DISTR'="*" S INP("DIST")=DISTR
 D PRUP S INP("DIST")=$TR($G(INP("DIST")),LC,UP)
 K Y M Y=INP S Y("DOC")=DOC,Y("ZAA02GSCR")=ZAA02GSCR,DOC=ZAA02GSCR_"("""_DIR_""","""_DOC_""")",CP=2,Y("XECUTE")="D PRINT^ZAA02GSCRMS1"
 K:$G(PRINT)=1 Y("FAX")
 I DV="" D
 . I $G(DISTR)]"",$D(@ZAA02GSCR@("PARAM","DIST",DISTR)) S Y("DIST")=DISTR
 . I P=1,$D(@ZAA02GSCR@("PARAM","DIST",Y("DIST"))) S Y=$O(^(Y("DIST"),"")) I Y S DV=$P(^(Y),"\",2) Q:DV]""
 . I DV="",P=1,$D(@ZAA02GSCR@("PARAM","DEVICE")) X ^("DEVICE")
 . I DV="",P<3,$G(TRANS)]"" S DV=$P($P($G(@ZAA02GSCR@("PARAM","USER",TRANS)),"\",10,11),"\",P)
 . I DV="",P<3 S DV=$P($P(@ZAA02GSCR@("PARAM","BASIC"),"|",7,9),"|",P)
 . I DV="" S DV=1
 D QUEUER^ZAA02GSCRSP K Y,CP,PG,DOC Q
 Q
PRS D PR^ZAA02GSCRSP Q:DV=""  D STATS G PR2
PRUP S UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ",LC="abcdefghijklmnopqrstuvwxyz" Q
 ;
MAMMO G MAMMO^ZAA02GSCRER3
 ;
DELETE W $C(13),"Type YES to confirm deletion - ",*7 R A#3 I A]"",A="YES"!(A="yes") W "  REPORT DELETED  " D HEAD^ZAA02GSCRER D D1 H 1 Q
 S A=0 Q
D1 S OSET=@ZAA02GWPD,Y="" D DIR^ZAA02GSCRER1 I $D(@ZAA02GSCR@("TRANS",DOC,.011,"LOCKED")) S ODOC=+$P(^("LOCKED"),",",2) I ODOC,$D(@ZAA02GSCR@("TRANS",.011,ODOC,"LOCKED")) K ^("LOCKED"),ODOC
 K @ZAA02GSCR@("TRANS",DOC) I +OCOUNT S TIME=0 D STATS X:$D(EXE) EXE
 I $D(^ZAA02GSCMD) D DATABASE^ZAA02GSCM D
 . S TSU="" F  S TSU=$O(@ZAA02GSCMD@("ST",TSU)) Q:TSU=""  I $D(@ZAA02GSCM@("EXAM",DOC)) D DELETE^ZAA02GSCMR1
 S A=1 Q
 ;
STATS Q:$P(TRTYPE,"\",2)="N"  Q:$P(INP("WORK"),"\",2)="N"  I $D(@ZAA02GWPD) Q:$D(@ZAA02GWPD@(.011,"Restore"))
 S UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ",INPP="PROVIDER,SITEC,TR" I ZAA02GSCRP["q" S INPP=@ZAA02GSCR@("PARAM","INPP")
 S TY=$TR($G(INP("PROC1")),LC,UP),TY1=$TR(INP("SITEC"),LC,UP),TY3=1 S:TY="" TY="NA" S:TY1=""!(ZAA02GSCRP["S") TY1="NA" I ZAA02GSCRP'["x" S TY4=$TR($G(INP("PROC2")),LC,UP) S:TY4]"" TY3=2 ; add additional PROCx here
 I '$D(nocount) D COUNT S:$D(@ZAA02GWPD) @ZAA02GWPD@(.011,"STATS")=COUNT
 D STATS1,REPORT:ZAA02GSCRP["A" Q
STATS1 S A=$S($P(INP("WORK"),"\")]"":"-"_$P(INP("WORK"),"\"),1:"")
 D STATS3 I TY3>1 S TY=TY4 D STATS3
 S TY3=1,TY="TOTAL",TY2=TY1,I=3,M=$TR(INP("TR"),LC,UP) D STATS2 I $P(ZAA02GSCRP,";",3)=4 S TY2="NA",I=5,TY=$TR($G(INP("P1")),LC,UP) I TY]"" D STATS2
 I $P(ZAA02GSCRP,";",3)=2 S TY2="NA",I=5,TY=$TR($G(INP("P1")),LC,UP) I TY]"" D STATS2
 K TY3,TY,TY1,TY2,TY4,INPP Q
STATS3 F I=1:1:3 S M=$P(INPP,",",I) I $D(INP(M)) S M=$TR(INP(M),LC,UP) S:M="" M="NA" S @$S(I=3:"M=M_A,TY2=TY1",I=2:"TY2=""NA""",1:"TY2=TY1") D STATS2
 S I=4,M=TY D STATS2 Q
STATS2 F J=1:1:8 S $P(^(J),"+",DY)=$S($D(@ZAA02GSCR@("STATS",YM,TY2,$P("PROV,SITEC,TR,TYPE,TRS",",",I),M,TY,J)):$P(^(J),"+",DY),1:0)+($P(DCOUNT,",",J)\TY3)
 Q
COUNT S (L,W,C,B,S)=0
 I '$D(@ZAA02GWPD@(.0115)) D
 . S A=.03,I=$D(@ZAA02GWPD@(A)),XS=$E($G(ZAA02G("RON"),$C(27))) S:'$D(XSL) XSL=$L($G(ZAA02G("RON"),12345)) F I=1:1 S A=$O(^(A)) Q:A=""  S X=$P(^(A),XF,4) D C2
 E  D
 . S A=4,X="" F  S A=$O(@ZAA02GWPD@(.0115,A)) Q:A=""  S X=X_^(A) Q:$L(X)>5800
 . S:X["TX_RTF32" X=$P($P(X,"TX_RTF32",2,99),"}",2,999)
 . F I="\par ","\line ","\par","\line" I X[I F F=2:1:$L(X,I) S:"\par \line\par\"[$E($P(X,I,2),1,5) B=B+1 S X=$P(X,I)_" "_$P(X,I,2,999),L=L+1
 . F I="\tab ","\tab" I X[I F F=2:1:$L(X,I) S X=$P(X,I)_" "_$P(X,I,2,999)
 . F F=2:1:$L(X,"\") S X=$P(X,"\")_$S($P(X,"\",2)[" ":$P($P(X,"\",2,9999)," ",2,9999),1:"\"_$P($P(X,"\",2,999),"\",2,9999))
 . S F=$L(X," ")-1,C=$L(X)+C-F,L=L+1,S=S+F,XS=$C(27),XSL=5 D:X["  " C3 S W=$L(X," ")+W
 ; I $D(@ZAA02GWPD@(.011)) S X=$TR(^(.011),"`"," ") D C2
 S DCOUNT="",COUNT=C_","_L_","_W_","_B_","_S_","_TY3_","_($P(OCOUNT,",",7)+TIME)_","_($P(OCOUNT,",",8)+$G(STMC)) F I=1:1:8 S $P(DCOUNT,",",I)=$P(COUNT,",",I)-$P(OCOUNT,",",I)
 Q
C2 I X="" S B=B+1 Q
 S F=$L(X," ")-1,E=$L(X,XS)-1,C=E*-XSL+(E*2)+$L(X)+C-F,L=L+1,S=S+F D:X["  " C3 S W=$L(X," ")+W-($E(X)=" ")-($E(X,$L(X))=" ")
 Q
C3 I X["          " F D=2:1:$L(X,"          ") S X=$P(X,"          ")_" "_$P(X,"          ",2,99)
 I X["     " F D=2:1:$L(X,"     ") S X=$P(X,"     ")_" "_$P(X,"     ",2,99)
 F D=1:1 Q:X'["  "  S X=$P(X,"  ")_" "_$P(X,"  ",2,99)
 Q
