ZAA02GCASEFIX ;Remove Invalid Ins Order from Cases;04/07/2015 12:05:26
 S A="" F  S A=$O(^CASE(A)) Q:A=""  D
 . S P="" F  S P=$O(^CASE(A,P)) Q:P=""  D
 .. S E="" F  S E=$O(^CASE(A,P,E)) Q:E=""  D
 ... S C="" F  S C=$O(^CASE(A,P,E,C)) Q:C=""  I $D(^CASE(A,P,E,C,0)) D
 .... S OK=1,L=^CASE(A,P,E,C,0) F I=1:1:$L(L,":") S O=$P(L,":",I) Q:O=""  D
 ..... I O,'$D(^GRG(A,O)) S OK=0,$P(L,":",I,I+1)=$P(L,":",I+1)
 .... I 'OK S ^CASE(A,P,E,C,0)=L W !,"Account ",A,"/",P," Case ",C," Repaired"
