ZAA02GISTAT ; Insurance Submission/Payment Statistics;2018-03-08 13:08:04
 ; ADS Corp. Copyright
 ;
 Q
 ;
VB
 N (B,EZ,HANDLE,HANDLE2,P2,USER,X)
 ;
 S B=""
 S (DEV,IO)=$I
 S OPZ=USER
 S PR=$S(P2["=":P2,1:+P2) I PR="0",$I'[":" S PR=$I
 S PRG="ZAA02GISTAT"
 S Q="1"
 S S=""
 S s=$P(X,"|",7)
 S VAL=$P(X,"|",6)
 S RUN=$P(X,"|",8)
 D READFIELDS(s)
 I B'="" Q
 I VAL="CHK" S B="EXCEL="_$S(EXCELF]"":"EXCEL"_$C(9)_EXCELF,1:"") Q
 I VAL'="RUN",VAL'="Q=2,R=6",EXCELF]"",$$EXIST^DFILE(EXCELF) S B="2|File '"_EXCELF_"' already exists.  Overwrite?|36|Report|6=1,7=0" Q
 S MODE="W"
 ;
 S COP=1
 S COPY=1
 S K=""
 S PAGE=0
 ;
 I VAL=""!(VAL="Q=1,R=6")!(VAL="Q=2,R=6") S B="||RUN||" Q
 I VAL'="RUN" S B="99|Invalid System Response|16|Report|1=0" Q
 ;
 S ZAA02GVB=1
 K ^SORT($J)
 S T=$$FOPEN^DFILE(EXCELF,"W","A")
 I T'=1 W:PRREP "Couldn't open file '"_EXCELF_"'." Q
 
 S MAXSUB=0
 S ENT="" F  S ENT=$O(ENT(ENT)) Q:ENT=""  D TRLOOP^TRUTIL("STORE^ZAA02GISTAT",ENT,DTF,DTT,DTS,"P")
 S GLBL="^SORT($J)"
 D getPos(FDEV,.COLNO)
 S TOT=""
 S PRVENT=""
 F  S GLBL=$Q(@GLBL) Q:GLBL=""  Q:$QS(GLBL,1)'=$J  Q:'$QS(GLBL,2)  D
 . S STRENT=$QS(GLBL,2)
 . I 'COMBINE,PRVENT'="",STRENT'=PRVENT D TOT(TOT(PRVENT),PRVENT,MAXSUB,FDEV,.COLNO)
 . S PRVENT=STRENT
 . D LINE($QS(GLBL,6),$QS(GLBL,3),$QS(GLBL,4),$QS(GLBL,5),@GLBL,FDEV,.COLNO)
 . S $P(TOT(STRENT),":",1)=$P($G(TOT(STRENT)),":",1)+1
 . S $P(TOT,":",1)=$P(TOT,":",1)+1
 . S SUBNO=$P(@GLBL,":",4)
 . I SUBNO D
 .. S $P(TOT(STRENT),":",SUBNO+1)=$P($G(TOT(STRENT)),":",SUBNO+1)+1
 .. S $P(TOT,":",SUBNO+1)=$P(TOT,":",SUBNO+1)+1
 . Q
 I 'COMBINE D TOT(TOT(PRVENT),PRVENT,MAXSUB,FDEV,.COLNO)
 D TOT(TOT,"",MAXSUB,FDEV,.COLNO)
 I PRREP W "Report written to '"_EXCELF_"'. Click 'Get File' to view."
 K ^SORT($J)
 Q
.
WRITEFIELDS
 S ^ZAA02GVBSYS("REPORT","FIELDS","ZAA02GISTAT")="::1:::::1:::::1:2::"
 D WRITEENT
 D WRITEINS
 D WRITEDATE
 D WRITEFILE
 S $P(^ZAA02GVBUSER("REPORT","DEFAULTS","ZAA02GISTAT",0),":",5)=0
 Q
READFIELDS(s)
 S D1=":"
 S D2="^"
 S D3=","
 S D4="/"
 D READENT(s) I B'="" Q
 D READINS(s) I B'="" Q
 D READDATE(s) I B'="" Q
 D READFILE(s) I B'="" Q
 S COMBINE=0
 Q
 ;
 
STORE(ENT,TR,TREC)
 N FLG S FLG=$P($P(TREC,":",19),"~",1)
 I $E(FLG,2)'=2,$E(FLG,2)'=3 Q 1
 N ACCT S ACCT=$P(TREC,":",3)
 I ACCT="" Q 1
 N INNO S INNO=$P($P(TREC,":",44),",",1)
 I INNO="" Q 1
 N INCD S INCD=$P($G(^GRG(ACCT,INNO)),":",3)
 I INCD="" Q 1
 I INS="I",'$D(INC(INCD)) Q 1
 I INS="E",$D(INC(INCD)) Q 1
 N FM,N,PDT
 S FM="" F  S FM=$O(^SUBHIS(ENT,ACCT,TR,FM)) Q:FM=""  D
 . S N=$O(^SUBHIS(ENT,ACCT,TR,FM,INNO,""),-1)
 . I N="" Q
 . S PDT(+$P(^SUBHIS(ENT,ACCT,TR,FM,INNO,N),":",1))=$P(^SUBHIS(ENT,ACCT,TR,FM,INNO,N),":",3)
 . Q
 S PDT=$O(PDT(""),-1)
 I PDT="" Q 1
 N SUBDTS S SUBDTS=$$^subDts(ENT,TR,INNO,1,,,,$NA(^SORT($J,"SUBDTS") ) )
 I $TR(SUBDTS,":")="" Q 1
 N L S L=$L(SUBDTS,":")
 N I,SUBDT 
 F I=1:1:L S SUBDT=$P(SUBDTS,":",I) I SUBDT>PDT S I=I-1 Q
 N SUBNO S SUBNO=I
 I 'SUBNO Q 1
 I SUBNO>MAXSUB S MAXSUB=SUBNO
 N STRENT S STRENT=ENT
 I COMBINE S STRENT=100
 S ^SORT($J,STRENT,ACCT,$P(TREC,":",7),TR,ENT)=INCD_":"_$TR(SUBDTS,":",",")_":"_PDT_":"_SUBNO
 Q 1
 
LINE(ENT,ACCT,PAT,TR,DATA,FDEV,COLNO)
 N (ENT,ACCT,PAT,TR,DATA,FDEV,COLNO)
 S NM=$P($G(^PTG(ACCT,PAT)),":",3)
 I NM="" S NM=$P($G(^GRG(ACCT)),":",7)
 S TREC=$G(^TRG(ENT,TR))
 S PC=$P(TREC,":",6)
 I PC'="" S PC=$P($G(^INPC(PC)),":",1)
 S PCDSC=""
 I PC'="" S PCDSC=$P($G(^PCG(PC)),":",2)
 S SUBDTS=$P(DATA,":",2)
 S L=$L(SUBDTS,",")
 F I=1:1:L S $P(SUBDTS,",",I)=$$SUB^IDATE($P(SUBDTS,",",I),0)
 D writeExcel(
        $$setFields(
                "",
                .COLNO,
                "ENTCD",        ENT,
                "ENT",          $P($G(^PRMG(ENT,1)),":",2),
                "ACCT",         ACCT_"/"_PAT,
                "NM",           NM,
                "TR",           TR,
                "INSCD",        $P(DATA,":",1),
                "INS",          $P($G(^ING($P(DATA,":",1) ) ),":",2),
                "POST",         $$SUB^IDATE($$DG^IDATE($P(TREC,":",1)),0),
                "SRV",          $$SUB^IDATE($P($P(TREC,":",16),"^",1),0),
                "PROCCD",       PC,
                "PROC",         PCDSC,
                "SUBDTS",       SUBDTS,
                "PDT",          $$SUB^IDATE($P(DATA,":",3),0),
                "SUBNO",        $P(DATA,":",4),
                "FLAG",         $P($P(TREC,":",19),"~",1)
        ),
        FDEV
 )
 Q
 
TOT(DATA,ENT,MAXSUB,FDEV,COLNO)
 N (DATA,ENT,MAXSUB,FDEV,COLNO)
 S LINE=""
 I 'ENT S ENT=""
 I ENT D
 . S LINE=$$setFields("",.COLNO,"ENTCD",ENT,"ENT",$P($G(^PRMG(ENT,1)),":",2))
 . S ENT="ENT"
 . Q
 S TOT=$P(DATA,":",1)
 S LINE=$$setFields(LINE,.COLNO,ENT_"TOT",TOT)
 F I=2:1:MAXSUB+1 D
 . S NUM=+$P(DATA,":",I)
 . S PER=0
 . I TOT S PER=NUM/TOT
 . S LINE=$$setFields(LINE,.COLNO,ENT_"CLM"_(I-1),NUM,ENT_"%"_(I-1),100*PER_"%")
 . Q
 D writeExcel(LINE,FDEV)
 Q
 
 ; Entity
WRITEENT
 N FNO S FNO=1
 S ^ZAA02GVBSYS("REPORT","FIELDS","ZAA02GISTAT",FNO)="Entity|All:A?Include:I?Exclude:E|:1:Y:1:99::PRM^Entity:|A??N?N^^?""^""?Y?N|"
 S $P(^ZAA02GVBUSER("REPORT","DEFAULTS","ZAA02GISTAT",0),":",FNO)="A"
 Q
READENT(s)
 N FNO S FNO=1
 S ENTERR=""
 S ENTLST=$TR($P($P(s,D1,FNO),D2,2),D3,D1)
 S SELENT=$E($P(s,D1,FNO))
 D ^OPENT
 I ENTERR'="" S B="1|"_ENTERR_"|16|Report Error|1=0" Q
 F I=1:1:$L(ENTLST,D1) D
 . S TMP=$P(ENTLST,D1,I)
 . I TMP]"",$D(^TRG(TMP)) S ENT(TMP)=""
 Q
 
 ; Insurance Companies
WRITEINS
 N FNO S FNO=2
 S ^ZAA02GVBSYS("REPORT","FIELDS","ZAA02GISTAT",FNO)="Insurance Company|All:A?Include:I?Exclude:E|:1:Y:1:99::IN:|A??N?N^^?""^""?Y?N|"
 S $P(^ZAA02GVBUSER("REPORT","DEFAULTS","ZAA02GISTAT",0),":",FNO)="A"
 Q
READINS(s)
 N FNO S FNO=2
 S INH="Ins Carr.:  "
 S INS=$E($P(s,D1,FNO))
 I INS="A" S INH=INH_"All"
 E  D
 . S TMP=$TR($P($P(s,D1,FNO),D2,2),D3,D1)
 . F I=1:1:$L(TMP,D1) D
 .. S TMP1=$P(TMP,D1,I)
 .. I TMP1]"" S INC(TMP1)=""
 . I INS="E" S INH=INH_"Excluded "
 . I INS="I" S INH=INH_"Selected "
 . S TMP=""
 . F  S TMP=$O(INC(TMP)) Q:TMP=""  S INH=INH_TMP_" "
 Q
 
 ; Dates
WRITEDATE
 N FNO S FNO=3
 S ^ZAA02GVBSYS("REPORT","FIELDS","ZAA02GISTAT",FNO)="Dates|Service:S?Posting:P|From:6:N:1:10:::"",""?Thru:6:N:1:10:::|??N?N^^?""^""?Y?N|"
 S $P(^ZAA02GVBUSER("REPORT","DEFAULTS","ZAA02GISTAT",0),":",FNO)="S"
 Q
READDATE(s)
 N FNO S FNO=3
 S DTS=$E($P(s,D1,FNO))
 S TMP=$TR($P($P($P(s,D1,FNO),D2,2),D3),"_")
 S TMP=$P(TMP,D4,3)_$P(TMP,D4)_$P(TMP,D4,2)
 S DTF=$$DG^IDATE(TMP,1)
 S TMP=$TR($P($P($P(s,D1,FNO),D2,2),D3,2),"_")
 S TMP=$P(TMP,D4,3)_$P(TMP,D4)_$P(TMP,D4,2)
 S DTT=$$DG^IDATE(TMP,1)
 I 'TMP S DTT=$$DG^IDATE(+$H)
 Q
 
 ; Create File
WRITEFILE
 N FNO S FNO=4
 S ^ZAA02GVBSYS("REPORT","FIELDS","ZAA02GISTAT",FNO)="Excel File||:1:Y:1:20:::|??N?N^^?""^""?Y?N|"
 S $P(^ZAA02GVBUSER("REPORT","DEFAULTS","ZAA02GISTAT",0),":",FNO)=""
 Q
READFILE(s)
 N FNO S FNO=4
 S PRREP=1
 S $P(EXCEL,":",2)=1,EXCELF=$P($P(s,D1,FNO),D2,2) I $P(EXCELF,".",2)="" S $P(EXCELF,".",2)="CSV"
 Q
.
setFields(line,vec,fields...)
        f i=1:2:$g(fields) d setFld(.line,fields(i),fields(i+1))
        q line
setFld(result,fld,value)
         q:fld=""
         q:'$d(vec(fld))
         s $p(result,""",""",vec(fld))=value 
         q
writeExcel(RECLH,FDEV) ;
          S RECLH=""""_RECLH_""""
          N T,IO s T=$Y,IO=$I U FDEV W RECLH,! U IO S $Y=T 
          q
getPos(FDEV,vec) ; get the positions of the fields for excel
        N s,s1,i,t,idx
        k recHdr
        s s="10ent"
        i COMBINE s s="30ent"
        s s(s)="ENTCD^EntCd:ENT^Entity"
        s s("20pat")="ACCT^Acct#:NM^Patient Name"
        s s("40trans")="TR^Trans#:INSCD^InsCd:INS^Insurance:POST^PostDt:SRV^ServDt:PROCCD^ProcCd:"
        s s("40trans")=s("40trans")_"PROC^Procedure:SUBDTS^SubmtDtes:PDT^Pay/DenyDte:SUBNO^#Submt before Pay:"
        s s("40trans")=s("40trans")_"FLAG^Flag"
        i 'COMBINE d
        . s s="50entTot"
        . s s(s)="ENTTOT^Entity Total #:ENTCLM1^# paid after 1 submt:ENT%1^% paid after 1 submt" 
        . f i=2:1:MAXSUB s s(s)=s(s)_":ENTCLM"_i_"^# after "_i_":ENT%"_i_"^% after "_i
        . q
        s s="60tot"
        s s(s)="TOT^Grand Total #:CLM1^# paid after 1 submt:%1^% paid after 1 submt" 
        f i=2:1:MAXSUB s s(s)=s(s)_":CLM"_i_"^# after "_i_":%"_i_"^% after "_i
    s idx="",pos=1
        f  s idx=$o(s(idx)) q:idx=""  d
        .s s1=s(idx)
        .f i=1:1 q:$p(s1,":",i)=""  d  
                ..s t=$p(s1,":",i) 
                ..s vec($p(t,"^",1))=pos
                ..s pos=pos+1
                ..s $p(recHdr,""",""",vec($p(t,"^",1)))=$tr($p(t,"^",2),";",":")
        d writeExcel(recHdr,FDEV)
        k s
        q
