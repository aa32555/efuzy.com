ZAA02GFAXM3 ; ADS;2016-06-29 16:04:03;;;Tue, 07 Jul 2015  11:39
 ;
 ;
INIT K sz,tail S BD="--uuid:bdf2ec19-fff1-4e3c-9205-2d407c44da9a+id=2",CR=$C(13,10)
 S P(4)=$G(^ZAA02GFAXC("MERGE","HOST"),"12.180.164.17")
 S P(23)=$G(^ZAA02GFAXC("MERGE","CUSTID"),"ADSC")
 S PASS=$G(^ZAA02GFAXC("MERGE","USER"),"david")_":"_$G(^("PASSWORD"),"Pa$$word1")
 S A=PASS D BASE64^ZAA02GVBTER3 S P(22)=CC
 S P(24)="http://173.15.0.177:5012/iconnect^ZAA02Gvbw6w"
 Q
REGIST D INIT
 S A=$$GETM("REGISTER",$C(13,10))_CR
 D FILL D:1 SEND Q:$G(AA)=""
 I AA'["CodeType"": ""0" S ^ZAA02GFAXC("MERGE","LAST ERROR",$H)=AA Q
 F J="Username","Password","ConnectionID" S A=$P($P(AA,J,2),"""",3) S ^ZAA02GFAXC("MERGE","Connection",J)=A
 Q
SENDREP D INIT S DOC=750499
 S FAXI="^ZAA02GHTML(""TRANS"",DOC)" D GETHTML
 S ACC="2015002221"
 S A=$P($T(CCD),";",2,999) D BASE64^ZAA02GVBTER3 S P(46)=CC
 S RENPI="1231231231",READ1="123 2nd Avenue South",REZP="60606",REFID="3" ; FRANK JONES
 ;S RENPI="1467597922",READ1="397 Ridge Rd, Suite 2",REZP="08810",REFID="3"
 S DOCN=DOC
 S P(1)=$P($H,",",2),P(2)=$$DTZ($H),P(3)=$G(^ZAA02GFAXC("MERGE","Connection","ConnectionID"),"??"),P(4)=ACC,P(5)=REFID,P(6)=REFID
 S PASS=$G(^ZAA02GFAXC("MERGE","Connection","Username"))_":"_$G(^("Password"))
 S A=PASS D BASE64^ZAA02GVBTER3 S P(22)=CC ; replaces first value of P(22)
 S P(7)=RENPI,P(8)="2.16.840.1.113883.4.6",P(9)=READ1,P(10)=REZP
 S P(11)="123/1"
 S P(12)=DOCN,P(13)="text/html"
 S A=$$GETM("TAIL",$C(13,10)) S A=$E(A,1,$L(A)-2)
 D FILL S tail=A_$C(13,10,13,10)
 S A=$$GETM("SENDREPORT",$C(13,10)) S A=$E(A,1,$L(A)-2)
 S EXE="S d=0 F  S d=$O(@FAXI@(2,d)) Q:'$L(d)  W ^(d)"
 D FILL D:1 SEND Q:$G(AA)=""
 Q
 ;
 I AA'["CodeType"": ""0" S ^ZAA02GFAXC("MERGE","LAST ERROR",$H)=AA Q
 F J="Username","Password","ConnectionID" S A=$P($P(AA,J,2),"""",3) S ^ZAA02GFAXC("MERGE","Connection",J)=A
 Q
DTZ(X) N Z S Z=$ZD(+X) Q $P(Z,"/",3)_"-"_$P(Z,"/")_"-"_$P(Z,"/",2)_"T"_$P($ZTIME($P(X,",",2))," ")_".5Z"
 ;
CCD ;<ClinicalDocument xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:hl7-org:v3" xsi:schemaLocation="urn:hl7-org:v3 http://hit-testing.nist.gov:11080/hitspValidation/schema/cdar2c32/infrastructure/cda/C32_CDA.xsd">
 ;
 ; ON CALL BACK
 ; {"ReplyTo":"e415bbf1-f913-4bf8-9443-6eb027061d46","Success":false,"DeliveryMethod":"Unknown","FailureCode":"200","Details":"Recipient could not be found."}
 ;
 ;
LOGON D INIT
 S P(1)="Login",A=$$GETM("HEAD",$C(13,10))_BD_"--"_CR,P(5)=$P($T(login),";",2,99)
 D FILL D:1 SEND Q:$G(AA)=""
 I AA'["<StatusCode>0<" S ^ZAA02GFAXC("MERGE","LAST ERROR",$H)=AA Q
 I AA["<AuthToken>" S ^ZAA02GFAXC("MERGE","TOKEN")=$P($P(AA,"<AuthToken>",2),"</AuthToken>")
 Q
 ;
LOGOUT D INIT
 S P(1)="Logout",A=$$GETM("HEAD",$C(13,10))_BD_"--"_CR,P(5)=$P($T(logout),";",2,99)
 S P(20)=$G(^ZAA02GFAXC("MERGE","TOKEN")) Q:P(20)=""
 D FILL,SEND
 I AA'["<StatusCode>0<" S ^ZAA02GFAXC("MERGE","LAST ERROR",$H)=AA Q
 K ^ZAA02GFAXC("MERGE","TOKEN")
 Q
 ;
GETFAX ;
QUERYFAX D INIT
 S P(1)="QuerySendFax",A=$$GETM("HEAD",$C(13,10))_BD_"--"_CR,P(5)=$P($T(queryfax),";",2,99)
 ;S P(20)=$G(^ZAA02GFAXC("MERGE","TOKEN")) Q:P(20)=""
 S P(30)=ID
 D FILL D:1 SEND Q:$G(AA)=""
 S ^ZAA02GFAXC("MERGE","LAST QUERY RESULT")=AA
 Q
 Q
 ;
FILL D FILL^ZAA02GVBW2
 Q
 ;
SEND D GETIP
 I A["++" S L=$L($P(A,$C(13,10,13,10),2,9999)_$G(tail))+$G(sz),A=$P(A,"++")_L_$P(A,"++",2,99)
 S DATA=A
 D NET
 Q
 ;  S A="USERNAME: MARK" D BASE64^ZAA02GVBTER3  > CC
 ;
 ;  W $$UUDEC^ZAA02GWEBU(CC)
 ;
 ;
NET S $ZT="NETER^ZAA02GFAXM2",DEV="TCP3",OS=^ZAA02G("OS"),C1=+$H,C2=$P($H,",",2) S:$D(^PROBE("CONNECT",C1,C2)) C2=$O(^(""),-1)+.01 S ^PROBE("CONNECT",C1,C2)=IP_"-"_PORT_"-"_$J_"-"_$E($G(DATA),1,150)
 S TMO=30
 I $G(DELAY)]"" H DELAY
 I OS="M3" O DEV:(IP_"/"_PORT:"") U DEV S ZC=$ZC
 I OS="M11" D
 . S DEV="|TCP|"_PORT S ZC=1 C DEV O DEV:(IP:PORT:"AS"):15 Q:'$T  S ZC=0 U DEV
 I ZC D  C DEV L -PROBE(IP) Q
 . S $P(^PROBE("CONNECT",C1,C2),"`",3)=$P($H,",",2)_" NO CONNECTION - "_ZC,(AA,ERROR,X)="ERROR-NO-CONNECTION"
FF W DATA I $G(EXE)]"" X EXE
 W $g(tail),!
 K X S AA=""
 S TT=0 H 1
PROBE2 R X:1 S TT=TT+1 I TT>15 G PROBET
 S AA=AA_X I AA'[$C(13,10,13,10)!(AA'[$C(125)) G PROBE2
 S X=AA,^PROBE("CONNECT",C1,C2,$H)=$E(X,1,500)
PROBE4 C DEV L -PROBE(IP) Q
PROBE3 D PROBE4 Q:C=10054  S ^PROBE("COMM-ERROR",C1,C2)=C,(ERROR,X)="ERROR-"_C Q
NETER D PROBE4 S ^PROBE("ERROR",C1,C2)=$ZE_" "_$G(X),(ERROR,X)="ERROR-"_$ZE Q
PROBET D PROBE4 S ^PROBE("TIME-OUT",C1,C2)=$H_","_$ZE,(ERROR,X)="ERROR-TIME-OUT" Q
 ;
 Q
CONNECT ; ZAA02GWEB
 ; ZT 6
 W 1234,! Q
 ;
GETHTML I '$D(^ZAA02GHTML("TRANS",DOC)) D
 . I $D(^ZAA02GPDF("SETUP","PATH")) D
 .. S P1=DOC N (P1) S:1 HTML=1 D JOBPDF^ZAA02GVBTERP(P1)
 .
 S sz=$G(@FAXI@(2)) Q:sz
 S (A,E,d,sz)="",dd=1 F  S d=$O(@FAXI@(1,d)) Q:d=""  S E=E_^(d) I $L(E)>57 D
 . F  S A=$E(E,1,57),E=$E(E,58,9999) D BASE64^ZAA02GVBTER3 S @FAXI@(2,dd)=CC,dd=dd+1,sz=sz+$L(CC) Q:$L(E)<57
 I E]"" S A=E D BASE64^ZAA02GVBTER3 S @FAXI@(2,dd)=CC,sz=sz+$L(CC)
 S @FAXI@(2)=sz
 Q
 ;
GETIP ;
 S IP=$G(^ZAA02GFAXC("MERGE","IP"),"10.60.16.3"),PORT=$G(^ZAA02GFAXC("MERGE","PORT"),"80")
 Q
 ;
GETM(X,Y) N J,B S B="" F J=0:1 Q:$P($T(@X+J),";",2)="/"  S B=B_$P($T(@X+J),";",2,999)_$G(Y)
 Q B
 ;
 ;
 ;
REGISTER ;POST https://icnsandbox.merge.com/api/ReportSource/Register HTTP/1.1
 ;Host: icnsandbox.merge.com
 ;Authorization: Basic *22
 ;Content-Type: application/json
 ;Content-Length: ++
 ;
 ;{"CustomerID" : "*23","CallbackUrl" : "*24","SoftwareReleaseVersion" : "1.0","SoftwareName" : "ChicagoSoft",}
 ;/
 ;
SENDREPORT ;POST https://icnsandbox.merge.com/api/ReportSource/Reports HTTP/1.1
 ;Host: icnsandbox.merge.com
 ;Authorization: Basic *22
 ;Content-Type: application/json
 ;Content-Length: ++
 ;
 ;{"MessageId":"*1","SentTime":"*2","ConnectionId":"*3","OrderFillerNumber":"*4","OrderingPhysicianIdentifiers": [{"Identifier":"*5","IdentifierTypeDef": "RISID"}],
 ;"ReferringPhysicians": [{"PhysicianIdentifiers": [{"Identifier": "*6","IdentifierTypeDef": "RISID" }],}],
 ;"Recipients": [{"RecipientIdentifiers": [{"Identifier":"*7","IdentifierTypeDef": "*8"}],"RecipientAddressLine1": "*9","RecipientZipCode":"*10","RecipientDeliveryMethod": "Default"}],
 ;"PatientIdentifiers": [{"Identifier":"*11","IdentifierTypeDef":"RISID"}],
 ;"ClinicalMessageMIMEType": "text/plain","ClinicalMessageData": "see attached file","ReportName": "*12","ReportMIMEType": "*13","ReportData":"
 ;/
 ;
TAIL ;","ReportStatus":"Final","AccessionNumber":"12345","AccessionNumberType":"default",
 ;"StructuredReport" : [{"Title":"Some Report Title","Text":"\r\nJacket Number:  7831\r\n\r\n1999 Wabash Ave Springfield, Il  62704-5351 \r\n\r\n\r\n\r\n\r\ncc: \r\n\r\r\r",
 ;"Code":{"Value":"2343","System":"56","SystemName":"0765700","DisplayName":"678"}}],
 ;}
 ;/
 ;
 ;"CCD":"*47"}
