%ZAA02GEDH20
	F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
	W "." G ^ZAA02GEDH21
D Q
	;;2190,1,103;  selected.  Routines can be selected/deselected using the
	;;2190,1,104;  SELECT key which operates as a toggle.  Placement of the
	;;2190,1,105;  "?" within the routine request is not important and it can
	;;2190,1,106;  be used in conjunction with other wildcards.  
	;;2190,1,107;
	;;2190,1,108;
	;;2190,1,109;~<Device Selection>~.  Selecting the device for printing
	;;2190,1,110;listings and reports is the same for all output programs. ;
	;;2190,1,111;You will be asked for the device number and the margins to
	;;2190,1,112;use.  To make it easier, AA UTILS remembers the device you
	;;2190,1,113;last used and the last margin parameters you used for that
	;;2190,1,114;device.  Both are presented as defaults and can be accepted
	;;2190,1,115;by simply pressing [RETURN] for each field. ;
	;;2190,1,116;
	;;2190,1,117;~(Step 1)~.  ~(Output Device)~.  Enter the device number of the
	;;2190,1,118;desired printer and press [RETURN].  AA UTILS does not
	;;2190,1,119;maintain a device table with printer definitions and such. ;
	;;2190,1,120;As a result, AA UTILS will not be able to determine whether
	;;2190,1,121;you have selected correctly.  It is up to you to ensure
	;;2190,1,122;that the device number you enter is correct. ;
	;;2190,1,123;
	;;2190,1,124;~(Step 2)~.  ~(Margins)~.  Enter the Left and Right margins AA UTILS
	;;2190,1,125;should use for the listing or report separated by a slash
	;;2190,1,126;"/", followed by a [RETURN].  AA UTILS does not control the
	;;2190,1,127;pitch of your printer; it is necessary for you to prepare
	;;2190,1,128;the printer. ;
	;;2190,1,129;
	;;2190,1,130;If you do not enter a Left Margin, AA UTILS will assume
	;;2190,1,131;value of 1, and if you do not specify a Right Margin,
	;;2190,1,132;AA UTILS will assume a value of 80. ;
	;;2300;Global Utilities||5
	;;2300,0,"Copy Global";2310
	;;2300,0,"Edit Global";2320
	;;2300,0,"List Global";2330
	;;2300,1,1;AA UTILS provides the following utilities for maintaining
	;;2300,1,2;MUMPS Globals.  SELECT and OPEN the topic of interest to
	;;2300,1,3;you. ;
	;;2300,1,4;
	;;2300,1,5;      ~<Copy Global>~     ~<Edit Global>~     ~<List Global>~
	;;2310;Copy Global Utility||44
	;;2310,1,1;This utility copies all or portions of a global to another
	;;2310,1,2;global.  Subscript substitution, in which the original
	;;2310,1,3;subscript is replaced with another, can be used during the
	;;2310,1,4;copy, making it possible to copy nodes from one global to a
	;;2310,1,5;different location within the same global. ;
	;;2310,1,6;
	;;2310,1,7;The only restriction is that the data cannot be moved from
	;;2310,1,8;one level to another.  For example, if the data in the
	;;2310,1,9;global being copied is at the fourth level, it will be at
	;;2310,1,10;the fourth level of the destination global as well. ;
	;;2310,1,11;
	;;2310,1,12;~(Step 1)~.  From the Functions menu, select Utilities. ;
	;;2310,1,13;         From the Utilities menu, select Global. ;
	;;2310,1,14;         From the Global Utilities, select Copy. ;
	;;2310,1,15;
	;;2310,1,16;~(Step 2)~.  Select the global to be copied.  AA UTILS' global
	;;2310,1,17;copy utility provides several powerful features that will
	;;2310,1,18;help you copy as much or as little of the selected global
	;;2310,1,19;as you need.  The following examples, which can also be
	;
	;