ZAA02GAUTOPOSTEXPORT ;Export Autopost screen ;2019-01-28 13:33:21;
 Q
 
FILEEXISTS(FILE) ;VB
 S $ZT="FILEEXISTSERROR"
 I $P(FILE,".",2)="" S $P(FILE,".",2)="CSV"
 I $D(^MSCG("ADDSUBDIR")) S FILE="claims"_$S($ZV["UNIX":"/",1:"\")_FILE
 Q ''$$EXIST^DFILE(FILE)
 
EXCEL(FILE) ;VB
 S $ZT="EXCELERROR"
 I $P(FILE,".",2)="" S $P(FILE,".",2)="CSV"
 I $D(^MSCG("ADDSUBDIR")) S FILE="claims"_$S($ZV["UNIX":"/",1:"\")_FILE
 S T=$$FOPEN^DFILE(FILE,"W","A")
 I T'=1 Q "Couldn't open file '"_FILE_"'."
 U FDEV
 W "Autopost: "_$G(^ZAA02GTVB($P(HANDLE,"/"),"AP","CURRSET","POSTING"))_" set",!
 W $$TABLEHDRTOCSV($G(^ZAA02GTVB($P(HANDLE,"/"),"AP","GRIDTOP") ) ),!
 S SUB="" F  S SUB=$O(^ZAA02GTVB($P(HANDLE,"/"),"AP","DATA",1,SUB)) Q:SUB=""  S TMP=^(SUB) D
 . S KEY=$P(TMP,"`",2)
 . I KEY'="" W $$TABLETOCSV($G(^ZAA02GTVB($P(HANDLE,"/"),"AP","FULLLINE",KEY) ) ),!
 . Q
 C FDEV
 Q 1
 
TABLEHDRTOCSV(LINE)
 ;Converts Premier table header to CSV
 N (LINE)
 S CSV=""""
 S L=$L(LINE,$C(9))
 F I=2:1:L D
 . S CELL=$P(LINE,$C(9),I)
 . S FMT=7
 . I CELL["^" S CELL=$P(CELL,"^",1),FMT=9
 . S CSV=CSV_$E(CELL,1,$L(CELL)-FMT)_""","""
 Q CSV_""""
 
TABLETOCSV(LINE)
 ;Converts Premier table row to CSV
 N (LINE)
 S CSV=""""
 S L=$L(LINE,$C(9))
 F I=2:1:L D
 . S CELL=$P(LINE,$C(9),I)
 . S CSV=CSV_$E(CELL,1,$L(CELL)-5)_""","""
 Q CSV_""""
.
FILEEXISTSERROR
 Q $ZE
 
EXCELERROR
 S $ZT=""
 I $G(FDEV)'="" C FDEV
 Q $ZE
 
.
