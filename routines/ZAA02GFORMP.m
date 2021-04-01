ZAA02GFORMP ;PG&A,ZAA02G-FORM,2.62,POP UP/PULL DOWN MENUS;05DEC93  20:32
 ;Copyright (C) 1985,89,91,92 Patterson, Gray and Assoc., Inc.
 ;
BEG N TA,TB,TC,TD,TE,TF,TG,TH,TI,TJ,TL,TM,TN,TO,TQO,TP,TQ,TQN,TR,TS,TSP,TT,TU,TV,TW,TT,TY,TZ,ZF,TRO,TMM,TMN,TEN,TFK,TDP,TOV,TQF,TVL,TOX,TEE,TEB,TEZ X ^ZAA02G("ECHO-OFF")
 S TP=$P(Y,"\",2),TC=$S(TP["F":1,1:$P(Y,"\",3)),TF=Y+(Y<1),TT=$P($P(Y,"\"),",",2),TDP=$P(Y,"\",5)'=""*-1+23-$S('TC:22,TP["C":%R,+TT:TT,1:1),TQN="Y",(TMM,TO,TA)=0,TEN="~",TS="S TX=Y(X)",TMN=99999,TFK="",TOV=$S(TP["O":$C(+$P(TP,"O",2)),1:"*")
 S TOX=$S($D(X):X,1:""),X=""
 I $D(Y(0)) S ZF=Y(0) D MF S TMN=$P(ZF,"\",9),TDP=$S(ZF<TDP&ZF:+ZF,1:TDP),TFK=$P(ZF,"\",2)
 I TS["~",TS'["""~" S TW=$P(Y(0),"\",4),TSP=$J("",80),TS="S TX=",TM=$S(TP["G":"_TVL_",1:"_") S:TM["T" TVL=ZAA02G("G1")_ZAA02G("VL")_ZAA02G("G0")_" "
 I  F TJ=1:1:$L(TW,"~") S:TJ>1 TSP(TJ)=TN S TI=$P(TW,"~",TJ),TN=$P(TI,";",2) Q:TI=""  S TS=TS_"$E("_$S(TN["R":"$J("_$P(TI,";")_",",1:"$E("_$P(TI,";")_",1,")_(+TN)_")_TSP,1,"_(TJ<$L(TW,"~")+TN)_")"_$S(TJ<$L(TW,"~"):TM,1:"")
 I TP["F" S TC(1)=TF,TW=80-TF-TF,TDP=TDP-(TP["L")-($P(Y,"\",4)'="")-($P(Y,"\",5)'=""*2)
 I TP["M",TOX'="" S TJ=$P(TOX,";") K X S X=TJ F TJ=1:1 S ZF=$P(TOX,",",TJ) Q:ZF=""  S X(ZF)=""
 S:TDP<0 TDP=1 I $D(ZAA02GPOPALT) S TQF="S TQ="""_ZAA02GPOPALT_"""" K ZAA02GPOPALT,TMO G OTH
 I 0'[X,$D(@TQN@(X)) S X=$TR($S(+X=X:X-1E-9,1:$E(X,1,$L(X)-1)_$C($A(X,$L(X))-1)_"~"),"`","_")
 I $D(TMO) K:TMO="" TMO
 S TQF="S TQ=""S X=$O(@TQN@(X)) S:X]TEN X=""""""""""" I TQN'="Y",$O(Y(0)) S TB=$O(Y(0)) I $D(Y(TB))#2,Y(TB)["\" S $P(TQF,"""",6)=" I X="""""""" D MFX^ZAA02GFORMP",TQM=0
 G OTH:TQN'="Y",OTH:TP["Y" S TB=$P(Y,"\",6) F TA=1:1:$L(TB,",") S Y(TA)=$P(TB,",",TA)
 S:TDP*TC<TA TA=0
OTH S TN=X G ^ZAA02GFORMP1
MF S TQN=$S($P(ZF,"\",3)]"":$P(ZF,"\",3),1:TQN),TS="S TX="_$S($P(ZF,"\",4)]"":$P(ZF,"\",4),1:"@TQN@(X)"),TMO=$P(ZF,"\",7),TEN=$P(ZF,"\",8) K:TMO="" TMO
 S X=$P(ZF,"\",5) S:X_TQN="Y" X=0 S:TEN="" TEN="~" Q
MFX S TQM=$O(Y(TQM)) Q:TQM=""  S ZF=Y(TQM) D MF X TQ Q
