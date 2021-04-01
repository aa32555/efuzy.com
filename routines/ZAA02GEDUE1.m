%ZAA02GEDUE1 ;;%AA UTILS;1.24;UTIL: EXPORT ROUTINES/ASCII FILE;14JUN91  14:05
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
INIT G:$O(@GS@(""))=0 EXIT N OS,ET,ER,DT D DATE^ZAA02GEDS0
        S OS=ZAA02G("OS"),ET=^%T("ERROR"),ER=^%T("ERRORR") D @("OPEN"_OS) Q:'OK
        S %C=lm+16 D COUNT,@($P("WORKS,DTM,MSM,CCSM",",",FM)) C FILE
        I $D(GS),GS]"" K @GS
EXIT K I,L,V,DT,FN,GS,NB,NR,RT,SC,TB,TY,EOR,GFR,GFI,TAB Q
WORKS U 0 W pBL_tLO_"Writing header information"_tCL S FLG=1 D HDR
        U FILE W ";"_DT_"`"_TY_"`"_NR_"`"_TB,! S R="" F I=0:0 S R=$O(@GS@(R)) Q:R=""  S IR=^(R),V=$P(IR,"`",2) W R_"`"_$P(IR,"`",3,99),!
        W "~I~",!
        U 0 W pBL_tLO_"Writing routines..."_tCL S %C=lm+19,EOR="~R~",TAB=" ",R="" F I=0:0 S R=$O(@GS@(R)) Q:R=""  W @ZAA02GP,tHI_R_tCL S IR=^(R),V=$P(IR,"`",2) D ROUT1
        U FILE W "~E~",!! U 0 Q
DTM S FLG=1 U 0 W pBL_tLO_"Writing header information"_tCL D HDR
        U 0 W pBL_tLO_"Writing routines..."_tCL S %C=lm+19,EOR=$C(12),TAB=$C(9),R="" F I=0:0 S R=$O(@GS@(R)) Q:R=""  U 0 W @ZAA02GP,tHI_R_tCL S IR=^(R),V=$P(IR,"`",2) D ROUT2
        W EOR U 0 Q
MSM S FLG=0 U 0 W pBL_tLO_"Writing header information"_tCL D HDR
        U 0 W pBL_tLO_"Writing routines..."_tCL S %C=lm+19,EOR="",TAB=" ",R="" F I=0:0 S R=$O(@GS@(R)) Q:R=""  U 0 W @ZAA02GP,tHI_R_tCL S IR=^(R),V=$P(IR,"`",2) D FIRST,ROUT2
        W EOR U 0 Q
CCSM Q
COUNT S (NR,TB,R)="" F I=0:0 S R=$O(@GS@(R)) Q:R=""  S NR=NR+1,TB=TB+$P(^(R),"`",5)
        Q
ROUT1 U FILE S S="" W R,! F I=1:1 S S=$O(@GFR@(S)) Q:S=""  S L=^(S) S:TY&($E(L)=ci) L="" I 'TY!(TY&($TR(L," ","")]"")) W $P(L," ")_TAB_$P(L," ",2,511),!
        W EOR,! U 0 Q
ROUT2 D FIRST U FILE W R,! S S="" F I=0:0 D FETCH Q:S=""  W T_TAB_L,!
        W EOR,! U 0 Q
FETCH I FL,$O(LI("")) S LI=$O(LI("")),T=$P(LI(LI)," "),L=$P(LI(LI)," ",2,511) K LI(LI) Q
F1 D GET Q:S=""  I 'FL,T]"",$E(T)'=ci S FL=1,$P(LI(1)," ")=T G FETCH
        S L=$E(L,$F(L,$E($TR(L," ","")))-1,511) F K=$L(L):-1:0 Q:$E(L,K)'=" "
        S L=$E(L,0,K) G:$L(T_L)=0 F1 Q
GET S S=$O(@GFR@(S)),L="" Q:S=""  S L=^(S),T=$P(L," "),L=$P(L," ",2,511) I TY S:$E(T)=ci L="" I T="",$TR(L," ","")="" G GET
        Q
HDR U FILE W:FLG ";" W "AA UTILS "_$P(VERS," ",3)_" Copyright (C) 1990 PG&A",!
        W:FLG ";"_$S(TY:"Executable",1:"Source")_" Code Distribution created "_$P(DT,"\",2),!
        W:FLG ";" W "Comments: ",CM W:FLG ! W:'FLG "`"_$S(TY:"Executable",1:"Source")_" Code Distribution created "_$P(DT,"\",2)_"`"
        W:FLG ";" W "Format:  "_$P("AA UTILS;DTM-PC;MSM;CCSM",";",FM),! U 0 Q
OPENDTM S $ZT="ODTM2^ZAA02GEDUE1",FILE=10,OK=0 O FILE:("R":FN:Bufsize=6):1 I  D VERIFY I 'OK C FILE S $ZT="" Q
ODTM2 S $ZT="ODTM3^ZAA02GEDUE1" U 0 W pBL_tLO_"Creating file "_tHI_FN_tCL O FILE:("W":FN:Bufsize=6) S OK=1,$ZT="" Q
ODTM3 D PROB S OK=0,$ZT="" Q
OPENDSM4 S @(ET_"=""ODSM2"""),FILE=FN,OK=1 O FILE:READONLY:1 I  D VERIFY I 'OK C FILE G ODSM3
ODSM2 W pBL_tLO_"Creating file "_tHI_FN_tCL O FILE:NEWVERSION S OK=1
ODSM3 S @(ET_"=""""") Q
OPENMSM S @(ET_"=""OMSM2"""),FILE=51,OK=1 O FILE:(FN:"R"):1 I  D VERIFY I 'OK C FILE G OMSM3
OMSM2 W pBL_tLO_"Creating file "_tHI_FN_tCL O FILE:(FN:"W") S OK=1
OMSM3 S @(ET_"=""""") Q
PROB U 0 W pBL_tLO_"Problem encountered creating "_tHI_FN S %C=rm-15 W @ZAA02GP,tLO_"...press any key" R *Z K Z Q
VERIFY U 0 W pBL_tLO_"File "_tHI_FN_tLO_" exists.  Overwrite it?"_tHI_tCL
        S %R=bl+2,%C=lm+$L(FN)+28,Y="RON\ROF\EX\\3\NY\No;Yes",X=0 D ^ZAA02GEDYN S OK=$S(ZAA02GF="EX":0,1:X) Q
FIRST N P,M S (FL,LI)=0,LI(1)=" ;"
        F K="DES","MOD","FIL","TID","PKG","PV" I $D(@sgl@(0,"FMT",K)),^(K) S M=+^(K),P=$P(^(K),"`",2) S:'$D(LI(M)) LI(M)=" ;" D @K S $P(LI(M),";",P)=X S:M>LI LI=M
        I $D(CPY),$D(@CPY)#2 F K=1:1:@CPY S LI=LI+1,LI(LI)=@CPY@(K)
        Q
DES S X=$P(IR,"`",3) Q
MOD S X=$P(IR,"`",6) D DATE Q
FIL S X=$P(IR,"`",7) D DATE Q
TID S X=$P(IR,"`",8) Q
PKG S X=$S($D(PKG):PKG,1:"") Q
PV S X=$S($D(PX):PX,$D(PV):PV,1:"") Q
DATE S X=$P(X,"\",2),X=$P(X,"/",2)_$P("JAN/FEB/MAR/APR/MAY/JUN/JUL/AUG/SEP/OCT/NOV/DEC","/",+X)_$P(X,"/",3) Q
        ;
