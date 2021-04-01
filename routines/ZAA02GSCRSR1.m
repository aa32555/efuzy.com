ZAA02GSCRSR1 ;PG&A,ZAA02G-SCRIPT,2.10,SUMTER- VARIABLE PROCESSING;21FEB95 4:42P;;;03OCT97  12:28
 ;Copyright (C) 1997, Patterson, Gray & Associates, Inc.
VAR N X1,X2,X3,X4 S X1=$G(INP("REV")),X2=-$P(X1,"|",2),X1=+$P(X1,"|") I $D(INP("ADMDR")) S X3=$G(INP("ADMDR"))
 E  I $G(DOC) S X3=$G(@ZAA02GSCR@("TRANS",DOC,.011,"ADMDR"))
 I X3]"" S X4=$O(^VA(200,"B",$TR(X3,"."),""))
 I '$D(DBASE) S DBASE="SUR,SYS"
 F I=1:1 S VAR=$P(ALLVAR,",",I) Q:VAR=""  D VAR1
 Q
VAR1 Q:VAR=""  S T="" Q:$T(@VAR)=""  D @VAR S INP(VAR)=T
 Q
 ;
ADM S T=$ZD($P($G(^[DBASE]ADT(X2)),"^",17)) Q
ADMDR S T=$G(^[DBASE]ZQD("SDMDA",+$P($G(^[DBASE]ADT(X2)),"^",14),"MD")) Q
 ;
DTx(dt) Q:dt="" "" Q $E(dt,4,5)_"/"_$E(dt,6,7)_"/"_($E(dt,1,3)+1700)
 ;
PN S T=$P(INP("PATIENT"),",",2)_" "_$P(INP("PATIENT"),",") Q
PLN S T=$P(INP("PATIENT"),",") Q
PA1 S T=$G(^[DBASE]RPT(X1,"A","AS")) Q
PA2 S T="" Q
PCSZ S T=$G(^[DBASE]RPT(X1,"A","C"))_", "_$G(^("ST"))_"  "_$G(^("Z")) S:T?.P T="" Q
PATEL S T=$G(^[DBASE]RPT(X1,"P")) Q
AGE S T=$G(^[DBASE]RPT(X1,"B")) Q:T=""  S T=$H-T\365.25_"Y" Q
SEX S T=$G(^[DBASE]RPT(X1,"S")) Q
RACE S T=$E("WHUBWUOOOOHH",+$G(^[DBASE]RPT(X1,"EO"))) Q
 ;
PVI S T=$P($P($G(INP("P3")),","),"MD"),T=$E($P(T," "))_$E($P(T," ",2))_$E($P(T," ",3)) Q
 ;
 ; REFERRAL STILL NEEDS WORK
RFN S T=X3 Q
RFA1 S T="" S:$G(X4)]"" T=$P($G(^VA(200,X4,.11)),"^",1) Q
RFA2 S T="" S:$G(X4)]"" T=$P($G(^VA(200,X4,.11)),"^",2) Q
RFCSZ S T="" S:$G(X4)]"" T=$G(^VA(200,X4,.11)) S:T]"" T=$P(T,"^",4)_", "_$P($G(^DIC(5,$P(T,"^",5),0)),"^",2)_"  "_$P(T,"^",6) S:T?.P T="" Q
