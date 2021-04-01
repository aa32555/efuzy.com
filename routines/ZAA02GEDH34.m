%ZAA02GEDH34 ;;%AA UTILS;1.21;(Subroutine);26MAY92 1:49P
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
        ;Loaded July 19, 1991 at 4:03 PM
        F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
        W "." G ^ZAA02GEDH35
D Q
        ;;14140,1,13;to right order, until one is found with a truth value of 1
        ;;14140,1,14;(true), then returns the value of the right-hand expression
        ;;14140,1,15;of the same pair.  In each pair, the truth-valued expression
        ;;14140,1,16;(Tn) on the left is separated from its result expression on
        ;;14140,1,17;the right by a colon.  There may be one or more pairs in
        ;;14140,1,18;the series, but at least one of the truth-valued expressions
        ;;14140,1,19;must be true. ;
        ;;14150;Intrinsic Function:  $TEXT||27
        ;;14150,1,1;~<Syntax:>~
        ;;14150,1,2;  $TEXT(L1)            ...where L1 is a line label
        ;;14150,1,3;  $T(L1+I2)            ...where I1 is an integer expressing
        ;;14150,1,4;                       an offset from L1
        ;;14150,1,5;  $T(+I1)              ...where I1 is an absolute offset
        ;;14150,1,6;                       from the beginning of a routine
        ;;14150,1,7;  $T(^R1)              ...where ^R1 is a routine name
        ;;14150,1,8;  $T(L1^R1)
        ;;14150,1,9;  $T(L1+I1^R1)
        ;;14150,1,10;
        ;;14150,1,11;~<Examples:>~
        ;;14150,1,12;  $T(LINE)             The text of the line labeled LINE
        ;;14150,1,13;  $T(LINE+3)           The text of the third line after LINE
        ;;14150,1,14;  $T(+2)               The text of the second line
        ;;14150,1,15;  $T(+0)               The name of the routine
        ;;14150,1,16;  $T(LINE^RTN)         The text of line LINE in routine ^RTN
        ;;14150,1,17;  $T(^RTN)             The first line of routine ^RTN
        ;;14150,1,18;
        ;;14150,1,19;~<Explanation:>~  $TEXT returns the text of a specified line of
        ;;14150,1,20;the current routine, including the line-start indicator and
        ;;14150,1,21;label.  Lines may be referenced by label (L1), by a positive
        ;;14150,1,22;offset from a label (L1+I2), or by a positive offset from
        ;;14150,1,23;the beginning of the routine (+I1).  If the specified line
        ;;14150,1,24;does not exist, the empty string is returned.  Text from
        ;;14150,1,25;another routine can be obtained by following the label (L1)
        ;;14150,1,26;or label plus offset (L1+I2) by a circumflex (^) and the
        ;;14150,1,27;routine name. ;
        ;;14160;Intrinsic Function:  $TRANSLATE||15
        ;;14160,1,1;~<Syntax:>~
        ;;14160,1,2;  $TRANSLATE(E1,E2)
        ;;14160,1,3;  $TR(E1,E2,E3)
        ;;14160,1,4;
        ;;14160,1,5;~<Examples:>~
        ;;14160,1,6;  $TR("ABCABC","AC","a")  "aBaB"
        ;;14160,1,7;  $TR(35.63,".")          3563
        ;;14160,1,8;
        ;;14160,1,9;~<Explanation:>~  $TRANSLATE returns the string E1 modified by
        ;;14160,1,10;replacing every character in E1 that matches the nth char-
        ;;14160,1,11;acter in E2 with the nth character in E3.  If the nth char-
        ;;14160,1,12;acter in E3 is null, each character in E1 that matches the
        ;;14160,1,13;nth character in E2 is deleted.  In the two argument form,
        ;;14160,1,14;each occurrence of every character in E2 is removed from
        ;;14160,1,15;E1. ;
        ;;14170;Intrinsic Function:  $VIEW||4
        ;;14170,1,1;~<Explanation:>~  $VIEW is an implementation-specific function
        ;;14170,1,2;available, at the option of the implementor, for providing
        ;;14170,1,3;implementation-specific data.  Refer to documentation sup-
        ;;14170,1,4;plied with your implementation of MUMPS. ;
        ;;16000;MUMPS Commands||28
        ;;16000,0,"BREAK";16001
        ;;16000,0,"CLOSE";16010
        ;;16000,0,"DO";16020
        ;;16000,0,"ELSE";16030
        ;;16000,0,"FOR";16040
        ;;16000,0,"GOTO";16050
        ;;16000,0,"HALT";16060
        ;;16000,0,"HANG";16070
        ;;16000,0,"IF";16080
        ;;16000,0,"JOB";16090
        ;;16000,0,"KILL";16100
        ;;16000,0,"LOCK";16110
        ;;16000,0,"NEW";16120
        ;;16000,0,"OPEN";16130
        ;;16000,0,"QUIT";16140
        ;;16000,0,"READ";16150
        ;;16000,0,"SET";16160
        ;;16000,0,"USE";16170
        ;;16000,0,"VIEW";16180
        ;;16000,0,"WRITE";16190
        ;;16000,0,"XECUTE";16200
        ;
