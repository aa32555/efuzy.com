ZAA02GINT08 ;PG&A,ZAA02G-CONFIG,2.25,CRT DEFINITION  (WYSE60-AT);17JAN90 3:13P [ 09/20/97  10:12 AM ];;;28JUN99  16:40
 ;Copyright (C) 1987, Patterson, Gray and Assoc., Inc.
BEG S OS=$S($D(^ZAA02G("OS")):^("OS"),1:"") Q:OS=""  S A=$T(DATA),T=$P(A,";",2) W !?5,$P(A,";",3),?50,"Initialize? (Y or N) " R A#5 S A=$E(A) Q:A=""!("Yy"'[$E(A))
ENT W !,?8,"Initializing ",T S M=0,^ZAA02G(0,T,M)="",H=""
 F I=1:1 S A=$T(DATA+I) Q:A=""  S C=$P(A,";",2,99) F J=1:2:$L(C,"\")-1 S D=$P(C,"\",J),E=$P(C,"\",J+1),X="X="_E,@X,^ZAA02G(0,T,D)=X W "." S Y=",ZAA02G("""_D_""")="_E S:$L(H)+$L(Y)>240 ^(M)="S "_$E(H,2,255),M=M+1,H="" S H=H_Y
 S:H'="" ^(M)="S "_$E(H,2,255)
FNC S ^ZAA02G(.1,T,1)="G:'$D(ZAA02G(""z"")) INIT^ZAA02GINT08" ;backspace key to ascii 26
 S ^(7)="W *27,""`;""\W *27,""`:""\$C(27,113)\$C(27,114)"
 S ^(2)="27,75`27,74`27,123`27,91,50,49,126`27,91,51,55,126`27,91,49,57,126`27,91,51,53,126`27,91,50,51,126`27,73`27,91,49,55,126`27,91,51,51,126`27,91,50,48,126`27,91,50,50,126`27,91,51,56,126`2"
 S ^(3)="```````````````27,91,49,56,126`27,91,50,53,126`27,91,52,49,126`27,91,50,54,126`23`27,91,50,52,126`30```5`1`27,91,50,52,126`27,91,52,48,126"
 S ^(5)="PG DN`PG UP`SHIFT HOME`F5`SHIFT F5`F3`SHIFT F3`F7`SHIFT TAB`F1`SHIFT F1`F4`F6`SHIFT F6`END or CTRL B"
 S ^(6)="```````````````F2`F9`SHIFT F9`F10`CTRL W`F8`HOME`INS`DEL`CTRL E`CTRL A`F8`SHIFT F8" Q
CLNUP D @(OS_"^ZAA02GINTRM") Q
 ;
INIT Q:$D(ZAA02G("z"))  W !,"Loading function keys.  Please wait." S ZAA02G("z")="",ZAA02G1=ZAA02G(1) I ZAA02G1 S ZAA02G(1)=1 X ^ZAA02G("TERM-OFF")
 D FUNC ;convert WYSE60 keys to ANSI format
 I ZAA02G="WY60AT" W *27,"Z0",*45,*26,*127 ;change cursor left key to ascii 26
 E  D PAGE
 I ZAA02G1 X ^ZAA02G("TERM-ON") S ZAA02G(1)=ZAA02G1
 K ZAA02G1 Q  ;flag that keys are loaded
 ;
PAGE S from="rw",to=$C(27)_"[6~|"_$C(27)_"[5~" F i=1:1:$L(from) W *27,"Z0",$E(from,i),$P(to,"|",i),*127 H 1
 ;
FUNC W ! F from=64:1:$S(ZAA02G="WY60AT":73,1:79) W *13,"F",from-63,*27,"z",$C(from),*27,"[",from-47,"~",*127 H 1 W *27,"z",$C(from+32),*27,"[",from-47+16,"~",*127 H 1
 ;Fn gets mapped to DSM acceptable Fn, S Fn at Fn+16
 W *13,"   " Q
 ;
 ;
DATA ;WY60AT;WYSE 60 with AT keyboard
 ;C\(80)\R\(24)\SET\""\H\$C(30)\U\$C(11)\D\$C(10)\RT\$C(12)\L\$C(8)\F\$C(30,26)\CL\$C(27,84)\CS\$C(27,89)\IN\$C(27,81)\DL\$C(27,87)\IL\"$C(27,69)"\DT\"$C(27,82)"\RON\$C(27,71,52)\ROF\$C(27,71,48)\HI\$C(27,71,48)\LO\$C(27,71,112)\UO\$C(27,71,56)\
 ;UF\$C(27,71,48)\P\"$C(27,97)_%R_""R""_%C_""C"""\HL\$C(58)\VL\$C(54)\TLC\$C(50)\TRC\$C(51)\BLC\$C(49)\BRC\$C(53)\TI\$C(48)\RI\$C(57)\BI\$C(61)\LI\$C(52)\X\$C(56)\SR\""\CSR\""\V\$C(49)
 ;UK\$C(11)\DK\$C(10)\RK\$C(12)\LK\$C(26)\INK\$C(27,113)\DLK\$C(127)\Z\$C(27,71,48)\G0\$C(27,72,3)\G1\$C(27,72,2)\
