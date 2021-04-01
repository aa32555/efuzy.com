ZAA02GFORMP2 ;PG&A,ZAA02G-FORM,2.62,POP UP/PULL DOWN MENUS - 2;7NOV94 10:07A;;;23JUL96  17:13
 ;Copyright (C) 1992, Patterson, Gray and Assoc., Inc.
 ;
 S TA=$S($D(Y(0)):$P(Y(0),"\",6),1:""),TE=X,TMN=$S('$D(TMN):99999,TMN="":99999,1:TMN) X:X'="" TQF,TQ S:TP["U" TH=$TR(TH,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 I TC'["." S TJ=$S(TN'["`":"",TA'["*"&$L(TA):"",TW-$L(TA)<35:"NXT/PRV KEYS",TMM=0:"Next Screen",X="":"Previous/First Screen",1:"Next/Previous/First Screen"),TA=$P(TA,"*")_TJ_$P(TA,"*",2) I TA]"" S %R=TT+TL+1,%C=-$L(TA)+TW\2+TC(1) W @ZAA02GP,$TR(TA,"*","")
 S TQO=X,TMM=TM,TA=TI-1,TI=TD,TJ="",X=TE S:TI>TA TI=TA G:TP["W" WRITONLY
 I TH?."\",TN'["`" X TS S %C=TF+$F(TX,TOV),%R=TT+TL W @ZAA02GP,TOX I TQN="Y" S:$D(LNG)=0 LNG=TW-$F(TX,TOV)-1 S FNC=$S('$D(Y(0)):"",1:$P(Y(0),"\",2)),TIM=TMN,X=TOX X ^ZAA02GREAD S:FNC'="" TJ=";"_FNC S T=X G SEL4
 S TM=ZAA02G("T"),TG="\",T=$S($D(TMO):TMO,1:+$O(TB(0))),TY=^ZAA02G(.3,ZAA02G,0) K TMO
SEL0 I $D(TB)=1 R TE#1:TMN X TM S ZF=$A(TY,$F(TY,ZF)),T="." G TT
 I TV F T=T:0:TMM W $P(TB(T),TZ),TRO,TR,*8 R TE#1:TMN X TM S ZF=$A(TY,$F(TY,ZF)) W " " G SEL2:TE?1ANP,SEL7:'$T S T=$S(ZF=33:T-1,ZF=35:T+TD,ZF=36:T-TD,ZF=34:+$O(TB(T)),ZF>1:T_".",1:+$O(TB(T))) G:$D(TB(T))=0 TT
 I 'TV F T=T:0:TMM W TR,TB(T) R TE#1:TMN X TM S ZF=$A(TY,$F(TY,ZF)) W TRO,TB(T) G SEL2:TE?1ANP,SEL7:'$T S T=$S(ZF=33:T-1,ZF=35:T+TD,ZF=36:T-TD,ZF=34:+$O(TB(T)),ZF>1:T_".",1:+$O(TB(T))) G:$D(TB(T))=0 TT
 S T=$O(TB(0)) G SEL0
SEL1 W:$D(TB(T)) TR,TB(T) I TP["M" S TX="",T=$S($O(X(""))]"":"",TP["M1":T_",",1:"") F TB=0:0 S TX=$O(X(TX)) S:TX'="" T=T_TX_"," I TX="" S TE=T K T S T=TE Q
 I TP["V"!(TP["S"),T,","'[T
 G:'$T SEL4 S:T'["," T=T_","
 I TN["`" F TE=1:1 S TB=+$P(T,",",TE) G:'TB SEL4 X "F TI=2:1 Q:'$D(TN(TI))  Q:TN(TI)'<TB" S X=$P(TN(TI-1),"`",2),TA=+TN(TI-1) D SEL6
 S X=TN,TA=0 F TE=1:1:$L(T,",")-1 S TB=+$P(T,",",TE) D SEL6
SEL4 W ZAA02G("ROF"),ZAA02G("LO") S TL=$D(TEMSM)>0+TL,TW=$D(TEMSM)>0+TW,%C=TF,X=T_TJ G:$D(REFRESH) FORM G:TP["D" END I TP["F" S %R=TX,%C=1 W @ZAA02GP,ZAA02G("CS") G END
 S TE=$J("",TW+2) S:TC["." TL=$S(TP["L":1,1:-1) I TP'["T" F %R=TT:1:TT+TL+1 W @ZAA02GP,TE
 E  F %R=TL+1+TT:-1:TT W @ZAA02GP,TE
END W ZAA02G("Z") K TA,TB,TC,TD,TE,TF,TG,TH,TI,TJ,TL,TM,TN,TO,TQO,TP,TQ,TQN,TR,TS,TSP,TT,TU,TV,TW,TT,TY,TZ,ZF,TRO,TMM,TMN,TEN,TFK,TDP,TOV,TQF,TVL,TOX,TEMSM I $S('$D(ln):1,ln["C":0,ln'["P":1,1:0) X ^ZAA02G("ECHO-ON")
 Q
MUL S TE='$D(X(T)),TB(T)=$P(TB(T),TZ)_TL(TE)_$P(TB(T),TZ,3) W TRO,TB(T) S:TE X(T)="" K:'TE X(T) G SEL0:TP'["A" S T=$O(TB(T)) S:T="" T=$O(TB(0)) G SEL0
TT I TFK[$P(^ZAA02G(.3),"\",ZF+2) S TJ=";"_$P(^(.3),"\",ZF+2) G SEL1
 I T["." S T=+T G SEL1:ZF=13,MUL:ZF=59&(TP["M"),SEL3
 I ZF=33 S T=$S(T<$O(TB(0)):TMM,1:T-1) G TT:$D(TB(T))=0,SEL0
 I ZF=35 S T=$S(T>TMM:T#TD+1,1:T+TD) G TT:$D(TB(T))=0,SEL0
 I ZF=36 S T=$S(T<$O(TB(0)):T-$O(TB(0))-2#TD+(TC-1*TD)+1+$O(TB(0)),1:T-TD) G TT:$D(TB(T))=0,SEL0
 S T=$O(TB(0)) G SEL0
SEL2 I TE?1P S T=+$O(TB(T)),ZF=34 G TT:'$D(TB(T)),SEL0
 I $E(TH,2)="\" F TX=2:1 I $E(TH,TX)'="\" S TH=$E(TH,TX-1,511) Q
 S TG=TG_$S(TP["U":$TR(TE,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWTYZ"),1:TE),TX=$F(TH,TG) I TX S T=$L($E(TH,1,TX-1),"\")+$O(TB(0))-2 G SEL1:TP["Q",SEL0
 I $L(TG)>2 S TG="\" G SEL2
 S TG="\" G SEL0
SEL3 G SEL5:TN'["`" I ZF=39 G SEL5:TQO="",MNX^ZAA02GFORMP1
 I ZF=40 G MPR^ZAA02GFORMP1:$P(TN,"`",3)>1
 I ZF=41 G MFR^ZAA02GFORMP1:$P(TN,"`",3)>1
SEL5 G SEL0:TP'["W"
WRITONLY I +$P(TP,"W",2)=0 G END:'$D(REFRESH),FORM
 R T#2:+$P(TP,"W",2) S TJ=";TM" G SEL4:'$T X ZAA02G("T") S TY=^ZAA02G(.3,ZAA02G,0),TJ="",ZF=$A(TY,$F(TY,ZF)) G SEL4:ZF=13,SEL3:'$D(Y(0)),SEL3:$P(Y(0),"\",2)'[$P(^ZAA02G(.3),"\",ZF+2) S TJ=";"_$P(^(.3),"\",ZF+2) G SEL4
 ;
SEL6 X TQF F TA=TA+1:1 X TQ I TA=TB S TX=X X:TP["V" TS S:TP["M" X(TA)=TX S:TP'["M" T=TX Q
 Q
SEL7 S TJ=";TIMEOUT" G SEL1
BEG G ^ZAA02GFORMP
FORM S REFRESH=TT_":"_(TL+TT+1)_":"_TF_":"_(TW+TF) G END
T K Y S Y="10,15\BLRH\1\Sample 1\\Apples,Apricots,Bananas,Grapes,Grapefruit,Melons,Oranges,Peaches,Strawberries,Tangerines" D ^ZAA02GFORMP Q
G K Y S Y="10,15\BVLRH\1\Sample 1\\",Y(0)="\\^MAIL\X" D ^ZAA02GFORMP Q
