ZAA02GRFDPT;;2018-03-13 10:52:32
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
 S PRG="ZAA02GRFDPT"
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
 
 S ENT="" F  S ENT=$O(ENT(ENT)) Q:ENT=""  D SORTCHRG^TRUTIL(ENT,DTF,DTT,DTS,"^SORT($J)","CHECK^ZAA02GRFDPT","REF","DPT")
 D getPos(FDEV,.COLNO)
 S SORT="^SORT($J)"
 K NUM S NUM=0
 K TOT S TOT=0
 S PRREF=""
 F  S SORT=$Q(@SORT) Q:SORT=""  Q:$QS(SORT,1)'=$J  D
 . S REF=$QS(SORT,2)
 . I REF'=PRREF,PRREF'="" D
 .. D LINE(PRREF,.NUM,FDEV,.COLNO)
 .. K NUM S NUM=0
 .. Q
 . S NUM=NUM+1
 . S TOT=TOT+1
 . S DPT=$QS(SORT,3)
 . S NUM(DPT)=$G(NUM(DPT))+1
 . S TOT(DPT)=$G(TOT(DPT))+1
 . S PRREF=REF
 . Q
 I PRREF'="" D LINE(PRREF,.NUM,FDEV,.COLNO)
 D TOT(.TOT,FDEV,.COLNO)
 I PRREP W "Report written to '"_EXCELF_"'. Click 'Get File' to view."
 
 K ^SORT($J)
 U IO
 C FDEV
 Q
.
WRITEFIELDS
 S ^ZAA02GVBSYS("REPORT","FIELDS","ZAA02GRFDPT")="::1:::::1:::::1:2::"
 D WRITEENT
 D WRITEDATE
 D WRITEREF
 D WRITEDPT
 D WRITEFILE
 S $P(^ZAA02GVBUSER("REPORT","DEFAULTS","ZAA02GRFDPT",0),":",6)=0
 Q
READFIELDS(s)
 S D1=":"
 S D2="^"
 S D3=","
 S D4="/"
 D READENT(s) I B'="" Q
 D READDATE(s) I B'="" Q
 D READREF(s) I B'="" Q
 D READDPT(s) I B'="" Q
 D READFILE(s) I B'="" Q
 S COMBINE=1
 Q
 
CHECK(ENT,TR,TREC)
 I '$$CHKRF(TREC) Q 0
 I '$$CHKDPT(TREC) Q 0
 Q 1
 
LINE(REF,NUM,FDEV,COLNO)
 N (REF,NUM,FDEV,COLNO)
 I REF="~" S REF="(none)"
 S LINE=$$setFields(
        "",
        .COLNO,
        "REF",          REF,
        "REFNM",        $P($G(^RFG(REF)),":",2),
        "TOT",          NUM
 )
 S DPT="" F  S DPT=$O(NUM(DPT)) Q:DPT=""  S LINE=$$setFields(LINE,.COLNO,DPT,NUM(DPT))
 D writeExcel(LINE,FDEV)
 Q
 
TOT(TOT,FDEV,COLNO)
 N (TOT,FDEV,COLNO)
 S LINE=$$setFields("",.COLNO,"GTOT",TOT)
 S DPT="" F  S DPT=$O(TOT(DPT)) Q:DPT=""  S LINE=$$setFields(LINE,.COLNO,"TOT "_DPT,TOT(DPT))
 D writeExcel(LINE,FDEV)
 Q
.
 ; Entity
WRITEENT
 N FNO S FNO=1
 S ^ZAA02GVBSYS("REPORT","FIELDS","ZAA02GRFDPT",FNO)="Entity|All:A?Include:I?Exclude:E|:1:Y:1:99::PRM^Entity:|A??N?N^^?""^""?Y?N|"
 S $P(^ZAA02GVBUSER("REPORT","DEFAULTS","ZAA02GRFDPT",0),":",FNO)="A"
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
 S ^ZAA02GVBSYS("REPORT","FIELDS","ZAA02GRFDPT",FNO)="Dates|Service:S?Posting:P|From:6:N:1:10:::"",""?Thru:6:N:1:10:::|??N?N^^?""^""?Y?N|"
 S $P(^ZAA02GVBUSER("REPORT","DEFAULTS","ZAA02GRFDPT",0),":",FNO)="S"
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
 
 ; Referring Physician
WRITEREF
 N FNO S FNO=3
 S ^ZAA02GVBSYS("REPORT","FIELDS","ZAA02GRFDPT",FNO)="Referring Physician|All:A?Include:I?Exclude:E|:1:Y:1:99::RF:|A??N?N^^?""^""?Y?N|"
 S $P(^ZAA02GVBUSER("REPORT","DEFAULTS","ZAA02GRFDPT",0),":",FNO)="A"
 Q
READREF(s)
 N FNO S FNO=3
 S RFS=$E($P(s,D1,FNO))
 I RFS'="A" D
 . S TMP=$TR($P($P(s,D1,FNO),D2,2),D3,D1)
 . F I=1:1:$L(TMP,D1) D
 .. S TMP1=$P(TMP,D1,I)
 .. I TMP1]"" S RFC(TMP1)=""
 Q
 
 ; Department
WRITEDPT
 N FNO S FNO=4
 S ^ZAA02GVBSYS("REPORT","FIELDS","ZAA02GRFDPT",FNO)="Department|All:A?Include:I?Exclude:E|:1:Y:1:99::DP:|A??N?N^^?""^""?Y?N|"
 S $P(^ZAA02GVBUSER("REPORT","DEFAULTS","ZAA02GRFDPT",0),":",FNO)="A"
 Q
READDPT(s)
 N FNO S FNO=4
 S DPS=$E($P(s,D1,FNO))
 I DPS'="A" D
 . S TMP=$TR($P($P(s,D1,FNO),D2,2),D3,D1)
 . F I=1:1:$L(TMP,D1) D
 .. S TMP1=$P(TMP,D1,I)
 .. I TMP1]"" S DPC(TMP1)=""
 Q
.
 ; Create File
WRITEFILE
 N FNO S FNO=5
 S ^ZAA02GVBSYS("REPORT","FIELDS","ZAA02GRFDPT",FNO)="Excel File||:1:Y:1:20:::|??N?N^^?""^""?Y?N|"
 S $P(^ZAA02GVBUSER("REPORT","DEFAULTS","ZAA02GRFDPT",0),":",FNO)=""
 Q
READFILE(s)
 N FNO S FNO=5
 S PRREP=1
 S $P(EXCEL,":",2)=1,EXCELF=$P($P(s,D1,FNO),D2,2) I $P(EXCELF,".",2)="" S $P(EXCELF,".",2)="CSV"
 Q
 
CHKRF(TREC)
 N RF S RF=$P(TREC,":",14)
 I RF="" Q RFS'="I"
 I RFS="I" Q $D(RFC(RF))
 I RFS="E" Q '$D(RFC(RF))
 Q 1
 
CHKDPT(TREC)
 N DPT S DPT=$P(TREC,":",5)
 I DPT="" Q DPS'="I"
 I DPS="I" Q $D(DPC(DPT))
 I DPS="E" Q '$D(DPC(DPT))
 Q 1
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
        i 'COMBINE d
        . s s="10ent"
        . s s(s)="ENTCD^EntCd:ENT^Entity"
        . q
        s s("20ref")="REF^RefCd:REFNM^Referring Physician"
        s s="30dep"
        s s(s)=""
        s s1="50tot"
        s s(s1)=""
        n rf,dp
        s rf="" f  s rf=$o(^SORT($j,rf)) q:rf=""  d
        . s dp="" f  s dp=$o(^SORT($j,rf,dp)) q:dp=""  d
        .. i $d(s1(dp)) q
        .. s s1(dp)=""
        .. s s(s)=s(s)_dp_"^"_dp_" - "_$p(^DPG(dp),":",2)_":"
        .. i s(s1)="" s s(s1)="TOT "_dp_"^Total All Ref; "_dp_" - "_$p(^DPG(dp),":",2)_":" q
        .. s s(s1)=s(s1)_"TOT "_dp_"^"_dp_" - "_$p(^DPG(dp),":",2)_":"
        . q
        s s(s)=s(s)_"TOT^All dpt"
        s s(s1)=s(s1)_"GTOT^Grand Total"
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
