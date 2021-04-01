SMS
        ;
        ;
        ; recovery key = 4nC9VQSS40QL9695OWYwYqeYzHgsUt1ZoHhWSDxX
        Q
STATUSCALLBACK(Q,R,A)
        S $ZT="^%ETN"
        N BODY S BODY = @Q("body")@(1)
        N STATUS S STATUS = $P($P(BODY,"&MessageStatus=",2),"&")
        S (%ACCOUNT,ACCOUNT) =A("account")
        S (%G)=A("global")
        S %EMAIL=A("email") 
        ;
        N M,MD,OM 
        D getModel^FUZNEW(.M,.MD,"SMS",A("id"),.OM)
        K ^A
        M ^A=OM S ^A=A("id")
        S OM("status")=STATUS
        D saveModel^FUZNEW(.MD,"SMS",.OM)
        ;
        ;
        Q
        ;       
REPLY(Q,R,A)
        ;
        K ^AHM
        M ^AHM=@Q("body")
        ;
        Q
        ;
Model(T)
        N R 
        ;
        S T("F","title")="SMS"
        S T("F","editTitle")="Edit SMS"
        S T("F","multiIndex",1)="date:time"
        ;
        ;
        ;
        I $I(R) 
        S T("M",R,"model")="id"
        S T("M",R,"data","id")=$TR($SYSTEM.Util.CreateGUID(),"-")
        S T("M",R,"type")="number"
        S T("M",R,"rules","required")="true"
        ;
        I $I(R) 
        S T("M",R,"model")="active"
        S T("M",R,"type")="number"
        S T("M",R,"data","active")="true"
        S T("M",R,"rules","required")="true"
        ;
        I $I(R) 
        S T("M",R,"model")="clientid"
        S T("M",R,"data","clientid")=""
        S T("M",R,"type")="string"
        S T("M",R,"rules","required")="true"
        S T("M",R,"index")="true"
        ;
        I $I(R) 
        S T("M",R,"model")="message"
        S T("M",R,"data","message")=""
        S T("M",R,"type")="string"
        S T("M",R,"rules","required")="true"
        ;
        I $I(R) 
        S T("M",R,"model")="phone"
        S T("M",R,"data","phone")=""
        S T("M",R,"type")="number"
        S T("M",R,"rules","required")="true"
        S T("M",R,"index")="true"               
        ;
        I $I(R) 
        S T("M",R,"type")="date"
        S T("M",R,"model")="date"
        S T("M",R,"data","date")=$ZD(+$H)
        S T("M",R,"transformOnIndex")="V=$ZDH(V)"
        S T("M",R,"rules","required")="true"
        ;
        I $I(R) 
        S T("M",R,"type")="time"
        S T("M",R,"model")="time"
        S T("M",R,"data","time")=$ZT($P($H,",",2),4)
        S T("M",R,"transformOnIndex")="V=$ZTH(V)"
        S T("M",R,"rules","required")="true"
        S T("M",R,"index")="true"
        ;
        I $I(R) 
        S T("M",R,"model")="credits"
        S T("M",R,"data","credits")=""
        S T("M",R,"type")="computed"
        S T("M",R,"computed")="updateCredits^SMS"
        S T("M",R,"is")="span"
        S T("M",R,"props","style")="display:none;"
        S T("M",R,"index")="true"
        ;
        I $I(R) 
        S T("M",R,"model")="status"
        S T("M",R,"data","status")="not sent"
        S T("M",R,"type")="string"
        S T("M",R,"rules","required")="true"
        S T("M",R,"index")="true"
        ;
        
        Q
        ;
updateCredits(T)
        N A,M S A="" F  S A=$O(T("model",A)) Q:A=""  S M(T("model",A,"model"))=A
        N V S V=$L(T("model",M("message"),"data","message"))
        N C,DV S C=0 S DV=0
        I V>160 S C=V\153 I V#153 S C=C+1
        I V<=160 S C=1
        S T("model",M("credits"),"data","credits")=C
        Q
        ;
Send(M)
        i M("phone")="" q 0
        n httprequest,Tsc,resp
        s httprequest=##class(%Net.HttpRequest).%New()
        s httprequest.SSLConfiguration="FCMClient"
        s httprequest.Https=1
        s httprequest.Server="api.twilio.com"
        s httprequest.Username=^MI(":WS","TWILIO_SID")
        s httprequest.Password=^MI(":WS","TWILIO_TOKEN")
        n outNumber s outNumber =^MI(":WS","PHONE")
        d httprequest.InsertFormData("From",outNumber)
        d httprequest.InsertFormData("To",M("phone"))
        d httprequest.InsertFormData("Body",M("message"))
    d httprequest.InsertFormData("StatusCallback","https://www.hairsalonsystems.com/servers/"_^MI(":WS","NAME")_"/sms-status-update?"_"id="_M("id")_"&account="_%ACCOUNT_"&global="_$zcvt(%GLOBAL,"O","URL")_"&email="_$zcvt(%EMAIL,"O","URL"))
    s Tsc = httprequest.Post("/2010-04-01/Accounts/"_^MI(":WS","TWILIO_SID")_"/Messages.json/")
        i +Tsc s resp=httprequest.HttpResponse.Data.ReadLine() d
        . I $p($p(resp,"""sid"": """,2),""",")]"" d
        .. S @%G@("SMS","SID:ID",$p($p(resp,"""sid"": """,2),""","))=M("id")
        .. S M("status")=$p($p(resp,"""status"": """,2),""",")
        ;
        q httprequest.HttpResponse
        ;
TEST
        N M,MD,OM 
        D getModel^FUZNEW(.M,.MD,"SMS","",.OM)
        S OM("phone")="+12017530708"
        S OM("message")="HELLO 2"
        D saveModel^FUZNEW(.MD,"SMS",.OM)
        I $$Send(.OM) 
        Q
