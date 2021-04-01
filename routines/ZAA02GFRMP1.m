ZAA02GFRMP1 ;PG&A,ZAA02G-FORM,2.62,SUBROUTINE FOR ZAA02GFRMPS;24APR87 4:22P
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;DOES ACTUAL PRINTOUT OF FORM AND FIELD ATTRIBUTES
 ;NEEDS DV, FD, SCR, & SN
 ;
CTL D FORM
 D ORDER
 D CONT Q:"Nn"[X
 I FD'="All" D F1 I 1
 E  D ALL
 Q
 ;
FORM ;PRINT FORM DATA
 D INIT^ZAA02GFRME4
 S A="   Form Attributes",$P(A," ",45)="Form:  "_SCR_"-"_SN
 D HEAD
 S EC=35,NE=11,ST="" S:$D(^ZAA02GDISP(SCR,SN)) ST=^(SN)
 D PRINT
 Q
 ;
HEAD ;GENERAL PURPOSE HEADER
 S J="",$P(J,"_",81)=""
 W @$S(DV=0:"ZAA02G(""F"")",1:"#!!"),A,!,J,!
 Q
 ;
PRINT ;SELF-EXPLANATORY, WOULDN'T YOU SAY?
 S H=HD F I=1:1:NE S %C=4,A=$P(H,";",I) S:A="*" H=HD1,A=$P(H,";",I) W !?%C,A,$E("................................",1,EC-$L(A)) S %C=EC+5 W ?%C,$P(ST,"`",$P(SD,",",I)) I NE=18,I=4!(I=9)!(I=12) W !
 Q
 ;
ORDER ;PRINT FORM EDITING ORDER
 W !!?4,"Editing Order (data #s separated",!?7,"by commas - or XX:XX:XX)"
 S X="" S:$D(^ZAA02GDISP(SCR,SN,.02)) X=^(.02)
 W "........ ",$S(X'="":X,1:"Undefined"),!
 Q
 ;
F1 D @$S(FD[">":"INITG^ZAA02GFRME3B",1:"SET^ZAA02GFRME2"),F2 Q
 ;
ALL S FD=">" D INITG^ZAA02GFRME3B F I=0:0 S FD=$O(^ZAA02GDISP(SCR,SN,FD)) Q:FD'[">"  D F2
 D SET^ZAA02GFRME2 S FD=">~" F I=0:0 S FD=$O(^ZAA02GDISP(SCR,SN,FD)) Q:FD=""!("Nn"[X)  D F2
 Q
 ;
F2 ;CALLED BY FIELDS
 S ST=^ZAA02GDISP(SCR,SN,FD),R=$P(ST,"`",3),C=$P(R,",",2),R=+R,O=$P(ST,"`",14)
 I FD[">" S $P(ST,"`",3)=+$P(ST,",",2) ;r,c becomes c only
 S A="Field: "_FD_"   Position: "_$S(R&C:"R"_R_" C"_C,1:"NONE"_$C(7))_"   Editing Order: "_$S(O>99:$P(^(O\100),"`",11)_"-"_(O#100),O?.N&R&C:O,1:"NONE"_$C(7))_"   Form: "_SCR_"-"_SN D HEAD
 D PRINT
 D CONT
 Q
 ;
CONT ;ASK WHETHER TO CONTINUE IFF DV=0
 S X="Y" I DV=0 S %R=24,%C=60,PROMPT="Continue?  ",CHR="YNyn",LNG=1 X ^ZAA02GREAD
 Q
