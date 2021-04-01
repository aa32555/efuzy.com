ZAA02GADDTASK ; Download report files ;2016-11-02 16:38:43
 ; ADS Corp. Copyright
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
    }
    else {   //RPTFILEGET
        if ($E(convval,($L(convval)-3),$L(convval))=".CSV") s res=1
        if ($E(convval,($L(convval)-3),$L(convval))=".OUT") s res=1
        if ($E(convval,($L(convval)-3),$L(convval))=".TXT") s res=1
    }
 q res 
        
IsHandleValid(usr,hndl)
        s ok=0
 
        ;go through^ZAA02GVBUSER("LOGON", usr) for today - piece 3; piece 6 is the handle, if logged-off:piece five is filled in
        ;if handle for today found and not logged off - connection is valid
        n a s a ="" n val
        if ($G(usr)="") q 0
        if ($G(hndl)="") q 0
        s a=$O(^ZAA02GVBUSER("LOGON",usr,a))
                while '(a="") {
                s val=$G(^ZAA02GVBUSER("LOGON",usr,a))
                if $P(val,",",5)="" if $P(val,",",6)=hndl if $P(val,",",3)=$P($h,",",1) s ok=1 
                s a=$O(^ZAA02GVBUSER("LOGON",usr,a))
        }
 q ok   
 
VALIDATEHANDLE ; ZAA02Gweb
 n res s res=0
 s usr=$G(%("FORM","param1"))
 s hndle=$G(%("FORM","param2"))
 s action=$G(%("FORM","param3"))
 
 s res=0
 s res=$$IsHandleValid(usr,hndle)
.
 if '($P($G(^OPG(usr,action)),":",1)) s res=-1 //no permission
.
 w res
 q
.
LOGIN ; ZAA02Gweb
 n res s res=0
 s usr=$G(%("FORM","param1"))
 s pwd=$G(%("FORM","param2"))
.
 s lc="abcdefghijklmnopqrstuvwxyz",uc="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 s usr=$TR(usr,lc,uc) s pwd=$TR(pwd,lc,uc)
 if ($P($G(^OPG(usr)),":",3)=pwd) s res=1 //password valid
.
 w res
 q
 
 
FILELIST ; ZAA02Gweb ; return : delimited file names , % delimited file size
 n sz s sz=0 n types s types=""
 s folder=$G(%("FORM","param1"))
 s types=$G(%("FORM","param2"))  // ERAFILEGET or RPTFILEGET
 s dbg=0
 
 s lstold=$$ListFilesInDir^ZAA02GEMD1(folder,"*.*") 
 s file1="" s DELIM=":" s cnt=0 s ptr=0
        
 s ptr=0 
 
 FOR i=1:1:$LISTLENGTH(lstold) 
 {
         s file1=$LIST(lstold,i)
         s file1=$P(file1,"\",$L(file1,"\"))     //get file name from full path
         
         if (dbg || $$FileNameMatch(file1,types)){  
                s sz=##class(%File).GetFileSize(folder_file1)
.
                s sz=$$FormatFileSize(sz)
.
                s cnt=cnt+1 
                w file1_"%"_sz,DELIM
                }        
 } 
 q 
 
 
GETFILE ; ZAA02Gweb
 ;get contents for download
 s folder=$G(%("FORM","param1"))
 s filename=$G(%("FORM","param2"))
 s global=$G(%("FORM","param3"))
 
         s readfile=##class(%Library.File).%New(folder_filename)
         Do readfile.Open("R") 
 
         if (readfile.SizeGet()<0)
         {
                w "ERROR: ",!
                w "file '"_folder_filename_"'",! 
                w "was not found in specified location.",!
                q
         }
                                 
          While 'readfile.AtEnd
         {
                s dt=readfile.Read(30000)
                w dt,!
         }
         Do readfile.Close()
 q
 
 
ST2 ;ZAA02Gweb ; reads params from %
  w "<font color='steelblue' face='verdana'><br>Your session has expired.</font>"
  q
 
ST3 ;ZAA02Gweb ; reads params from %
 n msg s msg=""
 s msg=$G(%("FORM","DATA"))
 w "<font color='steelblue' face='verdana'><br>Access denied. <br>Please verify your security settings.</font>"
 w "<br><font color='steelblue' size='2' face='verdana'><br>&nbsp &nbsp Program: "_msg_" </font>"
 q
.
STREC ;ZAA02Gweb ; reads params from %
 n ReconFiles s ReconFiles=1
.
ST ;ZAA02Gweb ; reads params from %
  
 N (%,ReconFiles)
 s action=""
 
 s ReconFiles=$G(ReconFiles)
 S hst1=$G(%("HOST:"))
 S IP=$G(%("ADDRESS"))
 s dbg=0
 
 s debug="OFF"
 if dbg s debug="ON"
 
 S A=$I
 W "<div><font face='verdana' size='2'>"_$ZDATETIME($H,5)_"</font></div>" ,!
 if (dbg) W "<div>"_A_"</div>"
 
 s lc="abcdefghijklmnopqrstuvwxyz",uc="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 n handle, usr
 s handle=$P($G(%("FORM","DATA")),"&",3)
 s usr=$P($G(%("FORM","DATA")),"&",2)
 
 s handle=$tr(handle,lc,uc)
 s usr=$tr(usr,lc,uc)
 
 s handle=$P(handle,"PWD=",2)
 s usr=$P(usr,"OP=",2)
 
 //get sysdir
 S UNIX=$S($ZV["UNIX":1,1:0),DELIM=$S(UNIX:"/",1:"\")
 D INT^%DIR,NSP^%DIR 
.
 s PageTitle="Reports Folder"
 s folder=%SYSDIR
 if ($G(^MSCG("ADDSUBDIR"))) s folder=%SYSDIR_"claims"_DELIM
 
 s action="RPTFILEGET"
 
 if ReconFiles { 
        s folder=%SYSDIR_"recon_copy"_DELIM
        s PageTitle="ERA files copies" 
        s action="ERAFILEGET"
 }
 
 
loginframe
        s Model="Model"   ; called with indirection
        s Model("Title")="ZAA02GAAWEB Demo"
        s Model("sidebar","username")="Welcome..."
        S Model("entity")=1
        s Model("user")="MG"
        s Model("htmlPage")="html.newtask"   // . is converted to /
        
        d Template^ZAA02GAAWEB("ZAA02GAATASK","html\container", Model) 
.
        ;;d Template^ZAA02GAAWEB("ZAA02GAAADDTASK","html\form", Model) 
        q
 w "<div id='Login'> <br><br>Please enter the password for => '"_usr_"' to continue. <p> <input type='password' size='8' id='pwd'></input> <button onClick=Login('"_usr_"',document.getElementById('pwd').value);> Login </button> </div>",!
endlogin
 
 w "<div id='ShowAll'>" ,! 
 
 w "<div class='hdr1' title='"_folder_"'>"_PageTitle_"</div>",!
 
 W "<div><button class='btn' id='btndoCommand1' "
       W "onclick=loadList("
       W "document.getElementById('txt').value,'"_action_"')"
       W "> See available files </button>"
 
 if (dbg) w " Folder:"
 s tghidden =" hidden " s rdonly=" readonly "
 if (dbg) s tghidden="" s rdonly=""
 
 
 W " &nbsp <input "_tghidden_rdonly_"id='txt' type='textarea' value='"_folder_"' size=40/></div>"
 W " <br>"
 
 W " <div>"
        W "<button class='btn' onclick=SaveAs("
       W "document.getElementById('txt').value,document.getElementById('ent').value"
       W ")>  Download selected </button>"
       
 W "  &nbsp  &nbsp  <input "_tghidden_rdonly_" id='ent' type='textarea' value='' size=40/>   "  
 
 W " </div>" 
 
 W " <br> Selected: <div class='statusSelected' id='FileNameReadOnly'> none </div>",!
 
.
 
 w "<div id='renderList'></div>",!
 w "<div id='statusMsg'></div>",!
 W "</div>", ! ///hide-show 'ShowAll' panel
 
 W "<p>",!
 W " <br><textarea style='display:none;' id='res1'> ...... </textarea> "  
 if (dbg) { 
 W "<p><font face='courier new' size='2'><div><font color=red>Debug mode: "_debug_"</font></div>"
 W "<p>" }
 
 
styles 
 W "<!DOCTYPE HTML>",!
 W "<head><meta http-equiv=""X-UA-Compatible"" content=""IE=9"">"
 
 W "<style type='text/css'>"
 W "div{font-family:Verdana;font-size:small;}"
 W "input{font-family:Verdana;}"
 W "td{font-family:Courier New;font-size:small;}"
 W "button.refresh {height:25px; background-color:green; color:white; border:none; font-size: 16px;} "
 W "button.btn {height:25px; background-color:lightsteelblue; font-family:Verdana;} "
 W "textarea { margin: 0; width:75%; padding: 0; border-width: 1; }"
 W "div.hdr1 {font-family: Verdana; text-align:center;line-height:40px;color:steelblue; width:100%;font-size:large;}",!
.
 W "div.statusSelected {margin: 5px; font-weight: bold; font-family: Verdana; padding:4px; font-size:small;color:white;background-color:lightsteelblue;}",!
 
 W "div.links {font-family: Verdana; font-size:small;}",!
 W "  ul#flList{list-style-position: inside} ",!
 W "  li.item{list-style:none; padding:2px;} ",!
 W "</style>"
 
SCRIPTSECTION 
 W "<script>",!
runCmd 
 W "    function runCmd(cmd,txt,ent,fileID,howMany,InsProg,FormNumber,FinCodes)"
 W "    {"
 W "        var dt = new Date();"
 W "        var reportData ='';"
 W "        reportData = CallCache(cmd,txt,ent,fileID,howMany,InsProg,FormNumber,FinCodes); "
 W "        document.getElementById('res1').value = reportData;  "
 W "    }", !
 
callCache               //call cache routine, routine name plus 7 params
 W "   function CallCache(url,param1,param2,param3,param4,param5,param6,param7)",!
 W "   {var params = ""param1="" + param1 + ""&param2="" + param2 + ""&param3="" + param3 + ""&param4="" + param4 + ""&param5="" + param5 + ""&param6="" + param6 + ""&param7="" + param7;",!
 W "    var resp='';",!
 W "    resp = senddata(url, params);",!
 W "    return resp;" ,!
 W "   }",!
 
loadList
 W "   function loadList(folder,types) { "
 
 W "            var longstr; longstr = CallCache('FILELIST^ZAA02GDOWNLOAD',folder,types,'','','','',''); ", !
 W "            fileList = longstr.split(':');  ",!
 
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
 W "                    //ul.appendChild(li);           " ,!
 W "                    t = document.createTextNode(a);         " ,!
 W "                    var fn;  fn=fileList[a].split('%')[0];  ", !
 W "                    var fsz; fsz=fileList[a].split('%')[1]; ;",!
 W "                    var strLi; var strFn; strFn='\'' +fn +'\''; ",!
 W "                    var jscrQuote ='""'; ",!
 W "                    strLi=""<a href='#' onclick="" + jscrQuote + ""setBox("" + strFn + "")"" + jscrQuote + "">"" + fn + '</a>' + '<span style=""color:steelblue"">&nbsp &nbsp &nbsp' + fsz + ' </span> ';           " ,!
 W "                    li.innerHTML=strLi;     if (fn!='') ul.appendChild(li); }  ", !
 W "   ",!
 
 W "            reportData = fileList.length - 1 + ' files available'; " ,!
 W "            document.getElementById('statusMsg').innerHTML = reportData; " ,!
 W "            document.getElementById('res1').value = reportData;   " ,!
 W "   } "
 
clearList
 W "  function clearList(ul) {   ",!
 W "                            var last;   ",!
 W "                            while (last = ul.lastChild) ul.removeChild(last);  ",!
 W "                    };  ",!
 
 
setBox 
  W "   function setBox(filename) { " 
  W "   document.getElementById('FileNameReadOnly').innerHTML=filename;  ", !
  W "   document.getElementById('ent').value=filename; }  ", !
 
 
saveAs
 W "   function SaveAs(folder, filename, saveas) { "
 
 W "            type='text/plain'; " ,!
 
 W "            if (filename=='') { alert('Nothing selected'); return; }",!
 W "            if (typeof Blob == 'undefined') { alert('Cannot download selected file: \nolder browsers are not supported.'); return; }", !
 
 W "            var longstr; longstr = CallCache('GETFILE^ZAA02GDOWNLOAD',folder,filename,saveas,'','','',''); ", !
 
 
 W "            ; ",!
 W "            var x5;  x5=longstr; ",!
 
 
 W "            var myBlob = new Blob([x5], {type: 'text/plain'}); " ,!
 W "            var myReader = new FileReader(); " ,!
 W "            myReader.readAsText(myBlob); " ,!
.
 W "            var objectURL; objectURL =  URL.createObjectURL(myBlob);" ,!
 
 W "            var a = document.createElement('a'); ", !
 W "            a.href = objectURL;"
                        
 W "            ; "
 W "            ; "
 
 W "            a.download = filename; "
 W "            a.click(); "
 W "            reportData = ' *** Downloaded ***' ; " ,!
 W "            document.getElementById('res1').value = reportData;  " ,!
 W "            objectURL.revokeObjectURL ; ", !        
 W "   } "
.
login
 W "    function Login(usr,pwd)"
 W "    {"  
 W "        var reportData ='';"
 W "        reportData = CallCache('LOGIN^ZAA02GDOWNLOAD',usr,pwd,'','','','',''); "
 W "        document.getElementById('res1').value = 'logged in here... ' + reportData;  "
 W "            if (reportData !='1') { alert('Not valid.'); return;} "  ,!
 W "            if (reportData =='1') {  "  ,!
 W "                    var ele = document.getElementById('ShowAll');                                                                                                                   ;",!
 W "                ele.style.display='block';  ;",!
 W "                    var ele = document.getElementById('Login');                                                                                                                     ;",!
 W "                ele.style.display='none';   ;",!
 W "            }               ;",!
 
 W "    }", !
validateOnStart
 W "    function validateOnStart(usr,hndle,action)"
 W "    {"  
 W "        var reportData ='';"
 W "            var ele = document.getElementById('ShowAll');                                                                                                                   ;",!
 W "            ele.style.display='none';       ;",!
 
 W "        reportData = CallCache('VALIDATEHANDLE^ZAA02GDOWNLOAD',usr,hndle,action,'','','',''); "
 W "        document.getElementById('res1').value = 'validated: ' +reportData;  "
 W "            isValid=reportData; "  
 W "            if (isValid =='-1') { window.location.href='/st3^ZAA02Gdownload' + '?' + action; return;} "  ,!
 W "            if (isValid !='1')  { window.location.href='/st2^ZAA02Gdownload' + '?'; return;} "  ,!
 W "            if (isValid =='1')  {  "  ,!
 W "                    var ele = document.getElementById('ShowAll');                                                                                                                   ;",!
 W "                ele.style.display='none';   ;",!
 W "                    var ele = document.getElementById('Login');                                                                                                                     ;",!
 W "                ele.style.display='block';  ;",!
 W "            }               ;",!
 
 W "    }", !
 
SCRIPTCOMMON
 
 W "   function senddata(href, args)",!
 W "   {"
 W "    var req = new XMLHttpRequest();",!
 W "    var response = '';",!
 W "    req.onreadystatechange = function()",!
 W "       {if (req.readyState == 4)",!
 W "           {response = req.responseText;",!
 W "           }",!
 W "       };",!
 W "    req.open(""POST"", href, false);",!
 W "    if (args)",!
 W "       {//req.setRequestHeader(""Content-Type"", ""application/x-www-form-urlencoded"");",!
 W "        //req.setRequestHeader(""Content-Length"", args.length);",!
 W "        req.send(args);",!
 W "       }",!
 W "    else req.send(null);",!
 W "    return response;",!
 W "   }",! 
 
 W "</script>"
.
DoOnLoad
 W " <script>"
 W " validateOnStart('"_usr_"','"_handle_"','"_action_"');  ",!
 W " </script> ",! 
.
 W "</head>"
 
  
 Q
  ;================================================= gjg ================================================================
  
TaskDfltCodes ; 
        n a,b s a="" f  s a=$o(^ZAA02GAATASKG("CODES","TASKCODES",a)) q:a=""!(a="~#")  d
        .  s b = "" ;;i a = "MDCR" s b = "selected"
        .  w "<option value="""_a_""""_b_">"_a_"-"_$p(^(a),":",2)_"</option>"
        q
  
  
  
  
  ; ======================================================================================================================
 
 
 
 
ToBase64URL(a) 
        n b,c,j,cd,cd1,cc d
        . s cd ="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_="
        . s cd1="" f j=1:1:65 s cd1=cd1_$c(j+31)
        s cc="" f j=1:3:$l(a) d  s cc=cc_c
        . s b=$e(a,j,j+2)
        . i $l(b)=3 s c=$tr($c($a(b)\4+32,$a(b)#4*16+($a(b,2)\16)+32,$a(b,2)#16*4+($a(b,3)\64)+32,$a(b,3)#64+32),cd1,cd) Q
        . i $l(b)=2 s c=$tr($c($a(b)\4+32,$a(b)#4*16+($a(b,2)\16)+32,$a(b,2)#16*4+32,96),cd1,cd) Q
        . s c=$tr($c($a(b)\4+32,$a(b)#4*16+32,96,96),cd1,cd) Q
        q $p(cc,"=")
        ;
BASE64(A)
 N B,C,J I '$D(Cd) D
 . S Cd="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="
 . S Cd1="" F J=1:1:65 S Cd1=Cd1_$C(J+31)
 S CC=$G(CChead) K CChead F J=1:3:$L(A) D  S CC=CC_C
 . S B=$E(A,J,J+2) I $L(B)=3 S C=$TR($C($A(B)\4+32,$A(B)#4*16+($A(B,2)\16)+32,$A(B,2)#16*4+($A(B,3)\64)+32,$A(B,3)#64+32),Cd1,Cd) Q
 . I $L(B)=2 S C=$TR($C($A(B)\4+32,$A(B)#4*16+($A(B,2)\16)+32,$A(B,2)#16*4+32,96),Cd1,Cd) Q
 . S C=$TR($C($A(B)\4+32,$A(B)#4*16+32,96,96),Cd1,Cd) Q
 Q CC
 
.
