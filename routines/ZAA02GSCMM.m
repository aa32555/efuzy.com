ZAA02GSCRMM ;PG&A,ZAA02G-MTS,,MACRO FILE MAINTAINENCE;29DEC94 12:37P
 ;
INIT S A="" F J=1:1 S B=A,A=$O(^ZAA02GWP("~G",A)) Q:A=""  G:$P(^(A),"\",2)="mammo" EDIT
 D BUILD
EDIT S TL=4,BL=22,WO="",MG=76,ZAA02GWPD="^ZAA02GWP(DIR,DOC)",NM="mammo",ZAA02GWPOPT="IM",DIR="~G",DOC=A
 D ENTRY^ZAA02GWPV6
 Q
 ;
BUILD D DATE^ZAA02GWPOA I '$D(^ZAA02GWP("~G")) S ^ZAA02GWP("~G")="GLOSSARY/MACRO DOCUMENTS\"_DT,^ZAA02GWP(98,"~G")=^("~G"),^ZAA02GWP("~G",1)="Master File\sys\"_DT_"\\\\",^ZAA02GWP(98,"~G",1)=^(1)
 S:B="" B=1 S A=B+1,^ZAA02GWP("~G",A)="MTS Phrase File\mammo\"_DT_"\\\\",^ZAA02GWP(98,"~G",A)=^(A) Q
