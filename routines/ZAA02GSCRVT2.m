ZAA02GSCRVT2 ;PG&A;2014-07-10 17:23:46;HL/7 - TCP;14DEC98  16:58;23MAR2000  14:13
 ;
 Q
START J OUTPUT^ZAA02GSCRVT2 Q
 ;
 ;  Send HL7 records queued in ^ZAA02GSCRVT() using TCP/IP.
 ;   ^ZAA02GSCRVTL("TCP") = IP ADDRESS, ^ZAA02GSCRVTL("PORTO") = output port
 ;
OUTPUT ;  HERE TO START CLIENT TO SEND ORDERS/REPORTS
 K  L ^ZAA02GSCRVT:10 E  H  ; already running
 S A=^ZAA02G("ERROR")_"=""ERROR^ZAA02GSCRVT1""",@A,^ZAA02GSCRVTL("START",$H,1)="O" K ^ZAA02GSCRVTL("STOP")
 D IP I IP="" S ^ZAA02GSCRVTL("NOOPEN",$H)="NO ADDRESS DEFINED" H
 S port=PORTO D TCPC I TCP="" S ^ZAA02GSCRVTL("NOOPEN",$H)="Open Error "_port_"-"_$G(lzb)_":"_$G(lzc) Q
ORD S A="" F  G:$D(^ZAA02GSCRVTL("STOP")) HALT S A=$O(^ZAA02GSCRVT(A)) Q:A=""  U TCP D ORDB
 Q
ORDB Q:'$D(^ZAA02GSCRVT(A))  W $C(11),^ZAA02GSCRVT(A,1),*13 F J=2:1 Q:'$D(^(J))  W ^(J),*13
 W $C(28,13),! R *R:30 I R'=11 Q:$D(^ZAA02GSCRVTL("STOP"))  H 5 R *B:25 G ORDB:B'=11
 S R="" F  R *B:25 G:'$T ORDB Q:B=28  S R=R_$S($L(R)<255:$C(B),1:"")
 G:R'["MSA|A" ORDB  S B=$P($P($P(R,"MSA|",2),"|",2),$C(13)) G:B="" ORDB
 I R["MSA|AR"!(R["MSA|AE") S ^ZAA02GSCRVTL("AR",B)=$G(^ZAA02GSCRVT(B))_";"_R K ^ZAA02GSCRVT(B) Q
 G:R'["AA" ORDB S ^ZAA02GSCRVTL("AA",B)=$H_","_$G(^ZAA02GSCRVT(B)) M ^ZAA02GSCRVTL("SENT_ORDERS",-B)=^ZAA02GSCRVT(B) K ^ZAA02GSCRVT(B)
 Q
 ;
IP S IP=$G(^ZAA02GSCRVTL("TCP")),PORTO=$G(^("PORTO")) Q
TCPS S TRY=0,ip="" G INITS ;  SERVER
TCPC S TRY=0,ip=IP G INITS ;  CLIENT
INITS G:$G(^ZAA02G("OS"))'="MSM" INITM C 56 O 56:(:0):"TCP" U 56 S KEY=$KEY,TCP=""
INITS2 W /SOCKET(ip,port) S %xddb=$KEY,lza=$ZA,lzb=$ZB,lzc=$ZC,ZC="s zc=$ZC"
 I lzc&(lzb=-8) S TRY=TRY+1 G INITS2:TRY<3 Q
 I lzc S TRY=TRY+1 G INITS:TRY<3 Q
 S TCP=56 Q
INITM S TCP="|TCP|"_port,ZC="s zc=$za\4#1" O TCP:(ip:port:"AS") Q:ip'=""
 U TCP R *%xddb Q
 ;
ERROR S B="B="_^ZAA02G("ERRORR"),@B,^ZAA02GSCRVTL("ERROR",$H)=B H 5 C:TCP'="" TCP S TCP="" Q
HALT S ^ZAA02GSCRVTL("STOPPED",$H)="" H
 ;
 ;                                       
FORMAT ;  REPORT & ACK
 ;MSH|^~\&|ZAA02GSCRIPT|FACILITY|||TIMESTAMP|MESSTYPE|CONTROL ID
 ;PID|||MRN||NAME|........|19TH PIECE = SSAN
 ;ORC|RE
 ;OBR|||ACCESSION#|SERVICE ID|......|22.STATUS CHANGE|26.P|32.DOCTOR
 ;OBX|SEQ #|FT|STUDY||FINDINGS
 ;
 ;MSH|^~\&|||||||ACK|
 ;MSA|AA|CONTROL ID        AA=ACCEPT, AE=ERROR, AR=REJECTED
 ;
 ;  ORDERS
 ;MSH|^~\&||||||8.ORU|9.MESSAGE CONTROL ID
 ;PID|||4.MRN||6.NAME||8.DOB|SEX|........|19.SSAN
 ;OBR|||4.ACCESSION#|5.EXAM CODE|||8.EXAM DATE&TIME|....|17.DOCTOR
 ;
 Q
 ;
 ; FOLLOWING LOGIC TO CREATE HL7 ORDER RECORDS FROM ADS SCHEDULING
 ;
 ;  This is accomplished by inserting a line into APPCH or APP3 that
 ;  traps a registration or scheduling event.  This causes and entry
 ;  into the ZAA02GSCRVP log for this patient.  A background process
 ;  then expands this patient info into a HL7 order record and
 ;  adds these records to the ZAA02GSCRVT queue.
 ;
 ;  Another background job is started that sends the queued HL7 
 ;  records to the remote site.  OUTPUT^ZAA02GSCRVT2
 ;
 ;
 ;INSERTED INTO ROUTINE  ^APPCH 
 ;S ^ZAA02GSCRVP=$G(^ZAA02GSCRVP)+1,^ZAA02GSCRVP(^ZAA02GSCRVP)=":"_SDATE_":"_K_"/"_K1 J POSTAP^ZAA02GSCRVT1 Q
 ;
 ;  setup for interface to TALK TECH box  - ^APP3
 ;S ^ZAA02GSCRVA=$G(^ZAA02GSCRVA)+1,^ZAA02GSCRVA(^ZAA02GSCRVA)=EZ_":"_K_"/"_K1_":"_DATE_":"_$G(RFG) J POSTAP^ZAA02GSCRVT1
 ;
POSTAP S A=^ZAA02G("ERROR")_"=""POSTE^ZAA02GSCRVT1""",@A
 S A="" F  S A=$O(^ZAA02GSCRVA(A)) Q:A=""  S B=^(A) K ^(A) S $P(B,":",2,3)=$P(B,":",3)_":"_$P(B,":",2) D POST(A,B)
 S A="" F  S A=$O(^ZAA02GSCRVP(A)) Q:A=""  S B=^(A) K ^(A) D POST(A,B)
 J OUTPUT^ZAA02GSCRVT1 Q
 ;
POST(ACCESSN,TR) ; ENTRY FROM POSTING ROUTINE FOR ADS
 N (ACCESSN,TR) S SITE="ADS",EXAMDATE=$P(TR,":",2) S:$L(EXAMDATE)=6 EXAMDATE="19"_EXAMDATE
 S K=$P(TR,":",3),K1=1,RFG=$P(TR,":",4,99) Q:K=""  I K["/" S K1=$P(K,"/",2),K=+K
 S GRG=$G(^GRG(K)),PTG=$G(^PTG(K,K1)),MR=K S:K1>1 MR=MR_","_K1
 S NAME=$P(PTG,":",3) S:NAME="" NAME=$P(GRG,":",7)
 s DOB=$P(PTG,":",12) S:$L(DOB)=6 DOB="19"_DOB
 S TT=$P(PTG,":",12),EXAM=$P(TR,":",6) S:EXAM]"" EXAM=EXAM_"^"_$P($G(^INPC(EXAM)),":",2) S:EXAM="" EXAM="NA^NOT AVAILABLE"
 S RF=$P(RFG,":"),(RFF,RFL,RFCSZ)="" I RF="" S RF=$P(PTG,":",16) I RF]"" S RFG=$G(^RFG(RF))
 I RF]"" D RFF^ZAA02GADS1 S RFF=T D RFL^ZAA02GADS1 S RFL=T ;,RFA1=$P(RFG,":",4),RFA2=$P(RFG,":",5),RFCSZ=$P(RFG,":",6)_"  "_$P(RFG,":",7),RFFAX=$P(RFG,":",21)
 I RF]"" S RFER=RF_"^"_RFF_" "_RFL_" "_RFCSZ
 ;
QUEUE N X D DATE^ZAA02GSCRER
 S NAME=$TR(NAME,", ","^^")
 S (^ZAA02GSCRVT,ORDER,ACCESSN)=$G(^ZAA02GSCRVT)+1
 D ORDER
 S A=$G(^ZAA02GSCRVT) ; F A=A:-1:A-200 I $D(^ZAA02GSCRVTL("AA",A)),$P(B,"|",3,8)=$P(^(A),"|",3,8),$P(B,"|",10,11)=$P(^(A),"|",10,11) G Q1
 ;  note - making mess # and assession # = queue #
 S ^ZAA02GSCRVT(ORDER,1)=D(1) F J=2:1 Q:'$D(D(J))  S ^(J)=D(J)
 I $D(^ZAA02GSCRVTL("STOP")) Q
 L +^ZAA02GSCRVT:0 I  L -^ZAA02GSCRVT J OUTPUT^ZAA02GSCRVT1
 Q
POSTE S A="A="_^ZAA02G("ERRORR"),@A,^ZAA02GSCRVTL("ERROR",$H)="POST ERROR - "_A_" "_B H 5 G POSTAP
 ;
ORDER ; fill hl7 records with order info
 F J=1:1 S RECD=$P($T(ORDDATA+J),";",2,99) Q:RECD=""  S D(J)="" F L=1:1:$L(RECD,";") S A=$P(RECD,";",L),B=$P(A,",",3,9),C=$P(A,",",2),A=$P(A,",") S B="B="_$S(B="":"A",B?1.A:"$G("_B_")",1:B),@B,$P(D(J),"|",C)=B
 Q
ORDDATA ;
 ;MSH,1;^~\&,2;,3,$$TYP;,4,SITE;,7,$$DT(DT);ORU,9;,10,ORDER
 ;PID,1;,4,MR;,6,NAME;,8,DOB;,9,SEX;,19,ACCT;,20,SSAN
 ;OBR,1;,4,ACCESSN;,5,EXAM;,8,EXAMDATE;,17,RFER
 ;
TYP() Q "ZAA02GSCRIPT"
DT(DT,TM) I $G(TM) Q $P(DT,"/",3)+1900*100+$P(DT,"/")*100+$P(DT,"/",2)*10000+$TR(TM,":")
 Q $P(DT,"/",3)+1900*100+$P(DT,"/")*100+$P(DT,"/",2)
 ;
 ;
 ;
 ;
 ;  THIS CODE GETS CALLED BY ZAA02GSCRIPT WHEN PRINTING REPORT
PRINTE S (HL7,^ZAA02GSCRHL7("QUEUE"))=$G(^ZAA02GSCRHL7("QUEUE"))+1,^ZAA02GSCRHL7("QUEUE",HL7)=DOC L HL7EXEC2:1 E  Q
 L  J:1 EXEC2^ZAA02GSCRHL7ADS Q
 ;
EXEC2 L HL7EXEC2:10 E  H
 S:'$D(TEST) $ZT="EXECERR^ZAA02GSCRHL7ADS" D DATE^ZAA02GSCRER
 S Q="" F  S Q=$O(^ZAA02GSCRHL7("QUEUE",Q)) Q:Q=""  S GLOB=$G(^(Q)) I '$D(^(Q,0)) S GLOBT="^ZAA02GSCRHL7(""TEMP"",$J)",^(0)=1 D REPORT K ^ZAA02GSCRHL7("QUEUE",Q)
 Q:$D(^ZAA02GSCRHL7("STOP"))
 I $D(^ZAA02GSCRHL7("OUTPUT")) X ^("OUTPUT")
 Q
 ;
REPORT K @GLOBT S REC=@GLOB@(.011),SEX=$G(@GLOB@(.011,"SEX")),PROV=$P(REC,"`",7),ERR="",NDOC=+$P(GLOB,""",""",2),CONSULT=$P(REC,"`",16)
 S:SEX="" SEX=$P($G(^PTG(+$P(REC,"`",9),1)),":",10)
 F J=1:1:4 S RECD=$P($T(REPDATA+J),";",2,99) S @GLOBT@(J)="" F L=1:1:$L(RECD,";") S A=$P(RECD,";",L),B=$P(A,",",3,9),C=$P(A,",",2),A=$P(A,",") S B="B="_$S(B="":"A",1:B),@B,$P(@GLOBT@(J),"|",C)=B
 D REP
 I ERR'="" S ^ZAA02GSCRHL7("ERROR",$H)=ERR_" DOC: "_$G(NDOC)_" "_$G(GLOB)
 E  S (^ZAA02GSCRHL7("OUT"),HL7)=$G(^ZAA02GSCRHL7("OUT"))+1 M ^ZAA02GSCRHL7("OUT",HL7)=@GLOBT
 K @GLOBT Q
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
