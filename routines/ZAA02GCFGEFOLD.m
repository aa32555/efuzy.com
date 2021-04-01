ZAA02GCFGEFOLD ;Old subroutines, NOT USED
 Q
CHECK  
 ;1) Checks to see if interfax globals exist
 ;2) Asks user to overwrite (if globals exist) or continue if they do not exist
 ;3) Asks the user whether or not to input the efax routines
 W !,"E-Fax Configuration Utility",!
 I $D(^ZAA02GFAXC("INTERFAX")) D
 .W !,"E-Fax is already Configured",!
 .W "Area Code: ",^ZAA02GFAXC("INTERFAX","CODE"),!,"IP: ",^("IP"),!,"Password: ",^("PASSWORD"),!,"Port: ",^("PORT"),!,"Username: ",^("USER"),!
 .F  R !,"Overwrite? [Y/N]> ",CHKG Q:CHKG="Y"!(CHKG="y")!(CHKG="N")!(CHKG="n")
 E  F  R !,"Configure Settings? [Y/N]> ",CHKG Q:CHKG="Y"!(CHKG="y")!(CHKG="N")!(CHKG="n")
 D:CHKG="Y"!(CHKG="y") LOADGOLD
 F  R !,"Load Routines? [Y/N]> ",CHKL Q:CHKL="Y"!(CHKL="y")!(CHKL="N")!(CHKL="n")
 D:CHKL="Y"!(CHKL="y") LOADROLD
 I SUSPEND=1 D
 .I $D(^ZAA02GFAXC("SUSPEND")) K ^ZAA02GFAXC("SUSPEND")
 .I SUSWARN=1 W !,"Warning:  Someone resumed faxes during this process",!,"You may need to run this again."
 I CHKG="Y"!(CHKG="y")!(CHKL="Y")!(CHKL="y") W !,"Done"
 E  W !,"No Change"
 Q
LOADGOLD ;Sets 5 globals in ^ZAA02GFAXC("INTERFAX")
 D SUSPEND
 S WS="Y"
 W !!,"Type % then enter to allow spaces",!
 R !,"Username> ",USER I USER="" W !,"Config not saved" Q
 I USER="%" S WS="N" R !,"Username (Whitespaces allowed)> ",USER I USER="" W !,"Config not saved" Q 
 R !,"Password> ",PASS I PASS="" W !,"Config not saved" Q
 I PASS="%" S WS="N" R !,"Password (Whitespaces allowed)> ",PASS I PASS="" W !,"Config not saved" Q
 R !,"Area Code> ",AREA I AREA="" W !,"Config not saved" Q
 I WS="Y" S USER=$ZSTRIP(USER,"*W"),PASS=$ZSTRIP(PASS,"*W"),AREA=$ZSTRIP(AREA,"*W")
 S ^ZAA02GFAXC("FAX")="INTERFAX\N"
 S ^ZAA02GFAXC("INTERFAX","CODE")=AREA,^("IP")="127.0.0.1",^("PASSWORD")=PASS,^("PORT")=8066,^("USER")=USER
 I '$D(^ZAA02GFAXC("SUSPEND")) S SUSWARN=1
 Q
LOADROLD ; Backs up the 6 Interfax routines and loads the new ones.
 D SUSPEND
 S D=$ZD($P($H,",",1)),T=$ZT($P($H,",",2))
 S DFORMAT=$P(D,"/",3)_$P(D,"/",1)_$P(D,"/",2) 
 S DT=$ZSTRIP(DFORMAT_T,"*P")
 S ^%utility($j,1)="ZAA02GFAXC.INT"
 S ^%utility($j,2)="ZAA02GFAXM.INT"
 S ^%utility($j,3)="ZAA02GFAXQ2.INT"
 S ^%utility($j,4)="ZAA02GVBTER2.INT"
 S ^%utility($j,5)="ZAA02GVBTER3.INT"
 S ^%utility($j,6)="ZAA02GVBTERP.INT"
 S TMP=$P($ZV,") ",2)
 I TMP<5.1 D rsave^%Wr("user.cur","ZAA02GEFAXBAK"_DT_".RO:(""WNS"")","ZAA02GEFAX Backup","Cache",0,0,1)
 I TMP>5 D rsave^Wr("user.cur","ZAA02GEFAXBAK"_DT_".RO:(""WNS"")","ZAA02GEFAX Backup","Cache",0,0,1)
 K ^%utility($j)
 W !!,"Backup file created: ZAA02GEFAXBAK"_DT_".RO"
 S DIR=$ZU(12,"")
 I $ZSEARCH("ZAA02GEFAX.RO")'="" D $System.OBJ.Load(DIR_"ZAA02GEFAX.RO","CF")
 E  W !,"ZAA02GEFAX.RO is not in the user folder",!,"E-Fax routines not loaded"
 I '$D(^ZAA02GFAXC("SUSPEND")) S SUSWARN=1
 Q
 ; Old routine build loop
 K ^%utility($j)
 S CNT=1
 S ^%utility($j,CNT)="ZAA02GFAXC.INT"
 S CNT=CNT+1
 S ^%utility($j,CNT)="ZAA02GSCRFX.INT"
 S RTN="ZAA02GFAXM" F  S RTN=$O(^ROUTINE(RTN)) Q:$E(RTN,1,6)'="ZAA02GFAXM"  D
 . S CNT=CNT+1
 . S ^%utility($j,CNT)=RTN_".INT"
 S CNT=CNT+1
 S ^%utility($j,CNT)="ZAA02GFAXQ2.INT"
 S CNT=CNT+1
 S ^%utility($j,CNT)="ZAA02GVBTER2.INT"
 S CNT=CNT+1
 S ^%utility($j,CNT)="ZAA02GVBTERP.INT"
EFINT ;Interfax
 N AREA,IP,PASS,PORT,USER
 N YN D:$D(^ZAA02GFAXC(STYNM))  D:'$D(^ZAA02GFAXC(STYNM)) YN("Configure Settings?") D:YN EFLOADG
 . W !,"CURRENT CONFIG"
 . S IP=$G(^ZAA02GFAXC(STYNM,"IP")),PASS=$G(^("PASSWORD")),PORT=$G(^("PORT")),USER=$G(^("USER"))
 . W !,"IP: ",IP,!,"Password: ",PASS,!,"Port: ",PORT,!,"Username: ",USER,!
 . D YN("Overwrite?")
 N YN D YN("Load Routines?") D:YN EFLOADINTR
 D:SUSPEND UNSUSPEND
 Q
EFSFT ;SoftlinX
 N YN
 D:$D(^ZAA02GFAXC("SOFTLINX"))
 .W !,"CURRENT CONFIG",!
 .W "IP:       ",$G(^ZAA02GFAXC("SOFTLINX","IP")),!,"Username: ",$G(^("USER")),!,"Password: ",$G(^("PASSWORD")),!,"Port:     ",$G(^("PORT")),!,"Realm:    ",$G(^("REALM")),!
 .D YN("Overwrite?")
 D:'$D(^ZAA02GFAXC("SOFTLINX")) YN("Configure Settings?") D:YN EFLOADG
 N YN D YN("Load Routines?") D:YN EFLOADSFTR
 N YN D YN("Configure STunnel?") D:YN EFLOADSFTSSL
 R:'YN !,"Enter IP address of STunnel installation> ", IP
 S IP=$ZSTRIP($G(IP),"*W") S ^ZAA02GFAXC("SOFTLINX","IP")=IP
 D:SUSPEND UNSUSPEND
 Q
EFLOADG ;Sets globals
 N WS,USER,PASS,AREA,PORT,REALM
 S CHANGE=1
 D:'SUSPEND SUSPEND
 W !!,"Type % then enter to allow spaces",!
 S WS=0
 R !,"Username> ",USER
 I USER="%" S WS=1 R !,"Username (Whitespaces allowed)> ",USER
 I USER="" W !,"Config not saved" Q
 S:'WS USER=$ZSTRIP($G(USER),"*W")
 S:USER["@" REALM=$P(USER,"@",2),USER=$P(USER,"@",1)
 D:'$D(REALM)
 .R !,"Realm> ",REALM
 .I REALM="%" S WS=1 R !,"Username (Whitespaces allowed)> ",REALM
 I REALM="" W !,"Config not saved" Q
 S:'WS REALM=$ZSTRIP($G(REALM),"*W")
 S WS=0
 R !,"Password> ",PASS
 I PASS="" W !,"Config not saved" Q
 I PASS="%" S WS=1 R !,"Password (Whitespaces allowed)> ",PASS
 I PASS="" W !,"Config not saved" Q
 S:'WS PASS=$ZSTRIP($G(PASS),"*W")
 I STY="I" R !,"Area Code> ",AREA
 I STY="I" S AREA=$ZSTRIP($G(AREA),"*W")
 S ^ZAA02GFAXC("FAX")=$S(STY="I":"INTERFAX\N",STY="S":"SOFTLINX\N",1:^ZAA02GFAXC("FAX"))
 S:STY="I" ^ZAA02GFAXC("INTERFAX","CODE")=$G(AREA),^("PASSWORD")=$G(PASS),^("PORT")=8066,^("USER")=$G(USER)
 S:STY="S" ^ZAA02GFAXC("SOFTLINX")="SOFTLINX SETTINGS",^ZAA02GFAXC("SOFTLINX","IP")=$G(IP),^("PASSWORD")=$G(PASS),^("PORT")=8080,^("USER")=$G(USER),^("REALM")=$G(REALM)
 S:'$D(^ZAA02GFAXC("SUSPEND")) SUSWARN=1
 Q
EFLOADINTR ;INTERFAX
 N DIR,CNT,TMP,DT
 S DIR=$ZU(12,"") S CHANGE=1 S:'$G(SUSPEND) SUSPEND=1 D:'SUSPEND SUSPEND D DT
 S ^%utility($j,$I(CNT))="ZAA02GFAXC.INT"
 S ^%utility($j,$I(CNT))="ZAA02GFAXM.INT"
 S ^%utility($j,$I(CNT))="ZAA02GFAXQ2.INT"
 S ^%utility($j,$I(CNT))="ZAA02GVBTER2.INT"
 S ^%utility($j,$I(CNT))="ZAA02GVBTER3.INT"
 S ^%utility($j,$I(CNT))="ZAA02GVBTERP.INT"
 S TMP=$P($ZV,") ",2)
 I TMP<5.1 D rsave^%Wr("user.cur","ZAA02GEFAXBAK"_DT_".RO:(""WNS"")","ZAA02GEFAX Backup","Cache",0,0,1)
 I TMP>5 D rsave^Wr("user.cur","ZAA02GEFAXBAK"_DT_".RO:(""WNS"")","ZAA02GEFAX Backup","Cache",0,0,1)
 K ^%utility($j)
 W !!,"Backup file created: ZAA02GEFAXBAK"_DT_".RO"
 I $ZSE("ZAA02GEFAXINT.RO")'="" D $SYSTEM.OBJ.Load(DIR_"ZAA02GEFAXINT.RO","CF")
 I $ZSE("ZAA02GEFAXINT.RO")=""  W !,"ZAA02GEFAXINT.RO is not in the user folder",!,"E-Fax routines not loaded"
 S:'$D(^ZAA02GFAXC("SUSPEND")) SUSWARN=1
 Q
EFLOADSFTR ;SOFTLINX
 N DIR,CNT,TMP,DT,RTN
 S DIR=$ZU(12,"") S CHANGE=1 S:$G(SUSPEND)="" SUSPEND=1 D:'SUSPEND SUSPEND D DT
 K ^%utility($j)
 S ^%utility($j,$i(CNT))="ZAA02GFAXC.INT"
 S ^%utility($j,$i(CNT))="ZAA02GSCRFX.INT"
 S RTN="ZAA02GFAXM" F  S RTN=$O(^ROUTINE(RTN)) Q:$E(RTN,1,6)'="ZAA02GFAXM"  S ^%utility($j,$i(CNT))=RTN_".INT"
 S ^%utility($j,$i(CNT))="ZAA02GFAXQ2.INT"
 S ^%utility($j,$i(CNT))="ZAA02GVBTER2.INT"
 S ^%utility($j,$i(CNT))="ZAA02GVBTERP.INT"
 S TMP=$P($ZV,") ",2)
 I TMP<5.1 D rsave^%Wr("user.cur","ZAA02GEFAXBAK"_DT_".RO:(""WNS"")","ZAA02GEFAX Backup","Cache",0,0,1)
 I TMP>5 D rsave^Wr("user.cur","ZAA02GEFAXBAK"_DT_".RO:(""WNS"")","ZAA02GEFAX Backup","Cache",0,0,1)
 K ^%utility($j)
 W !!,"Backup file created: ZAA02GEFAXBAK"_DT_".RO"
 I $ZSE("ZAA02GEFAXSFT.RO")'="" D $SYSTEM.OBJ.Load(DIR_"ZAA02GEFAXSFT.RO","CF")
 I $ZSE("ZAA02GEFAXSFT.RO")="" W !,"ZAA02GEFAXSFT.RO is not in the user folder",!,"E-Fax routines not loaded"
 S:'$D(^ZAA02GFAXC("SUSPEND")) SUSWARN=1
 Q
