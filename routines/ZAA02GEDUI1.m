%ZAA02GEDUI1  
BEG D DATE^ZAA02GEDS0 S TDY=DT,GTI=wgl_"(0)",GTR=wgl_"(NR,V)",CR="CK=CK+"_$P($T(@(OS_"CR")),";;",2),TAB=$C(9)
	S CPL=0 I $D(@sgl@(0,"FMT","COP"))#2 S CPL=$P(^("COP"),"`",2)
	D @FM U 0 C FILE K pc,I,R,V,X,FL,FM,FN,IR,NR,FLD,GTI,GTR,TAB,TDY,FILE Q
WKS S EOR="~R~",EOF="~E~" F I=0:0 S X=$$NXTREC Q:X="~I~"
	D IMP Q
DTM S EOR=$C(13,12),EOF="" D IM Q
DSM S EOR="",EOF="" D IM Q
MSM S EOR="",EOF="" D IM Q
IMP S (R,NR)=$$NXTREC I REN S NR=$$CNVT(R,RENF,RENT)
IM Q:R=EOF  D:OV>1 CNF I 'OK D SKIP G IMP
W1 U 0 D MSG S (CK,LC,NB,NL,FL,FLD)="",IR=$S($D(@GTI@(NR)):^(NR),1:"3`0`"_TDY),V=$P(IR,"`",2)+1 S:V>IR V=1 S $P(IR,"`",2)=V_"`"
W2 S X=$$NXTREC G:X=EOR W3 I X[TAB S X=$P(X,TAB)_" "_$P(X,TAB,2,511)
	I 'FL,$E(X)'=ci,$P(X," ")]"" S FLD=$TR($P(X,";",2,99),";","\"),FL=1
	I $E(X)'=ci,$TR(X," ","")]"" S NL=NL+1,NB=NB+$L(X)+1,@CR
	S LC=LC+1,@GTR@(LC)=X,pc=pc-1 U 0 D:'pc MSG W "." G W2
W3 S $P(IR,"`",4,5)=NL_"`"_(NB+CPL),$P(IR,"`",9)=CK S:$P(IR,"`",3)="" $P(IR,"`",3)=FLD S:$P(IR,"`",6)="" $P(IR,"`",6)=TDY S:$P(IR,"`",7)="" $P(IR,"`",7)=TDY S @GTI@(NR)=IR,@GTR=$P(IR,"`",3,99) G IMP
SKIP F I=0:0 S X=$$NXTREC Q:X=EOR
	Q
MSG S pc=rm-lm-$L(NR)-23 W pBL,tLO_"Importing "_tHI_R_tLO_" to "_tHI_"WORKFILE "_tLO_tCL Q
CNF I OV=2 G WKF:$D(@GTI@(NR)),ARF:$D(@agl@(0,NR)) Q
CONF U 0 W pBL_tLO_"Import "_tHI_NR_tLO_"? "_tHI_tCL S %R=bl+2,%C=lm+$L(NR)+8,Y="RON\ROF\EX\\3\NY\No;Yes",X=0 D ^ZAA02GEDYN S OK=$S(ZAA02GF="EX":0,1:X) Q
WKF U 0 W pBL_tLO_"Routine "_tHI_NR_tLO_" exists in workfile.  Overwrite it? "_tHI_tCL S %R=bl+2,%C=lm+$L(NR)+43,Y="RON\ROF\EX\\3\NY\No;Yes",X=0 D ^ZAA02GEDYN S OK=$S(ZAA02GF="EX":0,1:X) Q
ARF U 0 W pBL_tLO_"Routine "_tHI_NR_tLO_" exists in archive.  Add to workfile? "_tHI_tCL S %R=bl+2,%C=lm+$L(NR)+45,Y="RON\ROF\EX\\3\NY\No;Yes",X=0 D ^ZAA02GEDYN S OK=$S(ZAA02GF="EX":0,1:X) Q
PSMCR ;;$ZX(X,1)
M11CR ;;$ZC(X)
DTMCR ;;$ZCRC(X,1)
CCSMCR ;;$ZCRCX(X)
MSMCR ;;$ZCRC(X,1)
DSMCR ;;$L(X)
DSM4CR ;;$L(X)
NXTREC() I FMT'="DTM" U FILE R X U 0 Q X
	I '$D(CRLF) S:FMT="DTM" CRLF=$C(13,10)
	S X="" I $D(BUF),BUF[CRLF S X=$P(BUF,CRLF),BUF=$P(BUF,CRLF,2,999) U 0 Q X
	I $D(BUF) S X=BUF,BUF=""
	I '$D(BUF) S BUF=""
NX U FILE R ST#200 S X=X_$P(ST,CRLF),BUF=$P(ST,CRLF,2,999)
	I ST="" S:X=$C(13) X=EOR Q X
	I ST'[CRLF G NX
	U 0 S:X=$C(13) X=EOR K ST Q X
CNVT(RTN,REP,WTH) N NR,R1,W1,R2,W2 S NR=RTN,R1=$P(REP,"*"),R2=$P(REP,"*",2),W1=$P(WTH,"*"),W2=$P(WTH,"*",2)
	I R1'="",$E(NR,0,$L(R1))=R1 S NR=W1_$P(NR,R1,2)
	I R1="",W1'="" S NR=W1_NR
	I R2'="",$E(NR,$L(NR)-$L(R2)+1,99)=R2 S NR=$E(NR,0,$L(NR)-$L(R2))_W2
	I R2="",W2'="" S NR=NR_W2
	Q NR
	;
	;