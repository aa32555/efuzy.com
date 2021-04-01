ZAA02GAUTORECV ;;2016-04-28 13:57:58
 ; call from VB
 ;Dependencies:
 ;              EZ
 q
VB
 
 n TMP,usr,pwd,ent
  ;user name and password for Entity
 s ent=$G(EZ)
 i ent="" s ent=1
 S TMP=$S($D(^REF("COM",ent)):^(ent),1:$G(^REF("COM")))
 S usr=$P(TMP,":",13),pwd=$P(TMP,":",11)
.
 ////now see if there is an override in INS. PROGRAMS for this form number
 //s usrOver="" s pwdOver=""
 //s usrOver=$P($G(^SETFRMG(ent,formNumber,1)),":",2)
 //s pwdOver=$P($G(^SETFRMG(ent,formNumber,1)),":",3)
 
 //if ($L(usrOver) & $L(pwdOver)) {
 //      s usr=usrOver
 //      s pwd=pwdOver
 // }
  
 n res
 s ^DEBUG("AUTO","RECV","1")=$H_":"_$ZD($H,5)_"  "_$ZT($P($H,",",2),3)_" entity:"_$G(EZ)_" usr: "_usr
 s res=$$RECV^ZAA02GEMD1(usr,pwd,"MODNEIX")
 s ^DEBUG("AUTO","RECV","2")=$H_":"_$ZD($H,5)_"  "_$ZT($P($H,",",2),3)_" entity:"_$G(EZ)_" usr: "_usr_" result:"_res
 
 q
