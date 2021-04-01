ZAA02GADSSJ ;ZAA02G script interface for South Jersey;27APR93  11:32;;;03JAN2000  09:04
 N K,K1,GR,PT,T,LDT,PLC
 S K=X,K1=1 S:X["/" K=+X,K1=$P(X,"/",2)
 S (INP("PATIENT"),INP("DOB"),INP("CONSULT"))=""
 I K="" G LOAD2
 S GR=$G(^GRG(K))    G:GR="" LOAD2
 S PT=$G(^PTG(K,K1)) G:PT="" LOAD2
 S T=$P(PT,":",3) S:T="" T=$P(GR,":",7) S INP("PATIENT")=T
 S T=$P(PT,":",12) S:T?6N INP("DOB")=$E(T,3,4)_"/"_$E(T,5,6)_"/19"_$E(T,1,2) S:T?8N INP("DOB")=$E(T,5,6)_"/"_$E(T,7,8)_"/"_$E(T,1,4)
 I $G(INP("DS"))]"" S INP("DSL")=$P("January,February,March,April,May,June,July,August,September,October,November,December",",",INP("DS"))_" "_$P(INP("DS"),"/",2)_", "_$S($P(INP("DS"),"/",3)<90:20,$P(INP("DS"),"/",3)>100:"",1:19)_$P(INP("DS"),"/",3)
 I $G(INP("DT"))]"" S INP("D")=$P("January,February,March,April,May,June,July,August,September,October,November,December",",",INP("DT"))_" "_$P(INP("DT"),"/",2)_", "_$S($P(INP("DT"),"/",3)<90:20,1:19)_$P(INP("DT"),"/",3)
 S INP("CONSULT")=$P(PT,":",16)
LOAD2 S INP("MR")=X,INP("FDY")="" Q:K=""
 S LDT=0  ; Last Date
 S PLC=$G(SITE)
 I PLC="" S (INP("SITEC"),PLC)=$$LSTPLC(K)
 E  D SITE
 S INP("CC1")=$$GETCC(1)
 S INP("CC2")=$$GETCC(2)
 S INP("CC3")=$$GETCC(3)
 S INP("FDY")=LDT
 I LDT'="",K'="",K1'="",PLC'="" S INP("FNO")=$$FILMNO(K,K1,PLC,LDT) S:$G(INP("DS"))="" T=INP("FNO"),T=$E(T,3,8),INP("DS")=$E(T,3,4)_"/"_$E(T,5,6)_"/"_$E(T,1,2)
 Q
SITE ;;
 S:$D(^FILM(2,K,K1,PLC)) (INP("SITEC"),PLC)=SITE,LDT=$$LSTDTE(K,K1,PLC)
 I '$D(^FILM(2,K,K1,PLC)) S (INP("SITEC"),PLC)=$$LSTPLC(K)
 Q
FILMNO(K,K1,P,D) ;
 I K=""!(P="")!(D="") Q ""
 Q $P($G(^FILM(2,K,K1,P,D)),":",1)
 ;
GETCC(N) ; Get CC's
 Q:'N!(PLC="")!(LDT="") ""
 Q $P($P($G(^FILM(2,K,K1,PLC,LDT)),":",8),"^",N)
 ;
LSTPLC(K) ; Find last place of service for K account K1 patient#
 N P,D,PL S (P,PL)=""
 F  S P=$O(^FILM(2,K,K1,P)) Q:P=""  S D=$$LSTDTE(K,K1,P) S:D>LDT LDT=D,PL=P
 Q PL
LSTPLC1 ;
 F  S P=$O(^STUD(K,K1,P)) Q:P=""  S D=$$LSTDTE(K,K1,P) S:D]LDT LDT=D,PL=P
 Q
 ;
LSTDTE(K,K1,PL) ; Find last date of service For PL place
 Q:PL="" ""
 N D,DT S (D,DT)=""
 F  S D=$O(^FILM(2,K,K1,PL,D)) Q:D=""  S:D>DT DT=D
 Q DT
