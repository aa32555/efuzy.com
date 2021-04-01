ZAA02GSCMST5 ;PG&A,ZAA02G-MTS,1.20,REPORTS-PATIENT LIST/BIOPSY;;17DEC2002  11:53;30AUG95 3:01P;Thu, 04 Oct 2018  11:42
C ;Copyright (C) 1995, Patterson, Gray & Associates, Inc.
 S BM=$P(BEG,"/",3)-1900*100+BEG*100+$P(BEG,"/",2),EM=$P(END,"/",3)-1900*100+END*100+$P(END,"/",2),T1=""
 S DIR=$P("PROV,REF,SITEC,SITEC",",",SORT),REP="REP"_$P("1,1,1,1,1,1",",",SORT) S TS="All",RESULTS=$G(RESULTS,1)
 S HD=$P(",FOLLOW-UP REPORT,BIOPSY FOLLOW-UP REPORT,LETTER SUMMARY REPORT,BIRADS 0 REPORT",",",TYPE) S:TYPE=1 HD=$G(@ZAA02GSCM)
 S HD=HD_$S(SORT<4:" BY "_$P("RADIOLOGIST,REFERRING PHYSICIAN,SITE",",",SORT),1:"")_$S(BSORT'=4:" - SORTED "_$P("ALPHABETICALLY,BY DOS,BYBIRAD,,BY CODE",",",BSORT),1:" - BIRAD = "_$E("1234506",RESULTS))
 S EX="S ^ZAA02GTSCM($J,E,Y,B)=1"
 I BSORT=1 S EX="S C=$P($G(@ZAA02GSCR@(""TRANS"",B,.011)),""`"",8)_1,^ZAA02GTSCM($J,E,C,B)=1"
 I BSORT=2!BSORT=5 S EX="S ^ZAA02GTSCM($J,E,Y,B)=1"
 I BSORT=3 S EX="S C=$E($P($P($G(@ZAA02GSCM@(""EXAM"",B)),"";"",9,99),"";AB"",2)_1),^ZAA02GTSCM($J,E,C,B)=1"
 I BSORT=4 S RESULTS=$E("NBPSMAK",RESULTS),EX="I $E($P($P($G(@ZAA02GSCM@(""EXAM"",B)),"";"",9,99),"";AB"",2))=RESULTS "_EX
 I $D(RESULTS)>2,BSORT'=4 S HD=HD_"  BIRADS:"_RESULTS,EX="I $D(RESULTS($E($P($P($G(@ZAA02GSCM@(""EXAM"",B)),"";"",9,99),"";AB"",2)_"" ""))) "_EX
 I BSORT=5 S EX="I $G(@ZAA02GSCM@(""EXAM"",B))_"";""[SORT3 "_EX
 I BSORT=6 S EX="S ^ZAA02GTSCM($J,1,1,B)=1"
 I SORT=4,TYPE'=2,TYPE'=3 S EX="S E=""*"" "_EX
 I TYPE=2 S REP="REPF" I SORT<4 S EX="D TYPE2 "_EX
 I TYPE=3 S EX="",REP="REPB",BIO=$G(@ZAA02GSCM@("PARAM","BIOPSY CODES")) D
 . S EX=" "_EX F A=1:1:$L(BIO,",") S B=$P(BIO,",",A) I B]"" S EX="!(E["";"_B_""")"_EX
 . S EX="I $D(SC($P($G(@ZAA02GSCM@(""EXAM"",B)),"";"",5)_"" "")) S E=$P(^(B),"";"",9,99) I "_$E(EX,2,999) S:$L(EX)=2 EX="" S EX=EX_" S ^ZAA02GTSCM($J,Y,Y,B)=1"
 I TYPE=4 D
 . K T S T("T99")="Follow Up List" F J=1:1:25 S T("T"_J)="T"_J
 . S B="" F  S B=$O(@ZAA02GSCM@("PARAM","LETTERS",B))  Q:B=""  Q:B=99  S T("T"_B)=$S($P(^(B),"\",6)]"":$P(^(B),"\",6),1:"T"_B)
 . S REP="REP2"
 I TYPE=5 S EX="S ^ZAA02GTSCM($J,""*"",e,B)=1"
 I $G(SORT2)]"" M A=SORT2 K SORT2 F B=1:1:$L(A,",") S E=$P(A,",",B) I E S SORT2(A(E)_" ")=""
 I $D(SORT2) S EX="I $D(SORT2($P($G(@ZAA02GSCM@(""EXAM"",B)),"";"",4)_"" "")) "_EX
 I EX'["SC(" S EX="I $D(SC($P($G(@ZAA02GSCM@(""EXAM"",B)),"";"",5)_"" "")) "_EX
AA I DEVICE=1 S %R=1,%C=20 W @ZAA02GP,$J("",49) S %C=82-$L($P(HD," -"))\2 W @ZAA02GP,ZAA02G("HI"),$P(HD," -")
REP S (A,B,E,CT)="" K ^ZAA02GTSCM($J),SC F SI=1:1:$L(SITEC,",") S SC=$P(SITEC,",",SI) S:SC]"" SC(SC_" ")=""
 I TYPE=1 F  S A=$O(@ZAA02GSCM@("DIR",DIR,A)) Q:A=""  F Y=BM-1:0:EM S Y=$O(@ZAA02GSCM@("DIR",DIR,A,Y)) Q:Y=""  Q:Y>EM  F  S B=$O(@ZAA02GSCM@("DIR",DIR,A,Y,B)) Q:B=""  S E=A X EX
 I TYPE=2 F e=BM-1:0:EM S e=$O(@ZAA02GSCM@("LETTYP","T99",e)) Q:e=""  Q:e>EM  S Y="" F  S Y=$O(@ZAA02GSCM@("LETTYP","T99",e,Y)) Q:Y=""  S B=$P(^(Y),",",2),E=1 X EX
 I 34[TYPE F Y=BM-1:0:EM S Y=$O(@ZAA02GSCM@("DIR","DST",Y)) Q:Y=""  Q:Y>EM  F  S B=$O(@ZAA02GSCM@("DIR","DST",Y,Y,B)) Q:B=""  X EX
 I TYPE=5 F e=BM-1:0:EM S e=$O(@ZAA02GSCM@("XP","OBB",e)) Q:e=""  Q:e>EM  S B="" F  S B=$O(@ZAA02GSCM@("XP","OBB",e,B)) Q:B=""  X EX
 S (A,E,CT)="" F J=1:0 S CT=$O(^ZAA02GTSCM($J,CT)) Q:CT=""  D REPS G:J=999 DONE F  S A=$O(^ZAA02GTSCM($J,CT,A)) Q:A=""  F  S E=$O(^ZAA02GTSCM($J,CT,A,E)) Q:E=""  D @REP G DONE:J=999
END S TR=LN'=999 G END^ZAA02GSCMST
TYPE2 S E=$G(@ZAA02GSCR@("TRANS",B,.011)),E=$P(E,"`",$P("16,7,6",",",SORT))_" " Q
DONE G DONE^ZAA02GSCMST
REP1 S B=$G(@ZAA02GSCM@("EXAM",E)),CB=$P(B,";",9,999),C=$G(@ZAA02GSCR@("TRANS",E,.011))
 I BSORT=3,T1'="",$E($P(CB,";AB",2))'=T1,LN+1'>LNM W ! S LN=LN+1
 I LN>LNM D NEXT Q:J=999
 S LN=LN+1 W ?OFF,$E($P(C,"`",8),1,20),?OFF+21,$P($P(CB,"AGE,",2),";"),?OFF+25,$P(C,"`",9),?OFF+37,$E($P(C,"`",7),1,5),?OFF+41
 I 234[SORT S D=$P(C,"`",16) W $E($S(D="":"",1:$$REFNAME^ZAA02GSCMIF(D)),1,16)
 I 15[SORT D
 . I CB[";RA" W $P(",SCREENING,DIAGNOSTIC,FOLLOWUP,ADDNTL VIEW",",",$F("SPFA",$E($P(CB,";RA",2)))) Q
 . I CB[";XR" W $P(",BASELINE,REPEAT,FOLLOW-UP,SPECIAL VIEW,DIAGNOSTIC,NO EXAM",",",$F("BRFSDN",$E($P(CB,";XR",2))))
 . W $P(",SCREENING,DIAGNOSTIC,DIAGNOSTIC,DIAGNOSTIC,ADDNTL VIEW,FOLLOWUP,",",",$F("SBLRAF",$E($P(CB,";TS",2))))
 S D=$P(B,";",2) I $L(D)'=7 S D=D_"000000" W ?OFF+59,$E(D,3,4),"/",$E(D,5,6),"/",$E(D,1,2)
 E  W ?OFF+59,$E(D,4,5),"/",$E(D,6,7),"/",$E(D,2,3)
 W ?OFF+68,$P(B,";",5),?OFF+72 S T1=$E($P(CB,";AB",2)) W:T1?1A $F("ANBPSMK",T1)-2,"   ",$E($P(CB,";FA",2)) W !
 Q
REPF S B=$G(@ZAA02GSCM@("EXAM",E)),CB=$P(B,";",9,999),C=$G(@ZAA02GSCR@("TRANS",E,.011))
 I BSORT=3,T1'="",$E($P(CB,";AB",2))'=T1,LN+1'>LNM W ! S LN=LN+1
 I LN>LNM D NEXT Q:J=999
 S LN=LN+1,D=$P(B,";",2) I $L(D)'=7 S D=D_"000000" W ?OFF,$E(D,3,4),"/",$E(D,5,6),"/",$E(D,1,2)
 E  W ?OFF,$E(D,4,5),"/",$E(D,6,7),"/",$E(D,2,3)
 W ?OFF+9,$E($P(C,"`",8),1,17),?OFF+27,$P(C,"`",9)
 S D=$P(B,";") I D'="" S D=$$PATTEL^ZAA02GSCMIF(D) I D]"" W ?OFF+35,$E(D,1,13)
 S D=$P(C,"`",16) W ?OFF+48,$E($S(D="":"",1:$$REFNAME^ZAA02GSCMIF(D)),1,11) S T1=$E($P(CB,";AB",2)) W:T1?1A ?OFF+61,$F("ANBPSMK",T1)-2,"   ",$E($P(CB,";FA",2))
 S Y=2
REPF1 W ?OFF+68 S D=$E($P(CB,";RC",Y))
 S T1=$P(",Cyst Aspir,Addnt Proj,Magnif View,Decision to Bx,Excision Bx,Clinical Corr,Ultrasound,FLUP,Biopsy,Core Biopsyal,Histology,Take Approp,Cytologic Anal,U/S FNA,Galactogram,Spot Compr,MRI",",",$F("APMDECUFBLHTCSIGm",D))
 I T1="FLUP" S T1=T1_"("_$$DTX(+$P(CB,"RCF,",2))_")"
 I T1="",D'="" S T1=$G(@ZAA02GSCMD@("DICT",3,"RC"_D)) I T1]"" S T1=$P($P($G(@ZAA02GSCMD@("DICT",1,+T1,$P(T1,",",2))),"^",2),"-")
 W $E(T1,1,12),! I $P(CB,";RC",Y,99)[";RC" S Y=Y+1 D:LN>LNM NEXT Q:J=999  S LN=LN+1 W ?16,"""" G REPF1
 S Y=""
REPF2 S Y=$O(@ZAA02GSCM@("LETHIST",+$P(B,";"),+$P(B,";",2),Y)) I Y?1N S Y1=^(Y) G:Y1["\rtf" REPF3 D:LN>LNM NEXT Q:J=999  S LN=LN+1 W ?12,"NOTE ",Y,": ",$P(Y1,"|"),?70,$P(Y1,"|",2),! G REPF2
 K Y1 Q
 ; still need to convert rtf
REPF3 D
 . N (Y1) S ZAA02GWPD="Y1",Y1(.015)="VT220",RTF=Y1,DIR="AB" D SAVETX^ZAA02GVBTER1
 D:LN>LNM NEXT Q:J=999  S Y1=$O(Y1(.03)) I Y1 F  S LN=LN+1 W ?12,"NOTE: ",$P(Y1(Y1),$C(1),4),!  S Y1=$O(Y1(Y1)) Q:Y1=""
 G REPF2
 ;
DTX(X) N M S M=$P(B,";",2) S M=X*100+M S:M#10000>1299 M=M+10000-1200
 Q M\100#100_"\"_(M#100)_"\"_$E(M\10000#100+100,2,3)
DT(X) Q:$L(X)'=7 $E(X,3,4)_"/"_$E(X,5,6)_"/"_$E(X,1,2)
 Q $E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 ;
REPS Q:CT="*"  Q:TYPE>1  S T1="" I LN+5>LNM D NEXT Q:J=999
 S LN=LN+3 W !,CT I SORT=2 W " - ",$$REFNAME^ZAA02GSCMIF(CT),!! Q
 I SORT=1 W " - ",$$PROVNAM^ZAA02GSCMIF(CT),!! Q
 W !! Q
 ;
REPB S B=$G(@ZAA02GSCM@("EXAM",E)),CB=$P(B,";",9,999),C=$G(@ZAA02GSCR@("TRANS",E,.011))
 I LN>LNM D NEXT Q:J=999
 S LN=LN+1,D=$P(B,";",2) I $L(D)'=7 S D=D_"000000" W ?OFF,$E(D,3,4),"/",$E(D,5,6),"/",$E(D,1,2)
 E  W ?OFF,$E(D,4,5),"/",$E(D,6,7),"/",$E(D,2,3)
 W ?OFF+9,$E($P(C,"`",8),1,16),?OFF+26,$P(C,"`",9),?OFF+37,E
 S D=$P(C,"`",16) I D'="" W ?OFF+48,$E($$REFNAME^ZAA02GSCMIF(D),1,9),?OFF+58,$E($$REFTEL^ZAA02GSCMIF(D),1,13)
 S D=$E($P(CB,";AB",2)) W:D?1A ?OFF+73,$F("ANBPSMK",D)-2 S D=$E($P(CB,";FA",2)) W ?OFF+77,D
 W ! Q
 ;
REP2 S B=$G(@ZAA02GSCM@("EXAM",E)),CB=$P(B,";",9,999),DT=$P(B,";",2) Q:DT<BM  Q:DT>EM
 S C=$G(@ZAA02GSCR@("TRANS",E,.011))
 I LN>LNM D NEXT Q:J=999
 W ?OFF,$J(E,7),?OFF+8,$$DT(DT)
 S MR=$P(B,";") W ?OFF+17,$E($P(C,"`",8),1,12),?OFF+30,$J(MR,8)
 S D=$E($P(CB,";AB",2)) W:D?1A ?OFF+39,$F("ANBPSMK",D)-2
 S (D,B)="" F  S B=$O(@ZAA02GSCM@("LETHIST",MR,DT,B)) Q:B=""  F  S D=$O(@ZAA02GSCM@("LETHIST",MR,DT,B,D)) Q:D=""  I $E(B)="T" D:LN>LNM NEXT Q:J=999  S:'$X LN=LN+1 W ?OFF+41,$E($G(T(B)),1,22)," ( sent on ",$$DT(D),")",!
 Q:J=999  F  S B=$O(@ZAA02GSCM@("LETMR",MR,DT,B)) Q:B=""  F  S D=$O(@ZAA02GSCM@("LETMR",MR,DT,B,D)) Q:D=""  S a=19000000+D D:LN>LNM NEXT Q:J=999  S:'$X LN=LN+1 W ?OFF+41,$E($G(T(B)),1,22),$S(B'[99:" (queued for ",1:"( created "),$$DT(D),")",!
 W:$X !
 S LN=LN+1 I $O(@ZAA02GSCM@("LETMR",MR,DT)) W ?OFF+18,"return-",$$DT($O(^(DT))),! S LN=LN+1
 Q
 ;
HEAD S PG=PG+1 I DEVICE=1 S LN=4,%R=3,%C=1 W @ZAA02GP,ZAA02G("CS") S %C=5 W @ZAA02GP,ZAA02G("LO"),"DATES: ",ZAA02G("HI"),BEG," - ",END S %C=40 W @ZAA02GP,ZAA02G("LO"),"SITE: ",ZAA02G("HI"),$E(SITEC,1,20) S %C=55 W @ZAA02GP,ZAA02G("LO"),"STUDY: ",ZAA02G("HI"),TSU,!!
 I DEVICE>1 D TOP
 G HD1:TYPE=2,HD3:TYPE=3,HD4:TYPE=4,HD5:TYPE=5 W ?6+OFF,"PATIENT        AGE      #       PV",$S(SORT'=1:"     REFERRAL      ",1:"   TYPE OF EXAM    "),"SERVICE  SC  CAT/PATH",!
 W ?OFF,"____________________ ___ ___________ ___ _________________ ________ ___ ______",!
 Q
HD1 W ?3+OFF,"EXAM     PATIENT          JOB#    P PHONE     REFERRAL  CAT/PATH    FOLLOW-UP",!
 W ?OFF,"________ _________________ _______ ____________ ___________ _______ _______________",!
 Q
HD3 W ?2+OFF,"EXAM      PATIENT       ACCNT#      JOB#      REFERRAL    PHONE       CAT RES",!
 W ?OFF,"________ ________________ __________ __________ _________ _____________ ___ ___",!
 Q
HD4 W ?2+OFF,"EXAM    DOS    PATIENT     ACCOUNT  CAT              LETTERS",!
 W ?OFF,"_______ ________ ___________ _________ _ _____________________________________",!
 Q
HD5 W ?2+OFF,"PATIENT            AGE      #       PV   TYPE OF EXAM    SERVICE  SC  FINAL",!
 W ?OFF,"____________________ ___ ___________ ___ _________________ ________ ___ ______",!
 Q
TOP S LN=7 X:$D(HDRX) HDRX X:$D(B(4))+$D(LC)>1 "F AA=2:1:LC+B(4)*6 W !" W $G(bd),!?OFF,DT S AA=$P($G(@ZAA02GSCR@("PARAM","BASIC")),"|") W ?80-$L(AA)\2+OFF,AA,?73+OFF,"Page ",PG,!,?80-$L(HD)\2+OFF,HD,!
 S AA="DATES: "_BEG_" - "_END_"    SITE: "_$E(SITEC,1,25)_"  STUDY: "_TS W ?80-$L(AA)\2+OFF,AA,$G(BDO),!! Q
 ;
NEXT I DEVICE=1,PG>0 S %R=24,%C=20 W @ZAA02GP,"Press RETURN to continue - EXIT to quit " R D#1 X ZAA02G("T") S:$E(XX,$F(XX,ZF))="E" J=999 G HEAD:J'=999 Q
 W:LN'=999 # G HEAD:J'=999 Q
 ;
