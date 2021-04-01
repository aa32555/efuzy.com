ZAA02GSCRCM ;PG&A,ZAA02G-SCRIPT,2.10,COMMUNICATIONS CONTROL;27DEC94 4:19P;10JAN2002  16:35;;26JUL2000  17:47
 ;Copyright (C) 1992, Patterson, Gray & Associates, Inc.
LKUP S YX="Job#,7\  Date,8,/\Time,5,:\ Patient,20\ MR #,9\ Prov,9\Site,5\From,6\St,2\" D UL^ZAA02GSCRER
 Q
 ;
MODEM ; ENTRY POINT FOR KERMIT TRANSFERS
 D RECEIVEK^ZAA02GSEND5 Q  ; W GLOB,! R CCC
 Q
 ;
LOGON ; receive portion of logic from Remote Transcription
 W "OK",*13 ; OK completes first step of script
 D RECEIVEK^ZAA02GSEND5 ; W GLOB,! R CCC
 Q
SENDFILE S ID="TEST",GLOB="^ZAA02GTSCRR("_$J_")" K @GLOB S @GLOB=ID
 F J=1:1 S A=$P("106,.1;110,.1;",";",J) Q:A=""  D SENDF1
 Q
SENDF1 F B="",1:1:9 S C="^ZAA02GSCR"_B_"("_A_")" I $D(@C) D SENDF2
 Q
SENDF2 S D2="",D1=$O(^ZAA02GSCR("DWNLD",ID,C,"")) I D1 S D2=$O(^(D1,""))
 I $O(@C@(-D1))="",$O(@C@(-D1,-D2))="",$O(@C@(-D1))="" Q  ; STILL NEED  WORK HERE
 S I=$P(@C@(-D1,-D2),",",2),D="^ZAA02GSCR"_B_"("_A_",I)",W=GLOB D SENDCP ; COPY TO GLOBAL
 S ^ZAA02GSCR("DWNLD",ID,C,-$H,-$P($H,",",2))="" Q
 Q
SENDCP S (E,F,G,H)="" F J=1:1 S F=$O(@D@(F)) Q:F=""  S:$D(^(F))#2 @W@(C,F)=^(F) F J=1:1 S G=$O(@D@(F,G)) Q:G=""  S:$D(^(G))#2 @W@(C,F,G)=^(G) F J=1:1 S H=$O(@D@(F,G,H)) Q:H=""  S:$D(^(H))#2 @W@(C,F,G,H)=^(H)
 Q
 Q
INIT S ^ZAA02GSEND("PASSWD","ZAA02GSCRIPT")="D MODEM^ZAA02GSCRCM" Q
 ;
IMPORT D ^ZAA02GSCRPW
 S OS=^ZAA02G("OS"),FILE="D:\HOUSAT\HOUS\OLDREP.TXT"
 ;
IMP1 W FILE," " I OS="DTM" S FILE="C:\HOUSAT~1\OLDREP.TXT" O 10:("R":FILE) S DV=10,ZC="EC=$ZIOS"
 I OS="M3" O 51:(FILE:"R") S DV=51,ZC="EC=$ZC"
 D TEST K %A S HOSP="" ; backup one first
IMP3 U DV F J=2:1 R % S @ZC Q:EC  S I=$TR(%," ",""),I=$E(I,$L(I)),%=$E(%,1,$L($P(%,I,1,$L(%,I)-1)_I)),%A(J)=$E(%,10,99) Q:%["MEDIPLEX "  Q:$E(%,1,20)?." "&(%[", 19")
 I %["MEDIPLEX " F  R % S @ZC Q:EC  S I=$TR(%," ",""),I=$E(I,$L(I)),%=$E(%,1,$L($P(%,I,1,$L(%,I)-1)_I)) Q:$E(%,1,20)?." "&(%[", 19")
 S SA=$E(%,10,99) K %A(J) I J>13,$D(%A) D IMP2
 K %A S %A(1)=SA G:'EC IMP3
 C DV Q
 ;
RE(X) F j=$L(X):-1:0 Q:$E(X,j)'=" "
 Q $E(X,1,j)
DT(X) Q $E(X,3,4)_"/"_$E(X,5,6)_"/"_$E(X,1,2)
IMP2 U 0 ; N (A) W  Q
 ; HOSPP - 3=MR,4-DOS,5-PROC,6-REF,7-DR,8-DOB,9-PAT
 S UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ",LC="abcdefghijklmnopqrstuvwxyz"
 S HOSP=$O(^HOUSP(HOSP)) S:HOSP HD=^(HOSP)
 S (DS,DOB,NM,DR,TR,RF,NMI,MR,PC,NMX)="",INP("MR")="old"
 S DS=$$DT($P(HD,",",4)),DOB=$$DT($P(HD,",",8)),NM=$P(HD,",",9),NM=$$RE($E(NM,1,16))_","_$$RE($E(NM,17,99)),TR=$P(HD,",",10)
 S MR=+$P(HD,",",3),RF=+$P(HD,",",6),DR=+$P(HD,",",7),PC=+$P(HD,",",5)
 ; W !,HD,! R CCC
 S A="" F  S A=$O(%A(A)) Q:A=""  S I=%A(A) D
 . ; I I["the above named" S DS=$TR($P(I,"on ",2),".") Q
 . I
 . I I["RE: " S NMX=$P(I,"RE: ",2)
 . ; I I["RE: " S NM=$P(I,"RE: ",2),NMI=I S:$E(NM)=" " NM=$E(NM,2,99) S A=$O(%A(A)) Q:A=""  S I=%A(A),MR=$P(I," ",$L(I," ")) Q
 . ; I I["DOB: " S DOB=$P(I,"DOB: ",2) Q
 . ; I I["Dear Dr. " S RF=$P($P(I,"Dear Dr. ",2),",") Q
 . ; I I?1.3A1"/".E S DR=$P(I,"/"),DR=$P(DR," ",$L(DR," ")),TR=$P($P(I,"/",2)," ") S:TR="" TR="?"
 Q:NMX=""  ; EXPECTS REPORTS WITH RE: LINES
 W "." I $TR(NMX,LC,UP)'[$P(NM,",") W DS,?9,DOB,?18,DR,?22,TR,?32,RF,?50,NM,"  ",NMX,! R CCC
 I RF="",NMI'="" S RF=$P(NMI,","),RF=$P(RF," ",$L(RF," "))
 I DR="" ; X "N (%A) W"  R CCC Q
 ;
 D DATE^ZAA02GSCRER S INP("TR")=TR,(OSET,OCOUNT,OT)="",(INP("DS"),INP("DD"),INP("DT"))=DS,INP("TM")="00:00",INP("WORK")=WORKT,INP("PATIENT")=NM,INP("PROVIDER")=DR,INP("CONSULT")=RF,INP("REV")=MR,INP("DOB")=DOB,INP("PROC1")=PC,INP("STATS")="?"
 S INP("SITEC")="01",INP("DIST")="H1"
 S TIME=$P($H,",",2),STMC=0
 S DIR="TRANS",(REP,INP("TEMPLATE"))="oldrep",ZAA02GWPD="@ZAA02GSCR@(DIR,DOC)"
 ;
 S P=1 D NEW^ZAA02GSCRER1 M @ZAA02GWPD=%A
 D FILE^ZAA02GSCRER
 Q
TEST S TMPL="PROC1,PROC2,TEMPLATE,TEMPLATE2,TR,SITEC,PROVIDER,PATIENT,MR,DOB,DD,DT,TM,REV,DIST,CONSULT,CC1,CC2,WORK,P1"
 Q
 F A=1:1:$L(TMPL,",") S INP($P(TMPL,",",A))=$P(TMPL,",",A)
 Q
 ;  import from ZAA02GWP (DR LEVY)
ZAA02GWP D DATABASE^ZAA02GSCRPW,PARAM^ZAA02GSCRPW
 S (a,b)="" I $D(^ZAA02GLAST) S a=$p(^ZAA02GLAST,","),b=$P(^ZAA02GLAST,",",2),a=$o(^ZAA02GWP(98,a),-1)
 F  S a=$O(^ZAA02GWP(98,a)) Q:a=""  I "BX,MD,ME,MS"'[a F  S b=$O(^ZAA02GWP(98,a,b)) Q:b=""  I $P(^(b),"\")?1.N.E1"."1N.E S c=^(b) D ZAA02GWP1
 Q
ZAA02GWP1 S (DS,DOB,NM,DR,TR,RF,NMI,MR)="" D TEST
 S INP("MR")=$TR($P($P(c,"\"),"."),",")
 S DS=$P(c,"\",3),NM=$P(c,"\",2)
 S D=.03 F  S D=$O(^ZAA02GWP(a,b,D)) Q:D=""  S I=^(D) D
 . I I["re: " S NM=$P(I,"re: ",2)
 . I I["Dear Dr. " S RF=$P($P(I,"Dear Dr. ",2),",")
 . I $P(I,"/",2)?1.3A S TR=$P(I,"/",2),PROC=$P($P(I,"/",3)," ")
 . S DR="?"
 ; W DS,?9,DOB,?18,DR,?22,TR,?32,RF,?50,NM,!
 ;
 D DATE^ZAA02GSCRER
 S INP("TR")=TR,(OSET,OCOUNT,OT)="",(INP("DS"),INP("DD"),INP("DT"))=DS,INP("TM")="00:00",INP("WORK")=WORKT,INP("PATIENT")=NM,INP("PROVIDER")=DR,INP("CONSULT")=RF,INP("REV")=MR,INP("DOB")=DOB,INP("PROC1")=PROC
 S INP("SITEC")="O",INP("DIST")="A",INP("OLD")=a_","_b
 S UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ",LC="abcdefghijklmnopqrstuvwxyz",TIME=$P($H,",",2),STMC=0
 S DIR="TRANS",(REP,INP("TEMPLATE"))="??",ZAA02GWPD="@ZAA02GSCR@(DIR,DOC)"
 ;
 S P=1 D NEW^ZAA02GSCRER1 S AA="" F  S AA=$O(^ZAA02GWP(a,b,AA)) Q:AA=""  S:$D(^(AA))#2 @ZAA02GWPD@(AA)=^(AA) ;M @ZAA02GWPD=^ZAA02GWP(a,b)
 D FILE^ZAA02GSCRER S ^ZAA02GLAST=a_","_b
 ; R " ",CC
 Q
 ;
PROC S DV="FILE" O DV:("D:\HOUSAT\HOUS\OLDREP.TXT")
 K ^HOUS U DV S J=0 F  R A Q:$ZC  I A["RE: " S J=J+1,^HOUS(J)=$P(A,"RE: ",2)
 C DV Q
 ;
PROCS S DV="FILE" O DV:("D:\HOUSAT\HOUS\OLDREP.TXT") S S=0
 U DV S J=0 F  R A Q:$ZC  S A=$E(A,8,999),S=S+$S(A'?.P:$L(A)-1,1:1)
 C DV Q
 ;
PROC2 K ^HOUSP S DV="FILE" S J=0 F JJ=2:1:13 O DV:("D:\HOUSAT\HOUS\"_JJ_".TXT") U DV F  R A C:$ZC DV Q:$ZC  I $L(A)>3,$E(A,1,3)'="   " S J=J+1,^HOUSP(J)=A
 C DV Q
 ;
CPROC S A="",B="",D=0  F  S A=$O(^HOUS(A)) Q:A=""  S C=$P($P($ZU(^(A)),",")," ") F L=1:1 S B=$O(^HOUSP(B)) Q:B=""  S:^(B)'[C ^HOUSPS(B)=^(B) I ^HOUSP(B)[C Q:L=1  W B,! S D=D+L-1 Q
