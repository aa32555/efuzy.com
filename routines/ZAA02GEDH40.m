%ZAA02GEDH40 
	F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
	W "." G ^ZAA02GEDH41
D Q
	;;16140,1,3;  Q RESULT
	;;16140,1,4;  Q 37*N
	;;16140,1,5;
	;;16140,1,6;~<Explanation:>~  QUIT defines an exit point following a FOR, a
	;;16140,1,7;DO or an XECUTE command, or termination of an extrinsic
	;;16140,1,8;function. ;
	;;16140,1,9;
	;;16140,1,10;Normally used without arguments, the QUIT command takes an
	;;16140,1,11;argument only when terminating an extrinsic function, in
	;;16140,1,12;which case the value of the argument will be the value
	;;16140,1,13;returned from the extrinsic function. ;
	;;16150;Command:  READ||23
	;;16150,1,1;~<Examples:>~
	;;16150,1,2;  READ VALUE1,VALUE2
	;;16150,1,3;  R *A
	;;16150,1,4;  R C#1
	;;16150,1,5;  R "Prompt: ",ANSWER
	;;16150,1,6;  R X:30
	;;16150,1,7;
	;;16150,1,8;~<Explanation:>~  READ enables data from the current device to
	;;16150,1,9;be assigned to a named local variable. ;
	;;16150,1,10;
	;;16150,1,11;When an asterisk precedes a variable name in the argument
	;;16150,1,12;list, the decimal value of one character is obtained. ;
	;;16150,1,13;
	;;16150,1,14;When the argument contains a # following the variable name,
	;;16150,1,15;and the # is followed by a numeric expression, this expres-
	;;16150,1,16;sion specifies the maximum number of characters to be read. ;
	;;16150,1,17;
	;;16150,1,18;Any text and format control characters, such as the ! (Car-
	;;16150,1,19;riage Return/Line Feed) and the # (Form Feed) in the argu-
	;;16150,1,20;ment of the READ command are output on the current device. ;
	;;16150,1,21;
	;;16150,1,22;The amount of time for completion of input may be specified
	;;16150,1,23;by affixing a timeout to an argument of the read. ;
	;;16160;Command:  SET||18
	;;16160,0,"$PIECE";14110
	;;16160,1,1;~<Examples:>~
	;;16160,1,2;  SET NEW="BEG"
	;;16160,1,3;  S X="B",GO(1)=9
	;;16160,1,4;  S (I,J,J)=1
	;;16160,1,5;
	;;16160,1,6;~<Explanation:>~  The SET command provides the means for assign-
	;;16160,1,7;ing values to variables.  When a list of variable names in
	;;16160,1,8;parentheses is placed between the SET command and the
	;;16160,1,9;assignment symbol ("="), each named variable is given the
	;;16160,1,10;value following the assignment symbol. ;
	;;16160,1,11;
	;;16160,1,12;Note that the expression following the assignment symbol is
	;;16160,1,13;evaluated ~(before)~ the named variable(s), as in the following:
	;;16160,1,14;
	;;16160,1,15;SET(T)=COUNT(T)+1
	;;16160,1,16;
	;;16160,1,17;Also note that "pieces" of a variable can be set.  See the
	;;16160,1,18;function ~<$PIECE>~. ;
	;;16170;Command:  USE||13
	;;16170,1,1;~<Examples:>~
	;;16170,1,2;  U 4
	;;16170,1,3;  U MT+2:(devparms)
	;;16170,1,4;
	;;16170,1,5;~<Explanation:>~  USE designates a specific device (such as
	;;16170,1,6;device number 4 or device MT+2) as the current device for
	;;16170,1,7;input and output, or device status.  Device designators are
	;;16170,1,8;implementation-specific. ;
	;;16170,1,9;
	;;16170,1,10;Before a device can USEd, its ownership must first be es-
	;;16170,1,11;tablished with the OPEN command.  As with the CLOSE and OPEN
	;;16170,1,12;commands, implementation-specific device parameters may be
	;;16170,1,13;appended to the device designator. ;
	;;16180;Command:  VIEW||5
	;;16180,1,1;~<Example:>~
	;;16180,1,2;  Implementation Specific
	;;16180,1,3;
	;;16180,1,4;~<Explanation:>~  VIEW provides a means for examining or modify-
	;;16180,1,5;ing implementation-dependant information. ;
	;;16190;Command:  WRITE||15
	;
	;