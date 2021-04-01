ZAA02GFTPTEST ;  ;2019-01-24 10:58:10;25FEB2014  13:04;
 ; ADS Corp. Copyright
 Q
.
ST ;ZAA02Gweb 
 
 W "<!DOCTYPE HTML>",!
 W "<head><meta http-equiv=""X-UA-Compatible"" content=""IE=9"">", !
 
 W "<style type='text/css'>"
 W "body {font-family:Verdana;font-size:small;}",!
 W "input{font-family:Verdana;font-size:small;}"
 W "th{font-family:Verdana;font-size:small;font-weight:normal;background:whitesmoke;}"
 W "td{font-family:Verdana;font-size:small;}"
 W "button {height:25px; background-color:#99cfff;} "
 W "textarea {width: 95%; margin: 0; padding: 0; border-width: 1; }"
 W "div {font-family: Verdana; font-size:small;}"
 W "div.courier{font-family:Courier New;font-size:small;}"
 W "div.hdr1 {position:absolute;top:0;font-family: Verdana; text-align:center;line-height:30px;color:steelblue; width:100%;font-size:large;}"
 W "div.links {font-family: Verdana; font-size:small;}"
 W "</style>" ,!
.
 W "<script>",!
 
 W "    function runCmd(txt,host,port,username,password,filename,destfile,folder) {  ", !
 W "        var dt = new Date(); ", !
 W "        var reportData ='';", !
 W "        reportData =RunCommand('cmd^ZAA02Gftptest',txt,host,port,username,password,filename,destfile,folder); " , !
 W "        document.getElementById('res1').value = reportData;  ", !
 W "    }", !
 
 W "   function RunCommand(url,param1,param2,param3,param4,param5,param6,param7,param8)",!
 W "   {var params = ""param1="" + param1 + ""&param2="" + param2 + ""&param3="" + param3 + ""&param4="" + param4 + ""&param5="" + param5 + ""&param6="" + param6  + ""&param7="" + param7 + ""&param8="" + param8;",!
 W "    var resp='';",!
 W "    resp = senddata(url, params);",!
 W "    return resp;" ,!
 W "   }",!
 
.
 
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
 W "    RLC=document.getElementById('RLC').innerHTML; ", !
 W "    if (RLC!='') req.setRequestHeader('SES',RLC) ; ", !
 W "    if (args)",!
 W "       {//req.setRequestHeader(""Content-Type"", ""application/x-www-form-urlencoded"");",!
 W "        //req.setRequestHeader(""Content-Length"", args.length);",!
 W "        req.send(args);",!
 W "       }",!
 W "    else req.send(null);",!
 W "    return response;",!
 W "   }",! 
 
 
 W "</script>", !
 W "</head>", !
.
 W "<body>", !
 N (%,RLC)
.
 S hst1=$G(%("HOST:"))
 S IP=$G(%("ADDRESS"))
 ;
 s debug="OFF"
 if ($G(^DBG("FTP"))=1) s debug="ON"
 S TITLE="ZAA02GTEST"
 S A=$I
 
 W "<div id='RLC'>"_RLC_"</div>" ,!
 W "<div>"_$ZDATETIME($H,5)_"</div>" ,!
.
 w "<div class='hdr1' title='FTP TEST'>SFTP test</div>",!
 
 if (debug="ON")
 {
 W "<br><div class='links'><font color=red>Debug mode: "_debug_"</font>" ,!
 W "<br>See instructions on the bottom. </div>",!
 }
.
       
 W "<br><br>",!
.
 W "<br><div><button onclick=runCmd("
       W "document.getElementById('cmd').value,"
       W "document.getElementById('host').value,document.getElementById('port').value,"
       W "document.getElementById('username').value,document.getElementById('password').value,"
       W "document.getElementById('srcFilePath').value,document.getElementById('destFileName').value,document.getElementById('folder').value);>",!
       W "  Run Command   </button>",!
       
 W " <br><br>  command <input id='cmd' value='LIST' size=6/> &nbsp &nbsp &nbsp supported: LIST, SEND" ,!
 W " <br><br> &nbsp &nbsp &nbsp host &nbsp<input id='host' value='65.51.204.100' size=16/>   &nbsp port &nbsp   &nbsp <input id='port' value='22' size=4/>     "  ,!
 W " <br><br> username <input id='username' value='adsfiles' size=12/>  "
 W " &nbsp  &nbsp password &nbsp <input type='password' id='password' value='ADSfile$' size=16/> "  ,!
 W " &nbsp  &nbsp destination folder &nbsp <input id='folder' value='' size=16/> "  ,!
 W " <br><br> file path <input id='srcFilePath' value='c:\cachesys\temp\shorttext.txt' size=60/>"  ,!
 W " &nbsp  &nbsp file name on server &nbsp <input id='destFileName' value='BBB.txt' size=12/>"  ,!
.
 W " <br><br>"
 W "<br><font color='red'>Result </font><br> <textarea id='res1' rows='12' cols='120'> ...... </textarea> "  ,!
 
 W "<div><br><font color=red>Debug mode: "_debug_"</font></div>" ,!
 W "<div style='margin-left:0.5in;'>set S ^DBG(""FTP"")=1 (ON) or 0 (OFF) to switch mode. ",!
 
 W "</body>", !
 
 W "</html>",!
  
 Q
 
CMD ; ZAA02Gweb 
.
 N (%,RLC)
.
 //host port user password file
 s cmd=$G(%("FORM","param1"))
 s host=$G(%("FORM","param2"))
 s port=$G(%("FORM","param3")) 
 s user=$G(%("FORM","param4"))
 s password=$G(%("FORM","param5"))
 s srcFile=$G(%("FORM","param6"))
 s destFile=$G(%("FORM","param7"))
 s folder=$G(%("FORM","param8"))
 
 
 s res="0|100 command not recognized"
  
  ; returns "1|message " if success
  ; error code CHAR(9) then message from emdeon
 
 if cmd="SEND" ; 
 {
         s res=$$FTPSEND^ZAA02GFTP(host,port,user,password,srcFile,destFile,folder)
 }
 elseif cmd="LIST" ; 
 {
         s res=$$FTPLIST^ZAA02GFTP(host,port,user,password,folder)
 } 
 w res
 q 
 
