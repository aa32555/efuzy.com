ZAA02GSENDD ;PG&A,ZAA02G-SEND,1.36,KERMIT CALLS;8NOV95 11:10A;;;18JUL96  13:17
 ;Copyright (C) 1983, Patterson, Gray and Associates, Inc.
 ;
SENDGLO ;  This code sends one or more globals to a remote Kermit site
 ;
 ;   MODEM - device name (number) of output port
 ;   GLOB  - local or global name with file list
 ;            GLOB(0,"FILE",1)=remote (receiver) file name
 ;            GLOB(0,"FILE",1,0)=global reference of 1st global
 ;            GLOB(0,"FILE",2)=second file name
 ;            GLOB(0,"FILE",2,0)=second global reference
 ;   SFL   - type of transfer
 ;         =0  binary transfer - no changes
 ;         =1  text transfer - CR + LF added at end of each node
 ;         =2  ZAA02G-SEND global transfer - global reference and
 ;             lengths are added
 ;   KP    - Kermit paramters:  D-display,N-No control char process
 ;                              T-trace display
 ;
 D INIT^ZAA02GSENDA S SDATA="D:'CF @%ST I CF S SDB=$O(CC(SDB)),CF=CF-1,SD=CC(SDB) K CC(SDB)"
 S %ST="ENTRY1^ZAA02GSENDB" D SEXE^ZAA02GSEND9 G EXIT
 ;
EXIT K CC,CT,CA,C6,CQ,WO,SDATA,SDB,%ST,SFL Q
EXAMPLE S GLOB="GL",GL(0,"FILE",1)="ABC1",GL(0,"FILE",1,0)="^BOB",GL(0,"FILE",2)="ABC2",GL(0,"FILE",2,0)="^ZAA02G(.1)",GL(0,"FILE",3)="ABC3",GL(0,"FILE",3,0)="^COMP"
 S MODEM=12,SFL=1,KP="D"  G SENDGLO
 ;
 ;
ASCII S SDATA="D:'CF @%ST I CF S SDB=$O(CC(SDB)),CF=CF-1,SD=CC(SDB) K CC(SDB)"
 S %ST="ENTRY1^ZAA02GSENDB",%G="^ZAA02GSCR",CF=0,SZ=255+8,SFL=2,CC=1,(C6,SK,CC(1),%X1,SDB,CA,S8)="",(CQ,SQ)="#",$P(CA,"X",32)="" F J=0:1:31 S C6=C6_$C(J)
 F J=1:1 X SDATA Q:SDB=""  W SD,!
 Q
 ;
FEED ; EXAMPLE OF KERMIT FEED LOGIC
 S MODEM=0 D INIT^ZAA02GSENDA S SDATA="D:'CF @%ST I CF S SDB=$O(CC(SDB)),CF=CF-1,SD=CC(SDB) K CC(SDB)"
 S %ST="ENTRY1^ZAA02GSENDD" D SEXE^ZAA02GSEND9 G EXIT
ENTRY1 S %X=$H D XFR Q:CF  G ENTRY1
XFR D:$L(CC(CC))+4>SIZE XFR2 I %X1 S %X1(+%X1)=%X X "F %X1=0:1:%X1 S %X=%X1(%X1) D XFR1" Q
XFR1 I SK]"",%X["         "!(%X["0000000") D XFR3
 S %=$L(%X)+$L(CC(CC))-SIZE I %'>0 S CC(CC)=CC(CC)_%X Q
 S %=$L(%X)-%,CC(CC)=CC(CC)_$E(%X,1,%) I $L($TR($E(CC(CC),SIZE-4,SIZE),CQ,""))'=5 S %C=0 F %B=SIZE:-1:SIZE-4 I CQ'[$E(CC(CC),%B) Q:%B=SIZE  S %=%B-SIZE+%,CC(CC)=$E(CC(CC),1,%B) Q
 D XFR2 S %X=$E(%X,%+1,9999) G XFR1
 Q
XFR2 S CC=CC+1,CC(CC)="",CF=CF+1 Q
END S %ST="END1^ZAA02GSENDD" I $D(CC(CC)),CC(CC)]"" S CF=CF+1
 Q
END1 S:'CF SDB="" I SDB="" K CC Q
 Q
 ;
KERM S MODEM=0,%G="ZAA02GSEND",SFL=2 D INIT^ZAA02GSENDA S SDATA="D:'CF @%ST I CF S SDB=$O(CC(SDB)),CF=CF-1,SD=CC(SDB) K CC(SDB)"
 S %ST="ENTRY1^ZAA02GSENDB" S SDB="" F J=1:1 X SDATA Q:SDB=""  W SD,!!
 Q
 ;
SENDROU ;  This code sends one or more ROUTINES to a remote Kermit site
 ;
 ;   MODEM - device name (number) of output port
 ;   GLOB  - local or global name with file list
 ;            GLOB(0,"FILE",1)=remote (receiver) file name
 ;            GLOB(0,"FILE",1,0)=reference of routine list (either
 ;                               local or global) in the following
 ;                               format:
 ;                               REF(routinename)=""
 ;            GLOB(0,"FILE",2)=second remote file name (if any)
 ;            GLOB(0,"FILE",2,0)=second routine list reference
 ;   KP    - Kermit paramters:  D-display,N-No control char process
 ;                              T-trace display
 ;
 D INIT^ZAA02GSENDA S SFL=1,SDATA="D:'CF @%ST I CF S SDB=$O(CC(SDB)),CF=CF-1,SD=CC(SDB) K CC(SDB)"
 S %ST="RENTRY^ZAA02GSENDB" D SEXE^ZAA02GSEND9 G EXIT
 ;
REXAMPLE ;ROUTINE SEND EXAMPLE
 S GLOB="GL",GL(0,"FILE",1)="ROUTINES.TXT",GL(0,"FILE",1,0)="^UTILITY($J)"
 S MODEM=20,KP="D"  G SENDROU
 ;
KERMR S MODEM=0,%G="^UTILITY(1)" D INIT^ZAA02GSENDA S SDATA="D:'CF @%ST I CF S SDB=$O(CC(SDB)),CF=CF-1,SD=CC(SDB) K CC(SDB)"
 S %ST="RENTRY^ZAA02GSENDB",SFL=1 S SDB="" F J=1:1 X SDATA Q:SDB=""  W SD,!!
 Q
RECOVER S G="^ZAA02GKERMIT",A=$O(@G@(""),-1),B=$O(@G@(A,""),-1),(C,D,E)="" F  S:D="" C=$O(@G@(A,B,1,C)),D=^(C) S E=E_$P(D,$C(13,10)) D:D[$C(13,10) RECOV1 S D=$P(D,$C(13,10),2,99)
 Q
RECOV1 I E'[" " S R=E,L=1 W E,! S E="" Q
 I $T(+L^@R)'=E W C,!,$T(+L^@R),!,E,!! R CCC
 S E="",L=L+1 Q
 Q
 ;
SENDFILE ;  This code sends one or more HOST FILES to a remote Kermit site
 ;
 ;   MODEM - device name (number) of output port
 ;   GLOB  - local or global name with file list
 ;            GLOB(0,"FILE",1)=remote (receiver) file name
 ;            GLOB(0,"FILE",1,0)=local file name to send
 ;            GLOB(0,"FILE",2)=second remote file name (if any)
 ;            GLOB(0,"FILE",2,0)=second local file name
 ;   SFL   - type of transfer
 ;         =0  binary transfer - for non-ASCII files
 ;         =1  text transfer - CR + LF added at end of each line
 ;   KP    - Kermit paramters:  D-display,N-No control char process
 ;                              T-trace display
 ;
 D INIT^ZAA02GSENDA S SDATA="D:'CF @%ST I CF S SDB=$O(CC(SDB)),CF=CF-1,SD=CC(SDB) K CC(SDB)"
 S %ST="FENTRY^ZAA02GSENDB" D SEXE^ZAA02GSEND9 G EXIT
 ;
FEXAMPLE ;FILE SEND EXAMPLE
 S GLOB="GL",GL(0,"FILE",1)="FILETEST",GL(0,"FILE",1,0)="PSM.EXE"
 S MODEM=20,KP="D",SFL=0  G SENDFILE
 ;
KERMF S MODEM=0,%G="C:\AUTOEXEC.BAT" D INIT^ZAA02GSENDA,CTINIT^ZAA02GSENDB S SIZE=200,SDATA="D:'CF @%ST I CF S SDB=$O(CC(SDB)),CF=CF-1,SD=CC(SDB) K CC(SDB)",CF=0
 S %ST="FENTRY^ZAA02GSENDB",SFL=1 S SDB="" F J=1:1 X SDATA Q:SDB=""  W SD,!!
 Q
 ;
