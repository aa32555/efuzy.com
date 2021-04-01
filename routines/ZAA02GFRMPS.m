ZAA02GFRMPS ;PG&A,ZAA02G-FORM,2.62,Print Dialogue;10AUG86 2:56P
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
CTL NEW (DV,SCR,SN,ZAA02G,ZAA02GP)
 D PAINT
 D ASK
 I 14'[RX,SCR]"" D PRINT
 Q
 ;
PAINT S %R=3,%C=1 W:'$D(qt) @ZAA02GP,ZAA02G("CS")
 W:'$D(qt) ZAA02G("LO") F x="Enter Form Series","Enter Form Number","Print Field","Output Device"  W !!,$J(x,21)
 S %R=5,%C=23
 W:'$D(qt) ZAA02G("HI") F x="SCR","SN","FD","DV" W:$D(@x) @ZAA02GP,@x S %R=%R+2
 Q
 ;
ASK S ask="SCR;SN;FD;DV"
 F aski=1:1:$L(ask,";") D ASKER Q:aski<0
 Q
 ;
ASKER S %R=aski*2+3,ques=$P(ask,";",aski),X=$S($D(@ques):@ques,1:""),(PROMPT,RX)="" D @ques
 I RX=1!(RX=4)!(@ques="") S aski=aski-2
 Q
 ;
SCR S LNG=10 X ^ZAA02GREAD S SCR=X
 I SCR]"",14'[RX,'$D(^ZAA02GDISP(SCR)) S %C=23+10+2 W *7,@ZAA02GP,ZAA02G("RON")," Series Does Not Exist.  Press Return. ",ZAA02G("ROF") R *x W:'$D(qt) @ZAA02GP,ZAA02G("CL") S %C=23 G SCR
 Q
 ;
SN S LNG=10 X ^ZAA02GREAD S SN=X
 I SN]"",14'[RX,'$D(^ZAA02GDISP(SCR,SN)) S %C=23+10+2 W *7,@ZAA02GP,ZAA02G("RON")," Form Does Not Exist.  Press Return. ",ZAA02G("ROF") R *x W:'$D(qt) @ZAA02GP,ZAA02G("CL") S %C=23 G SN
 Q
 ;
FD S X=$D(^ZAA02GDISP(SCR,SN,0)),A=">" F I=1:1 S A=$O(^(A)) Q:A=""
 S NF=I-1,A=">" S:'$D(FD) FD=""
 S %R=3,%C=48 W:'$D(qt) @ZAA02GP,ZAA02G("RON")," FIELDS ",ZAA02G("ROF")
 D PULL
 S %R=3 W:'$D(qt) @ZAA02GP,ZAA02G("CL")
 S FD=$S(X=NB:FD,NB-1=X:"All",1:A(X)),%C=23,%R=9 S:X=NB RX=1
 W:'$D(qt) @ZAA02GP,ZAA02G("CL"),FD
 Q
 ;
PULL ;PULL:SEL2 STOLEN ALMOST VERBATIM FROM ^ZAA02GFRME2 (ADDED All, 2ND More)
 S (%R,SR)=4,(%C,SC)=45 W:'$D(qt) @ZAA02GP,ZAA02G("HI"),ZAA02G("G1"),ZAA02G("TLC") F I=1:1:12 W:'$D(qt) ZAA02G("HL")
 K TB S TY=" ",TJ="X="_ZAA02GP,X=$D(^ZAA02GDISP(SCR,SN,0)),%C=SC,B=ZAA02G("RT")_" " W:'$D(qt) ZAA02G("TRC")
 F I=1:1:15 S A=$O(^(A)) Q:A=""  S %R=%R+1,@TJ W X,ZAA02G("VL")," ",ZAA02G("G0") S TB(I)=X_B_A_" ",TY=TY_$E(A,1,4)_"\ ",A(I)=A W A,$J("",11-$L(A)),ZAA02G("G1"),ZAA02G("VL")
 S NB=I S:A="" NB=NB-1 S %C=SC,%R=%R+1 W:'$D(qt) @ZAA02GP,ZAA02G("VL"),$J("",12),ZAA02G("VL") S %R=%R+1 W:'$D(qt) @ZAA02GP,ZAA02G("VL")," "
 I NF>15 S B="More " S %C=%C+1,X="X="_ZAA02GP,@X,NB=NB+1,TB(NB)=X_" "_B,TY=TY_$E(B,1,4)_"\ " W:'$D(qt) ZAA02G("G0"),B,$J("",11-$L(B)),ZAA02G("G1"),ZAA02G("VL") S %R=%R+1,%C=SC W:'$D(qt) @ZAA02GP,ZAA02G("VL")," "
 S B="All " S %C=%C+1,X="X="_ZAA02GP,@X,NB=NB+1,TB(NB)=X_" "_B,TY=TY_$E(B,1,4)_"\ " W:'$D(qt) ZAA02G("G0"),B,$J("",11-$L(B)),ZAA02G("G1"),ZAA02G("VL") S %R=%R+1,%C=SC W:'$D(qt) @ZAA02GP,ZAA02G("VL")," "
 S B="Quit "  S %C=%C+1,X="X="_ZAA02GP,@X,NB=NB+1,TB(NB)=X_" "_B,TY=TY_$E(B,1,4)_"\ " W:'$D(qt) ZAA02G("G0"),B,$J("",11-$L(B)),ZAA02G("G1"),ZAA02G("VL")
 S %R=%R+1,%C=SC W:'$D(qt) @ZAA02GP,ZAA02G("BLC") F I=1:1:12 W:'$D(qt) ZAA02G("HL")
 W:'$D(qt) ZAA02G("BRC"),ZAA02G("G0")
SEL X ^ZAA02G("ECHO-OFF") S TG=" " F X=1:1:NB W:'$D(qt) ZAA02G("RON"),TB(X) R B#1 X ZAA02G("T") W:'$D(qt) ZAA02G("ROF"),TB(X) G:ZF=$C(13) SEL1 D:B?1AN SEL2 I ZF=ZAA02G("UK") S X=X-2 I X<0 S X=NB-1
 G SEL
 ;
SEL1 W:'$D(qt) ZAA02G("ROF"),ZAA02G("HI") X ^ZAA02G("ECHO-ON") S %C=SC F %R=%R:-1:SR W:'$D(qt) @ZAA02GP,ZAA02G("CL")
 I NF>15,NB-2=X S:A=""!($O(^ZAA02GDISP(SCR,SN,A))="") A=">~" G PULL
 W:'$D(qt) ZAA02G("HI") K TB,TG,TY,TJ,LB
 Q
 ;
SEL2 S TG=TG_B,TJ=$F(TY,TG) I TJ S X=$L($E(TY,1,TJ-1),"\")-1,ZF="" Q
 I $L(TG)>2 S TG=" " G SEL2
 S TG=" "
 Q
 ;
DV X ^ZAA02GREAD S DV=$S(X="":0,X=$I:0,1:X)
 Q
 ;
PRINT I DV'=0 O DV::0 E  S %R=14,%C=20 W:'$D(qt) @ZAA02GP,ZAA02G("HI"),"Device ",DV," is busy - Press RETURN and try later " R X#1 Q
 S %R=21,%C=34 W:'$D(qt) @ZAA02GP,ZAA02G("RON")," Please Wait ",ZAA02G("ROF")
 I DV=0 S %R=2,%C=1 W:'$D(qt) @ZAA02GP,ZAA02G("CS")
 U DV D ^ZAA02GFRMP1 U 0
 C:DV'=0 DV
 Q
