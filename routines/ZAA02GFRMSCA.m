ZAA02GFRMSCA ;PG&A,ZAA02G-SCHEMA,2.62,Dictionary Maintenance;7APR95 4:24P
C ;Copyright (C) 1984, Patterson, Gray & Associates, Inc.
 ;
 S:'$D(^ZAA02GSCHEMA) ^ZAA02GSCHEMA="" N:0 (ZAA02G,ZAA02GP) D:$D(ZAA02G)+$D(ZAA02GP)'=12 INIT^ZAA02GDEV X ^ZAA02G("TERM-ON"),^ZAA02G("WRAP-OFF")
BEG D HEAD S Y="Edit Dictionary Code\Display Codes\Print Codes\Copy Dictionary Code\List Updated Forms\Recompile Update Forms\Quit",L="EDPCLRQ"
 S NE=7,(TC,%C)=28,TR=8
SELECT D SEL G:J=0 EXIT S:'J J=$F(L,J)-1 K L
 I J=1 G CODE
 I J=2 D ^ZAA02GFRMSC2 D:$D(S1) ^ZAA02GFRMSC1:S1'="Q" G BEG
 I J=3 D ^ZAA02GFRMSC3 G BEG
 I J=4 D COPY^ZAA02GFRMSC3 G BEG
 I J=5 D FORMS^ZAA02GFRMSC3 G BEG
 I J=6 D RECOM G BEG
 ;
EXIT W:'$D(qt) ZAA02G("F") X ^ZAA02G("TERM-OFF"),^ZAA02G("WRAP-ON") Q
 Q
CODE K A,CA D HEAD
CODE1 S %R=5,%C=5,LNG=9,X="",PAT="X?1A.AN!(X?.E1""?"".E)" W:'$D(qt) @ZAA02GP,ZAA02G("LO"),"Enter Dictionary Code ",ZAA02G("HI"),ZAA02G("CL") S %C=28 X ^ZAA02GREAD G:X="" BEG S S1=X
 I X["?" W !!?10,"Codes may be any string starting with an Alpha character" G CODE1
 D ^ZAA02GFRMSC1 G CODE
 ;
 ;
NA S %R=20 W:'$D(qt) @ZAA02GP,"OPTION NOT AVAILABLE" H 2 W:'$D(qt) @ZAA02GP,ZAA02G("CL") Q
HEAD W:'$D(qt) ZAA02G("F"),ZAA02G("Z") S %R=1,%C=2 W:'$D(qt) ZAA02G("LO"),@ZAA02GP,ZAA02G("RON")," P ",ZAA02G("RT")," G ",ZAA02G("RT")," & ",ZAA02G("RT")," A " S %C=26 W:'$D(qt) @ZAA02GP,ZAA02G("ROF"),ZAA02G("HI"),"DATABASE DICTIONARY MANAGEMENT",ZAA02G("LO")
 S %C=68 W:'$D(qt) @ZAA02GP,ZAA02G("RON"),"  ZAA02GFRMSCA  ",ZAA02G("ROF"),ZAA02G("G1"),! S J=ZAA02G("HL"),J=J_J_J_J F I=1:1:20 W J
 W:'$D(qt) ZAA02G("G0") Q:$D(NE)  S %R=3,%C=14 W:'$D(qt) @ZAA02GP,ZAA02G("LO"),"Copyright (C) 1985, Patterson, Gray and Assoc., Inc." Q
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
 G A2
A3 W $C(8,8,8,8),"    ",ZAA02G("HI"),$E(X),ZAA02G("LO"),"  ",X Q
DONE K TR,TC,Y,L,X,C X ^ZAA02G("ECHO-ON") Q
 ;
RECOM S %R=3,%C=1,A="RECOMPILE UPDATED FORMS" W:'$D(qt) @ZAA02GP,ZAA02G("CS"),ZAA02G("Z"),!,?(80-$L(A)\2),A
 S A="" F I=1:1 S A=$O(^ZAA02GSCHEMA(1,A)) Q:A=""
 I I=1 S A="( No forms waiting to be recompiled. )" W !!,?(80-$L(A)\2),A R *A:30 Q
 S %R=6,%C=1,PROMPT="Do you want to recompile the "_(I-1)_" form"_$S(I>2:"s which have",1:" which has")_" been changed via ZAA02G-SCHEMA? ",X="N",CHR="YyNn",LNG=1 X ^ZAA02GREAD Q:"Nn"[X
 S ACOMPILE="ED2",A="" F I=0:0 S A=$O(^ZAA02GSCHEMA(1,A)) Q:A=""  S SCR=$P(A,"-"),SN=$P(A,"-",2) D AC^ZAA02GFRME1 S I=0,A=SCR_"-"_SN
 Q
