%ZAA02GEDH28 ;;%AA UTILS;1.21;(Subroutine);19JUL91  16:30
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
        ;Loaded July 19, 1991 at 4:03 PM
        F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
        W "." G ^ZAA02GEDH29
D Q
        ;;11000,1,8;
        ;;11000,1,9;~</>~    Divide             A/B   Divide A by B
        ;;11000,1,10;
        ;;11000,1,11;~<\>~    Integer divide     A\B   Divide A by B but return only
        ;;11000,1,12;                                integer portion of result
        ;;11000,1,13;
        ;;11000,1,14;~<#>~    Modulo divide      A#B   Divide A by B but return only
        ;;11000,1,15;                                decimal remainder of result
        ;;11000,1,16;
        ;;11000,1,17;~<=>~    Equal to           A=B   A equals B
        ;;11000,1,18;
        ;;11000,1,19;~<>>~    Greater than       A>B   A is greater than B
        ;;11000,1,20;
        ;;11000,1,21;~<<>~    Less than          A<B   A is less than B
        ;;11000,1,22;
        ;;11000,1,23;~<->~    Minus (Unary)      -A    Reverse the sign of A
        ;;11000,1,24;
        ;;11000,1,25;~<+>~    Plus (Unary)       +A    Force numeric conversion of A
        ;;11000,1,26;
        ;;11000,1,27;~<&>~    And                A&B   Determine if A and B are both
        ;;11000,1,28;                                true
        ;;11000,1,29;
        ;;11000,1,30;~<_>~    Concatenate        A_B   Concatenate B to A
        ;;11000,1,31;
        ;;11000,1,32;~<@>~    Indirect           @A    Use the contents of A
        ;;11000,1,33;
        ;;11000,1,34;~<'>~    Not                'A    Reverse the truth value of A
        ;;11000,1,35;
        ;;11000,1,36;~<[>~    String contains    A[B   Determine if string A contains
        ;;11000,1,37;                                string B
        ;;11000,1,38;
        ;;11000,1,39;~<]>~    String follows     A]B   Determine if string B follows
        ;;11000,1,40;                                string A in collating seq. ;
        ;;12000;MUMPS Special Variables||11
        ;;12000,0,"$HOROLOG";12010
        ;;12000,0,"$IO";12020
        ;;12000,0,"$JOB";12030
        ;;12000,0,"$STORAGE";12040
        ;;12000,0,"$TEST";12050
        ;;12000,0,"$X";12060
        ;;12000,0,"$Y";12070
        ;;12000,1,1;Information is provided regarding the syntax and use of the
        ;;12000,1,2;following MUMPS special variables.  SELECT and OPEN the text
        ;;12000,1,3;describing the desired variable. ;
        ;;12000,1,4;
        ;;12000,1,5;  ~<$HOROLOG>~    Internal date and time
        ;;12000,1,6;  ~<$IO>~         ID of current I/O device
        ;;12000,1,7;  ~<$JOB>~        Job Number assigned to the current process
        ;;12000,1,8;  ~<$STORAGE>~    Amount of local memory remaining in partition
        ;;12000,1,9;  ~<$TEST>~       Truth Value
        ;;12000,1,10;  ~<$X>~          Horizontal output position
        ;;12000,1,11;  ~<$Y>~          Vertical output position
        ;;12010;Special Variable:  $HOROLOG||12
        ;;12010,1,1;The current, internal system date and time can be accessed
        ;;12010,1,2;through the variable $H.  The variable contains a two-part
        ;;12010,1,3;with a comma between the parts. ;
        ;;12010,1,4;
        ;;12010,1,5;The first part is the number of days since 31 December 1840,
        ;;12010,1,6;and the second part is the number of seconds since midnight. ;
        ;;12010,1,7;
        ;;12010,1,8;Examples:
        ;;12010,1,9;
        ;;12010,1,10;     ~<0,0>~       the first second of 31 December 1840
        ;;12010,1,11;
        ;;12010,1,12; ~<54422,32400>~   9:00am on 1 January 1990
        ;;12020;Special Variable:  $IO||3
        ;;12020,1,1;$IO provides the unique identifier assigned to the current
        ;;12020,1,2;input/output device.  For example, the number assigned to
        ;;12020,1,3;the device you're currently using is ~<{IO}>~. ;
        ;;12030;Special Variable:  $JOB||2
        ;;12030,1,1;Each executing process (or job) in MUMPS has its own unique
        ;;12030,1,2;number, a positive integer, which is the value of $J. ;
        ;
