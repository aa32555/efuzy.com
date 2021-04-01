ZAA02GFAXC ;PG&A,ZAA02G-FAX,1.36,QUEUE CONTROL;2016-10-28 11:21:12;;;Fri, 23 Sep 2016  15:16
 ;Copyright (C) 1993, Patterson, Gray and Associates Inc.
 ;
BEGIN I $D(^ZAA02GFAXC("CONDITION"))  X ^("CONDITION") E  H
 S A=^ZAA02G("ERROR")_"=""ERR^ZAA02GFAXC""",@A
 C:^ZAA02G("OS")="PSM" 0 B 0 S A=^ZAA02GFAXC("CONFIG"),PTR=$P(A,"\",12,13),BJBS=$P(A,"\",14),THR=$P(A,"\",15,16) S:BJBS<1 BJBS=1 S:THR<1 THR="40\10"
 S NSV=$S($ZV["M3":$ZN,1:$ZU(5))
 F SLV=0+$G(SLVO):1:BJBS+$G(SLVO) H:BJBS+$G(SLVO)=SLV  L ZAA02GFAX(NSV,SLV):0 I  Q
A D TDATE^ZAA02GFAXU S RTY=$P(^ZAA02GFAXC("DEFLTS"),"\",7),FAX="" S:RTY<1 RTY=1
PR0 S JOB="",NS=0,NC=+THR,OS=^ZAA02G("OS") K SCH,PRI H 2
 ;
CONTROL S:$D(PRI) JOB=PRI S JOB=$O(^ZAA02GFAXQ(.9,JOB)) I JOB="" G SEND:$D(PHN)>10,HALT
 I $G(SKIP(JOB))>5 G CONTROL
 I JOB["." K:'$D(^(JOB*1000000)) ^(JOB) G:'$D(^(JOB)) CONTROL S PRI=JOB,JOB=JOB*1000000 G PRIO:$D(^ZAA02GFAXQ("DIR",10000-JOB)),CONTROL
 I $D(PRI) K PRI G SEND:$D(PHN)>10
PRIO S B=^ZAA02GFAXQ("DIR",10000-JOB) I B="" K ^ZAA02GFAXQ(.9,JOB) G CONTROL
 S C=+$P(B,"\",10) I C=1 L +ZAA02GFAX("COMPILE"):0 G CONTROL:'$T,HUFF:NS<NC L -ZAA02GFAX("COMPILE") G CONTROL
 G:NS<NC SENDQ:C=2,SCHED:C=4,INTSTAT:C=15 G SEND:NS'<NC,CONTROL
SCHED S C=$P(B,"\",24),SCH=0 G:$P($H,",",2)\90+($H*1000)'>C CONTROL S $P(B,"\",10)=2,^ZAA02GFAXQ("DIR",10000-JOB)=B
SENDQ G:$P(B,"\",30)>RTY ERROUT S PHN=$P(B,"\",4) S:PHN'["@" PHN=$TR(PHN," -,","") G:PHN="" ERROUT S:$D(PHN(PHN)) NS=NS#1*100>$P(THR,"\",2)*NC+NS+.01 S PHN(PHN,JOB)="",NS=NS+1,PHJ(JOB)=PHN S:+$P(B,"\",14)'=4 PHN(PHN)=1
 I $G(^ZAA02GFAXC("SEND-LOGIC"))]"" X ^("SEND-LOGIC")
 I NS>1,BJBS+$G(SLVO)>1 D START
 G CONTROL
SEND S PHJ="" F  I 1 S PHJ=$O(PHJ(PHJ)) Q:PHJ=""    D:$D(PHN(PHJ(PHJ)))#2=0 SEND3 I  L +ZAA02GFAXD(PHJ(PHJ)):0 I  S PHN=PHJ(PHJ) K PHJ(PHJ) G SEND1
 K PHJ,PHN S NS=0 H 5 G CONTROL
SEND1 I PHN["@" D SENDMAIL G SEND
 D GETPORT I D<3 L ZAA02GFAX(NSV,SLV) S K=$O(PHN(PHN,"")) S:K SKIP(K)=$G(SKIP(K))+1 G SEND
 S (K,JB)="" F J=1:1 S K=$O(PHN(PHN,K)) Q:K=""  Q:$L(JB)>120  S B=^ZAA02GFAXQ("DIR",10000-K) I $P(B,"\",10)=2 S JB=JB_K_",",$P(B,"\",27)=$P($H,",",2),$P(B,"\",3)="Dialing",$P(B,"\",23)=FAX,^(10000-K)=B,^ZAA02GFAXQ(.9,K)=FAX
 D:JB ^ZAA02GFAXD1
 I $D(SJB) S lc="abcdefghijklmnopqrstuvwxyz",uc="ABCDEFGHIJKLMNOPQRSTUVWXYZ",A="" F K=1:1 S A=$O(SJB(A)) Q:A=""  S B=^ZAA02GFAXQ("DIR",10000-A) D:SJB(A) SEND2,PRINT
 K DAT,SJB,INIT,DEST,lc,uc C FAX L ZAA02GFAX(NSV,SLV):0 G SEND
SEND2 S INIT=$P(B,"\",11),DEST=$TR($P(B,"\",4)," -,","")
 F I=1:1:3 S T=$P("FAX,INIT,DEST",",",I) F J=1,2 S M=@T,M=$TR(M,lc,uc) S:M="" M="NA" S M=M_"-"_$P("#,Min.",",",J),$P(^(M),"+",MT)=$S($D(^ZAA02GFAXC("STATS",YR,T,M)):$P(^(M),"+",MT),1:0)+$S(J=1:1,1:$J(SJB(A)/60,0,1))
 S ^ZAA02GFAXC("STATS",0,DEST)=$P(B,"\",32)_" - "_$P(B,"\",13) Q
SEND3 S JB="" F I=1:1 S JB=$O(PHN(PHJ(PHJ),JB)) Q:JB=""  I $D(^ZAA02GFAXQ(.9,JB)),$P($H,",",2)\90+($H*1000)>$P(^ZAA02GFAXQ("DIR",10000-JB),"\",24) Q
 Q
SENDMAIL S (K,JB)="" F J=1:1 S K=$O(PHN(PHN,K)) Q:K=""  Q:$L(JB)>120  S B=^ZAA02GFAXQ("DIR",10000-K) I $P(B,"\",10)=2 D
 . S JB=JB_K_",",$P(B,"\",27)=$P($H,",",2) I $G(^ZAA02GFAXQ("SRC",K))'[",ftp" S $P(B,"\",3)="Mailing",$P(B,"\",10)=17,^ZAA02GFAXQ("DIR",10000-K)=B,^ZAA02GFAXQ(.9,K)="EMAIL" Q
 . S $P(B,"\",3)="ftping",$P(B,"\",10)=18,^ZAA02GFAXQ("DIR",10000-K)=B,^ZAA02GFAXQ(.9,K)="FTP"
 S t=PHN K PHN,PHJ Q:JB=""  S $ZT="SMERR^ZAA02GFAXC"
 F JJ=1:1:$L(JB,",")-1 S KK=$P(JB,",",JJ) I KK S B=^ZAA02GFAXQ("DIR",10000-KK) D
 . I $G(^ZAA02GFAXQ("SRC",KK))["ftp" D FILE^ZAA02GSCRFX Q
 . K d S f=$G(^ZAA02GSCR("PARAM","EMAIL-FROM"),"info@adsc.com"),s=$P(B,"\",31),p=f,d="^ZAA02GFAXQ(""SRC"","_KK_")",recall="D SMFINE^ZAA02GFAXC("""_KK_""",$G(ERR))"
 . I $P($G(@d),",",3)="link" D  Q
 .. S d="d",d(1)="This is a special notification for: "_$P(B,"\",13),d(2)=""
 .. S d(3)="Document is available: "_$G(^ZAA02GSCR("PARAM","PORTAL-SERVER"),"http://127.0.0.1:5012")_"/xml/"_$G(KK)_"/email%5EZAA02Gvbw2",d(4)="",d(5)="This link will expire in 30 days"
 . K MIME I $P($G(@d),",",3)="pdf" D  Q
 .. I $P($G(^ZAA02GFAXI(KK)),",",4)'=1 D  Q
 ... S B=^ZAA02GFAXQ("DIR",10000-KK)
 ... I $P(B,"\",25)["PDF" D  Q
 .... S SCH=$P(B,"\",25)-$P($H,",",2),$P(B,"\",3)="Convert-PDF",$P(B,"\",10)=2 I SCH<-30!(SCH>30) S $P(B,"\",3)="Failed-PDF",$P(B,"\",10)=7,^ZAA02GFAXQ("ERR",10000-KK)="PDF Failed - " K ^ZAA02GFAXQ(.9,KK),^ZAA02GFAXQ(.9,KK/100000)
 .... S ^ZAA02GFAXQ("DIR",10000-KK)=B Q
 ... S $P(B,"\",10)=2,$P(B,"\",25)=$P($H,",",2)_"PDF",$P(B,"\",3)="Convert-PDF",^(10000-KK)=B Q
 .. S (A,E,d)="",dd=1 F  S d=$O(^ZAA02GFAXI(KK,1,d)) Q:d=""  S E=E_^(d) I $L(E)>80 D SM64
 .. D:E]"" SM64
 .. S (BOUN,BOUN2)="------=_NextPart_000_04A4_01CC94C8.5BE20190",$P(BOUN2,"_",3)="001"
 .. S ^ZAA02GFAXI(KK,2,dd)="",^(dd+1)=BOUN_"--",^(dd+2)=""
 .. S MESS=$G(^ZAA02GSCR("PARAM","EMAIL PDF REPORT MESSAGE"),"Please see the Password Protected PDF for a Medical Report")
 .. S MIME="multipart/mixed;"_$C(13,10,9)_"boundary="""_$E(BOUN,3,99)_""""_$C(13,10,13,10)_"this is a multi-part message in MIME format."_$C(13,10,13,10)
 .. S MIME=MIME_BOUN_$C(13,10)_"Content-Type: multipart/alternative;"_$C(13,10,9)_"boundary="""_$E(BOUN2,3,99)_""""_$C(13,10,13,10,13,10)
 .. S MIME=MIME_BOUN2_$C(13,10)_"Content-Type: text/plain;"_$C(13,10,9)_"charset=""iso-8859-1"""_$C(13,10)_"Content-Transfer-Encoding: quoted-printable"_$C(13,10,13,10)
 .. S MIME=MIME_MESS_$C(13,10,13,10)
 .. S MIME=MIME_BOUN2_$C(13,10)_"Content-Type: text/html;"_$C(13,10,9)_"charset=""iso-8859-1"""_$C(13,10)_"Content-Transfer-Encoding: quoted-printable"_$C(13,10,13,10)
 .. S MIME=MIME_"<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">"_$C(13,10)_"<HTML><HEAD>"_$C(13,10)
 .. S MIME=MIME_"<META content=3D""text/html; charset=3Diso-8859-1"" = http-equiv=3DContent-Type>"_$C(13,10)
 .. S MIME=MIME_"<META name=3DGENERATOR content=3D""MSHTML 8.00.6001.19088"">"_$C(13,10)
 .. S MIME=MIME_"</HEAD><BODY><DIV>"
 .. S MIME=MIME_MESS_"</DIV></BODY></HTML>"_$C(13,10,13,10)
 .. S MIME=MIME_BOUN2_"--"_$C(13,10,13,10)_BOUN_$C(13,10)_"Content-Type: application/pdf;"_$C(9)_"name="""_KK_".pdf"""
 .. S XFRTYPE="Content-Transfer-Encoding: base64"_$C(13,10)_"Content-Disposition: attachment;"_$C(9)_"filename="""_KK_".pdf""",d="^ZAA02GFAXI("_KK_",2)",BINHEX=1 d SMAIL^ZAA02GWEMSM
 . S d="^ZAA02GFAXQ(""SRC"","_KK_")"
 . S:$G(@d@(1))["\rtf" MIME="application/rtf" d SMAIL^ZAA02GWEMSM
 ; I $D(SJB) S lc="abcdefghijklmnopqrstuvwxyz",uc="ABCDEFGHIJKLMNOPQRSTUVWXYZ",A="" F K=1:1 S A=$O(SJB(A)) Q:A=""  S B=^ZAA02GFAXQ("DIR",10000-A) D:SJB(A) SEND2,PRINT
 K DAT,SJB,INIT,DEST,lc,uc  Q
SM64 F  S A=$E(E,1,57),E=$E(E,58,99999) D BASE64^ZAA02GVBTER3 S ^ZAA02GFAXI(KK,2,dd)=CC,dd=dd+1 Q:$L(E)<57
 Q
SMERR S ^ZAA02GFAXC("SENDMAIL-ERROR")=$ZE Q
SMFINE(X,ERR) S JOB=X D TDATE^ZAA02GFAXU
 S B=$G(^ZAA02GFAXQ("DIR",10000-JOB)) Q:B=""
 I $G(ERR)="" S $P(B,"\",3)=$S($P(B,"\",10)=18:"ftped",1:"Mailed")_$S($P(B,"\",33):"-"_($P(B,"\",33)+1),1:""),$P(B,"\",10)=7
 E  S $P(B,"\",3)="ERROR-"_ERR_$S($P(B,"\",33):"-"_($P(B,"\",33)+1),1:""),$P(B,"\",10)=3
 S $P(B,"\",7)=DTM,^ZAA02GFAXQ("DIR",10000-JOB)=B K ^(10000-JOB,0),^ZAA02GFAXQ(.9,JOB)
 Q
 ;
INTSTAT I $H-1>$P(B,"\",28) D  G CONTROL
 . S $P(B,"\",3)="Failed on Status",$P(B,"\",10)=3,^ZAA02GFAXQ("DIR",10000-JOB)=B K ^(10000-JOB,0),^ZAA02GFAXQ(.9,JOB),^ZAA02GFAXQ(.9,JOB/100000)
 I $P(B,"\",37)="Softlinx" G SOFTLINX
 I $P(B,"\",37)="Surescripts" G SURESC
 K PRI G:$P($H,",",2)<$P(B,"\",38) CONTROL
 S F=0,ID=$P(B,"\",39) D
 . D TDATE^ZAA02GFAXU
 . I ID<1 S $P(B,"\",10)=3,$P(B,"\",3)="Error-Interfax-no-id",F=1 Q
 . D INTSTAT2 S F=+$P($G(AA),"status"":",2) I F<0 S $P(B,"\",38)=$P($H,",",2)+60,$P(B,"\",40)=F,$P(B,"\",3)=$S(F=-1:"Processing",F=-3:"Sending",1:"Ready") Q
 . I F=0 D
 .. S $P(B,"\",10)=16,$P(B,"\",3)="Sent"_$S($P(B,"\",33):"-"_($P(B,"\",33)+1),1:""),$P(B,"\",40)="",$P(B,"\",7)=DTM
 .. S AA="" D INTSTAT3 I $G(AA)]"" S (F,DURATION)=+$P(AA,"duration"":",2),$P(B,"\",9)=+$P(AA,"pagesSent"":",2),$P(B,"\",8)=$J(F\60_":"_$E(F#60+100,2,3),5),F=0
 . I F>0 S $P(B,"\",10)=3,$P(B,"\",3)=$S(F=6017:"Busy",F=6031:"TelErr",F=6034:"TelErr",F=8010:"HungUp",F=8021:"NoAns",1:"#"_F),FAILED=1
 S ^ZAA02GFAXQ("DIR",10000-JOB)=B I F>-1 K ^(10000-JOB,0),^ZAA02GFAXQ(.9,JOB),^ZAA02GFAXQ(.9,JOB/100000) S A=JOB D SUPDT
 G CONTROL
INTSTAT2 N (ID,AA) D GETFAX^ZAA02GFAXM Q
INTSTAT3 N (ID,AA) D GETFAXE^ZAA02GFAXM Q
SUPDT N (A,B,PTR,FAILED,DURATION) D TDATE^ZAA02GFAXU S lc="abcdefghijklmnopqrstuvwxyz",uc="ABCDEFGHIJKLMNOPQRSTUVWXYZ",FAX=$P(B,"\",37),SJB(A)=$G(DURATION) D SEND2,PRINT Q
 ;
SOFTLINX K PRI G:$P($H,",",2)<$P(B,"\",38) CONTROL
 S F=0,ID=$P(B,"\",39) D
 . D TDATE^ZAA02GFAXU
 . I ID<1 S $P(B,"\",10)=3,$P(B,"\",3)="Error-Softlinx-no-id",F=1 Q
 . D SOFTLIN2
 . S STATUS=$P($P(AA,"<FaxStatus>",2),"</FaxStatus>"),FAXED=$P($P(AA,"<CompleteTime>",2),"</CompleteTime>"),DURATION=$P($P(AA,"<Duration>",2),"</Duration>"),PAGES=$P($P(AA,"<PagesSent>",2),"</PagesSent")
 . S ERRT=$P($P(AA,"<ErrorText>",2),"</ErrorText"),ERR=$P($P(AA,"<ErrorCode>",2),"</ErrorCode"),RTR=$P($P(AA,"<RetryCount"),"</RetryCount")-$P($P(AA,"<RetryCountLeft"),"</RetryCountLeft")
 . S:STATUS="sent" STATUS="Sent" S F=$S(STATUS["Failed":1,STATUS["Sent":1,1:0)
 . I F=0 D  Q
 .. S $P(B,"\",38)=$P($H,",",2)+60,$P(B,"\",40)=ERRT,$P(B,"\",3)=$S(ERRT]"":ERRT,1:STATUS) Q
 . S $P(B,"\",10)=16,$P(B,"\",3)=STATUS_$S($P(B,"\",33):"-"_($P(B,"\",33)+1),1:""),$P(B,"\",40)="",$P(B,"\",7)=DTM S:STATUS'["Sent" FAILED=1
 . S D=DURATION,$P(B,"\",9)=PAGES,$P(B,"\",8)=$J(D\60_":"_$E(D#60+100,2,3),5)
 S ^ZAA02GFAXQ("DIR",10000-JOB)=B I F>0 K ^(10000-JOB,0),^ZAA02GFAXQ(.9,JOB),^ZAA02GFAXQ(.9,JOB/100000) S A=JOB D SUPDT
 G CONTROL
SOFTLIN2 N (ID,AA) D GETFAX^ZAA02GFAXM2 Q
 ;
SURESC K PRI G:$P($H,",",2)<$P(B,"\",38) CONTROL
 S F=0,ID=$P(B,"\",39) D
 . D TDATE^ZAA02GFAXU
 . I ID<1 S $P(B,"\",10)=3,$P(B,"\",3)="Error-Surescripts-no-id",F=1 Q
 . D SURESC2
 . S F=$P($P(AA,"Status"":",2),",")
 . ; ,FAXED=$P($P(AA,"<CompleteTime>",2),"</CompleteTime>"),DURATION=$P($P(AA,"<Duration>",2),"</Duration>"),PAGES=$P($P(AA,"<PagesSent>",2),"</PagesSent")
 . S STATUS=$P("Sent,Delivered,Bounced,Ignore,No Sender Id,No Receiver ID",",",F) S:STATUS="" STATUS="?? Error"
 . I F=2*0 D  Q  ; FOR NOW
 .. S $P(B,"\",38)=$P($H,",",2)+60,$P(B,"\",40)=F,$P(B,"\",3)=STATUS Q
 . S $P(B,"\",10)=16,$P(B,"\",3)=STATUS_$S($P(B,"\",33):"-"_($P(B,"\",33)+1),1:""),$P(B,"\",40)="",$P(B,"\",7)=DTM S:F>2 FAILED=1
 . ; S D=DURATION,$P(B,"\",9)=PAGES,$P(B,"\",8)=$J(D\60_":"_$E(D#60+100,2,3),5)
 S ^ZAA02GFAXQ("DIR",10000-JOB)=B I F'=2+1 K ^(10000-JOB,0),^ZAA02GFAXQ(.9,JOB),^ZAA02GFAXQ(.9,JOB/100000) ; S A=JOB D SUPDT
 G CONTROL
SURESC2 N (ID,AA) D QUERYREP^ZAA02GFAXM4 Q
 ;
 ;         ;
HUFF I $D(^ZAA02GFAXC("SUSPEND")) L -ZAA02GFAX("COMPILE") G CONTROL
 S ZAA02GFAXD="^ZAA02GFAXQ(""SRC"",JOB)"
 I $P(B,"\",4)["@",$P(B,"\",4)'["Surescripts:" S PGN="?",TFXL=1 G HUFF1:$G(@ZAA02GFAXD@(1))'["{\rtf"
 I $D(@ZAA02GFAXD@(1)) G HUFF3:$G(@ZAA02GFAXD@(1))'["{\rtf"
 ;
 I $P(B,"\",3)'="Convert_MP" D  G CONTROL
 . I +$P(B,"\",14)=3,$P($H,",",2)\90+($H*1000)'>$P(B,"\",24) H 2 Q
 . K PRI I $P(B,"\",4)'["@"!($P(B,"\",4)["Surescripts:") D
 .. I $P(B,"\",4)["Surescripts:" S $P(B,"\",37)="Surescripts" Q
 .. I $G(^ZAA02GFAXC("FAX"))["INTERFAX",^ZAA02GFAXC("FAX")'["INTERFAX\Y" S $P(B,"\",37)="Interfax" Q
 .. I $G(^ZAA02GFAXC("FAX"))["SOFTLINX",^ZAA02GFAXC("FAX")'["SOFTLINX\Y" S $P(B,"\",37)="Softlinx" Q
 .. I $G(^ZAA02GFAXC("FAX"))["FAXMAN",^ZAA02GFAXC("FAX")'["FAXMAN\Y" S $P(B,"\",37)="FaxMan" Q
 . I $P(B,"\",37)]"" S DOC=$P(B,"\",2) I DOC,$D(^ZAA02GPDF("TRANS",DOC,1,1)),'$D(^ZAA02GFAXI(JOB)) D  Q  ; still needs some work
 .. N NS S NS=$S($ZV["M3":$ZN,1:$ZU(5)) M ^ZAA02GFAXI(JOB,1)=^ZAA02GPDF("TRANS",DOC,1) S ^ZAA02GFAXI(JOB)=+$H_",PDF,,",$P(B,"\",3)=$P(B,"\",37),^ZAA02GFAXQ("DIR",10000-JOB)=B
 .. S NM=JOB,P6="^ZAA02GFAXI(NM)" D SETOE^ZAA02GVBTERP L -ZAA02GFAX("COMPILE")
 . S $P(B,"\",25)=$P($H,",",2),$P(B,"\",3)="Convert_MP",^ZAA02GFAXQ("DIR",10000-JOB)=B D CVFAX^ZAA02GVBTERP S SCH=1 L -ZAA02GFAX("COMPILE")
 I $D(^ZAA02GFAXI(JOB))#2 S PGN=$P(^(JOB),",",3),TFXL=$P(^(JOB),",",2) G HUFF2 ; ZAA02Gvbterp does the same
 L -ZAA02GFAX("COMPILE") H 2 S SCH=$P(B,"\",25)-$P($H,",",2) S:SCH<-300!(SCH>300) $P(^ZAA02GFAXQ("DIR",10000-JOB),"\",3)="CONVERT_MP" S SCH=1 G CONTROL
HUFF3 S $P(B,"\",25)=$P($H,",",2),ZAA02GFAXS="^ZAA02GFAXI("_JOB_")" S $P(B,"\",3)="Convert",^ZAA02GFAXQ("DIR",10000-JOB)=B
 D ^ZAA02GFAXH K OVR
HUFF2 L -ZAA02GFAX("COMPILE") G:'$D(^ZAA02GFAXQ(.9,JOB)) CONTROL
HUFF1 S B=^ZAA02GFAXQ("DIR",10000-JOB),$P(B,"\",26)=$P($H,",",2)-$P(B,"\",25),$P(B,"\",10)=$S(+$P(B,"\",14)=3:4,1:2),$P(B,"\",9)=PGN,$P(B,"\",29)=TFXL\16
 S $P(B,"\",3)=$P("REGULAR,PRIORITY,DELAYED,ECONOMY",",",+$P(B,"\",14)),^ZAA02GFAXQ("DIR",10000-JOB)=B,JOB="" G CONTROL
ERROUT S A=$P(B,"\",3) K ^ZAA02GFAXQ(.9,JOB) S $P(B,"\",10)=3,$P(B,"\",3)="Fail-"_$S(A["NO-A":"NOA",A["BUSY":"BSY",A["NO-D":"NOD",1:"OTH"),^ZAA02GFAXQ("DIR",10000-JOB)=B,^ZAA02GFAXQ("ERR",10000-JOB)="Retry Failed - "_A,A=JOB D PRINT G CONTROL
ERR C:$G(FAX)]"" FAX H 5 K (SLV,TEST,BJBS,THR,SLVO,JOB,RTY,FAX,DTM,YR,MT,PTR,NSV) S C="C="_^ZAA02G("ERRORR"),@C S:'$D(TEST) A=^ZAA02G("ERROR")_"=""ERR^ZAA02GFAXC""",@A G:C["GLOB" PR0 L ZAA02GFAX(NSV,SLV):0 H 5
 I JOB K ^ZAA02GFAXQ(.9,JOB) S:JOB<1 JOB=JOB*1000000 S B=$G(^ZAA02GFAXQ("DIR",10000-JOB)),$P(B,"\",10)=3,$P(B,"\",3)="ERROR",^(10000-JOB)=B S:C'["DBD" ^ZAA02GFAXQ("ERR",10000-JOB)=C
 E  S ^ZAA02GFAXQ("ERR",0)=C
 G PR0
HALT I $O(^ZAA02GFAXQ(.91,"")) S JOB="" F J=1:1:5 S JOB=$O(^ZAA02GFAXQ(.91,JOB)) K ^(JOB) S ^ZAA02GFAXQ(.9,JOB)=""
 I $O(^ZAA02GFAXQ(.9,""))]"" H 5 G PR0
 I $D(SKIP) K SKIP G PR0
 I $G(^ZAA02GFAXC("CLEANUP"))'=+$H S ^ZAA02GFAXC("CLEANUP")=+$H D CLEANUP
HALT1 X:$D(^ZAA02GFAXC("CHECK")) ^("CHECK")
 I SLV>0 L +ZAA02GFAX(NSV,0):0 Q:'$T  S SLV=0 L ZAA02GFAX(NSV,0):0
 I $D(SCH) H 10 G PR0
 Q:'$D(^ZAA02GFAXC("LOOP"))  X ^("LOOP") I  H 10 G PR0
 Q
 ;
T S TEST=1,BJBS=1,SLV=0 G A
 ;
RESTART I $D(^ZAA02GFAXQ(.9))>1  L ZAA02GFAX(NSV,0):0 I  L  J ^ZAA02GFAXC
 Q
START F I=$G(SLVO)+0:1:BJBS-1+$G(SLVO) I I'=SLV L +ZAA02GFAX(NSV,I):0 I  L -ZAA02GFAX(NSV,I) J ^ZAA02GFAXC Q
 Q
GETPORT S A=^ZAA02GFAXC("FAX"),$P(A,"\",205)="",D=0,B=1,FAXP="" Q:$D(^("SUSPEND"))  I $G(FAX)'="" F I=1:6:200 S K=$P(A,"\",I) I K]"",K=FAX S B=I+6 Q
 L +MODEM
 F I=B:6:200 I $P(A,"\",I)'="FAXMAN",$P(A,"\",I)'="INTERFAX",$P(A,"\",I)'="SOFTLINX",$P(A,"\",I)'="",$P(A,"\",I+1)'="Y" S K=$P(A,"\",I) D
 . I OS="M3" S D=3,K=0,I=200 Q
 . O K::5 I  D
 .. I OS="M11",$ZV["Cach",$ZV'["UNIX",$G(FAX)="" C K D MODE(K) O K::5 E  Q
 .. S D=3,FAX=K,FAXP=$P(A,"\",I,I+5),I=300 Q
 L -MODEM
 I D<3,$G(FAX)'="" S FAX="" G GETPORT
 I D<3 Q
 S FAXP=$P(FAXP,"\",4,6) S:$P(FAXP,"\")="" $P(FAXP,"\")="ATDT" S:$P(FAXP,"\",3)="" $P(FAXP,"\",3)="PG&A ZAA02G-FAX"
NOECHO I OS="DTM" U:FAX'>399 FAX:(xongen=1:xon=1:speed=19200:parity="NONE":stopbits=1:charbits=8) U FAX:(em=0:ixinterp=1) Q
 I OS="MSM" X "U FAX:(0::::2097152+262144+4096+1:16384+8:::$C(13,10))" Q
 I OS="M11"&($ZV'["Cach") X "U FAX:(0:""S"":$C(13,10))" Q
 I OS="M11"&($ZV["Cach") U FAX:(0:"S":$C(13,10)) Q  ; :" 0801x11":19200) Q
 I OS="DSM4" X "U FAX:(NOECHO,WIDTH=0,PASTHRU)" Q
 I OS="M3" S FAX=0 Q
 U @(""""_FAX_""""_$P(^ZAA02G("WRAP-OFF"),"0",2,9)) U @(""""_FAX_""""_$P(^ZAA02G("ECHO-OFF"),"0",2,9)) Q
 Q
MODE(X) N (X) I $D(^ZAA02GSCR("PARAM","MEDICSPRINT")) D MPINFO^ZAA02GVBTERP("SH|"_X_"|19200|0|8|0|1") Q  ; baud/parity/bits/stop/xon
 H 1 S AA=$ZF(-2,"""MODE "_X_": BAUD=19200 DATA=8 PARITY=N STOP=1 XON=ON TO=ON""") Q
OPENAIX I $ZF("OPENDEV",K,"NONE",19200,8,1,1,0,0,"") O K::5 Q
 Q
PRINT I PTR'?.P D ^ZAA02GFAXQP Q
 I $D(^ZAA02GSCR("PARAM","FAX")) D NOLOG^ZAA02GSCRFX2 Q
 Q
CLEANUP L +ZAA02GFAX("COMPILE"):30 Q:'$T
 S CONFIG=^ZAA02GFAXC("CONFIG") S D=$H-$P(CONFIG,"\",8),A="" F J=1:1 S A=$O(^ZAA02GFAXQ("SRC",A)) Q:A=""  I $G(^(A)),^(A)<D K ^(A)
 S D=$H-$P(CONFIG,"\",9),A="" F J=1:1 S A=$O(^ZAA02GFAXI(A)) Q:A=""  I $S($D(^(A))=10:1,1:^(A)<D) K ^(A)
 S D=$H-$P(CONFIG,"\",10),A="" F J=1:1 S A=$O(^ZAA02GFAXQ("ERR",A)) Q:A=""  I $S($D(^ZAA02GFAXQ("DIR",A))=0:1,$P(^(A),"\",28)<D:1,1:0) K ^ZAA02GFAXQ("ERR",A)
 S D=$H-$P(CONFIG,"\",11),A="" F J=1:1 S A=$O(^ZAA02GFAXQ("DIR",A)) Q:A=""  S B=$P(^(A),"\",28) K:B<D ^(A) I B-D>100 S A=A+20
 L -ZAA02GFAX("COMPILE")
