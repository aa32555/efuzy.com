ZAA02GPRESUBELGXELAP1 ; (X12 5010) Presubmission Eligibility - process ;2017-03-07 09:35:19
 ; ADS Corp. Copyright
 ;
 N RTYPE,SLOPT,DT
 S RTYPE="A"
 I $D(^LIST("ELIGLIST")),$D(^MSCG("ELIGLIST")) D
 . S RTYPE="S"
 . S SLOPT="G"
 . S SLIST="ELIGLIST"
 . S (DTS,DT)=$ZD(+$H,8)
 I $G(RepMode)="S" D
 . S RTYPE="S"
 . S SLOPT="G"
 . S SLIST=RepList
 ;I RTYPE="A" G TYPEA
 I RTYPE="S" G TYPES
 Q
 ;
TYPES
 K ^SORT($J)
 D ^PRNTR Q:ZVD>1
 I SLOPT="P"!(SLOPT="G") G GPLIST
 I SLOPT="A" G ALIST
 Q
 ;
ALIST ;NOT USED
 K ^SORT($J)
 I '$G(ZAA02GVB) W "...processing, please wait" D PARAM
 D ^PRNTR Q:ZVD>1
 ;
 S:DTFRM'="" DTFRM=DTFRM-1 S COUNTER=$G(^ELG(0,$$DG^IDATE))
 I '$G(ZAA02GVB) D
 . S DT=DTFRM
 . F  S DT=$O(^INVAPP(ENT,DT)) Q:DT=""!(DTTHRU'=""&(DT>DTTHRU))  D
 .. Q:$L(DT)'=8
 .. S PRV="" K DUPV
 .. F  S PRV=$O(^INVAPP(ENT,DT,PRV)) Q:PRV=""  D
 ... Q:(PV="E"&($D(PV(PRV))))!(PV="I"&('$D(PV(PRV))))
 ... S TM="",PVNM=$P($G(^PVG(PRV)),":",2)
 ... F  S TM=$O(^INVAPP(ENT,DT,PRV,TM)) Q:TM=""  D
 .... S APP=^(TM) 
 .... F J=5:1:$L(APP,":") S KK1=$P(APP,":",J) D
 ..... S K=$P(KK1,"^",1),K1=$P(KK1,"^",2) Q:(K=""!(K1=""))
 ..... Q:$D(DUPV(KK1))  S DUPV(KK1)=""
 ..... D:KK1'="" FILE
 I $G(ZAA02GVB) D
 . S (RES,SL,SUB)=""
 . F  S RES=$O(^ZAA02GSCH(ENT,"DET",RES)) Q:RES=""  D
 .. Q:(PV="E"&($D(PV(RES))))!(PV="I"&('$D(PV(RES))))
 .. S PRV=$P($G(^ZAA02GSCH(PEZ,"PARAM","RES",RES)),"|",9)
 .. S DT=DTFRM,PVNM=$P($G(^ZAA02GSCH(PEZ,"PARAM","RES",RES)),"|",3)
 .. F  S DT=$O(^ZAA02GSCH(ENT,"DET",RES,DT)) Q:DT=""!(DTTHRU'=""&(DT>DTTHRU))  D
 ... K DUPV
 ... F  S SL=$O(^ZAA02GSCH(ENT,"DET",RES,DT,SL)) Q:SL=""  D
 .... F  S SUB=$O(^ZAA02GSCH(ENT,"DET",RES,DT,SL,SUB)) Q:SUB=""  D
 ..... S S=^ZAA02GSCH(ENT,"DET",RES,DT,SL,SUB) I $P(S,"|",7)="" Q
 ..... S T=$P(S,"|",4),K=$P(T,"/",1),K1=$P(T,"/",2) Q:K=""  S:K1="" K1=1
 ..... I BATCH K SI S INUM=+$$FINDI^XELFM10("","",DT),INSCD=$P($G(^GRG(K,INUM)),":",3) I INSCD]"",IC="I",'$D(IC(INSCD)) Q
 ..... S KK1=K_"^"_K1
 ..... Q:$D(DUPV(KK1))  S DUPV(KK1)=""
 ..... S TM=$P($P(S,"|",7)," ",1),TM=$TR(TM,":",";") D FILE
 ;
 D END
 Q
 ;
GPLIST
 S COUNTER=$G(^ELG(0,$$DG^IDATE))
 S TM="",DT=$G(DTS,$ZD(+$H,8)),PRV=""
 S SUB="" F  S SUB=$O(^ZAA02GPRESUBELG(SLIST,SUB)) Q:SUB=""  D
 . S SUB2="" F  S SUB2=$O(^ZAA02GPRESUBELG(SLIST,SUB,SUB2)) Q:SUB2=""  D
 .. S INCD="" F  S INCD=$O(^ZAA02GPRESUBELG(SLIST,SUB,SUB2,INCD)) Q:INCD=""  D
 ... S POLNO="" F  S POLNO=$O(^ZAA02GPRESUBELG(SLIST,SUB,SUB2,INCD,POLNO)) Q:POLNO=""  D
 .... S K=SUB
 .... S K1=SUB2
 .... S KK1=K_"^"_K1
 .... ;I REPDEM="R" S PRV=REPPR
 .... ;I REPDEM="D"&($D(^PTG(K,K1))) S PRV=$P(^PTG(K,K1),":",13)
 .... S PRV=$P(^PTG(K,K1),":",13)
 .... I PRV'="" S PVNM=$P(^PVG(PRV),":",2)
 .... I PRV=""  S PVNM=$P(^PVG($O(^PVG(""))),":",2)
 .... I PRV="" S PVNM=""
 .... S RES=PRV
 .... D FILE(INCD,POLNO)
 .... S ^ZAA02GPRESUBELG(SLIST,SUB,SUB2,INCD,POLNO)=ERR
 . Q
 ;D END
 Q
 ;
GPLISTP ;NOT USED
 S SUB="" F  S SUB=$O(^LIST(SLIST,SUB)) Q:SUB=""  D
 . S SUB2="" F  S SUB2=$O(^LIST(SLIST,SUB,SUB2)) Q:SUB2=""  D
 .. S SUB3="" F  S SUB3=$O(^LIST(SLIST,SUB,SUB2,SUB3)) Q:SUB3=""  D
 ... S K=SUB2
 ... S K1=SUB3
 ... S KK1=K_"^"_K1
 ... ;I REPDEM="R" S PRV=REPPR
 ... ;I REPDEM="D"&($D(^PTG(K,K1))) S PRV=$P(^PTG(K,K1),":",13)
 ... S PRV=$P(^PTG(K,K1),":",13)
 ... I PRV'="" S PVNM=$P(^PVG(PRV),":",2)
 ... I PRV="" S PVNM=""
 ... S RES=PRV
 ... D FILE
 D END
 Q
TYPEA ;NOT USED
 K ^SORT($J)
 I '$G(ZAA02GVB) W "...processing, please wait" D PARAM
 D ^PRNTR Q:ZVD>1
 ;
 S:DTFRM'="" DTFRM=DTFRM-1 S COUNTER=$G(^ELG(0,$$DG^IDATE))
 I '$G(ZAA02GVB) D
 . S DT=DTFRM
 . F  S DT=$O(^INVAPP(ENT,DT)) Q:DT=""!(DTTHRU'=""&(DT>DTTHRU))  D
 .. Q:$L(DT)'=8
 .. S PRV="" K DUPV
 .. F  S PRV=$O(^INVAPP(ENT,DT,PRV)) Q:PRV=""  D
 ... Q:(PV="E"&($D(PV(PRV))))!(PV="I"&('$D(PV(PRV))))
 ... S TM="",PVNM=$P($G(^PVG(PRV)),":",2)
 ... F  S TM=$O(^INVAPP(ENT,DT,PRV,TM)) Q:TM=""  D
 .... S APP=^(TM) 
 .... F J=5:1:$L(APP,":") S KK1=$P(APP,":",J) D
 ..... S K=$P(KK1,"^",1),K1=$P(KK1,"^",2) Q:(K=""!(K1=""))
 ..... Q:$D(DUPV(KK1))  S DUPV(KK1)=""
 ..... D:KK1'="" FILE
 I $G(ZAA02GVB) D
 . S (RES,SL,SUB)=""
 . F  S RES=$O(^ZAA02GSCH(ENT,"DET",RES)) Q:RES=""  D
 .. Q:(PV="E"&($D(PV(RES))))!(PV="I"&('$D(PV(RES))))
 .. S PRV=$P($G(^ZAA02GSCH(PEZ,"PARAM","RES",RES)),"|",9)
 .. S DT=DTFRM,PVNM=$P($G(^ZAA02GSCH(PEZ,"PARAM","RES",RES)),"|",3)
 .. F  S DT=$O(^ZAA02GSCH(ENT,"DET",RES,DT)) Q:DT=""!(DTTHRU'=""&(DT>DTTHRU))  D
 ... K DUPV
 ... F  S SL=$O(^ZAA02GSCH(ENT,"DET",RES,DT,SL)) Q:SL=""  D
 .... F  S SUB=$O(^ZAA02GSCH(ENT,"DET",RES,DT,SL,SUB)) Q:SUB=""  D
 ..... S S=^ZAA02GSCH(ENT,"DET",RES,DT,SL,SUB) I $P(S,"|",7)="" Q
 ..... S T=$P(S,"|",4),K=$P(T,"/",1),K1=$P(T,"/",2) Q:K=""  S:K1="" K1=1
 ..... I BATCH K SI S INUM=+$$FINDI^XELFM10("","",DT),INSCD=$P($G(^GRG(K,INUM)),":",3) I INSCD]"",IC="I",'$D(IC(INSCD)) Q
 ..... S KK1=K_"^"_K1
 ..... Q:$D(DUPV(KK1))  S DUPV(KK1)=""
 ..... S PLC=$P($P(S,"`",19),"  ")
 ..... S TM=$P($P(S,"|",7)," ",1),TM=$TR(TM,":",";") 
 ..... D FILE
 D END
 Q
 ;
END ;
 I PREVIEW!('$G(ZAA02GVB)),'BATCH D ^XELAP2 K:'$G(ZAA02GVB) ^SORT($J)  ; print
 ;
 I BATCH,'PREVIEW D
 . I $D(^SORT($J,"C")) D ^XELBT
 . ;S FFILENO="" D END^XELBT  ;to repeat batches
 I $$GETRESPS^XELBTR() D ^XELBTR 
 ; 
 ;I '$G(ZAA02GVB) D XELLS1 K ^SORT($J)
 Q
 ;
FILE(INCD,POL)   ;N EZ S EZ=ENT
 S (ERR,DTNO,S)=""
 S ERR=$$INCHK^XELFM10($G(INCD),K,K1,DT,$G(POL))
 G:ERR'="" FILE1
 S GRPV=$$GRPV^XELFM1(K,$P(S,":",29))
 I GRPV="" S ERR="Submission not defined in entity "_EZ G FILE1
 I '$G(ZAA02GVB),GRPV="P",'$D(^PVG(PRV)) S ERR="Provider not defined" G FILE1
 I PRV="",GRPV="P" S ERR="Resource not mapped to provider" G FILE1
 S PVV=PRV S:GRPV="G" PVV=""
 S ERR=$$PVCHK^XELFM1(PVV,$P(S,":",29)) G:ERR'="" FILE1
 ;S ERR=$$CHKADUP(K,K1,$P(S,":",1),DT) G:ERR'="" FILE1
 S $P(S,":",3)=$S($G(^ZAA02GVBUSER("CODE","DEFAULTS","ELIGTOS",0))'="":$P(^(0),"^"),1:30)
 S $P(S,":",7)="S"
 S $P(S,":",8)=DT,$P(S,":",35)=DT
 I $$JUL^IDATE(DT)>+$H S $P(S,":",8)=$$DG^IDATE(+$H)
 S INS=$P(S,":"),PS=$S($G(PLC)]"":PLC,1:$P(S,":",6)),PAYER=$P(S,":",12)
 S (OVRINS,OVRPY)="" I INS]"" S OVRD=$G(^ELG("INS",INS,EZ)) I OVRD]"" S OVRINS=$P(OVRD,":",2)
 I OVRINS="",PS]"",INS]"",$D(^INIDPL(INS,PS)) S OVRD=^INIDPL(INS,PS),OVRPY=$S($P(OVRD,":",2)]"":$P(OVRD,":",2),1:$P(OVRD,":"))
 S INS=$S(OVRINS]"":INS_"|"_OVRINS,1:INS),$P(S,":")=INS,PAYER=$S(OVRPY]"":OVRPY,1:PAYER),$P(S,":",12)=PAYER
 I GRPV="G" S NPI="",TEZ=$G(^MSCG("ELIG","ENT",EZ),EZ) I $D(^ENNPI(TEZ)) D  I NPI]"" S $P(S,":",13)=NPI
 . I PS]"",INS]"" S NPI=$G(^ENNPI(TEZ,INS,PS))
 . I NPI="",PS]"" S NPI=$G(^ENNPI(TEZ,"*",PS))
 I 'PREVIEW D STR^XELFM(.DTNO,.ERR) I ERR'="" G FILE1
 S COUNTER=COUNTER+1 I COUNTER>$S($D(^MSCG("ELG","LIMITCHGDT")):999999999999,1:999) S ERR="Limit exceeded for today" G FILE1
 I PREVIEW S DTNO=$$DG^IDATE(^TODAY)_"000"_$S($D(^MSCG("ELG","LIMITCHGDT")):"000000000",1:"")
FILE1 S PVV=PRV S:$G(ZAA02GVB) PVV=RES
 S IND=$S(ERR'="":"E",1:"G"),PVN=$S(PVNM'="":PVNM,1:" ")  
 S CNT=$ZP(^SORT($J,IND,PVN,""))+1
 S ^SORT($J,IND,PVN,CNT)=ENT_":"_DT_":"_PVV_":"_TM_":"_K_":"_K1_":"_DTNO_":"_ERR_":"_$P(S,":")
 I BATCH,IND="G" S CNT=$ZP(^SORT($J,"C",""))+1,^SORT($J,"C",CNT)=ENT_":"_DT_":"_PVV_":"_TM_":"_K_":"_K1_":"_DTNO_":"_ERR_":"_$P(S,":")
 Q
 ;
CHKADUP(K,K1,INS,DT) ;
 S K=$G(K),K1=$G(K1),DT=$G(DT),INS=$G(INS)
 I K=""!(K1="")!(DT="")!(INS="") Q ""
 N SW,DTNO,ELNO,S,T,REC,CNT
 S (SW,ELNO,S)="",DTNO=""
 F  S DTNO=$ZP(^ELG(1,K,K1,DTNO)) Q:DTNO=""  S T=$G(^(DTNO)) I $P(T,":",1)=INS&($P(T,":",8)=DT!($P(T,":",35)=DT)) Q
 I DTNO'="" S SW=$P($$STATUS^XELLS1(K,K1,DTNO),",",2)
 ;if response viewed allow to recreate a request if there is an error that the gate was closed and the request couldn't be processed at that moment
 ;I $E(SW)=4 D    
 I $E(SW)>2 D    
 .S ELNO=$O(^ELG(1,K,K1,DTNO,"")),CNT=""
 .I ELNO]"" F  S CNT=$O(^ELG(1,K,K1,DTNO,ELNO,CNT)) Q:CNT=""!(CNT="ACK")!(SW="")  D
 .. S REC=^(CNT)
 .. ;I $P(REC,":",1)="A",$P(REC,":",2)="AAA",$P(REC,":",5)=42 S SW=""
 .. I $P(REC,":",1)="A",$P(REC,":",2)="AAA" S SW=""
 Q SW
 ;
PARAM S PREVIEW=($P(S,":",3)="Y")
 S PRINT=$P(S,":",4)
 S PR=$P(S,":",5)
 S DTFRM=$$DG^IDATE($TR($P(S,":",6,8),":",""))
 S DTTHRU=$$DG^IDATE($TR($P(S,":",9,11),":",""))
 ;
 K PV
 S PV=$P(S,":",2)
 F I=11:1:19 S T=$P(S,":",I) S:T'="" PV(T)=""
 ;
AFILE   ;all insurances
 S (ERR,DTNO,S)=""
 K SI D FAI^XELFM10 I '$D(SI) D AFILE1 Q
 S I="" F  S I=$O(SI(I)) Q:I=""  I $P(SI(I),":",2)'="N" S ERR=$$INCHK^XELFM10($P(SI(I),":",3),K,K1,DT) D:ERR'="" AFILE1 D:ERR=""    
 .S GRPV=$$GRPV^XELFM1(K,$P(S,":",29))
 .I GRPV="" S ERR="Submission not defined in entity "_EZ D AFILE1 Q
 .I '$G(ZAA02GVB),GRPV="P",'$D(^PVG(PRV)) S ERR="Provider not defined" D AFILE1 Q
 .I PRV="",GRPV="P" S ERR="Resource not mapped to provider" D AFILE1 Q
 .S PVV=PRV S:GRPV="G" PVV=""
 .S ERR=$$PVCHK^XELFM1(PVV,$P(S,":",29)) I ERR'="" D AFILE1 Q
 .S ERR=$$CHKADUP(K,K1,$P(S,":",1),DT) I ERR'="" D AFILE1 Q
 .S $P(S,":",3)=$S($G(^ZAA02GVBUSER("CODE","DEFAULTS","ELIGTOS",0))'="":$P(^(0),"^"),1:30)
 .S $P(S,":",7)="S"
 .S $P(S,":",8)=DT,$P(S,":",35)=DT
 .I $$JUL^IDATE(DT)>+$H S $P(S,":",8)=$$DG^IDATE(+$H)
 .S INS=$P(S,":"),PS=$P(S,":",6),PAYER=$P(S,":",14)
 .S (OVRINS,OVRPY)="" I INS]"" S OVRD=$G(^ELG("INS",INS,EZ)) I OVRD]"" S OVRINS=$P(OVRD,":",2)
 .I OVRINS="",PS]"",INS]"",$D(^INIDPL(INS,PS)) S OVRD=^INIDPL(INS,PS),OVRPY=$S($P(OVRD,":",2)]"":$P(OVRD,":",2),1:$P(OVRD,":"))
 .S INS=$S(OVRINS]"":INS_"|"_OVRINS,1:INS),$P(S,":")=INS,PAYER=$S(OVRPY]"":OVRPY,1:PAYER),$P(S,":",14)=PAYER
 .I GRPV="G" S NPI="",TEZ=$G(^MSCG("ELIG","ENT",EZ),EZ) I $D(^ENNPI(TEZ)) D  I NPI]"" S $P(S,":",13)=NPI
 ..I PS]"",INS]"" S NPI=$G(^ENNPI(TEZ,INS,PS))
 ..I NPI="",PS]"" S NPI=$G(^ENNPI(TEZ,"*",PS))
 .D:'PREVIEW STR^XELFM(.DTNO,.ERR) S COUNTER=COUNTER+1 I ERR'="" D AFILE1 Q
 .I COUNTER>$S($D(^MSCG("ELG","LIMITCHGDT")):999999999999,1:999) S ERR="Limit exceeded for today" D AFILE1 Q
 .S DTNO=$$DG^IDATE(^TODAY)_"000"_$S($D(^MSCG("ELG","LIMITCHGDT")):"000000000",1:"")
 .D AFILE1
 ;
AFILE1 S PVV=PRV S:$G(ZAA02GVB) PVV=RES
 S IND=$S(ERR'="":"E",1:"G"),PVN=$S(PVNM'="":PVNM,1:" ")
 S CNT=$ZP(^SORT($J,IND,PVN,""))+1
 S ^SORT($J,IND,PVN,CNT)=ENT_":"_DT_":"_PVV_":"_TM_":"_K_":"_K1_":"_DTNO_":"_ERR_":"_$P(S,":")
 Q
 
