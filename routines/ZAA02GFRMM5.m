ZAA02GFRMM5 ;PG&A,ZAA02G-FORM,2.62,MAINTENANCE - CREATE ZAA02GSCHEMA;11MAY95 12:42P
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
 ; Scans SCReen series and creates ZAA02G-SCHEMA entries
 ;
T1 D TEMPL^ZAA02GFRMSC2 S %R=3,%C=1 W:'$D(qt) @ZAA02GP,ZAA02G("CS"),!?5 S SCR="" F J=1:1 S SCR=$O(SCR(SCR)) G:SCR="" DONE D T2
 Q
 ;
T2 G:$D(SCR(SCR))>1 T2A S SN=0 F J=1:1 S SN=$O(^ZAA02GDISP(SCR,SN)) Q:SN=""  D T3
 Q
T2A S SN=0 F J=1:1 S SN=$O(SCR(SCR,SN)) Q:SN=""  D T3
 Q
 ;
T3 S %R=3,%C=5 W:'$D(qt) @ZAA02GP,ZAA02G("CS"),SCR,"-",SN
 S a=":" F i=0:0 S a=$O(^ZAA02GDISP(SCR,SN,a)) Q:a=""  I a'[">",a'["$",a'["^" D COPY
 Q
 ;
COPY S %R=6,%C=10 W:'$D(qt) @ZAA02GP,a,ZAA02G("CS") S X="",%C=31 W:'$D(qt) @ZAA02GP,ZAA02G("LO"),"Copy (Y or N)? ",ZAA02G("HI") S %C=46,LNG=1 X ^ZAA02GREAD I X="Y" D SCHEMA
 Q
 ;
SCHEMA S %R=8,%C=10,ST=^ZAA02GDISP(SCR,SN,a),X=a W:'$D(qt) @ZAA02GP,ZAA02G("LO"),"ZAA02G-SCHEMA name ? ",ZAA02G("HI"),X,ZAA02G("CS") S %C=27,LNG=10 X ^ZAA02GREAD S A=X
 I $D(^ZAA02GSCHEMA(A)) S %C=45 W:'$D(qt) @ZAA02GP,"Already exists - Cannot Override" H 1
 S SCHEMA="" F I=1:1:12 S $P(SCHEMA,"`",$P(from,",",I))=$P(ST,"`",$P(to,",",I))
SCHEM1 S ^ZAA02GSCHEMA(0,X,SCR_"-"_SN)="",^ZAA02GSCHEMA(X)=SCHEMA,X="^"_X,ST=^ZAA02GDISP(SCR,SN,a),$P(ST,"`",11)=X,^(X)=ST K ^(a) S I=$P(ST,"`",14),$P(^(I),"`",11)=X
 Q
 ;
DONE K SCR,SN,gl Q
 ;
