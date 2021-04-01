ZAA02GSCRH2 ;PG&A,ZAA02G-SCRIPT,2.10,HELP SCREENS;22DEC94 11:01A;;;13MAR96  22:47
 ;Copyright (C) 1989, Patterson, Gray and Assoc., Inc.
BEG F TJ=1:1 S TX=$P($T(@TE+TJ),";",2,99) Q:TX="**"  D @$S($E(TX)="*":"LINE",TX["`":"C6",1:"C3")
 Q
C3 S %R=%R+1,%C=TC W @ZAA02GP,TY F TD=1:1:$L(TX,"|") S TA=$P(TX,"|",TD) W ZAA02G($S(TD#2:"LO",1:"HI")),TA I TD#2=0 S:TD=2 TD(%R)=TU S %C=$L($P(TX,"|",1,TD-1))-TD+TC+3,@TN,TU(TU)=TF_TA,TH=TH_"\"_$E(TA),TA(TU)=%R,TU=TU+1
 W $J("",TW-$L(TX)+TD-1),TY Q
 Q
C6 S %C=TC+3 W @ZAA02GP,ZAA02G("RON"),$P(TX,"`",2),$J("",TW-$L(TX)-3),ZAA02G("ROF") S %R=%R+1,%C=TC Q:$D(TG)  W @ZAA02GP,TY,$J("",TW),TY Q
LINE S TX=$E(TX,2),%R=%R+1 Q:$D(TG)&(TX="T")  S %C=TC W @ZAA02GP,ZAA02G("G1"),ZAA02G("HI"),ZAA02G($S(TX="T":"TLC",TX="B":"BLC",1:"LI")),TM F TD=6:2:TW W TM
 W TM,ZAA02G($S(TX="T":"TRC",TX="B":"BRC",1:"RI")),ZAA02G("G0") Q:TX="T"  S TX=$P($T(@TE+(TJ+1)),";",2,99) Q:TX'["|"  S TJ=TJ+1,TS=1
 S %C=TC F TD=1:1:$L(TX,"|") S TA=$P(TX,"|",TD),%C=$L(TA)+%C W @ZAA02GP I TD#2=0 W ZAA02G("HI"),TA S:TD=2 TD(%R)=TU S @TN,TU(TU)=TF_TA,TH=TH_"\"_$E(TA),TA(TU)=%R,TU=TU+1
 Q
 ;
DATA6 S TE="DATA6",HLP="7,9,15" G BEG
 ;*T
 ;` ZAA02G-SCRIPT REPORT GLOSSARY             (Press EXIT to return)
 ;  Text can be automatically inserted with the use of the following:
 ;
 ;ACCT  - account #      AGE   -  pat. age      BDT   - pat. DOB
 ;CC1   - cc 1 code      CC1A1 - cc addr 1      CC1A2 - cc addr 2
 ;CC1CSZ- cc city,st,zp  CC1F  - cc first name  CC1L  - cc last name
 ;CC1N  - cc 1 name      CC1TL - cc title       (same for cc2 & cc3)
 ;CONSULT-referral code  DD    - date dictated  DEPT  -  department
 ;DG    -                DIST  - distr. list    DOB   -  pat. DOB
 ;DS    - date of study  DT    - date typed     DTY   -
 ;*B
 ;  |NEXT|       |EXAMPLES|  |MODIFIERS|
 ;**
DATA7 S TE="DATA7",HLP="8,6,9,15" G BEG
 ;*T
 ;` ZAA02G-SCRIPT REPORT GLOSSARY - CONTINUED
 ;
 ;FDY   -  film date    FNO   - film #        MR    - account #
 ;NOTES -               PA1   - pat. addr 1   PA2   - pat. addr 2
 ;PATIENT- patient name PCS   - pat. city,st  PCSZ  - pat city,st,zp
 ;PFN   - pat. 1st name PLN   - pat. last nm  PN    - first last
 ;PNM   - last,first    PNUM  -               PROC1 - 1st procedure
 ;PROC1T- proc1 title   PROC2 - 2nd proc      PROC2T- proc 2 title
 ;PROVIDER- prov. code  PTL   - pat. tele     PV    - prov. name
 ;PV3   - prov. name #3 PVI   - prov initials PVI3  - prov intls-3
 ;*B
 ;  |NEXT|   |PREVIOUS|  |EXAMPLES|  |MODIFIERS|
 ;**
DATA8 S TE="DATA8",HLP="7,9,15" G BEG
 ;*T
 ;` ZAA02G-SCRIPT REPORT GLOSSARY - CONTINUED
 ;
 ;REV   -               RF    - referral      RFA1  - refer addr 1
 ;RFA2  - refer addr 2  RFCS  - refer city,st RFCSZ - ref city,st,zp
 ;RFF   - refer first   RFL   - refer last    RFN   - refer name
 ;RFTL  - refer tele    RFZP  - refer zip     SEX   - pat. sex
 ;SITEC - site code     SITENM- site name     SSN   - pat. SSAN
 ;STM   -               TEMPLATE-1st report   TEMPLATE2-2nd report    
 ;TM    - time          TR - transcriptionist WORK  - work type
 ;
 ;*B
 ;  |PREVIOUS|  |EXAMPLES|  |MODIFIERS|
 ;**
DATA9 S TE="DATA9",HLP="" G BEG
 ;*T
 ;` ZAA02G-SCRIPT REPORT GLOSSARY - EXAMPLES
 ;
 ;~$RFA1.L   - Left justifies referral address - data to the right
 ;             doesn't move
 ;~$RFA2     - Referral address as above but text to right floats
 ;             with the length of the address
 ;~$MR.R     - Medical record # is right justified on the last "R"
 ;
 ;~$PV.LS3,BS,MR,DE   - creates a vertical listing of the three
 ;             providers BS, MR, and DE with the primary at the top
 ;*B
 ;**
DATA10 S TE="DATA10",HLP="9,15" G BEG
 ;*T
 ;` ZAA02G-SCRIPT REPORT GLOSSARY             (Press EXIT to return)
 ;Text can be automatically inserted with the use of the following:
 ;              (precede each word with "~$")
 ;CC1   - cc1 code/name      CC2  - cc2 code/name     CONSULT
 ;DD    - date dictated      DIST - distribution      DOB
 ;DT    - date typed         MR   - med rec #         PATIENT
 ;PROC1 - 1st procedure      PROC2- 2nd procedure     PROVIDER
 ;REV   -                    SITEC- site code         TEMPLATE
 ;TEMPLATE2- 2nd report      TM   - time transcr. 
 ;TR    - transcriptionist   WORK - work type code
 ;*B
 ;     |EXAMPLES|    |MODIFIERS|
 ;**
