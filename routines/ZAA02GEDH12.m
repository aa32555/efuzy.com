%ZAA02GEDH12
	F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
	W "." G ^ZAA02GEDH13
D Q
	;;1440,1,29;end of the current row, a new blank row will be added auto-
	;;1440,1,30;matically and the cursor wrapped to the new row.  In add-
	;;1440,1,31;ition, you can use the BACKSPACE or RUBOUT key to correct
	;;1440,1,32;inserted characters without leaving insert mode. ;
	;;1440,1,33;
	;;1440,1,34;~(Step 3)~.  When the desired text has been entered, press the
	;;1440,1,35;[RETURN] key to reassemble the current line.  The screen
	;;1440,1,36;will be refreshed and you will be returned to edit mode. ;
	;;1450;Join Lines||11
	;;1450,1,1;JOIN LINE function key:  ~<{DO}>~
	;;1450,1,2;
	;;1450,1,3;This function joins two consecutive lines together into a
	;;1450,1,4;single line of text or code.  When the key is pressed, the
	;;1450,1,5;line immediately following the current line is moved up and
	;;1450,1,6;joined to the end of the current line.  
	;;1450,1,7;
	;;1450,1,8;~(Step 1)~.  Position the cursor anywhere on the first of the
	;;1450,1,9;two lines to be joined and press the JOIN LINE function
	;;1450,1,10;key.  The next line will be immediately joined to the end
	;;1450,1,11;of the first and you will be returned to edit mode. ;
	;;1460;Jump to Beginning-Of-Line||10
	;;1460,1,1;JUMP TO BOL function key:  ~<{GW}>~
	;;1460,1,2;
	;;1460,1,3;This function moves the cursor to the first cursor position
	;;1460,1,4;of the current row.  If the cursor is on a row which is a
	;;1460,1,5;continuation from the previous row, the first cursor
	;;1460,1,6;position will be two characters to the right of the first
	;;1460,1,7;TAB stop.  Otherwise, the cursor will jump to the leftmost
	;;1460,1,8;column. ;
	;;1460,1,9;
	;;1460,1,10;~(Step 1)~.  Press the JUMP TO BOL function key. ;
	;;1470;Jump to End-Of-Line||8
	;;1470,1,1;JUMP TO EOL function key:  ~<{GE}>~
	;;1470,1,2;
	;;1470,1,3;This function moves the cursor to the column immediately
	;;1470,1,4;following the end of the text on the current row.  If the
	;;1470,1,5;cursor is on a row which has no text, the cursor will be 
	;;1470,1,6;moved to column 2. ;
	;;1470,1,7;
	;;1470,1,8;~(Step 1)~.  Press the JUMP TO EOL key. ;
	;;1480;Move Text||36
	;;1480,1,1;COPY/MOVE function key:  ~<{CP}>~
	;;1480,1,2;
	;;1480,1,3;The Move Text function is very similar to the Copy Text
	;;1480,1,4;function except that it removes the text from the original
	;;1480,1,5;location before inserting it at the new location.  Text to
	;;1480,1,6;be moved can consist of any number of characters or lines. ;
	;;1480,1,7;
	;;1480,1,8;The only restriction is that text may only be moved within
	;;1480,1,9;the current routine.  It cannot be moved from one routine
	;;1480,1,10;to another.  Such an operation can only be done using the
	;;1480,1,11;Copy function to copy the desired text from a second
	;;1480,1,12;routine, then loading the second routine and deleting the
	;;1480,1,13;copied text using the DELETE CHARACTER or DELETE LINE keys. ;
	;;1480,1,14;
	;;1480,1,15;~(Step 1)~.  Move the cursor to the first character of the text
	;;1480,1,16;to be moved and press the COPY/MOVE key. ;
	;;1480,1,17;
	;;1480,1,18;~(Step 2)~.  Select MOVE from the COPY/MOVE menu.  You may also
	;;1480,1,19;press EXIT at this time to return to edit mode. ;
	;;1480,1,20;
	;;1480,1,21;~(Step 3)~.  Using the cursor movement keys, highlight the text
	;;1480,1,22;to be moved.  The selected text may be entirely within one
	;
	;