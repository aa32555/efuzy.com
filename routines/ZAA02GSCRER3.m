ZAA02GSCRER3 ;PG&A,ZAA02G-SCRIPT,2.10,ADD/EDIT REPORT - MAMMO;3OCT95 5:36P;;;Fri, 27 DeC 2013  10:08
 ;Copyright (C) 1992, Patterson, Gray & Associates, Inc.
MAMMO ; MAMMO FOLLOW-UP LETTERS - called by (PARAM,PRINTQ)
 N (ZAA02G,ZAA02GP,INP,YM,DOC) W *7 S M=INP("MR"),S=INP("SITEC") I $D(^ZAA02GFLUP(S,0,M,DOC))=0 F J="P4","P7" I $D(^ZAA02GFLUP(S,J,M)) S ^(M)=YM
MAM1 S Y="7,13\LDQHUM1YA\1\MAMMO REPORT\",Y(0)="\EX\",Y(1)="To order follow-up letter(s) for this patient:*",Y(2)="*",Y(3)="1. Select desired options by pointing and pressing RETURN key,*"
 S Y(5)="2. Select multiple options with the SELECT key, press RETURN.*",Y(4)="   or*",Y(6)="*",Y(7)="   No letter sent",Y(8)="   Patient 4 month follow-up letter"
 S Y(9)="   Patient 7 month follow-up letter",Y(10)="   Surgical diagnosis letter to MD"
 D ^ZAA02GPOP S X=$P(X,";") S:X[7 X="" S:X[8&(X[9) X=$P(X,"9,")_$P(X,"9,",2) K Y S P=X,Y="25,20\LDRW2\1\\\"_$S(X="":"No Letters",$L(X,",")<3:"One Letter",1:"Two Letters")_" Ordered" D ^ZAA02GPOP Q:X=""
 S ^ZAA02GFLUP(S,0,M,DOC)=YM F J=8:1:10 I P[J S ^ZAA02GFLUP(S,$P("P4,P7,RF",",",J-7),M,YM)=DOC
 Q
MAMREP ; MAMMO LETTER REPORT TO DUMP ^ZAA02GFLUP REPORT
 S (S,A)="" F J=1:1 S S=$O(^ZAA02GFLUP(S)) Q:S=""  S M=1 W !!,"Site-",S,!! F J=1:1 S M=$O(^ZAA02GFLUP(S,M)) Q:M=""  F J=1:1 S A=$O(^ZAA02GFLUP(S,M,A)) Q:A=""  W ?10,A,?20,$P($G(^PTG(+A,A'["/"+$P(A,"/",2))),":",2),?40,M,!
 Q
 ;  USED FOR WORD PERFECT EDITOR AS MAIN EDITOR
WP N (ZAA02G,ZAA02GP,ZAA02GWPD,XS,ZAA02GSCR,DIR,DOC) S XS=$E(ZAA02G("RON")),XSL=$L(ZAA02G("RON")),MG=$S($D(@ZAA02GWPD@(.01)):^(.01),1:65)
 O 51:("E:\WP51\FILE.DOC":"W") U 51 D IEPWPD^ZAA02GWPVP,IEPO^ZAA02GWPVP W X,! G:$ZC WPER D IEPWPD1^ZAA02GWPVP,IEPO^ZAA02GWPVP W X,! G:$ZC WPER
 S A=.03 F J=1:1 S A=$O(@ZAA02GWPD@(A)) Q:A=""  S X=$P(^(A),$C(1),4) K:0 ^(A) D IEPO^ZAA02GWPVP W X,! G:$ZC WPER
 C 51 S A=$&MSM.SHELLDOS("E:\WP51\WP.EXE E:\WP51\FILE.DOC") D HEAD^ZAA02GSCRER
 O 51:("E:\WP51\FILE.DOC":"R") U 51 D IEPICD^ZAA02GWPVP S IEO="R X S X=EC_X S IEOS=$ZC",IEOX="D IEPIC^ZAA02GWPVP,WPY^ZAA02GSCRER2",EC="",KK=.03,IEOS=0 D IEPIA^ZAA02GWPVP
 F J=1:1 X IEO Q:IEOS  X IEOX
 C 51 U 0 Q
WPY Q:X=$C(2)  S C=X F J=1:1 S X=$P(C,$C(10)),C=$P(C,$C(10),2,255) D WPY1 Q:C=""
 Q
WPY1 I $L(X)<MG!(X[XS) S OK=KK,KK=KK+10,@ZAA02GWPD@(KK)=OK_$C(1,1,1)_X Q
 F J=1:1 Q:X=""  S B=$E(X,1,MG),L=$L(B)<MG+$L(B," ")-1,J=$L($P(B," ",1,'L+L))+1,B=$E(X,1,J-1),X=$E(X,-'L+J+1,9999) S:$E(B,$L(B))=" " J=$TR(B," ",""),J=$E(J,$L(J)),B=$E(B,1,$L($P(B,J,1,$L(B,J)-1)_J)) S OK=KK,KK=KK+10,@ZAA02GWPD@(KK)=OK_$C(1,1,1)_B
 Q
WPER U 0 W "ERROR IN FILE TRANSFER" R CCC C 51 Q
 ;
NOMOD K MOD I ZAA02GSCRP["s" G ALTVER:$D(@ZAA02GSCR@("TRANS",DOC,.0172)),LOCK:$G(@ZAA02GSCR@("TRANS",DOC,.011,"eS"))["*",NOFORM
 G LOCK:$D(@ZAA02GSCR@("TRANS",DOC,.011,"LOCKED"))
NOMOD1 D NOTEST I  G NOFORM
NOMOD2 S ZAA02Gform=";Q;;",INQ="INQ"_$S($T:"D",1:"") D ^ZAA02GFORM S edit=0
 S %R=24,%C=1 W @ZAA02GP,ZAA02G("CS") K Y
 I $D(@ZAA02GSCR@("TRANS",DOC,.011,"LOCKED")),'$D(MOD) S Y="25,24\QHP3U\*\\\View Document,Quit",Y(0)="\EX\" D ^ZAA02GPOP S:X["EX" X=2 G I2^ZAA02GSCRER:X=1,AGAIN
 S Y="22,24\QHP1U\*\\\View Document,Create Addendum,Quit",Y(0)="\EX\" D ^ZAA02GPOP S:X["EX" X=4 G I2^ZAA02GSCRER:X=1,ADD:X=2,AGAIN
NOFORM G I3^ZAA02GSCRER
NOTEST S T=$G(INP("DT")) D JULIAN I $H-T<@ZAA02GSCR@("PARAM","NOMODIFY")
 Q
ADD D WPIN F J=.0172:.0001 I '$D(@ZAA02GWPD@(J)) S @ZAA02GWPD@(J,.0189)=$H_","_TRANS Q
 S @ZAA02GWPD@(J)=@ZAA02GWPD F A=.01,.03,.011,.015 S @ZAA02GWPD@(J,A)=$G(@ZAA02GWPD@(A))
 S A="" F  S A=$O(@ZAA02GWPD@(.011,A)) Q:A=""  S @ZAA02GWPD@(J,.011,A)=^(A)
 S A=.03,GET="B=^(A)",B=$O(@ZAA02GWPD@(.03)),C=10 I B S:^(B)[$C(1) GET="B=$P(^(A),$C(1),4)" F  S A=$O(@ZAA02GWPD@(A)) Q:A=""  S @GET,@ZAA02GWPD@(J,A)=B,C=A
 I 1 S ad=1,X="     ",$P(X,"-",45)="" D DATE^ZAA02GSCRER
 I $P(ZAA02GSCRP,";",3)=4 F Y=1:1:7 S B=$S("16"[Y:"",Y=3:X,Y=2:$$ESX^ZAA02GSCRTI1(65),Y=4:$$ESY^ZAA02GSCRTI1,Y=5:$$ESW^ZAA02GSCRTI1,1:DT_"   "_TM_"           ADDENDUM REPORT"),@ZAA02GWPD@(C+10)=$S(GET["$":C_$C(1,1,1),1:"")_B,C=C+10 S:Y<7 @ZAA02GWPD@(J,C)=B
 I $P(ZAA02GSCRP,";",3)'=4 F Y=1:1:4 S B=$S("13"[Y=1:"",Y=2:$$ESX^ZAA02GSCRTI1(65),1:DT_"   "_TM_"           ADDENDUM REPORT"),@ZAA02GWPD@(C+10)=$S(GET["$":C_$C(1,1,1),1:"")_B,C=C+10 S:Y<4 @ZAA02GWPD@(J,C)=B
 K GET,INQ D LOCK2 G NOFORM:$D(SCR),I2^ZAA02GSCRER
 ;
JULIAN S m=+T-3,d=$P(T,"/",2),y=$P(T,"/",3) I (m+d+y)<-2 S T="" Q
 S y=$S(y<30:y+2000,y<100:y+1900,1:y) S:$G(S) o=$S(y<1900:-14917,1:21608),y=y>1999*100+$E(y,3,4) S:m<0 m=m+12,y=y-1 S T=1461*y\4,T=153*m+2\5+T+d+$G(o) K m,y,o,d Q
 ;
LOCK I $G(@ZAA02GSCR@("TRANS",DOC,.011,"LOCKED"))["ADDEND," S INQ=+$P(^("LOCKED"),"ADDEND,",2) G LOCKADD:$G(@ZAA02GSCR@("TRANS",INQ,.011,"LOCKED"))[DOC K @ZAA02GSCR@("TRANS",DOC,.011,"LOCKED") G NOMOD
 I $G(^("LOCKED"))["ADDENDUM TO" S MOD=$P(^("LOCKED"),",",2) D NOTEST G NOMOD2
LOCK4 D LOCKQ
 S:X[";EX" X="R" S X=$E(X) G:X="R" AGAIN G:X="C" ADD I X="A" D LOCK2 G NOFORM
 S ZAA02Gform="1;N;;",INQ="INQ",edit=0 G I3^ZAA02GSCRER
 ;
LOCK2 S B=$G(@ZAA02GSCR@("TRANS",DOC,.011,"eS"))
 I B]"" F L=2,3 S A=$P(B,"\",L) I A["*" F J=1:1:$L(A,",") S K=$P(A,",",J) S:K["*" $P(A,",",J)=$P(K,"*") S:ZAA02GSCRP["a" A="ALL" S $P(B,"\",L)=A
 S $P(B,"\")="Y",$P(B,"\",4)="",^("eS")=B,INP("eS")=B
 Q
LOCKE N (ZAA02G,ZAA02GP,DOC,ZAA02GSCR,ZAA02GSCRP,ESREMOVE)
 S Y="20,10\RLYHV\1\",Y(1)="Transcript File has been previously sent to Provider for Signature*",Y(2)="*",Y(4)="Remove from Provider Queue",Y(3)="Leave on Queue"
 S Y(0)="\EX\\\\select option" D ^ZAA02GPOP K Y S:X["Remove" ESREMOVE=1 Q
LOCKQ N (ZAA02G,ZAA02GP,DOC,ZAA02GSCR,ZAA02GSCRP,X)
 S Y="20,10\RLYHV\1\",Y(1)="Transcript File has already been signed*",Y(2)="and should not be edited.*",Y(3)="*",Y(4)="Return to Transcript List",Y(5)="View Transcript without Edit" ;,Y(6)="Create Addendum (forces new signature)"
 I ZAA02GSCRP'["t" S Y(7)="Allow Edit of Current Document (forces new signature)"
 S Y(0)="\EX\\\\select option" D ^ZAA02GPOP K Y Q
LOCKADD S X="" D LOCKADDM I X=7 S DOC=INQ K INQ D FETCH^ZAA02GSCRER G NOMOD
 G:X=6 NOMOD1 G AGAIN
LOCKADDM N (X,ZAA02G,ZAA02GP,DOC,ZAA02GSCR,INQ,INX) S Y="20,10\RLYH\1\",Y(1)="This report has been amended through*",Y(2)="an addendum in document - *"_$G(INQ),Y(3)="*",Y(4)="Select one of the following-*",Y(5)="*"
 S:$D(INX) Y(6)="Print this document",Y(7)="Print document "_INQ S:'$D(INX) Y(6)="View this document",Y(7)="View document "_INQ
 S Y(0)="\EX\",Y(8)="Exit" D ^ZAA02GPOP K Y Q
LOCKADD2 S Y="20,10\RHU\1\\\This document is an amendment of*,document "_X_"*,*,View Document,Edit Addendum,Modify Referral/Acct#,Quit",Y(0)="\EX\" D ^ZAA02GPOP S:X["EX" X=7 K Y G I2^ZAA02GSCRER:X=4,ADDEND:X=5,MODACCT:X=6,AGAIN
ALTVER K B S B=90,Y=$P($G(@ZAA02GSCR@("TRANS",DOC)),"`",8,11),$P(Y,"`",3)="by",Y=$TR(Y,"`"," ")
 F J=.0172:.0001 Q:'$D(@ZAA02GSCR@("TRANS",DOC,J,.0189))  S Y(B)="   "_$S(J=.0172:"Original Document",1:"Amended Document ")_"    created "_Y,Y=$$DT(^(.0189))_" by "_$P($G(^(.0189)),",",3),B(B)=J,B=B-1
 S Y(9)="   Current Document     created "_Y,Y(99)="*"
 s Y(100)=" *      current document is - "_$S($P($G(@ZAA02GSCR@("TRANS",DOC)),"`",13)["I":"(Marked Incomplete)",$E($G(^(DOC,.011,"eS")))="S":"(Signed)",$E($G(^("eS")))="Y":"(Unsigned)",1:"")
 S Y(102)="*",Y(103)="Quit",B(9)=""
 S Y="6,6\LRHUYS\1\ADDENDUMS\\",Y(1)="This document has addendums.  You may view any version*",Y(2)="but only the last can be modified.*",Y(3)="*",Y(4)="Please select one of the following:*",Y(5)="*"
 S Y(0)="\EX\" D ^ZAA02GPOP S REFRESH="3:24" K Y G AGAIN:X["EX",AGAIN:'$D(B(X)) I B(X)="" G LOCK4:$E($G(@ZAA02GSCR@("TRANS",DOC,.011,"eS")))="S" S ad=1 G I3^ZAA02GSCRER
NOEDIT D NOED1
AGAIN G AGAIN^ZAA02GSCRER
 Q
CL D WPIN F J=.0172:.0001 I '$D(@ZAA02GWPD@(J)) S J=J-.0001 Q
 I '$D(@ZAA02GWPD@(.0188)) S (A,B)=.03 F  S A=$O(@ZAA02GWPD@(J,A)) S:B B=$O(@ZAA02GWPD@(B)) K:A&B ^(B) I A="" S @ZAA02GWPD@(.0188)=$H,ad=1 Q:'B  S:@ZAA02GWPD@(B)[$C(1) $P(^(B),$C(1))=.03 Q
 Q
RIAD K ad D WPIN Q:'$D(@ZAA02GWPD@(.0188))  F J=.0172:.0001 I '$D(@ZAA02GWPD@(J)) S J=J-.0001 Q
 Q:$D(@ZAA02GWPD@(J))=0  K ^ZAA02GTSCR($J)
 S A=.03 F  S A=$O(@ZAA02GWPD@(A)) Q:'A  S ^ZAA02GTSCR($J,A)=$S(^(A)[$C(1):$P(^(A),$C(1),4),1:^(A)) K @ZAA02GWPD@(A)
 S A=.03,C=10 F  S A=$O(@ZAA02GWPD@(J,A)) Q:'A  S @ZAA02GWPD@(C)=C-10_$C(1,1,1)_$S(^(A)[$C(1):$P(^(A),$C(1),4),1:^(A)),C=C+10
 S B=.03 F  S B=$O(^ZAA02GTSCR($J,B)) Q:'B  S @ZAA02GWPD@(C)=C-10_$C(1,1,1)_$S(^(B)[$C(1):$P(^(B),$C(1),4),1:^(B)),C=C+10
 S $P(@ZAA02GWPD@(10),$C(1))=.03 K @ZAA02GWPD@(.0188) Q
WPIN S ZAA02GWPD="@ZAA02GSCR@(DIR,DOC)",DIR="TRANS" Q
NOED1 S B=ZAA02GSCR N ZAA02GSCR S ZAA02GSCR=B_"(""TRANS"")",ZAA02Gform="1;N;;",INQ="INQ",edit=0,ZAA02GWPD="@ZAA02GSCR@(DIR,DOC)",DIR=DOC,DOC=B(X) D F1^ZAA02GSCRER,^ZAA02GFORM,EDIT^ZAA02GSCRER Q
DT(X) N Y,DT,M,K S K=X D D1^ZAA02GSCRER S K=$P(X,",",2)\60,K=$E(K\60+100,2,3)_":"_$E(K#60+100,2,3) Q DT_" "_K
