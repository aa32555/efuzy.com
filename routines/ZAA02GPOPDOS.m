ZAA02GPOPDOS ;PG&A,TOOLKIT I,1.51,POP UP/PULL DOS DIRECTORY;2014-07-10 17:23:46;;;15AUG97  09:13
 ;Copyright (C) 1985,89,91 Patterson, Gray and Assoc., Inc.
 ;  optional parameters in Y(0)
 ;    piece 3 = path (use "/" rather than "\")
 ;    piece 8 = search logic ("*.*" is default)
DOS Q:^ZAA02G("OS")'="MSM"  N (X,ZAA02G,ZAA02GP,Y) I $D(Y(0)),$P(Y(0),"\",3)]"" S A=$ZOS(8,$P(Y(0),"\",3))
 S DR=$ZOS(14)_":",DIR=$ZOS(11,DR)
DOS1 S Y=$S($D(Y)#2:$P(Y,"\"),1:"15,3")_"\LRSG\1\DOS DIRECTORY - "_DR_$TR(DIR,"\","/") ; _"\FILE       EXT      SIZE  -----MODIFIED-----"
 S:'$D(Y(0)) Y(0)="13\EX,GO,LK,RK" S:$P(Y(0),"\",4)="" $P(Y(0),"\",4)="TO3;8`TO2;3`TO1;11`TO4;17"
 S ZAA02GPOPALT="D DOKT^ZAA02GPOPDOS" D ^ZAA02GPOP S:X[";EX" X="" Q:X=""  G:X[";LK" DOS2
 I X'[";"!(X[";RK"),$ZB($A($P(X,"^",2,9),22),16,1) G:$P(X,"^")="." DOS2 S DIR=DIR_$S(DIR'="\":"\",1:"")_$P(X,"^") G DOS3
 G:X[";RK" DOS1 I X'[";GO" S X=DR_DIR_$S(DIR="\":"",1:"\")_$P(X,"^") Q
 K Y S Y(1)="*",Y(65)="  A:",Y(66)="  B:" F A=67:1:75 S B=$C(A),C=$ZOS(9,B) I C>0 S D=$P(C,"^",3)*C,Y(A)="  "_B_":  "_$J($FN(D*$P(C,"^",2),","),13)_$J($FN(D*$P(C,"^",4),","),14)
 S Y="24,6\YLRS\1\DISK DRIVES\DRIVE     AVAILABLE      TOTAL"
 S Y(0)="16\EX\\" D ^ZAA02GPOP Q:X[";EX"  Q:X=""  S DR=$C(X)_":",DIR="\",A=$ZOS(1,DR) G DOS1
DOS2 S:DIR'="\" DIR="\"_$P(DIR,"\",2,$L(DIR,"\")-1)
DOS3 S A=$ZOS(8,DR_DIR) G DOS1
 ;
DOKT S:TO=0 TO="" S:TO="" S=$ZOS(12,"*.*",63) S:TO'="" S=$ZOS(13,TO) S TO=S I S<0 S (TO,TO1,TO2,TO3,TO4)="" Q
 S TO3=$P(TO,"^"),TO2=$P(TO3,".",2),TO3=$P(TO3,"."),T=$P(TO,"^",2,9) I $ZB($A(T,22),16,1) G DOKT:$P(TO,"^")=".." S TO2="",TO1="<"_$S(TO3]"":"DIR",1:"back")_">  "
 E  S TO1=$J($FN($A(T,30)*256+$A(T,29)*256+$A(T,28)*256+$A(T,27),","),11)
 I TEN'="~",TO1'["<DIR>",TO3_"."_TO2?@TEN=0 Q:TO=""  G DOKT
 S %F=$A(T,26)*256+$A(T,25),%D=%F#32,%F=%F\32,%E=%F#16,%F=%F\16,%F=%F+1980
 S TO4=$E("  ",1,2-$L(%E))_%E_"-"_$E(%D+100,2,3)_"-"_%F_" "
 S %F=$A(T,24)*256+$A(T,23),%D=%F#32*2,%F=%F\32,%E=%F#64,%F=%F\64,%A=%F\12,%B=%F#12 S:%B=0 %B=12
 S TO4=TO4_$E("  ",1,2-$L(%B))_%B_":"_$E("00",1,2-$L(%E))_%E_$S(%A:"p",1:"a") Q
 ;
VIEW D ZAA02GPOPDOS Q:X=""  Q:X[";EX"  S FILE=X I ^ZAA02G("OS")="MSM" S DEV=51,ZC="Z=$ZC" O 51:(FILE:"R")
 I ^ZAA02G("OS")="DTM" S DEV=10,ZC="Z=$ZIOS" O 10:("R":FILE)
 I ^ZAA02G("OS")="CCS" S DEV=5,ZC="Z=$ZOS\256" O 5:("FN":FILE:1)
 S II=$I F J=10:10 U DEV R A S @ZC Q:Z  S ^ZAA02GTWP("DOS",II,J)=A
 C DEV U 0 S TL=4,BL=22,NM=FILE,MG=76,ZAA02GWPD="^ZAA02GTWP(""DOS"","""_$I_""")",ZAA02GWPOPT="INQ,ST,OT1,2,3,5,8"
 D ENTRY^ZAA02GWPV6 K ^ZAA02GTWP("DOS",II) G VIEW
 ;
DEL ; DELETE FILES IN DIRECTORY
 R "Enter Directory (Drive:Directory) - ",A,! Q:A=""  S B=$ZOS(8,A) I B'="" W "Error Selecting Directory" Q
 S F=$ZOS(12,"*.*",0) F  S C=$P(F,"^") Q:C=""  W !,C,"  Delete (Y or N)-" R B#1 S:B="Y" B=$ZOS(2,C) S F=$ZOS(13,F)
 Q
