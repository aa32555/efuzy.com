%ZAA02GEDH23
	F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
	W "." G ^ZAA02GEDH24
D Q
	;;2320,1,106;pointer up or down the left margin until it is pointing to
	;;2320,1,107;the node to be edited and press [RETURN]. ;
	;;2320,1,108;
	;;2320,1,109;~(Editing the reference)~.  You will first be given an oppor-
	;;2320,1,110;tunity to edit the global reference.  This has the effect
	;;2320,1,111;of copying the data to a new reference and removing it from
	;;2320,1,112;the original reference.  If the original reference has
	;;2320,1,113;descendants, they will be unaffected by the change. ;
	;;2320,1,114;
	;;2320,1,115;Changes to a reference must be syntactically correct. ;
	;;2320,1,116;AA UTILS does not evaluate the modified reference to
	;;2320,1,117;determine whether it is correct, and syntax errors will
	;;2320,1,118;cause the program to be interrupted. ;
	;;2320,1,119;
	;;2320,1,120;If no change is desired, simply press [RETURN]. ;
	;;2320,1,121;
	;;2320,1,122;
	;;2320,1,123;~(Editing the data)~.  After leaving the ~<reference >~field, the
	;;2320,1,124;cursor will move to the beginning of the ~<data>~ field which
	;;2320,1,125;consists of a three-row editing window at the bottom of the
	;;2320,1,126;screen.  This is a scrolling field, meaning that while
	;;2320,1,127;there are only three rows displayed, additional rows may be
	;;2320,1,128;reached using the cursor DOWN key. ;
	;;2320,1,129;
	;;2320,1,130;To edit, move the cursor to the desired position and make
	;;2320,1,131;the change.  You can use the INSERT CHARACTER or DELETE
	;;2320,1,132;CHARACTER keys to insert or delete characters as necessary. ;
	;;2320,1,133;When finished editing, press [RETURN].  The screen will be
	;;2320,1,134;refreshed and you will be returned to display mode. ;
	;;2320,1,135;
	;;2320,1,136;Note that while control characters are displayed in their
	;;2320,1,137;decimal form above, here in the editing field, they are
	;;2320,1,138;displayed as a period (".") and the decimal value is
	;;2320,1,139;displayed in the lower left corner of the screen when the
	;;2320,1,140;cursor is moved to the period. ;
	;;2320,1,141;
	;;2320,1,142;To edit a control character, position the cursor on the
	;;2320,1,143;period representing the character to be edited.  The
	;;2320,1,144;decimal value of the character will be displayed in the
	;;2320,1,145;lower left corner, as shown above, and can be edited by
	;;2320,1,146;pressing the SELECT key (~<{SE}>~). ;
	;;2320,1,147;
	;;2320,1,148;The cursor will move to the lower left corner of the screen
	;;2320,1,149;and permit the decimal value of the control character to be
	;;2320,1,150;edited.  Press [RETURN] when completed and the cursor will
	;;2320,1,151;return to its prior position. ;
	;;2320,1,152;
	;;2320,1,153;
	;;2320,1,154;~<Deleting A Node>~.  You can delete a node by moving the
	;;2320,1,155;pointer to it and pressing the DEL LINE key (~<{DL}>~). ;
	;;2320,1,156;
	;;2320,1,157;If the node is a simple data node and has no descendants,
	;;2320,1,158;it will be deleted immediately and "<deleted>" displayed in
	;;2320,1,159;place of the data on the screen.  If the deletion was in
	;;2320,1,160;error and you have ~(not)~ changed display pages the value can
	;;2320,1,161;be retrieved by pressing [RETURN] and entering edit mode. ;
	;;2320,1,162;The deleted value will be displayed, and by pressing
	;;2320,1,163;[RETURN] through the edit, you will be able to restore the
	;;2320,1,164;node to its original form. ;
	;
	;