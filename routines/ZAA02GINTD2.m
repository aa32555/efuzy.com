ZAA02GINTD2 ;PG&A,ZAA02G-CONFIG,2.25,CRT DEFINITION  (DTMPC COLOR);15FEB94  18:48;;;12JAN95  11:01 [ 09/20/97  10:12 AM ]
 ;Copyright (C) 1987, Patterson, Gray and Assoc., Inc.
BEG S OS=$S($D(^ZAA02G("OS")):^("OS"),1:"") Q:OS=""  S A=$T(DATA),T=$P(A,";",2) W !?5,$P(A,";",3),?50,"Initialize? (Y or N) " R A#5 S A=$E(A) Q:A=""!("Yy"'[$E(A))
ENT W !,?8,"Initializing ",T S M=0,^ZAA02G(0,T,M)="",H=""
 F I=1:1 S A=$T(DATA+I) Q:A=""  S C=$P(A,";",2,99) F J=1:2:$L(C,"\")-1 S D=$P(C,"\",J),E=$P(C,"\",J+1),X="X="_E,@X,^ZAA02G(0,T,D)=X W "." S Y=",ZAA02G("""_D_""")="_E S:$L(H)+$L(Y)>240 ^(M)="S "_$E(H,2,255),M=M+1,H="" S H=H_Y
 S:H'="" ^(M)="S "_$E(H,2,255),^("fon")=$C(255,83),^("fof")=$C(255,254,254)
 S ^("fost")="S X=$C(P4+33,P1+33,P2+33,P3+33)",^("foft")="S P4=$A(JJ)-33,P1=$A(JJ,2)-33,P2=$A(JJ,3)-33,P3=$A(JJ,4)-33"
FNC S ^ZAA02G(.1,T,1)="U 0:(PLEN=24:FLEN=24)"
 S ^(2)="0,81`0,73`0,119`0,88`0,63`0,61`0,86`0,65`0,15`0,59`0,84`0,62`0,64`0,89`0,79"
 S ^(3)="```````````````0,60`0,67`0,92`0,68`23`0,66`0,71```5`1`0,66`0,91"
 S ^(5)="PG DN`PG UP`CTRL HOME`F5`SHIFT F5`F3`SHIFT F3`F7`SHIFT TAB`F1`SHIFT F1`F4`F6`SHIFT F6`END",^(6)="```````````````F2`F9`SHIFT F9`F10`CTRL W`F8`HOME`INS`DEL`CTRL E`CTRL A`F8`SHIFT F8"
CLNUP D @(OS_"^ZAA02GINTRM") Q
 ;
DATA ;DTMPC COLOR;DataTree PC Monitor COLOR
 ;BO\$C(255,66,159)\BF\$C(255,66,23)\BI\$C(193)\BLC\$C(192)\BRC\$C(217)\C\"80"\CL\$C(255,69,76)\CS\$C(255,69,70)\D\$C(11)\DL\""\F\$C(255,67,0,0,255,69,70)\G0\""\G1\""\V\$C(49)
 ;IL\"$C(255,67,0,ZAA02G(""R"")-1,255,83,%R-1,ZAA02G(""R""),1,68,255,67,48,%R-1)"\DT\"$C(255,83,%R-1,ZAA02G(""R""),1,85)"\
 ;H\$C(255,67,0,0)\HI\$C(255,66,31)\HL\$C(196)\IN\""\L\$C(14)\LI\$C(195)\LO\$C(255,66,23)\P\"$C(255,67,%C-1,%R-1)"\
 ;R\"24"\RI\$C(180)\ROF\$C(255,66,31,128)\RON\$C(255,66,79,128)\RT\$C(18)\RU\$C(8)\SET\$C(255,89,16,255,66,31)\TI\$C(194)\TLC\$C(218)\TRC\$C(191)\
 ;U\$C(1)\UF\$C(255,66,31,127)\UO\$C(255,66,29,127)\VL\$C(179)\X\$C(197)\Z\$C(255,89,16,255,66,31)\SR\""\CSR\""
 ;UK\$C(0,72)\DK\$C(0,80)\RK\$C(0,77)\LK\$C(0,75)\INK\$C(0,82)\DLK\$C(0,83)
  
