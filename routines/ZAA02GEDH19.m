%ZAA02GEDH19
	F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
	W "." G ^ZAA02GEDH20
D Q
	;;2190,1,37;prompted to interactively build a list of routines from
	;;2190,1,38;that source by selecting and/or deselecting specific
	;;2190,1,39;routines.  
	;;2190,1,40;
	;;2190,1,41;The simplest way to select a routine is to enter the name
	;;2190,1,42;of the routine and press [RETURN].  Conversely, to deselect
	;;2190,1,43;a routine, enter a hyphen "-" followed by the name of the
	;;2190,1,44;routine to be deselected. ;
	;;2190,1,45;
	;;2190,1,46;As routines are selected and deselected, the updated list
	;;2190,1,47;will be displayed and the number of routines selected and
	;;2190,1,48;the sum of their sizes will be shown at the top of the
	;;2190,1,49;screen.  In addition, the size, date last modified and
	;;2190,1,50;description of each of the selected routines are shown to
	;;2190,1,51;the right of each routine name. ;
	;;2190,1,52;
	;;2190,1,53;If the number of selected routines exceeds the available
	;;2190,1,54;space on the screen, the NEXT SCREEN and PREV SCREEN keys
	;;2190,1,55;can be used to page forward and back through the list. ;
	;;2190,1,56;Complete the selection process by pressing [RETURN] at an
	;;2190,1,57;empty 'routine: ' prompt, or abort the process at any time
	;;2190,1,58;by pressing the EXIT key. ;
	;;2190,1,59;
	;;2190,1,60;~(Wildcards)~.  AA UTILS supports several wildcards to shorten
	;;2190,1,61;the process of building a list of routines. ;
	;;2190,1,62;
	;;2190,1,63;  ~<*>~              Format:  ~<AAA*>~
	;;2190,1,64;
	;;2190,1,65;  Select all routines beginning with the characters that
	;;2190,1,66;  precede the asterisk, if any. ;
	;;2190,1,67;
	;;2190,1,68;  ~<:>~              Format:  ~<AAA:BBB>~
	;;2190,1,69;
	;;2190,1,70;  Select all routines beginning with the name preceding the
	;;2190,1,71;  colon and ending with the name following the colon. ;
	;;2190,1,72;  Neither name need be to an existing routine.  This
	;;2190,1,73;  wildcard may not be used in conjunction with the "*". ;
	;;2190,1,74;
	;;2190,1,75;  ~<>>~              Format:  ~<AAA>dateparam>~
	;;2190,1,76;
	;;2190,1,77;  Select all routines whose names begin with the characters
	;;2190,1,78;  that precede the ">" and which were modified subsequent to
	;;2190,1,79;  the date specified in the dateparam.  Format requirements
	;;2190,1,80;  for dateparams are discussed below. ;
	;;2190,1,81;
	;;2190,1,82;  ~<<>~              Format:  ~<AAA<dateparam>~
	;;2190,1,83;
	;;2190,1,84;  Select all routines whose names begin with the characters
	;;2190,1,85;  that precede the "<" and which were modified prior to the
	;;2190,1,86;  date specified in the dateparam. ;
	;;2190,1,87;
	;;2190,1,88;  ~<=>~              Format:  ~<AAA=dateparam>~
	;;2190,1,89;
	;;2190,1,90;  Select all routines whose names begin with the characters
	;;2190,1,91;  that precede the "=" which were modified on the date speci-
	;;2190,1,92;  fied in the dateparam. ;
	;;2190,1,93;
	;;2190,1,94;  ~<dateparam>~      Valid dateparams include the following
	;;2190,1,95;       ~<MM/DD/YY>~
	;;2190,1,96;       ~<MM/DD>~
	;;2190,1,97;       ~<T >~        (today)
	;;2190,1,98;       ~<T-n>~       (today minus n days)
	;;2190,1,99;       ~<T+n>~       (today plus n days)
	;;2190,1,100;
	;;2190,1,101;  ~<?>~              Causes the contents of the source file
	;;2190,1,102;  to be displayed, highlighting routines which have been
	;
	;