%ZAA02GEDH06 ;;%AA UTILS;1.21;(Subroutine);19JUL91  16:30
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
        ;Loaded July 19, 1991 at 4:03 PM
        F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
        W "." G ^ZAA02GEDH07
D Q
        ;;1300,1,1;~(First Routine Line)~.   AA UTILS makes two assumptions re-
        ;;1300,1,2;garding the format of the first line of each routine. ;
        ;;1300,1,3;
        ;;1300,1,4;First, the label of the first line in each routine should
        ;;1300,1,5;be the name of the routine.  If the routine name is also an
        ;;1300,1,6;extrinsic function, the parameter list may be included. ;
        ;;1300,1,7;
        ;;1300,1,8;Second, AA UTILS expects the rest of the line to contain a
        ;;1300,1,9;description of the routine prefaced by a ";".  Note that at
        ;;1300,1,10;least one space must occur between the line label and the
        ;;1300,1,11;semicolon. ;
        ;;1300,1,12;
        ;;1300,1,13;
        ;;1300,1,14;~(Internal Comments)~.  AA UTILS provides an environment in
        ;;1300,1,15;which internal comments and white space can be used freely
        ;;1300,1,16;to assist in making the routine easy to read, understand
        ;;1300,1,17;and maintain.  To do this AA UTILS recognizes three types
        ;;1300,1,18;of line: a ~<blank line>~, a ~<comment line>~ and a ~<code line>~. ;
        ;;1300,1,19;
        ;;1300,1,20;Blank lines contain nothing and can be used to add "white-
        ;;1300,1,21;space" to routines to improve source readability.  They are
        ;;1300,1,22;stripped out during the compilation step and therefore have
        ;;1300,1,23;no effect on execution. ;
        ;;1300,1,24;
        ;;1300,1,25;Internal Comment lines begin with the slash "/" character. ;
        ;;1300,1,26;They can have any text and are also stripped out during the
        ;;1300,1,27;compilation step and have no effect on execution.  There is
        ;;1300,1,28;no limit to the number of comment lines you can use.  How-
        ;;1300,1,29;ever, you must make sure that the slash is placed at the
        ;;1300,1,30;extreme left margin.  Otherwise, AA UTILS will try to com-
        ;;1300,1,31;pile it. ;
        ;;1300,1,32;
        ;;1300,1,33;Standard MUMPS comments (preceded by a semi-colon) are
        ;;1300,1,34;also permitted.  Such comments, as well as any non-blank
        ;;1300,1,35;lines which do not begin with a slash, are considered code
        ;;1300,1,36;lines and will be transferred to MUMPS with the code when
        ;;1300,1,37;the routine is compiled. ;
        ;;1300,1,38;
        ;;1300,1,39;
        ;;1300,1,40;~(Coding Formats)~.  AA UTILS imposes few format restrictions
        ;;1300,1,41;on the programmer and most, if not all, are the same as
        ;;1300,1,42;other editors.  The rules are as follows:
        ;;1300,1,43;
        ;;1300,1,44;First, line labels must begin on the left margin and may
        ;;1300,1,45;not contain punctuation other than that required for para-
        ;;1300,1,46;meter lists.  In addition, labels must be followed by at
        ;;1300,1,47;least one [SPACE] before any code begins.  Pressing the
        ;;1300,1,48;[TAB] key after entering a label helps and also serves to
        ;;1300,1,49;keep left margins free from all but tags making the routine
        ;;1300,1,50;easier to read. ;
        ;;1300,1,51;
        ;;1300,1,52;Also, AA UTILS does allow lines of code which exceed the
        ;;1300,1,53;width of the screen and handles the wrapping of the line
        ;;1300,1,54;automatically as it is typed.  However, while you can enter
        ;;1300,1,55;a line over 255 characters in length, you will not be able
        ;;1300,1,56;to save it intact.  Lines that exceed 255 are broken when
        ;;1300,1,57;the routine is saved and the programmer notified.  When
        ;;1300,1,58;this occurs, the second half of the line will be preceded
        ;;1300,1,59;by the label '<LNGTH>'. ;
        ;;1320;Copy Text Function||44
        ;
