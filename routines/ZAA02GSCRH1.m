ZAA02GSCRH1 ;PG&A,ZAA02G-SCRIPT,2.10,HELP SCREENS;07NOV94  22:12
 ;Copyright (C) 1989, Patterson, Gray and Assoc., Inc.
BEG F TJ=1:1 S TX=$P($T(@TE+TJ),";",2,99) Q:TX="**"  D @$S($E(TX)="*":"LINE",TX["`":"C6",1:"C3")
 Q
C3 S %R=%R+1,%C=TC W @ZAA02GP,TY F TD=1:1:$L(TX,"|") S TA=$P(TX,"|",TD) W ZAA02G($S(TD#2:"LO",1:"HI")),TA I TD#2=0 S:TD=2 TD(%R)=TU S %C=$L($P(TX,"|",1,TD-1))-TD+TC+3,@TN,TU(TU)=TF_TA,TH=TH_"\"_$E(TA),TA(TU)=%R,TU=TU+1
 W $J("",TW-$L(TX)+TD-1),TY Q
C6 S %C=TC+3 W @ZAA02GP,ZAA02G("RON"),$P(TX,"`",2),$J("",TW-$L(TX)-3),ZAA02G("ROF") S %R=%R+1,%C=TC Q:$D(TG)  W @ZAA02GP,TY,$J("",TW),TY Q
LINE S TX=$E(TX,2),%R=%R+1 Q:$D(TG)&(TX="T")  S %C=TC W @ZAA02GP,ZAA02G("G1"),ZAA02G("HI"),ZAA02G($S(TX="T":"TLC",TX="B":"BLC",1:"LI")),TM F TD=6:2:TW W TM
 W TM,ZAA02G($S(TX="T":"TRC",TX="B":"BRC",1:"RI")),ZAA02G("G0") Q:TX="T"  S TA=$T(@TE+(TJ+1)) I TA["|" S %C=TC+$F(TA,"|"),TA=$P(TA,"|",2),@TN,TD(%R)=TU,TU(TU)=TF_TA,TH=TH_"\"_$E(TA),TA(TU)=%R,TU=TU+1,TJ=TJ+1,TS=1 W TU(TU-1)
 Q
 ;
DATA1 S TE="DATA1",HLP="20,22,23,93,46,",HLPR="^ZAA02GWPH" G BEG
 ;*T
 ;` ZAA02G-SCRIPT HELP FACILITY               (Press EXIT to return)
 ;  Help is available for the following areas:
 ;
 ;  |Editing Operations|    - adding and changing the text
 ;  |Movement Operations|   - moving around within the document
 ;  |Control Operations|    - setting templates, margins, tabs
 ;  |Print Control|         - changes to the document at printing
 ;  |Function Key Map|      - quick glance guide to the function keys
 ;
 ;  Highlighted text may be selected for more information
 ;*B
 ;**
DATA2 S TE="DATA2",HLP="" G BEG
 ;*T
 ;` ZAA02G-SCRIPT HELP FACILITY
 ;    Welcome to the ZAA02G-SCRIPT help facility.
 ;
 ;    Your system has has not been configured for HELP text
 ;    in the menus.  You can obtain help however while creating
 ;    and editing a medical report.  Pressing the HELP function
 ;    key while in the edit mode will give you information
 ;    concerning the various functions of the edit window.
 ;
 ;
 ;
 ;*B
 ;**
