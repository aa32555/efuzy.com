%ZAA02GEDH31 ;;%AA UTILS;1.21;(Subroutine);19JUL91  16:30
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
        ;Loaded July 19, 1991 at 4:03 PM
        F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
        W "." G ^ZAA02GEDH32
D Q
        ;;14040,1,8;  $E("ABC")       "A"
        ;;14040,1,9;  $E(V,2)         "B" if V="ABC"
        ;;14040,1,10;  $E(V,3,5)       "CDE" if V="ABCDE"
        ;;14040,1,11;  $E(V,3,999)     "CDE" iv V="ABCDE"
        ;;14040,1,12;  $E(V,99)        if V is less than 99 characters long
        ;;14040,1,13;  $E("ABC",-6,2)  "AB"
        ;;14040,1,14;
        ;;14040,1,15;~<Explanation:>~  $EXTRACT returns the substring of the string
        ;;14040,1,16;E1 which begins at character position I1 and ends at I2 or
        ;;14040,1,17;at the end of the string, whichever occurs first.  If I2 is
        ;;14040,1,18;not present, it is assumed to be equal to I1.  If I1 is not
        ;;14040,1,19;present, it is assumed to have a value of 1. ;
        ;;14050;Intrinsic Function:  $FIND||20
        ;;14050,1,1;~<Syntax:>~
        ;;14050,1,2;  $FIND(E1,E2)      ...where E1 and E2 are each a string or
        ;;14050,1,3;                    an expression resulting in a string
        ;;14050,1,4;  $F(E1,E2,I3)      ...where I1 is an integer
        ;;14050,1,5;
        ;;14050,1,6;~<Examples:>~           ~<Results>~
        ;;14050,1,7;  $F("ABC","B")     3
        ;;14050,1,8;  $F(V,"A",3)       5 where V="ABCA"
        ;;14050,1,9;  $F("ABC","X")     0
        ;;14050,1,10;
        ;;14050,1,11;~<Explanation:>~  $FIND returns an integer which identifies the
        ;;14050,1,12;end-position-plus-one of substring E2 within string E1.  If
        ;;14050,1,13;a third expression, I3, is specified the search for E2 be-
        ;;14050,1,14;gins at character position I3.  Otherwise the search begins
        ;;14050,1,15;at position 1. ;
        ;;14050,1,16;
        ;;14050,1,17;If the portion of E1 beginning at I3 (or 1) is the empty
        ;;14050,1,18;string or does not contain E2, the result is 0.  If E2 is
        ;;14050,1,19;null and the portion of E1 specified by I3 is not, the re-
        ;;14050,1,20;sult is I3. ;
        ;;14060;Intrinsic Function:  $FNUMBER||26
        ;;14060,1,1;~<Syntax:>~
        ;;14060,1,2;  $FNUMBER(N1,FL)   ...where N1 is a number to be formatted
        ;;14060,1,3;                    and FL contains one or more of the fol-
        ;;14060,1,4;                    lowing format codes:
        ;;14060,1,5;
        ;;14060,1,6;                    +   display plus signs for positive N1
        ;;14060,1,7;                    -   suppress minus signs for negative N1
        ;;14060,1,8;                    ,   insert commas every third position
        ;;14060,1,9;                    T   trail any undisplayed sign
        ;;14060,1,10;                    P   display negative N1 in parens. NOTE
        ;;14060,1,11;                        this may not be used in combination
        ;;14060,1,12;                        with + or - or T
        ;;14060,1,13;
        ;;14060,1,14;  $FN(N1,FL,I3)     ...where I3 specifies the number of dec-
        ;;14060,1,15;                    imal places number N1 will be rounded to
        ;;14060,1,16;
        ;;14060,1,17;~<Examples:             Results>~
        ;;14060,1,18;  $FN(12,"+")         +12
        ;;14060,1,19;  $FN(-20,"T")        20-
        ;;14060,1,20;  $FN(-1,"P",2)       (1.00)
        ;;14060,1,21;  $FN(1234.5678,",")  1,234.5678
        ;;14060,1,22;
        ;;14060,1,23;~<Explanation:>~  $FNUMBER formats the number N1 according to
        ;;14060,1,24;the code(s) specified in format list FL.  When a third arg-
        ;;14060,1,25;ument is provided, N1 is rounded to have I3 decimal places
        ;;14060,1,26;including trailing zeroes, if necessary. ;
        ;;14070;Intrinsic Function:  $GET||14
        ;;14070,1,1;~<Syntax:>~
        ;;14070,1,2;  $GET(VN)        ...where VN is a local or global variable
        ;;14070,1,3;                  name
        ;
