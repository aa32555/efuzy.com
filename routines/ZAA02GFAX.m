ZAA02GFAX ;PG&A,ZAA02G-FAX,1.36,MENU DRIVER;5JUL96 10:00A [ 01/12/1999   1:03 PM ]
C ;;Copyright (C) 1991-1996, Patterson, Gray and Associates Inc.
 D:$D(ZAA02GX)+$D(ZAA02G("ECHO-ON"))+$D(XX)'=3 SETUP S:'$D(ZAA02G(3)) ZAA02G(3)=$I
 I $D(^ZAA02GFAXC("FAX"))=0 D ^ZAA02GFAXI S ^ZAA02GFAXC("FAX")=""
TITLE D HEAD K CHR,TRM,LNG,PAT
 S %R=3,%C=5 W ZAA02G("LO"),@ZAA02GP,"Version ",$P($T(ZAA02GFAX),",",3),"  ",$P($T(C),";;",2) S cp=1
T1 K PASS S Y=$S('$D(ZAA02G(9)):"SYSTEM MANAGEMENT OPTIONS\Document Control\Modem Status\Configuration\PhoneBook Edit\Reports\Suspend/Resume Service\Quit\DMCPRSQ",1:@ZAA02G(9)@(18)) D SEL G:J=NE END I J>NE D HEAD G T1
 I J=2 S BL=22 D STATUS^ZAA02GFAXU G T1
 I J=1 D T4 G T1
 I J=3 D T3 G T1
 I J=4 S BL=23 D ^ZAA02GFAXQ2 G T1
 I J=5 D T2 G T1
 I J=6 D SUSPEND^ZAA02GFAXU G T1
 G T1
T2 S Y=$S('$D(ZAA02G(9)):"R E P O R T S\Fax/Modem Statistics\Initiator Statistics\Destination Statistics\Error Reports\Quit\FIDEQ",1:@ZAA02G(9)@(62)) D SEL Q:J=NE  I J>NE D HEAD G T2
 S TYP=3,BL=23,NX=5,SEL=0 I J=1 S EX="FAX" D ^ZAA02GFAXS G T2
 I J=2 S EX="INIT" D ^ZAA02GFAXS G T2
 I J=3 S EX="DEST" D ^ZAA02GFAXS G T2
 I J=4 K EX S TYP=5 D ^ZAA02GFAXS G T2
 G T2
T3 I '$D(PASS),$D(^ZAA02GFAXC("PASS")) D PASSWD E  K PASS Q
 S Y=$S('$D(ZAA02G(9)):"C O N F I G U R A T I O N    O P T I O N S\Basic System Parameters\Device Definition\System Defaults\Initialization\Font Editor\Test Modem Communication\Create and Send Test Fax\Modify Password\Quit\BDSIFTCMQ",1:@ZAA02G(9)@(63))
 D SEL Q:J=NE  I J>NE D HEAD G T3
 I J=1 D BEG2^ZAA02GFAXP G T3
 I J=2 D BEG1^ZAA02GFAXP G T3
 I J=4 D ^ZAA02GFAXI G T3
 I J=5 D ^ZAA02GFAXE G T3
 I J=3 D BEG3^ZAA02GFAXP G T3
 I J=6 D ^ZAA02GFAXD3 G T3
 I J=7 D T^ZAA02GFAXD3 G T3
 I J=8 D PASSWD^ZAA02GFAXU G T3
 G T3
T4 S Y=$S('$D(ZAA02G(9)):"D O C U M E N T   C O N T R O L\Status Screen\Resend Fax\Cancel Fax\Quit\SRCQ",1:@ZAA02G(9)@(64)) D SEL Q:J=NE  I J>NE D HEAD G T4
 S NX=5,BL=22,EX="I 0",TFM=0,TYP=1
 I J=1 S SEL=0 D ^ZAA02GFAXS G T4
 I J=2 D RESEND^ZAA02GFAXQ G T4
 I J=3 D CANCEL^ZAA02GFAXQ G T4
 G T4
T5 S Y=$S('$D(ZAA02G(9)):"T E S T   O P T I O N S\Send Test Fax\Test Modem Communication\Quit\STQ",1:@ZAA02G(9)@(65)) D SEL Q:J=NE  I J>NE D HEAD G T5
 I J=1 D NA G T5
 I J=2 D ^ZAA02GFAXD3 G T5
 G T5
 ;
SEL S %R=1,%C=20,J=$P(Y,"\"),Y=$P(Y,"\",2,99) W @ZAA02GP,$J("",44) S %C=84-$L(J)\2 W @ZAA02GP,ZAA02G("HI"),J,!! W:$D(cp) ! k cp W ZAA02G("CS")
 S L=$P(Y,"\",$L(Y,"\")),NE=$L(L),(TC,%C)=$L($P(Y,"\",1,NE))\NE\-2+35,TR=NE\-2+10 F I=1:1:NE S X=$P(Y,"\",I),%R=I+TR W @ZAA02GP,ZAA02G("HI"),$E(X),"  ",ZAA02G("LO"),X
FIND S I="",CN=1
LEV S %R=24,%C=7,X="[ Select *option* and press *RETURN*, use *HELP KEY* for on-line help ]" S:$D(ZAA02G(9)) X=@ZAA02G(9)@(3)
 W @ZAA02GP,ZAA02G("LO") F J=1:2:$L(X,"*") W $P(X,"*",J),ZAA02G("HI"),$P(X,"*",J+1),ZAA02G("LO")
 I $D(^ZAA02GFAXC("SUSPEND")) S %R=21,%C=28 W @ZAA02GP,ZAA02G("RON")," ",$S($D(ZAA02G(9)):$P(@ZAA02G(9)@(32),"\",9),1:"MODEM ACTIVITY SUSPEND")," ",ZAA02G("ROF")
 ;
ASK S J=1,%C=TC-4 X ^ZAA02G("ECHO-OFF")
A1 S %R=TR+J,X=$P(Y,"\",J) W @ZAA02GP,ZAA02G("HI"),"==> ",$E(X),"  ",X,@ZAA02GP,"==> "
A2 R C#1 X ZAA02G("T") S A=ZF I C'="" S:C?1L C=$C($A(C)-32) I L[C D A3 S J=$F(L,C)-1 G A1:^ZAA02G("MENU"),DONE
 I A=ZAA02G("UK") D A3 S J=$S(J>1:J-1,1:NE) G A1
 I C=" "!(A=ZAA02G("DK")) D A3 S J=$S(J<NE:J+1,1:1) G A1
 I ZF=$C(13) G DONE
 I C=".",$D(^ZAA02GFAXC(99)) S:$D(ZAA02G(9)) C=$P(ZAA02G(9),",",3)+1 S:'$D(^ZAA02GFAXC(99,1,C)) C=1 S ZAA02G(9)="^ZAA02GFAXC(99,"_(ZAA02G["VT")_","_C_")",^ZAA02GFAXC(98,$I)=C S J=99 G DONE
 I XX[A S C=$E(XX,$F(XX,A)) I C="E" S J=NE G DONE
 G A2
A3 W $C(8,8,8,8),"    ",ZAA02G("HI"),$E(X),ZAA02G("LO"),"  ",X Q
DONE K TR,TC,X,C X ^ZAA02G("ECHO-ON") W ZAA02G("HI") Q
 Q
HEAD W ZAA02G("F") S %R=1,%C=2 I $D(ZAA02G("a"))=0 W ZAA02G("LO"),@ZAA02GP,ZAA02G("RON")," P ",ZAA02G("RT")," G ",ZAA02G("RT")," & ",ZAA02G("RT")," A " S %C=70 W @ZAA02GP,"  ZAA02G-FAX  ",ZAA02G("ROF"),!
 E  S A=$P(ZAA02G("a"),"`"),I=$P(ZAA02G("a"),"`",2),%C=18 W @ZAA02GP,I,*13," ",ZAA02G("HI"),A,"P ",I,A,"G ",I,A,"& ",I,A,"A ",I S %C=71 W @ZAA02GP,A,"ZAA02G-FAX ",I,!
 W ZAA02G("G1") S J=ZAA02G("HL"),J=J_J_J_J F I=1:1:20 W J
 W ZAA02G("G0") Q
SETUP D:$D(ZAA02G)+$D(ZAA02GX)'=12 FUNC^ZAA02GDEV S ZAA02G("ECHO-ON")=^ZAA02G("ECHO-ON"),ZAA02G("ECHO-OFF")=^ZAA02G("ECHO-OFF")
 X ^ZAA02G("TERM-ON"),^ZAA02G("WRAP-OFF") S %R=23,%C=1 I $D(^ZAA02GFAXC(95,ZAA02G,1)) S XX=^(4)
 D:'$T SETUP^ZAA02GFAXU I $D(ZAA02G(9)),ZAA02G(9)["ZAA02GWP" S $P(ZAA02G(9),"(")="^ZAA02GFAXC" Q
 K ZAA02G(9) I $D(^ZAA02GFAXC(98,$I))#2 S:^ZAA02GFAXC(98,$I)>1 ZAA02G(9)="^ZAA02GFAXC(99,"_(ZAA02G["VT")_","_^($I)_")"
 Q
NA S %R=24,%C=1 W @ZAA02GP,ZAA02G("CL"),"Option not available" H 1 Q
END X ^ZAA02G("WRAP-ON"),^ZAA02G("TERM-OFF") K ZAA02G(9),TFM,NX,BL,NE,BL,XX,CN,A,B,I,J,S Q
PASSWD S %R=20,%C=23 W @ZAA02GP,"Enter Password ____________" X ZAA02G("ECHO-OFF") S %C=38,X="" W @ZAA02GP F J=1:1:12 R B#1 Q:B=""  S X=X_B W "_"
 X ZAA02G("ECHO-ON") I $D(^ZAA02GFAXC("PASS")),X=^("PASS") S PASS=X Q
 Q:X=""  S %C=55 W @ZAA02GP,"INVALID PASSWORD" H 2 W @ZAA02GP,ZAA02G("CL") Q
