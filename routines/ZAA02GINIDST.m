ZAA02GINIDST ;Insurance Payor ID Mapping Codes Report ;2018-05-24 15:19:02
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
 S PRG="ZAA02GINIDST"
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
 
 D HDR(FDEV,.COL)
 I INSSEL="I" S INS="" F  S INS=$O(INSARR(INS)) Q:INS=""  D STLP(INS,STSEL,.STARR,.COL,FDEV)
 I INSSEL'="I" S INS="" F  S INS=$O(^INIDST(INS)) Q:INS=""  D
 . I INSSEL="A"!'$D(INSARR(INS)) D STLP(INS,STSEL,.STARR,.COL,FDEV)
 . Q
 
 I PRREP W "Report written to '"_EXCELF_"'. Click 'Get File' to view."
 K ^SORT($J)
 Q
 
WRITEFIELDS
 S PRG="ZAA02GINIDST"
 S ^ZAA02GVBSYS("REPORT","FIELDS",PRG)="::1:::::1:::::1:2::"
 D WRITEINIDST(PRG,1)
 D WRITESTATE^REPUTIL(PRG,2)
 D WRITEFILE^REPUTIL(PRG,3)
 S $P(^ZAA02GVBUSER("REPORT","DEFAULTS",PRG,0),":",4)=0
 Q
READFIELDS(s)
 D READINIDST(s,1,.INSSEL,,.INSARR)
 D READSTATE^REPUTIL(s,2,.STSEL,,.STARR)
 D READFILE^REPUTIL(s,3,.EXCELF)
 Q
 
WRITEINIDST(PRG,FNO)
 D WRITEALLINCEXC^REPUTIL(PRG,FNO,"Insurance","INIDST")
 Q
READINIDST(s,FNO,INSSEL,INSLIST,INSARR)
 D READALLINCEXC^REPUTIL(s,FNO,.INSSEL,.INSLIST,.INSARR)
 Q
.
HDR(FDEV,COL)
 D addFields^REPUTIL(
        .COL,
        "INSCD",
        "INS",
        "ST",
        1500,
        "UB",
        "DT",
        "OP"
 )
 D writeExcel^REPUTIL(
        $$setFields^REPUTIL(
                "",
                .COL,
                "INSCD",        "InsCd",
                "INS",          "Insurance",
                "ST",           "State",
                1500,           "1500",
                "UB",           "UB",
                "DT",           "Last modified date",
                "OP",           "Last modified op"
        ),
        FDEV
 )
 Q
 
STLP(INS,STSEL,STARR,COL,FDEV)
 N (INS,STSEL,STARR,COL,FDEV)
 S ST="" F  S ST=$O(^INIDST(INS,ST)) Q:ST=""  D
 . I (STSEL="A")!(ST="*")!(STSEL="I"&$D(STARR(ST) ) )!(STSEL="E"&'$D(STARR(ST) ) ) D
 .. D LINE(INS,ST,$G(^INIDST(INS,ST)),.COL,FDEV)
 Q
 
LINE(INS,ST,REC,COL,FDEV)
 N (INS,ST,REC,COL,FDEV)
 I ST="*" S ST="ALL"
 D writeExcel^REPUTIL(
        $$setFields^REPUTIL(
                "",
                .COL,
                "INSCD",        INS,
                "INS",          $P($G(^ING(INS)),":",2),
                "ST",           ST,
                1500,           $P(REC,":",1),
                "UB",           $P(REC,":",2),
                "DT",           $$SUB^IDATE($P(REC,":",3),0),
                "OP",           $P(REC,":",4)
        ),
        FDEV
 )
 Q
