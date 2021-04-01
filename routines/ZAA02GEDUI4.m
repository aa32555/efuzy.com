%ZAA02GEDUI4 ;;%AA UTILS;1.24;UTIL: IMPORT ROUTINES/MUMPS;01JUL91  15:56
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
RTN W pBL_tLO_"Import routine(s):"_tHI_tCL
        S %R=bl+2,%C=lm+18,Y="RON\ROF\EX\\15\*%ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789",X="" D ^ZAA02GEDRS G:X=""!(ZAA02GF="EX") EXIT S M=X["*",(F,R,NR)=$P(X,"*")
        Q
IMPORT N pc D DATE^ZAA02GEDS0 S MSG=$P($T(MSG),";;",2),FLN=$P($T(FLN),";;",2),PRE=$P($T(PRE),";;",2),OST=$S(OS="DTM":"DTMGET",1:"OTHGET")
        S REM=$P($T(REM),";;",2),GET=$P($T(@OST),";;",2),FIN=$P($T(FIN),";;",2),CR="CK=CK+"_$P($T(@OS),";;",2),OK=1
        I $$EXIST(R) S:REN NR=$$CNVT(R,RENF,RENT) D:OV>1 CNFRM I OK X MSG,PRE,GET,FIN
        I M F I=0:0 S (R,NR)=$$NEXT(R),OK=1 Q:R=""!($E(R,1,$L(F))]F)  S:REN NR=$$CNVT(R,RENF,RENT) D:OV>1 CNFRM I OK X MSG,PRE,GET,FIN
EXIT K I,F,M,O,R,V,X,Y,CK,CR,DT,FL,FN,GT,IR,NB,NL,NR,OK,OS,OV,PD,FIN,FLD,FLN,GET,MSG,OST,PRE Q
DTMGET ;;S O=$ZRSOURCE(R) F I=1:1:$L(O,$C(10)) S X=$TR($P(O,$C(10),I),$C(9)," "),T=$P(X," "),X=$P(X," ",2,999),X=$E(X,$F(X,$E($TR(X," ","")))-1,511) X:'FL FLN S X=T_" "_X,NL=NL+1,NB=NB+$L(X)+1,@CR,@GT@(NR,V,NL)=X,pc=pc-1 X:'pc MSG W "."
OTHGET ;;X REM ZL @R F I=1:1 S X=$TR($T(+I),$C(9)," ") Q:X=""  S T=$P(X," "),X=$P(X," ",2,999),X=$E(X,$F(X,$E($TR(X," ","")))-1,511) X:'FL FLN S X=T_" "_X,NL=NL+1,NB=NB+$L(X)+1,@CR,@GT@(NR,V,NL)=X,pc=pc-1 X:'pc MSG W "."
REM ;;I OS'="CCSM" ZR
FLN ;;Q:T=""  S FL=1,FLD=$TR($P(X,";",2,9),";","\"),X=";"_FLD
PRE ;;S IR=$S($D(@GT@(0,NR))#2:^(NR),1:"3`0"),V=$P(IR,"`",2)+1 S:V>IR V=1 S $P(IR,"`",2)=V,@GT@(0,NR)=IR,(CK,FL,NL,NB,FLD)=""
FIN ;;S $P(IR,"`",3,7)=FLD_"`"_NL_"`"_NB_"``"_DT_"`"_TID S:CK'=$P(IR,"`",9) $P(IR,"`",6)=DT,$P(IR,"`",9)=CK S @GT@(0,NR)=IR,@GT@(NR,V)=$P(IR,"`",3,99)
MSG ;;S pc=rm-lm-$L(NR)-22 W pBL,tLO_"Importing "_tHI_NR_tLO_" from "_tHI_"MUMPS "_tLO_tCL
CNFRM G WKF:$D(@GT@(0,NR)),ARF:$D(@agl@(0,NR)) Q:OV=2
        U 0 W pBL_tLO_"Import "_tHI_NR_tLO_"? "_tHI_tCL S %R=bl+2,%C=lm+$L(NR)+8,Y="RON\ROF\EX\\3\NY\No;Yes",X=0 D ^ZAA02GEDYN S OK=$S(ZAA02GF="EX":0,1:X) Q
WKF U 0 W pBL_tLO_"Routine "_tHI_NR_tLO_" exists in workfile.  Overwrite it? "_tHI_tCL S %R=bl+2,%C=lm+$L(NR)+43,Y="RON\ROF\EX\\3\NY\No;Yes",X=0 D ^ZAA02GEDYN S OK=$S(ZAA02GF="EX":0,1:X) Q
ARF U 0 W pBL_tLO_"Routine "_tHI_NR_tLO_" exists in archive.  Add to workfile? "_tHI_tCL S %R=bl+2,%C=lm+$L(NR)+45,Y="RON\ROF\EX\\3\NY\No;Yes",X=0 D ^ZAA02GEDYN S OK=$S(ZAA02GF="EX":0,1:X) Q
EXIST(N) N D Q:N="" 0
        I OS="MSM"!(OS["DSM") S D=$D(^ (N))>0 Q D
        I OS="DTM" S D=$L($ZRSOURCE(N))>0 Q D
        I OS="M3" S D=$ZM(2,"R",N)]"" Q D
        I OS="PSM" S D=$D(^UTILITY("R",N))>0 Q D
        I OS="M11" S D=$D(^ROUTINE(N))>0 Q D
        I OS="CCSM" S %ZGD=$ZGD,$ZGD=$ZRD,D=$D(@("^"_R)),$ZGD=%ZGD K %ZGD Q D>0
        Q 1
NEXT(N) I OS="MSM"!(OS["DSM") S N=$O(^ (N)) Q N
        I OS="DTM" S N=$ZRNEXT(N) Q N
        I OS="PSM" S:N="" N=0 S N=$O(^UTILITY("R",N)) Q N
        I OS="M3" S N=$O(^$R(N)) Q N
        I OS="M11" S N=$O(^ROUTINE(N)) Q N
        I OS="CCSM" S:N="" N="A" S %ZGD=$ZGD,$ZGD=$ZRD,N=$O(@("^"_N)),$ZGD=%ZGD K %ZGD Q N
        Q ""
PSM ;;$ZX(X,1)
M3 ;;$ZX(X,1)
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
