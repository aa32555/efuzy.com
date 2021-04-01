ZAA02GFAXM ; ADS; INTERFAX INTERFACE;;;Tue, 02 Sep 2014  10:42
 ;
SENDTEST S ID=199,FAX="18478708559",contact="MARK",csid="PGA",reference="TEST123",CODE="1847",FAXI="^ZAA02GPDF(""TRANS"",ID)" ; test
 ;
SENDFAX ;
 S CODE=$G(^ZAA02GFAXC("INTERFAX","CODE")) ; local area code
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
GETFAX S CR=$C(13,10),DATA="GET /outbound/faxes/"_ID_"/status"
 S DATA2=""
 D SEND
 Q
GETFAXE S CR=$C(13,10),DATA="GET /outbound/faxes/"_ID
 S DATA2=""
 D SEND
 Q
GETALL ;
 S CR=$C(13,10),DATA="GET /outbound/faxes"
 S DATA2=""
 D SEND
 Q
 ;
SEND D GETIP
 S AA="",USER=$G(^ZAA02GFAXC("INTERFAX","USER")),PASS=$G(^("PASSWORD"))
 I USER=""  S ERROR="USER NOT DEFINED" Q
 ; S DATA="POST /HELP/CONNECT^ZAA02GFAXM?"_FAX
 S A=USER_":"_PASS D BASE64^ZAA02GVBTER3 S AUTH=CC
 S DATA2="Host: rest.interfax.net"_CR_"Accept-Language: en-us"_CR_"Accept: */*"_CR_"Authorization: Basic "_AUTH_CR_$S($G(DATA2)]"":DATA2_CR,1:CR)
 ;
 I 0 D
 . S DATA="GET /outbound/help/mediatype"
 . S DATA2="accept: */*"_CR_CR
 ;
 S DATA=DATA_" HTTP/1.1"_CR_DATA2
 D NET
 Q
 ;  S A="USERNAME: MARK" D BASE64^ZAA02GVBTER3  > CC
 ;
 ;  W $$UUDEC^ZAA02GWEBU(CC)
 ;
 ;
NET S $ZT="NETER^ZAA02GFAXM",DEV="TCP3",OS=^ZAA02G("OS"),C1=+$H,C2=$P($H,",",2) S:$D(^PROBE("CONNECT",C1,C2)) C2=$O(^(""),-1)+.01 S ^PROBE("CONNECT",C1,C2)=IP_"-"_PORT_"-"_$J_"-"_$E($G(DATA),1,150)
 S TMO=30
 I $G(DELAY)]"" H DELAY
 I OS="M3" O DEV:(IP_"/"_PORT:"") U DEV S ZC=$ZC
 I OS="M11" D
 . S DEV="|TCP|"_PORT S ZC=1 C DEV O DEV:(IP:PORT:"AS"):15 Q:'$T  S ZC=0 U DEV
 I ZC D  C DEV L -PROBE(IP) Q
 . S $P(^PROBE("CONNECT",C1,C2),"`",3)=$P($H,",",2)_" NO CONNECTION - "_ZC,(AA,ERROR,X)="ERROR-NO-CONNECTION"
FF W DATA,! I $G(EXE)]"" X EXE ; W CR,CR
 W !
 K X S AA=""
 S TT=0
PROBE2 R X:1 S TT=TT+1 I TT>15 G PROBET
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
 I 1 S IP=$G(^ZAA02GFAXC("INTERFAX","IP"),"127.0.0.1"),PORT=$G(^ZAA02GFAXC("INTERFAX","PORT"),"8066")
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
