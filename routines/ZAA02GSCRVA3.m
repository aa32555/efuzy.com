ZAA02GSCRVA3 ;PG&A,ZAA02G-SCRIPT,2.10,VA - VARIABLE PROCESSING;21FEB95 4:42P;;;20NOV97  18:15
 ;Copyright (C) 1992, Patterson, Gray & Associates, Inc.
VAR ; MISC VA LOOKUPS
 F I=1:1 S VAR=$P(ALLVAR,",",I) Q:VAR=""  D VAR1
 Q
VAR1 Q:VAR=""  S T="" Q:$T(@VAR)=""  D @VAR S INP(VAR)=T
 Q
 ;
ADM S T=$TR($E($G(INP("REV")),1,12)," ") Q
DISCH S T=$TR($E($G(INP("REV")),13,22)," ") Q
RELEASE S T="" Q
INPT S T=$P($$DAYS1($G(INP("REV"))),"^") Q
ABSENCE S T=$P($$DAYS1($G(INP("REV"))),"^",4) Q
RAD1 S T=$P($G(INP("REV")),"|",3) I T="" Q
 S X=$P($G(^RAO(75.1,+T,0)),"^",2),X=$S(X="":"",1:$P($G(^RAMIS(71,X,0)),"^"))
 N A F A=1:1:+$P($G(^RAO(75.1,+T,"M",0)),"^",3) S X=X_" - "_$P($G(^RAMIS(71.2,+$G(^RAO(75.1,+T,"M",A,0)),0)),"^")
 S T=X Q
RAD2 S T=$P($$RADS0($G(INP("REV"))),"^",14),T=$S(T="":"",1:$TR($P($G(^VA(200,T,20)),"^",2,3),"^"," ")) Q
RAD3 S T=$P($$RADS0($G(INP("REV"))),"^",16),T=$S(T="":"",1:$$DTx(T)) Q
RAD4 K iT S T=$$RADSH($G(INP("REV")),1) Q
RAD5 S T=$$RADSH($G(INP("REV")),2) Q
RAD6 S T=$$RADSH($G(INP("REV")),3) Q
RAD7 S T=$P($$RADS0($G(INP("REV"))),"^",18),T=$S(T="":"",1:$$DTx(T)) Q
 ;
SUR1 S T=$P($$SURS0($G(INP("REV")),.2),"^",2),T=$S(T="":"",1:$$DTx(T)) Q
SUR2 S T=$P($P($$SURS0($G(INP("REV")),.2),"^",2),".",2)_"0000",T=$S(T="0000":"",1:$E(T,1,2)_":"_$E(T,3,4)) Q
SUR3 S T=$P($P($$SURS0($G(INP("REV")),.2),"^",3),".",2)_"0000",T=$S(T="0000":"",1:$E(T,1,2)_":"_$E(T,3,4)) Q
SUR4 S T=$P($$SURS0($G(INP("REV")),"OP"),"^",1) Q
SUR5 S T=$P($$SURS0($G(INP("REV")),.1),"^",4),T=$S(T="":"",1:$TR($P($G(^VA(200,T,20)),"^",2,3),"^"," ")) Q
SUR6 S T=$P($$SURS0($G(INP("REV")),.1),"^",5),T=$S(T="":"",1:$TR($P($G(^VA(200,T,20)),"^",2,3),"^"," ")) Q
SUR7 S T=$P($$SURS0($G(INP("REV")),.1),"^",13),T=$S(T="":"",1:$TR($P($G(^VA(200,T,20)),"^",2,3),"^"," ")) Q
 ;
 ;
 ;
DAYS1(X) N Y,DGPMIFN Q:X="" "" Q:X'["|" "" S Y=$P($G(^DGPT($P(X,"|",3),0)),"^",2) Q:Y="" "" S DGPMIFN=$O(^DGPM("APRD",$P(X,"|",2),Y,"")) D ^DGPMLOS Q X
RADS0(X) ; Q:+$P(X,"\",2)'=2 ""
 S X=$P(X,"|",3) Q $S(X="":"",1:$G(^RAO(75.1,+X,0)))
RADSH(X,Y) S X=$P(X,"|",3),X=$S(X="":"",1:$G(^RAO(75.1,+X,"H",Y,0)))_$G(iT) K iT  Q:$L(X)<40 X
 S B=$E(X,1,40),L=$L(B)<40+$L(B," ")-1,J=$L($P(B," ",1,'L+L))+1,iT=$E(X,-'L+J+1,9999),X=$E(X,1,J-1) S:$E(X,$L(X))=" " J=$TR(X," ",""),J=$E(J,$L(J)),X=$E(X,1,$L($P(X,J,1,$L(X,J)-1)_J)) Q X
SURS0(X,Y) Q:+$P(X,"\",2)'=5 "" S X=$P(X,"|",3) Q $S(X="":"",1:$G(^SRF(+X,Y)))
 ;
 ;
DTx(dt) Q:dt="" "" Q $E(dt,4,5)_"/"_$E(dt,6,7)_"/"_($E(dt,1,3)+1700)
 ;
PA1(X) Q:'$O(^DPT("SSN",$TR(X,"-"),"")) "" Q $P($G(^DPT($O(^("")),.21)),"^",1)
PA2(X) Q:'$O(^DPT("SSN",$TR(X,"-"),"")) "" Q $P($G(^DPT($O(^("")),.21)),"^",2)
PACSZ(X) Q:'$O(^DPT("SSN",$TR(X,"-"),"")) "" Q $P($G(^DPT($O(^("")),.21)),"^",4)_", "_$P(^(.21),"^",5)_$G(^DXX($P(^(.021),"^",6),0))
PATEL(X) Q:'$O(^DPT("SSN",$TR(X,"-"),"")) "" Q $P($G(^DPT($O(^("")),.13)),"^")
 ;
 ; REFERRAL STILL NEEDS WORK
RFA1(X) Q $P($G(^VA(200,X,.21)),"^",1)
RFA2(X) Q $P($G(^VA(200,X,.21)),"^",2)
RFCSZ(X) Q $P($G(^VA(200,X,.21)),"^",4)_", "_$P(^(.21),"^",5)_$G(^DXX($P(^(.021),"^",6),0))
RFTEL(X) Q $P($G(^VA(200,X,.13)),"^")
