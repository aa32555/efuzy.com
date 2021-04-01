ZAA02GTOPUSE ; Top Used Procedure/Diagnosis;2017-03-17 13:29:55;12FEB2008  13:03; ; 30 Nov 2004  10:57AM
 ; ADS Corp. Copyright
 ;
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
 S PRG="ZAA02GTOPUSE"
 S Q="1"
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
 S SORTD=$E($P(s,D1,2))
 S DTF=$TR($P($P($P(s,D1,2),D2,2),D3),"_")
 S DTF=$P(DTF,D4,3)_$P(DTF,D4)_$P(DTF,D4,2)
 S DTF=$$DG^IDATE(DTF,1)
 I $E(DTF)<2 S DTF=$E(DTF,3,8)
 S DT1=$$DSS^IDATE(DTF)
 S DTT=$TR($P($P($P(s,D1,2),D2,2),D3,2),"_")
 S DTT=$P(DTT,D4,3)_$P(DTT,D4)_$P(DTT,D4,2)
 I DTT]"" S DTT=$$DG^IDATE(DTT,1)
 E  S DTT=$$DG^IDATE(+$H)
 I $E(DTT)<2 S DTT=$E(DTT,3,8)
 S DT2=$$DSS^IDATE(DTT)
 S FRTR=""
 I SORTD="P" D  Q:FRTR=-1  S FRTR=^DAY(FRTR)-1
 . S DAY=DTF-1
 . S FRTR=$N(^DAY(DAY))
 . S JUL=$$JUL^IDATE(DTT)
 ;
 ; Provider
 S PVH="Provider:"
 S PVS=$E($P(s,D1,3))
 I PVS="A" S PVH=PVH_" All"
 I PVS'="A" D
 . S TMP=$TR($P($P(s,D1,3),D2,2),D3,D1)
 . F I=1:1:$L(TMP,D1) D
 .. S TMP1=$P(TMP,D1,I)
 .. I TMP1]"" S PVC(TMP1)=""
 . I PVS="E" S PVH=PVH_" Excluded "
 . I PVS="I" S PVH=PVH_" Selected "
 . S TMP=""
 . F  S TMP=$O(PVC(TMP)) Q:TMP=""  S PVH=PVH_TMP_" "
 ;
 ; Code
 S LIST=","_$P($P(s,D1,4),D2,2)_","
 ;
 ; Top Number
 S TOP=$P($P(s,D1,5),D2,2)
 ;
 I VAL="" S B="||RUN||" Q
 I VAL'="RUN" S B="99|Invalid System Response|16|Report|1=0" Q
 ;
 K ^SORT($J)
 F I=1:1 S CODE=$P("DP,DG,IN,PS,PC,PV,RF",D3,I) Q:CODE=""  K ^SORT($J,CODE)
 S TEZ="" F  S TEZ=$O(ENT(TEZ)) Q:TEZ=""  D
 . I SORTD="P" S TR=FRTR D POST
 . I SORTD="S" S DAY=DTF,(K,TR)="" D SERV
 F I=1:1 S CODE=$P("DP,DG,IN,PS,PC,PV,RF",D3,I) Q:CODE=""  D
 . I $D(^SORT($J,CODE)) K ^SORT($J,"CNT") D @CODE 
 K ^SORT($J)
 W !,"Complete"
 Q 
POST F  S TR=$O(^TRG(TEZ,TR)) Q:TR=""  D
 . S TREC=$G(^TRG(TEZ,TR))
 . I $P(TREC,":",4)'="P" Q
 . I $P(TREC,":",1)>JUL Q
 . D COUNT
 Q
SERV F  S DAY=$O(^SVK(TEZ,DAY)) Q:DAY=""!(DAY>DTT)  D
 . F  S K=$O(^SVK(TEZ,DAY,K)) Q:K=""  D
 .. F  S TR=$O(^SVK(TEZ,DAY,K,TR)) Q:TR=""  D
 ... S TREC=$G(^TRG(TEZ,TR))
 ... I $P(TREC,":",4)'="P" Q
 ... D COUNT
 Q
COUNT ; Count Procedure/Diagnosis
 I PVS'="A" S T=$P(TREC,":",13) I PVS="I"&('$D(PVC(T)))!(PVS="E"&($D(PVC(T)))) Q
 F I=1:1 S CODE=$P("DP,DG,IN,PS,PC,PV,RF",D3,I) Q:CODE=""  I LIST[(","_$S(CODE="PS":"PL",1:CODE)_",") D
 . S DATA=$P(TREC,D1,$P("5,22,44,15,6,13,14",D3,I))
 . I DATA]"",CODE="DG"!(CODE="PC") S INV="^IN"_CODE,DATA=$P($G(@INV@(DATA)),D1)
 . I CODE="IN",'DATA Q
 . I DATA,CODE="IN" S ACCT=$P(TREC,D1,3),DATA=$P(^GRG(ACCT,+DATA),D1,3)
 . I DATA]"" S ^SORT($J,CODE,""_DATA_"")=$G(^SORT($J,CODE,""_DATA_""))+1
 Q
DG ;Top Diagnosis
 S DG="" F  S DG=$O(^SORT($J,"DG",DG)) Q:DG=""  S CNT=^(DG) I CNT S ^SORT($J,"CNT",CNT,DG)=""
 K ^SORT($J,"DG"),^GNG("DG") Q:'TOP
 S DG="" F  S DG=$O(^DGSRT(DG)) Q:DG=""!(DG'?1N.N)  K ^DGSRT(DG)
 S NUM=0,CNT="" F  S CNT=$O(^SORT($J,"CNT",CNT),-1) Q:CNT=""!((NUM'<TOP))  D
 . F  S DG=$O(^SORT($J,"CNT",CNT,DG)) Q:DG=""!((NUM'<TOP))  D
 .. S NUM=NUM+1
 .. S ^GNG("DG",DG)=$P($G(^DGG(DG)),":",1,2)
 .. S ^DGSRT(NUM)=DG
 S ^GNG("DG")="DG:TOP "_NUM_" DIAGNOSIS:DG"
 Q
DP ;Top Departments
IN ;Top Insrance
PS ;Top Places of Service
PL ;Top Places of Service
PC ;Top Procedures
PV ;Top Providers
RF ;Top Referring Physicians
 S LKSRT="^"_CODE_"SRT",GBL="^"_CODE_"G",LKUP="^"_CODE_"AH"
 S CD="" F  S CD=$O(^SORT($J,CODE,CD)) Q:CD=""  S CNT=^(CD) I CNT S ^SORT($J,"CNT",CNT,CD)=""
 K ^SORT($J,CODE),^GNG(CODE) K @LKSRT Q:'TOP
 S NUM=0,CNT="" F  S CNT=$O(^SORT($J,"CNT",CNT),-1) Q:CNT=""!((NUM'<TOP))  D
 . F  S CD=$O(^SORT($J,"CNT",CNT,CD)) Q:CD=""!((NUM'<TOP))  D
 .. S NUM=NUM+1
 .. S ^GNG(CODE,CD)=$P($G(@GBL@(CD)),":",1,2)
 .. S @LKSRT@(NUM,CD)=""
 S ^GNG(CODE)=CODE_":TOP "_NUM_" "_$P("DEPARTMENT,DIAGNOSIS,INSURANCE,PLACE OF SERVICE,PROCEDURE,PROVIDER,REF. PHYSICIAN",D3,I)_":"_$S(CODE="PS":"PL",1:CODE)
 S L1="" F  S L1=$O(@LKUP@(L1)) Q:L1=""  S L2="" F  S L2=$O(@LKUP@(L1,L2)) Q:L2=""  I '$D(^GNG(CODE,L2)) S NUM=NUM+1,@LKSRT@(NUM,L2)=""
 Q
VB G ZAA02GTOPUSE
