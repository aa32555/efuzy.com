%ZAA02GEDH36
	F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
	W "." G ^ZAA02GEDH37
D Q
	;;16020,1,3;  D NEW,OLD             
	;;16020,1,4;  D ^RTN                
	;;16020,1,5;  D LABEL^RTN
	;;16020,1,6;  D @VAR
	;;16020,1,7;  D SUB(NA,@X,"9",.SL)
	;;16020,1,8;
	;;16020,1,9;~<Explanation:>~  The argumentless DO command begins execution
	;;16020,1,10;of the next "sub-block" of code following the line contain-
	;;16020,1,11;ing the argumentless DO.  Each line in the sub-block will
	;;16020,1,12;begin with a period or, if the line containing the argument-
	;;16020,1,13;less DO is itself within a sub-block, on period more than
	;;16020,1,14;the number of periods at the beginning of the line contain-
	;;16020,1,15;ing the argumentless DO.  On termination of execution of
	;;16020,1,16;the sub-block (by either an explicit or implicit QUIT),
	;;16020,1,17;execution continues after the argumentless DO. ;
	;;16020,1,18;
	;;16020,1,19;Each of the line labels (for example, NEW and OLD) listed
	;;16020,1,20;in the argument are found in turn and the code following
	;;16020,1,21;each label is executed until the end (specified below) is
	;;16020,1,22;reached. ;
	;;16020,1,23;
	;;16020,1,24;If a circumflex (^) precedes a label (as in the case of RTN)
	;;16020,1,25;the routine whose name (RTN) follows the "^" is executed. ;
	;;16020,1,26;
	;;16020,1,27;Execution starts at the first line of the named routine un-
	;;16020,1,28;less a line label (e.g., LABEL) is specified in front of the
	;;16020,1,29;"^".  In the latter case, execution starts in the routine
	;;16020,1,30;named RTN at the line labelled LABEL.  Execution returns
	;;16020,1,31;immediately to the next argument of the next command after
	;;16020,1,32;executing a QUIT command or reaching the end of a routine
	;;16020,1,33;(provided this was not within the scope of a subsequent DO
	;;16020,1,34;command or a FOR command). ;
	;;16020,1,35;
	;;16020,1,36;Indirection (e.g., @VAR) can be used to begin execution of
	;;16020,1,37;the line or routine whose label is contained in a variable. ;
	;;16020,1,38;
	;;16020,1,39;A list of parameters may be appended only if the label being
	;;16020,1,40;called has an appended list of variables at least as long as
	;;16020,1,41;the list of parameters.  In the example, the label SUB may
	;;16020,1,42;appear in the code as SUB(A,B,C,D,E).  When execution begins
	;;16020,1,43;at the label SUB, each of the 5 variables in the receiving
	;;16020,1,44;list (A,B,C,D, and E) are NEWed, then each of the parameters
	;;16020,1,45;is evaluated starting at the left and the resulting value
	;;16020,1,46;stored in the corresponding receiving variable (e.g., the
	;;16020,1,47;value of NA is stored in A), X in B, 9 in C, and the value
	;;16020,1,48;of SL is stored in D; variable E remains undefined).  Vari-
	;;16020,1,49;ables in the parameter list preceded by a period will re-
	;;16020,1,50;flect the changes to the receiving variable (e.g., the var-
	;;16020,1,51;iable SL will contain the value of the variable D when the
	;;16020,1,52;subroutine SUB is completed; if D is KILLed, SL will be
	;;16020,1,53;undefined). ;
	;;16030;Command:  ELSE||10
	;;16030,1,1;~<Example:>~
	;;16030,1,2;  IF X<10 SET Y=0
	;;16030,1,3;  ELSE SET Y=X\10
	;;16030,1,4;
	;;16030,1,5;~<Explanation:>~  ELSE permits conditional execution depending
	;;16030,1,6;on the value of the special variable $TEST.  Execution of
	;;16030,1,7;the remainder of the line to the right of the ELSE command
	;
	;