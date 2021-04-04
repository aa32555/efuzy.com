ZAA02GINIT 
	D LINE W !,"PG&A Toolkit Initialization - Version ",$P($T(ZAA02GINIT),",",3),!,"Copyright (C) 1985,7,8 Patterson, Gray & Assoc., Inc.",!,"Schaumburg, IL  60173",! D LINE
	S B=$ZV,OS=$S(B["M3":9,B["DSM-1":3,B["DSM":7,B["MSM":6,B["M/S":4,B["DTM":5,B["V1.":1,B["ISM":4,B["Cache":4,B["Open M":4,B["UNIMP":4,B["<SYNTAX>":4,1:0)
	S B="^ZAA02GINIT1"_$E("ABCDEFGHI",OS) D @B
	W !!,"***> Initializing Code Portion of ^ZAA02GREAD" D ^ZAA02GREAD
	W !!,"***> Initializing Terminal Parameters",!!?4,"Please respond YES or NO to each of the following devices.  A YES"
	W !?4,"response will initialize device parameters, a NO or RETURN response will",!?4,"not.  The Toolkit Initialization can be run again to add further types.",!?4,"It is best to define only the types you are going to use.",!
	S ^ZAA02G="D:'$D(ZAA02G) INIT^ZAA02GDEV W:ZAA02G(""CSR"")]"""" @ZAA02G(""CSR"") S ZAA02G(1)=1 X ^ZAA02G(""TERM-OFF"") W:$L($P($G(^ZAA02G(.1,ZAA02G,7)),""\"",4)) @$P(^(7),""\"",4)"
	D:OS="DTM" ^ZAA02GINTD2 D:OS="MSM" ^ZAA02GINTM2
	D ^ZAA02GINT01,^ZAA02GINTVT,^ZAA02GINT02A,^ZAA02GINT13,^ZAA02GINT13C,^ZAA02GINT13D,^ZAA02GINT06,^ZAA02GINT18,^ZAA02GINT08,^ZAA02GINT16A,^ZAA02GINT16
	S ^ZAA02G("REST")="S ZAA02G(1)=1 X ^ZAA02G(""TERM-ON"")",^ZAA02G("MARGIN")=0 W !
X D LINE W !,"***> Menu Driver Option" S X=$S($D(^ZAA02G("MENU")):^("MENU"),1:0) W !!?5,"The PG&A Toolkit menu drivers provide the option of requiring that",!?5,"RETURN be pressed to complete a selection.  If you prefer either"
	W !?5,"mode, select it here.  Currently, RETURN is ",$S(X:"",1:"NOT "),"required.",!!?5,"Require RETURN at Toolkit Menus? > "
	R A#5 S:A="" A=$E("NY",X+1) S ^ZAA02G("MENU")="Yy"[A W "...RETURN ",$S(^("MENU"):"Required",1:"Not Required"),!
	D LINE W !,"***> Use of $I in a Network" S X=$S($D(^ZAA02G("$I")):1,1:0) W !!?5,"If your system is using a local area network, the value of $I may not",!?5,"reflect the same device at every logon.  If that is the case, the ZAA02G"
	W !?5,"routines will need to use alternate means for determining device types.",!?5,"Enter ""Y"" if your $I values are inconsistent.  Current definition is ",$S($D(^ZAA02G("$I")):"Y",1:"N"),!!?5,"Inconsistent $I values (Y or N)? > "
	R A#5 I A'="","Yy"[A S ^ZAA02G("$I")=""
	E  I A'="" K ^ZAA02G("$I")
	W ! D LINE W !,"***> Date Format" S X=$S($D(^ZAA02G("DATEF")):^("DATEF"),1:0) W !!?5,"What format is to be used for dates, US or International.",!
	W ?5,"The current definition is ",$S('$D(^ZAA02G("DATEF")):"US",^("DATEF"):"International",1:"US"),!!?5,"Enter U or I > "
	R A#1 I A'="","UIui"[A S ^ZAA02G("DATEF")=$S("Uu"[A:0,1:1) W $S(^("DATEF"):"nternational",1:"S")
	W ! D LINE W !,"PG&A Toolkit Initialization completed",!! G GETPARM^ZAA02GINIT2
	;
LINE F J=1:1:19 W "----"
	Q
COPY R "From Device-",DV,!,"To Device-",DV1,! S A="" F J=1:1 S A=$O(^ZAA02G(0,DV,A)) Q:A=""  S ^ZAA02G(0,DV1,A)=^(A)
	F J=1:1 S A=$O(^ZAA02G(.1,DV,A)) Q:A=""  S ^ZAA02G(.1,DV1,A)=^(A)
	S ^ZAA02G(.3,DV1,0)=^ZAA02G(.3,DV,0) W "done",! Q
	;
PRESET S OS="M3" D ^ZAA02GINIT1I,^ZAA02GREAD S T="VT220" D ENT^ZAA02GINTVT S ^ZAA02G("MENU")=0,^ZAA02G("MARGIN")=0 M ^%T=^ZAA02G
	S GN="^%ZAA02GEDHLP" W !?8,"Initializing AA UTILS" D ^%ZAA02GEDH01,SETUP^%ZAA02GEDIN1,SETUP^%ZAA02GEDIN2
	S ^%ZAA02GED="X ^%ZAA02GED(""ED"") Q  ;^ZAA02GEDE`^ZAA02GEDU`^ZAA02GEDW`^ZAA02GEDL`^ZAA02GEDA`^ZAA02GEDP`^ZAA02GEDR`1"
	W !?8,"Initializing ZAA02G-SQL" D INIT^ZAA02GSQL2
	Q
	;
	;