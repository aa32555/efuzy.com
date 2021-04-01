ZAA02GSCRSA ;PG&A,ZAA02G-SCRIPT,2.10,STATS - AD HOC REPORTING;27DEC94 9:45A;;;05JAN2000  10:39
 ;
 ;
BEG S %R=1,%C=20 W @ZAA02GP,$J("",40),ZAA02G("HI"),@ZAA02GP,$J("",8),"A D   H O C   R E P O R T S"
 D DATE^ZAA02GSCRER S $P(DT,"/",3)=$P(DT,"/",3)+2000,(DTO,FROM)=DT,$P(FROM,"/",2)="01"
T K Y,X,POS S %R=3,%C=1 W @ZAA02GP,ZAA02G("CS") S POS=1,MES="",Y="2,3\RLDHYT\1\TYPE\\",Y(0)="\EX\",Y(2)="DOWNLOAD TO DOS FILE"_$S(ZAA02G'["PC":"*",1:"*"),Y(1)="LISTING",Y(3)="DOWNLOAD TO ZAA02G-CALC"_$S('$D(^ZAA02GCALC):"*",1:"")
 D POP G END:X[";EX"  S TYPE=X I TYPE=2 D CLR,D I X[";EX" G T
T1 S X(X)="",$P(Y,"\",2)=$TR($P(Y,"\",2),"RH","W") D POP K X,Y
 ;
F K Y S POS=2,Y=POS(1)_",3\RLDHYT\1\FILE\\",Y(0)="\EX\",Y(1)="Transcriptionist Stats",Y(2)="Site Statistics",Y(3)="Report Type Statistics",Y(4)="Provider Statistics",Y(5)="Transcript File*" D POP I X[";EX" D CLR G T
 S FILE=X,TITLE=Y(X),X(X)="",$P(Y,"\",2)=$TR($P(Y,"\",2),"RH","W") D POP K X
 ;
R K Y S X="",POS=3,(YY,Y)=POS(2)_",3\RLWHT\1\DATE RANGE\\*,FROM:          *,*,  TO:*,*" D POP
 D DT I X[";EX" D CLR G F
 S Y=YY,$P(Y,"\",2)=$TR($P(YY,"\",2),"RH","W") D POP K X S %R=5,%C=POS(2)+8 W @ZAA02GP,$P(FROM,"\",FROM["\"+1) S %R=7 W @ZAA02GP,$P(DTO,"\",DTO["\"+1)
 S TITLE=$P(TITLE," from ")_" from "_$P(FROM,"\",FROM["\"+1)_" to "_$P(DTO,"\",DTO["\"+1)
 S BM=$P(FROM,"/",3)*100+$P(FROM,"\",2),BD=+$P(FROM,"/",2),EM=$P(DTO,"/",3)*100+$P(DTO,"\",2),ED=+$P(DTO,"/",2)
 ;
L K Y,LIM,LIMX,LIMY S LIMY=1
 S POS=4,Y="3,12\RYLHM1AT\2\LIMITED BY\\",Y(0)="\EX\\\\Select all needed"
 S XY="NO LIMIT,SITE,REPORT TYPE"_$P(",TRANSCRIPTIONISTS;;;,PROVIDER",";",FILE)
 F J=1:1:$L(XY,",") S Y(J)=$P(XY,",",J)
 S X="" D POP I X[";EX" D CLR G R
 S LIM=X,$P(Y,"\",2)=$TR($P(Y,"\",2),"RH","W") D POP
 S:$D(X)=1 X(X)="" S X="" F J=1:1 S X=$O(X(X)) Q:X=""  S LIM(X)=""
 K X S LIM="",LIMY(1)="NO LIMIT",TITLE2="",X(1)="" I $O(LIM(1)) S TITLE2="LIMITED BY: " F JJ=1:1 S X(JJ)="",LIM=$O(LIM(LIM)) Q:LIM=""  D L1 I LIM[";EX" D CLR G L
 S %R=12,%C=1 W @ZAA02GP,ZAA02G("CS") S POS=4,Y="3,12\LTW\1\LIMITED BY\\",Y(0)="10\EX\LIMY\\\" D POP K X,JJ
 G P ;
L1 N X S DD=$P(",SITEC,TYPE,"_$P("TR,,,PROV",",",FILE),",",LIM) Q:DD=""
 S LIMG="^ZAA02GTSCR($J,DD)" K @LIMG D OLIM
 K Y S POS=5,Y=POS(4)_",12\RLHM1ATS\2\"_$P(XY,",",LIM)_" - Select all needed\\",Y(0)="\EX\^ZAA02GTSCR($J,DD)\TO"
 S X="" D POP I X[";EX" S LIM=";EX" Q
 S:$D(X)=1 X(X)=1 S X="" F J=1:1 S X=$O(X(X)) Q:X=""  S LIMX(LIM,X(X))="",LIMY(LIMY)=$S(J=1:$P(XY,",",LIM)_"=",1:"")_X(X),TITLE2=TITLE2_","_LIMY(LIMY),LIMY=LIMY+1
 S:$L(TITLE2)>150 TITLE2=$E(TITLE2,1,150)_"+" Q
 ;
OLIM S A=BM-1,(B,C)="" F J=1:1 S A=$O(@ZAA02GSCR@("STATS",A)) Q:A=""  F J=1:1 S B=$O(@ZAA02GSCR@("STATS",A,B)) Q:B=""  F J=1:1 S C=$O(@ZAA02GSCR@("STATS",A,B,DD,C)) Q:C=""  I C'="NA",'$D(@LIMG@(C)) S ^(C)=""
 Q
 ;
P K Y,PR S POS=5,Y=POS(4)_",12\RYLHM1AT\3\OUTPUT - Select all needed\\",Y(0)="\EX\"
 S XY=$S(FILE=4:"Provider,",FILE=1:"Transcriptionists,",1:"")_"Site,Report Type,MM/YY,MM/DD/YY,Characters,Lines,Reports,Keyboard Time,Lines/Hour,Char/Hour,Macro Characters"
 F J=1:1:$L(XY,",") S Y(J)=$P(XY,",",J)
 S X="" D POP I X[";EX" D CLR G L
 S PR=X,$P(Y,"\",2)=$TR($P(Y,"\",2),"RH","W") D POP
 S:$D(X)=1 PR(PR)="" I $D(X)>10 S X="" F J=1:1 S X=$O(X(X)) Q:X=""  S PR(X)=Y(X)
 S OR=""
O K X,Y S POS=6,Y=POS(5)_",12\RLHST\1\SORT BY\\",Y(0)="10\EX\PR" S X="" D POP I X[";EX" D CLR G P
 S OR=X K X S X="" F J=1:1 S X=$O(PR(X)) Q:X=""  I OR=X S X(J)="" Q
 S $P(Y,"\",2)=$TR($P(Y,"\",2),"RH","W") D POP
 G SEARCH
D K Y S POS=1,Y="3,3\RLDHYT\1\DOWNLOAD TO\\",Y(0)="\EX\",Y(3)="N/A (A) ",Y(1)="dBASE",Y(2)="N/A (L) " D POP I X[";EX" Q
 S FILET=X,%R=9,%C=3 W @ZAA02GP,"FILENAME-" S X="NEW",%C=13 X ^ZAA02GREAD S DATA=X_".DBF" S %R=1,%C=1 G:FILET=3 D3 G:FILET=2 D2 S X=FILET G T1
D2 S DATA=X_".WK1" S X=FILET G T1
D3 S DATA=X_".ASC" S X=FILET G T1
 Q
 ;
S K Y,X S (A,B)="",Y(1)="ALL SITES" F J=1:1 S A=$O(@ZAA02GSCR@("STATS",A)) Q:A=""  F J=2:1 S B=$O(@ZAA02GSCR@("STATS",A,B)) Q:B=""  I '$D(X(B)) S X(B)="",Y(J)=B
 K X S POS=3,Y=POS(2)_",3\RLDHYTM1S\1\SITES\\",Y(0)="\EX\" D POP I X[";EX" D CLR G F
 S SITEC=X,TITLE=TITLE_" FOR "_X,$P(Y,"\",2)=$TR($P(Y,"\",2),"RH","W") D POP K X
 ;         ;
SEL N %R,%C S %R=24,%C=14 W @ZAA02GP,"Use the Select key (F8 on the PC) to select more than one" S MES="MES="_ZAA02GP_"_ZAA02G(""CL"")",@MES Q
DT S %R=5,%C=POS(2)+8,Y="10\H\H\\EX\?\",X=$G(FROM) D ^ZAA02GRDD I ZAA02GF="EX" S X=";EX" Q
 S FROM=X,%R=7,%C=POS(2)+8,Y="10\H\H\\EX,UK\?\",X=$G(DTO) D ^ZAA02GRDD I ZAA02GF="EX" S X=";EX" Q
 S DTO=X G:ZAA02GF="UK" DT Q
 ;
CLR S %C=$P(REFRESH,":",3) F %R=+REFRESH:1:$P(REFRESH,":",2)+1 I %R<25 W @ZAA02GP,ZAA02G("CL")
 Q
 ;
SEARCH G ^ZAA02GSCRSA1
POP S REFRESH="" W:MES'="" MES D:$P(Y,"\",2)["M" SEL D ^ZAA02GPOP S POS(POS)=$P(REFRESH,":",4)+3 Q
 ;
END D KILL Q
KILL K DTO,FROM,XY,X,Y,OR,P,POS,FILET,FILE,TYPE,LIM,LIMX,LIMY,YY,TITLE,TITLE2 Q
