%ZAA02GEDA0 ;;%AA UTILS;1.24;UTIL: ARCHIVE ROUTINES;24APR91  16:18
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
MULT N pc,L,R,S,GS,ACT,CPY,GFI,GFR,SET,ZAA02GF S SF=0
SEL S ACT="Archive",SET="2" D ^ZAA02GEDRL G EXIT:'$D(GS),EXIT:'$D(@GS) D DATE^ZAA02GEDS0
ASK W pBL,tLO_"Archive selected routines?  Please confirm:"_tLO_tCL
        S %R=bl+2,%C=lm+43,Y="RON\ROF\EX\\3\NY\No;Yes",X=0 D ^ZAA02GEDYN G:'X!(ZAA02GF="EX") EXIT
        S R="" F I=0:0 S R=$O(@GS@(R)) Q:R=""  S OR=^(R),V=$P(OR,"`",2) D ARCH
EXIT K I,X,Y,IR,OR I $D(GS),GS]"" K @GS
        Q
ARCH D MSG S IR=$S($D(@agl@(0,R)):^(R),1:"0`0`"),AV=$P(IR,"`",2) S:AV=+IR AV=AV+1 S $P(IR,"`",2)=AV F J=3:1:9 S $P(IR,"`",J)=$P(OR,"`",J)
        K @agl@(R,AV) S (E,S,N)="" F J=1:1 D FETCH Q:S=""  S @agl@(R,AV,J)=L S pc=pc-1 D:'pc MSG W "."
        S $P(IR,"`",10,11)=DT_"`"_TID,@agl@(0,R)=IR,@agl@(R,AV)=$P(IR,"`",3,99) K @wgl@(0,R),@wgl@(R),J,K,L,S Q
FETCH S S=$O(@GFR@(S)),L="" Q:S=""  S L=^(S) S:$TR(L," ","")="" L="" Q
MSG W pBL_tLO_"Archiving "_tHI_R_tLO_" from "_tHI_SRC_tLO_tCL S pc=rm-$L(R)-$L(SRC)-17 Q
        ;
