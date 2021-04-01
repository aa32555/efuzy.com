ZAA02GFRMEA ;PG&A,ZAA02G-FORM,2.62,FORMS EDITOR, Help Mess.;10DEC92  20:24
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
 ;CONTROL VARIABLES
 ;
 ;top level of ^ZAA02GDISP(
 ;
 ;   Mand. Flag\Addntl Output MUMPS Code\^DRAW:'$d(qt) subscript
 ;
 ;second level of ^ZAA02GDISP( (one entry for each input)
 ;
 ;MF`stor`x,y`displa`length`pat`err`dup`Table`In-Tr.`Code`Tab`TOL`Out-Tr`
 ;1   2    3    4      5     6   7   8    9    10     11   12 13   14
 ;
HELP G:II>9 ^ZAA02GFRMEA0 D G S A=$T(@II) Q:A=""  F HI=1:1 I $T(@II+HI) Q
 S:%R<12 SR=%R+1 S:%R>11 SR=%R-HI-2 S:(SR+HI+2'<ZAA02G("R"))!(SR<3) SR=3 S %R=SR,(%C,SC)=33 W:'$d(qt) @ZAA02GP,ZAA02G("HI"),ZAA02G("G1"),ZAA02G("TLC") F I=1:1:46 W:'$d(qt) ZAA02G("HL")
 W:'$d(qt) ZAA02G("TRC") F HI=0:1:HI-1 S A=$P($T(@II+HI),";",2,9),%R=%R+1 W:'$d(qt) @ZAA02GP,ZAA02G("VL")," ",ZAA02G("G0"),A,$J("",45-$L(A)),ZAA02G("G1"),ZAA02G("VL")
 S %R=%R+1,%C=SC W:'$d(qt) @ZAA02GP,ZAA02G("BLC") F I=1:1:46 W:'$d(qt) ZAA02G("HL")
 W:$S(%R<24:1,ZAA02G["VT":1,1:0) ZAA02G("BRC") W:'$d(qt) ZAA02G("G0"),*8 R A#1 S %C=SC F %R=SR:1:SR+HI+2 W:'$d(qt) @ZAA02GP,ZAA02G("CL")
 K SC,SR,HI Q
 ;
G I II=1,scope[">" S II="G1"
 Q
 ;
HELP1 G:II>9 HELP1^ZAA02GFRMEA0 D G S A=$T(@II) Q:A=""  F HI=1:1 I $T(@II+HI) Q
 S %C=31,%R=22 F I=0,2:1:HI-1 S A=$P($T(@II+I),";",2,9),%R=%R+1 W:'$d(qt) @ZAA02GP,A,$J("",47-$L(A)) I %R=24,I+1<HI R A#1 S %R=22
 I %R=23 S %R=24 W:'$d(qt) @P,$J("",47)
 R A#1 Q
DATA ;
1 ;REFERENCE
 ;
 ;Enter the global or local variable from where
 ;the data will be fetched and to where it will
 ;be stored.  All subscripts used must be
 ;defined external to ZAA02G-FORM.
10000 ;
G1 ;REFERENCE
 ;
 ;Enter the global or local variable from where
 ;the data will be fetched and to where it will
 ;be stored.  All subscripts used must be
 ;defined external to ZAA02G-FORM.
 ;REFERENCE NOTE FOR GROUPED DATA:
 ;For groups, use the following format:
 ;REF(...,n(1),...,n(2),...,n(n),...)
 ;eg ^PATIENT(ID,"VISIT",n(1),"DIAGNOSES",n(2))
 ;references the multiply occurring diagnosis
 ;groups for multiply occurring visits.
2 ;$PIECE
 ;
 ;If the data item is to be pieced out of the
 ;the above reference, enter the $Piece syntax
 ;such as $P(X,"^",3) or $P(X,"\",12).  Use X
 ;for the string in all cases.
3 ;LENGTH
 ;
 ;Enter the allowable data length.  It must be
 ;a value less than the screen width.  An
 ;optional comma following the length modifies
 ;the field as illustrated in the following
 ;examples:
 ;
 ;12,      right justified string in 12 spaces
 ;12,3     right justified number in 12 spaces
 ;          with 3 places to the right of the 
 ;          decimal
 ;16,0     right justified integer in 16 spaces
 ;40,180   Horizontal scroll mode - displays
 ;          40 characters of a string with a
 ;          maximum length of 180 (the 2nd #
 ;          must be greater than the 1st)
4 ;PATTERN MATCH
 ;
 ;If a string compare or match is to be used
 ;to validate the user's input, enter the
 ;appropriate MUMPS code.  X is the string to
 ;be checked and any false condition will
 ;result in a flagged error.  Examples:  X?5N
 ;X?1.3U    "YN"[X    X?3N,X>300,X<600
5 ;MANDATORY
 ;
 ;Enter Y to indicate an entry is required.
 ;Enter R if this required before proceeding
 ;to the next item.
6 ;DITTO FIELD
 ;
 ;If this field can be duplicated from another
 ;on the form, enter the field name of the
 ;source.
7 ;TAB STOP
 ;
 ;Enter Y if you want a TAB stop on this field.
8 ;HELP REFERENCE/ERROR REFERENCE
 ;3 formats acceptable in HELP and/or ERROR: 
 ;      Global Reference          
 ;      Global Reference;;ZAA02G-POP parameters
 ;      Routine Reference;D;optional para.
 ;      MUMPS string;X;optional parameters
 ;Ref should be a serial list starting at 1.
 ;0 should be the count of lines.  Include  
 ;ZAA02G-POP parameters for a pop-up.  Use "/" as
 ;delimiter between HELP and ERROR.  Using
 ;HELP/ indicates no ERROR processing, /ERROR
 ;indicates no HELP processing.  Setting RX=1 
 ;and "X=put_value`display_value" will cause
 ;the field to be modified.
9 ;DISPLAY ONLY & INPUT MODES:
 ;
 ; Y       - Display Only field (include a "S"
 ;              to force a "PUT" to database)
 ; P       - Password input (no echo)
 ; A       - AutoReturn (automatically jumps
 ;              to next field at end)
 ; C       - Calendar Date format (xd=Julian)
 ; E       - Erase Field on new input
 ; U or L  - Convert Input Upper/Lower Case
 ; K       - Key field (input is used as key
 ;              for the remainder of screen)
 ;    R    - Repeat Modifier for the Key field
 ;              input type (i.e. KR)
 ;    D    - Display Modifier for Key field
 ;              causing screen refresh on
 ;              scroll up & down of table keys
 ;
 ;        (these codes may be combined)   
 ;
99 ;
