ZAA02GINT13
BEG S OS=$S($D(^ZAA02G("OS")):^("OS"),1:"") Q:OS=""  S A=$T(DATA),T=$P(A,";",2) W !?5,$P(A,";",3),?50,"Initialize? (Y or N) " R A#5 S A=$E(A) Q:A=""!("Yy"'[$E(A))
ENT W !,?8,"Initializing ",T S M=0,^ZAA02G(0,T,M)="",H=""
	F I=1:1 S A=$T(DATA+I) S C=$P(A,";",2,99) Q:C=""  F J=1:2:$L(C,"|")-1 S D=$P(C,"|",J),E=$P(C,"|",J+1),X="X="_E,@X,^ZAA02G(0,T,D)=X W "." S Y=",ZAA02G("""_D_""")="_E S:$L(H)+$L(Y)>240 ^(M)="S "_$E(H,2,255),M=M+1,H="" S H=H_Y
	S:H'="" ^(M)="S "_$E(H,2,255) S ^("fon")=$C(27,61,32),^("fof")=$C(27,61,206)
	S ^("fost")="S X=$C(P4+32,P1+32,P2+32)",^("foft")="S P4=$A(JJ)-32,P1=$A(JJ,2)-32,P2=$A(JJ,3)-32,P3=0"
FNC S ^ZAA02G(.1,T,1)="F X=1:1:24 W *27,*33,*61,*32+X,*33,*27,*91,*69+X+(X=10*18)+(X=22*7)+(X=11!(X=12)*20),*27,*61",^(7)="W *27,*32,*114,*33,*33,*32,*57,*36,*68\W *27,*32,*114,*33,*33,*32,*57,*34,*80"
	S ^(2)="27,91,101`27,91,100`27,91,86`27,91,92`27,91,93`27,91,72`27,91,84`27,91,76`27,91,74`27,91,70`27,91,82`27,91,73`27,91,75`27,91,87`27,91,98"
	S ^(3)="```````````````27,91,71`27,91,78`27,91,90`27,91,97`27,91,83`27,91,77`27,91,88```27,91,85`1`27,91,77`27,91,89"
	S ^(5)="F12`F11`SHIFT F5`SHIFT F11`SHIFT F12`F3`SHIFT F3`F7`F5`F1`SHIFT F1`F4`F6`SHIFT F6`SHIFT F10",^(6)="```````````````F2`F9`SHIFT F9`F10`SHIFT F2`F8`SHIFT F7`F11`F12`SHIFT F4`Ctrl A`F8`SHIFT F8"
CLNUP D @(OS_"^ZAA02GINTRM") Q
	;
DATA ;IBM3151;IBM 3151 or compatible
	;BI|$C(246)|BLC|$C(237)|BRC|$C(234)|C|$C(56,48)|CL|$C(27,73)|CS|$C(27,74)|D|$C(27,66)|DL|$C(27,81)|F|$C(27,72,27,74)|IL|"$C(27,78)"|DT|"$C(27,79)"|G0|$C(15)|G1|$C(14)
	;H|$C(27,72)|HI|$C(27,52,40,97)|HL|$C(241)|IN|$C(27,80)|L|$C(27,68)|LI|$C(244)|LO|$C(27,52,39,98)|P|"$C(27,121,%R\32+32,%R#32+31,%C-1\32+32,%C-1#32+64)"|
	;R|$C(50,52)|RI|$C(245)|ROF|$C(27,52,46,98)|RON|$C(27,52,33,97)|RT|$C(27,67)|SET|$C(27)|TI|$C(247)|TLC|$C(236)|TRC|$C(235)|
	;U|$C(27,65)|UF|$C(27,52,45,98)|UO|$C(27,52,34,97)|V|$C(49)|VL|$C(248)|X|$C(238)|Z|$C(27,52,72)|SR|""|CSR|""
	;UK|$C(27,65)|DK|$C(27,66)|RK|$C(27,67)|LK|$C(27,68)|INK|$C(27,80)|DLK|$C(27,81)
	;
CONV ; 3151 CONVERSION
	S R(1)=$C(27,52,73),R(2)=$C(27,52,64),R(3)=$C(27,52,74),R(4)=$C(27,52,66)
	S W(1)=$C(27,52,33,97),W(2)=$C(27,52,46,98),W(3)=$C(27,52,34,97),W(4)=$C(27,52,45,98)
	S A="A",B="" F J=1:1 S A=$O(^ZAA02GWP(A)) Q:A=""  F J=1:1 S B=$O(^ZAA02GWP(A,B)) Q:B=""  I $D(^(B,.015)),^(.015)["3151" S C=.03 F K=1:1 S C=$O(^(C)) Q:C=""  I ^(C)[$C(27) D CONV1
	Q
CONV1 W "." F L=1:1:4 I ^(C)[R(L) F M=2:1:$L(^(C),R(L)) S ^(C)=$P(^(C),R(L))_W(L)_$P(^(C),R(L),2,99)
	Q
	;