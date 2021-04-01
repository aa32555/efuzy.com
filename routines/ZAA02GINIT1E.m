ZAA02GINIT1 ;PG&A,ZAA02G-CONFIG,2.25,O.S. PARAMETERS  (DTM);8JAN97 2:36P [ 09/20/97  10:12 AM ]
 ;Copyright (C) 1985,7 Patterson, Gray and Assoc., Inc.
 S OS="DTM" W !!,"***> Initializing Operating System Parameters ... ",OS
 S ^ZAA02G("OS")=OS
 S ^("ECHO-ON")="U 0:EM=1"
 S ^("ECHO-OFF")="U 0:EM=0"
 S X="" ;S X="X $C(72,58,49,69,53,45,36,72,60)_""45697"" "
 S X=X_"S ZAA02G(1)=ZAA02G(1)+1 I ZAA02G(1)=1 S ZAA02G(""late"")=$zdevixxlate,ZAA02G(""terp"")=$zdevixinterp"
 S X=X_" U $I:(IXXLATE=^ZAA02G(""XLAT""):IXINTERP=^ZAA02G(""TERP"")) S i=$V(0,^ZAA02G(""XLAT"")*4+$V(1,50,-3),-3) S:$V(0,i+34,$L(^(""XLAT"",1)))'=^(1) i=$$load^%mdevxlate(^ZAA02G(""XLAT""),^(""XLAT"",1))"
 S X=X_" D setall^%mixinterp(^ZAA02G(""TERP"",1))",^("TERM-ON")=$ZXECUTE(X) K X
 S ^("TERMST")="S ZF=$S($ZIOS:$C(0),1:$C($ZIOT)) X:$A(ZF)>160 ""N A R *A S ZF=ZF_$C(A)"""
 S ^("TERM-OFF")=$ZXECUTE("S ZAA02G(1)=ZAA02G(1)-1 I 'ZAA02G(1) U $I:(IXXLATE=$I>1+1:IXINTERP=$I>1)")
 S ^("ERROR")=$S($ZVER["/4.":"$ZT",$ZVER["/6.":"$ZT",1:"$ZE")
 S ^("ERRORR")="$ZE"
 S ^("WRAP-ON")=""
 S ^("WRAP-OFF")=""
 S:$D(^("TERP"))=0 ^("TERP")=2
 S:$D(^("XLAT"))=0 ^("XLAT")=2
 S ^("EXT")="$TR"
 S ^("INIT")=$ZXECUTE("K ZAA02G W:$D(^ZAA02G($I))=0 !!,""Device not defined to the Toolkit - Use ^ZAA02GDEV"",!! Q:$D(^($I))=0  S ZAA02G=^($I),ZAA02G(1)=0,ZAA02G(""T"")=^(""TERMST""),ZAA02GP=^(0,ZAA02G,""P"") X ""F ZAA02GI=0:1:8 I $D(^(ZAA02GI)) X ^(ZAA02GI)"" W ZAA02G(""SET"") K ZAA02GI,ZAA02G(""SET"")")
 ;
 S a="" F i=32:1:255 S $E(a,i+1)=$C(17) ;normal graphics
 S $E(a,13+1)=$C(51),$E(a,10+1)=$C(67),$E(a,12+1)=$C(83),$E(a,127+1)=$C(3),$E(a,128+1)=$C(3),$E(a,8+1)=$C(35),$E(a,0+1)=$C(3) ;cr,lf,ff,del,bs,null
 F i=0:1:9,11,14:1:31,176:1:180,185:1:188,191:1:197 S $E(a,i+1)=$C(19) ;termination
 S ^ZAA02G("TERP",1)=a
 ;
XLAT S X=^ZAA02G("XLAT")
 W !!,"  Input Translation Table to be used by PG&A software? (",X,") " R Y I Y'="",Y<1!(Y>15) W !!,"   must be a number between 0 and 15" G XLAT
 I Y'="",X'=Y S ^("XLAT")=Y
TERP S X=^ZAA02G("TERP")
 W !!,"  Character Interpretation Table to be used by PG&A software? (",X,") " R Y I Y'="",Y<1!(Y>15) W !!,"   must be a number between 0 and 15" G TERP
 I Y'="",X'=Y S ^("TERP")=Y
 Q
 ;
TERMON ;S ZAA02G(1)=ZAA02G(1)+1 I ZAA02G(1)=1 S ZAA02G("in1")=$$getall^%mixinterp(),ZAA02G("late")=$zdevixxlate,ZAA02G("terp")=$zdevixinterp,i=$$load^%mdevxlate(^ZAA02G("XLAT"),^("XLAT",1),0) U $I:(IXXLATE=^ZAA02G("XLAT"):IXINTERP=^ZAA02G("TERP")) D setall^%mixinterp(^ZAA02G("TERP",1))
 ;
DUMP S B=1,X=^ZAA02G("XLAT",1)
W S L=$A(X,B) Q:L<1  S S1=$E(X,B+1,B+L+1),S2=$E(X,B+L+2),B=B+L+3 W !,$A(S2),")   " F I=1:1:L W $A(S1,I)," "
 G W
 ;
TLOAD S i=$V(0,^ZAA02G("XLAT")*4+$V(1,50,-3),-3),i=$V(0,i+34,$L(^("XLAT",1)))
 Q
 ;
TEST S i=$$load^%mdevxlate(3,$C(3,27,91,66,1,13),"") U $I:(IXXLATE=3) W "Press Cursor Down on VT220 to test",!! F J=1:1 W !,"INPUT>>" R A S B=$ZIOT W ?10,"A=",A,?20,"$ZIOT=",B
