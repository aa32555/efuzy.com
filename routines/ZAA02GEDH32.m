%ZAA02GEDH32 ;;%AA UTILS;1.21;(Subroutine);19JUL91  16:30
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
        ;Loaded July 19, 1991 at 4:03 PM
        F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
        W "." G ^ZAA02GEDH33
D Q
        ;;14070,1,4;  $G(VN,E1)       ...where E1 is an optional value
        ;;14070,1,5;
        ;;14070,1,6;~<Examples:>~         ~<Results>~
        ;;14070,1,7;  $GET(V)         "" if V does not have a value, or
        ;;14070,1,8;                  "ABC" if V="ABC"
        ;;14070,1,9;  $GET(V,0)       0 if V does not have a value, or
        ;;14070,1,10;                  123 if V=123
        ;;14070,1,11;
        ;;14070,1,12;~<Explanation:>~  $GET returns the value assigned to V if V has
        ;;14070,1,13;a value, or the value resulting from expression E1.  If E1
        ;;14070,1,14;is not supplied, it is assumed to be an empty string (""). ;
        ;;14080;Intrinsic Function:  $JUSTIFY||21
        ;;14080,1,1;~<Syntax:>~
        ;;14080,1,2;  $JUSTIFY(E1,I2)  ...where E1 is an expression and I2 is
        ;;14080,1,3;                   an integer
        ;;14080,1,4;  $J(N1,I2,I3)     ...where N1 is a number and I2 and I3
        ;;14080,1,5;                   are integers
        ;;14080,1,6;
        ;;14080,1,7;~<Examples:          Results>~
        ;;14080,1,8;  $J("ABC",5)      "  ABC"
        ;;14080,1,9;  $J(100,4)        " 100"
        ;;14080,1,10;  $J(V,6,2)        " 20.10" if V="20.095"
        ;;14080,1,11;  $J(-5/3,0,1)     "-1.7"
        ;;14080,1,12;
        ;;14080,1,13;~<Explanation:>~  $JUSTIFY with 2 arguments returns the value
        ;;14080,1,14;of expression E1, right-justified within a field of size I2. ;
        ;;14080,1,15;However, if I2 is less than or equal to the length of E1,
        ;;14080,1,16;the value of E1 is returned unchanged. ;
        ;;14080,1,17;
        ;;14080,1,18;When 3 arguments are provided, the numeric interpretation
        ;;14080,1,19;of N1 is formed, rounded to have I3 decimal places, includ-
        ;;14080,1,20;ing trailing zeroes, and the result is right justified in a
        ;;14080,1,21;field of length I2. ;
        ;;14090;Intrinsic Function:  $JUSTIFY||15
        ;;14090,1,1;~<Syntax:>~
        ;;14090,1,2;  $LENGTH(E1)      ...where E1 is an expression resulting
        ;;14090,1,3;                   in a value
        ;;14090,1,4;  $L(E1,E2)        ...where E2 yields a value which is con-
        ;;14090,1,5;                   tained in the value yielded by E2
        ;;14090,1,6;
        ;;14090,1,7;~<Examples:>~          ~<Results>~
        ;;14090,1,8;  $L("ABC")        3
        ;;14090,1,9;  $L(V)            0 where V=""
        ;;14090,1,10;  $L("ABCA","A")   3
        ;;14090,1,11;
        ;;14090,1,12;~<Explanation:>~  $LENGTH returns the number of characters in
        ;;14090,1,13;string E1; that is, it returns the length of E1.  When two
        ;;14090,1,14;arguments are provided, the number returned is the number-
        ;;14090,1,15;plus-one of non-overlapping occurrences of E2 in E1. ;
        ;;14100;Intrinsic Function:  $ORDER||16
        ;;14100,1,1;~<Syntax:>~
        ;;14100,1,2;  $ORDER(VN)        ...where VN is a local or global varia-
        ;;14100,1,3;                    ble name
        ;;14100,1,4;
        ;;14100,1,5;~<Examples:           Results if ST is subscripted by state>~
        ;;14100,1,6;  $O(ST("IOWA"))    "KANSAS"
        ;;14100,1,7;  $O(ST(""))        "ALABAMA"
        ;;14100,1,8;  $O(ST("Z")        ""
        ;;14100,1,9;
        ;;14100,1,10;~<Explanation:>~  $ORDER returns the next existing subscript, in
        ;;14100,1,11;collating sequence, from the array specified by VN.  The
        ;;14100,1,12;empty string ("") is used to find the first subscript, and
        ;;14100,1,13;is returned when VN specifies the last subscript contained
        ;;14100,1,14;in the array.  The ordering sequence arranges al canonic
        ;;14100,1,15;numeric subscripts in numberic sequence, followed by all
        ;;14100,1,16;other subscripts in ASCII collating order. ;
        ;
