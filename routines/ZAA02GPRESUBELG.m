ZAA02GVBPRESUBELG ;;2018-03-29 10:52:02
 ; 
VB
 N (B,EZ,HANDLE,HANDLE2,P2,USER,X,RLC)
 I $G(X)["|",$P(X,"|",6)="" S B="||RUN||" Q
 S D1=":"
 S D2="^"
 S D3=","
 S D4="/"
 S s=$P(X,"|",7)
 ;
 ; Insurance
 S TMP=$P(s,D1,1),IC=$E(TMP)
 I IC'="A" D
 . S TMP=$TR($P(TMP,D2,2),D3,D1)
 . F I=1:1:$L(TMP,D1) D
 .. S TMP1=$P(TMP,D1,I)
 .. I TMP1]"" S IC(TMP1)=""
 ;
 ; New Submission
 S NEWSUB=($P($P(s,":",3),"^")="S")
 S OLIST=$P($P(s,":",3),"^",2)
 ;
 ; Days since last submission
 S ELGSINCE=$P($P(s,":",4),"^",2)
 I ELGSINCE<30 S ELGSINCE=30
 ;
 ; Name
 S TMP=$$up($P($P(s,":",5),"^",2))
 S NMF=$P(TMP,",",1)
 S NMT=$P(TMP,",",2)
 ;
 ; Service Date
 S TMP=$P($P(s,":",6),"^",2)
 S DTF=$$DG^IDATE($P(TMP,",",1))
 S DTT=$$DG^IDATE($P(TMP,",",2))
 ;
 S TS=$H
 S YR=$E($$DG^IDATE(+TS),1,4)
 S LST="" F  S LST=$O(^ZAA02GPRESUBELG(LST)) Q:LST=""  Q:LST="~#"  Q:YR-$E(LST,1,4)<2  K ^ZAA02GPRESUBELG(LST) S ^ZAA02GPRESUBELG("~#")=^ZAA02GPRESUBELG("~#")-1
 I NEWSUB D
 . S OLIST=$TR($ZDT(TS,8)," :"),DESC=$TR($ZDT(TS),":"," ")
 . S ENT="" F  S ENT=$O(^FORM(ENT)) Q:ENT=""  D
 .. S FM="" F  S FM=$O(^FORM(ENT,FM)) Q:FM=""  D
 ... S NM="" F  S NM=$O(^FORM(ENT,FM,NM)) Q:NM=""  D
 .... I NMF]NM Q
 .... I NMT'="",NM]NMT Q
 .... S ACCT="" F  S ACCT=$O(^FORM(ENT,FM,NM,ACCT)) Q:ACCT=""  D
 ..... S TR="" F  S TR=$O(^FORM(ENT,FM,NM,ACCT,TR)) Q:TR=""  D
 ...... S REC=$G(^TRG(ENT,TR))
 ...... S PAT=$P(REC,":",7)
 ...... I PAT="" Q
 ...... S SDT=$P($P(REC,":",16),"^",1)
 ...... I SDT<DTF Q
 ...... I DTT'="",SDT>DTT Q
 ...... ;S INNO="" F  S INNO=$O(^FORM(ENT,FM,NM,ACCT,TR,INNO)) Q:INNO=""  D
 ...... ;I INNO'=+$P(REC,":",44) Q
 ...... S INNO=$$MCRORPRIM(ACCT,PAT)
 ...... I INNO="" Q
 ...... S INS=$G(^GRG(ACCT,INNO))
 ...... S INCD=$P(INS,":",3)
 ...... I IC'="A" Q:INCD=""&(IC="I")  I IC]"",(IC="I"&'$D(IC(INCD)))!(IC="E"&$D(IC(INCD))) Q
 ...... S POLNO=$G(^PTG(ACCT,PAT,"P",INNO))
 ...... I POLNO="" S POLNO=$P(INS,":",5)
 ...... S LASTELG=$$LASTELG(ACCT,PAT,INCD,POLNO)
 ...... I INCD="" D
 ....... S INCD=" "
 ....... ;S ^ZAA02GPRESUBELG("ERRORS",TS,ACCT,PAT,INNO)="NO INSURANCE CODE FOR INSURANCE "_INNO_" ON ACCOUNT "_ACCT
 ....... Q
 ...... I POLNO="" D
 ....... S POLNO=" "
 ....... ;S ^ZAA02GPRESUBELG("ERRORS",TS,ACCT,PAT,INNO)="NO POLICY # FOR INSURANCE "_INNO_" ON ACCOUNT "_ACCT
 ....... Q
 ...... I $D(POLS(ACCT,PAT,INCD,POLNO)) Q
 ...... S POLS(ACCT,PAT,INCD,POLNO)=""
 ...... I $E(LASTELG,1,4)<$E($$DG^IDATE(+$H),1,4) S LASTELG=""
 ...... I $G(^MSCG("HOLDSUB")) N E S E="" F  S E=$O(^PRMG(E)) Q:'E  I $P($G(^GRG(E,ACCT)),":",10)="H" D  Q
 ....... I LASTELG,$H-$ZDH(LASTELG,5)>30 S LASTELG=""
 ....... Q
 ...... I LASTELG,$H-$ZDH(LASTELG,5)<=ELGSINCE Q
 ...... S ZAA02GPRESUBELG(OLIST,ACCT,PAT,INCD,POLNO)=""
 .. Q
 . I $D(ZAA02GPRESUBELG(OLIST)) D
 .. S ^ZAA02GPRESUBELG("~#")=$G(^ZAA02GPRESUBELG("~#"),1)+1
 .. S ^ZAA02GPRESUBELG(OLIST)=OLIST_":"_DESC
 .. M ^ZAA02GPRESUBELG=ZAA02GPRESUBELG
 .. S ^ZAA02GPRESUBELGAH(DESC,OLIST)=""
 . Q
 S $P(X,"|",6)="BRW"
 S $P(X,"|",7)="^01/10/1980,:A:"_$P(s,":",1,2)_":S^"_OLIST_":"_$S(NEWSUB:"Y",1:"N")_":Y:"_NMF_","_NMT
 D WEB
 Q
 
LASTELG(ACCT,PAT,INCD,POLNO)
 N (ACCT,PAT,INCD,POLNO)
 ;I (INCD="")!(POLNO="") Q ""
 S DATE=""
 S REQID="" F  S REQID=$O(^ELG(1,ACCT,PAT,REQID),-1) Q:REQID=""  D  Q:DATE]""
 . S REQ=$G(^ELG(1,ACCT,PAT,REQID))
 . ;I $P(REQ,":",1)'=INCD Q
 . ;I $P(REQ,":",14)'=POLNO Q
 . S DATE=$E(REQID,1,8)
 Q DATE
 
MCRORPRIM(K,K1)
 N (K,K1)
 S PRIM=$P($G(^PTG(K,K1,0)),":",1)
 I PRIM="" S PRIM=$P($G(^GRG(K,0)),":",1)
 I PRIM]"" S INS=$P($G(^GRG(K,PRIM)),":",3) I INS'="",$P($G(^ING(INS)),":",30)="M" Q PRIM
 S MCR=""
 S INNO="" F  S INNO=$O(^GRG(K,INNO),-1) Q:'INNO  D  Q:MCR]""
 . S INS=$P($G(^GRG(K,INNO)),":",3)
 . I INS]"",$P($G(^ING(INS)),":",30)="M" S MCR=INNO
 . Q
 I MCR]"" Q MCR
 Q PRIM
 
WEB ; ZAA02Gweb
 D INIT
 I $G(X)["|",$P(X,"|",6)="" S B="||RUN||" Q
 I $G(X)["|",$P(X,"|",6)="BRW" S B="URL:"_$C(9)_"*/premier/"_HANDLE_"/web^ZAA02Gpresubelg?"_HANDLE,^ZAA02GTVB(+HANDLE,"REPORT")=X Q
 S DATA=$G(^ZAA02GTVB(+$G(%("FORM","DATA")),"REPORT"))
 I DATA="" S DATA=X
 ;
 S LC="abcdefghijklmnopqrstuvwxyz",UC="ABCDEFGHIJKLMNOPQRSTUVWXYZ",WEB=1,WEBHANDLE=+$G(%("FORM","DATA"))
 S USER=$TR($P($P(DATA,"|"),$C(9)),LC,UC),P2=0,EZ=$P($P(DATA,"|"),$C(9),3)
 S $P(X,"|",6)="RUN",$P(X,"|",7)=$P(DATA,"|",7)
 ;
 N (B,EZ,HANDLE,HANDLE2,P2,USER,X,RLC)
 ;
 I '$D(RLC) S RLC=$J
 I '$D(HANDLE) S HANDLE=RLC
 S B=""
 S D1=":"
 S D2="^"
 S D3=","
 S D4="/"
 S (JOB,DEV,IO)=$I
 S OPZ=USER
 S PR=$S(P2["=":P2,1:+P2) I PR="0",$I'[":" S PR=$I
 S PRG="WEB^ZAA02GPRESUBELG"
 S Q="9"
 S S=""
 S s=$P(X,"|",7)
 S VAL=$P(X,"|",6)
 ;
 ; Dates
 S DTF=$TR($P($P($P(s,D1),D2,2),D3),"_")
 S DTF=$P(DTF,D4,3)_$P(DTF,D4)_$P(DTF,D4,2)
 I DTF]"" S DTF=$$DG^IDATE(DTF,1)
 I DTF<10 S DTF=9
 S DTT=$TR($P($P($P(s,D1),D2,2),D3,2),"_")
 S DTT=$P(DTT,D4,3)_$P(DTT,D4)_$P(DTT,D4,2)
 I DTT]"" S DTT=$$DG^IDATE(DTT,1)
 ;
 ; Resources
 S TMP=$P(s,D1,2),PV=$E(TMP)
 I PV'="A" D
 . S TMP=$TR($P(TMP,D2,2),D3,D1)
 . F I=1:1:$L(TMP,D1) D
 .. S TMP1=$P(TMP,D1,I)
 .. I TMP1]"" S PV(TMP1)=""
 ;
 ; Ins Codes
 S TMP=$P(s,D1,3),IC=$E(TMP)
 I IC'="A" D
 . S TMP=$TR($P(TMP,D2,2),D3,D1)
 . F I=1:1:$L(TMP,D1) D
 .. S TMP1=$P(TMP,D1,I)
 .. I TMP1]"" S IC(TMP1)=""
 ;
 ; View
 S PRINT=$P(s,D1,4),GROUP=0
 ;
 S RepMode      = $P($P(s,D1,5),"^")
 S RepList              = $P($P(s,D1,5),"^",2)
 S SubmitFile   = $P(s,D1,6)="Y"
 S RetrieveFile = $P(s,D1,7)="Y"
 S PREVIEW = 'SubmitFile
 ;
 ; Name
 S NMF=$P($P(s,":",8),",",1)
 S NMT=$P($P(s,":",8),",",2)
 ;
 I RepMode="A" S RepList=""
 I RepMode="S",RepList  ="" W "<h3>Error: Source List mode but empty source list</h3>" Q
 ;
 I VAL="" S B="||RUN||" Q
 I VAL'="RUN" S B="99|Invalid System Response|16|Report|1=0" Q
 ;
 ;
 S ^ZAA02GTVB(RLC,"REPORT","ELGB","SELECTIONS")=s
 ;
 S SSC1 = "New Response File(s) Received"
 S SSC2 = "There is a query already in progress. Please wait."
 S SSC3 = "No New Response File(s) Received"
 ;
 D EZ^ZAA02GVBAS S ENT=EZ,EZ=$G(TEZ,1) I EZ="" S EZ=1
 I $G(ENT)'?1N.NN S ENT=1
 I '$d(^ZAA02GVBUSER("WEB-LOGON",+$H,+RLC)) s ^ZAA02GVBUSER("WEB-LOGON",+$H,+RLC)=$H_","_USER_","_EZ
 S BATCH=1,ZAA02GVB=1,USECLIENT=0,WEBHANDLE=HANDLE,FROMDM=1
 K ^SORT($J)
 N JOB S JOB="REP"_$J K ^SORT(JOB)
 S DESC=$P($G(^ZAA02GPRESUBELG(RepList)),":",2)
 S DESC=" "_$P(DESC," ",1)_" "_$TR($P(DESC," ",2,10)," ",":")
 I PREVIEW D
 . S DESC=""
 . I $P(RepList,",",1)'="" S DESC=DESC_" from "_$P(RepList,",",1)
 . I $P(RepList,",",2)'="" S DESC=DESC_" thru "_$P(RepList,",",2)
 . Q
 S ^SORT(JOB,"TITLE")="Pre-Submission Eligibility"_DESC ;_$S(RepMode="S":"By Source List "_RepList,RepMode="A":"By Appointments")_""
 S ^SORT(JOB,"USER")=USER
 S ^SORT(JOB,"PRGRM")=PRG 
 I 'PREVIEW S TOT=$$XELAP1(WEBHANDLE,USER,EZ,ENT,TEZ,PEZ,OPZ,IO,FROMDM,PR,DTF,DTT,.PV,.IC,PRINT,GROUP,BATCH,ZAA02GVB,PREVIEW,USECLIENT)
 D END^ZAA02GPRESUBELGXELAP1
 U IO
 D REFRESHSRSLST,REP^ZAA02GVBAARPT2("REP"_$J) 
 K ^SORT($J)
 Q
 ;
 I RepMode="A" S ^SORT(JOB,"REP",1)="Resource|Appt Date|Appt Time|Account|Name|DOB|Insurance|Status"
 I RepMode="S" S ^SORT(JOB,"REP",1)="Provider|Date|Account|Name|DOB|Insurance|Status"
 D GENREP I $$lo(IO)[($G(^ZAA02GWEBC("SCRATCH SPACE"))_"scra") U IO D REP^ZAA02GVBAARPT2(JOB) Q
 I 'RetrieveFile,$$lo(IO)'[($G(^ZAA02GWEBC("SCRATCH SPACE"))_"scra") D EXCEL Q
 I RetrieveFile,$$lo(IO)'[($G(^ZAA02GWEBC("SCRATCH SPACE"))_"scra") S %("BODY")=JOB D PULLRESULTS D REFRESH D EXCEL  Q
 Q 
 ;
XELAP1(WEBHANDLE,USER,EZ,ENT,TEZ,PEZ,OPZ,IO,FROMDM,PR,DTFRM,DTTHRU,PV,IC,PRINT,GROUP,BATCH,ZAA02GVB,PREVIEW,USECLIENT) ;
 N (WEBHANDLE,USER,EZ,ENT,TEZ,PEZ,OPZ,IO,FROMDM,PR,DTFRM,DTTHRU,PV,IC,PRINT,GROUP,BATCH,ZAA02GVB,PREVIEW,USECLIENT,RepMode,RepList)
 D ^ZAA02GPRESUBELGXELAP1
 K ^ZAA02GTVB(WEBHANDLE,"REPORT","ELGB","REPORT")
 S CNT1=0,(IND,I,PVN)=""
 F  S IND=$O(^SORT($J,IND)) Q:IND=""!(IND="G"&(PRINT="E"))!(IND="RS")  D
 . F  S PVN=$O(^SORT($J,IND,PVN)) Q:PVN=""  D
 .. F  S I=$O(^SORT($J,IND,PVN,I)) Q:I=""  D
 ... S CNT1=CNT1+1
 ... S ^ZAA02GTVB(WEBHANDLE,"REPORT","ELGB","REPORT",IND,PVN,I)=^SORT($J,IND,PVN,I)
 I USECLIENT Q CNT1_"|"_$G(OK)
 Q CNT1
 
 ;
GENREP
 N A,B,C,LINE,GI,BI,TOTCTR
 S TOTCTR=0
 S GI="<i class=\""fa fa-check fa-2x green\"" aria-hidden=\""true\""></i>"
 S BI="<i class=\""fa fa-exclamation-triangle fa-2x orange\"" aria-hidden=\""true\""></i>"
 S A="" F  S A=$O(^ZAA02GTVB(WEBHANDLE,"REPORT","ELGB","REPORT",A)) Q:A=""  D
 . S B="" F  S B=$O(^ZAA02GTVB(WEBHANDLE,"REPORT","ELGB","REPORT",A,B)) Q:B=""  D
 .. S C="" F  S C=$O(^ZAA02GTVB(WEBHANDLE,"REPORT","ELGB","REPORT",A,B,C)) Q:C=""  D
 ... S IND = A I IND=""!(IND="G"&(PRINT="E")) Q
 ... S PVN = B
 ... S REC=^ZAA02GTVB(WEBHANDLE,"REPORT","ELGB","REPORT",A,B,C)
 ... F J=1:1:9 S @$P("ENT,DT,PRV,TM,K,K1,DTNO,ERR,INS",",",J)=$P(REC,":",J)
 ... I PRINT="E",$P(ERR,".") Q
 ... I PRINT="C",ERR'="",'$P(ERR,".") Q
 ... S TM=$TR($S($L(TM)=5:"0"_TM,1:TM),";",":")
 ... I DT?1N.8N S DT=$ZDT($ZDH(DT,8),5) E  S DT=$$DSS^IDATE(DT)
 ... S FILDT=$$DSS^IDATE($E(DTNO,1,8))
 ... S PTNM=$$NAME^ZAA02GVBELGBR(K,K1)
 ... S DOB=$$DOB^ZAA02GVBELGBR(K,K1)
 ... S PVNM=""
 ... I 'SubmitFile,DTNO'="" S STATUS="1. File to be created"
 ... I SubmitFile,DTNO'="" S STATUS=$$STATUS^XELLS1(K,K1,DTNO),FLAG=$P(STATUS,",",1),STATUS=$P(STATUS,",",2),TOTCTR=TOTCTR+1
 ... I ERR'="" S STATUS=ERR
 ... S LINE=""
 ... S LINE=LINE_$S($TR(B," ")="":"No Provider",1:B)_"|"
 ... S LINE=LINE_$S(RepMode="S":$ZDT(+$H,5),1:DT)_"|"
 ... I RepMode="A" S LINE=LINE_$TR(TM,"ap","AP")_"M"_"|"
 ... ;I RepMode="S" S LINE=LINE_RepList_"|"
 ... S LINE=LINE_(K_"/"_K1)_"|"
 ... S LINE=LINE_PTNM_"|"
 ... S LINE=LINE_DOB_"|"
 ... S LINE=LINE_INS_"|"
 ... S LINE=LINE_$S(+STATUS:GI_"&nbsp;"_STATUS,1:BI_"&nbsp;"_STATUS)
 ... S ^SORT(JOB,"REP",$O(^SORT(JOB,"REP",""),-1)+1)=LINE
 Q
 ;
EXCEL
 i $$lo(IO)[($G(^ZAA02GWEBC("SCRATCH SPACE"))_"scra") q
 n cd s cd=$i
 ;
 n f s f="claims\Auto_Elgibility"
 i '##class(%Library.File).DirectoryExists(f),'##class(%Library.File).CreateDirectoryChain(f) q
 n file 
 s file = "claims\Auto_Elgibility\"_$S(RetrieveFile:"Results  - ",1:"Request - ")
 s file = file_$S(RepMode="A":("Appts "_DTF_" "_DTT),1:"Source List "_RepList)_" on "_" - "_$tr($zdt($h,1,3)," /:","_--")_".csv"
 o file:("nw"):5 e  q
 u file
 n A s A="" f  s A=$o(^SORT(JOB,"REP",A)) q:A=""  w $$OUTEXCEL(^(A)),!
 c file u cd
 Q
 ;
OUTEXCEL(REC)
 N A,O S O="" F A=1:1:$L(REC,"|") D
 . S TMP = $P(REC,"|",A)
 . S TMP = $$r(TMP,"&nbsp;","")
 . ;
 . I TMP["></i>"         S TMP = $P(TMP,"></i>",2)
 . I TMP["<",TMP[">" S TMP=$P($P(TMP,">",2),"<")
 . S:A>1 O=O_"," 
 . S O=O_""""_$$r(TMP,"""","""""")_""""
 Q O
 ;
r(s,f,t)
 i $tr(s,f)=s q s
 n o,i,l s l=$l(s,f),o="" f i=1:1:l  s o=o_$s(i<l:$p(s,f,i)_t,1:$p(s,f,i))
 q o
 ;
 ;
PULLRESULTS ; ZAA02Gweb
 I '$D(^ZAA02GTVB(RLC,"REPORT","ELGB","SELECTIONS")) W:$$lo($IO)[($G(^ZAA02GWEBC("SCRATCH SPACE"))_"scra") "Invalid Session, please refresh" Q
 L +^ZAA02GAAUTOELG:5 E  W:$$lo($I)[($G(^ZAA02GWEBC("SCRATCH SPACE"))_"scra") 2 Q
 D GetUserAndEZ^ZAA02GAAWEB(+RLC,.USER,.EZ) 
 N A S A=^ZAA02GTVB(RLC,"REPORT","ELGB","SELECTIONS")
 S VALUES=""
 S VALUES=VALUES_$p($p(A,"^",2),",")_":"
 S VALUES=VALUES_$p($p($p(A,"^",2),",",2),":")_":"
 S VALUES=VALUES_$p($P($P(A,"^",2),",",2),":",2)_":"
 S VALUES=VALUES_$P($P(A,"^",3),":")_":"
 S VALUES=VALUES_$P($P(A,"^",3),":",2)_":"
 S VALUES=VALUES_$P($P(A,"^",4),":")_":"
 S VALUES=VALUES_$P($P(A,"^",4),":",2)_":"
 S VALUES=VALUES_0_":"
 S RepMode      = $P($P(A,":",5),"^")
 S RepList              = $P($P(A,":",5),"^",2)
 S WEBHANDLE=RLC
 S USECLIENT=0
 S IO=$I
 S OPZ=USER,FROMDM=1
 S PR=$I
 D EZ^ZAA02GVBAS S ENT=EZ,EZ=TEZ
 S DTFRM=$$DG^IDATE($P(VALUES,":"))
 S DTTHRU=$$DG^IDATE($P(VALUES,":",2))
 S PV=$E($P(VALUES,":",3))
 S TMP=$P(VALUES,":",4)
 F I=1:1 Q:$P(TMP,",",I)=""  S PV($P(TMP,",",I))=""
 S IC=$E($P(VALUES,":",5))
 S TMP=$P(VALUES,":",6)
 F I=1:1 Q:$P(TMP,",",I)=""  S IC($P(TMP,",",I))=""
 S PRINT=$E($P(VALUES,":",7))
 S GROUP=$P(VALUES,":",8)
 S BATCH=1
 S PREVIEW=0
 S ZAA02GVB=1
 S NEW=0
 I 'USECLIENT S NEW=$$GETRESPS^XELBTR()
 I NEW D ^XELBTR U IO W:$$lo(IO)[($G(^ZAA02GWEBC("SCRATCH SPACE"))_"scra") 1 L -^ZAA02GAAUTOELG Q
 U IO W:$$lo(IO)[($G(^ZAA02GWEBC("SCRATCH SPACE"))_"scra") 0
 L -^ZAA02GAAUTOELG
 Q
 
 ;
INIT
 I '$D(^ZAA02GVBSYS("USERDISPLAY","JS","ZAA02GPRESUBELG")) D 
 . S ^ZAA02GVBSYS("USERDISPLAY","JS","ZAA02GPRESUBELG",1)="CHECKFILES^ZAA02GPRESUBELG"
 . S ^ZAA02GVBSYS("USERDISPLAY","JS","ZAA02GPRESUBELG",2)="PREVFILES^ZAA02GPRESUBELG"
 . S ^ZAA02GVBSYS("USERDISPLAY","JS","ZAA02GPRESUBELG",3)="LOG^ZAA02GPRESUBELG"
 Q
 ;
REFRESH ;ZAA02Gweb
 S IO=$$lo($I)
 I '$D(^ZAA02GTVB(RLC,"REPORT","ELGB","SELECTIONS"))        W:$$lo(IO)[($G(^ZAA02GWEBC("SCRATCH SPACE"))_"scra") "Invalid Session-H, please refresh" Q
 S JOB=$G(%("BODY"))
 I '$D(^SORT(JOB))                                                                      W:$$lo(IO)[($G(^ZAA02GWEBC("SCRATCH SPACE"))_"scra") "Invalid Session-J, please refresh" Q
 D GetUserAndEZ^ZAA02GAAWEB(+RLC,.USER,.EZ) 
 N A S A=^ZAA02GTVB(RLC,"REPORT","ELGB","SELECTIONS")
 S VALUES=""
 S VALUES=VALUES_$p($p(A,"^",2),",")_":"
 S VALUES=VALUES_$p($p($p(A,"^",2),",",2),":")_":"
 S VALUES=VALUES_$p($P($P(A,"^",2),",",2),":",2)_":"
 S VALUES=VALUES_$P($P(A,"^",3),":")_":"
 S VALUES=VALUES_$P($P(A,"^",3),":",2)_":"
 S VALUES=VALUES_$P($P(A,"^",4),":")_":"
 S VALUES=VALUES_$P($P(A,"^",4),":",2)_":"
 S VALUES=VALUES_0_":"
 S RepMode      = $P($P(A,":",5),"^")
 S RepList              = $P($P(A,":",5),"^",2)
 S WEBHANDLE=RLC,USECLIENT=0,IO=$$lo($I),OPZ=USER,FROMDM=1
 S PR=$I  D EZ^ZAA02GVBAS  S ENT=EZ,EZ=TEZ
 S DTFRM  = $$DG^IDATE($P(VALUES,":"))
 S DTTHRU = $$DG^IDATE($P(VALUES,":",2))
 S PV     = $E($P(VALUES,":",3))
 S TMP    = $P(VALUES,":",4)
 ;
 F I=1:1  Q:$P(TMP,",",I)=""  S PV($P(TMP,",",I))=""
 ;
 S IC  = $E($P(VALUES,":",5))
 S TMP = $P(VALUES,":",6)
 ;
 F I=1:1 Q:$P(TMP,",",I)=""  S IC($P(TMP,",",I))=""
 S PRINT = $E($P(VALUES,":",7))
 S GROUP = $P(VALUES,":",8)
 S BATCH = 1,ZAA02GVB=1,(RES,SL,SUB)="",CNT=0
 K ^SORT(JOB)
 I RepMode="S",RepList]"",$D(^ZAA02GPRESUBELG(RepList)) D REFRESHSRSLST Q
 S GI="<i class=\""fa fa-check fa-2x green\"" aria-hidden=\""true\""></i>"
 S BI="<i class=\""fa fa-exclamation-triangle fa-2x orange\"" aria-hidden=\""true\""></i>"
 S ^SORT(JOB,"REP",1)="Resource|Appt Date|Appt Time|Account|Name|DOB|Insurance|Status|Result"
 K DUPV
 S (RES,SL,SUB)="" F  S RES=$O(^ZAA02GSCH(ENT,"DET",RES)) Q:RES=""  D
 . Q:(PV="E"&($D(PV(RES))))!(PV="I"&('$D(PV(RES))))
 . S PRV=$P($G(^ZAA02GSCH(PEZ,"PARAM","RES",RES)),"|",9)
 . S DT=DTFRM-1,PVNM=$P($G(^ZAA02GSCH(PEZ,"PARAM","RES",RES)),"|",3)
 . F  S DT=$O(^ZAA02GSCH(ENT,"DET",RES,DT)) Q:DT=""  D
 .. I DTTHRU]"",(DT>DTTHRU) Q
 .. F  S SL=$O(^ZAA02GSCH(ENT,"DET",RES,DT,SL)) Q:SL=""  D
 ... F  S SUB=$O(^ZAA02GSCH(ENT,"DET",RES,DT,SL,SUB)) Q:SUB=""  D
 .... S S=^ZAA02GSCH(ENT,"DET",RES,DT,SL,SUB) I $P(S,"|",7)="" Q
 .... S T=$P(S,"|",4),K=$P(T,"/",1),K1=$P(T,"/",2) Q:K=""  S:K1="" K1=1
 .... S KK1=K_"^"_K1
 .... Q:$D(DUPV(KK1))  S DUPV(KK1)=""
 .... S TM     = $P($P(S,"|",7)," ",1),TM=$TR(TM,":",";")
 .... ;S DTNO   = "" F  S DTNO=$O(^ELG(1,K,K1,DTNO),-1) Q:DTNO=""  Q:($P(^(DTNO),":",35))=DT
 .... S DTNO   = $O(^ELG(1,K,K1,""),-1)
 .... I DTNO   = "" Q 
 .... I IC     = "I" S INS=$P($G(^ELG(1,K,K1,DTNO)),":") I INS=""!('$D(IC(INS))) Q
 .... S ELNO   = $O(^ELG(1,K,K1,DTNO,""))
 .... S RESULT = $P($$ELGCOV2^XELRS(K,K1,DTNO,ELNO),"|",5)
 .... I PRINT  = "C",RESULT'="ACTIVE" Q
 .... I PRINT  = "E",RESULT="ACTIVE" Q
 .... S PTNM    = $$NAME^ZAA02GVBELGBR(K,K1)
 .... S DOB    = $$DOB^ZAA02GVBELGBR(K,K1)
 .... S TMP      =$G(^ELG(1,K,K1,DTNO)) I TMP="" Q
 .... S OP     = $P(TMP,":",20)
 .... S INS    = $P(TMP,":")
 .... S STATUS = $$STATUS^XELLS1(K,K1,DTNO)
 .... S FLAG   = $P(STATUS,",",1)
 .... S STATUS = $P(STATUS,",",2)
 .... I PVNM="" S PVNM="No Resource"
 .... D LINE
 Q
 ;
LINE 
 S LINE=""
 S LINE=LINE_$G(PVNM)_"|"
 S LINE=LINE_$ZDT($ZDH($G(DT),8),5)_"|"
 S LINE=LINE_$TR($G(TM),"ap;","AP:")_"M"_"|"
 S LINE=LINE_($G(K)_"/"_$G(K1))_"|"
 S LINE=LINE_$G(PTNM)_"|"
 S LINE=LINE_$G(DOB)_"|"
 S LINE=LINE_$G(INS)_"|"
 S LINE=LINE_$$FS($G(STATUS),$G(K),$G(K1))_"|"
 S LINE=LINE_$S($G(RESULT)="DATA ERRORS":$$ERTG(),$G(RESULT)="ACTIVE":$$ERTA(),$G(RESULT)="INACTIVE":$$ERIA(),1:$G(RESULT))
 K TMP S TMP = $O(^SORT(JOB,"REP",""),-1) S TMP=TMP+1
 S ^SORT(JOB,"REP",TMP)=LINE
 Q
 ;
ERIA()
 N O,T
 S T=""
 S O=""
 S O=O_"<span class=\""label arrowed label-danger\"" style=\""width:125px\"" >" ;
 S O=O_"INACTIVE</span>" 
 Q O
 ;
ERTG()
 N O 
 S O="" 
 S O=O_"<span class=\""label arrowed label-warning\"" style=\""width:125px\"" >"
 S O=O_"DATA ERRORS</span>" 
 Q O
 ;
ERTA()
 N O S O="" S O=O_"<span class=\""label arrowed label-success\"" style=\""width:125px\"">"
 S O=O_"ACTIVE</span>" 
 Q O 
 ;
FS(S,K,K1)
 I $E(S)?1N  S S=$E(S,2,$L(S))
 I $E(S)="." S S=$E(S,2,$L(S))
 S S=$$r(S,"VIEWED","")
 Q "<button class='btn btn-minier ADSelg btn-info btn-white' data-ads='"_K_"."_K1_"'>"_S_"</button>" 
 ;
ELG ;ZAA02Gweb
 N KK1 S KK1 = $P($P(%("BODY"),"para=",2),"&")
 N K   S K  =$P(KK1,".")
 N K1  S K1 =$P(KK1,".",2)
 I 'K                           W $$PopError("Account is not defined")          Q
 I 'K1                          W $$PopError("Patient is not defined")          Q
 I '$D(^PTG(K,K1))      W $$PopError("Invalid account "_K_"/"_K1)       Q
 N USER,EZ S (RLC,%("FORM","DATA"))=+RLC
 D GetUserAndEZ^ZAA02GAAWEB(+RLC,.USER,.EZ)
 S ^ZAA02GTVB(+RLC,"REPORT","ELG")=K_"/"_K1_"|"_EZ_"|"_USER
 D WEB2^ZAA02GVBELGR
 W "<script>$jQ(window).load(function(){$jQ(""#tabs"").tabs(""option"", ""active"", 2);})</script>"
 Q
 ;
PopError(E)
 Q "<h3 style='color:red'>"_E_"<h3>"
 ;
 ;
LOG ; <button class='btn btn-white btn-purple btn-xs btn-bold'><i class='ace-icon fa fa-files-o fa-lg'></i>Logs</button>
 ; 
 ; (function load_logs(){
 ;   loader_on(); 
 ;   $jQ.ajax({
 ;     url: 'getlogs^ZAA02GPRESUBELG',
 ;     method: "POST",
 ;     data: repjob
 ; }).done(function(resp) {
 ;              if (resp === '0') { 
 ;                      loader_off();
 ;                      alertify.error('<strong>An Error has occured, please refresh!</strong>')
 ;                              ;return;
 ;                      }        
 ;     $jQ.ajax({
 ;         url: 'js^ZAA02Gvbaarpt2',
 ;         method: "POST",
 ;         data: repjob
 ;     }).done(function (json) {
 ;         var fData = JSON.parse(json);
 ;         var pData = fData.oc.concat(fData.repdata);
 ;         window['fData'] = fData;
 ;         window['pData'] = pData;
 ;         $jQ.ajax({
 ;             url: 'pickset^ZAA02Gvbaarpt2',
 ;             method: "POST",
 ;             data: 'user=' + repuser + "&program=" + repprogram + reptype
 ;         }).done(function (pick) {
 ;             $jQ.ajax({
 ;                 url: 'getgroup^ZAA02Gvbaarpt2',
 ;                 method: "POST",
 ;                 data: 'user=' + repuser + "&set=" + pick + "&program=" + repprogram + reptype
 ;             }).done(function (groupby) {
 ;                 groupby = eval("(" + groupby + ")");
 ;                 loadReptable(pick, groupby);
 ;                                 loader_off();
 ;                                alertify.success('<strong>Logs loaded!</strong>');
 ;             })
 ;         });
 ;     }).fail(function (jqXHR, textStatus) {
 ;                      loader_off();    
 ;         logError("Request failed: " + textStatus || '');
 ;     });
 ; });
 ; })()
 Q
 ;  
PREVFILES ;<button class='btn btn-white btn-danger btn-xs btn-bold'><i class='ace-icon fa fa-history fa-lg'></i>History</button>
 ; 
 ; (function load_previous_responses(){
 ;  loader_on();         
 ;   $jQ.ajax({
 ;     url: 'refresh^ZAA02GPRESUBELG',
 ;     method: "POST",
 ;     data: repjob
 ; }).done(function(stop) {
 ;     if ( stop === '1' ){ return; }
 ;     $jQ.ajax({
 ;         url: 'js^ZAA02Gvbaarpt2',
 ;         method: "POST",
 ;         data: repjob
 ;     }).done(function (json) {
 ;         var fData = JSON.parse(json);
 ;         var pData = fData.oc.concat(fData.repdata);
 ;         window['fData'] = fData;
 ;         window['pData'] = pData;
 ;         $jQ.ajax({
 ;             url: 'pickset^ZAA02Gvbaarpt2',
 ;             method: "POST",
 ;             data: 'user=' + repuser + "&program=" + repprogram + reptype
 ;         }).done(function (pick) {
 ;             $jQ.ajax({
 ;                 url: 'getgroup^ZAA02Gvbaarpt2',
 ;                 method: "POST",
 ;                 data: 'user=' + repuser + "&set=" + pick + "&program=" + repprogram + reptype
 ;             }).done(function (groupby) {
 ;                 groupby = eval("(" + groupby + ")");
 ;                 loadReptable(pick, groupby);
 ;                                 loader_off();
 ;                 alertify.success('<strong>Previous Responses Loaded</strong>');
 ;             })
 ;         });
 ;     }).fail(function (jqXHR, textStatus) {
 ;                      loader_off();    
 ;         logError("Request failed: " + textStatus || '');
 ;     });
 ; });
 ; })()
 ;
 ; 
 Q
CHECKFILES ; <button class='btn btn-white btn-success btn-xs btn-bold'><i class='ace-icon fa fa-cloud-download fa-lg'></i>Download</button>
 ; 
 ;function refreshEligList(){
 ; 
 ; $jQ.ajax({
 ;     url: 'refresh^ZAA02GPRESUBELG',
 ;     method: "POST",
 ;     data: repjob
 ; }).done(function(stop) {
 ;     if ( stop === '1' ){ return; }
 ;     $jQ.ajax({
 ;         url: 'js^ZAA02Gvbaarpt2',
 ;         method: "POST",
 ;         data: repjob
 ;     }).done(function (json) {
 ;         var fData = JSON.parse(json);
 ;         var pData = fData.oc.concat(fData.repdata);
 ;         window['fData'] = fData;
 ;         window['pData'] = pData;
 ;         $jQ.ajax({
 ;             url: 'pickset^ZAA02Gvbaarpt2',
 ;             method: "POST",
 ;             data: 'user=' + repuser + "&program=" + repprogram + reptype
 ;         }).done(function (pick) {
 ;             $jQ.ajax({
 ;                 url: 'getgroup^ZAA02Gvbaarpt2',
 ;                 method: "POST",
 ;                 data: 'user=' + repuser + "&set=" + pick + "&program=" + repprogram + reptype
 ;             }).done(function (groupby) {
 ;                 groupby = eval("(" + groupby + ")");
 ;                 loadReptable(pick, groupby);
 ;                                      loader_off();
 ;                 alertify.success('<strong>New Response File(s) Received</strong>');
 ;             })
 ;         });
 ;     }).fail(function (jqXHR, textStatus) {
 ;                      loader_off();    
 ;         logError("Request failed: " + textStatus || '');
 ;     });
 ; });
 ;}     
 ; loader_on();  
 ;   $jQ.ajax({
 ;       url: 'pullresults^ZAA02GPRESUBELG',
 ;       method: "POST",
 ;       data: ''
 ;      }).done(function (got_files) {
 ;         if(got_files === '1'){
 ;                       refreshEligList();
 ;      } else if (got_files === '2'){
 ;                  loader_off();
 ;                      alertify.alert('<p class="alertboxfail">There is a query already in progress. Please wait.</p>');
 ;  } else if (got_files === '0'){
 ;                       loader_off();   
 ;                 alertify.error('<strong>No New Response File(s) Received</strong>');
 ;      } else {
 ;                      loader_off();
 ;                      alertify.alert('<p class="alertboxfail">' + got_files + '</p>');  
 ;  }
 ;  })
 Q
REFRESHSRSLST 
 S ^SORT(JOB,"REP",1)="Provider|Date|Account|Name|DOB|SpA|SpB|SpC|Insurance Code|Insurance|Primary Payor|Primary Payor Type|Part B Deductible|Status|Result"
 K ^SORT($J,"C")
 I PREVIEW D
 . S ENDLST=$$DG^IDATE($P(RepList,",",2))
 . I ENDLST="" S ENDLST="~#"
 . I ENDLST S ENDLST=ENDLST_"999999"
 . S STARTLST=$$DG^IDATE($P(RepList,",",1))_"000000" 
 . K DUPV S RepList=ENDLST F  S RepList=$O(^ZAA02GPRESUBELG(RepList),-1) Q:RepList=""  Q:RepList<STARTLST  D
 ..  S SUB2="" F  S SUB2=$O(^ZAA02GPRESUBELG(RepList,SUB2)) Q:SUB2=""  D
 ... S SUB3="" F  S SUB3=$O(^ZAA02GPRESUBELG(RepList,SUB2,SUB3)) Q:SUB3=""  D
 .... S INCD="" F  S INCD=$O(^ZAA02GPRESUBELG(RepList,SUB2,SUB3,INCD)) Q:INCD=""  D
 ..... S POLNO="" F  S POLNO=$O(^ZAA02GPRESUBELG(RepList,SUB2,SUB3,INCD,POLNO)) Q:POLNO=""  D
 ...... S K=SUB2
 ...... S K1=SUB3
 ...... S KK1=K_"^"_K1
 ...... Q:$D(DUPV(KK1))  S DUPV(KK1)=""
 ...... D NLINE
 . Q
 ;
 I 'PREVIEW D
 . K DUPV  S SUB="" F  S SUB=$O(^ZAA02GPRESUBELG(RepList,SUB)) Q:SUB=""  D
 .. S SUB2="" F  S SUB2=$O(^ZAA02GPRESUBELG(RepList,SUB,SUB2)) Q:SUB2=""  D
 ... S INCD="" F  S INCD=$O(^ZAA02GPRESUBELG(RepList,SUB,SUB2,INCD)) Q:INCD=""  D
 .... S POLNO="" F  S POLNO=$O(^ZAA02GPRESUBELG(RepList,SUB,SUB2,INCD,POLNO)) Q:POLNO=""  D
 ..... S K=SUB
 ..... S K1=SUB2
 ..... S KK1=K_"^"_K1 ;_"^"_INCD_"^"_POLNO
 ..... Q:$D(DUPV(KK1))  S DUPV(KK1)=""
 ..... D NLINE
 . Q
 I $D(^SORT($J,"C")) D ^XELBT
 Q
 ;
NLINE
 S DT     = $ZD(+$H,8)
 ;S DTNO   = "" F  S DTNO=$O(^ELG(1,K,K1,DTNO),-1) Q:DTNO=""  Q:($P(^(DTNO),":",35))=DT
 S PTNM   = $$NAME^ZAA02GVBELGBR(K,K1)
 S NM=$TR(PTNM," ")
 S NM=$E($P(NM,",",1)_"     ",1,5)_$E($P(NM,",",2),1)
 I NMF]NM Q
 I NMT'="",NM]NMT Q
 S DOB    = $$DOB^ZAA02GVBELGBR(K,K1)
 S PRV    = $P(^PTG(K,K1),":",13)
 I PRV]"" S PVNM=$P(^PVG(PRV),":",2)
 I $TR($G(PVNM)," ")=""  S PVNM="No Provider"
 S GRE=$G(^GRG(EZ,K))
 I $TR(GRE,":")="" D
 . N ENT 
 . S ENT="" F  S ENT=$O(^GRG(ENT)) Q:ENT=""  Q:ENT>99  I $TR($G(^GRG(ENT,K)),":")'="" S GRE=^GRG(ENT,K) Q
 . Q
 S SPA=$P(GRE,":",9),SPB=$P(GRE,":",10),SPC=$P(GRE,":",11)
 S LINE=""
 S LINE=LINE_PVNM_"|"
 ;S LINE=LINE_$ZDT($ZDH(DT,8),5)_"|"
 ;S LINE=LINE_RepList_"|"
 S DTNO="" F  S DTNO=$O(^ELG(1,K,K1,DTNO),-1) Q:DTNO=""  I $P($G(^ELG(1,K,K1,DTNO)),":",1)=INCD Q
 I $E(DTNO,1,8)<$E(RepList,1,8) D ELGERR Q 
 S TMP    = $G(^ELG(1,K,K1,DTNO)) I TMP="" Q
 S OP     = $P(TMP,":",20)
 S INS    = $P(TMP,":")
 I IC'="A" Q:INS=""&(IC="I")  I IC]"",(IC="I"&'$D(IC(INS)))!(IC="E"&$D(IC(INS))) Q
 S ELNO   = $O(^ELG(1,K,K1,DTNO,""))
 I ELNO="" S ELNO=" "
 S RESULT = $P($$ELGCOV2^XELRS(K,K1,DTNO,ELNO),"|",5)
 I PRINT  = "C",RESULT'="ACTIVE" Q
 I PRINT  = "E",RESULT="ACTIVE" Q
 S DED=0
 I $P($G(^ING(INS)),":",30)="M",ELNO D
 . S DED=$$MCRBDED(K,K1,DTNO,ELNO)
 . I '$G(^MSCG("HOLDSUB")) Q
 . S HOLD=DED
 . I HOLD,$G(^MSCG("HOLDSUB","MCD")) D
 .. S ORD=$G(^PTG(K,K1,0))
 .. I ORD="" S ORD=$G(^GRG(K,0))
 .. S PRIM=$P(ORD,":",1)
 .. I 'PRIM Q
 .. I $P($G(^GRG(K,PRIM)),":",3)'=INS Q
 .. S ST1=$P($G(^ING(INS)),":",13)
 .. S ST1=$P(ST1,",",$L(ST1,","))
 .. I ST1="" Q
 .. I '$D(^MSCG("HOLDSUB","MCD",ST1)) Q
 .. S SEC=$P(ORD,":",2)
 .. I 'SEC Q
 .. S SEC=$P($G(^GRG(K,SEC)),":",3)
 .. I SEC="" Q
 .. I $P($G(^ING(SEC)),":",30)'="D" Q
 .. S ST2=$P($G(^ING(SEC)),":",13)
 .. S ST2=$P(ST2,",",$L(ST2,","))
 .. I ST2="" Q
 .. I '$D(^MSCG("HOLDSUB","MCD",ST2)) Q
 .. S HOLD=0
 .. Q
 . S SPB=$S(HOLD:"H",SPB="H":"",1:SPB)
 . N ENT S ENT="" F  S ENT=$O(^GRG(ENT)) Q:ENT=""  Q:ENT>99  D
 .. I $D(^GRG(ENT,K)) S $P(^GRG(ENT,K),":",10)=$S(HOLD:"H",$P(^GRG(ENT,K),":",10)="H":"",1:$P(^GRG(ENT,K),":",10))
 . Q
 S PRIM=""
 I ELNO]""  S PRIM=$$PRIM(K,K1,DTNO,ELNO)
 S PRIMTYP=$P(PRIM,":",2),PRIM=$P(PRIM,":",1)
 I PRIMTYP'="" S PRIMTYP=$G(^ELG("SEG","EB",4,PRIMTYP),PRIMTYP)
 I PRIM]"",$G(^MSCG("PAYORINEMAIL")) D
 . I $P(^PTG(K,K1),":",21)="S" D  Q
 .. N TMP S TMP=$P(^GRG(K),":",26)
 .. S $P(TMP,"^",4)=PRIM
 .. S $P(^GRG(K),":",26)=TMP
 .. Q
 . N TMP S TMP=$P(^PTG(K,K1),":",28)
 . S $P(TMP,"^",4)=PRIM
 . S $P(^PTG(K,K1),":",28)=TMP
 . Q
 S STATUS = $$STATUS^XELLS1(K,K1,DTNO)
 S FLAG   = $P(STATUS,",",1)
 S STATUS = $P(STATUS,",",2)
 I STATUS["CREATED" D
 . N CTR S CTR=$O(^SORT($J,"C",""),-1)+1
 . S ^SORT($J,"C",CTR)="::::"_K_":"_K1_":"_DTNO
 . Q
 S LINE=LINE_$$SUB^IDATE($E(DTNO,1,8),0)_"|"
 S LINE=LINE_(K_"/"_K1)_"|"
 S LINE=LINE_PTNM_"|"
 S LINE=LINE_DOB_"|"
 S LINE=LINE_SPA_"|"_SPB_"|"_SPC_"|"
 S LINE=LINE_INS_"|"_$P($G(^ING(INS)),":",2)_"|"
 S LINE=LINE_PRIM_"|"_PRIMTYP_"|"
 S LINE=LINE_$J(DED,0,2)_"|"
 S LINE=LINE_$$FS(STATUS,K,K1)_"|"
 S LINE=LINE_$S(RESULT="DATA ERRORS":$$ERTG(),RESULT="ACTIVE":$$ERTA(),$G(RESULT)="INACTIVE":$$ERIA(),1:RESULT)
 K TMP S TMP = $O(^SORT(JOB,"REP",""),-1) S TMP=TMP+1
 S ^SORT(JOB,"REP",TMP)=LINE
 Q
 ;
ELGERR
 I PRINT="C" Q
 I IC'="A" Q:INCD=""&(IC="I")  I IC]"",(IC="I"&'$D(IC(INCD)))!(IC="E"&$D(IC(INCD))) Q
 S LINE=LINE_$$SUB^IDATE($E(RepList,1,8),0)_"|"
 S LINE=LINE_(K_"/"_K1)_"|"
 S LINE=LINE_PTNM_"|"
 S LINE=LINE_DOB_"|"
 S LINE=LINE_SPA_"|"_SPB_"|"_SPC_"|"
 S LINE=LINE_INCD_"|"_$P($G(^ING(INCD)),":",2)_"||||"
 S LINE=LINE_$$FS("NOT CREATED",K,K1)_"|"_$G(^ZAA02GPRESUBELG(RepList,K,K1,INCD,POLNO))
 K TMP S TMP = $O(^SORT(JOB,"REP",""),-1) S TMP=TMP+1
 S ^SORT(JOB,"REP",TMP)=LINE
 Q
 ;
MCRBDED(K,K1,DTNO,ELNO)
 N (K,K1,DTNO,ELNO)
 S DED=0
 S LN=0 F  S LN=$O(^ELG(1,K,K1,DTNO,ELNO,LN)) Q:'LN  D  Q:DED
 . S REC=^ELG(1,K,K1,DTNO,ELNO,LN)
 . I $P(REC,":",2)'="EB" Q
 . I $P(REC,":",3)'="C" Q
 . I $P(REC,":",5)'=30 Q
 . I $P(REC,":",6)'="MB" Q
 . I $P(REC,":",8)'=29 Q
 . S DED=$P(REC,":",9)
 Q DED
 ;
PRIM(K,K1,DTNO,ELNO)
 N (K,K1,DTNO,ELNO)
 S (HMO,OTH)=""
 S LN=0 F  S LN=$O(^ELG(1,K,K1,DTNO,ELNO,LN)) Q:'LN  D  Q:HMO]""
 . S REC=^ELG(1,K,K1,DTNO,ELNO,LN)
 . I $P(REC,":",2)'="EB" Q
 . I $P(REC,":",3)'="R",$P(REC,":",3)'="U" Q
 . I $P(REC,":",5)'=30 Q
 . S TYP=$P(REC,":",6) 
 . I TYP Q
 . S HN=0
 . I TYP="HN" S HN=1
 . I 'HN,OTH]"" Q
 . S EB=0
 . F  S LN=$O(^ELG(1,K,K1,DTNO,ELNO,LN)) Q:'LN  D  Q:EB  Q:HMO]""  Q:'HN&(OTH]"")
 .. S REC=^ELG(1,K,K1,DTNO,ELNO,LN)
 .. I $P(REC,":",2)="EB" S EB=1 Q
 .. I $P(REC,":",2)'="NM1" Q
 .. I $P(REC,":",3)'="PRP" Q
 .. I $P(REC,":",4)'=2 Q
 .. I HN S HMO=$P(REC,":",5)_":"_TYP Q
 .. S OTH=$P(REC,":",5)_TYP
 .. Q
 . I EB S LN=LN-1
 . I 'LN S LN="Z"
 . Q
 I HMO]"" Q HMO
 Q OTH
 ;
GETLOGS ;ZAA02Gweb
        S JOB=$G(%("BODY"))
        S UNIX=$S($ZV["UNIX":1,1:0),DELIM=$S(UNIX:"/",1:"\")
        D INT^%DIR,NSP^%DIR S NUM=$L(%SYSDIR,DELIM)
        N LIST K LIST D FileList^XELBTR(%SYSDIR_"claims"_DELIM_"Auto_Elgibility"_DELIM,"*.csv",1,.LIST)
        I '$D(LIST) W "0" Q
        K ^SORT(JOB)
        S ^SORT(JOB,"REP",1)="Filename|Filesize (KB)|Date Created|Dated Modified"
        S FILE = "" F  S FILE=$O(LIST(FILE)) Q:FILE=""  D
        . S FILESIZE = ##class(%File).GetFileSize(FILE)
        . I FILESIZE = "" Q
        . S FILESIZE = $J((FILESIZE/1024),0,2)
        . ;
        . S FILENAME = ##class(%File).GetFilename(FILE)
        . I FILENAME = "" Q
        . ;
        . S CREATEDATE = $ZDT(##class(%File).GetFileDateCreated(FILE),3)
        . I CREATEDATE = "" Q
        . ;
        . S MODIFIEDDATE = $ZDT(##class(%File).GetFileDateModified(FILE),3)
        . ;
        . S LINE=""
        . S LINE=LINE_"<a href=\""gf^ZAA02GPRESUBELG?ses="_+RLC_"&key="_$$ToBase64URL(FILENAME)_"\"">"_FILENAME_"<a/>"_"|"
        . S LINE=LINE_FILESIZE_"|"
        . S LINE=LINE_CREATEDATE_"|"
        . S LINE=LINE_MODIFIEDDATE
        . ;
        . K TMP S TMP = $O(^SORT(JOB,"REP",""),-1) S TMP=TMP+1
        . S ^SORT(JOB,"REP",TMP)=LINE
        Q
        ;
GF      ;ZAA02Gweb nocheck
        s DATA=%("FORM","DATA")
        s RLC=$p($p(DATA,"ses=",2),"&key=")
        S FILENAME = $$FromBase64URL($p(DATA,"&key=",2))
        S UNIX=$S($ZV["UNIX":1,1:0),DELIM=$S(UNIX:"/",1:"\")
        D INT^%DIR,NSP^%DIR S NUM=$L(%SYSDIR,DELIM)
        I '##class(%File).Exists(%SYSDIR_"claims"_DELIM_"Auto_Elgibility"_DELIM_FILENAME) D  Q
        . W "Invalid file name"
        d GetUserAndEZ^ZAA02GAAWEB(+RLC,.user,.EZ)
        i $g(user)="" w "<h1>Invalid Handle!</h1>" q
        s Filename=FILENAME
        ;
        s TYPE="application/octet-stream"
        s OTHERMM=$G(OTHERMM)_"Content-Disposition: attachment; filename="""_Filename_""""_$C(13,10)
        ;
        N TMP S TMP = %SYSDIR_"claims"_DELIM_"Auto_Elgibility"_DELIM_FILENAME
        S STREAM=##class(%FileCharacterStream).%New()
        S STREAM.Filename=TMP F  Q:STREAM.AtEnd  W STREAM.ReadLine(),!
        ;
url(s)
        n t
        s s=$$r(s,"-","+")
        s s=$$r(s,"_","/")
        s t=$l(s)#4
        q $s(t=0:s,t=2:s_"==",t=3:s_"=",1:"Invalid base64url string")
        ;
        ;
FromBase64URL(a)
        Q $system.Encryption.Base64Decode($$url(a))     
        ;
        ;
ToBase64URL(a) 
        n b,c,j,cd,cd1,cc d
        . s cd ="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_="
        . s cd1="" f j=1:1:65 s cd1=cd1_$c(j+31)
        s cc="" f j=1:3:$l(a) d  s cc=cc_c
        . s b=$e(a,j,j+2)
        . i $l(b)=3 s c=$tr($c($a(b)\4+32,$a(b)#4*16+($a(b,2)\16)+32,$a(b,2)#16*4+($a(b,3)\64)+32,$a(b,3)#64+32),cd1,cd) Q
        . i $l(b)=2 s c=$tr($c($a(b)\4+32,$a(b)#4*16+($a(b,2)\16)+32,$a(b,2)#16*4+32,96),cd1,cd) Q
        . s c=$tr($c($a(b)\4+32,$a(b)#4*16+32,96,96),cd1,cd) Q
        q $p(cc,"=")
        ;
        ;
up(s)   q $tr(s,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
lo(s)   q $tr(s,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 ;Routine(s): XELAP1
 ;Routine(s): XELFM10
 ;Routine(s): ZAA02GAAUTOELG
 ;Routine(s): ZAA02GVBELG*
 ;Routine(s): ZAA02GAAWEB*
 ;Routine(s): ZAA02GAAUTIL*
 ;Routine(s): ZAA02GVBREP*
 ;Routine(s): ZAA02GVBAARPT*
 ;Routine(s): XELBTR*
 
.
