ZAA02GPST ;Place of Service Translation Report ;2018-06-13 14:18:23
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
 S PRG="ZAA02GPST"
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
 
 D HDR(.COL,FDEV)
 I PLCSEL="I"  S PLC="" F  S PLC=$O(PLCARR(PLC)) Q:PLC=""  D PLC(PLC)
 I PLCSEL'="I" D
 . S PLC="" F  S PLC=$O(^PSG(PLC)) Q:PLC=""  D
 .. I PLCSEL="A"!'$D(PLCARR(PLC)) D PLC(PLC)
 . Q
 S ENT="" F  S ENT=$O(ENT(ENT)) Q:ENT=""  D
 . S STATE=$P($G(^PRMG(ENT,1)),":",17)
 . I STATE'="" D
 .. S OTHENT=$G(^SORT($J,"ENT",STATE))
 .. I OTHENT D
 ... S GL=$NA(^SORT($J,"SRV"))
 ... F  S GL=$Q(@GL) Q:GL=""  Q:$QS(GL,1)'=$J  Q:$QS(GL,2)'="SRV"  D
 .... S PLC=$QS(GL,4)
 .... M ^SORT($J,"FAC",PLC,ENT)=^SORT($J,"FAC",PLC,OTHENT)
 ... Q
 .. I 'OTHENT D
 ... S ^SORT($J,"ENT",STATE)=ENT
 ... S FORM="" F  S FORM=$O(^PST(STATE,FORM)) Q:FORM=""  D
 .... I (FRMSEL="A")!(FRMSEL="I"&$D(FRMARR(FORM) ) )!(FRMSEL="E"&'$D(FRMARR(FORM) ) ) D
 ..... S PROG="" F  S PROG=$O(^PST(STATE,FORM,PROG)) Q:PROG=""  D
 ...... I (PRGSEL="A")!(PRGSEL="I"&$D(PRGARR(PROG) ) )!(PRGSEL="E"&'$D(PRGARR(PROG) ) ) D
 ....... S SRV="" F  S SRV=$O(^SORT($J,"SRV",SRV)) Q:SRV=""  D
 ........ S USRV=SRV
 ........ S FAC=$G(^PST(STATE,FORM,PROG,SRV))
 ........ I FAC="" D
 ......... S FAC=$G(^PST(STATE,FORM,PROG,0))
 ......... S USRV=0
 ......... Q
 ........ S PLC=""  F  S PLC=$O(^SORT($J,"SRV",SRV,PLC)) Q:PLC=""  D
 ......... S ^SORT($J,"FAC",PLC,ENT,FORM,PROG)=FAC_":"_USRV
 . Q
 S GL=$NA(^SORT($J,"FAC"))
 F  S GL=$Q(@GL) Q:GL=""  Q:$QS(GL,1)'=$J  Q:$QS(GL,2)'="FAC"  D PRINTLN(GL,FDEV,.COL)
 
 I PRREP W "Report written to '"_EXCELF_"'. Click 'Get File' to view."
 K ^SORT($J)
 Q
.
WRITEFIELDS
 S PRG="ZAA02GPST"
 S ^ZAA02GVBSYS("REPORT","FIELDS",PRG)="::1:::::1:::::1:2::4-3,5-4"
 D WRITEENT^REPUTIL(PRG,1)
 D WRITEPLACE^REPUTIL(PRG,2)
 D WRITEFILE^REPUTIL(PRG,3)
 D WRITEFORM^REPUTIL(PRG,4)
 D WRITEPROG^REPUTIL(PRG,5)
 S $P(^ZAA02GVBUSER("REPORT","DEFAULTS",PRG,0),":",6)=0
 Q
READFIELDS(s)
 D READENT^REPUTIL(s,1,OPZ,,,.ENT,.B) I B'="" Q
 D READPLACE^REPUTIL(s,2,.PLCSEL,,.PLCARR)
 D READFILE^REPUTIL(s,3,.EXCELF)
 D READFORM^REPUTIL(s,4,.FRMSEL,,.FRMARR)
 D READPROG^REPUTIL(s,5,.PRGSEL,,.PRGARR)
 S COMBINE=0
 Q
 
HDR(COL,FDEV)
 D addFields(
        .COL,
        "PLCCD",
        "PLC",
        "ENTCD",
        "ENT",
        "FORM#",
        "FORM",
        "PROGCD",
        "PROG",
        "FAC",
        "SRVCD",
        "SRV"
 )
 D writeExcel(
        $$setFields(
                "",
                .COL,
                "PLCCD",        "PlaceCd",
                "PLC",          "Place",
                "ENTCD",        "EntCd",
                "ENT",          "Entity",
                "FORM#",        "Form#",
                "FORM",         "Form",
                "PROGCD",       "Program",
                "PROG",         "ProgDesc",
                "FAC",          "Facility Type",
                "SRVCD",        "Service Type Code",
                "SRV",          "Service Type"
        ),
        FDEV
 )
 Q
 
PLC(PLC)
 N (PLC)
 S SRV=$P($G(^PSG(PLC)),":",8)
 I SRV="" S SRV=0
 S ^SORT($J,"SRV",SRV,PLC)=""
 Q
 
PRINTLN(GL,FDEV,COL)
 N (GL,FDEV,COL)
 S ENT=$QS(GL,4)
 S SRV=$P(@GL,":",2)
 S SRVDSC=""
 I SRV'="" D
 . S ST=$P($G(^PRMG(ENT,1)),":",17)
 . I ST'="" S SRVDSC=$G(^PST(1,ST,SRV))
 . Q
 D writeExcel(
        $$setFields(
                "",
                .COL,
                "PLCCD",        $QS(GL,3),
                "PLC",          $P($G(^PSG($QS(GL,3) ) ),":",2),
                "ENTCD",        ENT,
                "ENT",          $P($G(^PRMG(ENT,1)),":",2),
                "FORM#",        $QS(GL,5),
                "FORM",         $P($G(^SETFRMG($QS(GL,4),$QS(GL,5) ) ),":",2),
                "PROGCD",       $QS(GL,6),
                "PROG",         $P($G(^PRG($QS(GL,6) ) ),":",2),
                "FAC",          $P(@GL,":",1),
                "SRVCD",        SRV,
                "SRV",          SRVDSC
        ),
        FDEV
 )
 Q
.
addFields(vec,fields...)
 n (vec,fields)
 s vec=$g(vec)
 f i=1:1:$g(fields) d
 . s vec=vec+1
 . s vec(fields(i))=vec
 q
setFields(line,vec,fields...)
 n (line,vec,fields)
 f i=1:2:$g(fields) d setFld(.line,fields(i),fields(i+1))
 q line
setFld(result,fld,value)
 q:fld=""
 q:'$d(vec(fld))
 s $p(result,""",""",vec(fld))=value 
 q
writeExcel(RECLH,FDEV) ;
 S RECLH=""""_RECLH_""""
 N T,IO s T=$Y,IO=$I U FDEV W RECLH,! U IO S $Y=T 
 q
.
