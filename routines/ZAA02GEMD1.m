ZAA02GEMD1 ;;2019-03-21 13:31:42
 ; no previous calls from VB needed, call from anywhere, this is self sufficient
 q
GetTm()
 q 120
AUTH(user,pass) ;VB 
 s tmp=$P($ZV,") ",2)
 s $zt="errorAuth"
 s client=##class(ITSWS.ITSWSSoap5Stream).%New()
 s client.Timeout=$$GetTm()
 s resp=client.Authenticate(user,pass)
 s r1="0|" if resp.ErrorCode="0" s r1="1|"
 s $zt=""
 q r1_resp.ErrorCode_$C(9)_resp.Response ; 0 is good, others are errors, message after char(9)
.
errorAuth ;
 S (errDescr,err)=""
 S $ZT=""
 I ($ZE["ZSOAP") {
        D $system.OBJ.DisplayError(%objlasterror) 
        D DecomposeStatus^%apiOBJ(%objlasterror,.err,"-d")
        For i=1:1:err { Set errDescr=errDescr_err(i) }
 } 
 ELSE {   
        S errDescr=$ZE
 }
 s respCode="ITS"
 s respMsg="ITS CONNECTION "_errDescr
 
 s ^DEBUG("SCH","T",$P($H,",",1),$P($H,",",2),"ERRAUT")=respCode_" "_respMsg
.
 q "0|"_respCode_$C(9)_respMsg
 
SUBM(user,pass,filenum) ;VB 
 N client,line,outstream,resp,stream,tmp,zipfile,nm,DT,TM,NO,tempstream,STRM
 n respMsg,respCode,itm,itm2
 
 i $g(USER)="MG",$g(^MSCG("MG","NOSUBMIT")) q "0|"_$c(9)_"Submission blocked for operator MG"
 
 s tmp=$P($ZV,") ",2)
  
 s ^DEBUG("SCH","T",$P($H,",",1),$P($H,",",2),"SUBM1")=user_" "_filenum
 
 s client=##class(ITSWS.ITSWSSoap5Stream).%New()
 s client.Timeout=$$GetTm()
.
 s itm="^EISCP("_$TR(filenum,":",",")_")"          ; get original subscripts for ^EISCP(65555,222,1)
 s itm2="^EISCPACK("_$TR(filenum,":",",")_")"  ; get original subscripts for ^EISCPACK(65555,222,1)
        
 n submType, insProgram
 
 s submType="MCD"  ;HCD for 2 programs only: MODUBX, MODNYLX
 s insProgram= $P(@itm,":",3)
 if (insProgram="MODUBX")||(insProgram="MODNYLX") s submType="HCD"
.
 if (insProgram="MODWCWX") s submType="SFTP" //submit to sftp together with medical record .pdf files prepared
.
.
        ;mark this file as being processed
        i $L($TR(filenum,":0123456789","")) q "0|invalid file num"
        i filenum="" q "0|filenum empty"
        i '($G(@itm)) q "0|"_itm_" not found"
        
        i $g(USER)'="" s ^EISOP("SUBMIT",$p($h,",",1),$p($h,",",2),filenum)=USER
.
        s $P(@itm,"***",3)="PROC"
        
        //retrieve from ^EISCP into file stream
        s outstream=##class(%GlobalCharacterStream).%New()
        s DT=$P(filenum,":",1) s TM=$P(filenum,":",2) s NO=$P(filenum,":",3)
        S nm=0 
        s STRM =##class(%GlobalCharacterStream).%New()
        While '(nm="")
        { s nm=$O(^EISCP(DT,TM,NO,nm)) 
                if '(nm="")
                {
                        s val=$G(^EISCP(DT,TM,NO,nm)) 
                        d STRM.MoveToEnd()
                        d STRM.Write(val)
                }
        }
        
        //timestamp 
        n tm3 s tm3=$ZD($H,3)_"-"_$TR($ZT($P($H,",",2),3),":","_")_"_"
        
        //copy for archive
        if $G(^MSCG("AUTOSUBM","KEEPFILE")) { 
                //create folder if possible, create 'namespace\claim_copy' folder in case folder name not defined 
                n fldr s fldr=$G(^MSCG("AUTOSUBM","FOLDER")) ;;check dir access
                if $L(fldr)=0 D INT^%DIR,NSP^%DIR s fldr=%SYSDIR_"claim_copy" 
                n a2 s a2=##class(%Library.File).CreateDirectory(fldr)
.
                n copyFileName s copyFileName=fldr_"\"_tm3_DT_"-"_TM_"-"_NO_".txt"
.
                Set fCopy=##class(%Library.File).%New(copyFileName)
                d fCopy.Open("WNS")
                
                Do STRM.Rewind()
                While 'STRM.AtEnd {
                s line=STRM.Read()
                d fCopy.Write(line)
                }
        }
        
        if (submType="SFTP") {
                s sftpFileName="sftp_"_insProgram_"_"_tm3_DT_"-"_TM_"-"_NO_".txt"
                        
                        Set fCopy=##class(%Library.File).%New(sftpFileName)
                        d fCopy.Open("WNS")
                
                        Do STRM.Rewind()
                        While 'STRM.AtEnd {
                        s line=STRM.Read()
                        d fCopy.Write(line)
                        }
                        n destFileName s destFileName=sftpFileName 
                        if $L(insProgram)>3 s destFileName=$E(insProgram,4,100)_".clm" //WCWX.clm
                        n subfolder s subfolder="Incoming/ANSI837" //s subfolder="Incoming/Test"                        
                        n ftpport s ftpport=22
                                        // sftp.iHCFA.com
                                        //      *    Incoming Subfolder for 837 EDI files = ANSI837       
                                        //      *    Incoming Subfolder for Individual Attachment files =  Attachments 
                                        //      *    Incoming Subfolder for Test files = TEST
.
                        n ftpserver, ftpRes
                        s ftpserver="sftp.iHCFA.com"
                        
                        if $G(^MSCG("IHCFAtest"))=1 s ftpserver="rcmfiles.adsc.com"             
                        
                        s ftpRes="" 
.
                        //check if there is a process we have to wait for 
                        s mustWait=$$chkProcess^ZAA02GUTILS("ZAA02GWAITFORPROCESS", "")
                        if mustWait { 
                                        s respMsg="Will not submit to SFTP. Related process is not completed, please wait and submit again. 'ZAA02GWAITFORPROCESS' is still running."
                                        s respCode=1    
                        } else {                        
                        
                                s ftpRes=$$FTPSEND^ZAA02GFTP(ftpserver,ftpport,user,pass,sftpFileName,destFileName,subfolder)
                        
                                //      sftp result: ftpRes starts "1|" = success, otherwise failed
                                //                      "1|OK"_$C(9)_log_" ; SENT 1"
                                //                      "0|"_"ERR_SFTP"_$C(9)_$G(log)_$C(9)_"ERROR: "_msg
                        
                                s respMsg=$E(ftpRes,3,1000)
                        
                                if $P(ftpRes,"|",1)=1 { 
                                        s respCode=0 
                                        s respMsg=$E(ftpRes,3,2000)_$C(9) s respMsg=$$REPLACE^ZAA02GUTILS(respMsg,$C(9),$C(10,10))
                        
                                        //now send attachements
                                        n sourceFolder,destFolder s destFolder="Incoming/Attachments"   //s destFolder="Incoming/Test"                  
                                        //c:\cachesys\mgr\user8\encounters\20181222-1-6-modwcwx-74\
                                        s sourceFolder=$$getRelatedFolder(DT,TM,NO)
                                        
                                        s resRelated=$$SENDFOLDER^ZAA02GFTP(ftpserver,ftpport,user,pass,sourceFolder,destFolder,"pdf") 
                                        s resRelatedCode=$P(resRelated,"|",1) s resRelatedMsg=$P(resRelated,"|",2)
                                        s respMsg=respMsg_" "_resRelatedMsg
                                        if (resRelatedCode=1) {         ;delete pdf files IF SENT SUCCESSFULLY
                                                        i '($G(^MSCG("IHCFAkeepPDF"))=1) d ##class(%Library.File).Delete(sourceFolder_"\*.pdf")
                                                }
                                } else { 
                                        s respCode=$E($P(ftpRes,$C(9),1),3,1000)
                                        s $P(ftpRes,$C(9),1)=""
                                        s respMsg=$$REPLACE^ZAA02GUTILS(ftpRes,$C(9),"  ")
                                }
                        }
                }
        else { 
                //encodeinto outstream for webservice submission
                d STRM.Rewind()
                While 'STRM.AtEnd {
                        s line=STRM.Read(30000)
                        s tempstream=$$ENCODE(line)
                        While 'tempstream.AtEnd {
                        d outstream.MoveToEnd()
                        d outstream.Write(tempstream.Read())
                        }
                }
        
                s STRM=""       
                s $zt="errorPutFile" //internet connectivity issues 
 
                s ^DEBUG("SCH","T",$P($H,",",1),$P($H,",",2),"SUBM2")=user_" "_filenum
.
                s resp=client.PutFile(user,pass,submType,outstream)
                d outstream.%Close()
 
                s respMsg=resp.Response.Read()
                s respCode=resp.ErrorCode       
        
        }
 
 s ^DEBUG("SCH","T",$P($H,",",1),$P($H,",",2),"SUBM3")=respCode_" "_respMsg
.
 ;log result into EISCP global, update EISCP status
 
 n usrCode s usrCode="" i $g(USER)'="" s usrCode=" [ operator: "_$G(USER)_" ]"
 s @itm2=$H_$C(9)_respCode_$C(9)_respMsg_usrCode_$C(9)_filenum
 if respCode=0
 {
         s $P(@itm,"***",3)="COMPL"
 }
 else
 {
         s $P(@itm,"***",3)="ERR"
 }
 
 s $zt=""
 s r1="0|" if respCode="0" s r1="1|"
 q r1_respCode_$C(9)_respMsg_$C(9)_filenum ; 0 from emdeon is good, others are errors, message after char(9)
 
errorPutFile ;
 S (errDescr,err)="" 
 S $ZT=""
 I ($ZE["ZSOAP") {
        D $system.OBJ.DisplayError(%objlasterror) 
        D DecomposeStatus^%apiOBJ(%objlasterror,.err,"-d")
        For i=1:1:err { Set errDescr=errDescr_err(i) }
 } 
 ELSE {   
        S errDescr=$ZE
 } 
 s respCode="ITS"
 s respMsg="ITS CONNECTION "_errDescr
 
 s @itm2=$H_$C(9)_respCode_$C(9)_respMsg_$C(9)_filenum
 
 s ^DEBUG("SCH","T",$P($H,",",1),$P($H,",",2),"ERRPUTFILE")=respCode_" "_respMsg
.
 q "0|"_respCode_$C(9)_respMsg_$C(9)_filenum
.
ENCODE(X) ;length of X must be divisible by 3
 S ReturnStream=##class(%GlobalCharacterStream).%New()
 N RGZ,RGZ1,RGZ2,RGZ3,RGZ4,RGZ5,RGZ6,RGZ7,RGZ8
 K ^SORT($J,"ENCODE")
 S RGZ=$$INIT,RGZ1="",RGZ7=0
 F RGZ2=1:3:$L(X) D
 . S RGZ3=0,RGZ6=""
 . F RGZ4=0:1:2 D
 .. S RGZ5=$A(X,RGZ2+RGZ4),RGZ3=RGZ3*256+$S(RGZ5<0:0,1:RGZ5)
 . F RGZ4=1:1:4 S RGZ6=$E(RGZ,RGZ3#64+2)_RGZ6,RGZ3=RGZ3\64
 . S RGZ7=RGZ7+1
 . S ^SORT($J,"ENCODE",RGZ7)=RGZ6
 S RGZ2=$L(X)#3
 S:RGZ2 RGZ1=^SORT($J,"ENCODE",RGZ7),RGZ3=$L(RGZ1),$E(RGZ1,RGZ3-2+RGZ2,RGZ3)=$E("==",RGZ2,2),^SORT($J,"ENCODE",RGZ7)=RGZ1
 S RGZ="" F  S RGZ=$O(^SORT($J,"ENCODE",RGZ)) Q:RGZ=""  d ReturnStream.Write(^(RGZ))
 K ^SORT($J,"ENCODE")
 Q ReturnStream
 
DECODE(X) ;
 N RGZ,RGZ1,RGZ2,RGZ3,RGZ4,RGZ5,RGZ6
 S RGZ=$$INIT,RGZ1=""
 F RGZ2=1:4:$L(X) D
 . S RGZ3=0,RGZ6=""
 . F RGZ4=0:1:3 D
 . S RGZ3=0,RGZ6=""
 . F RGZ4=0:1:3 D
 .. S RGZ5=$F(RGZ,$E(X,RGZ2+RGZ4))-3
 .. S RGZ3=RGZ3*64+$S(RGZ5<0:0,1:RGZ5)
 . F RGZ4=0:1:2 S RGZ6=$C(RGZ3#256)_RGZ6,RGZ3=RGZ3\256
 . S RGZ1=RGZ1_RGZ6
 Q $E(RGZ1,1,$L(RGZ1)-$L(X,"=")+1)
  
INIT() Q "=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
.
TAKEnotMarked(nm,type,formNumber) ;return a list of id's matching the third "***"-delimited piece
 ;retuns all that has null in third piece
 n dt,tm,lst,cntr,res,no,tag
 s dt=0
 s lst=$LB(""), cntr=0 
 
 While '(dt="")
 {
         S dt=$O(^EISCP(dt))
         if '(dt="")
         {
         s tm=0  
         While '(tm="") 
                {        
                 s tm=$O(^EISCP(dt,tm))
                 if '(tm="")
                        {
                         s no=0
                         While '(no="") & (cntr<nm)
                         {
                                s no=$O(^EISCP(dt,tm,no))
                                if no'=""
                                {
                                        s val=$G(^EISCP(dt,tm,no))
                                        s res=dt_":"_tm_":"_no 
.
                                        s tag=$P(val,"***",3)
                                        s frmNum=$P(val,":",2)
                                        if (tag="") ; return anything that is empty
                                        {
                                                if (frmNum=formNumber)
                                                {
                                                        s cntr=cntr+1
                                                        s $LIST(lst,cntr)=res
                                                }
                                        }
                                }
                         }
                        }
                }
         }
 }
 q lst
  
TAKENUM(nm,type,formNumber) ;return a list of id's matching the third "***"-delimited piece
 ;type choices are: "SCH","ERR","COMPL", "RESCH" for RESCH return any non-empty tag
 n dt,tm,lst,cntr,res,no,tag
 s dt=0
 s lst=$LB(""), cntr=0 
 
 While '(dt="")
 {
         S dt=$O(^EISCP(dt))
         if '(dt="")
         {
         s tm=0  
         While '(tm="") 
                {        
                 s tm=$O(^EISCP(dt,tm))
                 if '(tm="")
                        {
                         s no=0
                         While '(no="") & (cntr<nm)
                         {
                                s no=$O(^EISCP(dt,tm,no))
                                if no'=""
                                {
                                        s val=$G(^EISCP(dt,tm,no))
                                        s res=dt_":"_tm_":"_no 
 
                                        
                                        s tag=$P(val,"***",3)
                                        s frmNum=$P(val,":",2)
                                        if (tag=type) || ((tag'="")&&(type="RESCH")) ; for RESCH return anything not empty
                                        {
                                                if (frmNum=formNumber)
                                                {
                                                        s cntr=cntr+1
                                                        s $LIST(lst,cntr)=res
                                                }
                                        }
                                }
                         }
                        }
                }
         }
 }
 ;w !,"in TAKENUM "_"len of list "_$LISTLENGTH(lst),!
 q lst
 
PROCESSLIST(usr,pwd,cmd,howMany,formNumber)
  s res="" s tp="SCH" ; take files marked "SCH" from the oldest of EISCP global and submit, "TAKE" 
  if cmd="TAKE2" s tp="COMPL"   ; take those marked "COMPL" and submit
  if cmd="TAKE3" s tp="ERR"             ; take those marked "ERR" and submit
  if cmd="TAKE4" s tp="PROC"    ; take those marked "PROC" and submit
  if cmd="RESCH" s tp="RESCH"   ; take anything marked, do not submit, just reset status to "SCH"
  if cmd="CLSCH" s tp="SCH"     ; take anything marked SCH, do not submit, just reset status to null
.
  if (cmd ="SCHALL")  { ; reset all not marked to SCH
           s lst1=$$TAKEnotMarked(howMany,tp,formNumber) ;returns a list
  } else {
           s lst1=$$TAKENUM(howMany,tp,formNumber) ;returns a list
  }   
  
  SET ptr=0,count=0
  FOR i=1:1:$LISTLENGTH(lst1) {
        SET value=$LIST(lst1,i)
    n itm3 
    if value'="" { 
        
        SET count=count+1
                
            if (cmd="RESCH") {
                    s itm3="^EISCP("_$TR(value,":",",")_")" 
                    s $P(@itm3,"***",3)="SCH"
                    s res=res_"1|"_value_" reset to SCH"_$CHAR(9)
            }   
            elseif (cmd="CLSCH") {
                    s itm3="^EISCP("_$TR(value,":",",")_")" 
                    s $P(@itm3,"***",3)=""
                    s res=res_"1|"_value_" reset to null"_$CHAR(9)
            }
            elseif (cmd="SCHALL") {
                    s itm3="^EISCP("_$TR(value,":",",")_")" 
                    s $P(@itm3,"***",3)="SCH"
                    s res=res_"1|"_value_" reset to SCH from null"_$CHAR(9)
            }
            else {
                s sent=$$SUBM(usr,pwd,value)
                s res=res_sent_$CHAR(9)
                }
                }
 }
  
  if (count=0) {
           s ^DEBUG("AUTO","SUBM","1.1")=$H_":"_$ZD($H,5)_"  "_$ZT($P($H,",",2),3)_" usr: "_usr_" form:"_formNumber_" *** NO FILES PREPARED at this time *** "_"  "_cmd
  } 
  else {
           s ^DEBUG("AUTO","SUBM","1.1")=$H_":"_$ZD($H,5)_"  "_$ZT($P($H,",",2),3)_" usr: "_usr_" form:"_formNumber_" *** NUMBER of FILES: "_count_"  *** "_cmd
  }
    
 q res
 
RECV(usr,pwd,InsProg) ;VB ;MODNEIX download reports,make file, copy into \claims folder
 
 n msgType,tag,fileForServer,store,res
 s msgType="MCD" 
 s tag="recv"
 s fileForServer="neix5.rpt"
 s store="^EMDREP"
 
 s res=$$EMDEONFILES(usr,pwd,InsProg,msgType,tag,fileForServer,store)
 
 q res
 
XBS(usr,pwd,ent,post,finCode) ;VB 
 s res="not yet"
 n msgType, tempFileName,tmp,client,res
 s msgType="XBS" 
 s tag="XBS"
 
 s InsProg="XBS"
 s fileForServer="EOBLITE.txt"
 
 s store="^EMDXBS"
 s res=$$EMDEONFILES(usr,pwd,InsProg,msgType,tag,fileForServer,store)
 
 if '($P(res,"|",1)=1) q res ; no file received or error
 ;import XBS file now
 D INT^%DIR,NSP^%DIR
 s FILEP=%SYSDIR_"claims"_DELIM_fileForServer ; "neix.pay"
 s PROGRAM=InsProg ;"MODNEIX"
 s EZ=ent
 ;s FORM=insForm ; ^SETFRMG(ent,1) piece 12
 s ZAA02GVB=1
 
 n filesBefore,filesAfter,newFiles
 s filesBefore=$ZP(^EOBL(ent,""))
 
 s ER=""
 s MSG=""
 s WRITEOFF=0
 n z
 s z=$I
 d BEG^EOBL
 U z
 s filesAfter=$ZP(^EOBL(ent,""))
 s newFiles=filesAfter-filesBefore ; possibly that many, or not, if some failed
 n thisFile,tempList
 s tempList=""
 ; process recon
 
 s msg1="File imported: "_filesAfter
 if (newFiles>1) { s msg1="New files imported: "_(filesBefore+1)_" - "_filesAfter }
 i '$g(post) q res_"|"_msg1_"."
.
 s OPZ="SY"
 s IO=$I
 s Q=1 ; $C(27)
 s NAME="Emdeon Bundle"
 s incr=0 s tg=$P($H,",",1)_"-"_$P($H,",",2)
 
 n c1,c2,c3,c4, ex1 //fin codes, excel file
 ;s c1=$P($G(^MSCG("RECONCIL",insForm)),":",1)
 ;s c2=$P($G(^MSCG("RECONCIL",insForm)),":",2)
 ;s c3=$P($G(^MSCG("RECONCIL",insForm)),":",3)
 ;s c4=$P($G(^MSCG("RECONCIL",insForm)),":",4)
 n makeExcel s makeExcel=0
 //finCodes will come from params
 ;if ($Length($G(finCodes))>3) // not ":::" delims only
 ; {
        ;s c1=$P(finCodes,":",1)
        ;s c2=$P(finCodes,":",2)
        ;s c3=$P(finCodes,":",3)
        ;s c4=$P(finCodes,":",4)
        ;s makeExcel=+($P(finCodes,":",5))
        ;s ^DEBUG("WEBRECON-1a")=$H_" finCodes from params "_c1_":"_c2_":"_c3_":"_c4
        ;s ^DEBUG("WEBRECON-1a-excel")=$H_" make excel "_makeExcel
 ;}
 
 ;else {  
         ;s ^DEBUG("WEBRECON-1b")=$H_" finCodes from ^MSCG "_c1_":"_c2_":"_c3_":"_c4
 ;} 
 
 ;n c5 
 ;s c5=$P(finCodes,":",6)
 
 s ^LPT(700)="FILE"  ; create fake printer
 s ^LPT(700,1)="5:::::::::::::::::::-UNKNOWN:U"
 
 n fl1,flList s flList="" 
 s fl1=filesBefore 
 for { 
         s fl1=$O(^EOBL(ent,fl1))
         i fl1="" q
         i fl1>filesAfter q ; should not happen
         s flList=flList_fl1_$C(230)
        }
 
 //make a list of file numbers to process for Excel, $C(230) delimited
 if (makeExcel)
 {
        s ZAA02GVB("EXCELP")=1
        s ZAA02GVB("DATA")=flList
 }
 
 s thisFile=filesBefore s tempList=""
 for  {          ;d LOGALL^UTILS("WEBCLAIMS_LOOP",thisFile)
         s thisFile=$O(^EOBL(ent,thisFile)) ;next created index  
         i thisFile="" q
         i thisFile>filesAfter q ; should not happen
         s tempList=tempList_thisFile_","
         s incr=incr+1
         s fnm=tg_"-"_incr_"-"_"eobl.txt"
 
         k ZAA02GVB("msg")
         
         ;set up vars for MEDICS
         s FILESEL=thisFile
         s ZAA02GVB("MODE")=2
         s ZAA02GVB("OPT")="P"
         ;s C1=c1 s C2=c2 s C3=c3 s C4=c4 
         s ZAA02GVB("C1")=finCode ;s ZAA02GVB("C2")=c2 s ZAA02GVB("C3")=c3 s ZAA02GVB("C4")=c4
         s ZAA02GVB=thisFile_":P"
         s ZAA02GVB("ENT")="A^,,"
         s ZAA02GVB("PV")="A^,,"
         s ZAA02GVB("PRINT")="A"
         s ZAA02GVB("FLAG")=1
         s ZAA02GVB("OPT")="P"
         s ZAA02GVB("RTN")="MODNEIX"
         s ZAA02GVB("SVDT")=""
         s ZAA02GVB("VAL")=""  ; second time this is changed to "RUN"
         s ZAA02GVB("LAST")=0  ; second time this is changed to 1 ?
         s ZAA02GVB("PRINTER")="700="_fnm
         
         s z=$i
         d
         . n z
         . D ZAA02GVB^EOBL
         . q
         u z
         
         k ZAA02GVB("msg")
          ;set up vars for MEDICS
         s FILESEL=thisFile
         s ZAA02GVB("MODE")=2
         s ZAA02GVB("OPT")="P"
         ;s C1=c1 s C2=c2 s C3=c3 s C4=c4 
         s ZAA02GVB("C1")=finCode ;s ZAA02GVB("C2")=c2 s ZAA02GVB("C3")=c3 s ZAA02GVB("C4")=c4
         s ZAA02GVB=thisFile_":P"
         s ZAA02GVB("ENT")="A^,,"
         s ZAA02GVB("PV")="A^,,"
         s ZAA02GVB("PRINT")="A"
         s ZAA02GVB("FLAG")=1
         s ZAA02GVB("OPT")="P"
         s ZAA02GVB("RTN")="MODNEIX"
         s ZAA02GVB("SVDT")=""
         s ZAA02GVB("VAL")="RUN"  ; second time this is changed to "RUN"
         s ZAA02GVB("LAST")=1  ; second time this is changed to 1 ?
         s ZAA02GVB("PRINTER")="700="_fnm
         
         s z=$i
         d
         . n z
         . D ZAA02GVB^EOBL
         . q
         u z
         
         n z1234
         s z1234=$I
         
         ;if SW=0 D ^EISXI3 ; do this if not SW
         U z1234
 
         ;make message string
         n m1 s m1=0 n msgs s msgs=""
         f {s m1=$O(ZAA02GVB("msg",m1))
                i m1="" q
                s msgs=msgs_$C(9)_ZAA02GVB("msg",m1)
         }
         ; move printout file into the global and delete file
         d moveRec(fnm,msgs,$na(^EOBLHIST(ent,thisFile) ) )
 }
 k ^LPT(700) ; kill fake printer
 
 s res="0 |"
 i ($G(ER)="") & ($G(MSG)="") s res="1|patient pay received, new files loaded: "_tempList q res 
 
 s res="0|"_$G(ER)_" "_$G(MSG) q res
 q
.
moveRec(fileName,msg,global) ;store printout into the global, delete file
 n dt,readfile,c1
 s dt="" s c1=0
 ;s readfile=##class(%IO.FileStream).%New()
 D INT^%DIR,NSP^%DIR
 
 ;there is a switch MSCG("ADDSUBDIR") to use \clams folder instead
 n reportFile s reportFile=%SYSDIR_fileName 
 if $D(^MSCG("ADDSUBDIR")) s reportFile=%SYSDIR_"claims\"_fileName 
 s readfile=##class(%Library.File).%New(reportFile)
 
 Do readfile.Open("R") 
 
 if readfile.SizeGet()
 {
        s @global=$H_":"_msg
 }
                                 
  While 'readfile.AtEnd
 {
        s dt=readfile.Read(30000)
        s c1=c1+1
        s @global@(c1)=dt
        }
 Do readfile.Close()
 D ##class(%File).Delete(reportFile)
 q
.
RECON(usr,pwd,InsProg,ent,insForm,finCodes) ;VB 
 n msgType, tempFileName,tmp,client,res
 s msgType="ERA" 
 s tag="recon"
 
 s fileForServer="neix.pay"
 if (InsProg="MODUBX") s fileForServer="ubx.pay"
 
 s store="^EMDREC"
 s res=$$EMDEONFILES(usr,pwd,InsProg,msgType,tag,fileForServer,store)
 
 if '($P(res,"|",1)=1) q res ; no file received or error
 
 ;import recon file now
 D INT^%DIR,NSP^%DIR
 s FILEP=%SYSDIR_"claims"_DELIM_fileForServer ; "neix.pay"
 s PROGRAM=InsProg ;"MODNEIX"
 s EZ=ent
 s FORM=insForm ; ^SETFRMG(ent,1) piece 12
 s ZAA02GVB=1
 
 n filesBefore,filesAfter,newFiles
 s filesBefore=$ZP(^MODRECL(ent,insForm,""))
 
 s ER=""
 s MSG=""
 s WRITEOFF=0
 n z
 s z=$I
 s xxx=$ZT
 s $ZT="next"
 d BEG^EISXI    
next s $ZT=xxx  i $ZE'=""!($g(ER)'="") s ^DEBUG("SCH","T",$P($H,",",1),"ERROR",$P($H,",",2))=$ZE_" ;; "_$G(ER)
 U z
 s filesAfter=$ZP(^MODRECL(ent,insForm,""))
 s newFiles=filesAfter-filesBefore ; possibly that many, or not, if some failed
 n thisFile,tempList
 s tempList=""
 ; process recon
 
 if ($G(finCodes))="DONOTPROCESS" { 
        s msg1="File imported: "_filesAfter
        if (newFiles>1) { s msg1="New files imported: "_(filesBefore+1)_" - "_filesAfter }
        q res_"|"_msg1_"."
 }
 
 ;TEST1 ; go here directly to step through recon processing
 ;      ; commented out
 ;s insForm=5 s InsProg="MODNEIX"
 ;s filesBefore=33
 ;s filesAfter=39
 ;s ent=1
 ;s EZ=ent s FORM=5 s PROGRAM=InsProg
 ;      ; end of commented out  
        
 s OPZ="SY"
 s IO=$I
 s Q=1 ; $C(27)
 s NAME="Emdeon Bundle"
 s incr=0 s tg=$P($H,",",1)_"-"_$P($H,",",2)
 
 n c1,c2,c3,c4,ex1,c5,c6,c7,c8 //fin codes, excel file
 s c1=$P($G(^MSCG("RECONCIL",insForm)),":",1)
 s c2=$P($G(^MSCG("RECONCIL",insForm)),":",2)
 s c3=$P($G(^MSCG("RECONCIL",insForm)),":",3)
 s c4=$P($G(^MSCG("RECONCIL",insForm)),":",4)
 s c5=$P($G(^MSCG("RECONCIL",insForm)),":",5)
 s c6=$P($G(^MSCG("RECONCIL",insForm)),":",6)
 s c7=$P($G(^MSCG("RECONCIL",insForm)),":",7)
 s c8=$P($G(^MSCG("RECONCIL",insForm)),":",8)
 
 
 n makeExcel s makeExcel=0
 //finCodes will come from params
 if ($Length($G(finCodes))>3) // not ":::" delims only
  {
        s c1=$P(finCodes,":",1)
        s c2=$P(finCodes,":",2)
        s c3=$P(finCodes,":",3)
        s c4=$P(finCodes,":",4)
        s makeExcel=+($P(finCodes,":",5))
        s c5=$P(finCodes,":",6)
        s c6=$P(finCodes,":",7)
        s c7=$P(finCodes,":",8)
        s c8=$P(finCodes,":",9)
 }
 
 else {  
         s ^DEBUG("WEBRECON-1")=$H_" finCodes were taken from ^MSCG only "_c1_":"_c2_":"_c3_":"_c4_":"_c5_":"_c6_":"_c7_":"_c8
 } 
 
 s ^DEBUG("WEBRECON-1a")=$H_" finCodes c1="_c1_": c2="_c2_": c3="_c3_": c4="_c4_": c5="_c5_": c6="_c6_": c7="_c7_": c8="_c8
 s ^DEBUG("WEBRECON-1a-excel")=$H_" make excel = "_makeExcel
 
 s ^LPT(700)="FILE"  ; create fake printer
 s ^LPT(700,1)="5:::::::::::::::::::-UNKNOWN:U"
 
 n fl1,flList s flList="" 
 s fl1=filesBefore 
 for { 
         s fl1=$O(^MODRECL(ent,insForm,fl1))
         i fl1="" q
         i fl1>filesAfter q ; should not happen
         s flList=flList_fl1_$C(230)
        }
 
 //make a list of file numbers to process for Excel, $C(230) delimited
 if (makeExcel)
 {
        s ZAA02GVB("EXCELP")=1
        s ZAA02GVB("DATA")=flList
 }
 
 s thisFile=filesBefore s tempList=""
 for  {          ;d LOGALL^UTILS("WEBCLAIMS_LOOP",thisFile)
         s thisFile=$O(^MODRECL(ent,insForm,thisFile)) ;next created index  
         i thisFile="" q
         i thisFile>filesAfter q ; should not happen
         s tempList=tempList_thisFile_","
         s incr=incr+1
         s fnm=tg_"-"_incr_"-"_"recon.txt"
 
         k ZAA02GVB("msg")
         
         ;set up vars for MEDICS
         s FILESEL=thisFile
         s ZAA02GVB("MODE")=2
         s ZAA02GVB("OPT")="P"
         ;s C1=c1 s C2=c2 s C3=c3 s C4=c4 
         s ZAA02GVB("C1")=c1 s ZAA02GVB("C2")=c2 s ZAA02GVB("C3")=c3 s ZAA02GVB("C4")=c4 s ZAA02GVB("C5")=c5 s ZAA02GVB("C6")=c6 
         s ZAA02GVB("C7")=c7 s ZAA02GVB("C8")=c8
         s ZAA02GVB=thisFile_":P"
         s ZAA02GVB("ENT")="A^,,"
         s ZAA02GVB("PV")="A^,,"
         s ZAA02GVB("PRINT")="A"
         s ZAA02GVB("FLAG")=1
         s ZAA02GVB("OPT")="P"
         s ZAA02GVB("RTN")="MODNEIX"
         s ZAA02GVB("SVDT")=""
         s ZAA02GVB("VAL")=""  ; second time this is changed to "RUN"
         s ZAA02GVB("LAST")=0  ; second time this is changed to 1 ?
         s ZAA02GVB("PRINTER")="700="_fnm
         
         D TEMPRECON
         
         k ZAA02GVB("msg")
          ;set up vars for MEDICS
         s FILESEL=thisFile
         s ZAA02GVB("MODE")=2
         s ZAA02GVB("OPT")="P"
         ;s C1=c1 s C2=c2 s C3=c3 s C4=c4 
         s ZAA02GVB("C1")=c1 s ZAA02GVB("C2")=c2 s ZAA02GVB("C3")=c3 s ZAA02GVB("C4")=c4 s ZAA02GVB("C5")=c5 s ZAA02GVB("C6")=c6 
         s ZAA02GVB("C7")=c7 s ZAA02GVB("C8")=c8
         s ZAA02GVB=thisFile_":P"
         s ZAA02GVB("ENT")="A^,,"
         s ZAA02GVB("PV")="A^,,"
         s ZAA02GVB("PRINT")="A"
         s ZAA02GVB("FLAG")=1
         s ZAA02GVB("OPT")="P"
         s ZAA02GVB("RTN")="MODNEIX"
         s ZAA02GVB("SVDT")=""
         s ZAA02GVB("VAL")="RUN"  ; second time this is changed to "RUN"
         s ZAA02GVB("LAST")=1  ; second time this is changed to 1 ?
         s ZAA02GVB("PRINTER")="700="_fnm
         
         D TEMPRECON
         
         n z1234
         s z1234=$I
         
         if SW=0 D ^EISXI3 ; do this if not SW
         U z1234
 
         ;make message string
         n m1 s m1=0 n msgs s msgs=""
         f {s m1=$O(ZAA02GVB("msg",m1))
                i m1="" q
                s msgs=msgs_$C(9)_ZAA02GVB("msg",m1)
         }
         ; move printout file into the global and delete file
         d MOVEREC(fnm,ent,insForm,thisFile,msgs)
 }
 k ^LPT(700) ; kill fake printer
 
 s res="0 |"
 i ($G(ER)="") & ($G(MSG)="") s res="1|recon received, new files loaded: "_tempList q res 
 
 s res="0|"_$G(ER)_" "_$G(MSG)_" ; file list: "_tempList q res
 q
 
MOVEREC(fileName,entity,formNumber,fileNum, msg) ;store printout into the global, delete file
 n dt,readfile,c1
 s dt="" s c1=0
 ;s readfile=##class(%IO.FileStream).%New()
 D INT^%DIR,NSP^%DIR
 
 ;there is a switch MSCG("ADDSUBDIR") to use \clams folder instead
 n reportFile s reportFile=%SYSDIR_fileName 
 if $D(^MSCG("ADDSUBDIR")) s reportFile=%SYSDIR_"claims\"_fileName 
 s readfile=##class(%Library.File).%New(reportFile)
 
 Do readfile.Open("R") 
 
 if readfile.SizeGet()
 {
        s ^MODRECHIST(entity,formNumber,fileNum)=$H_":"_msg
 }
                                 
  While 'readfile.AtEnd
 {
        s dt=readfile.Read(30000)
        s c1=c1+1
        s ^MODRECHIST(entity,formNumber,fileNum,c1)=dt
        }
 Do readfile.Close()
 D ##class(%File).Delete(reportFile)
 q
        
TEMPRECON   
 n z222
 s z222=$I
 d ZAA02GVB^EISXI
 U z222
 q
.
errorGetFile
 S (errDescr,err)="" 
 //D DecomposeStatus^%apiOBJ(%objlasterror,.err,"-d") 
 //For i=1:1:err { Set errDescr=errDescr_err(i) } 
 S $ZT=""
 I ($ZE["ZSOAP") {
        D $system.OBJ.DisplayError(%objlasterror) 
        D DecomposeStatus^%apiOBJ(%objlasterror,.err,"-d")
        For i=1:1:err { Set errDescr=errDescr_err(i) }
 } 
 ELSE {   
        S errDescr=$ZE
 }
 
 s respCode="ITS"
 s respMsg="ITS CONNECTION "_errDescr
 s ^DEBUG("SCH","T",$P($H,",",1),$P($H,",",2),"ERRGETFILE")=respCode_" "_respMsg
.
 q "0|"_respCode_$C(9)_respMsg
 
EMDEONFILES(usr,pwd,InsProg,msgType,tag,fileForServer,store) ; set store="" to not log into the global otherwise store="^EISCPREP" or smth
 ;download, unzip,concatenate into \claims folder 'fileForServer', copy data into global 
.
 s ^DEBUG("SCH","T",$P($H,",",1),$P($H,",",2),"EMD1")=usr_" "_InsProg_" "_msgType_" "_tag_" "_fileForServer
 
 n tempFileName,tmp,client
 s tmp=$P($ZV,") ",2)
 
 s oldErrHandler=$zt
 s $zt="errorGetFile"
 
 s client=##class(ITSWS.ITSWSSoap5Stream).%New()
 s client.Timeout=$$GetTm()
.
 s resp=client.GetFile(usr,pwd,msgType) I tag="XBS"
 s $zt=oldErrHandler
.
 s fileLen=0
 ;set test=1 to use testfile.zip in namespace folder and do not delete after unzipping
 ;this is to pretend we just received RECON file from emdeon
 
 D INT^%DIR,NSP^%DIR ; get %SYSDIR populated
 
 s test=0
 if $D(^DEBUG("testfile.zip")) s test=1
 i (test) ;do not read response, assume file received always
                  ;copy it to %SYSDIR folder
 {
         s tempFileName=tag_"-testfile.zip" ; "recon-testfile.zip" or "recon-tesfile.zip"
 }
 else ;this is production
 {
    s ^DEBUG("SCH","T",$P($H,",",1),$P($H,",",2),"EMD2")="response code: "_resp.ErrorCode 
.
        i resp.ErrorCode q 0_"|"_resp.Response.Read()_" ("_resp.ErrorCode_")"
 
        s tempFileName=InsProg_"-"_tag_"-"_$P($H,",",2)_".zip"
        
        s ^DEBUG("tempFileName")=%SYSDIR_tempFileName
 
        Set file=##class(%Library.File).%New(%SYSDIR_tempFileName)
        d file.Open("WNS")
        Do resp.Response.Rewind()
        While ('resp.Response.AtEnd) {
        s line=resp.Response.Read()
        d file.Write($$DECODE(line))
        }
        set fileLen = file.SizeGet()
        do file.Close()
 
        Do resp.Response.%Close()
        if ('fileLen) {
        do ##class(%Library.File).Delete(%SYSDIR_tempFileName) 
        q 0_"|No data received"
        }
 }
 
  s ^DEBUG("SCH","T",$P($H,",",1),$P($H,",",2),"EMD3")="file size: "_$G(fileLen)
.
 
 ;find location of 7z.exe and run unzip
 S UNIX=$S($ZV["UNIX":1,1:0),DELIM=$S(UNIX:"/",1:"\")
 
 //make a copy with a timestamp for checking
 if ($G(^MSCG("AUTORECON","KEEPFILE"))="1")
        {
                n copyOK n tm1
                s copyOK=0 s tm1=$ZD($H,3)_"-"_$TR($ZT($P($H,",",2),3),":","_")_"_"
                s a=##class(%Library.File).CreateDirectory(%SYSDIR_"recon_copy")
                s copyOK=##class(%Library.File).CopyFile(%SYSDIR_tempFileName,%SYSDIR_"recon_copy\"_tm1_tempFileName)
                //w "copy ok "_copyOK_" ? "
        }
        
 D INT^%DIR,NSP^%DIR S NUM=$L(%SYSDIR,DELIM)
 S PATH=$P(%SYSDIR,DELIM,1,NUM-3)
 s unzipDirName=%SYSDIR_tag_DELIM
 
 n lstold 
 s lstold=$$ListFilesInDir(unzipDirName,"*.*") ; kill old recv directory
 d DeleteFiles(lstold) ; attempt to clean up directory, folders with files might not be killed
                ; do ##class(%File).RemoveDirectoryTree(unzipDirName) ; kill old recv directory
 
 s command=PATH_DELIM_"ads"_DELIM_"7z e "_%SYSDIR_tempFileName_" -o"_unzipDirName_" -y" 
 s t = $ZF(-1, command)
 if '(test) 
 {       do ##class(%Library.File).Delete(%SYSDIR_tempFileName) }
 
 i t q 0_"|Unable to unzip received file"
 
 ;FileList
 n fls,AllFiles,f,count, count1, fcase,resFileLen
 s AllFiles="" s fls="" s f="" s count=0 s count1=0 s flcase=""
 
 s lc="abcdefghijklmnopqrstuvwxyz",uc="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 ;H 60
 
 s resFileName=$P($H,",",1)_"-"_$P($H,",",2)_"-"_fileForServer
 s resFile=##class(%Library.File).%New(%SYSDIR_resFileName)
 s resDirectory=%SYSDIR
 d resFile.Open("WNS")
 s ^DEBUG("readingfile")=$H_" --- "
 n lstnew
 s lstnew=$$ListFilesInDir(unzipDirName,"*.*")
 
 FOR i=1:1:$LISTLENGTH(lstnew) 
 {
         s f=$LIST(lstnew,i)
         if $L(f){ 
                        s count=count+1
                        s fcase=$tr(f,lc,uc)
                        
                        i '(fcase["zzMCDPRD.ACKN")  ;if contains this ignore file todotodo, willremove later
                        {
                                S X="S cnt=$O("_store_"(""""),-1)+1"  ; 
                                X X
                                
                                S fls=fls_f_$CHAR(10)_$CHAR(13) s count1=count1+1
                                
                                 n dt,readfile,c1
                                 s dt="" s c1=0
                                 ;s readfile=##class(%IO.FileStream).%New()
                                 s ^DEBUG("readingfile")= $G(^DEBUG("readingfile"))_" - "_f
                                 s readfile=##class(%Library.File).%New(f)
                                 
                                 n isdirectory s isdirectory=0
                                
                                 if $LENGTH($ZU(12,f,2))>0 s isdirectory=1
                         
                                 if 'isdirectory 
                                 {
                                        if $L(store) s @(store_"("_cnt_")")=$H ;s ^EISCPREP(cnt)= $H
                                        if $L(store) s @(store_"("_cnt_",0)")=InsProg_"|"_f ;s ^EISCPREP(cnt,0)=InsProg_"|"_f
                                 
                                        Do readfile.Open("R")
                                        While 'readfile.AtEnd
                                        {
                                                s dt=readfile.Read(30000)
                                                s c1=c1+1
                                                if $L(store) s @(store_"("_cnt_",1,"_c1_")")=dt  ;s ^EISCPREP(cnt,1,c1)=dt
                                                d resFile.Write(dt_$CHAR(10))
                                        }
 
                                        Do readfile.Close()
                                 }
                        }
                }
         }
 do resFile.Close() 
 set resFileLen=resFile.SizeGet()
 if (resFileLen>0)  ;copy to where we need it
 {
         s OK=##class(%Library.File).CopyFile(resDirectory_resFileName,%SYSDIR_"claims"_DELIM_fileForServer)
     i 'OK q 0_"|Unable to CopyFile to \claims directory" }
     
     //also copy to a recon_copy folder, with a timestamp
.
        if ($G(^MSCG("AUTORECON","KEEPFILE"))="1")
        {
                n copyOK2 n tm2 n copy2 
                s copyOK2=0 s tm2=$ZD($H,3)_"-"_$TR($ZT($P($H,",",2),3),":","_")_"_"
                s a2=##class(%Library.File).CreateDirectory(%SYSDIR_"recon_copy")
.
                s ext=".pay"
                if tag="recv" s ext=".rpt"
                s copy2=InsProg_"_"_$P($H,",",2)_ext
.
                s copyOK2=##class(%Library.File).CopyFile(resDirectory_resFileName,%SYSDIR_"recon_copy\"_tm2_copy2)
        }
.
   
  do ##class(%File).Delete(resDirectory_resFileName)
 
 n res
 s res="1| File: "_fileForServer_", sz: "_resFileLen_"|"_InsProg_" "_msgType_" "_tag_" "_fileForServer_" res file length "_resFileLen
 s res=res_$CHAR(10)_$CHAR(13)_" downloaded file len:" _fileLen_" folder:"_unzipDirName 
 s res=res_$CHAR(10)_$CHAR(13)_" all files count:"_count_$CHAR(10)_$CHAR(13)_" report files count:"_count1
 s res=res_$CHAR(10)_$CHAR(13)_" concatenated file length:"_resFileLen
 s res=res_$CHAR(10)_$CHAR(13)_" files excluding ACK files:"_$CHAR(10)_$CHAR(13)_fls
 q res
 
ListFilesInDir(dir,wildcards) ; returns list
 n unix,delim,rs,cntr,fullpath
 s fullpath=1
 s lst=$LB("") s cntr=0
 s unix=$s($zv["UNIX":1,1:0)
 s delim=$s(unix:"/",1:"\")
 if ($e(dir,$l(dir))=delim) {
  s dir=$e(dir,1,($l(dir)-1))
 }
 s rs=##class(%ResultSet).%New()
 s rs.ClassName="%File"
 s rs.QueryName = "FileSet"
 d rs.Execute(dir,wildcards,"",0)
 while (rs.Next(.sc)) {
  if ($SYSTEM.Status.IsOK(sc)) {
   s name=rs.Data("Name")
   if (fullpath) {
     s cntr=cntr+1
         s $LIST(lst,cntr)=name
   } else {
    s lc="abcdefghijklmnopqrstuvwxyz""",uc="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    s name=$p($tr(name,lc,uc),$tr(dir,lc,uc),2)
    if ($e(name)=delim) {
     s name=$e(name,2,$l(name))
    }
    
    s cntr=cntr+1
        s $LIST(lst,cntr)=name
   }
    }
 else {
  q 
 }
 }
 q lst
 
DeleteFiles(lst) ; files full paths are in the list
 n f
 FOR i=1:1:$LISTLENGTH(lst) 
 {
         s f=$LIST(lst,i)
         i $L(f) 
         {
                 if (##class(%File).DirectoryExists(f)) 
                 {d ##class(%File).RemoveDirectory(f)} ; attempt to remove a directory, will allow if empty
                 else
                 { s res=##class(%File).Delete(f)} ;attempt to delete a file
         }
 }
 q 
 
XBILL(user,pass) 
 n res
 s res="not implemented yet"
 q res
 
GETACK(id) ;VB; id="63638:49860:3"
 n res, id1, id2, id3
 s id1=$P(id,":",1) s id2=$P(id,":",2) s id3=$P(id,":",3)
 s res=""
 S ^AHM=id1_","_id2_","_id3
 s res=$G(^EISCPACK(id1,id2,id3))
 q res
 
getRelatedFolder(DT,TM,NO) ; from ^EISCP entry 
 n (DT,TM,NO)
 s data=^EISCP(DT,TM,NO)
 s form=$P(data,":",2)
 s ent=$P(data,":",1)
 s program=$P(data,":",3)
 s fileId=$P($P(^EISCP(DT,TM,NO,0,0),"^",4),":",2) 
 s fileId=$ZSTRIP(fileId,"*"," ")
 q $$getRelatedFolderName(DT,ent,form,program,fileId)
.
getRelatedFolderName(date,ent,form,program,fileId)
 n (date,ent,form,program,fileId)
 s fldr=$ZSTRIP($ZD(date,3),"*","-")_"-"_ent_"-"_form_"-"_program_"-"_fileId
 s fldrRoot=$$GetNamespaceFolder^ZAA02GUTILS2_"Encounters\"
 if $L($G(^MSCG("IHCFAFOLDER"))) {
         s fldrRoot=$$TranslateToFullPath^ZAA02GUTILS2(^MSCG("IHCFAFOLDER"))
 }
 d ##class(%Library.File).CreateDirectory(fldrRoot) ;will create root folder
 q fldrRoot_fldr
.
