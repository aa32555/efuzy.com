ZAA02GSCMC ;PG&A,ZAA02G-MTS,1.20,CONFIGURATION SETUP;30DEC94 4:14P;;;14NOV96  19:02
C ;Copyright (C) 1995, Patterson, Gray & Associates, Inc.
 ;
SITE S %R=1,%C=20,Y="SITE PARAMETERS"
 S J=$P(Y,"\"),C=43-$L(J),C=$J("",C\2)_J_$J("",C\2) W @ZAA02GP,ZAA02G("HI"),C
 S SCR="ZAA02GSCM",SNL="1",REFRESH="3:22",ZAA02Gform="1" D ^ZAA02GFORM
 Q
CONF S %R=1,%C=20,Y="Automatic Letters Parameters"
 F J=1:1:12 I $P($G(@ZAA02GSCM@("PARAM","LETTERS",J)),"\",6)="" S $P(^(J),"\",6)=$P($T(LETTER+J),";",2)
 S J=$P(Y,"\"),C=43-$L(J),C=$J("",C\2)_J_$J("",C\2) W @ZAA02GP,ZAA02G("HI"),C
 S SCR="ZAA02GSCM",SNL="13",REFRESH="3:22",ZAA02Gform="1" D ^ZAA02GFORM
 Q
CONF1 S %R=1,%C=20,Y="Other System Parameters"
 S J=$P(Y,"\"),C=43-$L(J),C=$J("",C\2)_J_$J("",C\2) W @ZAA02GP,ZAA02G("HI"),C
 S SCR="ZAA02GSCM",SNL="3",REFRESH="3:22",ZAA02Gform="1" D ^ZAA02GFORM
 S (B,C)="" F J=2,1 S A=$P($G(@ZAA02GSCM@("PARAM","STATS CLASS")),";",J) F L=1:1:$L(A,",") S D=$P(A,",",L) I D]"" S B=B_$E(D,3),C=C_J
 S A="F L=1:1:"_$L(B)_" I MAMMO[("";RC""_$E("""_B_""",L)) S M=$E("""_C_""",L) Q"
 S @ZAA02GSCM@("PARAM","STATS CLASSC")=A
 S A="" I $G(@ZAA02GSCM@("PARAM","VRULES"))]"" S X=^("VRULES") D VRUVAL S @ZAA02GSCM@("PARAM","VRULESX")=L
 K A,B,C,D,L,FORMULA Q
VRUVAL S A=X F J=1:1:$L(A,",") S B=$P(A,",",J) S:$P(B,":")="" $P(B,":")=1 S $P(A,",",J)=B
 S L="FORMULA=$S("_A_")",A=99,@L I 1 Q
 ;
PW ; PRINT WORK SHEETS
 S Y="20,10\RLD\1\Select Form\\Patient Information,Examination,Biopsy Results",X="",Y(0)="\EX" D ^ZAA02GPOP Q:X[";EX"   Q:X=""  S TYPE=X
 S Y="25,13\RHLD\1\\\How many Copies?  *  ",X="",Y(0)="\EX" D ^ZAA02GPOP G:X[";EX" PWE G:X<1 PWE S COPIES=X
 S Y="33,15\RLDV\2\Select Printer\\" S X="" F J=1:1 S X=$O(^ZAA02GWP(96,X)) Q:X=""  S Y=Y_X_","
 S Y=$E(Y,1,$L(Y)-1),Y(0)="\EX" D ^ZAA02GPOP G:X[";EX" PWE S DV=X G:DV="" PWE
 S %R=3 W @ZAA02GP,ZAA02G("CS") S %R=10,%C=20 W @ZAA02GP,"Worksheets are Queued to Printer ",DV
 K Y S DOC="^REPORTS",Y("ZAA02GSCM")=ZAA02GSCM,Y("TYPE")=TYPE,CP=1,Y("COPIES")=COPIES,Y("XECUTE")="D PRINTWS^ZAA02GSCMC"
 D QUEUE^ZAA02GSCMSP H 1
PWE K Y,TYPE,COPIES Q
 ;
PRINTWS ;
 S A="" F J=1:1 S A=$O(@VDOC@(A)) Q:A=""  S B=A_"=@VDOC@(A)",@B
 ;S B(2)=11,B(3)=.5,B(4)=.9 D INIT^ZAA02GWPPC1,^ZAA02GSCRST9:+DVP=4
XX S DONE=1,A=$G(^ZAA02GBRMD("WS",TYPE,+DVP,1)) Q:A=""  S HG=$P($G(@ZAA02GSCM@("PARAM","BASIC")),"\")
 I $L(HG) S BDO="s1p14v",J=$$HPSZ^ZAA02GWPP2(HG),HG=$S(+DVP=4:$C(27)_"(s1p14v0s0b4101T"_$C(27)_"&a"_(5400-J\2)_"h80V",1:"")_HG
 I +DVP=9 S F=$F(A,$C(27)_"[F") S:F A=$E(A,1,F+5)_$C(COPIES)_$E(A,F+7,9999) W A
 I +DVP=4 S F=$F(A,$C(27)_"&l1X") S:F F=$C(27)_"&l1X",A=$P(A,F)_$C(27)_"&l"_COPIES_"X"_$P(A,F,2,9) W $P(A,$C(27)_"*t"),HG,*27,"*t",$P(A,$C(27)_"*t",2,99)
 S A=$D(^ZAA02GBRMD("WS",TYPE,+DVP,1)) F J=2:1 Q:'$D(^(J))  W ^(J)
 Q
TT S DVP=4 O 13 U 13 W !!!! F JJ="a","A","Little","MESSAGE","LONG TITLE IS HERE","Upper and Lower Case Title" S HG=JJ D TT1
 W # C 13 Q
TT1 I $L(HG) S BDO="s1p20v",J=$$HPSZ^ZAA02GWPP2(HG) S HG=$S(+DVP=4:$C(27)_"(s1p20v0s0b4101T"_$C(27)_"&a"_(6120-J\2)_"H",1:"")_HG_"    "_J W HG,!!
 Q
XXDOS S FILE="A:MAM"_$S(TYPE=1:"PINF",TYPE=2:"EXAM",1:"BIOP")_"."_$S(+DVP=4:"HP3",1:"IBM")
 O DV:(::::4096),51:(FILE:"R"::::"") F J=1:1 U 51 R A S B=$ZC U DV W A
 C 51 Q
COPY K ^ZAA02GBRMD("WS",2,4) O 51:("A:\MAMMOE.HP3":"R"::::"") U 51 F J=1:1 R A#200 S ^ZAA02GBRMD("WS",2,4,J)=A Q:$ZC<0
 C 51 Q
CHECK S B="T=T+"_$S(^ZAA02G("OS")="MSM":"$ZCRC(^(J),1)",^ZAA02G("OS")="M11":"$ZC(^(J))",1:"$ZX(^(J),2)")
 S A=$D(^ZAA02GBRMD("WS",2,9,0)),T=0 F J=1:1 Q:'$D(^(J))  S @B
 W T,! Q
 ;
LETTER ; DEFAULT TITLES FOR LETTERS
 ;Patient Lay Report - Normal
 ;Patient Lay Report - Benign
 ;Patient Lay Report - Prob. Benign
 ;Patient Lay Report - Susp/Suggest
 ;Patient Request for Prior Films
 ;Patient Short Term Follow-up
 ;Patient Additional Views
 ;Patient Ultrasound
 ;Patient Visit Reminder - Routine
 ;Referral Biopsy Request Letter
 ;Referral Clinical Correlation
 ;Referral Take Appropriate Action
