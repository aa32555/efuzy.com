%ZAA02GEDPO1 ;;%AA UTILS;1.24;SUBR: WINDOWS #2;17MAY91  11:13
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
OTH S TI=TO,TU=TDP*$S('TC:99,1:TC) X TQF I TA=0!(TEN'="~") F TA=0:1:TU X TQ Q:TO=""
        S TC=$S(TC'?1.N:TA+.001,1:TC) S:0'[TO TN="`"_TC S TO=TI
        S TD=TDP I TD-1*TC>TA S TD=TA\TC+1 ; S:TA<TU TU=TA S TD=TA/TC+.9\1 S:TD["." TD=TD+.9\1
O1 I TN["`" S TM=$P(TN,"`",3)+1,TN(TM)=TMM_"`"_TO,$P(TN,"`",3)=TM
O2 S TI=0,TM=TO X TQF G:TP["F" C0 K TJ F TJ=1:1:TC F TI=TI+1:1:TI+TD X TQ G:TO="" O3 X TS S TJ(TJ,80-$L(TX))=""
O3 S TO=TM
SET I $O(TJ(TC\1,""))="",+TC>0 S TC=TC-1 G SET
        S TV=82+$P(TP,"P",2) I $P(Y,"\",5)'="" F TJ=1:1:TC S TJ(TJ,80-$L($P(Y,"\",5)))=""
COL S TW=1,%C=TF+1 F TJ=1:1:TC S TW=TW+TV-$O(TJ(TJ,"")),TC(TJ)=%C,%C=TF+TW
        I $L($P(Y,"\",4))>TW S TW=$L($P(Y,"\",4))+4
        G:%C<ZAA02G("C") C3 I TC=1 G C3:TF<2 S TF=ZAA02G("C")-TW-2 S:TF<1 TF=1 G COL
        S:TN'["`" TN="`"_TC S TC=TC-1,TU=TD*TC S:$D(TN)<2 TN(1)="0`"_TO,$P(TN,"`",3)=1 G COL
C3 I TN["`" S TB=$P(TN,"`",5)-TW S:TB>0 TW=$P(TN,"`",5) S $P(TN,"`",5)=TW I TC>1,TB>TC S TV=TB\TC+TV G COL
C0 G C1:'$D(TMO) S TM=TO X TQF F TJ=1:1:TC*TD X TQ Q:TO=""  I TMO']TO S TMO=TMM+TJ,TO=TM G C1
        I TM'="",TN["`" S TMM=TMM+TJ G MNX
        S TMO=TMM+TJ-1,TO=TM
C1 K TJ S:TD<1 TD=1 S TL=$P(Y,"\",5)'=""+TD S:TT="" TT=$S(TP["C":%R,TP["T":1,TP["F":1,1:ZAA02G("R")-TL-1) I ZAA02G("RON")="" S TV=1,TW=TW+2,TR=$P(ZAA02G("a"),"`"),TRO=$P(ZAA02G("a"),"`",2) W $S(TP["H":ZAA02G("HI"),1:ZAA02G("LO")) G C2
        S TV=ZAA02G($S(TP["H":"HI",1:"LO")),TRO=TV_ZAA02G("RON"),TR=ZAA02G("ROF")_TV,TV=0 S:TP'["R" TE=TRO,TRO=TR,TR=TE W ZAA02G("Z"),TRO
C2 S %C=TF I TP["F" S %R=TT W @ZAA02GP,*13,ZAA02G("CS") G LIST
        I TP["L" S TE=ZAA02G("VL")_$J("",TW)_ZAA02G("VL"),TM="",$P(TM,ZAA02G("HL"),TW+1)="" D:TP["T" 1,2,3 D:TP'["T" 3,4,1 G LIST
        S TE=$J("",TW+2) I TP["T" F %R=TT:1:TT+TL+1-(TC["."*2) W @ZAA02GP,TE
        E   F %R=TT+TL+1-(TC["."*2):-1:TT W @ZAA02GP,TE
LIST K TB S TB=TT-(TC["."),%R=TT I $L($P(Y,"\",4)) S %C=TW-$L($P(Y,"\",4))\2+%C+1 W:$P(Y,"\",4)["*" TR W @ZAA02GP,$TR($P(Y,"\",4),"*"),TRO S %R=%R+1
        I TP["F" S TL=TU+2 I TP["L" S TZ=ZAA02G("HL"),%C=1 W @ZAA02GP,ZAA02G("G1"),TZ,TZ S TZ=TZ_TZ_TZ,%R=%R+1 X "F TM=1:1:26 W TZ" W ZAA02G("G0")
        D:$P(Y,"\",5)'="" HEAD I TP["F" S TB=%R-1
        S TZ=$C($S(ZAA02G["DTMPC":128,1:0)),TL(0)=TZ_" "_TZ,TL(1)=TZ_ZAA02G($S(TP["H":"LO",1:"HI"))_" "_TZ S:TN["`" $P(TN,"`")=TMM S TM=TMM,TE="TY="_ZAA02GP_"_TL($D(X(TM)))",TH="",TG=255\(TD*TC+1)-1 X TQF
        I 'TV F TJ=1:1:TC S %C=TC(TJ),%R=TB F TM=TM+1:1:TM+TD X TQ G L1:TO="" S %R=%R+1,@TE X TS S:TX'[TOV TB(TM)=TY_TX_" ",TH=TH_"\"_$E(TX,1,TG) S:TX[TOV TX=$TR(TX,TOV),TH=TH_"\" W TY,TX,TRO
        I TV F TJ=1:1:TC S %C=TC(TJ),%R=TB F TM=TM+1:1:TM+TD X TQ G L1:TO="" S %R=%R+1,@TE X TS S:TX'[TOV TB(TM)=TY_" "_TX,TH=TH_"\"_$E(TX,1,TG) S:TX[TOV TX=$TR(TX,TOV),TH=TH_"\" W TY,TRO,TX,TRO
L1 G ^ZAA02GEDPO2
HEAD S %R=TB+1 F TJ=1:1:TC S %C=TC(TJ)+1 W @ZAA02GP,ZAA02G("UO"),TRO,$P(Y,"\",5),ZAA02G("UF")
        S TB=TB+1 W TRO Q
1 S %R=TT W @ZAA02GP,ZAA02G("G1"),ZAA02G("TLC"),TM,ZAA02G("TRC"),ZAA02G("G0") Q
2 W ZAA02G("G1") F %R=TT+1:1:TT+TL W @ZAA02GP,TE
        W ZAA02G("G0") Q
3 S %R=TT+TL+1 W @ZAA02GP,ZAA02G("G1"),ZAA02G("BLC"),TM,ZAA02G("BRC"),ZAA02G("G0") Q
4 W ZAA02G("G1") F %R=TT+TL:-1:TT+1 W @ZAA02GP,TE
        W ZAA02G("G0") Q
MNX S TC=$P(TN,"`",2),TA=TU G O1
MFR S $P(TN,"`",3)=2
MPR S TO=$P(TN,"`",3)-1,$P(TN,"`",3)=TO-1,TO=TN(TO),TMM=+TO,TO=$P(TO,"`",2),TC=$P(TN,"`",2),TA=TU G O1
BEG G ^ZAA02GEDPO
        ;
