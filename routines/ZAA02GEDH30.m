%ZAA02GEDH30 ;;%AA UTILS;1.21;(Subroutine);19JUL91  16:30
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
        ;Loaded July 19, 1991 at 4:03 PM
        F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
        W "." G ^ZAA02GEDH31
D Q
        ;;14000,1,21;  ~<$QUERY>~       Returns the next full global reference
        ;;14000,1,22;  ~<$RANDOM>~      Returns a pseudo-random number
        ;;14000,1,23;  ~<$SELECT>~      Returns the value of the first true condition
        ;;14000,1,24;                 in a list of conditions
        ;;14000,1,25;  ~<$TEXT>~        Returns text from a specifed line of code
        ;;14000,1,26;  ~<$TRANSLATE>~   Returns a translated string
        ;;14000,1,27;  ~<$VIEW>~        Returns the contents of memory or view buffer
        ;;14000,1,28;  ~<$ZFUNCTIONS>~  Implementation-specific instrinsic functions
        ;;14010;Intrinsic Function:  $ASCII||16
        ;;14010,1,1;~<Syntax:>~
        ;;14010,1,2;  $ASCII(E1)       ...where E1 is a string or an expression
        ;;14010,1,3;                   resulting in a string
        ;;14010,1,4;  $A(E1,I1)        ...where I1 is an integer
        ;;14010,1,5;
        ;;14010,1,6;~<Examples:>~          ~<Result>~
        ;;14010,1,7;  $A("ABC")        65
        ;;14010,1,8;  $A("ABC",1)      65
        ;;14010,1,9;  $A("ABC",2)      66
        ;;14010,1,10;  $A(X,2)          66 where X="ABC"
        ;;14010,1,11;  $A("")           -1
        ;;14010,1,12;
        ;;14010,1,13;~<Explanation:>~  From string E1, $ASCII returns the ASCII
        ;;14010,1,14;decimal value of the character which is at the position in
        ;;14010,1,15;the string identified by optional pointer I1.  If I1 is not
        ;;14010,1,16;explicitly specified, it is assumed to have a value of 1. ;
        ;;14020;Intrinsic Function:  $CHARACTER||16
        ;;14020,1,1;~<Syntax:>~
        ;;14020,1,2;  $CHAR(I1)        ...where I1 is an integer in the range
        ;;14020,1,3;                   of {0..255} or an expression yielding
        ;;14020,1,4;                   such an integer
        ;;14020,1,5;  $C(I1,I2,..In)   ...where I2 through In are such integers
        ;;14020,1,6;
        ;;14020,1,7;~<Examples:>~          ~<Result>~
        ;;14020,1,8;  $C(65)           "A"
        ;;14020,1,9;  $C(66)           "B"
        ;;14020,1,10;  $C(65,66)        "AB"
        ;;14020,1,11;  $C(65,-1,66)     "AB"
        ;;14020,1,12;
        ;;14020,1,13;~<Explanation:>~  $CHAR translates a set of integers in the
        ;;14020,1,14;range {0..255} to their ASCII character value.  I1 through
        ;;14020,1,15;In are expressions whose values are interpreted as
        ;;14020,1,16;integers.  A negative number results in an empty string. ;
        ;;14030;Intrinsic Function:  $DATA||14
        ;;14030,1,1;~<Syntax:>~
        ;;14030,1,2;  $D(VN)          where VN is a local or global variable
        ;;14030,1,3;                  name or expression yielding one
        ;;14030,1,4;
        ;;14030,1,5;~<Examples:>~         ~<Results>~
        ;;14030,1,6;  $D(Y)            0 if Y does not exist
        ;;14030,1,7;                   1 if Y has a value but no descendants
        ;;14030,1,8;                  10 if Y has no value but has descendants
        ;;14030,1,9;                  11 if Y has a value and descendants
        ;;14030,1,10;
        ;;14030,1,11;~<Explanation:>~  $DATA returns an integer specifying the
        ;;14030,1,12;condition of a variable.  VN is the name of the variable of
        ;;14030,1,13;interest.  The values returned are integers as described
        ;;14030,1,14;above. ;
        ;;14040;Intrinsic Function:  $EXTRACT||19
        ;;14040,1,1;~<Syntax:>~
        ;;14040,1,2;  $EXTRACT(E1)    ...where E1 is a string or an expression
        ;;14040,1,3;                  resulting in a string
        ;;14040,1,4;  $E(E1,I1)       ...where I1 is an optional integer
        ;;14040,1,5;  $E(E1,I1,I2)    ...where I2 is another integer
        ;;14040,1,6;
        ;;14040,1,7;~<Examples:>~         ~<Results>~
        ;
