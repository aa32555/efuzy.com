ZAA02GCFGUD ;Routine updater;11/26/2014; MRM;;10/30/2015 11:38:03AM
 ; ADS Corp. Copyright
 R "Enter the .RO routine name (wihtout the .RO)",!,
 RNAME
 D LOADR(RNAME)
 Q
RELOAD(RNAME="")
 Q:RNAME=""
 D LOADR(RNAME)
 D ^@RNAME
 Q
LOADR(RNAME="")
 Q:RNAME=""
 N DIR,TMP,RTN,EXTRNAME
 S DIR=$ZU(12,"")
 S EXTRNAME=RNAME_".RO"
 D FTPADS(EXTRNAME)
 S TMP=$P($ZV,") ",2)
 D:$ZSE(EXTRNAME)]""
 . D:TMP<5.1 rload^%Wr("user.cur",RNAME_".RO:(""WNS"")",RNAME,"Cache",0,0,1)
 . D:TMP>5
 . . D $SYSTEM.OBJ.Load(DIR_EXTRNAME,"CF")
 . W !,"Message from Routine Updater:"
 . W !,"Errors detected during load are OK! The routines have still loaded"
 . W !,"Any errors detected should, however, be reported to development"
 D:$ZSE(EXTRNAME)=""
 . W !,EXTRNAME_" is not in the user folder",!,"Routine not updated"
 Q
FTPML(file)
 D FTP("ftp.mlaro.com","ftp","annonymous","21",file)
 Q
FTPADS(file)
 D FTP("ftp.adsc.com","suppftp","ftpup*99","21",file)
 Q
FTP(server,user,password,port,file)
 S dir=$ZU(12,"")
 S ftp=##class(%Net.FtpSession).%New()
 I 'ftp.Connect(server,user,password,port) W "Not connected",! Q
 W "Ftp server messsage:",!,ftp.ReturnMessage,!
 S stream=##class(%FileCharacterStream).%New()
 S stream.Filename=dir_file
 I 'ftp.Binary() W "Can not swap to binary mode",! Q
 W "Mode now: ",ftp.Type,!
 I 'ftp.Retrieve(file,stream) W "Failed to get file",! Q
 W "Length of file received: ",stream.Size,!
 I 'ftp.Logout() W "Failed to logout",!
 C file
 Q
 
