%ZAA02GEDH05
	F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
	W "." G ^ZAA02GEDH06
D Q
	;;1220,1,9;routine you're saving. ;
	;;1220,1,10;
	;;1220,1,11;To save the routine as named, simply press [RETURN]. ;
	;;1220,1,12;
	;;1220,1,13;However, you may also save the routine under a new name. ;
	;;1220,1,14;To do so, enter the new name and press [RETURN].  Notice
	;;1220,1,15;that the routine in your workspace is also renamed at the
	;;1220,1,16;same time. ;
	;;1220,1,17;
	;;1220,1,18;If for any reason you wish to abort before saving, press
	;;1220,1,19;the {EX} key before pressing [RETURN]. ;
	;;1220,1,20;
	;;1220,1,21;When the save is completed, you will be returned to the
	;;1220,1,22;Function menu. ;
	;;1230;Compiling A Routine||9
	;;1230,1,1;The Compilation function strips blank lines and internal
	;;1230,1,2;comments from a routine and exports the resulting routine
	;;1230,1,3;to MUMPS where it can be executed.  In implementations of
	;;1230,1,4;MUMPS where compilation to pseudo-code is required, this
	;;1230,1,5;step will be done at the same time. ;
	;;1230,1,6;
	;;1230,1,7;To compile the current routine, exit the Routine Editor and
	;;1230,1,8;select ~<COMPILE>~.  The routine will be compiled immediately
	;;1230,1,9;and you will be returned to the Function menu. ;
	;;1240;Looking Up Routines||38
	;;1240,1,1;If you're not sure of the name of the routine you're look-
	;;1240,1,2;ing for, enter as many characters of the name as you know
	;;1240,1,3;followed by a question mark. ;
	;;1240,1,4;
	;;1240,1,5;  Example:  ~<ZAA02G?>~       ...will look for routines that begin
	;;1240,1,6;                         with the letters "ZAA02G". ;
	;;1240,1,7;
	;;1240,1,8;Next, you'll be asked which source to search.  Your options
	;;1240,1,9;will include ~<workfile,>~ ~<archive>~ and ~<MUMPS>~. ;
	;;1240,1,10;
	;;1240,1,11;Select the source in which you expect to find the routine. ;
	;;1240,1,12;Generally speaking, if you're looking for the most current
	;;1240,1,13;copy, search the workfile first, the archive next, and
	;;1240,1,14;MUMPS last. ;
	;;1240,1,15;
	;;1240,1,16;When you have selected the source, AA UTILS will display a
	;;1240,1,17;list of the routines in that source that begin with the
	;;1240,1,18;characters you typed before the question mark.  If you have
	;;1240,1,19;displayed routines from the workfile or archive, the
	;;1240,1,20;approximate size, date last modified and description will
	;;1240,1,21;be displayed next to each routine name.  If from MUMPS, the
	;;1240,1,22;contents of the first line of the routine, if any, will be
	;;1240,1,23;displayed. ;
	;;1240,1,24;
	;;1240,1,25;If the list is too long to be displayed on one page, you
	;;1240,1,26;can use the ~<{PD}>~ and/or ~<{PU}>~ keys to page back
	;;1240,1,27;and forth throughout the list. ;
	;;1240,1,28;
	;;1240,1,29;If the list does not contain the routine you are looking
	;;1240,1,30;for, press ~<{EX}>~ and try again, this time with fewer char-
	;;1240,1,31;acters. ;
	;;1240,1,32;
	;;1240,1,33;If you find the routine, move the selector '=>' to the line
	;;1240,1,34;on which the desired routine is displayed using the cursor
	;;1240,1,35;UP and DOWN keys.  You can also use the [SPACE] key in
	;;1240,1,36;place of the cursor DOWN key.  Press [RETURN] and the
	;;1240,1,37;routine will be quickly loaded and displayed for you and
	;;1240,1,38;the cursor placed in the upper left corner of the routine. ;
	;;1300;Routine Conventions||59
	;
	;