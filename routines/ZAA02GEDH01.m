%ZAA02GEDH01 ;;%AA UTILS;1.21;(Subroutine);19JUL91  16:30
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
        ;Loaded July 19, 1991 at 4:03 PM
        N I,X F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
        W "." G ^ZAA02GEDH02
D Q
        ;;1;HELP INDEX||7
        ;;1,0,"Function Keys";10
        ;;1,0,"MUMPS Syntax";10000
        ;;1,0,"Routine Editor";1000
        ;;1,0,"Utilities";2000
        ;;1,1,1;Help is provided for each topic highlighted below.  SELECT
        ;;1,1,2;and OPEN the topic of interest to you. ;
        ;;1,1,3;
        ;;1,1,4;  ~<Function Keys>~       Finding and using Function Keys
        ;;1,1,5;  ~<Routine Editor>~      Loading, Editing and Saving routines
        ;;1,1,6;  ~<Utilities>~           Using the AA UTILS Utilities
        ;;1,1,7;  ~<MUMPS Syntax>~        Reviewing MUMPS syntax requirements
        ;;10;Function Key Assignments||34
        ;;10,1,1;The following functions are available at various times in
        ;;10,1,2;AA UTILS and can be invoked by pressing the key shown in
        ;;10,1,3;the column at the right. ;
        ;;10,1,4;
        ;;10,1,5;  Exit, Quit or Abort                        ~<{EX}>~
        ;;10,1,6;
        ;;10,1,7;  Move right one character                   ~<{RK}>~
        ;;10,1,8;  Move left one character                    ~<{LK}>~
        ;;10,1,9;  Move up one line                           ~<{UK}>~
        ;;10,1,10;  Move down one line                         ~<{DK}>~
        ;;10,1,11;
        ;;10,1,12;  Move to Next Page                          ~<{PD}>~
        ;;10,1,13;  Move to Previous Page                      ~<{PU}>~
        ;;10,1,14;  Move to Beginning of Routine               ~<{FP}>~
        ;;10,1,15;  Move to Beginning of Line                  ~<{GW}>~
        ;;10,1,16;  Move to End of Line                        ~<{GE}>~
        ;;10,1,17;
        ;;10,1,18;  Insert Character (or toggle mode)          ~<{IC}>~
        ;;10,1,19;  Delete Character                           ~<{DC}>~
        ;;10,1,20;  Insert Line                                ~<{IL}>~
        ;;10,1,21;  Delete Line                                ~<{DL}>~
        ;;10,1,22;  Erase to End of Line                       ~<{EF}>~
        ;;10,1,23;
        ;;10,1,24;  Cut or Break Line                          ~<{CT}>~
        ;;10,1,25;  Join the next line to this line            ~<{RE}>~
        ;;10,1,26;  Swap this line with the previous one       ~<{SU}>~
        ;;10,1,27;  Swap this line with the next one           ~<{SD}>~
        ;;10,1,28;  Copy or Move Text                          ~<{CP}>~
        ;;10,1,29;  Save or Recall from Code Library           ~<{CP}>~
        ;;10,1,30;  Find Line, String, etc.                    ~<{GO}>~
        ;;10,1,31;
        ;;10,1,32;  Set or Clear TAB Settings                  ~<{ST}>~
        ;;10,1,33;  Other Options Menu                         ~<{OT}>~
        ;;10,1,34;  Select                                     ~<{SE}>~
        ;;1000;Introduction to Routine Editor||56
        ;;1000,0,"Compiling A Routine";1230
        ;;1000,0,"Conventions";1300
        ;;1000,0,"Copy Text";1320
        ;;1000,0,"Creating A Routine";1200
        ;;1000,0,"Cut Line";1330
        ;;1000,0,"Delete Character";1342
        ;;1000,0,"Delete Line";1340
        ;;1000,0,"Discard Text";1350
        ;;1000,0,"Erase to EOL";1360
        ;;1000,0,"Exiting the Editor";1370
        ;;1000,0,"Find End-of-Routine";1380
        ;;1000,0,"Find Line";1390
        ;;1000,0,"Find String";1400
        ;;1000,0,"Find/Replace String";1420
        ;;1000,0,"Insert Line";1430
        ;;1000,0,"Insert Text";1440
        ;;1000,0,"Join Lines";1450
        ;;1000,0,"Jump to BOL";1460
        ;;1000,0,"Jump to EOL";1470
        ;;1000,0,"Loading A Routine";1210
        ;;1000,0,"Move Text";1480
        ;;1000,0,"Options";1100
        ;;1000,0,"Recall Text";1500
        ;;1000,0,"Save Text";1510
        ;;1000,0,"Saving A Routine";1220
        ;;1000,0,"Swapline Down";1530
        ;;1000,0,"Swapline Up";1520
        ;;1000,1,1;The AA UTILS Routine Editor provides a comprehensive, full-
        ;
