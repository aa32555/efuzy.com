ZAA02GFAVCOPY;;2018-03-26 13:28:30
        q
WriteOutNoPermission(usr,action)
  s action=$G(action) s usr=$G(usr)
  w "<font color='steelblue' face='verdana' title='"_usr _" - "_action_"'><br>Access denied. <br>Please verify your security settings.</font>"
  q
.
COPY ; ZAA02Gweb
 n from,to
 s from=$G(%("FORM","param1"))
 s to=$G(%("FORM","param2"))
 if $G(to)="***ALL***" M ^DEBUG1("FAVCOPY",$H)=%
.
 w $$CopyFavPrefs(from,to)
 q
 
COPY1 ; ZAA02Gweb 
 n from,to  //insert one item as the first item
 s itm=$G(%("FORM","param1"))
 s oper=$G(%("FORM","param2"))
 
 if $G(to)="***ALL***" 
 w $$InsertFav(itm,oper)
 q
 
GETFAVS ; ZAA02Gweb
 n oper, fav
 s oper=$G(%("FORM","param1"))
 if '$L(oper) q
 w "<br>"
 w "Operator: "_oper
 w "<br><br>"
 w "Favorites: <br><br>"
 w "<select id='favItems' size=10>"
 s fav=$G(^VB("FAV",oper))
 for i=1:1:$L(fav,$C(2,3,4)) {  
        
        s vl= $P(fav,$C(2,3,4),i)
        if i=1 s num=vl ;how many set to visible in horizontal menu
        
        s disp=$P($P(fav,$C(2,3,4),i),$C(9),3)
                //w i_"<br>"_" - "_$P(fav,$C(2,3,4),i)_"<br>"_$P($P(fav,$C(2,3,4),i),$C(9),3)
                if i>1 w "<option value='"_vl_"'>"_disp_"</option>" 
                }
 w "</select>"
 q
 
MakeOperatorsArr(outarr) //for dropdown
        n op n cnt
        s op="" s cnt=0
        s op=$O(^OPG(op)) 
                while '(op="")
                {
                        s cnt=cnt+1 
                        if '(op="~#") s outarr(cnt)=op_$C(9)_op 
                        s op=$O(^OPG(op))
                }
 q
 
InsertFav(itm,to) 
 ;  from:  operator code, to:  ***ALL*** or comma separated list of operators
    n (itm,to)
   
    s itm =$G(itm) s to=$G(to)
    if '$L(itm)||'$L(to) q "0|Invalid parameters"
.
        s lc="abcdefghijklmnopqrstuvwxyz",uc="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    s to=$tr(to,lc,uc)
.
        s cnt=0
        if (to="***ALL***")  
        { 
                s op=""
                s op=$O(^OPG(op))
        
                while '(op="") {  
                        s old=$G(^VB("FAV",op))
                        s num=$P(old,$C(2,3,4),1)+1
                        s $P(old,$C(2,3,4),1)=num
                        s ^VB("FAV",op)=old_$C(2,3,4)_itm
                        s op=$O(^OPG(op))
                        s cnt=cnt+1
                }
        } 
        else { 
                for i=1:1:$L(to,",") {  
                s op=$P(to,",",i) 
                if ($D(^OPG(op))) { 
                                s old=$G(^VB("FAV",op))
                                s num=$P(old,$C(2,3,4),1)
                                s $P(old,$C(2,3,4),1)=num+1
                                s ^VB("FAV",op)=old_$C(2,3,4)_itm
                                s op=$O(^OPG(op))
                                s cnt=cnt+1
                        }
                }
        } 
        q "1|"_"Copied for "_cnt
 
CopyFavPrefs(from,to) 
 ;  from:  operator code, to:  ***ALL*** or comma separated list of operators
    n (from,to)
    
    s from =$G(from) s to=$G(to)
    if '$L(from)||'$L(to) q "0|Invalid parameters"
        s vals=$G(^VB("FAV",from))
.
        s lc="abcdefghijklmnopqrstuvwxyz",uc="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    s to=$tr(to,lc,uc)
.
        s cnt=0
        if (to="***ALL***")  
        { 
                s op=""
                s op=$O(^OPG(op))
        
                while '(op="")
                {
                        k ^VB("FAV",op) 
                        if ($D(^OPG(op))) if ($L(vals)) s ^VB("FAV",op)=vals s cnt=cnt+1 
                        s op=$O(^OPG(op))
                }
        } 
        else { 
                for i=1:1:$L(to,",") {  
                s op=$P(to,",",i) 
                if $L(op) k ^VB("FAV",op) if ($D(^OPG(op))) s cnt=cnt+1 if $L(vals) s ^VB("FAV",op)=vals 
                }
        } 
        q "1|"_"Copied for "_cnt
WriteOutInvalidHandle()
  w "<font color='steelblue' face='verdana'><br>Access denied. <br>Invalid handle, user is not logged in.</font>"
  q     
ST ;ZAA02GWEB
 N (%,RLC)
 W "<!DOCTYPE HTML>",!
 W "<html>",!
 W "<head>",!
 W "<meta http-equiv=""X-UA-Compatible"" content=""IE=9"">",!
 D WRITESTYLES
 D WRITESCRIPT
 W "</head>",!
 
 W "<body>",!
 //W "<div><font face='verdana' size='2'>"_$ZDATETIME($H,5)_"</font></div>" ,!
 W "<div style='display:none;' id='rlcBox'>"_RLC_"</div>" ,!
.
 s lc="abcdefghijklmnopqrstuvwxyz",uc="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 s usr  = $P($G(^ZAA02GVBUSER("WEB-LOGON",+$H,+$G(RLC)\1)),",",3)
 if $L(usr)=0 D WriteOutInvalidHandle Q
 
 s PageTitle="Copy Favorites"
 s action="OP" 
 
 w "<div class='hdr1' title='"_PageTitle_"'>"_PageTitle_"</div>",!
 
 //check user permission, operator access to modify
 if '$L(usr)||'($P($G(^OPG(usr,action)),":",3)) D WriteOutNoPermission(usr,action) Q
.
 W "<br>  <div> Copy from operator "
        n arrList
        D MakeOperatorsArr(.arrList)
        W $$MakeDropdown^ZAA02GSETUTILS2("selFrom",.arrList,"","'ShowFavs()'",1) 
 
 W " &nbsp  to operators &nbsp <input id='txtTo' type='textarea' value='' size=20/> * See note </div>  "  
 W " <div><br><br> * List operator codes separated by comma, or type '***ALL***' to set for everyone. "  
 W " </div>",!
 
 W "<br><br><div><button class='btn' id='btnCopy' "
       W "onclick=CopyPrefs("
       W "document.getElementById('selFrom').value,document.getElementById('txtTo').value)"
       W "> Copy all </button> "_ " &nbsp (copy all favorites from one operator to another)"
       
 W "&nbsp &nbsp &nbsp &nbsp &nbsp <button class='btn' id='btnCopySel' "
       W "onclick=CopyPrefsSel("
       W "document.getElementById('selFrom').value,document.getElementById('txtTo').value)"
       W "> Add one item </button>"_ " &nbsp (add selected item only)"       
       
 W "</div>"
.
 W " <br> <div class='statusSelected' id='statusDisp'>  </div>",!
 W " <div id='favDisp'> </div>",!
 W "</body>"
 W "</HTML>"
  
 Q
 
WRITESCRIPT
 W "<script>",!
.
callCache               //call cache, routine name plus 7 params
 W "   function CallCache(url,param1,param2,param3,param4,param5,param6,param7)",!
 W "   {var params = ""param1="" + param1 + ""&param2="" + param2 + ""&param3="" + param3 + ""&param4="" + param4 + ""&param5="" + param5 + ""&param6="" + param6 + ""&param7="" + param7;",!
 W "    var resp='';",!
 W "    resp = senddata(url, params);",!
 W "    return resp;" ,!
 W "   }",!
 
CopyPrefsSel
 W "   function CopyPrefsSel(from, to) { "
 W "   e=document.getElementById('favItems'); if (e==null) {alert('Nothing selected'); return; }", !
 W "   indx=e.selectedIndex; if (indx<0) {alert('Nothing selected'); return; }",!
 
 W "   vl=e.options[indx].value;  ",!
 W "    var res = CallCache('COPY1^ZAA02GFAVCOPY',vl,to,'','','','',''); ", !
 W " if (res.substr(0,1)!='1') alert(res.substr(2)); ",!
 W " document.getElementById('statusDisp').innerHTML = res.substr(2);   ",!
 W "   } ", !
 
CopyPrefs
 W "   function CopyPrefs(from, to) { "
 W "            var res = CallCache('COPY^ZAA02GFAVCOPY',from,to,'','','','',''); ", !
 W " if (res.substr(0,1)!='1') alert(res.substr(2)); ",!
 W " document.getElementById('statusDisp').innerHTML = res.substr(2);   ",!
 W "   } ", !
 
ShowFavs
 W " function ShowFavs() { "
 W " var oper; oper=document.getElementById('selFrom').value; ", !
 W " var res = CallCache('GETFAVS^ZAA02GFAVCOPY',oper,'','','','','',''); ", !
 W " document.getElementById('favDisp').innerHTML = res;   ",!
 W " if (window.frameElement){ parent.ResizeFrame(); }  " ,! //if runs in iFrame with id='frameX' will be resized
 W " } ", !
.
ScriptCommon
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
 W "    var ses=document.getElementById('rlcBox').innerHTML;  ", !
 W "    req.setRequestHeader('SES',ses) ; ", !
.
 W "    if (args)",!
 W "       { //req.setRequestHeader(""Content-Type"", ""application/x-www-form-urlencoded"");",!
 W "         //req.setRequestHeader(""Content-Length"", args.length);",!
 W "        req.send(args);",!
 W "       }",!
 W "    else req.send(null);",!
 W "    return response;",!
 W "   }",! 
 
 W "</script>",!
 Q
 
WRITESTYLES
 W "<style type='text/css'>",!
 W "div{font-family:Verdana;font-size:small;}",!
 W "input{font-family:Verdana;}",!
 W "button.btn {height:25px; background-color:lightsteelblue; font-family:Verdana;} ",!
 W "div.hdr1 {font-family: Verdana; text-align:center;line-height:40px;color:steelblue; width:100%;font-size:large;}",!
 W "div.statusSelected {margin: 5px; font-weight: bold; font-family: Verdana; padding:4px; font-size:small;color:white;background-color:lightsteelblue;}",!
 W "</style>",!
 q
