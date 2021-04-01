%ZAA02GEDH27 ;;%AA UTILS;1.21;(Subroutine);19JUL91  16:30
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
        ;Loaded July 19, 1991 at 4:03 PM
        F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
        W "." G ^ZAA02GEDH28
D Q
        ;;2502,1,14;~(Step 3)~.  If you selected GLOBAL or ASCII FILE as the source,
        ;;2502,1,15;you will be asked for the name.  For ASCII files, include
        ;;2502,1,16;drive and path information as well.  Once identified, a
        ;;2502,1,17;window will be displayed which contains the file header
        ;;2502,1,18;information for confirmation purposes. ;
        ;;2502,1,19;
        ;;2502,1,20;~(Step 4)~.  Select type of confirmation desired.  You may have
        ;;2502,1,21;AA UTILS request confirmation before routines in one of the
        ;;2502,1,22;three following ways. ;
        ;;2502,1,23;
        ;;2502,1,24;  ~<EXISTING>~       Confirm import of routines which already
        ;;2502,1,25;                 exist in the AA UTILS system. ;
        ;;2502,1,26;
        ;;2502,1,27;  ~<EACH>~           Confirm import of every routine. ;
        ;;2502,1,28;
        ;;2502,1,29;  ~<NEVER>~          Import all routines without confirmation. ;
        ;;2502,1,30;
        ;;2502,1,31;
        ;;2502,1,32;~(Step 5)~.  Change Routine Names on Input.  If you would like
        ;;2502,1,33;for routine names to be changed as they're imported, answer
        ;;2502,1,34;YES by pressing [Y] and [RETURN].  You will then be asked
        ;;2502,1,35;to indicate how the names should be changed.  First specify
        ;;2502,1,36;the portion of the incoming name to be changed.  Then
        ;;2502,1,37;specify the change to be made.  Consider the following:
        ;;2502,1,38;
        ;;2502,1,39;  a) Change names from: ~(AA*      )~  to: ~(ZZ*      )~
        ;;2502,1,40;
        ;;2502,1,41;...changes the first two characters of routine name to "ZZ"
        ;;2502,1,42;if the routine name begins with "AA". ;
        ;;2502,1,43;
        ;;2502,1,44;  b) Change names from: ~(*        )~  to: ~(%*       )~
        ;;2502,1,45;
        ;;2502,1,46;...results in a percent sign ("%") being added to the
        ;;2502,1,47;beginning of all routine names. ;
        ;;2502,1,48;
        ;;2502,1,49;  c) Change names from: ~(%*       )~  to: ~(*        )~
        ;;2502,1,50;
        ;;2502,1,51;...results in the first character being removed from all
        ;;2502,1,52;routine names which begin with a percent sign ("%"). ;
        ;;2502,1,53;
        ;;2502,1,54;  d) Change names from: ~(*Z       )~  to: ~(*A       )~
        ;;2502,1,55;
        ;;2502,1,56;...changes the last character of routine name from "Z" to
        ;;2502,1,57;"A" if the routine name ends with an "A". ;
        ;;2502,1,58;
        ;;2502,1,59;
        ;;2502,1,60;~(Step 6)~.  Ready to begin?  If ready, press [Y] and [RETURN]
        ;;2502,1,61;to begin processing. ;
        ;;2502,1,62;
        ;;2502,1,63;As routines are imported, their name will be displayed at
        ;;2502,1,64;the bottom of the screen.  If the rename function has been
        ;;2502,1,65;used, the changed name will be displayed.   When finished,
        ;;2502,1,66;you will be returned to the Utilities menu. ;
        ;;10000;MUMPS Syntax||8
        ;;10000,0,"Commands";16000
        ;;10000,0,"Functions";14000
        ;;10000,0,"Operators";11000
        ;;10000,0,"Variables";12000
        ;;10000,1,1;Syntax information is provided for the following highlight-
        ;;10000,1,2;ed language categories:
        ;;10000,1,3;
        ;;10000,1,4;
        ;;10000,1,5;  ~<Commands>~    ~<Functions>~    ~<Variables>~    ~<Operators>~
        ;;10000,1,6;
        ;;10000,1,7;
        ;;10000,1,8;SELECT and OPEN the desired category. ;
        ;;11000;MUMPS Operators||40
        ;;11000,1,1;MUMPS provides the following operators:
        ;;11000,1,2;
        ;;11000,1,3;~<+>~    Add                A+B   Add B to A
        ;;11000,1,4;
        ;;11000,1,5;~<->~    Subtract           A-B   Subtract B from A
        ;;11000,1,6;
        ;;11000,1,7;~<*>~    Multiply           A*B   Multiply A by B
        ;
