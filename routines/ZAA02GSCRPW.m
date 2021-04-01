ZAA02GSCRPW ;PG&A,ZAA02G-SCRIPT,2.10,SYSTEM SETUP;18NOV94  01:15;;;Tue, 20 Oct 2009  11:37
C ;Copyright (C) 1991-1996, Patterson, Gray & Associates, Inc.
 I $D(ZAA02G("ECHO-ON"))+$D(XX)'=2 K (ZAA02G,ZAA02GP,ZAA02GPWD,TEST,CLN,ZAA02GID,ZAA02GSCR) D SETUP^ZAA02GWP S ZAA02G("MENU")=0
BEG D HEAD
 S %R=21,%C=4 W ZAA02G("LO"),@ZAA02GP,"Version ",$P($T(ZAA02GSCRPW),",",3),"  ",$P($T(C),";",2)
 D:'$D(ZAA02GSCR) DATABASE I '$D(@ZAA02GSCR) D INIT G ZAA02GSCRPW
BEG0 S NE=0,ZAA02GSCRP="" D PASSWD Q:'$D(TRANS)  D BEG1
 D PARAM K NE,ZAA02GSCRT Q
 ;
PARAMS ; REMOTE SETUP
 S X=$TR(USER,UP,LC) D PASSDB,PASSWD2,PARAM Q
 ;
PARAM Q:'$D(^ZAA02GSCR("PARAM","BASIC"))
 S WORKT=$S($D(@ZAA02GSCR@("PARAM","WORK",1)):$P(^(1),"\",1)_"\"_$P(^(1),"\",3),1:"")
 S CONFIG=@ZAA02GSCR@("PARAM","BASIC")
 S ZAA02GSCRP=$S($D(^ZAA02GSCR1)+$D(^ZAA02GSCR2):"C",1:"")_$S($G(@ZAA02GSCR@("PARAM","WPC"))="Y":"W",1:"")_$S($G(^("RSL"))]"":"R",1:"")_$S($G(^("INSHDR"))]"":"I",1:"")_$S($G(^("GETVAR"))]"":"G",1:"")_$S($G(^("MNEMONIC"))["F":"F",1:"")
 S ZAA02GSCRP=ZAA02GSCRP_$S($P($G(TRTYPE),"\",7)_$G(^("INDSTATS"))="YY":"A",1:"")_$S($G(^("NOSITESTATS"))="Y":"S",1:"")_$S($G(^("NODELETE"))="Y":"D",1:"")_$S($G(^("SITELIM"))="Y":"X",1:"")_$S($G(^("FAXTOF_LOGIC"))]"":"f",1:"")
 S ZAA02GSCRP=ZAA02GSCRP_$S($G(^("NOPROC2STATS"))="Y":"x",$D(^("INPP")):"q",1:"")
 S ZAA02GSCRP=ZAA02GSCRP_$S($G(^("XEDIT"))_$G(^("XEDIT1"))]"":"e",1:"")_$S($P(CONFIG,"|",6)="Y":"r",1:"")_$S($G(^("NOMODIFY"))>0:"i",1:"")_$S($P(CONFIG,"|",11)="Y":"s",1:"")_$S($P(CONFIG,"|",13)="Y":"a",1:"")
 S ZAA02GSCRP=ZAA02GSCRP_$S($P(CONFIG,"|",15)="Y":"t",1:"")
 S ZAA02GSCRP=ZAA02GSCRP_$S($G(^("CHANGE-OWNERSHIP"))="Y":"O",1:"")
 ; S ZAA02GSCRP=ZAA02GSCRP_$S($D(^ZAA02GSCMD):"M",1:"") not used
 S $P(ZAA02GSCRP,";",2)=$S($D(@ZAA02GSCR@("PARAM","SCR")):^("SCR"),1:5)
 S $P(ZAA02GSCRP,";",3)=$S($G(@ZAA02GSCR@("PARAM","LOOKUP"))]"":^("LOOKUP"),$D(^RFG):2,$D(^VA):1,$D(^MIDIC):3,1:0) ; VA=1,ADS=2,MIDS=3
 S $P(ZAA02GSCRP,";",4)=$G(@ZAA02GSCR@("PARAM","EDITHEADER"))
 S CONFIG=$P(CONFIG,"|") D:ZAA02GSCRP["W" DATABASE^ZAA02GSCM Q
BEG1 K ^ZAA02GTWP("~",$I) D DATE^ZAA02GSCRER S ^ZAA02GTWP("~",$I,0,1)=DT I $D(@ZAA02GSCR@("PARAM","CONFIG")) X ^("CONFIG")
 Q
PASSWD D PASSDB I $D(ZAA02GPWD) D ZAA02GPWD Q:'$D(ZAA02GPWD)  S X=ZAA02GPWD G PASSWD1
 I $D(@ZAA02GSCRT@("PARAM","CODE"))=0!($G(TEST)="?") S TRANS="xxx",TRTYPE="3\Y\xxx\N\N" Q
 D PASSWDH S %R=4,%C=32 W @ZAA02GP,ZAA02G("HI"),"Enter User Code" X ZAA02G("ECHO-OFF") S %R=6,%C=33,X="" W @ZAA02GP R B:0 F J=1:1:12 R B#1:3000 Q:B=""  S:B?1U B=$c($a(B)+32) S X=X_B W " "
 X ZAA02G("ECHO-ON")
PASSWD1 Q:X=""  I $D(@ZAA02GSCRT@("PARAM","CODE",X)) S (TRANS,X)=^(X) S:$D(^ZAA02GSCR(112,X))&'$D(ZAA02GID) ZAA02GSCR=^(X) S ^(TRANS)=ZAA02GSCR,^ZAA02GSCR(111,$I)=TRANS D:ZAA02GSCR'=ZAA02GSCRT PASSDB
 I  D PASSWD2 Q:X'=""
 S %R=8,%C=31 W @ZAA02GP,"Invalid User Code" S NE=NE+1 K:$G(TRANS)]"" ^ZAA02GSCR(112,TRANS) K TRANS G PASSWD:NE<4 Q
PASSWDH W ZAA02G("LO") D:$D(@ZAA02GSCR@(102,ZAA02G,1))=0 ^ZAA02GSCRINT F I=1:1 Q:$D(^(I))=0  W ^(I)
 Q
PASSWD2 S TRTYPE="2\Y\",X=$G(@ZAA02GSCRT@("PARAM","USER",X)) Q:X=""
 S TRTYPE=$TR($P(X,"\",4),"NYMXSR",123021)_"\"_$P(X,"\",7,9)_"\"_$P(X,"\",12,13)_"\"_$P(X,"\",15)_"\"_$P(X,"\",17) Q
 ;
PASSDB S ZAA02GSCRT=ZAA02GSCR S:$D(@ZAA02GSCR@("PARAM","USER FILE")) ZAA02GSCRT=^("USER FILE") Q
S S TEST="?" D ZAA02GSCRPW S TEST="" Q
 ;
 ;
DATABASE I $G(TEST)'="NEW" S ZAA02GSCR=$S($G(^ZAA02GSCR("PARAM","DATABASE"))]"":^("DATABASE"),1:"^ZAA02GSCR") Q
 F J="",1:1:9,"A","B","C" I '$D(@("^ZAA02GSCR"_J)) S ZAA02GSCR="^ZAA02GSCR"_J Q
 Q
HEAD W ZAA02G("F") S %R=1,%C=2 I $D(ZAA02G("a"))=0 W ZAA02G("LO"),@ZAA02GP,ZAA02G("RON")," P ",ZAA02G("RT")," G ",ZAA02G("RT")," & ",ZAA02G("RT")," A " S %C=67 W @ZAA02GP,"  ZAA02G-SCRIPT  ",ZAA02G("ROF"),!
 E  S A=$P(ZAA02G("a"),"`"),I=$P(ZAA02G("a"),"`",2),%C=18 W @ZAA02GP,I,*13," ",ZAA02G("HI"),A,"P ",I,A,"G ",I,A,"& ",I,A,"A ",I S %C=68 W @ZAA02GP,A,"ZAA02G-SCRIPT ",I,!
 W ZAA02G("G1") S J=ZAA02G("HL"),J=J_J_J_J F I=1:1:20 W J
 W ZAA02G("G0") Q
 ;
CONFIG N SYSTEM S SYSTEM=0 ; SELECTS DATABASE
CONFIG1 N CONFIG1 K Y S Y=0 F J="",1:1:20 S B="^ZAA02GSCR"_J I $D(@B),$S($D(SYSTEM):1,$D(@B@("PARAM","USER FILE")):1,1:$D(@B@("PARAM","USER",TRANS))) S Y=Y+1,Y(Y)=$S($D(@B@("PARAM","BASIC")):$P(^("BASIC"),"|"),1:"(?)"),A(Y)=B
 Q:'Y  S Y="20,12\RHLDSY\1\Select Configuration\",Y(0)="\EX\"
 D ^ZAA02GPOP Q:X[";EX"  S CONFIG1=A(X)
 I $D(SYSTEM) S Y="25,14\RL\1\\\System Wide Change,Local Change Only",Y(0)="\EX\" D ^ZAA02GPOP Q:X[";EX"  S:X=1 ^ZAA02GSCR("PARAM","DATABASE")=CONFIG1
 I '$D(SYSTEM) S ^ZAA02GSCR(112,TRANS)=CONFIG1
 S ZAA02GSCR=CONFIG1 I ZAA02GSCRP["C" S CONFIG=$P(@ZAA02GSCR@("PARAM","BASIC"),"|")
 K TRANS Q
 ;
INIT D ^ZAA02GSCRIN2 Q
 ;
 ;  SETUP FOR OUTSIDE INQUIRY OPTIONS
 ;
SETUP D:$D(ZAA02G("ECHO-ON"))+$D(XX)'=2 SETUP^ZAA02GWP S ZAA02G("MENU")=0 D DATABASE,PARAM
 I $D(@ZAA02GSCR@("PARAM","CONFIG")) X ^("CONFIG")
 Q
 ;
ZAA02GPWD S ZAA02GPWD=$TR(ZAA02GPWD,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 I $D(@ZAA02GSCRT@("PARAM","CODE",ZAA02GPWD))=0 S Y="20,14\RLH\1\\\"_ZAA02GPWD_" - PASSWORD NOT VALID WITH THIS SITE",Y(0)="\EX\" D ^ZAA02GPOP K ZAA02GPWD
 Q
