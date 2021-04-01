%ZAA02GEDH39 ;;%AA UTILS;1.21;(Subroutine);19JUL91  16:30
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
        ;Loaded July 19, 1991 at 4:03 PM
        F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
        W "." G ^ZAA02GEDH40
D Q
        ;;16110,1,12;executing each argument, LOCK releases all previously spec-
        ;;16110,1,13;ified exclusive claims to resources. ;
        ;;16110,1,14;
        ;;16110,1,15;If any arguments are specified, new temporary exclusive
        ;;16110,1,16;claims are established to the named resources.  If another
        ;;16110,1,17;user has exclusive claims on a resource named, the current
        ;;16110,1,18;process (that is, the one executing the LOCK command)
        ;;16110,1,19;remains suspended awaiting the availability of that
        ;;16110,1,20;resource. ;
        ;;16110,1,21;
        ;;16110,1,22;A "timeout" can be affixed to any argument of LOCK to abort
        ;;16110,1,23;an unsuccessful wait.  (Note that a series of named
        ;;16110,1,24;resources must be placed in parentheses, as for L (B,G(4)),
        ;;16110,1,25;but that parentheses are not required around the name of a
        ;;16110,1,26;single resource.)
        ;;16110,1,27;
        ;;16110,1,28;LOCK has no effect on the value or definition of existing
        ;;16110,1,29;variables or on the "naked indicator". ;
        ;;16110,1,30;
        ;;16110,1,31;Incremental LOCKing (e.g., L +^INDEX) will not affect any
        ;;16110,1,32;previously LOCKed values (i.e., they remain LOCKed), but
        ;;16110,1,33;each incremental LOCK of the same value is counted and must
        ;;16110,1,34;be decrementally LOCKed (e.g. L -^INDEX) as many times as
        ;;16110,1,35;it was LOCKed before it is released. ;
        ;;16120;Command:  NEW||25
        ;;16120,1,1;~<Examples:>~
        ;;16120,1,2;  NEW
        ;;16120,1,3;  N A,SAVE
        ;;16120,1,4;  N (A,SAVE)
        ;;16120,1,5;
        ;;16120,1,6;~<Explanation:>~  The NEW command temporarily removes variables;
        ;;16120,1,7;the removed variables are returned to their original $DATA
        ;;16120,1,8;status and value (if any) upon QUITing (explicitly or imp-
        ;;16120,1,9;licitly) out of the current DO or XECUTE.  Only local,
        ;;16120,1,10;unsubscripted variables can be used in the argument of a
        ;;16120,1,11;NEW command. ;
        ;;16120,1,12;
        ;;16120,1,13;Without arguments, NEW temporarily removes all existing
        ;;16120,1,14;local variables, including descendant values. ;
        ;;16120,1,15;
        ;;16120,1,16;When an argument is specified, the local variables named in
        ;;16120,1,17;the argument are temporarily removed along with their des-
        ;;16120,1,18;cendants.  In the second example, local variables A and
        ;;16120,1,19;SAVE are removed. ;
        ;;16120,1,20;
        ;;16120,1,21;The third example shows the "exclusive" form of NEW which
        ;;16120,1,22;is a special form in which the argument is a series of un-
        ;;16120,1,23;subscripted local variables (such as A and SAVE) contained
        ;;16120,1,24;in parentheses;  all local variables are temporarily
        ;;16120,1,25;removed except those named and their descendants. ;
        ;;16130;Command:  OPEN||13
        ;;16130,1,1;~<Examples:>~
        ;;16130,1,2;  OPEN 4
        ;;16130,1,3;  O 7:(devparms):1
        ;;16130,1,4;
        ;;16130,1,5;~<Explanation:>~  The OPEN command is used to obtain exclusive
        ;;16130,1,6;ownership of a device.  It does not affect the "current
        ;;16130,1,7;device" with which the routine is interacting.  Implementa-
        ;;16130,1,8;tion specific device parameters may be placed after a
        ;;16130,1,9;device name.  Ownership is relinquished upon execution of
        ;;16130,1,10;the CLOSE command. ;
        ;;16130,1,11;
        ;;16130,1,12;A "timeout" may be affixed to any argument to abort an
        ;;16130,1,13;unsuccessful attempt to OPEN that device. ;
        ;;16140;Command:  QUIT||13
        ;;16140,1,1;~<Examples:>~
        ;;16140,1,2;  QUIT
        ;
