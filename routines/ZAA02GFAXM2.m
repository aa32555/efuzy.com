ZAA02GFAXM2 ; ADS;2016-06-29 16:04:03;;;Mon, 06 Jun 2016  16:09
 ;
 ;
oldSENDFAX ;
 S CODE=$G(^ZAA02GFAXC("SOFTLINX","CODE")) ; local area code
 s CR=$C(13,10),MM="" F J=32:1:125 S MM=MM_$C(J)
 S MM=$TR(MM,"0123456789")
 S FAX=$TR(FAX,MM)
 I $L(FAX)<11 S:FAX?7N FAX=CODE_FAX S:FAX?10N FAX="1"_FAX
 S faxNumber="00"_FAX
 S DATA="POST /outbound/faxes?"
 ; S DATA="POST /xml/connect^ZAA02Gfaxm?"
 ;
 D GETPDF
 S A="" F J="faxNumber","contact","csid","pageheader","reference" I $G(@J)]"" S:1 DATA=DATA_A_J_"="_(@J),A="&" S:0 DATA=DATA_A_J_"=%7B"_(@J)_"%7D",A="&"
 S DATA2="Content-Type: application/pdf"_CR_"Content-Length: "_sz_CR
 S EXE="S D="""" F  S D=$O(@FAXI@(1,D)) Q:D=""""  W ^(D)"
 D SEND S RID=+$P(AA,"/faxes/",2) I AA'["201 Created" S RID="ERROR: "_AA
 Q
 ;
 ;http://faxtest.softlinx.com:8080/softlinx/replixfax/wsapi
 ;https://faxtest.softlinx.com:8083/softlinx/replixfax/wsapi
 ; web site http://faxtest.softlinx.com    use admin@adsc
 ;
INIT K sz,tail,P S BD="--uuid:bdf2ec19-fff1-4e3c-9205-2d407c44da9a+id=2",CR=$C(13,10)
 S P(4)=$G(^ZAA02GFAXC("SOFTLINX","HOST"),"faxtest.softlinx.com:8080")
 S P(10)=$G(^ZAA02GFAXC("SOFTLINX","USER")),P(12)=$G(^ZAA02GFAXC("SOFTLINX","REALM")),PASS=$G(^("PASSWORD"))
 S A=PASS D BASE64^ZAA02GVBTER3 S P(11)=CC
 Q
 ;
LOGON D INIT
 S P(1)="Login",A=$$GETM("HEAD",$C(13,10))_BD_"--"_CR,P(5)=$P($T(login),";",2,99)
 D FILL D:1 SEND Q:$G(AA)=""
 I AA'["<StatusCode>0<" S ^ZAA02GFAXC("SOFTLINX","LAST ERROR",$H)=AA Q
 I AA["<AuthToken>" S ^ZAA02GFAXC("SOFTLINX","TOKEN")=$P($P(AA,"<AuthToken>",2),"</AuthToken>")
 Q
 ;
LOGOUT D INIT
 S P(1)="Logout",A=$$GETM("HEAD",$C(13,10))_BD_"--"_CR,P(5)=$P($T(logout),";",2,99)
 S P(20)=$G(^ZAA02GFAXC("SOFTLINX","TOKEN")) Q:P(20)=""
 D FILL,SEND
 I AA'["<StatusCode>0<" S ^ZAA02GFAXC("SOFTLINX","LAST ERROR",$H)=AA Q
 K ^ZAA02GFAXC("SOFTLINX","TOKEN")
 Q
 ;
TESTSF ; TEST SEND FAX WITH ONE A RANDOM PDF DOCUMENT
 R "Enter Fax # (18478708559) - ",FAX,! I FAX="" S FAX="18478708559"
 R "Enter FaxTo (Support) - ",FAXTO,! I FAXTO="" S FAXTO="Support"
 R "Enter Document (last) - ",DOC,!
 I DOC="" S DOC=$O(^ZAA02GPDF("TRANS",""))
 S FAXI="^ZAA02GPDF(""TRANS"",NM)",NM=DOC
 D SENDFAX C DEV
 W "IP-",IP," Port-",PORT,!
 I $G(ERROR)]"" W "ERROR=",ERROR,!
 W !,"Result: ",$G(AA),! Q
 ;
SENDFAX D INIT
 S CODE=$G(^ZAA02GFAXC("SOFTLINX","CODE")) ; local area code
 s CR=$C(13,10),MM="" F J=32:1:125 S MM=MM_$C(J)
 S MM=$TR(MM,"0123456789"),NM2=$TR(NM,"-")
 S FAX=$TR(FAX,MM)
 I $L(FAX)<11 S:FAX?7N FAX=CODE_FAX S:FAX?10N FAX="1"_FAX
 S P(30)=FAX,P(31)=$G(contact),P(40)=NM2_".PDF"
 I $G(^ZAA02GFAXC("SOFTLINX","EXTRA"))]"" D
 . S D=$G(^ZAA02GFAXQ("DIR",10000-NM2)) Q:D=""  S D=$P(^(10000-NM2),"\",2) Q:D=""  S REC=$G(^ZAA02GSCR("TRANS",D,.011)),K=$P(REC,"`",9),K1=1 S:K["/" K1=$P(K,"/",2),K=+K
 . X ^ZAA02GFAXC("SOFTLINX","EXTRA")
 D GETPDF
 S EXE="S D="""" F  S D=$O(@FAXI@(1,D)) Q:D=""""  W ^(D)"
 ;
 S P(1)="SendFax",A=$$GETM("HEAD",$C(13,10))_BD_CR,P(5)=$$GETM("sendfax")
 ; S P(20)=$G(^ZAA02GFAXC("SOFTLINX","TOKEN"))
 S A=A_BD_CR_"Content-ID: <http://tempuri.org/1/635362626113949894>"_CR_"Content-Transfer-Encoding: binaryContent-Type: application/octet-stream"_CR_CR ; then the attachment
 S tail=CR_BD_"--"_CR
 D FILL D:1 SEND Q:$G(AA)=""
 I AA'["<StatusCode>0<" S ^ZAA02GFAXC("SOFTLINX","LAST ERROR",$H)=AA Q
 S RID=$P($P(AA,"<FaxId>",2),"</FaxId>")
 Q
 ;
GETFAX ;
QUERYFAX D INIT
 S P(1)="QuerySendFax",A=$$GETM("HEAD",$C(13,10))_BD_"--"_CR,P(5)=$P($T(queryfax),";",2,99)
 ;S P(20)=$G(^ZAA02GFAXC("SOFTLINX","TOKEN")) Q:P(20)=""
 S P(30)=ID
 D FILL D:1 SEND Q:$G(AA)=""
 S ^ZAA02GFAXC("SOFTLINX","LAST QUERY RESULT")=AA
 Q
 Q
 ;
FILL D FILL^ZAA02GVBW2
 S L=$L($P(A,"Keep-Alive",2,9))-4+$G(sz)+$L($g(tail)),A=$P(A,"~")_L_$P(A,"~",2,9)
 Q
 ;
SEND D GETIP S DATA=A
 D NET
 Q
 ;  S A="USERNAME: MARK" D BASE64^ZAA02GVBTER3  > CC
 ;
 ;  W $$UUDEC^ZAA02GWEBU(CC)
 ;
 ;
NET L +PROBE(IP):300 E  S ERROR="LOCKED" Q
 S $ZT="NETER^ZAA02GFAXM2",DEV="TCP3",OS=^ZAA02G("OS"),C1=+$H,C2=$P($H,",",2) S:$D(^PROBE("CONNECT",C1,C2)) C2=$O(^(""),-1)+.01 S ^PROBE("CONNECT",C1,C2)=IP_"-"_PORT_"-"_$J_"-"_$E($G(DATA),1,150)
 S TMO=30
 I $G(DELAY)]"" H DELAY
 I OS="M3" O DEV:(IP_"/"_PORT:"") U DEV S ZC=$ZC
 I OS="M11" D
 . S DEV="|TCP|"_PORT S ZC=1 C DEV O DEV:(IP:PORT:"AS"):15 Q:'$T  S ZC=0 U DEV
 I ZC D  C DEV L -PROBE(IP) Q
 . S $P(^PROBE("CONNECT",C1,C2),"`",3)=$P($H,",",2)_" NO CONNECTION - "_ZC,(AA,ERROR,X)="ERROR-NO-CONNECTION"
FF W DATA,! I $G(EXE)]"" X EXE ; W CR,CR
 W $g(tail),!
 K X S AA=""
 S TT=0
PROBE2 R X:1 S TT=TT+1 I TT>45 G PROBET
 S AA=AA_X I AA'[$C(13,10,13,10) G PROBE2
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
GETPDF I $P($G(@FAXI@(1)),",",3)="" D
 . S d="",sz=0 F  S d=$O(@FAXI@(1,d)) Q:d=""  S sz=sz+$L(^(d))
 . S $P(@FAXI@(1),",",3)=sz
 S sz=$P($G(@FAXI@(1)),",",3) Q:sz
 Q
 ; this is not required
 ;
 S sz=$G(@FAXI@(2)) Q:sz
 S (A,E,d,sz)="",dd=1 F  S d=$O(@FAXI@(1,d)) Q:d=""  S E=E_^(d) I $L(E)>57 D
 . F  S A=$E(E,1,57),E=$E(E,58,9999) D BASE64^ZAA02GVBTER3 S @FAXI@(2,dd)=CC_$C(13,10),dd=dd+1,sz=sz+$L(CC)+2 Q:$L(E)<57
 I E]"" S A=E D BASE64^ZAA02GVBTER3 S @FAXI@(2,dd)=CC_$C(13,10),sz=sz+$L(CC)+2
 S @FAXI@(2)=sz
 Q
 ;
GETIP ; S IP=$$NAME^ZAA02GWEBN("rest.interfax.net"),PORT=80
 S:0 IP="10.1.10.75",PORT=8066
 S:0 IP="127.0.0.1",PORT=8066
 I 1 S IP=$G(^ZAA02GFAXC("SOFTLINX","IP"),"127.0.0.1"),PORT=$G(^ZAA02GFAXC("SOFTLINX","PORT"),"8080")
 Q
 ;
WRAP K dd S dd="",(BOUN,BOUN2)="------=_NextPart_000_04A4_01CC94C8.5BE20190",$P(BOUN2,"_",3)="001",CR=$C(13,10)
 S dd=CR_BOUN_"--"_CR_CR
 I 0 D
 . S MESS=$G(^ZAA02GSCR("PARAM","EMAIL PDF REPORT MESSAGE"),"Please see the Password Protected PDF for a Medical Report")
 . S dd="multipart/mixed;"_$C(13,10,9)_"boundary="""_$E(BOUN,3,99)_""""_CR_CR_"this is a multi-part message in MIME format."_CR_CR
 . S dd=dd_BOUN_CR_"Content-Type: multipart/alternative;"_$C(13,10,9)_"boundary="""_$E(BOUN2,3,99)_""""_CR_CR_CR
 . S dd=dd_BOUN2_CR_"Content-Type: text/plain;"_$C(13,10,9)_"charset=""iso-8859-1"""_CR_"Content-Transfer-Encoding: quoted-printable"_CR_CR
 . S dd=dd_MESS_CR_CR
 . S dd=dd_BOUN2_CR_"Content-Type: text/html;"_$C(13,10,9)_"charset=""iso-8859-1"""_CR_"Content-Transfer-Encoding: quoted-printable"_CR_CR
 . S dd=dd_"<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">"_CR_"<HTML><HEAD>"_CR
 . S dd=dd_"<META content=3D""text/html; charset=3Diso-8859-1"" = http-equiv=3DContent-Type>"_CR
 . S dd=dd_"<META name=3DGENERATOR content=3D""MSHTML 8.00.6001.19088"">"_CR
 . S dd=dd_"</HEAD><BODY><DIV>"
 . S dd=dd_MESS_"</DIV></BODY></HTML>"_CR_CR
 . S dd=dd_BOUN2_"--"_CR_CR_BOUN_CR_"Content-Type: application/pdf;"_$C(9)_"name="""_KK_".pdf"""
 . S XFRTYPE="Content-Transfer-Encoding: base64"_CR_"Content-Disposition: attachment;"_$C(9)_"filename="""_KK_".pdf""",d="^ZAA02GFAXI("_KK_",2)",BINHEX=1 d SMAIL^ZAA02GWEMSM
 . S d="^ZAA02GFAXQ(""SRC"","_KK_")"
 Q
GETM(X,Y) N J,B S B="" F J=0:1 Q:$P($T(@X+J),";",2)="/"  S B=B_$P($T(@X+J),";",2,999)_$G(Y)
 Q B
 ;
 ;
 ;
HEAD ;POST /softlinx/replixfax/wsapi HTTP/1.1
 ;MIME-Version: 1.0
 ;Content-Type: multipart/related; type="application/xop+xml";start="<http://tempuri.org/0>";boundary="uuid:bdf2ec19-fff1-4e3c-9205-2d407c44da9a+id=2";start-info="text/xml"
 ;SOAPAction: "http://www.softlinx.com/wsapi/op=*1/ver=11"
 ;Host: *4
 ;Content-Length: ~
 ;Connection: Keep-Alive
 ;
 ;--uuid:bdf2ec19-fff1-4e3c-9205-2d407c44da9a+id=2
 ;Content-ID: <http://tempuri.org/0>
 ;Content-Transfer-Encoding: 8bit
 ;Content-Type: application/xop+xml;charset=utf-8;type="text/xml"
 ;
 ;<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"><s:Body xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
 ;*5</s:Body></s:Envelope>
 ;/
login ;<Login xmlns="http://www.softlinx.com/ReplixFax"><LoginInput xmlns=""><Authentication><Login>*10</Login><Password>*11</Password><PasswordSecurity>base64</PasswordSecurity><Realm>*12</Realm></Authentication></LoginInput></Login>
 ;
logout ;<Logout xmlns="http://www.softlinx.com/ReplixFax"><LogoutInput xmlns=""><AuthenticationToken><AuthToken>*20</AuthToken></AuthenticationToken></LogoutInput></Logout>
 ;
sendfax ;<SendFax xmlns="http://www.softlinx.com/ReplixFax"><SendFaxInput xmlns=""><Authentication><Login>*10</Login><Password>*11</Password><PasswordSecurity>base64</PasswordSecurity><Realm>*12</Realm></Authentication><AuthenticationToken><AuthToken>*20</AuthToken></AuthenticationToken>
 ;<FaxRecipient><FaxNumber>*30</FaxNumber><RcptName>*31</RcptName><RcptCompany>*32</RcptCompany><RcptVoice>*33</RcptVoice></FaxRecipient>
 ;<Attachment><FileName>*40</FileName><AttachmentContent><xop:Include href="cid:http%3A%2F%2Ftempuri.org%2F1%2F635362626113949894" xmlns:xop="http://www.w3.org/2004/08/xop/include"/></AttachmentContent></Attachment>
 ;<ProjectCode>*44</ProjectCode><ProjectCode2>*45</ProjectCode2>
 ;</SendFaxInput></SendFax>
 ;/
 ;
 ;
 ;<Attachment><FileName>*40</FileName><AttachmentContent><xop:Include href="cid:http%3A%2F%2Ftempuri.org%2F2%2F635362626113949894" xmlns:xop="http://www.w3.org/2004/08/xop/include"/></AttachmentContent></Attachment>
 ;<CoverPageEnabled>false</CoverPageEnabled><CoverMessage/><CoverField FieldId="ID FOR COVER"></CoverField><FaxHeaderEnabled>false</FaxHeaderEnabled><NotifySuccess>false</Notifss>false</NotifySuccess><NotifyFailed>false</NotifyFailed><NotifyFailedAttachFax>false</NotifyFailedAttachFax>
 ;Content-ID: <http://tempuri.org/1/635362626113949894>
 ;Content-Transfer-Encoding: binaryContent-Type: application/octet-stream
 ; not used -queries all waiting faxes
queryfax ;<QuerySendFax xmlns="http://www.softlinx.com/ReplixFax"><QuerySendFaxInput xmlns=""><Authentication><Login>*10</Login><Password>*11</Password><PasswordSecurity>base64</PasswordSecurity><Realm>*12</Realm></Authentication><AuthenticationToken><AuthToken>*20</AuthToken></AuthenticationToken><FaxId>*30</FaxId></QuerySendFaxInput></QuerySendFax>
 ;
 ; (response)
 ;.....<AuthToken>aaaaaa</AuthToken><StatusCode>0</StatusCode>......
 ;
 ;
 ;Logout
 ;.....SOAPAction: "http://www.softlinx.com/wsapi/op=Logout/ver=11"....
 ;....<Logout xmlns="http://www.softlinx.com/ReplixFax"><LogoutInput xmlns=""><AuthenticationToken><AuthToken>aaaa</AuthToken></AuthenticationToken></LogoutInput></Logout>....
 ;
 ;
SOAPH ;<?xml version="1.0" encoding="UTF-8"?><soapenv:Envelope xmlns:soapenv=""http://schemas.xmlsoap.org/soap/envelope/"" xmlns:xsd=""http://www.w3.org/2001/XMLSchema""  xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance""><soapenv:Header/><soapenv:Body>
 ;
SOAPF ;</soapenv:Body></soapenv:Envelope>"
 ;
AUTH ;Login *;Password *;PasswordSecurity "base64";Realm *  >> AuthToken
 ;
SENDFAX ;SENDFAXINPUT;FaxNumber *;RcptName *;RctpFax *;RcptVoice *
Attach ;FileName *.pdf;AttachmentContent *
other ;RetryCount *;RetryInterval *;TSI *;Priority *;FaxDescription *;
 ;    >>> FaxID
