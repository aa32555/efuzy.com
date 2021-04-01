FUZNEW
	;
	;
	;
	Q
	;
FillModel(T,TYPE,ID)
	N A,M,V S A="" F  S A=$O(T("M",A)) Q:A=""  D
	. K V
	. S M=T("M",A,"model")
	. I $D(T("M",A,"data",M))>1 K T("M",A,"data",M) S T("M",A,"data",M)=""
	. M V=@%G@(TYPE,"DATA",ID,M)
	. M T("M",A,"data",M)=V
	. I $D(T("M",A,"data",M))>1 ZK T("M",A,"data",M)
	Q       
	; 
getModel(M,MD,Type,ID,OM)
	N D,O,T
	S D("data","type")=Type
	S D("data","id")=ID
	D getModelData(.D,.O)
	M T=O("data","model")
	N A S A="" F  S A=$O(T("M",A)) Q:A=""  S M(T("M",A,"model"))=A,MD(T("M",A,"model"))=A,OM(T("M",A,"model"))=T("M",A,"data",T("M",A,"model"))
	Q
	;
saveModel(MD,Type,OM)
	N D,O,T
	S D("data","type")=Type
	S D("data","id")=""
	D getModelData(.D,.O)
	M T=O("data","model")
	N A S A="" F  S A=$O(T("M",A)) Q:A=""  S M(T("M",A,"model"))=A
	N A S A=""  F  S A=$O(MD(A)) Q:A=""  S O("data","model","M",M(A),"data",A)=OM(A)
	N IN 
	M IN("data","model")=O("data","model","M")
	M IN("data","form")=O("data","model","F")
	S IN("data","type")=Type
	S IN("data","id")=OM("id")
	D saveModelData(.IN,.OUT)
	;
	Q       
	;       
	;
getModelData(D,O)
	N DATA M DATA=D("data")
	N PAGE S PAGE=$$ZCVT^SALON(DATA("type"),"U")
	I $T(@("onBeforeGetModel^"_PAGE))]"" D @("onBeforeGetModel^"_PAGE_"(.DATA)")
	N ID S ID=$G(DATA("id"))
	I ID]"",ID'="*",'$D(@%G@(PAGE,"DATA",ID)) s O("data","model","invalidID")="true" Q
	I ID]"",ID="*" S ID=""
	;
	N OUT
	D @("Model^"_PAGE_"(.OUT)")
	;
	I $G(ID)]"" D
	. I $T(@("FillModel^"_PAGE))]"" D @("FillModel^"_PAGE_"(.OUT,ID)")
	. E  D FillModel(.OUT,PAGE,ID)
	. s OUT("F","title")=OUT("F","editTitle")
	M O("data","model")=OUT
	Q
	;
getSimpleModelData(D,O)
	N DATA M DATA=D("data")
	N PAGE S PAGE=$$ZCVT^SALON(DATA("type"),"U")
	N ID S ID=$G(DATA("id"))
	N OUT
	D @("Model^"_PAGE_"(.OUT)")
	;
	I $G(ID)]"" D
	. I $T(@("FillModel^"_PAGE))]"" D @("FillModel^"_PAGE_"(.OUT,ID)")
	. E  D FillModel(.OUT,PAGE,ID)
	N MODEL,M,V
	N A S A="" F  S A=$O(OUT("M",A)) Q:A=""  D
	. K M,V
	. S M=OUT("M",A,"model")
	. I $D(OUT("M",A,"data",M))>1 M V=OUT("M",A,"data",M),MODEL(M)=V
	. E  S V=OUT("M",A,"data",M),MODEL(M)=V
	M O("data","model")=MODEL
	Q
	;
saveModelData(D,O)
	N ERROR S ERROR=""
	N DATA M DATA=D("data")
	N PAGE S PAGE=$$ZCVT^SALON(DATA("type"),"U")
	N MODE S MODE=""
	N FORM M FORM=DATA("form")
	I $T(@("onBeforeModelSave^"_PAGE))]"" D @("onBeforeModelSave^"_PAGE) I STATUS'="OK" Q
	N A,M,V,HOLDER,MODEL S A="" F  S A=$O(DATA("model",A)) Q:A=""  D
	. S M=DATA("model",A,"model") K V 
	. I DATA("model",A,"type")="computed" d @(DATA("model",A,"computed")_"(.DATA)")
	. I $D(DATA("model",A,"data",M))<10 S V=DATA("model",A,"data",M) S HOLDER(M)=V M MODEL(M)=DATA("model",A)
	. I $D(DATA("model",A,"data",M))>1 M V=DATA("model",A,"data",M) M HOLDER(M)=V  M MODEL(M)=DATA("model",A)
	. I $G(DATA("model",A,"rules","required"))="true" I ('$D(V)!$G(V)="") S ERROR=ERROR_$S(ERROR="":"",1:",")_M_" is required"
	. ;
	I '$D(MODEL) D Error^FUZ("Error on save. Empty Model!") Q
	I ERROR]"" D Error^FUZ(ERROR) Q
	I $G(HOLDER("id"))="*" S HOLDER("id")=""
	I $G(HOLDER("id"))="" S MODE="Created New" S HOLDER("id")=$I(@%G@(PAGE,"DATA","COUNTER"))
	E  S MODE="Updated"
	N TM,TC,A,IV,V,LT,TCU,TMU,IND
	S LT=$H
	S A="" F  S A=$O(MODEL(A)) Q:A=""  D
	. I $D(HOLDER(A))>1 Q
	. S IV=HOLDER(A)
	. S V=$G(@%G@(PAGE,"DATA",HOLDER("id"),A),"*")
	. I ($G(MODEL(A,"index"))="true") D
	.. I $G(MODEL(A,"transformOnIndex"))]"" D
	... S V=HOLDER(A)
	... S @$G(MODEL(A,"transformOnIndex")),IV=V
	... ;S V=$G(@%G@(PAGE,"DATA",HOLDER("id"),A),"*"),@$G(MODEL(A,"transformOnIndex"))
	.. i V]"" K @%G@(PAGE,"INDEX",A,V,HOLDER("id"))
	.. I IV]"" S @%G@(PAGE,"INDEX",A,IV,HOLDER("id"))="",@%G@(PAGE,"INDEX",A,IV)=HOLDER("id") S IND(A)=IV
	;
	S TC=$G(@%G@(PAGE,"DATA",HOLDER("id"),"created"))
	S TCU=$G(@%G@(PAGE,"DATA",HOLDER("id"),"createdUser"))  
	;
	I $D(FORM("multiIndex")) D
	. N A,IS,I,V,M,OV S A="" F  S A=$O(FORM("multiIndex",A)) Q:A=""  D
	.. S IS=FORM("multiIndex",A)
	.. S IV="",OV=""
	.. F I=1:1:$L(IS,":") S M=$P(IS,":",I) D
	...  ;_$S($G(IND(M))]"":IND(M),HOLDER(M)]"":HOLDER(M),1:"")
	... S V=$S($G(IND(M))]"":IND(M),HOLDER(M)]"":HOLDER(M),1:"")
	... ;I $G(MODEL(M,"transformOnIndex"))]"" S @$G(MODEL(M,"transformOnIndex"))
	... S IV=IV_$S(IV="":"",1:" ")_V
	... S OV=OV_$S(OV="":"",1:" ")_$S($G(@%G@(PAGE,"DATA",HOLDER("id"),M))]"":$G(@%G@(PAGE,"DATA",HOLDER("id"),M)),1:"")
	.. I OV]"" K @%G@(PAGE,"INDEX",IS,OV,HOLDER("id"))
	.. I IV]""  S @%G@(PAGE,"INDEX",IS,IV,HOLDER("id"))=""
	;
	K @%G@(PAGE,"DATA",HOLDER("id"))
	M @%G@(PAGE,"DATA",HOLDER("id"))=HOLDER
	; 
	S TM=LT
	S @%G@(PAGE,"MOD",$P(TM,","),$P(TM,",",2),HOLDER("id"))=%EMAIL
	S @%G@(PAGE,"ID-MOD",HOLDER("id"),$P(TM,","),$P(TM,",",2))=%EMAIL
	;
	S @%G@(PAGE,"DATA",HOLDER("id"),"modified")=TM
	S @%G@(PAGE,"DATA",HOLDER("id"),"userModified")=%EMAIL
	S @%G@(PAGE,"DATA",HOLDER("id"),"created")=TC
	S @%G@(PAGE,"DATA",HOLDER("id"),"userCreated")=TCU
	I MODE="Created New",TC="" D
	. S @%G@(PAGE,"DATA",HOLDER("id"),"created")=TM,@%G@(PAGE,"DATA",HOLDER("id"),"userCreated")=%EMAIL
	. S @%G@(PAGE,"ORDER",$O(@%G@(PAGE,"ORDER",""),-1)+1)=HOLDER("id")
	I MODE="Updated",TC="" I $$ADD^LOG("SYSTEM",LT,PAGE_" no date created on "_PAGE_" id:"_HOLDER("id")) 
	D
	. S @%G@(PAGE,"DATA",HOLDER("id"),"created")=TM
	. S @%G@(PAGE,"DATA",HOLDER("id"),"userCreated")=%EMAIL
	;
	N LID S LID=$$ADD^LOG(PAGE,LT,MODE_" client "_HOLDER("id")) I LID S @%G@(PAGE,"LOG",$P(TM,","),$P(TM,",",2))=LID
	I 'LID S ERROR="Error in creating log entry"
	I ERROR]"" D Error^FUZ(ERROR) Q
	I ERROR="" ;D Success^FUZ("Saved!") S O("data","status")="OK"
	m O("data","id")=@%G@(PAGE,"DATA",HOLDER("id"))
	S O("data","status")="OK"
	I $T(@("onAfterModelSave^"_PAGE))]"" D @("onAfterModelSave^"_PAGE)
	Q
	;
cycleModel(D,O)
	N DATA M DATA=D("data")
	N PAGE S PAGE=$$ZCVT^SALON(DATA("type"),"U")
	N ROUTINE S ROUTINE=DATA("routine")
	N MODEL M MODEL=DATA("model")
	N FORM M FORM=DATA("form")
	N OUT
	M OUT("M")=MODEL
	M OUT("F")=FORM
	D @(ROUTINE_"^"_PAGE_"(.OUT)")
	M O("data","model")=OUT("M")
	M O("data","form")=OUT("F")
	S O("data","status")="OK"
	Q
	;
EditRecord(D,O)
	;S O("dispatch","action")="app/showFUZListEditDialog"
	;S O("dispatch","data")=D("data","id")
	S O("dispatch","action")="app/changeRoute"
	S O("dispatch","data")="/"_$$ZCVT^SALON(D("data","type"),"l")_"/edit/"_D("data","id")
	Q
	;
ViewRecord(D,O)
	S O("dispatch","action")="app/changeRoute"
	S O("dispatch","data")="/"_$$ZCVT^SALON(D("data","type"),"l")_"/view/"_D("data","id")
	Q       
	;
DeleteRecord(D,O)
	S M="Are you sure you want to delete record "_D("data","id")_"? This cannot be undone!"
	S C="deleteRecord^FUZNEW"
	S DD("type")=D("data","type")
	S DD("id")=D("data","id")
	S L="Delete Client"
	D WarningWithCallBack^FUZ(M,C,.DD,L)
	Q
	;
deleteRecord(D,O)
	N DATA
	S TYPE=D("data","type")
	S ID=D("data","id")
	N A
	D getModelData(.D,.A)
	M D=A
	N ERROR S ERROR=""
	M DATA=D("data")
	N PAGE S PAGE=$$ZCVT^SALON(DATA("type"),"U")
	N MODE S MODE=""
	M FORM=DATA("model","F")
	k DATA("model","M"),DATA("model","F")
	m DATA("model")=A("data","model","M")
	N A,M,V,HOLDER,MODEL S A="" F  S A=$O(DATA("model",A)) Q:A=""  D
	. S M=DATA("model",A,"model") K V 
	. I DATA("model",A,"type")="computed" d @(DATA("model",A,"computed")_"(.DATA)")
	. I $D(DATA("model",A,"data",M))<10 S V=DATA("model",A,"data",M) S HOLDER(M)=V M MODEL(M)=DATA("model",A)
	. I $D(DATA("model",A,"data",M))>1 M V=DATA("model",A,"data",M) M HOLDER(M)=V  M MODEL(M)=DATA("model",A)
	. I $G(DATA("model",A,"rules","required"))="true",('$D(V)!$G(V)="") S ERROR=ERROR_$S(ERROR="":"",1:",")_M_" is required"
	. ;
	I '$D(MODEL) D Error^FUZ("Error on delete. Empty Model!") Q
	I ERROR]"" D Error^FUZ(ERROR) Q
	I $G(HOLDER("id"))="" D Error^FUZ("ERROR") Q
	S MODE="Deleted"
	N TM,TC,A,IV,V,LT,TCU,TMU,IND
	S LT=$ZTS
	S A="" F  S A=$O(MODEL(A)) Q:A=""  D
	. I $D(HOLDER(A))>1 Q
	. S IV=HOLDER(A)
	. S V=$G(@%G@(PAGE,"DATA",HOLDER("id"),A),"*")
	. I ($G(MODEL(A,"index"))="true") D
	.. I $G(MODEL(A,"transformOnIndex"))]"" D
	... S V=HOLDER(A)
	... S @$G(MODEL(A,"transformOnIndex")),IV=V
	... S V=$G(@%G@(PAGE,"DATA",HOLDER("id"),A),"*"),@$G(MODEL(A,"transformOnIndex"))
	.. i V]"" K @%G@(PAGE,"INDEX",A,V)
	.. I IV]"" K @%G@(PAGE,"INDEX",A,IV)
	;
	S TC=$G(@%G@(PAGE,"DATA",HOLDER("id"),"created"))
	S TCU=$G(@%G@(PAGE,"DATA",HOLDER("id"),"createdUser"))  
	;
	I $D(FORM("multiIndex")) D
	. N A,IS,I,V,M,OV S A="" F  S A=$O(FORM("multiIndex",A)) Q:A=""  D
	.. S IS=FORM("multiIndex",A)
	.. S IV="",OV=""
	.. F I=1:1:$L(IS,":") S M=$P(IS,":",I) D
	...  ;_$S($G(IND(M))]"":IND(M),HOLDER(M)]"":HOLDER(M),1:"")
	... S V=$S($G(IND(M))]"":IND(M),HOLDER(M)]"":HOLDER(M),1:"")
	... I $G(MODEL(M,"transformOnIndex"))]"" S @$G(MODEL(M,"transformOnIndex"))
	... S IV=IV_$S(IV="":"",1:" ")_V
	... S OV=OV_$S(OV="":"",1:" ")_$S($G(@%G@(PAGE,"DATA",HOLDER("id"),M))]"":$G(@%G@(PAGE,"DATA",HOLDER("id"),M)),1:"")
	.. I OV]"" K @%G@(PAGE,"INDEX",IS,OV)
	.. I IV]""  K @%G@(PAGE,"INDEX",IS,IV)
	; 
	S TM=LT
	N LID S LID=$$ADD^LOG(PAGE,LT,MODE_" client "_HOLDER("id")) I LID S @%G@(PAGE,"LOG",$P(TM,","),$P(TM,",",2))=LID
	I 'LID S ERROR="Error in creating log entry"
	I ERROR]"" D Error^FUZ(ERROR) Q
	I ERROR="" D Success^FUZ("Deleted!") S O("data","status")="OK"
	K @%G@(PAGE,"DATA",HOLDER("id"))
	S O("data","id")=HOLDER("id")
	S %J("dispatch","action")="list/refreshList"
	S %J("dispatch","data","type")=TYPE
	S %J("dispatch","data","routine")="TREE^"_TYPE  
	Q
	;
	;       
	;       
	;       
	;
	;