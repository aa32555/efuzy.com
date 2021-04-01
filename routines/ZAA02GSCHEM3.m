ZAA02GSCHEM3 ;PG&A,ZAA02G-SCHEMA,1.20,Dictionary Maintenance - 3;21AUG90 9:19A
 ;Copyright (C) 1984, Patterson, Gray and Associates, Inc.
 ;
BEG S %R=3,%C=1 W @ZAA02GP,ZAA02G("CS"),ZAA02G("LO") S %R=4,%C=20 F I=1:1:4 S %R=%R+2 W @ZAA02GP,$P("Printer Number,First Code to print,Last Code to print,Detail (Y or N)",",",I)
 S (FC,LC,DV,TP)="" S %R=14,%C=48 W @ZAA02GP,"<-- Here to Continue",ZAA02G("HI")
SEL S %C=42,LNG=10 X ^ZAA02G("ECHO-OFF") F I=1:0:4 S V=$P("DV,FC,LC,TP",",",I),X=@V,%R=I*2+4,L=1,RX=0 W @ZAA02GP D RD S @V=X,I=I+$S(RX=1:-1,1:1) Q:I=0
 G END:I=0,END:DV="" D PRINT
END K OC,NC,FC,PE,DV,A,LC,TP X ^ZAA02G("ECHO-ON") Q
 ;
RD R B#1 X ZAA02G("T") G RB:B=""
 G ER:L>LNG W B S X=$E(X,1,L-1)_B_$E(X,L+1,99),L=L+1 G RD
RB G UP:ZF=ZAA02G("UK"),DN:ZF=ZAA02G("DK"),TB:ZF=$C(9),CR:ZF=$C(13)
 G RT:ZF=ZAA02G("RK"),LT:ZF=ZAA02G("LK"),IN:ZF=ZAA02G("INK"),DL:ZF=ZAA02G("DLK"),127:ZF=$C(127),RE:ZF=ZAA02G("CL")
ER W *7 G RD
LT G RD:L'>1 S L=L-1 W ZAA02G("L") G RD
RT G RD:L'<LNG W ZAA02G("RT") S L=L+1 G RD
127 G:L=1 RD S X=$E(X,1,L-2)_" "_$E(X,L,99),L=L-1 W *8," ",*8 G RD
DN S RX=2 G CR
UP S RX=1 G CR
TB S RX=3
CR I $E(X)=" " S X=$E(X,2,99) G CR
OUT Q
DL W $E(X,L+1,99)," " S X=$E(X,1,L-1)_$E(X,L+1,99)_" " W @ZAA02GP,$E(X,1,L-1) G RD
IN G:$E(X,LNG)'=" " ER W " ",$E(X,L,LNG-1) S X=$E(X,1,L-1)_" "_$E(X,L,LNG-1) W @ZAA02GP,$E(X,1,L-1) G RD
RE S X=$E(X,0,L-1),CC=%C,%C=%C+L-1 W @ZAA02GP,$J("",LNG-L),@ZAA02GP S %C=CC,L=$L(X) K CC G RD
 ;
 ;
PRINT I DV'=0 O DV::0 E  S %R=14,%C=20 W @ZAA02GP,ZAA02G("HI"),"Device ",DV," is busy - Press RETURN and try later " R X#1 Q
 S %R=21,%C=34 W @ZAA02GP,ZAA02G("RON")," Please Wait ",ZAA02G("ROF")
 S PE=55 I DV=0 S %R=2,%C=1,PE=23 W @ZAA02GP,ZAA02G("CS"),#
 U DV D PR1 U 0
 C:DV'=0 DV K A,PE,TP,DV,FC,LC,C,B Q
 ;
PR1 K A S C=". . . . . . . . . . . . . . . . . ." D PSET^ZAA02GSCHEM1 W !! D:$D(^ZAA02GSCHEMA(FC)) PR2 F I=1:1 S FC=$O(^ZAA02GSCHEMA(FC)) Q:FC=""  Q:FC]LC  D PR2
 S A=PE G PR3
PR2 S B=^ZAA02GSCHEMA(FC) I TP["N"!(TP["n") S A=1 W FC,?10,$E($P(B,"`"),1,30),?42,$P(B,"`",3),?66,$P(B,"`",4) G PR3
 S A=17 F I=1:1:26 W "---"
 W !!,FC,!! F I=1:1 Q:$D(A(I))=0  W $P(A(I),"\",2),$E(C,$X,38)," ",$P(B,"`",+A(I)),!
PR3 W ! I DV'=0 W:PE-A<$Y # Q
 I PE-A<$Y W !!,"Press RETURN" R X W @ZAA02GP,ZAA02G("CS"),#,!! Q
 Q
 ;
COPY S %R=3,%C=1 W @ZAA02GP,ZAA02G("CS"),ZAA02G("LO") S %R=4,%C=20 F I=1:1:2 S %R=%R+2 W @ZAA02GP,$P("Old Code Name,New Code Name",",",I)
 S (OC,NC)=""
CP0 S %R=12,%C=48 W @ZAA02GP,"<-- Here to Continue",ZAA02G("HI")
SEL1 S %C=42,LNG=10 X ^ZAA02G("ECHO-OFF") F I=1:0:2 S V=$P("OC,NC",",",I),X=@V,%R=I*2+4,L=1,RX=0 W @ZAA02GP D RD S @V=X,I=I+$S(RX=1:-1,1:1) Q:I=0
 G END:I=0,END:OC="" S %R=15,%C=20 W @ZAA02GP,ZAA02G("CL") I $D(^ZAA02GSCHEMA(OC))=0 W "Old Code not Found - Must enter a valid code" G CP0
 I NC="" W "Enter a New Code name to copy to" G CP0
 W "...done" S ^ZAA02GSCHEMA(NC)=^ZAA02GSCHEMA(OC) H 2 G COPY
 ;
LIST S A="Forms which access item "_S1,list="^ZAA02GSCHEMA(0,S1)"
LISTER S %R=3,%C=1 W @ZAA02GP,ZAA02G("CS"),ZAA02G("Z") S %C=80-$L(A)\2 W @ZAA02GP,A,ZAA02G("Z") ;needs A=title and list=reference
 S %R=4,PROMPT="Display Forms' Titles?  ",X="N",%C=80-$L(PROMPT)\2,CHR="YyNn",LNG=1 X ^ZAA02GREAD W *13,ZAA02G("CS"),ZAA02G("Z")
 I $O(@list@(""))="" S %R=12,%C=36 W @ZAA02GP,"( None )" G LIST1
 I "Nn"[X S A="" F I=1:1 S A=$O(@list@(A)) Q:A=""  S %R=I-1#20+4,%C=I-1\20*30 W @ZAA02GP,A D:I=60 LIST1
 E  S A="" F I=1:1 S A=$O(@list@(A)) Q:A=""  S %R=I+3,%C=5 W @ZAA02GP,A,$J("",15-$L(A)) W:$D(^ZAA02GDISP($P(A,"-"),$P(A,"-",2))) $P(^($P(A,"-",2)),"`",4) I I=20 D LIST1
 K list
LIST1 S %R=24,%C=28 W @ZAA02GP,"Press RETURN to continue" R A#1 S I=0
 Q
FORMS S A="Updated Forms.",list="^ZAA02GSCHEMA(1)" G LISTER
