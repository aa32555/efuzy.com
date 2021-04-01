ZAA02GOPACC ; Operator Access Report;2017-07-26 14:05:33
 ;ADS Corp. Copyright
 ;
 Q
 ;
VB
 N (B,EZ,HANDLE,HANDLE2,P2,USER,X)
 ;
 S B=""
 S D1=":"
 S D2="^"
 S D3=","
 S D4="/"
 S IO=$I
 S OPZ=USER
 S PR=$S(P2["=":P2,1:+P2) I PR="0" S PR=$I
 S Q="1"
 S S=""
 S s=$P(X,"|",7)
 S VAL=$P(X,"|",6)
 ;
 ; Operators
 S OPS=$P($P(s,":",1),"^",1)
 I OPS'="A" D
 . S OPC=$P($P(s,":",1),"^",2)
 . F I=1:1:$L(OPC,",") D
 .. S TMP=$P(OPC,",",I)
 .. I TMP'="" S OPC(TMP)=""
 . Q
 ;
 ; Dates
 S DTF=$ZDH($P($P($P(s,":",2),"^",2),",",1),5,,,,,,,"")
 S DTT=$ZDH($P($P($P(s,":",2),"^",2),",",2),5,,,,,,,"")
 ;
 ; Excel File
 S (EXCEL,EXCELF)=""
 S PRREP=1
 S $P(EXCEL,":",2)=1,EXCELF=$P($P(s,D1,3),D2,2) I $P(EXCELF,".",2)="" S $P(EXCELF,".",2)="CSV"
 I VAL="CHK" S B="EXCEL="_$S(EXCELF]"":"EXCEL"_$C(9)_EXCELF,1:"") Q
 I VAL'="RUN",VAL'="Q=2,R=6",EXCELF]"",$$EXIST^DFILE(EXCELF) S B="2|File '"_EXCELF_"' already exists.  Overwrite?|36|Report|6=1,7=0" Q
 S MODE="W"
 ;
 S COP=1
 S DLM=""","""
 S DLM2=""""
 S MODE="W"
 S PGE=0
 ;
 I VAL=""!(VAL="Q=1,R=6")!(VAL="Q=2,R=6") S B="||RUN||" Q
 I VAL'="RUN" S B="99|Invalid System Response|16|Report|1=0" Q
 ;
 S ZAA02GVB=1
.
 S T=$$FOPEN^DFILE(EXCELF,MODE,"A")
 I 'T W:PRREP "Unable to open file '"_EXCELF_"'." Q
 K ^SORT($J)
 D getPos
 I OPS="I" D INCLUDE Q
 S OP="" F  S OP=$O(^ACTACC("USER",OP)) Q:OP=""  D
 . I OPS="E",$D(OPC(OP)) Q
 . D PRINT(OP)
 I PRREP W "Report written to '"_EXCELF_"'. Click 'Get File' to view."
 Q
 
INCLUDE
 S OP="" F  S OP=$O(OPC(OP)) Q:OP=""  I $D(^ACTACC("USER",OP)) D PRINT(OP)
 I PRREP W "Report written to '"_EXCELF_"'. Click 'Get File' to view."
 Q
 
PRINT(OP)
 S SW=0
 S DT=DTF-1
 F  S DT=$O(^ACTACC("USER",OP,DT)) Q:DT=""  Q:(DTT'="")&(DT>DTT)  D
 . S ACCT="" F  S ACCT=$O(^ACTACC("USER",OP,DT,ACCT)) Q:ACCT=""  D
 .. S FUNC="" F  S FUNC=$O(^ACTACC("USER",OP,DT,ACCT,FUNC)) Q:FUNC=""  S SW=1 D LINE(OP,DT,ACCT,FUNC)
 . Q
 I SW D writeExcel("")
 Q
 
LINE(OP,DT,ACCT,FUNC)
 N K,K1,NM
 S K=$P(ACCT,"/",1)
 S K1=$P(ACCT,"/",2)
 I 'K1 S K1=1
 S NM=$P($G(^PTG(K,K1)),":",3)
 I NM="" S NM=$P($G(^GRG(K)),":",7)
 D writeExcel($$setFields("",
                                                         "OP",          OP,
                                                         "OPNM",        $P($G(^OPG(OP)),":",2),
                                                         "DT",          $$SUB^IDATE($$DG^IDATE(DT),0),
                                                         "ACCT",        ACCT,
                                                         "NM",          NM,
                                                         "FUNC",        $$FUN^ZAA02GVBW6T(FUNC)
                                                  )
                          )
 Q
 
setFields(line,fields...)
        f i=1:2:$g(fields) d setFld(.line,fields(i),fields(i+1))
        q line
setFld(result,fld,value)
         q:fld=""
         q:'$d(vec(fld))
         s $p(result,DLM,vec(fld))=value 
         q
writeExcel(RECLH) ;
          S RECLH=""""_RECLH_""""
          N T s T=$Y U FDEV W RECLH,! S $Y=T U:PRREP PR
          q
getPos ; get the positions of the fields for excel
        N s,s1,i,t,idx
        k vec,recHdr
        s s("10")="OP^Operator Code:OPNM^Operator:DT^Date:ACCT^Account:NM^Patient Name:FUNC^Function"
        s idx="",pos=1
        f  s idx=$o(s(idx)) q:idx=""  d
        .s s1=s(idx)
        .f i=1:1 q:$p(s1,":",i)=""  d  
                ..s t=$p(s1,":",i) 
                ..s vec($p(t,"^",1))=pos
                ..s pos=pos+1
                ..s $p(recHdr,DLM,vec($p(t,"^",1)))=$tr($p(t,"^",2),";",":")
        d writeExcel(recHdr)
        k s
        q
.
 
.
