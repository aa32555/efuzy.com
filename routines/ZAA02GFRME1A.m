ZAA02GFRME1A ;PG&A,ZAA02G-FORM,2.62,FORMS EDITOR, PART 5;07JUL94  12:36;;;05JAN95  13:42
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
CTL D INIT K D,path
 D SORTSCOP K P S $P(P,".",133)=""
 S scope=SCR_"-"_SN D ORDER
 S scope="" F path=0:0 S path=$O(path(path)) Q:'path  F path=path:0 S scope=$O(path(path,scope)) Q:scope=""  D ORDER
END K P,path,C,DO,K,D Q
 ;
INIT S %R=23,%C=1 W:'$d(qt) ZAA02G("LO"),ZAA02G("RON"),@ZAA02GP,ZAA02G("CL"),"Enter Editing Order:  (please wait)" ;"  (enter data #s separated with commas - may use XX:XX:XX) "
 K ^ZAA02GDISP(SCR,SN,.021) F I=1:1 S A=$O(^(.8)) Q:+A=0  K ^(A)
 Q
 ;
ORDER K C S A=">",IN=$S(scope[">":$P(^ZAA02GDISP(SCR,SN,scope),"`",14)_"01",1:1)
 G:$D(D(scope))=0 OR3 W:'$d(qt) ZAA02G("LO"),ZAA02G("RON") S I=0 F %R=0:0 S %R=$O(D(scope,%R)) Q:%R=""  F %C=0:0 S %C=$O(D(scope,%R,%C)) Q:%C=""  S I=I+1,C(I)=$P(D(scope,%R,%C),";",2),C=D(scope,%R,%C)-$L(I) W:'$d(qt) @ZAA02GP,I,$J("",C)
OR0 S X=$S(scope[">":$P(^ZAA02GDISP(SCR,SN,scope),"`",21),$D(^ZAA02GDISP(SCR,SN,.02)):^(.02),I=1:1,I>0:"1:1:"_I,1:"") S:X[";" X=$P(X,";")
OR1 S %R=23,%C=22 W:'$d(qt) @ZAA02GP I $D(ACOMPILE) W:'$d(qt) SCR,"-",SN
 E  S $P(^ZAA02GDISP(SCR,SN),"`")=$H
 E  S LNG=ZAA02G("C")*2-%C,CHR="0123456789,:?" K RX W:'$d(qt) ZAA02G("HI"),ZAA02G("RON"),X,$J("",LNG-$L(X)) X ^ZAA02GREAD I X["?" W:'$d(qt) @ZAA02GP,"enter field #s separated with commas - may use XX:XX:XX",!,"Press RETURN to resume editing." R X G OR0
 I X="" S:scope[">" $P(^ZAA02GDISP(SCR,SN,scope),"`",21)="" D CLEAR G OR3
 S A=$L(X,",") F I=1:1 G:I>A OR2 S B=$P(X,",",I) Q:(B'?1.3N)&(B'?1.3N1":"1.3N1":"1.3N)
ERROR S %C=1 W:'$d(qt) @ZAA02GP,ZAA02G("LO"),$J("Invalid entry - "_B,19)," :",*7 G OR1:'$D(ACOMPILE) W:'$d(qt) ZAA02G("CS"),"Please edit." X " *CRASH "
OR2 S A="F I="_X_" I $D(C(I))=0 S B=I G ERROR" X A D CLEAR
 S %C=$L(X)+1,%R=ZAA02G("R") W:'$d(qt) @ZAA02GP,"...wait",ZAA02G("CL")
 I scope[">" S $P(^ZAA02GDISP(SCR,SN,scope),"`",21)=X,I=$P(^(scope),"`",14),IN=I_"01" G:'I OR3 D INSERT S $P(^(I),"`",23)=IN-1 G OR3
 S ^ZAA02GDISP(SCR,SN,.02)=X I X'="" S IN=1 D INSERT
OR3 S L=$D(^ZAA02GDISP(SCR,SN,0))
 S L=$S($D(DO(scope)):DO(scope),1:0) S:scope'[">" ^(.9)=IN-1_","_(IN+L-1) S:scope[">" $P(^(scope),"`",20)=IN+L-1 I L F L=0:0 S L=$O(DO(scope,L)) Q:L=""  F B=0:0 S B=$O(DO(scope,L,B)) Q:B=""  S C=DO(scope,L,B),$P(^(C),"`",14)=IN,^(IN)=^(C),IN=IN+1
 I $D(K(scope)) S K=K(scope),A=IN_","_(IN+K-1) S:scope'[">" ^(.021)=A S:scope[">" $P(^(scope),"`",22)=A F A=1:1:K S C=K(scope,A),$P(^(C),"`",14)=IN,^(IN)=^(C),IN=IN+1
 S %R=24,%C=1 W:'$d(qt) ZAA02G("ROF"),@ZAA02GP,ZAA02G("CS") Q
 ;
INSERT X "F A="_X_" S C=C(A),$P(^ZAA02GDISP(SCR,SN,C),""`"",14)=IN,^(IN)=^(C),IN=IN+1" Q
 ;
CLEAR W:'$d(qt) ZAA02G("ROF"),ZAA02G("HI") F %R=0:0 S %R=$O(D(scope,%R)) Q:%R=""  F %C=0:0 S %C=$O(D(scope,%R,%C)) Q:%C=""  W:'$d(qt) @ZAA02GP,"  ",@ZAA02GP,$E($P(D(scope,%R,%C),";",2)_P,1,+D(scope,%R,%C))
 Q
 ;
SORTSCOP K D,DO,K S A=">" F B=1:1 S A=$O(^ZAA02GDISP(SCR,SN,A)) Q:A=""  S $P(^(A),"`",14)="" D SORTSC1
 S A=">" F B=1:1 S A=$O(D(A)) Q:A=""  S C="" F B=1:1 S C=$O(D(A,C)) Q:C=""  S D="" F B=1:1 S D=$O(D(A,C,D)) Q:D=""  I D(A,C,D)[">" S E=$P(D(A,C,D),";",2),L=$O(D(E,"")) I L'="" S I=$O(D(E,L,"")) I C=L+(D=I)'=2 S D(A,L,I)=D(A,C,D) K D(A,C,D)
 Q
SORTSC1 S B=^(A),E=$P(B,"`",3) Q:+E=0  S L=$P(B,"`",5),C=$P(B,"`",20),B=^(A,0)
 I A'[">",C["K" S:'$D(K(B)) K(B)=0 S K(B)=K(B)+1,K(B,K(B))=A Q
 I C["Y" S:'$D(DO(B)) DO(B)=0 S DO(B)=DO(B)+1,DO(B,+E,$P(E,",",2))=A Q
 S D(B,+E,$P(E,",",2))=L_";"_A I A[">" S (path,B)=A D PATH S path($L(path,">"),A)=A
 Q
 ;
PATH S B=^ZAA02GDISP(SCR,SN,B,0),path=B_path Q:$E(path)'=">"  G PATH
