ZAA02GFORMS ;PG&A,ZAA02G-FORM,2.62,SAMPLER;8JAN88 9:13A
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
 D:$D(ZAA02G)+$D(ZAA02GP)'=12 INIT^ZAA02GDEV X ^ZAA02G("TERM-ON"),^ZAA02G("WRAP-OFF")
BEG K S,P D:$D(ZAA02G)=0 INIT^ZAA02GDEV Q:'$D(ZAA02G)  D HEAD
 S %R=%R+2,%C=35 W ZAA02G("ROF"),ZAA02G("HI"),@ZAA02GP,"features" D BOX
BEG1 S %C=3,%R=7 S:$D(P)=0 I=0,P=0 W ZAA02G("HI") S P=P+1
 F I=I+1:1 Q:$P($T(TEXT+I),";",2)=""  S %R=%R+1,A=$P($T(TEXT+I),";",2,9) W @ZAA02GP,A,$J("",77-$L(A))
 I %R<21 F %R=%R+1:1:21 W @ZAA02GP,$J("",77)
 S %R=23,%C=28 W @ZAA02GP,ZAA02G("HI"),"Press RETURN to continue " R A#1 G BEG1:P<3
REBUILD K A,I,P,S S %R=24,%C=1 W @ZAA02GP,"...wait",ZAA02G("CS") D ^ZAA02GFRMS1,^ZAA02GFRMS5,ACOMPILE,SAMPLE X ^ZAA02G("TERM-OFF"),^ZAA02G("WRAP-ON") Q
BOX S A=ZAA02G("HL"),A=A_A_A,%R=7,%C=1 W ZAA02G("LO"),@ZAA02GP,ZAA02G("G1"),ZAA02G("TLC") F I=1:1:26 W A
 W ZAA02G("TRC") F %R=8:1:21 F %C=1,80 W @ZAA02GP,ZAA02G("VL")
 S %R=22,%C=1 W @ZAA02GP,ZAA02G("BLC") F I=1:1:26 W A
 W ZAA02G("BRC"),ZAA02G("G0") Q
 ;
HEAD S %C=20,L=ZAA02G("RT") W ZAA02G("F"),ZAA02G("LO"),ZAA02G("RON") F %R=1,2,3 W @ZAA02GP F I=1:1:11 S J=$E("PG&A ZAA02GFORM",I) W:%R=2 $S(J=" ":L_L_L,1:" "_J_" "),L W:%R'=2 $S(J=" ":L_L_L,1:"   "),L
 W ZAA02G("Z")
 S %R=4,%C=14 W @ZAA02GP,ZAA02G("LO"),"Copyright (C) 1985, Patterson, Gray and Assoc., Inc."
 Q
TEXT ;
 ;o  Two Modules  -  ZAA02GFORME is the user's Forms Editor which allows building,
 ;                           editing, and managing forms.
 ;                   ZAA02GFORM  is the Forms Driver which is called from the
 ;                           user's applications program to call up a form
 ;                           or series of forms.
 ;o  CRT Independence - Forms built on one vendor's CRT will run on other
 ;                       CRT types.  You can customize the use of the special
 ;                       keys on the keyboard.
 ;o  Responsiveness -   The Forms Driver provides you with a quick means of
 ;                       displaying and editing large amounts of data.  The
 ;                       efficient design requires minimum system overhead.
 ;o  Friendliness  -    The forms approach to data entry coupled with a
 ;                       logical use of the keyboard makes user training easy.
 ;
 ;o  Video Attributes - In designing a form, you may use whatever video
 ;                       attributes are appropriate for form clarity.  Data
 ;                       elements may be distinguished from the text by using
 ;                       a contrasting attribute for the data.  You may also
 ;                       select the attribute for the data under the cursor.
 ;o  Line Drawing -     Because it is so easy to draw lines on the form,
 ;                       you will find that boxing off and partitioning
 ;                       parts of the form will make it easier for the
 ;                       user to visualize.
 ;o  Advanced Features- Table look-up, grouped data, field duplication
 ;                       (ditto), list processing and windowing cover most
 ;                       of your needs.  It is easy to enter your own MUMPS
 ;                       code to handle particular data entry needs.
 ;
 ;   Once you press RETURN, the ZAA02G-FORM Sampler will build, compile, and
 ;   demonstrate its SAMPLE forms.  You may run the demonstration any time
 ;   by selecting "I  Invoke SAMPLE Forms" on the ZAA02G-FORM Editor Menu.
 ;
ACOMPILE S ACOMPILE="BUILD",SCR="SAMPLE",SN="" F i=0:0 S SN=$O(^ZAA02GDISP(SCR,SN)) Q:SN=""  D AC^ZAA02GFRME1
 K SCR,SN,i Q
 ;
SAMPLE K (qt,ZAA02G,ZAA02GP,ZID,ZAA02GID,SNL) S SCR="SAMPLE",PN=1,PNAME="Herb W. Smith",PDEMO="MALE;42;02/03/44" G ^ZAA02GFORM
S2 S SNL=2 G SAMPLE
S3 S SCR="SAMPLE",SNL=3,ZAA02Gform=";Q",PN=1,PNAME="Herb W. Smith",PDEMO="MALE;42;02/03/44" D ^ZAA02GFORM D HEAD W !!!!!! Q
