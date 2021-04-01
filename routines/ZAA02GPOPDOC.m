ZAA02GPOPDOC ;PG&A,TOOLKIT I,1.51,POP UP/PULL DOWN MENUS (Part 2);2014-07-10 17:23:46;;;20JAN98  10:30
 ;Copyright (C) 1985, Patterson, Gray and Assoc., Inc.
 R "Run Samples? (Y/N)-",A,! S A=$E(A) I A="Y"!(A="y") D ^ZAA02GPOPDO1
 F I=1:1 S A=$T(DOC+I) Q:A'[";"  W $P(A,";",2,99),! I I#23=0 R A
 Q
DOC ;
 ;ZAA02G-POP Quick Reference (see Toolkit I manual for details)
 ;Y  = Left Column, Top Row\ Flags \ # columns \ Title \ Col Title \
 ;  option1,option2...
 ;
 ;   NOTES
 ;
 ; 1.  Top Row is only used when pop-up is located in mid-screen
 ; 2.  # Column = "*" indicates single line menu
 ; 3.  Title is optional and will appear on the top line
 ; 4.  Col Title is optional and appears on the first line
 ; 5.  Options followed by a "*" will be considered text only and cannot
 ;     be selected.  Used for headings and "information only" text.
 ; 6.  If only one item is available for selection, then it will become
 ;     a dialogue box where the user's entry will be returned in X.
 ; 7.  The Y(0) variable provides additional options as listed below.
 ; 8.  Setting REFRESH before calling ZAA02GPOP will disable screen clear
 ;     and returns top and bottom rows in REFRESH.  This enables
 ;     external refresh.
 ;
 ; Flags: T - Top menu
 ;        B - Bottom menu
 ;        R - Reverse video
 ;        L - Line border
 ;        W - Write only
 ;        Wxx - Write only (but wait for RETURN or timeout of xx)
 ;        H - High intensity
 ;        D - Leave display
 ;        C - Start at current row (%R)
 ;        Y - Options are in Y(1) thru Y(x) rather than piece 6
 ;        Pxx - pad columns with xx spaces
 ;        M - multiple selection
 ;        M1 - multiple with markers & RETURN selection
 ;        A - Advance (causes advance after selection in mult.)
 ;        V - Returns the displayed value in X rather than the #
 ;        S - Returns the subscript value in X rather than the #
 ;        U - Force Upper Case on Entries
 ;        Q - Quick Mode (RETURN not required)
 ;        Oxx - Override "*" flag in data with $C(xx)
 ;        G  - Inserts grid line between columns
 ;        K  - Center text in pop-up
 ;        w  - Forms mode (fill-in blanks)
 ;
 ; Y(0) pieces:
 ;
 ; Piece 1 - Optional count of # of lines to use on the screen for selection
 ; Piece 2 - Function key list - Insert the allowable function key
 ;           mnemonic if function key capture is desired. 
 ;           The list consists of:
 ;           ER,TB,CR,ES,RU,UK,DK,RK,LK,IC,DC,PD,PU,FP,SU,SD,IL,DL,EF,ST
 ;           HL,OT,CP,BO,FM,EK,GO,RE,CT,EX,GW,SE,HK,XX,YY,GE,HO
 ;           ZAA02GPOP will return the function key pressed in X
 ; Piece 3 - Other list option - optional variable reference for
 ;           an alternate source for the list - may be global
 ; Piece 4 - Alternate display syntax - generally ZAA02GPOP uses the
 ;           contents of the list (either Piece 6 of Y, the Y() array,
 ;           or the contents of the Alternate Source Global).  Optional
 ;           MUMPS code can be inserted to change the display.  Columns
 ;           can be formatted with:  reference;length`ref2;len2...
 ;           (addition of a "R" on the length = right justification)
 ; Piece 5 - Optional starting reference - Specifies the beginning of
 ;           of the Alternate Source where the listing is to start
 ; Piece 6 - Bottom Line Message - allows a user message to be
 ;           displayed on the bottom line of the menu.  (may use *)
 ; Piece 7 - Define cursor position - Allow the initial cursor position
 ;           to be specifed (default is first position)
 ; Piece 8 - Define END OF LIST - If not all of the list is to be
 ;           displayed, specifies the last subscript allowed.
 ; Piece 9 - Timeout in # of seconds (99999 default)
 ; Piece 10- Used for more than 1 list - "R=Repeat"
 ;
 ; other variables that may be used - 
 ; ZAA02GPOPALT - alternate $O syntax for traversing global (Uses TO as
 ;            the subscript values)
 ; ZAA02GPOPMUL - user specific code executed during multiple selection
 ; 
 ; Use ^ZAA02GPOPDOS for DOS file directory
 ;
 Q
TESTM ; TEST MULTIPLE SELECTION
 S Y="20\TM1RHL\1\Press SELECT to make SELECTION\\*,A  APPLES,O  ORANGES,M  MELONS,T  TANGERINES",Y(0)="\PU,PD" D ^ZAA02GPOP Q
 ;
EXAMPLES ;
1 S Y="10,20\RLW10\\\\Please Wait" D ^ZAA02GPOP Q
