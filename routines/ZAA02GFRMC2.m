ZAA02GFRMC2 ;PG&A,ZAA02G-FORM,2.62,Copy/Recompile SCREEN Dialogue;23MAR94 10:56A
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;CALLED BY ^ZAA02GFRMC, RETURNS copy IF SUCCESSFUL (copy=SCRF_";"_SCRT, copy(SNF)=SNT, copy("ALL")="ALL" IF ALL SCREENS)
 ;
CTL NEW SCRF,SCRT,SNF,SNT K copy
 D PAINT
 D ASK
 I 14'[RX,SCRF]"" D SET
 Q
 ;
PAINT S %R=3,%C=1 W:'$D(qt) @ZAA02GP,ZAA02G("CS")
 W:'$D(qt) ZAA02G("LO") F x="Copy from Screen","Copy from Number","Copy to Screen","Copy to Number" W !!,$J(x,18)
 S %C=20 W:'$D(qt) ZAA02G("HI")
 F x="SCR","SN" S %R=%R+2 I $D(@x) W:'$D(qt) @ZAA02GP,@x S @(x_"F")=@x
 Q
 ;
ASK S ask="SCRF;SNF;SCRT;SNT"
 F aski=1:1:$L(ask,";") D ASKER Q:aski<0
 Q
 ;
ASKER S %R=aski*2+3,ques=$P(ask,";",aski),X=$S($D(@ques):@ques,1:""),(PROMPT,RX)="" D @ques
 I RX=1!(RX=4)!(@ques="") S aski=aski-2
 Q
 ;
SCRF S LNG=10 X ^ZAA02GREAD S (SCR,SCRF)=X
 I SCRF]"",14'[RX,'$D(^ZAA02GDISP(SCRF)) S %C=20+10+2 W *7,@ZAA02GP,ZAA02G("RON")," Series Does Not Exist.  Press Return. ",ZAA02G("ROF") R *x W:'$D(qt) @ZAA02GP,ZAA02G("CL") S %C=20 G SCRF
 Q
 ;
SNF S LNG=10 X ^ZAA02GREAD S (SN,SNF)=X Q:SNF="ALL"
 I SNF]"",14'[RX,'$D(^ZAA02GDISP(SCRF,SNF)) S %C=20+10+2 W *7,@ZAA02GP,ZAA02G("RON")," Screen Does Not Exist.  Press Return. ",ZAA02G("ROF") R *x W:'$D(qt) @ZAA02GP,ZAA02G("CL") S %C=20 G SNF
 Q
 ;
SCRT S LNG=10 X ^ZAA02GREAD S SCRT=X
 I SNF="ALL",SCRT]"",14'[RX,$D(^ZAA02GDISP(SCRT)) S %R=21,%C=6 W *7,@ZAA02GP,ZAA02G("RON")," Copying ALL screens to existing series not allowed.  Press Return. ",ZAA02G("ROF") R *x W:'$D(qt) @ZAA02GP,ZAA02G("CL") S %C=20,%R=aski*2+3 G SCRT
 ; I SCRT]"",14'[RX,$D(^ZAA02GDISP(SCRT)) S %C=20+10+2 W *7,ZAA02G("RON"),@ZAA02GP," Screen series already exists.  Continue? ",ZAA02G("ROF") S CHR="YyNn",X="N",%C=%C+43,PROMPT="",LNG=1 X ^ZAA02GREAD S %C=20+10+2 W:'$D(qt) @ZAA02GP,ZAA02G("CL") S %C=20 I "Nn"[X S X=SCRT G SCRT
 Q
 ;
SNT I SNF="ALL" S SNT="ALL",RX=2 W:'$D(qt) @ZAA02GP,SNT Q
 S LNG=10 X ^ZAA02GREAD S SNT=X
 Q
 ;
SET S %R=21,%C=34 W:'$D(qt) @ZAA02GP,ZAA02G("RON")," Please Wait ",ZAA02G("ROF")
 S copy=SCRF_";"_SCRT,copy(SNF)=SNT
 Q
