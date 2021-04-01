%ZAA02GEDPO2 ;;%AA UTILS;1.24;SUBR: WINDOWS #3;3SEP92 4:57P
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
        S TA=$S($D(Y(0)):$P(Y(0),"\",6),1:""),TE=TO,TMN=$S('$D(TMN):99999,TMN="":99999,1:TMN) X:TO'="" TQF,TQ S:TP["U" TH=$TR(TH,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        I TC'["." S TJ=$S(TN'["`":"",TA'["*"&$L(TA):"",TW-$L(TA)<35:"NXT/PRV KEYS",TMM=0:"Next Screen",TO="":"Previous/First Screen",1:"Next/Previous/First Screen"),TA=$P(TA,"*")_TJ_$P(TA,"*",2) I TA'="" S %R=TT+TL+1,%C=TW\2+TC(1)-($L(TA)\2) W @ZAA02GP,$TR(TA,"*")
        S TOO=TO,TMM=TM,TA=TI-1,TI=TD,TJ="",TO=TE S:TI>TA TI=TA G:TP["W" WRITONLY
        I TH?."\",TN'["`" S:'$D(X) X="" S:'$D(TX) TX="" S %C=TF+$L(TX)+1,%R=TT+TL W @ZAA02GP,X I TQN="Y" D READ G SEL4
        S TM=ZAA02G("T"),TG="\",X=$S($D(TMO):TMO,1:+$O(TB(0))),TY=^%T(.3,ZAA02G,0) K TMO
SEL0 I $D(TB)=1 R TE#1:TMN X TM S ZF=$A(TY,$F(TY,ZF)),X="." G TT
        I TV F X=X:0:TMM W $P(TB(X),TZ),TRO,TR,*8 R TE#1:TMN X TM S ZF=$A(TY,$F(TY,ZF)) W " " G SEL2:TE?1ANP,SEL7:'$T S X=$S(ZF=33:X-1,ZF=35:X+TD,ZF=36:X-TD,ZF=34:+$O(TB(X)),ZF>1:X_".",1:+$O(TB(X))) G:$D(TB(X))=0 TT
        I 'TV F X=X:0:TMM W TR,TB(X) R TE#1:TMN X TM S ZF=$A(TY,$F(TY,ZF)) W TRO,TB(X) G SEL2:TE?1ANP,SEL7:'$T S X=$S(ZF=33:X-1,ZF=35:X+TD,ZF=36:X-TD,ZF=34:+$O(TB(X)),ZF>1:X_".",1:+$O(TB(X))) G:$D(TB(X))=0 TT
        S X=$O(TB(0)) G SEL0
SEL1 W:$D(TB(X)) TR,TB(X) I TP["M" S (TX,X)="" F TB=0:0 S TX=$O(X(TX)) S:TX'="" X=X_TX_"," I TX="" S TE=X K X S X=TE Q
        I TP["V"!(TP["S"),X,","'[X
        G:'$T SEL4 S:X'["," X=X_","
        I TN["`" F TE=1:1 S TB=+$P(X,",",TE) G:'TB SEL4 X "F TI=2:1 Q:'$D(TN(TI))  Q:TN(TI)'<TB" S TO=$P(TN(TI-1),"`",2),TA=+TN(TI-1) D SEL6
        S TO=TN,TA=0
        F TE=1:1:$L(X,",")-1 S TB=+$P(X,",",TE) D SEL6
SEL4 W ZAA02G("ROF"),ZAA02G("LO") S %C=TF,X=X_TJ G:$D(REFRESH) FORM G:TP["D" END I TP["F" S %R=TT,%C=1 W @ZAA02GP,ZAA02G("CS") G END
        S TE=$J("",TW+2) S:TC["." TL=$S(TP["L":1,1:-1) I TP'["T" F %R=TT:1:TT+TL+1 W @ZAA02GP,TE
        E  F %R=TL+1+TT:-1:TT W @ZAA02GP,TE
END X ^%T("ECHO-OFF") W ZAA02G("Z") K TA,TB,TC,TD,TE,TF,TG,TH,TI,TJ,TL,TM,TN,TO,TOO,TP,TQ,TQN,TR,TS,TSP,TT,TU,TV,TW,TX,TY,TZ,ZF,TRO,TMM,TMN,TEN,TFK,TDP,TOV,TQF Q
MUL S TE='$D(X(X)),TB(X)=$P(TB(X),TZ)_TL(TE)_$P(TB(X),TZ,3) W TRO,TB(X) S:TE X(X)="" K:'TE X(X) G SEL0:TP'["A" S X=$O(TB(X)) S:X="" X=$O(TB(0)) G SEL0
TT I TFK[$P(^%T(.3),"\",ZF+2) S TJ=";"_$P(^(.3),"\",ZF+2) G SEL1
        I X["." S X=+X G SEL1:ZF=13,MUL:ZF=59&(TP["M"),SEL3
        I ZF=33 S X=$S(X<$O(TB(0)):TMM,1:X-1) G TT:$D(TB(X))=0,SEL0
        I ZF=35 S X=$S(X>TMM:X#TD+TN+1,1:X+TD) G TT:$D(TB(X))=0,SEL0
        I ZF=36 S X=$S(X<$O(TB(0)):X-2-TN#TD+(TC-1*TD)+TN+1,1:X-TD) G TT:$D(TB(X))=0,SEL0
        S X=$O(TB(0)) G SEL0
SEL2 I TE?1P S X=+$O(TB(X)),ZF=34 G TT:'$D(TB(X)),SEL0
        S TG=TG_$S(TP["U":$TR(TE,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ"),1:TE),TX=$F(TH,TG) I TX S X=$L($E(TH,1,TX-1),"\")+TN-1 G SEL1:TP["Q",SEL0
        I $L(TG)>2 S TG="\" G SEL2
        S TG="\" G SEL0
SEL3 G SEL5:TN'["`" I ZF=39 G SEL5:TOO="",MNX^ZAA02GEDPO1
        I ZF=40 G MPR^ZAA02GEDPO1:$P(TN,"`",3)>1
        I ZF=41 G MFR^ZAA02GEDPO1:$P(TN,"`",3)>1
SEL5 G SEL0:TP'["W"
WRITONLY I +$P(TP,"W",2)=0 G END:'$D(REFRESH),FORM
        R X#2:+$P(TP,"W",2) S TJ=";TM" G SEL4:'$T X ZAA02G("T") S TY=^%T(.3,ZAA02G,0),TJ="",ZF=$A(TY,$F(TY,ZF)) G SEL4:ZF=13,SEL3:'$D(Y(0)),SEL3:$P(Y(0),"\",2)'[$P(^%T(.3),"\",ZF+2) S TJ=";"_$P(^(.3),"\",ZF+2) G SEL4
SEL6 X TQF F TA=TA+1:1 X TQ I TA=TB S TX=TO X:TP["V" TS S:TP["M" X(TA)=TX S:TP'["M" X=TX Q
        Q
SEL7 S TJ=";TIMEOUT" G SEL1
BEG G ^ZAA02GEDPO
FORM S REFRESH=TT_":"_(TL+TT+1)_":"_TF_":"_(TW+TF) G END
READ S Y="HI\HI\"_$S($D(Y(0)):$P(Y(0),"\",2),1:"")_",EX\\"_$S($D(LNG):LNG,1:TW-$L(TX)-2)_"\"_$S('$D(CHR):"",1:CHR) D ^ZAA02GEDRS S:ZAA02GF'="CR" TJ=";"_ZAA02GF Q
        ;
