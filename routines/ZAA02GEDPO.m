%ZAA02GEDPO
BEG S TP=$P(Y,"\",2),TC=$S(TP["F":1,1:$P(Y,"\",3)),TF=Y+(Y<1),TT=$P($P(Y,"\"),",",2),TDP=$P(Y,"\",5)'=""*-1+23-$S('TC:22,TP["C":%R,+TT:TT,1:1),TQN="Y",(TMM,TO,TA)=0,TEN="~",TS="S TX=Y(TO)",TMN=99999,TFK="",TOV=$S(TP["O":$E($P(TP,"O",2)),1:"*")
	X ^%T("ECHO-OFF") I $D(Y(0)) S ZF=Y(0) D MF S TMN=$P(ZF,"\",9),TDP=$S(ZF<TDP&ZF:+ZF,1:TDP),TFK=$P(ZF,"\",2)
	I TS["`",TS'["""`" S TW=$P(Y(0),"\",4),TSP=$J("",80),TS="S TX=" F TJ=1:1:$L(TW,"`") S TI=$P(TW,"`",TJ) Q:TI=""  S TS=TS_"$E($E("_$P(TI,";")_",1,"_($P(TI,";",2)-1)_")_TSP,1,"_$P(TI,";",2)_")_"
	I  S TS=$E(TS,1,$L(TS)-1)
	I TP["F" S TC(1)=TF,TW=80-TF-TF,TDP=TDP-(TP["L")-($P(Y,"\",4)'="")-($P(Y,"\",5)'=""*2)
	I TP["M",$D(X) S TJ=$P(X,";") K X S X=TJ F TJ=1:1 S ZF=$P(X,",",TJ) Q:ZF=""  S X(ZF)=""
	I 0'[TO,$D(@TQN@(TO)) S TO=$S(+TO=TO:TO-1E-9,1:$E(TO,1,$L(TO)-1)_$C($A(TO,$L(TO))-1)_"~")
	S:TDP<0 TDP=1 I $D(ZAA02GPOPALT) S TQF="S TQ="""_ZAA02GPOPALT_"""" K ZAA02GPOPALT G OTH
	S TQF="S TQ=""S TO=$O(@TQN@(TO)) S:TO]TEN TO=""""""""""" I TQN'="Y",$O(Y(0)) S TB=$O(Y(0)) I $D(Y(TB))#2,Y(TB)["\" S $P(TQF,"""",6)=" I TO="""""""" D MFX^ZAA02GEDPO",TQM=0
	G OTH:TQN'="Y",OTH:TP["Y" S TB=$P(Y,"\",6) F TA=1:1:$L(TB,",") S Y(TA)=$P(TB,",",TA)
	S:TDP*TC<TA TA=0
OTH S TN=TO G ^ZAA02GEDPO1
MF S TQN=$S($P(ZF,"\",3)]"":$P(ZF,"\",3),1:TQN),TS="S TX="_$S($P(ZF,"\",4)]"":$P(ZF,"\",4),1:"@TQN@(TO)"),TMO=$P(ZF,"\",7),TEN=$P(ZF,"\",8) K:TMO="" TMO
	S TO=$P(ZF,"\",5) S:TO_TQN="Y" TO=0 S:TEN="" TEN="~" Q
MFX S TQM=$O(Y(TQM)) Q:TQM=""  S ZF=Y(TQM) D MF X TQ Q
	;
	;