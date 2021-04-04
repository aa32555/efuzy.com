%ZAA02GEDH41
	F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
	W "." Q
D Q
	;;16190,1,1;~<Examples:>~
	;;16190,1,2;  WRITE "HELLO"
	;;16190,1,3;  W A,B,Z
	;;16190,1,4;  W *13
	;;16190,1,5;  W !?5,NAME
	;;16190,1,6;  W "AVG=",SUM/TOT
	;;16190,1,7;
	;;16190,1,8;~<Explanation:>~  The WRITE command specifies the output of
	;;16190,1,9;data and format control information to the currend device. ;
	;;16190,1,10;
	;;16190,1,11;When an argument includes an asterisk followed by an
	;;16190,1,12;integer value, one character whose ASCII code is the number
	;;16190,1,13;represented by the integer is sent to the current device. ;
	;;16190,1,14;The effect of this character at the device is device-
	;;16190,1,15;dependant and implementation specific. ;
	;;16200;Command:  XECUTE||8
	;;16200,1,1;~<Examples:>~
	;;16200,1,2;  X "S A=3"
	;;16200,1,3;
	;;16200,1,4;~<Explanation:>~  XECUTE provides a means of interpreting a
	;;16200,1,5;data value, created during program execution, as if it were
	;;16200,1,6;M code.  Each argument is interpreted as if it were a line
	;;16200,1,7;of M instructions (without a label or line-start
	;;16200,1,8;indicator). ;
	;
	;