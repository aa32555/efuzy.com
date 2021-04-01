ZAA02GFRMM1 ;PG&A,ZAA02G-FORM,2.62,MAINTENANCE MENU;8DEC95 9:07A
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
BEG D HEAD
 S Y="Edit Control Question Wording\Print Global Xref\Copy ALL Forms to Export Global\Select & Copy FORMS to Export Global\Restore FORMS from Export Global\Build ZAA02GSCHEMA Entries from Existing Fields\Display Screen\Quit"
 S L="EPCSRBDQ"
 S NE=8,(TC,%C)=24,TR=6
SELECT D SEL G:J=0 EXIT
 I J=1 D ^ZAA02GFRMM2 G BEG
 I J=2 D CHOOSE G:$D(SCR)<10 BEG D ^ZAA02GFRMM3 G BEG
 I J=3 S SCR="ALL" D FORM G:X="" BEG D ^ZAA02GFRMM4 G BEG
 I J=4 D CHOOSE G:$D(SCR)<10 BEG D FORM G:X="" BEG D ^ZAA02GFRMM4 G BEG
 I J=5 S %R=10 D FORM G:X="" BEG D REBUILD^ZAA02GFRMM4 G BEG
 I J=6 D CHOOSE G:$D(SCR)<10 BEG D ^ZAA02GFRMM5 G BEG
 I J=7 D DISPLAY G BEG
 Q
DISPLAY S A="A" F J=1:1 S A=$O(^ZAA02GDISPL(A)) Q:A=""  D D1
 Q
D1 W:'$D(qt) ZAA02G("F") I $O(^(A,0,ZAA02G,""))="" W A," not compiled for this terminal" G D2
 S B="" F J=1:1 S B=$O(^(B)) Q:B=""  Q:B>99  W:B#1<.2 ^(B)
D2 S %R=24,%C=60-$L(A)/2 W *13,@ZAA02GP,ZAA02G("ROF"),ZAA02G("UF"),ZAA02G("HI"),A,"   -   PRESS RETURN" R AA Q
EXIT W:'$D(qt) ZAA02G("F") Q
 ;
HEAD W:'$D(qt) ZAA02G("F"),ZAA02G("Z") S %R=1,%C=2 W:'$D(qt) ZAA02G("LO"),@ZAA02GP,ZAA02G("RON")," P ",ZAA02G("RT")," G ",ZAA02G("RT")," & ",ZAA02G("RT")," A " S %C=26 W:'$D(qt) @ZAA02GP,ZAA02G("ROF"),ZAA02G("HI"),"ZAA02G-FORM MAINTENANCE UTILITIES",ZAA02G("LO")
 S %C=65 W:'$D(qt) @ZAA02GP,ZAA02G("RON"),"    ZAA02G-FORM    ",ZAA02G("ROF"),ZAA02G("G1"),! S J=ZAA02G("HL"),J=J_J_J_J F I=1:1:20 W J
 W:'$D(qt) ZAA02G("G0") Q
 ;
SEL F I=1:1:NE S X=$P(Y,"\",I),%R=I+TR W:'$D(qt) @ZAA02GP,ZAA02G("HI"),$E(X),"  ",ZAA02G("LO"),X
 S I=""
LEV S %R=24,%C=7 W:'$D(qt) @ZAA02GP,ZAA02G("LO"),"[ Type ",ZAA02G("HI"),"Letter",ZAA02G("LO")," or use ",ZAA02G("HI"),"ARROWS",ZAA02G("LO")," to move selector, ",ZAA02G("HI"),"RETURN",ZAA02G("LO")," to make selection ]" S %C=1,%R=TR+1 W:'$D(qt) @ZAA02GP,*13
 ;
ASK S J=1,%C=TC-4 X ^ZAA02G("ECHO-OFF")
A1 S %R=TR+J,X=$P(Y,"\",J) W:'$D(qt) @ZAA02GP,ZAA02G("HI"),"==> ",$E(X),"  ",X,@ZAA02GP,"==> "
A2 R C#1 X ZAA02G("T") S A=ZF I C'="" S:C?1L C=$C($A(C)-32) I L[C S J=$F(L,C)-1 D A3 G A1:^ZAA02G("MENU"),DONE
 I A=ZAA02G("UK") D A3 S J=$S(J>1:J-1,1:NE) G A1
 I C=" "!(A=ZAA02G("DK")) D A3 S J=$S(J<NE:J+1,1:1) G A1
 I ZF=$C(13) G DONE
 I ^ZAA02GDISP(95,ZAA02G,4)[ZF S ZF=$F(^(4),ZF) I $E(^(4),ZF,ZF+1)="E4" S J=0 Q
 G A2
A3 W $C(8,8,8,8),"    ",ZAA02G("HI"),$E(X),ZAA02G("LO"),"  ",X Q
DONE K TR,TC,Y,L,X,C X ^ZAA02G("ECHO-ON") Q
 ;
CHOOSE K Y,SCR S %R=12,%C=1 W:'$D(qt) @ZAA02GP,ZAA02G("CS") S Y="8,12\TRLM1ADS\6\ Select One or More Form Series with SELECT Key - Press RETURN ",A=99,Y(0)="\EX\^ZAA02GDISP\X\99"
 S X="" D ^ZAA02GFORMP Q:X=""  Q:X[";EX"  I X'="" F J=1:1:$L(X,",")-1 S SCR(X($P(X,",",J)))=""
 S SCR="" F J=1:1 S SCR=$O(SCR(SCR)) Q:SCR=""  D CH1
 K X,Y Q
CH1 K X S Y="5,15\BRLM1AHDS\2\SERIES: "_SCR_" (Select One or More FORM #s - Press RETURN) ",Y(0)="\EX\^ZAA02GDISP(SCR)\X_""  ""_$E($P(^ZAA02GDISP(SCR,X),""`"",4),1,15)"
 S X="" D ^ZAA02GFORMP Q:X[";EX"  F J=1:1:$L(X,",")-1 S SCR(SCR,$P(X($P(X,",",J))," "))=""
 Q
 ;
FORM S:%R>20 %R=20 S Y="50,"_%R_"\HL\1\\\Enter MUMPS GLOBAL*,*" K X D ^ZAA02GFORMP
 Q:X=""  I $E(X)'="^" S X="^"_X Q
 Q
 ;
LONG S A=999,(B,C)="" F J=1:1 S A=$O(^ZAA02GDISP(A)) Q:A=""  F J=1:1 S B=$O(^ZAA02GDISP(A,B)) Q:B=""  W:$L(^(B))>254 !,A," ",B F J=1:1 S C=$O(^ZAA02GDISP(A,B,C)) Q:C=""  I $D(^(C))#2,$L(^(C))>254 W !,A," ",B," ",C," = ",$L(^(C))
