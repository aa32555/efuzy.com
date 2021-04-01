%ZAA02GEDH15 ;;%AA UTILS;1.21;(Subroutine);19JUL91  16:30
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
        ;Loaded July 19, 1991 at 4:03 PM
        F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
        W "." G ^ZAA02GEDH16
D Q
        ;;2100,1,4;  ~<Utility Conventions>~
        ;;2100,1,5;  ~<Print Routine Listings>~
        ;;2100,1,6;  ~<Print Routine Directory>~
        ;;2100,1,7;  ~<Compile Routines>~
        ;;2100,1,8;  ~<Archive Routines>~
        ;;2100,1,9;  ~<Search Routines>~
        ;;2100,1,10;  ~<Search Routines & Replace>~
        ;;2100,1,11;  ~<Purge Routines from Workfile>~
        ;;2100,1,12;  ~<Release Management>~
        ;;2110;Archive Routine Utility||26
        ;;2110,0,"conventions";2190
        ;;2110,1,1;This utility provides the ability to move a group of
        ;;2110,1,2;routines from the ~<workfile>~ to the routine ~<archive>~, at which
        ;;2110,1,3;time the current workfile version is copied to the archive,
        ;;2110,1,4;and removed from the workfile with all its backups. ;
        ;;2110,1,5;
        ;;2110,1,6;Archiving a routine creates a new archive version of that
        ;;2110,1,7;routine ~(only)~ if it is the first time the routine has been
        ;;2110,1,8;archived, or if the previously archived version of the
        ;;2110,1,9;routine has been locked through the Freeze option in the
        ;;2110,1,10;Release Management utility. ;
        ;;2110,1,11;
        ;;2110,1,12;~(Step 1)~.  From the Functions menu, select Utilities. ;
        ;;2110,1,13;         From the Utilities menu, select Routine. ;
        ;;2110,1,14;         From the Routine Utilities menu, select Archive
        ;;2110,1,15;           (ARCH). ;
        ;;2110,1,16;
        ;;2110,1,17;~(Step 2)~.  Select the routines to be archived according to
        ;;2110,1,18;routine selection ~<conventions>~.  Note that unlike other
        ;;2110,1,19;utilities, the source of the routines is preselected for
        ;;2110,1,20;you (the workfile). ;
        ;;2110,1,21;
        ;;2110,1,22;~(Step 3)~.  Confirm that you want to archive by typing [Y] and
        ;;2110,1,23;[RETURN].  The default response is NO. ;
        ;;2110,1,24;
        ;;2110,1,25;The Archival will begin immediately and proceed until
        ;;2110,1,26;completed. ;
        ;;2120;Compile Routines||24
        ;;2120,0,"Conventions";2190
        ;;2120,1,1;This utility compiles a group of routines from the AA UTILS
        ;;2120,1,2;database to MUMPS.  This is particularly beneficial when
        ;;2120,1,3;testing software modules.  Note that routines can only be
        ;;2120,1,4;compiled from the following two sources; pre-releases and
        ;;2120,1,5;final releases can be compiled only through Release Manage-
        ;;2120,1,6;ment. ;
        ;;2120,1,7;
        ;;2120,1,8;  ~<Workfile>~       Latest version of routines in workfile. ;
        ;;2120,1,9;
        ;;2120,1,10;  ~<Archive>~        Latest version of routines in archive. ;
        ;;2120,1,11;
        ;;2120,1,12;
        ;;2120,1,13;~(Step 1)~.  From the Functions menu, select Utilities. ;
        ;;2120,1,14;         From the Utilities menu, select Routine. ;
        ;;2120,1,15;         From the Routine Utilities menu, select Compile
        ;;2120,1,16;           (COMP). ;
        ;;2120,1,17;
        ;;2120,1,18;
        ;;2120,1,19;~(Step 2)~.  Select the routines to be compiled.  Additional
        ;;2120,1,20;information regarding selection of source and routines is
        ;;2120,1,21;covered under ~<Conventions>~. ;
        ;;2120,1,22;
        ;;2120,1,23;Compilation will begin immediately following selection of
        ;;2120,1,24;routines. ;
        ;;2130;Print Routine Directory||25
        ;;2130,0,"Conventions";2190
        ;;2130,1,1;This utility prints the list (or a subset of the list) of
        ;;2130,1,2;routines from one of the three sources described below.  In
        ;;2130,1,3;addition to routine name, size and date last modified, a
        ;;2130,1,4;description of the routine is printed. ;
        ;;2130,1,5;
        ;
