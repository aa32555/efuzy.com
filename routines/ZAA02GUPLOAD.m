ZAA02GUPLOAD ; Download report files ;2018-03-26 13:28:10
 ; ADS Corp. Copyright
 q
STOREFILE ;ZAA02GWEB
 n (%,CON,CNT)
 s fname=$G(%("FORM","DATA"))
 s folder=$$GetUploadsFolder()
 s lc="abcdefghijklmnopqrstuvwxyz",uc="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 s errMsg=""
 s fcase=$tr(fname,lc,uc) 
 s bytesWritten=0
 s fromGlob =$D(%("WEBPUT"))
 
 s CONloc=+$G(CON) s CNTloc=+$G(CNT)
        //s ^DEBUG("SCH","T",$P($H,",",1),"storefile",CON,CNT)=$G(^DEBUG("SCH","T",$P($H,",",1),"storefile",CON,CNT))_"~"_$G(CON)_"-"_$G(CNT)_":"_fromGlob_":"_fname
 
 if (fcase="CACHE.DAT") s errMsg=" Invalid request. File name is not allowed."
 if '$L(folder)                 s errMsg=" Folder is not defined." 
 if 'fromGlob if '$L($G(%("BODY"))) s errMsg=" Invalid request. No file attached." ; if called directly
 
 s ^DEBUG("SCH","T",$P($H,",",1),"storefile","request1",$P($H,",",2))=CONloc_"-"_CNTloc_":"_fname
 
 d ##class(%Library.File).CreateDirectory(folder) ; attempt to create folder 
 if '(##class(%File).DirectoryExists(folder)) s errMsg=" requested folder '"_folder_"' is not available ."
.
 s ^DEBUG("SCH","T",$P($H,",",1),"storefile","request2",$P($H,",",2))=CONloc_"-"_CNTloc_":"_fname
 
 if ($L(errMsg))        {
         w "<font color='red'>ERROR: "_errMsg_"</font><br><br>",!
         s ^DEBUG("SCH","T",$P($H,",",1),"storefile","request2 ERROR MSG",$P($H,",",2))=CONloc_"-"_CNTloc_":"_fname_" "_errMsg
         q
 }
        s resFileName=folder_fname 
        s resFile=##class(%Library.File).%New(resFileName)
        d resFile.Open("WNS")
    s dt=""
        if fromGlob { 
                
                //start with ^ZAA02GWEBPUT(CON,1,6), excluding the last, and remove $C(13,10) from the end
                s n1=6 s n2=$O(^ZAA02GWEBPUT(CONloc,CNTloc,""),-1)-1
.
                if (n2<0) { 
                        s bytesWritten=0
                        w "<font color='darkred'> Connection error. Please try again.</font><br><br>",!
                        s ^DEBUG("SCH","T",$P($H,",",1),"storefile","request2 FAILED",$P($H,",",2))=CONloc_"-"_CNTloc_":"_fname
                        q
                }
                                for i=n1:1:n2-1
                        {  
                                s dt=^ZAA02GWEBPUT(CONloc,CNTloc,i)
                                s bytesWritten = bytesWritten + $L(dt)
                                d resFile.Write(dt)
                        } 
                        s dt=^ZAA02GWEBPUT(CONloc,CNTloc,n2)
                        if $E(dt,$L(dt)-1,$L(dt)) = $C(13,10) s dt=$E(dt,1,$L(dt)-2) //remove trailing $C(13,10) 
                        s bytesWritten = bytesWritten + $L(dt)
                        d resFile.Write(dt)
        }
        else { 
                s fdata=$G(%("BODY"))
                s tag=$P(fdata,$C(13,10),1)
                
                s fdata=$P(fdata,$C(13,10),5,$L(fdata,$C(13,10))) //remove first 4 pieces
                
                s z=$F(fdata,$C(13,10)_tag)
                if z s fdata=$E(fdata,1,z-$L($C(13,10)_tag)-1)
                s bytesWritten = bytesWritten + $L(fdata)
.
        d resFile.Write(fdata)
        }
     do resFile.Close() 
     
     W "<br><br><font color='green' size='3'> &nbsp &nbsp &nbsp*** File saved. ***</font><br><br>"_resFileName_" &nbsp &nbsp "_bytesWritten_" B", !
 
 s ^DEBUG("SCH","T",$P($H,",",1),"storefile","request3",$P($H,",",2))=CONloc_"-"_CNTloc_":"_fname
.
 Q
 ; 
 
MakeFoldersArrAll(outarr) 
        n cnt,val s val="" s cnt=0 
        
        s val=$$GetUploadsFolder()
        if $L(val) s outarr(cnt+1)=val_$C(9)_val
 q
 
GetUploadsFolder()
        s val=$G(^MSCG("UPLOAD","FOLDER"))              //submitFileCopyFolder
        if $L(val) s val=$$TranslateToFullPath^ZAA02GUTILS2(val) 
        q val
 
FormatFileSize(sz)
 s sz=$G(sz)
         if (sz<=1000){s sz=sz_" B"}
         elseif (sz<1000000) {s sz=sz/1000 s sz=$J(sz,0,1)_" kB" }
         else {s sz=sz/1000000 s sz=$J(sz,0,1)_" MB"}
 q sz
 
        
FILELIST ; ZAA02Gweb  return : delimited file names , % delimited file size
 n sz,dtCr,dtMod,types s sz=0 s types="" s dtCr="" s dtMod=""
 s folder=$G(%("FORM","param1"))
 s types=$G(%("FORM","param2"))  // ERAFILEGET or RPTFILEGET
 s dbg=1 //set to 1 to see all files
 
 if '$L(folder) w "Parameters missing" q
.
 s lstold=$$ListFilesInDir^ZAA02GEMD1(folder,"*.*") 
 s file1="" s DELIM="=" s cnt=0 s ptr=0
        
 s ptr=0 
 FOR i=1:1:$LISTLENGTH(lstold) 
 {
         s file1=$LIST(lstold,i)
         s file1=$P(file1,"\",$L(file1,"\"))     //get file name from full path
         
.
                s sz=##class(%File).GetFileSize(folder_file1)
.
                s sz=$$FormatFileSize(sz)
                if (sz>=0) {  ;;folders show up with -5 as a file size
                        s dtMod=##class(%File).GetFileDateModified(folder_file1)
                        s dtMod=$ZDATETIME(dtMod,3)
                        s cnt=cnt+1 
                        w file1_"%"_sz_" &nbsp &nbsp "_dtMod,DELIM
                }
         
 } 
 q 
 
WriteOutNoPermission(usr,action)
  s action=$G(action) s usr=$G(usr)
  w "<font color='steelblue' face='verdana' title='"_usr _" - "_action_"'><br>Access denied. <br>Please verify your security settings.</font>"
  q
  
WriteOutInvalidHandle()
  w "<font color='steelblue' face='verdana'><br>Access denied. <br>Invalid handle, user is not logged in.</font>"
  q
.
ST ;ZAA02Gweb 
 N (%,RLC)
.
 s action=""
 
 s lc="abcdefghijklmnopqrstuvwxyz",uc="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 s usr  = $P($G(^ZAA02GVBUSER("WEB-LOGON",+$H,+$G(RLC)\1)),",",3)
 if $L(usr)=0 D WriteOutInvalidHandle Q
 
 //get sysdir
 S UNIX=$S($ZV["UNIX":1,1:0),DELIM=$S(UNIX:"/",1:"\")
 D INT^%DIR,NSP^%DIR 
 s folder=%SYSDIR
 
 if ($G(^MSCG("ADDSUBDIR"))) s folder=%SYSDIR_"claims"_DELIM
.
 s PageTitle="Upload File to Premier Server"
 s action="FILEUPLD"
 
 W "<!DOCTYPE HTML>",!
 W "<html>",!
 W "<head>",!
 W "<meta http-equiv=""X-UA-Compatible"" content=""IE=edge"">",!
 D WRITESTYLES
 D WRITESCRIPT
 W "</head>",!
 
 W "<body onload='doOnLoad()'>",!
 W "<div style='display:none;' id='rlcBox'>"_RLC_"</div>" ,!
 //W "<div><font face='verdana' size='2'>"_$ZDATETIME($H,5)_"</font></div>" ,!
 
 //check user permission
 if '$L(usr)||'($P($G(^OPG(usr,action)),":",1)) D WriteOutNoPermission(usr,action) Q
.
 w "<div id='pgTitle' class='hdr1' title='"_folder_"'>"_PageTitle_"</div>",!
 
 W "<div class='msg4' hidden id='idReportsOnly'>"
 W " Allowed to upload to this folder (server) "
        n arrList
 
        D MakeFoldersArrAll(.arrList)
.
        n selItm s selItm=$P($G(arrList(1)),$C(9),1)
        W $$MakeDropdown^ZAA02GSETUTILS2("thisFolder",.arrList,selItm,"'setCurrentFolder()'",1) 
 W " </div>",!
.
 
 W " <div class='msg4'> Files already in this folder  &nbsp  &nbsp  &nbsp <button class='btn' id='btndoCommand1' "
       W "onclick=loadList("
       W "document.getElementById('txt').value,'"_action_"')"
       W "> Show list </button>"
 w "  <button class='btn' onclick='setCurrentFolder()'>Hide list</button>", !
 W "  <input hidden readonly id='txt' type='textarea' value='"_folder_"' size=40/></div>"
 W "  <input hidden readonly id='ent' type='textarea' value='' size=40/>   "  
 W "  <br>"
.
.
 W "<div class='row'><label class='label2'>  &nbsp File </label><input type='file' onchange='fileChanged()' onclick='fileChanged()' name='fileCntrl' id='fileCntrl' size='60' accept='*'>", !
 W "<span id='fileSize'></span></div>",!
 
 W "<br> <div> <label>  Send    </label><button id='sendFile' onclick=sendFile();> Upload File</button></div>", !
 
 W "<br><div id='res'> </div>", !
.
.
 W "<br> <div class='blueBar' id='fileListTitle'> Files in folder </div>",!
 
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
 W "<script>",!
.
sendFile
 W "    function sendFile() { ", !   
 W "    document.getElementById('sendFile').innerHTML=' loading ... '; " , ! 
 W "    document.getElementById('sendFile').disabled = true; "    , ! 
.
 W "    var formData = new FormData(); ", !     
 W "    var ido=document.getElementById('fileCntrl');", !
 W "    var file=ido.files[0]; ", !
 W "    formData.append(ido.getAttribute('file'),file,file.name);  ", !     
 W "    var fname1 = file.name; fname1=fname1.replace('#','_') ; fname1=fname1.replace('&','-') ;" , !
 W "    var ref='storefile^ZAA02Gupload?'+ fname1 ;    ", ! 
.
 W "    var d = senddata(ref,formData,true); ", !  
 W "    document.getElementById('sendFile').innerHTML=' Processing... ' ;", !  
 W "    document.getElementById('res').innerHTML ='<br><br><font color=red size=3> &nbsp &nbsp &nbsp*** Please wait. ***</font><br><br>' ;   " , ! 
 W "     "
 W "   } " , !   
.
fileChanged
 W " function fileChanged() { document.getElementById('res').innerHTML ='' ; ", !   
 W " var filesize=''; var numfiles = document.getElementById('fileCntrl').files.length; ",!
 W " if (numfiles>0) { " , !
 W "  ", !
 W "    filesize = document.getElementById('fileCntrl').files[0].size ;", !
 W "    document.getElementById('sendFile').disabled=false; "    , ! 
 W "    document.getElementById('sendFile').innerHTML=' Upload '; " , ! 
 W "    document.getElementById('fileSize').innerHTML='File size: '+ filesize + ' bytes '; } ", !  
 W " else {  ", !
 W "    document.getElementById('sendFile').disabled=true;  document.getElementById('fileSize').innerHTML=''; } ", !   
 W " if (+filesize>500E+6) {            ", !  //500 Meg 
 W "    var warn='<font color=red> &nbsp &nbsp &nbsp *** Files size exceeds the limit allowed *** </font>'", !
 W "    document.getElementById('fileSize').innerHTML='File size: '+ filesize + ' bytes ' + warn;       ", !
 W "    document.getElementById('sendFile').disabled=true;      }", !
 W " } ", !   
.
loadList
 W "   function loadList(folder,types) { "
 W "            var longstr; longstr = CallCache('FILELIST^ZAA02GUPLOAD',folder,types,'','','','',''); ", !
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
 W "                    strLi= fn +  '<span style=""color:steelblue"">&nbsp &nbsp &nbsp' + fsz + ' </span> ';           " ,!
 W "                    li.innerHTML=strLi;     if (fn!='') ul.appendChild(li); }  ", !
 W "            var tg=' files '; if ((fileList.length - 1)==1) tg=' file ' ;                                                                           ",!
 W "            reportData = fileList.length - 1 + tg; " ,!
 W "            document.getElementById('statusMsg').innerHTML = reportData; " ,!
 W "            document.getElementById('res1').value = reportData;   " ,!
 W "            if (window.frameElement){ parent.ResizeFrame(); }  " ,! //if runs in iFrame with id='frameX' will be resized
 W "   document.getElementById('fileListTitle').style.visibility='visible'; ", !     
 W "   } "
 
clearList
 W "  function clearList(ul) {   ",!
 W "  document.getElementById('fileListTitle').style.visibility='hidden'; ", !     
 W "  if (ul == null) return; ",!
 W "  var last;   while (last = ul.lastChild) ul.removeChild(last);  ",!
 W "  };  ",!
.
showDone
 W " function showDone(response) { "
 W " document.getElementById('idReportsOnly').style.display = 'block' ;  ",!
 W " document.getElementById('sendFile').disabled = true ;  ",!
 W " document.getElementById('sendFile').innerHTML=' Upload File ' ;", !  
 W " document.getElementById('res').innerHTML =''; alert('Done.'); ", !
 W " document.getElementById('res').innerHTML=response ;  " , ! 
 W " } ", !
  
doOnLoad
 W " function doOnLoad() { "
 W " document.getElementById('idReportsOnly').style.display = 'block' ;  ",!
 W " document.getElementById('sendFile').disabled = true ;  ",!
 W " setCurrentFolder();} ", !
 
setCurrentFolder
 W " function setCurrentFolder() { "
 W " document.getElementById('txt').value=document.getElementById('thisFolder').value ;  ",!
 W " document.getElementById('pgTitle').title=document.getElementById('thisFolder').value ;  ",!
 W " document.getElementById('statusMsg').innerHTML = '';  ", !
 W " var ul=document.getElementById('flList'); ", !
 W " clearList(ul);} ", !
 
sendData 
 W "   function senddata(href, args, async)",!
 W "   {"
 W "    var ses=document.getElementById('rlcBox').innerHTML;", !
.
 W "    var req = new XMLHttpRequest();",!
 W "    var response = '';",!
 W "    req.onreadystatechange = function()",!
 W "       {if (req.readyState == 4)",!
 W "           { response = req.responseText; if (async) { showDone(response);}",!
 W "           }",!
 W "       };",!
 W "    req.open('POST', href, async);",!
 W "    req.setRequestHeader('SES',ses) ; ", !
 W "    if (args) { ",!
 W "        req.send(args);",!
 W "       }",!
 W "    else req.send(null);",!
 W "    return response;",!
 W "   }",! 
 
callCache               //call cache routine, routine name plus 7 params
 W "   function CallCache(url,param1,param2,param3,param4,param5,param6,param7)",!
 W "   {var params = ""param1="" + param1 + ""&param2="" + param2 + ""&param3="" + param3 + ""&param4="" + param4 + ""&param5="" + param5 + ""&param6="" + param6 + ""&param7="" + param7;",!
 W "    var resp='';",!
 W "    resp = senddata(url, params, false);",!
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
 W "button.btn {   background-color:lightsteelblue; padding:2px; font-size:small; font-family:Verdana;} "
 W "textarea { margin: 0; width:75%; padding: 0; border-width: 1; }"
 W "div.hdr1 {font-family: Verdana; margin:6px; text-align:center;line-height:40px;color:steelblue; width:100%;font-size:large;}",!
.
 W "div.blueBar {visibility:hidden; margin: 5px; font-weight: bold; font-family: Verdana; padding:4px; font-size:small;color:white;background-color:lightsteelblue;}",!
 
 W "div.links {font-family: Verdana; font-size:small;}",!
 W "  ul#flList{list-style-position: inside} ",!
 W "  li.item{list-style:none; padding:2px;} ",!
 
 w "div.parent1 {position:relative;}",!
 W "div.msg4 {color:steelblue; width:75%;  margin-left:0px; margin-bottom:20px;  }",! 
 W "</style>",!
 Q
.
