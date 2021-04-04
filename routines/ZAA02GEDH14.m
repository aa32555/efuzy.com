%ZAA02GEDH14
	F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
	W "." G ^ZAA02GEDH15
D Q
	;;1510,1,14;COPY/MOVE menu. ;
	;;1510,1,15;
	;;1510,1,16;~(Step 2)~.  Using the cursor movement keys, highlight all of
	;;1510,1,17;the text to be saved.  To abort, press EXIT. ;
	;;1510,1,18;
	;;1510,1,19;~(Step 3)~.  Press COPY/MOVE again to mark the end of the text
	;;1510,1,20;to be saved.  When asked 'Save to: ', enter a name for the
	;;1510,1,21;text which will be easy to identify later.  The name may be
	;;1510,1,22;up to 15 characters long and is not case sensitive, so the
	;;1510,1,23;name 'INIT' will ~(not)~ be the same as the name 'init'. ;
	;;1510,1,24;
	;;1510,1,25;Complete the operation by pressing [RETURN].  The screen
	;;1510,1,26;will be refreshed and you will be returned to edit mode. ;
	;;1520;Swapline Up||13
	;;1520,1,1;SWAPLINE UP Function key:  ~<{SU}>~
	;;1520,1,2;
	;;1520,1,3;The Swapline Function switches the sequence of two lines. ;
	;;1520,1,4;Swapline Up swaps the current line with the one above it. ;
	;;1520,1,5;After the switch, the cursor remains with the line it
	;;1520,1,6;started on.  In this way a line can be moved up the routine
	;;1520,1,7;by repetitively pressing the SWAPLINE UP key. ;
	;;1520,1,8;
	;;1520,1,9;~(Step 1)~.  Place the cursor on the lower of the two lines to
	;;1520,1,10;be switched and press the SWAPLINE UP key.  Note that the
	;;1520,1,11;cursor can be on any part of the line, including continua-
	;;1520,1,12;tion lines.  The two lines will be reversed and you will be
	;;1520,1,13;placed back in edit mode. ;
	;;1530;Swapline Down||14
	;;1530,1,1;SWAPLINE DOWN Function key:  ~<{SD}>~
	;;1530,1,2;
	;;1530,1,3;The Swapline function switches the sequence of two lines. ;
	;;1530,1,4;Swapline Down swaps the current line with the line below
	;;1530,1,5;it.  After the switch is completed, the cursor remains with
	;;1530,1,6;the line it started on.  In this way, a line can be moved
	;;1530,1,7;down the routine by repetitively pressing the SWAPLINE DOWN
	;;1530,1,8;key. ;
	;;1530,1,9;
	;;1530,1,10;~(Step 1)~.  Place the cursor on the upper of the two lines to
	;;1530,1,11;be switched and press the SWAPLINE DOWN key.  Note that the
	;;1530,1,12;cursor can be on any part of the line, including continua-
	;;1530,1,13;tion lines.  The two lines will be reversed and you will be
	;;1530,1,14;placed back in edit mode. ;
	;;2000;AA UTILS Utilities||7
	;;2000,0,"Export Utility";2501
	;;2000,0,"Global Utilities";2300
	;;2000,0,"Import Utility";2502
	;;2000,0,"Routine Utilities";2100
	;;2000,1,1;AA UTILS provides many of the utilities programmers need to
	;;2000,1,2;create and maintain application systems.  These utilities
	;;2000,1,3;are available by selecting UTILITIES from the Function menu
	;;2000,1,4;and include the following:
	;;2000,1,5;
	;;2000,1,6;~<Routine Utilities>~     ~<Global Utilities>~     ~<Screen Utility>~
	;;2000,1,7;~<Import Utility>~        ~<Export Utility>~       ~<Form Utility>~
	;;2100;Routine Utilities||12
	;;2100,0,"Archive Routines";2110
	;;2100,0,"Compile Routines";2120
	;;2100,0,"Print Routine Directory";2130
	;;2100,0,"Print Routine Listings";2140
	;;2100,0,"Purge Routines from Workfile";2150
	;;2100,0,"Release Management";2160
	;;2100,0,"Search Routines";2170
	;;2100,0,"Search Routines & Replace";2180
	;;2100,0,"Utility Conventions";2190
	;;2100,1,1;AA UTILS provides the following utilities for managing
	;;2100,1,2;MUMPS routines:
	;;2100,1,3;
	;
	;