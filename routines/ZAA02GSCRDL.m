ZAA02GSCRDL ;PG&A,ZAA02G-SCRIPT,2.10,DOWNLOAD OPTIONS;01NOV94  04:06;;;17APR2007  09:20
 ;Copyright (C) 1992, Patterson, Gray & Associates, Inc.
SETUP D DATE^ZAA02GSCRER S DATE=DT,TIME=TM
 W !!,"ZAA02G-SCRIPT DOWNLOAD OPTIONS",!!,"Enter download code - "
 R CODE,! Q:CODE=""  I '$D(^ZAA02GSCR("PARAM","DOWNLOAD",CODE)) W "CODE NOT FOUND" H 2 G SETUP
 D TSET
 W "Enter PASSWORD for code ",CODE," - " R P,! G:P'=PASS SETUP
 I DR="" R "Enter PROVIDER CODE(s) - ",DR,! G:DR="" SETUP
 R "Enter BEGINNING date (MM/DD/YY) - ",BEG,! G:BEG="" SETUP
 R "Enter ENDING date (MM/DD/YY) - ",END,! G:END="" SETUP
 D DR S FGLOB="^ZAA02GSCRDL("_$H_")",TYPE=""
 S CRLF=$C(13,10)
 S DT=$S($P(BEG,"/",3)<30:2000+$P(BEG,"/",3),1:$E($P(BEG,"/",3)+100,2,3))_$E(BEG+100,2,3)_$E($P(BEG,"/",2)+100,2,3),BEG=$S($D(@ZAA02GSCR@("DIR",98,DT)):^(DT),$O(^(DT)):^($O(^(DT))),1:@ZAA02GSCR@("PARAM","NEXT"))
 S DT=$S($P(END,"/",3)<30:2000+$P(END,"/",3),1:$E($P(END,"/",3)+100,2,3))_$E(END+100,2,3)_$E($P(END,"/",2)+100,2,3),END=$S($O(^(DT)):^($O(^(DT))),1:@ZAA02GSCR@("PARAM","NEXT"))
 W !!,"Searching documents from - ",BEG," to ",END,".  Wait..."
 S CT=0,JJ=1 D WR I CT=0 W !!,"NO REPORTS FOUND - press any key to exit",!! R J#1 G END
 W !!,CT," REPORTS FOUND",!!
 S @ZAA02GSCR@("PARAM","DOWNLOAD",CODE,"HIST",$H)=CT_" started"
 I RUN="" W !,"Make sure you select KERMIT for the download transfer",!!,"It will start momentarily - Start download on your computer",!! H 9
 I RUN'="" X RUN
 S GLOB="^ZAA02GKERMIT("_$H_")",@GLOB@(0,"FILE",1)=FGLOB,^(1,0)=FGLOB,MODEM=$I,(ER,SFL)=0,KP="" D SENDGLO^ZAA02GSENDD H 5 W !!,$S('$G(ER):"DOWNLOAD COMPLETED",1:"TOO MANY ERRORS - DOWNLOAD CANCELLED") H 5
 K @FGLOB S @ZAA02GSCR@("PARAM","DOWNLOAD",CODE,"HIST",$H)="ended with "_$S($G(ER)>0:"error: "_ER,1:"no")_" errors"
END K FORMAT,CODE,QT,PARAM,DATE,TIME,B,T,END,DT,D,C,ZC,ER,BEG,HD,DV Q
 ;
DR I DR="*" S EXE="WRA" Q  ; ALL RECORDS
 F J=1:1:$L(DR,",") S A=$P(DR,",",J) S:A]"" DR(A)=""
 S EXE="WRG"
 Q
 ;
WR S B=BEG F J=1:1 S B=$O(@ZAA02GSCR@("TRANS",B)) Q:B=""  Q:B>END  D @EXE
 Q
WRA ; GENERIC - SENDS ALL REPORTS
 Q:$D(@ZAA02GSCR@("TRANS",B,.011))#2=0  S D=$P(^(.011),"`",16,18) G WR3
 Q
WRG ; GENERIC - USES REFERRAL LIST & CC'S
WR2 Q:$D(@ZAA02GSCR@("TRANS",B,.011))#2=0  S D=$P(^(.011),"`",16,18) F J=1:1:3 S A=$P(D,"`",J) I A]"",$D(DR(A)) G WR3
 Q
WRC Q:$D(@ZAA02GSCR@("TRANS",B))#2=0  S D=$G(^(B,.011,"PROV")) Q:D=""  Q:'$D(DR(D))
WR3 K L S XS=$C(27),XSL=5 ; I $D(@ZAA02GSCR@("TRANS",B,.015)),$G(^(.015))'=TYPE S (TYPE,ZAA02G)=^(.015),ZAA02GWPD=$N(@ZAA02GSCR@("TRANS",B))  D REVERS^ZAA02GWPPC1
 S A1=$G(@ZAA02GSCR@("TRANS",B,.011)),(L(1),L(2))=""
 I $G(^(.011,"eS"))]"" S A=^("eS") Q:$E(A)="Y"  S A=$P(A,"\",2) I $P(A,"*")'="" S L(98)="Electronically signed - "_$P($G(^PVG($P(A,"*"))),":",2)_"  "_$$DTXY^ZAA02GSCRTI1($TR($P(A,"*",2),"-",","))
 ;
 ;   FORMAT:  txt/field#/var/mcode,record_#,segment_#,segment_size ;
 ;          txt=in quotes, field#=numeric, var=name, mcode="#"string
 I QT'="" F J=1:1:$L(FORMAT,";") S A=$P(FORMAT,";",J),$P(L($P(A,",",2)),QT,$P(A,",",3))=$$WRE
 I QT="" F J=1:1:$L(FORMAT,";") S A=$P(FORMAT,";",J),$P(L($P(A,",",2)),$C(1),$P(A,",",3))=$E($$WRE_$J("",50),1,$P(A,",",4))
 S @FGLOB@(JJ)=$TR(L(1),$C(1))_CRLF,@FGLOB@(JJ+1)=$TR(L(2),$C(1))_CRLF,JJ=JJ+2
 I 1 S C=.03,D=$O(@ZAA02GSCR@("TRANS",B,C)) Q:D=""  I ^(D)[$C(1) F  S C=$O(@ZAA02GSCR@("TRANS",B,C)) Q:C=""  S D=$P(^(C),$C(1),4) D:D[XS VID S @FGLOB@(JJ)=D_CRLF,JJ=JJ+1
 E  F J=1:1 S C=$O(@ZAA02GSCR@("TRANS",B,C)) Q:C=""  S D=^(C) D:D[XS VID S @FGLOB@(JJ)=D_CRLF,JJ=JJ+1
 F J=98,99 I $D(L(J)) S @FGLOB@(JJ)=$TR(L(J),$C(1))_CRLF,JJ=JJ+1
 S @FGLOB@(JJ)=$C(12),JJ=JJ+1,CT=CT+1 Q
 ;
WRE() Q $S(A>0:$P(A1,"`",+A),$E(A)="""":$TR($P(A,","),""""),$E(A)="#":$$XE(@$E($P(A,","),2,999)),1:$G(@ZAA02GSCR@("TRANS",B,.011,$P(A,","))))
XE(X) Q @X
VID F J=1:1:$L(D,XS) S D=$P(D,XS)_$E($P(D,XS,2,99),XSL,255)
 Q
TEST R "DOWNLOAD CODE - ",CODE Q:CODE=""   I '$D(^ZAA02GSCR("PARAM","DOWNLOAD",CODE)) W "  NOT FOUND",! G TEST
 D TSET R !,"STARTING AT DOC # ",B,!,"ENDING AT DOC # ",END,!
 S TYPE="",FGLOB="^ZAA02GSCRDL("_$H_")",JJ=1,CT=0,CRLF=$C(13,10) D DR
 S B=B-1 F  S B=$O(@ZAA02GSCR@("TRANS",B)) Q:B=""  Q:B>END  D @EXE
 K ZAA02G Q
TSET K DR S TITLE=^ZAA02GSCR("PARAM","DOWNLOAD",CODE) I $O(^(CODE,""))'="" S P="" F  S P=$O(^(P)) Q:P=""  I $D(^(P))#2 S @P=^(P)
 S ZAA02GSCR=$P(PARAM,";"),PASS=$P(PARAM,";",2),DR=$P(PARAM,";",3),QT=$P(PARAM,";",4),RUN=$P(PARAM,";",5),PATH=$P(PARAM,";",7),CR=$C(13,10) S:$P(PARAM,";",6)'="" CR="CR=$C("_$P(PARAM,";",6)_")",@CR
 S:QT'="" QT="QT=$C("_QT_")",@QT S EXE="WRG" S:QT=CR CR=""
 Q
XFR R "DOWNLOAD CODE - ",CODE Q:CODE=""   I '$D(^ZAA02GSCR("PARAM","DOWNLOAD",CODE)) W "  NOT FOUND",! G XFR
 D TSET R !,"STARTING AT DOC # ",BEG,!,"ENDING AT DOC # ",END,!
 R "Enter File Path ",PATH,! I PATH]"","\/"'[$E(PATH,$L(PATH)) S PATH=PATH_$S($zv["UNIX":"/",1:"\")
 R "Enter # or reports per file - ",SIZE,! S:SIZE<1 SIZE=1
 S (FO,DE)=0 I SIZE=1 R "Descriptive File Name (Y/N)-",DE,! S DE="Yy"[DE R "Year/Month Folder option (Y/N)-",FO,! S FO="Yy"[FO
 W "Please wait while transferring data....",! D XFR1 U 0 Q
XFRBK S SIZE=1,(DE,FO)=1,PATH="",CODE=15,BEG=1,END=99999999,$ZT="XRFERR^ZAA02GSCRDL" D TSET,XFR1 Q
XRFERR S ^ZAA02GSCR("PARAM","XFRBK")=$G(B)_"-"_$ZE Q
 ;
XFR1 S TYPE="",FGLOB="TEMP",JJ=1,CT=0,CRLF="",(LAST,FILE)=""  D DR
 S B=BEG-1 F  S B=$O(@ZAA02GSCR@("TRANS",B)) Q:B=""  Q:B>END  K TEMP D @EXE I $D(TEMP) D XFR2
 I FILE]"" C VDV
 K ZAA02G Q
XFR2 S FILX=(B\SIZE*SIZE+1),FILX=$S(FILX<BEG:BEG,1:FILX)
 I LAST'=FILX C:FILE]"" VDV W:0 FILE,! S FILE=""
 I FILE="" D
 . S FILE=PATH_FILX_".TXT",LAST=FILX
 . ; I DE S FILE=PATH_$TR($P(A1,"`",8,10)_"`"_$P(A1,"`",16),"/,` ","-___")_"_"_B_".TXT"
 . I DE S FILE=PATH_$S(FO:$$FO,1:"")_$TR($P(A1,"`",8,9)_"`"_B,"/,` *","-___")_".TXT"
 . I ^ZAA02G("OS")="M3" S VDV="FILE" O VDV:(FILE:"NW") Q
 . I ^ZAA02G("OS")="M11" S VDV=FILE O VDV:("NW") Q
 U VDV S ZC=$ZC Q:ZC  S A="" F  S A=$O(TEMP(A)) Q:A=""  W TEMP(A),!
 Q
FO() N X S X=$P(A1,"`",13) Q $P(X,"/",3)<50*100+1900+$P(X,"/",3)*100+X_$S(PATH["/":"/",1:"\")
PRINT(CODES,B) S SVDV=$G(VDV) I B["^ZAA02GWP" S B=$P($G(@B),"""",4) Q:B=""
 N:1 (CODES,B,SVDV)
 F LL=1:1:$L(CODES,",") S CODE=$P(CODES,",",LL) I CODE]"" D
 . S BEG=B,END=B,TYPE="",FGLOB="TEMP",JJ=1,CT=0,CRLF="",(LAST,FILE)=""  D TSET,DR
 . S SIZE=1,DE=1
 . K TEMP D @EXE I $D(TEMP) D XFR2
 . I FILE]"" C VDV
 . K ZAA02G Q
 I $G(SVDV)]"" U SVDV
 Q
