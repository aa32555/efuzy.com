%ZAA02GEDH04 ;;%AA UTILS;1.21;(Subroutine);19JUL91  16:30
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
        ;Loaded July 19, 1991 at 4:03 PM
        F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
        W "." G ^ZAA02GEDH05
D Q
        ;;1200,1,6;If you have HOT KEYS turned on, typing an [N] will invoke
        ;;1200,1,7;the Create Routine function.   Otherwise, type [N] or use
        ;;1200,1,8;your [SPACE] key or [RIGHT] and [LEFT] arrow keys to move
        ;;1200,1,9;the selector to the new option and press [RETURN]. ;
        ;;1200,1,10;
        ;;1200,1,11;To clear your workspace of the current routine but ~(not)~
        ;;1200,1,12;actually create a new routine, simply press [RETURN] when
        ;;1200,1,13;prompted for the name. ;
        ;;1200,1,14;
        ;;1200,1,15;Otherwise, enter the name of the new routine when AA UTILS
        ;;1200,1,16;prompts you for it and press [RETURN].  If a routine by
        ;;1200,1,17;that name already exists in AA UTILS, you will be notified
        ;;1200,1,18;of its existence and asked for another name.  If no such
        ;;1200,1,19;routine exists, your ~<workspace >~will be cleared and the
        ;;1200,1,20;cursor will be placed at the top left corner of the editing
        ;;1200,1,21;window. ;
        ;;1200,1,22;
        ;;1200,1,23;Remember that creating a routine does not automatically
        ;;1200,1,24;save it to the ~<workfile>~ at the same time.  A newly created
        ;;1200,1,25;routine exists only in your ~<workspace>~ until you explicitly
        ;;1200,1,26;save it. ;
        ;;1210;Loading A Routine||28
        ;;1210,0,"ROUTINE LOOKUP";1240
        ;;1210,1,1;To edit an existing routine, it must first be loaded into
        ;;1210,1,2;your ~(workspace)~.  To do this, select ~<LOAD>~ from the Functions
        ;;1210,1,3;menu at the bottom of the screen.  AA UTILS will ask you
        ;;1210,1,4;for the name of the routine to be loaded. ;
        ;;1210,1,5;
        ;;1210,1,6;If you are not sure of the name of the routine you want to
        ;;1210,1,7;load use the ~<ROUTINE LOOKUP>~ facility. ;
        ;;1210,1,8;
        ;;1210,1,9;If you know the name of the routine, enter it and press
        ;;1210,1,10;[RETURN].  AA UTILS will then identify the sources from
        ;;1210,1,11;which the routine can be loaded and request that you select
        ;;1210,1,12;one.  For example, if the routine is in the ~(workfile)~, the
        ;;1210,1,13;list of possible sources will include WORKFILE.  If the
        ;;1210,1,14;workfile has backup copies of the routine, the list will
        ;;1210,1,15;include BACKUP.  And if the routine is also found in the
        ;;1210,1,16;~(archive)~, ARCHIVE will be in the list.  Finally, MUMPS will
        ;;1210,1,17;be included as a possible source, and sometimes the only
        ;;1210,1,18;one. ;
        ;;1210,1,19;
        ;;1210,1,20;The important thing to remember is that regardless of which
        ;;1210,1,21;sources are represented in the list, the default option will
        ;;1210,1,22;always be the ~(most)~ ~(current)~ copy of the routine.  So, unless
        ;;1210,1,23;you are specifically intending to load an older copy of the
        ;;1210,1,24;routine, simply press [RETURN]. ;
        ;;1210,1,25;
        ;;1210,1,26;Once selected, the routine will be loaded into your work-
        ;;1210,1,27;space and the cursor placed in the top left corner of the
        ;;1210,1,28;routine. ;
        ;;1220;Saving A Routine||22
        ;;1220,1,1;The process of saving a routine copies the routine in your
        ;;1220,1,2;~<workspace>~ to the ~<workfile>~.  If prior copies of the routine
        ;;1220,1,3;already exist in the workfile, the two most recent copies
        ;;1220,1,4;are retained as backups. ;
        ;;1220,1,5;
        ;;1220,1,6;To save the current routine, exit the Routine Editor and
        ;;1220,1,7;select SAVE from the Function menu at the bottom of the
        ;;1220,1,8;screen.  AA UTILS will ask you to confirm the name of the
        ;
