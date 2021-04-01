ZAA02GCOMMH ;PG&A,ZAA02G-COMM,1.36,HELP SCREENS\;09NOV93  22:16;17FEB92  11:05;28JUL95 4:51P [ 02/17/98   9:40 AM ]
 ;; Copyright (C) 1992 Patterson, Gray and Associates, Inc.
 ;; All rights reserved.
 ;Copyright (C) 1989, Patterson, Gray and Assoc., Inc.
BEG F TJ=1:1 S TX=$P($T(@TE+TJ),";",2,99) Q:TX="**"  D @$S($E(TX)="*":"LINE",TX["`":"C6",1:"C3")
 Q
C3 S %R=%R+1,%C=TC W @ZAA02GP,TY F TD=1:1:$L(TX,"~") S TA=$P(TX,"~",TD) W ZAA02G($S(TD#2:"LO",1:"HI")),TA I TD#2=0 S:TD=2 TD(%R)=TU S %C=$L($P(TX,"~",1,TD-1))-TD+TC+3,@TN,TU(TU)=TF_TA,TH=TH_"\"_$E(TA),TA(TU)=%R,TU=TU+1
 W $J("",TW-$L(TX)+TD-1),TY Q
C6 S %C=TC+3 W @ZAA02GP,ZAA02G("RON"),$P(TX,"`",2),$J("",TW-$L(TX)-3),ZAA02G("ROF") S %R=%R+1,%C=TC Q:$D(TG)  W @ZAA02GP,TY,$J("",TW),TY Q
LINE S TX=$E(TX,2,80),%R=%R+1 Q:$D(TG)&($E(TX)="T")  S %C=TC W @ZAA02GP,ZAA02G("G1"),ZAA02G("HI"),ZAA02G($S($E(TX)="T":"TLC",$E(TX)="B":"BLC",1:"LI")),TM F TD=6:2:TW W TM
 W TM,ZAA02G($S("TB"[$E(TX):$E(TX)_"RC",1:"RI")),ZAA02G("G0") Q:$E(TX)="T"  F TD=2:2:$L(TX,"~") S TA=$P(TX,"~",TD) S:TD=2 TD(%R)=TU S %C=$L($P(TX,"~",1,TD-1))-TD+TC+3,@TN,TU(TU)=TF_TA,TH=TH_"\"_$E(TA),TA(TU)=%R,TU=TU+1 W TU(TU-1)
 Q
 ;
DATA1 S TE="DATA1",HLP="2,5,6," G BEG
 ;*T
 ;` ZAA02G-COMM SCRIPT PROCESSING FACILITY
 ; ZAA02G-COMM allows the user to create, edit and execute scripts that
 ; perform various functions such as dialing modems, displaying mess-
 ; ages and controlling devices.  A simple script language is used by
 ; the user to direct this process.  The following help information is
 ; available concerning the script language:
 ;
 ;    ~listing~ of script commands
 ;    ~examples~ of the script language
 ;    ~additional information~ concerning using scripts
 ;*B
 ;**
DATA2 S TE="DATA2",HLP="3," G BEG
 ;*T
 ;` ZAA02G-COMM SCRIPT LANGUAGE COMMANDS    (Press EXIT to return)
 ; CAPTURE [ON,OFF]   -  Select Capture mode
 ; ELSE GOTO-xx       -  Branch on False Condition
 ; END                -  Quit script - return to Command Mode
 ; GOTO-xx            -  Unconditional branch
 ; IF GOTO-xx         -  Branch on True Condition
 ; PAUSE-xx           -  Pause for xx seconds
 ; QUIET [ON,OFF]     -  Selects command display
 ; REPORT-xx          -  Displays user message
 ; RASCII-xx          -  Receive File using ASCII transfer
 ;*B         ~NEXT~
 ;**
DATA3 S TE="DATA3",HLP="4,2,5," G BEG
 ;*T
 ;` ZAA02G-COMM SCRIPT LANGUAGE COMMANDS - CONTINUED
 ; REM                -  Remark, not executed
 ; RKERMIT-xx         -  Receive File using Kermit transfer
 ; SASCII-xx          -  Send File using ASCII transfer
 ; SKERMIT-xx         -  Send File using Kermit transfer
 ; RUN-xx             -  Executes another script
 ; SEND-xx            -  Transmit message to port
 ; SET BAUD-b,p,d     -  Set port baud rate, parity & bits (9600,N,8)
 ; SET DELAY-xx       -  Set delay time before SEND
 ; SET DEVICE-xx      -  Select Port #
 ;*B      ~NEXT~    ~PREVIOUS~    ~EXAMPLES~
 ;**
DATA4 S TE="DATA4",HLP="3,5," G BEG
 ;*T
 ;` ZAA02G-COMM SCRIPT LANGUAGE COMMANDS - CONTINUED
 ; SET FILTER-xx      -  Select Input Filter
 ; SET FLAG [0,1]     -  Set Condition Flag (0-false,1-true)
 ; SET WAIT-xx        -  Set WAIT FOR timeout in seconds (default-10)
 ; TERM ON            -  Begin Terminal Emulation
 ; TRACE [ON,OFF]     -  Debugging facility
 ; WAIT FOR-xx        -  Wait for input match
 ;
 ;
 ;
 ;*B      ~PREVIOUS~    ~EXAMPLES~
 ;**
DATA5 S TE="DATA5",HLP="" G BEG
 ;*T
 ;` ZAA02G-COMM SCRIPT COMMANDS - EXAMPLES
 ; SET WAIT-60                      - sets timeout to 60 seconds
 ; REPORT-WAIT FOR DIALING          - send message to screen
 ; SEND-ATDT 123456\                - send dial command (and CR)
 ; WAIT FOR-CONNECT|BUSY|NO CARRIER - wait for response
 ; GOTO-GOOD|ERROR1|ERROR2          - computed GOTO
 ; END                              - all other responses end
 ; GOOD:                            - label
 ; REPORT-CONNECTION MADE           - message to user
 ; 
 ;*B
 ;**
DATA6 S TE="DATA6",HLP="" G BEG
 ;*T
 ;` ZAA02G-COMM SCRIPT CONVENTIONS
 ; 1.  Create the script with the "E"dit option
 ; 2.  Execute the script with the "X" option
 ; 
 ;
 ; 
 ; 
 ; 
 ; 
 ;
 ;*B
 ;**
