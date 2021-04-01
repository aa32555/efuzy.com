ZAA02GVT ; Voice Technology Interface to ZAA02G-SCRIPT;2014-07-10 17:23:48;13FEB2003  09:54;;02JUN2003  17:23
 ; ADS Corp. Copyright
 ;
 ; Installation -
 ;   1. For importing REPORTS
 ;     a. Set ^ZAA02GSCRVTC("IN-FOLDER") = INBOX folder from voice
 ;        example: /usr/INBOX/ or \dict\reports\
 ;     b. Set ^ZAA02GSCRVTC("TYPE") = MUMPS code to intrepret header
 ;        example: D HEAD2^ZAA02GVT
 ;     c. Optional ^ZAA02GSCRVTC("PRE-HEADER") & ^ZAA02GSCRVTC("POST-HEADER")
 ;        code can be setup for site specific control
 ;     d. Make sure ZAA02G-SCRIPT is installed and Template "blankvt" 
 ;        exists and contains an "*" line by itself
 ;     e. Set ^ZAA02GSCRVTC("IN-EXTENSION") = Host file extension
 ;        example: mds
 ;     f. Set ^ZAA02GSCRVTC("PRINTER-DEVICE") = output device
 ;     g. Set ^ZAA02GSCRVTC("PRINTER-TYPE") = output type code
 ;        1=print, 2=alt print, 4=hold, 8=quit
 ;     h. Set ^ZAA02GSCRVTC("FLAG","CR") = 0 or 1
 ;        Cache/Open M file input processing for 1 or 2 carriage 
 ;        returns (ASCII 13) after each line.
 ;     i. Set ^ZAA02GSCRVTC("FLAG","DS") = 0 or 1
 ;        File input processing will double space report if enabled.
 ;     j. Set ^ZAA02GSCRVTC("FLAG","MW") = <margin width>
 ;        Margin default is 65 but may be overridden.
 ;     k. Set ^ZAA02GSCRVTC("DIST")= <M code to set INP("DIST")>
 ;        I.e. S INP("DIST")=$S($G(SITEC)]"":$E(SITEC,1,2),1:"A")
 ;     l. Set ^ZAA02GSCRVTC("MNSP") = <M code to set NAMESPACE for ZAA02G doc>
 ;        I.e. S MNSP=$S(SITEC=1:"USER1",SITEC=2:"USER2",1:"USER")
 ;
 ;   2. For exporting REPORTS
 ;     a. Set ^ZAA02GSCRVTC("OUT-FOLDER") = folder from output
 ;        example: /usr/OUTBOX/
 ;     b. In CONFIG in ZAA02G-SCRIPT set the "EXECUTE ON PRINT" parameter
 ;        to "D PRINTE^ZAA02GVT"
 ;
LOOP J FILEIN^ZAA02GVT H 30 G LOOP
 ;
FILEIN L +^ZAA02GSCRVTC:1 I '$T Q
 S MVER=$$SYS^SET,P=$G(^ZAA02GSCRVTC("IN-FOLDER"),"/usr/talktech/")
 S EXT=$G(^ZAA02GSCRVTC("IN-EXTENSION"),"mds")
 I MVER["M3-" D M3IN
 I MVER="INW"!(MVER="INX") D CACHEIN
 I MVER="DTM" D DTMIN
 D EXT
 L -^ZAA02GSCRVTC
 Q
 ;
M3IN S A=$ZOS(12,P_"*."_EXT,63),L=0 I A'=""  D  F  S A=$ZOS(13,A) Q:A=""  D
 . S REP=$O(^ZAA02GSCRVI(""),-1)+1,J=1
 . S D=$P(A,"^") O "FILE":(P_"\"_D:"R") U "FILE" F  R R D  Q:$ZC
 . . ; F L=1:1:$L(R,$C(13)) S ^ZAA02GSCRVI(REP,J)=$P(R,$C(13),L),J=J+1
 . . S ^ZAA02GSCRVI(REP,J)=$TR(R,$C(13)),J=J+1
 . C "FILE" Q
 Q
 ;
CACHEIN ; Cache File Processing
 S EXEC=$S(MVER="INW":"DIR",1:"ls")_" "_P_"*."_EXT
 I MVER="INX" S EXEC=$TR(EXEC,"\","/")
 S FILE="CACHEXEC.TMP"
 S X=$ZF(-1,EXEC_" > "_FILE)
 S $ZT="CACHE1"
 O FILE:"R":0 I '$T G CACHE1
 F COUNT=1:1 U FILE R DATA S OUT(COUNT)=DATA Q:COUNT>5000
CACHE1 ; Cache continue after Directory File read
 C FILE Q:COUNT>5000
 S X=$ZF(-1,$S(MVER="INW":"DEL",1:"rm")_" "_FILE)
 S SUB=""
 F  S SUB=$O(OUT(SUB)) Q:SUB=""  S DATA=OUT(SUB) I DATA]"",$E(DATA)'=" " D
 . S FILE=$S(MVER="INW":P_$E(DATA,40,999),1:$P(DATA," "))
 . I MVER="INX" S FILE=$TR(FILE,"\","/")
 . S $ZT="CACHE2"
 . O FILE:"R":0 I '$T Q
 . L +^ZAA02GSCRVI:0 I '$T Q
 . S REC=$O(^ZAA02GSCRVI(""),-1)+1
 . S COUNT=1
 . S LINE=""
 . F  D
 .. U FILE R *DATA
 .. I DATA=13 D
 ... S ^ZAA02GSCRVI(REC,COUNT)=$S($E(LINE)=$C(10):$E(LINE,2,9999),1:LINE)
 ... S LINE=""
 ... S COUNT=COUNT+1
 ... S OUT=""
 ... R *DATA1
 ... I DATA1'=10,DATA1'=13 S LINE=LINE_$C(DATA1)
 ... I $G(^ZAA02GSCRVTC("FLAG","CR")),DATA1=13 S ^ZAA02GSCRVI(REC,COUNT)="",COUNT=COUNT+1
 .. I DATA'=13 S LINE=LINE_$C(DATA)
 Q
 ;
CACHE2 ; Cache continue after Data File read
 I $G(LINE)]"" S ^ZAA02GSCRVI(REC,COUNT)=$S($E(LINE)=$C(10):$E(LINE,2,9999),1:LINE)
 C FILE
 S X=$ZF(-1,$S(MVER="INW":"DEL",1:"rm")_" "_FILE)
 L -^ZAA02GSCRVI
 Q
 ;
DTMIN ; Datatree File Processing
 S DATAIN=$$files^%dos(P_"*."_EXT)
 S DONE=0
 F  D  I DONE Q
 . S FILE=$P(DATAIN,$C(10))
 . S DATAIN=$P(DATAIN,$C(10),2,999999)
 . S FILE=$P(FILE,";")
 . I FILE?." " S DONE=1 Q
 . O 10:(file=P_FILE:mode="r"):0 I '$T Q
 . L +^ZAA02GSCRVI:0 I '$T C 10 Q
 . S REC=$O(^ZAA02GSCRVI(""),-1)+1
 . S COUNT=1
 . S LINE=""
 . S DONE1=0
 . F  D  I DONE1 Q
 .. U 10 R *DATA
 .. I $ZIOS S DONE1=1 Q
 .. I DATA=10 Q
 .. I DATA=13 D
 ... S ^ZAA02GSCRVI(REC,COUNT)=LINE
 ... S LINE=""
 ... S COUNT=COUNT+1
 ... S OUT=""
 ... R *DATA1
 ... I DATA1'=10,DATA1'=13 S LINE=LINE_$C(DATA1)
 .. I DATA'=13 S LINE=LINE_$C(DATA)
 . I LINE]"" S ^ZAA02GSCRVI(REC,COUNT)=LINE
 . C 10
 . D del^%dos(P_FILE)
 . L -^ZAA02GSCRVI
 Q
 ;
FILEOUT S MVER=$$SYS^SET,P=$G(^ZAA02GSCRVTC("OUT-FOLDER"),"/usr/talktechout/")
 S OUT="" F  S OUT=$O(^ZAA02GSCRVO("OUT",OUT)) Q:OUT=""  I '$G(^(OUT)) D
 . S ^(OUT)=1,D=^(OUT,0)_".TXT"
 . I MVER["M3-" D M3OUT
 . I MVER="INW"!(MVER="INX") D CACHEOUT
 . S J=0 F  S J=$O(^ZAA02GSCRVO("OUT",OUT,J)) Q:J=""  W ^(J),!
 . C FILE K:1 ^ZAA02GSCRVO("OUT",OUT)
 Q
 ;
M3OUT S FILE="FILE" O FILE:(P_D:"W") U FILE Q
CACHEOUT S T=$$FOPEN^DFILE(P_D,"W","A") S FILE=FDEV U FILE Q
 ; 
EXT S:1 A=^ZAA02G("ERROR")_"=""ERROR^ZAA02GVT""",@A D DATABASE^ZAA02GSCRPW,PARAM^ZAA02GSCRPW S A="",HEADTYP=$G(^ZAA02GSCRVTC("TYPE"),"D HEAD1")
EXT2 S A=$O(^ZAA02GSCRVI(A)) Q:A=""  G:$G(^(A)) EXT2 S ^(A)=1 M ^ZAA02GSCRVTL("REC_REP",A)=^ZAA02GSCRVI(A)
 S GOOD=0,aa=A D EXT3 I 'GOOD D  G EXT2
 . I $E(MVER)="I",$G(MNSP)]"",$ZU(5,CURNSP)
 S GLOB="^[CURNSP]ZAA02GTMP($J)" K @GLOB S LN=1
 S @ZAA02GWPD@(.011,"eS")="S"
 S MW=$S($D(^[CURNSP]ZAA02GSCRVTC("FLAG","MW")):^("MW"),1:65)
 S B=Bb F  S Bb=B,B=$O(^[CURNSP]ZAA02GSCRVI(aa,B)) Q:B=""  Q:^(B)'=""
 S L="",B=Bb F  S B=$O(^[CURNSP]ZAA02GSCRVI(aa,B)) Q:B=""  S C=^(B),L=L_C,F=C="" D:$L(L)>MW!F!1 EXT1
 S @GLOB@(LN)=L,LN=LN+1,B=.03 I LN>1 F  S B=$O(@ZAA02GWPD@(B)) Q:B=""  I ^(B)["*" D EXTINS Q
 D EXT5 ;L
 S ^[CURNSP]ZAA02GSCRVTL("REP",DOC)=$H_","_aa K ^[CURNSP]ZAA02GSCRVI(aa),@GLOB
 I $E(MVER)="I",$G(MNSP)]"",$ZU(5,CURNSP)
 G EXT2
 ;
EXTINS S C=$O(^(B)) S:C="" C=B+100,^(C)=B_$C(1,1,1) S D=$J(C-B/LN,0,3),J=$O(@GLOB@("")),$P(@ZAA02GWPD@(B),$C(1),4)=@GLOB@(J) F  S J=$O(@GLOB@(J)) Q:J=""  S @ZAA02GWPD@(B+D)=B_$C(1,1,1)_@GLOB@(J),B=B+D
 S $P(@ZAA02GWPD@(C),$C(1))=B Q
 ;
EXT1 ;
 S OUT=""
 F  D  I L="" Q
 . S WORD=$P(L," ")
 . I $L(OUT)+$L(WORD)+1>MW D  Q
 .. S @GLOB@(LN)=OUT,OUT="",LN=LN+1
 . S OUT=OUT_WORD_" ",L=$P(L," ",2,9999)
 . I L="" S @GLOB@(LN)=OUT,LN=LN+1
 I $G(^[CURNSP]ZAA02GSCRVTC("FLAG","DS")) S @GLOB@(LN)="",LN=LN+1
 Q
 ; mr,sitec,patient,dob,ds,template,proc1,consult
EXT3 N A,F,L K INP D DATE^ZAA02GSCRER,TMPL^ZAA02GSCRER
 S (INP("TR"),TRANS)="VT",(OSET,OCOUNT,OT)="",(INP("DD"),INP("DT"))=DT,INP("TM")=TM,ZAA02G("RON")=$C(27)_"AAAA",XF=$C(1)
 S UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ",LC="abcdefghijklmnopqrstuvwxyz",TIME=$P($H,",",2),STMC=0,ZAA02GWPD="@ZAA02GSCR@(DIR,DOC)",DIR="TRANS"
 ;
 K PATIENT,MR,DOB,DS,PROC1,PROC2,CONSULT,PROVIDER,SITEC,ACC,CC1,CC2,CC3
 ;
 I $D(^ZAA02GSCRVTC("PRE-HEADER")) X ^("PRE-HEADER")
 X HEADTYP
 I $D(^ZAA02GSCRVTC("POST-HEADER")) X ^("POST-HEADER")
 X $G(^ZAA02GSCRVTC("MNSP")) S CURNSP=$ZU(5)
 I $E(MVER)="I",$G(MNSP)]"",$ZU(5,MNSP)
 I $E(MVER)="I",$G(MNSP)]"" S T=$ZU(20,CURNSP)
 Q:'GOOD
 ;
 F A="PATIENT","DOB","MR","DS","PROC1","PROVIDER","CONSULT","SITEC" S INP(A)=$G(@A,"??")
 F A="CC1","CC2","PROC2" S INP(A)=$G(@A)
 F A="ACC","CC3" S:$D(@A) INP(A)=$G(@A)
 D CCPOP S (REP,INP("TEMPLATE"))="blankvt",INP("DIST")="A"
 X $G(^[CURNSP]ZAA02GSCRVTC("DIST"))
 ; PTYPE 1-Print, 2-Alt Print, 4-Hold, 8-Quit
 S PTYPE=$G(^[CURNSP]ZAA02GSCRVTC("PRINTER-TYPE"),1) ; output type
 S PDEV=$G(^[CURNSP]ZAA02GSCRVTC("PRINTER-DEVICE"),2) ; default printer
 I $D(@ZAA02GSCR@("PARAM","VT")) X ^("VT") ; site params here
 S X=INP("CONSULT"),op="I 1" D FAX^ZAA02GSCRER2 ; CHECKS CONSULT
 D NEW^ZAA02GSCRER1 Q
 ;
EXT5 S ODOC=DOC N A,DOC S DOC=ODOC,P=PTYPE S:0 INCOMP=1 D FILE^ZAA02GSCRER S UNLOCK=ZAA02GSCR_"(""TRANS"","_ODOC_")" L -@UNLOCK
 ; I ZAA02GSCRP["W" S STMC=STMC_",A" D MAMMO^ZAA02GSCMR K TYPS,EDIT
 S DV=PDEV,INP("WORK")="",TRTYPE="" D STATS^ZAA02GSCRER2 D:P<3 PR2^ZAA02GSCRER2
 Q
ERROR S ^ZAA02GSCRVTC("ERROR-IN",$H)=$ZE Q
 ;
 ;
 ; following sections pull ID block from report header
 ;
 ;
 ;  Talk Tech - uses XFRTALK("JAC") to point to STUDU record
HEAD1 S (ACC,PROV,Bb)="" F J=1:1:2 S Bb=$O(^ZAA02GSCRVI(aa,Bb)) Q:Bb=""  S:J=1 ACC=^(Bb) S:J=2 PROV=$P(^(Bb),",")
 I ACC=""!(PROV="") Q
 S R=$E(ACC,$L(ACC)),S=$E(ACC,1,$L(ACC)-1),S=$G(^XFRTALK("JAC",S)) Q:S=""
 S REC=$G(^STUDU($P(S,"^"),$P(S,"^",2),$P(S,"^",3),$P(S,"^",4),$P(S,"^",5),R)),GOOD=1
 S (K,MR)=$P(S,"^",2),K1=$P(S,"^",3)
 I $D(^PTG(K,K1)) S PAT=$P(^(K1),":",3),DOB=$P(^(K1),":",12) S:PAT="" PAT=$P(^GRG(K),":",7)
 S PATIENT=PAT,DS=$$DS2($P(S,"^",5)),PROC1=$P(REC,":")
 S CONSULT=$P(REC,":",4),PROVIDER=PROV,SITEC=$P(S,"^",4)
 S CC1=$P(REC,":",9),CC2=$P(REC,":",10),CC3=$P(REC,":",11) D CCPOP
 Q
 ;
CCPOP N I F I="CC1","CC2","CC3" I $G(INP(I))]"",$D(^RFG(INP(I))) S INP(I)=INP(I)_"  "_$P(^(INP(I)),":",2)
 Q
 ;
 ; Talk Tech - positional format, 1 line per variable
HEAD2 S FORMAT=",,MR,LAST,FIRST,,DOB,SEX,,CC,,,,,PROC1,,DS,,CONSULT,,,,,,,,,,,PROVIDER,SITEC"
 S Bb="" F J=1:1:$L(FORMAT,",") S R=$P(FORMAT,",",J) S Bb=$O(^ZAA02GSCRVI(aa,Bb)) Q:Bb=""  I R]"",^(Bb)]"" S @R=^(Bb)
 S CC1=$P(CC,"^"),CC2=$P(CC,"^",2),CC3=$P(CC,"^",3) D CCPOP
 S MR=$P(MR,".") I $G(LAST)]"" S PATIENT=LAST_$S($G(FIRST)]"":",",1:"")_$G(FIRST),MR=$P(MR,".")
 S GOOD=1 Q
 ;
 ; Dictaphone/LH - keyword format (see list below)
HEAD3 F J=1:1 S A=$P($T(HDR+J),";",2) Q:A=""  S HDR($P(A,":"))=$P(A,": ",2)
 S Bb="" F  S Bb=$O(^ZAA02GSCRVI(aa,Bb)) Q:Bb=""  Q:^(Bb)=""  S R=$P(^(Bb),":") I R]"",$D(HDR(R)) S @HDR(R)=$P(^(Bb),": ",2)
 I $G(LAST)]"" S PATIENT=LAST_$S($G(FIRST)]"":",",1:"")_$G(FIRST)
 S DS=$$DS(DS)
 S GOOD=1 Q
 ;
 ; Dictaphone/LH - positional format, 1 line per variable
HEAD4 S FORMAT="SITEC,MR,LAST,FIRST,MI,DOB,SEX,MDIR,SSN,,ACC,PROC1,DS,CONSULT,CC1,CC2,CC3,,,,,,PROVIDER,,,"
 S Bb="" F J=1:1:$L(FORMAT,",") S R=$P(FORMAT,",",J) S Bb=$O(^ZAA02GSCRVI(aa,Bb)) Q:Bb=""  I R]"" S @R=$P(^(Bb),"$") ; Removed for Radio. Assoc. of NJ.(Middle Init. problem) - ,^(Bb)]""
 S CONSULT=$P($G(CONSULT),"^")
 S DOB=$$DS($G(DOB)) D CCPOP
 S DS=$$DS($G(DS))
 S MR=$P(MR,".") I $G(LAST)]"" S PATIENT=LAST_$S($G(FIRST)]"":",",1:"")_$G(FIRST)_$S($G(MI)]"":" "_$G(MI),1:""),MR=$P(MR,".")
 S GOOD=1 Q
 ;
 ;  called from the PRINT logic of ZAA02G-SCRIPT
 ;   copies document over to a file in a folder of the host
 ;
PRINTE S (HL7,^ZAA02GSCRVO("QUEUE"))=$G(^ZAA02GSCRVO("QUEUE"))+1,^ZAA02GSCRVO("QUEUE",HL7)=DOC L +HL7EXEC2:1 E  Q
 L -HL7EXEC2 J:1 EXEC2^ZAA02GVT Q
 ;
EXEC2 L HL7EXEC2:10 E  H
 S:0 $ZT="EXECERR^ZAA02GVT" D DATE^ZAA02GSCRER
 S Q="" F  S Q=$O(^ZAA02GSCRVO("QUEUE",Q)) Q:Q=""  S GLOB=$G(^(Q)) I '$D(^(Q,0)) S GLOBT="^ZAA02GTEMP(""TEMP"","_Q_")",^(0)=1 D REPORT K ^ZAA02GSCRVO("QUEUE",Q)
 D FILEOUT I $D(^ZAA02GSCRVTC("OUTPUT")) X ^("OUTPUT")
 K:1 ^ZAA02GTEMP("TEMP")
 Q
EXECERR S ^ZAA02GSCRVTC("ERROR-OUT",$H)=$ZE Q
 ;
REPORT K @GLOBT S REC=@GLOB@(.011),SEX=$G(@GLOB@(.011,"SEX")),PROV=$P(REC,"`",7),ERR="",NDOC=+$P(GLOB,""",""",2),CONSULT=$P(REC,"`",16)
 S:SEX="" SEX=$P($G(^PTG(+$P(REC,"`",9),1)),":",10)
 F J=1:1 S RECD=$P($T(REPDATA+J),";",2,99) Q:RECD=""  S @GLOBT@(J)="" F L=1:1:$L(RECD,";") S A=$P(RECD,";",L),B=$P(A,",",3,9),C=$P(A,",",2),A=$P(A,",") S B="B="_$S(B="":"A",1:B),@B,$P(@GLOBT@(J),"|",C)=B
 D REP
 I ERR'="" S ^ZAA02GSCRVO("ERROR",$H)=ERR_" DOC: "_$G(NDOC)_" "_$G(GLOB)
 E  S @GLOBT@(0)=NDOC,(^ZAA02GSCRVO("OUT"),HL7)=$G(^ZAA02GSCRVO("OUT"))+1 M ^ZAA02GSCRVO("OUT",HL7)=@GLOBT
 K @GLOBT
 Q
REPDATA ;
 ;MSH,1;^~\&,2;,4,$$REC(6);,7,$$DT(DT);,10,Q;P,11;2.1,12
 ;PID,1;1,2;,4,$$REC(9);,6,$$NAME(8);,8,$$DT($P(REC,"`",10));,9,SEX
 ;OBR,1;,4,NDOC;,8,$$DT($P(REC,"`",11));,9,$$DT($P(REC,"`",12));,17,$$REFR(CONSULT);P,26;,33,$$PROV(PROV);,36,$$REC(5)
 ;OBX,1;5,2;TX,3
 ;
NAME(X) S X=$P(REC,"`",X) S:X[", " X=$P(X,", ")_","_$P(X,", ",2,9) Q $TR(X,", ","^^")
PROV(X) S X=$P($G(^PVG(X)),":",2)_"^"_X
 Q X
REFR(X) S X=$P($G(^RFG(X)),":",2)_"^"_X
 Q X
DS(X) Q:X="" "" Q $E($E(X,5,6)+100,2,3)_"/"_$E($E(X,7,8)+100,2,3)_"/"_$E(X,1,4)
DS2(X) Q:$L(X)=6 $E(X,5,6)_"/"_$E(X,7,8)_"/"_$E(X,3,4) Q $$DS(X)
DT(DT,TM) I $G(TM) Q $P(DT,"/",3)+1900*100+$P(DT,"/")*100+$P(DT,"/",2)*10000+$TR(TM,":")
 Q $P(DT,"/",3)+1900*100+$P(DT,"/")*100+$P(DT,"/",2)
REC(X,Y,S) Q $G(Y)_$S('$D(S):$P(REC,"`",X),1:$E(1000000000+$P(REC,"`",X),9-S+2,10))
 ;
REP I '$D(XS) S XS=$C(27),XSL=5 I $D(@GLOB@(.015)) S ZAA02G=^(.015),XS=$E(^ZAA02G(0,ZAA02G,"UO")),XSL=$L(^("UO"))
 S A=.03 I 1 S D=$O(@GLOB@(A)) Q:D=""  I ^(D)[$C(1) F I=1:1 S A=$O(@GLOB@(A)) Q:A=""  S B=$P(^(A),$C(1),4) D REPR1 I 1
 E  F I=1:1 S A=$O(@GLOB@(A)) Q:A=""  S B=^(A) D REPR1
 Q
REPR1 F L=1:1:$L(B,XS) S B=$P(B,XS)_$E($P(B,XS,2,99),XSL,255)
 I J=4 S $P(@GLOBT@(4),"|",6)=B_"~",J=J+1 Q
 S @GLOBT@(J)=B_"~",J=J+1 Q
 ;
 ;         
HDR ;
 ;PatientName_Last: LAST
 ;PatientName_First: FIRST
 ;PatientBirthDateTime: DOB
 ;PatientSex: SEX
 ;PatientAccountNumber: MR
 ;PlaceOrderNumberID:  SITEC
 ;ServiceID: PROC1
 ;OrderingProviderID: CONSULT
 ;ResultsRptDateTime: DS
 ;PrincipalInterpreterID: PROVIDER
 ;TranscriptionistID: TRANS
 ;ObservationDateTime: DS
