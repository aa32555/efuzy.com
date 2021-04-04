%ZAA02GEDH38
	F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
	W "." G ^ZAA02GEDH39
D Q
	;;16080,1,8;~<Explanation:>~  IF enables conditional execution.  When used
	;;16080,1,9;without arguments, execution is dependent upon the value of
	;;16080,1,10;the special variable $TEST.  If the value of $TEST is 0
	;;16080,1,11;(false), the remainder of the line to the right of the IF
	;;16080,1,12;is not executed;  If the value of $TEST is 1 (true), exe-
	;;16080,1,13;cution continues normally at the next command on the line. ;
	;;16080,1,14;If one argument is present (such as A=3), the argument is
	;;16080,1,15;evaluated to be true or false and $TEST is set to 1 or 0
	;;16080,1,16;respectively; then the IF command is executed as in the
	;;16080,1,17;argumentless form.  A series of arguments following an IF
	;;16080,1,18;command is treated like a series of IF commands with single
	;;16080,1,19;arguments, the ultimate result being the same as if the
	;;16080,1,20;arguments were 'and'-ed together, except that as soon as
	;;16080,1,21;one false argument is found, interpretation and execution
	;;16080,1,22;of the line ceases. ;
	;;16090;Command:  JOB||16
	;;16090,1,1;~<Examples:>~
	;;16090,1,2;  J ^ROU
	;;16090,1,3;  J LINE^ROU
	;;16090,1,4;  J LINE^ROU(2,NM)
	;;16090,1,5;
	;;16090,1,6;~<Explanation:>~  JOB initiates execution of code in parallel
	;;16090,1,7;to the routine that invokes it.  A new process (a job) is
	;;16090,1,8;started (without ~(any)~ local variables) at the routine entry
	;;16090,1,9;point specified, but the invoking routine also continues
	;;16090,1,10;execution. ;
	;;16090,1,11;
	;;16090,1,12;If the routine name is followed by a parameter list, the
	;;16090,1,13;entry point specified must have a list of receiving vari-
	;;16090,1,14;ables which are initialized in the same manner as parameter
	;;16090,1,15;passing using the DO command.  Note that call by reference
	;;16090,1,16;is ~(not)~ allowed. ;
	;;16100;Command:  KILL||20
	;;16100,1,1;~<Examples:>~
	;;16100,1,2;  K
	;;16100,1,3;  K A,NEW,^LP(3)
	;;16100,1,4;  K (SAVE,A)
	;;16100,1,5;
	;;16100,1,6;~<Explanation:>~  Without arguments, KILL permanently removes
	;;16100,1,7;all existing local variables, including subscripted local
	;;16100,1,8;variables. ;
	;;16100,1,9;
	;;16100,1,10;When an argument is specified, the local and global vari-
	;;16100,1,11;ables named in the argument are deleted together with all
	;;16100,1,12;descendant variables.  In the second example, local vari-
	;;16100,1,13;ables A and NEW are removed, as are all nodes in global LP
	;;16100,1,14;which have a first-level subscript of 3. ;
	;;16100,1,15;
	;;16100,1,16;The "exclusive KILL" is a special form of the KILL command
	;;16100,1,17;where the argument of the KILL command is a series of un-
	;;16100,1,18;subscripted local variables (such as SAVE and A) contained
	;;16100,1,19;in parentheses; all local variables are killed ~(except)~ those
	;;16100,1,20;named and their descendants. ;
	;;16110;Command:  LOCK||35
	;;16110,1,1;~<Examples:>~
	;;16110,1,2;  L
	;;16110,1,3;  L ^MUG L (B,^G(4))
	;;16110,1,4;  L X123:1
	;;16110,1,5;  L +^INDEX
	;;16110,1,6;  L -^INDEX
	;;16110,1,7;
	;;16110,1,8;~<Explanation:>~  LOCK is used primarily as a software conven-
	;;16110,1,9;tion to avoid conflicting updates of named resources, pri-
	;;16110,1,10;marily global variables.  For the non-incremental LOCK
	;;16110,1,11;(i.e., the argument is not preceded with a + or -), when
	;
	;