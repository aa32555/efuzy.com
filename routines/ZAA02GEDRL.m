%ZAA02GEDRL ;;%AA UTILS;1.24;SUBR: ROUTINE LOOKUP;17JUL91  09:51
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
BEG N PG S (SF,PKG,PV)="",DL=$S(ZAA02G["IBM":$C(0),1:$C(127)),GS="^ZAA02GEDSEL($J)",ST="WORKSPACE,WORKFILE,ARCHIVE,RELEASE"
        S CPY=sgl_"(0,""FMT"",""COP"")",(CPL,CPN)=0 I $D(@CPY)#2 S CPN=+@CPY,CPL=$P(@CPY,"`",2)
        K:'$D(NOKILL) @GS I $L(SET)=1 S TYP=SET,SRC=$P(ST,",",TYP) G SR2
SRC S (X,Y)="" F I=1:1:4 I SET[I S X=X_","_$P(ST,",",I),Y=Y+1,Y(Y)=I
        S Y=(lm-1)_","_(bl+2)_"\H\EX\"_ACT_" From: \\"_$E(X,2,99) W pBL_tCL_tLO D ^ZAA02GEDPL I ZAA02GF="EX" K X,Y,DL,GS,ST Q
        S TYP=Y(X),SRC=$P(ST,",",TYP) K I,X,Y I TYP=1 K ST Q:rt=""  S GS="",GFR=gl,R=rt K DL,TYP Q
SR2 I TYP<4 D REF S (SIZ,CNT)=0 G RTN
        W pBL_tCL S %R=bl+2,%C=lm-1,Y="RON\ROF\EX\\20\\\\\\Package: ",X=PKG D ^ZAA02GEDRS G:X=""!(ZAA02GF="EX") SRC S PKG=X
        I PKG["?" S X=PKG D ^ZAA02GEDRL3 G:PKG=""!(ZAA02GF="EX") SRC
        I PKG]"",'$D(@pgl@(PKG)) S X=PKG D ^ZAA02GEDRL3 G:PKG=""!(ZAA02GF="EX") SRC
        S X="" D ^ZAA02GEDRL4 G SR2:PV=""!(ZAA02GF="EX")  S CPY=pgl_"(PKG,PV,0)",(CPL,CPN)=0 I $D(@CPY)#2 S CPN=+@CPY,CPL=$P(@CPY,"`",2)
SR3 D REF S SRC=PKG_" v"_PV,(CNT,DTC,DSP,SIZ,X)="" D LOAD^ZAA02GEDRL1 G DONE
RTN S:'$D(CHG) CHG=0 S:'$D(CNT) (CNT,SIZ)=0
RT1 I CHG,$D(GS),$D(@GS) D ^ZAA02GEDRL1
RT2 W pBL_tLO_ACT_" routine(s):"_tHI_tCL I $D(GS),$D(@GS) S %R=bl+2,%C=rm-38 W @ZAA02GP,tLO_"Functions: ["_tHI_"NEXT PAGE  PREV PAGE  EXIT"_tLO_"]"_tHI
RT3 S %R=bl+2,%C=lm+$L(ACT)+12,Y="RON\ROF\PU,PD,EX\\20\*?:<=>+-/%ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789",X="" D ^ZAA02GEDRS I ZAA02GF="EX" K @GS Q
        I ZAA02GF="PU" G:PG<2 RT3 S PG=PG-1 D FETCH^ZAA02GEDRL1 G RT3
        I ZAA02GF="PD" G:'$D(PG(PG+1)) RT3 S PG=PG+1 D FETCH^ZAA02GEDRL1 G RT3
        G:X="" DONE S CHG=0 I X?1A.AN!(X?1"%"1A.AN) D ADD G RT1
        I X?1"-"1A.AN!(X?1"-"1"%"1A.AN) S X=$TR(X,"-","") D DEL G RT1
        S DTC=0,DSP=X["?",PRE=X["*"!(X[":"),DEL=$E(X)="-",X=$E(X,DEL+1,99),X=$TR(X,"*?","") D:X["="!(X["<")!(X[">") DATE
        I DEL D UNLOAD^ZAA02GEDRL1:PRE,FIND:DSP K P,Z G RT1
        D LOAD^ZAA02GEDRL1:PRE,FIND:DSP K P,Z G RT1
FIND D LKUP^ZAA02GEDRL2 S CHG=1 Q
ADD Q:X=""  Q:$D(@GS@(X))  I '$D(@GFI@(X)) W *7 Q
        S Z=^(X) I TYP=4 S V=$S(PX=PV:$P(Z,"`",2),1:$P(@agl@(0,X),"`",2)),Z="`"_V_"`"_@agl@(R,V)
        S @GS@(X)=Z,CNT=CNT+1,SIZ=SIZ+$P(Z,"`",5),CHG=1 Q
DEL Q:X=""  Q:'$D(@GS@(X))  S CNT=CNT-1,SIZ=SIZ-$P(^(X),"`",5),CHG=1 K ^(X) Q
DATE I X["<" S D=$P(X,"<",2),X=$P(X,"<"),PRE=1,OP="<" D ANSI Q
        I X[">" S D=$P(X,">",2),X=$P(X,">"),PRE=1,OP=">" D ANSI Q
        I X["=" S D=$P(X,"=",2),X=$P(X,"="),PRE=1,OP="=" D ANSI Q
        Q
ANSI S D=$TR(D,"t","T") I "T+,T-"[$E(D,1,2) S @("DTC="_(+$H)_$E(D,2,99)) Q
        N m,d,y,o S:'$D(ZAA02G("d")) ZAA02G("d")=0 I ZAA02G("d")=0 S m=+D-3,d=$P(D,"/",2),y=$P(D,"/",3)
        E  S d=+D,m=$P(D,"/",2)-3,y=$P(D,"/",3)
        Q:(m+d+y)<-2  D:'y GETYR S:y<100 y=y+1900 S o=$S(y<1900:-14916,y<2000:21608,1:58132),y=$E(y,3,4) S:m<0 m=m+12,y=y-1 S DTC=1461*y\4,DTC=153*m+2\5+DTC+d+o Q
GETYR N X,m,d,o S X=+$H,o=$S(X<21609:14915,1:-21609),X=X+o,y=4*X+3\1461,d=X*4+7-(1461*y)\4,m=5*d-3\153,d=5*d+2-(153*m)\5,m=m+3 S:m>12 m=m-12,y=y+1 S y=$S(o=14915:y+1800,1:y+1900) Q
REF S GFI=$P("/"_wgl_"(0)/"_agl_"(0)/"_pgl_"(PKG,PV,1)","/",TYP)
        S GFR=$P("/"_wgl_"(R,V)/"_agl_"(R,V)/"_agl_"(R,V)","/",TYP) Q
DONE K D,P,X,Y,Z,DL,OP,ST,CNT,DEL,DTC,DSP,PRE,SIZ Q
        ;
