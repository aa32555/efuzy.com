%ZAA02GEDH25
	F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
	W "." G ^ZAA02GEDH26
D Q
	;;2321,1,45;played, the number of levels can be reduced interactively. ;
	;;2321,1,46;Examples:
	;;2321,1,47;
	;;2321,1,48;  ^GLO                Display entire global
	;;2321,1,49;
	;;2321,1,50;  ^GLO("A",           Display only descendants of first
	;;2321,1,51;                      level node "A"
	;;2321,1,52;
	;;2321,1,53;  ^GLO("A":"E",       Display descendants of first level
	;;2321,1,54;                      nodes with values that equal or
	;;2321,1,55;                      follow an "A", and equal or precede
	;;2321,1,56;                      an "E"
	;;2322;Editing Global References||12
	;;2322,1,1;The following function keys are available when editing a
	;;2322,1,2;global reference:
	;;2322,1,3;
	;;2322,1,4;  Abort edit                                  ~<{EX}>~
	;;2322,1,5;  Finish edit, proceed to edit data           ~<{CR}>~
	;;2322,1,6;
	;;2322,1,7;  Advance ten character positions             ~<{TB}>~
	;;2322,1,8;  Move cursor RIGHT                           ~<{RK}>~
	;;2322,1,9;  Move cursor LEFT                            ~<{LK}>~
	;;2322,1,10;  Insert Character                            ~<{IC}>~
	;;2322,1,11;  Delete Character                            ~<{DC}>~
	;;2322,1,12;  Erase to end-of-field                       ~<{EF}>~
	;;2323;Editing Global Data||16
	;;2323,1,1;When editing the data portion of a global node, the
	;;2323,1,2;following function keys are available:
	;;2323,1,3;
	;;2323,1,4;  Abort edit                                  ~<{EX}>~
	;;2323,1,5;  Finish edit                                 ~<{CR}>~
	;;2323,1,6;
	;;2323,1,7;  Advance ten character positions             ~<{TB}>~
	;;2323,1,8;  Move cursor RIGHT                           ~<{RK}>~
	;;2323,1,9;  Move cursor LEFT                            ~<{LK}>~
	;;2323,1,10;
	;;2323,1,11;  Insert Character                            ~<{IC}>~
	;;2323,1,12;  Delete Character                            ~<{DC}>~
	;;2323,1,13;  Erase to end-of-field                       ~<{EF}>~
	;;2323,1,14;
	;;2323,1,15;  Edit characters whose ASCII values range
	;;2323,1,16;    from 0-31 and 127-255.                    ~<{SE}>~
	;;2330;Global List Utility||28
	;;2330,0,"Conventions";2190
	;;2330,1,1;This utility produces listings of the content and structure
	;;2330,1,2;of globals. ;
	;;2330,1,3;
	;;2330,1,4;~(Step 1)~.  From the Functions menu, select Utilities. ;
	;;2330,1,5;         From the Utilities menu, select Global. ;
	;;2330,1,6;         From the Global Utilities, select List. ;
	;;2330,1,7;
	;;2330,1,8;~(Step 2)~.  Select the global to be listed.  AA UTILS' Global
	;;2330,1,9;Listing utility allows you to print as much, or as little,
	;;2330,1,10;of the selected global as you want.  The following examples
	;;2330,1,11;which can be used in combination, illustrate how to make
	;;2330,1,12;the request. ;
	;;2330,1,13;
	;;2330,1,14;  ^GLO            Print entire global
	;;2330,1,15;
	;;2330,1,16;  ^GLO("A",       Print descendants of first level node "A"
	;;2330,1,17;
	;;2330,1,18;  ^GLO("A":"E",   Print descendants of first level nodes
	;;2330,1,19;                  from "A" to "E" inclusive
	;;2330,1,20;
	;;2330,1,21;  ^GLO()          Print all nodes at first level of global
	;;2330,1,22;
	;;2330,1,23;  ^GLO(,,)        Print all nodes at first three levels of
	;;2330,1,24;                  global
	;;2330,1,25;
	;
	;