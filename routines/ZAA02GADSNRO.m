ZAA02GADSNRO ;ZAA02G Script interface for New Rochelle;27APR93  11:32;18OCT94 4:13P;;07JAN99  09:45
 N K,K1,GR,PT,T,LDT,PLC
A I X?9N S:$O(^SK(X/1000000000,"")) X=$O(^("")) S:$O(^SK(X,"")) X=$O(^(""))
 S K=X,K1=1 S:X["/" K=+X,K1=$P(X,"/",2)
 S INP("PATIENT")=""
 S INP("DOB")=""
 I K="" G LOAD
 S GR=$G(^GRG(K))    G:GR="" LOAD
 S PT=$G(^PTG(K,K1)) G:PT="" LOAD
 S T=$P(PT,":",3) S:T="" T=$P(GR,":",7) S INP("PATIENT")=T
 S T=$P(PT,":",12) S:T?6N INP("DOB")=$E(T,3,4)_"/"_$E(T,5,6)_"/"_$E(T,1,2) S:T?8N INP("DOB")=$E(T,5,6)_"/"_$E(T,7,8)_"/"_$E(T,1,4)
 I $D(INP("DT")) S INP("D")=$P("January,February,March,April,May,June,July,August,September,October,November,December",",",INP("DT"))_" "_$P(INP("DT"),"/",2)_", "_$S($P(INP("DT"),"/",3)<90:20,1:19)_$P(INP("DT"),"/",3)
 ;
LOAD ;;
 ; S INP("PROVIDER")=""
 S INP("CONSULT")=""
 S INP("REV")="" ; REV is used to store CONSULT2
 S INP("CC1")=""
 S INP("CC2")=""
 S INP("DS")="" ;MP changed from FDY
 S INP("PROC1")=""
 S INP("PROC2")=""
 S (INP("MR"),INP("ACT"))=X I $D(PT),$P(PT,":",9)]"" S (X,INP("MR"))=$P(PT,":",9)
 Q:K=""
 ;;
 S PLC=$G(SITE) S PLC=$$SITE
 ;;
 I LDT="" Q  ; no VISIT was found (no match Site-Patient)
 ;;
 N VISIT  S VISIT=^STUD(K,K1,PLC,LDT)
 S T=LDT S:T?6N INP("DS")=$E(T,3,4)_"/"_$E(T,5,6)_"/"_$E(T,1,2) S:T?8N INP("DS")=$E(T,5,6)_"/"_$E(T,7,8)_"/"_$E(T,1,4) ; MP changed FDY to DS
 S INP("PROC1")=$P(VISIT,":",1)
 S INP("PROC2")=$P(VISIT,":",3)
 S INP("CONSULT")=$P(VISIT,":",2) I INP("CONSULT")]"" D RPHONE
 ; S INP("REV")=$P(VISIT,":",4) ; 2nd consult
 S INP("CC1")=$P(VISIT,":",7)
 S INP("CC2")=$P(VISIT,":",8)
 Q
SITE() ;;
 ;;If we didn't get the SITE from the block id we will look for the last
 ;; site for this patient (by date).
 S LDT=""  ; Last Date
 I PLC=""  Q $$LSTPLC(K)
 ;; If patient does not have visit in this site - will be blank
 I '$D(^STUD(K,K1,PLC)) Q ""
 ;; if patient has visits in this site - find the last date
 I $D(^STUD(K,K1,PLC)) S LDT=$$LSTDTE(PLC) Q PLC
 B
 ;
LSTPLC(K) ; Find last place of service for K account K1 patient#
 N P,D,PL S (P,PL)=""
 F x=0:0 S P=$O(^STUD(K,K1,P)) Q:P=""  S D=$$LSTDTE(P) S:D]LDT LDT=D,PL=P
 Q PL
 ;
LSTDTE(PL) ; Find last date of service For PL place
 N D,DT S (D,DT)=""
 F x=0:0 S D=$O(^STUD(K,K1,PL,D)) Q:D=""  S:D]DT DT=D
 Q DT
 ;
 ;  THIS CODE CALLED FROM ID BLOCK
LOADN S:'$D(INP("DIST")) INP("DIST")="A" I $G(INP("PROVIDER"))="",$D(TRANS),TRANS]"",$D(^PVG($TR(TRANS,LC,UP))) S INP("PROVIDER")=$TR(TRANS,LC,UP)
 Q
RPHONE S T=INP("CONSULT") I T]"",$D(^RFG(T)),$P(^(T),":",8)]"" S INP("REV")=$P(^(T),":",8)
 Q
 ;
CONV ; CONVERT EXIST MR# ENTRIES IN ZAA02GACT TO SSAN ENTRIES
 S (A,B)="" F J=1:1 S A=$O(^ZAA02GACT(A)) Q:A=""  Q:A?9N  I $P($G(^PTG(A,1)),":",9)]"" F J=1:1 S B=$O(^ZAA02GACT(A,"TRANS",B)) Q:B=""  I $D(^ZAA02GSCR("TRANS",B)) D CONV1
 Q
CONV1 
