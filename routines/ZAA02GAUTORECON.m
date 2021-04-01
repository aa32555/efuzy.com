ZAA02GAUTORECON ;;2018-09-05 11:36:44
 ; call from VB
 ;Dependencies:
 ;              EZ
 ;              DATA2
 q ; 
VB
 
 n TMP,usr,pwd,ent
  ;user name and password for Entity
 s ent=$G(EZ)
 i ent="" s ent=1
 S TMP=$S($D(^REF("COM",ent)):^(ent),1:$G(^REF("COM")))
 S usr=$P(TMP,":",13),pwd=$P(TMP,":",11)
 
 n res
 n formNumber
 n finCodes,makeExcel
 
 s finCodes="" s makeExcel=0
 ;take form number from  the scheduled report 
 
 s ^DEBUG("AUTO","RECON","X")=$H_" "_$G(X)
 s ^DEBUG("AUTO","RECON","DATA2")=$H_" "_$G(DATA2) ; FORM=5:PROGRAM=MODNEIX:INPY:HNDY:HNDA:BLDN:1:reversal-code-here:debit adjustment here:coinsurance here:copay here
 
 s DATA2=$G(DATA2)
 s formNumber=$P(DATA2,":",1)
 s formNumber=$TR(formNumber,"FORM=","")
 s makeExcel=+($P(DATA2,":",7)) // 1 or 0
.
 //when 3 fin codes are empty - download but not process
 if ($L($P(DATA2,":",3)) + $L($P(DATA2,":",4))+$L($P(DATA2,":",5))=0)  { 
        s finCodes="DONOTPROCESS" 
        }
 else {  
        s finCodes=$P(DATA2,":",3)_":"_$P(DATA2,":",4)_":"_$P(DATA2,":",5)_":"_$P(DATA2,":",6)_":"_makeExcel 
        s finCodes=finCodes_":"_$P(DATA2,":",8)_":"_$P(DATA2,":",9)_":"_$P(DATA2,":",10)_":"_$P(DATA2,":",11)
        }
.
.
 //now see if there is an override in INS. PROGRAMS for this form number
 n usrOver,pwdOver s usrOver="" s pwdOver=""
 s usrOver=$P($G(^SETFRMG(ent,formNumber,1)),":",2)
 s pwdOver=$P($G(^SETFRMG(ent,formNumber,1)),":",3)
 
 if ($L(usrOver) & $L(pwdOver)) { 
         s usr=usrOver
         s pwd=pwdOver
 }  
.
.
 s ^DEBUG("AUTO","RECON","1")=$H_":"_$ZD($H,5)_"  "_$ZT($P($H,",",2),3)_" entity:"_$G(EZ)_" usr: "_usr_" form:"_formNumber_" finCodes: "_finCodes
 s res=$$RECON^ZAA02GEMD1(usr,pwd,"MODNEIX",ent,formNumber,finCodes)
 s ^DEBUG("AUTO","RECON","2")=$H_":"_$ZD($H,5)_"  "_$ZT($P($H,",",2),3)_" entity:"_$G(EZ)_" usr: "_usr_" form:"_formNumber_" result:"_res
 
 q
