ZAA02GFRME4 ;PG&A,ZAA02G-FORM,2.62,FORMS EDITOR, PART 5;13FEB94  08:03
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
EDIT D INIT
DISP S A=" Form Attributes" W:'$d(qt) ZAA02G("F") D HEAD S EC=30,NE=15,%R=3,%C=35 W:'$d(qt) @ZAA02GP,"(Title is the only required field)"
 S ST=$S($D(^ZAA02GDISP(SCR,SN)):^(SN),1:"") I ST>0 S X=+ST,ln=8 D CAL1^ZAA02GFORMD S %R=1,%C=40 W:'$d(qt) @ZAA02GP,ZAA02G("LO"),"Last Edited: ",ZAA02G("HI"),X
 S %C=2 D E0^ZAA02GFRME5 S:$D(ST) ^ZAA02GDISP(SCR,SN)=ST K EC,NE,LL,SD,DD,HD Q
INIT S LL="40,6,3,1,1,40,40,40,40,40,1,1,1,8,6",DD="5,7,8,9,10,12,13,14,15,16,18,19,20,21,22",T=^ZAA02G("TERMST")_" S ZC=$A(ZF)",SD="4,10,12,11,5,2,15,19,16,17,13,14,7,18,6",HELP="^ZAA02GFRMEA2"
 S HD="Title;Data Video Attributes;Edit Video Attributes;Edit Position;132 Column Display (Y/N);Extra Display Code;Pre-Edit Code;Post-Edit Code;Pre-Filing Code;Post-Filing Code;Full Window Display (Y/N);*"
 S HD1=";;;;;;;;;;;Conserve Symbol Space (Y/N);Real Time Database Update (Y/N);MUMPS Display Routine;Screen Timeout"
 Q
 ;
HEAD S (%R,%C)=1 W:'$d(qt) @ZAA02GP,ZAA02G("HI"),A,ZAA02G("LO")," ( ? for HELP )" S %R=1,%C=74-$L(SCR_SN) W:'$d(qt) @ZAA02GP,"Form: ",ZAA02G("HI"),SCR,"-",SN S %R=2,%C=1 W:'$d(qt) @ZAA02GP,ZAA02G("LO"),ZAA02G("G1") S J=ZAA02G("HL"),J=J_J_J_J F I=1:1:20 W:'$d(qt) J
 W:'$d(qt) ZAA02G("G0") Q
 ;
WINDOW K WI S LL="6,4,4",DD="10,12,14",T=^ZAA02G("TERMST")_" S ZC=$A(ZF)",SD="7,8,9"
 S HD="Top Left Coordinates (Row,Column);Number of Rows;Number of Columns"
DIS S (CS,RS)=1,CE=ZAA02G("C"),RE=22 Q  ;removed the following from edit
 S A="   Window Parameters" W:'$d(qt) ZAA02G("F") D HEAD S %R=5,%C=16 W:'$d(qt) @ZAA02G("P"),ZAA02G("HI"),"To activate Windowing option - Enter Window Size" S EC=40,NE=3
 S ST="" S:$D(^ZAA02GDISP(SCR,SN)) ST=^(SN) D ^ZAA02GFRME5
 S (CS,RS)=1,CE=ZAA02G("C"),RE=22,^ZAA02GDISP(SCR,SN)=ST I $P(ST,"`",7)'="" S WI="X",I=$P(ST,"`",7),RS=+I,CS=$P(I,",",2),RE=RS+$P(ST,"`",8)-1,CE=CS+$P(ST,"`",9)-1
 K ST,EC,NE,LL,SD,DD,HD Q
 ;
