ZAA02GADSLX ;;09:12 AM  28 Apr 1993;19 Apr 1993;14JUL93 11:08A
 D LOAD
 S K=0 F J=1:1 S A=$P("SITEC",",",J) Q:A=""  I $D(INP(A)) S K=K+1,opi(K)="PDSP;"_$P("SITEC",",",J)_";INP("""_A_""")"
 S opi=K,SRF=rf,rf=ZAA02G("HI") x:K op S rf=SRF K SRF,A
 Q
 ;
LOAD N K,K1,GR,PT,T,LDT,PLC
 S K=$P(X,"/",1),K1=$P(X,"/",2)
 I X?7.11N S (K,K1)="",T=$G(^SK(X)) I T'="" S K=$P(T,":",1),K1=$P(T,":",2)
 S:K1="" K1=1
 ;;
 ;;For Lenox-Hill we have to look also/only by Medical-Record-No
 ;;SITE must be change to look-up Department codes and Not Place-of service
 ;;We need more Operators for referrals CONSULT,CONSULT2,PROVIDER are extras
 ;;
 S INP("PATIENT")=""
 S INP("DOB")=""
 I K="" G LOADX
 S GR=$G(^GRG(K))    G:GR="" LOADX
 S PT=$G(^PTG(K,K1)) G:PT="" LOADX
 S T=$P(PT,":",3) S:T="" T=$P(GR,":",7) S INP("PATIENT")=T
 S T=$P(PT,":",12) S:T?6N INP("DOB")=$E(T,3,4)_"/"_$E(T,5,6)_"/"_$E(T,1,2)
 S T=$P(PT,":",14) S INP("DS")=$S(T?6N:$E(T,3,4)_"/"_$E(T,5,6)_"/"_$E(T,1,2),1:"*")
 I $D(INP("DT")) S INP("D")=$P("January,February,March,April,May,June,July,August,September,October,November,December",",",INP("DT"))_" "_$P(INP("DT"),"/",2)_", 19"_$P(INP("DT"),"/",3)
 ;
LOADX ;;
 ; S INP("PROVIDER")=""
 S INP("CONSULT")="" ;
 S INP("REV")="" ; REV is used to store CONSULT2
 S INP("CC1")=""
 S INP("CC2")=""
 S INP("CC3")=""
 S INP("DS")="" ;MP CHANGED FROM FDY
 S INP("PROC1")=""
 S INP("PROC2")=""
 S INP("SSAN")=X
 S INP("MR")=K I K="" S INP("MR")="NA" Q
 ;;
 S PLC=$G(SITE) D SITE Q  ;,(PLC,INP("SITEC"))=$$SITE
 ;;
 I LDT="" Q  ; no VISIT was found (no match Site-Patient)
 ;;
 N VISIT  S VISIT=^STUDLX(K,K1,PLC,LDT)
 I LDT]"" S T=LDT,INP("DS")=$S(T?6N:$E(T,3,4)_"/"_$E(T,5,6)_"/"_$E(T,1,2),1:"*") ; MP ADDED DS
 S INP("PROC1")=$P(VISIT,":",1)
 S INP("PROC2")=$P(VISIT,":",5)
 S INP("CONSULT")=$P(VISIT,":",2)
 S INP("REV")=$P(VISIT,":",6)  ; consult2
 S INP("CC1")=$P(VISIT,":",13)
 S INP("CC2")=$P(VISIT,":",14)
 S INP("CC3")=$P(VISIT,":",15)
 Q
SITE K REFRESH D SITEP I $D(REFRESH) D AP0^ZAA02GFORM4
 Q
SITEP N (K,K1,REFRESH,X) Q:'$D(^STUDLX(K,K1))  S (A,B,C)="" F J=1:1 S A=$O(^STUDLX(K,K1,A)) Q:A=""  F J=1:1:99 S B=$O(^STUDLX(K,K1,A,B)) Q:B=""  S C=C+1,C(999-C)=A,D(999-C)=B
 I C=1 G SITEE
 S REFRESH=1,Y="10,8\GRHL\1\Patient Studies"
 S Y(0)="\EX\C\C(TO);5`$E(D(TO),3,4)_""/""_$E(D(TO),5,6)_""/""_$E(D(TO),1,2);8`$P(^STUDLX(K,K1,C(TO),D(TO)),"":"");9`$P(^(D(TO)),"":"",2);30\"
 D ^ZAA02GPOP
SITEE Q
 ;         
 ; (code below not used if the above popup code works)
 ;
 ;;This is a Department's Code
 ;;If we didn't get the SITE from the block id we will look for the last
 ;; site for this patient (by date).
 S LDT=""  ; Last Date
 I PLC=""  Q $$LSTPLC(K)
 ;; If patient does not have visit in this site - will be blank
 I '$D(^STUDLX(K,K1,PLC)) Q ""
 ;; if patient has visits in this site - find the last date
 I $D(^STUDLX(K,K1,PLC)) S LDT=$$LSTDTE(PLC) Q PLC
 B
 ;
LSTPLC(K) ; Find last place of service for K account K1 patient#
 N P,D,PL S (P,PL)=""
 F  S P=$O(^STUDLX(K,K1,P)) Q:P=""  S D=$$LSTDTE(P) S:D>LDT LDT=D,PL=P
 Q PL
 ;
LSTDTE(PL) ; Find last date of service For PL place
 Q $ZP(^STUDLX(K,K1,PL,""))
 ;
HEAD ; THIS ADJUSTS THE HEADER AND FOOTER OF THE DOCUMENT AT TIME OF PRINTING
 Q:'$D(@ZAA02GWPD@(.011))  S X=$P(^(.011),"`",6),X=$G(^DPG(X)),Z=$P(X,":",5),X=$P(X,":",4)  Q:X_Z=""
 Q:'$D(@ZAA02GWPD@(.03))  S Y=$P(^(.03),"\",13) S:$P(Y,"/")]"" $P(Y,"/")=$P(Y,"/")_X S:$P(Y,"/",2)]"" $P(Y,"/",2)=$P(Y,"/",2)_X S $P(Y,"/",3)=X,$P(^(.03),"\",13)=Y
 S Y=$P(^(.03),"\",14) S:$P(Y,"/")]"" $P(Y,"/")=$P(Y,"/")_Z S:$P(Y,"/",2)]"" $P(Y,"/",2)=$P(Y,"/",2)_Z S $P(Y,"/",3)=Z,$P(^(.03),"\",14)=Y
 Q
 
