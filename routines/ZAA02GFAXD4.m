ZAA02GFAXD4 ;PG&A,ZAA02G-FAX,1.36,DEVICE DRIVER;3SEP94 3:46P;;;05SEP97  13:15
 ;Copyright (C) 1991-1994, Patterson, Gray and Associates Inc.
 ;
SEND S (CSI,DCS)="",ST=$H I DT(3)[$P(FAXP,"\") S DT(3)=$P(DT(3),$P(FAXP,"\"),2,9)
 S (RVA,RVB)="" F J=0:1:254 S A=^ZAA02GFAXC(0,4,J) S B=0,L=1 F K=8:-1:1 S B=$E(A,K)*L+B,L=L+L I K=1 S RVB=RVB_$C(B),RVA=RVA_$C(J)
 ;
 S DD="DATA" F SN=1:1 R A:0 Q:'$T
 F SN=1:1 S SCR=$P($T(@DD+SN),";;",2,99) Q:SCR=""  H 0 X:$D(TEST) "U 0 W ""C: "",SCR,! U DV" D INQ X $P(SCR,"`",6-OK) Q:'OK
 Q:OK  F J=1:1 D ERROR^ZAA02GFAXD2 S JOB=$P(JB,",") Q:JOB=""  S JB=$P(JB,",",2,99)
 Q
XMT S C=$P($H,",",2),BL=$E(^ZAA02GFAXC(0,2,1),3,255),BL=$C(27,122,3,$L(BL),0)_BL
 S TFL=0 W $C(27,122,4,2),"THIS IS A TEST",!,"ANOTHER LINE",!!!
 D RSEND^ZAA02GFAXD1 S NL=@ZAA02GFAXD@(PG),X=$D(^(PG,0)),X=$D(^(NL)),X=$D(^ZAA02GFAXC("FX",2,1))
 W "BACK FROM RSEND",!
 R A:0 S B=A R A:0 S B=B_A R A:0 G:B_A["<" XMTA W BL I TP F TFL=2:1:TP-.1*6#300 W !
 S CV=0 I CV,PG=1,$E(CG)="^",$D(@CG) S CC="",TFL=TFL+$S($D(@CG)#2:@CG,1:0),FL=$D(@CG@(0)) F FL=1:1 S CC=$O(^(CC)) Q:CC=""  S B=$E(^(CC),3,255) D XMT1 R B:0 I B["<" D XMTA Q:B=""
 I CV,PG=1 S CC="",TFL=TFL+46,FL=$D(^ZAA02GFAXC("FX",2,1)) F FL=1:1 S CC=$O(^(CC)) Q:CC=""  S B=$E(^(CC),3,255) D XMT1 R B:0 I B["<" D XMTA Q:B=""
 S TFL=TFL+NL,X=$D(@ZAA02GFAXD@(PG,0)) F FL=1:1:NL S B=$E(^(FL),3,255) D XMT1 R B:0 I B["<" D XMTA Q:B=""
 W !,"FIRST SECTION",!
 F TFL=TFL:1:$S(PTL:PTL-64,1:TFL+25) W BL
 S CC="" F TFL=TFL:1 S CC=$O(^ZAA02GFAXC("FX",1,CC)) Q:CC=""  S B=$E(^(CC),3,255) D XMT1 R B:0 I B["<" D XMTA Q:B=""
 S X=$D(@ZAA02GFAXD@(0,PG,0)),CC="" F TFL=TFL:1 S CC=$O(^(CC)) Q:CC=""  S B=$E(^(CC),3,255) D XMT1 R B:0 I B["<" D XMTA Q:B=""
 F TFL=TFL:1:TFL+10 W BL
 W # G AGAIN
 ;
XMT1 S B=$TR(B,RVA,RVB) W $C(27,122,3,$L(B),0),B Q
 F JJ=64,17,19 I B[$C(JJ) F JL=2:1:$L(B,$C(JJ)) S B=$P(B,$C(JJ))_$S(JJ=17:"@Q",JJ=19:"@S",1:"@@")_$P(B,$C(JJ),2,99)
 S JJ=$L(B)#256,JL=$L(B)\256 W $C(27,122,3)_$S(JJ=17:"@Q",JJ=19:"@S",JJ=64:"@@",1:$C($L(B))),$C(JL),B Q
XMTA R BB:1 S B=B_B I $D(TEST) U 0 W !,"M: ",B,! U DV
XMTB I B["<24" D CSI S ST=$H
 I B["<11" S ER=4,B="" Q
 I B["<13" S ER=6,B="" Q
 S B=$P(B,">",2,99) I B="" S B=1 Q
 I B["<" G XMTB
 Q
 ;
AGAIN S PG=PG+1 I PG'>PGN G XMT
 D FPOST^ZAA02GFAXD1,JOB^ZAA02GFAXD1 I JOB G XMT
 Q
 ;
INQ S OK=0,X1=$P(SCR,"`"),DN=$P(SCR,"`",2),IT=$P(SCR,"`",3),T=$P(SCR,"`",4)
 I X1["*" S X1=$P(X1,"*")_DT($E($P(X1,"*",2)))_$E($P(X1,"*",2,9),2,255)
 F J=1:1 R A:0 Q:'$T
 S DATA="" F J=1:1:IT W:X1["$C" @X1 W:X1'["$C" X1,*13 S T1=$P($H,",",2)+T F K=1:1:199 Q:$P($H,",",2)>T1  R A:T X:$D(TEST) "U 0 W:$L(A) ""R: "",A,! U DV" S:$L(DATA)+$L(A)<250 DATA=DATA_A_"\" G:A'?1"<"2N INQ1:DATA[DN
 Q
INQ1 S OK=1 Q
DIAL S OK=1,ER=3,DATA="" F K=1:0:8 R A:10 S:'$T K=K+1 S:$L(DATA)+$L(A)>255 DATA1=DATA,DATA="" S DATA=DATA_A_"\" S:DATA["<13" ER=6,OK=0 S:DATA["<11" ER=4,OK=0 D:DATA["<CSI" CSI I A'?1"<"2N Q:DATA["<23"  Q:'OK  Q:'$D(^ZAA02GFAXQ(.9,JOB))
 I $D(TEST) U 0 W "D: ",OK," ",ER," ",DATA,! U DV
 I OK S ST=$H G XMT
 Q
 ;
CSI S CSI=$TR($P($P(DATA,"CSI RECEIVED: ",2),"\"),""" ",""),DATA="" Q
 ;
DATA ;;
 ;;^hI*3`<21`3`1`D DIAL`S ER=3
 ;;^T``1`1
 ;;`<01`5`5
 ;;`<22`1`1
