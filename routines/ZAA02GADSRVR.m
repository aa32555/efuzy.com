ZAA02GADSRVR ;RIVERHEAD INTERFACE FOR ZAA02G-SCRIPT;08:12 AM  1 Jun 1993;19 Apr 1993;24JAN94 11:50A;11MAY2005  11:33
 N K,K1,GR,PT,T,LDT,PLC
 S K=$P(X,"/",1),K1=$P(X,"/",2) S:K1="" K1=1
 ;;
 S (INP("PATIENT"),INP("DOB"),LDT)=""
 I K="" G LOAD
 S GR=$G(^GRG(K))    G:GR="" LOAD
 S PT=$G(^PTG(K,K1)) G:PT="" LOAD
 S T=$P(PT,":",3) S:T="" T=$P(GR,":",7) S INP("PATIENT")=T
 S T=$P(PT,":",12) S:T?6N INP("DOB")=$E(T,3,4)_"/"_$E(T,5,6)_"/"_$E(T,1,2)  S:T?8N INP("DOB")=$E(T,5,6)_"/"_$E(T,7,8)_"/"_$E(T,1,4)
 ; S T=$P(PT,":",14) S INP("DS")=$S(T?6N:$E(T,3,4)_"/"_$E(T,5,6)_"/"_$E(T,1,2),1:"*")
 I $D(INP("DT")) S INP("D")=$P("January,February,March,April,May,June,July,August,September,October,November,December",",",INP("DT"))_" "_$P(INP("DT"),"/",2)_", 19"_$P(INP("DT"),"/",3)
 ;
LOAD ;;
 S INP("PROVIDER")=""
 S INP("CONSULT")=$P($G(PT),":",16)
 S INP("REV")=$P($G(PT),":",8) ; REV is used to store CONSULT2
 S INP("CC1")=""
 S INP("CC2")=""
 S INP("STM")=$P($G(PT),":",11) ; if visit - comes from A1 below
 S INP("FDY")=""
 S INP("DS")=""
 S INP("PROC1")=""
 S INP("PROC2")=""
 S INP("MR")=X Q:K=""
 ;;
 S PLC=$G(INP("SITEC"))
 ;
 ;
 D NEWSTUDY Q:LDT'=""
 ;;
 S PLC=$$SITE S:$G(INP("SITEC"))="" INP("SITEC")=PLC
 Q:LDT=""  Q:PLC=""
 ;
 D OLDSTUDY
 Q
 ;
OLDSTUDY N VISIT  S VISIT=^STUDG(K,K1,PLC,LDT)
 S T=LDT S:T?8N INP("DS")=$E(T,5,6)_"/"_$E(T,7,8)_"/"_$E(T,1,4) S:T?6N INP("DS")=$E(T,3,4)_"/"_$E(T,5,6)_"/"_$E(T,1,2) ; MP changed FDY to DS
 S INP("FDY")=LDT
 S INP("PROC1")=$P(VISIT,":",1)
 S INP("PROC2")=$P(VISIT,":",5)
 S INP("CONSULT")=$P(VISIT,":",2)
 S INP("REV")=$P(VISIT,":",6) ; consult 2
 S INP("CC1")=$P(VISIT,":",13)
 S INP("CC2")=$P(VISIT,":",14)
 S INP("STM")=$P(VISIT,":",17)
 Q
 ;
NEWSTUDY N VISIT,A,DT,D I LDT["|" S PLC=$P(LDT,"|")
 I LDT="" D  Q:LDT=""  S LDT=S4_"|"_PLC_"|"_LDT_"|1"
 . D TDATE S (A,LDT,S4)=""  I PLC'="" D  Q
 .. F  S S4=$O(^STUDU(S4)) Q:S4=""  I $O(^(S4,K,K1,PLC,DT),-1) S LDT=$O(^STUDU(S4,K,K1,PLC,DT),-1) Q
 . S S5="" F  S S5=$O(^STUDU(S5)) Q:S5=""  F  S A=$O(^STUDU(S5,K,K1,A)) Q:A=""  S:$O(^STUDU(S5,K,K1,A,DT),-1)>LDT LDT=$O(^(DT),-1),PLC=A,S4=S5
 Q:PLC=""  Q:LDT=""  I S4="" S LDT="" Q
 S VISIT=^STUDU(S4,K,K1,PLC,$P(LDT,"|",3))
 S T=$P(LDT,"|",3) S:T?6N INP("DS")=$E(T,3,4)_"/"_$E(T,5,6)_"/"_$E(T,1,2) S:T?8N INP("DS")=$E(T,5,6)_"/"_$E(T,7,8)_"/"_$E(T,3,4) ; MP changed FDY to DS
 S INP("FDY")=LDT
 S INP("PROC1")=$P($G(^($P(LDT,"|",3),1)),":")
 S INP("CONSULT")=$P($G(^(1)),":",4)
 S INP("PROC2")=$P($G(^(2)),":")
 S INP("REV")=$P($G(^(2)),":",4) ; consult 2
 S INP("CC1")=$P(VISIT,":",9)
 S INP("CC2")=$P(VISIT,":",10)
 S INP("STM")=$P(VISIT,":",14)
 Q
 ;
TDATE N K,Y,M D DATE^ZAA02GSCRER S DT=YM*100+$P(DT,"/",2)+1 Q
 ;
SITE() ;;This is a PLACE OF SERVICE Code
 ;;If we didn't get the SITE from the block id we will look for the last
 ;; site for this patient (by date).
 S LDT=""  ; Last Date
 I PLC=""  Q $$LSTPLC(K)
 ;; If patient does not have visit in this site - will be blank
 I '$D(^STUDG(K,K1,PLC)) Q ""
 ;; if patient has visits in this site - find the last date
 I $D(^STUDG(K,K1,PLC)) S LDT=$$LSTDTE(PLC) Q PLC
 B
 ;
LSTPLC(K) ; Find last place of service for K account K1 patient#
 N P,D,PL S (P,PL)=""
 F  S P=$O(^STUDG(K,K1,P)) Q:P=""  S D=$$LSTDTE(P) S:D>LDT LDT=D,PL=P
 Q PL
 ;
LSTDTE(PL) ; Find last date of service For PL place
 Q $ZP(^STUDG(K,K1,PL,""))
