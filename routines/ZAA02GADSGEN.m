ZAA02GADSGEN ;GENERIC INTERFACE FOR ZAA02G-SCRIPT;08:12 AM  1 Jun 1993;19 Apr 1993;;09NOV2006  08:41
 N K,K1,GR,PT,T,LDT,PLC,EZ
 I X?9N S:$O(^SK(X/1000000000,"")) X=$O(^("")) S:$O(^SK(X,"")) X=$O(^(""))
 S K=$P(X,"/",1),K1=$P(X,"/",2) S:K1="" K1=1
 S (INP("PATIENT"),INP("DOB"))="" I K="" G LOAD
 S GR=$G(^GRG(K))    G:GR="" LOAD
 S PT=$G(^PTG(K,K1)) G:PT="" LOAD
 S T=$P(PT,":",3) S:T="" T=$P(GR,":",7) S INP("PATIENT")=T
 S T=$P(PT,":",12) S:T?6N INP("DOB")=$E(T,3,4)_"/"_$E(T,5,6)_"/"_$E(T,1,2) S:T?8N INP("DOB")=$E(T,5,6)_"/"_$E(T,7,8)_"/"_$E(T,1,4)
 S PLC=$G(INP("SITEC"))
 ; D SHOW^ZAA02GADSNAS
 I $D(^STUDU) S EZ="" F  S EZ=$O(^STUDU(EZ)) Q:EZ=""  I $D(^STUDU(EZ,K,K1)) D STUDY D:$D(REFRESH) AP0^ZAA02GFORM4 S:LDT[";EX" LDT="" Q
 ;
LOAD ;;
 S INP("CONSULT")=$P($G(PT),":",16)
 S INP("REV")=$P($G(PT),":",8) ; REV is used to store CONSULT2
 S INP("CC1")=""
 S INP("CC2")=""
 S INP("CC3")=""
 S INP("FDY")=""
 S INP("DS")=""
 S INP("PROC1")=""
 S INP("PROC2")=""
 S INP("MR")=X Q:K=""
 I $G(LDT)["|" G NEWSTUDY
 ;;
 S PLC=$G(INP("SITEC")) S PLC=$$SITE
 I $G(LDT)="",$P($G(PT),":",14)?6.8N S T=$P(PT,":",14) D DOS
 ;;
 I $G(LDT)="" Q  ; no VISIT was found (no match Site-Patient)
 ;;
 N VISIT  S VISIT=^STUDG(K,K1,PLC,LDT)
 S T=LDT D DOS
 S INP("FDY")=LDT
 S INP("PROC1")=$P(VISIT,":",1)
 S INP("PROC2")=$P(VISIT,":",5)
 S INP("CONSULT")=$P(VISIT,":",2)
 S INP("REV")=$P(VISIT,":",6) ; consult 2
 S INP("CC1")=$P(VISIT,":",13)
 S INP("CC2")=$P(VISIT,":",14)
 S INP("CC3")=$P(VISIT,":",15)
 Q
DOS S:T?6N INP("DS")=$E(T,3,4)_"/"_$E(T,5,6)_"/"_$E(T,1,2) S:T?8N INP("DS")=$E(T,5,6)_"/"_$E(T,7,8)_"/"_$E(T,1,4) Q
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
TEST S K=123,K1=1,PLC=1
STUDY N:1 (ZAA02G,ZAA02GP,PLC,K,K1,REFRESH,LDT,INP)
STUHP S Y="4,7\RLHSG1DO23\1\PATIENT: "_$G(INP("PATIENT"))_"  DOB: "_$G(INP("DOB"))_"\   DATE     ENT SITE      PROCEDURE          REFERRAL         REPORT  ",REFRESH="",LX=""
 S Y(0)="10\EX,HL\\$S(LS=S2:$J($C(34),4),1:$$DS^ZAA02GADSGEN(S2));10`EZ;1`S;2`$P(LX,"":"");15`$S($P(LX,"":"",4)="""":"""",1:$P($G(^RFG($P(LX,"":"",4))),"":"",2));17`$P(LX,"":"",9);8\"
 S $P(Y(0),"\",6)="Press HELP for CPT text"
 I $G(HL)#2 S Y(0)=$P(Y(0),"$P")_"$P($G(^PCG(+LX)),"":"",2);15"_$P(Y(0),";15",2,9),$P(Y(0),"\",6)="Press HELP for CPT codes"
 S ZAA02GS1="S EZ=$P(TO,""|""),S=$P(TO,""|"",2),S2=$P(TO,""|"",3),S3=$P(TO,""|"",4),LS=S2"
 S ZAA02GPOPALT=$P($T(LOOKT),";",2,99)
 S X="" D ^ZAA02GPOP I X[";HL" S HL=$G(HL)+1 G STUHP
 S LDT=X I X'[";EX",$P($G(^STUDU(+LDT,K,K1,$P(LDT,"|",2),$P(LDT,"|",3))),":",15)]"" D STUNOTE
 Q
STUNOTE N REFRESH K Y,X S Y="20,10\HL\1\NOTES:\\*,*,"_$P(^($P(LDT,"|",3)),":",15)_"*,*,Press RETURN" D ^ZAA02GPOP Q
 ;
LOOKT ;X ZAA02GS1 F  S:S_S2_S3="""" (TO,EZ)=$O(^STUDU(EZ)) Q:TO=""""  S:S2_S3="""" S=$O(^STUDU(EZ,K,K1,S)) I $L(S) S:S3="""" S2=$O(^STUDU(EZ,K,K1,S,S2),-1) I $L(S2) S S3=$O(^STUDU(EZ,K,K1,S,S2,S3)) I $L(S3) S TO=EZ_""|""_S_""|""_S2_""|""_S3,LX=^(S3) Q
 ;
NEWSTUDY N VISIT  S VISIT=^STUDU($P(LDT,"|"),K,K1,$P(LDT,"|",2),$P(LDT,"|",3))
 S T=$P(LDT,"|",3) S:T?6N INP("DS")=$E(T,3,4)_"/"_$E(T,5,6)_"/"_$E(T,1,2) S:T?8N INP("DS")=$E(T,5,6)_"/"_$E(T,7,8)_"/"_$E(T,1,4) ; MP changed FDY to DS
 S INP("FDY")=LDT,LDt=$P(LDT,"|",4)
 S INP("PROC1")=$P($G(^($P(LDT,"|",3),LDt)),":")
 S:$P($G(^(LDt)),":",4)]"" INP("CONSULT")=$P(^(LDt),":",4)
 S INP("PROC2")=$P($G(^(LDt+1)),":")
 S INP("REV")=$P($G(^(LDt+1)),":",4) ; consult 2
 S INP("CC1")=$P(VISIT,":",9)
 S INP("CC2")=$P(VISIT,":",10)
 S INP("CC3")=$P(VISIT,":",11)
 D CCPOP
 S INP("SITEC")=$P(LDT,"|",2)
 K LDt Q
 ;
CCPOP N I F I="CC1","CC2","CC3" I $G(INP(I))]"",$D(^RFG(INP(I))) S INP(I)=INP(I)_"  "_$P(^(INP(I)),":",2)
 Q
 ;
 ;  CODE BELOW CALLED BY RSL LOGIC WHEN REPORT IS CREATED
PROC F II=1,2 S A="PROC"_II I INP(A)]"",$D(^PCG(INP(A))) S $P(Y,"`",5+II)=$E($P(^(INP(A)),":",2)_"~       ",1,6)
 Q
STUDU I $G(INP("ACC"))]"" S ACC=INP("ACC") D
 . S R=$E(ACC,$L(ACC)),T=$E(ACC,1,$L(ACC)-1),S=""
 . S:$D(^XFRTALK) S=$G(^XFRTALK("JAC",T)) S:$D(^XFRDICT) S=$G(^XFRDICT("JAC",T)) S:$D(^XFRGEN("JAC")) S=$G(^XFRGEN("JAC",T)) Q:S=""
 . I $D(^STUDU($P(S,"^"),$P(S,"^",2),$P(S,"^",3),$P(S,"^",4),$P(S,"^",5),R)) S $P(^(R),":",9)=DOC
 . Q
 Q:$L($G(INP("FDY")),"|")<4  Q:$E(INP("FDY"))="W"
 N I,J,K,K1,L S L=INP("FDY"),K=$P($G(INP("MR")),"/"),K1=$P($G(INP("MR")),"/",2) S:K1="" K1=1
 F I=1:1:$L(L,",") S J=$P(L,",",I) I J]"",$D(^STUDU($P(J,"|"),K,K1,$P(J,"|",2),$P(J,"|",3),$P(J,"|",4))) S $P(^($P(J,"|",4)),":",9)=DOC
 Q
STPROC D PROC,STUDU Q
DS(X) Q:$L(X)=6 $E(X,3,4)_"/"_$E(X,5,6)_"/19"_$E(X,1,2) Q $E(X,5,6)_"/"_$E(X,7,8)_"/"_$E(X,1,4)
 ;
 ; move CC info on printed page/searches for address/inserts statement
CC S A=$P($G(@VDOC@("CONDITIONS")),"`",CP),j=$G(^("RFN")) Q:A=""  S A=$P($G(^(A))," ")
 Q:A=""  S ZAA02GSCRP=";;2",INP("CONSULT")=A,ALLVAR="RFN,RFA1,RFA2,RFCSZ" D ^ZAA02GSCRVB
 S A=.03,B=1 F  S A=$O(@ZAA02GWPD@(A)) Q:A=""  I $E($P(^(A),$C(1),4),1,10)'?." " Q
 Q:A=""  S A=$O(^(A),-1) F J=1:1:4 S A=$O(^(A)) Q:A=""  S $P(^(A),$C(1),4)="" F  S i=$P("RFN,RFA1,RFA2,RFCSZ",",",B),B=B+1 Q:i=""  S:$G(INP(i))]"" $P(^(A),$C(1),4)=INP(i) Q
 Q:$D(@VDOC@("CCINSERT"))  S ^("CCINSERT")=1
 D REVERS^ZAA02GWPPC1  S B=$D(@ZAA02GWPD@(A))
 F  S A=$O(^(A)) Q:A=""  I ^(A)["Date: "!(^(A)["DATE: ") Q  ; find marker
 Q:A=""  S A=$O(^(A)) Q:A=""  I $P(^(A),$C(1),4)'?." " S A=$O(^(A)) Q:A=""
 S:$P(^(A),$C(1),4)'?." " B=$O(^(A)),$P(^(B-A/5+A),$C(1),4)=$P(^(A),$C(1),4) S $P(^(A),$C(1),4)=$G(ZAA02G("ron"))_"Report sent to ordering physician:  "_j_$G(ZAA02G("rof"))
 Q
 ; 2ND FORMAT
CC2 I $D(@ZAA02GWPD@(.0115,5)) S @VDOC@("POSTRTF")="D CC2R^ZAA02GADSGEN" Q
 S A=$P($G(@VDOC@("CONDITIONS")),"`",CP),j=$G(^("RFN")) Q:A=""  S A=$P($G(^(A))," ")
 Q:A=""  S ZAA02GSCRP=";;2",INP("CONSULT")=A,ALLVAR="RFN,RFA1,RFA2,RFCSZ,RFL" D ^ZAA02GSCRVB
 S A=.03,B=1 F  S A=$O(@ZAA02GWPD@(A)) Q:A=""  I $E($P(^(A),$C(1),4),1,10)'?." " Q
 Q:A=""  F MMM=1:1:3 S A=$O(@ZAA02GWPD@(A)) Q:A=""
 Q:A=""  S A=$O(^(A),-1) F J=1:1:4 S A=$O(^(A)) Q:A=""  S $P(^(A),$C(1),4)="" F  S i=$P("RFN,RFA1,RFA2,RFCSZ",",",B),B=B+1 Q:i=""  S:$G(INP(i))]"" $P(^(A),$C(1),4)=INP(i) Q
 S j=$P("RFN,RFA1,RFA2,RFCSZ,RFL",",",5)  S j=INP(j)
 F  S A=$O(^(A)) Q:A=""  I ^(A)["Dear Dr."!(^(A)["DEAR DR.") Q  ; find marker
 I A'="" S $P(^(A),$C(1),4)="Dear Dr. "_j_",              "
 Q:$D(@VDOC@("CCINSERT"))  S ^("CCINSERT")=1
 D REVERS^ZAA02GWPPC1  S B=$D(@ZAA02GWPD@(A))
 Q
CC2R S A=$P($G(@VDOC@("CONDITIONS")),"`",CP),j=$G(^("RFN")) Q:A=""  S A=$P($G(^(A))," ") Q:A=""  D
 . N B S ZAA02GSCRP=";;2",INP("CONSULT")=A,ALLVAR="RFN,RFA1,RFA2,RFCSZ,RFL",B="" D ^ZAA02GSCRVB
 M INO=INP K INP D
 . N B S INP("CONSULT")=$P($G(@ZAA02GWPD@(.011)),"`",16),ALLVAR="RFN,RFA1,RFA2,RFCSZ,RFL" D ^ZAA02GSCRVB
 S DE=INP("RFL") I $L(DE)>1 S DE="Dear Dr. "_DE
 Q:INP("RFN")=""  I B'[INP("RFN") Q
 S C="" F J=3:-1:1 S A=$P("RFA1,RFA2,RFCSZ",",",J) I $L($G(INP(A)))>1,B[INP(A) S C=A Q
 I C="" Q  ; for now
 S D3=INP("RFN")_$P($P(B,INP(C)),INP("RFN"),2)_INP(C)
 S C="" F J="RFN","RFA1","RFA2","RFCSZ" I $L($G(INO(J)))>1 S C=C_"\line "_INO(J)
 S C=$P(C,"\line ",2,99),B=$P(B,D3)_C_$P(B,D3,2,9)
 I $L(DE),B[DE,$L(INO("RFL"))>1 S B=$P(B,DE)_"Dear Dr. "_INO("RFL")_$P(B,DE,2,9)
 Q
 W B,!,D3,!,C,!! R CCC Q
