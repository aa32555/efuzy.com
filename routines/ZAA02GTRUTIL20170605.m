ZAA02GTRUTIL;;2017-06-05 09:32:56
 ; Transaction utilities
 q
 
DTLOOP(dtLoop...)
 ;Loops through all transactions in given entity and date range and calls callback
 ;To minimize chance of overwriting public variables used by callback, all variables are
 ;stored in the dtLoop array.
 ;Parameters:
 ; callback                     - label/routine name of callback routine; will be passed entity and transaction #
 ; ent                          - entity
 ; dtf (optional)       - start of date range, (yy)yymmdd format preferred
 ; dtt (optional)       - end of date range, (yy)yymmdd format preferred
 ; dtTyp (optional)     - if "S", based on service date; otherwise posting date
 ;Zach Pastore 4/11/2017
 ; 
 s dtLoop("callback")=$g(dtLoop(1))
 i dtLoop("callback")="" q
 i $t(@dtLoop("callback"))="" q
 s dtLoop("ent")=$g(dtLoop(2))
 i dtLoop("ent")="" q
 s dtLoop("callback")=dtLoop("callback")_"(dtLoopCallback(""ent""),dtLoopCallback(""tr""))"
 s dtLoop("dtf")=$g(dtLoop(3)),dtLoop("dtt")=$g(dtLoop(4))
 i dtLoop("dtf")'?6.8n s dtLoop("dtf")=$$ymd(dtLoop("dtf"))
 i dtLoop("dtt")'?6.8n s dtLoop("dtt")=$$ymd(dtLoop("dtt"))
 s dtLoop("dtTyp")=$g(dtLoop(5))
 i dtLoop("dtTyp")="S" d serv(.dtLoop) q
 d tr(.dtLoop)
 q
 
tr(dtLoop)
 i $l(dtLoop("dtt"))>5 s dtLoop("dtt")=$zdh(dtLoop("dtt"),8,,,,,,,"")
 s dtLoop("tr")=""
 i dtLoop("dtf")'="" d
 . s dtLoop("dtf")=$o(^DAY(dtLoop("dtf")-1))
 . i dtLoop("dtf")'="" s dtLoop("tr")=^DAY(dtLoop("dtf"))-1
 . q
 f  s dtLoop("tr")=$o(^TRG(dtLoop("ent"),dtLoop("tr"))) q:dtLoop("tr")=""  q:dtLoop("dtt")&($g(^TRG(dtLoop("ent"),dtLoop("tr")))>dtLoop("dtt"))  d 
 . d dtLoopCallback(.dtLoop)
 q
 
serv(dtLoop)
 s dtLoop("dt")=dtLoop("dtf")-1 
 f  s dtLoop("dt")=$o(^SVK(dtLoop("ent"),dtLoop("dt"))) q:dtLoop("dt")=""  q:dtLoop("dtt")&(dtLoop("dt")>dtLoop("dtt"))  d
 . s dtLoop("k")="" f  s dtLoop("k")=$o(^SVK(dtLoop("ent"),dtLoop("dt"),dtLoop("k"))) q:dtLoop("k")=""  d
 .. s dtLoop("tr")="" f  s dtLoop("tr")=$o(^SVK(dtLoop("ent"),dtLoop("dt"),dtLoop("k"),dtLoop("tr"))) q:dtLoop("tr")=""  d 
 ... d dtLoopCallback(.dtLoop)
 q
 
dtLoopCallback(dtLoop)
 n dtLoopCallback
 s dtLoopCallback=dtLoop("callback"),dtLoopCallback("ent")=dtLoop("ent"),dtLoopCallback("tr")=dtLoop("tr")
 n dtLoop
 d @dtLoopCallback
 q
 
ymd(date)
 n (date)
 q $$DG^IDATE(date)
 
APPPAY(appPay...)
 ;finds payments/adjustments applied to given charge and calls callback
 ;To minimize chance of overwriting public variables used by callback, all variables are
 ;stored in the appPay array.
 ;Parameters:
 ; callback                     - label/routine name of callback routine; will be passed entity, 
 ;                                              transaction #, amount applied, and insurance order of related 
 ;                                              payment/adjustment
 ; ent                          - entity of given charge
 ; tr                           - transaction # of given charge
 ; str (optional)       - a variable name which will be used to store relationship of applied
 ;                                              payments/adjustments to charges as 
 ;                                              str($j,"app",charge tr #,paymt tr #)=amt applied:ins order.
 ;                                              A global variable is preferable to avoid STORE errors and to 
 ;                                              prevent access to stored relationships from being lost due to 
 ;                                              "New" commands.
 ;                                              While APPPAY will function without this argument, it will be far
 ;                                              more efficient when called for multiple charges from the same account
 ;                                              if the same value is passed for str each time.
 ;Zach Pastore 4/11/2017
 ;
 s appPay("ent")=$g(appPay(2))
 i appPay("ent")="" q
 s appPay("tr")=$g(appPay(3))
 i appPay("tr")="" q
 i $p($g(^TRG(appPay("ent"),appPay("tr"))),":",4)'="P" q
 s appPay("callback")=$g(appPay(1))
 i appPay("callback")="" q
 i $t(@appPay("callback"))="" q
 s appPay("callback")=appPay("callback")_"(appPayCallback(""ent""),appPayCallback(""ftr"")"
 s appPay("callback")=appPay("callback")_",appPayCallback(""amt""),appPayCallback(""inOrd""))"
 s appPay("str")=$g(appPay(4))
 s appPay("str")=$$name(appPay("str")) 
 s appPay("trec")=^TRG(appPay("ent"),appPay("tr"))
 s appPay("k")=$p(appPay("trec"),":",3)
 s appPay("ftr")=$p(appPay("trec"),":",53)-1
 s appPay("ltr")=""
 i appPay("str")'="" s appPay("ltr")=$g(@appPay("str")@($j,"chk",appPay("k"))),@appPay("str")@($j,"chk",appPay("k"))=appPay("ftr")
 f  s appPay("ftr")=$o(^INTR(appPay("ent"),appPay("k"),appPay("ftr"))) q:appPay("ftr")=""  q:(appPay("ltr")'="")&(appPay("ftr")>appPay("ltr"))  d
 . s appPay("frec")=$g(^TRG(appPay("ent"),appPay("ftr")))
 . i "MP"'[$p(appPay("frec"),":",4) d
 .. f appPay("pos")=21:1:26,48:1:99 s appPay("arec")=$p(appPay("frec"),":",appPay("pos")) q:appPay("arec")=""  d
 ... s appPay("amt")=$p(appPay("arec"),",",1),appPay("ctr")=$p(appPay("arec"),",",2),appPay("inOrd")=$p(appPay("arec"),",",3)
 ... i appPay("ctr")="" q
 ... i appPay("ltr")="",appPay("ctr")=appPay("tr") d appPayCallback(.appPay)
 ... i appPay("str")'="" s @appPay("str")@($j,"app",appPay("ctr"),appPay("ftr"))=appPay("amt")_":"_appPay("inOrd")
 . q
 i appPay("ltr")'="" d
 . s appPay("ftr")="" f  s appPay("ftr")=$o(@appPay("str")@($j,"app",appPay("tr"),appPay("ftr"))) q:appPay("ftr")=""  d
 .. s appPay("amt")=$g(@appPay("str")@($j,"app",appPay("tr"),appPay("ftr")))
 .. s appPay("inOrd")=$p(appPay("amt"),":",2),appPay("amt")=+appPay("amt")
 .. d appPayCallback(.appPay)
 q
 
appPayCallback(appPay)
 n appPayCallback
 s appPayCallback=appPay("callback")
 s appPayCallback("ent")=appPay("ent"),appPayCallback("ftr")=appPay("ftr")
 s appPayCallback("amt")=appPay("amt"),appPayCallback("inOrd")=appPay("inOrd")
 n appPay
 d @appPayCallback
 q
 
name(name)
 s $zt="invalidName"
 q $na(@name)
invalidName
 q ""
