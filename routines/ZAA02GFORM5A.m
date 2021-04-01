ZAA02GFORM5A ;PG&A,ZAA02G-FORM,2.62,Operators - 2;6SEP95 2:20P;;;07NOV96  11:58
 ;Copyright (C) 1994, Patterson, Gray & Associates, Inc.
 ;
CALL W ZAA02G("Z"),rf D save D @$P(opi,";",3)
 D load D AP0^ZAA02GFORM4 W ZAA02G("Z"),ro Q
save K ^ZAA02GF(JJ,"local") S:$D(%) ^ZAA02GF(JJ,"local",1,"%")=% S:$D(%1) ^ZAA02GF(JJ,"local",1,"%1")=%1 S:$D(%2) ^ZAA02GF(JJ,"local",1,"%2")=%2
 D @("save"_^ZAA02G("OS")) Q
load S %="%" F  S JJ=$O(^ZAA02GF($J+.99),-1) Q:JJ<$J  Q:$D(^ZAA02GF(JJ,"local"))
 S:JJ<$J JJ=$J F jj=0:0 S %=$O(^ZAA02GF(JJ,"local",%)) Q:%=""  S @%=^(%)
 S %=$G(^ZAA02GF(JJ,"local","%")) K ^ZAA02GF(JJ,"local") Q
 ;
saveMSM S %2="S %1=$ZO(@%1)" G saveX
saveDTM S %2="S %1=$Q(@%1)" G saveX
saveX S %="%" F  S %=$O(@%) Q:%=""  S:$D(@%)#10 ^ZAA02GF(JJ,"local",%)=@% I $D(@%)>1 S %1=% F  X %2 Q:%1=""  S ^ZAA02GF(JJ,"local",%1)=@%1
 S:$D(^ZAA02GF(JJ,"local",1,"%")) %=^("%") S:$D(^("%1")) %1=^("%1") S:$D(^("%2")) %2=^("%2") Q
 ;
savePSM S (%K,%0K,%7)=0 S %0C="%0k"
 D:$D(@%0C) PSMC F   S %0C=$O(@%0C) Q:%0C=""  D PSMC
 Q
PSMC S %7=%0C D PSMD S %0C=%7 Q
PSMD S:$D(@%0C)#2 ^ZAA02GF(JJ,"local",%0C)=@%0C I $D(@%0C)>1 S %A="" F  S %A=$O(@%0C@(%A)) Q:%A=""  S:$D(@%0C@(%A))#2 ^ZAA02GF(JJ,"local",%0C_"("""_%A_""")")=@%0C@(%A) I $D(@%0C@(%A))>1 D PSME
 Q
PSME S %B="" F  S %B=$O(@%0C@(%A,%B)) Q:%B=""  S:$D(@%0C@(%A,%B))#2 ^ZAA02GF(JJ,"local",%0C_"("""_%A_""","""_%B_""")")=@%0C@(%A,%B) I $D(@%0C@(%A,%B))>1 D PSMF
 Q
PSMF S %C="" F  S %C=$O(@%0C@(%A,%B,%C)) Q:%C=""  S:$D(@%0C@(%A,%B,%C))#2 ^ZAA02GF(JJ,"local",%0C_"("""_%A_""","""_%B_""","""_%C_""")")=@%0C@(%A,%B,%C)
 ;
