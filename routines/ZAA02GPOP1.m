ZAA02GPOP1
OTH S TI=TO,TU=TDP*$S('TC:99,1:TC) X TQF I TA=0!(TEN'="~") F TA=0:1:TU X TQ Q:TO=""
	S TC=$S(TC'?1.N:TA_".",1:TC) S:0'[TO TN="`"_TC S TO=TI
	S TD=TDP I TD*TC>TA S:TA<TC&TA TC=TA_$S(TC[".":".",1:"") S TD=TA/TC+.9\1
O1 I TN["`" S TM=$P(TN,"`",3)+1,TN(TM)=TMM_"`"_TO,$P(TN,"`",3)=TM
O2 S TI=0,TM=TO X TQF G:TP["F" C0 K TJ,TH F TJ=1:1:TC F TI=TI+1:1:TI+TD X TQ G:TO="" O3 X TS S TJ(TJ,80-$L($TR(TX,TOV,"")))=""
O3 S TO=TM
SET I $O(TJ(TC\1,""))="",+TC>.1 S TC=TC-1 G SET
	S TV=82+$P(TP,"P",2) I $P(Y,"\",5)'="" F TJ=1:1:TC S TJ(TJ,82-$L($P(Y,"\",5)))=""
COL S TW=1,%C=TF+1 S:TS["TVL"!($G(TSX)["TVL") TW=$L($P(Y(0),"\",4),"`")-1*(2-$L($G(TVL)))+1 F TJ=1:1:TC S TW=TW+TV-$O(TJ(TJ,"")),TC(TJ)=%C,%C=TF+TW
	S:$L($P(Y,"\",4))>TW TW=$L($P(Y,"\",4))+4 S:$L($P($G(Y(0)),"\",6))+($P($G(Y(0)),"\",6)["*"*10)>TW TW=$L($P(Y(0),"\",6))+($P(Y(0),"\",6)["*"*10)+2
	I $D(LNG),LNG>TW S TW=LNG+2
	G:%C<ZAA02G("C") C3 I TC=1 G C3:TF<2 S TF=ZAA02G("C")-TW-2 S:TF<1 TF=1 G COL
	S TC=TC-1,TD=TD/TC+.9\1+TD,TU=TD*TC I TD>TDP S TD=TDP,TU=TD*TC S:$D(TN)<2 TN(1)="0`"_TO,$P(TN,"`",2,3)=TC+1_"`"_1
	G O2
C3 S TC(TJ+1)=%C I TN["`" S TB=$P(TN,"`",5)-TW S:TB>0 TW=$P(TN,"`",5) S $P(TN,"`",5)=TW I TC>1,TB>TC S TV=TB\TC+TV G COL
C0 G C1:'$D(TMO) S TM=TO,TL=$S(+TMO=TMO:"TMO'>TO",1:"TMO']TO") X TQF F TJ=1:1:TC*TD X TQ Q:TO=""  I @TL S TMO=TMM+TJ,TO=TM G C1
	I TO'="",TN["`" S TMM=TMM+TJ G MNX
	S TMO=TMM+TJ,TO=TM
C1 K TJ I TD<1 S TD=1 I TP'["Y" W *7 S X=$G(X)_";EXnomatch" G END^ZAA02GPOP2
	S TL=$P(Y,"\",5)'=""+TD S:TT="" TT=$S(TP["C":%R,TP["T":1,TP["F":1,1:ZAA02G("R")-TL-1) I ZAA02G("RON")="" S TV=1,TW=TW+2,TR=$P(ZAA02G("a"),"`"),TRO=$P(ZAA02G("a"),"`",2) W $S(TP["H":ZAA02G("HI"),1:ZAA02G("LO")) G C2
	S TV=ZAA02G($S(TP["H":"HI",1:"LO")),TRO=TV_ZAA02G("RON"),TR=ZAA02G("ROF")_TV,TV=0 S:TP'["R" TE=TRO,TRO=TR,TR=TE W ZAA02G("Z"),TRO
C2 K TB S %C=TF I TP["F" S %R=TT W @ZAA02GP,*13,ZAA02G("CS") G LIST
	I $D(TEB),$P(TEB,",",2)=TW G L3
	I ZAA02G["COLOR",TF+TW<79,TT+TL<23 S TEMSM=$S(ZAA02G["MSM":$C(27)_"[40m ",1:$C(255,66,0,32))_TRO
	I TP["L" S TE=ZAA02G("VL")_$J("",TW)_ZAA02G("VL"),TM="",$P(TM,ZAA02G("HL"),TW+1)="" D:TP["T" 1,2,3 D:TP'["T" 3,4,1 G LIST
	S TE=$J("",TW+2) I TP["T" F %R=TT:1:TT+TL+1-(TC["."*2) W @ZAA02GP,TE
	E  F %R=TT+TL+1-(TC["."*2):-1:TT W @ZAA02GP,TE
LIST I $D(TSP)>2,TP["G" W ZAA02G("G1") S %R=TT,%C=TF F TJ=0:0 S TJ=$O(TSP(TJ)) Q:'TJ  S %C=%C+TSP(TJ)+3 W @ZAA02GP,ZAA02G("TI")
	W ZAA02G("G0") S TB=TT-(TC["."),%R=TT I $L($P(Y,"\",4)) S %C=TW-$L($P(Y,"\",4))\2+TF+1 W:$P(Y,"\",4)["*" TR W @ZAA02GP,$TR($P(Y,"\",4),"*",""),TRO
	I TP["F" S TL=TU+2 I TP["L" S TZ=ZAA02G("HL"),%C=1 W @ZAA02GP,ZAA02G("G1"),TZ,TZ S TZ=TZ_TZ_TZ,%R=%R+1 X "F TM=1:1:26 W TZ" W ZAA02G("G0")
	D:$P(Y,"\",5)'="" HEAD S:TP["F" TB=%R-1 S TEE="" G L4
L3 S TB=TEB S:TP["L" TEE=$J("",TW)_ZAA02G("G1")_ZAA02G("VL")_ZAA02G("G0"),TM=ZAA02G("G1"),$P(TM,ZAA02G("HL"),TW)=ZAA02G("G0") S:TP'["L" TEE=$J("",TW+2),TM=TEE S %R=TT+TL-(TC["."*2)+1,%C=TC(1) W @ZAA02GP,TM
L4 S TZ=$C($S(ZAA02G["DTMPC":127,1:0)),TL(0)=TZ_" "_TZ,TL(1)=TZ_ZAA02G($S(TP["H":"LO",1:"HI"))_">"_TZ S:TN["`" $P(TN,"`")=TMM
	S TEZ=$S(TEE="":"I 1",1:"W @ZAA02GP,TEE"),TM=TMM,TE="TY="_ZAA02GP_"_TL($D(X(TM)))",TH="",TG=255\(TD*TC+1)-1 X TQF
	I 'TV F TJ=1:1:TC S %C=TC(TJ),%R=TB F TM=TM+1:1:TM+TD X TQ G L1:TO="" S %R=%R+1,@TE X TS X:TJ=1 TEZ S:TX'[TOV TB(TM)=TY_TX_" ",TH=TH_"\"_$E(TX,1,TG) S:TX[TOV TX=$TR(TX,TOV,""),TH=TH_"\" W TY,TX,TRO
	I TV F TJ=1:1:TC S %C=TC(TJ),%R=TB F TM=TM+1:1:TM+TD X TQ G L1:TO="" S %R=%R+1,@TE X TS X:TJ=1 TEZ S:TX'[TOV TB(TM)=TY_" "_TX,TH=TH_"\"_$E(TX,1,TG) S:TX[TOV TX=$TR(TX,TOV,""),TH=TH_"\" W TY,TRO,TX,TRO
L1 G:$D(TSP)<2!(TP'["G") L5 I TT+TL>%R F %R=%R+1:1:TT+TL S %C=TC(1) X TEZ W ZAA02G("G1") S %C=TF F TJ=0:0 S TJ=$O(TSP(TJ)) Q:'TJ  S %C=%C+TSP(TJ)+3 W @ZAA02GP,ZAA02G("VL")
	S %R=TT+TL+1,%C=TF W ZAA02G("G1") F TJ=0:0 S TJ=$O(TSP(TJ)) Q:'TJ  S %C=%C+TSP(TJ)+3 W @ZAA02GP,ZAA02G("BI")
	W ZAA02G("G0") G L2
L5 I $D(TEB),TJ=1 S %C=TC(1) F %R=%R+1:1:TT+TL X TEZ
L2 S TEB=TB_","_TW G ^ZAA02GPOP2
	;
HEAD S %R=TB+1 F TJ=1:1:TC S %C=TC(TJ)+1 W @ZAA02GP,ZAA02G("UO"),TRO,$P(Y,"\",5),ZAA02G("UF")
	S TB=TB+1 W TRO
	I $D(TSP)>2,TP["G" W ZAA02G("G1") S %C=TF F TJ=0:0 S TJ=$O(TSP(TJ)) Q:'TJ  S %C=%C+TSP(TJ)+3 W @ZAA02GP,ZAA02G("VL")
	W ZAA02G("G0") Q
	;
1 S %R=TT W @ZAA02GP,ZAA02G("G1"),ZAA02G("TLC"),TM,ZAA02G("TRC"),ZAA02G("G0") Q
2 W ZAA02G("G1") F %R=TT+1:1:TT+TL W @ZAA02GP,TE,$G(TEMSM)
	W ZAA02G("G0") Q
3 S %R=TT+TL+1 W @ZAA02GP,ZAA02G("G1"),ZAA02G("BLC"),TM,ZAA02G("BRC"),ZAA02G("G0") I $D(TEMSM) W TEMSM S %R=%R+1 W @ZAA02GP,ZAA02G("RT"),ZAA02G("RT") F %R=0:1:TW W TEMSM
	Q
4 W ZAA02G("G1") F %R=TT+TL:-1:TT+1 W @ZAA02GP,TE,$G(TEMSM)
	W ZAA02G("G0") Q
	;
MNX S TC=$P(TN,"`",2),TA=TU G O1
MFR S $P(TN,"`",3)=2
MPR S TO=$P(TN,"`",3)-1,$P(TN,"`",3)=TO-1,TO=TN(TO),TMM=+TO,TO=$P(TO,"`",2),TC=$P(TN,"`",2),TA=TU G O1
BEG G ^ZAA02GPOP
	;