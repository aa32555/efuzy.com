%ZAA02GEDDV
DEV S DEV=$S($D(@ugl@(TID,"PRN")):^("PRN"),1:"")
D1 S %R=bl+2,%C=lm-1,Y="RON\ROF\EX\\28\\\\\\Output device: ",X=DEV W pBL_tCL D ^ZAA02GEDRS I X=""!(ZAA02GF="EX") K DEV,LM,RM Q
	S DEV=$S($E(X)=0:0,1:X) D OPEN E  S %C=rm-31 W @ZAA02GP,*7,tHI_"Device not available - try again"  H 3 G D1
	S @ugl@(TID,"PRN")=DEV,TLP=66,ULP=55 I DEV=0 S TLP=24,ULP=22
MGN S X=$S($D(@ugl@(TID,"PRN",DEV)):^(DEV),1:"1/80") I DEV=0 S X="1/"_(rm+1)
M1 S %R=bl+2,%C=rm-29,Y="RON\ROF\EX\\7\0123456789/\\\\\Margins (RM or LM/RM): " W @ZAA02GP,tCL D ^ZAA02GEDRS I ZAA02GF="EX" C DEV G D1
	S:X="" X="1/80" S LM=$P(X,"/"),RM=$P(X,"/",2) S:'RM RM=LM,LM=0 S W=RM-LM+1 I W<60 W *7 G M1
	S @ugl@(TID,"PRN",DEV)=X,LM=LM-1
SITE S SITE=$S($D(@sgl@(0,"SITE")):^("SITE"),1:"")
VERS D:'$D(VERS) VERS^ZAA02GED S SW=$S($D(VERS):$P(VERS," ",3),1:"")
DATE N m,d,y,o,H,M,S S X=$H,S=$P(X,",",2),o=$S(X<21609:14915,1:-21609),X=X+o,y=4*X+3\1461,d=X*4+7-(1461*y)\4,m=5*d-3\153,d=5*d+2-(153*m)\5 S m=m+3 S:m>12 m=m-12,y=y+1 S y=$S(o=14915:y+1800,y>99:y+1900,1:y)#100
	I $D(ZAA02G("d")),ZAA02G("d") S PDT=$E(0,d<10)_d_"/"_$E(0,m<10)_m_"/"_$E(0,y<10)_y
	E  S PDT=$E(0,m<10)_m_"/"_$E(0,d<10)_d_"/"_$E(0,y<10)_y
	S H=S\3600,M=S#3600\60,PDT=PDT_$J(H,4)_":"_$E(0,M<10)_M Q
OPEN S OS=ZAA02G("OS") I OS="DTM" O DEV:(fwid=230:flen=66):0 Q
	I OS="PSM" O DEV:0:0 Q
	O DEV::0 Q
	;