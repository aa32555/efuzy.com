SALON
	;
	;
	;Server Routes
	S ^MI(":WS","ROUTES","OPTIONS","api","API^SALON")=""
	S ^MI(":WS","ROUTES","OPTIONS","login","LOGIN^SALON")=""
	S ^MI(":WS","ROUTES","OPTIONS","register","REGISTER^SALON")=""
	S ^MI(":WS","ROUTES","OPTIONS","publicprofile","PUBLICPROFILE^SALON")=""
	S ^MI(":WS","ROUTES","POST","api","API^SALON")=""
	S ^MI(":WS","ROUTES","POST","login","LOGIN^SALON")=""
	S ^MI(":WS","ROUTES","POST","register","REGISTER^SALON")=""
	S ^MI(":WS","ROUTES","POST","publicprofile","PUBLICPROFILE^SALON")=""
	;
	S ^MI(":WS","ROUTES","OPTIONS","account-details","ACCOUNTDETAILS^SALON")=""
	S ^MI(":WS","ROUTES","POST","account-details","ACCOUNTDETAILS^SALON")=""
	;
	S ^MI(":WS","ROUTES","OPTIONS","services-details","SERVICESDETAILS^SALON")=""
	S ^MI(":WS","ROUTES","POST","services-details","SERVICESDETAILS^SALON")=""
	;
	S ^MI(":WS","ROUTES","OPTIONS","notificationclicked","notificationClicked^FCM")=""
	S ^MI(":WS","ROUTES","POST","notificationclicked","notificationClicked^FCM")=""
	;
	S ^MI(":WS","ROUTES","OPTIONS","sms-status-update","STATUSCALLBACK^SMS")=""
	S ^MI(":WS","ROUTES","POST","sms-status-update","STATUSCALLBACK^SMS")=""
	S ^MI(":WS","ROUTES","GET","sms-status-update","STATUSCALLBACK^SMS")=""
	;
	S ^MI(":WS","ROUTES","OPTIONS","sms-reply","REPLY^SMS")=""
	S ^MI(":WS","ROUTES","POST","sms-reply","REPLY^SMS")=""
	;
	S ^MI(":WS","PORT")=7777
	S ^MI(":WS","IP")="172.31.44.106"
	S ^MI(":WS","NAME")="solo"
	S ^MI(":WS","PHONE")="+13473421431"
	S ^MI(":WS","ONE_SIGNLA_APPID")="b9f9bf97-5895-45a7-8145-d5de17c8e964"
	S ^MI(":WS","ONE_SIGNLA_API_KEY")="ODQwODMyY2MtNWUzNi00MmNmLTkzOWYtNjUwOTljYThjNjY1"
	S ^MI(":WS","TWILIO_SID")="ACc6f4d9901756378f43513a279f02806f"
	S ^MI(":WS","TWILIO_TOKEN")="20ff7b431ed9e760d7d36096bf658661"
	; twilio api secret mGAsH3FWWQ8lqNdYQveN5F15cM3TKN4d
	;D SetupSSL^FCM("")
	;
	;S ^ARTROOMSPA("SALONPROFILE","DATA","ARTROOMSPA")=""
	;
	Q
	;       
TREE(T)
	;S @T@("header","class")="bg-white text-primary"
	S @T@("header","flat")="true"
	S @T@("header","round")="true"
	S @T@("toolbar","flat")="true"
	S @T@("toolbar","round")="true"
	S @T@("data","title")="MasterStylists.com" ;$G(@G@("SALON","title"))
	N P,H,N
	D ROUTES^DASHBOARD
	D ROUTES^CALENDAR
	D ROUTES^CLIENTS
	D ROUTES^STAFF
	D ROUTES^SERVICES
	D ROUTES^CATEGORIES
	D ROUTES^LOCATIONS
	D ROUTES^DISCOUNTS
	D ROUTES^ACTIVITY
	D ROUTES^FEEDBACK
	D ROUTES^CLIENTRETENTION
	D ROUTES^SETTINGS
	;D ROUTES^SYNC
	;D ROUTES^BOOKING
	D ROUTES^CUSTOMIZATIONS
	;
	;
	i $I(P)
	I %TYPE="STYLIST" D
	. S @T@("pages",P,"path")="/profile/:tab"
	. S @T@("pages",P,"name")="myprofile"
	. S @T@("pages",P,"component")="Profile"
	. S @T@("pages",P,"requiresAuth")="true"
	. S @T@("pages",P,"routine")="TREE^STYLISTS"
	. S @T@("pages",P,"type")="STYLIST"
	I %TYPE="SALON" D
	. S @T@("pages",P,"path")="/profile/:tab"
	. S @T@("pages",P,"name")="salonprofile"
	. S @T@("pages",P,"component")="SalonProfile"
	. S @T@("pages",P,"requiresAuth")="true"
	. S @T@("pages",P,"routine")="TREE^SALONPROFILE"
	. S @T@("pages",P,"type")="SALON"
	;
	q
	;
	;
PUBLICPROFILE(Q,R,A)
	S R("header","Access-Control-Allow-Origin")="*"
	S R("header","Access-Control-Allow-Headers")="Origin, X-Requested-With, Content-Type, Accept, auth, jwt"
	S R("mime")="application/json"
	I '$D(@Q("body")) Q
	N RES
	D DECODE^MIWS(Q("body"),"RES")
	N TYPEONLY
	S TYPEONLY=($G(RES("typeOnly"))="true")
	N ACCT S ACCT=$$ZCVT($P(RES("acct"),"/",2),"U") I ACCT="" Q
	I '$D(^SALON("ACCOUNT-DETAILS",ACCT)) Q
	N EM1,EM2
	S EM1=$O(^SALON("ACCOUNT-DETAILS",ACCT,""))
	S EM2=$O(^SALON("ACCOUNT-DETAILS",ACCT,""),-1)
	I EM1'=EM2 Q
	S %EMAIL=$$ZCVT(EM1,"L")
	S (%ACCOUNT,ACCOUNT)=^SALON("ACCOUNT-EMAIL",%EMAIL)
	s %TYPE=$G(^SALON("ACCOUNT-TYPE",%EMAIL)) I %TYPE="" Q
	S (G,%G)="^"_ACCOUNT
	I '$D(@G) Q
	N D,OUT,J
	S TYPE=^SALON("ACCOUNT-TYPE",%EMAIL)
	S D("data","id")=EM1
	I TYPE="STYLIST" S D("data","type")="STYLISTS"
	I TYPE="SALON" S D("data","type")="SALONPROFILE"
	I TYPEONLY S J("data","type")=TYPE
	D getSimpleModelData^FUZNEW(.D,.J)
	D ENCODE^MIWS("J",R)
	Q       
	;
LOGIN(%Q,%R,A)
	S %R("header","Access-Control-Allow-Origin")="*"
	S %R("header","Access-Control-Allow-Headers")="Origin, X-Requested-With, Content-Type, Accept, auth, jwt"
	S %R("mime")="application/json"
	I '$D(@%Q("body")) Q
	D DECODE^MIWS(%Q("body"),"RES")
	N EMAIL,PASSWORD,%J,ER S ER=0
	S RES("email")=$$ZCVT(RES("email"),"L")
	S EMAIL=RES("email")
	S PASSWORD=RES("password")
	I '$D(^SALON("ACCOUNT-EMAIL",RES("email"))) S %J("status")="Invalid login" G LOGINEND
	I $G(^SALON("ACCOUNT-TYPE",RES("email")))'=$$ZCVT(RES("type"),"U") S %J("status")="Invalid login" G LOGINEND
	N ACCOUNT,JWTRES,JWTOUT S JWTOUT=""
	S ACCOUNT=^SALON("ACCOUNT-EMAIL",RES("email"))
	;I ^SALON("ACCOUNT-DETAILS",ACCOUNT,RES("email"),"DETAILS","password")'=$SYSTEM.Encryption.SHA1Hash(RES("password")) S J("status")="Invalid login" G LOGINEND
	I ^SALON("ACCOUNT-DETAILS",ACCOUNT,RES("email"),"DETAILS","password")'=RES("password") S %J("status")="Invalid login" G LOGINEND
	N JWT
	S JWT("account")=ACCOUNT
	S JWT("session")=$$GUID()
	S JWT("email")=RES("email")
	S %EMAIL=$$ZCVT(RES("email"),"L")
	D ENCODE^MIWS("JWT","JWTRES")
	N A S A="" F  S A=$O(JWTRES(A)) Q:A=""  S JWTOUT=JWTOUT_JWTRES(A)
	S %J("status")="OK"
	S %J("jwt","jwt")=$$EncodeJWT(JWTOUT,"B2C5584D-7975-49C2-88B0-6696DDAEBBE8")
	S %J("jwt","account")=ACCOUNT
	S %J("jwt","session")=JWT("session")
	S %J("jwt","email")=RES("email")
	S %J("jwt","type")=^SALON("ACCOUNT-TYPE",RES("email"))
	;S J("jwt","url")="https://"_"www.hairsalonsystems.com"_"/servers/"_^MI(":WS","NAME")
	;S J("jwt","url")="http://"_"localhost:3001"
	s %TYPE=^SALON("ACCOUNT-TYPE",RES("email"))
	S G="^"_ACCOUNT
	M @G@("SESSION",JWT("session"))=%J("jwt")
	;S @G@("JWT",%J("jwt","jwt"))=JWT("session")
	M ^%JWT("JWT",%J("jwt","jwt"))=%J("jwt")
	S %J("auth_status")="true"
	D TREE($NA(%J("tree")))
LOGINEND
	D ENCODE^MIWS("%J",%R)
	Q
	;
LOGINENDAPI     
	D ENCODE^MIWS("%J",%R)
	Q       
REGISTER(Q,R,A)
	N J,RES,C,ER S ER=0
	S R("header","Access-Control-Allow-Origin")="*"
	S R("header","Access-Control-Allow-Headers")="Origin, X-Requested-With, Content-Type, Accept, auth, jwt"
	S R("mime")="application/json"
	I '$D(@Q("body")) Q
	D DECODE^MIWS(Q("body"),"RES")
	N T S T=$$ZCVT(RES("type"),"U") I $T(@("REGISTER"_T_"^SALON"))]"" D @("REGISTER"_T_"^SALON") 
	Q
	;
REGISTERSTYLIST 
	S RES("account")=$$ZCVT($G(RES("name")),"U")
	S RES("email")=$$ZCVT($G(RES("email")),"l")
	I '$G(RES("account"))="" S J("status",$I(C))="Invalid Account" S ER=1
	I '$G(RES("name"))="" S J("status",$I(C))="Name is required!" S ER=1
	I '$G(RES("email"))="" S J("status",$I(C))="Email is required" S ER=1
	I '$G(RES("password"))="" S J("status",$I(C))="Password is required" S ER=1
	;I '$D(^SALON("ACCOUNT",RES("account"))) S J("status",$I(C))="Invalid Account" S ER=1
	I 'ER,$D(^SALON("ACCOUNT-EMAIL",RES("email"))) S J("status",$I(C))="Email Already Exists" S ER=1 
	I 'ER,$D(^SALON("ACCOUNT-DETAILS",RES("account"))) S J("status",$I(C))="Name URL Already Exists" S ER=1 
	I 'ER D
	. M ^SALON("ACCOUNT-DETAILS",RES("account"),RES("email"),"DETAILS")=RES
	. ; add password hash
	. S ^SALON("ACCOUNT-DETAILS",RES("account"),RES("email"),"DETAILS","password")=^SALON("ACCOUNT-DETAILS",RES("account"),RES("email"),"DETAILS","password")
	. S ^SALON("ACCOUNT-EMAIL",RES("email"))=RES("account")
	. S ^SALON("ACCOUNT-TYPE",RES("email"))=$$ZCVT(RES("type"),"U")
	. S J("status")="OK"
	D ENCODE^MIWS("J",R)
	Q
	;
REGISTERSALON   
	S RES("account")=$$ZCVT($G(RES("name")),"U")
	S RES("email")=$$ZCVT($G(RES("email")),"l")
	I '$G(RES("account"))="" S J("status",$I(C))="Invalid Account" S ER=1
	I '$G(RES("name"))="" S J("status",$I(C))="Name is required" S ER=1
	I '$G(RES("email"))="" S J("status",$I(C))="Email is required" S ER=1
	I '$G(RES("password"))="" S J("status",$I(C))="Password is required" S ER=1
	;I '$D(^SALON("ACCOUNT",RES("account"))) S J("status",$I(C))="Invalid Account" S ER=1
	I 'ER,$D(^SALON("ACCOUNT-EMAIL",RES("email"))) S J("status",$I(C))="Email is alredy registered, please reset your passeord" S ER=1 
	I 'ER,$D(^SALON("ACCOUNT-DETAILS",RES("account"))) S J("status",$I(C))="Account name is alredy taken, please try something else" S ER=1 
	I 'ER D
	. M ^SALON("ACCOUNT-DETAILS",RES("account"),RES("email"),"DETAILS")=RES
	. ;S ^SALON("ACCOUNT-DETAILS",RES("account"),RES("email"),"DETAILS","password")=$SYSTEM.Encryption.SHA1Hash(^SALON("ACCOUNT-DETAILS",RES("account"),RES("email"),"DETAILS","password"))
	. S ^SALON("ACCOUNT-DETAILS",RES("account"),RES("email"),"DETAILS","password")=^SALON("ACCOUNT-DETAILS",RES("account"),RES("email"),"DETAILS","password")
	. S ^SALON("ACCOUNT-EMAIL",RES("email"))=RES("account")
	. S ^SALON("ACCOUNT-TYPE",RES("email"))=$$ZCVT(RES("type"),"U")
	. S J("status")="OK"
	D ENCODE^MIWS("J",R)
	Q
	;
SetReplay(QR,RR)
	K ^REPLAY
	M ^REPLAY("bodyData")=@QR("body")
	M ^REPLAY("Q")=QR
	S ^REPLAY("Q","body")=$NA(^REPLAY("bodyData"))
	Q
	;
API(%Q,%R,%A)
	new $etrap set $etrap="zgoto "_$zlevel_":apierr^"_$text(+0)
	;I '$G(%REPLAY) D SetReplay(.%Q,.%R)
	N %J
	S %R("mime")="application/json"
	S %R("header","Access-Control-Allow-Origin")="*"
	S %R("header","Access-Control-Allow-Headers")="Origin, X-Requested-With, Content-Type, Accept, auth, jwt"
	I '$D(@%Q("body")) Q
	N %SESSION S %SESSION=$G(%Q("header","auth")) I %SESSION="" S %J("auth_status")="false" G LOGINENDAPI
	N %JWT S %JWT=$G(%Q("header","jwt")) I %JWT="" S %J("auth_status")="false" G LOGINENDAPI
	I '$D(^%JWT("JWT",%JWT)) S %J("auth_status")="false" G LOGINENDAPI
	M %SESSION=^%JWT("JWT",%JWT)
	I '$D(%SESSION) S %J("auth_status")="false" G LOGINENDAPI
	N %JWT S %JWT=$G(%SESSION("jwt")) I %JWT="" S %J("auth_status")="false" G LOGINENDAPI
	S %SESSION=$G(%SESSION("session")) I %SESSION="" S %J("auth_status")="false" G LOGINENDAPI
	N %EMAIL S %EMAIL=$G(%SESSION("email")) I %EMAIL="" S %J("auth_status")="false" G LOGINENDAPI
	N %ACCOUNT S %ACCOUNT=$G(%SESSION("account")) I %ACCOUNT="" S %J("auth_status")="false" G LOGINENDAPI
	n %USER S %USER=^SALON("ACCOUNT-DETAILS",%ACCOUNT,%EMAIL,"DETAILS","name")
	N %G,%GLOBAL S %G="^"_%ACCOUNT,%GLOBAL=%G
	I '$D(@%G@("SESSION",%SESSION("session"))) S %J("auth_status")="false" G LOGINENDAPI
	N %TYPE S %TYPE=^SALON("ACCOUNT-TYPE",%EMAIL)
	N %RR D DECODE^MIWS(%Q("body"),"%RR")
	N %ROUTINE S %ROUTINE=%RR("routine")
	K %RR("routine") K %J
	N (%Q,%JWT,%SESSION,%EMAIL,%ACCOUNT,%TYPE,%USER,%G,%GLOBAL,%ROUTINE,%J,%R,%RR)
	D @(%ROUTINE_"(.%RR,.%J)")
	S %J("auth_status")="true"
	K @%R D ENCODE^MIWS("%J",%R)
	Q
	;
apierr
	new $etrap set $etrap="W $ZSTATUS,! H"  
	I $$CheckAut^FUZ() S @("%J(""auth_status"")")="true"
	S HTTPRSP="^MI("":TEMP"",""HTTPERR"",$J,""JSON"")"
	D Error^FUZ($P($zstatus,",",2,999)_"  =>   "_$NA(^MI("ZERR",+$H,$G(^MI("ERRORS",+$H),0)+1)))
	S %J("mime")="application/json"
	S %J("header","Access-Control-Allow-Origin")="*"
	S %J("header","Access-Control-Allow-Headers")="Origin, X-Requested-With, Content-Type, Accept, auth, jwt"
	D LOGERR^MIWS S $ECODE=""
	G LOGINENDAPI
	Q
	;
r(s,f,t)
	i $tr(s,f)=s q s
	n o,i s o="" f i=1:1:$l(s,f)  s o=o_$s(i<$l(s,f):$p(s,f,i)_t,1:$p(s,f,i))
	q o
	;
s(s)
	i $tr(s,"""\/"_$c(8,9,10,13))=s q s
	i s["\"    s s=$$r(s,"\","\\")
	i s[""""   s s=$$r(s,"""","\""")
	i s["/"    s s=$$r(s,"/","\/")
	i s[$c(8)  s s=$$r(s,$c(8),"\b")
	i s[$c(10) s s=$$r(s,$c(10),"\n")
	i s[$c(13) s s=$$r(s,$c(13),"\r")
	i s[$c(9)  s s=$$r(s,$c(9),"\t")
	q s
	;
	;
lo(String) Q $$LO^MIWS(String)
	;
	;
url(s)
	n t
	s s=$$r(s,"-","+")
	s s=$$r(s,"_","/")
	s t=$l(s)#4
	q $s(t=0:s,t=2:s_"==",t=3:s_"=",1:"Invalid base64url string")
	;
	;
ToBase64URL(a) 
	n b,c,j,cd,cd1,cc d
	. s cd="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_="
	. s cd1="" f j=1:1:65 s cd1=cd1_$c(j+31)
	s cc="" f j=1:3:$l(a) d  s cc=cc_c
	. s b=$e(a,j,j+2)
	. i $l(b)=3 s c=$tr($c($a(b)\4+32,$a(b)#4*16+($a(b,2)\16)+32,$a(b,2)#16*4+($a(b,3)\64)+32,$a(b,3)#64+32),cd1,cd) Q
	. i $l(b)=2 s c=$tr($c($a(b)\4+32,$a(b)#4*16+($a(b,2)\16)+32,$a(b,2)#16*4+32,96),cd1,cd) Q
	. s c=$tr($c($a(b)\4+32,$a(b)#4*16+32,96,96),cd1,cd) Q
	q $p(cc,"=")
	;
	;
EncodeJWT(payload,secret) Q "ABCDEF"
	N PL
	S PL("payload")=payload
	S PL("secret")=secret
	N OUT,DATA S DATA=""
	D ENCODE^MIWS("PL","OUT")
	N A S A="" S A=$O(OUT(A)) Q:A=""  S DATA=DATA_OUT(A)
	N D S D="encodejwtpipe"
	N OLDIO S OLDIO=$I
	ZSY "echo '"_DATA_"' > "_"request."_$j
	O D:(command="curl -s -X POST -H 'Content-Type: application/json; charset=UTF-8' -H 'X-Accept: application/json' -d @request."_$j_" http://localhost:3000/jwt/encode")::"pipe"
	K OUT
	U D R OUT:1
	U OLDIO C D
	N RESULT
	D DECODE^MIWS("OUT","RESULT")
	zsy "rm "_"request."_$j
	Q $G(RESULT("token"))
	;
VerifyJWT(payload,secret)
	n s
	;s s=$system.Encryption.Base64Decode($$url($p(payload,".",3)))
	;i s=$system.Encryption.HMACSHA(256,$p(payload,".",1,2),secret) q 1
	q 1
	;
DecodeJWT(payload,secret)
	N D S D="/tmp/jwt."_$j
	N OLDIO S OLDIO=$I
	N C S C="jwt --decode --secret "_secret_" "_payload_" > "_D
	zsy C open D:(readonly:fixed:recordsize=4080)
	U D R OUT:1
	s OUT=$TR(OUT,$C(10))
	U OLDIO C D
	zsy "rm "_D
	Q OUT
	Q
	;
CheckAuth(D,O)
	s O("data","status")="true"
	q
	;
LogOff(D,O)
	;k @%G@("SESSION",%SESSION("session"))
	s O("data","status")="true"
	q
	;
ACCOUNTDETAILS(Q,%R,A) ; FOR ONLINE BOOKING
	I '$G(%REPLAY) D SetReplay(.Q,.%R)
	S %R("header","Access-Control-Allow-Origin")="*"
	S %R("header","Access-Control-Allow-Headers")="Origin, X-Requested-With, Content-Type, Accept, auth, jwt"
	S %R("mime")="application/json"
	;	
	I '$D(@Q("body")) Q
	N RESULT
	D DECODE^MIWS(Q("body"),"RESULT")
	N SITE S SITE=$$UP^MIWS($G(RESULT("site"))) I SITE="" S %J("status")="false" G LOGINEND
	I '$D(^SALON("ACCOUNT-DETAILS",SITE)) S %J("status")="false" G LOGINEND
	S %ACCOUNT=SITE
	S ACCOUNT=SITE
	S (%G,%GLOBAL)="^"_SITE
	N D,O
	N STEP S STEP=$G(RES("step")) I STEP="" S STEP=1
	K %J 
	M %J("data","logo")=@%G@("SALONPROFILE","DATA",%ACCOUNT,"image")
	ZK %J("data","logo")
	;S D("data","step")=STEP
	S %J("data","url")="https://"_"efuhair.com"_"/api/" ;_^MI(":WS","NAME")
	;D GetMOdelForStep^ONLINEBOOKINGCUSTOMIZATION(.D,.J)
	G LOGINEND
	Q
	;
SERVICESDETAILS(Q,%R,A) ; FOR ONLINE BOOKING
	I '$G(%REPLAY) D SetReplay(.Q,.%R)
	S R("header","Access-Control-Allow-Origin")="*"
	S R("header","Access-Control-Allow-Headers")="Origin, X-Requested-With, Content-Type, Accept"
	S R("mime")="application/json"
	I '$D(@Q("body")) Q
	N RESULT
	D DECODE^MIWS(Q("body"),"RESULT")
	N SITE S SITE=$$UP^MIWS($G(RESULT("site"))) I SITE="" S %J("status")="false" G LOGINEND
	I '$D(^SALON("ACCOUNT-DETAILS",SITE)) S %J("status")="false" G LOGINEND
	S %ACCOUNT=SITE
	S %J("status")="true" 
	S ACCOUNT=SITE
	S (%G,%GLOBAL)="^"_SITE
	N D,O
	D EXPANDSERVICES^SERVICES(.%J)
	G LOGINEND
	Q       
	;       
	;
ZCVT(STR,T)
	S T=$$LOW^MIWS(T)
	I T="l" Q $$LOW^MIWS(STR)
	I T="u" Q $$UP^MIWS(STR)
	Q
	;
ZDH(dt,type) 
	S type=$G(type,1)
	n cc,dat,dd,mm,yy,dh,zd
	I type=5 D
	. i dt["T" s dt=$p(dt,"T")
	. s mm=$p(dt,"-",2)
	. s dd=$p(dt,"-",3)
	. s yy=$p(dt,"-")
	I type=1 D
	. s mm=$p(dt,"/")
	. s dd=$p(dt,"/",2)
	. s yy=$p(dt,"/",3)
	Q $$ZDHP(dt)
	;
ZD(dt,type)
	S type=$G(type)
	I type="" S type=1
	I type=10 Q $$ZD12D($ZD(dt,"DAY"))
	I type=3 Q $ZD(dt,"YYYY-MM-DD")
	I type=1 Q $ZD(dt,"MM/DD/YYYY")
	I type=12  Q $$ZD12DAY($ZD(dt,"DAY"))
	Q 
	;
ZDHP(dt)        
	i mm<1 q ""
	i mm>13 q ""
	i dd<1 q ""
	s zd=$ZDATEFORM
	i $l(yy)<3 d
	. s dh=$H
	. s yy=yy+(100*$S('zd:19,(zd>1840)&($L(zd)=4):($E(zd,1,2)+$S($E(zd,3,4)'>yy:0,1:1)),1:$E($ZDATE(dh,"YEAR"),1,2)))
	;                  20th           rolling                                current century
	i dd>$s(+mm'=2:$e(303232332323,mm)+28,yy#4:28,yy#100:29,yy#400:28,1:29) q ""
	s dat=yy-1841,mm=mm-1,cc=1
	i dat<0 s dd=dd-1,cc=-1
	s dat=dat\4*1461+(dat#4-$s(dat'<0:0,1:4)*365)+(mm*30)+$e(10112234455,mm)+dd-(yy-1800\100-(yy-1600\400))
	i yy#4,mm>1 s dat=dat-cc
	i yy#100=0,mm<2,yy#400 s dat=dat+cc
	q dat
	;
ZD12M(M)
	I M>=3,M<=10 Q M-2
	I M=1 Q 11
	I M=2 Q 12
	Q ""
	;
ZD12Y(Y,M)
	I M=1 Q Y-1
	I M=2 Q Y-1
	Q Y
	;
ZD12D(D)
	I D="SUN" Q 0
	I D="MON" Q 1
	I D="TUE" Q 2
	I D="WED" Q 3
	I D="THU" Q 4
	I D="FRI" Q 5
	I D="SAT" Q 6
	Q ""
	;
ZD12DAY(D)
	I D="SUN" Q "Sunday"
	I D="MON" Q "Monday"
	I D="TUE" Q "Tuesday"
	I D="WED" Q "Wednesday"
	I D="THU" Q "Thursday"
	I D="FRI" Q "Friday"
	I D="SAT" Q "Saturday"
	Q ""
	;
ZDT(dt,type1,type2)
	N P1,P2
	I type1=3 S P1=$ZD(dt,"YYYY-MM-DD")
	I type2=5 S P2=$$ZDTIME24($p(dt,",",2))
	I type1=3,type2=5 Q P1_"T"_P2_$$ZDTTZ()
	Q ""
	;
ZDTTZ()
	N OUT
	N D S D="datetimepipe"
	N OLDIO S OLDIO=$I
	O D:(shell="/bin/sh":command="date -Is")::"pipe"
	U D R OUT:1
	U OLDIO C D
	S TZ=OUT
	Q $E(TZ,$L(TZ)-5,$L(TZ))
	;
ZDTIME(%TN)
	N %M,%N,%I,%TS,%A,%B,%C
	I %TN'>0!(%TN>86400) Q ""
	S %M=%TN\60,%N="AM" S:%M'<720 %M=%M-720,%N="PM" S:%M<60 %M=%M+720
	S %I=%M\600 S:'%I %I=""
	S %A=%I_(%M\60#10)
	I $L(%A)<2 S %A="0"_%A
	S %B=(%M#60\10)_(%M#10)
	I $L(%B)<2 S %B="0"_%B
	S %C=(%TN#60)
	I $L(%C)<2 S %C="0"_%C
	Q %A_":"_%B_%N
	;
ZDTIME24(%TN)
	N %M,%N,%I,%TS,%A,%B,%C
	I %TN'>0!(%TN>86400) Q ""
	S %M=%TN\60 S:%M<60 %M=%M+720
	S %I=%M\600 
	S:'%I %I=""
	S %A=%I_(%M\60#10)
	I $L(%A)<2 S %A="0"_%A
	S %B=(%M#60\10)_(%M#10)
	I $L(%B)<2 S %B="0"_%B
	S %C=(%TN#60)
	I $L(%C)<2 S %C="0"_%C
	Q %A_":"_%B_":"_%C
	;
ZT(t,type)
	I type=4 Q $$ZDTIME(t)
	I type=2 Q $P($$ZDTIME24(t),":",1,2)
	Q
	;
ZTHFUNC(ts)
	quit:(""=$get(ts)) $piece($horolog,",",2)
	if '$data(%zdebug) new $etrap set $etrap="zgoto "_$zlevel_":err^"_$text(+0)
	new apm,cp,dir,hr,ilen,min,ocp,tp,tok,dh
	set dh="",min=0
	set ilen=$length(ts)+1,ocp=1
	do advance quit:(dir?1C) ""
	quit:(tok?1A.E) $select("\NOON"[("\"_tok):43200,"\MIDNIGHT\MIDNITE"[("\"_tok):0,1:"")
	if tok?4N set min=$extract(tok,3,4),hr=$extract(tok,1,2) quit:(24<hr)!(59<min) ""
	else  if (tok?1.N) quit:24<tok "" do  if dir'?1A do advance quit:(dir?1C) "" if tok?1.N quit:(59<tok) "" set min=tok
	. set hr=tok,min=0
	if dir?1A quit:12<hr "" do advance quit:(dir?1C) "" do  quit:(0>apm) ""
	. set apm=$find("\AM\PM\MI\NO","\"_$extract(tok,1,2))-3\3
	. set:((1<apm)&min) apm=-1
	. if 0<=apm set:(12=hr)&(apm<2) hr=apm*hr set hr=$select((0=apm):hr,(1=apm)&(12'=hr):12+hr,2=apm:0,3:12)
	quit $select((ocp+1<ilen):"",1:((hr*60)+min)*60)
	;
advance for cp=ocp:1:ilen quit:$extract(ts,cp)?1AN
	set dir=$extract(ts,cp)
	if dir?1A for tp=cp+1:1:ilen quit:$extract(ts,tp)'?1A
	else  if dir?1N for tp=cp+1:1:ilen quit:$extract(ts,tp)'?1N
	if  set tok=$extract(ts,cp,tp-1) set:(dir?1A) tok=$zconvert(dir,"U")
	else  set tok="",tp=ocp
	for cp=tp:1:ilen set dir=$extract(ts,cp) quit:dir'?1P
	set dir=$zconvert(dir,"U"),ocp=cp
	quit
err     write !,$piece($zstatus,",",2,99),!
	use:$data(d("use")) @d("use")
	use:$data(d("io")) d("io")
	set $ecode=""
	quit
	;
ZTH(ts)
	N A,H,M,S,RT
	S H=$P(ts,":")
	S M=$TR($P(ts,":",2)," AMPamp")
	S C=$TR($P(ts,":",3)," AMPamp")
	S A=$$UP^MIWS($TR(ts,"0123456789: "))
	S RT=H_":"_M
	I A]"" S RT=RT_A
	Q $$ZTHFUNC(RT)
	;
KEY(LEN,B)      
	N I,KEY
	S KEY="" F I=1:1:LEN S KEY=KEY_B($R(B)+1)
	Q KEY
	;
GUID()
	N MN S MN=$E(+$H,1)+$E(+$H,2)+$E(+$H,3)+$E(+$H,4)+$E(+$H,5)
	I $L(MN)=4 S MN=$E(MN,1)+$E(MN,1)+$E(MN,3)+$E(MN,4)
	I $L(MN)=3 S MN=$E(MN,1)+$E(MN,2)+$E(MN,3)
	I $L(MN)=2 S MN=$E(MN,1)+$E(MN,2)
	N I,B F I=48:1:57,65:1:90 S B($I(B))=$C(I)
	Q $$KEY(8,.B)_"-"_$$KEY(4,.B)_"-"_MN_$$KEY(3,.B)_"-"_$$KEY(4,.B)_"-"_$$KEY(12,.B)
	;
	;