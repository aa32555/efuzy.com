%ZAA02GEDLIB
LKUP N S,Y,%C,%R,BR,TR I $D(@lgl)<10 W pBL_tLO_"The Code Library is empty" S %R=bl+2,%C=rm-14 W @ZAA02GP,"...press "_tHI_"RETURN" R X#1 W pBL_tCL Q
	S TR=5,BR=22,ZAA02GF="" S:X="?"!(ZAA02GF="HL") X=""
	I X]"",'$D(@lgl@(X)) S Y=$O(@lgl@(X)) I Y=""!($E(Y,1,$L(X))'=X) S X="" Q
	S Y="15,"_TR_"\THRLDS\3\Code Library",Y(0)="30\EX\"_lgl_"\TO_$J("""",15-$L(TO))\"_X_"\\\"_X_"~",REFRESH="" D ^ZAA02GEDPO
	W eLO S S=+@gl@(ts),TR=+REFRESH,BR=$P(REFRESH,":",2) F %R=tl:1:BR S S=$O(^(S)) I %R'<TR S %C=lm-1 W @ZAA02GP," ",$P(^(S),d,2),tCL
	S:X[";" ZAA02GF=$P(X,";",2),X="" K ST,REFRESH Q
	;
	;