%ZAA02GEDH07
	F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
	W "." G ^ZAA02GEDH08
D Q
	;;1320,0,"wildcard";1240
	;;1320,1,1;COPY/MOVE Function key:  ~<{CP}>~
	;;1320,1,2;
	;;1320,1,3;The COPY function is used to copy text or code from one
	;;1320,1,4;location to another.  The source of the text can be the
	;;1320,1,5;current routine, or another routine.  Text can even be
	;;1320,1,6;copied from routines outside of AA UTILS, provided their
	;;1320,1,7;source code is available. ;
	;;1320,1,8;
	;;1320,1,9;~(Step 1)~.  If you want to copy from the current routine, move
	;;1320,1,10;the cursor to the beginning of the text to be copied and
	;;1320,1,11;press the COPY/MOVE key twice and proceed to Step 2. ;
	;;1320,1,12;
	;;1320,1,13;Otherwise, press the COPY/MOVE and type [C] or select COPY
	;;1320,1,14;from the COPY/MOVE menu.   Enter the name of the routine to
	;;1320,1,15;be copied from, or accept the current routine and press
	;;1320,1,16;[RETURN].  You may use the "?" ~<wildcard>~ to search the index
	;;1320,1,17;if you're not sure of the name. ;
	;;1320,1,18;
	;;1320,1,19;When the routine has been selected, you will be given a
	;;1320,1,20;choice of the source of the routine.  The list of possible
	;;1320,1,21;sources includes the WORKFILE, ARCHIVE, and MUMPS.  Select
	;;1320,1,22;the desired source and press [RETURN].  The routine will be
	;;1320,1,23;displayed to enable you to find and select the text to be
	;;1320,1,24;copied. ;
	;;1320,1,25;
	;;1320,1,26;Using the cursor movement keys, move the cursor to the
	;;1320,1,27;first character of the text to be copied and press the
	;;1320,1,28;COPY/MOVE key to begin marking.  If you are unable to find
	;;1320,1,29;the text, press the EXIT key to abort the copy operation
	;;1320,1,30;and try again.   
	;;1320,1,31;
	;;1320,1,32;~(Step 2)~.  Using your cursor movement keys, highlight the
	;;1320,1,33;text to be copied.  When completely highlighted (shown by
	;;1320,1,34;reversing the intensity of the selected text), press the
	;;1320,1,35;COPY/MOVE key once more.  If you copied from another
	;;1320,1,36;routine, the display will be refreshed with the current
	;;1320,1,37;routine. ;
	;;1320,1,38;
	;;1320,1,39;~(Step 3)~.  Now move the cursor to the location at which the
	;;1320,1,40;selected text is to be inserted, using the cursor movement
	;;1320,1,41;keys as before.  Press the COPY/MOVE key to insert the
	;;1320,1,42;selected text.  The screen will be refreshed, showing the
	;;1320,1,43;newly inserted text and you will be returned to normal edit
	;;1320,1,44;mode. ;
	;;1330;Cut Line||15
	;;1330,1,1;CUT LINE function key:  ~<{CT}>~
	;;1330,1,2;
	;;1330,1,3;AA UTILS will break one line of code into two at a desired
	;;1330,1,4;location using the CUT LINE function key.  Use caution,
	;;1330,1,5;there is no "undo" function.  However, lines which have
	;;1330,1,6;been broken can be rejoined using the JOIN LINE function. ;
	;;1330,1,7;
	;;1330,1,8;When the CUT LINE key is pressed, all characters from the
	;;1330,1,9;cursor to the end of the line are removed from the current
	;;1330,1,10;line and inserted as a new line immediately below. ;
	;;1330,1,11;
	;;1330,1,12;~(Step 1)~.  Move the cursor to the point where you want the
	;;1330,1,13;line to be broken and press CUT LINE.  The remainder of the
	;;1330,1,14;line will be immediately removed and inserted as a new line
	;;1330,1,15;in the routine and you returned to edit mode. ;
	;;1340;Delete Line||14
	;
	;