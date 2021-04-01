ZAA02GFIXDGG ;Fix Diagnosis Codes Trailing Spaces;04/07/2015 12:05:27
 S DT=$H
 M ^ZAA02GVBOLD(DT,"DGG")=^DGG
 M ^ZAA02GVBOLD(DT,"TRG")=^TRG
 K ^TEMP($J)
 S DG="" F  S DG=$O(^DGG(DG)) Q:DG=""!(DG="~#")  S NDG=DG D RTRIM(.NDG) D
 . S DATA=^DGG(DG)
 . I DG'=NDG&($D(^DGG(NDG))) S ^TEMP($J,"INV",$P(DATA,":",11))=$P(^DGG(NDG),":",11),^TEMP($J,"DG",DG)=""
 . I DG'=NDG&('$D(^DGG(NDG)))!(DG=NDG&($P(DATA,":",5)'=NDG)) D
 .. D UPD("DG",DATA)
 .. F I=1,5,6,7 S $P(DATA,":",I)=NDG
 .. S ^DGG(NDG)=DATA
 .. S SRT=$$KEY^BLDDGSRT(NDG)
 .. S ^DGSRT(SRT)=NDG
 .. S SRT=$$KEY^BLDDGSRT(DG)
 .. I DG'=NDG K ^DGSRT(SRT)
 .. I DG'=NDG K ^DGG(DG)
 I $D(^TEMP($J)) D TRANSFIX K ^TEMP($J)
 D ALPHAXREF
 Q
RTRIM(STR) ;Right Trim
 S LEN=$L(STR)
 I LEN=0!($E(STR,LEN)'=" ") Q STR
 S STR=$E(STR,1,(LEN-1))
 D RTRIM(.STR)
UPD(ID,MSG) ; Update update ID info
 N SEQ
 I $G(ID)="" Q
 S MSG=$G(MSG)
 L ^ZAA02GVBHIST
 S SEQ=$O(^ZAA02GVBHIST("UPD",ID,""),-1)+1
 S ^ZAA02GVBHIST("UPD",ID,SEQ)=$H_"`"_MSG
 L -^ZAA02GVBHIST
 Q
ALPHAXREF ;Rebuild Alpha
 S NM="DG"
 S ZAA02GVB=1
 D MN^BLDACD
 Q
TRANSFIX ;Fix Transactions, delete replaced DG codes
 S E="" F  S E=$O(^TRG(E)) Q:E=""  D
 . S TR="" F  S TR=$O(^TRG(E,TR)) Q:'TR  S DATA=$G(^(TR)) I $P(DATA,":",4)="P" D
 .. S DG1=$P(DATA,":",22),DG2=$P(DATA,":",23),DG3=$P($P(DATA,":",21),"^"),DG4=$P($P(DATA,":",21),"^",2)
 .. S FIX=0 F I=1:1:4 S DG="DG"_I I @DG]"",$D(^TEMP($J,"INV",@DG)) S NDG=^(@DG),@DG=NDG,FIX=FIX+1
 .. I FIX D UPD("TR",(TR_"|"_E_"|"_DATA)) S $P(DATA,":",22)=DG1,$P(DATA,":",23)=DG2,$P(DATA,":",21)=DG3_"^"_DG4,^TRG(E,TR)=DATA
 S DG="" F  S DG=$O(^TEMP($J,"DG",DG)) Q:DG=""  K ^DGG(DG)
 Q
