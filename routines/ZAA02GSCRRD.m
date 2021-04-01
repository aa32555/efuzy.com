ZAA02GSCRRD ;PG&A,ZAA02G-SCRIPT,2.10,REPORT DEFINITION;02NOV94  12:23;;;07NOV2006  18:48
 ;Copyright (C) 1991, Patterson, Gray & Associates, Inc.
REP S DIR=106 G REPA
HELP S DIR="HELP" D HEAD S %R=1,%C=25,tr=4 W @ZAA02GP,"H E L P   S C R E E N   E D I T O R" G REP0
HDFR S DIR=110 G REPA
INCENT S DIR="INCENTR"
REPA D HEAD S %R=1,%C=25,tr=12 W @ZAA02GP,$S(DIR=106:"R E P O R T   T E M P L A T E S",DIR=110:"H E A D E R S  /  F O O T E R S",1:"     INCENTIVE PAY TEMPLATES")
 S X="Commonly used text for reports and headers and footers can be created here\for later use.  ""Stops"" may be defined in the template to indicate where"
 S %R=3,%C=2 W @ZAA02GP,ZAA02G("LO"),$P(X,"\"),!?1,$P(X,"\",2)
 S X="specific information can be automatically inserted by ZAA02G-SCRIPT.  Use ~$xxxx\(such as ~$PATIENT) with optional .L, .R, .C modifiers as needed.  Use the\HELP key for a list.  A ""*"" may also be included for TAB-TO-MARKER editing."
 W !?1,$P(X,"\"),!?1,$P(X,"\",2),!?1,$P(X,"\",3),!
 S X="The first line of the template is a short description and is not copied."
 W !?1,$P(X,"\"),!?1,$P(X,"\",2)
REP0 S tc=5 D REPN G END:X=""
COPYX S DOC=X G:$D(@ZAA02GSCR@(DIR,DOC)) REP1P S ^(DOC)=""
 S %R=tr+2,%C=5 W @ZAA02GP,ZAA02G("CS"),ZAA02G("LO"),$P(Y,"\",4)," - ",ZAA02G("HI") S %C=$L($P(Y,"\",4))+8,X="",FNC="EX,HL",LNG=RLNG,TRM="?"
 X ^ZAA02GREAD S X=$TR(X,UP,LC),A1=X D POP:FNC="HL"!ESC K:FNC="EX" @ZAA02GSCR@(DIR,DOC) G REP0:FNC="EX",COPYX:X[";EX"  G:X="" REP1P
 S A=0 I $D(@ZAA02GSCR@(DIR,X)) M @ZAA02GSCR@(DIR,DOC)=@ZAA02GSCR@(DIR,X)
REP1P K COPY D:$D(@ZAA02GSCR@(DIR,DOC)) COPY D CRC1
 S TL=tr,BL=22,WO="",ZAA02GWPD=ZAA02GSCR_"(DIR,DOC)",NM=DOC,ZAA02GWPOPT="AT,OT1,2,3,4,5,6,8,9,10,14,17,IM",MG=$S(DIR="INCENTR":76,$D(@ZAA02GWPD@(.01)):^(.01),$O(@ZAA02GSCR@(DIR,99))]"":$S($G(^($O(^(99)),.01))>1:^(.01),1:65),1:65)
 S @ZAA02GWPD@(.01)=MG,HLPR="^ZAA02GSCRH" S:"HELP,INCENTR"[DIR ZAA02GWPOPT=ZAA02GWPOPT_",ST"
 S HPX=$S(DIR="INCENTR":16,'$D(ZAA02GSCRP):10,1:$P("10,6,11,10,13",",",$P(ZAA02GSCRP,";",3)))
 I $D(@ZAA02GWPD@(.001))=0 S ^(.001)="|"_$J("",MG+1)
 I '$O(@ZAA02GWPD@(.03)),$D(@ZAA02GWPD@(.0115,5)) S B="",ID="" D ZAA02GGETTX^ZAA02GVBTER1  ; S ZAA02GWPOPT=ZAA02GWPOPT_",INQ D ENTRY^ZAA02GWPV6 G REPA
 S ZAA02GWPD("XECUTE")="S ZAA02GWPD="""_ZAA02GSCR_"(DIR,DOC)"" D SETUP,BLD^ZAA02GSCRRD" D ENTRY^ZAA02GWPV6 S ZAA02G("MENU")=0 I $O(@ZAA02GSCR@(DIR,DOC,.03))="" G RDEL
 S @ZAA02GSCR@(DIR,DOC,.015)=ZAA02G K:$D(COPY) ^ZAA02GSCRC(DIR,DOC)
 S ZAA02GWPD=ZAA02GSCR_"(DIR,DOC)" D DDEL D:DIR=106 ^ZAA02GSCRPS D SCAN,CRC2
 G HELP:DIR="HELP",REPA
END K UP,LC,DOC,DIR,BL,TL,NM,ZAA02GWPOPT,X,A,B,tr,tc,tcc,CRC,CRC1,CRC2,ECRC Q
REPN S Y="Enter Template\Name\\Copy from ?\"
 K LNG,PAT,TRM S UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ",LC="abcdefghijklmnopqrstuvwxyz" S:DIR'=106 A=UP,UP=LC,LC=A S RLNG=$S(DIR'=106:15,ZAA02GSCRP["F":65,1:14)
 S %R=tr,%C=tc W @ZAA02GP,ZAA02G("CS"),ZAA02G("LO"),$P(Y,"\",1)," ",ZAA02G("HI"),$P(Y,"\",2),ZAA02G("LO")," ",$P(Y,"\",3),"- ",ZAA02G("HI") S (tcc,%C)=$L($P(Y,"\",1,3))+tc+2,X="",FNC="EX,HL,TB",LNG=RLNG,TRM="?"
 X ^ZAA02GREAD S X=$TR(X,UP,LC),A1=X G REND:FNC="TB",REND:FNC="EX",REND:X_FNC=""&'ESC I tc>10,X'="",'$D(@ZAA02GSCR@(DIR,X)) S FNC="HL"
 D POP:FNC="HL"!ESC  G REPN:FNC="EX",REPN:X[";EX" G:X="" REND Q
REND S X="" Q
BLD S %="" F  S %=$O(@ZAA02GWPD@(0,%)) Q:%=""  S ^ZAA02GWP(.9,DP,XDC,%)=%
 Q
RDEL D DDEL K @ZAA02GSCR@(DIR,DOC),@ZAA02GSCR@(DIR,0,DOC) G REP0
DDEL S CPT=0 I $D(@ZAA02GSCR@(DIR,DOC,.03)),$P(^(.03),"\",15)]"" S CPT=$P(^(.03),"\",15)
 I $D(@ZAA02GSCR@(DIR,DOC,.03)),$P(^(.03),"\",19)'="" S A=$P(^(.03),"\",19) F I=1:1:$L(A,",") S X=$P(A,",",I) I X'="" K @ZAA02GSCR@(DIR,0,0,X,DOC),@ZAA02GSCR@(DIR,0,0,X,0,CPT,DOC)
 Q
 ;
POP N Y D:'$D(@ZAA02GSCR@(DIR,0)) RBDIR
 S Y=$O(@ZAA02GSCR@(DIR,A1_" ")) I $E(Y,1,$L(A1))'=A1 S A1="" ; W *7 S X=";EX" Q
 S Y="20,12\RLTHSO14U\1\"_$S(DIR=106:"Reports",1:"Headers/Footers"),Y(0)="\EX\"_ZAA02GSCR_"(DIR,0)\$E($E(TO,1,60)"_$S(RLNG<20:"_$J("""",20-$L(TO))_$E($G(^(TO)),1,60)",1:"")_",1,70)\"_$S(A1="":0,1:A1)_"\\\"_$S(A1="":"",1:A1_"zzz") K A1
 D ^ZAA02GPOP S X=$S(X[";EX":X,X[";IL":"N",X="":"",'$D(@ZAA02GSCR@(DIR,X)):"",1:X) Q
 ;
SCAN S X=$G(@ZAA02GSCR@(DIR,DOC)),A=$O(^(DOC,.03)) I A'=""  S X=$P(^(A),$C(1),4),@ZAA02GSCR@(DIR,DOC)=X
 S @ZAA02GSCR@(DIR,0,DOC)=$S(DIR="HELP":"",1:X)
 S CPT=0,PG=$G(@ZAA02GSCR@(DIR,DOC,.0113),$G(@ZAA02GSCR@(DIR,DOC,.03))) I $P(PG,"\",15)]"" S CPT=$P(PG,"\",15)
 I $P(PG,"\",19)'="" S A=$P(PG,"\",19) D:A="*" ALLSITES D
 . F I=1:1:$L(A,",") S B=$P(A,",",I) S:B'="" @ZAA02GSCR@(DIR,0,0,B,DOC)=X,@ZAA02GSCR@(DIR,0,0,B,0,CPT,DOC)=X,@ZAA02GSCR@(DIR,0,0,0,0,CPT,DOC)=X
 K @ZAA02GSCR@(DIR,DOC,0)
 S A=.03 F I=1:1 S A=$O(@ZAA02GSCR@(DIR,DOC,A)) Q:A=""  I ^(A)["~$" S X=^(A) F I=2:1:$L(X,"~$") S B=$E($P($P($P(X,"~$",I)," "),$C(27)),1,20) I B'?.E1"=".E S B=$P($TR(B,":.,/\-+*>)","          ")," ") S:B'="" @ZAA02GSCR@(DIR,DOC,0,B,A)=""
 S A=1 Q
 ;
ALLSITES S A="",B=0 F  S B=$O(@ZAA02GSCR@(DIR,0,0,B)) Q:B=""  S A=A_","_B
 Q
ALL S DOC=.9 W:'$D(qt) "wait..." F JJ=1:1 S DOC=$O(@ZAA02GSCR@(DIR,DOC)) Q:DOC=""  D SCAN
 I JJ=1 W "No templates defined" H 2 K JJ Q
 W:'$D(qt) "..",JJ-1," documents" K JJ Q
RBDIR ; REBUILD DIR DIRECTORY
 K @ZAA02GSCR@(DIR,0) D ALL
 Q
RB106 S DIR=106 G RBDIR
 ;
HEAD W ZAA02G("F") S %R=1,%C=2 W ZAA02G("LO"),@ZAA02GP,ZAA02G("RON")," P ",ZAA02G("RT")," G ",ZAA02G("RT")," & ",ZAA02G("RT")," A " S %C=69 W @ZAA02GP," ZAA02G-SCRIPT ",ZAA02G("ROF"),!,ZAA02G("G1") S J=ZAA02G("HL"),J=J_J_J_J F I=1:1:20 W J
 W ZAA02G("G0"),ZAA02G("HI") Q
 ;
HDCP ; COPY HEADERS OUT OF 106
 S A="@",B="" F J=1:1 S A=$O(@ZAA02GSCR@(106,A)) Q:$E(A)]"Z"  W A," " S @ZAA02GSCR@(110,A)=^(A) F J=1:1 S B=$O(@ZAA02GSCR@(106,A,B)) Q:B=""  S:$D(^(B))#2 @ZAA02GSCR@(110,A,B)=^(B)
 S DIR=110 K @ZAA02GSCR@(DIR,0) D ALL Q
 ;
COPY ; MAKES COPY OF DELETED REPORTS IF ^ZAA02GSCRC IS DEFINED
 Q:$D(^ZAA02GSCRC)=0  S A=0,COPY=0 I $D(@ZAA02GSCR@(DIR,DOC)) S ^ZAA02GSCRC(DIR,DOC)=$H_","_$I F J=1:1 S A=$O(@ZAA02GSCR@(DIR,DOC,A)) Q:A=""  S ^ZAA02GSCRC(DIR,DOC,A)=^(A)
 Q
CRC1 S A=^ZAA02G("OS"),ECRC="S CRC=CRC+$"_$S(A="PSM":"ZX(^(A),2)",A="MSM":"ZCRC(^(A),1)",1:"L(^(A))") D CRC3 S CRC1=CRC Q
CRC2 D CRC3 I CRC'=CRC1 S @ZAA02GSCR@(DIR,.1,+$H,$P($H,",",2))=DOC_","_$G(TRANS)
 Q
CRC3 S A="",CRC=0 F J=1:1 S A=$O(@ZAA02GSCR@(DIR,DOC,A)) Q:A=""  I $D(^(A))#2 X ECRC
 Q
