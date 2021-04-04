%ZAA02GEDH24
	F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
	W "." G ^ZAA02GEDH25
D Q
	;;2320,1,165;
	;;2320,1,166;If the node has descendants, "<delete?>" will be displayed
	;;2320,1,167;on the screen next to the reference and any of its descen-
	;;2320,1,168;dants which are also displayed on the screen, and you will
	;;2320,1,169;be asked to confirm the deletion.  If your answer is YES,
	;;2320,1,170;the node and its descendants will be killed. ;
	;;2320,1,171;
	;;2320,1,172;Finally, the screen will be refreshed and you will be
	;;2320,1,173;returned to display mode. ;
	;;2320,1,174;
	;;2320,1,175;
	;;2320,1,176;~<Inserting A Node>~.  To insert a new data node into the
	;;2320,1,177;global, press the INS LINE key (~<{IL}>~). ;
	;;2320,1,178;
	;;2320,1,179;You will be prompted for the reference of the node to be
	;;2320,1,180;inserted.  Enter the subscripts to be used, ensuring that
	;;2320,1,181;they are syntactically correct and press [RETURN]. ;
	;;2320,1,182;
	;;2320,1,183;You will then be asked for the data to be inserted at the
	;;2320,1,184;node.  Enter the value and press [RETURN]. ;
	;;2320,1,185;
	;;2320,1,186;If at either question you would like to abort, simply press
	;;2320,1,187;the EXIT key. ;
	;;2321;Global Reference Options||56
	;;2321,1,1;The AA UTILS' Global Editor uses a masking feature that lets
	;;2321,1,2;you display as much, or as little, of a global as you need. ;
	;;2321,1,3;This masking abides by several rules. ;
	;;2321,1,4;
	;;2321,1,5;~<Rule 1>~.  Subscripts don't need surrounding quotation marks
	;;2321,1,6;unless they contain a comma or colon.  If they are used,
	;;2321,1,7;they must be paired.  Examples:
	;;2321,1,8;
	;;2321,1,9;  ^GLO(A)             Is the same as ^GLO("A")
	;;2321,1,10;
	;;2321,1,11;  ^GLO("1A")          Could have been ^GLO(1A)
	;;2321,1,12;
	;;2321,1,13;  ^GLO(A:Z)           Is the same as ^GLO("A":"Z")
	;;2321,1,14;
	;;2321,1,15;
	;;2321,1,16;~<Rule 2>~.  Closing a reference with a parenthesis limits the
	;;2321,1,17;number of subscript levels to be displayed and a null sub-
	;;2321,1,18;script will select all subscripts at the requested level. ;
	;;2321,1,19;The number of levels can be changed interactively after
	;;2321,1,20;display using the cursor LEFT and cursor RIGHT keys. ;
	;;2321,1,21;
	;;2321,1,22;  ^GLO()              Display all nodes at top level
	;;2321,1,23;
	;;2321,1,24;  ^GLO(,,)            Display all nodes at top three levels
	;;2321,1,25;
	;;2321,1,26;  ^GLO(A,)            Display all nodes at top two levels
	;;2321,1,27;                      in which "A" is top level subscript. ;
	;;2321,1,28;
	;;2321,1,29;  ^GLO(A:E,)          Display all nodes at top two levels
	;;2321,1,30;                      in which the top level is "A", or
	;;2321,1,31;                      follows "A", but precedes "E". ;
	;;2321,1,32;
	;;2321,1,33;  ^GLO(,A)            Display all nodes at top two levels
	;;2321,1,34;                      in which the second level subscript
	;;2321,1,35;                      is an "A". ;
	;;2321,1,36;
	;;2321,1,37;  ^GLO(11025,,1990)   Display all nodes at top three levels
	;;2321,1,38;                      in which the top level subscript is
	;;2321,1,39;                      "11025" and the third level subscript
	;;2321,1,40;                      is 1990. ;
	;;2321,1,41;
	;;2321,1,42;
	;;2321,1,43;~<Rule 3>~.  Global references without a closing parenthesis
	;;2321,1,44;will display all existing levels of the global.  Once dis-
	;
	;