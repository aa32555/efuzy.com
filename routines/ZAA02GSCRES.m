ZAA02GSCRES ;PG&A,ZAA02G-SCRIPT,2.10,Electronic Signature Util;;19MAR2002  22:07;;06SEP2006  14:18
 ;;Copyright (C) Patterson, Gray and Associates, Inc.
 ;
 ;  CALLED FROM THE ADS ID BLOCK - PROV
ESADS N Y,y ; I X]"",$P($G(^PVG(X)),":",22)="Y" G NOT
 I $S(ZAA02GSCRP'["s":1,X="":1,1:$E($P($G(@ZAA02GSCR@("PROV",X)),"\",19))'="Y") Q:'$D(INP("eS"))  S $P(INP("eS"),"\",2)="" G ESADS1
 S id=X S:ZAA02GSCRP["a" id="ALL"
 I 1 S $P(INP("eS"),"\",2)=id_$E($P(^(X),"\",19),2,99)
ESADS1 S $P(INP("eS"),"\")=$S($P(INP("eS"),"\",2,3)?.P:"",1:"Y")
 S id=$E($P(INP("eS"),"\")),opi="PDP;ES;id" X op K id Q
 ;
NOT S er="" I 0
 Q
 ;
ESX ; from DIR update
 S C=$G(@ZAA02GWPD@(.011,"eS"))
 I C]"" F A=2,3 S L=$P(C,"\",A) F J=1:1:$L(L,",") S K=$P(L,",",J) I K]"" K @ZAA02GSCR@("DIR",48,K,-(10000000-DOC))
 Q
 S C=$G(@ZAA02GWPD@(.011,"eS")),B=$G(INP("eS")),Q:B=C
 ; I B]"" F L=2,3 S A=$P(B,"\",L) F J=1:1:$L(A,",") S K=$P(A,",",J) S:K]"" A(K)=""
 I C]"" F A=2,3 S L=$P(C,"\",A) F J=1:1:$L(L,",") S K=$P(L,",",J) I K]"",'$D(A(K)) K @ZAA02GSCR@("DIR",48,K,-(10000000-DOC))
 ; S A="" F  S A=$O(A(A)) Q:A=""  S @ZAA02GSCR@("DIR",48,A,-(10000000-DOC))=""  THIS WILL BE SET WHEN PRINTED
 K A Q
 ;
 ; PRINT SIGNATURE LOGIC - CALLED FROM HEADER/FOOTERS
PR(NM) ;
 N A W *27,"*t300R",*27,"*r1A" S A="" F  S A=$O(^ZAA02GSCR("SIGN",NM,A)) Q:A=""  W *27,^(A)
 W *27,"*rB" Q
TR(NM) W *27,"&f0S" D T(NM) W *27,"&f1S" Q
 ;                 
