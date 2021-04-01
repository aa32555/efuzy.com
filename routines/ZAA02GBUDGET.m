ZAA02GBUDGET;;2019-02-01 17:55:15
 q
.
DebugMode()
        q +$G(^DBG("ON"))
                
WriteOut(filename, soapParams)  //HTML page from file; plus SOAP parameters inserted into a div
        n readfile,dt s dt=""
        s soapParams=$G(soapParams)
        Set readfile=##class(%Library.File).%New(filename)
    if '(readfile.Exists(filename)) {
        w "<!-- source "_filename_" NOT FOUND -->" , !
        w "404"
        q
    }
        w "<!-- source "_filename_" -->" , !
        s soapDone=0 s soapTag="<div id='SOAPparams'></div>"             
                Do readfile.Open("R")
                While 'readfile.AtEnd
                {
                        s dt=readfile.Read(30000)
                        if 'soapDone  //insert SOAPparams into div
                        {  if ($F(dt,soapTag)) 
                                { 
                                s dt=$$REPLACE^ZAA02GUTILS(dt,soapTag,"<div class='dbg' id='SOAPparams'>"_soapParams_"</div>")
                                s soapDone=1
                                }
                        }
                        Write dt, !
                }
                Do readfile.Close()
        q
.
ST ; ZAA02Gweb 
        n (%, RLC)
    n filename
    s filename=$$GetRoot^JSLOAD()_"Budget\Budget.html"
        s soapParams=$G(%("FORM","DATA"))
.
        s soapParams=soapParams_"&RLC="_$G(RLC)                 // will be populated after Premier login screen if login is required
        s usr  = $P($G(^ZAA02GVBUSER("WEB-LOGON",+$H,+$G(RLC)\1)),",",3)
        if $L(usr) s soapParams=soapParams_"&usr="_$G(usr)
        if $$DebugMode() s soapParams=soapParams_"&DBG=1"       
                                                                                                        // permissions for usr; 
        if '($P($G(^OPG(usr,"BUD")),":",2)) d WriteOutNoPermission^ZAA02GUTILS(usr,"BUD") q 
        D WriteOut(filename,soapParams)                                 // insert SoapParams into <div id='SOAPparams'></div> on page 
        q
        
DELETE ; ZAA02Gweb 
 n (RCL,%)
 s dt=%("BODY") //  ent|acct/pat
 s acct=$P(($P(dt,"|",2)),"/",1)
 s res="Cleared for account # "
 if $D(^BUD(acct)) k ^BUD(acct) s res="Deleted for account # "
 w "1|"_res_acct_"."
 q  
.
SAVE ; ZAA02Gweb 
 n (RCL,%)
 d GetModel^ZAA02GUTILS(.M,%("BODY"))
 s acct=$P($G(M("account")),"/",1)
 s dateFrom=$G(M("dateFrom"))
 s numDays=$G(M("numDays"))
 s amount=$G(M("amount"))
 s authBy=$G(M("authBy"))
 s ent=$G(M("ENTITY"))                                          ; logged in entity
 if '$D(^BUD(acct)) { 
        s usr=$G(M("USER"))                                     ; created       
 } else {
        s usr=$P($G(^BUD(acct)),":",5)_","_$G(M("USER")) ; append operator
 }      
 s ^BUD(acct)=dateFrom_":"_numDays_":"_amount_":"_$$REPLACE^ZAA02GUTILS(authBy,":",";")_":"_usr
 w "1|Budget payment plan for acct# "_acct_" saved. "
 q  
.
GETACCT ; ZAA02Gweb 
 n (RCL,%)
 s dt=%("BODY")
 s acctNo=$P(dt,"|",2)
 S ACCT=$P(acctNo,"/",1)
 I ACCT="" S ACCT=" "
 S PAT=$P(acctNo,"/",2)
 I 'PAT S PAT=1
 s ent=$P(dt,"|",1)
 S DEF=""
 
 s err1=$zt s $zt="here1"
 I ACCT'=" " S DEF=$TR($$CPYDEF2^ZAA02GVBUT4(acctNo,$$DG^IDATE(+$H),ent),$C(230),"^")
here1
 s $zt=err1
 S z("patBal")=$P(DEF,$C(9),4)
 
 S NM=$P($G(^PTG(ACCT,PAT)),":",3)
 I NM="" S NM=$P($G(^GRG(ACCT)),":",7)
 I '$D(^PTG(ACCT,PAT)) S NM=""
 S z("ACCT")=$S($D(^PTG(ACCT,PAT)):ACCT_"/"_PAT,1:"")
 S z("NAME")=NM
 
 s z("hasBudget")=$D(^BUD(ACCT)) 
 S z("dateFrom")=$P($G(^BUD(ACCT)),":",1)
 S z("numDays")=$P($G(^BUD(ACCT)),":",2)
 S z("amount")=$P($G(^BUD(ACCT)),":",3)
 S z("authBy")=$P($G(^BUD(ACCT)),":",4)
 ;s z("info")="Op: "_$P($G(^BUD(ACCT)),":",5) ; 
 s info=$P($G(^BUD(ACCT)),":",5) s usr2=""
 if $L(info,",")>1 s usr2=$P(info,",",$L(info,",")) //last modified by
 s z("info")="Op: "_$P(info,",",1)                                      //created by
 if $L(usr2) s z("info")=z("info")_", "_usr2
 w $$strJSON^ZAA02GUTILS($NA(z))
 q
.
.
.
.
.
