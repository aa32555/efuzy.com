ZAA02GTEST ; Special Procedure Upload Report;2018-08-22 16:44:17;25FEB2014  13:04;
 ; ADS Corp. Copyright
 Q
.
ST ;ZAA02Gweb 
 
 W "<!DOCTYPE HTML>",!
 W "<head><meta http-equiv=""X-UA-Compatible"" content=""IE=9"">"
.
 N (%,RLC)
.
 S hst1=$G(%("HOST:"))
 S IP=$G(%("ADDRESS"))
 ;
 s debug="OFF"
 if ($D(^DEBUG("testfile.zip"))) s debug="ON"
 S TITLE="ZAA02GTEST"
 S A=$I
 
 W "<div hidden id='RLC'>"_RLC_"</div>" ,!
 W "<div>"_$ZDATETIME($H,5)_"</div>" ,!
.
 w "<div class='hdr1' title='ZAA02GTEST'>Emdeon Web Services Test Page</div>",!
 W "<br><div class='links'>Links  &nbsp <a href='https://its.changehealthcare.com/Webclient/'>ITS Webclient</a>  &nbsp  "
 W "<a href='https://its.changehealthcare.com/ITS/itsws.asmx'>ITS Service</a>  &nbsp  "
 //W "<a href='https://its.changehealthcare.com/ITS/itsws.asmx?wsdl'>ITS Service Description</a>  &nbsp  " 
 W "<a href='http://"_hst1_"/premier'>Open Premier</a></div>"
 
 if (debug="ON")
 {
 W "<br><div class='links'><font color=red>Debug mode: "_debug_"</font>"
 W "<br>See instructions on the bottom. </div>"
 }
 
 
 n FinCodes s FinCodes=""
 s FinCodes=$G(^MSCG("RECONCIL",5))
 W "<br><div><button id='btndoCommand' onclick=runCmd("
       W "document.getElementById('txt').value,document.getElementById('ent').value,"
       W "document.getElementById('fileID').value,document.getElementById('HowMany').value,"
       W "document.getElementById('InsProg').value,document.getElementById('FRM').value,document.getElementById('FINCODES').value)>    Run Command   </button>"
 W " &nbsp <input id='txt' type='textarea' value='AUT' size=6/>"
 W " &nbsp &nbsp Entity &nbsp<input id='ent' type='textarea' value='1' size=2/>    "  
 W " &nbsp Program <input id='InsProg' type='textarea' value='MODNEIX' size=10/>  "  
 W " &nbsp Ins.Form <input id='FRM' type='textarea' value='5' size=2/>"  
 W " &nbsp File ID <input id='fileID' type='textarea' value='654321:12345:1' size=12/>"  
 W " &nbsp How many files to take <input id='HowMany' type='textarea' value='2' size=2/>"  
 W " <br><br>"
 W " <font color='steelblue'>Financial Codes and Excel flag for RECON</font>, delimited by ':' <br> ", !
 W " <div style='margin-left:1in;'> <br>4 financial codes ( Payment, Deductible, Disallowance, Denial  ", !
 W "  - first three are required! )", !
 W " <br>   then a switch to create Excel file (0 or 1), ",! 
 W " <br>   then code #5 (Reversal) , code #6 (Debit Adjustment) ",!
 W " <br>   then code #7 (Co-insurance) , code #8 (Copay) ",!
 W " <br><br>   Enter codes in the following format <font color='steelblue'> CODE1:CODE2:CODE3:CODE4:0:CODE5:CODE6:CODE7:CODE8 </font>,  ", !
 W " or type <font color='steelblue'>DONOTPROCESS</font> ", !
 W " <br><br>  &nbsp &nbsp &nbsp &nbsp  &nbsp &nbsp &nbsp &nbsp *** Note: current contents of ^MSCG(""RECONCIL"",5) are : "_FinCodes_" ",!
 W " <br><br><input id='FINCODES' type='textarea' value='"_"DONOTPROCESS"_"' size=32/>   "  
 W " </div>",!
 W "</div>",!
 w "<br><table>",!
 W "<tr><th>Command</th><th> Description</th><th>Params</th></tr>"
 W "<tr><td>AUT </td><td> -  authenticate userID/password for Entity/Form# if set; or Comm. Settings</td><td>Entity, form#</td></tr>"
 W "<tr><td>SUBM </td><td>  - submit one file from Prepared Files, by ID from ^EISCP, delimited by ':'</td><td>File Id </td></tr>"
 W "<tr><td>TAKE </td><td>  -  take files marked SCH, oldest of EISCP global and submit</td><td>how many files </td></tr>"
 W "<tr><td>TAKE2 </td><td> -  take files marked COMPL and submit</td><td>how many files </td></tr>"
 W "<tr><td>TAKE3 </td><td>  - take files marked ERR and submit</td><td>how many files </td></tr>"
 W "<tr><td>TAKE4 </td><td> -  take files marked PROC and submit</td><td>how many files </td></tr>"
 W "<tr><td>RESCH </td><td> -  take anything marked, do not submit, just reset status to SCH</td><td>how many files </td></tr>"
 W "<tr><td>CLSCH </td><td> -  take anything marked SCH, do not submit, just reset status to null</td><td>how many files </td></tr>"
 W "<tr><td>SCHALL </td><td> -  take anything NOT marked and set it to SCH, <b>use caution!</b></td><td>how many files </td></tr>"
 W "<tr><td>RECV </td><td>  - download reports</td><td>program,form#</td></tr>"
 W "<tr><td>RECON </td><td> -  download and run reconciliation, use <font color='steelblue'>DONOTPROCESS</font> in Fin.Codes box to download, import, but NOT process</td><td>program,form#,fin.codes</td></tr>"
 
 W "<tr><td><font color='brick'>XBS</font></td><td>  -   download files from Emdeon using 'XBS' request</td><td>Entity</td></tr>"
 w "</table>",!
 
 W "<br><font color='red'>Result </font><br> <textarea id='res1' rows='6' cols='120'> ...... </textarea> "  
 
 W "<div><br><font color=red>Debug mode: "_debug_"</font></div>"
 W "<div style='margin-left:0.5in;'>set/remove S ^DEBUG(""testfile.zip"")="""" to switch mode. "
 W "<br>RECON/RECV will not go to internet, instead file 'recon-testfile.zip' or 'recv-testfile.zip'", !
 W "<br> from the namespace directory will be used and processed as a received file.</div>"
.
 S url2="'cmd^ZAA02Gtest'"
 
 
 
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
 W "</style>"
 
 W "<script>",!
 
 W "    function runCmd(txt,ent,fileID,howMany,InsProg,FormNumber,FinCodes)"
 W "    {"
 W "        var dt = new Date();"
 W "        var reportData ='';"
 W "        reportData = RunCommand("_url2_",txt,ent,fileID,howMany,InsProg,FormNumber,FinCodes); "
 W "        document.getElementById('res1').value = reportData;  "
 W "    }", !
 
 W "   function RunCommand(url,param1,param2,param3,param4,param5,param6,param7)",!
 W "   {var params = ""param1="" + param1 + ""&param2="" + param2 + ""&param3="" + param3 + ""&param4="" + param4 + ""&param5="" + param5 + ""&param6="" + param6 + ""&param7="" + param7;",!
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
 
 
 W "</script>"
 W "</head>"
 
  W "</html>"
  
 Q
 
CMD ; ZAA02Gweb reads params from %, choices are: AUT, SUBM, TAKE, TAKE2, TAKE3, RESCH, CLSCH, RECV, result is written out
 
 N TMP,ent,usr,pwd,PATH,NUM,UNIX,tmp,client,resp,zipfile,file,fileLen,command,t,res,lst,lst1
 n ptr,count,value,sent,res,lst1,tp,resch,progr,formNumber,finCodes
 
 s cmd=$G(%("FORM","param1"))
 s ent=$G(%("FORM","param2"))
 s filenum=$G(%("FORM","param3")) 
 s howMany=$G(%("FORM","param4"))
 s progr=$G(%("FORM","param5"))
 s formNumber=$G(%("FORM","param6"))
 s finCodes=$G(%("FORM","param7"))
 
 //get from communicaion settings
 S TMP=$S($D(^REF("COM",ent)):^(ent),1:$G(^REF("COM")))
 S usr=$P(TMP,":",13),pwd=$P(TMP,":",11)
 
 //now see if there is an override in INS. PROGRAMS for this form number
 s usrOver="" s pwdOver=""
 s usrOver=$P($G(^SETFRMG(ent,formNumber,1)),":",2)
 s pwdOver=$P($G(^SETFRMG(ent,formNumber,1)),":",3)
 
 if ($L(usrOver) & $L(pwdOver)) {
         s usr=usrOver
         s pwd=pwdOver
 } 
 
 //s ^DBG("usr")=usr
 //s ^DBG("pwd")=pwd
 
 s res="0|100 command not recognized"
  
  ; returns "1|message " if success
 
  ; AUT, SUBM
  ; error code CHAR(9) then message from emdeon
 
 s ^ZAA02GVB=1
 if cmd="AUT" ; 
 {s res=$$AUTH^ZAA02GEMD1(usr,pwd)
 }
  elseif cmd="SUBM" ; submit one file by ID 
 {s res=$$SUBM^ZAA02GEMD1(usr,pwd,filenum)
 }
 
 elseif cmd="XBS"
 {s res=$$XBS^ZAA02GEMD1(usr,pwd)
 }  
 
 elseif cmd="XBILL"
 {s res=$$XBILL^ZAA02GEMD1(usr,pwd)
 }  
  elseif cmd="RECV"
 {s res=$$RECV^ZAA02GEMD1(usr,pwd,progr)
 }
  elseif cmd="RECON" 
 {s res=$$RECON^ZAA02GEMD1(usr,pwd,progr,ent,formNumber,finCodes)
 }
  elseif (cmd="TAKE") || (cmd="TAKE2") || (cmd="TAKE3") || (cmd="TAKE4") || (cmd="RESCH") || (cmd="CLSCH") || (cmd="SCHALL")
 {
  s res=$$PROCESSLIST^ZAA02GEMD1(usr,pwd,cmd,howMany,formNumber)
 }
 
 w res
 q 
 
