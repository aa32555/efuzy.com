ZAA02GCCTRLST ;Credit Card Trans List;2017-04-25 11:06:00
 ;
VB
 N (B,EZ,HANDLE,HANDLE2,P2,USER,X)
 ;
 S B=""
 S D1=":"
 S D2="^"
 S D3=","
 S D4="/"
 S (DEV,IO)=$I
 S OPZ=USER
 S PR=$S(P2["=":P2,1:+P2) I PR="0",$I'[":" S PR=$I
 S PRG="ZAA02GCCTRLST"
 S Q="1"
 S S=""
 S s=$P(X,"|",7)
 S VAL=$P(X,"|",6)
 ;
 ; Entity
 S ENTERR=""
 S ENTLST=$TR($P($P(s,D1),D2,2),D3,D1)
 S SELENT=$E($P(s,D1))
 D ^OPENT
 I ENTERR'="" S B="1|"_ENTERR_"|16|Report Error|1=0" Q
 F I=1:1:$L(ENTLST,D1) D
 . S TMP=$P(ENTLST,D1,I)
 . I TMP]"",$D(^TRG(TMP)) S ENT(TMP)=""
 ;
 ; Dates
 S DTF=$TR($P($P($P(s,D1,2),D2,2),D3,1),"_")
 S DTT=$TR($P($P($P(s,D1,2),D2,2),D3,2),"_")
 S DTF=$P(DTF,D4,3)_$P(DTF,D4)_$P(DTF,D4,2)
 S DTT=$P(DTT,D4,3)_$P(DTT,D4)_$P(DTT,D4,2)
 I 'DTT S DTT=$$DG^IDATE
 ;
 ; Void
 S VOID=$E($P(s,":",3),1)
 ;
 ; Posted
 S POSTED=$E($P(s,":",4),1)
 ;
 ; Excel File
 S (EXCEL,EXCELF)=""
 S PRREP=1
 S $P(EXCEL,":",2)=1,EXCELF=$P($P(s,D1,5),D2,2) I $P(EXCELF,".",2)="" S $P(EXCELF,".",2)="CSV"
 I VAL="CHK" S B="EXCEL="_$S(EXCELF]"":"EXCEL"_$C(9)_EXCELF,1:"") Q
 I VAL'="RUN",VAL'="Q=1,R=6",EXCELF]"",$$EXIST^DFILE(EXCELF) S B="1|File '"_EXCELF_"' already exists.  Overwrite?|36|Report|6=1,7=0" Q
 S MODE="W"
 ;
 I VAL=""!(VAL="Q=1,R=6") S B="||RUN||" Q
 I VAL'="RUN" S B="99|Invalid System Response|16|Report|1=0" Q
 S T=$$FOPEN^DFILE(EXCELF,MODE,"A"),EXCEL=1 I T'=1 W:PRREP "Couldn't open file" Q
 S COP=1
 S COPY=1
 S DLM=""",""",DLM2=""""
.
 D getPos
 S PRF=$G(^MSCG("CreditModule","MerchantCodeMapping","PV"))
 S TEZ="" F  S TEZ=$O(ENT(TEZ)) Q:TEZ=""  D
 . Set returnList = ##class(Adsc.MedicsPremier.CreditCardTransaction).TransactionList(DTF,DTT,TEZ,VOID,POSTED)
 . Set listLength = $ListLength(returnList)
 . For J=1:1:listLength D
 .. S DATA=$LG(returnList,J)
 .. F LNO=1:1:$L(DATA,$C(230)) D
 ... S LINE=$P(DATA,$C(230),LNO)
 ... F I=2:1:$L(LINE,$C(9)) D
 .... S TMP=$P(LINE,$C(9),I)
 .... S $E(TMP,$L(TMP)-2,$L(TMP))=""
 .... S $P(LINE,$C(9),I)=TMP 
 .... Q
 ... I $TR(LINE,$C(9))'="" D PRINT(TEZ,LINE,PRF,.PRVMAP)
 . Q
 I PRREP U PR W "Report written to '"_EXCELF_"'. Click 'Get File' to view."
 Q
 
PRINT(TEZ,LINE,PRF,PRVMAP)
 S (PRV,DESC)=""
 S MERCH=$P(LINE,$C(9),11)
 I PRF'="",MERCH'="" D
 . I '$D(PRVMAP(MERCH)) S PRVMAP(MERCH)=$$FINDMERCH(PRF,MERCH)
 . S PRV=PRVMAP(MERCH)
 . Q
 I PRV'="" S DESC=$P($G(^PVG(PRV,TEZ),$G(^PVG(PRV))),":",2)
 D writeExcel($$setFields("",
                                                         "ENT",         TEZ,
                                                         "ACCT",        $P(LINE,$C(9),2),
                                                         "PAT",         $P(LINE,$C(9),3),
                                                         "NAME",        $P(LINE,$C(9),4),
                                                         "DATE",        $P(LINE,$C(9),5),
                                                         "AMT",         $P(LINE,$C(9),6),
                                                         "EFF",         $P(LINE,$C(9),7),
                                                         "AUTH",        $P(LINE,$C(9),8),
                                                         "TYP",         $P(LINE,$C(9),9),
                                                         "TR",          $P(LINE,$C(9),10),
                                                         "MERCH",       MERCH,
                                                         "PVCD",        PRV,
                                                         "PROV",        DESC
                                                 )
                         )
 Q
 
FINDMERCH(PRF,MERCH)
 N (PRF,MERCH)
 S PRV=""
 S CTR="" F  S CTR=$O(^EDI("PRF",PRF,"TABLE","PV",CTR)) Q:CTR=""  D  Q:PRV'=""
 . S REC=^EDI("PRF",PRF,"TABLE","PV",CTR)
 . I $P(REC,"`",1)=MERCH S PRV=$P(REC,"`",3)
 Q PRV
.
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
        s s("10hdr")="ENT^Entity:ACCT^Account:PAT^Pat:NAME^Name:DATE^Paid Date:AMT^Paid Amt:EFF^Eff Amt:"
                                 _"AUTH^Auth Trans #:TYP^Type:TR^Cr Tr#:MERCH^Merchant:"
        i $d(^MSCG("CreditModule","MerchantCodeMapping","PV")) d
        . s s("10hdr")=s("10hdr")_"PVCD^Prv Cd:PROV^Provider"
        . q
    
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
