ZAA02GBILLTP ;Transaction Bill Type Report;2018-05-24 09:06:15
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
 S PRG="ZAA02GBILLTP"
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
 
 D addFields(
        .COLNO,
        "ENTCD",
        "ENT",
        "ACCT",
        "PAT",
        "NAME",
        "TR",
        "PC",
        "PCDSC",
        "POST",
        "SERV",
        "ADMT",
        "DSCH",
        "PLCCD",
        "PLC",
        "AMT",
        "BAL"
        )
 S ^SORT($J,0)=$$setFields(
        "",
        .COLNO,
        "ENTCD",        "EntCd",
        "ENT",          "Entity",
        "ACCT",         "Acct#",
        "PAT",          "Pat#",
        "NAME",         "PatNme",
        "TR",           "Tr#",
        "PC",           "ProcCd",
        "PCDSC",        "ProcDsc",
        "POST",         "PostDt",
        "SERV",         "ServDt",
        "ADMT",         "AdmtDt",
        "DSCH",         "DischDt",
        "PLCCD",        "PlaceCd",
        "PLC",          "Place",
        "AMT",          "Amt",
        "BAL",          "Bal"
        )
 S ENT="" F  S ENT=$O(ENT(ENT)) Q:ENT=""  D TRLOOP^TRUTIL("LOOP^ZAA02GBILLTP",ENT,DTF,DTT,DTS,"P")
 S L=$O(^SORT($J,""),-1)
 F I=0:1:L D writeExcel(^SORT($J,I),FDEV)
 I PRREP W "Report written to '"_EXCELF_"'. Click 'Get File' to view."
 
 K ^SORT($J)
 U IO
 C FDEV
 Q
.
WRITEFIELDS
 S ^ZAA02GVBSYS("REPORT","FIELDS","ZAA02GBILLTP")="::1:::::1:::::1:2::"
 D WRITEENT
 D WRITEDATE
 D WRITEFILE
 S $P(^ZAA02GVBUSER("REPORT","DEFAULTS","ZAA02GBILLTP",0),":",4)=0
 Q
READFIELDS(s)
 S D1=":"
 S D2="^"
 S D3=","
 S D4="/"
 D READENT(s) I B'="" Q
 D READDATE(s) I B'="" Q
 D READFILE(s) I B'="" Q
 S COMBINE=0
 Q
 
 ; Entity
WRITEENT
 N FNO S FNO=1
 S ^ZAA02GVBSYS("REPORT","FIELDS","ZAA02GBILLTP",FNO)="Entity|All:A?Include:I?Exclude:E|:1:Y:1:99::PRM^Entity:|A??N?N^^?""^""?Y?N|"
 S $P(^ZAA02GVBUSER("REPORT","DEFAULTS","ZAA02GBILLTP",0),":",FNO)="A"
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
 
 ; Dates
WRITEDATE
 N FNO S FNO=2
 S ^ZAA02GVBSYS("REPORT","FIELDS","ZAA02GBILLTP",FNO)="Dates|Service:S?Posting:P|From:6:N:1:10:::"",""?Thru:6:N:1:10:::|??N?N^^?""^""?Y?N|"
 S $P(^ZAA02GVBUSER("REPORT","DEFAULTS","ZAA02GBILLTP",0),":",FNO)="S"
 Q
READDATE(s)
 N FNO S FNO=2
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
 N FNO S FNO=3
 S ^ZAA02GVBSYS("REPORT","FIELDS","ZAA02GBILLTP",FNO)="Excel File||:1:Y:1:20:::|??N?N^^?""^""?Y?N|"
 S $P(^ZAA02GVBUSER("REPORT","DEFAULTS","ZAA02GBILLTP",0),":",FNO)=""
 Q
READFILE(s)
 N FNO S FNO=3
 S PRREP=1
 S $P(EXCEL,":",2)=1,EXCELF=$P($P(s,D1,FNO),D2,2) I $P(EXCELF,".",2)="" S $P(EXCELF,".",2)="CSV"
 Q
 
LOOP(ENT,TR,TREC)
 N (ENT,TR,TREC,COLNO)
 I '$D(^BILLTP(ENT,TR)) Q 1
 S ACCT=$P(TREC,":",3)
 S PAT=$P(TREC,":",7)
 S NAME=$P(^PTG(ACCT,PAT),":",3)
 I NAME="" S NAME=$P(^GRG(ACCT),":",7)
 S PC=$P(TREC,":",6)
 I PC'="" S PC=$P($G(^INPC(PC)),":",1)
 S PCDSC=""
 I PC'="" S PCDSC=$P($G(^PCG(PC,ENT),$G(^PCG(PC) ) ),":",2)
 S PLC=$P(TREC,":",15)
 S PLCDSC=""
 I PLC'="" S PLCDSC=$P($G(^PSG(PLC)),":",2)
 S LINE=$$setFields(
        "",
        .COLNO,
        "ENTCD",        ENT,
        "ENT",          $P($G(^PRMG(ENT,1)),":",2),
        "ACCT",         ACCT,
        "PAT",          PAT,
        "NAME",         NAME,
        "TR",           TR,
        "PC",           PC,
        "PCDSC",        PCDSC,
        "POST",         $$SUB^IDATE($$DG^IDATE($P(TREC,":",1)),0),
        "SERV",         $$SUB^IDATE($P($P(TREC,":",16),"^",1),0),
        "ADMT",         $$SUB^IDATE($P($P(TREC,":",28),"^",1),0),
        "DSCH",         $$SUB^IDATE($P($P(TREC,":",28),"^",2),0),
        "PLCCD",        PLC,
        "PLC",          PLCDSC,
        "AMT",          $J($P(TREC,":",9)/100,0,2),
        "BAL",          $J(($P(TREC,":",9)-$P(TREC,":",10))/100,0,2)
        )
 S SUBS=0
 S BILLTP=$NA(^BILLTP(ENT,TR))
 F  S BILLTP=$Q(@BILLTP) Q:BILLTP=""  Q:$QS(BILLTP,1)'=ENT  Q:$QS(BILLTP,2)'=TR  D
 . I @BILLTP'["*" D
 .. S SUBS=SUBS+1
 .. I '$D(COLNO("BILLTP"_SUBS)) D ADDFLDS(SUBS,.COLNO)
 .. S LINE=$$BILLTP(LINE,ENT,BILLTP,SUBS,.COLNO)
 . Q
 I SUBS D
 . S LNO=$O(^SORT($J,""),-1)+1
 . S ^SORT($J,LNO)=LINE
 Q 1
.
ADDFLDS(I,COLNO)
 D addFields(
        .COLNO,
        "SUBDT"_I,
        "INSCD"_I,
        "INS"_I,
        "BILLTP"_I
        )
 S ^SORT($J,0)=$$setFields(
        ^SORT($J,0),
        .COLNO,
        "SUBDT"_I,      "SubmtDt "_I,
        "INSCD"_I,      "InsCd "_I,
        "INS"_I,        "Ins "_I,
        "BILLTP"_I,     "Bill Type "_I
        )
 Q
 
BILLTP(LINE,ENT,BILLTP,I,COLNO)
 Q $$setFields(
        LINE,
        .COLNO,
        "SUBDT"_I,      $$SUB^IDATE($QS(BILLTP,3),0),
        "INSCD"_I,      $QS(BILLTP,5),
        "INS"_I,        $P($G(^ING($QS(BILLTP,5),ENT),$G(^ING($QS(BILLTP,5) ) ) ),":",2),
        "BILLTP"_I,     @BILLTP
        )
 
addFields(vec,fields...)
 n (vec,fields)
 s vec=$g(vec)
 f i=1:1:$g(fields) d
 . s vec=vec+1
 . s vec(fields(i))=vec
 q
setFields(line,vec,fields...)
 n (line,vec,fields)
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
.
