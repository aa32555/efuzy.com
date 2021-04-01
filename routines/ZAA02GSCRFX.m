ZAA02GSCRFX ;PG&A,ZAA02G-SCRIPT,2.10,FAX OPERATIONS;7DEC94 2:39P;03DEC2008  09:39;;Wed, 28 Feb 2018  11:28
 ; ADS Corp. Copyright
 ;Copyright (C) 1993, Patterson, Gray & Associates, Inc.
 ;
PRINT ; AUTOFAX LOGIC FROM PRINT DRIVER
 N I,A,HD,FT,DELAY,DRVR,REC,D,S,R,COVER,USER,INP G:'$D(@ZAA02GSCR@("PARAM","FAX")) NOFAX K X
 G:$L($P(^("FAX"),"\",1,2),"Y")'=3 NOFAX S A=^("FAX"),DELAY=$P(A,"\",3) D DELAY
PRINT1 S DRVR=$P(A,"\",19),COVER=$P(A,"\",16) S:DRVR="" DRVR="ADS" D @DRVR
 Q
NOFAX K ^ZAA02GWP(.9,DP,XDC,"FAX") Q
 ;
ADS ; LOGIC SETUP AUTOFAX - FROM PRINT SIDE
 S SAF=$G(^ZAA02GSCR("PARAM","FAX-SUPPRESS-PRINT"))
 S Agn=$G(^ZAA02GSCR("PARAM","AUTO-FAX-AGAIN"))
 Q:'$D(^ZAA02GWP(.9,DP,XDC,"FAX"))  I $L($G(^("FAX")),"`")>4 S FAXPARAM=^("FAX") G ADS4
 G:$G(^("DIST"))?.P NOFAX K A S A=^("FAX"),(FM,FX,SU)=0
 I DOC'["TRANS" S X=A D FAXINFO Q:FAXTOF'?.E4N.E  Q:$L(FAXTOF,5)=8  S REC="" D ADS2 Q
 G:'$D(@DOC@(.011)) ADS0 S REC=^(.011)
 I $G(^(.011,"IO"))["F",'$G(Agn) S JBS=$P(^("IO"),"F",2),^ZAA02GWP(.9,DP,XDC,"FAX")="AutoFax: "_$S(+JBS:$$DT^ZAA02GSCRTR1(+JBS),1:"") G END
 I $G(^("IO"))["M",'$G(Agn) S JBS=$P(^("IO"),"M",2),^ZAA02GWP(.9,DP,XDC,"FAX")="AutoEmail: "_$S(+JBS:$$DT^ZAA02GSCRTR1(+JBS),1:"") G END
 I $G(^("IO"))["S",'$G(Agn) S JBS=$P(^("IO"),"S",2),^ZAA02GWP(.9,DP,XDC,"FAX")="Surescripts: "_$S(+JBS:$$DT^ZAA02GSCRTR1(+JBS),1:"") G END
 F I=1:1:$L(A,"\") S X=$P(A,"\",I) S:X]"" A(X)=""
 K X S (JBS,X)="",USER="AUTO" F I=1:1 S X=$O(A(X)) Q:X=""  D ADS1
 D:FX SETFAX D:FM SETMAIL D:SU SETSURE
ADS0 S:FX+FM ^ZAA02GWP(.9,DP,XDC,"FAX")=$S(FX:"AutoFax ",1:"")_$S(FM:"AutoEmail",1:"") D:FX+FM+SU=0 NOFAX
END K FX,JBS,FM,SU Q
 Q
ADS1 Q:X=""  D FAXINFO I AF,FAXTOF?.E4N.E I '$D(X(FAXTOF)) S X(FAXTOF)="" D ADS2
 I AM,EMAIL?1.E1"@"1.E D EMAIL
 I SU,SUREP]"" D SURES
 Q
ADS2 S FX=FX+1,D=$P(REC,"`",7),S=$P(REC,"`",6) S:S="" S=" " S:D="" D=" "
 S DEF=$G(^ZAA02GFAXC("DEFLTS")),FAXSUB=$P(REC,"`",8)
 S FAXPARAM=$G(FAXFROM)_" - "_S_"`"_$G(FAXN)_"`"_FAXSUB_"`"_FAXTO_"`"_FAXTOF_"``"_$S(DELAY:3,1:1)_"`"_DELAY_"`"_COVER_"```Y``"_$P(DEF,"\",6)_"```"_(+$P(DOC,""",""",2))_"``"_$G(PGS)
ADS4 N (FAX,RF,FAXPARAM,DP,XDC,ZAA02GWPD,ZAA02GSCR,INP,JOB,FAXN,FAXTO,FAXTOF,FAXFROM,FAXSUB,TITLE,USER,DT) G FAXHDS
 ;
SURES S SU=SU+1,D=$P(REC,"`",7),S=$P(REC,"`",6) S:S="" S=" " S:D="" D=" "
 S DEF=$G(^ZAA02GFAXC("DEFLTS")),FAXSUB=$P(REC,"`",8),FAXTOF="Surescripts:"_SUREP
 S FAXPARAM=$G(FAXFROM)_" - "_S_"`"_$G(FAXN)_"`"_FAXSUB_"`"_FAXTO_"`"_FAXTOF_"``"_$S(DELAY:3,1:1)_"`"_DELAY_"`"_COVER_"```Y``"_$P(DEF,"\",6)_"```"_(+$P(DOC,""",""",2))_"``"_$G(PGS)
ADS4 N (FAX,RF,FAXPARAM,DP,XDC,ZAA02GWPD,ZAA02GSCR,INP,JOB,FAXN,FAXTO,FAXTOF,FAXFROM,FAXSUB,TITLE,USER,DT) G FAXHDQ2
 ;
EMAIL S FM=FM+1,rX=X,D=$P(REC,"`",7),S=$P(REC,"`",6) S:S="" S=" " S:D="" D=" "
 S FAXPARAM=$G(FAXFROM)_" - "_S_"`"_$G(FAXN)_"`"_$P(REC,"`",8)_"`"_FAXTO_"`"_EMAIL_"``"_$S(DELAY:3,1:1)_"`"_DELAY_"`"_COVER_"```Y`````"_(+$P(DOC,""",""",2))_"``"_$G(PGS)
 S SAM=$G(^ZAA02GSCR("PARAM","EMAIL-SUPPRESS-PRINT"))
 N (FAX,RF,FAXPASS,FAXPARAM,DP,XDC,ZAA02GWPD,ZAA02GSCR,INP,JOB,FAXTO,FAXTOF,EMAIL,TITLE,USER,rX,EMAILT) D FAXHDS
 I $G(EMAIL)["@",$G(JOB),$D(^ZAA02GFAXQ("SRC",JOB)) D
 . S T=$G(EMAILT),T=$S(T="P":"pdf",T="F":"ftp",T="D":"ftp-pdf",T="X":"ftp-xml",1:"link")
 . S $P(^(JOB),",")=$H+$S(T="link":30,1:0),$P(^ZAA02GFAXQ("SRC",JOB),",",3,4)=T_","_$G(rX)_","_$P($G(FAXPARAM),"`",17)_","_$G(FAXPASS)_","_$C(1)_$G(^ZAA02GTFAX($J))_JOB
 . I T["ftp",T'["pdf" S ^ZAA02GFAXI(JOB,1,1)=$G(^ZAA02GFAXQ("SRC",JOB,1))
 Q
 ;
SETFAX ; INDICATE FAX PENDING
 S ^("IO")=$E($G(@DOC@(.011,"IO")),1,200)_",F*"_$G(JOB),K=$E($TR($P(@DOC,"`",13),"F~ ")_"F~  ",1,4),$P(@DOC,"`",13)=K,$P(@ZAA02GSCR@("DIR",99,10000000-$P(DOC,""",""",2)),"`",13)=K Q
 ;
SETSURE ; INDICATE SURESCRIPTS PENDING
 S ^("IO")=$E($G(@DOC@(.011,"IO")),1,200)_",S*"_$G(JOB),K=$E($TR($P(@DOC,"`",13),"S~ ")_"S~  ",1,4),$P(@DOC,"`",13)=K,$P(@ZAA02GSCR@("DIR",99,10000000-$P(DOC,""",""",2)),"`",13)=K Q
 ;
SETMAIL ; INDICATE MAIL PENDING
 S ^("IO")=$E($G(@DOC@(.011,"IO")),1,200)_",M*"_$G(JOB),K=$E($TR($P(@DOC,"`",13),"M~ ")_"M~  ",1,4),$P(@DOC,"`",13)=K,$P(@ZAA02GSCR@("DIR",99,10000000-$P(DOC,""",""",2)),"`",13)=K Q
 ;
DELAY Q:DELAY=""  I DELAY?1.N Q:+DELAY=0  S DELAY=DELAY+($P($H,",",2)\60)*60\90+($H*1000)
 E  D DELAY^ZAA02GSCRMS2 S DELAY=DELAY\90+($H*1000)
 Q
OTH ; FROM ZAA02GWPVB TO ADD HEADER & FOOTERS TO FAX
 S ZAA02GWPB=ZAA02GWPD N ZAA02GWPD S ZAA02GWPD=ZAA02GWPB
 ;
FAXAI ; FAX BY DEMAND - EITHER ZAA02G-VIEW OR ZAA02G-WRITER
 Q:ZAA02GWPD'["ZAA02GSCR"  D STATUS^ZAA02GSCRFX2 Q:X'=1
 K INP S DT="" D FETCH^ZAA02GSCRER
 K FAXPARAM,X,FAXSUB D FAXINFO,DIRECT^ZAA02GSCRFX2 Q:'$D(X)
 X "N (ZAA02G,ZAA02GP) S Y=""40,14\RHLW5\1\\\*,FAX QUEUED,*"" D ^ZAA02GPOP"
 F A="FAXTO","FAXFROM","FAXSUB" I $G(@A)="" S @A="-"
FAXAI1 D GETHD
 S HD=$P(A,"\",22),FT=$P(A,"\",23),HD1=$P(A,"\",24),FT1=$P(A,"\",25),CVR=$P(A,"\",26),DELAY=$P(A,"\",21) D DELAY
 S DEF=$G(^ZAA02GFAXC("DEFLTS"))
 I $G(FAXN)="" S A=$P($G(@ZAA02GWPD@(.011)),"`",6) I A]"" S A=$P($G(^PSG(A)),":",13) I A]"" S FAXN="TEL: "_A
 S FAXPARAM=$G(FAXFROM)_"`"_$S($G(FAXN)]"":FAXN,1:$P($G(^ZAA02GFAXC("FAX")),"\",3))_"`"_$G(FAXSUB)_"`"_FAXTO_"`"_FAXTOF_"`"_$G(FAXORG)_"`"_$S(DELAY:3,1:2)_"`"_DELAY_"`"_CVR_"```Y``"_$P(DEF,"\",6)_"```"_DOC_"``"_$G(PGS)
 I FAXTOF["@" ; S EMAIL=FAXTOF,EMAILT="P"  ; SET IN ZAA02GVBTER
 I $G(EMAIL)["@" S (HD,FT,HD1,FT1,CVR)=""
 I FAXTOF["Surescripts:" G FAXHDQ2
 D CP
 B  I $G(EMAIL)["@",$G(JOB),$G(EMAILT)]"",$D(^ZAA02GFAXQ("SRC",JOB)) D
 . S T=EMAILT,T=$S(T="P":"pdf",T="F":"ftp",T="D":"ftp-pdf",T="X":"ftp-xml",1:"link")
 . S A="" I "FDXP"[EMAILT S A=$G(CONSULT)
 . ; E  D UP S EMAIL=$TR(EMAIL,LC,UP),A="" F  S A=$O(^RFG(A)) Q:A=""  I $P(^(A),":",23)]"",$TR($P(^(A),":",23),LC,UP)=EMAIL Q
 . S $P(^ZAA02GFAXQ("SRC",JOB),",")=$H+$S(T="link":30,1:0),$P(^ZAA02GFAXQ("SRC",JOB),",",3,4)=T_","_A_","_$P($G(FAXPARAM),"`",17)_","_$G(FAXPASS)_","_$C(1)_$G(^ZAA02GTFAX($J))_JOB
 . I T["ftp",T'["pdf" S ^ZAA02GFAXI(JOB,1,1)=$G(^ZAA02GFAXQ("SRC",JOB,1))
 Q
 ;
GETHD I $D(SETHD) S A=SETHD Q
 S A=$S($D(@ZAA02GWPD@(.0115,5)):"FAXNEW",1:"FAX"),A=$G(@ZAA02GSCR@("PARAM",A),$G(@ZAA02GSCR@("PARAM","FAX")))
 Q
FAXHDS D GETHD S HD=$P(A,"\",4),FT=$P(A,"\",5),HD1=$P(A,"\",14),FT1=$P(A,"\",15),CVR=$P(A,"\",16)
 I FAXTOF["@",FAXTOF'["Surescripts:" S EMAIL=FAXTOF
 I $G(EMAIL)["@" S (HD,FT,HD1,FT1,CVR)=""
 S $P(FAXPARAM,"`",9)=CVR
CP I $D(@ZAA02GWPD@(.0115,5)) G FAXHDQ
 I $L($P($G(@ZAA02GWPD@(.03)),"\",13),"/")>2 S HD=$P(^(.03),"\",13),FT=$P(HD,"/",2),HD=$P(HD,"/"),(HD1,FT1)="",B=$G(@ZAA02GWPD),B=$O(@ZAA02GSCR@(106,B,.03)) S:B B=$P(^(B),$C(1),4),$P(FAXPARAM,"`",3)=B S $P(FAXPARAM,"`",7,8)="1`"
 S HD=$P(HD,"/") ; G:$G(HD)_$G(FT)_$G(HD1)_$G(FT1)="" FAXHDQ
 S ZAA02GWPB=ZAA02GWPD S:$D(ZAA02GSCR) VDOC=ZAA02GSCR_"(""TRANS"","_(+$P($NA(@ZAA02GWPB),",",2))_",.011)",PGP=0 N ZAA02GWPD
 I HD["*" S HD=$P(HD,"*")_$G(INP("SITEC"))_$P(HD,"*",2,9)
 K B,D S ZAA02GWPD="^ZAA02GTFAX($J)",SUB=$S(ZAA02GWPB["ZAA02GSCR":$P(ZAA02GWPB,")")_",.011)",$D(DP):"^ZAA02GWP(.9,DP,XDC)",1:"") K @ZAA02GWPD S @ZAA02GWPD=ZAA02GWPB_";"_SUB
 S LN=$S($G(CVR)="P":19,1:0),A=^ZAA02GFAXC("CONFIG"),LNG=$P(A,"\",6)-$P(A,"\",4)*6-5 I FT1]"" S K=$O(@ZAA02GSCR@(110,FT1,.03)) F J=1:1 S K=$O(^(K)) Q:K=""  S LNG=LNG-1
 S B="",A=0,C=10,(INP("PG"),INP("APN"))=1 F J=1:1 S A=$O(@ZAA02GWPB@(A)) Q:A=""  Q:A>.03  S D=$D(^(A)) S:D#2 @ZAA02GWPD@(A)=^(A)
 I HD]"" S REP=HD D CP1 D:C>10 CP4 S INP("APN")=1
 S E=.03 D CP0
FAXHDQ I $D(@ZAA02GWPD@(.0115,5)) D
 . I $G(DOC)<1  S:ZAA02GWPD["ZAA02GSCR" DOC=+$TR($P(ZAA02GWPD,",",2),"""") S:ZAA02GWPD["DOC" DOC=+$G(@ZAA02GWPD)
 . S VIEW=$S($G(VIEW)>3:VIEW,1:2),TRANS=$P($G(@ZAA02GWPD@(.011)),"`",5) S:$G(USER)="" USER=TRANS D UP,PARAMS^ZAA02GSCRPW K ^ZAA02GTFAX($J)
 . I HD["*" S HD=$P(HD,"*")_$G(INP("SITEC"))_$P(HD,"*",2,9)
 . I FT["*" S FT=$P(FT,"*")_$G(INP("SITEC"))_$P(FT,"*",2,9)
 . I $TR(CVR,"YP")'=CVR,VIEW<3,$G(EMAIL)="" D
 .. S $P(FAXPARAM,"`",9)=$TR(CVR,"YNP","ynp")
 .. I HD]"",$G(^ZAA02GSCR(110,HD,.0115,5))]"" N ZAA02GWPD S ZAA02GWPD="^ZAA02GSCR(110,"""_HD_""")" D ORTF^ZAA02GVBTER,FILL^ZAA02GVBTER,FILL Q
 .. D MEDFAXH D FILL^ZAA02GVBTER,FILL
 . S HD=$G(FT),FT="" I HD]"" D
 .. I $D(^ZAA02GSCR("PARAM","LETTERHEAD",HD)) S HD="//"_HD Q
 .. I $D(^ZAA02GSCR(110,HD)) S HD="//"_HD Q
 D  Q
 . D DOCMNT
 . S ZAA02GWPB=ZAA02GWPD N ZAA02GWPD S ZAA02GWPD="^ZAA02GTFAX($J)"
 . D FAXHDQ2 ; here because of NEW
FAXHDQ2 Q:$G(QUITQ)  I $G(@ZAA02GSCR@("PARAM","FAXPARAM"))]"" X ^("FAXPARAM")
 K ZAA02GWPC,VAR,D,B,BT,HD,FT,LNG,E,A,C,REP,CVR,HD1,FT1 I $D(FAXPARAM) D QUEUE^ZAA02GFAXQ  ; I $G(ZAA02GWPD)["^ZAA02GTFAX" K @ZAA02GWPD
 Q
 ;
EXTRA I $G(EMAIL)]"" D
 . ; I $D(^ZAA02GSCR(110,"EMAIL",.0156)) S HD="/EMAIL"
 . I "PFDX"[EMAILT D DOCMNT
 . I "PFDX"'[EMAILT D  Q
 .. S B="" D ZAA02GGETTX^ZAA02GVBTER1
 .. I EMAILT="T" D
 ... S ^ZAA02GTFAX($J,1)="<PRE>"
 ... S A=.03 F J=2:1 S A=$O(@ZAA02GWPD@(A)) Q:A=""   S C=$P(^(A),$C(1),4) D:$TR(C,$C(27,255))'=C VID^ZAA02GVBW2 S ^ZAA02GTFAX($J,J)=C
 ... S ^ZAA02GTFAX($J,J+1)="<PRE>" Q
 .. I EMAILT="H" D
 ... S B="<HTML><BODY>"
 ... S A=.03 F  S A=$O(@ZAA02GWPD@(A)) Q:A=""   S C=$P(^(A),$C(1),4) D:$TR(C,$C(27,255))'=C VID^ZAA02GVBW2 S B=B_" "_C S:C?.P B=B_"<p>"
 ... S B=B_"</BODY></HTML>"
 ... S E=$O(^ZAA02GTFAX($J,""),-1)+1 F J=1:126:$L(B) S ^ZAA02GTFAX($J,E)=$E(B,J,J+125),E=E+1
 Q
 ;
DOCMNT I "FDX"[$G(EMAILT,"?") D  Q
 . K OUTPUT
 . I EMAILT="F" D HL7^ZAA02GVBW9X
 . I EMAILT="X" D
 .. D ZAA02GGETTX^ZAA02GVBTER1
 .. S LINE=$G(@ZAA02GWPD@(.011))
 .. S A="<?xml version='1.0'?><XMLData>"
 .. S A=A_"<job>"_DOC_"</job><dos>"_$P(LINE,"`",12)_"</dos><study>"_$P(LINE,"`")_"</study><name>"_$P(LINE,"`",8)_"</name><mrec>"_$P(LINE,"`",9)_"</mrec><dob>"_$P(LINE,"`",10)_"</dob><report>"
 .. S OUTPUT(1)=A,D=2
 .. S A=.03 F  S A=$O(@ZAA02GWPD@(A)) Q:A=""   S C=$P(^(A),$C(1),4) D:$TR(C,$C(27,255))'=C VID^ZAA02GVBW9 S OUTPUT(D)="<line>"_C_"</line>",D=D+1
 .. S OUTPUT(D)="</report></XMLData>" Q
 . S HDR="",B=$TR(EMAIL,"@","*") F J=3,4,1,2,5 S HDR=HDR_$C(9)_$P(B,"*",J)
 . S HDR=HDR_$C(9)_$G(^ZAA02GVBUSER("LOCAL-IP"))_$C(9)_$G(^ZAA02GVBUSER("PORT"),"5012")_$C(9)_"Job:"
 . S ^ZAA02GTFAX($J)=$E(HDR,2,9999)
 . S (Y,B)="" F  S B=$O(OUTPUT(B)) Q:B=""  S Y=Y_OUTPUT(B)_$C(13,10)
 . I Y]"" S ^ZAA02GTFAX($J,1)=Y
 . I EMAILT="D" D DOCM2
 ;
DOCM2 I DOC="LETTER" D  D FILL Q
 . S B=$G(B) I $D(@ZAA02GWPD@(.0115,5)) D GETRTF^ZAA02GVBTER
 . E  D ASCIIRTF^ZAA02GVBTER
 S MPRINT=1 D ORTF^ZAA02GVBTER I $G(FT1)]"",$D(^ZAA02GSCR(110,FT1,.0156)) S B=$E(B,1,$L(B)-1)_$G(^(.0156))_"}"
 D FILL
 Q
FILL S B=$TR(B,$C(13,10)),E=$O(^ZAA02GTFAX($J,""),-1)+1,L=$P(B,$C(200,202,201)) F J=1:500:$L(L) S ^ZAA02GTFAX($J,E)=$E(L,J,J+499),E=E+1
 I $G(Br)]""  S L=Br F  S L=$O(@Brd@(L)) Q:L=""  Q:$G(Bre)=L  S ^ZAA02GTFAX($J,E)=@Brd@(L),E=E+1
 S Bcl="" F  S Bcl=$O(Bc(Bcl)) Q:Bcl=""  S L=Bc(Bcl) F J=1:500:$L(L) S ^ZAA02GTFAX($J,E)=$E(L,J,J+499),E=E+1
 I '$D(Bc2) S B=$P(B,$C(200,202,201),2,9) F J=1:500:$L(B) S ^ZAA02GTFAX($J,E)=$E(B,J,J+499),E=E+1
 E  D
 . N C S C=$P(B,$C(200,202,201),3,99),B=$P(B,$C(200,202,201),2) F J=1:500:$L(B) S ^ZAA02GTFAX($J,E)=$E(B,J,J+499),E=E+1
 . S Bcl="" F  S Bcl=$O(Bc2(Bcl)) Q:Bcl=""  S L=Bc2(Bcl) F J=1:500:$L(L) S ^ZAA02GTFAX($J,E)=$E(L,J,J+499),E=E+1
 . F J=1:500:$L(C) S ^ZAA02GTFAX($J,E)=$E(C,J,J+499),E=E+1
 K Bcl,Bc,Bc2,Br,Bre,Brd
 Q
MEDFAXH S B="" D HEAD^ZAA02GVBTER,HEAD2^ZAA02GVBTER
 S B=B_$P($T(MEDFAXHD),";",2)_$P($T(MEDFAXHD+1),";",2)_$P($T(MEDFAXHD+2),";",2)_$P($T(MEDFAXHD+3),";",2) D HEAD3^ZAA02GVBTER Q
 ; \box
MEDFAXHD ;\plain\f0\fs48\pard\box
 ;                   Facsimile   Message
 ;\par\pard\fs1\par\tx1500\tx3000\box\f0\fs24\line
 ;\tab From:\tab ~$FAXFROM\line\tab\tab ~$FAXN\line\tab To:\tab ~$FAXTO\line\tab Date:\tab ~$DT\line\tab Subject:\tab ~$FAXSUB \line\par\pard
 ;
CP0 F J=1:1 S E=$O(@ZAA02GWPB@(E)) Q:E=""  I ^(E)'["~P" S C=C+100,LN=LN+1,@ZAA02GWPD@(C)=C-100_$C(1,1,1)_$$STRIP($P(^(E),$C(1),4)) I LN>LNG Q
 I E="",FT]"" S REP=FT D CP4,CP1
 I FT1]"" S REP=FT1 X "F LN=LN:0:LNG+1 D CP4" D CP1
 I E'="" S LN=0,C=C+100,@ZAA02GWPD@(C)=C-100_$C(1,1,1)_"~PF",INP("APN")=INP("APN")+1,INP("PG")=INP("PG")+1 I HD1]"" S REP=HD1 D CP1,CP4
 G:E'="" CP0 I $D(SAVPAG),$D(@ZAA02GWPD@(SAVPAG)) S ^(SAVPAG)=$P(^(SAVPAG),"$P")_$G(INP("PG"))_$P(^(SAVPAG),"$P",2,9) K SAVPAG
 Q
UP S UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ",LC="abcdefghijklmnopqrstuvwxyz" Q
STRIP(X) Q:X'["~C" X Q $P(X,"~C")_"  "_$P(X,"~C",2,9)
CP1 K VAR S K="" D:$D(UP)+$D(LC)'=2 UP
 F J=1:1 S K=$O(@ZAA02GSCR@(110,REP,0,K)) Q:K=""  S L=$D(^(K,0)),L="" F J=1:1 S L=$O(^(L)) Q:L=""  S VAR(L)=K_","_$G(VAR(L))
 S A=$O(@ZAA02GSCR@(110,REP,.03)) F J=1:1 S A=$O(@ZAA02GSCR@(110,REP,A)) Q:A=""  S LN=LN+1,C=C+100,@ZAA02GWPD@(C)=C-100_$C(1,1,1)_$P(^(A),$C(1),4) S:^(C)["~P" LN=0,INP("APN")=INP("APN")+1,INP("PG")=INP("PG")+1 I $D(VAR(A)) D CP2
 Q
CP4 S LN=LN+1,C=C+100,@ZAA02GWPD@(C)=C-100_$C(1,1,1) Q
CP2 S L=@ZAA02GWPD@(C) F K=1:1:$L(VAR(A),",") S D=$P(VAR(A),",",K) I D'="" D CP3,F1^ZAA02GSCRER1
 I $P(L,$C(1),4)?." " K @ZAA02GWPD@(C) S C=C-100,LN=LN-1 Q
 S @ZAA02GWPD@(C)=L Q
CP3 I D="PAGES" S SAVPAG=C,T="$P" Q
 S T="" I $D(INP(D)) S T=INP(D) X:T["~EC" $P(T,"~EC",2) Q
 I $G(VDOC)]"",$G(@VDOC@(D))]"" S T=@VDOC@(D) Q
 I SUB]"",$D(@SUB@(D)) S T=@SUB@(D) Q
 I D?1A.AN,$D(@D) S T=@D Q
 Q
 ;
FAXU G:'$D(^ZAA02GFAXC) NA^ZAA02GSCRIPT N (ZAA02G,ZAA02GP) D ^ZAA02GFAX D HEAD^ZAA02GSCRIPT Q
FAXS S NX=5,BL=22,TYP=1,SEL=0,EX="I 0",TFM=0,A="F A X    L O G" D FAXH,^ZAA02GFAXS K NX,BL,TYP Q
FAXH S %R=1,%C=20 W @ZAA02GP,$J("",45) S %C=84-$L(A)\2 W @ZAA02GP,ZAA02G("HI"),A,!!,ZAA02G("CS") Q
 ;
TT S X="",$P(ZAA02GSCRP,";",3)=2 F J=1:1 S X=$O(^RFG(X)) Q:X=""  D FAXINFO W FAXTO,?30,FON,?50,FAXTOF,!
 Q
FAXINFO N RX,R,S S (FAXTO,FAXTOF,FON)="",(AF,AM)=0,FAXFROM=$P(@ZAA02GSCR@("PARAM","BASIC"),"|") I $G(ZAA02GWPD)="" S ZAA02GWPD="AAS" ; bogus value
 D @("FAXIN"_$S($G(^("LOOKUP")):$G(^("LOOKUP")),1:2)) X:$G(@ZAA02GSCR@("PARAM","FAXTOF_LOGIC"))]"" ^("FAXTOF_LOGIC") Q
CONSULT S X="" S:$D(@ZAA02GWPD@(.011))#2 X=$P(^(.011),"`",16) Q
PROV S X="" S:$G(@ZAA02GWPD@(.011,"PROV"))]"" X=^("PROV") Q
FAXIN2 D:$G(X)="" CONSULT Q:X=""  S RX=$G(^RFG(X)),R=$P(RX,":",19) I R="" S R=$P(RX,":",2) D FAXNAME ; ADS
 I $G(FAXSUB)="" D
 . I $D(INP("PATIENT")) S FAXSUB=INP("PATIENT")
 . I $G(FAXSUB)="",$G(VDOC)]"" S FAXSUB=$G(@VDOC@("PATIENT"))
 S DT=$S($G(DT)="":$ZD(+$H),1:DT)
 S FAXTO=R,R=$G(INP("SITEC")) I R="",$G(VDOC)]"" S R=$G(@VDOC@("SITEC")),INP("SITEC")=R
 I $G(DOC) S PGS=$G(@ZAA02GWPD@(.011,"P"))
 S:R="" R=$P($G(REC),"`",6) I R]"" S R=$G(^PSG(R)) I $P(R,":",2)]"" S FAXFROM=$P(R,":",2),FAXN="TEL:  "_$P(R,":",13)
 I $P(RX,":",46)="N" S done(X)=3
 S FON=$P(RX,":",8),(FAXTOF,AF)=$P(RX,":",21),FAXTOF=$TR(AF,"FAX()- ",""),AF=AF["AF",SU=$P(RX,":",48)["Y",SUREP=$P(RX,":",49)
 I FAXTOF]"",$TR($P(RX,":",22),"S","Y")="Y" S AF=1 S:$P(RX,":",22)="S" done(X)=2 S:$G(SAF) done(X)=2
 I $TR($P(RX,":",24),"S","Y")="Y"!$G(FMa),$P(RX,":",23)_$$FTP($P(RX,":",40))["@" D
 . S EMAIL=$P(RX,":",23),EMAILT=$P(RX,":",33),FAXPASS=$P(RX,":",29) S:EMAILT="" EMAILT="F"
 . I "FDX"[$G(EMAILT),$$FTP($P(RX,":",40))'["@" S EMAILT="P"
 . I FAXPASS="","FDX"['EMAILT,'$G(FMa) Q
 . I "FDX"[EMAILT S EMAIL=$$FTP($P(RX,":",40)),FAXPASS=""
 . I $TR($P(RX,":",24),"S","Y")="Y" S AM=1 S:$P(RX,":",24)="S" done(X)=2 S:$G(SAM) done(X)=2
 ; I $G(done(X))=2,$G(^ZAA02GWP(.9,DP,XDC,"CONSULT"))=X S DONE=2
 Q
 ;
FTP(X) Q:X["**" "" Q:$L(X,"*")'=5 "" Q $P(X,"*",3,4)_"@"_$P(X,"*",1,2)_"*"_$P(X,"*",5)
 ;
 ;
FAXNAME S:R["," S=$S(R[", ":", ",1:","),S=$P(R,S,2),R=$P(S," ",1,$L(S," ")>2+1)_" "_$P(R,",")_$S($L(S," ")>1:", "_$P(S," ",$L(S," ")),1:"") S:$E(R)=" " R=$E(R,2,99) Q
 ;
LOGALL G LOGALL^ZAA02GSCRFX2
LOGERR G LOGERR^ZAA02GSCRFX2
NOLOG G NOLOG^ZAA02GSCRFX2
 ;
 ;
SETUPM ; SETUP EMAIL
 I $D(^ZAA02GWEMM("HOST")) W "Already Defined",!
 R "Host ",HOST,!,"DNS-1 ",DNS1,!,"DNS-2 ",DNS2,!
 S:HOST]"" ^ZAA02GWEMM("HOST")=HOST,^("DNS")=DNS1 S:DNS1]"" ^ZAA02GWEMM("DNS",1)=DNS1 S:DNS2]"" ^ZAA02GWEMM("DNS",2)=DNS2
 R "From Name for Email ",FROM,!,"Portal Server Address (https://xx) ",PORTAL,!
 S:FROM]"" ^ZAA02GSCR("PARAM","EMAIL-FROM")=FROM S:PORTAL]"" ^ZAA02GSCR("PARAM","PORTAL-SERVER")=PORTAL
 Q
 ;
FILERR S ERR="FILE ERROR" G DEND
DEND S ERR="ERROR" C:$D(ODV) ODV C FL K ODV Q
FILEND I $ZE["ENDOFFILE" S ZC=1 Q
 U 0 W $ZE S $ZT="" R CCC S ZC=1 B  Q
 ;
FILE N DOC S J="" I $G(B)]"" S J=$TR($P(B,"\",31),", ","_")_"-"_$S($P(B,"\",2)>0:$TR($P($G(^ZAA02GSCR("TRANS",$P(B,"\",2),.011)),"`",10)_"-"_$G(^(.011,"DS")),"/","_"),1:"?-?") S J=$TR(J,"""","_")
 S tp=$P(^ZAA02GFAXQ("SRC",KK),",",3)
 S PATH=$G(PATH,"FTP"),DOC=PATH_"\"_J_"-"_KK_"-"_$P($H,",",2)_$S(tp["pdf":".pdf",1:".hl7")
 S ^ZAA02GFAXQ("FTP",KK,DOC)=$H
 I $ZV["M3" D
 . F J=1:1:$L(PATH,"\") I $ZOS(10,$P(PATH,"\",1,J))=-2 S A=$ZOS(6,$P(PATH,"\",1,J))
 . S DV="FILE" O DV:(DOC:"WN") ; DOC INSTEAD OF 1T
 I $ZV["Cache" D
 . S DV=DOC,J=$ZF(-1,"mkdir "_PATH) ;J=0 DIR MADE
 . O DV:("NW")
 . ; PROCESS ERRORS
 S Y=$P(^ZAA02GFAXQ("SRC",KK),$C(1),2)_$C(13,10) D STORE2
 S X="" F  S X=$O(^ZAA02GFAXI(KK,1,X)) Q:X=""  S Y=^(X) D STORE2
 D STORE3
 Q
 ;
BATCH ;winscp /console /command {/privatekey=<key_file>} "option batch abort" "option confirm off" "open ftp://ads:adschicago@fileserver" "put ftp.txt" "exit"
 ;
STORE2 Q:$G(NOFILE)  I $ZV["M3" U DV W Y S C=$ZC Q
 I $ZV["Cache" U DV W Y S C=$ZC Q
 S C=0 Q
STORE3 Q:$G(NOFILE)  I $ZV["M3" C DV S C=0 Q
 I $ZV["Cache" C DV S C=0 Q
 S C=0 Q
 Q
 ;
SETSFTP S K=$P($P(P1,"Job:",2),$C(9)) I K]"" D
 . S ^ZAA02GFAXQ("FTP",K,1)=P1 ; FOR NOW
 . S E=$P($P(P1,"Job:",2),$C(9),2),ERR=$S(E'="SUCCESS":E,1:"")
 . D SMFINE^ZAA02GFAXC(K,ERR)
 S B="OK" G GETE^ZAA02GVB
 ;
RESEND ;
 S A="" F  S A=$O(^ZAA02GSCR("TRANS",A),-1) Q:A=""  I $E($G(^(A,.011,"eS")))="S",$G(^("IO"))="",$L($G(^("FAX"))) W A," " R CC D RSND2
 Q
RSND2 S DOC=A N (DOC)
 D LC^ZAA02GVBTER S USER="MG",HANDLE2=1
 S S=$P($G(^ZAA02GFAXC("CONFIG")),"\"),PF=$P($G(^ZAA02GFAXC("CONFIG")),"\",18),Re=$G(^ZAA02GSCR("TRANS",DOC,.011,"FAX")) F JJ=1:1:$L(Re,",") S RF=$P(Re,",",JJ) D
 . S F=$TR($P($G(^RFG(RF)),":",21),"AF"),RFN=$P($G(^RFG(RF)),":",2) Q:F=""  S P=$P($G(^ZAA02GSCR("TRANS",DOC,.011)),"`",8)
 . S X="|GETP|TRAN|FAX|"_DOC_"|"_S_$C(230)_PF_$C(230)_P_$C(230)_RFN_$C(230)_F_$C(230,230,230,230)_"F",P1=$P(X,"|",5),P2=$P(X,"|",6) D FAX^ZAA02GVBTER
