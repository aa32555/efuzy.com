ZAA02GFORME ;PG&A,ZAA02G-FORM,2.62,FORM EDITOR;31MAR95 10:03A
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
 D:'$D(^ZAA02GDISP) INIT D:$D(ZAA02G)+$D(ZAA02GP)'=12 INIT^ZAA02GDEV X ^ZAA02G("TERM-ON"),^ZAA02G("WRAP-OFF")
 D UND^ZAA02GFORM3:'$D(^ZAA02GDISP(95,ZAA02G,4))
BEG D HEAD
 S Y="Edit Input Criteria\Build Form Format\List Forms\Copy Form\Print Form Detail\Delete Options\Recompile Forms\Invoke SAMPLE Forms\Original SAMPLE Forms Rebuild\ZAA02G-SCHEMA Data Dictionary\Maintenance Utilities\Quit"
 S L="EBLCPDRIOTMQ"
 S NE=12,(TC,%C)=28,TR=6
SELECT D SEL G:J=0 EXIT K ACOMPILE
 I J=1 D SEB G:SCR="" BEG D EDIT^ZAA02GFRME1 G BEG
 I J=2 D SEB G:SCR="" BEG D ^ZAA02GFRME1 G BEG
 I J=3 D LIST G BEG
 I J=4 D ^ZAA02GFRMC G BEG
 I J=5 D ^ZAA02GFRMPS G BEG
 I J=6 D ^ZAA02GFRMD G BEG
 I J=7 S J="Start with" S (SCR,SN)="" D SCR D:FNC'["EX" ACOMPILE^ZAA02GFRME1 G BEG
 I J=8 D SAMPLE^ZAA02GFORMS G BEG
 I J=9 D REBUILD^ZAA02GFORMS G BEG
 I J=10 D SCHEMA G BEG
 I J=11 D ^ZAA02GFRMM1 G BEG
 ;
EXIT W ZAA02G("F") X ^ZAA02G("TERM-OFF"),^ZAA02G("WRAP-ON") Q
 ;
HEAD W ZAA02G("F"),ZAA02G("Z") S %R=1,%C=2 W ZAA02G("LO"),@ZAA02GP,ZAA02G("RON")," P ",ZAA02G("RT")," G ",ZAA02G("RT")," & ",ZAA02G("RT")," A " S %C=26 W @ZAA02GP,ZAA02G("ROF"),ZAA02G("HI"),"F O R M   M A N A G E M E N T",ZAA02G("LO")
 S %C=65 W @ZAA02GP,ZAA02G("RON"),"    ZAA02G-FORM    ",ZAA02G("ROF"),ZAA02G("G1"),! S J=ZAA02G("HL"),J=J_J_J_J F I=1:1:20 W J
 S %R=3,%C=8 W ZAA02G("G0"),@ZAA02GP,ZAA02G("LO"),"Version ",$P($T(ZAA02GFORME),",",3),"  ",$P($T(ZAA02GFORME+1),";",2,99)
 Q
 ;
LIST S %R=3,%C=1 W @ZAA02GP,ZAA02G("CS"),ZAA02G("HI") S %R=1,%C=26 W @ZAA02GP,"  C U R R E N T   F O R M S  " S %R=5,A=99,B="",%C=1
 I $O(^ZAA02GDISP(99))="" S %R=12,%C=30 W @ZAA02GP,"( Directory Empty )",!!! R C Q
 S Y="3,3\LRHGS\1\\Series        #    Description                                Updated ",Y(0)="\EX\^ZAA02GDISP\$P(X,""|"");10~$P(X,""|"",2);3R~$P(^ZAA02GDISP($P(X,""|""),$P(X,""|"",2)),""`"",4);40~$$LCD^ZAA02GFORME;8\99"
 S ZAA02GPOPALT=$P($T(LISTX),";",2) D ^ZAA02GFORMP Q:X[";EX"  Q:X=""
 S SCR=$P(X,"|"),SN=$P(X,"|",2) D EDIT^ZAA02GFRME1 Q
LCD() N Y S K=^($P(X,"|",2))+306 Q:K<500 ""  S Y=4*K+3\1461,D=K*4+3-(1461*Y)+4\4,M=5*D-3\153,D=5*D-3-(153*M)+5\5,M=M+2,Y=M\12+Y+140,M=M#12+1,Y=Y*100+M*100+D Q $E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)
LISTX ;Q:X=""""  S S=$P(X,""|""),S1=$P(X,""|"",2) F jj=1:1 S:S1="""" S=$O(@TQN@(S)) S:S="""" X="""" S:S]TEN X=""""  Q:X=""""  S:$L(S) S1=$O(@TQN@(S,S1)) I $L(S1) S X=S_""|""_S1 Q
 ;
SEB S J=" Enter the"
SCR S X=$G(SCR),(%C,%R)=3,FNC="EX,HL" W @ZAA02GP,ZAA02G("CS") S %R=5,%C=2 W @ZAA02GP,ZAA02G("LO"),J," Form Series    ",ZAA02G("HI"),X S %C=28,LNG=10 X ^ZAA02GREAD I FNC'="HL" S SCR=X Q:X=""  I FNC="EX" S (SCR,SN)="" Q
 I X="?"!(FNC="HL") D SCR^ZAA02GFRMPOP S SCR=X Q:X=""  S %R=5,%C=28 W @ZAA02GP,ZAA02G("HI"),SCR,ZAA02G("CL")
 S %R=7,%C=2,X=$G(SN),FNC="EX,HL" W @ZAA02GP,ZAA02G("LO"),J," Form Number    ",ZAA02G("HI"),X S %C=28,LNG=10,PAT="X?.N!(X=""?"")" X ^ZAA02GREAD I FNC'="HL" G SCR:X="" I FNC="EX" S (SCR,SN)="" Q
 I X="?"!(FNC="HL") D SN^ZAA02GFRMPOP:$D(^ZAA02GDISP(SCR)) S:"?"[X X="" S %R=7,%C=28 W @ZAA02GP,ZAA02G("HI"),X G:X="" SCR
 S SN=X Q:J["Star"  Q:$D(^ZAA02GDISP(SCR,SN))
 S %R=9,%C=3 W @ZAA02GP,ZAA02G("LO"),"Form not found - Is this is a ",ZAA02G("HI"),"new ",ZAA02G("LO"),"screen (",ZAA02G("HI"),"Y or N",ZAA02G("LO"),") ",ZAA02G("HI")  R A#1 G:"Yy"'[A SCR Q
SEL F I=1:1:NE S X=$P(Y,"\",I),%R=I+TR W @ZAA02GP,ZAA02G("HI"),$E(X),"  ",ZAA02G("LO"),X
 S I=""
LEV S %R=24,%C=7 W @ZAA02GP,ZAA02G("LO"),"[ Type ",ZAA02G("HI"),"Letter",ZAA02G("LO")," or use ",ZAA02G("HI"),"ARROWS",ZAA02G("LO")," to move selector, ",ZAA02G("HI"),"RETURN",ZAA02G("LO")," to make selection ]" S %C=1,%R=TR+1 W @ZAA02GP,*13
 ;
ASK S J=1,%C=TC-4 X ^ZAA02G("ECHO-OFF")
A1 S %R=TR+J,X=$P(Y,"\",J) W @ZAA02GP,ZAA02G("HI"),"==> ",$E(X),"  ",X,@ZAA02GP,"==> "
A2 R C#1 X ZAA02G("T") S A=ZF I C'="" S:C?1L C=$C($A(C)-32) I L[C S J=$F(L,C)-1 D A3 G A1:^ZAA02G("MENU"),DONE
 I A=ZAA02G("UK") D A3 S J=$S(J>1:J-1,1:NE) G A1
 I C=" "!(A=ZAA02G("DK")) D A3 S J=$S(J<NE:J+1,1:1) G A1
 I ZF=$C(13) G DONE
 I ^ZAA02GDISP(95,ZAA02G,4)[ZF S ZF=$F(^(4),ZF) I $E(^(4),ZF,ZF+1)="E4" S J=0 Q
 G A2
A3 W $C(8,8,8,8),"    ",ZAA02G("HI"),$E(X),ZAA02G("LO"),"  ",X Q
DONE K TR,TC,Y,L,X,C X ^ZAA02G("ECHO-ON") Q
 ;
INIT W !,"Create the ZAA02G-FORM Sampler? " R x I "YESYesyes"[x G ^ZAA02GFORMS
 Q
 ;
SCHEMA G ^ZAA02GFRMSCA
