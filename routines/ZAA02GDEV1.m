ZAA02GDEV1
BEG S H=$F("PV",$E(E_H))-2,^ZAA02G(0,DV,"V")=H
 W !!,"OUTPUT PARAMETERS       (control sequences from computer to terminal)",!!,"Enter the decimal values of the ASCII characters that define the following",!,"functions.  Press RETURN to skip functions.  Functions with * require an",!
 W "executable MUMPS expression which will be an argument of the Write command",!
 I $D(^ZAA02G(0,DV,"a")) F A=1:1:4 S ^($P("RON`ROF`UO`UF","`",A))=$P(^("a"),"`",A)
 S M=0,M(M)="" F C=1:1 S B=$P($T(FUNC+C),";",2,9) Q:B=""  I H[$P(B,";") S SB=$P(B,";",3),A=$P(B,";",2),T=$S(A=3:"HARD COPY DEVICES",1:0),O=$S($D(^ZAA02G(T,DV,SB)):^(SB),1:"") D ENTER
 G ^ZAA02GDEV2
ERASE X "F J=J:-1:1 W $C(8,32,8)" Q
ENTER I SB="SET",$L(O)>20 D CKSET I  S X=O,Y="^(""SET"")" G S1
 W ! W:$P(B,";",2)=2 "*" W ?3,SB,?8,"- ",$P(B,";",4),"  " S X=O D DISP W "> "
E1 R E I E="" W $C(8,8,32) G:X'="" S1 S (X,Y)="" G SS
 I E="-" S J=$L(Y) S (E,X,Y)="" G SS D ERASE W "(Item Cleared)" S ^ZAA02G(T,DV,SB)="" Q
 I E="?" W !!,$S($P(B,";",5)'="":$P(B,";",5),1:"Enter the ASCII sequence in decimal separated by commas ( - clears item)"),! G ENTER
 S F=0,X="" I A'=2 F I=1:1 S J=$P(E,",",I) Q:J=""  S:'(J?1N.N&(J<256)) F=1 S X=X_$C(J)
 I F W "  ???",*7 S J=$L(E)+6 H 2 D ERASE W " " G E1
SS S:"12"[A X=E S ^ZAA02G(T,DV,SB)=X,J=$X-44 D ERASE D DISP
S1 D:A=2 S2 S:Y="" Y="""""" S:$L(M(M))+$L(Y_SB)>240 M=M+1,M(M)="" S M(M)=M(M)_",ZAA02G("""_SB_""")="_Y Q
S2 S Y=X Q:Y=""  I Y["""" S %F=$F(X,"""") F %J=0:0 S Y=$E(Y,0,%F-2)_""""""_$E(Y,%F,256),%F=$F(Y,"""",%F+1) Q:%F<1
 S Y=""""_Y_"""" Q
 ;
DISP S Y="" W ?44 Q:X=""  I 12'[A S Y="$C(" F I=1:1:$L(X) S:I>1 Y=Y_"," S Y=Y_$A(X,I)
 I  S Y=Y_")" W Y Q
 I A=1 S Y="("_X_")" W Y Q
 S Y=X W X Q
 ;
CKSET F Y=0:1 Q:'$D(^ZAA02G(0,DV,Y))  I ^(Y)["^(""SET"")" Q
 S Y="" Q
FUNC ; 0=hard,1=soft;0=$C(X),1=X,2=MUMPS code,3=^ZAA02G("HARDCOPY DEVICES",T)=$C(X);variable;prompt;help
 ;;1;C;# Columns;Enter maximum horizontal columns
 ;;1;R;# Rows;Enter total number of lines per page
 ;1;0;SET;Setup terminal (graphics, etc.)
 ;1;0;H;Cursor home
 ;1;0;U;Cursor up
 ;1;0;D;Cursor down
 ;1;0;RT;Cursor right
 ;1;0;L;Cursor left
 ;1;0;F;Home and Erase Screen
 ;1;0;CL;Clear to end of line
 ;1;0;CS;Clear to end of screen
 ;1;0;IN;Insert Character
 ;1;0;DL;Delete Character
 ;1;2;IL;Insert Line
 ;1;2;DT;Delete Line
 ;1;0;RON;Reverse Video On
 ;1;0;ROF;Reverse Video Off
 ;1;0;HI;High Intensity
 ;1;0;LO;Low Intensity
 ;1;0;UO;Underline On
 ;1;0;UF;Underline Off
 ;1;0;Z;Reset Video to High
 ;1;2;P;Cursor Address (%R=row,%C=col.);Enter MUMPS executable code
 ;0;3;CPI10;Normal 10 char/inch output
 ;0;3;CPI12;Normal 12 char/inch output
 ;0;3;CPI16;Compressed 16 char/inch output
 ;1;0;G1;Graphic Mode On
 ;1;0;G0;Graphic Mode Off
 ;1;0;HL;Horizontal Line
 ;1;0;VL;Vertical Line
 ;1;0;TLC;Top Left Corner
 ;1;0;TRC;Top Right Corner
 ;1;0;BLC;Bottom Left Corner
 ;1;0;BRC;Bottom Right Corner
 ;1;0;TI;Top Intersection
 ;1;0;RI;Right Intersection
 ;1;0;BI;Bottom Intersection
 ;1;0;LI;Left Intersection
 ;1;0;X;Crossed Lines
 ;1;2;SR;Scroll Region (%R=top,%C=bottom)
 ;1;2;CSR;Clear Scroll Region
