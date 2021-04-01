ZAA02GCFGEM ;Email (auto-email) config tool.;2018-05-01 13:19:56; MRM;;11/05/2014 11:13:11
 ; ADS Corp. Copyright
 ;
MAIN
 N NEW,COR,DNS1,DNS2,HOST,USER,PASS,FROM,BODY,RHOST,WS,SUSWARN,CHANGE,HOSTTMP,YN
 S (NEW,COR)="N",(SUSPEND,SUSWARN,MSAUTOSTOP,CHANGE,PASSCH,PASSE,UPDATED)=0,OK=1,SDIR=$ZU(5)
 D CTRL
 D:'UPDATED VER("ZAA02GCFGEM")
 D:$D(^ZAA02GWEMM) EM
 S:'$D(^ZAA02GWEMM) NEW=1
 D:NEW EMIN
 D:COR EMAPPLY
 W:COR !,"Changes Applied"
 W:'COR !,"No Changes"
 Q
EM
 W !
 W !,"CURRENT CONFIG"
 W !
 W !,"DNS Info"
 W !,"DNS1:  ",$G(^ZAA02GWEMM("DNS",1))
 W !,"DNS2:  ",$G(^ZAA02GWEMM("DNS",2))
 W !,"HOST:  ",$G(^ZAA02GWEMM("HOST"))
 W !
 W !,"POP 3 / SMTP Login Info"
 W !,"Username:  ",$P($G(^ZAA02GWEMM("RELAYHOST-USER")),":",1)
 W !,"Password:  ",$P($G(^ZAA02GWEMM("RELAYHOST-USER")),":",2)
 W !,"Outgoing Server:  ",$G(^ZAA02GWEMM("RELAYHOST"))
 W !
 W !,"Email Info"
 W !,"FROM:  ",$G(^ZAA02GSCR("PARAM","EMAIL-FROM"))
 W !,"BODY:  ",$G(^ZAA02GSCR("PARAM","EMAIL PDF REPORT MESSAGE")),!!
 S NEW=$$YN("Overwrite?")
 Q
EMIN
 S EMWS=1
 W !!,"INPUT NEW INFO",!,"Type ^ to quit at any time",!,"Type ! to erase any line",!,"Type % to allow white spaces"!"Leave blank to retain old info",!
 W !,"DNS Info"
 ;DNS1
 R !,"DNS Server 1 - IP Address> " ,DNS1
 I DNS1="%" S DNS1WS=1 R !,"(Whitespaces allowed)> ",DNS1
 Q:DNS1="^"  W:DNS1="" $G(^ZAA02GWEMM("DNS",1)) S:DNS1="" DNS1=$G(^ZAA02GWEMM("DNS",1)) S:DNS1="!" DNS1=""
 ;DNS2
 R !,"DNS Server 2 - IP Address> ",DNS2
 I DNS2="%" S DNS2WS=1 R !,"Whitespaces allowed)> ",DNS2
 Q:DNS2="^"  W:DNS2="" $G(^ZAA02GWEMM("DNS",2)) S:DNS2="" DNS2=$G(^ZAA02GWEMM("DNS",2)) S:DNS2="!" DNS2=""
 ;HOST
 R !,"Domain name - Host Name> ",HOST
 I HOST="%" S HOSTWS=1 R !,"(Whitespaces allowed)> ",HOST
 Q:HOST="^"  W:HOST="" $G(^ZAA02GWEMM("HOST")) S:HOST="" HOST=$G(^ZAA02GWEMM("HOST")) S:HOST="!" HOST=""
 D:'$L(HOST)
 . W !,$C(9),"A Host name must be defined for this to work."
 . W !,$C(9) S:$$YN("Apply local hostname?") HOST=$ZU(110) W !,$C(9),"Using:  ",HOST
 ;POP3/SMTP
 W !!,"POP3 / SMTP Login Info"
 W !,"(Case Sensative)",!
 ;USER
 R !,"Username> ",USER
 I USER="%" S USERWS=1 R !,"(Whitespaces allowed)> ",USER
 Q:USER="^"  W:USER="" $P($G(^ZAA02GWEMM("RELAYHOST-USER")),":",1) S:USER="" USER=$P($G(^ZAA02GWEMM("RELAYHOST-USER")),":",1) S:USER="!" USER=""
 ;PASS
 R !,"Password> ",PASS
 I PASS="%" S PASSWS=1 R !,"(Whitespaces allowed)> ",PASS
 Q:PASS="^"  W:PASS="" $P($G(^ZAA02GWEMM("RELAYHOST-USER")),":",2) S:PASS="" PASS=$P($G(^ZAA02GWEMM("RELAYHOST-USER")),":",2) S:PASS="!" PASS=""
 ;RHOST
 R !,"Outgoing Server (address:port) > ",RHOST
 I RHOST="%" S RHOSTWS=1 R !,"(Whitespaces allowed)> ",RHOST
 Q:RHOST="^"  W:RHOST="" $G(^ZAA02GWEMM("RELAYHOST")) S:RHOST="" RHOST=$G(^ZAA02GWEMM("RELAYHOST")) S:RHOST="!" RHOST=""
 ;EMAIL INFO
 W !!,"Email Info"
 ;FROM
 R !,"Display (From) address> ",FROM
 I FROM="%" S FROMWS=1 R !,"(Whitespaces allowed)> ",FROM
 Q:FROM="^"  W:FROM="" $G(^ZAA02GSCR("PARAM","EMAIL-FROM")) S:FROM="" FROM=$G(^ZAA02GSCR("PARAM","EMAIL-FROM")) S:FROM="" FROM="INFO@ADSC.COM" S:FROM="!" FROM=""
 ;BODY
 R !,"Email Body message> ",BODY
 Q:BODY="^"  W:BODY="" $G(^ZAA02GSCR("PARAM","EMAIL PDF REPORT MESSAGE")) S:BODY="" BODY=$G(^ZAA02GSCR("PARAM","EMAIL PDF REPORT MESSAGE")) S:BODY="" BODY="Please see the password protected PDF for a medical report" S:BODY="!" BODY=""
 W !!!,"PLEASE VERIFY INFORMATION ABOVE"
 W !!
 S COR=$$YN("Is this correct?")
 Q
EMAPPLY
 D SUSPEND
 S ^ZAA02GWEMM("DNS",1)=DNS1,^ZAA02GWEMM("DNS",2)=DNS2,^ZAA02GWEMM("HOST")=HOST,^ZAA02GSCR("PARAM","EMAIL-FROM")=FROM,^ZAA02GSCR("PARAM","EMAIL PDF REPORT MESSAGE")=BODY
 S ^ZAA02GWEMM("RELAYHOST-USER")=USER_":"_PASS, ^ZAA02GWEMM("RELAYHOST")=RHOST
 S CHANGE=1
 D UNSUSPEND
 Q
VER(RTN)
 N D,T
 D CLS
 W !,"Checking for updates"
 S RTN=$ZSTRIP($P(^ROUTINE(RTN,0,1),";",1),"*W")
 D FTPADS(RTN_".VER"),$SYSTEM.OBJ.Load(RTN_".VER")
 S D=$ZDH($P($P(^ROUTINE(RTN,0,1),";",6)," ",1))
 S T=$ZTH($P($P(^ROUTINE(RTN,0,1),";",6)," ",2))
 D:'((D=$P($G(^ZAA02GCFGVER(RTN)),",",1))&(T=$P($G(^ZAA02GCFGVER(RTN)),",",2)))
 . D:$$YN(RTN_" is outdated. Update?")
 . . D:'$D(^ROUTINE("ZAA02GCFGUD"))
 . . . D FTPADS("ZAA02GCFGUD.RO")
 . . . D $SYSTEM.OBJ.Load("ZAA02GCFGUD.RO","CF")
 . . D LOADR^ZAA02GCFGUD(RTN)
 . . S UPDATED=1
 Q
SUSPEND
 S:'$D(^ZAA02GFAXC("SUSPEND")) SUSPEND=1,^ZAA02GFAXC("SUSPEND")=""
 Q
UNSUSPEND
 K:$D(^ZAA02GFAXC("SUSPEND")) ^ZAA02GFAXC("SUSPEND")
 J ^ZAA02GFAXC
 W:$G(SUSWARN) !,"Warning:  Someone resumed faxes during this process",!,"You may need to run this again."
 Q
MSTOP
 N MSRUN,MSTOP
 S MSRUN=$ZF(-1,"tasklist | find /i ""medicsservice.exe""") S MSRUN='MSRUN
 D:MSRUN
 . S MSAUTOSTOP=1
 . W !,"Stopping Medics service..."
 . S MSTOP=$ZF(-1,"net stop ""medics service""")
 S MPRUN=$ZF(-1,"tasklist | find /i ""medicsprintui.exe""") S MPRUN='MPRUN
 I MPRUN R !,"Please stop Medics Service and/or Print",!,"then press any key to continue. . .",!,anykey#1 W $C(13)," "
 Q
MSTART
 N MSRUN,MSTOP,I
 S MSRUN=$ZF(-1,"tasklist | find /i ""medicsservice.exe""") S MSRUN='MSRUN
 D:'MSRUN 
 . W !,"Starting Medics service..."
 . S MSTART=$ZF(-1,"net start ""medics service""")
 . W "Done"
 . W !,"Please wait while Medics Print starts..."
 . F I=1:1:60 H 1 S MPRUN=$ZF(-1,"tasklist | find /i ""medicsprintui.exe""") S MPRUN='MPRUN Q:MPRUN
 I 'MPRUN R !!,"Medics print failed to start",!,"Please start Medics Service and/or Print",!,"then press any key to continue. . .",!,anykey#1 W $C(13)," "
 Q
FTPALL(file)
 N ftpcheck,connection
 S ftpcheck=0,connection=0
 D FTPADS(file)
 D:'connection FTPUSER(file)
 Q
FTPADS(file)
 D FTP("ftp.adsc.com","suppftp","ftpup*99","21",file)
 Q
FTPUSER(file)
 N server,user,password,port,stream,I,N,B
 S port=21
 F I=1:1:3 D  D FTP(server,user,password,port,file) Q:connection
 . R !,"Server (ftp.adsc.com) >",server
 . I server="" S server="ftp.adsc.com" W "ftp.adsc.com"
 . S:server["ftp://" server=$p(server,"ftp://",2)
 . S:server[":" port=$P(server,":",2),server=$P(server,":",1)
 . R !,"Username: ",user
 . W !,"Password: " S (N,B)="" F  S B=B_"*" R A#1 S N=N_A Q:A=$C(256)  W $C(13) W "Password: ",B
 . S password=N
 Q
FTP(server,user,password,port,file)
 S dir=$ZU(12,"")
 S ftp=##class(%Net.FtpSession).%New()
 I 'ftp.Connect(server,user,password,port) W !,"Could not connect to ",server Q
 s connection=1 D
 . W !,"Ftp server messsage:",!,ftp.ReturnMessage,!
 . S stream=##class(%FileCharacterStream).%New()
 . S stream.Filename=dir_file
 . I 'ftp.Binary() W "Can not swap to binary mode",! Q
 . W "Mode now: ",ftp.Type,!
 . I 'ftp.Retrieve(file,stream) W "Failed to get file",! Q
 . W "Length of file received: ",stream.Size,!
 . S ftpcheck=1
 I 'ftp.Logout() W "Failed to logout",!
 C file
 Q
YN(YNF)
 N MSG,A,I S MSG=$C(13)_$E($G(YNF),0,70)_" [Y/N]>"
 W ! F  D  Q:(YN?1N)  W MSG,"<Invalid>" H .2 W $C(13) F I=1:1:80 W " "
 . W MSG R YN#1 S A=(YN?1A),(YN,YNF)=$S('A:"",A:$TR(YN,"YyNn","1100"))
 W $S(YN:"es",'YN:"o") Q YNF
CH(CHF)
 N MSG,OP,O,I,N S MSG=$C(13)_" >"
 F I=1:1 S O=$P(CHF,":",I) Q:O=""  S OP(I)=O
 W ! S N="" F  S N=$O(OP(N)) Q:N=""  W OP(N)," "
 W ! F  D  Q:N'=""  W MSG,"<Invalid>" H .2 W $C(13) F I=1:1:80 W " "
 . W MSG R CH#1 S (CH,CHF)=$ZCVT(CH,"U") S N="" F  S N=$O(OP(N)) Q:(N="")||($P(OP(N),"-",1)=CH)
 W MSG,$P(OP(N),"-",2) Q CHF
DT
 N D,T,DFORMAT
 S D=$ZD($P($H,",",1)),T=$ZT($P($H,",",2))
 S DFORMAT=$P(D,"/",3)_$P(D,"/",1)_$P(D,"/",2) 
 S DT=$ZSTRIP(DFORMAT_T,"*P")
 Q
PASS(PASSCH,MSG)
 D:$D(^ZAA02GCFG("PASS"))
 . S OK=0,ZAA02GCFGCHK=^ZAA02GCFG("PASS")
 . W !!,"Enter password",!
 . S (N,B)="" F  S B=B_" " R A#1 S N=N_A Q:A=$C(256)  W $C(13) W B
 . S ZAA02GCFGPASS=N
 . S ZAA02GCFGHASH=$SYSTEM.Encryption.SHA1Hash(ZAA02GCFGPASS)
 . S:ZAA02GCFGHASH=ZAA02GCFGCHK OK=1
 Q:'PASSCH
 W !,MSG,! S (N,B)="" F  S B=B_" " R A#1 S N=N_A Q:A=$C(256)  W $C(13) W B
 S ZAA02GCFGPASS=N,PASSCH=1
 S ^ZAA02GCFG("PASS")=$SYSTEM.Encryption.SHA1Hash($G(ZAA02GCFGPASS))
 Q
CTRL
 N CM,CS,I,LIST
 S BR=$C(13,10),IBR=$C(13,10,32,32),TAB=$C(9),SP=$C(32)
 F CS="BR","IBR","TAB","SP" S CM="" D  M @CS=LIST(CS)
 . F I=1:1:10 S CM=@CS_CM,LIST(CS,I)=CM
 Q
CLS(CHD)
 N I,C
 W $C(27,91) F I=1:1:24 W !,$C(13) F C=1:1:80 W " "
 W $C(27,91,85)
 S:$G(CHD)]"" HD=CHD W:$D(HD) HD
 Q
