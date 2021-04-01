ZAA02GCFG
        Q
DIR(entityName)
 N I,LIST,NSP,NSPOR
 F I=1:1:$ZU(90,0) S LIST($ZU(90,2,0,I))=""
 S NSPOR="S NSP=$O(LIST(NSP))"
 W !! S NSP="" F  X NSPOR Q:NSP=""  W:"%CACHELIB%SYSDOCBOOKSAMPLES"'[NSP NSP_" "
 F  R !,"Choose dir from list above to configure>",DIR D  Q:DIR=NSP
 . F  X NSPOR Q:(NSP="")!(DIR=NSP)
 W:DIR="" $ZU(5) S $ZNSPACE=DIR 
 Q
sysInfo(premVer,entityName)
        s entityName=$P($G(^PRMG(1,1),":NO ENTITY DEFINED"),":",2)
        s premVer=^ZAA02GVBSYS("VER","CLIENT")
        q
YN(YNF)
 N MSG,A,I S MSG=$C(13)_$E($G(YNF),0,70)_" [Y/N]>"
 W ! F  D  Q:(YN?1N)  W MSG,"<Invalid>" H .2 W $C(13),?80
 . W MSG R YN#1 S A=(YN?1A),(YN,YNF)=$S('A:"",A:$TR(YN,"YyNn","1100"))
 W $S(YN:"es",'YN:"o") S $ZT="^%ET" Q YNF
 
CH(CH)
 N MSG,OP,O,I S MSG=$C(13)_" >"
 F I=1:1 S O=$P(CH,":",I) Q:O=""  S OP(I)=O
 W ! S N="" F  S N=$O(OP(N)) Q:N=""  W OP(N)," "
 W ! F  D  Q:N'=""  W MSG,"<Invalid>" H .2 W $C(13),?80
 . W MSG R CH#1 S (CH)=$ZCVT(CH,"U") S N="" F  S N=$O(OP(N)) Q:(N="")||($P(OP(N),"-",1)=CH)
 W MSG,$P(OP(N),"-",2) Q CH
SUSPEND(SUSPEND)
 S:'$D(^ZAA02GFAXC("SUSPEND")) SUSPEND=1,^ZAA02GFAXC("SUSPEND")=""
 Q
UNSUSPEND(SUSWARN=1)
 K:$D(^ZAA02GFAXC("SUSPEND")) ^ZAA02GFAXC("SUSPEND")
 J ^ZAA02GFAXC
 W:$G(SUSWARN) !,"Warning:  Someone resumed faxes during this process",!,"You may need to run this again."
 Q
MSTOP
 N MSRUN,MSTOP,MPRUN,anykey
 S MSRUN=$ZF(-1,"tasklist | find /i ""medicsservice.exe""") S MSRUN='MSRUN
 D:MSRUN
 . S MSAUTOSTOP=1
 . W !,"Stopping Medics service..."
 . S MSTOP=$ZF(-1,"net stop ""medics service""")
 S MPRUN=$ZF(-1,"tasklist | find /i ""medicsprintui.exe""") S MPRUN='MPRUN
 I MPRUN R !,"Please stop Medics Service and/or Print",!,"then press any key to continue. . .",!,anykey#1 W $C(13)," "
 Q
MSTART
 N MSRUN,MSTOP,I,MPRUN,anykey
 S MSRUN=$ZF(-1,"tasklist | find /i ""medicsservice.exe""") S MSRUN='MSRUN
 D:'MSRUN 
 . W !,"Starting Medics service..."
 . S MSTART=$ZF(-1,"net start ""medics service""")
 . W "Done"
 . W !,"Please wait while Medics Print starts..."
 . F I=1:1:60 H 1 S MPRUN=$ZF(-1,"tasklist | find /i ""medicsprintui.exe""") S MPRUN='MPRUN Q:MPRUN
 I 'MPRUN R !!,"Medics print failed to start",!,"Please start Medics Service and/or Print",!,"then press any key to continue. . .",!,anykey#1 W $C(13)," "
 Q
AUTOSSL(NAME,ACCEPT,CONNECT,CLIENT)
 S IO="|TCP|"_ACCEPT
 O IO:("127.0.0.1"):0 I $T W !,"Port is already in use, Stunnel settings not applied",!
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
