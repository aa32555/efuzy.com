ZAA02GFRMD ;PG&A,ZAA02G-FORM,2.62,DELETE FIELD or SCREEN;17MAR94  23:09
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
CTL K (qt,FD,SCR,SN,ZAA02G,ZAA02GP,ZAA02GID,ZID)
 D PAINT
 D ASK
 I 14'[RX,SCR]"","N"'=CON D @$S("ALL,All"[FD:"DELS",1:"DELF")
 K (qt,FD,SCR,SN,ZAA02G,ZAA02GP,ZAA02GID,ZID) Q
 ;
PAINT S %R=3,%C=1 W:'$D(qt) @ZAA02GP,ZAA02G("CS"),ZAA02G("LO")
 F x="Screen Series","Screen Number","Delete Field (or ALL)","Press ""Y"" to Confirm" W !!,$J(x,20)
 S %R=5,%C=23,CON="N"
 W:'$D(qt) ZAA02G("HI") F x="SCR","SN","FD","CON" W:$D(@x) @ZAA02GP,@x S %R=%R+2
 Q
 ;
ASK S ask="SCR;SN;FD;CON"
 F aski=1:1:$L(ask,";") D ASKER Q:aski<0
 Q
 ;
ASKER S %R=aski*2+3,ques=$P(ask,";",aski),X=$S($D(@ques):@ques,1:""),(PROMPT,RX)="" D @ques
 I RX=1!(RX=4)!(@ques="") S aski=aski-2
 Q
 ;
SCR ;GET SERIES (SCR)
 S LNG=10 D READ S SCR=X Q:SCR']""!(14[RX)
 I X?1"?".E D SCR^ZAA02GFRMPOP S SCR=X W:'$D(qt) @ZAA02GP,ZAA02G("CL"),SCR G SCR:X=""
 I '$D(^ZAA02GDISP(SCR)) S Y(1)="Series does not exist.*",Y(2)="Enter ""?"" for list.*",N=3 D ERROR G SCR
 Q
 ;
SN ;GET SCREEN NUMBER (SN)
 S LNG=10 D READ S SN=X Q:SN']""!(14[RX)
 I X?1"?".E D SN^ZAA02GFRMPOP S SN=X W:'$D(qt) @ZAA02GP,ZAA02G("CL"),SN G SN:X=""
 I '$D(^ZAA02GDISP(SCR,SN)) S Y(1)="Screen does not exist.*",Y(2)="Enter ""?"" for list.*",N=3 D ERROR G SN
 S name=$P(^(SN),"`",4) I name'="" S %C=%C+5 W:'$D(qt) @ZAA02GP,"(",name,")" S %C=%C-5
 Q
 ;
FD ;GET FIELD (FD), ALL FOR ENTIRE SCREEN
 S LNG=10 D READ S FD=X Q:FD']""!(14[RX)!(FD="ALL")!(FD="All")
 I X?1"?".E S %R=6 D FD^ZAA02GFRMPOP S FD=X,%R=9 W:'$D(qt) @ZAA02GP,ZAA02G("CL"),FD G FD:X="" Q:FD="All"
 I '$D(^ZAA02GDISP(SCR,SN,FD)) S Y(1)="Field does not exist.*",Y(2)="Enter ""?"" for list.*",N=3 D ERROR G FD
 S row=$P(^(FD),"`",3),col=$P(row,",",2),row=+row
 I FD'[">",row!col S Y(1)="This field's position is defined.  Use*",Y(2)="Build Screen Format to space over the*",Y(3)="field identifier, then use this option.*",N=4 D ERROR G FD
 Q
 ;
CON ;CONFIRM DELETION (CON="Y")
 S LNG=1,CHR="NnYy" D READ S CON=X Q:14[RX
 I "Nn"[CON S CON="N",Y(1)="Deletion canceled.*",N=2 D ERROR
 Q
 ;
READ S FNC="EX" X ^ZAA02GREAD S:$G(FNC)="EX" RX=1 Q
 ;
DELF ;DELETE SINGLE FIELD
 I FD[">" S scope=^ZAA02GDISP(SCR,SN,FD,0)
 K ^ZAA02GDISP(SCR,SN,FD) I $E(FD)="^" K ^ZAA02GSCHEMA(0,$E(FD,2,99),SCR_"-"_SN)
 S %C=10,%R=%R+5 W:'$D(qt) @ZAA02GP,ZAA02G("HI")," Field ",FD," from ",name," deleted."
 I FD[">" W !,?10,"Since this was a group, the form,",!,?10,"will be automatically rebuilt."
 W !,?10,"Press return. ",ZAA02G("Z") R *x
 I FD[">" D GSF S ACOMPILE="ED2" D AC^ZAA02GFRME1
 S FD="" Q
 ;
GSF ;GROUP SCOPE FIX
 S a=">" W ! F i=0:0 S a=$O(^ZAA02GDISP(SCR,SN,a)) Q:a=""  I ^(a,0)=FD S ^(0)=scope,i=i+1 W $J(a,15)
 Q:'i  W !,?10,"The fields listed above were in the scope of the group you deleted."
 W !,?10,"They now have the group's old scope of ",scope
 W !,?10,"Press RETURN to continue to the recompile."
 Q
DELS ;DELETE ENTIRE SCREEN
 S FD="^" F i=0:0 S FD=$O(^ZAA02GDISP(SCR,SN,FD)) Q:FD'["^"  K ^ZAA02GSCHEMA(0,$E(FD,2,99),SCR_"-"_SN)
 K ^ZAA02GDISP(SCR,SN),^ZAA02GDISPL(SCR_"-"_SN)
 S %C=11,%R=%R+5,FD="" W:'$D(qt) @ZAA02GP,ZAA02G("RON")," ",SCR,"-",SN," ",name," deleted.  Press return. ",ZAA02G("ROF") R *x
 Q
 ;
ERROR ;ERROR MESSAGES
 S Y=23+10+2_","_%R_"\RY\1",Y(N)="*",Y(N+1)="Press return.",Y(0)=N+1
 N X S r0=%R D UTIL^ZAA02GFORM4 S %C=23,%R=r0 K Y
 Q
