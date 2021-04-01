ZAA02GSTMTCT ;Statement Count Report;2018-09-20 09:54:08
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
 S PRG="ZAA02GSTMTCT"
 S Q="1"
 S S=""
 S s=$P(X,"|",7)
 S VAL=$P(X,"|",6)
 S RUN=$P(X,"|",8)
 
 D READFIELDS(s)
 I B'="" Q
 
 S COP=1
 S COPY=1
 S K=""
 S PG=0
 ;
 I VAL="" S B="||RUN||" Q
 I VAL'="RUN" S B="99|Invalid System Response|16|Report|1=0" Q
 ;
 S ZAA02GVB=1
 
 S $P(UND,"_",130)="_"
 S DDTF=$$SUB^IDATE(DTF,0)
 S DDTT=$$SUB^IDATE(DTT,0)
 D HDR
 S TOT=0
 S ENT="" F  S ENT=$O(ENT(ENT)) Q:ENT=""  S TOT=TOT+$$STMTBYACCT(ENT,DTF,DTT)
 . ;S STCT=$$STMTCT(ENT,DTF,DTT)
 . ;I $Y>55 D HDR
 . ;W $J(ENT,2),?15,$J(STCT,6),!
 . ;S TOT=TOT+STCT
 . ;Q
 I $Y>55 D HDR
 W !
 W "Total:",?30,$J(TOT,6)
 Q
.
WRITEFIELDS
 S PRG="ZAA02GSTMTCT"
 S ^ZAA02GVBSYS("REPORT","FIELDS",PRG)="::1:::::1::::::::"
 D WRITEENT^REPUTIL(PRG,1)
 D WRITEDATE(PRG,2)
 Q
READFIELDS(s)
 D READENT^REPUTIL(s,1,OPZ,,.ENTLST,.ENT,.B) I B'="" Q
 D READDATE(s,2,.DTF,.DTT)
 Q
.
WRITEDATE(PRG,FNO)
 S ^ZAA02GVBSYS("REPORT","FIELDS",PRG,FNO)="Dates||From:6:N:1:10:::"",""?Thru:6:N:1:10:::|??N?N^^?""^""?Y?N|"
 S $P(^ZAA02GVBUSER("REPORT","DEFAULTS",PRG,0),":",FNO)=""
 Q
READDATE(INPUT,FNO,DTF,DTT)
 S DTF=$$DG^IDATE($P($P($P(INPUT,":",FNO),"^",2),",",1))
 S DTT=$$DG^IDATE($P($P($P(INPUT,":",FNO),"^",2),",",2))
 Q
.
HDR
 S PG=PG+1
 S HDR="Statement Count Report"
 S TEZ=EZ
 D ^TOP
 W !
 W "Dates: "_DDTF_" - "_DDTT,!
 W "Entities: "_$TR(ENTLST,":",","),!
 W !
 W "Entity",?15,"Account",?30,"Statement Count",!
 W UND,!
 Q
 
STMTBYACCT(ENT,DTF,DTT)
 N TOT
 I DTF'?5N,DTF'="" S DTF=$ZDH(DTF,5)
 I DTT'?5N,DTT'="" S DTT=$ZDH(DTT,5)
 S TOT=0
 S ACCT="" F  S ACCT=$O(^ZAA02GSTP(ENT,ACCT)) Q:ACCT=""  D
 . S CTR=$$ACCTSTMTCT(ENT,ACCT,DTF,DTT)
 . I CTR D
 .. I $Y>55 D HDR
 .. W $J(ENT,2),?15,ACCT,?30,$J(CTR,6),!
 .. S TOT=TOT+CTR
 . Q
 I TOT D
 . I $Y>55 D HDR
 . W !
 . W $J(ENT,2),?30,$J(TOT,6),!
 . W !
 Q TOT
 
ACCTSTMTCT(ENT,ACCT,DTF,DTT)
 S CTR=0
 S PAT="" F  S PAT=$O(^ZAA02GSTP(ENT,ACCT,PAT)) Q:PAT=""  D
 . S DT=DTF-1
 . F CTR=CTR:1 S DT=$O(^ZAA02GSTP(ENT,ACCT,PAT,DT)) Q:DT=""  Q:(DTT'="")&(DT>DTT)
 Q CTR
 
STMTCT(ENT,DTF,DTT)
 N (ENT,DTF,DTT)
 I DTF'?5N,DTF'="" S DTF=$ZDH(DTF,5)
 I DTT'?5N,DTT'="" S DTT=$ZDH(DTT,5)
 S CTR=0
 S ACCT="" F  S ACCT=$O(^ZAA02GSTP(ENT,ACCT)) Q:ACCT=""  D
 . S PAT="" F  S PAT=$O(^ZAA02GSTP(ENT,ACCT,PAT)) Q:PAT=""  D
 .. S DT=DTF-1
 .. F CTR=CTR:1 S DT=$O(^ZAA02GSTP(ENT,ACCT,PAT,DT)) Q:DT=""  Q:(DTT'="")&(DT>DTT)
 Q CTR
