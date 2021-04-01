ZAA02GDEV3
PROG D:$D(ZAA02G)<10 INIT^ZAA02GDEV W ZAA02G("F") X ^ZAA02G("TERM-ON"),^ZAA02G("WRAP-OFF")
ENTRY D HEAD S %R=3,%C=10 W @ZAA02GP,ZAA02G("LO"),"Enter any CRT specific MUMPS code necessary to set up this CRT type",!?9,"for Advanced Editing (i.e., function keys, video attributes, etc.)."
 S X=$S($D(^ZAA02G(.1,ZAA02G,1)):^(1),1:""),%R=5,%C=1,LNG=255 W @ZAA02GP,ZAA02G("HI"),X X ^ZAA02GREAD S ^ZAA02G(.1,ZAA02G,1)=X
 I X'="",^ZAA02G("OS")'="CCSM" S A="help="_^ZAA02G("ERRORR"),@A,A=^("ERROR")_"=""HELP""",@A X X S:help'["<" A=^ZAA02G("ERROR")_"=help",@A K help,A
WIDE S SUB7=$S($D(^ZAA02G(.1,ZAA02G,7)):^(7),1:"")
 S %R=9,%C=10 W @ZAA02GP,ZAA02G("LO"),"If the CRT has a 132 column screen option, enter the MUMPS code ",!?9,"necessary for changing to the wide screens."
 S X=$P($P(SUB7,"\"),"S ZAA02G(""C"")=132 ",2),%R=11,%C=1,LNG=80 W @ZAA02GP,ZAA02G("HI"),X X ^ZAA02GREAD S:$L(X)>3 X="S ZAA02G(""C"")=132 "_X S $P(SUB7,"\")=X G:X="" INS
 S X=$P($P(SUB7,"\",2),"S ZAA02G(""C"")=80 ",2),%R=13,%C=10,LNG=80 W @ZAA02GP,ZAA02G("LO"),"Enter code to change back to normal screen." S %R=14,%C=1 W @ZAA02GP,ZAA02G("HI"),X X ^ZAA02GREAD S:$L(X)>3 X="S ZAA02G(""C"")=80 "_X S $P(SUB7,"\",2)=X
INS S %R=16,%C=10 W @ZAA02GP,ZAA02G("LO"),"Enter a valid MUMPS argument indirection to turn INSERT MODE on," S %R=%R+1 W @ZAA02GP,"e.g., $C(27,91,52,104) is the valid DEV VT220 sequence."
 S %R=%R+1,%C=1,X=$P(SUB7,"\",3) W @ZAA02GP,ZAA02G("HI"),X X ^ZAA02GREAD
 S $P(SUB7,"\",3)=X I X="" G EXIT
 S %R=%R+2,%C=10 W @ZAA02GP,ZAA02G("LO"),"Enter a valid MUMPS argument indirection to turn REPLACE MODE on."
 S %R=%R+1,%C=1,X=$P(SUB7,"\",4) W @ZAA02GP,ZAA02G("HI"),X X ^ZAA02GREAD S $P(SUB7,"\",4)=X
EXIT S ^ZAA02G(.1,ZAA02G,7)=SUB7 K SUB7
EDIT G ^ZAA02GDEV4
 ;
HEAD W ZAA02G("F") S %C=20,%R=1 W @ZAA02GP,"F U N C T I O N   K E Y   D E F I N I T I O N"
 Q
 ;
HELP W !!!,"Enter a valid MUMPS expression.",*7 H 4 G PROG
 ;
DEV R "Enter Device Number ( 0 for current device, ? to list defined devices ) > ",A Q:A=""  G:A="?" DEVL
 S:A=0 A=$I I $D(^ZAA02G(A)) W !!," Currently Device ",A," = ",^(A)
 W !!
DEV1 W "Select the appropriate ",$S(A=$I:"type of your device ",1:"device type"),"from the following list",!! S B="" F I=1:1 S B=$O(^ZAA02G(0,B)) Q:B=""  W I,"-",B,"  " S I(I)=B
 W !
DEVT R !," ? ",B I B>0,B<I S ^ZAA02G(A)=I(B) W "...defined as ",I(B),!! K ZAA02G Q
 I B'="" W " ???" G DEVT
 W ! G DEV
DEVL W !! S A=.9 I +$O(^ZAA02G(A))=0 W ?10,"( nothing currently defined )",!! G DEV
 F I=0:0 S A=$O(^ZAA02G(A)) Q:A=""  Q:A<1  I A?.N W A," - ",?I*26+7,^(A),?I+1*26 S I=I+1 I $X>53 W ! S I=0
 W !! G DEV
 ;
CLEANUP ; REMOVES UNUSED TERMINAL TYPES
 W !! K A S A=.9 F  S A=$O(^ZAA02G(A)) Q:A=""  Q:A<1  I A?.N,$D(^(A))#2 S A(^(A))=""
 S A="" F  S A=$O(^ZAA02G(0,A)) Q:A=""  I '$D(A(A)) W !,A," is not used.  Do you want to remove it? (Y/N) " R B#1 I B]"","yY"[B K ^ZAA02G(0,A) W " ...removed"
 Q
