%ZAA02GEDRL1
DISP N C,I,L,S,T,W,Y,CN,NK,US,UD,FR S SF=1,TR=4,BR=22,W=rm-lm+1 I '$D(PG) S PG=1,(NK,PG(1))=""
	S T="Selected: "_CNT_"   Bytes: "_(CNT*CPL+SIZ) D ^ZAA02GEDHD F I=0:0 D FETCH Q:CN!(PG<2)  S PG=PG-1
	K T Q
FETCH S NK=PG(PG),CN=0 K US,UD,LST,PG(PG+1)
F1 S NK=$O(@GS@(NK)) I NK="" D CLEAR Q
F2 S:CN=(BR-TR) LST=NK I CN=(BR-TR+1) S:LST]"" PG(PG+1)=LST Q
	S Y=^(NK),V=$P(Y,"`",2),SZ=$P(Y,"`",5)+CPL,DT=$P($P(Y,"`",6),"\",2),CN=CN+1,%R=TR+CN-1,%C=3,US=NK,UD=NK_$J("",10-$L(NK))_$J(SZ,5)_"b  "_DT_$J("",18-$L(DT))_$E($P(Y,"`",3),1,41)
	W @ZAA02GP,tLO_UD_tCL G F1
CLEAR S %C=1 F %R=CN+TR:1:BR W @ZAA02GP,tCL
	Q
LOAD S %R=bl+2,%C=rm-38 W @ZAA02GP,tCL S %C=rm-17,@("P="_ZAA02GP),P=P_tLO_"Loading: "_tHI
	S R=X,RE=X_"~" S:X[":" R=$P(X,":"),RE=$P(X,":",2) S LN=$L(RE) I R]"",$D(@GFI@(R)) S Z=^(R) D LSET
	I TYP<4 F I=0:0 S R=$O(@GFI@(R)) Q:R=""!($E(R,1,LN)]RE)  S Z=^(R) D LSET
	I TYP=4 F I=0:0 S R=$O(@GFI@(R)) Q:R=""!($E(R,1,LN)]RE)  S V=$S(PX=PV:$P(^(R),"`",2),1:$P(@agl@(0,R),"`",2)),Z="`"_V_"`"_@agl@(R,V) D LSET
	K P,R,Z,RE,LN,OK Q
LSET I DTC X "S OK="_($P(Z,"`",7)\100000)_OP_DTC Q:'OK
	Q:$D(@GS@(R))  S @GS@(R)=Z,CNT=CNT+1,SIZ=SIZ+$P(Z,"`",5),CHG=1 W P_R_tCL Q
UNLOAD S %R=bl+2,%C=rm-38 W @ZAA02GP,tCL S %C=rm-19,@("P="_ZAA02GP),P=P_tLO_"Unloading: "_tHI
	S R=X,RE=X_"~" S:X[":" R=$P(X,":"),RE=$P(X,":",2) S LN=$L(RE) I R]"",$D(@GS@(R)) S Z=^(R) D LDEL
	F I=0:0 S R=$O(@GS@(R)) Q:R=""!($E(R,1,LN)]RE)  S Z=^(R) D LDEL
	K P,R,Z,RE,LN,OK Q
LDEL I DTC X "S OK="_($P(Z,"`",7)\100000)_OP_DTC Q:'OK
	S CHG=1,CNT=CNT-1,SIZ=SIZ-$P(@GS@(R),"`",5) K ^(R) W P_R_tCL Q
	;
	;