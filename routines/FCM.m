FCM ;
	;
	;
	;
	Q
	;
	;	
notificationClicked(Q,R,A)
	N RES
	S R("header","Access-Control-Allow-Origin")="*"
	S R("header","Access-Control-Allow-Headers")="Origin, X-Requested-With, Content-Type, Accept, auth, jwt"
	S R("mime")="application/json"
	I '$D(@Q("body")) Q
	D DECODE^MIWS(Q("body"),"RES")  
	N DATA,ACTION S ACTION = A("action") I ACTION="" Q
	M DATA = RES("data")
	N ID S ID=$G(DATA("id")) I ID="" Q
	N TYPE S TYPE = DATA("type")
	N %USER S %USER = DATA("user")
	N %EMAIL S %EMAIL = DATA("email")
	N %G,%GLOBAL
	S (%G,%GLOBAL)=DATA("global")
	I $G(@%G@("NOTIFICATIONS","DATA","ID",ID,"type"))'=TYPE Q
	I $G(@%G@("NOTIFICATIONS","DATA","ID",ID,"user"))'=%USER Q
	I $G(@%G@("NOTIFICATIONS","DATA","ID",ID,"email"))'=%EMAIL Q
	I $G(@%G@("NOTIFICATIONS","DATA","ID",ID,"global"))'=%G Q
	I ACTION="displayed" D  S @%G@("NOTIFICATIONS","DISPLAYED",%EMAIL,ID)=$H
	I ACTION="clicked" D  S @%G@("NOTIFICATIONS","CLICKED",%EMAIL,ID)=$H K @%G@("NOTIFICATIONS","LIST",%EMAIL,ID) 
	I ACTION="dismissed" D  S @%G@("NOTIFICATIONS","DISMISSED",%EMAIL,ID)=$H K @%G@("NOTIFICATIONS","LIST",%EMAIL,ID) 
	I ACTION="clicked",$G(DATA("clearAll"))="true" K @%G@("NOTIFICATIONS","LIST",%EMAIL) 
	Q
	;	
	;
saveFCMToken(dd,rr,s)
	n r s r="r"
	n d m d=dd("data")
	N ACCOUNT S ACCOUNT = %ACCOUNT
	N TOKEN S TOKEN = $G(d("currentToken")) I TOKEN="" Q
	S ^FUZNOTIFY(ACCOUNT,%EMAIL,"TOKEN",TOKEN)=$H
	zk r
	m rr("data","data")=r
	Q
	;       
	;
saveUserNotificationID(D,O)
	N DATA M DATA=D("data")
	N ID,EMAIL
	S ID=DATA("id")
	S EMAIL=$ZCVT(DATA("email"),"L")
	I ID="" Q
	I EMAIL="" Q 
	S @%G@("NOTIFICATIONS","EMAIL:ID",EMAIL,ID)=$H
	Q
	;
	;
userClickedNotificationID(D,O)
	N DATA M DATA=D("data")
	Q
	;       
GroupNotifications(EMAIL,S)
	S S=""
	N ID,TYPE,TYPEC S ID="" F  S ID=$O(@%G@("NOTIFICATIONS","LIST",EMAIL,ID)) Q:ID=""  D
	. I $D(@%G@("NOTIFICATIONS","CLICKED",EMAIL,ID)) K @%G@("NOTIFICATIONS","LIST",EMAIL,ID) Q
	. S TYPE = @%G@("NOTIFICATIONS","DATA","ID",ID,"type") I TYPE="" S TYPE="General"
	. S TYPEC(TYPE)=$G(TYPEC(TYPE))+1
	N A S A="" F  S A=$O(TYPEC(A)) Q:A=""  S S=$S($G(S)="":"",1:S_", ")_TYPEC(A)_" "_A
	Q $G(S)
	;
	;
Notify(MESSAGE,URL,TYPE)
	N EMAIL S EMAIL="" F  S EMAIL=$O(^SALON("ACCOUNT-DETAILS",%ACCOUNT,EMAIL)) Q:EMAIL=""  D
	. I $$NotifyFCM(EMAIL,MESSAGE,URL,TYPE)
	Q
	;
NotifyFCM(EMAIL,MESSAGE,URL,TYPE)
	q ""
	N ID,DATA S ID="" F  S ID=$O(@%G@("NOTIFICATIONS","EMAIL:ID",EMAIL,ID)) Q:ID=""  D
	. S DATA("include_player_ids",$O(DATA("include_player_ids",""),-1)+1)=ID
	;I $D(@%G@("NOTIFICATIONS","LIST",%EMAIL)) D GroupNotifications(EMAIL,.MESSAGE) S DATA("data","clearAll")="true"
	S DATA("app_id")=^MI(":WS","ONE_SIGNLA_APPID")
	S DATA("contents","en")=MESSAGE
	S DATA("url")=URL
	;S DATA("chrome_web_image")="https://hairsalonsystems.com/bg.jpg"
	;S DATA("android_background_layout","image")="https://hairsalonsystems.com/bg.jpg"
	S DATA("channel_for_external_user_ids")="push"
	S DATA("headings","en")=TYPE
	S DATA("collapse_id")=$ZTS_"-"_$SYSTEM.Util.CreateGUID()
	S DATA("data","id")=DATA("collapse_id")
	S DATA("data","type")=TYPE
	S DATA("data","account")=%ACCOUNT
	S DATA("data","user")=%USER
	S DATA("data","email")=%EMAIL
	S DATA("data","global")=%G
	N RESP S RESP=$$callFCM(.DATA)
	S @%G@("NOTIFICATIONS","SENT",%EMAIL,DATA("data","id"))=$H
	S @%G@("NOTIFICATIONS","LIST",%EMAIL,DATA("data","id"))=$H
	I RESP="" Q 0
	N RESDATA D DECODE^MIWS("RESP","RESDATA")
	N TS S TS=$H
	N A S A="" F  S A=$O(RESDATA("errors","invalid_player_ids",A)) Q:A=""  K @%G@("NOTIFICATIONS","EMAIL:ID",EMAIL,RESDATA("errors","invalid_player_ids",A))
	S @%G@("NOTIFICATIONS","OPEN",%EMAIL,DATA("data","id"))=$H
	M @%G@("NOTIFICATIONS","DATA","ID",DATA("data","id"))=DATA("data")
	Q +$G(RESDATA("recipients"))
	;
NotifyEmail(EMAIL,MESSAGE,URL)
	;N ID,DATA S ID="" F  S ID=$O(@%G@("NOTIFICATIONS","EMAIL:ID",EMAIL,ID)) Q:ID=""  D
	;
	S DATA("include_email_tokens",1)=EMAIL
	S DATA("app_id")=^MI(":WS","ONE_SIGNLA_APPID")
	S DATA("channel_for_external_user_ids")="email"
	S DATA("email")=EMAIL
	S DATA("email_subject")="Subject"
	S DATA("email_from_name")="Notifications"
	S DATA("email_from_address")="ntifications@hairsalonsystems.com"
	S DATA("email_body")="<html><head>Welcome to Cat Facts</head><body><h1>Welcome to Cat Facts<h1><h4>Learn more about everyone's favorite furry companions!</h4><hr/><p>Hi Nick,</p><p>Thanks for subscribing to Cat Facts! We can't wait to surprise you with funny details about your favorite animal.</p><h5>Today's Cat Fact (March 27)</h5><p>In tigers and tabbies, the middle of the tongue is covered in backward-pointing spines, used for breaking off and gripping meat.</p><a href='https://catfac.ts/welcome'>Show me more Cat Facts</a><hr/><p><small>(c) 2018 Cat Facts, inc</small></p><p><small><a href='[unsubscribe_url]'>Unsubscribe</a></small></p></body></html>"
	N RESP S RESP=$$callFCM(.DATA)
	I RESP="" Q 0
	N RESDATA D DECODE^MIWS("RESP","RESDATA")
	;I RESDATA("id") M @%G@("NOTIFICATIONS","RESP:ID",RESDATA("id"))=RESDATA Q 1
	ZW RESDATA
	Q 0
	;       
	;	
	;
callFCM(data)
	n httprequest,Tsc,resp S resp=""
	s httprequest=##class(%Net.HttpRequest).%New()
	s httprequest.SSLConfiguration="FCMClient"
	s httprequest.Https=1
	d httprequest.SetHeader("Content-Type","application/json; charset=utf-8")
	d httprequest.SetHeader("Authorization","Basic "_^MI(":WS","ONE_SIGNLA_API_KEY"))
	s httprequest.Server="onesignal.com"
	n r,o s r=$na(^FUZ("TEMP",$j,"RES")) s o = $na(^FUZ("TEMP",$j,"OUT"))
	k @r,@o
	M @r = data 
	n s s s=""
	d ENCODE^MIWS(r,o)
	n a s a="" f  s a=$o(@o@(a)) q:a=""  s s=s_@o@(a)
	d httprequest.EntityBody.Write(s)
	s Tsc = httprequest.Post("/api/v1/notifications")
	i +Tsc s resp=httprequest.HttpResponse.Data.Read(32000)
	q resp
	;
	;
SetupSSL(io)
	D INT^%DIR,NSP^%DIR
	N NMSP S NMSP=%NSP
	ZN "%SYS"
	n config,status
	n % s %=##class(Security.SSLConfigs).Exists("FCMClient",.config,.status)
	i '% d
	. n prop s prop("Name")="FCMClient"
	. s %=##class(Security.SSLConfigs).Create("FCMClient",.prop)
	. i '% w $SYSTEM.Status.GetErrorText(%) s $ec=",u-cache-error,"
	. s %=##class(Security.SSLConfigs).Exists("FCMClient",.config,.status)
	e  s %=config.Activate()
	;
	n rtn,ip
	i $g(io)="" s ip=##class(%SYSTEM.INetInfo).HostNameToAddr("www.google.com")
	i $g(io)="" d config.TestConnection(ip,443,.rtn)
	ZN NMSP
	i $g(io)="",$g(rtn) w "TLS/SSL client configured on Cache as config name 'FCMClient'",!
	e  i $g(io)="" w "Cannot configure TLS/SSL on Cache",! s $ec=",u-cache-error,"
	q
	;       
	;
SendFCM(payload,token)
	n httprequest,Tsc,resp
	s httprequest=##class(%Net.HttpRequest).%New()
	s httprequest.Https=0
	s httprequest.Server="localhost"
	s httprequest.Port = 5000
	s httprequest.ContentType = "application/json"
	n r,o s r=$na(^FUZ("TEMP",$j,"RES")) s o = $na(^FUZ("TEMP",$j,"OUT"))
	k @r,@o
	s @r@("token")=token
	m @r@("data")=payload
	n s s s=""
	d ENCODE^MIWS(r,o)
	n a s a="" f  s a=$o(@o@(a)) q:a=""  s s=s_@o@(a)
	d httprequest.EntityBody.Write(s)
	s Tsc = httprequest.Post("/sendMesage")
	s response = httprequest.HttpResponse
	S STCD = response.StatusCode
	q $g(STCD)
	;
	;
NotifyFeedBack(INVOICE)
	N ACCOUNT S ACCOUNT = $G(^FUZEMAILACC($ZCVT(%USER,"L")))
	I ACCOUNT="" Q 
	N NAME,STAFF,RATING,REF
	S REF=$o(@%GLOBAL@("INVOICE","DATA",INVOICE,"")) Q:REF=""
	S ID = @%GLOBAL@("INVOICE","DATA",INVOICE,REF,"Client ID")
	S STAFF = @%GLOBAL@("INVOICE","DATA",INVOICE,REF,"Staff")
	S NAME = @%GLOBAL@("INVOICE","DATA",INVOICE,REF,"Client Name")
	S RATING = $P(@%GLOBAL@("INVOICE:RATING",INVOICE),":")
	N P
	S P("title")="?"_$c(159,146,129)_"?"_$c(128,141)_"?"_$c(153,128)_"??"_$c(143)_" "_NAME_" rated "_STAFF_" "_+RATING_" star(s)"
	S P("body")="'"_RATING_"'"
	S P("data")="https://efuzy.com/#/client/"_ID
	S P("image")="https://www.efuzy.com/statics/FUZ.png"
	S P("icon")="https://www.efuzy.com/statics/FUZ.png"
	N U,T,E S U="" F  S U=$O(^FUZNOTIFY(ACCOUNT,U)) Q:U=""  D
	. S T="" F  S T=$O(^FUZNOTIFY(ACCOUNT,U,"TOKEN",T)) Q:T=""  D
	.. S E = ^FUZNOTIFY(ACCOUNT,U,"TOKEN",T)
	.. S ST=$$SendFCM(.P,T) I ST="" S ST="*"
	.. ;
	Q
	;
	;
NotifyGen(title,body,id)
	I $G(%ACCOUNT)="" Q
	N P
	S P("title")=title
	S P("body")="'"_body_"'"
	S P("data")="https://efuzy.com/#/client/"_id
	S P("image")="https://www.efuzy.com/statics/FUZ.png"
	S P("icon")="https://www.efuzy.com/statics/FUZ.png"
	N U,T,E S U="" F  S U=$O(^FUZNOTIFY(%ACCOUNT,U)) Q:U=""  D
	. S T="" F  S T=$O(^FUZNOTIFY(%ACCOUNT,U,"TOKEN",T)) Q:T=""  D
	.. S E = ^FUZNOTIFY(%ACCOUNT,U,"TOKEN",T)
	.. H 0.1 S ST=$$SendFCM(.P,T) I ST="" S ST="*"
	.. I ST=404 K ^FUZNOTIFY(%ACCOUNT,U,"TOKEN",T)
	.. ;
	Q
	;
DBG B  D NotifyGen^FCM("title","body",1234) Q
	;