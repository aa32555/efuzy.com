ZAA02GSCRH4 ;PG&A,ZAA02G-SCRIPT,2.10,HELP SCREENS;22DEC94 11:07A;;;25MAY95 11:37A
 ;;Copyright (C) Patterson, Gray and Associates, Inc.
BEG F TJ=1:1 S TX=$P($T(@TE+TJ),";",2,99) Q:TX="**"  D @$S($E(TX)="*":"LINE",TX["`":"C6",1:"C3")
 Q
C3 S %R=%R+1,%C=TC W @ZAA02GP,TY F TD=1:1:$L(TX,"|") S TA=$P(TX,"|",TD) W ZAA02G($S(TD#2:"LO",1:"HI")),TA I TD#2=0 S:TD=2 TD(%R)=TU S %C=$L($P(TX,"|",1,TD-1))-TD+TC+3,@TN,TU(TU)=TF_TA,TH=TH_"\"_$E(TA),TA(TU)=%R,TU=TU+1
 W $J("",TW-$L(TX)+TD-1),TY Q
 Q
C6 S %C=TC+3 W @ZAA02GP,ZAA02G("RON"),$P(TX,"`",2),$J("",TW-$L(TX)-3),ZAA02G("ROF") S %R=%R+1,%C=TC Q:$D(TG)  W @ZAA02GP,TY,$J("",TW),TY Q
LINE S TX=$E(TX,2),%R=%R+1 Q:$D(TG)&(TX="T")  S %C=TC W @ZAA02GP,ZAA02G("G1"),ZAA02G("HI"),ZAA02G($S(TX="T":"TLC",TX="B":"BLC",1:"LI")),TM F TD=6:2:TW W TM
 W TM,ZAA02G($S(TX="T":"TRC",TX="B":"BRC",1:"RI")),ZAA02G("G0") Q:TX="T"  S TX=$P($T(@TE+(TJ+1)),";",2,99) Q:TX'["|"  S TJ=TJ+1,TS=1
 F TD=1:1:$L(TX,"|") S TA=$P(TX,"|",TD),%C=$F(TX,"|",TD)+TC W @ZAA02GP I TD#2=0 W ZAA02G("HI"),TA S:TD=2 TD(%R)=TU S @TN,TU(TU)=TF_TA,TH=TH_"\"_$E(TA),TA(TU)=%R,TU=TU+1
 Q
 ;
DATA16 S TE="DATA16",HLP="9,15" G BEG
 ;*T
 ;` ZAA02G-SCRIPT INCENTIVE PAY REPORT GLOSSARY WORDS
 ;Use the following mnemonics (preceded with a ~$) to insert text:
 ; CHAR  - # of characters         TCHAR  - total # characters
 ; DATE  - Date of data            TDAYS  - total # of days
 ; DATER - Date range of report    TYPING - total keyboard time
 ; LINE  - # of lines              TLINE  - total # of lines
 ; PBASE  - Patient Base Rate
 ;
 ;
 ;
 ;*B
 ;**
DATA17 ;
