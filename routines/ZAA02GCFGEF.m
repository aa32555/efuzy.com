ZAA02GCFGEF ;Install E-Fax;2015-11-30 12:34:00; MRM;;11/30/2015 12:34:00PM
MAIN
 N HD S HD="E-Fax Configuration Utility"
 N RMSMAXLEN,SUSPEND,SUSWARN,UPDATED,STY,STYNM,ZAA02GCFGCHK,ZAA02GCFGPASS,ZAA02GCFGHASH
 N PASSCH,PASSE,DIR,SDIR,MPRUN,MSAUTOSTOP,MSTART,YN,CH,OK,CHANGE
 S (SUSPEND,SUSWARN,MSAUTOSTOP,CHANGE,PASSCH,PASSE,UPDATED)=0,OK=1,SDIR=$ZU(5)
 D:'UPDATED VER
 Q:UPDATED
 D CLS("")
 W !
 W !,"This will configure internet based faxing in place of traditional modems"
 W !,"Use of existing modems may not be used with this configuration"
 W !,"STunnel is required for functionality"
 W !,"An account must be created for functionality"
 D DIR
 D:$$YN("Is this correct?")
 . S:$D(^ZAA02GCFG("PASS")) PASSE=1
 . D:PASSE PASS(0) W:'OK !,"Password Incorrect" Q:'OK  D
 . . I ('$D(^ZAA02GFAXC(0)))&&($$YN("Initialize never ran. Run this now?")) N SILENT S SILENT=1 D INIT^ZAA02GFAXI
 . . D SEL
 D:CHANGE  W:'CHANGE !,"No Changes" S $ZNSPACE=SDIR
 . W !,"Changes Applied"
 . D:$$YN("Set password to prevent future changes?")  W:PASSCH !,"Password Applied"
 . . D:'PASSE PASS(1,"Enter Password") D:PASSE PASS(1,"Enter New Password")
 Q
SEL
 N OPTIONS,I,O
 F  D  Q:(STY?1A)
 . D CLS("")
 . S:'$D(^ZAA02GCFG("EF","STY")) ^ZAA02GCFG("EF","STY","I")="Interfax:INTERFAX",^ZAA02GCFG("EF","STY","S")="Softlinx:SOFTLINX"
 . W !!,"Configuring ",DIR,": Select E-Fax service" 
 . S (I,O,OPTIONS)="" F  S O=$O(^ZAA02GCFG("EF","STY",O)) Q:O=""  S $P(OPTIONS,":",$I(I))=O_"-"_$P(^(O),":")
 . S OPTIONS=OPTIONS_":N-New/Remove:Q-Quit"
 . S STY=$$CH(OPTIONS)
 . D:STY="N" SELEDIT D:'((STY="Q")!(STY="")) CC
 Q
SELEDIT
 N KEY,DESC,ZAA02G,CHK S STY=""
 D CH("N-New:R-Remove")
 D:CH="N"
 . F  R !,"Enter instant key-stroke letter >",KEY#1 Q:(KEY?1A)&'($ZCVT(KEY,"U")="N")  W " Invalid key"
 . I $ZCVT(KEY,"U")="Q" W uit Q
 . R !,"Enter description >",DESC R !,"Enter ZAA02GFAX name >",ZAA02G
 . S ^ZAA02GCFG("EF","STY",$ZCVT(KEY,"U"))=DESC_":"_ZAA02G
 D:CH="R"
 . F  R !,"Enter key >",KEY#1 S N=$A(KEY) D:(KEY?1A)  Q:(KEY=CHK)!(KEY="Q")  W " Invalid key"
 . . S CHK="" F  S CHK=$O(^ZAA02GCFG("EF","STY",CHK)) Q:(CHK="")!(KEY=CHK)
 . K ^ZAA02GCFG("EF","STY",$ZCVT(KEY,"U"))
 Q
CC
 D CLS("")
 N DPARAM,PARAM,EF
 S STYNM=$P(^ZAA02GCFG("EF","STY",STY),":",2)
 D:('$D(ZAA02GCFG("EF",STY)))&($D(^ZAA02GFAXC(STYNM))) BLDZAA02GCFG
 N YN D:$D(^ZAA02GCFG("EF",STY))
 . W !!,"Current Configuration"
 . M EF=^ZAA02GCFG("EF",STY) S PARAM="" F  S PARAM=$O(EF(PARAM)) Q:PARAM=""  D
 . . S DPARAM=PARAM S:$L(PARAM)>7 DPARAM=$E(PARAM,1,4) W !,DPARAM,":",$C(9),(EF(PARAM))
 . D YN("Overwrite?")
 S:'$D(^ZAA02GCFG("EF",STY)) YN=1
 D:YN LOADG
 D:($P($G(^ZAA02GVBSYS("VER","CLIENT")),".",1)<8)&('$G(^ZAA02GCFG("EF","UPDATED")))
 . D:$$YN("System outdated, load compatible routines?") LOADR
 D:(STY="S")&($G(EF("IP"))="127.0.0.1")
 . D:$$YN("Auto-config STunnel settings?") AUTOSSL("softlinx",^ZAA02GFAXC(STYNM,"PORT"),"api.rpxfax.com:443","yes")
 D:MSAUTOSTOP MSTART
 D:SUSPEND UNSUSPEND
 Q
LOADG
 N NEWFIN
 S CHANGE=1,PARAM="" D SUSPEND,MSTOP
 W !!,"Type ^ to quit at any time",!,"Type % then enter to allow spaces",!,"Type ! to erase a line"
 D:('$D(^ZAA02GFAXC(STYNM))) NEWZAA02GCFG
 I $D(^ZAA02GFAXC(STYNM)) F  S PARAM=$O(EF(PARAM)) Q:(PARAM="")!('CHANGE)  D READIN(PARAM)
 F  S NEWFIN=0 D READIN("")  Q:(NEWFIN)!('CHANGE)
 I CHANGE D
 . K ^ZAA02GCFG("EF",STY) M ^ZAA02GFAXC(STYNM)=EF,^ZAA02GCFG("EF",STY)=EF
 . F I=1:1:$L(^ZAA02GFAXC("FAX"),"\") S $P(^ZAA02GFAXC("FAX"),"\",I)=""
 . S ^ZAA02GFAXC(STYNM)=STYNM_" SETTINGS",$P(^ZAA02GFAXC("FAX"),"\")=STYNM,$P(^ZAA02GFAXC("FAX"),"\",2)="N"
 Q
BLDZAA02GCFG
 N DFLTS,I
 D DFLTS
 F I=1:1:$L(DFLTS,":") S PARAM=$P(DFLTS,":",I) S ^ZAA02GCFG("EF",STY,PARAM)=$G(^ZAA02GFAXC(STYNM,PARAM))
 Q
NEWZAA02GCFG
 N DFLTS,I
 D DFLTS
 F I=1:1:$L(DFLTS,":") S PARAM=$P(DFLTS,":",I)  D READIN(PARAM) Q:'CHANGE
 Q
DFLTS
 S DFLTS="IP:PORT:USER:PASSWORD:CODE" S:STY="S" DFLTS="IP:PORT:USER:REALM:PASSWORD:CODE"
 Q
READIN(PARAM)
 W !,"  New ",PARAM R:'$L(PARAM) PARAM S:PARAM="" NEWFIN=1 Q:PARAM=""
 R " >",EF(PARAM) S EF(PARAM)=$ZSTRIP(EF(PARAM),"*W") D:EF(PARAM)="%"
 . W !,"  ",PARAM," allow spaces>" R EF(PARAM)
 S:EF(PARAM)="^" CHANGE=0
 I EF(PARAM)="" S EF(PARAM)=$G(^ZAA02GFAXC(STYNM,PARAM)) W EF(PARAM)
 K:EF(PARAM)="!" EF(PARAM)
 Q
LOADR
 N DIR,CNT,TMP,DT,RTN,RNAME,EXTRNAME
 N TYPE,file,description,format,printf,autoload,silent
 S EXTRNAME="ZAA02GCFGEFR.RO",DIR=$ZU(12,""),CHANGE=1
 S:$G(SUSPEND)="" SUSPEND=1 D:'SUSPEND SUSPEND D DT
 S RNAME=$P(EXTRNAME,".",1)
 K ^%utility($j)
 F R="ZAA02GFAXC","ZAA02GFAXQ2","ZAA02GSCRFX","ZAA02GVBUT2" S ^%utility($j,$i(CNT))=R_".INT"
 F R="ZAA02GVBTER","ZAA02GFAXM" S S=R,D=";",W="s ^%utility($j,$i(CNT))=R_"".INT""" X W F  S R=$O(^ROUTINE(R)) Q:$E(R,1,$L(S))]S  X W
 S TMP=$P($ZV,") ",2)
 S TYPE="user.cur",file=RNAME_DT_".RO:(""WNS"")",description=RNAME_" Backup",format="Cache",printf=0,autoload=0,silent=1
 D:TMP<5.1 rsave^%Wr("user.cur",RNAME_DT_".RO:(""WNS"")",RNAME_" Backup","Cache",0,0,1)
 D:TMP>5 rsave^Wr("user.cur",RNAME_DT_".RO:(""WNS"")",RNAME_" Backup","Cache",0,0,1)
 K ^%utility($j)
 W !!,"Backup file created: "_RNAME_DT_".RO"
 D FTPADS(EXTRNAME)
 D:$ZSE(EXTRNAME)]""
 . D:TMP<5.1 rload^%Wr("user.cur",RNAME_".RO"_DT_".RO:(""WNS"")",RNAME,"Cache",0,0,1)
 . D:TMP>5
 . . D $SYSTEM.OBJ.Load(DIR_EXTRNAME,"CF")
 . . W !,"Message from E-Fax Configuration Utility:"
 . . W !,"Errors detected during load are OK! The routines have still loaded"
 . S ^ZAA02GCFG("EF","UPDATED")=1
 D:$ZSE(EXTRNAME)=""
 . W !,EXTRNAME_" is not in the user folder",!,"E-Fax routines not loaded"
 S:'$D(^ZAA02GFAXC("SUSPEND")) SUSWARN=1
 Q
AUTOSSL(NAME,ACCEPT,CONNECT,CLIENT)
 S IO="|TCP|"_^ZAA02GFAXC(STYNM,"PORT")
 O IO:(^ZAA02GFAXC(STYNM,"IP")):0 I $T W !,"Port is already in use, Stunnel settings not applied",!
 C IO
 S:$SYSTEM.Version.GetPlatform()'="x86-64" PRG="%programfiles%"
 S:$SYSTEM.Version.GetPlatform()="x86-64" PRG="%programfiles(x86)%"
 I $ZSE(PRG_"\stunnel\stunnel.conf")'=""                        S STLOC=PRG_"\stunnel"                          D AUTOSSLAPPLY
 I $ZSE(PRG_"\stunnel\config\stunnel.conf")'=""         S STLOC=PRG_"\stunnel\config"           D AUTOSSLAPPLY
 I $ZSE(PRG_"\ADS\stunnel\stunnel.conf")'=""            S STLOC=PRG_"\ADS\stunnel"                      D AUTOSSLAPPLY
 I $ZSE(PRG_"\ADS\stunnel\config\stunnel.conf")'="" S STLOC=PRG_"\stunnel\config\ADS"   D AUTOSSLAPPLY
 W:'$D(STLOC) !,"STunnel folder cannot be found,",!,"Please set manually"
 Q
AUTOSSLAPPLY
 D:$D(STLOC)
 . S CHANGE=1
 . S STCFG=STLOC_"\stunnel.conf"
 . S STBK=STLOC_"\backup"
 . S STRUN=$ZF(-1,"sc query | find /i ""stunnel""") S STRUN='STRUN
 . S:STRUN STSTOP=$ZF(-1,"net stop ""stunnel""")
 . S:$ZSE(""""_STBK_"""")="" ERX1=$ZF(-1,"md """_STBK_"""")
 . S ERX2=$ZF(-1,"xcopy """_STCFG_""" """_STBK_""" /y")
 . S ERX3=$ZF(-1,"echo.>> """_STCFG_"""")
 . S ERX4=$ZF(-1,"echo ["_NAME_"]>> """_STCFG_"""")
 . S ERX5=$ZF(-1,"echo accept = "_ACCEPT_">> """_STCFG_"""")
 . S ERX6=$ZF(-1,"echo connect = "_CONNECT_">> """_STCFG_"""")
 . S ERX7=$ZF(-1,"echo client = "_CLIENT_">> """_STCFG_"""")
 . S:STRUN STSTART=$ZF(-1,"net start ""stunnel""")
 . W:'(ERX1+ERX2+ERX3+ERX4+ERX5+ERX6+ERX7) !,"STunnel auto append complete"
 . W:(ERX1+ERX2+ERX3+ERX4+ERX5+ERX6+ERX7) !,"STunnel auto append completed with failures"
 Q
 ;All prelim below
DIR
 N I,LIST,NSP,NSPOR
 F I=1:1:$ZU(90,0) S LIST($ZU(90,2,0,I))=""
 S NSPOR="S NSP=$O(LIST(NSP))"
 W !! S NSP="" F  X NSPOR Q:NSP=""  W:"%CACHELIB%SYSDOCBOOKSAMPLES"'[NSP NSP_" "
 F  R !,"Choose dir from list above to configure>",DIR D  Q:DIR=NSP
 . F  X NSPOR Q:(NSP="")!(DIR=NSP)
 W:DIR="" $ZU(5) S $ZNSPACE=DIR W !!,"Entity name: ",$P($G(^PRMG(1,1),":NO ENTITY DEFINED"),":",2)
 Q
VER
 N RTN,D,T
 D CLS("")
 W !,"Checking for updates"
 S RTN=$ZSTRIP($P(^ROUTINE("ZAA02GCFGEF",0,1),";",1),"*W")
 D FTPADS(RTN_".VER"),$SYSTEM.OBJ.Load(RTN_".VER")
 D:'( $G(^ZAA02GCFGVER(RTN)) = $G(^ROUTINE(RTN,0)) )
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
CLS(CHD)
 N I,C
 W $C(27,91) F I=1:1:24 W !,$C(13) F C=1:1:80 W " "
 W $C(27,91,85)
 S:$G(CHD)]"" HD=CHD W:$D(HD) HD
 Q
 ;
 ;
 ;New Variables:
 ;ERX1=0
 ;ERX2=0
 ;ERX3=0
 ;ERX4=0
 ;ERX5=0
 ;ERX6=0
 ;ERX7=0
 ;PRG="%programfiles(x86)%"
 ;STBK="%programfiles(x86)%\stunnel\backup"
 ;STCFG="%programfiles(x86)%\stunnel\stunnel.conf"
 ;STLOC="%programfiles(x86)%\stunnel"
 ;STRUN=1
 ;STSTART=0
 ;STSTOP=0
 ;connection=1
 ;dir="c:\cachesys\mgr\user\"
 ;ftp=<OBJECT REFERENCE>[1@%Net.FtpSession]
 ;ftpcheck=1
 ;stream=<OBJECT REFERENCE>[2@%Library.FileCharacterStream]
