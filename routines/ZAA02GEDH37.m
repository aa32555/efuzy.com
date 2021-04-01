%ZAA02GEDH37 ;;%AA UTILS;1.21;(Subroutine);19JUL91  16:30
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
        ;Loaded July 19, 1991 at 4:03 PM
        F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
        W "." G ^ZAA02GEDH38
D Q
        ;;16030,1,8;continues only if the value of $TEST is 0 (false).  If $TEST
        ;;16030,1,9;is 1 (true) any commands to the right of the ELSE are not
        ;;16030,1,10;executed.  ELSE does not take an argument. ;
        ;;16040;Command:  FOR||30
        ;;16040,1,1;~<Examples:>~
        ;;16040,1,2;  FOR I=7,"B"
        ;;16040,1,3;  F J=2:4:20
        ;;16040,1,4;  F K=1:1
        ;;16040,1,5;  F L=9:-1:0,15
        ;;16040,1,6;  F
        ;;16040,1,7;
        ;;16040,1,8;~<Explanation:>~  FOR specifies the repeated execution of all
        ;;16040,1,9;the commands following it on the line.  There are three
        ;;16040,1,10;formats.  First is the expression format in which a local
        ;;16040,1,11;variable is assigned a value such as 7, or BD. ;
        ;;16040,1,12;
        ;;16040,1,13;Second is the range format in which a local variable is set
        ;;16040,1,14;to an initial value and then incremented or decremented in
        ;;16040,1,15;specified steps until it reaches or exceeds a limiting val-
        ;;16040,1,16;lue; in the second example, the initial value 2, the incre-
        ;;16040,1,17;mental step is 4, and the limiting value is 20.  Note that
        ;;16040,1,18;in this case 18 is the last value of J for which the associ-
        ;;16040,1,19;ated commands will be executed. ;
        ;;16040,1,20;
        ;;16040,1,21;The third format is the "endless loop" format in which the
        ;;16040,1,22;loop is broken only by execution of a QUIT or GOTO command
        ;;16040,1,23;within the instructions following the FOR command. ;
        ;;16040,1,24;
        ;;16040,1,25;Any of these formats may be mixed (except for the argument-
        ;;16040,1,26;less format).  Note that a QUIT or GOTO command will termin-
        ;;16040,1,27;ate all forms of the FOR loop, not just the "endless loop"
        ;;16040,1,28;form, and that a QUIT will terminate only the most recent
        ;;16040,1,29;in a series of nested FOR loops, whereas GOTO will termin-
        ;;16040,1,30;ate all active FOR loops. ;
        ;;16050;Command:  GOTO||11
        ;;16050,1,1;~<Examples:>~
        ;;16050,1,2;  GOTO NEXT
        ;;16050,1,3;  G ^RTN
        ;;16050,1,4;  G LABEL^RTN
        ;;16050,1,5;  G @VAR
        ;;16050,1,6;
        ;;16050,1,7;~<Explanation:>~  GOTO transfers execution of code to a line of
        ;;16050,1,8;code in the current routine (e.g., G NEXT), to the first
        ;;16050,1,9;line of another routine (e.g., G ^RTN), or to a specified
        ;;16050,1,10;line in another routine (e.g., G LABEL^RTN).  If return of
        ;;16050,1,11;control is required, use the DO command. ;
        ;;16060;Command:  HALT||8
        ;;16060,1,1;~<Examples:>~
        ;;16060,1,2;  HALT
        ;;16060,1,3;  H
        ;;16060,1,4;
        ;;16060,1,5;~<Explanation:>~  Terminates execution of the current process
        ;;16060,1,6;after doing necessary housekeeping, such as issuing a LOCK
        ;;16060,1,7;command with no arguments, closing all devices owned by the
        ;;16060,1,8;process.  HALT does not take an argument. ;
        ;;16070;Command:  HANG||9
        ;;16070,1,1;~<Examples:>~
        ;;16070,1,2;  HANG 3
        ;;16070,1,3;  H SECONDS
        ;;16070,1,4;
        ;;16070,1,5;~<Explanation:>~  HANG suspends execution for the number of
        ;;16070,1,6;seconds specified by each argument (such as 3 or TIME).  If
        ;;16070,1,7;an argument is less than zero, execution is suspended for
        ;;16070,1,8;zero seconds.  Note that HANG ~(always)~ has an argument, while
        ;;16070,1,9;HALT ~(never)~ has an argument. ;
        ;;16080;Command:  IF||22
        ;;16080,1,1;~<Examples:>~
        ;;16080,1,2;  I
        ;;16080,1,3;  I A=3
        ;;16080,1,4;  I B="B",A>4
        ;;16080,1,5;  I C=4!(C=5)
        ;;16080,1,6;  I $D(X),X=4
        ;;16080,1,7;
        ;
