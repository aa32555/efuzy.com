%ZAA02GEDUR  
INIT S CMPRS=0 I $D(@ugl@(TID))#2,$P(^(TID),"`",2)>79 X ZAA02G(80) S CMPRS=1
	N rm S rm=80,(OPK,PKG,PDE,OPV,PV)="",SF=0 D VLOAD,MASK X ZAA02G("EOF")
PKG S %R=4,%C=12,Y="RON\ROF\DK,EX\\15",X=PKG D ^ZAA02GEDRS G:X=""!(ZAA02GF="EX") EXIT S PKG=X
	I PKG["?" S X=PKG D ^ZAA02GEDRL3,MASK G:PKG=""!(ZAA02GF="EX") PKG
	I $D(@pgl@(PKG)) D:PKG'=OPK PLOAD S %R=4,%C=39 W @ZAA02GP,tHI_PDE G VER
PKADD S PR="package" D ADD G:'X PKG I PKG'=OPK S PKR=PKG,@pgl@(PKG)=PKR D PLOAD
PKD S %R=4,%C=39,Y="RON\ROF\DK,EX\\40",X=PDE D ^ZAA02GEDRS Q:X=""!(ZAA02GF="EX")  S PDE=X,$P(PKR,"`",2)=X,@pgl@(PKG)=PKR
VER S %R=6,%C=12,Y="RON\ROF\UK,DK,TB,EX\\8",X=PV D ^ZAA02GEDRS G PKG:X="",EXIT:ZAA02GF="EX" S PV=X
	I PV["?" S X=$TR(PV,"?","") D ^ZAA02GEDRL4,MASK G VER:PV=""!(ZAA02GF="EX")
	I '$D(@pgl@(PKG,PV))#2 S PR="version" D ADD G:'X VER S @pgl@(PKG,PV)="" S:'$D(^(PV,0)) ^(0)="0`0" S:$P(PKR,"`",5)="" $P(PKR,"`",5)=PV,@pgl@(PKG)=PKR
	D:PV'=OPV VLOAD,MSK1 S OPV=PV G:ZAA02GF="UK" PKG
MENU S TPK=PKG,TPV=PV
M1 S Y="Package Information\Archive Routines\Select Routines\Release Report\Compile Release\Freeze Release\Quit",L="PASRCFQ",NE=7,TC=29,TR=9 D SELECT
	I J<NE S PGM=$P("^ZAA02GEDUR1/MULT^ZAA02GEDA0/^ZAA02GEDUR2,VLOAD/^ZAA02GEDUR9/COMPILE^ZAA02GEDUR3/^ZAA02GEDUR3","/",J) K TTL,Y,L,NE,TC,TR,J D:PGM]"" @PGM S PKG=TPK,PV=TPV D MASK G M1
EXIT X:CMPRS ZAA02G(132) K J,NE,TC,TR,PGM,TTL,CMPRS K PB,PR,PV,PDE,PD,TX,PKG,CMPRS S SF=1 Q
SELECT S %R=TR,%C=1 W @ZAA02GP,ZAA02G("CS") S %C=TC F I=1:1:NE S X=$P(Y,"\",I),%R=I+TR W @ZAA02GP,tHI_$E(L,I),"  "_tLO_X
	S %R=24,%C=5 W @ZAA02GP,tLO_"[ Type "_tHI_"Letter"_tLO_" or use "_tHI_"ARROWS"_tLO_" to move selector, "_tHI_"RETURN"_tLO_" to make selection ]" S %C=1,%R=TR+1,I="" W @ZAA02GP,*13
ASK S J=1,%C=TC-4 X ZAA02G("EOF")
A1 S %R=TR+J,X=$P(Y,"\",J) W @ZAA02GP,tHI,"==> ",$E(L,J),"  ",X,@ZAA02GP,"==> "
A2 R C#1 I C]"" G DK:C=" " S:C?1L C=$C($A(C)-32) G A2:L'[C D A3 S J=$F(L,C)-1 G A1:ZAA02G("M"),CR
	X ZAA02G("T") S ZAA02GF=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2) G @ZAA02GF:"CR,UK,DK,EX"[ZAA02GF,A2
A3 W $C(8,8,8,8),"    ",tHI_$E(L,J)_tLO_"  "_X Q
UK D A3 S J=$S(J>1:J-1,1:NE) G A1
DK D A3 S J=$S(J<NE:J+1,1:1) G A1
EX D A3 S J=NE
CR K TR,TC,Y,L,X,C X ZAA02G("EON") Q
ADD W pBL,tLO_"Add this new "_PR_"?  Please confirm:"_tLO_tCL S %R=bl+2,%C=lm+39,Y="RON\ROF\EX\\3\NY\No;Yes",X=0 D ^ZAA02GEDYN S:ZAA02GF="EX" X=0 W pBL_tCL Q
PLOAD S OPK=PKG,PKR=$S($D(@pgl@(PKG))#2:^(PKG),1:""),PDE=$P(PKR,"`",2),PV=$P(PKR,"`",5)
VLOAD I PV="" S (OPV,PD,PR,PB,TX(1),TX(2),TX(3),TX(4))="" Q
	S X=$S($D(@pgl@(PKG,PV))#2:^(PV),1:""),PR=+X,PB=+$P(X,"`",3),PD=$P($P($P(X,"`",4),"\",2),"  ") F I=1:1:4 S TX(I)=$S($D(@pgl@(PKG,PV,0,I))#2:$P(^(I),";",2,99),1:"")
	Q
MASK S T="R E L E A S E   M A N A G E M E N T" D ^ZAA02GEDHD K T
MSK1 S %R=4,%C=3 W @ZAA02GP,tLO_"Package: "_tHI_PKG_$J("",18-$L(PKG))_tLO_"Descrip: "_tHI_PDE_$J("",40-$L(PDE))
	S %R=6,%C=3 W @ZAA02GP,tLO_"Version: "_tHI_PV_$J("",11-$L(PV)),tLO_"Routines: "_tHI_PR_$J("",8-$L(PR)),tLO_"Bytes: "_tHI_PB_$J("",11-$L(PB))
	S X=$S(PKG="":"",PD]"":PD,1:"UNRELEASED") W tLO_"Release: "_tHI_X_$J("",10-$L(X)) Q
	;
	;