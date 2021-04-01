%ZAA02GEDH08 ;;%AA UTILS;1.21;(Subroutine);19JUL91  16:30
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
        ;Loaded July 19, 1991 at 4:03 PM
        F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
        W "." G ^ZAA02GEDH09
D Q
        ;;1340,1,1;DELETE LINE function key:  ~<{DL}>~
        ;;1340,1,2;
        ;;1340,1,3;AA UTILS can remove an entire row of text or code with the
        ;;1340,1,4;DELETE LINE function key.  Use caution, there is no "undo"
        ;;1340,1,5;function, and the only source for retrieving the line is
        ;;1340,1,6;from the routine backup, if any, or routine archive. ;
        ;;1340,1,7;
        ;;1340,1,8;When the DELETE LINE key is pressed, the row which the
        ;;1340,1,9;cursor is on is removed and all following lines moved up
        ;;1340,1,10;one row. ;
        ;;1340,1,11;
        ;;1340,1,12;~(Step 1)~.  Move cursor to the row to be deleted and press
        ;;1340,1,13;DELETE LINE.  The line will be removed immediately and you
        ;;1340,1,14;will be returned to edit mode. ;
        ;;1342;Delete Character(s)||21
        ;;1342,1,1;
        ;;1342,1,2;DELETE CHARACTER function key:  ~<{DC}>~
        ;;1342,1,3;
        ;;1342,1,4;The DELETE CHARACTER key allows you to mark one or more
        ;;1342,1,5;characters of code or text and delete them from a line. ;
        ;;1342,1,6;
        ;;1342,1,7;
        ;;1342,1,8;~(Step 1)~.  Move the cursor to the first character of the text
        ;;1342,1,9;to be deleted and press the DELETE CHARACTER key.  The
        ;;1342,1,10;character will be highlighted and instructions displayed at
        ;;1342,1,11;the bottom of the screen as.  Notice that spaces are shown
        ;;1342,1,12;as a period "." when highlighted, enabling them to be seen. ;
        ;;1342,1,13;
        ;;1342,1,14;Continue to press the DELETE CHARACTER key until the entire
        ;;1342,1,15;text to be deleted has been highlighted.  You may also use
        ;;1342,1,16;the cursor LEFT key to undo or deselect one or more high-
        ;;1342,1,17;lighted characters. ;
        ;;1342,1,18;
        ;;1342,1,19;You may press EXIT to abort the deletion at this time or
        ;;1342,1,20;press [RETURN] to complete the deletion.  The screen will
        ;;1342,1,21;be refreshed and you will be returned to edit mode. ;
        ;;1350;Discard Text||18
        ;;1350,0,"Recall Text";1510
        ;;1350,0,"Save Text";1520
        ;;1350,1,1;The DISCARD function is available from the COPY/MOVE menu. ;
        ;;1350,1,2;The COPY/MOVE function key is:  ~<{CP}>~
        ;;1350,1,3;
        ;;1350,1,4;The discard text option is provided for you to remove text
        ;;1350,1,5;from the AA UTILS Code Library.  To learn more about the
        ;;1350,1,6;code library, refer to ~<Save Text>~ and ~<Recall Text>~. ;
        ;;1350,1,7;
        ;;1350,1,8;~(Step 1)~.  Press the COPY/MOVE key and select DISCARD from
        ;;1350,1,9;the menu.  You may abort the operation at this time by
        ;;1350,1,10;pressing the EXIT key. ;
        ;;1350,1,11;
        ;;1350,1,12;~(Step 2)~.  Enter the name of the text to be removed from the
        ;;1350,1,13;AA UTILS code library.  You may also enter a question mark
        ;;1350,1,14;[?] to view the list of objects in the code library and
        ;;1350,1,15;select the desired one from the pop-up menu. ;
        ;;1350,1,16;
        ;;1350,1,17;~(Step 3.)~  Press [RETURN] to complete the operation and you
        ;;1350,1,18;will be returned to edit mode. ;
        ;;1360;Erase to End-Of-Line||15
        ;;1360,1,1;ERASE TO EOL function key:  ~<{EF}>~
        ;;1360,1,2;
        ;;1360,1,3;The ERASE TO EOL function enables you to quickly remove all
        ;;1360,1,4;characters from the cursor position to the end of the rou-
        ;;1360,1,5;tine line. ;
        ;;1360,1,6;
        ;;1360,1,7;~(Step 1)~.  Move the cursor to the first character to be
        ;;1360,1,8;erased and press the ERASE TO EOL key.  All of the text to
        ;;1360,1,9;be erased will be highlighted to provide an opportunity for
        ;
