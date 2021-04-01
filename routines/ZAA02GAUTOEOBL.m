ZAA02GAUTOEOBL ;;2018-02-07 14:25:51
 ; call from VB
 ;Dependencies:
 ;              EZ
 ;              DATA2
 q ; 
VB b
 
 n TMP,usr,pwd,ent
  ;user name and password for Entity
 s ent=$G(EZ)
 i ent="" s ent=1
 S TMP=$S($D(^REF("COM",ent)):^(ent),1:$G(^REF("COM")))
 S usr=$P(TMP,":",13),pwd=$P(TMP,":",11)
 
 n res
 n formNumber
 ;n finCodes,makeExcel
 
 ;s finCodes="" s makeExcel=0
 ;take form number from  the scheduled report 
 
 s ^DEBUG("AUTO","EOBL","X")=$H_" "_$G(X)
 s ^DEBUG("AUTO","EOBL","DATA2")=$H_" "_$G(DATA2) ; FORM=5:PROGRAM=MODNEIX:INPY:HNDY:HNDA:BLDN:1:reversal-code-here
 
 s DATA2=$G(DATA2)
 s post=1
 s finCode=$p(DATA2,":",1)
 i finCode="" s post=0
 /*s formNumber=$P(DATA2,":",1)
 s formNumber=$TR(formNumber,"FORM=","")
 s makeExcel=+($P(DATA2,":",7)) // 1 or 0
.
 //when 3 fin codes are empty - download but not process
 if ($L($P(DATA2,":",3)) + $L($P(DATA2,":",4))+$L($P(DATA2,":",5))=0)  { 
        s finCodes="DONOTPROCESS" 
        }
 else {  
        s finCodes=$P(DATA2,":",3)_":"_$P(DATA2,":",4)_":"_$P(DATA2,":",5)_":"_$P(DATA2,":",6)_":"_makeExcel 
        s finCodes=finCodes_":"_$P(DATA2,":",8)
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
 }  */
.
.
 s ^DEBUG("AUTO","EOBL","1")=$H_":"_$ZD($H,5)_"  "_$ZT($P($H,",",2),3)_" entity:"_$G(EZ)_" usr: "_usr ;_" form:"_formNumber_" finCodes: "_finCodes
 s res=$$XBS^ZAA02GEMD1(usr,pwd,ent,post,finCode)
 s ^DEBUG("AUTO","EOBL","2")=$H_":"_$ZD($H,5)_"  "_$ZT($P($H,",",2),3)_" entity:"_$G(EZ)_" usr: "_usr_" result:"_res
 
 q
