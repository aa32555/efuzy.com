ZAA02GSCMIF ;PG&A,ZAA02G-MTS,1.20,HOST INTERFACE;;;;01JUL97  16:06
 ;
 ;
REFNAME(D) I $P(ZAA02GSCRP,";",3)=2 Q $S($D(^RFG(D)):$P(^(D),":",2),1:D)
 Q D
REFTEL(D) I $P(ZAA02GSCRP,";",3)=2 Q $S(D="":"",1:$P($G(^RFG(D)),":",8))
 Q ""
 ;
PATTEL(D) I $P(ZAA02GSCRP,";",3)=2 Q:$P($G(^PTG(D,1)),":",8)]"" $P(^(1),":",8) Q $P($G(^GRG(D)),":",12)
 I $P(ZAA02GSCRP,";",3)=6 Q:'$O(^DPT("SSN",$TR(D,"-"),"")) "" Q $P($G(^DPT($O(^("")),.13)),"^")
 I $P(ZAA02GSCRP,";",3)=7 Q:'$O(^["SUR,SYS"]RNUM("SSN",D,"")) "" Q $G(^["SUR,SYS"]RPT($O(^("")),"P"))
 Q ""
PATSEX(D) I $P(ZAA02GSCRP,";",3)=2 Q:$P($G(^PTG(D,1)),":",10)]"" $P(^(1),":",10) Q ""
 I $P(ZAA02GSCRP,";",3)=6 Q ""
 I $P(ZAA02GSCRP,";",3)=7 Q:'$O(^["SUR,SYS"]RNUM("SSN",D,"")) "" Q $G(^["SUR,SYS"]RPT($O(^("")),"S"))
 Q ""
PATNAME(D) I $P(ZAA02GSCRP,";",3)=2 Q:$P($G(^PTG(D,1)),":",2)]"" $P(^(1),":",2) Q $P($G(^GRG(D,1)),":",2)
 Q D
 ;
PROVNAM(D) I $P(ZAA02GSCRP,";",3)=2 Q $S($D(^PVG(D)):$P(^(D),":",2),1:D)
 Q D
 ;
SITENAM(D) I $P(ZAA02GSCRP,";",3)=2 Q $S($D(^PSG(D)):$P(^(D),":",2),1:D)
 Q D
 ;
T S ZAA02GSCRP=";;6" W $$PATTEL^ZAA02GSCMIF("078-56-8665"),!
