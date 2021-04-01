ZAA02GFAXQ ;PG&A,ZAA02G-FAX,1.36,QUEUE DOCUMENT;26JAN96 9:04A;;;Fri, 19 Aug 2016  14:59
 ;Copyright (C) 1991-1994, Patterson, Gray and Associates Inc.
 ;
 ;
START D INIT S SEL=0,NX=14,TYP=1 I FAX="" S Y="Fax is not defined in device tables\Call system manager",Y="40\CRHL\1\\\"_$P(Y,"\")_"*,*,*,"_$P(Y,"\",2),%R=BL-10 D ^ZAA02GFAXU2 Q
 G:$S('$D(QC):0,QC=2:1,1:0) S2 S Y="Send Current Document,Resend Fax,Cancel ZAA02G-FAX Job,Document Status,Edit PhoneBook,FAX/Server Status,ZAA02G-FAX Statistics",Y="40\CRHLUD\1\ZAA02G-FAX\\"_$S($D(ZAA02G(9)):@ZAA02G(9)@(30),1:Y)
 S %R=BL-8,Y(0)="\EX" D ^ZAA02GFAXU2 G:X["EX" END
 G RESEND:X=2,CANCEL:X=3,DSTATUS:X=4,PB:X=5,SERVER:X=6,STATS:X=7
S2 K X S X(2)=FAXN,X(34)=$S($D(OVR):"S OVR="""_OVR_"""",1:""),X(7)="*",X(1)=$G(USER,$I)
 S:$D(FAXTO)#2 X(4)=FAXTO S:$D(FAXSUB) X(3)=FAXSUB S:$D(FAXFROM) X(1)=FAXFROM S:$D(FAXTOF) X(5)=FAXTOF S:$D(FAXORG) X(6)=FAXORG
 S B=^ZAA02GFAXC("DEFLTS"),X(11)=$S($P(B,"\",1)="":"Y",1:$P(B,"\",1)),X(14)=$S($P(B,"\",4)="":"Y",1:$P(B,"\",4)),X(15)=$P(B,"\",5),X(16)=$P(B,"\",6)
S4 D ^ZAA02GFAXQ1 G END:X(5)="",END:FNC["EX" S C=X(5) I C'["@" S C=$TR(C,"0123456789,- FAX()/","0123456789") I $L(C)>7,10'[$E(C),$S($D(ZAA02G("d")):'ZAA02G("d"),1:1) D ATT G S4:Y=7
 X:$G(^ZAA02GFAXC("AREACODE"))]"" ^ZAA02GFAXC("AREACODE")
 S FAXTO=X(4),FAXTOF=X(5),FAXFROM=X(1),FAXORG=X(6),FAXSUB=X(3) S:FAXTO'="" ^ZAA02GFAXP($TR(FAXTO,lc,uc))=FAXTOF_"`"_FAXTO_"`"_X(7)_"`"_X(8)_"`"_X(9)_"`"_X(10)_"`"_X(11)_"`"_X(12)_"`"_X(13)_"`"_X(14)_"`"_X(15)_"`"_X(16)_"`"_FAXORG
 S STM="" I X(9)_X(10)'="" D DELAY^ZAA02GFAXU G:STM="" END
 D JOB S MESS=4 D MESS
 F C=7:1:10 I X(C)="*" S X(7)=C-6 Q
S3 D COPY,TDATE^ZAA02GFAXU S:X(7)<1 X(7)=1 S B=$G(USER,$I)_"\"_$S(DIR="TRANS":DOC,1:DIR_DOC)_"\"_$P("Regular,Priority,Delayed,Economy",",",X(7))
 S B=B_"\"_X(5)_"\\"_DTM_"\\\\1\"_X(1)_"\"_X(2)_"\"_X(4)_"\"_X(7)_"\"_X(11)_"\"_X(12)_"\"_X(13)_"\"_X(14)_"\"_X(15)_"\"_X(16)_"\\\\"_STM_"\\\\"_(+$H)_"\\\"_X(3)_"\"_X(6)_"\\"_X(34),$P(B,"\",41)=$G(X(41)) K X
S1 S ^ZAA02GFAXQ("DIR",10000-JOB)=B,^ZAA02GFAXQ(.9,JOB)="" S:$D(FAXEXEC) ^(10000-JOB,0)=FAXEXEC S:$P(B,"\",14)=2 ^ZAA02GFAXQ(.9,JOB/100000)=""
 S NS=$S($ZV["M3":$ZN,1:$ZU(5))
 L +ZAA02GFAX(NS,0):0 I  L -ZAA02GFAX(NS,0) J ^ZAA02GFAXC
 I $D(FNC),FNC="PD" G S2
 G:'$D(QC) START
END K FAX,FNC,B,X,lc,H,I,J,MESS,A,C,NE,R,Y,YR,MT,SEL,RX,RD,TM,DTM,DT,ZAA02GC,QC,STM,FAXEXEC S:$D(ZAA02G(9.1)) ZAA02G(9)=ZAA02G(9.1) K ZAA02G(9.1) Q
 ;
ST D SETUP^ZAA02GWP S BL=22,%R=15 G START
 ;
DSTATUS D ^ZAA02GFAXS G START
PB D ^ZAA02GFAXQ2 G START
STATS S TYP=3,EX="FAX" D ^ZAA02GFAXS G START
CANCEL D SEL^ZAA02GFAXS Q:ZF="EX"  Q:X=""  S JOB=10000-X,B=^ZAA02GFAXQ("DIR",X) K ^(X,0) Q:'$D(^ZAA02GFAXQ(.9,JOB))  S $P(B,"\",10)=9,$P(B,"\",3)="CANCEL" S:$P(B,"\",33) $P(B,"\",10)=7,$P(B,"\",3)="Sent-"_$P(B,"\",33) S ^ZAA02GFAXQ("DIR",10000-JOB)=B K ^ZAA02GFAXQ(.9,JOB)
 S MESS=2
CAN1 D MESS Q:$D(TFM)  S SEL=-1 G DSTATUS
MESS S Y=$S('$D(ZAA02G(9)):"Fax Source has been purged,*,Must Resend from Original\JOB CANCELLED\JOB # RESENT\Document is being sent to ZAA02G-FAX,*,          Job #",1:@ZAA02G(9)@(7)) S MESS=$P(Y,"\",MESS) S:MESS["#" MESS=$P(MESS,"#")_"#"_JOB_$P(MESS,"#",2)
 S %R=BL-6,Y=$L(MESS)\-2+50_"\DLHCW3\1\\\*,"_MESS_",*" X "N X D ^ZAA02GFAXU2" Q
RESEND G RESEND^ZAA02GFAXQ2
JOB L +ZAA02GFAX("JOB") S JOB=$S('$D(^ZAA02GFAXQ(.5)):1,1:^(.5)+1),^(.5)=JOB L -ZAA02GFAX("JOB") Q
COPY S ^ZAA02GFAXQ("SRC",JOB)=+$H_","_$G(X(11)),Y=0 I $D(@ZAA02GWPD@(.015))#2 S A=^(.015),C=$S($D(^(.01)):^(.01),1:76),Y=$O(^(.03)) S:Y Y=^(Y)[$C(1) S ^ZAA02GFAXQ("SRC",JOB,.015)=A,^(.01)=C
 S A=.03,C=A I Y F J=1:1 S A=$O(@ZAA02GWPD@(A)) Q:A=""  S ^ZAA02GFAXQ("SRC",JOB,J)=$P(^(A),$C(1),4) S:^(J)'="" C=J D:^(J)["~EC" EC
 E  D
 . S C=0 F J=1:1 S A=$O(@ZAA02GWPD@(A)) Q:A=""  S ^ZAA02GFAXQ("SRC",JOB,J)=@ZAA02GWPD@(A)
 I C,$O(^ZAA02GFAXQ("SRC",JOB,C)) F J=C+1:1:J K ^(J)
 ; D CHECKDUP
 Q
EC S ^(J)=^(J)=$P(^(J),"~EC")_$S(^(J)["ESME":"Electronically Signed",1:"") Q
 ;
CHECKDUP I $G(ZAA02GSCR)]"",$G(DOC)>0 S A="" F  S A=$O(^ZAA02GFAXQ(.9,A)) Q:A=""  I $P($G(^ZAA02GFAXQ("DIR",10000-A)),"\",2)=DOC S B=^(10000-A) D
 . S C=1 D
 .. I $O(^ZAA02GFAXQ("SRC",JOB,""),-1)'=$O(^ZAA02GFAXQ("SRC",A,""),-1) Q
 ..  S C="" F  S C=$O(^ZAA02GFAXQ("SRC",JOB,C)) Q:C=""  I ^(C)'=$G(^ZAA02GFAXQ("SRC",A,C)) S C=1 Q
 . I C=1 K ^ZAA02GFAXQ("SRC",A),^ZAA02GFAXI(A) M ^ZAA02GFAXQ("SRC",A)=^ZAA02GFAXQ("SRC",JOB) S $P(B,"\",10)=1,$P(B,"\",3)="READY",^ZAA02GFAXQ("DIR",10000-A)=B
 Q
SERVER D STATUS^ZAA02GFAXU G START
INIT S FAX=$S($D(^ZAA02GFAXC("FAX")):^("FAX"),1:"") S:'$D(FAXN) FAXN=$P(FAX,"\",3) S FAX=$P(FAX,"\"),lc="abcdefghijklmnopqrstuvwxyz",uc="ABCDEFGHIJKLMNOPQRSTUVWXYZ" S:'$D(ZAA02G(3)) ZAA02G(3)=$G(USER)
 I $D(ZAA02G(9)),ZAA02G(9)["ZAA02GWP" S ZAA02G(9.1)=ZAA02G(9),$P(ZAA02G(9),"(")="^ZAA02GFAXC"
 Q
ATT S %R=BL-7,Y="35\LHCD\1\Fax Number Check: "_X(5)_"\\*,Select one-*,*,Add  1    to the number,Add  011  to the number,Use the number as is,Return" X "N X D ^ZAA02GFAXU2 S Y=X" S:Y=4 X(5)=1_X(5) S:Y=5 X(5)="011"_X(5) Q
 ;
QUEUE D INIT S DIR=$G(DIR),FAXPARAM=$TR(FAXPARAM,"\","|") F J=1:1:19 S X($P("1,2,3,4,5,6,7,18,11,12,13,14,15,16,19,20,17,34,41",",",J))=$P(FAXPARAM,"`",J)
 I X(5)'["@",X(5)'["Surescripts:" D
 . S X(5)=$TR(X(5),"()-/ ") I $L(X(5))=10 S X(5)=1_X(5)
 . X:$G(^ZAA02GFAXC("AREACODE"))]"" ^ZAA02GFAXC("AREACODE")
 S DOC=X(17),STM=X(18),QC=1 D JOB D S3 K:$D(ZAA02G)=10 ZAA02G Q
DIRECT D:'$D(ZAA02G) FUNC^ZAA02GDEV X ^ZAA02G("TERM-ON"),^ZAA02G("WRAP-OFF") S:'$D(BL) BL=22 S:'$D(DOC) DOC="" S:'$D(DIR) DIR="" S:'$D(QC) QC=1 D START X ^ZAA02G("WRAP-ON"),^ZAA02G("TERM-OFF") Q  ; may also set OVR, QC=2 means no menu
STATUS S:'$D(JOB) JOB=1 I JOB,$D(^ZAA02GFAXQ("DIR",10000-JOB)) S JOB=$P(^(10000-JOB),"\",3)
 Q
