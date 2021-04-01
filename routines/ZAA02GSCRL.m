ZAA02GSCRL ;PG&A,ZAA02G-SCRIPT,2.10,LETTERS MODULE  ;;;;21JAN98  16:24
 ;Copyright (C) 1998, Patterson, Gray & Associates, Inc.
CTL S J=99 D INIT I '$D(LIST) G END
 S tr=5 D LIST G:J=99 CTL I LIST]"" D DOC I DOC]"" D PRP^ZAA02GSCRER2 K Y I DV]"" G CTL1
 G END
CTL1 S COPY=2,CP=2,Y("DOC")=DOC,Y("ZAA02GSCR")=ZAA02GSCR,DOC=ZAA02GSCR_"("""_DIR_""","""_DOC_""")",CP=2,Y("XECUTE")="D PRINT^ZAA02GSCRMS1"
 D PRNT^ZAA02GSCRSP
END D EXIT Q
 ;
INIT S Y="\L E T T E R S   M O D U L E\List\Starting List at\just press RETURN for beginning or enter new starting point\End List at\just press RETURN for end or enter new ending point"
 S L="Type\Number\or use\ARROWS\to move selector -\RETURN\to make selection\\\"
 S %R=3,%C=1,CR=25,LIST="" W @ZAA02GP,ZAA02G("HI"),ZAA02G("CS") S %R=1,%C=21 W @ZAA02GP,$J("",40) S %C=84-$L($P(Y,"\",2))\2 W @ZAA02GP,$P(Y,"\",2)
 K C S %R=5,%C=CR,C=1
 S A="" F I=1:1:ZAA02G("R")-2 S A=$O(^ZAA02GWPLIST(A)) Q:A=""  S C(C)=ZAA02G("HI")_$J(C,2)_ZAA02G("LO")_"  "_^(A),B(C)=A W @ZAA02GP,C(C) S C=C+1,%R=%R+1
 S NE=C,A=ZAA02G("HI")_" Q"_ZAA02G("LO")_"  Quit",(C(C),C("Q"))=A W @ZAA02GP,C(C) Q
 S NE=C-1 Q
 ;
LIST S HP=6 D LEV Q:J=99  I J=NE Q
 S LIST=B(J) K B S %R=3,%C=21 W @ZAA02GP,ZAA02G("CS"),ZAA02G("LO"),$P(Y,"\",3),": ",ZAA02G("HI"),LIST,"   ",^ZAA02GWPLIST(LIST)
 I $D(^(LIST,"NEXT"))=0 S LIST="" Q
 S STRT="" X ^("NEXT") S X=$P(STRT,"/")
 S %C=36-$L($P(Y,"\",4)),%R=tr,RX=0 W @ZAA02GP,ZAA02G("LO"),$P(Y,"\",4)," - ",ZAA02G("HI"),X,!!!!?8,$P(Y,"\",5)
 S %C=39,LNG=35 X ^ZAA02GREAD G LIST:RX=1!(RX=4) I X'="" S X=$S(+X=X:X-.00000001,1:$E(X,1,$L(X)-1)_$C($A(X,$L(X))-1,126))
 S LIST=LIST_","_X K STRT
 S B=$P($P(^ZAA02GWPLIST(+LIST,"NEXT"),"$O(",2),")") I B="" Q
 S STRT="",B=B_")",STRT=$O(@B,-1) Q:STRT=""
 S tr=tr+2,%C=36-$L($P(Y,"\",6)),%R=tr,X=STRT,RX=0 W @ZAA02GP,ZAA02G("CS"),ZAA02G("LO"),$P(Y,"\",6)," - ",ZAA02G("HI"),X,!!!!?8,$P(Y,"\",7)
 S %C=39,LNG=35 X ^ZAA02GREAD G LIST:RX=1!(RX=4) I X'="" S X=$S(+X=X:X-.00000001,1:$E(X,1,$L(X)-1)_$C($A(X,$L(X))-1,126))
 S LIST=LIST_"/"_X Q
 ;
LEV S %R=24,%C=5 W @ZAA02GP,ZAA02G("LO"),"[ Type ",ZAA02G("HI"),"Number",ZAA02G("LO")," or use ",ZAA02G("HI"),"ARROWS",ZAA02G("LO")," to move selector, ",ZAA02G("HI"),"RETURN",ZAA02G("LO")," to make selection ]" S %C=1,%R=5 W @ZAA02GP,*13
 ;
ASK S J=1,%C=CR-3,POS=ZAA02G("RT")_ZAA02G("RT")_ZAA02G("RT")_ZAA02G("RT") X ZAA02G("ECHO-OFF")
A1 S %R=4+J,X=C(J) W @ZAA02GP,ZAA02G("HI"),"==>",C(J),@ZAA02GP,POS
A2 R C#1 X ZAA02G("T") S A=ZF I C'="" S:C?1L C=$C($A(C)-32) S:C="Q" C=NE I $D(C(C)) D A3 S J=C G A1:ZAA02G("MENU"),DONE
 I A=ZAA02G("UK") D A3 S J=$S(J>1:J-1,1:NE) G A1
 I C=" "!(A=ZAA02G("DK")) D A3 S J=$S(J<NE:J+1,1:1) G A1
 I ZF=$C(13) G DONE
 G:XX'[A A2 S C=$E(XX,$F(XX,A)) I C="E" S J=NE G DONE
 I C="Y" D HELP^ZAA02GWPV9 S J=99 G DONE
 G A2
A3 W $C(8,8,8,8),"   ",ZAA02G("HI"),C(J) Q
DONE K C,L,X,POS X ZAA02G("ECHO-ON") Q
 ;
DOC S tr=tr+2,%R=tr,%C=1 W @ZAA02GP,ZAA02G("CS")
 S DIR=106,tc=17 D REPN^ZAA02GSCRRD S DOC=X,%R=tr,%C=tcc W @ZAA02GP,X
 K tr,tc,tcc Q
 ;
PRINT D LSTENTRY^ZAA02GWPP8
 Q
 ;
EXIT K C,A,LIST,STRT,RX,B,tr,tc Q
 ;         
