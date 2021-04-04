%ZAA02GEDIN
INIT D INIT^ZAA02GED X ZAA02G("TON"),ZAA02G("WOF"),ZAA02G("EOF") W ZAA02G("Z")
	S lm=2,rm=79,bl=22,tl=3,sgl=$S($D(^ZAA02GED)#2:"^ZAA02GED",1:"^ZAA02GED") D MASK
TESTUCI S @(^%T("ERROR")_"=""TESTERR^ZAA02GEDIN"""),^%ZAA02GWORKS(.001)="",MGR=1 G TESTEND
TESTERR S MGR=0,sgl="^ZAA02GED",%R=4,%C=15 W @ZAA02GP,tHI_sgl
TESTEND S @(^%T("ERROR")_"=""""") G:'MGR DSPLY
SYSGL S %R=4,%C=16,Y="RON\ROF\EX\\5\T%\ZAA02GED;%ZAA02GED",X=sgl["%" D ^ZAA02GEDYN G EXIT:ZAA02GF="EX" S sgl=$S(X:"^ZAA02GED",1:"^ZAA02GED")
	I sgl["%",'MGR W *7 G SYSGL
DSPLY S GR=$S($D(@sgl)#2:@sgl,1:$P($T(DEF),";;",2)) S:GR[";" GR=$P(GR,";",2) S ugl=$P(GR,"`",2),rgl=$P(GR,"`",7),LOCK=$P(GR,"`",8)
	S SITE=$S($D(@sgl@(0,"SITE"))#2:^("SITE"),1:"") S %R=4,%C=32 W @ZAA02GP,tHI_SITE
	S R1="6,7,8,6,7,8",C1="19,19,19,57,57,57" F I=1:1:6 S P=$E("213564",I),G=$P(GR,"`",P),%R=$P(R1,",",I),%C=$P(C1,",",I) W @ZAA02GP,tHI_G
	S %R=10,%C=24 W @ZAA02GP,rgl S %C=58 W @ZAA02GP,$P("No /Yes","/",LOCK+1)
	S NP=6,DS="DES/PKG/PV/FIL/MOD/TID",R2="13,14,15,13,14,15",C2="28,28,28,67,67,67" F I=1:1:NP S J=$P(DS,"/",I),XP(I)=$S($D(@sgl@(0,"FMT",J))#2:$TR(^(J),"`",","),1:""),%R=$P(R2,",",I),%C=$P(C2,",",I) W @ZAA02GP,XP(I)
	S %R=18,%C=1 F I=1:1:4 S TX(I)=$S($D(@sgl@(0,"FMT","COP",I))#2:$P(^(I),";",2,99),1:"") S %R=I+17 W @ZAA02GP,TX(I),tCL
SITE S %R=4,%C=32,Y="RON\ROF\DK,TB,EX\\40",X=SITE D ^ZAA02GEDRS S SITE=X G:ZAA02GF="EX" EXIT
GLOB S P=1,NP=6
G1 S %R=$P(R1,",",P),%C=$P(C1,",",P),G=$E("213564",P),X=$P(GR,"`",G),Y="RON\ROF\UK,DK,TB,EX\\15\[^^%%[],,""""AZaz09]" D ^ZAA02GEDRS G:ZAA02GF="EX" EXIT I X="" W *7 G G1
	S:$E(X)'="^" X="^"_X D CHECK I E,E'=2 W *7 G G1
	S $P(GR,"`",G)=X G:ZAA02GF="TB" LOCK S P=$S(ZAA02GF="UK":P-1,1:P+1) G SITE:'P,LOCK:P>NP,G1
LOCK S %R=10,%C=24,Y="RON\ROF\UK,DK,TB,EX\\15\[^^%%[],,""""AZaz09]",X=$P(GR,"`",7) D ^ZAA02GEDRS G:ZAA02GF="EX" EXIT I X="" W *7 G LOCK
	S:$E(X)'="^" X="^"_X D CHECK I E,E'=2 W *7 G LOCK
	S $P(GR,"`",7)=X,rgl=X G:ZAA02GF="TB" MAP I ZAA02GF="UK" S (P,NP)=6 G G1
LOCKYN S %R=10,%C=58,Y="RON\ROF\UK,DK,TB,EX\\3\NY\No;Yes",X=LOCK D ^ZAA02GEDYN S LOCK=X G EXIT:ZAA02GF="EX",LOCK:ZAA02GF="UK"
MAP S P=1,NP=6
M1 S %R=$P(R2,",",P),%C=$P(C2,",",P),X=XP(P),Y="RON\ROF\UK,DK,TB,EX\\3\0123456789," D ^ZAA02GEDRS G:ZAA02GF="EX" EXIT S:X=0 X=""
	I X]"",+X<1!(X>2)!($P(X,",",2)<2)!($P(X,",",2)>10) W *7 G M1
	S XP(P)=X G:ZAA02GF="TB" COPY S P=$S(ZAA02GF="UK":P-1,1:P+1) G LOCK:'P,COPY:P>NP,M1
COPY S TR=18,FC=1,NT=4,LNG=80 D ^ZAA02GEDUR5 G:ZAA02GF="EX" EXIT I ZAA02GF="UK" S P=NP G M1
SAVE D VERS^ZAA02GED,^ZAA02GEDIN1:MGR,^ZAA02GEDIN2:MGR K @sgl@(0,"USER") S ^("VERSION")=$P(VERS," ",3)
	S GN="^"_$E("%",sgl["%")_"ZAA02GEDHLP",D=$S('$D(@GN):1,@sgl@(0,"VERSION")'=$P(VERS," ",3):1,1:0) I D K @GN S %R=24,%C=1 W @ZAA02GP,tLO_"Creating Online Help File"_tHI_tCL D ^ZAA02GEDH01
	S $P(GR,"`",8)=LOCK,$P(@sgl,";",2)=GR,@sgl@(0,"SITE")=SITE
	F P=1:1:6 S J=$P(DS,"/",P),@sgl@(0,"FMT",J)=$TR(XP(P),",","`")
	S (B,C)=0 F I=1:1:4 K @sgl@(0,"FMT","COP",I) I TX(I)]"" S C=C+1,X=" ;"_TX(I),B=B+$L(X)+1,@sgl@(0,"FMT","COP",C)=X
	S @sgl@(0,"FMT","COP")=C_"`"_B
EXIT X ZAA02G("EON"),ZAA02G("TOF"),ZAA02G("WON") W ZAA02G("Z"),ZAA02G("F")
	K lm,rm,B,C,I,J,P,X,Y,CC,NP,RR,TX,LOCK Q
CHECK N GR,GN,MX,NL,SB,SE D ^ZAA02GEDGL Q
DEF ;;;^ZAA02GEDE`^ZAA02GEDU`^ZAA02GEDW`^ZAA02GEDL`^ZAA02GEDA`^ZAA02GEDP`^ZAA02GEDR`1
MASK S T="I N I T I A L I Z A T I O N" D ^ZAA02GEDHD S %R=7,%C=1 W @ZAA02GP,ZAA02G("CS") K T
MSK1 S %R=4,%C=1 W @ZAA02GP,tLO_"System Global "_tHI_"^"_tCL_tLO S %C=27 W @ZAA02GP,"Site"
	S %R=6,%C=1 W @ZAA02GP,"Parameter Global"_tCL S %C=41 W @ZAA02GP,"Archive Global"
	S %R=7,%C=1 W @ZAA02GP,"Workspace Global"_tCL S %C=41 W @ZAA02GP,"Package Global"
	S %R=8,%C=1 W @ZAA02GP,"Workfile Global"_tCL S %C=41 W @ZAA02GP,"Library Global"
	S %R=10,%C=1 W @ZAA02GP,"Routine Locking Global"_tCL S %C=41 W @ZAA02GP,"Locking Enabled?"
	S %R=12,%C=1 W @ZAA02GP,"Routine Header Map:  (LineNo {1..2},PieceNo {2..10})"
	S %R=13,%C=4 W @ZAA02GP,"a. Routine Description"_tCL S %C=45 W @ZAA02GP,"d. Date Last Saved"_tCL
	S %R=14,%C=4 W @ZAA02GP,"b. Package Name"_tCL S %C=45 W @ZAA02GP,"e. Date Last Modified"_tCL
	S %R=15,%C=4 W @ZAA02GP,"c. Release Version"_tCL S %C=45 W @ZAA02GP,"f. User/Device Number"_tCL
	S %R=17,%C=1,Z="",$P(Z,ZAA02G("HL"),81)="" W @ZAA02GP,"General Copyright Lines",ZAA02G("G1")_$P(Z,ZAA02G("HL"),1,57)_ZAA02G("G0")
	S %R=22 W @ZAA02GP,ZAA02G("G1")_Z_ZAA02G("G0") K Z Q
	;
	;