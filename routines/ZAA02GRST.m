ZAA02GRST ;,,1.41;;Input Text;04OCT90  12:57
 ;;Copyright (C) 1990 Patterson, Gray and Associates, Inc.
 ;;All rights reserved.
INIT N C,I,R,W,LC,TT,FC,NT,LNG,F,H,C,ZF,TX,IN
 D:$D(ZAA02G)+$D(ZAA02GP)+$D(ZAA02GX)+$D(ZAA02GY)'=14 FUNC^ZAA02GDEV
 X ^ZAA02G("TERM-ON"),^ZAA02G("WRAP-OFF")
 S:'$D(Y) Y="" S TT=$S(+$P(Y,",",2):+$P(Y,",",2),$D(%R):%R,1:1),FC=$S(+Y:+Y,$D(%C):%C,1:1),NT=+$P(Y,"\",3),LNG=+$P($P(Y,"\",3),",",2),TP=$P(Y,"\",2),H=$P(Y,"\",4)
 S:'NT NT=1 S:TT+NT>ZAA02G("R") NT=ZAA02G("R")-TT S:'LNG LNG=ZAA02G("C")-FC-(TP["L"*2) S IN=ZAA02G("Z")_$S(TP'["H":ZAA02G("LO"),1:"")_$S(TP["R":ZAA02G("RON"),1:"") F I=1:1:NT S:'$D(Y(I)) Y(I)=""
 I $S(TP["W":1,TP["P":1,1:0) D DSPLY
 S %R=TT,%C=FC,LC=FC+LNG-1,TX=1 D PAD W IN
PO W @ZAA02GP
RD R C#LC-%C+1 I C]"" S C=$TR(C,"`",""),Y(TX)=$E(Y(TX),0,%C-FC)_C_$E(Y(TX),%C-FC+$L(C)+1,LNG),%C=%C+$L(C) G:%C>LC WRAP
FK X ZAA02G("T") S ZAA02GF=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2) G @ZAA02GF:"RK,LK,UK,DK,IC,DC,RU,EF,IL,DL,CR,TB,RE,EX"[ZAA02GF,PO
UK G:TX=1 EX S TX=TX-1,%R=%R-1 G PO
DK G:TX=NT EX S TX=TX+1,%R=%R+1 G PO
RK G:TX=NT&(%C=LC) RD S %C=%C+1 S:%C>LC %C=FC,%R=%R+1,TX=TX+1 G PO
LK G:TX=1&(%C=FC) RD S %C=%C-1 S:%C<FC %C=FC+LNG-1,%R=%R-1,TX=TX-1 G PO
RU G:TX=1&(%C=FC) RD I %C=FC S %C=LC+1,TX=TX-1,%R=%R-1 W @ZAA02GP
 W *8,*32,*8 S Y(TX)=$E(Y(TX),0,%C-FC-1)_" "_$E(Y(TX),%C-FC+1,LNG),%C=%C-1 G RD
CR I TX<NT S %R=%R+1,TX=TX+1,%C=FC G PO
TB ;
EX F I=1:1:NT S X=Y(I) D STRP S Y(I)=X
 W ZAA02G("Z")
 I TP'["D" S %R=TT-(TP["P"),%C=FC-(TP["P"*2),X=$S(ZAA02G["VT220":$C(27,91)_(TP["P"*4+LNG)_"X",1:$J("",TP["P"*4+LNG)) F I=1:1:TP["P"*2+NT W @ZAA02GP,X S %R=%R+1
 X ^ZAA02G("WRAP-ON"),^ZAA02G("TERM-OFF") Q
IC S X=$E(Y(TX),0,%C-FC)_" "_$E(Y(TX),%C-FC+1,LNG+1) I $E(X,LNG+1)=" "!(TX=NT) S Y(TX)=$E(X,1,LNG) W $E(X,%C-FC+1,LNG) G PO
 S Y(TX)=X D INSWRAP G PO
DC S Y(TX)=$E(Y(TX),0,%C-FC)_$E(Y(TX),%C-FC+2,LNG)_" " W $E(Y(TX),%C-FC+1,LNG) G PO
EF S Y(TX)=$E(Y(TX),0,%C-FC)_$J("",LNG-%C+FC+1) W @ZAA02GP,$J("",LNG-%C+FC+1) G PO
IL I $TR(Y(NT)," ","")]"" W *7 G PO
 F I=NT-1:-1:TX S Y(I+1)=Y(I)
 S Y(TX)=$J("",LNG) D DSP G PO
DL F I=TX:1:NT-1 S Y(I)=Y(I+1)
 S Y(NT)=$J("",LNG) D DSP G PO
RE G PO
DSP N %R,%C S %R=TX+TT-1,%C=FC F I=TX:1:NT W @ZAA02GP,Y(I) S %R=%R+1
 Q
WRAP S L=$L(Y(TX)," ") I L=1!(TX=NT)!($E(Y(TX),LNG)=" ") S:TX=NT %C=LC S:TX<NT TX=TX+1,%R=%R+1,%C=FC G PO
 S W=$P(Y(TX)," ",L),Y(TX)=$P(Y(TX)," ",1,L-1),%C=FC+$L(Y(TX)) W @ZAA02GP,$J("",$L(W)+1) S Y(TX)=Y(TX)_$J("",LNG-$L(Y(TX)))
 S %R=%R+1,TX=TX+1,Y(TX)=W_$E(Y(TX),$L(W)+1,LNG),%C=FC W @ZAA02GP,W S %C=FC+$L(W) K W G RD
INSWRAP F I=1:1:NT S X=Y(I) D STRP S Y(I)=X
 I $L(Y(TX))'>LNG D PAD Q
 S X=TX,R=%R,C=%C
I1 I X=NT S Y(X)=$E(Y(X),1,LNG),%R=R,%C=C D PAD Q  ;Last line gets chopped
 I $L(Y(X))'>LNG S %R=R,%C=C D PAD Q
 S L=$L($E(Y(X),1,LNG)," "),W=$P(Y(X)," ",L,99),Y(X)=$P(Y(X)," ",1,L-1),L=$L(Y(X)),%C=FC+L W @ZAA02GP,$J("",LNG-L)
 S X=X+1,%R=%R+1,S=$S($E(Y(X))=" ":"",1:" "),Y(X)=W_S_Y(X),%C=FC W @ZAA02GP,$E(Y(X),1,LNG) G I1
PAD F I=1:1:NT S Y(I)=Y(I)_$J("",LNG-$L(Y(I)))
 Q
STRP N I F I=$L(X)-10:-10:0 Q:$E(X,I,255)'?." "
 F I=I+10:-1:0 Q:$E(X,I)'=" "
 S X=$E(X,1,I) Q
DSPLY W IN I TP["P" D POP S (TT,%R)=TT+1,(%C,FC)=FC+2 I 1
 E  S %R=TT,%C=FC D PAD
 F I=1:1:NT W @ZAA02GP,Y(I) S %R=%R+1
 Q
POP D BOX I H]"" S %R=TT,%C=LNG+4-FC-$L(H)\2+FC W @ZAA02GP,H
 Q
BOX N TW,TE,TM S %C=FC,TW=LNG+2
 I TP["L" S TE=ZAA02G("VL")_$J("",TW)_ZAA02G("VL"),TM="",$P(TM,ZAA02G("HL"),TW+1)="" D:TP["T" 1,2,3 D:TP'["T" 3,4,1 Q
 S TE=$J("",TW+2) I TP["T" F %R=TT:1:TT+NT+1 W @ZAA02GP,TE
 E   F %R=TT+NT+1:-1:TT W @ZAA02GP,TE
 Q
1 S %R=TT W @ZAA02GP,ZAA02G("G1")_ZAA02G("TLC")_TM_ZAA02G("TRC")_ZAA02G("G0") Q
2 W ZAA02G("G1") F %R=TT+1:1:TT+NT W @ZAA02GP,TE
 W ZAA02G("G0") Q
3 S %R=TT+NT+1 W @ZAA02GP,ZAA02G("G1")_ZAA02G("BLC")_TM_ZAA02G("BRC")_ZAA02G("G0") Q
4 W ZAA02G("G1") F %R=TT+NT:-1:TT+1 W @ZAA02GP,TE
 W ZAA02G("G0") Q
