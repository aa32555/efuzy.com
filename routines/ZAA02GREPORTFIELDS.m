ZAA02GREPORTFIELDS ;Common report fields global setup and input parsing ;2018-05-23 14:44:11
 ; ADS Corp. Copyright
 
 ;WRITE*(PRG,FNO,other variables)
 ; Sets up global for field # FNO of report PRG
 ; Parameters:
 ;  PRG - report program of report being set up
 ;  FNO - field number of frame of report being set up
 ;  other variables described in individual subroutines
 
 ;READ*(INPUT,FNO,other variables)
 ; Parses input from field FNO
 ; Parameters:
 ;  INPUT       - Report input. Sixth "|"-separated piece of command, traditionally stored in variable "s".
 ;  FNO         - field number of field to parse
 ;  other variables described in individual subroutines
 Q
 
 ;Entity All/Include/Exclude selection
WRITEENT(PRG,FNO)
 S ^ZAA02GVBSYS("REPORT","FIELDS",PRG,FNO)="Entity|All:A?Include:I?Exclude:E|:1:Y:1:99::PRM^Entity:|A??N?N^^?""^""?Y?N|"
 S $P(^ZAA02GVBUSER("REPORT","DEFAULTS",PRG,0),":",FNO)="A"
 Q
READENT(INPUT,FNO,OPZ,SELENT,ENTLST,ENT,B)
 ;Parameters:
 ; OPZ          - operator running report
 ; SELENT       - pass by reference; will be set to A, I, or E for All, Include, or Exclude, respectively
 ; ENTLST       - pass by reference; will be set to ":"-separated list of entities included in report
 ; ENT          - pass by reference; will be set to array of entities included in report
 ; B            - pass by reference; will be set to error message if no entity included or user doesn't
 ;  have permission to view included entity
 S ENTERR=""
 S ENTLST=$TR($P($P(INPUT,":",FNO),"^",2),",",":")
 S SELENT=$E($P(INPUT,":",FNO))
 D ^OPENT
 I ENTERR'="" S B="1|"_ENTERR_"|16|Report Error|1=0" Q
 F I=1:1:$L(ENTLST,":") D
 . S TMP=$P(ENTLST,":",I)
 . I TMP]"",$D(^TRG(TMP)) S ENT(TMP)=""
 Q
.
 ;All/Include/Exclude code selection
WRITEALLINCEXC(PRG,FNO,NAME,LOOKUP)
 ;Parameters:
 ; NAME         - field name
 ; LOOKUP       - lookup code
 S ^ZAA02GVBSYS("REPORT","FIELDS",PRG,FNO)=NAME_"|All:A?Include:I?Exclude:E|:1:Y:1:99::"_LOOKUP_"^"_NAME_":|A??N?N^^?""^""?Y?N|"
 S $P(^ZAA02GVBUSER("REPORT","DEFAULTS",PRG,0),":",FNO)="A"
 Q
READALLINCEXC(INPUT,FNO,TYPE,LIST,ARRAY)
 ;Parameters
 ; TYPE         - pass by reference; will be set to A, I, or E for All, Include, or Exclude, respectively
 ; LIST         - pass by reference; will be set to ","-separated list of selected codes if TYPE is not A
 ; ARRAY        - pass by reference; will be set to array of selected codes if TYPE is not A
 S TYPE=$P($P(INPUT,":",FNO),"^",1)
 I TYPE'="A" D
 . S LIST=$P($P(INPUT,":",FNO),"^",2)
 . N L,I,CD
 . S L=$L(LIST,",")
 . F I=1:1:L D
 .. S CD=$P(LIST,",",I)
 .. I CD'="" S ARRAY(CD)=""
 Q
 
 ;Place of Service Code All/Include/Exclude selection
WRITEPLACE(PRG,FNO)
 D WRITEALLINCEXC(PRG,FNO,"Place of Service","PS")
 Q
READPLACE(INPUT,FNO,TYPE,LIST,ARRAY)
 D READALLINCEXC(INPUT,FNO,.TYPE,.LIST,.ARRAY)
 Q
 
 ;CSV file name
WRITEFILE(PRG,FNO)
 S ^ZAA02GVBSYS("REPORT","FIELDS",PRG,FNO)="Excel File||:1:Y:1:20:::|??N?N^^?""^""?Y?N|"
 S $P(^ZAA02GVBUSER("REPORT","DEFAULTS",PRG,0),":",FNO)=""
 Q
READFILE(INPUT,FNO,EXCELF)
 ;Parameters:
 ; EXCELF       - pass by reference; will be set to file name, with .CSV added if no extension
 ;Public variables:
 ; PRREP        - will be set to 1; if file is opened using FOPEN^DFILE, will be set to 0 if 
 ;  report is run in User Display
 S PRREP=1
 S EXCELF=$P($P(INPUT,":",FNO),"^",2) 
 I $P(EXCELF,".",2)="" S $P(EXCELF,".",2)="CSV"
 Q
.
