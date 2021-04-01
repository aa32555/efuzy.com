ZAA02GADSPCG ;ADS; PROCEDURE CODE/EXCEL INTERFACE;;;28MAY98  09:45
 ;
EXCEL S EXCEL=1 ; ZAA02GWEB
POSTQ ; ZAA02GWEB
 N ST I $G(%("FORM","HELP"))]"" G HELP^ZAA02GSQLH
 M A=%("FORM") S T=$G(A("query")) S I="" F  S I=$O(A("query",I)) Q:I=""  S T=T_" "_A("query",I)
 D:T["|" INSERT
 D sel^ZAA02GSQL3 I $l($G(Sel(0)))<20!($L($G(ERS))) G PE
PE2 W "<center><table cellpadding=5 cellspacing=0 border=1><tr>"
 F I=11:1 S X=$G(Sel(0,I)) Q:X=""  W "<th>",$S($D(Sel(0,I,1)):Sel(0,I,1),1:$P($TR(X,""""),",",3)),"</th>"
 S $ZE="PER^ZAA02GSQL1",LC="abcdefghijklmnopqrstuvwxyz",UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 W "</tr>" S x="" D web^ZAA02GSQL w "</table>" Q
PE S ER="<font color=""#ff0000"">"_$S($G(ERS)]"":ERS,1:"Error in Query Syntax")_"</font>",$ZE="" G QUERY
PER W "SQL Statement Error<p><pre>",$ZE,!,$G(Sel(0)) Q
 ;
INSERT S T=$P(T,"|")_$G(%("FORM","P"_$E($P(T,"|",2))))_$E($P(T,"|",2,99),2,999)
 G:T["|" INSERT Q
