ZAA02GINT06 ;PG&A,ZAA02G-CONFIG,2.25,CRT DEFINITION  (WYSE30);14MAY91 2:54P [ 09/20/97  10:12 AM ];;;28JUN99  16:39
 ;Copyright (C) 1987, Patterson, Gray and Assoc., Inc.
BEG S OS=$S($D(^ZAA02G("OS")):^("OS"),1:"") Q:OS=""  S A=$T(DATA),T=$P(A,";",2) W !?5,$P(A,";",3),?50,"Initialize? (Y or N) " R A#5 S A=$E(A) Q:A=""!("Yy"'[$E(A))
ENT W !,?8,"Initializing ",T S M=0,^ZAA02G(0,T,M)="",H=""
 F I=1:1 S A=$T(DATA+I) Q:A=""  S C=$P(A,";",2,99) F J=1:2:$L(C,"\")-1 S D=$P(C,"\",J),E=$P(C,"\",J+1),X="X="_E,@X,^ZAA02G(0,T,D)=X W "." S Y=",ZAA02G("""_D_""")="_E S:$L(H)+$L(Y)>240 ^(M)="S "_$E(H,2,255),M=M+1,H="" S H=H_Y
 S:H'="" ^(M)="S "_$E(H,2,255)
FNC S ^ZAA02G(.1,T,1)="I ZAA02G(1)=0"_$S(^ZAA02G("OS")="DTM":" D set^%mixinterp(127,37)",1:"")_" F I=64:1:71,96:1:103 W *27,""z"",*I,*27,""["",*I,*127 I I=103 H 2"_$S(^ZAA02G("OS")="DTM":" D set^%mixinterp(127,3)",1:"")
 S ^(2)="14`16`6`27,91,102`27,91,103`27,91,65`27,91,97`27,91,71`20`27,91,66`27,91,67`27,91,69`27,91,68`27,91,100`27,91,53,126"
 S ^(3)="```````````````27,91,101`27,91,99`27,91,98`24`23`27,91,70`30```5`1"
 S ^(5)="Ctrl N`Ctrl P`Ctrl F`Ctrl SHIFT F3`Ctrl SHIFT F4`F2`SHIFT F2`Ctrl F4`Ctrl T`F3`F4`Ctrl F2`Ctrl F1`Ctrl SHIFT F1`F5"
 S ^(6)="```````````````Ctrl SHIFT F2`SHIFT F4`SHIFT F3`Ctrl X`Ctrl W`Ctrl F3`HOME`F1`SHIFT F1`Ctrl E`Ctrl A"
 S ^(7)="\\$C(27,113,27,79)\$C(27,114,27,79)"
CLNUP D @(OS_"^ZAA02GINTRM") Q
 ;
DATA ;WYSE30;WYSE 30 with keypad
 ;BI\$C(61)\BLC\$C(49)\BRC\$C(53)\C\$C(56,48)\CL\$C(27,84)\CS\$C(27,89)\D\$C(10)\DL\$C(27,87)\F\$C(27,43)\G0\$C(27,72,3)\G1\$C(27,72,2)\H\$C(30)\HI\$C(27,40)\HL\$C(58)\IL\"$C(27,69)"\DT\"$C(27,82)"\
 ;IN\$C(27,81)\L\$C(8)\LI\$C(52)\LO\$C(27,41)\P\"$C(27,61,%R+31,%C+31)"\R\$C(50,52)\RI\$C(57)\ROF\""\RON\""\RT\$C(12)\SET\""\TI\$C(48)\TLC\$C(50)\TRC\$C(51)\U\$C(11)\UF\""\UO\""\V\$C(49)\VL\$C(54)\X\$C(56)\
 ;Z\$C(27,71,48,27,40)\SR\""\CSR\""\a\$C(27,71,52,96,27,71,48,96,27,71,56,96,27,71,48)
 ;UK\$C(11)\DK\$C(10)\LK\$C(8)\RK\$C(12)\INK\$C(27,91,64)\DLK\$C(27,91,96)
