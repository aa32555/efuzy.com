%ZAA02GEDH11 ;;%AA UTILS;1.21;(Subroutine);19JUL91  16:30
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
        ;Loaded July 19, 1991 at 4:03 PM
        F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
        W "." G ^ZAA02GEDH12
D Q
        ;;1400,1,48;  total number of occurrences of the string is displayed in
        ;;1400,1,49;  the lower left corner of the screen. ;
        ;;1400,1,50;
        ;;1400,1,51;
        ;;1400,1,52;~<Line Mode.>~                              (Parameter:  /L)
        ;;1400,1,53;
        ;;1400,1,54;  Example:        Find string: ~(XYZ/L)~
        ;;1400,1,55;
        ;;1400,1,56;  When a "/L" (upper or lower case) is typed at the end of
        ;;1400,1,57;  string to be found, the editor will clear the editing
        ;;1400,1,58;  window and display only those lines which contain the
        ;;1400,1,59;  string to be found.  This is most useful when context is
        ;;1400,1,60;  unimportant or when scanning a routine to determine if
        ;;1400,1,61;  the string occurs anywhere in the routine.  It is not
        ;;1400,1,62;  limited by the weaknesses of Interactive Mode and also
        ;;1400,1,63;  displays the number of occurrences of the string in the
        ;;1400,1,64;  lower left corner of the the screen when the entire
        ;;1400,1,65;  routine has been scanned. ;
        ;;1430;Insert Line||12
        ;;1430,1,1;INSERT LINE function key:  ~<{IL}>~
        ;;1430,1,2;
        ;;1430,1,3;This function enables the insertion of new, blank lines into
        ;;1430,1,4;a routine which can be left blank, used for additional code
        ;;1430,1,5;or internal comments.  The only restriction is that lines
        ;;1430,1,6;may not be inserted between the beginning and ending row of
        ;;1430,1,7;a single, wrapped line of code. ;
        ;;1430,1,8;
        ;;1430,1,9;~(Step 1)~.  Position the cursor on the row at which you want
        ;;1430,1,10;to insert a line and press the INSERT LINE function key. ;
        ;;1430,1,11;A new line will be created, and space made for it on the
        ;;1430,1,12;screen. ;
        ;;1440;Insert Character||36
        ;;1440,0,"Editmode";1000
        ;;1440,0,"Insert Line";1430
        ;;1440,1,1;INSERT CHARACTER function key:  ~<{IC}>~
        ;;1440,1,2;
        ;;1440,1,3;The INSERT CHARACTER key has two different behaviors
        ;;1440,1,4;depending on which ~<Editmode>~ you've chosen from the Options
        ;;1440,1,5;menu.  If you have chosen Insert Mode, this key will toggle
        ;;1440,1,6;you between Insert-On and Insert-Off modes.  If you prefer
        ;;1440,1,7;Typeover Mode, the following instructions apply. ;
        ;;1440,1,8;
        ;;1440,1,9;~(TYPEOVER Mode.)~  In Typeover mode, The Insert Character(s)
        ;;1440,1,10;function enables the insertion of one or more characters of
        ;;1440,1,11;additional text any point within an existing line of text. ;
        ;;1440,1,12;The function is not required to add text to the end of a
        ;;1440,1,13;line and does not permit insertion of new lines of text. ;
        ;;1440,1,14;Use the ~<Insert Line>~ function to insert additional lines. ;
        ;;1440,1,15;
        ;;1440,1,16;When inserting text in a line, the cursor is moved to the
        ;;1440,1,17;position at which the new text is to begin and the INSERT
        ;;1440,1,18;CHARACTER key causes the remainder of the line to be moved
        ;;1440,1,19;to the following row to allow the entry of text.  You can
        ;;1440,1,20;press EXIT any time to abort the insertion, or press
        ;;1440,1,21;[RETURN] to complete it. ;
        ;;1440,1,22;
        ;;1440,1,23;~(Step 1)~.  Move the cursor to the location at which text is
        ;;1440,1,24;to be inserted and press the INSERT CHARACTER key.  Any
        ;;1440,1,25;remaining characters on the current row will be moved to
        ;;1440,1,26;the next row to provide space to enter the new text. ;
        ;;1440,1,27;
        ;;1440,1,28;~(Step 2)~.  Enter the new text.  Should the cursor reach the
        ;
