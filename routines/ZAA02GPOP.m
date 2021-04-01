ZAA02GPOP ;PG&A,TOOLKIT I,1.51,POP UP/PULL DOWN MENUS;2014-07-10 17:23:46;;;20MAR96  08:58
 ;Copyright (C) 1985,89,91 Patterson, Gray and Assoc., Inc.
 ;
 ; see ZAA02GPOPDOC for info
 ;
BEG D:$D(ZAA02G)<10 INIT^ZAA02GDEV X ^ZAA02G("TERM-ON"),^ZAA02G("WRAP-OFF"),^ZAA02G("ECHO-OFF")
 S TP=$P(Y,"\",2),TC=$S(TP["F":1,1:$P(Y,"\",3)),TF=Y+(Y<1),TT=$P($P(Y,"\"),",",2),TDP=$P(Y,"\",5)'=""*-1+23-$S('TC:22,TP["C":%R,+TT:TT,1:1) S:TC="" TC=1
 S TQN="Y",(TMM,TO,TA)=0,TEN="~",TS="S TX=Y(TO)",TMN=99999,TFK="",TOV=$S(TP["O":$C(+$P(TP,"O",2)),1:"*")
 I $D(Y(0)) S ZF=Y(0) D MF S TMN=$P(ZF,"\",9),TDP=$S(ZF<TDP&ZF:+ZF,1:TDP),TFK=$P(ZF,"\",2)
 I TS["`",TS'["""`" S TW=$P(Y(0),"\",4),TSP=$J("",80),TS="S TX=",TM=$S(TP["G":"_TVL_",1:"_") S:TM["T" TVL=ZAA02G("G1")_ZAA02G("VL")_ZAA02G("G0")_" " S TB="S:$L(TQ)+$L(TS)>255 TSX=$E(TS,1,$L(TS)-1),TS=""X TSX S TX=TX_"" S TS=TS_TQ"
 I  F TJ=1:1:$L(TW,"`") S:TJ>1 TSP(TJ)=TN S TI=$P(TW,"`",TJ),TN=$P(TI,";",2) Q:TI=""  S TQ="$E("_$S(TN["R":"$J("_$P(TI,";")_",",1:"$E("_$P(TI,";")_",1,")_(+TN)_")_TSP,1,"_(TJ<$L(TW,"`")+TN)_")"_$S(TJ<$L(TW,"`"):TM,1:"") X TB
 I TP["K" S TS=TS_" S:$D(TH) TZ=TC(TJ+1)-%C-1,TX=$E($J("""",TZ-$L(TX)\2)_TX_$J("""",TZ),1,TZ-1)"
 I TP["F" S TC(1)=TF,TW=80-TF-TF,TDP=TDP-(TP["L")-($P(Y,"\",4)'="")-($P(Y,"\",5)'=""*2)
 I TP["M",$D(X) S TJ=$P(X,";") K X S X=TJ F TJ=1:1 S ZF=$P(X,",",TJ) Q:ZF=""  S X(ZF)=""
 I TP["w" S TS=TS_" S:TX[""|"" TX(TO)=TX,TX=$TR(TX,""|"")"
 S:TDP<0 TDP=1 I $D(ZAA02GPOPALT) S TQF="S TQ="""_ZAA02GPOPALT_"""" K ZAA02GPOPALT G OTH
 I 0'[TO,$D(@TQN@(TO)) S TO=$TR($S(+TO=TO:TO-1E-9,1:$E(TO,1,$L(TO)-1)_$C($A(TO,$L(TO))-1)_"~"),"`","_")
 S TQF="S TQ=""S TO=$O(@TQN@(TO)) S:TO"_$S(TEN?.N:">",1:"]")_"TEN TO=""""""""""" I TQN'="Y",$O(Y(0)) S TB=$O(Y(0)) I $D(Y(1))#2,Y(1)["\" D CMF
 G OTH:TQN'="Y",OTH:TP["Y" S TB=$P(Y,"\",6) F TA=1:1:$L(TB,",") S Y(TA)=$P(TB,",",TA)
 S:TDP*TC<TA TA=0
OTH S TN=TO G ^ZAA02GPOP1
MF S TQN=$S($P(ZF,"\",3)]"":$P(ZF,"\",3),1:TQN),TS="S TX="_$S($P(ZF,"\",4)]"":$P(ZF,"\",4),1:"@TQN@(TO)"),TMO=$P(ZF,"\",7),TEN=$P(ZF,"\",8) K:TMO="" TMO
 S TO=$P(ZF,"\",5) S:TO_TQN="Y" TO=0 S:TEN="" TEN="~" Q
MFX S TQM=$O(Y(TQM)) Q:TQM=""  S ZF=Y(TQM) D MF X TQ Q
CMF S $P(TQF,"""",6)=" I TO="""""""" D MFX^ZAA02GPOP",TQM=0 S:$P(Y(1),"\",10)["R" TQF=$P(TQF,"S TQ=")_"S TQM="""""" D MFX^ZAA02GPOP S TQ="_$P(TQF,"S TQ=",2,99)
