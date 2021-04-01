ZAA02GSCMU ;PG&A,ZAA02G-MTS,1.20,UTILITY OPS;30DEC94 4:14P;;;Wed, 28 Apr 2010  16:10
C ;Copyright (C) 1995, Patterson, Gray & Associates, Inc.
 ;
SEARCH Q
 ;
NOTES N (ZAA02G,TOP,ZAA02GP,DT,E,SDIR,SRC,ZAA02GSCM,ZAA02GSCMD,INX,IA,J,TSU) S FP=$P(IA(J),",",3),MR=$P(IA(J),","),FPMR=$P(IA(J),",",2) D DATE^ZAA02GSCRER
 S Y(1)="* Patient: "_MR
 S Y="12,5\HLDYw\1\FOLLOW-UP NOTES - "_MR S Y(2)=$J("*",60) F J=1:1:8 S Y(J+2)=J_". |"_$E($P($G(@ZAA02GSCM@("LETHIST",MR,FP,J)),"|")_$J("",50),1,48)_"| "_$P($G(^(J)),"|",2)
 S Y(11)="*",Y(12)="   Press RETURN here to Remove Patient from List"
 S Y(0)="\EX\\\\Edit items then Press EXIT" D ^ZAA02GPOP
 ; X "N (X) W  R CCC"
 F J=3:1:10 I $D(X(J)) S Y=$G(X(J)) K:Y="" @ZAA02GSCM@("LETHIST",MR,FP,J-2) I Y'="" S @$S('$D(@ZAA02GSCM@("LETHIST",MR,FP,J-2)):"^(J-2)=Y_""|""_DT",1:"$P(^(J-2),""|"")=Y")
 I +X'=12 Q
 K Y,X S Y="30,9\RHL\1\DELETE FROM FOLLOW-UP\\Do NOT Delete,DELETE Patient from list",Y(0)="\EX\" D ^ZAA02GPOP Q:X=1  Q:X["EX"  F J=1:1:8 K @ZAA02GSCM@("LETMR",MR,FP,J)
 S X=$O(^("T99","")) I X K @ZAA02GSCM@("LETTYP","T99",X,MR),@ZAA02GSCM@("LETMR",MR,FP,"T99")
 Q
STATUS ;DISPLAYS PATIENT STATUS
 S FIND=J,IA=10000000-IA(J) G ST0
STATUS2 S FIND=J,IA=IA(J),FP=$P(IA,",",3),IA=$P($G(@SRC@($P(IA,","))),",",2)
ST0 N (ZAA02GVB,ZAA02G,ZAA02GP,IA,ZAA02GSCR,ZAA02GSCM,ZAA02GSCRP,ZAA02GSCMD,TSU)
 S Y="7,6\RLHSD\1\Patient Mammography File Status\",Y(0)="12\EX,SE\^ZAA02GTSCR($J)\\\press RETURN to Select, EXIT  *"
 S A=$G(@ZAA02GSCR@("TRANS",IA,.011)) G:A="" STATM S MR=$P(A,"`",9),PN=$P(A,"`",8),DOB=$P(A,"`",10),A=$P(A,"`",16),REF=$$REFNAME^ZAA02GSCMIF(A),REFTEL=$$REFTEL^ZAA02GSCMIF(A)
 S B=$G(@ZAA02GSCM@("EXAM",IA)) G:B="" STATM S AG=$P($P(B,";AGE,",2),";")
 I MR]"" S TEL=$$PATTEL^ZAA02GSCMIF(MR),SX=$$PATSEX^ZAA02GSCMIF(MR)
 S GLOB="^ZAA02GTSCR($J)" K @GLOB
 F J=1:1:6 S C=$P($T(DATA+J),";",2,99) D:C["~" ST1 S @GLOB@(J)=C_"*"
 K IN S (A,I,J)="" F  S A=$O(@ZAA02GSCM@("DIR","MR",MR,A)) Q:A=""  F J=J:.001 S I=$O(@ZAA02GSCM@("DIR","MR",MR,A,I)) Q:I=""  S B=$G(@ZAA02GSCM@("EXAM",I)) I B]"" S C="" D ST2 S @GLOB@(E+J)=C,IN(E+J)=I_";"_B
 S (B,D)="",A=9
 F  S A=$O(@ZAA02GSCM@("LETHIST",MR,A)) Q:A=""  F  S B=$O(@ZAA02GSCM@("LETHIST",MR,A,B)) Q:B=""  F  S D=$O(@ZAA02GSCM@("LETHIST",MR,A,B,D)) Q:D=""  S M=$G(^(D)) F L=2:1 S E=$P(M,",",L) Q:E=""  D ST3 S J=J+.001,a=19000000+A,@GLOB@(a+J)=C,IN(a+J)=B_","_A_","_D
 S (E,B)="" F  S A=$O(@ZAA02GSCM@("LETMR",MR,A)) Q:A=""  F  S B=$O(@ZAA02GSCM@("LETMR",MR,A,B)) Q:B=""  F J=J+.001:.001 S E=$O(@ZAA02GSCM@("LETMR",MR,A,B,E)) Q:E=""  S a=19000000+E D ST4 S a=19000000+A,@GLOB@(a+J)=C,IN(a+J)=B_":"_A_":"_E
 Q:$D(ZAA02GVB)
 K AA,a D ^ZAA02GPOP K @GLOB I X[";EX" Q
 S E=$G(IN(+X)),X=$P(@ZAA02GSCM@("EXAM",IA),";",3) I X]"" D FAXINFO^ZAA02GSCRFX
 G STEXPAND:E[";",RESEND:E[",",CANCEL
ST1 S E=C,C=$P(E,"~") F L=2:1:$L(E,"~") S M=$P(E,"~",L),D=$P(M," "),F=$G(@D),C=C_$S($L(F)>$L(D):F_$E(M,$L(F),255),1:F_$J("",$L(D)-$L(F)+1)_" "_$P(M," ",2,99))
 Q
ST2 S E=19000000+$P(B,";",2),C=$E(E,5,6)_"/"_$E(E,7,8)_"/"_$E(E,3,4)_" "_$E($P(B,";",4)_"      ",1,6)
 S D=$P(B,";",3),B=$P(B,";",10,99),C=C_$E($S(D="":"",1:$$REFNAME^ZAA02GSCMIF(D))_$J("",23),1,23)_" "_$E($P(",SCREEN,DIAGNOSTIC,ADDN'L VIEW,ADDN'L VIEW,FOLLOW-UP,REVIEW",",",$F("SPAVFO",$E($P(B,";RA",2))))_"             ",1,13)
 S C=C_"   "_$E($P(B,";AB",2))_" "_$E("0123456",$F("ANBPSMK",$E($P(B,";AB",2)))-1)_"      "_$E($P(B,";FA",2)) Q
ST3 S K=E X "N (K,DT) D D1^ZAA02GSCMST" S $P(DT,"/",3)=$E($P(DT,"/",3),3,4)
 I $E(B,2,9)=99 S C="   FOLLOW-UP LIST CANCELLED - ("_DT_")" Q
 S C="   LETTER - "_$P($G(@ZAA02GSCM@("PARAM","LETTERS",$E(B,2,9))),"\",6)_" ("_$S(E["C":"cancelled",E["R":"requeued",E["F":"faxed",1:"sent")_" "_DT_")" Q
ST4 I $E(B,2,9)=99 S C="   FOLLOW-UP LIST CREATED - ("
 E  S C=^(E),C="   LETTER - "_$E($P($G(@ZAA02GSCM@("PARAM","LETTERS",$E(B,2,9))),"\",6),1,30)_" ("_$S(C["R":"re",1:"")_"queued for "
 S C=C_$E(a,5,6)_"/"_$E(a,7,8)_"/"_$E(a,3,4)_")" Q
 ;
STATM Q
 ;
STEXPAND S DOC=$P(E,";"),D=19000000+$P(E,";",3),D=$E(D,5,6)_"/"_$E(D,7,8)_"/"_$E(D,1,4),Y="10,5\RLHSD\1\Mammography Codes - Exam: "_D,Y(0)="12\EX,SE\^ZAA02GTSCR($J)\\\Press SELECT for REPORT\"
 S E=$TR(E,"|",";")
 F J=9:1:$L(E,";") S M=$E($P(E,";",J),1,3) I M]"",M'["AGE" S I=$G(@ZAA02GSCMD@("DICT",3,M)) I I["," S C=$E($P($G(@ZAA02GSCMD@("DICT",1,+I)),"^")_$J("",20),1,18),I=$G(^(+I,$P(I,",",2))) S @GLOB@(M)=$E(M,1,3)_"  "_C_"  "_$E($P(I,"^",2),1,40)
 D ^ZAA02GPOP K @GLOB I X'[";SE" Q
 S ZAA02GWPD=ZAA02GSCR_"(""TRANS"",DOC)" G:'DOC END D BUSY^ZAA02GSCRVW Q:DOC=""
 S %R=5,%C=1 W @ZAA02GP,ZAA02G("CL"),ZAA02G("RON"),$TR(@ZAA02GWPD,"`~","  "),ZAA02G("ROF")
 S TL=7,BL=22,WO="",MG=76,NM=DOC,ZAA02GWPOPT="INQ,NC"
 D ENTRY^ZAA02GWPV6 S %R=22,%C=1 W @ZAA02GP,ZAA02G("CS") D FT^ZAA02GSCRTR
 Q
RESEND G FLUP:E["T99" ; S X=$G(@ZAA02GSCM@("LETHIST",MR,$P(E,",",2),$P(E,","),$P(E,",",3))) G CANCEL:$P(X,",",$L(X,","))'["C"
 S Y="15,9\LHD\1\Reprint/Requeue Letters\\*,"_$E($P($G(@ZAA02GSCM@("PARAM","LETTERS",+$E(E,2,9))),"\",6),1,35)_"*,*,Return with no change,Requeue this letter as before,Print a copy of this letter"
 S:$G(FAXTOF)]"" Y=Y_",Fax copy to referral" S Y(0)="\EX\"
 D ^ZAA02GPOP S:X[";EX" X="" G PRINT:X=6,FAX:X=7,REQUEUE:X=5
 Q
CANCEL G:+$E(E,2,99)=99 FLUPC
 S Y="15,9\LHD\1\Cancel/Print Letters\\*,"_$E($P($G(@ZAA02GSCM@("PARAM","LETTERS",+$E(E,2,9))),"\",6),1,35)_"*,*,Return with no change,Cancel this letter,Cancel all letters for this patient,Print this letter"
 S:$G(FAXTOF)]"" Y=Y_",Fax this letter" S Y(0)="EX\" D ^ZAA02GPOP S:X[";EX" X="" G PRINT:X=7,FAX:X=8 Q:X<5
 I X=6 S (B,C,J)="" F  S B=$O(@ZAA02GSCM@("LETMR",MR,B)) K:B="" @ZAA02GSCM@("LETMR",MR) Q:B=""  F  S C=$O(@ZAA02GSCM@("LETMR",MR,B,C)) Q:C=""  F  S J=$O(@ZAA02GSCM@("LETMR",MR,B,C,J)) Q:J=""  D CANC1
CANC2 I X=5 S A=$S(E[":":":",1:","),B=$P(E,A,2),C=$P(E,A),J=$P(E,A,3) I $D(@ZAA02GSCM@("LETMR",MR,B,C,J)) D CANC1 K @ZAA02GSCM@("LETMR",MR,B,C,J) I $D(@ZAA02GSCM@("LETMR",MR,B))<10 K ^(B)
 Q
CANC1 S @ZAA02GSCM@("LETHIST",MR,B,C,J)=^(J)_","_(+$H)_"C" K @ZAA02GSCM@("LETTYP",C,J,MR)
 Q
REQUEUE N DST,MAMMO,DOC S DOC=IA,A=$S(E[":":":",1:","),DST=$P(E,A,2),C=$P(E,A),J=$P(E,A,3),MAMMO=@ZAA02GSCM@("EXAM",DOC)
 S @ZAA02GSCM@("LETMR",MR,DST,C,J)=DOC_","_(+$H)_"R",@ZAA02GSCM@("LETTYP",C,J,MR)=DST_","_IA_","_$P(MAMMO,";",5) ; K @ZAA02GSCM@("LETHIST",MR,DST,C,J)
 I $D(@ZAA02GSCM@("LETMR",MR,DST))#2=0 S DS=$E(DST\100#100+100,2,3)_"/"_$E(DST#100+100,2,3)_"/"_$E(DST\10000#100+100,2,3) D LINE^ZAA02GSCMR
 Q
FLUP S Y="15,9\LHD\1\Follow-up List\\*,Return with no change,Restore patient to follow-up list",Y(0)="\EX\"
 D ^ZAA02GPOP S:X[";EX" X="" G REQUEUE:X=3 Q
FLUPC S Y="15,9\LHD\1\Follow-up List\\*,Return with no change,Cancel patient from follow-up list",Y(0)="\EX\"
 D ^ZAA02GPOP S:X[";EX" X="" Q:X'=3  S X=5 G CANC2
 ;
PRINT K FAXTOF
PRINT2 K INX N (ZAA02G,TOP,ZAA02GP,MR,X,ZAA02GSCM,ZAA02GSCR,E,FAXTOF,FAXPARAM,ZAA02GSCMD,TSU,ZAA02GVB,LTR,LTX,DV,DOC) S A=$S(E[":":":",1:","),FPMR=$P(E,A,2),FP=$P(E,A,3)
 S SRC=$P(ZAA02GSCM,")")_",""LETTYP"","""_$P(E,A)_""")",X=$G(FAXTOF)]""*2+3,TOP=3,SDIR=$NA(@ZAA02GSCM@("LETMR")),IND=1
 D PRINTE^ZAA02GSCML Q
 ;
FAX K FAXPARAM,X D DIRECT^ZAA02GSCRFX2 I '$D(X) S %R=5,%C=1 W @ZAA02GP,ZAA02G("CS") Q
 X "N (ZAA02G,ZAA02GP) S Y=""40,14\RHLW5\1\\\*,FAX QUEUED,*"" D ^ZAA02GPOP"
 F A="FAXTO","FAXFROM","FAXSUB" I $G(@A)="" S @A="-"
 ; S A=$G(@ZAA02GSCR@("PARAM","FAX")) G:$P(A,"\",21,26)?."\" FAXHDQ S HD=$P(A,"\",22),FT=$P(A,"\",23),HD1=$P(A,"\",24),FT1=$P(A,"\",25),CVR=$P(A,"\",26),DELAY=$P(A,"\",21) D DELAY
 S FAXPARAM=$G(FAXFROM)_"`"_$P(^ZAA02GFAXC("FAX"),"\",3)_"`"_$G(FAXSUB)_"`"_FAXTO_"`"_$TR(FAXTOF,"FAX","")_"`"_$G(FAXORG)_"`1``P```Y`````"_IA
 G PRINT2
 ;
DATA ;
 ;
 ;Patient: ~PN                             MR:  ~MR
 ;    DOB: ~DOB        Age: ~AG  Sex: ~SX  Tel: ~TEL
 ;    Ref: ~REF                        Ref Tel: ~REFTEL
 ;
 ;   Exam    Dr.       Referral              Type      Assess. Lab
 ; -------- ------ ---------------------- ------------ ------- ---
 ;
