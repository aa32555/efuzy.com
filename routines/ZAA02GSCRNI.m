ZAA02GSCRNI ;PG&A,ZAA02G-SCRIPT,2.10,INCENTIVE PAY;16NOV94  22:07;;;24JAN2000  14:07
C ;Copyright (C) 1991-1994, Patterson, Gray & Associates, Inc.
TN S Y="Create New Incentive Report\Display/Edit Old Incentive Reports\Print Incentive Report\Setup Incentive Report Parameters\Report Templates\Quit\;CDPSRQ;I N C E N T I V E   P A Y   M E N U"
 S TC=25,TR=8 D SEL^ZAA02GSCRIPT I J'<NE Q
 D @$P("CREATE\EDIT\PRINT\SETUP\TEMPLATE","\",J) G TN
 ;
CREATE S SNL=19,HD="I N C E N T I V E   P A Y",EX="I 1",T1="" D SETUP^ZAA02GSCRST G:'$D(BEG) END W "wait..."
 S ZAA02GSCRT=$S($D(@ZAA02GSCR@("PARAM","USER FILE")):^("USER FILE"),1:ZAA02GSCR)
 S UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ",LC="abcdefghijklmnopqrstuvwxyz"
 D SETUP1^ZAA02GSCRST,INIT^ZAA02GSCRST,DATE^ZAA02GSCRER K CT S CT="",JJ=$H+1*-100-1 I $D(@ZAA02GSCR@("INCENTD",JJ)) F JJ=JJ:-1 Q:'$D(^(JJ))
 F SI=1:1:$L(SITEC,",") S SC=$P(SITEC,",",SI) F Y=BM:1:EM S:$E(Y,5,6)=13 Y=Y+88 F J=1:1 S CT=$O(@ZAA02GSCR@("STATS",Y,SC,"TR",CT)) Q:CT=""  S CT(CT)=""
 S @ZAA02GSCR@("INCENTD",JJ)=TYPE_"\"_BEG_"\"_END_"\"_SITEC_"\"_DT_" "_TM,TR=0
 S TT=$G(@ZAA02GSCR@("PARAM","INCENT",TYPE)),AA=$S($P(TT,"|",17)="C":"CC",1:"LL"),NPC=0,TRT=$P(TT,"|",12),LDT=$P(TT,"|",13)
 F J=20:4:24 I $P(TT,"|",J,J+3)'="|||" S NPC=NPC+1,PC(NPC)=$S($P(TT,"|",J+2)="":"A=""TOTAL""",1:"PCL(PC)"_$S($P(TT,"|",J+3)="E":"'",1:"")_"[("",""_A_"",""),A'=""TOTAL"""),PCL(NPC)=","_$P(TT,"|",J+2)_","
 S CTX="" F J=1:1 S CTX=$O(CT(CTX)) Q:CTX=""  D CRET
 I 'TR S %R=12,%C=20 W @ZAA02GP,"No Transcriptionist Statistics Found" H 5 K @ZAA02GSCR@("INCENTD",JJ) G END
 K TT,AA,NPC,TRT,LDT,PCL,PC,CT,CTX,SITEC,SI,SITE,ZAA02GSCRT G CALC
CRET I CTX["-",$P(TT,"|",18)]"",$P(TT,"|",18)'[$P(CTX,"-",2) Q
 S CT=$P(CTX,"-"),B=$TR(CT,UP,LC),P=8 Q:'$D(@ZAA02GSCRT@("PARAM","USER",B))  S CX=$P(^(B),"\",16) Q:CX=""  Q:TRT'=CX&(LDT'=CX)  S:$P(^(B),"\",14) P=$P(^(B),"\",14)
 W CTX," " S CX=$G(@ZAA02GSCR@("INCENTD",JJ,CT))
 S (C,W,L,R,MN,B,S)=0 F SI=1:1:$L(SITEC,",") S SC=$P(SITEC,",",SI) F M=BM:1:EM S B1=$S(M=BM:BD,1:1),B2=$S(M=EM:ED,1:31) D C0:B2'<B1
 S @ZAA02GSCR@("INCENTD",JJ,CT)=CX Q
C0 I $D(@ZAA02GSCR@("STATS",M,SC,"TR",CTX))=0 S:$E(M,5,6)>12 M=M+87 Q
 S A="" F C=0:0 S A=$O(@ZAA02GSCR@("STATS",M,SC,"TR",CTX,A)) Q:A=""  D C1
 Q
C1 Q:'$D(@ZAA02GSCR@("STATS",M,SC,"TR",CTX,A,1))  F C=1:1:7 S C(C)=$G(^(C))
 F PC=1:1:NPC I @PC(PC) F DY=B1:1:B2 D C2
 Q
C2 S C=$P(C(1),"+",DY),L=$P(C(2),"+",DY),W=$P(C(3),"+",DY),B=$P(C(4),"+",DY),S=$P(C(5),"+",DY),R=$P(C(6),"+",DY),MN=$P(C(7),"+",DY),@LF,@WF I @AA=0 Q
 S TR=TR+1,$P(CX,",",PC)=$P(CX,",",PC)+@AA,C=$G(@ZAA02GSCR@("INCENTD",JJ,CT,M*100+DY)) S:C="" $P(CX,",",10)=$P(CX,",",10)+1,$P(C,",",6)=P,$P(CX,",",6)=$P(CX,",",6)+P S $P(C,",",PC)=$P(C,",",PC)+@AA,^(M*100+DY)=C
 I +C+$P(C,",",2)+$P(C,",",3)+$P(C,",",4)=0 S $P(CX,",",10)=$P(CX,",",10)-1 K ^(M*100+DY)
 Q
 ;  1-level1,2-level2,3-,4-,5-,6-stand hrs,
 ;  7-leave,8-downtime,9-,10-count
 ;
EDIT S JJ="DISPLAY/EDIT" D PAYR Q:X=""  I X[";DL" S X=$P(X,";") Q:X=""  K @ZAA02GSCR@("INCENTD",X) Q
 S JJ=X,A=@ZAA02GSCR@("INCENTD",X),TYPE=$P(A,"\",1) G CALC
 ;S SCR="ZAA02GSCRIPT",SNL=25,ID=JJ,REFRESH="3:22" D ^ZAA02GFORM Q
ELOAD K AA S A="",CT=X Q:X=""  F J=1:1 S A=$O(@ZAA02GSCR@("INCENTD",ID,CT,A)) Q:A=""  S AA(J)=^(A),$P(AA(J),",")=$E(A,3,4)_"/"_$E(A,5,6)_"/"_$E(A,1,2)
PAYR K Y S Y="7,5\RLHTGS\1\"_JJ_" INCENTIVE PAY REPORTS\  FROM        TO           SITES        TYPE      CREATED    "
 I $D(@ZAA02GSCR@("INCENTD"))=0 S Y=Y_"\*,*NO INCENTIVE PAY REPORTS FOUND,*"
 E  S Y(0)="\EX"_$S($E(JJ)="D":",DL",1:"")_"\@ZAA02GSCR@(""INCENTD"")\$P(@ZAA02GSCR@(""INCENTD"",TO),$C(92),2);8`$P(^(TO),$C(92),3);8`$P(^(TO),$C(92),4);15`$P(^(TO),$C(92));3`$P(^(TO),$C(92),5);14\\"_$S($E(JJ)="D":"To delete - Press DELETE LINE",1:"")
 D ^ZAA02GPOP I X[";EX" S X="" Q
 Q
CALC S %R=3,%C=1 W @ZAA02GP,ZAA02G("CS")
 K Y,X S ID=JJ,Y(0)="\EX\\TO\\\",Y="5,4\RHLSY\8\TRANSCRIPTIONISTS\" S A="" F J=1:1 S A=$O(@ZAA02GSCR@("INCENTD",ID,A)) Q:A=""  S Y(A)=""
CAL1 D ^ZAA02GPOP Q:X[";EX"  Q:X=""  S X=$TR(X,"+"),$P(Y(0),"\",7)=X,Y(X_"+")="" K Y(X) D SHT G CAL1
 ;
SHT S %R=4,%C=30 W @ZAA02GP,"Transcriptionists: ",X,"  "
 N (X,ZAA02G,ZAA02GP,ID,ZAA02GSCR,ZAA02GSCRP) S ZAA02GCALG="^ZAA02GSCC($J)",A="",DIR="",SHT=X K @ZAA02GCALG S @ZAA02GCALG="``````0,75"
 S C=$C(8,8,8,8,8) F I=1:1:5 S C=C_C_$C(8,8,8)
 S C=$C(8,8,10)_$E(C,2,255),@ZAA02GCALG@("C",2)=C
 D SHT1 Q
SHT1 ; TYPE 1
 I $P(ZAA02GSCRP,";",3)=1 F J=1:1:8 S @ZAA02GCALG@(J,1)="0`"_$P("Routine, X-Ray ,    ,   Reg ,   ,  Down,----Adju,st-----",",",J)_"`"
 E  F J=1:1:8 S @ZAA02GCALG@(J,1)="0`"_$P("Type A, Type B,    ,   Reg ,   ,  Down,----Adju,st-----",",",J)_"`"
 I $P(ZAA02GSCRP,";",3)=1 F J=1:1:8 S @ZAA02GCALG@(J,2)="0`"_$P(" Lines, Lines ,  Date,  Hours,  Leave,  Time,Routine,  X-Ray",",",J)_"`"
 E  F J=1:1:8 S @ZAA02GCALG@(J,2)="0`"_$P(" Lines, Lines ,   Date,  Hours,  Holiday,  Time, Type A, Type B",",",J)_"`"
 F J=1:1:8 S @ZAA02GCALG@(J,3)=3_"`--------------"
 F J=4:1 S A=$O(@ZAA02GSCR@("INCENTD",ID,SHT,A)) Q:A=""  S AA=^(A),$P(AA,",",10)=$E(A,5,6)_"/"_$E(A,7,8)_"/"_$E(A,1,4) F L=1:1:8 S @ZAA02GCALG@(L,J)=L'=3*5_"`"_$P(AA,",",$P("1,2,10,6,7,8,11,12",",",L))_$J("`",L<3+1)
 S %R=24,%C=20 W @ZAA02GP,*13,ZAA02G("CL"),@ZAA02GP,"Edit Sheet as needed - Press Exit when completed" S TR=6,BR=23,FR=4,FC=3 D ENTRY^ZAA02GCAL01
 S BB=$G(@ZAA02GSCR@("INCENTD",ID,SHT)) K ^(SHT),B
 S L=3 F J=1:1 S L=$O(@ZAA02GCALG@(3,L)) Q:L=""  S C=^(L),A=$P(C,"`",2),A=$P(A,"/",3)*100+A*100+$P(A,"/",2) D SHT2
 F J=1:1:8 S $P(BB,",",$P("1,2,10,6,7,8,11,12",",",J))=$G(B(J))
 S @ZAA02GSCR@("INCENTD",ID,SHT)=BB K BB Q
SHT2 S B="" F J=1,2,4:1:8 S $P(B,",",$P("1,2,10,6,7,8,11,12",",",J))=$P($G(@ZAA02GCALG@(J,L)),"`",2),B(J)=$G(B(J))+$P($G(^(L)),"`",2)
 S @ZAA02GSCR@("INCENTD",ID,SHT,A)=$TR(B," ") S:$P(B,",",6)+$P(B,",",7)+$P(B,",",8) B(3)=$G(B(3))+1 Q
 ;
PRINT S JJ="PRINT" D PAYR Q:X=""  S ID=X G ^ZAA02GSCRNI1
SETUP D INCENT^ZAA02GSCRMS Q
TEMPLATE D INCENT^ZAA02GSCRRD Q
 ;
END K TYPE,DY G DONE^ZAA02GSCRST
 ;
HLINE S REFRESH="" D HL G AP0^ZAA02GFORM4
HL N (ZAA02G,ZAA02GP,REFRESH) S Y="12,4\RHLYW25\1",Y(0)="\EX" F J=2:1 S A=$P($T(HL+J),";",2,9) Q:A=""  S Y(J)=A
 D ^ZAA02GPOP Q
 ;Line and Character Count Formulas
 ;*
 ;Enter a formula using the following letters:
 ;  C = # non-space characters     W = # of words
 ;  S = # of spaces                B = # of blank lines
 ;  L = # of non-blank lines       R = # of reports
 ;*
 ;  allowable numeric operators: + - * / \
 ;*
 ;Examples:   C+W+B+L    counts all non-space characters plus
 ;                       1 character per word and each line
 ;            C+S+40\80  characters and spaces only, round up
 ;                       to the nearest 80 character line
 ;
HPAY S REFRESH="" D HP G AP0^ZAA02GFORM4
HP N (ZAA02G,ZAA02GP,REFRESH) S Y="12,4\RHLYW25\1",Y(0)="\EX" F J=2:1 S A=$P($T(HL+J),";",2,9) Q:A=""  S Y(J)=A
 D ^ZAA02GPOP Q
 ;Incentive Pay Formula
 ;*
 ;Enter a formula using the following letters and functions:
 ;  C = total character count      B1 = base rate 1
 ;  L = total line count           B2 = base rate 2
 ;  R = # of reports               B3 = base rate 3
 ;  D = total days worked          $$MAX(x,y..) = maximum
 ;  H = total hours worked         $$MIN(x,y..) = minimum
 ;*
 ;Examples:   L+W+B+L    counts all non-space characters plus
 ;                       1 character per word and each line
 ;            C+S+40\80  characters and spaces only, round up
 ;                       to the nearest 80 character line
 ;
