%ZAA02GEDH17 ;;%AA UTILS;1.21;(Subroutine);19JUL91  16:30
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
        ;Loaded July 19, 1991 at 4:03 PM
        F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
        W "." G ^ZAA02GEDH18
D Q
        ;;2150,1,4;
        ;;2150,1,5;~(Step 1)~.  From the Functions menu, select Utilities. ;
        ;;2150,1,6;         From the Utilities menu, select Routine. ;
        ;;2150,1,7;         From the Routine Utilities menu, select Purge
        ;;2150,1,8;           (PURG). ;
        ;;2150,1,9;
        ;;2150,1,10;~(Step 2)~.  Select the routines to be purged.  Additional
        ;;2150,1,11;information regarding selection of routines is covered in
        ;;2150,1,12;~<Conventions>~.  Note that unlike other utilities, the source
        ;;2150,1,13;of the routines is preselected for you (the ~<workfile>~). ;
        ;;2150,1,14;
        ;;2150,1,15;~(Step 3)~.  Confirm the purge by typing [Y] and [RETURN] at
        ;;2150,1,16;the prompt.  Purging will begin immediately and proceed
        ;;2150,1,17;until completed. ;
        ;;2170;Search Routines Utility||31
        ;;2170,0,"Conventions";2190
        ;;2170,1,1;This utility searches selected routines for occurrences of
        ;;2170,1,2;a specified string.  When a routine is found that contains
        ;;2170,1,3;the string, a header line is printed for each routine, as
        ;;2170,1,4;well as each line in the routine which contains the string. ;
        ;;2170,1,5;For each line, the offset from the beginning of the routine
        ;;2170,1,6;is provided as well as the line label, if any. ;
        ;;2170,1,7;
        ;;2170,1,8;Routines can be searched from any of three sources:
        ;;2170,1,9;
        ;;2170,1,10;  ~<Workfile>~       Latest version of routines in workfile. ;
        ;;2170,1,11;
        ;;2170,1,12;  ~<Archive>~        Latest version of routines in archive. ;
        ;;2170,1,13;
        ;;2170,1,14;  ~<Release>~        The versions of routines in the archive
        ;;2170,1,15;                 which belong to a release. ;
        ;;2170,1,16;
        ;;2170,1,17;
        ;;2170,1,18;~(Step 1)~.  From the Functions menu, select Utilities. ;
        ;;2170,1,19;         From the Utilities menu, select Routine. ;
        ;;2170,1,20;         From the Routine Utilities menu, select Search
        ;;2170,1,21;           (SRCH). ;
        ;;2170,1,22;
        ;;2170,1,23;~(Step 2)~.  Enter the string to be found. ;
        ;;2170,1,24;
        ;;2170,1,25;~(Step 3)~.  Select the routines to be searched.  Additional
        ;;2170,1,26;information regarding selection of source and routines is
        ;;2170,1,27;covered in ~<Conventions>~. ;
        ;;2170,1,28;
        ;;2170,1,29;~(Step 4)~.  Select the output device, and its left and right
        ;;2170,1,30;margins.  Additional information regarding selection of
        ;;2170,1,31;output device and margins is also provided in ~<Conventions>~. ;
        ;;2180;Search Routines and Replace||42
        ;;2180,1,1;This utility searches selected routines for occurrences of
        ;;2180,1,2;a specified string, replaces the string with another string
        ;;2180,1,3;and documents the change in report form. ;
        ;;2180,1,4;
        ;;2180,1,5;A header line is printed for each routine which is found to
        ;;2180,1,6;contain the string, as well as the old and new versions of
        ;;2180,1,7;each line that is changed.  An offset from the beginning of
        ;;2180,1,8;the routine is provided for each line in addition to the
        ;;2180,1,9;line label, if any. ;
        ;;2180,1,10;
        ;;2180,1,11;You can search routine from any of the following three
        ;;2180,1,12;sources.  However, routines which are changed during the
        ;;2180,1,13;process will be saved to the workfile, just as if they had
        ;;2180,1,14;been loaded, edited and saved. ;
        ;;2180,1,15;
        ;;2180,1,16;  ~<Workfile>~       Latest version of routines in workfile. ;
        ;;2180,1,17;
        ;;2180,1,18;  ~<Archive>~        Latest version of routines in archive. ;
        ;
