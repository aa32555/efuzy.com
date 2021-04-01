ZAA02GLINKS;;2018-08-03 18:02:22
 ; ADS Corp. Copyright
 q
WriteOutNoPermission(usr,action)
  s action=$G(action) s usr=$G(usr)
  w "<font color='steelblue' face='verdana' title='"_usr _" - "_action_"'><br>Access denied. <br>Please verify your security settings.</font>"
  q
 
GETWEBHANDLE2 ; ZAA02Gweb 
 n url, hndl, res
 s url=$G(%("FORM","param1"))
 s hndl=$G(%("FORM","param2"))
 if (url="") q 
 d GetOneTimeValidHandle2(url,hndl)
 q
.
GetOneTimeValidHandle2(url,hndl) ;
 s X="|||"_url
 s HANDLE=hndl
 s HANDLE2=""
 D SETWEB^ZAA02GVBW6B //this one writes out long VB communication formatted string with new url
 Q 
 
MakeLinksArr(outarr) //a list of links to open
        n op n cnt
        s op="" s cnt=1
        s op=$O(^MSCG("WEBOPTIONS",op)) 
                while '(op="")
                {   
                        s cnt=cnt+1 
                        s outarr(cnt)=op
                        s op=$O(^MSCG("WEBOPTIONS",op))
                }
 q
.
.
ST ;ZAA02Gweb 
.
 N (%,RLC)
 s action=""
 s lc="abcdefghijklmnopqrstuvwxyz",uc="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 s usr  = $P($G(^ZAA02GVBUSER("WEB-LOGON",+$H,+$G(RLC)\1)),",",3)
 s action="SYSUTILS" //permission
 
 W "<!DOCTYPE HTML>",!
 W "<html>",!
 W "<head>",!
.
        d WriteOutStyles
        d WriteOutScripts
.
 W "</head>"
 //w "<button onclick='ResizeFrame()'> resize. fr </button> user  "_usr_" &nbsp &nbsp &nbsp  ",!
 //w " RLC "_RLC 
.
 w "<br>"
 
 //check user permission
 if '$L(usr)||'($P($G(^OPG(usr,action)),":",1)) D WriteOutNoPermission(usr,action) Q
 
 s PageTitle="Premier Links"
 n links s links=""
 D MakeLinksArr(.links)
 s hndl=""_RLC_""
 
 s EmptyPageMessage="*** Use UTILS section of System Settings to enable features.***"
 
 ///s x ="""st%5EZAA02Gdownload""" s hndl=""_RLC_""         s xdescr="Reports Files Access"
.
 W "<body>"
 //W "<div><font face='verdana' size='2'>"_$ZDATETIME($H,5)_"</font></div>" ,!
 //w "<div class='hdr1' title='Admin Utilities'>"_PageTitle_"</div>",!
 
 W "<div class='leftmenu'> ",!
        w "<div class='left'> ",!
                                w " <div class='hdr2'><b>Premier Utilities</b></div>",!
                                w " <br>",!
        n i s i=""
        s i=$O(links(i))
        while '(i="")
        {
                s vl=""""_$P($G(links(i)),"==",2)_""""
                s desc=$P($G(links(i)),"==",1)
                                W " <div class='pgOpen'> "
                                W " <button class='pgOpen' onclick='OpenPageInFrame("_vl_","_hndl_")'>"_desc_"</button>   "
                                W " </div>  "  
.
                s i=$O(links(i))
                s EmptyPageMessage=""
        }
.
        w EmptyPageMessage
        w "</div>",!
        
        /* 
        w "<div class='right'> ",!
                                w " <div class='hdr2'>Open in new window</div>",!
                                W " <div class='pgOpen'> "
                                W " <button class='pgOpen' onclick='OpenPageNewWindow("_x_","_hndl_")'>"_xdescr_"</button>   "
                                W " </div>  "  
 
        w "</div>",!
        */ 
        
 w "</div>", !
 
 W "<iframe onload='resizeIframe(this)' name='theFrame' id='frameX'></iframe> ",!
.
 W " </div>"
 W " </body>"
 
 W "</html>"
.
WriteOutScripts
 W "<script>",!
 W " var myWindow; ",!
.
 //W " window.onload = function(){showCurrentConfig(); } ; ", !
 W " window.onbeforeunload = function(){closeChildren(); } ; ", !
.
 W " function closeChildren() { ",!
 W " if (myWindow != undefined)  myWindow.close(); ", !
 W " } "
.
.
getWebHandle2
 W " function getWebHandle2(url,hndl) { ",!
 W " var res = callCache2('GETWEBHANDLE2^ZAA02GLINKS',hndl,url,hndl,'','','','',''); ", !
 W " return res;   ",!
 W " } "
.
OpenPageNewWindow ; 
 W "    function OpenPageNewWindow(url,handle)   {  ",!       
 W "    var link=getWebHandle2(url,handle);     ",! 
 W "    var l = link.length; link=link.substring(10).substring(1,l-22);;        ",! 
 W "    myWindow = window.open('/'+link,'zzzzzzzz','scrollbars=1,menubar=1,status=1,resizable=1,height=400,width=600');  ",! 
 W "    myWindow.name='zzzzzzzz'; ", !
 W "    }; ",! 
.
OpenPageInFrame ; 
 W "    function OpenPageInFrame(url,handle)   {    ",!       
 W "    var link=getWebHandle2(url,handle);  ",! 
 W "    var l = link.length; link=link.substring(10).substring(1,l-22); ",! 
 W "    window.open('/'+link,'theFrame');  ",! 
 W "    }; ",! 
.
ResizeFrame
 W "    function ResizeFrame()  {       ; ",!       
 W "    var obj=document.getElementById('frameX');      ",! 
 W "    if (obj!=null) {resizeIframe(obj)};     ",! 
 W "    }; ",! 
 
.
 W "            function resizeIframe(obj){     ; ",! 
 W "                    obj.style.height = 0;           ; ",! 
 W "                    var h1=obj.contentWindow.document.body.scrollHeight; ",!
 W "            if (h1<900) { h1=900; } obj.style.height = h1 + 'px';           ; ",! 
 W "                    }       ; ",! 
.
callCache2              //URL, RCL, plus 7 params
 W "   function callCache2(url,RLC,param1,param2,param3,param4,param5,param6,param7)",!
 W "   {var params = ""param1="" + param1 + ""&param2="" + param2 + ""&param3="" + param3 + ""&param4="" + param4 + ""&param5="" + param5 + ""&param6="" + param6 + ""&param7="" + param7;",!
 W "    var resp='';",!
 W "    resp = sendData2(url,RLC,params);",!
 W "    return resp;" ,!
 W "   }",! 
.
sendData2
 W "   function sendData2(href, RLC, args)",!
 W "   {    ", !
 W "    var req = new XMLHttpRequest();",!
 W "    var response = '';",!
 W "    req.onreadystatechange = function()",!
 W "       {if (req.readyState == 4)",!
 W "           {response = req.responseText;",!
 W "           }",!
 W "       };",!
 W "    req.open(""POST"", href, false);",!
 W "    if (RLC!='') req.setRequestHeader('SES',RLC) ; ", !
 W "    if (args)",!
 W "       {                                    ",!
 W "        req.send(args);             ",!
 W "       }                                    ",!
 W "    else req.send(null);    ",!
 W "    return response;",!
 W "   }",! 
.
.
 W "</script>",!
 Q
.
WriteOutStyles
 
 W "<style type='text/css'>"
.
 W "input{font-family:Verdana;}"
 W "textarea { margin: 0; width:75%; padding: 0; border-width: 1; }"
 W "div {font-family: Verdana;font-size:small; padding:4px;}",!
 W "div.hdr1 {font-family: Verdana; text-align:center;line-height:40px;color:steelblue; font-size:large;}",!
 W "div.hdr2 {font-family: Verdana; color:steelblue; font-size:medium; }",!
 W "div.hdrNotes {font-family: Verdana;  padding:20px; font-size:small;}",!
 W "div.msg2 {font-weight: bold; font-family: Verdana; padding:4px; font-size:small;color:white;background-color:lightsteelblue;}",!
 W "div.msg3 {color:steelblue; width:75%;  margin-left:20px; padding:10px; }",! 
.
 W " iframe {position:absolute;display:inline-block;left:20%;top:10px;",!
 W " width:78%;border:none;background-color:white;border-color:lightsteelblue; ", !
 W " } ",!
.
 W "div.leftmenu {background-color:ghostwhite;width:18%;position:absolute;top:10px;height:90%;}",!
.
.
 W "th {text-align:left; }",! 
 W "table {border-spacing:5px;}",!
 
 W "button.pgOpen, button.pgOpen:focus, button.pgOpen:active {  ",!
 W "    background: none;       ",!
 W "    border-top: 0;  ",!
 W "    border-right: 0;        ",!
 W "    border-bottom: 1px solid #00F;  ",!
 W "    border:left: 0 ;        ",!
 W "    padding:0;      ",!
 W "    font: inherit;  ",!
 W "    color: steelblue ;      ",!
 W "    outline: none;  ",!
 W "    cursor: pointer;        ",!
 W "}   ",!
 
 W "</style>"
.
 Q
 
END //THE END 
  
  
.
