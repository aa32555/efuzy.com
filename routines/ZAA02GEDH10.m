%ZAA02GEDH10 ;;%AA UTILS;1.21;(Subroutine);19JUL91  16:30
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
        ;Loaded July 19, 1991 at 4:03 PM
        F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
        W "." G ^ZAA02GEDH11
D Q
        ;;1390,1,8;~(Step 1)~.  Press the FIND function key and select LINE from
        ;;1390,1,9;the FIND menu, or press EXIT to abort. ;
        ;;1390,1,10;
        ;;1390,1,11;~(Step 2)~.  When asked 'Find Line: ', enter the tag, or tag
        ;;1390,1,12;plus offset, or offset from the beginning of the routine
        ;;1390,1,13;and press [RETURN].  Note that when offsets are used, blank
        ;;1390,1,14;and internal comment lines are not counted.  Only those
        ;;1390,1,15;lines which would remain in the compiled routine are
        ;;1390,1,16;included. ;
        ;;1390,1,17;
        ;;1390,1,18;The desired line will be found (if it exists) and displayed
        ;;1390,1,19;in the middle of the editing window.  The cursor will be
        ;;1390,1,20;placed at the beginning of the requested line and you will
        ;;1390,1,21;be left in edit mode. ;
        ;;1400;Find String||65
        ;;1400,1,1;The FIND STRING function is available from the FIND menu. ;
        ;;1400,1,2;The FIND function key is:  ~<{GO}>~
        ;;1400,1,3;
        ;;1400,1,4;The Find String is used to identify the locations of a
        ;;1400,1,5;particular string within a routine.  There are three modes
        ;;1400,1,6;of the function which can be used for different purposes
        ;;1400,1,7;and which will be discussed further down.   Each is invoked
        ;;1400,1,8;the same, but the results are different.  
        ;;1400,1,9;
        ;;1400,1,10;~(Step 1)~.  Press the FIND function key and select STRING from
        ;;1400,1,11;the FIND menu, or press EXIT to abort.  
        ;;1400,1,12;
        ;;1400,1,13;~(Step 2)~.  Enter the string you want found.  There are three
        ;;1400,1,14;different results which can be achieved as a result of this
        ;;1400,1,15;search.  Two require that a parameter (a "/C" or a "/L") be
        ;;1400,1,16;added to the end of the string.  These are discussed below. ;
        ;;1400,1,17;
        ;;1400,1,18;~<Interactive Search Mode.>~                   (No parameter)
        ;;1400,1,19;
        ;;1400,1,20;  If you enter a string with no parameter, AA UTILS will
        ;;1400,1,21;  highlight all occurrences of the string and return you to
        ;;1400,1,22;  edit mode.  AA UTILS will then attempt to keep them high-
        ;;1400,1,23;  lighted until you search for a different string or leave
        ;;1400,1,24;  the editor. ;
        ;;1400,1,25;
        ;;1400,1,26;  There are limitations however.  AA UTILS is unable to
        ;;1400,1,27;  find strings which are split between two rows on the
        ;;1400,1,28;  screen.  As a result, this function works better with
        ;;1400,1,29;  short strings than longer ones. ;
        ;;1400,1,30;
        ;;1400,1,31;  Also, editing the line on which the string is highlighted
        ;;1400,1,32;  will temporarily erase the highlight.  It will be high-
        ;;1400,1,33;  lighted again if the line is redisplayed in full, such as
        ;;1400,1,34;  after a NEXT PAGE/PREV PAGE sequence. ;
        ;;1400,1,35;
        ;;1400,1,36;
        ;;1400,1,37;~<Context Mode.>~                           (Parameter:  /C)
        ;;1400,1,38;
        ;;1400,1,39;  Example:         Find string: ~(XYZ/C)~
        ;;1400,1,40;
        ;;1400,1,41;  When a "/C" (upper or lower case) is typed at the end of
        ;;1400,1,42;  a string to be found, the editor will scroll the entire
        ;;1400,1,43;  routine through the editing window, highlighting all
        ;;1400,1,44;  occurrences of the string XYZ as it goes.  This is most
        ;;1400,1,45;  useful when looking at the context in which a string is
        ;;1400,1,46;  found and is not limited by the weaknesses of Interactive
        ;;1400,1,47;  Mode.  When the entire routine has been searched, the
        ;
