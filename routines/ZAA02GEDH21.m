%ZAA02GEDH21 ;;%AA UTILS;1.21;(Subroutine);19JUL91  16:30
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
        ;Loaded July 19, 1991 at 4:03 PM
        F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
        W "." G ^ZAA02GEDH22
D Q
        ;;2310,1,20;used in combination, will illustrate how to make a request. ;
        ;;2310,1,21;
        ;;2310,1,22;  ^GLO             Copy entire global
        ;;2310,1,23;
        ;;2310,1,24;  ^GLO("A",        Copy node "A" at the first level and its
        ;;2310,1,25;                   descendants
        ;;2310,1,26;
        ;;2310,1,27;  ^GLO("A":"E",    Copy nodes "A" through "E" of the first
        ;;2310,1,28;                   level and their descendants
        ;;2310,1,29;
        ;;2310,1,30;  ^GLO()           Copy all nodes at first level of global
        ;;2310,1,31;
        ;;2310,1,32;  ^GLO(,,)         Copy all nodes at first three levels of
        ;;2310,1,33;                   global
        ;;2310,1,34;
        ;;2310,1,35;~(Step 3)~.  Enter the name of the destination global.  If
        ;;2310,1,36;subscript substitution is desired, enter the subscripts to
        ;;2310,1,37;be substituted at the appropriate level.  Note that
        ;;2310,1,38;subscript substitution is not possible for levels in which
        ;;2310,1,39;a range has been specified, or for which no subscript has
        ;;2310,1,40;been specified. ;
        ;;2310,1,41;
        ;;2310,1,42;After pressing return, the copy will begin and you will be
        ;;2310,1,43;periodically provided a reference indicating what node is
        ;;2310,1,44;being copied. ;
        ;;2320;Global Edit Utility||187
        ;;2320,1,1;The AA UTILS Global Editor displays selected portions of
        ;;2320,1,2;any global, allows you to page forward from the starting
        ;;2320,1,3;reference and back, and even screen out nodes in which you
        ;;2320,1,4;have no interest.  Further it allows you to interactively
        ;;2320,1,5;add new nodes and edit or delete existing ones. ;
        ;;2320,1,6;
        ;;2320,1,7;~(Step 1)~.  From the Functions menu, select Utilities. ;
        ;;2320,1,8;         From the Utilities menu, select Global. ;
        ;;2320,1,9;         From the Global Utilities, select Edit. ;
        ;;2320,1,10;
        ;;2320,1,11;~(Step 2)~.  Select the global to be displayed.  AA UTILS'
        ;;2320,1,12;Global Editor provides a powerful masking feature that
        ;;2320,1,13;allows you display as much, or as little, of the selected
        ;;2320,1,14;global as you need.  This masking abides by several rules. ;
        ;;2320,1,15;
        ;;2320,1,16;  ~<Rule 1>~  Subscripts do not need surrounding quotations
        ;;2320,1,17;  marks unless they contain a comma or colon.  However, if
        ;;2320,1,18;  quotes are used, they must be paired.  Examples:
        ;;2320,1,19;
        ;;2320,1,20;  ^GLO(A)             Is the same as ^GLO("A")
        ;;2320,1,21;
        ;;2320,1,22;  ^GLO("1A")          Could have been ^GLO(1A)
        ;;2320,1,23;
        ;;2320,1,24;  ^GLO(A:Z)           Is the same as ^GLO("A":"Z")
        ;;2320,1,25;
        ;;2320,1,26;
        ;;2320,1,27;  ~<Rule 2>~  Global references which have a closing paren-
        ;;2320,1,28;  thesis will limit the number of levels of the global to
        ;;2320,1,29;  be displayed.   Once displayed, the number of levels can
        ;;2320,1,30;  be changed interactively.  When using the closing paren-
        ;;2320,1,31;  thesis, a null subscript will select all all subscripts
        ;;2320,1,32;  at the requested level.  Examples:
        ;;2320,1,33;
        ;;2320,1,34;  ^GLO()              Display all nodes at top level
        ;;2320,1,35;
        ;;2320,1,36;  ^GLO(,,)            Display all nodes at top three levels
        ;;2320,1,37;
        ;;2320,1,38;  ^GLO(A,)            Display all nodes at top two levels
        ;;2320,1,39;                      in which "A" is top level subscript. ;
        ;;2320,1,40;
        ;;2320,1,41;  ^GLO(A:E,)          Display all nodes at top two levels
        ;
