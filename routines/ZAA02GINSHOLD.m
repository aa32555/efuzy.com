ZAA02GINSHOLD(ACCT,INNO) ;;2017-08-30 15:06:14
 ;Returns holder info for specified insurance
 ;Arguments:
 ; ACCT - account number
 ; INNO - insurance number on account (^GRG(ACCT,INNO) = insurance info)
 ;Returns:
 ; name:address 1:address 2:city:state:zip code:phone #:email:fax #:contact:insurance code:insurance company name
 ;      1               2               3                4         5      6               7              8              9               10              11                              12
 ;Zach Pastore 3/29/2017
 ;
 N (ACCT,INNO)
 I '$$VERIFYARGS(.ACCT,"INNO") Q ""
 I 'INNO Q ":::::::::"
 S INSREC=$G(^GRG(ACCT,INNO))
 I INSREC="" Q ""
 S INCD=$P(INSREC,":",3)
 S INS=""
 I INCD'="" S INS=$P($G(^ING(INCD)),":",2)
 S HLD=$P(INSREC,":",6)
 I HLD="E" Q $$EMPLOYER(ACCT)_":"_INCD_":"_INS
 I HLD="G" Q $$GUARANTOR(ACCT)_":"_INCD_":"_INS
 I HLD=+HLD Q $$PATIENT(ACCT,HLD)_":"_INCD_":"_INS
 Q $$OTHER(INSREC)_":"_INCD_":"_INS
 
BYACCT(ACCT,PAT,POS)
 ;Returns holder info for insurance in given position in insurance order on account
 ;Arguments:
 ; ACCT - account number
 ; PAT  - patient number, defaults to guarantor
 ; POS  - position in account insurance order, defaults to 1 (primary)
 ;Returns:
 ; same as ZAA02GINSHOLD 
 ;
 N (ACCT,PAT,POS)
 I '$$VERIFYARGS(.ACCT,"PAT","POS") Q ""
 I 'POS S POS=1
 S ORD=$G(^GRG(ACCT,0))
 I PAT,$D(^PTG(ACCT,PAT,0)) S ORD=$G(^PTG(ACCT,PAT,0))
 S INS=$P(ORD,":",POS)
 Q $$ZAA02GINSHOLD(ACCT,INS)
.
BYCASE(ACCT,PAT,CASE,ENT,POS)
 ;Returns holder info for insurance in given position in insurance order of case
 ;Arguments:
 ; ACCT - account number
 ; PAT  - patient number, defaults to 1
 ; CASE - case number
 ; ENT  - entity
 ; POS  - position in case insurance order, defaults to 1 (primary)
 ;Returns:
 ; same as ZAA02GINSHOLD
 ;
 N (ACCT,PAT,CASE,ENT,POS)
 I '$$VERIFYARGS(.ACCT,"PAT","CASE","ENT","POS") Q ""
 I 'PAT S PAT=1
 I 'POS S POS=1
 I $G(^CASE)=0 S ENT=0
 I ENT="" S CASE=""
 I CASE="" Q ""
 I '$D(^CASE(ACCT,PAT,ENT,CASE)) Q ""
 S ORD=$G(^CASE(ACCT,PAT,ENT,CASE,0))
 S INS=$P(ORD,":",POS)
 Q $$ZAA02GINSHOLD(ACCT,INS)
.
BYAPPTID(APPTID,EZ,POS)
 ;Returns holder info for insurance in given position in insurance order of appointment
 ;Arguments:
 ; APPTID       - appointment id
 ; EZ           - entity, defaults to 1
 ; POS  - position in appointment insurance order, defaults to 1 (primary)
 ;Returns:
 ; same as ZAA02GINSHOLD
 ;
 N (EZ,APPTID,POS)
 S APPTID=$G(APPTID)
 I APPTID="" Q ""
 S EZ=$G(EZ,1)
 D EZ^ZAA02GVBAS
 S APPTREC=$QS($Q(^ZAA02GSCH(PEZ,"SEQN",APPTID)),4)
 S APPTREC=$G(@APPTREC)
 S ACCT=$P(APPTREC,"|",4)
 S PAT=$P(ACCT,"/",2),ACCT=$P(ACCT,"/",1)
 I '$$VERIFYARGS(ACCT,"POS") Q ""
 I 'PAT S PAT=1
 S CASE=+$P(APPTREC,"`",39)
 S CSENT=""
 I CASE D
 . I $G(^CASE)=0 S CSENT=0 Q
 . S CSENT=0 F  S CSENT=$O(^CASE(ACCT,PAT,CSENT)) Q:CSENT=""  I $D(^CASE(ACCT,PAT,CSENT,CASE)) Q
 . Q
 S OUT=$$BYCASE(ACCT,PAT,CASE,CSENT,POS)
 I OUT'="" Q OUT
 Q $$BYACCT(ACCT,PAT,POS)
 
EMPLOYER(ACCT)
 N (ACCT)
 S GREC=$G(^GRG(ACCT))
 S NM=$P(GREC,":",13)
 S ADD1=$P(GREC,":",14)
 S ADD2=""
 S CTST=$P(GREC,":",17)
 S CITY=$P(CTST,",",1,$L(CTST,",")-1)
 S STATE=$P(CTST,",",$L(CTST,","))
 S ZIP=$P(GREC,":",18)
 S PHONE=$P(GREC,":",15)
 S OTHER=$P(GREC,":",27)
 S EMAIL=$P(OTHER,"^",3)
 S FAX=$P(OTHER,"^",2)
 S CONTACT=$P(OTHER,"^",1)
 Q NM_":"_ADD1_":"_ADD2_":"_CITY_":"_STATE_":"_ZIP_":"_PHONE_":"_EMAIL_":"_FAX_":"_CONTACT
 
GUARANTOR(ACCT)
 N (ACCT)
 S GREC=$G(^GRG(ACCT))
 S NM=$P(GREC,":",7)
 S ADD1=$P(GREC,":",8)
 S ADD2=$P(GREC,":",9)
 S CTST=$P(GREC,":",10)
 S CITY=$P(CTST,",",1,$L(CTST,",")-1)
 S STATE=$P(CTST,",",$L(CTST,","))
 S ZIP=$P(GREC,":",11)
 S PHONE=$P(GREC,":",12)
 S OTHER=$P(GREC,":",26)
 S EMAIL=$P(OTHER,"^",4)
 S FAX=""
 S CONTACT=""
 Q NM_":"_ADD1_":"_ADD2_":"_CITY_":"_STATE_":"_ZIP_":"_PHONE_":"_EMAIL_":"_FAX_":"_CONTACT
 
PATIENT(ACCT,PAT)
 N (ACCT,PAT)
 S PREC=$G(^PTG(ACCT,PAT))
 S REL=$P(PREC,":",21)
 S NM=$P(PREC,":",3)
 I (REL="S")!(NM="") Q $$GUARANTOR(ACCT)
 S ADD1=$P(PREC,":",4)
 S ADD2=$P(PREC,":",5)
 S CTST=$P(PREC,":",6)
 S CITY=$P(CTST,",",1,$L(CTST,",")-1)
 S STATE=$P(CTST,",",$L(CTST,","))
 S ZIP=$P(PREC,":",7)
 S PHONE=$P(PREC,":",8)
 S OTHER=$P(PREC,":",28)
 S EMAIL=$P(OTHER,"^",4)
 S FAX=""
 S CONTACT=""
 Q NM_":"_ADD1_":"_ADD2_":"_CITY_":"_STATE_":"_ZIP_":"_PHONE_":"_EMAIL_":"_FAX_":"_CONTACT
 
OTHER(INSREC)
 N (INSREC)
 S NM=$P(INSREC,":",19)
 S ADD1=$P(INSREC,":",20)
 S ADD2=""
 S CITY=$P(INSREC,":",21)
 S STATE=$P(INSREC,":",22)
 S ZIP=$P(INSREC,":",23)
 S PHONE=""
 S EMAIL=""
 S FAX=""
 S CONTACT=""
 Q NM_":"_ADD1_":"_ADD2_":"_CITY_":"_STATE_":"_ZIP_":"_PHONE_":"_EMAIL_":"_FAX_":"_CONTACT 
 
VERIFYARGS(ACCT,ARGS...)
 S ACCT=$G(ACCT)
 I 'ACCT Q 0
 I '$D(^PTG(ACCT)) Q 0
 I $D(ARGS) N I F I=1:1:ARGS S @ARGS(I)=$G(@ARGS(I))
 Q 1
 
