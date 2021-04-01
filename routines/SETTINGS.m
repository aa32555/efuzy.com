SETTINGS ;
	;
	;
	;
	Q
	;
ROUTES
	I $I(H) K N 
	S @T@("header","mainNav",H,"label")="Settings"
	I $I(N)
	S @T@("header","mainNav",H,"children",N,"label")="General Setting"
	S @T@("header","mainNav",H,"children",N,"to")="/settings"
	;
	;
	i $I(P)
	S @T@("pages",P,"path")="/settings"
	S @T@("pages",P,"name")="Settings"
	S @T@("pages",P,"component")="Settings"
	S @T@("pages",P,"requiresAuth")="true"
	S @T@("pages",P,"routine")=""
	S @T@("pages",P,"type")="SALON"
	;
	Q       
	;	
	;
GETSTAFFFROMUSER(EMAIL)
	I $G(EMAIL)="" Q ""
	S EMAIL = $ZCVT(EMAIL,"L")
	N ACCOUNT
	S ACCOUNT = $G(^FUZEMAILACC(EMAIL)) 
	I ACCOUNT = "" Q ""
	Q $G(^FUZACCOUNTID(ACCOUNT,EMAIL,"DATA","staff","name"))
	;
GETSTAFFOPTIONS(EMAIL,O)
	N A,B,C S A="" F  S A=$O(@%GLOBAL@("STAFF","DATA",A)) Q:A=""  D
	. S C=$G(C)+1
	. I $G(@%GLOBAL@("STAFF","DATA",A,"Active"))'="true" Q 
	. S STAFF = @%GLOBAL@("STAFF","DATA",A,"ID")
	. S @O@("staffOptions",STAFF)="true"
	Q
	;	
getSettings(dd,rr,s)
	n r s r="r"
	n d m d=dd("data")
	s rr("data","data")=""
	q
	N ACCOUNT
	S ACCOUNT = %ACCOUNT 
	s @r@("smsPhone")=$G(@%GLOBAL@("SETTINGS","SMS_PHONE"))
	s @r@("salonTitle")=$G(@%GLOBAL@("SETTINGS","SALON_DETAILS","Name"))
	s @r@("feedBackText")=$G(@%GLOBAL@("SETTINGS","SALON_DETAILS","FeedbackText"))
	s @r@("globalDaysBetweenC")=$G(@%GLOBAL@("SETTINGS","SALON_DETAILS","globalDaysBetweenC"))
	s @r@("numberMinFeedback")=$G(@%GLOBAL@("SETTINGS","SALON_DETAILS","numberMinFeedback"))
	s @r@("feedBackAns1")=$G(@%GLOBAL@("SETTINGS","SALON_DETAILS","feedBackAns1"))
	s @r@("feedBackAns2")=$G(@%GLOBAL@("SETTINGS","SALON_DETAILS","feedBackAns2"))
	s @r@("feedBackAns3")=$G(@%GLOBAL@("SETTINGS","SALON_DETAILS","feedBackAns3"))
	s @r@("feedBackAns4")=$G(@%GLOBAL@("SETTINGS","SALON_DETAILS","feedBackAns4"))
	s @r@("feedBackAns5")=$G(@%GLOBAL@("SETTINGS","SALON_DETAILS","feedBackAns5"))
	s @r@("feedBackAnsG")=$G(@%GLOBAL@("SETTINGS","SALON_DETAILS","feedBackAnsG"))
	m @r@("crRules")=@%GLOBAL@("CLIENT-RETENSION","RULES")
	m @r@("onlineBookingSteps")=@%GLOBAL@("ONLINE-BOOKING","PROMPTS")
	D GETSERVICEOPTIONS(%USER,.r)
	zk r
	m rr("data","data")=r
	q
	;
GetStaffDetails(dd,rr,s)
	n r s r="r"
	n d m d=dd("data")      
	S S="",C=0 F  S S=$O(@%GLOBAL@("STAFF","DATA",S)) Q:S=""  D
	. S STAFF = @%GLOBAL@("STAFF","DATA",S,"ID")
	. S C=C+1
	. S @r@("staffDetails",C,"id")=@%GLOBAL@("STAFF","DATA",STAFF,"ID")
	. S @r@("staffDetails",C,"active")=$G(@%GLOBAL@("STAFF","DATA",STAFF,"Active"),"false")
	zk r
	m rr("data","data")=r
	Q
	;
GETSERVICEOPTIONS(EMAIL,O)
	N A,B,C,DONE S DONE=0 S A="" F  S A=$O(@%GLOBAL@("INVOICE","DATA",A),-1) Q:A=""  Q:DONE  D
	. S B="" F  S B=$O(@%GLOBAL@("INVOICE","DATA",A,B),-1) Q:B=""  Q:DONE  D
	.. ;S C=$G(C)+1 Q:C>1000
	.. S ID = $ZDTH(@%GLOBAL@("INVOICE","DATA",A,B,"Invoice Date"),3,1)
	.. I (+$H-ID)>360 S DONE=1 Q
	.. S ITEM = @%GLOBAL@("INVOICE","DATA",A,B,"Item")
	.. S @O@("crServices",ITEM)="true"
	Q
	;
setSettings(dd,rr,s)
	n r s r="r"
	n d m d=dd("data")
	d
	. i $g(d("smsPhone"))]"" s @%GLOBAL@("SETTINGS","SMS_PHONE")=d("smsPhone")
	. i $g(d("salonTitle"))]"" s @%GLOBAL@("SETTINGS","SALON_DETAILS","Name")=d("salonTitle")
	. i $g(d("feedBackText"))]"" s @%GLOBAL@("SETTINGS","SALON_DETAILS","FeedbackText")=d("feedBackText")
	. i $g(d("globalDaysBetweenC"))]"" S @%GLOBAL@("SETTINGS","SALON_DETAILS","globalDaysBetweenC")=d("globalDaysBetweenC")
	. i $g(d("numberMinFeedback"))]"" S @%GLOBAL@("SETTINGS","SALON_DETAILS","numberMinFeedback")=d("numberMinFeedback")
	. i $g(d("feedBackAns5"))]"" s @%GLOBAL@("SETTINGS","SALON_DETAILS","feedBackAns5")=d("feedBackAns5")
	. i $g(d("feedBackAns4"))]"" s @%GLOBAL@("SETTINGS","SALON_DETAILS","feedBackAns4")=d("feedBackAns4")
	. i $g(d("feedBackAns3"))]"" s @%GLOBAL@("SETTINGS","SALON_DETAILS","feedBackAns3")=d("feedBackAns3")
	. i $g(d("feedBackAns2"))]"" s @%GLOBAL@("SETTINGS","SALON_DETAILS","feedBackAns2")=d("feedBackAns2")
	. i $g(d("feedBackAns1"))]"" s @%GLOBAL@("SETTINGS","SALON_DETAILS","feedBackAns1")=d("feedBackAns1")
	. i $g(d("feedBackAnsG"))]"" s @%GLOBAL@("SETTINGS","SALON_DETAILS","feedBackAnsG")=d("feedBackAnsG")
	s @r@("resp")="Saved!"
	zk r
	m rr("data","data")=r
	q
	;
setCRRulesAssign(dd,rr,s)
	n r s r="r"
	n d m d=dd("data")
	n cnt
	s cnt=$o(@%GLOBAL@("CLIENT-RETENSION","RULES",""),-1)+1
	i $g(d("index"))]"" s cnt=d("index")+1
	k @%GLOBAL@("CLIENT-RETENSION","RULES",cnt)
	m @%GLOBAL@("CLIENT-RETENSION","RULES",cnt)=d
	zk r
	m rr("data","data")=r
	q
	;
setCRRules(dd,rr,s)
	n r s r="r"
	n d m d=dd("data")
	k @%GLOBAL@("CLIENT-RETENSION","RULES")
	m @%GLOBAL@("CLIENT-RETENSION","RULES")=d("rules")
	zk r
	m rr("data","data")=r
	q
	;
deleteCRRule(dd,rr,s)
	n r s r="r"
	n d m d=dd("data")
	n cnt
	i $g(d("index"))]"" s cnt=d("index")+1
	i cnt k @%GLOBAL@("CLIENT-RETENSION","RULES",cnt)
	m @r@("crRules")=@%GLOBAL@("CLIENT-RETENSION","RULES")
	zk r
	m rr("data","data")=r
	q
	;
	;
saveOnlinePrompts(dd,rr,s)
	n r s r="r"
	n d m d=dd("data")
	k @%GLOBAL@("ONLINE-BOOKING","PROMPTS")
	M @%GLOBAL@("ONLINE-BOOKING","PROMPTS")=d
	s @r@("status")="saved"
	zk r
	m rr("data","data")=r
	q
	;
	;