%ZAA02GEDUR3  
FREEZE N pc,C,R,DT,LV,MS,NB,NL,NR,RR I '$D(@pgl@(PKG,PV))#2 W *7 Q
	I $P(^(PV),"`",4)]"" S MS="Version "_tHI_PV_tLO_" has already been released." D MSG Q
	I '^(PV) S MS="The routines for this version must first be selected." D MSG Q
CONF W pBL_tLO_"Freeze "_tHI_PKG_tLO_", version "_tHI_PV_tLO_"?  Please confirm:"_tHI_tCL
	S %R=bl+2,%C=lm+36+$L(PKG)+$L(PV),Y="RON\ROF\EX\\3\NY\No;Yes",X=0 D ^ZAA02GEDYN Q:'X!(ZAA02GF="EX")
FRZ S (NR,NL,NB,R)=0,LV=$P(PKR,"`",4),CPL=$S($D(@pgl@(PKG,PV,0)):$P(^(0),"`",2),1:0) D DATE^ZAA02GEDS0 S PD=$P($P(DT,"\",2),"  ")
F1 S R=$O(@pgl@(PKG,PV,1,R)) G:R="" FEND S NR=NR+1,RR=@agl@(0,R),V=$P(RR,"`",2),NL=NL+$P(RR,"`",4),NB=NB+$P(RR,"`",5)+CPL,C=2
	I LV]"",$D(@pgl@(PKG,LV,1,R)) S C=$S(V=$P(^(R),"`",2):0,1:1)
	S @pgl@(PKG,PV,1,R)=C_"`"_V,$P(@agl@(0,R),"`")=V G F1
FEND S @pgl@(PKG,PV)=NR_"`"_NL_"`"_NB_"`"_DT_"`"_LV,$P(@pgl@(PKG),"`",4,5)=PV_"`"
	Q
COMPILE N i,s,pc,E,G,L,N,P,R,S,T,GFI,GFR,GS,OS,SF,ACT,CPY,SET,ZAA02GF,MULT
	S OS=ZAA02G("OS"),MULT=1,SF=0,GFR=agl_"(R,V)",GS="^ZAA02GEDSEL($J)",CPY=pgl_"(PKG,PV,0)",PX=PV I '$P(@pgl@(PKG,PV),"`",4) S PX=PX_"p"
	S R="" F i=0:0 S R=$O(@pgl@(PKG,PV,1,R)) Q:R=""  S V=$P(^(R),"`",2) S:PX'=PV V=$P(@agl@(0,R),"`",2) S ^ZAA02GEDSEL($J,R)="`"_V_"`"_@agl@(R,V)
	D COMP^ZAA02GEDR0 Q
MSG S %R=24,%C=67 W pBL_tLO_MS_tCL,@ZAA02GP,"Press any key" R *C Q
	;
	;