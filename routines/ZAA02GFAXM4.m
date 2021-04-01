ZAA02GFAXM4 ; SURESCRIPTS;;;;Tue, 30 Aug 2016  13:29
 ;
INIT K sz,tail S CR=$C(13,10)
 S P(7)=$G(^ZAA02GFAXC("SURESCRIPTS","PRACTICE-CODE"),"VLA9YHKOIJB")
 S P(78)=$G(^ZAA02GFAXC("SURESCRIPTS","FROM")) S:P(78)'["@" P(78)=P(78)_"@direct.medicscloud.com"
 S P(79)=$G(^ZAA02GFAXC("SURESCRIPTS","API-KEY"),"6D861973-5722-4BB6-BBEC-0E6D609D08EB")
 S P(66)=$G(^ZAA02GFAXC("SURESCRIPTS","SESSION-KEY"),"A4D050B338AE7FBC763B4A938309F407BZ")
 S P(6)=$G(^ZAA02GFAXC("SURESCRIPTS","TIME-STAMP"),"2016-03-31T13:09:54")
 I $ZV["Cache" D GMT ; S P(6)=D,P(66)="A"_md5_""Z" ADD MD5 CLASS
 Q
GMT S X=$H,T=$G(^ZAA02GWEBC("TimeZone")),T=$P(X,",",2)+(-T*3600) S:T<0 X=X-1,T=T+86400  S:T>86400 X=X+1,T=T-86400
 S K=X>21608+305+X,Y=4*K+3\1461,D=K*4+3-(1461*Y)+4\4,M=5*D-3\153,D=5*D-3-(153*M)+5\5,M=M+2,Y=M\12+Y-60,M=M#12+1,DT=1900+Y*100+M*100+D
 S D=1900+Y_"-"_$E(100+M,2,3)_"-"_$E(100+D,2,3)_"T"
 S M=T\60,M=$E(M\60+100,2,3)_":"_$E(M#60+100,2,3)_":"_$E(T#60+100,2,3)
 S D=D_M
 Q
 ;
DYR D YRA^ZAA02GVBW5D S B=+$H,K=$O(YRA(B),-1),YR=YRA(K),DY=B-K
 Q
 ;
SENDREP D INIT
 D DYR S MT=+$ZD(+$H)
 S $P(^ZAA02GFAXC("SURESCRIPTS","STATS",YR),"+",DY)=$P($G(^ZAA02GFAXC("SURESCRIPTS","STATS",YR)),"+",DY)+1
 S ^ZAA02GFAXC("SURESCRIPTS","STATS",YR,MT)=$G(^ZAA02GFAXC("SURESCRIPTS","STATS",YR,MT))+1
 S D=$G(^ZAA02GFAXQ("DIR",10000-NM))
 S REC=$G(^ZAA02GSCR("TRANS",DOC,.011)),AC=$P(REC,"`",9),SEX=$P($G(^PTG(+AC,$S(AC["/":$P(AC,"/",2),1:1))),":",10)
 S P(1)=$P(D,"\",31)_"  "_$P(REC,"`",10)_"  "_SEX
 S P(2)="Document #"_DOC
 S P(3)="application/pdf"
 S P(4)=DOC_".pdf"
 S P(77)=$P(FAX,"Surescripts:",2) S:P(77)'["@" P(77)=P(77)_"@direct.medicscloud.com"
 S FAXI="^ZAA02GPDF(""TRANS"",DOC)"
 D GETPDF
 ;
 ; S ACC="2015002221"
 ; S A=$P($T(CCD),";",2,999) D BASE64^ZAA02GVBTER3 S P(46)=CC
 ; S RENPI="1231231231",READ1="123 2nd Avenue South",REZP="60606",REFID="3" ; FRANK JONES
 ;S RENPI="1467597922",READ1="397 Ridge Rd, Suite 2",REZP="08810",REFID="3"
 ; S PASS=$G(^ZAA02GFAXC("SURESCRIPTS","Connection","Username"))_":"_$G(^("Password"))
 ; S A=PASS D BASE64^ZAA02GVBTER3 S P(22)=CC ; replaces first value of P(22)
 S A=$$GETM("TAIL",$C(13,10)) S A=$E(A,1,$L(A)-2)
 D FILL S tail=A_$C(13,10,13,10)
 S A=$$GETM("SENDREPORT",$C(13,10)) S A=$E(A,1,$L(A)-2)
 S EXE="S d=0 F  S d=$O(@FAXI@(2,d)) Q:'$L(d)  W ^(d)"
 D FILL D:1 SEND Q:$G(AA)=""
 I AA'[$C(13,10,13,10) S ^ZAA02GFAXC("SURESCRIPTS","LAST ERROR",$H)=AA Q
 S RID=$TR($P(AA,$C(13,10,13,10),2),"""")
 Q
 ;
QUERYREP D INIT
 S P(44)=ID
 S P(77)="ATESTPROVIDER@direct.medicscloud.com"
 K tail S A=$$GETM("GETSTATUS",$C(13,10)) S A=$E(A,1,$L(A)-2)_$C(13,10,13,10)
 D FILL D:1 SEND Q:$G(AA)=""
 S ^ZAA02GFAXC("SURESCRIPTS","LAST QUERY RESULT")=AA
 Q
 ;  1-sent,2-delivered,3-bounced,4-ignore,5-sender id not on file,6-receiver id not on file
 ;
FILL D FILL^ZAA02GVBW2
 Q
 ;
SEND D GETIP
 I A["++" S R=$P(A,$C(13,10,13,10),2,9999),A=$P(A,$C(13,10,13,10))_$C(13,10,13,10),L=$L(R_$G(tail))+$G(sz),A=$P(A,"++")_L_$P(A,"++",2,99)_R
 S DATA=A
 D NET
 Q
 ;  S A="USERNAME: MARK" D BASE64^ZAA02GVBTER3  > CC
 ;
 ;  W $$UUDEC^ZAA02GWEBU(CC)
 ;
 ;
NET S $ZT="NETER^ZAA02GFAXM2",DEV="TCP3",OS=^ZAA02G("OS"),C1=+$H,C2=$P($H,",",2) S:$D(^PROBE("CONNECT",C1,C2)) C2=$O(^(""),-1)+.01 S ^PROBE("CONNECT",C1,C2)=IP_"-"_PORT_"-"_$J_"-"_$E($G(DATA),1,150)
 S TMO=30
 I $G(DELAY)]"" H DELAY
 I OS="M3" O DEV:(IP_"/"_PORT:"") U DEV S ZC=$ZC
 I OS="M11" D
 . S DEV="|TCP|"_PORT S ZC=1 C DEV O DEV:(IP:PORT:"AS"):15 Q:'$T  S ZC=0 U DEV
 I ZC D  C DEV L -PROBE(IP) Q
 . S $P(^PROBE("CONNECT",C1,C2),"`",3)=$P($H,",",2)_" NO CONNECTION - "_ZC,(AA,ERROR,X)="ERROR-NO-CONNECTION"
FF W DATA I $G(EXE)]"" X EXE
 W $g(tail),!
 K X S AA=""
 S TT=0 H 1
PROBE2 R X:1 S TT=TT+1 I TT>15 G PROBET
 S AA=AA_X I AA'[$C(13,10) G PROBE2
 S X=AA,^PROBE("CONNECT",C1,C2,$H)=$E(X,1,500)
PROBE4 C DEV L -PROBE(IP) Q
PROBE3 D PROBE4 Q:C=10054  S ^PROBE("COMM-ERROR",C1,C2)=C,(ERROR,X)="ERROR-"_C Q
NETER D PROBE4 S ^PROBE("ERROR",C1,C2)=$ZE_" "_$G(X),(ERROR,X)="ERROR-"_$ZE Q
PROBET D PROBE4 S ^PROBE("TIME-OUT",C1,C2)=$H_","_$ZE,(ERROR,X)="ERROR-TIME-OUT" Q
 ;
 Q
CONNECT ; ZAA02GWEB
 ; ZT 6
 W 1234,! Q
 ;
GETPDF G GETHTML2
 ;
GETHTML I '$D(^ZAA02GHTML("TRANS",DOC)) D
 . I $D(^ZAA02GPDF("SETUP","PATH")) D
 .. S P1=DOC N (P1) S:1 HTML=1 D JOBPDF^ZAA02GVBTERP(P1)
 .
GETHTML2 S sz=$G(@FAXI@(2)) Q:sz
 S (A,E,d,sz)="",dd=1 F  S d=$O(@FAXI@(1,d)) Q:d=""  S E=E_^(d) I $L(E)>57 D
 . F  S A=$E(E,1,57),E=$E(E,58,9999) D BASE64^ZAA02GVBTER3 S @FAXI@(2,dd)=CC,dd=dd+1,sz=sz+$L(CC) Q:$L(E)<57
 I E]"" S A=E D BASE64^ZAA02GVBTER3 S @FAXI@(2,dd)=CC,sz=sz+$L(CC)
 S @FAXI@(2)=sz
 Q
 ;
GETIP ;
 ;   S IP="127.0.0.1",PORT=8097 Q
 S IP=$G(^ZAA02GFAXC("SURESCRIPTS","IP"),"192.235.88.172"),PORT=$G(^ZAA02GFAXC("SURESCRIPTS","PORT"),"80")       ; 65.51.204.42
 Q
 ;
GETM(X,Y) N J,B S B="" F J=0:1 Q:$P($T(@X+J),";",2)="/"  S B=B_$P($T(@X+J),";",2,999)_$G(Y)
 Q B
 ;
 ;
SENDREPORT ;POST /MedicsN2N/api/Net2NetService/SendMessage/ HTTP/1.1
 ;SessionKey: *66
 ;TimeStamp: *6
 ;Account: *78
 ;PracticeCode: *7
 ;APIKey: *79
 ;Accept: application/json
 ;Content-Type: application/json; charset=utf-8
 ;Host: rx-staging.medicscloud.com
 ;Connection: Keep-Alive
 ;Content-Length: ++
 ;
 ;{"PracticeCode":"*7","From":"*78","Subject":"*1","BodyText":"*2","To":"*77","CC":null,"MessageAttachments":[{"Name":"*4","contenttype":"*3","content":"
 ;/
 ;
 ;
TAIL ;"}]}
 ;/
 ;
GETSTATUS ;GET /MedicsN2N/api/Net2NetService/GetMessageStatus/?messageIds=*44 HTTP/1.1
 ;SessionKey: *66
 ;Account: *78
 ;TimeStamp: *6
 ;PracticeCode: *7
 ;APIKey: *79
 ;Host: rx-staging.medicscloud.com
 ;Connection: Keep-Alive
 ;/
 ;
