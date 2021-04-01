ZAA02GSCMQ1 ;PG&A,ZAA02G-MTS,1.20,DATABASE SEARCH UTILITY;29NOV93 3:38P;17DEC2002  12:21;;Thu, 13 May 2010  11:41
 ;
 D HEAD D DATE^ZAA02GSCMST S (BEG,END)=DT,$P(BEG,"/",2)="01"
 K POS,SORT2,SORT3,RESULTS S POS=1,DATA(1)=1,POS(1)=3_","_3,MES="",MAXR=0  D SITEC
AA S DATA=DATA(POS)
A1 K Y S Y=POS(POS)_"\RLDHTY\1\\\",Y(0)="10\EX\",POS=POS+1
 S Z=$T(DATA+DATA),FILE=$P(Z,";",4),$P(Y,"\",4)=$P(Z,";",3),$P(Y,"\",3)=$P(Z,";",5),X=$P(Z,";",6)
 F J=1:1:$L(X,",") S Y(J)=$P(X,",",J)
 G:$P(Z,";",2)'="AA" @$P(Z,";",2)
A2 D POP I X[";EX" D CLR S POS=POS-2 G:POS>0 AA G END
 S @FILE=X,X(X)="",$P(Y,"\",2)=$TR($P(Y,"\",2),"RH","W") D POP
 S DATA(POS)=$S($P(Z,";",7)["*":$P(Z,";",7),1:$P($P(Z,";",7),",",@FILE)) K X I +DATA(POS) G AA
 G GEN^ZAA02GSCMST
END K POS,DATA,TYPE,SEARCH,SORT,MAXR Q
SITEC K SC S (A,B)="",SC=",NA" F  S A=$O(@ZAA02GSCM@("STATS",A)) Q:A=""  F  S B=$O(@ZAA02GSCM@("STATS",A,"NA","SITEC",B)) Q:B=""  I B'="TOTAL",'$D(SC(B)) S SC=SC_","_B,SC(B)=""
 Q
DATA ;
 ;AA;REPORT TYPE;TYPE;1;Patient Listing,Follow-up,Biopsy Results,QA Statistics,Status;2,2,2,2,2
 ;AA;SORTED BY;SORT;1;Radiologist,Referral,Site,No Sort;4,3,5,6
 ;AA;;MOD1;1;Selected Referrals,All Referrals;6,6
 ;AA;;MOD1;1;Selected Radiologists,All Radiologists;11,6
 ;AA;;MOD1;1;Selected Sites,All Sites;6,6
 ;AA;THEN SORTED;BSORT;1;Alphabetically,Chronologically,By Results,Selected Results,By Codes;7:8,7:8,7:8,10,12
 ;R;RANGE;RANGE;1;*,FROM:         *,*,  TO:*,*;
 ;AA;Output;DEVICE;1;Terminal,Printer;,9
 ;P;Printer;DV;1;
 ;AA;Results;RESULTS;1;1-Normal,2-Benign,3-Probably Benign,4-Suspicious,5-Malignant,0-Incomplete;7:8,7:8,7:8,7:8,7:8,7:8,7:8
 ;AAR;Select;SORT2;2;;6*
 ;CD;Select;SORT3;2;;7:8*
 ;
R S YY=Y,X="",$P(Y,"\",2)=$P(Y,"\",2)_"W" D POP
 D DT D:0 TX I X[";EX" D CLR S POS=POS-2 G:POS>0 AA G END
 S Y=YY,$P(Y,"\",2)=$TR($P(YY,"\",2),"RH","W") D POP K X,YY S %R=$P(POS(POS-1),",",2)+2,%C=POS(POS-1)+7 W @ZAA02GP,$P(BEG,"\",BEG["\"+1) S %R=%R+2 W @ZAA02GP,$P(END,"\",END["\"+1)
 S RTITLE=" FROM "_$P(BEG,"\",BEG["\"+1)_" TO "_$P(END,"\",END["\"+1),@FILE=BEG_","_END
 K X S DATA=$P(DATA(POS-1),":",2),DATA(POS)=DATA G A1
 G A1
 ;
P S X="",$P(Y,"\",2)=$P(Y,"\",2)_"V" F J=1:1 S X=$O(^ZAA02GWP(96,X)) Q:X=""  S Y(J)=X
 G A2
CD S X="",$P(Y,"\",2)=$P(Y,"\",2)_"M1A" F J=1:1 S X=$O(^ZAA02GSCMD("XP",X)) Q:X=""  S:$S("AGE,XX1,XX2,XX3,XX4,XXC,XXP"[$P(X,","):0,1:1) Y(J)=X
 G A2
SEL N %R,%C S %R=24,%C=14 W @ZAA02GP,"Use the PF3 key (F8 on the PC) to select more than one" S MES="MES="_ZAA02GP_"_ZAA02G(""CL"")",@MES Q
DT S %R=$P(POS(POS-1),",",2)+2,%C=POS(POS-1)+7,Y="10\H\H\\EX\?\",X=BEG D ^ZAA02GRDD I ZAA02GF="EX" S X=";EX" Q
 S BEG=X,%R=$P(POS(POS-1),",",2)+4,%C=POS(POS-1)+7,Y="10\H\H\\EX,UK\?\",X=END D ^ZAA02GRDD I ZAA02GF="EX" S X=";EX" Q
 S END=X G:ZAA02GF="UK" DT Q
TX S %R=5,%C=POS(POS-1)+2,Y="10\H\H\\EX\?\",X="" D ^ZAA02GRDF I ZAA02GF="EX" S X=";EX" Q
 S BEG=X,%R=7,%C=POS(POS-1)+2,Y="10\H\H\\EX,UK\?\",X="" D ^ZAA02GRDF I ZAA02GF="EX" S X=";EX" Q
 S END=X G:ZAA02GF="UK" TX Q
 Q
 ;
CLR S %C=$P(REFRESH,":",3) F %R=+REFRESH:1:$P(REFRESH,":",2) W @ZAA02GP,ZAA02G("CL")
 Q
HEAD S %R=1,%C=20 W @ZAA02GP,"       R E P O R T   G E N E R A T O R            " S %R=3,%C=1 W @ZAA02GP,ZAA02G("CS") Q
 ;
POP S REFRESH="" W:MES'="" MES D:$P(Y,"\",2)["M" SEL D ^ZAA02GPOP I $P(Y,"\",2)["W" I $P(REFRESH,":",2)>MAXR S MAXR=$P(REFRESH,":",2)
 I $P(REFRESH,":",4)<70 S POS(POS)=$P(REFRESH,":",4)+2_","_(+REFRESH) Q
 S POS(POS)=3_","_(MAXR+2) Q
 ;
AAR K SORT2 N A,B,C S (A,B,C)="" F  S A=$O(@ZAA02GSCM@("STATS",A)) Q:A=""  F  S B=$O(@ZAA02GSCM@("STATS",A,B)) Q:B=""  F  S C=$O(@ZAA02GSCM@("STATS",A,B,"PROV",C)) Q:C=""  S A(C)=""
 S A="" F J=1:1 S A=$O(A(A)) Q:A=""  S Y(J)=A,SORT2(J)=A
 S $P(Y,"\",2)=$P(Y,"\",2)_"M1" G A2
 ;
VB ; entry point from Premier
 I '$D(X) S X="1|GET|REPORT|ZAA02GSCMQ1|0|RUN|^10/05/2009,05/12/2010:1:4:A^:A^:A^:A:1:N^:|0"
 S VAL=$P(X,"|",6)
 S S=$P(X,"|",7) Q:S=""
 S BEG=$P($P(S,":",1),"^",2),END=$P(BEG,",",2),BEG=$P(BEG,",")
 S TYPE=$P(S,":",2)
 S SORT=$P(S,":",3)
 S MOD1=0
 S MODP=$P(S,":",4)
 S MODR=$P(S,":",5)
 S MODS=$P(S,":",6)
 S MODB=$P(S,":",7)
 S BSORT=$P(S,":",8)
 S EXCEL=$P(S,":",9)
 ;S (SORT2,SORT3)=""
 I VAL="CHK" S B="EXCEL=" Q
 I VAL="" S B="||RUN||" Q
 I VAL'="RUN" S B="99|Invalid System Response|16|Report|1=0" Q
 S VB=1,DEVICE=1.1
 S DEVICE=1.1,OFF=10,ZAA02GSCM="^ZAA02GSCMD(""ST"",TSU)",ZAA02GSCR="^ZAA02GSCR",ZAA02GSCRP=";;2",ZAA02GSCMD="^ZAA02GSCMD"
 S DV="",LN=999,LNM=60,PG=0
 S TSU="M",TS="Mammo"
 S RESULTS="" I MODB'="A" F J=1:1:$L(MODB) S I=$E(MODB,J) I I?1N,I<7 S RESULTS=RESULTS_I,RESULTS(I)="",RESULTS($E("ANBPSMK",I+1))=""
 D SITEC S SITEC=SC
 D DATE^ZAA02GSCMST,^ZAA02GSCMST5
 Q
