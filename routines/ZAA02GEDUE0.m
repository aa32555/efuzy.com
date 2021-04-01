%ZAA02GEDUE0 ;;%AA UTILS;1.24;UTIL: EXPORT ROUTINES;14JUN91  14:04
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
INIT N (ZAA02G,ZAA02GP,ZAA02GX,ZAA02GY,TID,d,ci,bl,ct,gl,lm,rm,rt,sr,tl,SF,tCL,tHI,tLO,pBL,agl,pgl,ugl,wgl,sgl,VERS) S (GFI,GFR,TY,SC,FN,FM)=""
SRC S ACT="Export",SET="234" D ^ZAA02GEDRL G EXIT:'$D(GS),EXIT:'$D(@GS)
DES S OS=ZAA02G("OS"),X="GLOBAL",Y=1,Y(Y)="G" S:"DTM,MSM,CCSM,DSM4"[OS X=X_",ASCII FILE",Y=Y+1,Y(Y)="A"
        S Y=(lm-1)_","_(bl+2)_"\H\EX\Export to: \\"_X W pBL_tLO_tCL D ^ZAA02GEDPL G EXIT:ZAA02GF="EX" S SC=Y(X) G GLO:SC="G",FIL:SC="A" I SC="C" D NA G DES
FIL W pBL_tLO_"Export path: "_tHI_tCL S %R=bl+2,%C=lm+12,Y="RON\ROF\EX\\25\",X="" D ^ZAA02GEDRS G:ZAA02GF="EX" EXIT S FN=X
FMT S Y=(lm-1)_","_(bl+2)_"\H\EX\Export Format: \\AA UTILS,DTM-PC,MSM,CCSM" W @ZAA02GP,tCL_tLO D ^ZAA02GEDPL G EXIT:ZAA02GF="EX" S FM=X I X=4 D NA G FMT
        G:X=1 TYP S TY=1 G CMT
GLO W pBL_tLO_"Export to Global: "_tHI_"^"_tCL S %R=bl+2,%C=lm+18,Y="RON\ROF\EX\\25\",X="" D ^ZAA02GEDRS G:ZAA02GF="EX" EXIT I X="" W *7 G GLO
        S FN="^"_$TR(X,"^",""),(TY,NR,TB,CM,KILL)="" G:'$D(@FN) TYP I $D(@FN@(0))#2 S X=^(0),TY=$P(X,"`",2),NR=$P(X,"`",3),TB=$P(X,"`",4),CM=$P(X,"`",6) K X I TY'=0&(TY'=1) S (TY,NR,TB,CM)=""
ASK W pBL_tHI_FN_tLO_" already exists:  "_tCL S %R=bl+2,%C=lm+$L(FN)+16,Y=%C_","_%R_"\H\EX\\\ QUIT , ADD TO GLOBAL , KILL GLOBAL" D ^ZAA02GEDPL G:X=1!(ZAA02GF="EX") EXIT I X=3 S KILL=1
TYP S %R=bl+2,%C=lm-1,Y=%C_","_%R_"\H\EX\Export type: \"_(TY+1)_"\SOURCE,EXECUTABLE" W @ZAA02GP,tCL_tLO D ^ZAA02GEDPL G:ZAA02GF="EX" EXIT S TY=X-1
CMT S %R=bl+2,%C=lm-1,W=rm-lm-12 S:W>60 W=60 S Y="RON\ROF\EX\\"_W_"\\\\\\Comments: ",X=$S($D(CM):CM,1:"") W pBL_tCL D ^ZAA02GEDRS G:ZAA02GF="EX" EXIT S CM=X
ON D DATE,@$S(SC="G":"^ZAA02GEDUE2",SC="A":"^ZAA02GEDUE1",1:"^ZAA02GEDUE3")
EXIT W pBL_tCL Q
NA W pBL_tLO_"Not Available"_$J("...press any key",rm-lm-11) R *X Q
DATE N m,d,y,o,F,H,M,S,X S X=$H,S=$P(X,",",2),o=$S(X<21609:14915,1:-21609),X=X+o,y=4*X+3\1461,d=X*4+7-(1461*y)\4,m=5*d-3\153,d=5*d+2-(153*m)\5 S m=m+3 S:m>12 m=m-12,y=y+1 S y=$S(o=14915:y+1800,y>99:y+1900,1:y)
        S H=S\3600,M=S#3600\60,F="A" S:H>11 F="P",H=H-12 S:'H H=12 S DT=d_" "_$P("JAN/FEB/MAR/APR/MAY/JUN/JUL/AUG/SEP/OCT/NOV/DEC","/",m)_" "_(y#100)_"   "_H_":"_$E(0,M<10)_M_F Q
        ;
