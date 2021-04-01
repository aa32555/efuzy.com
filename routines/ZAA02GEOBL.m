ZAA02GEOBL ; EOB LITE - personal payments;2017-09-19 09:55:09
 ; ADS Corp. Copyright
 Q
 ;
VB ; VB Interface
 S VAL=$P(X,"|",6)
 I VAL'="",VAL'="RUN",VAL'="Q=1,R=6",VAL'="CHK" S B="99|Invalid System Response|16|Report|1=0" Q
 S SYS=$$SYS^SET,CDIR=$$PATH^MNU2
 S LC="abcdefghijklmnopqrstuvwxyz",UC="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 S FORM=$P($P(P1,"!",3),":"),PROGRAM=$P(P1,"!")
 S RTN=$P(P1,"!"),OPTION=$P(P1,"!",2)
 S ^EZ($I)=EZ
 S PR=$P(X,"|",5) I PR="0",$I'[":" S PR=$I
 S OPZ=USER
 N HANDLE2,OP,OS,TCP,USER
 S ^TRMG($I)="VT200"
 S ^TRMG($I,1)="VT200:::::VT200"
 S ^OP($I)=OPZ
 S DATA=$P(X,"|",7),OPT=$P(DATA,":",2),MODE=$P(DATA,":",3)
 ;S ZAA02GVB("EXCELP")=+$P(DATA,":",13)
 ;I PROGRAM="MODNJCX",$P(^PRMG(EZ,1),":",17)="PA",OPT="P",MODE'="3",'$D(^MSCG("PACXRECON")) S B="99|Post and Print not Allowed|16|Reconciliation|1=0" Q
 S C1=$TR($P($P(DATA,":",4),"^",2),LC,UC) ;,C2=$TR($P($P(DATA,":",5),"^",2),LC,UC),C3=$TR($P($P(DATA,":",6),"^",2),LC,UC),C4=$TR($P($P(DATA,":",7),"^",2),LC,UC),C5=$TR($P($P(DATA,":",8),"^",2),LC,UC)
 ;S ENT=$P(DATA,":",9),PV=$P(DATA,":",10),SVDT=$P($P(DATA,":",11),"^",2)
 S SVDT=$P($P(DATA,":",5),"^",2)
 I SVDT S SVDT=$P(SVDT,"/",3)_$P(SVDT,"/")_$P(SVDT,"/",2) I $L(SVDT)=8 S SVDT=$E(SVDT,3,8)
 S PRINT=$P(DATA,":",12),DATA=$P(DATA,":")
 S PRINTER=PR
 S DONE=0,ZAA02GVB("VAL")=""
 F I="OPT","MODE","C1","SVDT","PRINTER","P1","DATA","VAL","RTN","OPTION","HANDLE" S ZAA02GVB(I)=@I
 S ZAA02GVB("FLAG")=0
 F COUNT=1:1 D  I DONE Q
 . S REC=$P(DATA,$C(230),COUNT)
 . I REC="" S DONE=1 Q
 . I $P(REC,$C(9),7)'=1 Q
 . K ^EISXICHK($J)
 . ;K ZAA02GVB("SELECTCK")
 . D  ;I $P(ZAA02GVB("P1"),"!")["X" D
 .. S ZAA02GVB("FLAG")=1
 .. S ZAA02GVB("COUNT")=COUNT
 .. ;S CHKS=$P(REC,$C(9),8)
 .. ;I CHKS]"",ZAA02GVB("VAL")="RUN" S ZAA02GVB("SELECTCK")=""  F CNT=1:1:$L(CHKS,$C(220)) S CHK=$P(CHKS,$C(220),CNT),PAYER=$G(^ZAA02GTVB(+ZAA02GVB("HANDLE"),"INS","RECON",+$P(REC,$C(9)),CHK)) S:PAYER]"" ^EISXICHK($J,PAYER,CHK)=""
 .. S ZAA02GVB("LAST")=0 I $P(^EOBL(EZ,+$P(REC,$C(9))),":",3)=1 S ZAA02GVB("LAST")=1
 .. S ZAA02GVB=$P(REC,$C(9))_":"_OPT
 .. K ZAA02GVB("RSP") I ZAA02GVB("VAL")="Q=1,R=6" S ZAA02GVB("RSP")="Y"
 .. S X12VER=$G(^X12VER(PROGRAM))
 .. S:X12VER TT=$ZU(20),TT=$ZU(20,"%SYS",TT)
 .. K (FORM,PROGRAM,NAME,CDIR,ZAA02GVB,OPZ) D ^SET
 .. S WRITEOFF=0
 .. D ^EOBL
 .. ;I 'SW D ^EOBL3
 .. ;D @$P(^PRG(ZAA02GVB("RTN"),ZAA02GVB("OPTION")),":",2)
 .. S T=$ZU(20,"")
 .. S COUNT=ZAA02GVB("COUNT"),DATA=ZAA02GVB("DATA"),HANDLE=ZAA02GVB("HANDLE")
 . S DONE=0
 S ID=99,MODE="16",OUT="",RSP="1=0"
 I $D(ZAA02GVB("msg")) D
 . S SUB=""
 . F  S SUB=$O(ZAA02GVB("msg",SUB)) Q:SUB=""  D
 .. S TMP=ZAA02GVB("msg",SUB),OUT=OUT_$S(OUT]"":$C(13,10),1:"")_TMP
 .. I $D(ZAA02GVB("msg",SUB,"mode")) S TMP=ZAA02GVB("msg",SUB,"mode"),ID=$P(TMP,":"),MODE=$P(TMP,":",2),RSP=$P(TMP,":",3) ;"6=1,7=0"
 S B=""
 I 'ZAA02GVB("FLAG") S OUT=OUT_$S(OUT]"":$C(13,10),1:"")_"No File selected.",B=ID_"|"_OUT_"|"_""_"|Reconciliation|1=0" Q
 S (EXCELF,FILES)=""
 ;I ZAA02GVB("EXCELP") D
 . F I=1:1 Q:$P(ZAA02GVB("DATA"),$C(230),I)=""  S FILES=$G(FILES)_+$P(ZAA02GVB("DATA"),$C(230),I)_" "
 . S FILES=$E($G(FILES),1,$L($G(FILES))-1)
 . S EXCELF="Recon "_EZ_" "_FORM_" "_$ZD(+$H,8)_" "_FILES_".csv"
 . I $D(^MSCG("ADDSUBDIR")) S EXCELF="claims"_$S($ZV["UNIX":"/",1:"\")_EXCELF
 . Q
 I ZAA02GVB("VAL")="CHK" S B="EXCEL="_$S(EXCELF]"":"EXCEL"_$C(9)_EXCELF,1:"") Q
 I ZAA02GVB("VAL")'="RUN",ZAA02GVB("VAL")'="Q=1,R=6",EXCELF]"",$$EXIST^DFILE(EXCELF) S B="1|File '"_EXCELF_"' already exists. Overwrite?|36|Report|6=1,7=0" Q
 I OUT]"",ZAA02GVB("OPT")'="P" S B=ID_"|"_OUT_"|"_MODE_"|Reconciliation|"_RSP
 I OUT]"",ZAA02GVB("OPT")="P",ZAA02GVB("VAL")'="RUN" S B=ID_"|"_OUT_"|"_$S(RSP="1=0":"RUN",1:MODE)_"|Reconciliation|"_RSP
 I B="",ZAA02GVB("OPT")="P",ZAA02GVB("VAL")'="RUN" S B="||RUN||"
 Q
 ;
msg(MSG,MODE) ; Message
 N TMP
 S TMP=$O(ZAA02GVB("msg",""),-1)+1
 S ZAA02GVB("msg",TMP)=MSG
 I $G(MODE)]"" S ZAA02GVB("msg",TMP,"mode")=MODE
 Q
