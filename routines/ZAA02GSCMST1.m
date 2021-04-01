ZAA02GSCMST1 ;PG&A,ZAA02G-MTS,1.20,REPORTS-DICT,;2DEC94 4:57P;;;21APR97  17:06
 ;Copyright (C) 1995, Patterson, Gray & Associates, Inc.
C ;
DICT ; PRINTS DICTIONARY
 S Y="25,8\RHLD\1\Select Type of Listing\\Groups Only,Complete Listing of Groups/Codes,Selected Groups Only,Codes used in Patient Information Form,Codes used in Examination Form",Y(0)="\EX" D ^ZAA02GPOP Q:X[";EX"  S TYP=X,TITLE=Y(X)
 K Z,Y I TYP=3 D D31S G:X[";EX" DEND S X="" F J=1:1 S X=$O(X(X)) Q:X=""  S Z(X)=X(X)
 K X S Y="33,10\HLDV\2\Select Printer\\" S X="" F J=1:1 S X=$O(^ZAA02GWP(96,X)) Q:X=""  S Y=Y_X_","
 S Y=$E(Y,1,$L(Y)-1),Y(0)="\EX" D ^ZAA02GPOP Q:X[";EX"   S DV=X Q:DV=""  S %R=3,%C=1 W @ZAA02GP,ZAA02G("CS") S %R=10,%C=23 W @ZAA02GP,"Dictionary Listing is Queued to Printer ",DV H 1
 K Y I TYP=3 S X="" F J=1:1 S X=$O(Z(X)) Q:X=""  S Y("R"_J)=Z(X)
 S DOC="^LISTING",Y("XECUTE")="D D^ZAA02GSCMST1",Y("TYP")=TYP,Y("ZAA02GSCM")=ZAA02GSCM,Y("TITLE")=TITLE D QUEUE^ZAA02GSCMSP
DEND K Y,TYP,X,Z,TITLE Q
D D DATE^ZAA02GSCMST S B(1)=6,B(2)=11,B(3)=.5,B(4)=.9,(B,I)="",(PG,LTM)=1 D DEVSET^ZAA02GWPPC,INIT1^ZAA02GWPPC1 I 49[+DVP S REPORTH="D" D ^ZAA02GSCMST9
 S TYP=@VDOC@("TYP"),ZAA02GSCM=@VDOC@("ZAA02GSCM"),TITLE=@VDOC@("TITLE")
 S LEX="ORG" I $D(@ZAA02GSCM@("PARAM","LEX")) S LEX=^("LEX")
 D @("D"_TYP_1) S DONE=1 Q
D11 S B="" D:'$D(@ZAA02GSCMD@("DICT",2)) DIR D DICTH1 F J=1:1 S B=$O(@ZAA02GSCMD@("DICT",2,B)) Q:B=""  D D12
 Q
D12 S E=@ZAA02GSCMD@("DICT",1,@ZAA02GSCMD@("DICT",2,B)) W ?2,$P(E,"^",4),?7,$E($P(E,"^"),1,20),?28,$E($P(E,"^"),21,57),?68,$P(E,"^",2),?75,$P(E,"^",3),!
 I J>50 W # D DICTH1 S J=0
 Q
 ;
D21 S B="" D:'$D(@ZAA02GSCMD@("DICT",2)) DIR F J=1:1 S B=$O(@ZAA02GSCMD@("DICT",2,B)) Q:B=""  D D22
 Q
D22 D:J<2 DICTH2 S C=@ZAA02GSCMD@("DICT",2,B),E=@ZAA02GSCMD@("DICT",1,C) W:J>1 ! W ?9,$G(BD),$E($P(E,"^"),1,20),"   ",$E($P(E,"^"),21,58),$S($P(E,"^",2)["Y":"  (BIRADS)",1:""),$G(BDO),!
 S A="" F J=J+1:1 S A=$O(@ZAA02GSCMD@("DICT",1,C,A)) Q:A=""  S E=^(A),%=$G(^(A,LEX,1)) D D23
 S J=J+1 I J>48 W # D DICTH2 S J=0
 Q
D23 W ?2,$P(E,"^",4),?7,$E($P(E,"^",2),1,63),?73,$P(E,"^",3),"-",$P(E,"^"),?79,!
 I %]"" S %=%_" " F J=J+1:1 S L=$L($E(%,1,60)," ")-1,L=$L($P(%," ",1,'L+L))+1 W ?10,$E(%,1,L-1),! S %=$E(%,1+L,255) Q:%?." "
 I J>50 W # D DICTH2 W ! S J=1
 Q
 ;
D31 S JJ=$G(DVP(.2)) S:JJ="" JJ="R",J=1 S JJ=$O(@VDOC@(JJ)) Q:$E(JJ)'="R"  S B=^(JJ),DVP(.2)=JJ D D22 G D31
 S DONE=1 Q
 ;
D31S K X S M1="M1A" D GROUP^ZAA02GSCMD K M1 Q
 ;
D41 S TYP=1 G D52
D51 S TYP=2
D52 S PARAM=$G(@ZAA02GSCM@("PARAM","INPUT")) Q:PARAM=""
 S TYP=$S(TYP=1:"P",1:"E")_$S(TYP=1:$P(PARAM,"\"),1:$P(PARAM,"\",2))
 S J=1 D DICTH2
 S A="" F J=J+1:1 S A=$O(@ZAA02GSCMD@("XDIR",TYP,1,A)) Q:A=""  S E=^(A) D D53:$L(A)=1,D54:$L(A)=2
 Q
D53 I J>45 W # D DICTH2 S J=1
 W:J>2 ! W ?9,$G(BD),$E(E,2,99),$G(BDO),! S J=J+1 Q
D54 S B=$P(E,","),B=$G(@ZAA02GSCMD@("DICT",3,B)) Q:B=""  S E=@ZAA02GSCMD@("DICT",1,+B,$P(B,",",2)),%=$G(^($P(B,",",2),LEX,1)) D D23 Q
 ;
DICTH2 X:$D(HDRX) HDRX W !?2,DT,?34 W:'$D(REPORTH) "DICTIONARY LISTING" W ?77,"Page ",PG,!?2,"Codes",?80-$L(TITLE)\2,TITLE,?77,TM,!!! S PG=PG+1
 W ?2,"Code",?25,"Description/Text",?72,"NMD #",?79,"Used",!
 W ?2,"---- ---------------------------------------------------------------- ------ ----",!! Q
DICTH1 X:$D(HDRX) HDRX W !?2,DT,?30 W:'$D(REPORTH) "DICTIONARY LISTING" W ?75,"Page ",PG,!?2,"Groups",?80-$L(TITLE)\2,TITLE,?75,TM,!!! S PG=PG+1
 W ?2,"Code   Group",?30,"Description",?66,"BIRADS",?74,"Active",!
 W ?2,"---- ------------------- -------------------------------------- ------ -------",!! Q
 ;
DIR Q
