%ZAA02GEDH03 ;;%AA UTILS;1.21;(Subroutine);19JUL91  16:30
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
        ;Loaded July 19, 1991 at 4:03 PM
        F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
        W "." G ^ZAA02GEDH04
D Q
        ;;1100,1,2;changed to reflect each programmer's preferences.  These
        ;;1100,1,3;are available under ~<Options >~in the ~<Functions>~ menu. ;
        ;;1100,1,4;
        ;;1100,1,5;~(Menu Control)~.  Menus in the AA UTILS system can require a
        ;;1100,1,6;[RETURN] to terminate a selection, or can execute in HOT
        ;;1100,1,7;KEY mode in which [RETURN] is not required.  In this mode,
        ;;1100,1,8;menu selections can be made by typing the first character
        ;;1100,1,9;of the option being selected.  If two options begin with
        ;;1100,1,10;the same letter, press [RETURN] to select the first, or
        ;;1100,1,11;press the letter a second time followed by [RETURN] to
        ;;1100,1,12;select the second. ;
        ;;1100,1,13;
        ;;1100,1,14;~(Display Width)~.  AA UTILS is capable of operating in the
        ;;1100,1,15;normal 80 column mode, or with terminals which support 132
        ;;1100,1,16;cpi, in 132 column mode.  Regardless of which mode is
        ;;1100,1,17;desired, AA UTILS will always put the terminal back in 80
        ;;1100,1,18;column mode when you exit the system. ;
        ;;1100,1,19;
        ;;1100,1,20;~(Display Intensity)~.  A routine can be displayed in either
        ;;1100,1,21;high or low intensity.  This makes it possible for one pro-
        ;;1100,1,22;grammer to overcome excessive screen glare by using high
        ;;1100,1,23;intensity, while another prefers low intensity.  In either
        ;;1100,1,24;case, editing functions which mark text such as COPY or
        ;;1100,1,25;MOVE text, will use the alternate intensity to mark the
        ;;1100,1,26;affected regions. ;
        ;;1100,1,27;
        ;;1100,1,28;~(Editmode)~.  AA UTILS provides two editing modes for prog-
        ;;1100,1,29;grammers to choose from, each of which has a different
        ;;1100,1,30;appeal. ;
        ;;1100,1,31;
        ;;1100,1,32;In ~<TYPEOVER >~mode, which is the AA UTILS default mode,
        ;;1100,1,33;characters typed will type over, or replace the character
        ;;1100,1,34;at the cursor with the character just typed.  To insert new
        ;;1100,1,35;characters in a line, the INSERT CHARACTER key is pressed
        ;;1100,1,36;to enter a temporary insert mode.  The line is broken at
        ;;1100,1,37;the cursor and text can be entered.  When the new text has
        ;;1100,1,38;been entered and [RETURN] is pressed, the line into which
        ;;1100,1,39;the text is being inserted is put back together and the
        ;;1100,1,40;screen refreshed.  In this mode, new lines can be inserted
        ;;1100,1,41;anywhere in the routine by pressing the INSERT LINE key. ;
        ;;1100,1,42;
        ;;1100,1,43;In ~<INSERT >~mode, the editor can be toggled between INSERT-ON
        ;;1100,1,44;and INSERT-OFF modes by pressing the INSERT CHARACTER key. ;
        ;;1100,1,45;In INSERT-ON mode, all characters typed are treated as new
        ;;1100,1,46;characters and do not replace but are added to existing
        ;;1100,1,47;characters.   In addition, the [RETURN] key will break a
        ;;1100,1,48;line at the cursor, and the [BACKSPACE] or [RUBOUT] will
        ;;1100,1,49;put two lines back together again.  INSERT-OFF mode works
        ;;1100,1,50;just like TYPEOVER mode, except for the function of the INS
        ;;1100,1,51;CHAR key. ;
        ;;1200;Creating A New Routine||26
        ;;1200,1,1;To create a new routine, invoke the ~<NEW>~ function from the
        ;;1200,1,2;Functions menu at the bottom of the screen when you exit
        ;;1200,1,3;from the Routine Editor.  This function clears your work-
        ;;1200,1,4;space and prompts you to enter the name of the new routine. ;
        ;;1200,1,5;
        ;
