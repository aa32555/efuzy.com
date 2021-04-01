ZAA02GRCMVIEW ;;2018-09-18 12:35:52
 ; ADS Corp. Copyright
 q
.
GETCURRENT ; ZAA02Gweb  
 
 n res,op,val,oth,row1
 s res="", op="", val="", row1=""
 
 s tg="PPOL request"
 s vl=$G(^DEBUG("AUTO","EOBL",1))
 s $P(vl,":",1)=""  s $E(vl,1,1)=""
 s res=res_"<tr><td>"_tg_"</td><td> &nbsp "_vl_"</td></tr>"
 
 s tg="PPOL response"
 s vl=$G(^DEBUG("AUTO","EOBL",2))
 s vl=$$REPLACE^ZAA02GUTILS(vl,"|","<BR> &nbsp &nbsp ")
 s vl=$$REPLACE^ZAA02GUTILS(vl,$C(13),"<BR> &nbsp &nbsp")
 s vl=$$REPLACE^ZAA02GUTILS(vl,$C(10),"")
 s $P(vl,":",1)=""  s $E(vl,1,1)=""
 s res=res_"<tr><td>"_tg_"</td><td> &nbsp "_vl_"</td></tr>"
.
.
 s tg="Recon request"
 s vl=$G(^DEBUG("AUTO","RECON",1))
 s $P(vl,":",1)=""  s $E(vl,1,1)=""
 s res=res_"<tr><td>"_tg_"</td><td> &nbsp "_vl_"</td></tr>"
 
 s tg="Recon response"
 s vl=$G(^DEBUG("AUTO","RECON",2))
 s vl=$$REPLACE^ZAA02GUTILS(vl,"|","<BR> &nbsp &nbsp ")
 s vl=$$REPLACE^ZAA02GUTILS(vl,$C(13),"<BR> &nbsp &nbsp")
 s vl=$$REPLACE^ZAA02GUTILS(vl,$C(10),"")
 s $P(vl,":",1)=""  s $E(vl,1,1)=""
 s res=res_"<tr><td>"_tg_"</td><td> &nbsp "_vl_"</td></tr>"
.
 s tg="Report request"
 s vl=$G(^DEBUG("AUTO","RECV",1))
 s $P(vl,":",1)=""  s $E(vl,1,1)=""
 s res=res_"<tr><td>"_tg_"</td><td> &nbsp "_vl_"</td></tr>"
.
 s tg="Report response"
 s vl=$G(^DEBUG("AUTO","RECV",2)) 
 s vl=$$REPLACE^ZAA02GUTILS(vl,"|","<br>")
 s vl=$$REPLACE^ZAA02GUTILS(vl,$C(13),"<br> &nbsp &nbsp")
 s vl=$$REPLACE^ZAA02GUTILS(vl,$C(10),"")
 s $P(vl,":",1)=""  s $E(vl,1,1)=""
 s res=res_"<tr><td>"_tg_"</td><td> &nbsp "_vl_"</td></tr>"
.
 s tg="Submission request"
 s vl=$G(^DEBUG("AUTO","SUBM",1))
 s $P(vl,":",1)=""  s $E(vl,1,1)=""
 s res=res_"<tr><td>"_tg_"</td><td> &nbsp "_vl_"</td></tr>"
.
 s tg="Submission files prepared"
 s vl=$G(^DEBUG("AUTO","SUBM",1.1))
 s $P(vl,":",1)=""  s $E(vl,1,1)=""
 s res=res_"<tr><td>"_tg_"</td><td> &nbsp "_vl_"</td></tr>"
.
 s tg="Submission response"
 s vl=$G(^DEBUG("AUTO","SUBM",2))
 s vl=$$REPLACE^ZAA02GUTILS(vl,$C(9),"<br><br>")
 s $P(vl,":",1)=""  s $E(vl,1,1)=""
 s res=res_"<tr><td>"_tg_"</td><td> &nbsp "_vl_"</td></tr>"
                
 if ($L(res)) { 
        s res="<table class='list'>"_res_"</table>"
 }
 w res
.
 s dtLast=$O(^DEBUG("SCH","T",""),-1)
 while dtLast'="" {
         if $D(^DEBUG("SCH","T",dtLast,"SFTP")) { 
                w "<div class='hdr2'> "_"The most recent sftp submission  "_"</div>",!
.
                d WriteOutLog2(dtLast,"SFTP",1)
                s dtLast=""
         }
         else { 
                 s dtLast=$O(^DEBUG("SCH","T",dtLast),-1)
         }
 }      
.
        
 q 
.
GETSFTPLOG ; ZAA02Gweb
 n (%,RLC)
 W "<!DOCTYPE HTML>",!
 W "<html>",!
 W "<head>",!
 W "<meta http-equiv=""X-UA-Compatible"" content=""IE=9"">",!
 D WRITESTYLES
 D WRITESCRIPT
 W "</head>",!
 W "<body>",!
 W "<div style='display:none;' id='rlcBox'>"_$G(RLC)_"</div>" ,!
.
 w "<div class='titleLog' style='text-align:center; font-size:medium;'>File Transfer Tracking ",!
 w "<div style='float:right;'>", !
 W " show <input id='dayFrom' value='7' size='3'> days ", !
 W " &nbsp <button class='btn1' onclick=showSFTPdays(document.getElementById('dayFrom').value)>Apply</button>",!
 W " &nbsp &nbsp&nbsp &nbsp&nbsp &nbsp", !
 w "</div></div>", !
 
 w "<div id='res' class='curr'>...</div>", !
 W "<script>showSFTPdays(document.getElementById('dayFrom').value);</script>",!
 W "</body>",!
 W "</html>",!
 q
  
GETLOG ; ZAA02Gweb 
 n from, to, today, d2, d1, d
 s from=+$G(%("FORM","param1"))
 s to=+$G(%("FORM","param2"))
 s today=$P($h,",",1)
 s d1=today-from s d2=today-to  //d1 is recent  d2 is old
 
 w "<br><div class='titleLog'> "_$ZD(d1)_" to "_$ZD(d2)_"  </div>"
        
                if ($D(^DEBUG("SCH","T",d1)))   { 
                        D OneDayLog(d1)
                } 
        
                s d=$O(^DEBUG("SCH","T",d1))
 
                while ('(d="") && '(d>d2))      { 
                        D OneDayLog(d)
                        s d=$O(^DEBUG("SCH","T",d))
                }
        q
.
GETLOG2 ; ZAA02Gweb 
 n days, today, d2, d1, d
 s days=+$G(%("FORM","param1"))
 s today=$P($h,",",1)
 s d1=today s d2=today-days +1  //d1 is recent  d2 is old
 if days<1  w "<br><div class='titleLog' style='float:center;'> Date Range is invalid</div>" q
.
 w "<br><div class='titleLog' style='float:center;'> Date Range: &nbsp &nbsp &nbsp &nbsp "_$ZD(d2)_" &nbsp &nbsp - &nbsp&nbsp "_$ZD(d1)
 W "&nbsp &nbsp &nbsp &nbsp  <button class='btnToggleCol btn' onclick=toggleCol(this);> show detail </button>",!
 W "  </div>"
        
.
                if ($D(^DEBUG("SCH","T",d1)))   { 
                        D WriteOutLog2(d1,"SFTP")
                } 
        
                s d=$O(^DEBUG("SCH","T",d1),-1)
 
                while ('(d="") && '(d<d2))      { 
                        D WriteOutLog2(d,"SFTP")
                        s d=$O(^DEBUG("SCH","T",d),-1)
                }
        q
.
.
OneDayLog(d)
        w "<br><div class='titleLogCenter'> Log of "_$ZD(d)_"   </div>"
        
        s defs(0)="Time"
        s defs(4)="Error"
    d WriteOutLog(d,"ERROR",.defs,"*** ERRORS ***",1)
        
        s defs(0)="Source"
        s defs(1)="Group"
        s defs(2)="Report"
        s defs(3)="Timestamp"
        s defs(4)="Params"
        d WriteOutLog(d,"params",.defs,"By Group") 
        
        s defs(0)="Time"
        s defs(1)="Tag"
        s defs(2)="Report"
        s defs(3)=""
        s defs(4)="Report / Time / Job #"
        d WriteOutLog(d,"runPROG",.defs,"By Job") 
        
        d WriteOutLog2(d,"SFTP",1) 
        
 q
 
WriteOutLog(date,key,defs,title,isError)
 if ($D(^DEBUG("SCH","T",date,key))) {
        if $G(title)="" s title=key     
        if $G(isError) { 
                w "<div class='titleError'> "_title_"</div>",!
        }
        else {
                w "<div class='titleLog'> "_title_"</div>",!
        }
           
    s z1=$Q(^DEBUG("SCH","T",date,key))
    w "<table class='list'>"
        
    w "<tr><th>"_$G(defs(0))_"</th><th>"_$G(defs(1))_"</th><th>"_$G(defs(2))_"</th><th>"_$G(defs(3))_"</th><th class='params'>"_$G(defs(4))_"</th></tr>"
        
    while '(z1="") 
        {
        s f1=$qs(z1,5) if $G(defs(0))="Time" s f1=$ZT(+f1)_" ("_f1_")"                                  //format time to readable format
        s f4=$qs(z1,8) if $G(defs(3))="Timestamp" s f4=$ZT(+$P(f4,",",2))_" ("_f4_")"   //format $H to readable format
.
        s str1=@z1 
        s str1= $zcvt(str1,"O","HTML")
        
        w "<tr>"
        w "<td>"_f1_"</td><td>"_$qs(z1,6)_"</td><td>"_$qs(z1,7)_"</td><td>"_f4_"</td>",!
        w "<td><div class='params'>"_str1_"</div></td>",!
                w "</tr>",!
                
        s z1=$Q(@z1)
        q:z1=""
        q:$qs(z1,4)'=key
        }
    w "</table>",!
 }
 q
 
WriteOutLog2(date,key,detail)
 if ($D(^DEBUG("SCH","T",date,key))) {
    s detail=$G(detail) 
    if detail s detail="<button class='btnToggleCol btn' onclick=toggleCol(this);> show detail </button>"
    w "<br>"
    w "<table class='list'>"
        w "<div class='titleLog'>"_key_" log of "_$ZD(date)_"&nbsp &nbsp "_detail_"</div>"
    w "<tr>"
    W "<th>#</th><th>time</th>"
    w "<th class=fl1>msg</th>"
    W "<th class=fl1>time resp</th><th>log</th>"
    s btn="<button class='btn' onclick=window.open('strec^ZAA02Gdownload','_blank');> go to files </button>"
    W "<th>result</th><th class=fl1>data file &nbsp &nbsp "_btn_"</th>"
    W "</tr>"
.
    s z1=$Q(^DEBUG("SCH","T",date,key))
        
    while '(z1="") 
        {
        
        s r1=$qs(z1,5) // # 
        s r2=$qs(z1,6) // req, resOK, resError
        
        s str1=@z1 
        s str1= $zcvt(str1,"O","HTML")
        
        s tm1=$ZT($P($P(str1,$C(9),1),",",2),3)
        s log1=$P(str1,$C(9),2)
        s msg1=$P(str1,$C(9),3)
        s fl1=$P(str1,$C(9),4)
        
        if (r2="req") {
                w "<tr>"
                w "<td>"_r1_"</td>"
                w "<td>"_tm1_"</td>"
                w "<td class=fl1>"_log1_"</td>",!
        }
        else  {
                s cl="msg" if r2="resError" s cl="err" 
                w "<td class=fl1>"_tm1_"</td>"
                w "<td>"_log1_"</td>",!
                w "<td class="_cl_">"_msg1_"</td>",!
                W "<td class=fl1>"_fl1_"</td>",!
                w "</tr>",!
       }
        
       
        s z1=$Q(@z1)
        q:z1=""
        q:$qs(z1,4)'=key
        }
    w "</table>",!
 }
 q 
WriteOutNoPermission(usr,action)
  s action=$G(action) s usr=$G(usr)
  w "<font color='STEELBLUE' face='verdana' title='"_usr _" - "_action_"'><br>Access denied. <br>Please verify your security settings.</font>"
  q
.
ST ;ZAA02Gweb 
 N (%,RLC)
 s PageTitle=" Scheduled Tasks"
  
 W "<!DOCTYPE HTML>",!
 W "<html>",!
 W "<head>",!
 W "<meta http-equiv=""X-UA-Compatible"" content=""IE=9"">",!
 D WRITESTYLES
 D WRITESCRIPT 
 W "</head>",!
.
 s usr  = $P($G(^ZAA02GVBUSER("WEB-LOGON",+$H,+$G(RLC)\1)),",",3)
 s tgASP ="" if $$IsASP^ZAA02GUTILS() s tgASP=" &nbsp ASP "
 
.
 W "<body>",!
 W "<div hidden id='rlcBox'>"_RLC_"</div>" ,!
 W "<div><font face='verdana' size='2'>"_$ZDATETIME($H,5) ,!
 W "<br>"
 W " Version: <b> "_$ZDATE($G(^ZAA02GVBSYS("VER","SERVER")),5)_"</b></font>"
 s patchVer=$P($G(^ZAA02GVBSYS("VER","SERVER")),"`",2) 
 if $L(patchVer) w " <b>(patch "_$E($ZDATE(patchVer,1),1,5)_")</b>"
 W "&nbsp &nbsp Server:  "_$ZU(110)_" &nbsp   ",!
 W "<b>"_tgASP_"</b>",!
 W "</div>" ,!
 
 s processRunning="<font color='red'>ZAA02GVBREP is not running</font>"
 if $$chkProcess^ZAA02GUTILS("ZAA02GVBREP","") s processRunning="ZAA02GVBREP is running"
.
 s ent1name=" Entity 1 : "_$P($G(^PRMG(1,1)),":",2)
 
 W " <div title='"_ent1name_" 'id='processRunStatus'>"_processRunning_" in "_$zu(5)_" <img height='16px' src='help2.png' onclick='alert("""_ent1name_""");'> ",!
 W "</div>", !
 
 W "<br>",!
 w "<div class='hdr1'>"_PageTitle,!
 W " &nbsp &nbsp &nbsp  &nbsp <button class=btn onclick='togglePending(1)')>see waiting to run</button>"
 W " &nbsp  &nbsp <button class=btn onclick='toggleAllGroups(1)')>see scheduled groups</button>"
.
 w " </div><br>",!
.
 W "<div class='bx2' hidden id='pendingBox'>" , !
 W "    <div class='titleLog2'>Waiting to run<button style='float:right' onclick='togglePending(0)'>close</button></div>",!
 W "    <br><div id='pending'></div>",!
 W "</div>",!
 
 W "<div class='bx2' hidden id='allGroupsBox'>" , !
 W "    <button style='float:right' onclick='toggleAllGroups(0)'>close</button>",!
 W "    <br><div id='allGroups'></div>",!
 W "</div>",!
.
.
 w "<div class='hdr2'><b>The most recent Emdeon communication by task</b> </div><br>",!
 d GETCURRENT
.
.
 w "<br><div class='hdr2'>Daily Logs </div><br>",!
 w "<div class='curr'>", !
 W "    <button class='btn1' onclick=showOneDay(document.getElementById('dayFrom').value,document.getElementById('dayTo').value)>show logs</button>",!
 W "    &nbsp &nbsp from T- <input id='dayFrom' value='' size='4'>&nbsp &nbspto T- <input id='dayTo' value='' size='4'>" , !
 w "    &nbsp &nbsp leave empty to see today,  '1' for yesterday, etc ",!
 w "</div>", !
 w "<div id='res' class='curr'>...</div>", !
 
 W "</body>",!
 W "</html>",!
.
 Q 
.
.
WRITESTYLES 
 W "<style type='text/css'>", !
 W "body {--darkBlue1:#396a93;--lightBlue1:#91b6d4 ;} ", !
 W "body {  font-size: 12px; font-family: verdana; color:#333; } ", !
 W "div.titleLogCenter {text-align:center; padding:12px 0 12px 0; color:white; font-weight:bold;background-color:#91b6d4;}",!
 
 W "button.btn {height:25px;line-height:20px; background-color:buttonface; font-family:Verdana;text-align:center;} ",!
.
 W "       input {border-color:#396a93;border-style:solid;border-radius:4px; border-width: 1px;padding-left:2px;}", !
.
 W "       button.btn1 {",!
 W "           background-color:STEELBLUE;color:white;",!
 W "           border-radius:8px;padding:4px 4px 4px 4px;font-weight: bold;",!
 W "           min-width:60px; max-height:30px;text-align:center;",!
 W "       }",!
.
 W "div {font-family: Verdana; font-size:small;}",!
 W "div.hdr1 {font-family: Verdana; text-align:center; line-height:40px;color: white ; background-color:#91b6d4; font-size:medium;font-weight:bold;}",!
 W "div.hdr2 {font-family: Verdana; text-align:center; line-height:30px;  color:#396a93; font-size:medium; font-weight:bold; padding:6px;}",!
 W "div.res {font-family: Verdana; color:green; font-size:small;padding:2px;}",!
.
 W "div.titleLog {text-align:left; line-height:20px; color:#396a93; font-weight:bold; padding-top:10px;padding-bottom:10px;}",!
 W "div.titleError {text-align:left; line-height:20px; color:red; font-weight:bold;padding-top:10px;}",!
 W "div.bx2 {margin-bottom:16px; margin-left:12px; padding:12px; border-style:solid; border-width:1px; border-color:#396a93; background-color:whitesmoke;}",!
 W "div.titleLog2 {text-align:center; color:coral; font-weight:bold; padding:6px;}",!
.
 W "td.err {color:red;} ",!
 
 W "table.list {font-family:Verdana;font-size:small;border-collapse:collapse;}",!
 W "table.list td,th {word-wrap: break-word; border:1px solid rgb(200,200,200); padding:4px 4px 4px 4px;} ", !
 W "table.list th{ color:#396a93; } ", !
.
 w ".fl1 {display:none;}",!
 
 W ".params { width:300px; max-width:300px;}", !
 
.
 W " </style>"
 q
.
WRITESCRIPT
 W "<script>",!
 
toggleCol
 W " function toggleCol(btn) {  var curr = btn.innerHTML; ",!
 W " var elements = document.getElementsByClassName('fl1'); ", !
 W " if (curr=='hide detail') { st='none'; newCaption='show detail';} else {st='table-cell'; newCaption='hide detail'}; ", !
 
 W " for (var i = 0; i < elements.length; i++){", !
 W "    elements[i].style.display = st; ", !
 W " }", !
 W " var btns = document.getElementsByClassName('btnToggleCol');", !
 W " for (var i = 0; i < btns.length; i++){", !
 W "    btns[i].innerHTML=newCaption;  ", !
 W "    }", !
 W " } " , !
 
togglePending
 W " function togglePending(vl) {  var el; el=document.getElementById('pendingBox');  ",!
 W " if (vl == 1) { showPending(); el.style.display = 'inline-block'; return;} ", !
 W " el.style.display = 'none'; ", !
 W "  } "
 
toggleAllGroups
 W " function toggleAllGroups(vl) {  var el; el=document.getElementById('allGroupsBox');  ",!
 W " if (vl == 1) { showSchedule(); el.style.display = 'inline-block'; return;} ", !
 W " el.style.display = 'none'; ", !
 W "  } "
.
showSchedule
 W " function showSchedule() {  "
 W " var res = callCache('READONLY2^ZAA02GRPTSCHW','','','','','','',''); ", !
 W " document.getElementById('allGroups').style.display = 'inline-block';  ", !
 W " document.getElementById('allGroups').innerHTML=res;  ", !
 W "  } " 
showPending
 W " function showPending() {  "
 W " var res = callCache('GETPENDING^ZAA02GRPTSCHW','','','','','','',''); ", !
 W " document.getElementById('pending').innerHTML=res;  ", !
 W "  } "
   
callCache               //call cache routine, routine name plus 7 params
 W "   function callCache(url,param1,param2,param3,param4,param5,param6,param7)",!
 W "   {var params = ""param1="" + param1 + ""&param2="" + param2 + ""&param3="" + param3 + ""&param4="" + param4 + ""&param5="" + param5 + ""&param6="" + param6 + ""&param7="" + param7;",!
 W "    var resp='';",!
 W "    resp = sendData(url, params);",!
 W "    return resp;" ,!
 W "   }",!
 
sendData
 W "   function sendData(href, args)",!
 W "   {"
 W "    var req = new XMLHttpRequest();",!
 W "    var response = '';",!
 W "    req.onreadystatechange = function()",!
 W "       {if (req.readyState == 4)",!
 W "           {response = req.responseText;",!
 W "           }",!
 W "       };",!
 W "    ses=document.getElementById('rlcBox').innerHTML; ", !
 W "    req.open(""POST"", href, false);",!
 W "    req.setRequestHeader('SES',ses) ; ", !
 W "    if (args)",!
 W "       {                                    ",!
 W "        req.send(args);             ",!
 W "       }                                    ",!
 W "    else req.send(null);    ",!
 W "    return response;",!
 W "   }",! 
.
showOneDay
 W " function showOneDay(from,to) { "
 W " if (from=='') from='0'; if (to=='') to='0';" 
 W " var res = callCache('GETLOG^ZAA02GRCMVIEW',from,to,'','','','',''); ", !
 W " document.getElementById('res').innerHTML = res;   ",!
 W " ;} "
showSFTPdays
 W " function showSFTPdays(days) { "
 W " if (days=='') days='0'; " 
 W " var res = callCache('GETLOG2^ZAA02GRCMVIEW',days,'','','','','',''); ", !
 W " document.getElementById('res').innerHTML = res;   ",!
 W " ;} "
 W "</script>",!
 
 Q
 
.
