%ZAA02GEDH18 ;;%AA UTILS;1.21;(Subroutine);19JUL91  16:30
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
        ;Loaded July 19, 1991 at 4:03 PM
        F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
        W "." G ^ZAA02GEDH19
D Q
        ;;2180,1,19;
        ;;2180,1,20;  ~<Release>~        The versions of routines in the archive
        ;;2180,1,21;                 which belong to a release. ;
        ;;2180,1,22;
        ;;2180,1,23;~(Step 1)~.  From the Functions menu, select Utilities. ;
        ;;2180,1,24;         From the Utilities menu, select Routine. ;
        ;;2180,1,25;         From the Routine Utilities menu, select Replace
        ;;2180,1,26;           (REPL). ;
        ;;2180,1,27;
        ;;2180,1,28;~(Step 2)~.  In response to the prompt 'Replace string: ',
        ;;2180,1,29;enter the string to be found and replaced.  Pressing EXIT
        ;;2180,1,30;will abort the process. ;
        ;;2180,1,31;
        ;;2180,1,32;~(Step 3)~.  In response to the prompt 'With string: ', enter
        ;;2180,1,33;the string to be inserted in place of the string entered in
        ;;2180,1,34;Step 2. ;
        ;;2180,1,35;
        ;;2180,1,36;~(Step 4)~.  Select the routines to be searched.  Additional
        ;;2180,1,37;information regarding selection of source and routines can
        ;;2180,1,38;be found under ~<Conventions>~. ;
        ;;2180,1,39;
        ;;2180,1,40;~(Step 5)~.  Select the output device, and its left and right
        ;;2180,1,41;margins.  Additional information regarding selection of
        ;;2180,1,42;output device and margins can be found under ~<Conventions>~. ;
        ;;2190;Utility Conventions||132
        ;;2190,0,"AAA";dateparam
        ;;2190,1,1;Several helpful conventions are used throughout the utili-
        ;;2190,1,2;ties which can be very helpful. ;
        ;;2190,1,3;
        ;;2190,1,4;~<Routine Selection>~.  All routine selection in the AA UTILS'
        ;;2190,1,5;utilities operate in the same manner.  Once you have become
        ;;2190,1,6;familiar with the steps involved, you will find the process
        ;;2190,1,7;to be powerful and easy-to-use. ;
        ;;2190,1,8;
        ;;2190,1,9;~(Step 1)~.  ~(Identify the source of the routines)~.  There are
        ;;2190,1,10;four possible sources of routines for use by the utilities:
        ;;2190,1,11;the programmer's ~<workspace>~, the common ~<workfile>~, the rou-
        ;;2190,1,12;tine ~<archive>~ and routine ~<releases>~.  For example, when prin-
        ;;2190,1,13;ting a listing you can (1) list the routine currently in
        ;;2190,1,14;your workspace, (2) list the current versions of a selected
        ;;2190,1,15;set of routines in the workfile, (3) list the most current
        ;;2190,1,16;versions of routines from the routine archive, or (4) list
        ;;2190,1,17;the versions of routines from the archive which have been
        ;;2190,1,18;linked to a particular release of a package. ;
        ;;2190,1,19;
        ;;2190,1,20;When the Routine Listings utility is used, the first ques-
        ;;2190,1,21;tion asked will be the source of the routines.  Note that
        ;;2190,1,22;some utilities are limited to certain sources.  Because of
        ;;2190,1,23;this, not all the sources will be available for each
        ;;2190,1,24;utility.  The process of selection, however, remains the
        ;;2190,1,25;same. ;
        ;;2190,1,26;
        ;;2190,1,27;Type the first character of the desired source, or use the
        ;;2190,1,28;cursor movement keys to move the selector to highlight it
        ;;2190,1,29;and press [RETURN].  If you select workspace as the source,
        ;;2190,1,30;routine selection is complete since the workspace can
        ;;2190,1,31;contain only one routine. ;
        ;;2190,1,32;
        ;;2190,1,33;If the selected source is a release, proceed to Step 3. ;
        ;;2190,1,34;
        ;;2190,1,35;~(Step 2)~.  ~(Identify the routines)~.  If either workfile or
        ;;2190,1,36;archive are selected as the routine source, you will be
        ;
