ZAA01D02
	;
	;
	;
	Q
	;
OnBeforeGet(data)
	i $g(data("ACCESSION"))="" s %ZAUT1STATUS="0`Accession number is required [ACCESSION]" q
	i '$d(^PADEM(data("ACCESSION"))) s %ZAUT1STATUS="0`No patient demographics data for "_data("ACCESSION") q
	q
	;
Map
		 ; FieldName					Global		Delimiter  Piece	Index1		Index2		Index3
	 ; -------------------				------		---------  -----	------		------		------	
	 ; EntryStatus					^PADEM			^	     1		ACCESSION
	 ; ClientMnemonic				^PADEM			^	     2		ACCESSION	
	 ; RequisitionNumber				^PADEM			^	     8		ACCESSION	
	 ; MiniLogDateTime				^PADEM			^	     10		ACCESSION	
	 ; MiniLogInitials				^PADEM			^	     11		ACCESSION
	 ; CollectedDate				^PADEM			^	     12		ACCESSION		
	 ; CollectedTime				^PADEM			^	     13		ACCESSION	
	 ; PatientName					^PADEM			^	     14		ACCESSION	
	 ; RequestingPhysician				^PADEM			^	     15		ACCESSION	
	 ; Sex						^PADEM			^	     16		ACCESSION	
	 ; Age						^PADEM			^	     17		ACCESSION	
	 ; PID						^PADEM			^	     18		ACCESSION	
	 ; HospitalRoom					^PADEM			^	     19		ACCESSION	
	 ; LabReferenceNumber				^PADEM			^	     20		ACCESSION	
	 ; CollectionInformation			^PADEM			^	     21		ACCESSION	
	 ; Volume					^PADEM			^	     22		ACCESSION	
	 ; Fasting					^PADEM			^	     23		ACCESSION	
	 ; Species					^PADEM			^	     24		ACCESSION	
	 ; PatientStatus				^PADEM			^	     25		ACCESSION	
	 ; MaxiLogDateTime				^PADEM			^	     26		ACCESSION	
	 ; MaxiLogInitials				^PADEM			^	     27		ACCESSION	
	 ; MedicalRecordsNumber				^PADEM			^	     29		ACCESSION	
	 ; HistoryIdentificationNumber			^PADEM			^	     30		ACCESSION	
	 ; Notes					^PADEM			^	     1		ACCESSION	[1]
	 ; ReportingComments				^PADEM			^	     2		ACCESSION	[1]
	 ; NotesMessageText				^PADEM			NULL	 NULL	ACCESSION	[2]
	 ; ResponsiblePartyName				^PADEM			^		 1		ACCESSION	[2]
	 ; ResponsiblePartyAddressLine1			^PADEM			^		 2		ACCESSION	[2]
	 ; ResponsiblePartyAddressLine2			^PADEM			^		 3		ACCESSION	[2]
	 ; ResponsiblePartyAddressLine3			^PADEM			^		 4		ACCESSION	[2]
	 ; PhoneNumber					^PADEM			^	     5		ACCESSION	[2]
	 ; Diagnosis					^PADEM			^		 6		ACCESSION	[2]
	 ; MedicareNumber				^PADEM			^		 7		ACCESSION	[2]
	 ; SignatureDate				^PADEM			^		 8		ACCESSION	[2]
	 ; MedicaidNumber				^PADEM			^		 9		ACCESSION	[2]
	 ; MedicaidDoctorID				^PADEM			^		 10		ACCESSION	[2]
	 ; Relationship					^PADEM			^		 11		ACCESSION	[2]
	 ; BCBSInsured					^PADEM			^		 1		ACCESSION	[2]		[1]
	 ; BCBSContractNumber				^PADEM			^		 2		ACCESSION	[2]		[1]
	 ; BCBSGroupNumber				^PADEM			^		 3		ACCESSION	[2]		[1]
	 ; BCBSCoverageCode				^PADEM			^		 4		ACCESSION	[2]		[1]
	 ; Employer					^PADEM			^		 5		ACCESSION	[2]		[1]
	 ; InsurerCode					^PADEM			^		 6		ACCESSION	[2]		[1]
	 ; PolicyNumber					^PADEM			^		 7		ACCESSION	[2]		[1]
	 ; PrivateInsuranceGroupNumber			^PADEM			^		 8		ACCESSION	[2]		[1]
	 ; ICD9Codes					^PADEM			NULL	NULL	ACCESSION	[2]		[2]
	 ; FloorClient					^PADEM			^		1		ACCESSION	[3]
	 ; AdditionalReportToClients			^PADEM			^		2		ACCESSION	[3]
	 ; ClientRoute					^PADEM			^		3		ACCESSION	[3]
	 ; AutodialGroup				^PADEM			^		5		ACCESSION	[3]
	 ; ClientFlag					^PADEM			^		6		ACCESSION	[3]
	 ; ReportForm					^PADEM			^		7		ACCESSION	[3]
	 ; ReportBatches				^PADEM			NULL	NULL	ACCESSION	[3]
	 ; AutoDialLog					^PADEM			NULL	NULL	ACCESSION	[3.1]
	 ; Procedure					^PADEM			^		1		ACCESSION	[4]
	 ; TissueSubmitted1				^PADEM			^		2		ACCESSION	[4]
	 ; ProcPreOpDiagnosis				^PADEM			^		3		ACCESSION	[4]
	 ; LMB						^PADEM			^		1		ACCESSION	[4]		[1]
	 ; Surgeon					^PADEM			^		2		ACCESSION	[4]		[1]
	 ; TissueSubmitted2				^PADEM			^		3		ACCESSION	[4]		[1]
	 ; AutopsyAuthorizedBy				^PADEM			^		1		ACCESSION	[4]		[2]
	 ; RelationToPatient				^PADEM			^		2		ACCESSION	[4]		[2]
	 ; County					^PADEM			^		3		ACCESSION	[4]		[2]
	 ; DateAdmitted					^PADEM			^		4		ACCESSION	[4]		[2]
	 ; DateDied					^PADEM			^		5		ACCESSION	[4]		[2]
	 ; BodyIdentifiedBy				^PADEM			^		1		ACCESSION	[4]		[3]
	 ; PresentAtAutopsy1				^PADEM			^		2		ACCESSION	[4]		[3]
	 ; PresentAtAutopsy2				^PADEM			^		3		ACCESSION	[4]		[3]
	 ; Race						^PADEM			^		1		ACCESSION	[4]		[4]
	 ; Length					^PADEM			^		2		ACCESSION	[4]		[4]
	 ; Weight					^PADEM			^		3		ACCESSION	[4]		[4]
	 ; Circumcised					^PADEM			^		4		ACCESSION	[4]		[4]
	 ; Hair						^PADEM			^		5		ACCESSION	[4]		[4]
	 ; Beard					^PADEM			^		6		ACCESSION	[4]		[4]
	 ; Moustache					^PADEM			^		7		ACCESSION	[4]		[4]
	 ; Eyes						^PADEM			^		8		ACCESSION	[4]		[4]
	 ; RightPupil					^PADEM			^		9		ACCESSION	[4]		[4]
	 ; LeftPupil					^PADEM			^		10		ACCESSION	[4]		[4]
	 ; Rigor					^PADEM			^		1		ACCESSION	[4]		[5]
	 ; Jaw						^PADEM			^		2		ACCESSION	[4]		[5]
	 ; Neck						^PADEM			^		3		ACCESSION	[4]		[5]
	 ; Back						^PADEM			^		4		ACCESSION	[4]		[5]
	 ; Legs						^PADEM			^		5		ACCESSION	[4]		[5]
	 ; Arms						^PADEM			^		6		ACCESSION	[4]		[5]
	 ; Chest					^PADEM			^		7		ACCESSION	[4]		[5]
	 ; Abdomen					^PADEM			^		8		ACCESSION	[4]		[5]
	 ; Liver					^PADEM			^		9		ACCESSION	[4]		[5]
	 ; Anterior					^PADEM			^		10		ACCESSION	[4]		[5]
	 ; Posterior					^PADEM			^		11		ACCESSION	[4]		[5]
	 ; Lateral					^PADEM			^		12		ACCESSION	[4]		[5]
	 ; Regional					^PADEM			^		13		ACCESSION	[4]		[5]
	 ; BodyHeat					^PADEM			^		1		ACCESSION	[4]		[6]
	 ; ProbableCauseOfDeath1			^PADEM			^		2		ACCESSION	[4]		[6]
	 ; ProbableCauseOfDeath2			^PADEM			^		3		ACCESSION	[4]		[6]
	 ; InterestingCaseFlag				^PADEM			^		1		ACCESSION	[4]		[7]
	 ; FamilyID					^PADEM			^		2		ACCESSION	[4]		[7]
	 ; CaseStudyIDs					^PADEM			NULL	NULL	ACCESSION	[4]		[CS]
	;
	Q
OnAfterGet(data)
	ZK @data@("ReportBatches")
	Q
TestOne
	N A S A="IRCY07063826"
	K DATA
	S DATA("ACCESSION")=A
	W $$Get^ZAA($na(DATA),"PatientDemographics")
	Q
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