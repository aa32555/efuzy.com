%ZAA02GEDH35
	F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
	W "." G ^ZAA02GEDH36
D Q
	;;16000,1,1;Information is provided regarding the syntax and use of the
	;;16000,1,2;following MUMPS commands.  SELECT and OPEN the text describ-
	;;16000,1,3;ing the desired command. ;
	;;16000,1,4;
	;;16000,1,5;  ~<BREAK>~      Interrupt program execution for debugging
	;;16000,1,6;  ~<CLOSE>~      Release a device owned by the current job
	;;16000,1,7;  ~<DO>~         Call a routine or subroutine
	;;16000,1,8;  ~<ELSE>~       Execution conditional on value of $TEST
	;;16000,1,9;  ~<FOR>~        Repeat execution until QUIT or GOTO reached
	;;16000,1,10;  ~<GOTO>~       Transfers control to a new line or routine
	;;16000,1,11;  ~<HALT>~       Terminate the current process
	;;16000,1,12;  ~<HANG>~       Suspend execution for a period of time
	;;16000,1,13;  ~<IF>~         Execution conditional on value of $TEST
	;;16000,1,14;  ~<JOB>~        Initiate a new, independent process
	;;16000,1,15;  ~<KILL>~       Remove local or global variables
	;;16000,1,16;  ~<LOCK>~       A generalized interlock facility
	;;16000,1,17;  ~<NEW>~        Stack variables to create a new environment
	;;16000,1,18;  ~<OPEN>~       Obtain ownership of a device and set params
	;;16000,1,19;  ~<QUIT>~       Terminates execution of a DO, FOR or routine
	;;16000,1,20;  ~<READ>~       Read information from the current device
	;;16000,1,21;  ~<SET>~        Assign values to local or global variables
	;;16000,1,22;  ~<USE>~        Change the current device (or set parameters)
	;;16000,1,23;  ~<VIEW>~       Read/Write system memory
	;;16000,1,24;  ~<WRITE>~      Output to the current device
	;;16000,1,25;  ~<XECUTE>~     Interpret and execute specified MUMPS code
	;;16000,1,26;  ~<ZCOMMANDS>~  Implementation-specific commands
	;;16000,1,27;
	;;16000,1,28;SELECT and OPEN the desired category. ;
	;;16001;Command:  BREAK||16
	;;16001,1,1;~<Example:         Action>~
	;;16001,1,2;  B              Break
	;;16001,1,3;  B:X=""         Break if X is null
	;;16001,1,4;
	;;16001,1,5;~<Explanation:>~   When used without arguments (e.g., "B  ") in
	;;16001,1,6;a line of MUMPS code, the BREAK command causes the process
	;;16001,1,7;to be interupted.  In most implementations of MUMPS,
	;;16001,1,8;debugging aids are then invoked to permit examination of
	;;16001,1,9;the local and global variables as they existed at the time
	;;16001,1,10;the BREAK was encountered.  Refer to your implementation's
	;;16001,1,11;manuals for descriptions of these aids, if any. ;
	;;16001,1,12;
	;;16001,1,13;The 1990 MUMPS Standard does not specify the syntax or
	;;16001,1,14;execution of arguments to the BREAK command.  Implementa-
	;;16001,1,15;tion-specific arguments may be available.  Refer to your
	;;16001,1,16;system documentation. ;
	;;16010;Command:  CLOSE||10
	;;16010,1,1;~<Examples:>~
	;;16010,1,2;  CLOSE DEV
	;;16010,1,3;  C MT1:(devparms)
	;;16010,1,4;
	;;16010,1,5;~<Explanation:>~  CLOSE releases the listed devices from owner-
	;;16010,1,6;ship; for example, it releases device 4 (or MT1.  A list of
	;;16010,1,7;implementation-specific device parameters may be placed
	;;16010,1,8;after a device name if desired.  If the current device is
	;;16010,1,9;closed, the special variable $IO will be empty or reset to
	;;16010,1,10;a default value depending on the implementation of MUMPS. ;
	;;16020;Command:  DO||53
	;;16020,1,1;~<Examples:>~
	;;16020,1,2;  DO                    
	;
	;