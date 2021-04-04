%ZAA02GEDH13
	F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
	W "." G ^ZAA02GEDH14
D Q
	;;1480,1,23;line and may also span multiple lines. ;
	;;1480,1,24;
	;;1480,1,25;~(Step 4)~.  Complete the selection of text to be moved by
	;;1480,1,26;pressing the COPY/MOVE key again.  Note that the text to be
	;;1480,1,27;moved is removed immediately upon completing the selection. ;
	;;1480,1,28;However, it is still possible to cancel the move operation
	;;1480,1,29;by pressing the EXIT key.  Any text removed will be replaced
	;;1480,1,30;before you are returned to edit mode. ;
	;;1480,1,31;
	;;1480,1,32;~(Step 5)~.  Move the cursor to location at which the text is
	;;1480,1,33;to be inserted and complete the move operation by pressing
	;;1480,1,34;the COPY/MOVE function key once more.  The selected text
	;;1480,1,35;will be inserted at the indicated position, the screen
	;;1480,1,36;refreshed and you will be returned to edit mode. ;
	;;1500;Recall Text||28
	;;1500,0,"Save Text";1510
	;;1500,1,1;The Recall Text function is available from the COPY/MOVE
	;;1500,1,2;menu.  The COPY/MOVE function key is:  ~<{CP}>~
	;;1500,1,3;
	;;1500,1,4;The Recall Text function is provided to enable text to be
	;;1500,1,5;recalled from the AA UTILS Code Library and inserted at a
	;;1500,1,6;specified location in the current routine.  Text is added
	;;1500,1,7;to the code library using the ~<Save Text>~ function. ;
	;;1500,1,8;
	;;1500,1,9;~(Step 1)~.  Press the COPY/MOVE function key and select RECALL
	;;1500,1,10;from the COPY/MOVE menu. ;
	;;1500,1,11;
	;;1500,1,12;~(Step 2)~.  When asked 'Recall From: ', enter the name given
	;;1500,1,13;the desired text when it was saved to the code library.  If
	;;1500,1,14;you press the HELP key, a window will appear containing the
	;;1500,1,15;names of current entries in the Code Library.  If the name
	;;1500,1,16;you enter is not found in the library the same window will
	;;1500,1,17;appear listing the names of entries which begin with the
	;;1500,1,18;characters you entered.  Find and select the desired name
	;;1500,1,19;or press EXIT to look again. ;
	;;1500,1,20;
	;;1500,1,21;~(Step 3)~.  Move the cursor to the location in the current
	;;1500,1,22;routine at which the recalled text should be inserted.  Of
	;;1500,1,23;course you may abort the recall operation at this time by
	;;1500,1,24;pressing the EXIT key.  Otherwise, press the COPY/MOVE key
	;;1500,1,25;once more to complete the operation. ;
	;;1500,1,26;
	;;1500,1,27;The selected text will be inserted, the screen refreshed,
	;;1500,1,28;and you will be returned to edit mode. ;
	;;1510;Save Text||26
	;;1510,0,"Discard Text";1350
	;;1510,0,"Recall Text";1500
	;;1510,1,1;The Save Text function is available from the COPY/MOVE
	;;1510,1,2;menu.  The COPY/MOVE function key is ~<{CP}>~. ;
	;;1510,1,3;
	;;1510,1,4;The Save Text function is used to add portions of text,
	;;1510,1,5;usually source code and accompanying comments, to the
	;;1510,1,6;AA UTILS Code Library.  As it is saved, each such portion of
	;;1510,1,7;text is given a name with which it can be recalled later
	;;1510,1,8;for insertion into other routines using the ~<Recall Text>~
	;;1510,1,9;function.  The name is also used to subsequently remove the
	;;1510,1,10;text from the code library using the ~<Discard Text>~ Function. ;
	;;1510,1,11;
	;;1510,1,12;~(Step 1)~.  Position cursor at the beginning of the text to be
	;;1510,1,13;saved, press the COPY/MOVE key, and select SAVE from the
	;
	;