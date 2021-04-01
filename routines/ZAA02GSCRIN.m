ZAA02GSCRIN ;PG&A,ZAA02G-SCRIPT,2.10,SITE INIT;02NOV94  11:35;09SEP2015  11:58;;Fri, 18 Mar 2016  16:43
 ; ADS Corp. Copyright
 ;
UP S UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ",LC="abcdefghijklmnopqrstuvwxyz" Q
COPY ; COPY ^G1 to ^G2
 D UP R "FROM GLOBAL - ",G1,!,"TO GLOBAL - ",G2,! S:$E(G1)'="^" G1="^"_G1 S:$E(G2)'="^" G2="^"_G2
CP0 S (A,B,C,D,E)="" F J=1:1 S A=$O(@G1@(A)) Q:A=""  D CP1
 Q
CP1 S A1=A ; S A1=$P(A,".*.")_"."_$P(A,".*.",2,9),A1=$TR(A1,UP,LC) ;TRANSFORM
 Q:$D(@G2@(A1))  W:0 A," "
 S:$D(@G1@(A))#2 @G2@(A1)=^(A) F J=1:1 S B=$O(@G1@(A,B)) Q:B=""  D CP2
 Q
CP2 S:$D(^(B))#2 @G2@(A1,B)=^(B) F J=1:1 S C=$O(@G1@(A,B,C)) Q:C=""  D CP3
 Q
CP3 S:$D(^(C))#2 @G2@(A1,B,C)=^(C) F J=1:1 S D=$O(@G1@(A,B,C,D)) Q:D=""  D CP4
 Q
CP4 S:$D(^(D))#2 @G2@(A1,B,C,D)=^(D) F J=1:1 S E=$O(@G1@(A,B,C,D,E)) Q:E=""  S @G2@(A1,B,C,D,E)=^(E)
 Q
 ;
NEG S G2="^ZAA02GSCR(""TRANS"",X2)",X2=$G(^ZAA02GSCR("PARAM","NEXT")) F X2=X2:1 Q:$O(@G2)=""
 S G1="^ZAA02GSCR(""TRANS"",X1)",X1=-200 F J=1:1 S X1=$O(@G1) Q:X1=""  Q:X1>-1   W X1,">",X2 R CCC,! D CP0 S X2=X2+1
 Q
DEVICE ; COPY PRINTER DEVICE CHARACTERISTICS TO ANOTHER
 R "FROM DEVICE-",DV,!,"TO DEVICE-",DT,!
 S ^ZAA02GWP(96,DT)=^ZAA02GWP(96,DV) F J=1,3 I $D(^ZAA02GWP(96,DV,J)) S ^ZAA02GWP(96,DT,J)=^(J)
 I $D(^ZAA02GWP(96.1,DV)) S ^ZAA02GWP(96.1,DT)=^(DV)
 Q
 ;
REPORTS ; DISPLAY/MODIFY REPORT TEMPLATE SETTINGS
 D DATABASE^ZAA02GSCREC
 R "RTF or ASCII settings (R/A) - ",S,! I S=""!("AR"'[S) W " ??",! G REPORTS
 I S="A" D
 . S C="WIDTH,.01,1;LPI,.03,1;CPI,.03,2;L-MARGIN,.03,3;T-MARGIN,.03,4;B-MARGIN,.03,10;2+ T-MARGIN,.03,9;RT-JUSTIFY,.03,8;1ST HEAD/FOOT,.03,13;2+ HEAD/FOOT,.03,14;TYPE,.03,15;NOTES,.03,16;DIST,.03,17;SITE,.03,19"
 I S="R" D
 . S C="L-MARGIN,.0113,3;T-MARGIN,.0113,4;B-MARGIN,.0113,10;2+ T-MARGIN,.0113,9;1ST HEAD/FOOT,.0113,13;2+ HEAD/FOOT,.0113,14;TYPE,.0113,15;DIST,.0113,17;LTRHEAD,.0113,18;SITE,.0113,19;TRAK,.0113,20"
 W "DISPLAY/MODIFY REPORT TEMPLATE SETTINGS",!!,"Select one",! F J=1:1 S B=$P(C,";",J) Q:B=""  W ?4,J,".  ",$P(B,","),?20,$P(B,",",2),?27,$P(B,",",3),!
 R "?? ",A,! Q:A=""  I A<1!(A'<J) W *7 G REPORTS
 S T=$P(C,";",A)
REPS1 R "Display or Modify (DM) ? ",D,! S MM="I 1",M=1 G REPDP:D="D",REPS1:D'="M"
REPMO R "Modify Options",!?5,"1. Change All",!?5,"2. Change from X to Y",!?5,"3. Prompt for each",!?5,"4. Enter Custom Criteria",!,"?? ",M,! G:M<1!(M>4) REPMO
 I M=1 R !,"Change All to - ",C,!  S MM="S $P(^($P(T,"","",2)),""\"",$P(T,"","",3))=C W ?30,""change to - "",C"
 I M=2 R !,"Change From - ",F,!," To - ",C,! S MM="I $P($G(^($P(T,"","",2))),""\"",$P(T,"","",3))=F S $P(^($P(T,"","",2)),""\"",$P(T,"","",3))=C W ?30,""change to - "",C"
 I M=3 S MM="R ?30,""Change? (N) - "",F I F=""Y"" R "" To - "",C S $P(^($P(T,"","",2)),""\"",$P(T,"","",3))=C W ?40,"" changed"""
 I M=4 R !,"Enter Criteria - ",MM,!
REPDP S A=.9 W # F J=1:1 S A=$O(@ZAA02GSCR@(106,A)) Q:A=""  W A,?20,$P(T,",")," = ",$P($G(^(A,$P(T,",",2))),"\",$P(T,",",3)) X MM W ! I M=1,$Y>22 W "press return to continue" R CC,!! W #
 R !!,"END",!!,"Do you want to rebuild Index ? - ",A,! I A="Y" S DIR=106 D RBDIR^ZAA02GSCRRD
 Q
113 ; FIXES MISSING .O3
 S A="" F  S A=$O(^ZAA02GSCR("TRANS",A)) Q:A=""  I $D(^(A,.03))=0 D
 . S B=$P($G(^(.011)),"`",3) I B]"" S PGMG=$S($D(^ZAA02GSCR(106,B,.0113)):^(.0113),1:$G(^(.03))) S ^ZAA02GSCR("TRANS",A,.03)=PGMG W A," "
 Q
 ;
INCOMP ; CLEARS INCOMPL FLAG IN REPORTS
 S A="" F  S A=$O(^ZAA02GSCR("TRANS",A),-1) Q:A=""  I $P($G(^(A)),"`",13)["I" S C=^(A),$P(C,"`",13)=$TR($P(C,"`",13),"I"),^(A)=C,^ZAA02GSCR("DIR",99,10000000-A)=C
 K ^ZAA02GSCR("DIR",12,"I") Q
 ;
PREPORT ; PRINT REPORTS
 R "PRINT REPORTS FROM-",B,!,"TO REPORT-",E,!,"TO DEVICE-",DEV,!! X:DEV]"" "O DEV U DEV" W:$Y #  F J=1:1 D PREP1 S B=$O(^ZAA02GSCR(106,B)) Q:B=""  Q:B]E
 C:DEV]"" DEV Q
PREP1 I B]"",$D(^ZAA02GSCR(106,B)) W !!,B,"   " W:$D(^(B,.03)) $P(^(.03),"\",19) W !! S A=.03 F I=1:1 S A=$O(^ZAA02GSCR(106,B,A)) Q:A=""  W $P(^(A),$C(1),4),! I $Y>60 W #,B,"  CONTINUES",!!
 Q
 ;
INITIALS ;COPY TRANSCRIPTIONIST'S INITIALS TO ANOTHER
 R "OLD INITIALS-",O,!,"NEW INITIALS-",N,! S OL=$TR(O,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz"),NL=$TR(N,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 S A="" F J=1:1 S A=$O(@ZAA02GSCR@("DIR",11,O,A)) Q:A=""  D INITIAL1
 Q
INITIAL1 S B=@ZAA02GSCR@("TRANS",10000000-A) Q:$P(B,"`",11)'=OL  S $P(B,"`",11)=NL,^(10000000-A)=B,@ZAA02GSCR@("DIR",11,N,A)="",@ZAA02GSCR@("DIR",99,A)=B K @ZAA02GSCR@("DIR",11,O,A) W "."
 S:$P(@ZAA02GSCR@("TRANS",10000000-A,.011),"`",5)=OL $P(^(.011),"`",5)=NL Q
 Q
 ;
ASITE ; Add site codes to another site
 R "ADD CODE-",AC,!,"TO SITE-",S,! S A=0 F J=1:1 S A=$O(@ZAA02GSCR@(106,0,0,S,A)) Q:A=""  I $D(@ZAA02GSCR@(106,A,.03)),$P(^(.03),"\",19)'[AC S $P(^(.03),"\",19)=$P(^(.03),"\",19)_","_AC W "."
 Q
 ;
CSITE ; change site code to another code
 R "CHANGE CODE-",AC,!,"TO SITE-",S,! S A=0 F J=1:1 S A=$O(@ZAA02GSCR@(106,0,0,AC,A)) Q:A=""  I $D(@ZAA02GSCR@(106,A,.03)),$P(^(.03),"\",19)[AC S $P(^(.03),"\",19)=S W "."
 Q
D97 ; FIXES DIR,97
 K @ZAA02GSCR@("DIR",97) S A="" F J=1:1 S A=$O(@ZAA02GSCR@("TRANS",A)) Q:A=""  S D=$G(^(A,.011,"DS")) I D S D=$S($P(D,"/",3)<100:1900,1:0)+$P(D,"/",3)*100+D*100+$P(D,"/",2),@ZAA02GSCR@("DIR",97,D,A)=""
 Q
 ;
CIMAGE ; CLEANS LARGE IMAGE IN RTF
 N A S:$D(ZAA02GSCR)=0 ZAA02GSCR="^ZAA02GSCR"
 Q:'$D(@ZAA02GSCR@("TRANS",DOC))  Q:'$D(@ZAA02GSCR@("TRANS",DOC,.0115,500))
 S A=5 F  S A=$O(^(A)) Q:A=""  I ^(A)["{\*\txfi" D  Q
 . S ^(A)=$P(^(A),"{\*\txfi") F  S A=$O(^(A)) Q:A=""  K:^(A)'["}" ^(A) I $G(^(A))["}" S ^(A)=$P(^(A),"}",2,999) Q
 I A=""  S A=5 F  S A=$O(^(A)) Q:A=""  I ^(A)["{\pict\" D  Q
 . S ^(A)=$P(^(A),"{\pict\") F  S A=$O(^(A)) Q:A=""  K:^(A)'["}" ^(A) I $G(^(A))["}" S ^(A)=$P(^(A),"}",2,999) Q
 I A'="" S ^ZAA02GSCR("TRANS",DOC,.011,"IMAGE-CLEAN",$H)="",^ZAA02GSCR("IMAGE-CLEAN",DOC,$H)=""
 Q
 ;
 ;
D98 ; FIXES DIR,98
 K @ZAA02GSCR@("DIR",98) S A="" F J=1:1 S A=$O(@ZAA02GSCR@("DIR",99,A)) Q:A=""  S DOC=+^(A),D=$P(^(A),"`",8),D=$P(D,"/",3)*100+D*100+$P(D,"/",2) S:'$D(@ZAA02GSCR@("DIR",98,D)) ^(D)=DOC S:^(D)>DOC ^(D)=DOC
 Q
INSERT ; INSERTS HEADER/FOOTER TEXT INTO ALL REPORT TEMPLATES
 S J=1 R "ENTER HEADER NAME-",H,! K A I H'="" S A=$O(@ZAA02GSCR@(110,H,.03)) F J=1:1 S A=$O(^(A)) Q:A=""  S A(J)=$P(^(A),$C(1),4)
 R "ENTER FOOTER NAME-",F,! K E I F'="" S A=$O(@ZAA02GSCR@(110,F,.03)) F K=1:1 S A=$O(^(A)) Q:A=""  S E(K)=$P(^(A),$C(1),4)
 S B=0,K=J
 F J=1:1 S B=$O(@ZAA02GSCR@(106,B)) Q:B=""  D:$D(E)>2 INSR1 I H'="" S C=$O(@ZAA02GSCR@(106,B,.03)),D=$O(^(C)),L=$J(D-C/K,0,4) W !,B," ",D," ",L,! F J=1:1:K-1 S ^(C+L)=C_$C(1,1,1)_A(J) S C=C+L W C," " I J=K-2 S D=$O(^(C)) I D S $P(^(D),$C(1))=C-L
 Q
INSR1 S L=$O(@ZAA02GSCR@(106,B,""),-1),D="" F  S D=$O(E(D)) Q:D=""  S ^(L+10)=L_$C(1,1,1)_E(D),L=L+10
 Q
 ;
LDOS ;   LOAD DOCUMENTS FROM FLOPPY USING WORD PERFECT FORMAT
 D SETUP^ZAA02GWP S F=$ZOS(12,"A:\*.*",0) I $P(F,"^")="" S F="" Q
 F  D DALL1 S F=$ZOS(13,F) Q:$P(F,"^")=""
 Q
DALL1 S FILE=$TR($P(F,"^"),"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 ; W !,FILE,?15,"Restore? " R A Q:A'="Y"
 S JJ=10,LJ=.03,EC="" K @ZAA02GSCR@(106,FILE) S @ZAA02GSCR@(106,FILE,JJ)=LJ_$C(1,1,1)_FILE,LJ=JJ,JJ=JJ+10 K L
 D IEPICD^ZAA02GWPVP O 51:("A:"_FILE:"R") S IEOX="D IEPIC^ZAA02GWPVP",IEO="U 51 R X S X=EC_X,EC="""",IEOS=$ZC",IEOS=0,EC="" D IEPIA^ZAA02GWPVP D:X'="" DALL2 I 'IEOS U 0 F J=1:1 X IEO Q:IEOS  Q:X=""  D IEPIC^ZAA02GWPVP U 0 D DALL2
 U 0 Q:X=""  D IEPIC^ZAA02GWPVP D DALL2 Q
DALL2 F  Q:X=""  S J=$P(X,$C(10)),X=$P(X,$C(10),2,99),@ZAA02GSCR@(106,FILE,JJ)=LJ_$C(1,1,1)_J,LJ=JJ,JJ=JJ+10
 Q
TMPEDIT ; EDIT TEMPLATES
 R "MARGINS-",MGS,! S FILE=99 F  S FILE=$O(@ZAA02GSCR@(106,FILE)) Q:FILE=""  D TMPED1
 Q
TMPED1 S TL=3,BL=22,MG=MGS,WO="",NM=FILE,ZAA02GWPD="@ZAA02GSCR@(106,FILE)" D ENTRY^ZAA02GWPV6 K:$O(@ZAA02GSCR@(106,FILE,.03))="" @ZAA02GSCR@(106,FILE) Q
 ;
TMPSCAN S (A,B)="" F  S A=$O(@ZAA02GSCR@(106,A)) Q:A=""  F  S B=$O(@ZAA02GSCR@(106,A,B)) Q:B=""  F  Q:$G(^(B))'[C  S ^(B)=$P(^(B),C)_$P(^(B),C,2,99) W "."
 Q
 ;
GETPRT ; LOOKUP FOR %ZIS
 S ^ZAA02G("GETPRINTER")=$P($T(GETPRT+2),";",2,9) Q
 ;S VDV=$S(VDV="LASER":4,VDV?.N:VDV,$D(^%ZIS(1,"B",VDV)):$P(^%ZIS(1,$O(^%ZIS(1,"B",VDV,"")),0),"^",2),1:VDV)
 ;
DIR ; REBUILD TOP LEVEL OF TRAN & DIR,99
 ; IF TRACKING - RUN REBUILD^ZAA02GSCMIN - first
 R "STARTING WITH DOC-",DOC,! S For=1
 R "UPDATE OR REBUILD-",UPD,! I $L(UPD)'=1!("UR"'[UPD) G DIR
 S UPD=UPD="R"
DIRBACK S DOC=$G(DOC),REBUILD=1,UPD=$G(UPD,1) I '$D(ZAA02GSCR) S ZAA02GSCR="^ZAA02GSCR",ZAA02GSCRP=";;2"
 S YY=",7,,Y\,30\,11\,3\,6\,15\,15\,8,,DS\,5\,5\,2\,3\,4" I $G(@ZAA02GSCR@("PARAM","TR"))]"" S YY=^("TR")
 I DOC<10 K @ZAA02GSCR@("DIR",13)
 S UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ",LC="abcdefghijklmnopqrstuvwxyz"
 S STOV=13,D=$O(@ZAA02GSCR@("TRANS",""),-1) I D,$G(^(D))]"" S STOV=$L(^(D),"`") S:STOV>13 STOV=13
 I $G(@ZAA02GSCR@("PARAM","RSL"))]"" S ZAA02GSCRP=ZAA02GSCRP_"R",RSL=^("RSL")
 D DATE^ZAA02GSCRER
 S:DOC DOC=DOC-1 F  S DOC=$O(@ZAA02GSCR@("TRANS",DOC)) Q:DOC=""  I $D(^(DOC,.011)) K INP D FETCH^ZAA02GSCRER,DIR1
 Q
DIR1 S DS=$G(INP("DS")) S:$P(DS,"/",3)?4N $P(DS,"/",3)=$E($P(DS,"/",3),3,4)
 S LNN=@ZAA02GSCR@("TRANS",DOC),INP("ST")=$TR($P(LNN,"`",STOV)," ~"),PR=$P($G(@ZAA02GSCR@("TRANS",DOC,.03)),"\",21)
 S Y=$E(10000000+DOC,9-$P(YY,",",2),8)
 F J=1:1:13 S A=$P($P(YY,"\",J),",",2,4) S:A $P(Y,"`",J)=$E($S($P(A,",",3)]"":$G(@$P(A,",",3)),1:$G(INP($P(",PATIENT,MR,PROVIDER,CONSULT,PROC1,PROC2,DS,DT,TM,SITEC,TR,ST",",",J))))_"~              ",1,A)
 S $P(Y,"`",14)=$S($E($G(INP("eS")))="S":"A",$G(INP("STAT")):"S",1:"")_$S($G(INP("NORM")):"N",1:"")_$S($P($G(@ZAA02GSCR@("TRANS",DOC,.03)),"\",20)]"":"T",1:"")
 I $D(STCHG),$P(Y,"`",14)["T",$P(^(.03),"\",20)="N" S $P(^(.03),"\",20)="",$P(Y,"`",14)=$TR($P(Y,"`",14),"T")
 X:ZAA02GSCRP["R" RSL I Y'=@ZAA02GSCR@("TRANS",DOC)+UPD D
 . W:DOC_" "["000 "&$G(For) ^(DOC),!,Y,!! S OSET=$G(^(DOC)),^(DOC)=Y,@ZAA02GSCR@("DIR",99,10000000-DOC)=Y
 . S Y=$TR(Y,LC_"~ ,-:.",UP),OSET=$TR(OSET,LC_"~ ,-:.",UP)
 . F J=2:1:8,12 I $P(OSET,"`",J)'=$P(Y,"`",J)+UPD S A=$P(OSET,"`",J),L=$P(Y,"`",J),K=$P(",2,3,4,5,6,6,7,,,,11",",",J) K:A]"" @ZAA02GSCR@("DIR",K,$S(+A=A:A_" ",1:A),10000000-DOC) S:L]"" @ZAA02GSCR@("DIR",K,$S(+L=L:L_" ",1:L),10000000-DOC)=""
 . I $P(Y,"`",13)["EP",$E($G(@ZAA02GSCR@("TRANS",DOC,.011,"eS")))="Y" S A=$P(^("eS"),"\",2) F J=1:1:$L(A,",") S @ZAA02GSCR@("DIR",48,$P($P(A,",",J),"*"),DOC-10000000)=""
 Q
 ;
REBES ; REBUILD ALL ES FOR TESTING
 S DOC="" F  S DOC=$O(^ZAA02GSCR("TRANS",DOC)) Q:DOC=""  I $E($G(^(DOC,.011,"eS")))'="N" D
 . S $P(^ZAA02GSCR("TRANS",DOC,.011,"eS"),"\")="Y",A=$P(^("eS"),"\",2)
 . I A="" S A=$P(^ZAA02GSCR("TRANS",DOC,.011),"`",16) Q:A=""  S $P(^ZAA02GSCR("TRANS",DOC,.011,"eS"),"\",2)=A
 . F J=1:1:$L(A,",") S ^ZAA02GSCR("DIR",48,$P(A,",",J),DOC-10000000)="" W DOC," "
 . S $P(^ZAA02GSCR("TRANS",DOC),"`",13)=$TR($P(^ZAA02GSCR("TRANS",DOC),"`",13),"EP~")_"EP",^ZAA02GSCR("DIR",99,10000000-DOC)=^(DOC)
 Q
 ;
 ; to convert DIR,99 for archived documents.
 ;
ARCH99 S A=$O(^ZAA02GSCR("DIR",99,"")),A=0 F  S A=$O(^(A)) Q:A=""  I $L(^(A),"`")<13 D
 . S (B,C)=^(A),$P(C,"`",9,14)=$P($P(B,"`",9)," ")_"`"_$P($P(B,"`",9)," ",2)_"`"_$P(B,"`",10,11)_"``"_$P(B,"`",12)
 . I $L($P(B,"`",8),"/")=2 S $P(C,"`",8)=$P(B,"`",8)_"/"_$P($P($P(B,"`",9),"/",3)," ")
 . S $P(C,"`",4)=$E($P($P(B,"`",4),"~")_"   ~",1,3)
 . W $P(C,"`")," " S ^(A)=C
 Q
 ;
 ; link reports to study where ACC is defined but STUDU job# is blank
STUDU3 S A="" F  S A=$O(^ZAA02GSCR("TRANS",A),-1) Q:A=""  S B=$G(^(A,.011,"ACC")) I B]"" S L=$E(B,$L(B)),B=$E(B,1,$L(B)-1) I $D(^XFRGEN("JAC",B)) S JAC=^(B) D
 . I $P($G(^STUDU($P(JAC,"^"),$P(JAC,"^",2),$P(JAC,"^",3),$P(JAC,"^",4),$P(JAC,"^",5),L)),":",9)>1 Q
 . Q:'$D(^(L))  W !,A,"  ",^(L) S $P(^(L),":",9)=A
 Q
 ;
 ; link premier reports where FDY is not attached to STUDU
STUDU2 S A="" F  S A=$O(^ZAA02GSCR("TRANS",A),-1) Q:A=""  I $D(^(A,.0115))=10 S B=$G(^(.011)) I $G(^(.011,"FDY"))="" D
 . K L S (E,D,N,P,L)="",K=$P(B,"`",9),K1=1 S:K["/" K1=$P(K,"/",2),K=+K
 . F  S E=$O(^STUDU(E)) Q:E=""  I $D(^STUDU(E,K,K1)) D
 .. F  S P=$O(^STUDU(E,K,K1,P)) Q:P=""  F  S D=$O(^STUDU(E,K,K1,P,D)) Q:D=""  F  S N=$O(^STUDU(E,K,K1,P,D,N)) Q:N=""  S L=L+1,L(L)=$NA(^(N)) W L,"  ",D,?20,^(N),!
 .. W A,!,B,! R CCC,!! I CCC'="",$D(L(CCC)) S L=L(CCC),$P(@L(CCC),":",9)=A,F=$QS(L,1)_"|"_$QS(L,4)_"|"_$QS(L,5)_"|"_$QS(L,6),^ZAA02GSCR("TRANS",A,.011,"FDY")=F,^ZAA02GPOSTA("QUEUEP",A)=""
 Q
 ;         ;
 ; link reports to study where FDY = 4 piece format
STUDU S A="" F  S A=$O(^ZAA02GSCR("TRANS",A),-1) Q:A=""  S B=$G(^(A,.011)) I $L($G(^(.011,"FDY")),"|")=4 W A," " D
 . S INP("MR")=$P(B,"`",9),INP("FDY")=^("FDY"),DOC=A D STUDU^ZAA02GADSGEN
 Q
 ;
 ; link premier reports where FDY is not attached to STUDU
STUDU2 S A="" F  S A=$O(^ZAA02GSCR("TRANS",A),-1) Q:A=""  I $D(^(A,.0115))=10 S B=$G(^(.011)) I $G(^(.011,"FDY"))="" D
 . K L S (E,D,N,P,L)="",K=$P(B,"`",9),K1=1 S:K["/" K1=$P(K,"/",2),K=+K
 . F  S E=$O(^STUDU(E)) Q:E=""  I $D(^STUDU(E,K,K1)) D
 .. F  S P=$O(^STUDU(E,K,K1,P)) Q:P=""  F  S D=$O(^STUDU(E,K,K1,P,D)) Q:D=""  F  S N=$O(^STUDU(E,K,K1,P,D,N)) Q:N=""  S L=L+1,L(L)=$NA(^(N)) W L,"  ",D,?20,^(N),!
 .. W A,!,B,! R CCC,!! I CCC'="",$D(L(CCC)) S L=L(CCC),$P(@L(CCC),":",9)=A,F=$QS(L,1)_"|"_$QS(L,4)_"|"_$QS(L,5)_"|"_$QS(L,6),^ZAA02GSCR("TRANS",A,.011,"FDY")=F,^ZAA02GPOSTA("QUEUEP",A)=""
 Q
 ;
 ; link premier reports where FDY is not attached to WORKFLW
WRKFLW S A="" F  S A=$O(^ZAA02GSCR("TRANS",A),-1) Q:A=""  I $D(^(A,.0115)) S B=$G(^(.011)) I $G(^(.011,"FDY"))="" D
 . K L S (E,D,N,P,L)="",K=$P(B,"`",9),K1=1 S:K["/" K1=$P(K,"/",2),K=+K S DS=$G(^("DS")) Q:DS=""  S DS=$P(DS,"/",3)*100+DS*100+$P(DS,"/",2)
 . S E=$O(^WRKFLW("ACCOUNT",K,K,K1,1,DS,E)) Q:E=""  Q:$D(^WRKFLW(1,DS,K,K1,E))=0  S R=$NA(^(E)) Q:$P(^(E),"`",13)'=""
 . W A,!,B,! R CCC,!! I CCC'="" S $P(@R,"`",13)="1?? "_A,F="W1||"_DS_"|"_E,^ZAA02GSCR("TRANS",A,.011,"FDY")=F,^ZAA02GPOSTA("QUEUEP",A)=""
 Q
 ;
 ; refresh Workflow reports where ACC is not defined correctly
ACC S A="" F  S A=$O(^ZAA02GSCR("TRANS",A),-1) Q:A=""  I $D(^(A,.0115)) S B=$G(^(.011)) S FDY=$G(^(.011,"FDY")) I $E(FDY)="W",$G(^("ACC"))="" D
 . S K=$P(B,"`",9),K1=1 S:K["/" K1=$P(K,"/",2),K=+K
 . S DS=$P(FDY,"|",3),E=$P(FDY,"|",4),WK=$G(^WRKFLW(1,DS,K,K1,E)) Q:WK=""  I $P(WK,"`",4)]"" S ^ZAA02GSCR("TRANS",A,.011,"ACC")=$P(WK,"`",4) W A," "
 Q
 ;
PREMIER ; Prepare existing ZAA02GSCRIPT site for Premier
 S ZAA02GSCR="^ZAA02GSCR",ZAA02GSCRP=";;2"
 I '$D(^ZAA02GWORD("acanthella")) W !,"**** ^ZAA02GWORD medical dictionary is missing - Press RETURN to continue ",!! R CCC
 I $G(@ZAA02GSCR@("PARAM","TR"))]"" S ^("TR-SAVE")=^("TR") K ^("TR") W "TR code was saved under TR-SAVE and TR was removed.",!,"It may not be needed under Premier",! R "ENTER to continue",CCC,!
 ; If ES on - each PROV needs a ^OPG user code
 S P=0 F  S P=$O(@ZAA02GSCR@("PROV",P)) Q:P=""  I $P(^(P),"\",14)="Y" S C=$P(^(P),"\",11) I C]"",'$D(@ZAA02GSCR@("PROV",0,C)) S E=0 F  D  W ! Q:E
 . W "Provider - ",$P(@ZAA02GSCR@("PROV",P),"\"),?50,"Operator Code? " R O I O="" W "...skipped" S E=1 Q
 . I '$D(^OPG(O)) W "...not valid operator code" Q
 . S $P(@ZAA02GSCR@("PROV",P),"\",11)=O,@ZAA02GSCR@("PROV",0,O)=P,E=1
 K STCHG I $D(^ZAA02GSCMD),'$D(^ZAA02GSCMD("ST")) S STCHG=1,A=0 F  S A=$O(@ZAA02GSCR@(106,A)) Q:A=""  I $P($G(^(A,.03)),"\",20)="N" S $P(^(.03),"\",20)=""
 D CODES S P=$O(@ZAA02GSCR@("TRANS",1)) I P,$L(^(P),"`")'=14 W "Rebuilding Directory - this may take a while" S DOC=0,For=1 D DIRBACK
 Q
CODES I '$D(ZAA02GSCR) S ZAA02GSCR="^ZAA02GSCR"
 ;  Q:$G(@ZAA02GSCR@("CODE"))=1
 F J=1:1 S A=$P($T(CODED+J),";",2,99) Q:A=""  S @ZAA02GSCR@("CODE","LIST",$P(A,";"))=$TR($P(A,";",2,9),"|",$C(230))
 S @ZAA02GSCR@("CODE")=$P($T(CODED),";",2,99) Q
CODED ;1
 ;Batch Codes;BT|1|&Code|&Description
 ;Diagnostic Codes;DG|1|&Code|&Description|DGP9|||1
 ;Dictionary;DCT|0|&Code|
 ;Distribution List;DL|1|&Code|&Description|DGP9
 ;Headers/Footers;HDFT|0|&Code|
 ;Letter Definitions;LDEF|0|&Code|
 ;Place of Service;PS|1|&Code|&Description||||1
 ;Procedure Codes;PC|1|&Code|&Description|PCP9|1||1
 ;Provider Codes;PV|1|&Code|&Name|PVP9|1||1
 ;Referring Physician Codes;RF|1|&Code|&Name|RFP9|||1
 ;Report Templates;RT|0|&Code|
 ;Macro;MA|1|&Code|&Description|1
 ;Transcriptionist;TR|0|&Code|&Name|
 ;
PMERGEX F UCI=1,2,3 I $D(^["USER"]pmergeX(UCI)) D
 . S NS="USER"_$S(UCI=2:2,UCI=3:4,1:"") S A="" F  S A=$O(^[NS]ZAA02GSCR("TRANS",A)) Q:A=""  S B=$P($G(^(A,.011)),"`",9) I B S:B'["/" B=B_"/1" I $D(^["USER"]pmergeX(UCI,B)) S N=^(B) S:N_" "["/1 " N=+N D
 .. S D=10000000-A,(DO,O)=$P(^[NS]ZAA02GSCR("TRANS",A,.011),"`",9) S:+O=O DO=O_" " W UCI
 .. I UCI=1 K ^ZAA02GSCR("DIR",3,DO,D) S ^ZAA02GSCR("DIR",3,N_" ",D)="",$P(^ZAA02GSCR("TRANS",A),"`",3)=$E(N_"~            ",1,12),^ZAA02GSCR("DIR",99,D)=^ZAA02GSCR("TRANS",A)
 .. S $P(^ZAA02GSCR("TRANS",A,.011),"`",9)=N
 .. Q:UCI=1
 .. S AA=^ZAA02GSCR("PARAM","NEXT") F AA=AA:1 I '$D(^ZAA02GSCR("TRANS",AA)) S ^ZAA02GSCR("PARAM","NEXT")=AA+1 Q
 .. M ^ZAA02GSCR("TRANS",AA)=^[NS]ZAA02GSCR("TRANS",A)
 .. S C=$G(^ZAA02GSCR("TRANS",AA,.011)) F J=16,17,18 S B=$P(C,"`",J) I B]"" S $P(^(.011),"`",J)="Z"_B
 W "NOW RUN REBUILD",!
 Q
 ;
 ;
PMERGMAM D  Q
 . S C="" F  S C=$O(^ZAA02GSCMD("ST",C)) Q:C=""  I $D(^ZAA02GSCMD("ST",C,"EXAM",A)) D
 .. S $P(^(A),";")=N M ^ZAA02GSCMD("ST",C,"LETHIST",N)=^ZAA02GSCMD("ST",C,"LETHIST",O) K ^ZAA02GSCMD("ST",C,"LETHIST",O)
 .. I '$D(^ZAA02GSCMD("ST",C,"LETMR",N)) M ^ZAA02GSCMD("ST",C,"LETMR",N)=^ZAA02GSCMD("ST",C,"LETMR",O) K ^ZAA02GSCMD("ST",C,"LETMR",O) S (E,F,G)="" F  S E=$O(^ZAA02GSCMD("ST",C,"LETMR",N,E)) Q:E=""  D
 ... S $P(^ZAA02GSCMD("ST",C,"LETMR",N,E),"`",3)=$E(N_"~            ",1,12) F  S F=$O(^ZAA02GSCMD("ST",C,"LETMR",N,E,F)) Q:F=""  F  S G=$O(^ZAA02GSCMD("ST",C,"LETMR",N,E,F,G)) Q:G=""  D
 .... S ^ZAA02GSCMD("ST",C,"LETTYP",F,G,N)=$G(^ZAA02GSCMD("ST",C,"LETTYP",F,G,O)) K ^ZAA02GSCMD("ST",C,"LETTYP",F,G,O)
 Q
ACCNCHK ;  update AccnT Index DIR,3
 S (A,B)="",C=0 F  S A=$O(^ZAA02GSCR("DIR",3,A)) Q:A=""  F  S B=$O(^ZAA02GSCR("DIR",3,A,B)) Q:B=""  S D=$TR($P($P($G(^ZAA02GSCR("DIR",99,B)),"`",3),"~"),",-. ") I $TR(A," ")'=D,D]"" W A,"  ",D,! K:1 ^ZAA02GSCR("DIR",3,A,B) S C=C+1
 W C," accnts deleted from index",! Q
 ;
NAMECHK ;  update Name Index DIR,2
 S UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ",LC="abcdefghijklmnopqrstuvwxyz"
 S (A,B)="",C=0 F  S A=$O(^ZAA02GSCR("DIR",2,A)) Q:A=""  F  S B=$O(^ZAA02GSCR("DIR",2,A,B)) Q:B=""  S D=$TR($P($P($G(^ZAA02GSCR("DIR",99,B)),"`",2),"~"),LC_",-. ",UP) I A'=D W A,"  ",D,! K ^ZAA02GSCR("DIR",2,A,B) S C=C+1
 W C," names deleted from index",! Q
 ;
DELETED ; DELETE DUPLICATES
 S USER="MG" D UP D TRANINIT^ZAA02GVBTER
 R "HOW MANY REPORTS DO YOU WANT TO GO BACK-",BK,!
 S ENDC=$O(^ZAA02GSCR("TRANS",""),-1)-BK
 S DOCC=ENDC F  S DOCC=$O(^ZAA02GSCR("TRANS",DOCC)) Q:DOCC=""  D
 . S BD=$P($G(^(DOCC,.011)),"`",1,12),LB=$O(^ZAA02GSCR("TRANS",DOCC,.0115,""),-1) Q:LB=""  S LBB=$G(^(LB)) Q:BD=""
 . W !,DOCC
 . S DOCB=DOCC F   S DOCB=$O(^ZAA02GSCR("TRANS",DOCB)) Q:DOCB=""  D
 .. I BD=$P($G(^(DOCB,.011)),"`",1,12),LBB=$G(^ZAA02GSCR("TRANS",DOCB,.0115,LB),-1) S DOC=DOCB,DIR="TRANS" W ?10,DOCB,?20,$P(BD,"`",9),! R CCC D FETCH^ZAA02GSCRER,D1^ZAA02GSCRER2
 Q
 ;
SOUND ; CONVERT SOUND MED REPORTS
 C "FILE" S F="C:\D\HL72014.TXT" O "FILE":(F:"I")
 S JJ=0,B="" D HEAD^ZAA02GVBTER,HEAD2^ZAA02GVBTER S JB=B,B="" D HEAD3^ZAA02GVBTER S JE=B,CNT=700000
 S C="" F  U "FILE" R A#8000 S Z=$ZC U 0 D  I Z D S2 Q
 . S C=C_A   F  Q:$L(C,"<Row>")<2   D S2
 Q
S2 S D=$P(C,"<Row>"),C=$P(C,"<Row>",2,9999),JJ=JJ+1
 K DD F J=1:1:9 D
 . S E=$P(D,"</Cell>"),D=$P(D,"</Cell>",2,99),DD=$P($P(E,">",3),"<")
 . I E["ss:Index=" S J=+$P(E,":Index=""",2)
 . W:0 !,J," ",DD S DD(J)=DD
 D
 . N (DD) W  R CC
 Q:1
 D S3 I $L(E)>10 D
 . S CNT=CNT+1 W CNT," " K ^ZAA02GSCR("TRANS",CNT)
 . S MR="00" I $D(^MK(DD(6))) S MR=$O(^(DD(6),"")) I $O(^(MR,""))>1 S MR=MR_"/"_$O(^(""))
 . S B=JB_E_JE,E=5 F J=1:500:$L(B) S ^ZAA02GSCR("TRANS",CNT,.0115,E)=$E(B,J,J+499),E=E+1
 . S ^ZAA02GSCR("TRANS",CNT)="",^(CNT,.011)=$G(DD(9))_"``blank``mg`O`1`"_DD(7)_"`"_MR_"`"_$G(DD(2),DD(3))_"`"_$G(DD(5),DD(3))_"`"_$G(DD(5),DD(3))
 . S ^ZAA02GSCR("TRANS",CNT,.011,"MR")=DD(6),^("ACC")=DD(1)
 Q
 ;
S3 S H=DD(8)
 F I=1:1:5 S T=$P("&lt;,&gt;,&amp;,&nbsp;,&quot;",",",I),F=$E("<>& """,I) I H[T F  Q:H'[T  S H=$P(H,T)_F_$P(H,T,2,9999)
 F I=1:1:2 S T=$P("&#13;,&#10;",",",I) I H[T F  Q:H'[T  S H=$P(H,T)_$P(H,T,2,9999)
 S E="" F I=1:1:$L(H,"<") S E=E_$P(H,"<"),TT=$P($P(H,"<",2),">"),f=0 I TT]"" D
 . D   Q:f  S H=$P($P(H,"<",2,999),">",2,9999)
 .. S T=$ZL($P($P(TT," "),":"))
 .. I T="b"!(T="strong")!(T="em") S E=E_"\b " Q
 .. I T="/b"!(T="/strong")!(T="/em") S E=E_"\b0 " Q
 .. I T="u" S E=E_"\u " Q
 .. I T="/u" S E=E_"\u0 " Q
 .. I T="i" S E=E_"\i " Q
 .. I T="/i" S E=E_"\i0 " Q
 .. I T="br"!(T="br/") S E=E_"\para " Q
 .. I T="li"!(T="/li") S E=E_"\line " Q
 .. I T="p"!(T="p/") S E=E_"\para " Q
 .. I T="hr" S E=E_"---------------------------------" Q
 .. I T="a"!(T="/a") Q
 .. I $E(T,1)="t" Q
 .. I $E(T,1,2)="/t" Q
 .. I T["ul"!(T="/ul") Q
 .. I T="ol"!(T="/ol") Q
 .. I T="dir"!(T="/dir") Q
 .. I T["div" Q
 .. I T["img" Q
 .. I T["sup" Q
 .. I T["span" Q
 .. I T["body" Q
 .. I T["font" Q
 .. I T["xml" Q
 .. I T="o"!(T="/o") Q
 .. I T="st1"!(T="/st1") Q
 .. I T["/p" Q
 .. W:0 !,TT S f=1,E=E_"<"_$P(H,"<",2),H=$P(H,"<",2,9999)
 ; W E,!! R CC
 Q
 1 AccessionNumber
 2 BeginDate
 3 ScheduleDate
 4 OrderDate
 5 CompletionDate
 6 PatientID
 7 NameLF
 8 Report
 9 Exam
 ;
GRAPHIC ; REMOVE GRAPHIC IN MIDDLE OF RTF
 Q:$G(DOC)<1
 Q:$L($G(^ZAA02GSCR("TRANS",DOC,.0115,300)))'=500
 S A=300 F  S A=$O(^(A),-1) Q:A=""  Q:^(A)["{"
 S ^(A)=$P(^(A),"{",1,$L(^(A),"{")-1)
 F  S A=$O(^(A)) Q:A=""  Q:^(A)["}"  K ^(A)
 S ^(A)=$P(^(A),"}",2,999)
 S ^ZAA02GSCR("TRANS",DOC,.011,"IMAGE-CLEAN",$H)="",^ZAA02GSCR("IMAGE-CLEAN",DOC,$H)=""
 Q
 ;
REFS ; SET ALL REFERRALS WITH FAX # TO SUPPRESS PRINT/AUTOFAX
 S A=""  F  S A=$O(^RFG(A)) Q:A=""  I $P(^(A),":",21)'=""  S $P(^(A),":",22)="S" W "."
 Q
 ;
DOUT R "STARTING DOC=",DOC,! K FILE
 R "ENDING DOC=",EDOC,!
 S (FILE,MT)="",DIR="TRANS",ZAA02GWPD="^ZAA02GSCR(DIR,DOC)",ZAA02GSCRP=";;2",DT="",REBUILD=1,ZAA02GSCR="^ZAA02GSCR"
 S UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ",LC="abcdefghijklmnopqrstuvwxyz",eor=$C(13,10),char=$c(27),charlen=5
 S EXC="Consult,PATH,Follow-up,COMPLETION,76377NP,99212,chart note" F J=1:1:$L(EXC,",")-1 S EXC($P(EXC,",",J)_" ")=""
DOUT2 K ^ZAA02GVBT($J)
 F  S DOC=$O(^ZAA02GSCR("TRANS",DOC),-1) Q:DOC=""  Q:DOC<EDOC  I $D(^(DOC,.011))#2 K INP D FETCH^ZAA02GSCRER S P=$G(INP("PROC1")) I '$D(EXC(P_" ")) S ACC=$G(INP("ACC")) D:ACC="" DOUTR D:ACC=""  I ACC]"" S JACC=ACC F  S ACC=$P(JACC,","),JACC=$P(JACC,",",2,9) Q:ACC=""  D
 . I $G(INP("DT"))]"" S NT=$P(INP("DT"),"/")_"-"_$$YDT($P(INP("DT"),"/",3))_$S(ACC="":" noAcc",1:"") W DOC," " S ^ZAA02GVBT($J,NT,DOC,ACC_" ")="" Q
 . S ^ZAA02GVBT($J,"NoDate",DOC)=ACC
 S (FIL,DOC,AC)="" F  C:FIL'="" FILE S FIL=$O(^ZAA02GVBT($J,FIL)) Q:FIL=""  S FILE="REPORTS-"_FIL O FILE:("NW") F  S DOC=$O(^ZAA02GVBT($J,FIL,DOC)) Q:DOC=""  F  S AC=$O(^ZAA02GVBT($J,FIL,DOC,AC)) Q:AC=""  D
 . I $D(^ZAA02GSCR("TRANS",DOC,.011))#2=0 Q
 . K INP D FETCH^ZAA02GSCRER S ACC=$E(AC,1,$L(AC)-1),PGMG=$G(@ZAA02GWPD@(.03)),NEWDIR="TEMP-"_$J
 . U 0 W DOC,"-" U FILE
 . D DOUTHD
 . I $O(@ZAA02GWPD@(.03))="" D
 .. D ZAA02GGETTX^ZAA02GVBTER1 s sub=.03
 .. f  s sub=$o(^ZAA02GSCR(NEWDIR,DOC,sub)) q:sub=""  d
 ... s line=$tr($p($g(^ZAA02GSCR(NEWDIR,DOC,sub)),$c(1),4),"~","")
 ... f l=1:1:$l(line,char) s line=$p(line,char)_$e($p(line,char,2,99),charlen,999) ;255
 ... W line,eor
 .. K ^ZAA02GSCR(NEWDIR,DOC)
 . E  D  ; ascii
 .. s sub=".03",CNT=0
 .. f  s sub=$o(^ZAA02GSCR("TRANS",DOC,sub)) q:sub=""  d  Q:CNT>9999
 ... s line=$tr($p(^ZAA02GSCR("TRANS",DOC,sub),$c(1),4),"~","")
 ... f l=1:1:$l(line,char) s line=$p(line,char)_$e($p(line,char,2,99),charlen,255)
 ... W line,eor
 . W "|#END",eor,!
 Q
DOUTR S DT=$G(INP("DS")),DT=$P(DT,"/",3)*100+DT*100+$P(DT,"/",2)
 S K=$G(INP("MR")),K1=1 S:K["/" K1=+$P(K,"/",2),K=+K
 S W=$O(^WRKFLW("ACCOUNT",K,K,K1,1,DT,"")) Q:W=""
 S N=$O(^(W)) S ACC=$P($G(^WRKFLW(1,DT,K,K1,W)),"`",4) I N="",ACC'="" S GD=$G(GD)+1 Q
 I N]"",$G(INP("PROC1"))]"",$P($P(^(W),"`"),"  ")=INP("PROC1") S ACC=$P($G(^WRKFLW(1,DT,K,K1,W)),"`",4) I ACC'="" Q
 I N]"",$G(INP("PROC1"))]"",$P($P(^(N),"`"),"  ")=INP("PROC1") S ACC=$P($G(^WRKFLW(1,DT,K,K1,N)),"`",4) I ACC'="" Q
 S ACC=""
 Q
 ;
DOUTHD W "#START|",ACC,"|",$$DOB($G(INP("DS"))),"|",INP("PROC1"),"^",$$PC(INP("PROC1")),"|",$S($E($G(INP("eS")))="S":"F",1:"P"),"|",$$NM(INP("MR")),"|",$$DOB(INP("DOB")),"|",$$SX(INP("MR")),"|",$$DB(INP("CONSULT"),"^RFG"),"|",$$DB(INP("PROVIDER"),"^PVG"),"|",$$DB($P($P($G(INP("eS")),"\",2),"*"),"^PVG"),"|",$$RDT($G(INP("DT"),"00/00/0000")),"|"
 Q
NM(X) S K1=1 S:X["/" K1=$P(X,"/",2) Q $P(X,"/")_"|"_$TR(INP("PATIENT"),",","^")
SX(X) S K1=1 S:X["/" K1=$P(X,"/",2) Q $P($G(^PTG(+X,+K1)),":",10)
RE(X) F  Q:$E(X)'=" "  S X=$E(X,2,999)
 Q X
PC(X) Q:X="" "" Q $P($G(^PCG(X)),":",2)
YDT(X) I $L(X)=2 Q $S(X>60:19,1:20)_X
 Q X
DOB(X) I $L(X)=8 Q $S($P(X,"/",3)>60:19,1:20)_$P(X,"/",3)_$E(X+100,2,3)_$E($P(X,"/",2)+100,2,3)
 Q $P(X,"/",3)_$E(X+100,2,3)_$E($P(X,"/",2)+100,2,3)
DB(X,DB) Q:X="" X  I $D(@DB@(X))=0 Q X
 Q X_"^"_$P($P(@DB@(X),":",2),",")_"^"_$$RE($P($P(@DB@(X),":",2),",",2,9))
RDT(X) Q $$DOB(X)_"000000"
 ;;
 ;#START|ACC|DOS|ExamCode^ExamDescription|ReportStatus|MRN|PatientLast^First^Middle|DOB|Sex|OrderingProvID^Last^First|InterpretingProvID^Last^First|SigningProvID^Last^First|Report Date/Time|Report Text|#END
 ;
TMPLTS S ZAA02GWPD="^ZAA02GSCR(106,DOC)",DIR=106,ZAA02GSCR="^ZAA02GSCR",ZAA02GSCRP=";;2" I $D(^ZAA02GSCR(106,DOC,.0115,5)) S B="" W DOC," " G GETRTF^ZAA02GVBTER
 Q
TMPLTS2 S (SC,DOC)="" F  S SC=$O(^TEMPLATES(SC)) Q:SC=""  F  S DOC=$O(^TEMPLATES(SC,DOC))  Q:DOC=""  S B="" D TMPLTS^ZAA02GSCRIN I $L(B) D
 . S F=$TR(DOC,"/ ","-_") F  Q:$E(F,$L(F))'="."  S F=$E(F,1,$L(F)-1)
 . S F="TEMPLATES-"_SC_"/"_F_".rtf" O F:("NW") U F W B C F U 0
 Q
