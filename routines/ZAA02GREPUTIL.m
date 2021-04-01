ZAA02GREPUTIL ;Common report utilities (fields global setup and input parsing, CSV file creation, etc);2018-08-22 14:55:02
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
 ; ENTLST       - pass by reference; will be set to ":"-separated list of entities to include in report
 ; ENT          - pass by reference; will be set to array of entities to include in report
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
 ;Service/Posting date range
WRITEDATE(PRG,FNO,TITLE)
 ;Parameters:
 ; TITLE (optional)     - field title; default "Dates"
 I $G(TITLE)="" S TITLE="Dates"
 S ^ZAA02GVBSYS("REPORT","FIELDS",PRG,FNO)=TITLE_"|Service:S?Posting:P|From:6:N:1:10:::"",""?Thru:6:N:1:10:::|??N?N^^?""^""?Y?N|"
 S $P(^ZAA02GVBUSER("REPORT","DEFAULTS",PRG,0),":",FNO)="S"
 Q
READDATE(INPUT,FNO,DTTYP,DTF,DTT)
 ;Parameters:
 ; DTTYP        - pass by reference; will be set to S for Service or P for Posting
 ; DTF          - pass by reference; will be set to start of date range (YYYYMMDD) or ""
 ; DTT          - pass by reference; will be set to end of date range (YYYYMMDD) or ""
 S DTTYP=$P($P(INPUT,":",FNO),"^",1)
 S DTF=$$DG^IDATE($P($P($P(INPUT,":",FNO),"^",2),",",1))
 S DTT=$$DG^IDATE($P($P($P(INPUT,":",FNO),"^",2),",",2))
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
 
 ;Yes/No selection
WRITEYESNO(PRG,FNO,TITLE,DEFAULT)
 ;Parameters:
 ; TITLE        - field title
 ; DEFAULT      - default value, 1 or 0 for Yes or No, respectively
 S ^ZAA02GVBSYS("REPORT","FIELDS",PRG,FNO)=TITLE_"|Yes:1?No:0||??N?N^^?""^""?Y?N|"
 S $P(^ZAA02GVBUSER("REPORT","DEFAULTS",PRG,0),":",FNO)=''DEFAULT
 Q
READYESNO(INPUT,FNO,ANS)
 ;Parameters
 ; ANS  - pass by reference; will be set to field value (1 for Yes, 0 for No)
 S ANS=$P(INPUT,":",FNO)
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
 
 ;Procedure Code All/Include/Exclude selection
WRITEPROC(PRG,FNO)
 D WRITEALLINCEXC(PRG,FNO,"Procedure Code","PC")
 Q
READPROC(INPUT,FNO,TYPE,LIST,ARRAY)
 D READALLINCEXC(INPUT,FNO,.TYPE,.LIST,.ARRAY)
 Q
 
 ;A/R Code All/Include/Exclude selection
WRITEAR(PRG,FNO)
 D WRITEALLINCEXC(PRG,FNO,"A/R Class","AR")
 Q
READAR(INPUT,FNO,TYPE,LIST,ARRAY)
 D READALLINCEXC(INPUT,FNO,.TYPE,.LIST,.ARRAY)
 Q
 
 ;Department Code All/Include/Exclude selection
WRITEDPT(PRG,FNO)
 D WRITEALLINCEXC(PRG,FNO,"Department","DP")
 Q
READDPT(INPUT,FNO,TYPE,LIST,ARRAY)
 D READALLINCEXC(INPUT,FNO,.TYPE,.LIST,.ARRAY)
 Q
.
 ;Provider Code All/Include/Exclude selection
WRITEPRV(PRG,FNO)
 D WRITEALLINCEXC(PRG,FNO,"Provider","PV")
 Q
READPRV(INPUT,FNO,TYPE,LIST,ARRAY)
 D READALLINCEXC(INPUT,FNO,.TYPE,.LIST,.ARRAY)
 Q
.
 ;2nd Provider Code All/Include/Exclude selection
WRITEPRV2(PRG,FNO)
 D WRITEALLINCEXC(PRG,FNO,"2nd Provider","PV")
 Q
READPRV2(INPUT,FNO,TYPE,LIST,ARRAY)
 D READALLINCEXC(INPUT,FNO,.TYPE,.LIST,.ARRAY)
 Q
.
 ;Referring Physician Code All/Include/Exclude selection
WRITEREF(PRG,FNO)
 D WRITEALLINCEXC(PRG,FNO,"Referring Physician","RF")
 Q
READREF(INPUT,FNO,TYPE,LIST,ARRAY)
 D READALLINCEXC(INPUT,FNO,.TYPE,.LIST,.ARRAY)
 Q
.
 ;2nd Referring Physician Code All/Include/Exclude selection
WRITEREF2(PRG,FNO)
 D WRITEALLINCEXC(PRG,FNO,"2nd Referring Physician","RF")
 Q
READREF2(INPUT,FNO,TYPE,LIST,ARRAY)
 D READALLINCEXC(INPUT,FNO,.TYPE,.LIST,.ARRAY)
 Q
.
 ;Place of Service Code All/Include/Exclude selection
WRITEPLACE(PRG,FNO)
 D WRITEALLINCEXC(PRG,FNO,"Place of Service","PS")
 Q
READPLACE(INPUT,FNO,TYPE,LIST,ARRAY)
 D READALLINCEXC(INPUT,FNO,.TYPE,.LIST,.ARRAY)
 Q
.
 ;Insurance Company Code All/Include/Exclude selection
WRITEINS(PRG,FNO)
 D WRITEALLINCEXC(PRG,FNO,"Insurance Company","IN")
 Q
READINS(INPUT,FNO,TYPE,LIST,ARRAY)
 D READALLINCEXC(INPUT,FNO,.TYPE,.LIST,.ARRAY)
 Q
.
 ;Attorney Code All/Include/Exclude selection
WRITEATT(PRG,FNO)
 D WRITEALLINCEXC(PRG,FNO,"Attorney","AT")
 Q
READATT(INPUT,FNO,TYPE,LIST,ARRAY)
 D READALLINCEXC(INPUT,FNO,.TYPE,.LIST,.ARRAY)
 Q
.
 ;State All/Include/Exclude selection
WRITESTATE(PRG,FNO)
 D WRITEALLINCEXC(PRG,FNO,"State","STATEOTH")
 Q
READSTATE(INPUT,FNO,TYPE,LIST,ARRAY)
 D READALLINCEXC(INPUT,FNO,.TYPE,.LIST,.ARRAY)
 Q
 
 ;Insurance Form All/Include/Exclude selection
WRITEFORM(PRG,FNO)
 D WRITEALLINCEXC(PRG,FNO,"Insurance Form","FORM")
 Q
READFORM(INPUT,FNO,SEL,LST,ARR)
 D READALLINCEXC(INPUT,FNO,.SEL,.LST,.ARR)
 Q
 
 ;Insurance Program All/Include/Exclude selection
WRITEPROG(PRG,FNO)
 D WRITEALLINCEXC(PRG,FNO,"Insurance Program","PRG")
 Q
READPROG(INPUT,FNO,SEL,LST,ARR)
 D READALLINCEXC(INPUT,FNO,.SEL,.LST,.ARR)
 Q
 
INCEXC(zARGS...)
 ;Returns 1/0 if value included/excluded by All/Include/Exclude filter. Multiple sets of values
 ;and filters can be passed. For example, if INCEXC(1,"I","ARRAY1",2,"E","ARRAY2) is called, it 
 ;will return 1 only if ARRAY1(1) is defined and ARRAY2(2) is not defined. To avoid naming conflicts
 ;all variable names used in this routine start with "z" followed by a capital letter.
 ;Parameters (passed in groups of three):
 ; zVAL - value
 ; zSEL - A, I, or E for All, Include, or Exclude, respectively
 ; zARR - an array reference storing the list of included or excluded values
 ;Returns: 1 if all values are included, 0 otherwise
 N zOK,zI,zVAL,zSEL,zARR
 S zARGS=$G(zARGS)
 S zOK=1
 F zI=1:1:zARGS\3 D  I 'zOK Q
 . S zVAL=zARGS(3*zI-2)
 . S zSEL=zARGS(3*zI-1)
 . S zARR=zARGS(3*zI)
 . I zSEL'="A" D
 .. I zVAL="",zSEL="I" S zOK=0 Q
 .. I zVAL'="" D
 ... I zSEL="I",'$D(@zARR@(zVAL)) S zOK=0 Q
 ... I zSEL="E",$D(@zARR@(zVAL)) S zOK=0
 Q zOK
 
setHeader(hdr,vec,fields...)
 q $$setHeaderArr(hdr,.vec,.fields)
setHeaderArr(hdr,vec,fields)
 n (hdr,vec,fields)
 s vec=$g(vec)
 f i=1:2:$g(fields) d
 . s vec=vec+1
 . s vec(fields(i))=$g(vec(fields(i) ) )_vec_","
 . s $p(hdr,""",""",vec)=fields(i+1)
 q hdr
addFields(vec,fields...)
 n (vec,fields)
 s vec=$g(vec)
 f i=1:1:$g(fields) d
 . s vec=vec+1
 . s vec(fields(i))=$g(vec(fields(i) ) )_vec_","
 q
setFields(line,vec,fields...)
 n (line,vec,fields)
 f i=1:2:$g(fields) d setFld(.line,fields(i),fields(i+1))
 q line
setFld(result,fld,value)
 n (result,fld,value,vec)
 q:fld=""
 q:'$d(vec(fld))
 f i=1:1 s pos=$p(vec(fld),",",i) q:pos=""  d
 . s $p(result,""",""",pos)=value 
 q
writeExcel(RECLH,FDEV) ;
 S RECLH=""""_RECLH_""""
 N T,IO s T=$Y,IO=$I U FDEV W RECLH,! U IO S $Y=T 
 q
.
