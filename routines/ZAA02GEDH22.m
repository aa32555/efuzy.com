%ZAA02GEDH22 ;;%AA UTILS;1.21;(Subroutine);19JUL91  16:30
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
        ;Loaded July 19, 1991 at 4:03 PM
        F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
        W "." G ^ZAA02GEDH23
D Q
        ;;2320,1,42;                      in which the top level is "A", or
        ;;2320,1,43;                      follows "A", but precedes "E". ;
        ;;2320,1,44;
        ;;2320,1,45;  ^GLO(,A)            Display all nodes at top two levels
        ;;2320,1,46;                      in which the second level subscript
        ;;2320,1,47;                      is an "A". ;
        ;;2320,1,48;
        ;;2320,1,49;  ^GLO(11025,,1990)   Display all nodes at top three levels
        ;;2320,1,50;                      in which the top level subscript is
        ;;2320,1,51;                      "11025" and the third level subscript
        ;;2320,1,52;                      is 1990. ;
        ;;2320,1,53;
        ;;2320,1,54;
        ;;2320,1,55;  ~<Rule 3>~  Global references without a closing parenthesis
        ;;2320,1,56;  will display all existing levels of the global.  Once dis-
        ;;2320,1,57;  played, the number of levels can be reduced interactively. ;
        ;;2320,1,58;  Examples:
        ;;2320,1,59;
        ;;2320,1,60;  ^GLO                Display entire global
        ;;2320,1,61;
        ;;2320,1,62;  ^GLO("A",           Display only descendants of first
        ;;2320,1,63;                      level node "A"
        ;;2320,1,64;
        ;;2320,1,65;  ^GLO("A":"E",       Display descendants of first level
        ;;2320,1,66;                      nodes with values that equal or
        ;;2320,1,67;                      follow an "A", and equal or precede
        ;;2320,1,68;                      an "E"
        ;;2320,1,69;
        ;;2320,1,70;
        ;;2320,1,71;When you have entered the global reference, the first page
        ;;2320,1,72;will be displayed.  The reference to each node is displayed
        ;;2320,1,73;on the left margin and its data displayed to its right.  If
        ;;2320,1,74;the data is too long to fit on one row it is truncated and
        ;;2320,1,75;three periods are displayed on the right edge.  If the node
        ;;2320,1,76;is a pointer node only, and has no data of its own, "<ptr>"
        ;;2320,1,77;is displayed in place of data. ;
        ;;2320,1,78;
        ;;2320,1,79;If 132 column mode is supported by your terminal, you can
        ;;2320,1,80;switch from 80 column to 132 column by pressing the greater
        ;;2320,1,81;than [>] key.  To switch back to 80 column mode, press the
        ;;2320,1,82;less-than [<] key. ;
        ;;2320,1,83;
        ;;2320,1,84;The NEXT SCREEN and PREV SCREEN keys are used to display
        ;;2320,1,85;the next or previous page of the global.  However, you will
        ;;2320,1,86;not be able to page back further than your starting
        ;;2320,1,87;reference. ;
        ;;2320,1,88;
        ;;2320,1,89;Another important feature of the Global Editor is the
        ;;2320,1,90;ability to interactively increase or decrease the number of
        ;;2320,1,91;levels of the global to be displayed. ;
        ;;2320,1,92;
        ;;2320,1,93;To increase the number of levels, point to the node whose
        ;;2320,1,94;descendants you would like to view and press the cursor
        ;;2320,1,95;[RIGHT] key.  Likewise, to decrease the number of levels
        ;;2320,1,96;being viewed, press the cursor LEFT key. ;
        ;;2320,1,97;
        ;;2320,1,98;You may also select a new starting reference when increas-
        ;;2320,1,99;ing the number of levels to be displayed.  Move the "->"
        ;;2320,1,100;pointer to the parent node and press cursor RIGHT.  This
        ;;2320,1,101;has the effect of making the parent you pointed to the
        ;;2320,1,102;starting point for the expanded display. ;
        ;;2320,1,103;
        ;;2320,1,104;
        ;;2320,1,105;~<Editing A Node>~.  To edit the contents of a node, move the
        ;
