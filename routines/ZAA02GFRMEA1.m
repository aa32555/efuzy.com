ZAA02GFRMEA1 ;PG&A,ZAA02G-FORM,2.62,FORMS EDITOR, Help Mess.;13FEB94  07:52
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
 ;CONTROL VARIABLES
 ;
 ;second level of ^ZAA02GDISP( (one entry for each input)
 ;
 ;top row`bottom row`top x,y`rightmost column`# groups to display`Max # groups`tab stop`exist`count`dense`id`#mandatory`process reference`
 ;   1   `      2   `   3   `        4       `         5          `      6      `   7    `  8  `  9  `10`11
 ;
HELP S A=$T(@II) Q:A=""  F HI=1:1 I $T(@II+HI) Q
 S:%R<12 SR=%R+1 S:%R>11 SR=%R-HI-2 S %R=SR,(%C,SC)=33 W:'$d(qt) @ZAA02GP,ZAA02G("HI"),ZAA02G("G1"),ZAA02G("TLC") F I=1:1:46 W:'$d(qt) ZAA02G("HL")
 W:'$d(qt) ZAA02G("TRC") F HI=0:1:HI-1 S A=$P($T(@II+HI),";",2),%R=%R+1 W:'$d(qt) @ZAA02GP,ZAA02G("VL")," ",ZAA02G("G0"),A,$J("",45-$L(A)),ZAA02G("G1"),ZAA02G("VL")
 S %R=%R+1,%C=SC W:'$d(qt) @ZAA02GP,ZAA02G("BLC") F I=1:1:46 W:'$d(qt) ZAA02G("HL")
 W:'$d(qt) ZAA02G("BRC"),ZAA02G("G0"),*8 R A#1 S %C=SC F %R=SR:1:SR+HI+2 W:'$d(qt) @ZAA02GP,ZAA02G("CL")
 K SC,SR,HI Q
 ;
HELP1 S A=$T(@II) Q:A=""  F HI=1:1 I $T(@II+HI) Q
 S %C=31,%R=22 F I=0,2:1:HI-1 S A=$P($T(@II+I),";",2),%R=%R+1 W:'$d(qt) @ZAA02GP,A,$J("",47-$L(A)) I %R=24,I+1<HI R A#1 S %R=22
 I %R=23 S %R=24 W:'$d(qt) @P,$J("",47)
 R A#1 Q
 ;
EDIT S II=II+4 D HELP S II=II-4 Q
 ;
DATA ;
1 ;Top Row
 ;
 ;Enter the top row for the first group.
2 ;Bottom Row
 ;
 ;Enter the bottom row for the first group.
 ;Note: the row is absolute, not relative.
3 ;First Column
 ;
 ;Enter the column where a group begins.
 ;Note: this is an absolute reference.
4 ;Last Column
 ;
 ;Enter the column where the first group
 ;ends. Note: this is an absolute reference.
5 ;# of Records to Display
 ;
 ;Enter the number of groups you want to display
 ;simultaneously on the form.
6 ;Maximum number of Groups
 ;
 ;Enter the maximum number of allowed
 ;groups.
7 ;Tab Stop
 ;
 ;Enter Y if you want TAB to stop on the
 ;groups.
8 ;Existence Test
 ;
 ;ZAA02GFORM may optionally put only completed
 ;groups, i.e., it does not have to put the
 ;maximum number of groups. Similarly, it
 ;may fetch only the number which exist.  If
 ;this option is desired, enter MUMPS code
 ;which will set $T to true if the group
 ;exists, e.g.,
 ;     I $D(^PATIENT(ID,"DIAGNOSES",n(1)))
 ;would test each diagnosis group, n(1), for
 ;existence.
 ;
 ;NOTE: with this option, during data entry
 ;      the first blank trailing group
 ;      forces a groups' EXIT
9 ;Reference to Put Group Count
 ;
 ;Typically the total number of groups will
 ;be less than the maximum indicated above.
 ;To PUT the count of the groups, enter the
 ;destination MUMPS reference, e.g.,
 ;    ^PATIENT(ID,"DIAGNOSES")
 ;which is the reference which stores the
 ;number of diagnoses for a patient.
 ;
 ;NOTE:  the EXISTENCE TEST is ignored if
 ;       this item is defined.
10 ;Group Count Ref $P
 ;
 ;If the group count is a piece in the 
 ;reference, then enter in the ZAA02G-FORM format
 ;    $P(X,delimiter,piece #)
 ;e.g., for a FILEMAN reference,
 ;    $P(X,"^",5)
 ;
 ;$P reference not used in Real Time
 ;Symbol Update
11 ;Dense
 ;
 ;This parameter requires count or
 ;or the existence test to be operating.
 ;If this parameter is answered "Y",
 ;then whenever a record in a group
 ;is empty due to erasing the data or
 ;inserting a record and failing to input
 ;data, then the record will be
 ;automatically removed.
 ;
12 ;Number Mandatory
 ;
 ;Enter the minimum number of records
 ;mandatory for this group.  Default=0
13 ;Pre-Remove eXecute
 ;
 ;Optional MUMPS code eXecuted prior to 
 ;removing one record of a group.  This
 ;code must return $T=true to continue or
 ;$T=FLASE to terminate the removal.
 ;NOTE: "I 0" will always cancel the removal.
14 ;Pre-Insert eXecute
 ;
 ;Optional MUMPS code eXecuted prior to
 ;inserting one record into a group.
 ;This code must return $T=TRUE to insert,
 ;or $T=FASLE to cancel the insertion.
99 ;
