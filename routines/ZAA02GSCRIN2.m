ZAA02GSCRIN2 ;PG&A,ZAA02G-SCRIPT,2.10,SYSTEM INITIALIZATION;27DEC94 4:45P;;;Mon, 18 Jan 2010  09:42
C ;Copyright (C) 1991-1994, Patterson, Gray & Associates, Inc.
 ;
 G INIT
BEG S %R=4,%C=8 W @ZAA02GP,ZAA02G("LO"),"Is this a REMOTE (or Home) Transcription System ? (Y or N) - ",ZAA02G("HI"),ZAA02G("CS") R A#1 I "YN"'[A W *7 G BEG
 G:A="N" INIT
BEG1 S %R=6,%C=8 W @ZAA02GP,ZAA02G("LO"),"What is the last name of the Transcriptionist ? ",ZAA02G("HI"),ZAA02G("CS") R A#20 G:A="" BEG S NAM=A
BEG2 S %R=8,%C=8 W @ZAA02GP,ZAA02G("LO"),"What is the first name of the Transcriptionist ? ",ZAA02G("HI"),ZAA02G("CS") R A#20 G BEG1:A="" S FNAM=A
 S %R=10,%C=8 W @ZAA02GP,ZAA02G("LO"),"What are the initials of the Transcriptionist ? ",ZAA02G("HI"),ZAA02G("CS") R A#3 G BEG2:A="" S INIT=$TR(A,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 S %R=12,%C=8 W @ZAA02GP,ZAA02G("LO"),"Is the above information correct ? (Y or N) - ",ZAA02G("HI"),ZAA02G("CS") R A#1 G BEG:A="N",BEG:A="n"
 D INITR Q
INIT S @ZAA02GSCR@("PARAM","NEXT")=1,@ZAA02GSCR@("PARAM","BASIC")=$P($G(^PRMG(1,1)),":",2)_"|C+W+B+L||C+W+B+L+36\72|Y|M||||Y|||"
 I $D(^RFG) S @ZAA02GSCR@("PARAM","SCR")=27,^("RSL")="D STUDU^ZAA02GADSGEN",^("LOOKUP")=2,^ZAA02G("GETPRINTER")="S VDV=$S($D(^LPT(VDV)):$P(^(VDV),"";""),1:VDV)",^ZAA02GACT=""
 I  F J=1:1:3 S @ZAA02GSCR@("PARAM",$P("EDITHEADER,NOSITESTATS,SINGLECOPY,",",",J))=$P("1,N,Y",",",J)
 S @ZAA02GSCR@("PARAM","DIST","A")="Single Copy\1\1\Original Copy - Do Not Remove From Medical Records"
 S @ZAA02GSCR@("PARAM","USER","xxx")="Last\First\xxx\M\\\Y\xxx\Y",@ZAA02GSCR@("PARAM","CODE","xxx")="xxx" S INIT="xxx"
 D FOOT,FOOT2,CONT,BLANK S DIR=106 D ALL^ZAA02GSCRRD S DIR=110 D ALL^ZAA02GSCRRD
 I $D(^SCRIPT) D REBUILD
 D:'$D(qt) MESS K TEST
 Q
REBUILD N (ZAA02G,ZAA02GP,qt) S X="^SCRIPT" D REBUILD^ZAA02GFRMM4 Q
INITR S ZAA02GSCR="^ZAA02GSCRR",@ZAA02GSCR@("PARAM","NEXT")=1,@ZAA02GSCR@("PARAM","BASIC")="Remote Site|C+W+B+L||C+W+B+L+36\72|Y|Y|3|5|5|Y|||",@ZAA02GSCR@("PARAM","USER",INIT)=NAM_"\"_FNAM_"\"_INIT_"\N\\\Y\"_INIT_"\Y",@ZAA02GSCR@("PARAM","CODE",INIT)=INIT
 I $D(^SCRIPT) N (ZAA02G,ZAA02GP) S X="^SCRIPT" D REBUILD^ZAA02GFRMM4
 D MESS
 Q
MESS W ZAA02G("F") S %R=15,%C=20 W @ZAA02GP,ZAA02G("LO"),"Use the password ",ZAA02G("HI"),INIT,ZAA02G("LO")," to logon to ZAA02G-SCRIPT" S %R=18 W @ZAA02GP,"PRESS RETURN to continue" R A#1 Q
 ;
DEVICE ; Default device table maintenance
 ; assumes PARAM,DEVICE)=S DV=$S($D(^("DEVICE",$I)):^($I),1:"")
 N (ZAA02G,ZAA02GP,ZAA02GSCR) S TL=4,MG=60,NM="DEVICE DEFAULTS",ZAA02GWPD="^ZAA02GTWP($J)",ZAA02GWPOPT="ST" S A="" K @ZAA02GWPD S @ZAA02GWPD@(.001)="|"_$J("X",30) F J=10:10 S A=$O(@ZAA02GSCR@("PARAM","DEVICE",A)) Q:A=""  S @ZAA02GWPD@(J)="device="_A_$J("",22-$L(A))_"default="_$G(^(A))
 D ENTRY^ZAA02GWPV6 S A=.03,ZAA02GWPD="^ZAA02GTWP($J)" F  S A=$O(@ZAA02GWPD@(A)) Q:A=""  I $G(^(A))'?." " S B=^(A),C=$TR($P(B,"default=",2)," "),B=$TR($P($P(B,"device=",2),"default")," ","") S:B]"" @ZAA02GSCR@("PARAM","DEVICE",B)=C
 Q
 ;~EC I WW-LN-100<8,'HFA S EXE="S I=1E5,C(2E5)=""~"" K EXE"
 ;~EC I WW-LN-100<8!HFA K C S (C,I)="" W:'PGP !?30,"(continues)"
 ;
FOOT2 I '$D(@ZAA02GSCR@(110,"FOOT2")) F J=2:1:17 S A=$P($T(FOOT2+J),";",2,9) S @ZAA02GSCR@(110,"FOOT2",J*10)=J-1*10_$C(1,1,1)_A
 Q
 ;FOOTER FOR LAST PAGE - SIGNATURE BLOCK
 ;
 ;Thank you for the courtesy of this referral.
 ;
 ;                                    Sincerely,
 ;
 ;
 ;
 ;                                    ~$PV3
 ;~$PVI3:~$TR
 ;
 ;~$CC1N
 ;~$CC2N
 ;~$CC3N
FOOT I '$D(@ZAA02GSCR@(110,"FOOT")) F J=2:1:4 S A=$P($T(FOOT+J),";",2,9) S @ZAA02GSCR@(110,"FOOT",J*10)=J-1*10_$C(1,1,1)_A
 Q
 ;CONTINUATION FOOTER
 ;
 ;                  (CONTINUES)
CONT I '$D(@ZAA02GSCR@(110,"CONT")) F J=2:1:4 S A=$P($T(CONT+J),";",2,9) S @ZAA02GSCR@(110,"CONT",J*10)=J-1*10_$C(1,1,1)_A
 Q
 ;CONTINUATION HEADER
 ; RE: ~$PN    ACCNT#: ~$MR      DOS: ~$DS
 ;     
BLANK I '$D(@ZAA02GSCR@(106,"blank")) F J=3:1:24 S A=$P($T(BLANK+J),";",2,9) S @ZAA02GSCR@(106,"blank",J*10)=J-1*10_$C(1,1,1)_A
 S ^(.03)="6\10\1\1\N\1.6\5\\1\1\\\\CONT\\\A\\"
 Q
 ;BLANK REPORT
 ;                                           ~$DT
 ;
 ;~$RFN
 ;~$RFA1
 ;~$RFA2
 ;~$RFCSZ
 ;
 ;
 ;Dear ~$RFL.L,                            ~   RE: ~$PN
 ;
 ;*
 ;
 ;IMPRESSION:  *
 ;
 ;
 ;~$PVI3/~$TR                        ~    Very truly yours,
 ;~$CC1N
 ;~$CC2N
 ;~$CC3N
 ;                                        ~$PV3
