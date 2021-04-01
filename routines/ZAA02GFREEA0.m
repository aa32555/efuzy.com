ZAA02GFRMEA0 ;PG&A,ZAA02G-FORM,2.62,FORMS EDITOR, Help Mess.;12APR92 4:42P [ 12/05/93   5:20 PM ]
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
HELP D G S A=$T(@II) Q:A=""  F HI=1:1 I $T(@II+HI) Q
 S:%R<12 SR=%R+1 S:%R>11 SR=%R-HI-2 S:(SR+HI+2'<ZAA02G("R"))!(SR<3) SR=3 S %R=SR,(%C,SC)=33 W @ZAA02GP,ZAA02G("HI"),ZAA02G("G1"),ZAA02G("TLC") F I=1:1:46 W ZAA02G("HL")
 W ZAA02G("TRC") F HI=0:1:HI-1 S A=$P($T(@II+HI),";",2),%R=%R+1 W @ZAA02GP,ZAA02G("VL")," ",ZAA02G("G0"),A,$J("",45-$L(A)),ZAA02G("G1"),ZAA02G("VL")
 S %R=%R+1,%C=SC W @ZAA02GP,ZAA02G("BLC") F I=1:1:46 W ZAA02G("HL")
 W ZAA02G("BRC"),ZAA02G("G0"),*8 R A#1 S %C=SC F %R=SR:1:SR+HI+2 W @ZAA02GP,ZAA02G("CL")
 K SC,SR,HI Q
 ;
G I II=1,scope[">" S II="G1"
 Q
 ;
HELP1 D G S A=$T(@II) Q:A=""  F HI=1:1 I $T(@II+HI) Q
 S %C=31,%R=22 F I=0,2:1:HI-1 S A=$P($T(@II+I),";",2),%R=%R+1 W @ZAA02GP,A,$J("",47-$L(A)) I %R=24,I+1<HI R A#1 S %R=22
 I %R=23 S %R=24 W @P,$J("",47)
 R A#1 Q
DATA ;
10 ;      TABLE PARAMETERS\MNEMONIC REF
 ;Table Types:  (0 is default)
 ;  0= ^TABLE(table,X) where X is a ptr & mne.
 ;  1= ^LOOKUP(table,X)=ptr and
 ;     ^TABLE(table,ptr)=data
 ;  2= ^LOOKUP(table,mnenonic,ptr)="" and
 ;     ^TABLE(table,ptr)=data
 ;  5= ^NAMES(last,first,ptr)="" and
 ;     ^FILE(ptr)=data
 ;Optional Parameters:
 ;   A= Alphanumeric sort on pop-ups.
 ;   D= Do $D(reference) on display
 ;   F= Free text allowed.
 ;   H= Output Table Text in HELP only.
 ;   K= Pop-up Key Matches
 ;   L= Left Justify Table Text
 ;   V= eXecute validation after table check
 ;Table Mnemonic Ref: type 1 & 2 tables only!
 ;   Enter a MUMPS reference, where X is a ptr,
 ;   e.g., 1VF\$P(^TABLE(table,X),"^",3)
11 ;TABLE LOOKUP-REFERENCE
 ;
 ;For table look-up, enter the global reference
 ;of the table, i.e. ^TEXT("TAX TABLES",X).
12 ;TABLE REFERENCE
 ;
 ;For type 1-2 tables (see TABLE PARAMETERS)
 ;enter the MUMPS reference for this table.
 ;
 ;From the TABLE PARAMETER example, the
 ;reference is ^TABLE(table,X)
 ;
 ;Do not enter for the simple type 0 tables!
13 ;TABLE TEXT LENGTH & TEXT REF.
 ;
 ;Enter the length of the text display area
 ;to the right of the input field.  Enter any
 ;additional MUMPS code if the text is to be
 ;modified before display.  Examples:
 ;
 ;20        will display the text right
 ;          justified in a 20 characters
 ;
 ;20\$P(^TEXT("TABLE",X),"^",3)  will display
 ;          the 3rd piece of the Table.
 ;
 ;Use the "H" parameter in the Table Para.
 ;to restrict display to only the HELP window.
 ;Use "L" parameter to left justify text.  If
 ;this field is blank, no text will be
 ;displayed.
14 ;MENU  - the menu parameters are the ZAA02GPOP
 ;        parameters in the format:
 ;
 ; column,row \ flags \ # columns \ title
 ;
 ;    where the flags are -
 ; T-Top     B-Bottom     C-Current position
 ; H-High    R-Reverse    L-Line border
 ;
 ;Row is optional and if left blank, the
 ;menu will appear next to the field.
 ;
 ; Example:   20\RHT\1\TAX TABLES
15 ;PROCESS ACKNOWLEDGEMENT
 ;
 ;Normally the edit checks are not executed
 ;when the user "passes through" a field with 
 ;either the RETURN or cursor key.  PROCESS
 ;ACKNOWLEDGE overrides this as follows:
 ;
 ;  Y - executes all edit checks
 ;  C - executes edit checks if field
 ;      has been modified
 ;  N - (default) no edit checks
16 ;ADDITIONAL VALIDATION CODE
 ;
 ;Enter Xecutable string if additional valid-
 ;ation of the input is required.  The logic
 ;should set $T = TRUE if ok, FALSE if not.
17 ;FETCH TRANSFORM
 ;
 ;Enter Xecutable string if X is to be modified
 ;before it is displayed on the form.
18 ;PUT TRANSFORM
 ;
 ;Enter Xecutable string if X is to be modified
 ;before it is stored.
19 ;MULTIPLE ITEM PARAMETERS
 ;
 ;If a multiple item - specify the following
 ;parameters separated with a comma:
 ;   1  -  form display - H=horizontal,V=vert
 ;   2  -  # items to display initially
 ;   3  -  storage - H=horizontal,V=vert.
 ;   4  -  increment between items
 ;   5  -  Maximum # of items
 ;   6  -  W=Wrap On, C=Check each item
 ;   7  -  Misc. Flags: may be combined
 ;         S=Strip Trailing Empty Lines
 ;         J=Jump Out on last line
 ;         K=Kill old values on PUT
 ;   8  -  Put Multiple Count Reference
 ;         include any $PIECE, eg
 ;         $P(^ZAA02GFORMS(1),"\",20)
 ;NOTE: all 'H' values currently do not work.
20 ;WINDOW
99 ;
