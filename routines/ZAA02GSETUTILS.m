ZAA02GSETUTILS ;;2018-07-06 17:17:10
 ; writes out web page styles, common javascript, 'save settings page' script, configure dictionary page script
 q
WRITESTYLE(debug) 
 W "<style type='text/css'>"
 
 W "    button.LikeLink { "
 W "    background:none!important; "
 W "    border:none;  "
 W "    padding:0!important; "
 W "    border-bottom:1px solid #444;  "
 W "    cursor: pointer; "
 W "                                    } "
 
 W "table, td, th {font-size:small;font-weight:normal;}"
.
 W "tr.grTitle1 { background-color: white; color:steelblue; font-weight:bold; } "               //#d0eed0 #e5f5ff 
.
 W "tr.grh1 { background-color: steelblue; color:white;} "                      // lightblue //#e5f5ff 
 W "tr.grh2 { background-color: #e5e5e5  ; } "                  //#e5f5ff // no color gridheader
 W "td.grC1 { background-color:  #e5e5e5; width:  240px; } "                    //  gainsboro // #e2e2e2 //#e5f5ff
 W "td.grC2 { background-color: GhostWhite ;} "                 //WhiteSmoke  grColReadOnly
 W "td.grColReadOnly { background-color: lightgreen ;} "
 W "td.grEnt { background-color: WhiteSmoke ;} "                //WhiteSmoke
 
 W "select.selectClass {font-family: Verdana; font-size:8pt;  }"
.
 W "div {font-family:Verdana; }"
 W "div.hdr1 {font-family: Verdana; text-align:center;line-height:40px;color:steelblue; width:100%;}"
 W "div.hdr2 {font-family: Verdana; font-size:small; text-align:left;width:100%;}"
 W "div.hdr3 {font-family: Verdana; font-size:small; color:red; text-align:left;width:100%;}"
 W "div.hdr4 {font-family: Verdana; font-size:small; text-align:left; color:darkblue; width:75%; padding-bottom: 10px;}"
 
 W "select {font-family:Verdana;}"
 W "td{font-family:Verdana; font-size:small;}"
 W "button {  background-color:WhiteSmoke;font-family:arial;color:steelblue;} "
 W "button.dbg {  color:brown; background-color:WhiteSmoke;font-family:arial;} "
 W "textarea {font-family:verdana; margin: 0; padding: 0; border-width: 1;}"
 W ".inputbox1  ", !
 W "{ " , !
 W "   border-color:#D3D3D3; background-color: transparent; border-width: 1px; border-style:solid;", !
 W "}", !
 W ".inputbox1:hover", !
 W "{", !
 W "   border-color:black; ", !
 W "}", !
 W ".inputbox1:focus", !
 W "{", !
 W "   border-color:black; ", !
 W "}", !
 W
        if (debug) {    
                //W " td.groupTagItem { font-family:arial;  background-color: Moccasin; } "
                //W " td.setName { font-family:arial;  background-color: Moccasin;} "
                //W " td.swName { font-family:arial;  background-color: mistyrose;} " 
                W " td.groupTagItem {display:none;  } "
                W " td.setName {display:none;  } "
                W " td.swName {display:none;  } "               
                W " td.setNameRO { font-family:arial;  background-color: Moccasin;} "
                W " td.ex3 { font-family:arial;  background-color: lightgrey;} " 
                W " td.ex5 { font-family:verdana; font-size:x-small; } "  // background-color: LightSteelBlue;
                W " td.grEntH { font-size:small; background-color: white;} " 
                W " div.ex1 { background-color: PaleGreen; text-align:center;} " 
                W " div.ex2 { background-color: AliceBlue; font-size:small;} " 
                W " div.ex3 { font-family:verdana;background-color: AliceBlue; font-size:x-small; width:300px;} " 
                W " textarea.ex4 { display:none; font-family:verdana; } " ///{ background-color: AliceBlue;} " 
                }
         else           { 
                W " td.groupTagItem {display:none;  } "
            W " td.grEnt0 {display:none;  } "
                W " td.setName {display:none;  } "
                W " td.swName {display:none;  } " 
                W " td.setNameRO {display:none;  } "
                W " div.ex1 {display:none;  } " 
                W " div.ex2 {display:none;  } " 
                W " div.ex3 {display:none;  } " 
                W " td.ex3 {display:none;  } " 
                W " td.ex5 {display:none;  } " 
                W " td.grEntH {display:none;  } "
                W " textarea.ex4 { display:none; font-family:verdana; border:0px;} " 
                }
 
 W "</style>" ,!
 q
WRITECOMMONSCRIPT
RunCommand
 W "<script>"
 W "   function RunCommand(url,param1,param2,param3,param4,param5,param6)",!
 W "   {var params = ""param1="" + param1 + ""&param2="" + param2 + ""&param3="" + param3 + ""&param4="" + param4 + ""&param5="" + param5 + ""&param6="" + param6;",!
 W "    var resp='';",!
 W "    resp = senddata(url, params);",!
 W "    return resp;" ,!
 W "   }",!
SendData
 W "   function senddata(href, args)",!
 W "   { "
 W "    var req = new XMLHttpRequest();",!
 W "    var response = '';",!
 W "    req.onreadystatechange = function()",!
 W "       {if (req.readyState == 4)",!
 W "           {response = req.responseText;",!
 W "           }",!
 W "       };",!
 W "    req.open(""POST"", href, false);",!
.
 W "    var ses=document.getElementById('rlcBox').innerHTML;  ", !
 W "    req.setRequestHeader('SES',ses) ; ", !
.
 W "    if (args)",!
 W "       {//req.setRequestHeader(""Content-Type"", ""application/x-www-form-urlencoded"");",!
 W "        //req.setRequestHeader(""Content-Length"", args.length);",!
 W "        req.send(args);",!
 W "       }",!
 W "    else req.send(null);",!
 W "    return response;",!
 W "   }",! 
 W "</script>"
 q 
 
WRITESAVESETTINGSSCRIPT(url1,url2) ;
 W "<script>",!
IE8Support 
 w " function getElementsByClassName(className) {                                       ",!
 w " if (document.getElementsByClassName) {                                             ",!
 w " return document.getElementsByClassName(className); }                       ",!
 w " else {return document.querySelectorAll('.' + className); } }       ",!
 
 
SaveFlag ; returns 'OK' or error  message
.
 W "    function SaveFlag(tag) "
 W "    { var NewVal; var Address; var reportData; ",! 
 W "            NewVal=document.getElementById(tag).checked ; ", !
 W "        Address=document.getElementById(tag+'-Addr').innerHTML ; ", !
   W "          if ( NewVal > 0 )                       {               ",!
   W "         NewVal='ADD';                            " ,!
   W "          } else    {             ",!
   W "         NewVal='DEL';    " ,!
   W "          }               ",!
 W "        reportData = RunCommand('"_url1_"',NewVal,Address,'','','',''); ",! ; RunCommand returns 'OK' is all good
 W "            return reportData;", !
 W "    }", ! 
.
SaveValue ; returns 'OK' or error  message
                ; if tag starts with "E" - empty value is allowed
                ; if tag starts with "D" and value is an empty string - delete this entry 
 
 W "    function SaveValue(tag) "
 W "    { var NewVal; var Address; var reportData; var msg ='Required parameters are missing.' ; ",! 
.
 W "            NewVal=document.getElementById(tag).value ; ", !
 W "        Address=document.getElementById(tag+'-Addr').innerHTML ;                                            ", !
.
 W "        if ( NewVal=='' ) ",! 
 W "            {                                                                                                                                                               ",!
 W "                    if (tag.substr(0,1)=='E') {}    //allow empty for E tags, proceed to save       ", !  
 
 W "                    else if (tag.substr(0,1)=='D')  //D tag, delete this entry if empty                             ", !  
 W "                    {                                                                                                                                                       ", !  
 W "                            reportData = RunCommand('"_url1_"','DEL',Address,'','','','');                  ", !  
 W "                            return reportData;                                                                                                              ", !  
 W "                }                                                                                                                                                   ", !  
.
 W "                    else {return msg;}                                                                                                                      ", !  
.
 W "            }                                                                                                                                                               ", !  
.
 W "        reportData = RunCommand('"_url2_"',NewVal,Address,'','','',''); ",! ; RunCommand returns 'OK' if all good
 W "        return reportData;",!
 W "    }", ! 
ApplySettings
 
 W "    function ApplySettings() "  ;;;get all items of class flagId and setId, save setting/flags for each value 
 W "    {       var allFlags; var allValues; var reportData=''; var res =''; var tg=''; var Err =false;                                 ",! 
 W "            allFlags = getElementsByClassName('swName') ;                   ", !
 W "            allValues = getElementsByClassName('setName') ;                 ", !
   W "                                                                                                                                  ",! 
   W "     for (i=0;i<allFlags.length;i++)                                                                      ",! 
   W "     {                                                                                                                            ",! 
   W "                  tg= allFlags[i].innerHTML;                                                              ",! 
   W "                  res=SaveFlag(tg);                                       ",! 
   W "          if (res!='OK') { Err=true;              ", !
   W "                          document.getElementById(tg).parentElement.style.backgroundColor='pink';  ", !
   W "                          document.getElementById(tg).style.backgroundColor='pink';  ", !
   W "                          reportData=reportData + tg +': ' + res + '\n' ; }                       ",! 
   W "      }                                    ",! 
.
   W "     for (i=0;i<allValues.length;i++)                                                                     ",! 
   W "     {                                                                                                                            ",! 
   W "                  tg= allValues[i].innerHTML;                                                                     ",! 
   W "                  res=SaveValue(tg);              ",! 
   W "                  if (res!='OK') { Err=true;      ", ! 
   W "                  document.getElementById(tg).parentElement.style.backgroundColor='pink';    ", !
   W "                  document.getElementById(tg).style.backgroundColor='pink';  ", !
   W "                  reportData=reportData + tg +': ' + res + '\n' ; }                                       ",! 
   W "      }                                    ",! 
   
 W "                                                    ; ", !
 W "        if (Err) {",!
   W "          alert( reportData) ;                                     ",! 
   W "          document.getElementById('res').value='*** ERROR ***\n' + reportData;    ",! 
   W "                  document.getElementById('warning').style.display='block';document.getElementById('res').style.display='block'; document.getElementById('res').style.color='red';} ",!
   W "          else {document.getElementById('warning').style.display='none';document.getElementById('res').style.display='none'; alert('Saved.'); }",! 
 W "    }", ! 
.
 W "</script>",!
 q
 
.
