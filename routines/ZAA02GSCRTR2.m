ZAA02GSCRTR2 ;PG&A,ZAA02G-SCRIPT,2.10,SELECT A TRANSCRIPT;31OCT94  13:32;;;16SEP2005  11:20
 ;Copyright (C) 1992, Patterson, Gray & Associates, Inc.
PRNT I E[",12,"!(SRC["12,"),$D(ZAA02GSCM) G STATUS^ZAA02GSCMU
 N (ZAA02G,TOP,ZAA02GP,E,PAGE,PP,EP,SDIR,SRC,YY,ZAA02GSCR,TR,ID)
 S %R=TOP+4,%C=33,Y="33\CHLDS\2\Select Printer",Y(0)="\EX\^ZAA02GWP(96)\TO" D POP Q:X[";EX"   S DV=X Q:DV=""
 S %R=TOP+2,%C=1 W @ZAA02GP,ZAA02G("CS") S %R=TOP+4,%C=20 W @ZAA02GP,"Transcript Listing is Queued to Printer ",DV H 2
 K Y S DOC="^REPORTS",Y("XECUTE")="D PRNT1^ZAA02GSCRTR2",Y("PG")=PAGE(PP) F J="FP","EP","TR","ZAA02GSCR","SDIR","SRC","YY","E","ID" I $D(@J)#2 S Y(J)=@J
 D QUEUE^ZAA02GSCRSP
 Q
POP N TR D ^ZAA02GPOP Q
PRNT1 S Y="" F J=1:1 S Y=$O(@VDOC@(Y)) Q:Y=""  S @Y=^(Y)
 D DATE^ZAA02GSCRER S B(1)=6,B(2)=11,B(3)=.4,B(4)=.5 D INIT^ZAA02GWPPC1 S OFF=B(3)*B(2)*$S($D(LMG):0,1:1) S:OFF<0 OFF=0
 I +DVP=4 S REPORT="ED" D ^ZAA02GSCRST9 X:$D(HDRX) HDRX
 X:$D(B(4))+$D(LC)=2 "F AA=3:1:LC+B(4)*6 W !" W !!?OFF,DT S AA=$P(@ZAA02GSCR@("PARAM","BASIC"),"|"),C=80-$L(AA) W ?73+OFF,"Page 1",!?OFF,TM,?C\2+OFF,AA,!
 W ! S C=OFF,MM="" F I=1:1:13 S Y=$P(YY,"\",I),ll(I)=$P(Y,",",2) W ?C,$P(Y,",") S C=C+$P(Y,",",2)+1,MM=MM_$E($TR("--/--/------------------------","/",$P(Y,",",3)_"-"),1,$P(Y,",",2))_" "
 W !?OFF,MM,! S CN=0,NE=54,I=PG S:I["," FP=$P(I,","),I=$P(I,",",2) S I=I-1
PRLEV1 I '$D(FP) S (II,I)=$O(@SRC@(I)) G PRLEV3:I="" X E G:'$T PRLEV1 S CN=CN+1
PRLEV2 I $D(FP) S:I="" FP=$O(@SRC) G:I="" PRLEV3:FP="",PRLEV3:FP]EP S (II,I)=$O(@SRC@(I)) G PRLEV2:I="" X E G:'$T PRLEV2 S CN=CN+1
 G PRLEV1:'$D(@SDIR@(II)) S X=$P(^(II),"`",1,13)
 F m=2,6,7 I $L($P(X,"`",m))'=ll(m) S $P(X,"`",m)=$E($P(X,"`",m)_"                            ",1,ll(m))
 W ?OFF,$TR(X,"`~","  "),! G PRLEV1:CN<NE
PRLEV3 S DONE=1 Q
 ;
EDITCTR S X=$P($G(@ZAA02GSCR@("TRANS",OF*IA(J)+OF1,.03)),"/",1,13),%R=TOP+J+1,%C=1 W @ZAA02GP,X,ZAA02G("CL") X ^ZAA02GREAD W *13,"Update? ",ZAA02G("CL") R C S:C="Y" $P(@ZAA02GSCR@("TRANS",OF*IA(J)+OF1,.03),"/",1,13)=X S C=$D(@SDIR@(0)) Q
 ;
HLP I $D(ZAA02GSCM) D STATUS^ZAA02GSCMU S PP=PP+1 G P^ZAA02GSCRTR
STATUS ;DISPLAYS REPORT SUMMARY
 S FIND=J,IA=10000000-IA(J) D ST0 S PP=PP+1 G P^ZAA02GSCRTR
ST0 N (ZAA02G,ZAA02GP,IA,ZAA02GSCR,ZAA02GSCRP,TRANS) S DIR="TRANS",DOC=IA,DT="",SDIR=ZAA02GSCR_"(DIR,DOC)" D FETCH^ZAA02GSCRER
 S ALLVAR="MR,PN,DR,AGE,SEX" D ^ZAA02GSCRVB
 I $G(INP("DR"))="" S ALLVAR="PV" D ^ZAA02GSCRVB S INP("DR")=$G(INP("PV"))
 I $G(INP("CONSULT"))'[" " S ALLVAR="RFN" D ^ZAA02GSCRVB S INP("CONSULT")=INP("CONSULT")_"  "_$G(INP("RFN"))
 S D=$G(INP("eS")),INP("ESS")=$S($E(D)="Y":"Unsigned",$E(D)="S":"Signed",1:"")_"  "_$$ASI^ZAA02GSCRTR1($P(D,"\",2))
 S D=$G(INP("eS")) S:$P(D,"\",3)["*" INP("ESC")="Cosigned  "_$$ASI^ZAA02GSCRTR1($P(D,"\",3))
 S D=$$AZX^ZAA02GSCRTR1($G(@ZAA02GSCR@(DIR,DOC,.011,"IO")),"P") I $D(@SDIR@(0))'=3
 S:D="" D="(NOT PRINTED)" S INP("PRNT")=$E(D,1,60) S:$L(D)>60 INP("PRNT1")=$E(D,61,120)
 S Y="7,6\RLHSD\1\Report Summary\",Y(0)="14\EX,SE\^ZAA02GTSCR($J)\\\press RETURN to View Report, EXIT  *"
 S A=$G(@ZAA02GSCR@("TRANS",IA,.011)) G:A="" ST2 S GLOB="^ZAA02GTSCR($J)" K @GLOB
 F J=1:1:12 S C=$P($T(DATA+J),";",2,99) D:C["~" ST1 S @GLOB@(J)=C_"*"
 K AA D ^ZAA02GPOP K @GLOB I X[";EX" Q
 S E=$G(IN(+X)) Q
ST1 S E=C,C=$P(E,"~") F L=2:1:$L(E,"~") S M=$P(E,"~",L),D=$P(M," "),F=$G(INP(D)),C=C_$S($L(F)>$L(D):F_$E(M,$L(F),255),1:F_$J("",$L(D)-$L(F)+1)_" "_$P(M," ",2,99))
ST2 Q
 ;
DATA ;
 ;
 ;Patient:  ~PATIENT                          MR:  ~MR
 ;    DOB:  ~DOB        Age: ~AGE  Sex: ~SEX  Tel: ~TEL
 ; Authen:  ~ESS
 ;          ~ESC
 ;  Print:  ~PRNT
 ;          ~PRNT1
 ;Dict Dr:  ~DR
 ; Referr:  ~CONSULT 
 ;    cc1:  ~CC1
 ;    cc2:  ~CC2
 ;    cc3:  ~CC3
