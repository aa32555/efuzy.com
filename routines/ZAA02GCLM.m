ZAA02GCLM ;Claims by Patient;2018-07-09 11:00:00
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
 S PRG="ZAA02GCLM"
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
 K ^SORT($J)
 S T=$$FOPEN^DFILE(EXCELF,"W","A")
 I T'=1 W:PRREP "Couldn't open file '"_EXCELF_"'." Q
 S ENT="" F  S ENT=$O(ENT(ENT)) Q:ENT=""  D
 . S STRENT=ENT
 . I COMBINE S STRENT="Z"
 . S FRM="" F  S FRM=$O(^INV(2,ENT,FRM)) Q:FRM=""  D
 .. S DT=DTF-1
 .. F  S DT=$O(^INV(2,ENT,FRM,DT)) Q:DT=""  Q:(DTT'="")&(DT>DTT)  D
 ... S INS="" F  S INS=$O(^INV(2,ENT,FRM,DT,INS)) Q:INS=""  D
 .... S CLM="" F  S CLM=$O(^INV(2,ENT,FRM,DT,INS,CLM)) Q:CLM=""  D
 ..... S DATA=^INV(1,CLM)
 ..... S ^SORT($J,STRENT,$P(DATA,":",2),$P(DATA,":",3),CLM)=""
 . Q
 S HDR=$$setHeader^REPUTIL(
        "",
        .COL,
        "ENT",          "Entity",
        "ENTNM",        "Entity Name",
        "ACCT",         "Acct#",
        "PAT",          "Pat#",
        "NM",           "Patient Name",
        "CLM",          "Internal Claim#",
        "SUBDT",        "SubmitDt",
        "INS",          "Insurance",
        "INSNM",        "Insurance Name",
        "POL",          "Policy#",
        "TR",           "Trans#",
        "PDT",          "PostDt",
        "SDT",          "SrvDt",
        "PROC",         "Proc",
        "PROCDSC",      "Proc Description",
        "MOD",          "Modifiers",
        "QT",           "Qt",
        "AR",           "A/R",
        "ARDSC",        "A/R Description"
 )
 F I=1:1:4 S HDR=$$INSHDR(HDR,I,.COL)
 D writeExcel^REPUTIL(
        $$setHeader^REPUTIL(
                HDR,
                .COL,
                "RESP",         "Resp",
                "PRV",          "Prov",
                "PRVNM",        "Prov Name",
                "REF",          "Ref",
                "REFNM",        "Ref Name",
                "PLC",          "Plc",
                "PLCNM",        "Plc Name",
                "DPT",          "Dpt",
                "DPTNM",        "Dpt Name",
                "CASE",         "Case",
                "CASEDSC",      "Case Description",
                "DG",           "Diag",
                "DGDSC",        "Diag Description",
                "BILLTP",       "Bill Type",
                "AMT",          "Amount",
                "BAL",          "Balance",
                "CLAMT",        "Claim Total Amount",
                "CLBAL",        "Claim Balance"
        ),
        FDEV
 )
 S GL=$NA(^SORT($J))
 F  S GL=$Q(@GL) Q:GL=""  Q:$QS(GL,1)'=$J  D CLM($QS(GL,5),FDEV,.COL)
 I PRREP W "Report written to '"_EXCELF_"'. Click 'Get File' to view."
 K ^SORT($J)
 Q      
.
WRITEFIELDS
 S PRG="ZAA02GCLM"
 S ^ZAA02GVBSYS("REPORT","FIELDS",PRG)="::1:::::1:::::1:2::"
 D WRITEENT^REPUTIL(PRG,1)
 D WRITEDATE(PRG,2)
 D WRITEFILE^REPUTIL(PRG,3)
 S $P(^ZAA02GVBUSER("REPORT","DEFAULTS",PRG,0),":",4)=0
 Q
READFIELDS(s)
 D READENT^REPUTIL(s,1,OPZ,,,.ENT,.B) I B'="" Q
 D READDATE(s,2,.DTF,.DTT)
 D READFILE^REPUTIL(s,3,.EXCELF)
 S COMBINE=0
 Q
 
WRITEDATE(PRG,FNO)
 S ^ZAA02GVBSYS("REPORT","FIELDS",PRG,FNO)="Submission Dates||From:6:N:1:10:::"",""?Thru:6:N:1:10:::|??N?N^^?""^""?Y?N|"
 S $P(^ZAA02GVBUSER("REPORT","DEFAULTS",PRG,0),":",FNO)=""
 Q
READDATE(INPUT,FNO,DTF,DTT)
 S DTF=$$DG^IDATE($P($P($P(INPUT,":",FNO),"^",2),",",1))
 S DTT=$$DG^IDATE($P($P($P(INPUT,":",FNO),"^",2),",",2))
 Q
.
INSHDR(HDR,I,COL)
 N (HDR,I,COL)
 Q $$setHeader^REPUTIL(
        HDR,
        .COL,
        "INS"_I,        "Ins "_I,
        "INSNM"_I,      "Ins "_I_" Name",
        "POL"_I,        "Ins "_I_" Policy#",
        "FLAG"_I,       "Ins "_I_" Flag"
 )
 
CLM(CLM,FDEV,COL)
 N (CLM,FDEV,COL)
 S DATA=^INV(1,CLM)
 S ENT=$P(DATA,":",1)
 S ENTNM=$P($G(^PRMG(ENT,1)),":",2)
 S ACCT=$P(DATA,":",2)
 S PAT=$P(DATA,":",3)
 S PNM=$P($G(^PTG(ACCT,PAT)),":",3)
 I PNM="" S PNM=$P($G(^GRG(ACCT)),":",7)
 S SUBDT=$P(DATA,":",7)
 S INNO=$P(DATA,":",4)
 S INSREC=$G(^GRG(ACCT,INNO))
 S INS=$P(INSREC,":",3)
 S INSNM=""
 I INS'="" S INSNM=$P($G(^ING(INS,ENT),$G(^ING(INS) ) ),":",2)
 S POL=$G(^PTG(ACCT,PAT,"P",INNO))
 I POL="" S POL=$P(INSREC,":",5)
 S CLMFLD=$$setFields^REPUTIL(
        "",
        .COL,
        "ENT",          ENT,
        "ENTNM",        ENTNM,
        "ACCT",         ACCT,
        "PAT",          PAT,
        "NM",           PNM,
        "CLM",          CLM,
        "SUBDT",        $$SUB^IDATE(SUBDT,0),
        "INS",          INS,
        "INSNM",        INSNM,
        "POL",          POL
 )
 S AMT=0
 S BAL=0
 S TR="" F  S TR=$O(^INV(1,CLM,TR)) Q:TR=""  D TR(ENT,TR,ACCT,PAT,SUBDT,INNO,INS,CLMFLD,FDEV,.COL,.AMT,.BAL)
 D writeExcel^REPUTIL(
        $$setFields^REPUTIL(
                CLMFLD,
                .COL,
                "CLAMT",        $J(AMT/100,0,2),
                "CLBAL",        $J(BAL/100,0,2)
        ),
        FDEV
 )
 Q
 
TR(ENT,TR,ACCT,PAT,SUBDT,INNO,INCD,CLMFLD,FDEV,COL,CAMT,CBAL)
 N (ENT,TR,ACCT,PAT,SUBDT,INNO,INCD,CLMFLD,FDEV,COL,CAMT,CBAL)
 S BILLTP=""
 I INCD'="" S BILLTP=$G(^BILLTP(ENT,TR,SUBDT,INNO,INCD))
 I BILLTP["*" S BILLTP=""
 S TREC=$G(^TRG(ENT,TR))
 S PC=$P(TREC,":",6)
 I PC'="" S PC=$P($G(^INPC(PC)),":",1)
 S PCDSC=""
 I PC'="" S PCDSC=$P($G(^PCG(PC,ENT),$G(^PCG(PC) ) ),":",2)
 S AR=$P(TREC,":",45)
 S ARDSC=""
 I AR'="" S ARDSC=$P($G(^ARG(AR,ENT),$G(^ARG(AR) ) ),":",2)
 S LN=$$setFields^REPUTIL(
        CLMFLD,
        .COL,
        "TR",           TR,
        "PDT",          $$SUB^IDATE($$DG^IDATE($P(TREC,":",1)),0),
        "SDT",          $$SUB^IDATE($P($P(TREC,":",16),"^",1),0),
        "PROC",         PC,
        "PROCDSC",      PCDSC,
        "MOD",          $P(TREC,":",27),
        "QT",           $P(TREC,":",18),
        "AR",           AR,
        "ARDSC",        ARDSC
 )
 F I=1:1:4 S LN=$$INS(LN,TREC,I,ENT,ACCT,PAT,.COL)
 S RESP=$$RESP^TRUTIL(TREC)
 I 'RESP S RESP="Patient"
 I RESP S RESP=$P($P(TREC,":",44),",",RESP)
 I RESP S RESP=$P($G(^GRG(ACCT,RESP)),":",3)
 S PRV=$P(TREC,":",13)
 S PRVNM=""
 I PRV'="" S PRVNM=$P($G(^PVG(PRV,ENT),$G(^PVG(PRV) ) ),":",2)
 S REF=$P(TREC,":",14)
 S REFNM=""
 I REF'="" S REFNM=$P($G(^RFG(REF)),":",2)
 S PLC=$P(TREC,":",15)
 S PLCNM=""
 I PLC'="" S PLCNM=$P($G(^PSG(PLC)),":",2)
 S DPT=$P(TREC,":",5)
 S DPTNM=""
 I DPT'="" S DPTNM=$P($G(^DPG(DPT)),":",2)
 S CS=+$P(TREC,":",72)
 I 'CS S CS=+$P(TREC,":",43)
 I 'CS S CS=""
 S CSDSC=""
 I CS'="" D
 . S CSENT=ENT
 . I $G(^CASE)=0 S CSENT=0
 . S CSDSC=$P($G(^CASE(ACCT,PAT,CSENT,CS)),":",2)
 . Q
 S DG=$P(TREC,":",22)
 I DG'="" S DG=$P($G(^INDG(DG)),":",1)
 S DGDSC=""
 I DG'="" S DGDSC=$P($G(^DGG(DG)),":",2)
 S AMT=$P(TREC,":",9)
 S BAL=$P(TREC,":",9)-$P(TREC,":",10)
 S CAMT=CAMT+AMT
 S CBAL=CBAL+BAL
 D writeExcel^REPUTIL(
        $$setFields^REPUTIL(
                LN,
                .COL,
                "RESP",         RESP,
                "PRV",          PRV,
                "PRVNM",        PRVNM,
                "REF",          REF,
                "REFNM",        REFNM,
                "PLC",          PLC,
                "PLCNM",        PLCNM,
                "DPT",          DPT,
                "DPTNM",        DPTNM,
                "CASE",         CS,
                "CASEDSC",      CSDSC,
                "DG",           DG,
                "DGDSC",        DGDSC,
                "BILLTP",       BILLTP,
                "AMT",          $J(AMT/100,0,2),
                "BAL",          $J(BAL/100,0,2)
        ),
        FDEV
 )
 Q
 
INS(LN,TREC,I,ENT,ACCT,PAT,COL)
 N (LN,TREC,I,ENT,ACCT,PAT,COL)
 S INNO=$P($P(TREC,":",44),",",I)
 I INNO="" Q LN
 S INSREC=$G(^GRG(ACCT,INNO))
 I INSREC="" Q LN
 S INS=$P(INSREC,":",3)
 S INSNM=""
 I INS'="" S INSNM=$P($G(^ING(INS,ENT),$G(^ING(INS) ) ),":",2)
 S POL=$G(^PTG(ACCT,PAT,"P",INNO))
 I POL="" S POL=$P(INSREC,":",5)
 Q $$setFields^REPUTIL(
        LN,
        .COL,
        "INS"_I,        INS,
        "INSNM"_I,      INSNM,
        "POL"_I,        POL,
        "FLAG"_I,       $P($P(TREC,":",19),"~",I)
 )
 
