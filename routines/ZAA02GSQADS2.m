ZAA02GSQADS2 ;ADS; USER DEFINED FUNCTIONS;;;14AUG2002  15:51
 ;
 F J=1:1 S A=$T(FUNCT+J),C=$T(FUNCT+J+1) Q:A=""  I A?3U.E S B=$P($P(A,";",2)," "),A=$P(A," "),^ZAA02GSQLD(0,"UDF",B)=$S(C?1." "1";".E:$P(C,";",2,99),1:"D "_A_"^ZAA02GSQADS2")
 Q
 ;
 ;  NOTE FORMAT OF LABELLED LINES ARE IMPORTANT
 ;
 ;    IF LABEL CONTAINS MORE THAN 3 ALPHA - THEN IT IS A NEW UDF
 ;    IF THE SECOND LINE BEGINS WITH ";" - THEN EXECUTE STRING
 ;    IF THE SECOND LINE NOT BEGIN WITH ";" - THEN "DO" IS USED
 ;
 ; OLD GPAGNO:   S (X4,X1)="" Q:X2=""  F  S X4=$O(^Tperson(X2,X4)) Q:X4=""  I $P($G(^(X4,1)),"`",31)="T" S X1=X4 Q
 ;
FUNCT ;
LASTNAME ;LASTNAME - lookup lastname from account, patient#
 ;S X1="" Q:X2=""!(X3="")  S X1=$P($G(^Tperson(X2,X3,1)),"`",12) Q
FIRSTNME ;FIRSTNAME - lookup firstname from account, patient#
 ;S X1="" Q:X2=""!(X3="")  S X1=$P($G(^Tperson(X2,X3,1)),"`",13) Q
GLSTNAME ;GLASTNAME - lookup guarantor's lastname from account
 ;S X1="" Q:X2=""  S X2=$O(^IguarCd(X2,"")) Q:X2=""  S X3=$P(X2,"`",2),X2=$P(X2,"`"),X1=$P($G(^Tperson(X2,X3,1)),"`",12) Q
GFIRSTME ;GFIRSTNAME - lookup guarantor's firstname from account
 ;S X1="" Q:X2=""  S X2=$O(^IguarCd(X2,"")),X3=$P(X2,"`",2),X2=$P(X2,"`"),X1=$P($G(^Tperson(X2,X3,1)),"`",13) Q
NAME ;NAME - lookup lastname, first from account, patient#
 ;S X1="" Q:X2=""!(X3="")  S X1=$P($G(^Tperson(X2,X3,1)),"`",12)_", "_$P($G(^(1)),"`",13) Q
GNAME ;GNAME - lookup lastname, first from guarantor's account
 ;S X1="" Q:X2=""  S X2=$O(^IguarCd(X2,"")),X3=$P(X2,"`",2),X2=$P(X2,"`") Q:X2=""  S X1=$P($G(^Tperson(X2,X3,1)),"`",12)_", "_$P($G(^(1)),"`",13) Q
GPATNO ;GUARPATNO - lookup guarantor patient number
 ;S X1="" Q:X2=""!(X2=0)  S X2=$O(^IguarCd(X2,"")) q:X2=""  S X1=$P(X2,"`",2) Q
DOB ;DOB - lookup dateofbirth from account, person#
 ;S X1="" Q:X2=""!(X3="")  S X1=$$DT($P($G(^Tperson(X2,X3,1)),"`",26)) Q
GDOB ;GDOB - lookup guarantor's dateofbirth from account
 ;S X1="" Q:X2=""  S X2=$O(^IguarCd(X2,"")),X3=$P(X2,"`",2),X2=$P(X2,"`") Q:X2=""  S X1=$$DT($P($G(^Tperson(X2,X3,1)),"`",26)) Q
AGE ;AGE - lookup age from account, person#, (ref date)
 ;S:$G(X4)="" X4=+$H S X1="" Q:X2=""!(X3="")  S X1=+$P($G(^Tperson(X2,X3,1)),"`",26) S X1=$S(X1=0:-1,1:X4-X1/365.25\1) Q
RINS ;RINSURANCE - (,trans#,level)
 ;S X1=0 S:$G(X3)="" X3=1 Q:X2=""  S X2=$P($G(^Tcharge(X2,1)),"`",46,63) F X4=1:3:16 I +$P(X2,"`",X4)'=0,$P(X2,"`",X4+1)'="S",$P(X2,"`",X4+2)'="N" S X3=X3-1 I 'X3 S X5=$P($G(^TsysSet(" CHGNOACCEPTTOGUAR",1)),"`",13) S:$P(X2,"`",X4+1)="A"!(X5="NO") X1=+$P
 ***(X2,"`",X4) Q
VOID ;VOIDDATE - (,trans#)
 ;S X1="2500-01-01" Q:X2=""  I $P($G(^Tcharge(X2,1)),"`",64)="V" S X3=$P(^(1),"`",10),X3=$O(^TchCrJoi(X3,X2," A","")) Q:X3=""  S X1=$$DT($O(^(X3,""))) Q
CHGBAL ;CHGBALANCE - (,trans#)
 ;S X1=0 Q:X2=""  S X3=$G(^Tcharge(X2,1)),X1=$P(X3,"`",14)+$P(X3,"`",17)-$P(X3,"`",15)-$P(X3,"`",16)
ACCNTBAL ;ACCNTBAL - (,account,date) - NOT FINISHED
 ;S (X1,X4,X5,X6)=0 Q:X2=""  F  S X4=$G(^TchCrJoi(X2,X4)) Q:X4=""  F  S X5=$O(^TchCrJoi(X2,X4," A",X5)) Q:X5=""  F  S X6=$O(^TchCrJoi(X2,X4," A",X5,X6)) Q:X6>X3  X ^ZAA02GSQLD(0,"UDF","ACCNTB1")
ACCNTB1 ;ACCNTBAL1 - CONTINUATION
 ;,X1=$P(X3,"`",14)+$P(X3,"`",17)-$P(X3,"`",15)-$P(X3,"`",16)
 ;
 ;S R=@A S ACNT=$P(R,"`",10),E=$P(R,"`",9),T=$P(R,"`",12) D  I $D(^TchCrJoi(ACNT,T)) S @glb@(E,ACNT,1,"charge")=""
 ; . S X=$G(@glb@(E,ACNT)),@glb@(E,ACNT)=($P(X,"`",1)+$P(R,"`",14))_"`"_($P(X,"`",2)-$P(R,"`",15))_"`"_($P(X,"`",3)-$P(R,"`",16))_"`"_($P(X,"`",4)+$P(R,"`",17)),^(ACNT,0,A)=""
 ;
XREF ;XREF - (,tablekey,column,row,entity[,row2[,value#]])
 ;S X1="" Q:X2=""  Q:X3=""  Q:X4=""  S X2=$TR(X2,LC,UP),X6=$G(X6) S:$G(X7) X7=X7-1 X ^ZAA02GSQLD(0,"UDF","XREFC1")
XREFC1 ;XREFC1 - CONTINUATION
 ;F  X ^ZAA02GSQLD(0,"UDF","XREFC2") S X1=$P(X1,"`",13+$G(X7)) Q:X1'["~"  S X4=$TR(X1,"~"),X5=X9
XREFC2 ;XREFC2 - CONTINUATION
 ;S X9=X5 F  S X1=$G(^Txrf(" "_X2," "_X3," "_X4," "_X6,+X5,1)) S:X1="" X5=$S(+X5=0:"",1:0) S:$S($P(X1,"`",6)="T":1,X5=""&(X4'="%DEFAULT%"):1,1:0) X5=X9,X1="",X4=$S(X4="%DEFAULT%":"",1:"%DEFAULT%") Q:X1'=""  Q:X4=""  Q:X5=""
XFREF2 ;XREF2 - (,tablekey,column,row,entity[,row2[,value#]])
 ;S X1="" Q:X2=""  Q:X3=""  Q:X4=""  S X2=$TR(X2,LC,UP),X6=$G(X6) S:$G(X7) X7=X7-1 X ^ZAA02GSQLD(0,"UDF","XREFC3")
XREF3 ;XREFC3 - CONTINUATION
 ;S X1=$P($G(^Txrf(" "_X2," "_X3," "_X4," "_X6,+X5,1)),"`",13+$G(X7)) S:X1="" X1=$P($G(^Txrf(" "_X2," "_X3," "_X4," "_X6,0,1)),"`",13+$G(X7)) S X1=$S(X1["~":$TR(X1,"~"),1:X4)
GETFIELD ;GETFIELD - (,table.field,key1,key2,key3,key4)
 ;S X0=$G(^ZAA02GSQLD("MEDICAL",$P(X2,"."))),X8="^T"_$P(X0,"`",2)_"(",X0=$P(X0,"`",6) X ^ZAA02GSQLD(0,"UDF","GETFLD1") X "N X S X=$S($D(@X8):X8,1:""X1""),X1="""",X1="_X9
GETFLD1 ;GETFLD1 - CONTINUATION
 ;X "F X1=3:1:6 S X9=""X""_X1 Q:'$D(@X9)  S X8=X8_$S($P(X0,"","",X1-2):@X9,1:$C(34,32)_$TR(@X9,LC,UP)_$C(34))_"",""" S X8=X8_"1)" S X9=$P($G(^ZAA02GSQLD("MEDICAL",$P(X2,"."),$P(X2,".",2))),"`",9) I X9["$$",$D(RAW) S X9="$P"_$P($P(X9,"$P",2,9),")",1,2)_")" K R
GETFLDE ;GETFIELDE  - (,table.field,key1,key2,key3,entity)
 ;S X0=$G(^ZAA02GSQLD("MEDICAL",$P(X2,"."))),X8="^T"_$P(X0,"`",2)_"(",X0=$P(X0,"`",6) X ^ZAA02GSQLD(0,"UDF","GETFLDE1") X "N X S X=$S($D(@X8):X8,1:""X1""),X1="""",X1="_X9
GETFLDE1 ;GETFLDE1 - CONTINUATION
 ;X "F X1=3:1:6 S X9=""X""_(X1+1) Q:'$D(@X9)  S X9=""X""_X1,X8=X8_$S($P(X0,"","",X1-2):@X9,1:$C(34,32)_$TR(@X9,LC,UP)_$C(34))_"",""" X ^ZAA02GSQLD(0,"UDF","GETFLDE2") S X8=X8_"1)" S X9=$P($G(^ZAA02GSQLD("MEDICAL",$P(X2,"."),$P(X2,".",2))),"`",9)
GETFLDE2 ;GETFLDE2 - CONTINUATION
 ;S X9="X9=X"_X1 S @X9 S X8=X8_$S($D(@(X8_X9_")")):X9,1:0)_","
GETFIELDR ;GETFIELDRAW - (,table.field,key1,key2,key3,key4) ; returns raw rslt
 ;S X0=$G(^ZAA02GSQLD("MEDICAL",$P(X2,"."))),X8="^T"_$P(X0,"`",2)_"(",X0=$P(X0,"`",6) X ^ZAA02GSQLD(0,"UDF","GETFLDR1") X "N X S X=$S($D(@X8):X8,1:""X1""),X1="""",X1="_X9
GETFLDR1 ;GETFLDR1 - CONTINUATION
 ;X "F X1=3:1:6 S X9=""X""_X1 Q:'$D(@X9)  S X8=X8_$S($P(X0,"","",X1-2):@X9,1:$C(34,32)_$TR(@X9,LC,UP)_$C(34))_"",""" S X8=X8_"1)" S X9=$P($G(^ZAA02GSQLD("MEDICAL",$P(X2,"."),$P(X2,".",2))),"`",9) I X9["$$" S X9="$P"_$P($P(X9,"$P",2,9),")",1,2)_")"
RESP ;RESPPARTY - (,tranNo) who is responsible
 ;S X1="" q:X2=""!(X2=0)  S X3=$G(^Tcharge(X2,1)) q:X3=""!($p(X3,"`",71)'=0)!($p(X3,"`",45)=0)  S X1=$p(X3,"`",43)
UNIQUE ;UNIQUE - provides unique record #
 ;S X1=+$G(Jj)
RWINS ;RAWINSURANCE (,trans#,level)
 ;S X1=0 S:$G(X3)="" X3=1 Q:X2=""  S X2=$P($G(^Tcharge(X2,1)),"`",46,63) F X4=1:3:16 I +$P(X2,"`",X4)'=0,$P(X2,"`",X4+1)'="S",$P(X2,"`",X4+2)'="N" S X3=X3-1 I 'X3 S X1=+$P(X2,"`",X4) Q
YEAR ;YEAR (,date) - return the year of the date in YYYY format
 ;S X1=$P(X2,"-",1)
MONTH ;MONTH (,date) - return the year and month in "YYYY-MM" format
 ;S X1=$P(X2,"-",1,2)
BILLST ;BILLSTATUS (,trans#,polid) - return the bill status of the input policy for the charge
 ;S X1="" q:X2=""!(X2=0)  q:X3=""!(X3=0)  S X2=$P($G(^Tcharge(X2,1)),"`",46,63) F X4=1:3:16 I +$P(X2,"`",X4)=+X3 S X1=$P(X2,"`",X4+1) Q
SUBMST ;SUBMITSTATE (,trans#,polid) - return the submit state of the input policy for the charge
 ;S X1="" q:X2=""!(X2=0)  q:X3=""!(X3=0)  S X2=$P($G(^Tcharge(X2,1)),"`",46,63) F X4=1:3:16 I +$P(X2,"`",X4)=+X3 S X1=$P(X2,"`",X4+2) Q
ACCPER ;ACCTPERSON - return patient number if patient or guarantor's patient number if not
 ;S X1="" Q:X2=""!(X2=0)  S:X3'=0 X1=X3 q:X3'=0  S X2=$O(^IguarCd(X2,"")) q:X2=""  S X1=$P(X2,"`",2) Q
FIRSTPAT ;FIRSTPAT - (,account,patient) - returns TRUE if this is the first patient on the account
 ;S X1="F" Q:X2=""!(X2=0)  Q:X3=""!(X3=0)  S X1="T" F X4=X3:-1:1 S X5=$G(^Tperson(X2,X4,1)) I X4=X3&(X5="")!(X4'=X3&(X5'="")) S X1="F" Q
PATNBR ;PATNUMBER (acct,patient) - return string: acct-patient
 ;S X1="" q:X2=""!(X3="")  S X1=X2_"-"_X3
AGECATFD ;AGECATFIRSTDATE (entity,categnumber,agingdate) - return first date of given aging category where aging is based on agingdate
 ;S X1="" Q:X2=""!(X2=0)  Q:X3>5!(X3<0)  S X6=$G(^Tentity(X2,1)) Q:'X6  S:X3=5 X1=0 Q:X3=5  S X5=$P(X6,"`",X3+23) S X1=$$DT(X4-X5) Q
AGECATLD ;AGECATLASTDATE (entity,categnumber,agingdate) - return last date of given aging category where aging is based on agingdate
 ;S X1="" Q:X2=""!(X2=0)  Q:X3>5!(X3<0)  S X6=$G(^Tentity(X2,1)) Q:'X6  S:X3=0 X1=$$DT(X4) Q:X3=0  S X5=$P(X6,"`",X3+22) S X1=$$DT(X4-X5-1) Q
NOYEAR ;NOYEAR (date) - return MM-DD
 ;S X1=$P(X2,"-",2,3)
