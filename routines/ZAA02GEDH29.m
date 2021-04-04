%ZAA02GEDH29
	F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
	W "." G ^ZAA02GEDH30
D Q
	;;12040;Special Variable:  $STORAGE||4
	;;12040,1,1;$S is the number of unused bytes of local memory available
	;;12040,1,2;to the current process (or job).  The usefulness and meaning
	;;12040,1,3;of this value, however, may vary from implementation to
	;;12040,1,4;implementation. ;
	;;12050;Special Variable:  $TEST||5
	;;12050,1,1;$T contains the last computed truth value within the scope
	;;12050,1,2;of the current argumentless DO, extrinsic function, or
	;;12050,1,3;extrinsic variable.  The value is set by the execution of
	;;12050,1,4;the IF command containing an argument, or by an OPEN, LOCK,
	;;12050,1,5;VIEW, or READ without a timeout. ;
	;;12060;Special Variable:  $X||9
	;;12060,1,1;$X is the column or horizontal position at which the
	;;12060,1,2;carriage (for a printing device) or the cursor (for a video
	;;12060,1,3;terminal) lies for the current device.  The first column is
	;;12060,1,4;defined as column 0, the second as column 1, and so on. ;
	;;12060,1,5;
	;;12060,1,6;Therefore, $X is 0 at the start of a line.  After the first
	;;12060,1,7;character in a line has been written, $X is 1.  $X is init-
	;;12060,1,8;ialized to zero by carriage return, and incremented by 1
	;;12060,1,9;for graphics. ;
	;;12070;Special Variable:  $Y||4
	;;12070,1,1;$Y is the vertical position on the current device.  The
	;;12070,1,2;first line is defined as line 0, the second as line 1, and
	;;12070,1,3;so on.  $Y is initialized to zero by a form feed, and
	;;12070,1,4;incremented by 1 for each line feed. ;
	;;14000;MUMPS Intrinsic Functions||28
	;;14000,0,"$ASCII";14010
	;;14000,0,"$CHAR";14020
	;;14000,0,"$DATA";14030
	;;14000,0,"$EXTRACT";14040
	;;14000,0,"$FIND";14050
	;;14000,0,"$FNUMBER";14060
	;;14000,0,"$GET";14070
	;;14000,0,"$JUSTIFY";14080
	;;14000,0,"$LENGTH";14090
	;;14000,0,"$ORDER";14100
	;;14000,0,"$PIECE";14110
	;;14000,0,"$QUERY";14120
	;;14000,0,"$RANDOM";14130
	;;14000,0,"$SELECT";14140
	;;14000,0,"$TEXT";14150
	;;14000,0,"$TRANSLATE";14160
	;;14000,0,"$VIEW";14170
	;;14000,1,1;Information is provided regarding the syntax ans use of the
	;;14000,1,2;following MUMPS Intrinsic Functions.  SELECT and OPEN the
	;;14000,1,3;text describing the desired function. ;
	;;14000,1,4;
	;;14000,1,5;  ~<$ASCII>~       Returns the decimal value of an ASCII char
	;;14000,1,6;  ~<$CHAR>~        Returns the char value of a decimal number
	;;14000,1,7;  ~<$DATA>~        Returns info regarding the characteristics
	;;14000,1,8;                 of a local or global variable
	;;14000,1,9;  ~<$EXTRACT>~     Returns a specified subset of a string
	;;14000,1,10;  ~<$FIND>~        Returns the location of a string in another
	;;14000,1,11;  ~<$FNUMBER>~     Returns numbers in various formats
	;;14000,1,12;  ~<$GET>~         Returns data from a variable if it exists
	;;14000,1,13;                 or a specified alternate value
	;;14000,1,14;  ~<$JUSTIFY>~     Returns right justified numbers and strings
	;;14000,1,15;  ~<$LENGTH>~      Returns the length of a string, or the
	;;14000,1,16;                 number of occurrences +1 of a second string
	;;14000,1,17;  ~<$ORDER>~       Returns the next subscript in a subscripted
	;;14000,1,18;                 local or global variable
	;;14000,1,19;  ~<$PIECE>~       Returns a substring between specified occur-
	;;14000,1,20;                 rences of a specified delimiter
	;
	;