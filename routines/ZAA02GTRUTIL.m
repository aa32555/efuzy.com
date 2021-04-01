ZAA02GTRUTIL;;2018-09-17 16:51:16
 ;Transaction utilities
 ;Subroutines and functions named in all capital letters are intended to be callable by external
 ;code. Those named with lower case letters are intended to be called only by other subroutines
 ;and functions within this routine.
 q
 
NXTTR(ENT,TR,DTF,DTT,DTTYP,TRTYP)
 Q $$NXTTR^TRUTIL(ENT,TR,DTF,DTT,DTTYP,TRTYP)
 
NXTRELPAY(ENT,TR,FTR,STORE)
 Q $$NXTRELPAY^TRUTIL(ENT,TR,FTR,STORE)
 
NTHRELCHRG(ENT,TR,N)
 Q $$NTHRELCHRG^TRUTIL(ENT,TR,N)
 
NXTACCTTR(ENT,TR,ACCT,PAT,DTF,DTT,DTTYP,TRTYP)
 Q $$NXTACCTTR^TRUTIL(ENT,TR,ACCT,PAT,DTF,DTT,DTTYP,TRTYP)
   
STATEASOF(TEZ,TR,TIME)
 Q $$STATEASOF^TRUTIL(TEZ,TR,TIME)
 
 ;CHRGAMT(TEZ,K,K1,PC,PV,PS,SDT,QTY,INNO,AR)
 ;
 N (TEZ,K,K1,PC,PV,PS,SDT,QTY,INNO,AR)
 S $P(S,":",44)=INNO
 S $P(S,":",45)=AR
 S XT=SDT
 D AMT^ZAA02GVBSTR
 Q AMT
 
POSTCHRG(ENT,REC,EXPL,WAIT,OTHER)
 ;
 N (ENT,REC,EXPL,WAIT,OTHER)
 I '$P(REC,":",43) S $P(REC,":",43)=$P(REC,":",72)
 S AMT=$P(REC,":",9)
 S ZEROAMT=0
 I AMT'="",'AMT S ZEROAMT=1
 D STOOUT^ZAA02GVBPO8(REC)
 S T("EZ")=ENT
 S T("K")=$P(REC,":",3)
 S T("K1")=$P(REC,":",7)
 I 'T("AMT"),'ZEROAMT S T("AMT")=""
 I '$G(T("CASE")) S T("CASE")=""
 D STORE^ZAA02GVBPO1(.T,.MSG,,,1,1,,.OTHER)
 I MSG D  Q MSG
 . S MSG=0
 . S M="" F  S M=$O(MSG(M)) Q:M=""  S MSG=MSG_"|"_$$TRANS^ZAA02GVBPO6(MSG(M))
 . Q
 D STR^ZAA02GVBSTR(ENT,T("K"),T("K1"),T("HOLD"),$G(T("COPAY")),$G(WAIT),$G(EXPL),,.MSG)
 I MSG D  Q MSG
 . S MSG=0
 . S M="" F  S M=$O(MSG(M)) Q:M=""  S MSG=MSG_"|"_$$TRANS^ZAA02GVBPO6(MSG(M))
 . Q
 I '$G(TR) Q "0|Unexpected error"
 S TRANS=TR
 S K=T("K")
 S K1=T("K1")
 S $ZT="DELTRANS"
 D TAX^ZAA02GVBPO6(ENT,K,K1,T("HOLD"),.TRANS)
 I $G(^ZAA02GVBUSER("CODE","DEFAULTS","POSTAUTOWRITEOFF",0)) D WRITEOFFAP^ZAA02GVBPO6(ENT,T("OP"),T("HOLD"),.TRANS)
 Q TRANS
 
DELTRANS
 S $ZT=""
 N MSG
 D DELTRANS^ZAA02GVBPO8
 S MSG=0
 S M="" F  S M=$O(MSG(M)) Q:M=""  S MSG=MSG_"|"_$$TRANS^ZAA02GVBPO6(MSG(M))
 Q MSG
 
MODCHRG(TR,TREC,USER)
 N (TR,TREC,USER)
 D DELIMS^ZAA02GVBCOD1
 S USER=$G(USER)
 I USER="" S USER="SY"
 S HANDLE=-1
 S K=TR
 S ERR=""
 D CD^ZAA02GVBCOD1(TREC)
 I ERR'="" Q "0|"_ERR
 S DATA=$P(B,$C(246),1)
 D
 . N TREC,TR
 . D SETCD^ZAA02GVBCOD9
 . Q
 I ERR'="" Q "0|"_ERR
 S SAME(1)=""   ;can't change posting date,
 S SAME(3)=""   ;account,
 S SAME(4)=""   ;transaction type,
 S SAME(7)=""   ;patient #,
 S SAME(10)=""  ;distributed amount(controlled by allocations),
 S SAME(73)=""  ;original operator
 S L=$L(TREC,":")
 S NEW=$$TRTEZ^TRUTIL(TR)
 S ENT=$P(NEW,"|",1)
 S NEW=$E(NEW,$L(ENT)+2,$L(NEW))
 F I=1:1:L I '$D(SAME(I)) S $P(NEW,":",I)=$P(TREC,":",I)
 D SAVE^TRUTIL(ENT,TR,NEW,USER)
 Q 1 
 
DELETECHRG(TR,USER)
 ;
 N (TR,USER)
 S USER=$G(USER)
 I USER="" S USER="SY"
 S HANDLE=-1
 S K=TR_"-DELETE"
 S DATA=""
 S ^ZAA02GTVB(HANDLE)=$H
 D CD^ZAA02GVBCOD2
 I $G(ERR)'="" Q "0|"_ERR
 Q 1
.
POSTFIN(EZ,ACCT,PAT,AMT,SDT,FCD,USER,PV,DPT,PLC,CHKNO,COPAY,NODIST)
 ;
 N (EZ,ACCT,PAT,AMT,SDT,FCD,USER,PV,DPT,PLC,CHKNO,COPAY,NODIST)
 S SDT=$ZDH($$YMD^TRUTIL(SDT),8)
 I $G(PV)'="",'$D(^PVG(PV)) S PV=""
 I $G(DPT)'="",'$D(^DPG(DPT)) S DPT=""
 I $G(PLC)'="",'$D(^PSG(PLC)) S PLC=""
 S $P(X,"|",7)=EZ_":"_ACCT_"/"_PAT_":"_SDT
 S P8=FCD_"::"_$G(CHKNO)_"::"_$G(PV)_":"_$G(DPT)_":"_$G(PLC)_":"_AMT
 I $G(COPAY) S $P(P8,":",2)=AMT,$P(P8,":",8)=""
 S $P(X,"|",8)=P8
 S EXTERNAL=1
 D INIT^ZAA02GWEBL
 D SETCOPAY^ZAA02GVBCOD10($G(NODIST))
 I $G(TRPY) Q TRPY
 S B=$$REPLACE^ZAA02GUTILS($P(B,"|",4),"Copay","Financial Transaction")
 Q "0|"_B
 
MODFIN(TR,TREC,USER)
 ;
 N (TR,TREC,USER)
 D DELIMS^ZAA02GVBCOD1
 S $P(X,D1,6)=$P(TREC,":",28)_$C(9)_"1,"_$P(TREC,":",18)_$C(9)_$P(TREC,":",8)_$C(9)_$P(TREC,":",13)
 S $P(X,D1,6)=$P(X,D1,6)_$C(9)_$P(TREC,":",15)_$C(9)_$P(TREC,":",5)_$C(9)
 F I=28,18,8,13,15,5 S USED(I)=""
 S DT=+$P(TREC,":",19)
 S USED(19)=""
 I $L(DT)<8 S DT=19_DT
 S DT=$E(DT,5,$L(DT))_$E(DT,1,4)
 S INFL=$P(TREC,":",6)
 S USED(6)=""
 I INFL="" Q "0|ERROR: NO INTERNAL FINANCIAL CODE"
 S FL=$P($G(^INFL(INFL)),":",1)
 I FL="" Q "0|ERROR: INVALID INTERNAL FINANCIAL CODE"
 S TMP=FL
 S $P(TMP,D7,5)=""
 S TMP=TMP_DT_D7_$P(TREC,":",9)_D7_$P(TREC,":",10)_D7
 F I=9,10 S USED(I)=""
 S X=X_D3_TMP_D3
 S ACCT=$P(TREC,":",3)
 S ENT=+$$TRTEZ^TRUTIL(TR)
 F I=21:1:26,48:1:98 D
 . S USED(I)=""
 . S CHRG=$P(TREC,":",I) 
 . I CHRG="" Q
 . S TMP=1
 . S $P(TMP,D7,6)=$P(CHRG,",",1)
 . S $P(TMP,D7,10)=$P(CHRG,",",2)
 . I $P(CHRG,",",3) D
 .. S PTR=$P(CHRG,",",2)
 .. I PTR'="" D
 ... S PREC=$G(^TRG(ENT,PTR))
 ... I $P(PREC,":",4)="P" D
 .... S INNO=$P($P(PREC,":",44),",",$P(CHRG,",",3))
 .... I INNO'="" S $P(TMP,D7,9)=$P($G(^GRG(ACCT,INNO)),":",3)
 .. Q
 . S X=X_TMP_D8
 . Q
 S HANDLE=-1
 S USER=$G(USER)
 I USER="" S USER="SY"
 S ERR=""
 S K=TR
 D
 . N TREC,USED,ENT,TR
 . D PD^ZAA02GVBCOD2
 . Q
 I ERR'="" Q "0|"_ERR
 S USED(1)=""   ;can't change posting date,
 S USED(3)=""   ;account,
 S USED(4)=""   ;transaction type,
 S USED(7)=""   ;patient #,
 S USED(10)=""  ;undistributed (controlled by amount and allocations),
 S USED(16)=""  ;financial type,
 S USED(37)=""  ;original operator,
 S USED(40)=""  ;whether payment is copay,
 S USED(41)=""  ;check deposit date
 S L=$L(TREC,":")
 S NEW=$G(^TRG(ENT,TR))
 F I=1:1:L I '$D(USED(I)) S $P(NEW,":",I)=$P(TREC,":",I)
 D SAVE^TRUTIL(ENT,TR,NEW,USER)
 Q 1
 
DELETEFIN(TR,USER)
 ;
 N (TR,USER)
 S USER=$G(USER)
 I USER="" S USER="SY"
 S K=TR_"-DELETE"
 S HANDLE=-1
 S ERR=""
 D PD^ZAA02GVBCOD2
 I ERR'="" Q "0|"_ERR
 Q 1
.
APPLYTOSTATEMENT(ENT,TR,PAT,STATDT,USER)
 ;
 N (ENT,TR,PAT,STATDT,USER)
 S FREC=^TRG(ENT,TR)
 I $P(FREC,":",16)'="PRP" Q "0|TRANSACTION NOT PATIENT PAYMENT"
 S ACCT=$P(FREC,":",3)
 S UNAP=$P(FREC,":",10)
 I UNAP<=0 Q 1
 S STP=$G(^ZAA02GSTP(ENT,ACCT,PAT,STATDT,1))
 I STP="" Q "0|NO STATEMENT FOR DATE "_$$SUB^IDATE($$YMD^TRUTIL(STATDT),0)
 S POS=20
 F I=1:1 S LN=$P(STP,":",I) Q:LN=""  D  I (UNAP<=0)!(POS>=98) Q
 . S T=$P(LN,",",1)
 . I (T="F")!(T="L") D
 .. S PTR=$P(LN,",",2)
 .. S CREC=$G(^TRG(ENT,PTR))
 .. I $P(CREC,":",4)="P",$P(CREC,":",7)=$P(FREC,":",7) D
 ... S AMT=$P(CREC,":",9)-$P(CREC,":",10)
 ... I AMT>0 D
 .... I AMT>UNAP S AMT=UNAP
 .... F POS=POS+1:1:98 D  I 'AMT Q
 ..... I POS=27 S POS=48
 ..... I $P(FREC,":",POS)="" D
 ...... S $P(FREC,":",POS)=AMT_","_PTR
 ...... S UNAP=UNAP-AMT
 ...... S AMT=0
 . Q
 S $P(FREC,":",10)=UNAP
 Q $$MODFIN(TR,FREC,$G(USER))
.
