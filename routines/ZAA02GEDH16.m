%ZAA02GEDH16 ;;%AA UTILS;1.21;(Subroutine);19JUL91  16:30
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
        ;Loaded July 19, 1991 at 4:03 PM
        F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
        W "." G ^ZAA02GEDH17
D Q
        ;;2130,1,6;  ~<Workfile>~       Latest version of routines in workfile. ;
        ;;2130,1,7;
        ;;2130,1,8;  ~<Archive>~        Latest version of routines in archive. ;
        ;;2130,1,9;
        ;;2130,1,10;  ~<Release>~        The versions of routines in the archive
        ;;2130,1,11;                 which belong to a release. ;
        ;;2130,1,12;
        ;;2130,1,13;~(Step 1)~.  From the Functions menu, select Utilities. ;
        ;;2130,1,14;         From the Utilities menu, select Routine. ;
        ;;2130,1,15;         From the Routine Utilities menu, select Directory
        ;;2130,1,16;           (DIR). ;
        ;;2130,1,17;
        ;;2130,1,18;~(Step 2)~.  Select the routines to be included.  Additional
        ;;2130,1,19;information regarding selection of source and routines is
        ;;2130,1,20;covered under ~<Conventions>~. ;
        ;;2130,1,21;
        ;;2130,1,22;~(Step 3)~.  Select the output device, and its left and right
        ;;2130,1,23;margins.  Additional information regarding selection of
        ;;2130,1,24;output device and margins is also provided under
        ;;2130,1,25;~<Conventions>~. ;
        ;;2140;Print Routine Listings Utility||44
        ;;2140,0,"Conventions";2190
        ;;2140,1,1;This utility prints source code listings for one or more
        ;;2140,1,2;routines from one of the following three sources:
        ;;2140,1,3;
        ;;2140,1,4;  ~<Workfile>~       Latest version of routines in workfile. ;
        ;;2140,1,5;
        ;;2140,1,6;  ~<Archive>~        Latest version of routines in archive. ;
        ;;2140,1,7;
        ;;2140,1,8;  ~<Release>~        The versions of routines in the archive
        ;;2140,1,9;                 which belong to a release. ;
        ;;2140,1,10;
        ;;2140,1,11;
        ;;2140,1,12;~(Step 1)~.  From the Functions menu, select Utilities. ;
        ;;2140,1,13;         From the Utilities menu, select Routine. ;
        ;;2140,1,14;         From the Routine Utilities menu, select List. ;
        ;;2140,1,15;
        ;;2140,1,16;~(Step 2)~.  Select the routines to be listed.  Additional
        ;;2140,1,17;information regarding selection of source and routines is
        ;;2140,1,18;covered ~<Conventions>~. ;
        ;;2140,1,19;
        ;;2140,1,20;~(Step 3)~.  Select the output device, and its left and right
        ;;2140,1,21;margins.  Additional information regarding selection of
        ;;2140,1,22;output device and margins is also provided under
        ;;2140,1,23;~<Conventions>~. ;
        ;;2140,1,24;
        ;;2140,1,25;~(Step 4)~.  If you select more than one routine, you will be
        ;;2140,1,26;asked whether you would like a Routine Directory printed. ;
        ;;2140,1,27;If you respond [Y], a directory will be printed for the
        ;;2140,1,28;routines you selected. ;
        ;;2140,1,29;
        ;;2140,1,30;One feature of the listing routine which can be very help-
        ;;2140,1,31;ful in visually separating logical sections of a routine
        ;;2140,1,32;converts special comment lines to titles.  A comment like
        ;;2140,1,33;this one... ;
        ;;2140,1,34;
        ;;2140,1,35;    /- GET LOAN AMOUNT
        ;;2140,1,36;
        ;;2140,1,37;...will result in the title being centered on the page in a
        ;;2140,1,38;line of hyphens, like this... ;
        ;;2140,1,39;
        ;;2140,1,40;-----------------------GET LOAN AMOUNT----------------------
        ;;2140,1,41;
        ;;2140,1,42;In order for this to work, the line must begin with a slash
        ;;2140,1,43;followed by a punctuation character, followed by a space,
        ;;2140,1,44;followed by the title. ;
        ;;2150;Purge Routines Utility||17
        ;;2150,0,"Conventions";2190
        ;;2150,1,1;This utility removes a selected group of routines and their
        ;;2150,1,2;corresponding backups, if any, from the workfile. ;
        ;;2150,1,3;
        ;
