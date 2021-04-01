ZAA02GSCRVB ;PG&A,ZAA02G-SCRIPT,2.10,VARIABLE PROCESSING;22DEC94 9:52A;06MAR2002  11:27;;Fri, 29 DeC 2017  10:35
 ;Copyright (C) 1992, Patterson, Gray & Associates, Inc.
VAR S B=$P(ZAA02GSCRP,";",3) G ADS:B=2,VAR^ZAA02GSCRMI1:B=3,VAR^ZAA02GSCRCHM:B=4,VAR^ZAA02GSCRSRC:B=5,VAR^ZAA02GSCRVA3:B=1,VAR^ZAA02GSCRSR1:B=7,@("VAR^ZAA02GSCRo"_B) Q
ADS D ^ZAA02GADS1
 S LOWVAR="RFF,RFL,RFN,RFA1,RFA2,RFCS,RFCSZ,PV,PV3,PV12,PV23,CC1F,CC2F,CC3F,CC1L,CC2L,CC3L,CC1FL,CC2FL,CC3FL,CC1N,CC2N,CC3N,CC1A1,CC2A1,CC3A1,CC1A2,CC2A2,CC3A2,CC1CSZ,CC2CSZ,CC3CSZ,PATIENTL,RFN1,RFL1"
 D LOW
 ;  S B=$D(@ZAA02GWPD@(.011,0)) F J=1:1:$L(ALLVAR,",") S B=$P(ALLVAR,",",J) I B'="",$D(INP(B)),INP(B)'="" S ^(B)=INP(B)
 F J="CC1F","CC2F","CC1N","CC2N","CC3N","CC1FL","CC2FL","CC3FL" I $D(INP(J)),INP(J)'["cc:" S INP(J)=$S(INP(J)?.P:" ",1:"cc: "_INP(J)) I $L(INP(J))>1,$G(INP("RFN"))]"" S INP("RFGCN")="Ordered by: "_INP("RFN")
 I ALLVAR["TT1",$D(INP("TEMPLATE")),INP("TEMPLATE")]"",$D(@ZAA02GSCR@(106,0,INP("TEMPLATE")))  S INP("TT1")=^(INP("TEMPLATE"))
 I ALLVAR["TT2",$D(INP("TEMPLATE2")),INP("TEMPLATE2")]"",$D(@ZAA02GSCR@(106,0,INP("TEMPLATE2")))  S INP("TT2")=^(INP("TEMPLATE2"))
 Q
LOW N C,A,B,J,I,K,LC,UP S UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ",LC="abcdefghijklmnopqrstuvwxyz"
 F J=1:1 S B=$P(LOWVAR,",",J) Q:B=""  I $D(INP(B)) S C=INP(B) D LW1 S INP(B)=C
 K LOWVAR Q
LW1 I C?.E1L.E Q
 I C?.E1","1U.E F I=2:1:$L(C,",") S:$E($P(C,",",I))?1U $P(C,",",I)=" "_$P(C,",",I)
 F I=1:1:$L(C," ") S A=$P(C," ",I) D
 . I $L(A),"AK,AL,AR,AZ,CA,CO,CT,DC,DE,FL,GA,HI,IA,ID,IL,IN,KS,KY,LA,MA,MD,ME,MI,MN,MO,MS,MT,NC,ND,NE,NH,NJ,NM,NV,NY,OH,OK,OR,PA,RI,SC,SD,TN,TX,UT,VA,VT,WA,WI,WV,WY,IV,II,DO"[A Q
 . S $P(C," ",I)=$E(A)_$S(A="MDR":"DR",A="DPM":"PM",A="DMD":"MD",A="DMT":"MT",A="DMP":"MP",A="FACP":"ACP",A="PAC":"AC",A="FACC":"ACC",A="DDS":"DS",A="FACR":"ACR",A="ARNP-C":"RNP-C",A="III":"II",A="PHD":"hD",1:$TR($E(A,2,99),UP,LC))
 I C?.E1"."1L.E F I=2:1:$L(C,".") I $E($P(C,".",I))?1L S A=$P(C,".",I),$P(C,".",I)=$TR($E(A),LC,UP)_$E(A,2,99)
 I C?.E1"'"1L.E F I=1:1:$L(C,"'") S A=$P(C,"'",I),$P(C,"'",I)=$TR($E(A),LC,UP)_$E(A,2,99)
 I C["Mac",$L(C)>5,C'["Machesney" S C=$P(C,"Mac")_"Mac"_$TR($E($P(C,"Mac",2,9)),LC,UP)_$E($P(C,"Mac",2,9),2,99)
 I C["Mc" S C=$P(C,"Mc")_"Mc"_$TR($E($P(C,"Mc",2,9)),LC,UP)_$E($P(C,"Mc",2,9),2,99)
 I C?.E1","2L,$L(C,",")=2 S $P(C,",",2)=" "_$TR($P(C,",",2),LC,UP)
 I C?.E1L1"-"1L.E S $P(C,"-",2,9)=$TR($E($P(C,"-",2)),LC,UP)_$E($P(C,"-",2,9),2,99)
 Q
LC N C,A,B,I,K,LC,UP S UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ",LC="abcdefghijklmnopqrstuvwxyz",C=J D LW1 S J=C Q
TT R "INPUT-",C,!?6 S INP("T")=C,LOWVAR="T" D LOW W INP("T"),! G TT
 ;
 ;
VA ; MISC VA LOOKUPS
 F I=1:1 S VAR=$P(ALLVAR,",",I) Q:VAR=""  D VAR1
 Q
VAR1 Q:VAR=""  Q:$T(@VAR)=""  D @VAR S INP(VAR)=T
 Q
 ;
LIST S LIST="D LISTX^ZAA02GSCRVB ;"_C_";"_(F-$L(W)-4)_";"_$E(L,F,99),J="",L=$E(L,1,F-1) Q
LISTX S Y=$P(LIST,";",4),F=$P(LIST,";",3),C=$P(LIST,";",2)
 S $P(@ZAA02GWPD@(C),$C(1),4)=$E($P(^(C),$C(1),4)_$J("",F),1,F)_$$PV($G(INP("PROVIDER")))
 F J=2:1:$L(Y,",") I $P(Y,",",J)'=$G(INP("PROVIDER")) S B=C,C=$O(@ZAA02GWPD@(C)) S:C="" C=B+10,^(C)=B_$C(1,1,1) S $P(@ZAA02GWPD@(C),$C(1),4)=$E($P(^(C),$C(1),4)_$J("",F),1,F)_$$PV($P(Y,",",J))
 K LIST,t Q
PV(t) Q:t="" "" I t'["^" Q $P($G(^PVG(t)),":",$S(+Y=0:2,1:+Y))
 Q $G(@t)
