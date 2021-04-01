ZAA02GADSMID ;SAME AS ZAA02GADSGEN BUT FOR MR# IN REV;
 N K,K1,GR,PT,T,LDT,PLC,EZ
 I X?9N S:$O(^SK(X/1000000000,"")) X=$O(^("")) S:$O(^SK(X,"")) X=$O(^(""))
 S K=$P(X,"/",1),K1=$P(X,"/",2) S:K1="" K1=1
 S (INP("PATIENT"),INP("DOB"))="" I K="" G LOAD
 S GR=$G(^GRG(K))    G:GR="" LOAD
 S PT=$G(^PTG(K,K1)) G:PT="" LOAD
 S T=$P(PT,":",3) S:T="" T=$P(GR,":",7) S INP("PATIENT")=T
 S T=$P(PT,":",12) S:T?6N INP("DOB")=$E(T,3,4)_"/"_$E(T,5,6)_"/"_$E(T,1,2)
 S PLC=$G(INP("SITEC"))
 I $D(^STUDU) S EZ=$S($D(^EZ($I)):^($I),1:1) I $D(^STUDU(EZ,K,K1)) D STUDY D:$D(REFRESH) AP0^ZAA02GFORM4 S:LDT[";EX" LDT=""
 ; S T=$P(PT,":",14) S INP("DS")=$S(T?6N:$E(T,3,4)_"/"_$E(T,5,6)_"/"_$E(T,1,2),1:"*")
 ;
LOAD ;;
 S INP("PROVIDER")=""
 S INP("CONSULT")=$P($G(PT),":",16)
 S INP("REV")=$P($G(PT),":",8)
 S INP("CC1")=""
 S INP("CC2")=""
 S INP("CC3")=""
 S INP("FDY")=""
 S INP("DS")=""
 S INP("PROC1")=""
 S INP("PROC2")=$P($G(PT),":",11)
 S INP("MR")=X Q:K=""
 I $G(LDT)["|" G NEWSTUDY
 ;;
 S PLC=$G(INP("SITEC")) S PLC=$$SITE
 ;;
 I LDT="" Q  ; no VISIT was found (no match Site-Patient)
 ;;
 N VISIT  S VISIT=^STUDG(K,K1,PLC,LDT)
 S T=LDT S:T?6N INP("DS")=$E(T,3,4)_"/"_$E(T,5,6)_"/"_$E(T,1,2) ; MP changed FDY to DS
 S INP("FDY")=LDT
 S INP("PROC1")=$P(VISIT,":",1)
 S INP("PROC2")=$P(VISIT,":",5)
 S INP("CONSULT")=$P(VISIT,":",2)
 S INP("REV")=$P(VISIT,":",6) ; consult 2
 S INP("CC1")=$P(VISIT,":",13)
 S INP("CC2")=$P(VISIT,":",14)
 S INP("CC3")=$P(VISIT,":",15)
 Q
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
 F  S P=$O(^STUDG(K,K1,P)) Q:P=""  S D=$$LSTDTE(P) S:D]LDT LDT=D,PL=P
 Q PL
 ;
LSTDTE(PL) ; Find last date of service For PL place
 Q $ZP(^STUDG(K,K1,PL,""))
 ;
 ;
TEST S K=700,K1=1,PLC=1
STUDY N:1 (ZAA02G,ZAA02GP,PLC,K,K1,EZ,REFRESH,LDT,INP) S Y="8,7\RLHSG1\1\STUDY: "_$G(INP("PATIENT"))_"\  DATE     SITE      PROCEDURE          REFERRAL         REPORT  ",REFRESH="",LX=""
 S Y(0)="10\EX\\$S(LS=S2:$J($C(34),4),1:$E(S2,3,4)_""/""_$E(S2,5,6)_""/""_$E(S2,1,2));8`S;4`$P(LX,"":"");15`$S($P(LX,"":"",4)="""":"""",1:$P($G(^RFG($P(LX,"":"",4))),"":"",2));17`$P(LX,"":"",9);8\"_PLC
 S ZAA02GS1="S S=$P(TO,""|""),S2=$P(TO,""|"",2),S3=$P(TO,""|"",3)"
 S ZAA02GPOPALT=$P($T(LOOKT+(PLC="")),";",2,99)
 S X="" D ^ZAA02GPOP S LDT=X Q
 ;
LOOKT ;X ZAA02GS1 S LS=S2 F jj=1:1 S:S3="""" S2=$O(^STUDU(EZ,K,K1,S,S2),-1) S:jj=999 TO="""" S:S2="""" TO="""" Q:TO=""""  S S3=$O(^STUDU(EZ,K,K1,S,S2,S3)) I $L(S3) S TO=S_""|""_S2_""|""_S3,LX=^(S3) Q
 ;X ZAA02GS1 S LS=S2 F jj=1:1 S:S2_S3="""" S=$O(^STUDU(EZ,K,K1,S)) S:jj=999 TO="""" S:S="""" TO="""" Q:TO=""""  S:S3="""" S2=$O(^STUDU(EZ,K,K1,S,S2),-1) S:$L(S2) S3=$O(^STUDU(EZ,K,K1,S,S2,S3)) I $L(S3) S TO=S_""|""_S2_""|""_S3,LX=^(S3) Q
 ;
NEWSTUDY N VISIT  S VISIT=^STUDU(EZ,K,K1,$P(LDT,"|"),$P(LDT,"|",2))
 S T=$P(LDT,"|",2) S:T?6N INP("DS")=$E(T,3,4)_"/"_$E(T,5,6)_"/"_$E(T,1,2) ; MP changed FDY to DS
 S INP("FDY")=LDT
 S INP("PROC1")=$P($G(^($P(LDT,"|",2),1)),":")
 S INP("CONSULT")=$P($G(^(1)),":",4)
 S INP("PROC2")=$P($G(^(2)),":")
 S INP("REV")=$P($G(^(2)),":",4) ; consult 2
 S INP("CC1")=$P(VISIT,":",9)
 S INP("CC2")=$P(VISIT,":",10)
 S INP("CC3")=$P(VISIT,":",11)
 Q
 ;
 ;
 ;  CODE BELOW CALLED BY RSL LOGIC WHEN REPORT IS CREATED
PROC F II=1,2 S A="PROC"_II I INP(A)]"",$D(^PCG(INP(A))) S $P(Y,"`",5+II)=$E($P(^(INP(A)),":",2)_"~       ",1,6)
 Q
STUDU Q:$G(INP("FDY"))'["|"
 N I,J,K,K1,EZ S J=INP("FDY"),K=$P($G(INP("MR")),"/"),K1=$P($G(INP("MR")),"/",2),EZ=$S($D(^EZ($I)):^($I),1:1) S:K1="" K1=1 F I=0,1 I $D(^STUDU(EZ,K,K1,$P(J,"|"),$P(J,"|",2),$P(J,"|",3)+I)) S $P(^($P(J,"|",3)+I),":",9)=DOC
 Q
STPROC D PROC,STUDU Q
