ZAA02GFTP ;;2018-12-28 17:59:15
 q
 
errFTP ;
 S (errDescr,err)=""
 S $ZT=""
 I $D(%objlasterror) {
        D DecomposeStatus^%apiOBJ(%objlasterror,.err,"-d")
        For i=1:1:err { Set errDescr=errDescr_err(i) }
 } 
 ELSE {   
        S errDescr=$ZE
 }
 
 d logError($G(log),$G(errDescr),$G(ff))
 q "0|"_"ERR_SFTP"_$C(9)_$G(log)_$C(9)_"ERROR: "_$G(errDescr)
 
FTPSEND(ftpserver,port,username,password,fileFullPath,destFileName,folder)
 n (ftpserver,port,username,password,fileFullPath,destFileName,folder)
 
 s $zt="errFTP"
 
    s cnt=+$G(^DEBUG("SCH","T",$P($H,",",1),"SFTP"))+1
        s ^DEBUG("SCH","T",$P($H,",",1),"SFTP")=cnt
        
        s res=0 s msg=""
        s fldrLog="" if ($L($G(folder))) s fldrLog="; dest. folder '"_$G(folder)_"'"
        
        s log="host '"_ftpserver_"' as '"_username_"'"_"; file '"_destFileName_"'"_fldrLog
        
        s ^DEBUG("SCH","T",$P($H,",",1),"SFTP",cnt,"req")=$H_$C(9)_log_" ; source file: "_fileFullPath
        
    //always keep a copy 
        s fldrCopy=$G(^MSCG("AUTOSFTP","FOLDER_COPY"))                                  ;create folder if possible, create 'namespace\sftp_copy' is the default 
        if $L(fldrCopy)=0 s fldrCopy="sftp_copy" 
        s fldrFailed=$G(^MSCG("AUTOSFTP","FOLDER_FAILED"))      ;create folder if possible, create 'sftp_failed' is the default 
        if $L(fldrFailed)=0 s fldrFailed="sftp_failed" 
        
        D INT^%DIR,NSP^%DIR s fldrCopy=%SYSDIR_fldrCopy s fldrFailed=%SYSDIR_fldrFailed
        d ##class(%Library.File).CreateDirectory(fldrCopy)
        d ##class(%Library.File).CreateDirectory(fldrFailed)
        
        n tm3 s tm3=$ZD($H,3)_"-"_$TR($ZT($P($H,",",2),3),":","_")_"_"
        s ff=fldrFailed_"\"_tm3_destFileName_".txt"
        s fcopy=fldrCopy_"\"_tm3_destFileName_".txt"
        d ##class(%Library.File).CopyFile(fileFullPath,ff)                      ; copy into failed folder right away
.
        set ssh = ##class(%Net.SSH.Session).%New()
        
    Set sc = ssh.Connect(ftpserver,port)
    if +$G(sc)'=1 s msg="'Connect' error, check host. " d logError(log,msg,ff) q $$getErrRes(log,msg)
    
    Set sc = ssh.AuthenticateWithUsername(username,password)
    if +$G(sc)'=1 s msg="'Authenticate' error, check username/password. " d logError(log,msg,ff) q $$getErrRes(log,msg)
    
    set st = ssh.OpenSFTP(.sftp)
    if +$G(st)'=1 s msg="'OpenSFTP' error. " s msg=msg_" "_$$getErrDescr(st) d logError(log,msg,ff) q $$getErrRes(log,msg)
    
    if ($L($G(folder))) { 
        s destFileName=folder_"\"_destFileName
    }
    
    set st = sftp.Put(fileFullPath,destFileName,"0600",0)
    
        if +$G(st)'=1 s msg="'Put file' error. "_" "_$$getErrDescr(st) d logError(log,msg,ff) q $$getErrRes(log,msg)
 
    if +$G(st)=1 { 
        d ##class(%Library.File).CopyFile(fileFullPath,fcopy)   ; all OK, copy to copy folder
        d ##class(%Library.File).Delete(ff)                                     ; delete from failed folder
    }
    
        s res="1|OK"_$C(9)_log_" ; SENT 1"
        s ^DEBUG("SCH","T",$P($H,",",1),"SFTP",cnt,"resOK")=$H_$C(9)_log_" ; SENT 1"_$C(9)_"OK"_$C(9)_fcopy
        
        q res
.
logError(log,msg,f1)
        s ^DEBUG("SCH","T",$P($H,",",1),"SFTP",cnt,"resError")=$H_$C(9)_log_" ; SENT 0 "_$C(9)_msg_$C(9)_f1
        q
getErrRes(log,msg)
        q "0|"_"ERR_SFTP"_$C(9)_$G(log)_$C(9)_"ERROR: "_msg
        
getErrDescr(er)
 D DecomposeStatus^%apiOBJ(er,.err,"-d")
    s errDescr=""
        For i=1:1:err { Set errDescr=errDescr_err(i) }  
        q errDescr
.
FTPLIST(ftpserver,port,username,password,folder) //list files on remote server
 n (ftpserver,port,username,password,folder)
 s $zt="errFTP"
.
        s fldrLog="" if ($L($G(folder))) s fldrLog=" (folder '"_$G(folder)_"')" 
        s res=0 s msg=""
        s log="host '"_ftpserver_"' as '"_username_"'"_fldrLog_"; LIST "
        
        set ssh = ##class(%Net.SSH.Session).%New()
        
    Set sc = ssh.Connect(ftpserver,port)
    if +$G(sc)'=1 s msg="'Connect' error, check host. " q "0|"_"ERR_SFTP"_$C(9)_$G(log)_$C(9)_"ERROR: "_msg
    
    Set sc = ssh.AuthenticateWithUsername(username,password)
    if +$G(sc)'=1 s msg="'Authenticate' error, check username/password. " q "0|"_"ERR_SFTP"_$C(9)_$G(log)_$C(9)_"ERROR: "_msg
    
    set st = ssh.OpenSFTP(.sftp)
    if +$G(st)'=1 s msg="'OpenSFTP' error. " q "0|"_"ERR_SFTP"_$C(9)_$G(log)_$C(9)_"ERROR: "_msg_" "_$$getErrDescr(st)
    
    s fldr=""
    if ($L($G(folder))) { 
        s fldr="\"_folder
    }
   
    set st = sftp.Dir(fldr,.files)
    if +$G(st)'=1 s msg="'Dir' error. " q "0|"_"ERR_SFTP"_$C(9)_$G(log)_$C(9)_"ERROR: "_msg_" "_$$getErrDescr(st)
    
    set i=0
    s tp="" s nm="" 
    while $data(files(i))
    {   
        s nm=$listget(files(i),1)
        s tp=$listget(files(i),3)
        s log=log_$C(13)_"file name: "_nm_"  type: "_tp
        if tp'="D" s log=log_ " size: "_$listget(files(i),2)
        set i=i+1
    }
.
.
    s log="Files: "_i_ $C(9)_log
    
        s res="1|OK"_$C(9)_log
        
        if +$G(st)'=1 s msg="'List files' error. " s res="0|ERR_FILE"_$C(9)_$G(log)_$C(9)_"ERROR: "_msg_" "_$$getErrDescr(st)
.
        q res
 
SENDFOLDER(ftpserver,port,username,password,sourceFolder,destFolder,fileExt) 
 ; upload all files in sourceFolder that match extension if extension provided, otherwise all files
 n (ftpserver,port,username,password,sourceFolder,destFolder,fileExt) 
 if '$L($G(fileExt)) s fileExt="*"
 s $zt="errFTP"
 
    s cnt=+$G(^DEBUG("SCH","T",$P($H,",",1),"SFTP"))+1
        s ^DEBUG("SCH","T",$P($H,",",1),"SFTP")=cnt
        
        s res=0 s msg=""
        s fldrLog="" if ($L($G(destFolder))) s fldrLog="; dest. folder '"_$G(destFolder)_"'"
        
        s log="host '"_ftpserver_"' as '"_username_"'"_"; folder contents '"_sourceFolder_"'"_fldrLog
        
        s ^DEBUG("SCH","T",$P($H,",",1),"SFTP",cnt,"req")=$H_$C(9)_log_" ; folder contents: "_sourceFolder
.
        set ssh = ##class(%Net.SSH.Session).%New()
        
    Set sc = ssh.Connect(ftpserver,port)
    if +$G(sc)'=1 s msg="'Connect' error, check host. " d logError(log,msg,ff) q $$getErrRes(log,msg)
    
    Set sc = ssh.AuthenticateWithUsername(username,password)
    if +$G(sc)'=1 s msg="'Authenticate' error, check username/password. " d logError(log,msg,ff) q $$getErrRes(log,msg)
    
    set st = ssh.OpenSFTP(.sftp)
    if +$G(st)'=1 s msg="'OpenSFTP' error. " s msg=msg_" "_$$getErrDescr(st) d logError(log,msg,ff) q $$getErrRes(log,msg)
    
    s fileList=$$ListFilesInDir^ZAA02GEMD1(sourceFolder,"*."_fileExt)
    
    n f, howMany, strAllFiles, shortFN, errRes, errAll
    s howMany=0 s strAllFiles="" s shortFN="" s errRes="" s errAll=""
        FOR i=1:1:$LISTLENGTH(fileList) 
        {
                s f=$LIST(fileList,i)
                i $L(f) {
                        if (##class(%File).DirectoryExists(f)) {}  //do nothing
                        else  { 
                        s destFileName=$$REPLACE^ZAA02GUTILS(f,"\","/")
                        s shortFN=$P(destFileName,"/",$L(destFileName,"/"))
                        
                        if ($L($G(destFolder))) { 
                                s destFileName=destFolder_"/"_shortFN
                                }
.
                        set st = sftp.Put(f,destFileName,"0600",0)
                
                        if +$G(st)=1 
                        {               
                                s howMany=howMany+1
                                s strAllFiles=strAllFiles_shortFN_", "
                        } 
                        else 
                        {
                                if '$L(errRes) s errRes=$$getErrDescr(st) //keep the first error status
                                s errAll=errAll_shortFN_", "
                        }
                        }
                }
        }
.
    if $L(errRes) {
            d logError(log,errRes_"; files "_errAll,"send folder contents") 
        s res="0|*** ERROR *** "_" Folder '"_destFolder_"' "_errRes
    } 
    else
        { 
                s res="1|dest. folder '"_destFolder_"' SENT "_howMany_$C(9)_log_" ; SENT "_howMany
                s ^DEBUG("SCH","T",$P($H,",",1),"SFTP",cnt,"resOK")=$H_$C(9)_log_" ; SENT "_howMany_": "_strAllFiles_$C(9)_"OK"
        }
        q res
.
.
