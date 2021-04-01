ZAA02GFRMEA2 ;PG&A,ZAA02G-FORM,2.62,FORMS EDITOR, Help Mess.;08NOV94  08:19
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;CONTROL VARIABLES
 ;1`2 USER DISPLAY CODE`3 SCR-SN`4 TITLE`5 132/80`6 TIMEOUT`7`8`9`10 DATA ATTR`11 EDIT POS`12 EDIT ATTR`13 FORCE WINDOW`14 CONSERVE`15 PRE-EDIT CODE`16 PRE-FILE CODE`17 POST-FILE CODE`18 MUMPS DISPLAY ROUTINE
 ;
 ;
HELP S:NE=4 II=II+5 S A=$T(@II) Q:A=""  F HI=1:1 I $T(@II+HI) Q
 S:%R<12 SR=%R+1 S:%R>11 SR=%R-HI-2 S %R=SR,(%C,SC)=33 W:'$d(qt) @ZAA02GP,ZAA02G("HI"),ZAA02G("G1"),ZAA02G("TLC") F I=1:1:46 W:'$d(qt) ZAA02G("HL")
 W:'$d(qt) ZAA02G("TRC") F HI=0:1:HI-1 S A=$P($T(@II+HI),";",2),%R=%R+1 W:'$d(qt) @ZAA02GP,ZAA02G("VL")," ",ZAA02G("G0"),A,$J("",45-$L(A)),ZAA02G("G1"),ZAA02G("VL")
 S %R=%R+1,%C=SC W:'$d(qt) @ZAA02GP,ZAA02G("BLC") F I=1:1:46 W:'$d(qt) ZAA02G("HL")
 W:'$d(qt) ZAA02G("BRC"),ZAA02G("G0"),@ZAA02GP R A#1 S %C=SC F %R=SR:1:SR+HI+2 W:'$d(qt) @ZAA02GP,ZAA02G("CL")
 K SC,SR,HI S:NE=4 II=II+5 Q
 ;
HELP1 S A=$T(@II) Q:A=""  F HI=1:1 I $T(@II+HI) Q
 S %C=31,%R=22 F I=0,2:1:HI-1 S A=$P($T(@II+I),";",2),%R=%R+1 W:'$d(qt) @ZAA02GP,A,$J("",47-$L(A)) I %R=24,I+1<HI R A#1 S %R=22
 I %R=23 S %R=24 W:'$d(qt) @P,$J("",47)
 R A#1 Q
DATA ;
1 ;Title
 ;
 ;This name is seen by the user
 ;during Menu selection.
2 ;Data Video Attr.
 ;
 ;Enter the video composite for
 ;for displaying the data. Valid answers:
 ;R=Reverse, H=High intensity, U=Underline
 ;.=pad allocated space with "."
3 ;Edit Video Attr.
 ;
 ;Enter the video composite used
 ;during editing a field.  Valid answers:
 ;R=Reverse, H=High intensity, U=Underline
4 ;Edit Position
 ;
 ;This is where you want the cursor
 ;to appear upon entering a field
 ;for editing. Valid answers:
 ; L=Left or R=Right
5 ;132 Column Mode
 ;
 ;Enter a "Y" if the screen is
 ;to be displayed in 132 column
 ;format.
6 ;Display Code
 ;
 ;Enter any additional MUMPS code that you
 ;would want to execute just prior to ZAA02G-FORM
 ;displaying the static portions of the form.
 ;
 ;Note that ZAA02G-FORM will not clear the screen
 ;before painting static information if
 ;anything is in this field.
7 ;Pre-Edit Code
 ;
 ;This optional MUMPS code is eXecuted
 ;immediately after the drawing has been
 ;painted and the data loaded.  If the edit
 ;control question is asked before editing,
 ;the code is invoked after the control
 ;question.  Not invoked if process control is
 ;"Q" or "S" or if "static only".
8 ;Post-Edit Code
 ;
 ;Any code here will get executed prior to any
 ;manditory checks and the Edit/Control Quest-
 ;ion if it is active.  Primary purpose is to
 ;perform any cleanup before the manditory
 ;check or to cancel form (set RX=9998).
 ;
 ;As in the Pre-Filing Code, a $T value of
 ;false will send the control back into the
 ;edit mode.
9 ;Pre-Filing Code
 ;
 ;If editing occurred, then this optional MUMPS
 ;code is eXecuted prior to filing the data
 ;from the screen.
 ;
 ;IF $T=false after executing this line, then
 ;ZAA02G-FORM returns control back to the edit
 ;mode rather than filing.  If you want to
 ;specify a field use the ZAA02G-FORM "BRANCH"
 ;operator.
10 ;Post-Filing Code
 ;
 ;If editing occurred, then this optional
 ;code is eXecute after ZAA02G-FORM files the
 ;edited data.
11 ;Full Window Display
 ;
 ;ZAA02G-FORM will erase the screen as it writes
 ;the static information unless you indicate
 ;that you don't want full screen.
 ;
 ;A "form-within-form requires "N".
12 ;Conserve Symbol Space
 ;
 ;If Storage errors occur while using
 ;the form, then answer this question "Y".
 ;
 ;A "R" will cause ZAA02G-FORM to directly
 ;address the reference of each field in
 ;real-time.  No intermediate will be used.
 ;
13 ;Optional MUMPS Display Routine
 ;
 ;Enter a MUMPS Routine Name without the "^".
 ;If this option is used, ZAA02G-FORM will use this
 ;routine for the initial fetch, display and
 ;final put to the database.  Because it uses
 ;very little indirection and eXecute commands,
 ;you may find this will run more quickly on
 ;compiled MUMPS systems.
14 ;Optional Screen Timeout
 ;
 ;Enter the number of seconds that the form
 ;may be inactive in the edit control question
 ;and the edit mode.  If this time expires, the
 ;form will be canceled and the ZAA02Gform control
 ;variable will contain "C-timeout" to indicate
 ;the form was cancelled because of timeout.
99 ;
