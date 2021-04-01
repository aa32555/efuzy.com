%ZAA02GEDUI0 ;;%AA UTILS;1.24;UTIL: IMPORT ROUTINES;30MAY91  11:07
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
INIT N (ZAA02G,ZAA02GP,ZAA02GX,ZAA02GY,TID,d,ci,bl,ct,gl,lm,rm,rt,sr,tl,SF,tCL,tHI,tLO,pBL,agl,ugl,wgl,sgl)
        S OS=ZAA02G("OS"),ET=@ZAA02G("G")@("ERROR"),ER=^("ERRORR"),GT=wgl,FN=""
SRC S X="GLOBAL",Y=1,Y(Y)="G" S:"DTM,MSM,DSM4,CCSM"[OS X=X_",ASCII FILE",Y=Y+1,Y(Y)="A" S X=X_",MUMPS",Y=Y+1,Y(Y)="M"
        S Y=(lm-1)_","_(bl+2)_"\H\EX\Import from: \\"_X W pBL_tLO_tCL D ^ZAA02GEDPL G EXIT:ZAA02GF="EX" S SC=Y(X) K X,Y G GLO:SC="G",FIL:SC="A" I SC="M" D RTN^ZAA02GEDUI4 G EXIT:X=""!(ZAA02GF="EX") G OVR
        I SC="C" D NA G SRC
GLO S %R=bl+2,%C=lm-1,X="" W @ZAA02GP,tLO_"Import from Global: "_tHI_"^"_tCL S %C=lm+20,Y="RON\ROF\EX\\25\" D ^ZAA02GEDRS Q:X=""!(ZAA02GF="EX")
        S:$E(X)'="^" X="^"_X I '$D(@X@(0)) S X=$E(X,2,99) W *7 G GLO
        S FN=X D DSPG G OVR
FIL W pBL_tLO_"Import from file: "_tHI_tCL S %R=bl+2,%C=lm+17,Y="RON\ROF\EX\\25\",X="" D ^ZAA02GEDRS G:ZAA02GF="EX" EXIT S FN=X
        S FMT="" I "DSM4,MSM"[OS S Y=(lm-1)_","_(bl+2)_"\H\EX\Source format: \\MSM,DSM,DTM-PC" W pBL_tCL_tLO D ^ZAA02GEDPL G:ZAA02GF="EX" EXIT S:X=3 FMT="DTM"
        D @("OPEN"_OS) G:'OK FIL  D DSPF
OVR S Y=(lm-1)_","_(bl+2)_"\H\EX\Confirm: \\EXISTING ROUTINES,EACH ROUTINE,NEVER" W pBL_tCL_tLO D ^ZAA02GEDPL G:ZAA02GF="EX" EXIT S OV=$E("231",X)
REN W pBL_tLO_"Rename routines before saving?"_tCL S %R=bl+2,%C=32,Y="RON\ROF\EX\\3\NY\No;Yes",(X,REN)=0 D ^ZAA02GEDYN G EXIT:ZAA02GF="EX",CNF:'X S REN=X
        W pBL_tLO_"Change names from:            to:"_tCL S (RENF,RENT)=""
RE1 S %R=bl+2,%C=20,Y="RON\ROF\LK,EX\\10\[%%**AZaz09]",X=RENF D ^ZAA02GEDRS G EXIT:ZAA02GF="EX",REN:ZAA02GF="LK" S RENF=X
RE2 S %R=bl+2,%C=35,Y="RON\ROF\LK,EX\\10\[%%**AZaz09]",X=RENT D ^ZAA02GEDRS G EXIT:ZAA02GF="EX" S RENT=X G:ZAA02GF="LK" RE1
CNF S %R=bl+2,%C=lm-1,Y="RON\ROF\EX\\3\NY\No;Yes\\\\Ready to begin? ",X=0 W pBL_tCL_tLO D ^ZAA02GEDYN
        I ZAA02GF'="EX",X D @$S(SC="A":"^ZAA02GEDUI1",SC="G":"^ZAA02GEDUI2",SC="C":"^ZAA02GEDUI3",1:"IMPORT^ZAA02GEDUI4")
EXIT I $D(FILE),FILE]"" C FILE
        Q
OPENDTM S @(ET_"=""PROBLEM"""),FILE=12,OK=0 O FILE:("R":FN:Bufsize=6):1 I  S OK=1
        G:'OK PROBLEM S @(ET_"=""""") Q
OPENDSM4 S @(ET_"=""PROBLEM"""),FILE=FN,OK=0 O FILE:READONLY:1 I  S OK=1
        G:'OK PROBLEM S @(ET_"=""""") Q
OPENMSM S @(ET_"=""PROBLEM"""),FILE=53,OK=0
        I FMT="DTM" O FILE:(FN:"R"::::$C(12)):1 I  S OK=1 S @(ET_"=""""") Q
        I FMT'="DTM" O FILE:(FN:"R"):1 I  S OK=1 S @(ET_"=""""") Q
        G PROBLEM
PROBLEM S OK=0 U 0 W pBL_"Problem encountered opening "_tHI_FN_tLO_".  Press any key to try again. "_tCL R *X Q
DSPG N X,Y,CM,TY,NR,NB,VR S X=@FN@(0),DT=$P(X,"`"),TY=$P(X,"`",2),NR=$P(X,"`",3),NB=$P(X,"`",4),VR=$P(X,"`",5),CM=$P(X,"`",6)
        S Y(1)="  AA UTILS "_VR_" Copyright (C) 1990 PG&A",Y(2)="  "_$S(TY:"Executable",1:"Source")_" Code Distribution created "_DT_" ",Y(3)="  Comments: "_CM_"  ",Y(4)="  "_NR_" Routines"
        S Y=(lm+20)_","_(tl+4)_"\THRLWDY\1\CONTENTS OF GLOBAL:  "_FN D ^ZAA02GEDPO S SF=1 Q
DSPF S Y=1,FM="MSM" S X=$$NXTREC
        I $E(X)=";" S FM="DTM",Y(Y)=$P(X,";",2,99) F I=0:0 S X=$$NXTREC Q:$E(X)'=";"  S Y=Y+1,Y(Y)=$P(X,";",2,99)
        E  S Y(Y)=X,X=$$NXTREC D EXTEND S X=$$NXTREC
        I FM="DTM",$D(Y(4)),Y(4)["WORKS" S FM="WKS" K Y(5)
        I FM="MSM" S Y(1)="Routine(s) saved at "_Y(1),Y(2)="Header comment is: "_Y(2)
        D:FM="DTM" DTMTYP
        U 0 S R=X,Y=(lm+20)_","_(tl+4)_"\THRLWDY\1\CONTENTS OF FILE:  "_FN D ^ZAA02GEDPO S SF=1 Q
EXTEND I X'["`" S Y=Y+1,Y(Y)=X Q
        E  S Y(2)=$P(X,"`",2),Y(3)=$P(X,"`",1),Y(4)=$P(X,"`",3),Y=4 Q
NA W pBL_tLO_"Not Available"_$J("...press any key",rm-lm-11) R *X Q
DTMTYP F I=0:0 S X=$$NXTREC S:X="" FM="DSM" Q:X=""!(X=$C(13,12))
        D @("OPEN"_OS) F I=0:0 S X=$$NXTREC Q:$E(X)'=";"
        Q
NXTREC() I FMT'="DTM" U FILE R X U 0 Q X
        I '$D(CRLF) S:FMT="DTM" CRLF=$C(13,10)
        S X="" I $D(BUF),BUF[CRLF S X=$P(BUF,CRLF),BUF=$P(BUF,CRLF,2,999) U 0 Q X
        I $D(BUF) S X=BUF,BUF=""
        I '$D(BUF) S BUF=""
NX U FILE R ST#200 S X=X_$P(ST,CRLF),BUF=$P(ST,CRLF,2,999)
        Q:ST="" X I ST'[CRLF G NX
        U 0 K ST Q X
        ;
