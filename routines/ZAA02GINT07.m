ZAA02GINT07 ;PG&A,ZAA02G-CONFIG,2.25,CRT DEFINITION  (WYSE60-ASCII);23MAY89 12:02P [ 09/20/97  10:12 AM ]
 ;Copyright (C) 1987, Patterson, Gray and Assoc., Inc.
BEG S OS=$S($D(^ZAA02G("OS")):^("OS"),1:"") Q:OS=""  S A=$T(DATA),T=$P(A,";",2) W !?5,$P(A,";",3),?50,"Initialize? (Y or N) " R A#5 S A=$E(A) Q:A=""!("Yy"'[$E(A))  W !,?8,"Initializing ",T S M=0,^ZAA02G(0,T,M)="",H=""
 F I=1:1 S A=$T(DATA+I) Q:A=""  S C=$P(A,";",2,99) F J=1:2:$L(C,"\")-1 S D=$P(C,"\",J),E=$P(C,"\",J+1),X="X="_E,@X,^ZAA02G(0,T,D)=X W "." S Y=",ZAA02G("""_D_""")="_E S:$L(H)+$L(Y)>240 ^(M)="S "_$E(H,2,255),M=M+1,H="" S H=H_Y
 S:H'="" ^(M)="S "_$E(H,2,255)
FNC S ^ZAA02G(.1,T,1)="G:'$D(ZAA02G(""z"")) INIT^ZAA02GINT07" ;function key load
 S ^(7)="W *27,""`;""\W *27,""`:""\$C(27,113)\$C(27,114)"
 S ^(2)="27,75`27,74`27,91,50,48,126`27,91,50,49,126`27,91,51,50,126`27,69`27,82`27,84`27,73`27,91,49,55,126`27,91,51,49,126`27,91,50,51,126`27,91,50,52,126`27,91,50,53,126`27,123"
 S ^(3)="```````````````27,91,50,54,126`27,91,49,56,126`27,91,49,57,126`27,91,51,50,126`23`27,91,50,55,126`30`27,81`27,87`5`1`27,91,50,56,126`27,91,50,57,126"
 S ^(5)="NEXT PAGE`PREV PAGE`F4`F5`F6`INS LINE`DEL LINE`LINE CLR`SHIFT TAB`F1`F15`F7`F8`F9`SHIFT HOME"
 S ^(6)="```````````````F10`F2`F3`F16`CTRL W`F11`HOME`INS CHAR`DEL CHAR`CTRL E`CTRL A`F12`F13"
CLNUP D @(OS_"^ZAA02GINTRM") Q
 ;
INIT Q:$D(ZAA02G("z"))  S ZAA02G("z")="",ZAA02G1=ZAA02G(1) I ZAA02G1 S ZAA02G(1)=1 X ^ZAA02G("TERM-OFF")
 D FUNC ;convert WYSE60 keys to ANSI format
 I ZAA02G1 X ^ZAA02G("TERM-ON") S ZAA02G(1)=ZAA02G1
 K ZAA02G1 Q  ;flag that keys are loaded
 ;
FUNC ;Fn gets mapped to DSM acceptable Fn
 F from=64:1:79 W *27,"z",$C(from),*27,"[",from-47,"~",*127
 Q
 ;
DATA ;WYSE60;WYSE 60 with ASCII keyboard
 ;C\(80)\R\(24)\SET\$C(27,101,49)\H\$C(30)\U\$C(11)\D\$C(10)\RT\$C(12)\L\$C(8)\F\$C(30,26)\CL\$C(27,84)\CS\$C(27,89)\IN\$C(27,81)\DL\$C(27,87)\IL\"$C(27,69)"\DT\"$C(27,82)"\RON\$C(27,71,52)\
 ;ROF\$C(27,71,48)\HI\$C(27,71,48)\LO\$C(27,71,112)\UO\$C(27,71,56)\
 ;UF\$C(27,71,48)\P\"$C(27,97)_%R_""R""_%C_""C"""\HL\$C(58)\VL\$C(54)\TLC\$C(50)\TRC\$C(51)\BLC\$C(49)\BRC\$C(53)\TI\$C(48)\RI\$C(57)\BI\$C(61)\LI\$C(52)\X\$C(56)\SR\""\CSR\""\V\$C(49)
 ;UK\$C(11)\DK\$C(10)\RK\$C(12)\LK\$C(8)\INK\$C(27,81)\DLK\$C(27,87)\Z\$C(27,71,48)\G0\$C(27,72,3)\G1\$C(27,72,2)\
