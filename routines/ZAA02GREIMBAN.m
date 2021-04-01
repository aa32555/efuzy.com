ZAA02GREIMBAN ; Reimbursement Analysis Report;2017-12-12 13:25:16;28NOV2007  14:24; ; 30 Nov 2004  10:57A
 ; ADS Corp. Copyright
 ;
VB ;
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
 S PRG="ZAA02GREIMBAN"
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
 I SELENT'="A" D
 . S TMP=""
 . F I=1:1 S TMP=$O(ENT(TMP)) Q:TMP=""  S ENTH(TMP)=""
 S MORE=0
 S TMP=""
 F I=0:1 S TMP=$O(ENT(TMP)) Q:TMP=""
 I I>1 S MORE=1
 ;        
 ; By Month or Day
 S SHWOP="M"
 ;
 ; Dates
 S SORTD="S"
 S TODAY=$$DG^IDATE(^TODAY)
 S DTF=$TR($P($P($P(s,D1,2),D2,2),D3,1),"_")
 S DTT=$TR($P($P($P(s,D1,2),D2,2),D3,2),"_")
 S DTF=$P(DTF,D4,3)_$P(DTF,D4)_$P(DTF,D4,2)
 S DTT=$P(DTT,D4,3)_$P(DTT,D4)_$P(DTT,D4,2)
 ;
 ; Provider
 S (PVC,PRC,PRS)=$E($P(s,D1,3))
 S DATA=$P($P(s,D1,3),D2,2)
 I PVC'="A" F I=1:1 S T=$P(DATA,D3,I) Q:T=""  S (POV(T),PRS(T),PVV(T))=""
 ;
 ; Second Provider
 S BPRC="A"
 ;
 ; Department
 S (DPS,DPC)=$E($P(s,D1,4))
 S DATA=$P($P(s,D1,4),D2,2)
 I DPC'="A" F I=1:1 S T=$P(DATA,D3,I) Q:T=""  S DPV(T)=""
 ;
 ; Place of Service
 S (PLS,PLC)=$E($P(s,D1,5))
 S DATA=$P($P(s,D1,5),D2,2)
 I PLC'="A" F I=1:1 S T=$P(DATA,D3,I) Q:T=""  S PLV(T)=""
 ;
 S SNO=0
 S IND="^SORT($J,""CD"",STEZ,GRP,CODE)"
 S INDQ="^SORT($J,""AR"",STEZ,AR,CODE)"
 ;
 ; Procedure Groups
 S PRCGPLST=$TR($P($P(s,":",6),"^",2),",",":")
 ;
 ; A/R Class
 S ARC="A"
 S ARLST=$TR($P($P(s,":",7),"^",2),",",":")
 ;
 ; Revenue ranks
 S REVRNK=+$P($P(s,":",8),"^",2)
 ;
 ; Combine entities
 S COMBINE=1
 ;
 ; Operator
 S OPC="A"
 ;
 ; Insurance Company Code
 S INC="A"
 ;
 ; Itemized/Totals Only
 S ITMZ="T"
 ;
 ; Show Payments Without Charge
 S OPT=0
 ;
 ; Show Charges Without Payment
 S CHOPT=1
 ;
 ; Procedure Codes
 S PROS="A"
 ;
 ; Based on Dates of Procedure or Payments
 ; N/A Procedure Only
 ;
 ; Create File
 S (EXCEL,EXCELF)="",EXCELP=$E($P(s,D1,9))
 S PRREP=1
 S $P(EXCEL,":",2)=1,EXCELF=$P($P(s,D1,9),D2,2) I $P(EXCELF,".",2)="" S $P(EXCELF,".",2)="CSV"
 I VAL="CHK" S B="EXCEL="_$S(EXCELF]"":"EXCEL"_$C(9)_EXCELF,1:"") Q
 I VAL'="RUN",VAL'="Q=1,R=6",EXCELF]"",$$EXIST^DFILE(EXCELF) S B="1|File '"_EXCELF_"' already exists.  Overwrite?|36|Report|6=1,7=0" Q
 S MODE="W"
 ;
 I VAL=""!(VAL="Q=1,R=6") S B="||RUN||" Q
 S T=$$FOPEN^DFILE(EXCELF,MODE,"A"),EXCEL=1 I T'=1 W:PRREP "Couldn't open file" Q
 S COP=1
 S COPY=1
 S DLM=""",""",DLM2=""""
 S EXHSW=1
 ;S F1="PRP INP"
 ;S F2="CAD OTD TFD"
 ;S F3="WOC DSC AIC IDC"
 ;S F4="CBP APN CBD WCC CBC"
 ;S F5="TTC"
 S GGSW=0
 S GSW=0
 S HDR=$S(SHWOP="M":"Monthly",1:"Daily")_" Charge Analysis"
 S HDR1="Grand Totals for All Selected Entities"
 S PG=0
 S PGE=0
 S PRP="29:41:53:65:77:89"
 S $P(S,D1,6)=PR
 S SHQTY=1
 S $P(UND,"_",130)="_",AST="****"
 S GTPROC=0
 S DASH=1 ; For now always create ^DASH.
 I DASH D
 . K ^DASH(OPZ,PRG)
 . S ^DASH(OPZ,PRG,"SEL")=X,DASHSW=1
 ;
 K ^SORT1($J)
 S ZEROBAL=1 I $D(^MSCG("TRLSTSH","NOZEROBAL")) S ZEROBAL=0
 S BILLPRVDFLT=$G(^MSCG("2NDPRVDFLT"))
 S UNDISTR=+$G(^MSCG("PRAN","UNDISTR"))
 D MAIN
 Q
 
MAIN
 K ^SORT($J)
 S TEZ="" F  S TEZ=$O(ENT(TEZ)) Q:'TEZ  I $D(^TRG(TEZ)) D  
 . S TR="" F  S TR=$$NXTTR^TRUTIL(TEZ,TR,DTF,DTT,SORTD,"P") Q:TR=""  D STORE(TEZ,TR) 
 N INGRP
 D GETCDSINGRP(PRCGPLST,.INGRP)
 S TEZ="" F  S TEZ=$O(^SORT($J,"CD",TEZ)) Q:TEZ=""  D PRINT(TEZ,.INGRP)
 C FDEV
 K ^SORT($J)
 I PRREP U PR W "Report written to '"_EXCELF_"'. Click 'Get File' to view."
 Q
 
STORE(TEZ,TR)
 S STEZ=TEZ
 I COMBINE S STEZ="Z"
 S OPBL=0
 S (S,TREC)=^TRG(TEZ,TR),TYP=$P(TREC,":",4) 
 I TYP'="P" Q
 D CHK 
 I 'SW Q
 D WR
 Q
 
CHK S SW=0 ;,ACCT=$P(TREC,":",3) Q:'$D(^GRG(TEZ,ACCT))
 I PRS'="A" S T=$P(TREC,":",13) Q:PRS="I"&(T="")  I T'="" Q:((PRS="I")&('$D(POV(T))))!((PRS="E")&($D(POV(T))))
 I DPS'="A" S T=$P(TREC,":",5)  Q:DPS="I"&(T="")  I T'="" Q:((DPS="I")&('$D(DPV(T))))!((DPS="E")&($D(DPV(T))))
 I PLS'="A" S T=$P(TREC,":",15) Q:PLS="I"&(T="")  I T'="" Q:((PLS="I")&('$D(PLV(T))))!((PLS="E")&($D(PLV(T))))
 S SW=1
 Q
.
WR S CODE=$P(^INPC($P(TREC,":",6)),":",1),AM=$P(TREC,":",9),PAID=+$P(TREC,":",10)
 S (ADJ,PAY,COL)=0,BAL=AM-$P(TREC,":",10),QA=$P(TREC,":",18)
 S DQA=0
 S AR=$P(TREC,":",45)
 S GRP=$P($G(^PCG(CODE)),":",6)
 I GRP="" Q
 I '$$INLST(GRP,PRCGPLST) Q
 S TS=TREC D IND
 ;D RELPAY^ZAA02GTRUTIL("PAY^ZAA02GREIMBAN",TEZ,TR,"^SORT($J,""PAY"",TEZ)")
 S FTR="" F  S AREC=$$NXTRELPAY^TRUTIL(TEZ,TR,FTR,"^SORT($J,""PAY"",TEZ)") Q:AREC=""  D
 . S AMT=$P(AREC,",",1),FTR=$P(AREC,",",2)
 . D PAY(TEZ,,FTR,AMT)
 . Q
 S $P(T,":",1)=$P(T,":",1)+QA,$P(T,":",2)=$P(T,":",2)+AM,$P(T,":",3)=$P(T,":",3)+PAY
 S $P(T,":",4)=$P(T,":",4)+ADJ,$P(T,":",5)=$P(T,":",5)+COL,$P(T,":",6)=$P(T,":",6)+BAL
 S $P(T,":",7)=$P(T,":",7)+DQA
 S @IND=T
 S $P(TQ,":",1)=$P(TQ,":",1)+QA,$P(TQ,":",2)=$P(TQ,":",2)+AM,$P(TQ,":",3)=$P(TQ,":",3)+PAY
 S $P(TQ,":",4)=$P(TQ,":",4)+ADJ,$P(TQ,":",5)=$P(TQ,":",5)+COL,$P(TQ,":",6)=$P(TQ,":",6)+BAL
 S $P(TQ,":",7)=$P(TQ,":",7)+DQA
 S @INDQ=TQ
 S T=$G(^SORT($J,"AR",STEZ,AR)),$P(T,":",1)=$P(T,":",1)+QA,$P(T,":",3)=$P(T,":",3)+PAY,^SORT($J,"AR",STEZ,AR)=T
 S ^SORT($J,"CD",STEZ,GRP)=$G(^SORT($J,"CD",STEZ,GRP))+PAY
 Q
  
IND F I=1:1:SNO-1 S T=SEL(I),NM=SLN(T) S:T=1 @NM=AR I T'=1 S POS=POS(T),T1=$P(TS,":",PSS) S:T1="" T1=" " D:POS=13  S @NM=T1
 .N PRV I $D(^MSCG("PRCOMP","USEATTORNEY")) S PRV=$P(TS,":",57) S:PRV="" PRV="UNA" S T1=PRV
 S (T,TQ)="" S:$D(@IND) T=@IND S:$D(@INDQ) TQ=@INDQ
 Q
.
PAY(TEZ,TR,FTR,AMT,INORD)
 ;PAY(TEZ,FTR,AMT) 
 I $E($P(^TRG(TEZ,FTR),":",16),3)="P" S PAY=PAY+AMT,TOTPAY(STEZ)=$G(TOTPAY(STEZ))+AMT
 Q
 
PRINT(TEZ,INGRP) 
 U FDEV
 I TEZ'="Z" W """ENTITY:"","""_TEZ_""","""_$P($G(^PRMG(TEZ,1)),":",2)_"""",!
 I PRREP U PR
 N REV
 I REVRNK>0 D REVRANK(TEZ,PRCGPLST,REVRNK,.INGRP,.REV)
 F I=1:1:$L(PRCGPLST,":") D
 . S GRP=$P(PRCGPLST,":",I)
 . I GRP="" D  Q
 .. I I=1 S $E(PRCGPLST,1)="",I=0
 .. Q
 . I I=1 D getPos
 . I I>1 D GRPLINE(TEZ,GRP)
 . S CD="" F  S CD=$O(INGRP(GRP,CD)) Q:CD=""  D CDLINE(TEZ,GRP,CD,ARLST,.REV)
 . D writeExcel("")
 . Q
 D writeExcel("")
 ;significantly above/below average
 Q
 
GETCDSINGRP(PRCGPLST,INGRP)
 N (PRCGPLST,INGRP)
 S PC="" F  S PC=$O(^PCG(PC)) Q:PC=""  D
 . S GRP=$P($G(^PCG(PC)),":",6)
 . I GRP="" Q
 . I $$INLST(GRP,PRCGPLST) S INGRP(GRP,PC)=""
 Q
.
REVRANK(TEZ,PRCGPLST,REVRNK,INGRP,REV)
 N (TEZ,PRCGPLST,REVRNK,INGRP,REV)
 F I=1:1:$L(PRCGPLST,":") D
 . S GRP=$P(PRCGPLST,":",I)
 . I GRP="" Q
 . S PC="" F  S PC=$O(INGRP(GRP,PC)) Q:PC=""  D
 .. S PAY=$P($G(^SORT($J,"CD",TEZ,GRP,PC)),":",3)
 .. S PAID(+PAY,PC)=""
 . Q
 S REV=0
 S PAY="" F  S PAY=$O(PAID(PAY),-1) Q:PAY=""  Q:REV>=REVRNK  D
 . S PC="" F  S PC=$O(PAID(PAY,PC)) Q:PC=""  Q:REV>=REVRNK  D
 .. S REV=REV+1
 .. S REV(PC)=REV 
 Q
.
GRPLINE(TEZ,GRP)
 S AMT=$G(^SORT($J,"CD",TEZ,GRP))
 D writeExcel($$setFields("",
                                                         "CD",          $P($G(^PCGR(GRP)),":",2),
                                                         "DESC",        "$ "_$FN(AMT/100,",",0)_" ("_$J(AMT/TOTPAY(TEZ)*100,0,0)_"%)"
                                                 )
                         )
 Q
.
CDLINE(TEZ,GRP,CD,ARLST,REV)
 S LINE=$$setFields("",
                                           "REV",       $G(REV(CD)),
                                           "CD",        CD,
                                           "DESC",      $P($G(^PCG(CD)),":",2),
                                           "PAY",       $J($P($G(^SORT($J,"CD",TEZ,GRP,CD)),":",3)/100,0,0),
                                           "QTY",       +$P($G(^SORT($J,"CD",TEZ,GRP,CD)),":",1)
                                   )
 S (AVER,ARNO)=0
 N I F I=1:1:$L(ARLST,":") D
 . S AR=$P(ARLST,":",I)
 . I AR="" Q
 . S DATA=$G(^SORT($J,"AR",TEZ,AR,CD))
 . S QTY=$P(DATA,":",1),AMT=$P(DATA,":",3)
 . I 'QTY S QTY=1
 . S AVE=AMT/QTY
 . ;significantly greater/less than average?
 . I AVE S LINE=$$setFields(LINE,"AR"_I,$J(AVE/100,0,0))
 . S AVER=AVER+AVE
 . I AVE S ARNO=ARNO+1
 . Q
 I 'ARNO S ARNO=1
 S AVER=AVER/ARNO
 D writeExcel($$setFields(LINE,"AVE",$J(AVER/100,0,0)))
 Q
.
INLST(ITEM,LIST,DLM)
 N (ITEM,LIST,DLM)
 S ITEM=$G(ITEM),LIST=$G(LIST),DLM=$G(DLM,":")
 Q ($P(LIST,DLM,1)=ITEM)!($P(LIST,DLM,$L(LIST,DLM))=ITEM)!(LIST[(DLM_ITEM_DLM))
 
 
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
        s amt=$g(^SORT($j,"CD",TEZ,GRP))
        s s("10cds")="REV^Revenue rank:CD^"_$p($g(^PCGR(GRP)),":",2)_":DESC^$ "_$fn(amt/100,",",0)_" ("_$J(amt/TOTPAY(TEZ)*100,0,0)_"%)"
        s s("20blank")="blank^"
        s s("30amt")="PAY^Revenue per CPT Code:QTY^# of times BILLED:AVE^AVER $ COLL per CPT code"
        s s("40blank")="blank^"
        s s("50ars")=""
        f i=1:1:$l(ARLST,":") d
        . s ar=$p(ARLST,":",i)
        . i ar="" q
        . s amt=$p($g(^SORT($j,"AR",TEZ,ar)),":",3)
        . s s("50ars")=s("50ars")_"AR"_i_"^"_$p($g(^ARG(ar)),":",2)_" $ "_$fn(amt/100,",",0)_" ("_$J(amt/TOTPAY(TEZ)*100,0,0)_"%):"
        . q
        s s("60tot")="revenue^REVENUE; $"_$fn(TOTPAY(TEZ)/100,",",0)_" AS OF; "_$$SUB^IDATE($$DG^IDATE(+$H),0)
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
 
ERR
 U:PRREP PR
 W !,$ZE
 Q
 
.
