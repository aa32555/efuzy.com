ZAA02GSUBAGE ;Insurance Aging by Submission Date ;
 ; ADS Corp. Copyright
 ;
 Q
 ;
VB b
 N (B,EZ,HANDLE,HANDLE2,P2,USER,X)
 ;
 S B=""
 S (DEV,IO)=$I
 S OPZ=USER
 S PR=$S(P2["=":P2,1:+P2) I PR="0",$I'[":" S PR=$I
 S PRG="ZAA02GSUBAGE"
 S Q="1"
 S S=""
 S s=$P(X,"|",7)
 S VAL=$P(X,"|",6)
 S RUN=$P(X,"|",8)
 
 D READFIELDS(s)
 I B'="" Q
 
 I VAL="CHK" S B="EXCEL="_$S(EXCELF]"":"EXCEL"_$C(9)_EXCELF,1:"") Q
 I VAL'="RUN",VAL'="Q=1,R=6",EXCELF]"",$$EXIST^DFILE(EXCELF) S B="1|File '"_EXCELF_"' already exists.  Overwrite?|36|Report|6=1,7=0" Q
 S MODE="W"
 ;
 S COP=1
 S COPY=1
 S K=""
 S PAGE=0
 ;
 I VAL=""!(VAL="Q=1,R=6") S B="||RUN||" Q
 I VAL'="RUN" S B="99|Invalid System Response|16|Report|1=0" Q
 ;
 S ZAA02GVB=1
 S T=$$FOPEN^DFILE(EXCELF,"W","A")
 I T'=1 W:PRREP "Couldn't open file '"_EXCELF_"'." Q
 
 K ^SORT($J)
 S TODAY=+$H
 S BUCKETNO=0
 S ENT="" F  S ENT=$O(ENT(ENT)) Q:ENT=""  D TRLOOP^TRUTIL("STORE^ZAA02GSUBAGE",ENT,,,,"P") ;calls STORE
 I '$D(^SORT($J,"INS")) Q
 S HDR=$$setHeader^REPUTIL(
        "",
        .COL,
        "INCD",         "Insurance Code",
        "INS",          "Insurance Name",
        "AVE",          "Average Payment Time",
        "CHRG0",        "Charges Not Submitted",
        "BAL0",         "Balance Not Submitted"
 )
 F I=1:1:BUCKETNO D
 . S RNG=(BUCKETSIZE*(I-1))_" - "_(BUCKETSIZE*I-1)
 . S HDR=$$setHeader^REPUTIL(HDR,.COL,"CHRG"_I,RNG_" Amount","BAL"_I,RNG_" Balance")
 . Q
 D writeExcel^REPUTIL(HDR,FDEV)
 S INS="" F  S INS=$O(^SORT($J,"INS",INS)) Q:INS=""  D LINE(INS,.COL,BUCKETNO,FDEV)
 I PRREP W "Report written to '"_EXCELF_"'. Click 'Get File' to view."
 Q
 
WRITEFIELDS
 S PRG="ZAA02GSUBAGE"
 S ^ZAA02GVBSYS("REPORT","FIELDS",PRG)="::1:::::1:::::1:2::"
 D WRITEENT^REPUTIL(PRG,1)
 D WRITEINS^REPUTIL(PRG,2)
 D WRITEBUCKETSIZE(PRG,3)
 D WRITEFILE^REPUTIL(PRG,4)
 S $P(^ZAA02GVBUSER("REPORT","DEFAULTS",PRG,0),":",5)=0
 Q
READFIELDS(s)
 D READENT^REPUTIL(s,1,OPZ,,,.ENT,.B) I B'="" Q
 D READINS^REPUTIL(s,2,.INSSEL,,.INSARR)
 D READBUCKETSIZE(s,3,.BUCKETSIZE,.B) I B'="" Q
 D READFILE^REPUTIL(s,4,.EXCELF)
 Q
 
WRITEBUCKETSIZE(PRG,FNO)
 S ^ZAA02GVBSYS("REPORT","FIELDS",PRG,FNO)="Aging Category Size (Days)||:4:Y:1:3:::|??N?N^^?""^""?Y?N|"
 S $P(^ZAA02GVBUSER("REPORT","DEFAULTS",PRG,0),":",FNO)=""
 Q
READBUCKETSIZE(s,FNO,BUCKETSIZE,B)
 S BUCKETSIZE=$P($P(s,":",FNO),"^",2)
 I 'BUCKETSIZE S B="1|Aging Category Size must be at least 1 day|16|Report Error|1=0"
 Q
 
STORE(ENT,TR,TREC) ;called from VB via TRLOOP^TRUTIL
 ;^SORT($J,"INS",insurance code)=#charges paid by ins:sum over charges paid by ins (date of 1st ins payment - last submit date):
 ;                                         1                                          2
 ;                               amount of charges not yet submitted:balance of charges not yet submitted:
 ;                                              3                                  4
 ;                               amount of charges in first age bucket:balance of charges in first age bucket:...
 ;                                                 5                                  6
 N (ENT,TR,TREC,INSSEL,INSARR,TODAY,BUCKETSIZE,BUCKETNO)
 S POS=0
 F I=1:1:4 I $P($P(TREC,":",19),"~",I)'["N" S POS=I Q
 I 'POS Q 1
 S INNO=$P($P(TREC,":",44),",",POS)
 I 'INNO Q 1
 S ACCT=$P(TREC,":",3)
 I 'ACCT Q 1
 S INCD=$P($G(^GRG(ACCT,INNO)),":",3)
 I INCD="" Q 1
 I '$$INCEXC^REPUTIL(INCD,INSSEL,"INSARR") Q 1
 S BAL=$P(TREC,":",9)-$P(TREC,":",10)
 S INSPAIDDT=$$INSPAIDDT(ENT,TR)
 I 'BAL,'INSPAIDDT Q 1
 S SUBDTS=$$^subDts(ENT,TR,INNO,1,-1,,,$NA(^SORT($J,"SUBDT") ) )
 S T=$G(^SORT($J,"INS",INCD))
 I INSPAIDDT D  Q 1
 . F I=1:1 S SUBDT=$ZDH($P(SUBDTS,":",I),5,,,,,,,"") Q:'SUBDT  I SUBDT<=INSPAIDDT Q
 . I SUBDT D
 .. S $P(T,":",1)=$P(T,":",1)+1
 .. S $P(T,":",2)=$P(T,":",2)+INSPAIDDT-SUBDT
 .. S ^SORT($J,"INS",INCD)=T
 . Q
 I 'INSPAIDDT D
 . S SUBDT=$ZDH($P(SUBDTS,":",1),5,,,,,,,"")
 . S BUCKET=0
 . I SUBDT S BUCKET=(TODAY-SUBDT)\BUCKETSIZE+1
 . I BUCKET>BUCKETNO S BUCKETNO=BUCKET
 . S POS=2*BUCKET+3
 . S $P(T,":",POS)=$P(T,":",POS)+$P(TREC,":",9)
 . S $P(T,":",POS+1)=$P(T,":",POS+1)+BAL
 . S ^SORT($J,"INS",INCD)=T
 Q 1
 
INSPAIDDT(ENT,TR)
 N (ENT,TR)
 S INSPAIDDT=0
 D RELPAYLOOP^TRUTIL("INSPAID^ZAA02GSUBAGE",ENT,TR,"^SORT($J)") ;calls INSPAID
 Q INSPAIDDT
 
INSPAID(ENT,tr,FTR,AMT,unused...) ;called from INSPAIDDT via RELPAYLOOP^TRUTIL
 N (ENT,FTR,AMT,INSPAIDDT)
 I 'AMT Q 1
 S FREC=$G(^TRG(ENT,FTR))
 I $P(FREC,":",16)="INP" S INSPAIDDT=$P(FREC,":",1)
 I INSPAIDDT Q 0 ;quit loop if insurance payment found
 Q 1
 
LINE(INS,COL,BUCKETNO,FDEV)
 N (INS,COL,BUCKETNO,FDEV)
 S REC=^SORT($J,"INS",INS)
 S AVE=0
 I $P(REC,":",1) S AVE=$P(REC,":",2)/$P(REC,":",1)
 S LINE=$$setFields^REPUTIL(
        "",
        .COL,
        "INCD",         INS,
        "INS",          $P($G(^ING(INS)),":",2),
        "AVE",          $J(AVE,0,0),
        "CHRG0",        $J($P(REC,":",3)/100,0,2),
        "BAL0",         $J($P(REC,":",4)/100,0,2)
 )
 F I=1:1:BUCKETNO D
 . S POS=2*I+3
 . S LINE=$$setFields^REPUTIL(LINE,.COL,"CHRG"_I,$J($P(REC,":",POS)/100,0,2),"BAL"_I,$J($P(REC,":",POS+1)/100,0,2))
 . Q
 D writeExcel^REPUTIL(LINE,FDEV)
 Q
.
