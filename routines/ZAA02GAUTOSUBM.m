ZAA02GAUTOSUBM ;;2016-04-28 14:01:34
 ; call from VB
 ;Dependencies:
 ;              EZ
 ;              DATA2
 q
VB
 n TMP,usr,pwd,ent
  ;user name and password for Entity
 s ent=$G(EZ)
 i ent="" s ent=1
 S TMP=$S($D(^REF("COM",ent)):^(ent),1:$G(^REF("COM")))
 S usr=$P(TMP,":",13),pwd=$P(TMP,":",11)
  
 n res
 n formNumber
 
 s formNumber=$P($G(DATA2),":",1)
 s formNumber=$TR(formNumber,"FORM=","")
 
 //now see if there is an override in INS. PROGRAMS for this form number
 s usrOver="" s pwdOver=""
 s usrOver=$P($G(^SETFRMG(ent,formNumber,1)),":",2)
 s pwdOver=$P($G(^SETFRMG(ent,formNumber,1)),":",3)
 
 if ($L(usrOver) & $L(pwdOver)) {
         s usr=usrOver
         s pwd=pwdOver
 }
 s ^DBG1("SubmUsr")=usr
 s ^DBG1("SubmPwd")=pwd
 
 s ^DEBUG("AUTO","SUBM","1")=$H_":"_$ZD($H,5)_"  "_$ZT($P($H,",",2),3)_" entity:"_$G(EZ)_" usr: "_usr_" form:"_formNumber
 s res=$$PROCESSLIST^ZAA02GEMD1(usr,pwd,"",99,formNumber) ; s res=$$PROCESSLIST(usr,pwd,cmd,howMany)
 s ^DEBUG("AUTO","SUBM","2")=$H_":"_$ZD($H,5)_"  "_$ZT($P($H,",",2),3)_" entity:"_$G(EZ)_" usr: "_usr_" result:"_res
 
 q
