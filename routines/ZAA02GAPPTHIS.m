ZAA02GAPPTHIS ; Appointment History Report;2018-03-06 09:56:51
 ; ADS Corp. Copyright
 ;
VB
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
 S PRG="ZAA02GAPPTHIS"
 S Q="1"
 S S=""
 S s=$P(X,"|",7)
 S VAL=$P(X,"|",6)
 ;
 ; Dates
 S DTTYP=$P($P(s,":",1),"^")
 S DTF=$P($P($P(s,":",1),"^",2),",",1)
 S DTT=$P($P($P(s,":",1),"^",2),",",2)
 S (DTF,DTFJUL)=$ZDH(DTF,,,,,,,,"")
 S (DTT,DTTJUL)=$ZDH(DTT,,,,,,,,"")
 I DTF'="" S DTF=$ZD(DTF,8)
 I DTT'="" S DTT=$ZD(DTT,8)
 ;
 ; Create File
 S (EXCEL,EXCELF)="",EXCELP=$E($P(s,D1,2))
 S PRREP=1
 S $P(EXCEL,":",2)=1,EXCELF=$P($P(s,D1,2),D2,2) I $P(EXCELF,".",2)="" S $P(EXCELF,".",2)="CSV"
 I VAL="CHK" S B="EXCEL="_$S(EXCELF]"":"EXCEL"_$C(9)_EXCELF,1:"") Q
 I VAL'="RUN",VAL'="Q=1,R=6",EXCELF]"",$$EXIST^DFILE(EXCELF) S B="1|File '"_EXCELF_"' already exists.  Overwrite?|36|Report|6=1,7=0" Q
 S MODE="W"
 ;
 I VAL=""!(VAL="Q=1,R=6") S B="||RUN||" Q
 S T=$$FOPEN^DFILE(EXCELF,MODE,"A"),EXCEL=1 I T'=1 W:PRREP "Couldn't open file" Q
 ;
 K ^SORT($J)
 D getPos
 D EZ^ZAA02GVBAS
 D MOD(EZ,DTFJUL,DTTJUL)
 D CREATE(EZ,DTFJUL,DTTJUL)
 D PRINT(EZ,PEZ,DTFJUL,DTTJUL)
 I PRREP W "Report written to '"_EXCELF_"'. Click 'Get File' to view."
 K ^SORT($J)
 Q
 
MOD(EZ,DTFJUL,DTTJUL)
 N (EZ,DTFJUL,DTTJUL)
 S ID=""
 S END=""
 I DTTJUL'="" D
 . S DT=DTTJUL+1
 . S END=DT_","
 . F  S DT=$O(^ZAA02GSCH(EZ,"BOOK","DATE",DT),-1) Q:DT=""  S ID=$O(^ZAA02GSCH(EZ,"BOOK","DATE",DT,""),-1) I ID'="" Q
 . Q
 I DTTJUL'="",ID="" Q
 I ID'="" S ID=ID+1
 F  S ID=$O(^ZAA02GSCH(EZ,"CHG",ID),-1) Q:ID=""  D
 . I $O(^ZAA02GSCH(EZ,"CHG",ID,END),-1)>=DTFJUL S ^SORT($J,ID)=""
 Q
 
CREATE(EZ,DTFJUL,DTTJUL)
 N (EZ,DTFJUL,DTTJUL)
 S DT=DTFJUL-1
 F  S DT=$O(^ZAA02GSCH(EZ,"BOOK","DATE",DT)) Q:DT=""  Q:(DTTJUL'="")&(DT>DTTJUL)  D
 . S ID="" F  S ID=$O(^ZAA02GSCH(EZ,"BOOK","DATE",DT,ID)) Q:ID=""  S ^SORT($J,ID)=""
 Q
.
PRINT(EZ,PEZ,DTFJUL,DTTJUL)
 N (EZ,PEZ,DTFJUL,DTTJUL,vec,FDEV,PRREP,PR)
 S ID="" F  S ID=$O(^SORT($J,ID)) Q:ID=""  D
 . N APREC S APREC=$O(^ZAA02GSCH(PEZ,"SEQN",ID,""))
 . I APREC="" Q
 . S APREC=$P($G(@APREC),"|",11)
 . F I=1:1:$L(APREC,"`") S APREC(I)=$P(APREC,"`",I)
 . S FIRST=1
 . I DTTJUL="" D
 .. S DT="as of "_$$SUB^IDATE($$DG^IDATE(+$H),0)
 .. D OUT(DT,"","",.APREC,.APREC)
 .. S FIRST=0
 .. Q
 . S DTTM="" F  S DTTM=$O(^ZAA02GSCH(EZ,"CHG",ID,DTTM),-1) D  I DTTM="" Q
 .. I (DTTM<DTFJUL)!(DTTM="") D  Q
 ... S DT=$P(APREC(37),":",1)
 ... S TM=$TR($P(DT," ",2),"-",":")
 ... S DT=$P(DT," ",1)
 ... S OP=$P(APREC(36),":",1)
 ... I DTTM'="" D
 .... S DTTM=""
 .... I DTFJUL'="" D
 ..... S DT="as of "_$$SUB^IDATE($$DG^IDATE(DTFJUL),0)
 ..... S (TM,OP)=""
 .... Q
 ... D OUT(DT,TM,OP,.APREC,.APREC)
 ... Q
 .. N MCOLS
 .. S MOD=^ZAA02GSCH(EZ,"CHG",ID,DTTM)
 .. S OP=$P(MOD,"`",1)
 .. F I=2:1:$L(MOD,"`") D
 ... S CHG=$P(MOD,"`",I)
 ... I $P(CHG,";",1) S MCOLS($P(CHG,";",1))=$P(CHG,";",2)
 ... Q
 .. S DT=$P(DTTM,",",1)
 .. I (DTTJUL="")!(DT<=DTTJUL) D
 ... S TM=$P(DTTM,",",2)
 ... I FIRST D
 .... N DT S DT="as of "_$$SUB^IDATE($$DG^IDATE($S(DTTJUL:DTTJUL,1:+$H)),0)
 .... D OUT(DT,"","",.APREC,.APREC)
 .... S FIRST=0
 .... Q
 ... S DT=$$SUB^IDATE($$DG^IDATE(DT),0)
 ... S TM=$ZT(TM,1)
 ... D OUT(DT,TM,OP,.APREC,.MCOLS)
 ... Q
 .. M APREC=MCOLS
 .. Q
 . D writeExcel("")
 Q
 
OUT(DT,TM,OP,NDATA,MCOLS,COLS) ;Output old and new
 N I,II,B,LINE,PIECE,DLIM,OUT
 I '$D(COLS) S OUT=$$setFields("","DT",DT,"TM",TM,"OP",OP,"OPNM",$S(OP="":"",1:$P($G(^OPG(OP)),":",2) ) )
 S (B,L)="" F  S L=$O(MCOLS(L)) Q:L=""  S LINE=$T(APPCOL+L^ZAA02GVBASR20) I $P(LINE,";",3)]"" D
 . S PIECE=$P(LINE,";",2),FIELDS=$P(LINE,";",3),FRMTO=$P(LINE,";",4),FRMTN=$P(LINE,";",5)
 . S DLIM=$P(LINE,";",6),NUM=$P(LINE,";",7),DLIM2=$P(LINE,";",8),NUM2=$P(LINE,";",9)
 . S FIELDS2=$P(LINE,";",10),HEADER=$P(LINE,";",11)
 . I FRMTO]"",FRMTN="" S FRMTN=FRMTO
 . S MULTI=1 I 'NUM S NUM=1,DLIM="^",MULTI=0
 . S MULTI2=1 I 'NUM2 S NUM2=1,DLIM2="~",MULTI2=0
 . I NUM,DLIM="" S DLIM="^" D  S NDATA(L)=OD
 .. S (OD,ND)="" F I=1:1:NUM S $P(OD,"^",I)=$E(NDATA(L),I)
 . S DDLIM="" I $E(DLIM,1,3)="$C(" S DDLIM=$E(DLIM,4,($L(DLIM)-1))
 . S DDLIM=$S(DDLIM]"":$C(DDLIM),1:DLIM)
 . I NUM>1 S LO=$L(MCOLS(L),DDLIM)
 . F II=1:1:NUM D
 .. S FIELD=$P(FIELDS,DLIM,II) I FIELD]"" D
 ... I HEADER]"" S @HEADER I DEFHEAD]"" S FIELD=DEFHEAD 
 ... S DDLIM2="" I $E(DLIM2,1,3)="$C(" S DDLIM2=$E(DLIM2,4,($L(DLIM2)-1))
 ... S DDLIM2=$S(DDLIM2]"":$C(DDLIM2),1:DLIM2)
 ... I NUM2>1 S LO=$L($P(MCOLS(L),DDLIM,II),DDLIM2)
 ... F III=1:1:NUM2 D
 .... S FLD=FIELD_" "_$P(FIELDS2,DLIM2,III)
 .... S PIECE=PIECE_$S(MULTI:"-"_II,1:"")_$S(MULTI2:"-"_III,1:"") 
 .... I $D(COLS) S COLS(PIECE)=PIECE_"^"_FLD Q
 .... S X=$P($P(MCOLS(L),DDLIM,II),DDLIM2,III) S OLD=X
 .... S X=$P($P($G(NDATA(L)),DDLIM,II),DDLIM2,III) S NEW=X
 .... I FRMTN]"" S X=NEW,@FRMTN,NEW=X
 .... I FRMTO]"" S X=OLD,@FRMTO,OLD=X
 .... S:OLD="" OLD="Empty"  S:NEW="" NEW="Empty"
 .... I OLD=NEW,$G(MCOLS)="" Q
 .... S OUT=$$setFields(OUT,PIECE,NEW)
 . Q
 I '$D(COLS) D writeExcel(OUT)
 Q
   
APPT
 S LASTRES=$O(^ZAA02GSCH(PEZ,"PARAM","RES",""),-1)
 S RES="" F  S RES=$O(^ZAA02GSCH(EZ,"DET",RES)) Q:RES=""  Q:RES>LASTRES  D
 . S DT=DTF-1
 . F  S DT=$O(^ZAA02GSCH(EZ,"DET",RES,DT)) Q:DT=""  Q:(DTT'="")&(DT>DTT)  D
 .. S SLOT="" F  S SLOT=$O(^ZAA02GSCH(EZ,"DET",RES,DT,SLOT)) Q:SLOT=""  D
 ... S SUB="" F  S SUB=$O(^ZAA02GSCH(EZ,"DET",RES,DT,SLOT,SUB)) Q:SUB=""  D
 .... S ID=$P(^ZAA02GSCH(EZ,"DET",RES,DT,SLOT,SUB),"`",46)
 .... I ID="" Q
 .... I $D(^ZAA02GSCH(EZ,"CHG",ID)) S ^SORT($J,DT,ID)=""
 . Q
 Q
  
 
setFields(line,fields...)
        f i=1:2:$g(fields) d setFld(.line,fields(i),fields(i+1))
        q line
setFld(result,fld,value)
         q:fld=""
         q:'$d(vec(fld))
         s $p(result,""",""",vec(fld))=value 
         q
writeExcel(RECLH) ;
          S RECLH=""""_RECLH_""""
          N T s T=$Y U FDEV W RECLH,! S $Y=T U:PRREP PR
          q
getPos ; get the positions of the fields for excel
        N s,s1,i,t,idx
        k vec,recHdr
        s s(-1)="DT^Modification Date:TM^Modification Time:OP^Modified by code:OPNM^Modified by"
        f i=1:1:35,38:1 s line=$t(APPCOL+i^ZAA02GVBASR20) q:line=""  d
        . i $p(line,";",3)'="" s mcols($p(line,";",2))=""
        . q
        d OUT("","","",.mcols,.mcols,.s)
    s idx="",pos=1
        f  s idx=$o(s(idx)) q:idx=""  d
        .s s1=s(idx)
        .f i=1:1 q:$p(s1,":",i)=""  d  
                ..s t=$p(s1,":",i) 
                ..s vec($p(t,"^",1))=pos
                ..s pos=pos+1
                ..s $p(recHdr,""",""",vec($p(t,"^",1)))=$tr($p(t,"^",2),";",":")
        d writeExcel(recHdr)
        k s
        q
