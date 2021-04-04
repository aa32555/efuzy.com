%ZAA02GEDUI2  
BEG S OS=ZAA02G("OS"),CR="CK=CK+"_$P($T(@OS),";;",2),R="",GT=wgl
	F I=0:0 S (R,NR)=$O(@FN@(0,R)) Q:R=""  S:REN NR=$$CNVT(R,RENF,RENT) S RR=$P(^(R),"`",1,6),OK=1 D CNFRM:OV>1,IMP:OK
	K G,I,J,R,CK,FN,IR,NR,OS,RR Q
IMP D MSG S CK=0,IR=$S($D(@GT@(0,NR)):$P(^(NR),"`",1,2)_"`",1:"3`4`")_RR,V=$P(IR,"`",2) S:V>IR V=1 S $P(IR,"`",2)=V,@GT@(0,NR)=IR
	K @GT@(NR,V) S @GT@(NR,V)=RR,S="" F J=0:0 S S=$O(@FN@(R,S)) Q:S=""  S X=^(S),@GT@(NR,V,S)=X,pc=pc-1 D:'pc MSG W "." I $E(X)'=ci,$TR(X," ","")'="" S @CR
	S $P(IR,"`",9)=CK,@GT@(NR,V)=$P(IR,"`",3,99),@GT@(0,NR)=IR Q
MSG S pc=rm-lm-$L(NR)-23 W pBL,tLO_"Importing "_tHI_NR_tLO_" to "_tHI_"WORKFILE "_tLO_tCL Q
CNFRM G WKF:$D(@GT@(0,NR)),ARF:$D(@agl@(0,NR)) Q:OV=2
	U 0 W pBL_tLO_"Import "_tHI_NR_tLO_"? "_tHI_tCL S %R=bl+2,%C=lm+$L(NR)+8,Y="RON\ROF\EX\\3\NY\No;Yes",X=0 D ^ZAA02GEDYN S OK=$S(ZAA02GF="EX":0,1:X) Q
WKF U 0 W pBL_tLO_"Routine "_tHI_NR_tLO_" exists in workfile.  Overwrite it? "_tHI_tCL S %R=bl+2,%C=lm+$L(NR)+43,Y="RON\ROF\EX\\3\NY\No;Yes",X=0 D ^ZAA02GEDYN S OK=$S(ZAA02GF="EX":0,1:X) Q
ARF U 0 W pBL_tLO_"Routine "_tHI_NR_tLO_" exists in archive.  Add to workfile? "_tHI_tCL S %R=bl+2,%C=lm+$L(NR)+45,Y="RON\ROF\EX\\3\NY\No;Yes",X=0 D ^ZAA02GEDYN S OK=$S(ZAA02GF="EX":0,1:X) Q
PSM ;;$ZX(X,1)
M11 ;;$ZC(X)
DTM ;;$ZCRC(X,1)
CCSM ;;$ZCRCX(X)
MSM ;;$ZCRC(X,1)
DSM ;;$L(X)
DSM4 ;;$L(X)
CNVT(RTN,REP,WTH) N NR,R1,W1,R2,W2 S NR=RTN,R1=$P(REP,"*"),R2=$P(REP,"*",2),W1=$P(WTH,"*"),W2=$P(WTH,"*",2)
	I R1'="",$E(NR,0,$L(R1))=R1 S NR=W1_$P(NR,R1,2)
	I R1="",W1'="" S NR=W1_NR
	I R2'="",$E(NR,$L(NR)-$L(R2)+1,99)=R2 S NR=$E(NR,0,$L(NR)-$L(R2))_W2
	I R2="",W2'="" S NR=NR_W2
	Q NR
	;
	;