ZAA02GDEV2 
CTL I ^ZAA02G(0,DV,"V")=1 D EMBED
 D INPUT S T=DV D @(^ZAA02G("OS")_"^ZAA02GINTRM")
 G OK^ZAA02GDEV
 ;
EMBED S C=$D(^ZAA02G(0,DV,"a"))  K ^("a")
EMBED1 W !!,"Does this terminal use embedded video attributes, (i.e., does this terminal,",!,"utilize a position on the screen for changes in video attributes)?",!,"   Y or N: (",$S(C:"Y",1:"N"),")  " R A#1
 S:A="" A=$S(C:"Y",1:"N") S:A?1L A=$C($A(A)-32) G:"YN"'[A EMBED1 Q:A="N"
 S a="" F A=1:1:4 S B=$P("RON`ROF`UO`UF","`",A),C=$S('$D(^(B)):"",^(B)]"":^(B),1:"") S:C]"" $P(a,"`",A)=C S ^(B)=""
 S ^("a")=a K a
 W !!,"ZAA02G-DEV has stored Reverse ON & OFF and Underline ON & OFF in ZAA02G(""a""),"
 W !,"pieces 1 thru 4 respectively, and has reset the attributes to nil."
 W !,"Only ZAA02GPOP and ZAA02GFORM table pop-ups will use Reverse Video."
 Q
INPUT W !!,"INPUT PARAMETERS       (Control sequence from terminal to computer)",!!,"Enter the decimal values of the ASCII characters that are transmitted by the",!,"key that is used for each of the following functions.",!!
 W ?10,"Example of an input:     27,65     (which is an ESC,A)",!!
 S (ZAA02G("T"),ZF)="",ZAA02G=DV G:$D(^ZAA02G("TERMST"))=0 BEG S:$D(ZAA02G(1))=0 ZAA02G(1)=0 S ZAA02G("T")=^("TERMST") X:$I=1&$D(^ZAA02G("8BIT")) ^("8BIT") X ^ZAA02G("TERM-ON")
 W "NOTE:  If you are presently typing on the terminal that you are also defining",!,"then you need only press the key associated with the function and the computer",!,"will create the decimal values for you.",!!
BEG W "Press RETURN to skip over a function.",!!
 F C=1:1 S B=$P($T(FUNC+C),";",2,9) Q:B=""  I H[$P(B,";") S SB=$P(B,";",3),A=$P(B,";",2),T=$S(A=3:"HARD COPY DEVICES",1:0),O=$S($D(^ZAA02G(T,DV,SB)):^(SB),1:"") D ENTER
 D:0 LAST F I=0:1:5 K ^ZAA02G(T,DV,I)
 F I=0:1:M S ^(I)="S "_$E(M(I),2,255)
 X:ZAA02G("T")'="" ^ZAA02G("TERM-OFF") K:$D(ZAA02G)=10 ZAA02G Q
ERASE X "F J=J:-1:1 W $C(8,32,8)" Q
LAST S A="",SB="Z" F I="ROF","UF" S A=A_^ZAA02G(0,DV,I)
 I A="",$D(^ZAA02G(0,DV,"a")) F I=2,4 S A=A_$P(^ZAA02G(0,DV,"a"),"`",I)
 S:A="" A=$C(0) S ^ZAA02G(0,DV,SB)=A S:DV["VT" ^(SB)=$C(27,91,48,109) S Y="$C(" F J=1:1:$L(A) S:J>1 Y=Y_"," S Y=Y_$A(A,J)
 S Y=Y_")" D S1 Q
ENTER W ! W:$P(B,";",2)=2 "*" W ?3,SB,?8,"- ",$P(B,";",4),"  " S X=O D DISP W "> "
E1 R E X ZAA02G("T") I ZF'="",ZF'=$C(13) F I=1:1:$L(ZF) S E=E_$A(ZF,I)_","
 S:$E(E,$L(E))="," E=$E(E,1,$L(E)-1) I E="" W $C(8,8,32) G:X'="" S1 S (X,Y)="" G SS
 I E="-" S J=$L(Y) S (E,X,Y)="" G SS
 I E="?" W !!,$S($P(B,";",5)'="":$P(B,";",5),1:"Enter the ASCII sequence in decimal separated by commas ( - clears item)"),! G ENTER
 S F=0,X="" I A'=2 F I=1:1 S J=$P(E,",",I) Q:J=""  S:'(J?1N.N&(J<256)) F=1 S X=X_$C(J)
 I F W "  ???",*7 S J=$L(E)+6 H 2 D ERASE W " " G E1
SS S:"12"[A X=E S ^ZAA02G(T,DV,SB)=X,J=$X-44 D ERASE D DISP
S1 D:A=2 S2 S:Y="" Y="""""" S:$L(M(M))+$L(Y)>240 M=M+1,M(M)="" S M(M)=M(M)_",ZAA02G("""_SB_""")="_Y Q
S2 S Y=X Q:X=""  I Y["""" S %F=$F(X,"""") F %J=0:0 S Y=$E(Y,0,%F-2)_""""""_$E(Y,%F,256),%F=$F(Y,"""",%F+1) Q:%F<1
 S Y=""""_Y_"""" Q
 ;
DISP S Y="" W ?44 Q:X=""  I 12'[A S Y="$C(" X "F I=1:1:$L(X) S:I>1 Y=Y_"","" S Y=Y_$A(X,I)" S Y=Y_")" W Y Q
 I A=1 S Y="("_X_")" W Y Q
 S Y=X W X Q
 ;
FUNC ; 0=hard,1=soft;0=$C(X),1=X,2=MUMPS code,3=^ZAA02G("HARDCOPY DEVICES",T)=$C(X);variable;prompt;help
 ;1;0;UK;Cursor up
 ;1;0;DK;Cursor down
 ;1;0;RK;Cursor right
 ;1;0;LK;Cursor left
 ;1;0;INK;Insert Character
 ;1;0;DLK;Delete Character
