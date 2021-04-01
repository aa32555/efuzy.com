CLIENTRETENTION
	;
	;
	;
	Q
	;
ROUTES
	I $I(H)
	S @T@("header","mainNav",H,"label")="Client Retention"
	S @T@("header","mainNav",H,"to")="/client_retention"
	;
	;
	i $I(P)
	S @T@("pages",P,"path")="/client_retention"
	S @T@("pages",P,"name")="Client Retention"
	S @T@("pages",P,"component")="ClientRetention"
	S @T@("pages",P,"requiresAuth")="true"
	S @T@("pages",P,"routine")=""
	S @T@("pages",P,"type")="SALON"
	;
	Q       
	;	
	;	
	;
GENREFERALS(dd,rr)
	s rr("data","data")=""
	q
	N s S s=$NA(@%G@("SESSION",%SESSION("session")))
	n r s r="r"
	n d m d=dd("data")
	; * have not been to the salon in 6 week atleast
	; * have had a haircut in the past
	; * limit to last 6 months
	;
	N %SEND S %SEND=($G(d("sendMessages"))="true")
	N %SHOWSENT S %SHOWSENT = ($G(d("showSent"))="true")
	N %SENTCAMPFROM S %SENTCAMPFROM = $G(d("sentFrom")) I %SENTCAMPFROM]"" S %SENTCAMPFROM=$ZDH(%SENTCAMPFROM,5)
	N %SENTCAMPTO   S %SENTCAMPTO = $G(d("sentTo")) I %SENTCAMPTO]"" S %SENTCAMPTO=$ZDH(%SENTCAMPTO,5)      
	N %RULE S %RULE=$G(d("rule")) I %RULE S %RULE=%RULE+1
	I %RULE=0 S %RULE=1
	i %RULE="" S %RULE="*"
	S RTYPE=" ",TOT=0
	N ACCOUNT S ACCOUNT = %ACCOUNT 
	N %NOFDAYS S %NOFDAYS = $G(@%GLOBAL@("SETTINGS","SALON_DETAILS","globalDaysBetweenC"),42)
	;I '$D(@s@("CLIENT-RETENTIONS",RTYPE)) d
	m @r@("crRules")=@%GLOBAL@("CLIENT-RETENSION","RULES")
	zk @r@("crRules")
	B
	k @s@("CLIENT-RETENTIONS"),@s@("sentStats")
	i $g(d("mounted"))="true" q
	l +@s@("CLIENT-RETENTIONS"):1  e  q
	D
	. ;
	.N INVOICE,ID,lastAppointment,hasService,serviceAppointments,service,DT
	.;s service="balayage"
	.S INVOICE="" F  S INVOICE=$O(@%GLOBAL@("INVOICE","DATA",INVOICE),-1) Q:INVOICE=""  D
	.. s ID=0
	.. s hasService=0
	.. s lastAppointment=0
	.. ;k serviceAppointments
	.. S REF="" F  S REF=$O(@%GLOBAL@("INVOICE","DATA",INVOICE,REF)) Q:REF=""  D
	... S ID=$TR(@%GLOBAL@("INVOICE","DATA",INVOICE,REF,"Client ID"),"""")
	... I $D(@%GLOBAL@("OPTED-OUT","ID-"_ID)) Q
	... I $g(@%GLOBAL@("doNotSend","ID-"_ID))="false" Q
	... I $D(@%GLOBAL@("REJECTED",INVOICE)) Q
	... I $TR(@%GLOBAL@("INVOICE","DATA",INVOICE,REF,"Client Mobile")," +()-")'?11N Q
	... S ITEM=$ZCVT(@%GLOBAL@("INVOICE","DATA",INVOICE,REF,"Item"),"L")
	... S DT=$ZD($ZDH(@%GLOBAL@("INVOICE","DATA",INVOICE,REF,"Invoice Date"),5),8)
	... I $G(IDD(ID))<$ZDH(DT,8) S IDD(ID)=$ZDH(DT,8)
	... ;
	... S MATCHED = $$RetentionRulesMatched(INVOICE,REF,%RULE) I MATCHED D  ;I ITEM[service,ITEM'["added to any balayage" D
	.... S serviceAppointments(ID,DT)=INVOICE_":"_REF_":"_$TR(@%GLOBAL@("INVOICE","DATA",INVOICE,REF,"Item"),":")_":"_MATCHED
	.;
	.N A,B,C,D S A="" F  S A=$O(serviceAppointments(A),-1) Q:A=""  D
	.. S B="" F  S B=$O(serviceAppointments(A,B),-1) Q:B=""  D
	... I $D(C(A)) Q
	... I %SHOWSENT,('$D(@%GLOBAL@("CLIENT-RETENSION","SENT",A))) Q
	... I %SENTCAMPTO,%SHOWSENT,$O(@%GLOBAL@("CLIENT-RETENSION","SENT",A,""),-1),($O(@%GLOBAL@("CLIENT-RETENSION","SENT",A,""),-1))>(%SENTCAMPTO) S C(A)=serviceAppointments(A,B) Q
	... I %SENTCAMPFROM,%SHOWSENT,$O(@%GLOBAL@("CLIENT-RETENSION","SENT",A,""),-1),($O(@%GLOBAL@("CLIENT-RETENSION","SENT",A,""),-1))<(%SENTCAMPFROM) S C(A)=serviceAppointments(A,B)  Q
	... I '%SHOWSENT,(+$O(@%GLOBAL@("CLIENT-RETENSION","SENT",A,""),-1)),(+$H-$O(@%GLOBAL@("CLIENT-RETENSION","SENT",A,""),-1)<=(%NOFDAYS)) S C(A)=serviceAppointments(A,B) Q
	... I '%SHOWSENT,(+$H-IDD(A))<(%NOFDAYS) S C(A)=serviceAppointments(A,B)  Q ;LAST TIME WAS IN THE SALON
	... ;S MATCHED = $$RetentionRulesMatched(A,B) I 'MATCHED S C(A)=serviceAppointments(A,B) Q
	... ;I (+$H-$ZDH(B,8))<(6*7) S C(A)=serviceAppointments(A,B) Q
	... ;S TOT=$G(TOT)+1 Q:TOT>30
	... I '$D(C(A)) K D(A,B)  M D(A,B)=serviceAppointments(A,B)
	.;
	.N ID,DT,CNT S CNT=1
	.S ID="" F  S ID=$O(D(ID)) Q:ID=""  D
	.. s lst = $o(@%GLOBAL@("CLIENT-RETENSION","SENT",ID,""),-1)
	.. I lst,%SHOWSENT,%RULE,$P(@%GLOBAL@("CLIENT-RETENSION","SENT",ID,lst),":",6)'=@%GLOBAL@("CLIENT-RETENSION","RULES",+%RULE,"rule") Q
	.. S CNT=CNT+1
	.. ;
	.. B  I '%SHOWSENT,'$D(@%GLOBAL@("CLIENT-RETENSION","SENT",ID,+$H)),%SEND,$$sendClientRetentionList(D(ID,$o(D(ID,""),-1))) S @%GLOBAL@("CLIENT-RETENSION","SENT",ID,+$H)=D(ID,$o(D(ID,""),-1))_":"_%USER H 0.01
	.. i lst,%SHOWSENT d
	... S LCLMD="",LCLMDTXT=""
	... S SINV = $P(D(ID,$o(D(ID,""),-1)),":")  I SINV="" Q 
	... I $D(@%GLOBAL@("CLIENT-RETENSION","REPLIES",SINV)),$O(@%GLOBAL@("CLIENT-RETENSION","REPLIES",SINV,""))]"" D
	.... S LCLMD=$O(@%GLOBAL@("CLIENT-RETENSION","REPLIES",SINV,""))
	.... I LCLMD]"" S LCLMDTXT=$G(@%GLOBAL@("CLIENT-RETENSION","REPLIES",SINV,LCLMD))
	... I +LCLMDTXT=1 S @s@("sentStats","Claimed")=$G(@s@("sentStats","Claimed"))+1
	... I +LCLMDTXT=2 S @s@("sentStats","OptedOut")=$G(@s@("sentStats","OptedOut"))+1
	... I $ZCVT(LCLMDTXT,"U")["STOP" S @s@("sentStats","OptedOut")=$G(@s@("sentStats","OptedOut"))+1 ;will never happen
	... S @s@("CLIENT-RETENTIONS",RTYPE,"LIST",CNT,"lastSentName")=$P(@%GLOBAL@("CLIENT-RETENSION","SENT",ID,lst),":",7)
	... S @s@("CLIENT-RETENTIONS",RTYPE,"LIST",CNT,"lastSentOn")=$zd(lst)
	... S @s@("CLIENT-RETENTIONS",RTYPE,"LIST",CNT,"lastSentBy")=$$GETNAMEFROMUSER($P(@%GLOBAL@("CLIENT-RETENSION","SENT",ID,lst),":",7))
	.. S @s@("CLIENT-RETENTIONS",RTYPE,"LIST",CNT,"id")=ID
	.. S @s@("CLIENT-RETENTIONS",RTYPE,"LIST",CNT,"matchedRuleNo")=$P(D(ID,$o(D(ID,""),-1)),":",5) ;$P(serviceAppointments(A,B),":",5)
	.. S @s@("CLIENT-RETENTIONS",RTYPE,"LIST",CNT,"matchedRuleName")=$P(D(ID,$o(D(ID,""),-1)),":",6) ;$P(serviceAppointments(A,B),":",6)
	.. S @s@("CLIENT-RETENTIONS",RTYPE,"LIST",CNT,"name")=$G(@%GLOBAL@("CLIENT","DATA",ID,"Name"))
	.. S @s@("CLIENT-RETENTIONS",RTYPE,"LIST",CNT,"lastHere")="" I $G(IDD(ID))]"" S @s@("CLIENT-RETENTIONS",RTYPE,"LIST",CNT,"lastHere")=$ZD(IDD(ID))
	.. S SINV = $P(D(ID,$o(D(ID,""),-1)),":")  S @s@("CLIENT-RETENTIONS",RTYPE,"LIST",CNT,"invoiceNo")=$G(SINV)
	.. I %SHOWSENT D 
	... S LCLMD="",LCLMDTXT=""
	... S SINV = $P(D(ID,$o(D(ID,""),-1)),":")  I SINV="" Q 
	... S @s@("CLIENT-RETENTIONS",RTYPE,"LIST",CNT,"invoiceNo")=$G(SINV)
	... ;
	... S LCLMD="",LCLMDCNT=0 F  S LCLMD=$O(@%GLOBAL@("CLIENT-RETENSION","REPLIES",SINV,LCLMD)) Q:LCLMD=""  D
	.... I (+$H-LCLMD)>%NOFDAYS Q 
	.... S LCLMDTXT=@%GLOBAL@("CLIENT-RETENSION","REPLIES",SINV,LCLMD)
	.... S LCLMDCNT=LCLMDCNT+1
	.... S @s@("CLIENT-RETENTIONS",RTYPE,"LIST",CNT,"messages",LCLMDCNT,"MESSAGE")=LCLMDTXT
	.... S @s@("CLIENT-RETENTIONS",RTYPE,"LIST",CNT,"messages",LCLMDCNT,"TIME")=$ZDT(LCLMD,5,3)
	.... S @s@("CLIENT-RETENTIONS",RTYPE,"LIST",CNT,"messages",LCLMDCNT,"USER")=$G(@%GLOBAL@("CLIENT","DATA",ID,"Name"))
	.. S CNT2=0
	.. S DT="" F  S DT=$O(D(ID,DT)) Q:DT=""  D
	... S CNT2=CNT2+1
	... S @s@("CLIENT-RETENTIONS",RTYPE,"LIST",CNT,"services",CNT2,"service")=$P(D(ID,DT),":",3)
	... s tm=@%GLOBAL@("INVOICE","DATA",$P(D(ID,DT),":"),$P(D(ID,DT),":",2),"Invoice Date")
	... S @s@("CLIENT-RETENTIONS",RTYPE,"LIST",CNT,"services",CNT2,"time")=tm
	... S @s@("CLIENT-RETENTIONS",RTYPE,"LIST",CNT,"services",CNT2,"matched")=$P(D(ID,DT),":",6)
	... S @s@("CLIENT-RETENTIONS",RTYPE,"LIST",CNT,"services",CNT2,"staff")=@%GLOBAL@("INVOICE","DATA",$P(D(ID,DT),":"),$P(D(ID,DT),":",2),"Staff")
	.. s @s@("CLIENT-RETENTIONS",RTYPE,"donotSend")="true"
	.. i $g(@%GLOBAL@("doNotSend","ID-"_ID))]"" d 
	... s @s@("CLIENT-RETENTIONS",RTYPE,"donotSend","ID-"_ID)=$g(@%GLOBAL@("doNotSend","ID-"_ID))
	. S @s@("CLIENT-RETENTIONS",RTYPE,"total")=CNT-1
	. S @s@("CLIENT-RETENTIONS",RTYPE,"type")=RTYPE
	;M @r=@s@("CLIENT-RETENTIONS",RTYPE)
	;
	i $g(d("index"))="" q
	N A,B,C S C=0 S A=((((d("index")))*10)-9) S:A=1 A=0 S:'$D(@s@("CLIENT-RETENTIONS",RTYPE,"LIST",A+10)) @r@("done")="true"
	F  S A=$O(@s@("CLIENT-RETENTIONS",RTYPE,"LIST",A)) Q:A=""  D
	. S C=C+1
	. M @r@("LIST",C)=@s@("CLIENT-RETENTIONS",RTYPE,"LIST",A)
	;
	m @r@("sentStats")=@s@("sentStats") zk @r@("sentStats")
	S @r@("total")=@s@("CLIENT-RETENTIONS",RTYPE,"total")
	S @r@("type")=@s@("CLIENT-RETENTIONS",RTYPE,"type")
	m @r@("donotSend")=@s@("CLIENT-RETENTIONS",RTYPE,"donotSend")
	zk @r@("donotSend")
	l -@s@("CLIENT-RETENTIONS")
	zk r
	m rr("data","data")=r
	Q
	;
RetentionRulesMatched(INV,REF,RL)
	N MATCHED,SERVICES
	S MATCHED=0
	N ITEM S ITEM = $G(@%GLOBAL@("INVOICE","DATA",INV,REF,"Item")) I ITEM="" Q 0 
	N IDT  S IDT = $ZDH(@%GLOBAL@("INVOICE","DATA",INV,REF,"Invoice Date"),5)
	N RULE,MRULE S MRULE=0
	D  Q MATCHED
	.S RULE ="" F  S RULE=$O(@%GLOBAL@("CLIENT-RETENSION","RULES",RULE)) Q:RULE=""  Q:MATCHED  D
	.. K SERVICES D GETSERVICESBYRULE(RULE,.SERVICES)
	.. S DAYS = @%GLOBAL@("CLIENT-RETENSION","RULES",RULE,"days")
	.. I +RL,+RL=+RULE,(+$H-IDT)>=DAYS,$D(SERVICES(ITEM)) S MRULE=+RULE S MATCHED=1_":"_RULE_":"_@%GLOBAL@("CLIENT-RETENSION","RULES",RULE,"rule") Q
	.. I RL="*",(+$H-IDT)>=DAYS,$D(SERVICES(ITEM)) S MRULE=+RULE S MATCHED=1_":"_RULE_":"_@%GLOBAL@("CLIENT-RETENSION","RULES",RULE,"rule") Q
	Q MRULE
	;
GETSERVICESBYRULE(R,S)
	N A,B
	S A="" F  S A=$O(@%GLOBAL@("CLIENT-RETENSION","RULES",R,"services",A),1,B) Q:A=""  D
	. I B]"" S S(B)=""
	Q
	;
GETNAMEFROMUSER(EMAIL)
	S EMAIL = $ZCVT(EMAIL,"L")
	I $G(EMAIL)="" Q ""
	Q $G(^SALON("ACCOUNT-DETAILS",%ACCOUNT,EMAIL,"DETAILS","name"))
	;
sendClientRetentionList(S)
	N RNO,RNM,INVOICE,REF,MSG,STAFF,SALON
	N name,staff
	S RNO = $P(S,":",5) I RNO="" Q 0
	S RNM = $P(S,":",6) I RNM="" Q 0
	S INVOICE = $P(S,":") I INVOICE="" Q 0
	S REF = $P(S,":",2) I REF="" Q 0
	S MSG = $G(@%GLOBAL@("CLIENT-RETENSION","RULES",RNO,"txt")) I MSG="" Q 0
	s name = @%GLOBAL@("INVOICE","DATA",INVOICE,REF,"Client Name") 
	s staff = @%GLOBAL@("INVOICE","DATA",INVOICE,REF,"Staff")
	S MSG=$$getMessageText(name,staff,MSG)
	n cid s cid = @%GLOBAL@("INVOICE","DATA",INVOICE,REF,"Client ID")
	s number = $tr(@%GLOBAL@("INVOICE","DATA",INVOICE,REF,"Client Mobile")," +()-")
	i number '?11N s @%GLOBAL@("REJECTED",INVOICE)="Invalid or missing phone number" Q 0
	s number = "+"_number
	k sms
	s sms("number")=number
	s sms("message")=MSG
	s sms("invoice")=INVOICE
	s sms("cid")=cid
	S ZTS=$ZTS
	I $D(@%GLOBAL@("CLIENT-RETENSION","EXCLUDE",cid)) s @%GLOBAL@("REJECTED",INVOICE)="Client Opted Out" q 0
	S ^FUZAUTOSENDER("AutoSender",ZTS,"%GLOBAL")=%GLOBAL
	S ^FUZAUTOSENDER("AutoSender",ZTS,"%USER")=%USER
	S ^FUZAUTOSENDER("AutoSender",ZTS,"INVOICE")=INVOICE
	S ^FUZAUTOSENDER("AutoSender",ZTS,"SEND_AT")=$P($h,",",1)_","_($P($h,",",2)+(0*60))
	M ^FUZAUTOSENDER("AutoSender",ZTS,"SMS")=sms
	S @%GLOBAL@("EXPECT:REPLY",sms("invoice"),$H)="RETENSION-LIST"_":"_%USER_":"_S
	Q 1
	;
getMessageText(name,staff,SRC)
	N MSG,ACCOUNT
	S ACCOUNT = %ACCOUNT
	S MSG=$replace(SRC,"[[name]]",$P(name," "))
	S MSG=$replace(MSG,"[[staff]]",$P(staff," "))
	S MSG=$replace(MSG,"[[salon]]",$G(@%GLOBAL@("SETTINGS","SALON_DETAILS","Name")))
	S MSG=$replace(MSG,"[[coupon]]",$p($SYSTEM.Util.CreateGUID(),"-"))
	q MSG
	;
	;