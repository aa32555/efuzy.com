ZAA01D01
	;
	;
	Q
	;
Map     ;
	; FieldName				Global	Delimiter	Piece		Index1		Index2 		 Index3
	; -------------------		------	---------	-----		------		------ 		------ 
	; AccessionNumber			^PACUS		NULL	  NULL		ACCESSION	[ACN]		SEQUENCE
	; Age						^PACUS		NULL	  NULL		ACCESSION	[AGE,DOB]	SEQUENCE
	; Bill						^PACUS		NULL	  NULL		ACCESSION	[BILL]		SEQUENCE
	; Breed    					^PACUS		NULL	  NULL		ACCESSION	[BREED]		SEQUENCE
	; MiniLogDate				^PACUS		NULL	  NULL		ACCESSION	[CDT]		SEQUENCE
	; ClientDR					^PACUS		NULL	  NULL		ACCESSION	[CLN]		SEQUENCE
	; Consol					^PACUS		NULL	  NULL		ACCESSION	[CONSOL]	SEQUENCE
	; Crit						^PACUS		NULL	  NULL		ACCESSION	[CRIT]		SEQUENCE
	; Mrn						^PACUS		NULL	  NULL		ACCESSION	[MRN]		SEQUENCE
	; Notes						^PACUS		NULL	  NULL		ACCESSION	[NOTES]		SEQUENCE
	; Pet						^PACUS		NULL	  NULL		ACCESSION	[PET]		SEQUENCE
	; Pid						^PACUS		NULL	  NULL		ACCESSION	[PID]		SEQUENCE
	; PatientName				^PACUS		NULL	  NULL		ACCESSION	[PN]		SEQUENCE
	; Recheck					^PACUS		NULL	  NULL		ACCESSION	[RECHECK]	SEQUENCE
	; RequisitionNumber			^PACUS		NULL	  NULL		ACCESSION	[RN]		SEQUENCE
	; RequisitionNotes			^PACUS		NULL	  NULL		ACCESSION	[RNOTES]	SEQUENCE
	; RequestingPhysician		^PACUS		NULL	  NULL		ACCESSION	[RPH]		SEQUENCE
	; Sex						^PACUS		NULL	  NULL		ACCESSION	[SEX]		SEQUENCE
	; Specimen					^PACUS		NULL	  NULL		ACCESSION	[SPE]		SEQUENCE
	; Tbtp						^PACUS		NULL	  NULL		ACCESSION	[TBTP]		SEQUENCE
	Q
	;
OnBeforeGet(data)
	i $g(data("ACCESSION"))="" s %ZAUT1STATUS="0`Accession number is required [ACCESSION]" q
	i '$d(^PACUS(data("ACCESSION"))) s %ZAUT1STATUS="0`No patient custom data for "_data("ACCESSION") q
	i '$g(data("SEQUENCE")),$g(data("SEQUENCE"))]"",$g(data("SEQUENCE"))'="*",$g(data("SEQUENCE"))'=0 d  q
	. s %ZAUT1STATUS="0`Sequence has to be either a number or empty [SEQUENCE]" q
	i $g(data("SEQUENCE"))=""  s data("SEQUENCE")="*"
	q
	;
OnAfterGet(data)
	I @data@("PARAMS","SEQUENCE")'="*" Q 
	N %ACC S %ACC=@data@("PARAMS","ACCESSION")
	N HS,GR S GR=$NA(^PACUS(%ACC)),HS=0
	F  S GR=$Q(@GR) Q:GR=""  Q:($QS(GR,0)'="^PACUS"!($QS(GR,1)'=%ACC))  D
	. I $QS(GR,3)>HS S HS=$QS(GR,3)
	N %DATA N I,ST
	F I=0:1:HS D
	. S %DATA(I,"SEQUENCE")=I
	. S %DATA(I,"ACCESSION")=%ACC
	. S ST=$$Get^ZAA($NA(%DATA(I)),"PatientCustomData") I 'ST S %ZAUT1STATUS=ST
	N A,KEY,S F I=0:1:HS D
	. S A="" F  S A=$O(%DATA(I,A)) Q:A=""  D
	.. I A="PARAMS" Q
	.. S KEY=$TR(^ZAA01G("MAP","DEF","RAW","PatientCustomData","Fields",A,"%I2"),"[]")
	.. I $D(^PACUS(%ACC,KEY,I)) S S(A)=$S($D(^PACUS(%ACC,KEY,I)):($S($G(S(A))]"":$G(S(A))_"^"_$G(^PACUS(%ACC,KEY,I)),1:$G(^PACUS(%ACC,KEY,I)))),1:"")
	K @data
	S A="" F  S A=$O(S(A)) Q:A=""  S @data@(A)=S(A)
	q
	;
tESTOne
	N A S A="IRCY07063826"
	K DATA
	S DATA("ACCESSION")=A
	w $$Get^ZAA($na(DATA),"PatientCustomData")
	Q
	;
TestMany
	N A,D,ST,CNTS,CNTF 
	S (CNTS,CNTF)=0
	S A="" F  S A=$O(^CUSTR(A)) Q:A=""  D
	. K D
	. S D("ACCESSION")=A
	. S ST=$$Get^ZAA($na(D),"PatientDemographics")
	. I ST S CNTS=CNTS+1
	. E   S CNTF=CNTF+1
	. W "  ACCESSION:"_(CNTF+CNTS)_"=>"_$J(CNTS,6," ")_"(Success) "_$J(CNTF,6," ")_"(Fail)"_$S('ST:$E(ST,1,30),1:""),!
	Q
	;