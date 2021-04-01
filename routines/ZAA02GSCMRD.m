ZAA02GSCMRD ;PG&A,ZAA02G-MTS,1.20,LETTER DEFINITION;30DEC94 4:17P [ 02/05/95   6:08 AM ];;;25FEB2005  10:25
 ;Copyright (C) 1995, Patterson, Gray & Associates, Inc.
REP S DIR=106 G REPA
HDFR S DIR=110
REPA K LNG,PAT,TRM D HEAD S %R=1,%C=25 W @ZAA02GP,$P("L E T T E R S   D E F I N I T I O N,H E A D E R S  /  F O O T E R S",",",DIR=110+1)
 S X="Form letters may be defined for a variety of uses in the Mammography Tracking\System. ""Stops"" may be defined in the letter to indicate where specific inform-"
 S %R=3,%C=2 W @ZAA02GP,ZAA02G("LO"),$P(X,"\"),!?1,$P(X,"\",2)
 S X="ation can be automatically inserted by the software.  Use ~$xxxx (such as\~$PATIENT) with optional .L, .R, .C modifiers as needed.  The HELP key may be\used to see a list of terms."
 W !?1,$P(X,"\"),!?1,$P(X,"\",2),!?1,$P(X,"\",3),!
 S X=$S('$D(ZAA02G(9)):"The first line of the letter is a short description and is not printed.",1:@ZAA02G(9)@(65))
 W !?1,$P(X,"\"),!?1,$P(X,"\",2)
 S UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ",LC="abcdefghijklmnopqrstuvwxyz" S:DIR=110 A=UP,UP=LC,LC=A S RLNG=8
REP1 S Y=$S('$D(ZAA02G(9)):"Enter Letter\Name\\Copy from ?\",1:@ZAA02G(9)@(66))
 S %R=12,%C=5 W @ZAA02GP,ZAA02G("CS"),ZAA02G("LO"),$P(Y,"\",1)," ",ZAA02G("HI"),$P(Y,"\",2),ZAA02G("LO")," ",$P(Y,"\",3),"- ",ZAA02G("HI") S %C=$L($P(Y,"\",1,3))+7,X="",FNC="EX,HL",LNG=RLNG,TRM="?"
 X ^ZAA02GREAD S X=$TR(X,UP,LC),A1=X G END:FNC="EX",END:X_FNC=""&'ESC D POP:FNC="HL"!ESC  G REP1:FNC="EX",REP1:X[";EX" G:X="" END
COPYX S DOC=X G:$D(@ZAA02GSCMD@(DIR,X)) REP1P S ^(X)=""
 S %R=14,%C=5 W @ZAA02GP,ZAA02G("CS"),ZAA02G("LO"),$P(Y,"\",4)," - ",ZAA02G("HI") S %C=$L($P(Y,"\",4))+8,X="",FNC="EX,HL",LNG=RLNG,TRM="?"
 X ^ZAA02GREAD S X=$TR(X,UP,LC),A1=X D POP:FNC="HL"!ESC G REP1:FNC="EX",COPYX:X[";EX"  G:X="" REP1P
 S A=0 I $D(@ZAA02GSCMD@(DIR,X)) F J=1:1 S A=$O(@ZAA02GSCMD@(DIR,X,A)) Q:A=""  S @ZAA02GSCMD@(DIR,DOC,A)=^(A)
REP1P S TL=12,BL=22,WO="",ZAA02GWPD=ZAA02GSCMD_"(DIR,DOC)",NM=DOC,ZAA02GWPOPT="AT,OT1,2,3,4,5,6,8,9,10,14,17",MG=$S($D(@ZAA02GWPD@(.01)):^(.01),1:76),^(.01)=MG,HLPR="^ZAA02GSCRH",HPX=10-($D(^RFG)>0*4)
 I $D(@ZAA02GWPD@(.001))=0 S ^(.001)="|"_$J("",MG+1)
 S ZAA02GWPD("XECUTE")="S ZAA02GWPD="""_ZAA02GSCMD_"(DIR,DOC)"" D SETUP,BLD^ZAA02GSCMRD"
 D ENTRY^ZAA02GWPV6 S ZAA02G("MENU")=0 I $O(@ZAA02GSCMD@(DIR,DOC,.03))="" G RDEL
 S @ZAA02GSCMD@(DIR,DOC,.015)=ZAA02G
 S ZAA02GWPD="@ZAA02GSCMD@(DIR,DOC)" D DDEL,^ZAA02GSCMPS D SCAN
 G REPA
END K UP,LC,DOC,DIR,BL,TL,NM,ZAA02GWPOPT,X,A,B Q
BLD S %="" F  S %=$O(@ZAA02GWPD@(0,%)) Q:%=""  S ^ZAA02GWP(.9,DP,XDC,%)=%
 Q
RDEL D DDEL K @ZAA02GSCMD@(DIR,DOC),@ZAA02GSCMD@(DIR,0,DOC) G REP1
DDEL S CPT=0 I $D(@ZAA02GSCMD@(DIR,DOC,.03)),$P(^(.03),"\",15)]"" S CPT=$P(^(.03),"\",15)
 I $D(@ZAA02GSCMD@(DIR,DOC,.03)),$P(^(.03),"\",19)'="" S A=$P(^(.03),"\",19) F I=1:1:$L(A,",") S X=$P(A,",",I) I X'="" K @ZAA02GSCMD@(DIR,0,0,X,DOC),@ZAA02GSCMD@(DIR,0,0,X,0,CPT,DOC)
 Q
 ;
POP N Y D:'$D(@ZAA02GSCMD@(DIR,0)) RBDIR
 S Y=$O(@ZAA02GSCMD@(DIR,A1)) Q:$E(Y,1,$L(A1))'=A1
 S Y="10,12\RLTHSO14\2\Reports",Y(0)="\EX\@ZAA02GSCMD@(DIR,0)\$E(TO,1,60)"_$S(RLNG<20:"_$J("""",12-$L(TO))_$E(^(TO),1,60)",1:"")_"\"_$S(A1="":0,1:A1)_"\\\"_$S(A1="":"",1:A1_"zzz") K A1
 D ^ZAA02GPOP S X=$S(X[";EX":X,X[";IL":"N",X="":"",'$D(@ZAA02GSCMD@(DIR,X)):"",1:X) Q
 ;
SCAN S A=0,X="I 1" I $D(@ZAA02GSCMD@(DIR,DOC,.03)) S X=$P(^(.03),"\",24),A=$TR(X,"()!&",",,,,") D S2
 F I=1:1:$L(A,",") S B=$P(A,",",I) S:B'="" @ZAA02GSCMD@(DIR,0,0,B,DOC)=X
 S A=$O(@ZAA02GSCMD@(DIR,DOC,.03)) Q:A=""  S X=$P(^(A),$C(1),4),@ZAA02GSCMD@(DIR,DOC)=X,@ZAA02GSCMD@(DIR,0,DOC)=$S(DIR="HELP":"",1:X)
 K @ZAA02GSCMD@(DIR,DOC,0) S A=.03 F I=1:1 S A=$O(@ZAA02GSCMD@(DIR,DOC,A)) Q:A=""  I ^(A)["~$" S X=^(A) F I=2:1:$L(X,"~$") S B=$E($P($P($P(X,"~$",I)," "),$C(27)),1,20) I B'["=" S B=$P($TR(B,":.,/\-","      ")," ") S:B'="" @ZAA02GSCMD@(DIR,DOC,0,B,A)=""
 S A=1 Q
T R X,! D S2 W X,! X X G T
S2 S L=0,Y="I ",X=$TR(X,",","!"),A=$TR(X,"()!&",",,,,") F I=1:1:$L(A,",") S B=$P(A,",",I),Y=Y_$E(X,L,$L($P(A,",",1,I))-$L(B)) S:B]"" Y=Y_"$D(D("""_B_"""))" S L=$L($P(A,",",1,I))+1
 S X=Y_$E(X,L,255) Q
 ;
ALL S DOC=0 W "wait..." F JJ=1:1 S DOC=$O(@ZAA02GSCMD@(DIR,DOC)) Q:DOC=""  D SCAN
 W "..",JJ-1," documents",! K JJ Q
RBDIR ; REBUILD DIR DIRECTORY
 K @ZAA02GSCMD@(DIR,0) D ALL
 Q
RB106 S DIR=106 G RBDIR
 ;
HEAD W ZAA02G("F") S %R=1,%C=2 W ZAA02G("LO"),@ZAA02GP,ZAA02G("RON")," P ",ZAA02G("RT")," G ",ZAA02G("RT")," & ",ZAA02G("RT")," A " S %C=69 W @ZAA02GP," ZAA02G-MTS ",ZAA02G("ROF"),!,ZAA02G("G1") S J=ZAA02G("HL"),J=J_J_J_J F I=1:1:20 W J
 W ZAA02G("G0"),ZAA02G("HI") Q
 ;
