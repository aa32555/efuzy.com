ZAA02GFRME3 ;PG&A,ZAA02G-FORM,2.62,FORMS EDITOR, PART 4;16SEP94  11:33;;;29SEP96  18:16
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
CODE X ^ZAA02G("ECHO-ON") W:'$d(qt) "*",VIDOF S RR=%R,CC=%C
C1 S (ST,X)="" I $D(@ZAA02GG@(.2,%R,%C)) S CD=$P(^(%C),"\",2),ST=^ZAA02GDISPL("~",$I,0,CD) G C3
 W:'$d(qt) STL,ZAA02G("LO"),ZAA02G("RON"),"DATA ID:  (Enter NAME of datum - precede with a ""^"" for ZAA02GSCHEMA item or a "">"" "
C2 I $D(OF),$P($G(^ZAA02GDISPL("~",$I,0,OF)),"`",3)'="" K OF
 W:'$d(qt) ZAA02G("LO"),STL1,"to enter grouped data, < to leave the group): ",ZAA02G("HI"),$G(OF)
 S %R=ZAA02G("R"),%C=47,LNG=10,X=$G(OF) K OF D READ S CD=X G C4:CD="",UN1^ZAA02GFRME3B:CD="<" I $S("^>"[$E(CD):CD'?1P1A.AN."_".AN,1:CD'?1A.AN."_".AN) W:'$d(qt) "  incorrect field name " R X:2 G C2
 I '$D(^ZAA02GDISPL("~",$I,0,CD))&'$D(^ZAA02GDISP(SCR,SN,CD)),CD'?1P.E S X="" D COPY S:ST=""&$D(LST) ST=LST I 1
 E  I $D(^(CD))!$D(^ZAA02GDISP(SCR,SN,CD)) D EXIST I CD="" G C1
C3 K PST I CD["^" S PST=",1,2,3," I ST="" S A=$E(CD,2,99) G:$D(^ZAA02GSCHEMA(A))=0 C8 S SCHEMA=^(A),^ZAA02GSCHEMA(0,A,SCR_"-"_SN)="" D COPY^ZAA02GFRMSC2
 G:$E(CD)=">" G^ZAA02GFRME3B D F K HELP,PST W:'$d(qt) ZAA02G("Z"),VIDON D:$P(ST,"`",21)["V" LIST
 D C4 Q:'$D(CD)
 I $P(ST,"`",2)=""!($P(ST,"`",5)="") W:'$d(qt) *7,"  Need Reference & Length. Press Return to Continue." R *RR S RR=%R,CC=%C X ^ZAA02G("ECHO-ON") G C3
C5 S B=$P(ST,"`",5) I $D(@ZAA02GG@(.2,%R,%C)) D RECODE
 D C7 S @ZAA02GG@(.2,%R,%C)=B_"\"_CD_"\"_VD,$P(ST,"`",3)=%R_","_%C,^ZAA02GDISPL("~",$I,0,CD)=ST,^(CD,0)=scope K CD S $P(LST,"`",2)=$P(ST,"`",2),$P(LST,"`",4)=$P($P(ST,"`",4),",",1,2) Q
C6 W:'$d(qt) STL,STL1,*13 G C1
C7 W:'$d(qt) @ZAA02GP,ZAA02G("HI"),$E(CD_SP,1,B),@ZAA02GP S @ZAA02GG@(%R,%C)=$E(CD_SP,1,B)_"`0*"_"`"_B_"\"_CD Q
C8 W:'$d(qt) *7,"  Code not found" H 2 G C2
RECODE W:'$d(qt) @ZAA02GP,$J("",+@ZAA02GG@(.2,%R,%C)),@ZAA02GP S OF=$P(^(%C),"\",2) K ^(%C) S $P(^ZAA02GDISPL("~",$I,0,OF),"`",3)="" Q
C4 S %R=RR,%C=CC K RR,CC X ^ZAA02G("ECHO-OFF") I ST=""!(ST?."`")!(">"[$E($G(CD))) W:'$d(qt) @ZAA02GP,VIDOF," " I $D(@ZAA02GG@(%R,%C)) S F=^(%C) D EXDS^ZAA02GFRME9
 Q
 ;
READ N (%R,%C,ZAA02G,ZAA02GP,X,LNG) X ^ZAA02GREAD Q
 ;
F S HELP="HELP1^ZAA02GFRMEA" D SET^ZAA02GFRME2,EDIT1^ZAA02GFRME5 Q
 ;
EXIST S ST=$S($D(^ZAA02GDISPL("~",$I,0,CD)):^(CD),1:^ZAA02GDISP(SCR,SN,CD)),a=^(CD,0)
 I a'=scope,$P(ST,"`",3)]"" W:'$d(qt) *7 S %R=ZAA02G("R")-1,%C=1 W:'$d(qt) @ZAA02GP,ZAA02G("CS"),ZAA02G("Z"),ZAA02G("HI"),CD," is not in group ",scope,".   Press any key to continue." R ST#1:5 S CD="" Q
 I $P(ST,"`",3)'="" S %R=RR,%C=CC W:'$d(qt) @ZAA02GP,ZAA02G("Z")," " S RR=$P(ST,"`",3),(%C,CC)=$P(RR,",",2),(%R,RR)=+RR W:'$d(qt) @ZAA02GP,"*"
 Q
 ;
DEFALT D:$D(DST)=0 DEF1 S ST=DST,B=$P(ST,"`",2) S:B'["(" B=B_"(1)",$P(ST,"`",2)=B F I=$L(B)-1:-1 Q:$E(B,I)'?1N
 S CD="d"_+$E(B,I+1,99) D C5 S B=$P(ST,"`",2),$P(DST,"`",2)=$E(B,1,I)_($E(B,I+1,99)+1)_")" Q
DEF1 X ^ZAA02G("ECHO-ON") W:'$d(qt) "*",VIDOF S RR=%R,CC=%C W:'$d(qt) STL,ZAA02G("LO"),ZAA02G("RON"),"DEFAULT DATA ENTRY TEMPLATE:  Enter a sample definition for use with the       ",STL1,"default assignments - you may update it later with a CTL T   -   PRESS RETURN "
 R ST#1 S CD="^D",ST="" S:$D(DST) ST=DST S HELP="HELP1^ZAA02GFRMEA" D SET^ZAA02GFRME2,EDIT1^ZAA02GFRME5 K HELP W:'$d(qt) ZAA02G("Z"),VIDON S $P(ST,"`",21)="",DST=ST
 S %R=RR,%C=CC K RR,CC X ^ZAA02G("ECHO-OFF") S B=" " S:$D(@ZAA02GG@(%R,%C)) B=$E(^(%C)) W:'$d(qt) @ZAA02GP,B,@ZAA02GP Q
 ;
LIST S C=$P(ST,"`",21),A=$P(C,",",2),B=$P(ST,"`",5) Q:A<2  Q:$P(C,",")'="V"
 S %C=CC F %R=RR+1:1:RR+A-1 D C7
 Q
 ;
COPY S %C=57 W:'$d(qt) @ZAA02GP,ZAA02G("LO")," Copy from: ",ZAA02G("HI") S %C=69 D READ I X]"",X'?1A.E W:'$d(qt) *7 G COPY
 I X]"",$D(^ZAA02GDISPL("~",$I,0,X)) S ST=^(X),$P(ST,"`",3)=(RR_","_CC),$P(ST,"`",11)=CD
 E  I X]"" W:'$d(qt) *7 G COPY
 Q
