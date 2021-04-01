ZAA02GSCMTR1 ;PG&A,ZAA02G-MTS,1.20,SELECT A LETTER;31OCT94  13:32;;;11NOV98  12:29
 ;Copyright (C) 1995, Patterson, Gray & Associates, Inc.
6 S %R=TOP+1,%C=1 W @ZAA02GP,ZAA02G("CS"),ZAA02G("HI") S SM=$TR(MM,"- ","_`") S:'$D(OC) M=SM
 D:$D(SETM) SETM
 W $TR(M,"`"," ") S %C=$S($D(OC):OC,1:10),u="ABCDEFGHIJKLMNOPQRSTUVWXYZ",l="abcdefghijklmnopqrstuvwxyz"
F1 W @ZAA02GP R C#1 I C'="" S C=$TR(C,l_" ",u_"_"),F="",M=$E(M,1,%C-1)_C_$E(M,%C+1,255) W C S D=0 G F4
 X ZAA02G("T") S F=$E(XX,$F(XX,ZF)),D="D"=F*-2 G F2:F="E",F3:F="F",F4:"CD"[F,F6:F="A",F8:F="B" I F=9 S D=0,%C=$F(SM_"`","`",%C)-1 S:%C>$L(SM) %C=0 G F4
 I "RH"[F S:F="R" %C=%C-1 G:$E(SM,%C)'="_" F4 S D=$F($TR(SM,":/","``"),"`",%C) S:'D D=255 S M=$E(M,1,%C-1)_$E(M,%C+1,D-2)_"_"_$E(M,D-1,255) W @ZAA02GP,$E(M,%C,D-2)
 G F1
F4 S %C=%C+D#$L(SM)+1 G:$E(SM,%C)'="_" F4
 G F1
F2 K OC,OFP G:$D(SETM) E^ZAA02GSCMTR S FP="" G R5^ZAA02GSCMTR
F3 D:$D(SETM) SETM S OC=0,(E,FP)=""
 ; I +M S EP="z",FP=+M,SRC="@ZAA02GSCM@(""TRANS"",FP)",OC=1,E="S I="""",II=10000000-"_FP_",SRC=""@ZAA02GSCM@(""""DIR"""",99)"" I $D(@SRC@(II))" D:0 ARCHT^ZAA02GSCMAT G F7
 F J=1,2,3,4,5,6,7,8 I $P(M,"`",J)'=$P(SM,"`",J) S K=$P(",2,3,4,5,6,7,8",",",J) D F5
 S:E]"" E="S A=D I "_$E(E,1,$L(E)-1) S:E="" E="I 1"
F7 W ZAA02G("ROF") I $D(TESTF) S %R=23,%C=1 W @ZAA02GP,SRC,"  ",$G(FP),"  ",$G(EP),"  ",$G(E) R C
 S:$D(FP) OFP=FP_$C(1)_SRC_$C(1)_EP_$C(1)_E_$C(1)_M_$C(1)_OC G R5^ZAA02GSCMTR
F5 S C=$TR($P(M,"`",J),l_",",u)
 S:'OC OC=$L($P(M,"`",1,J-1))+2
 S:'K K=J I C["[" S E=E_"$P(A,""`"","_K_")["""_$TR(C,"_:/[","")_"""," Q
 F A=1:1:$L(C,"_") I ":/"'[$P(C,"_",A) S E=E_"$E($P(A,""`"","_K_"),"_$S(A>1:$L($P(C,"_",1,A-1)_11),1:1)_","_$L($P(C,"_",1,A))_")="""_$P(C,"_",A)_""","
 Q
F6 S %C=1 G F1
F8 S %C=$L(SM) G F1
SETM S $P(M,"`",+SETM)=$E($P(SETM,",",2)_"______________",1,$L($P(M,"`",+SETM))) Q
 ;
