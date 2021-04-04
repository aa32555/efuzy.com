%ZAA02GEDH09
	F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
	W "." G ^ZAA02GEDH10
D Q
	;;1360,1,10;you to review it.  To abort the erasure at this time, press
	;;1360,1,11;the EXIT key. ;
	;;1360,1,12;
	;;1360,1,13;~(Step 2)~.  To complete the erasure, press the ERASE TO EOL
	;;1360,1,14;key a second time.  The text will be removed, the screen
	;;1360,1,15;refreshed, and you will be returned to edit mode. ;
	;;1370;Find and Replace String||35
	;;1370,1,1;FIND & REPLACE STRING function key:  ~<{GO}>~
	;;1370,1,2;
	;;1370,1,3;This function finds all occurrences of a specified string
	;;1370,1,4;and replaces them with a second string in the current rou-
	;;1370,1,5;tine.  A verify option enables the function to process all
	;;1370,1,6;occurrences without interruption, or request verification
	;;1370,1,7;of each. ;
	;;1370,1,8;
	;;1370,1,9;~(Step 1)~.  Press the FIND function key.  A menu of FIND
	;;1370,1,10;options will be displayed; select REPLACE, or press EXIT to
	;;1370,1,11;abort. ;
	;;1370,1,12;
	;;1370,1,13;~(Step 2)~. When asked 'Replace String: ', enter the string to
	;;1370,1,14;be searched for and replaced followed by a [RETURN].  You
	;;1370,1,15;may also press EXIT to abort. ;
	;;1370,1,16;
	;;1370,1,17;~(Step 3)~.  When asked 'With String: ', enter the string to use
	;;1370,1,18;as a replacement, followed by a [RETURN].  A null value, or
	;;1370,1,19;empty string, is a valid response.  You may also press EXIT
	;;1370,1,20;to abort at this time. ;
	;;1370,1,21;
	;;1370,1,22;~(Step 4)~.  When asked whether you want to 'Verify each
	;;1370,1,23;replacement? ', answer by typing a [Y] for yes or a [N] for
	;;1370,1,24;no.  Complete your response by pressing [RETURN].  You may
	;;1370,1,25;also abort at this time by pressing EXIT. ;
	;;1370,1,26;
	;;1370,1,27;AA UTILS will begin its search for the first string on the
	;;1370,1,28;beginning line of the routine and will search each line. ;
	;;1370,1,29;If you requested the verify option, each line will be also
	;;1370,1,30;displayed as it goes and when the first string is found,
	;;1370,1,31;you will be asked to verify the change. ;
	;;1370,1,32;
	;;1370,1,33;When the last line of the routine has been searched, the
	;;1370,1,34;screen will be refreshed and you will be returned to edit
	;;1370,1,35;mode. ;
	;;1380;Find End-Of-Routine||15
	;;1380,1,1;The FIND EOR function is available from the FIND menu. ;
	;;1380,1,2;The FIND function key is:  ~<{GO}>~
	;;1380,1,3;
	;;1380,1,4;This function causes the cursor to jump to the end of the
	;;1380,1,5;routine currently in the workspace.  It is of particular
	;;1380,1,6;value when editing long routines, or routines with many
	;;1380,1,7;internal comments because it does not require use of the
	;;1380,1,8;NEXT SCREEN key. ;
	;;1380,1,9;
	;;1380,1,10;~(Step 1)~.  Press the FIND function key.  A menu of FIND
	;;1380,1,11;options will be displayed. ;
	;;1380,1,12;
	;;1380,1,13;~(Step 2)~.  Select END, or press EXIT to abort.  The end of
	;;1380,1,14;the routine will be found and displayed without further
	;;1380,1,15;action, and you will be left in edit mode. ;
	;;1390;Find Line||21
	;;1390,1,1;FIND LINE is available from the FIND menu. ;
	;;1390,1,2;The FIND function key is:  ~<{GO}>~
	;;1390,1,3;
	;;1390,1,4;This function searches the current routine for a line and
	;;1390,1,5;if found, displays the page of the routine on which the
	;;1390,1,6;line is found and moves the cursor to the line.  
	;;1390,1,7;
	;
	;