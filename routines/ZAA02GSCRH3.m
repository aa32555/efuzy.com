ZAA02GSCRH3 ;PG&A,ZAA02G-SCRIPT,2.10,HELP SCREENS;22DEC94 11:07A;;;29JAN95  15:20
 ;;Copyright (C) Patterson, Gray and Associates, Inc.
 ;Copyright (C) 1989, Patterson, Gray and Assoc., Inc.
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
DATA11 S TE="DATA11",HLP="9,15" G BEG ; MIDS
 ;*T
 ;` ZAA02G-SCRIPT REPORT GLOSSARY             (Press EXIT to return)
 ;Use the following mnemonics (preceded with a ~$) to insert text:
 ; ADMIT - Admit Date    ADMT - Admit Time    CC1 - cc1 name
 ; CC2  - cc2 name       CONSULT-Attend. Dr   DD  - date dict.
 ; DIST - distribution   DOB - date of birth  DR  - signature
 ; DT  - date typed      MR   - med rec #     PATIENT-last,first
 ; PROC1 - procedure     PROC2- Patient Type  PROVIDER-dictator
 ; REV - Room            SITEC- site code     TEMPLATE-report temp
 ; TEMPLATE2- Acct #     TM - time transcr.   TR - transcriptionist
 ; WORK - work type
 ;*B
 ; |EXAMPLES|      |MODIFIERS|
 ;**
DATA12 ;
 ;
DATA13 S TE="DATA13",HLP="9,15" G BEG
 ;*T
 ;` ZAA02G-SCRIPT REPORT GLOSSARY             (Press EXIT to return)
 ;Use the following mnemonics (preceded with a ~$) in insert text:
 ;CC1  - cc1 name        CC2  - cc2 name         CC3  - cc3 name
 ;DD   - date dictated   DOB  - date of birth    DOI  - date of injury
 ;DR   - Prov. Name      DS   - exam date        DT   - date typed
 ;LOC  - location        MR   - accnt #          PATIENT - Last, First
 ;PN   - First Last      PROC1- procedure        PROVIDER - prov code
 ;PVI  - prov initials   RFN  - Referral name    SEX  - Patient's Sex
 ;SITEC- location code   SSAN - Patient's SSAN   TEMPLATE - 
 ;TM   - time transcr.   TR   - transcriptionist
 ;*B
 ; |EXAMPLES|   |MODIFIERS|
 ;**
DATA14 ;
 ;
DATA15 S TE="DATA15",HLP="" G BEG
 ;*T
 ;` ZAA02G-SCRIPT GLOSSARY MODIFIERS
 ;Use the following modifier to format the text as follows:
 ;
 ;   .L   Left justifies text without moving text to right
 ;   .R   Right justifies text at current position
 ;   .C   Centers text at current position
 ;   .D   Converts MM/DD/YY date format to MMMMMMMM DD, YYYY format
 ;   .CC  Adds cc: to beginning of text
 ;   .X   Converts text to all upper case
 ;   .x   Converts text to upper and lower
 ;*B
 ;**
