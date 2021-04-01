ZAA02GDOWNLOAD ; Download report files ;2018-07-27 15:24:43
 ; ADS Corp. Copyright
 q
 ;
GetModule() q "ZAA02GDOWNLOAD" 
        ;
import ; ClassImport
        n
        ; needed for the pdf exe
        d Install^ZAA02GAAWEB("SHARED"),Source^ZAA02GAAWEB5("SHARED")
        q
        ;
        ;
SETFN ; ZAA02Gweb 
 N (%,RLC)
 n folder,filename
 s folder=$G(%("FORM","param1"))
 s filename=$G(%("FORM","param2"))
 if folder="" w "Parameters missing " k ^fnmd("download") q
 
 s rlc=$G(RLC) if rlc="" s rlc="0"
 s ^fnmd("download",rlc)=folder_filename
 s ^fnmd("download",rlc,"folder")=folder
 w folder_filename
 q
 
GETFN2 ; ZAA02Gweb   
 N (%,TYPE,OTHERMM)  // check ^fnmd("download",rlc) for one time use
.
        n data,readfile1,filenamepath           
        s soapParams=$G(%("FORM","DATA"))
        
    s rlc=$P(soapParams,"?",1)
        s data=$P(soapParams,"?",2)
        
        if ($L($G(data)))=0 w "File name not defined." q
.
        if rlc="" w "Handle invalid. " Q
.
        S filenamepath = $G(^fnmd("download",rlc,"folder"))_data
        if '($G(^fnmd("download",rlc))=filenamepath) w "Link expired. " Q
.
    if '( ##class(%File).Exists(filenamepath) ) w "File not found " Q
.
        s TYPE="application/x-unknown"  
        s OTHERMM=$G(OTHERMM)_"Content-Disposition: attachment; filename="""_data_""""_$C(13,10)
.
    k ^fnmd("download",rlc)
    D WriteOutTheFile^ZAA02GDOWNLOAD(filenamepath)
    
    q
    ;
    ;
pdfConverterExe()
        q ##class(%File).ManagerDirectory()_$SYSTEM.SYS.NameSpace()_"\"_"ZAA02Gaautil"_"\"_"shared"_"\"_"exe"_"\"_"txt2pdf.exe"
        ;
pdfConverterInstalled()
    q ##class(%File).Exists($$pdfConverterExe())
    ;
ConvertToPdf(file)
        ;
        n exe,bat,command,st
        s exe = $$pdfConverterExe() 
        s command = (exe_" """_file_""" """_file_".pdf"""_" "_"-pfs8 -pwa -ptm30 -pot")
        s st = $zf(-1,command)
        q st
        ;
        ;
GETFNPDF2 ; ZAA02Gweb   
 N (%,TYPE,OTHERMM)  // check ^fnmd("download",rlc) for one time use
 
        n data,readfile1,filenamepath           
        s soapParams=$G(%("FORM","DATA"))
.
        s rlc=$P(soapParams,"?",1)
        s data=$P(soapParams,"?",2)
        
        if ($L($G(data)))=0 w "File name not defined." q
.
        if rlc="" w "Handle invalid. " Q
.
        S filenamepath = $G(^fnmd("download",rlc,"folder"))_data
        if '($G(^fnmd("download",rlc))=filenamepath) w "Link expired. " Q
.
    if '( ##class(%File).Exists(filenamepath) ) w "File not found " Q
        ;
    k ^fnmd("download",rlc)
    ;
    d ConvertToPdf(filenamepath)
    ;
    i ##class(%File).Exists(filenamepath_".pdf") d
    . s TYPE="application/pdf"
        . s OTHERMM=$G(OTHERMM)_"Content-Disposition: attachment; filename="""_data_".pdf"_""""_$C(13,10)
    . D WriteOutTheFile^ZAA02GDOWNLOAD(filenamepath_".pdf")
    . d ##class(%File).Delete(filenamepath_".pdf")
    . i 1 
    e  w "Error: File not converted!"
    ;
    q
.
MakeFoldersArr2(outarr) //dropdown selection for copies of downloaded era files and uploaded submission files 
        n cnt,val,rptfolder s val="" s cnt=0 
.
        //get sysdir
        S UNIX=$S($ZV["UNIX":1,1:0),DELIM=$S(UNIX:"/",1:"\")
        D INT^%DIR,NSP^%DIR 
        s rptFolder=%SYSDIR_"recon_copy"_DELIM
.
        s cnt=cnt+1
        s outarr(cnt)=rptFolder_$C(9)_rptFolder
.
        s cnt=cnt+1
        s val=%SYSDIR_"claim_copy"_DELIM s outarr(cnt)=val_$C(9)_val
        
        s val=$G(^MSCG("AUTOSUBM","FOLDER"))                    //custom submitFileCopyFolder
        if $L(val) { 
                s cnt=cnt+1
                s val=$$TranslateToFullPath^ZAA02GUTILS2(val) s outarr(cnt)=val_$C(9)_val }
.
        s val=$G(^MSCG("AUTOSFTP","FOLDER_COPY")) 
        if $L(val)=0 s val="sftp_copy"                          
        if $L(val) { 
                s cnt=cnt+1
                s val=$$TranslateToFullPath^ZAA02GUTILS2(val) s outarr(cnt)=val_$C(9)_val }
.
        s val=$G(^MSCG("AUTOSFTP","FOLDER_FAILED"))                     
        if $L(val)=0 s val="sftp_failed"                        
        if $L(val) { 
                s cnt=cnt+1
                s val=$$TranslateToFullPath^ZAA02GUTILS2(val) s outarr(cnt)=val_$C(9)_val }
.
        //s val=$G(^MSCG("ADDFOLDER","SUB"))                    //additional folder allowed to access - no GUI to set intentionally
        //if $L(val) s outarr(cnt+1)=val_$C(9)_val
 q
.
MakeFoldersArr(outarr) //dropdown selection for report folders
        n op n cnt n val s val=""
        s op="" s cnt=0
    n rptFolder s rptFolder=$$GetReportsFolder^ZAA02GUTILS2() 
    
        //main reports folder is always item 1, displayed as default
        s cnt=cnt+1
        s outarr(cnt)=rptFolder_$C(9)_rptFolder
        
        s op=$O(^RPTSCH("FOLDER","EXCEL",op)) //go through scheduled reports folders
                while '(op="")
                {   
                        s val=$G(^RPTSCH("FOLDER","EXCEL",op))
                        if $L(val) s val=$$TranslateToFullPath^ZAA02GUTILS2(val) s cnt=cnt+1 s outarr(cnt)=val_$C(9)_val
                        s op=$O(^RPTSCH("FOLDER","EXCEL",op))
                }
        s val=$G(^RPTSCH("FOLDER","EXCEL"))
        if $L(val) s val=$$TranslateToFullPath^ZAA02GUTILS2(val) s outarr(cnt+1)=val_$C(9)_val
.
        //s val=$G(^MSCG("ADDFOLDER","RPT"))                    //additional folder allowed to access - no GUI to set intentionally
        //if $L(val) s outarr(cnt+1)=val_$C(9)_val
        
 q
 
FormatFileSize(sz)
 s sz=$G(sz)
         if (sz<=1000){s sz=sz_" B"}
         elseif (sz<1000000) {s sz=sz/1000 s sz=$J(sz,0,1)_" kB" }
         else {s sz=sz/1000000 s sz=$J(sz,0,1)_" MB"}
 q sz
 
FileNameMatch(filename,types)
        n res s res=0 n convval s convval=""
    s lc="abcdefghijklmnopqrstuvwxyz",uc="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    s convval=$tr(filename,lc,uc)
    if types="ERAFILEGET" { 
        if ($E(convval,($L(convval)-3),$L(convval))=".PAY") s res=1
        if ($E(convval,($L(convval)-3),$L(convval))=".RPT") s res=1
        if ($E(convval,($L(convval)-3),$L(convval))=".TXT") s res=1
        if ($E(convval,($L(convval)-3),$L(convval))=".PDF") s res=1
        if ($E(convval,($L(convval)-3),$L(convval))=".HL7") s res=1
    }
    else {   //RPTFILEGET
        if ($E(convval,($L(convval)-3),$L(convval))=".CSV") s res=1
        if ($E(convval,($L(convval)-3),$L(convval))=".OUT") s res=1
        if ($E(convval,($L(convval)-3),$L(convval))=".TXT") s res=1
        if ($E(convval,($L(convval)-3),$L(convval))=".PDF") s res=1
        if ($E(convval,($L(convval)-3),$L(convval))=".HL7") s res=1
    }
    
    if (convval="COLLECT.DAT") s res=1 //allow as this filename is hardcoded in multiple programs
.
 q res 
        
FILELIST ; ZAA02Gweb ;return : delimited file names , % delimited file size
 n sz,dtCr,dtMod,types s sz=0 s types="" s dtCr="" s dtMod=""
 s folder=$G(%("FORM","param1"))
 s types=$G(%("FORM","param2"))  // ERAFILEGET or RPTFILEGET
 s dbg=0 //set to 1 to see all files
 
 if '$L(folder) w "invalid folder" q
.
 s lstold=$$ListFilesInDir^ZAA02GEMD1(folder,"*.*") 
 s file1="" s DELIM="=" s cnt=0 s ptr=0
        
 s ptr=0 
 
 FOR i=1:1:$LISTLENGTH(lstold) 
 {
         s file1=$LIST(lstold,i)
         s file1=$P(file1,"\",$L(file1,"\"))     //get file name from full path
         
         if (dbg || $$FileNameMatch(file1,types)){  
                s sz=##class(%File).GetFileSize(folder_file1)
.
                s sz=$$FormatFileSize(sz)
                s dtMod=##class(%File).GetFileDateModified(folder_file1)
                s dtMod=$ZDATETIME(dtMod,3)
                s cnt=cnt+1 
                w file1_"%"_sz_" &nbsp &nbsp "_dtMod,DELIM
                }        
 } 
 q 
.
WriteOutTheFile(filepath) ; write out file contents 
     n (filepath)
     if '$L(filepath) w "Parameters missing" q
.
     s dt=""
     s readfile=##class(%FileCharacterStream).%New()
     s readfile.Filename=filepath
.
         if (readfile.SizeGet()<0)       {
                w "ERROR: ",!
                w "file '"_filepath_"'",! 
                w "was not found in specified location.",!
                q
         }
        
         While 'readfile.AtEnd   {
                s dt=readfile.Read(30000)
                w dt
         }
 q
 
WriteOutNoPermission(usr,action)
  s action=$G(action) s usr=$G(usr)
  w "<font color='steelblue' face='verdana' title='"_usr _" - "_action_"'><br>Access denied. <br>Please verify your security settings.</font>"
  q
WriteOutInvalidHandle()
  w "<font color='steelblue' face='verdana'><br>Access denied. <br>Invalid handle, user is not logged in.</font>"
  q
  
STREC ;ZAA02Gweb 
 n ReconFiles s ReconFiles=1
 
ST ;ZAA02Gweb 
 N (%,ReconFiles,RLC)
 s action=""
 s ReconFiles=$G(ReconFiles)
 
 s lc="abcdefghijklmnopqrstuvwxyz",uc="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 s usr  = $P($G(^ZAA02GVBUSER("WEB-LOGON",+$H,+$G(RLC)\1)),",",3)
 if $L(usr)=0 D WriteOutInvalidHandle Q
  
 //get sysdir
 S UNIX=$S($ZV["UNIX":1,1:0),DELIM=$S(UNIX:"/",1:"\")
 D INT^%DIR,NSP^%DIR 
 s folder=%SYSDIR
 
 if ($G(^MSCG("ADDSUBDIR"))) s folder=%SYSDIR_"claims"_DELIM
.
 s PageTitle="Report Files"
 s action="RPTFILEGET"
 s onload=" onload='doOnLoad()'"
 
 if ReconFiles { 
        s folder=%SYSDIR_"recon_copy"_DELIM
        s PageTitle="File tracking: claims, ERA, SFTP " 
        s action="ERAFILEGET"
        //s onload=""
 } 
 
 
 W "<!DOCTYPE HTML>",!
 W "<html>",!
 W "<head>",!
 W "<meta http-equiv=""X-UA-Compatible"" content=""IE=9"">",!
 D WRITESTYLES
 D WRITESCRIPT
 W "</head>",!
 
 W "<body"_onload_">",!
.
 W "<div><font face='verdana' size='2'>"_$ZDATETIME($H,5)_"</font></div>" ,!
 
 W "<div style='display:none;' id='rlcBox'>"_RLC_"</div>" ,!
 
 //check if pdf converter available
 s pdfOK=""
 if ( $$pdfConverterInstalled() ) s pdfOK="YES"
.
 W "<div style='display:none;' id='canConvertPDF'>"_pdfOK_"</div>" ,!
 
 
 //check user permission
 if '$L(usr)||'($P($G(^OPG(usr,action)),":",1)) D WriteOutNoPermission(usr,action) Q
.
 w "<div id='pgTitle' class='hdr1' title='"_folder_"'>"_PageTitle_"</div>",!
 
 W "<div class='msg4' hidden id='idReportsOnly'>"
 W " Accessible server folders "
        n arrList
        if ReconFiles { 
                D MakeFoldersArr2(.arrList) }
        else { 
                D MakeFoldersArr(.arrList) }
.
        n selItm s selItm=$P($G(arrList(1)),$C(9),1)
        W $$MakeDropdown^ZAA02GSETUTILS2("thisFolder",.arrList,selItm,"'setCurrentFolder()'",1) 
 W " </div>",!
.
 W "<div class='msg4'>"
 W " 1. Press 'See available files' to get a list.<br>"
 W " 2. Click on the file name to download.<br>"
 W " </div>",!
 
 W "<div><button class='btn' id='btndoCommand1' "
       W "onclick=loadList("
       W "document.getElementById('txt').value,'"_action_"')"
       W "> See available files </button>"
 
 W "  <input hidden readonly id='txt' type='textarea' value='"_folder_"' size=40/></div>"
 W "  <input hidden readonly id='ent' type='textarea' value='' size=40/>   "  
 W "  <br>"
 
.
  
 W " &nbsp  &nbsp<div id='waitmsg' class='msg1'> Downloading... Please wait.</div>",!
 W " &nbsp  &nbsp<div id='waitimage' class='wait1'><img src='BOOTSTRAP\CSS\IMAGES\AJAX-LOADER.GIF'> </div>",!
.
.
 W " </div>" 
 
 W " <br> <font face='verdana' size='2'> Selected: </font><div class='statusSelected' id='FileNameReadOnly'> none </div>",!
 
 w "<div id='renderList'></div>",!
 w "<div id='statusMsg'></div>",!
 W "</div>", ! 
 
 W "<p>",!
 W " <br><textarea style='display:none;' id='res1'> ...... </textarea> "  
.
 W "</body>"
 W "</HTML>"
 Q
  
WRITESCRIPT
 W "<script src=""../bootstrap/js/jquery.min.js""></script>" 
 W "<script>",!
 W "var PDFconverterInstalled = true;", !
loadList
 W "  function loadList(folder,types) { "
 w "  PDFconverterInstalled = (document.getElementById('canConvertPDF').innerHTML=='YES');  ", ! 
 
 W "            var longstr; longstr = CallCache('FILELIST^ZAA02GDOWNLOAD',folder,types,'','','','',''); ", !
 W "            fileList = longstr.split('=');  ",!
 
 W "            if (document.getElementById('flList')== null ) {;               ",!
 W "                    var ul = document.createElement('ul');                          ", !
 W "                    ul.setAttribute('id','flList');                                         ",!
 W "            } ",!
 
 W "            else {   ",!
 W "                    var ul=document.getElementById('flList'); ",!
 W "                    clearList(ul);   ",!
 W "            }                ",!
 
 W "            document.getElementById('renderList').appendChild(ul);    ",!
 
 W "        for (a in fileList) {  ", !
 W "                    var li = document.createElement('li');          " ,!
 W "                    li.setAttribute('class','item');                " ,!
 W "                    t = document.createTextNode(a);         " ,!
 W "                    var fn;  fn=fileList[a].split('%')[0];  ", !
 W "                    var fsz; fsz=fileList[a].split('%')[1]; ;",!
 W "                    var strLi; var strFn; strFn='\'' +fn +'\''; ",!
 W "                    var jscrQuote ='""'; ",!
.
 W "                    strLi=""<a href='#' onclick="" + jscrQuote + ""doDownload("" + strFn + "")"" + jscrQuote + "">"" + fn + '</a>' + '<span style=""color:steelblue"">&nbsp &nbsp &nbsp' + fsz + ' </span> ';       " ,!
.
 W " strPdfLinkAdd = ""&nbsp;&nbsp;&nbsp;<a href='#' onclick="" + jscrQuote + ""doDownloadPDF("" + strFn + "")"" + jscrQuote + "">"" + 'PDF' + '</a>'", !
 W " if (PDFconverterInstalled) strLi=strLi + strPdfLinkAdd ; ", !
 
 W "                    li.innerHTML=strLi;     if (fn!='') ul.appendChild(li); }  ", !
.
 W "            var tg=' files '; if ((fileList.length - 1)==1) tg=' file ' ;                                                                           ",!
 W "            reportData = fileList.length - 1 + tg +'available'; " ,!
 W "            document.getElementById('statusMsg').innerHTML = reportData; " ,!
 W "            document.getElementById('res1').value = reportData;   " ,!
 W "            if (window.frameElement){ parent.ResizeFrame(); }  " ,! //if runs in iFrame with id='frameX' will be resized
 W "   } "
 
clearList
 W "  function clearList(ul) {   ",!
 W "  if (ul == null) return; ",!
 W "  var last;   while (last = ul.lastChild) ul.removeChild(last);  ",!
 W "  };  ",!
 
 W " var IsWaiting ;", !
showWait
 W " function showWait(waiting) { " 
 W " IsWaiting=waiting;", !
 W " var st; st='hidden'; if (waiting) {st='visible'}  ", !
 W " document.getElementById('waitmsg').style.visibility=st;    ", !
 W " document.getElementById('waitimage').style.visibility=st;  }", !
  
setBox 
 W "   function setBox(filename) {  " 
 W "   document.getElementById('FileNameReadOnly').innerHTML=filename;; ", !
 W "   document.getElementById('ent').value=filename;   ", !
 W " } ", !
.
downloadFile // filename, convert 
 W "   function downloadFile(filename, convertToPdf) {  " 
       
 W "   setBox(filename);; ", !
 W "   folder = document.getElementById('thisFolder').value ; ", !
 
 W "   ok=confirm('Download \'' + filename  + '\'?'); if (!ok) return; ", !
 W "   res = CallCache('SETFN^ZAA02GDOWNLOAD',folder,filename,'','','','','');", !          //mark for download
 W "   if (res != (folder+filename) ) {alert(folder+filename + '\n not allowed.' + '\n' + res); return;}          ", !
.
 W "   var ses =document.getElementById('rlcBox').innerHTML; ", !
.
 W "   addr='GETFN2^ZAA02GDOWNLOAD?'+ ses + '?' + filename ; ", !
 W "   if (convertToPdf) addr='GETFNPDF2^ZAA02GDOWNLOAD?'+ ses + '?' + filename ; ", !
 
                //get one time use url
 W "    addr=getWebHandle2(addr,ses); ", !
.
 W "    window.location.href=addr;  ", !
 W " } ", !
.
doDownload 
 W "   function doDownload(filename) {  " 
 W "   downloadFile(filename,false); ",!
 W " }", !      
.
doDownloadPDF 
 W "   function doDownloadPDF(filename) {  " 
 W "   downloadFile(filename,true); ",!
 W " }", !        
.
.
getWebHandle2
 W " function getWebHandle2(url,hndl) {  ",!
 W " var link = CallCache('GETWEBHANDLE2^ZAA02GLINKS',url,hndl,'','','','',''); ", !
 W " var l = link.length; link=link.substring(10).substring(1,l-22);    ",! 
 W " return link;   ",!
 W " } "
 
doOnLoad
 W " function doOnLoad() { "
 W " document.getElementById('idReportsOnly').style.display='block' ;  ",!
 W " } ", !
 
setCurrentFolder
 W " function setCurrentFolder() { "
 W " document.getElementById('txt').value=document.getElementById('thisFolder').value ;  ",!
 W " document.getElementById('pgTitle').title=document.getElementById('thisFolder').value ;  ",!
 W " setBox(''); document.getElementById('FileNameReadOnly').innerHTML='none';",!
 W " document.getElementById('statusMsg').innerHTML = '';  ", !
 W " var ul=document.getElementById('flList'); ", !
 W " clearList(ul);} ", !
 
SCRIPTCOMMON
sendData 
 W "   function senddata(href, args)",!
 W "   {"
 W "    var ses=document.getElementById('rlcBox').innerHTML;  ", !
.
 W "    var req = new XMLHttpRequest();",!
 W "    var response = '';",!
 W "    req.onreadystatechange = function()",!
 W "       {if (req.readyState == 4)",!
 W "           {response = req.responseText;",!
 W "           }",!
 W "       };",!
 W "    req.open(""POST"", href, false);",!
 W "    req.setRequestHeader('SES',ses) ; ", !
 W "    if (args)",!
 W "       { //req.setRequestHeader(""Content-Type"", ""application/x-www-form-urlencoded"");",!
 W "         //req.setRequestHeader(""Content-Length"", args.length);",!
 W "        req.send(args);",!
 W "       }",!
 W "    else req.send(null);",!
 W "    return response;",!
 W "   }",! 
 
callCache               //call cache routine, routine name plus 7 params
 W "   function CallCache(url,param1,param2,param3,param4,param5,param6,param7)",!
 W "   {var params = ""param1="" + param1 + ""&param2="" + param2 + ""&param3="" + param3 + ""&param4="" + param4 + ""&param5="" + param5 + ""&param6="" + param6 + ""&param7="" + param7;",!
 W "    var resp='';",!
 W "    resp = senddata(url, params);",!
 W "    return resp;" ,!
 W "   }",!
.
 W "</script>",!
 
  
 Q
 
WRITESTYLES
 W "<style type='text/css'>"
 W "div{font-family:Verdana;font-size:small;}"
 W "input{font-family:Verdana;}"
 W "td{font-family:Courier New;font-size:small;}"
 W "button.btn {   background-color:lightsteelblue; padding:4px; font-size:small; font-family:Verdana;} "
 W "textarea { margin: 0; width:75%; padding: 0; border-width: 1; }"
 W "div.hdr1 {font-family: Verdana; text-align:center;line-height:40px;color:steelblue; width:100%;font-size:large;}",!
.
 W "div.statusSelected {margin: 5px; font-weight: bold; font-family: Verdana; padding:4px; font-size:small;color:white;background-color:lightsteelblue;}",!
 
 W "div.links {font-family: Verdana; font-size:small;}",!
 W "  ul#flList{list-style-position: inside} ",!
 W "  li.item{list-style:none; padding:2px;} ",!
 
 w "div.parent1 {position:relative;}",!
 W "div.msg1 {visibility:hidden;display:inline; color:red; position:absolute;left:240px;top:6px;}",!
 W "div.msg4 {color:steelblue; width:75%;  margin-left:0px; margin-bottom:20px;  }",! 
 W "div.wait1 {visibility:hidden;display:inline; position:absolute;top:-2;left:180px;}",!
 W "th {text-align:left; }",! 
 W "table {border-spacing:5px;}",!
 W "</style>",!
 Q
.
