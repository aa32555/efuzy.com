ZAA02GREFMATCHSET ;;2018-03-26 13:27:46
 ; ADS Corp. Copyright
 q
.
GETCURRENT  ;ZAA02Gweb 
    n
    s incr="C"  //default if no  ^MSCG("MNGCR","VIS") no ^MSCG("MNGCR","QTY") no ^MSCG("MNGCR","SCH")   
    if $G(^MSCG("MNGCR","QTY")) s incr="Q"
    if $G(^MSCG("MNGCR","VIS")) s incr="V"
    if $G(^MSCG("MNGCR","SCH")) s incr="S"
.
.
        w "fld-ENTSP:"_$G(^MSCG("MNGCREN"))_$C(9)
.
        w "fld-RFF:"_$G(^ZAA02GVBUSER("CODE","DEFAULTS","RFF",0))_$C(9)_"fld-INCR:"_incr_$C(9)
.
 //by entity
        s ENT=+$O(^PRMG(""))
        while (ENT) { 
.
        s incr1=""
        if $G(^MSCG("MNGCR","QTY",ENT)) s incr1="Q"
        if $G(^MSCG("MNGCR","VIS",ENT)) s incr1="V"
        if $G(^MSCG("MNGCR","SCH",ENT)) s incr1="S"
                w "fld-RFF="_ENT_":"_$G(^ZAA02GVBUSER("CODE","DEFAULTS","RFF",0,ENT))_$C(9)_"fld-INCR="_ENT_":"_incr1_$C(9)
      
                s ENT=+$O(^PRMG(ENT))
        }    
        q
.
SAVE ;ZAA02Gweb 
         n M,val,type,action,record s M="" s val="" s type=""
         if ($L($G(%("BODY"))))=0 w "Missing params." Q
         d GetModel^ZAA02GUTILS(.M,%("BODY"))
         
         s RFF= $G(M("fld-RFF"))
         s INCR= $G(M("fld-INCR"))
         
         ZK ^MSCG("MNGCREN")
         if $G(M("fld-ENTSP")) s ^MSCG("MNGCREN")=$G(M("fld-ENTSP"))
         
         s ^ZAA02GVBUSER("CODE","DEFAULTS","RFF",0)=RFF
.
     ZK ^MSCG("MNGCR","QTY")
     ZK ^MSCG("MNGCR","SCH")
     ZK ^MSCG("MNGCR","VIS")
        
     if (INCR="C") { 
     }
     elseif (INCR="V") { 
        s ^MSCG("MNGCR","VIS")=1
     }
     elseif (INCR="Q") { 
        s ^MSCG("MNGCR","QTY")=1
     }
     elseif (INCR="S") { 
        s ^MSCG("MNGCR","SCH")=1
     }
     
         //by entity
         s ENT=+$O(^PRMG(""))
         while (ENT) { 
                
                s ref1= $G(M("fld-RFF="_ENT))
            s incr1= $G(M("fld-INCR="_ENT))
        
                K ^ZAA02GVBUSER("CODE","DEFAULTS","RFF",0,ENT)
        K ^MSCG("MNGCR","QTY",ENT)
        K ^MSCG("MNGCR","SCH",ENT)
        K ^MSCG("MNGCR","VIS",ENT)
     
        if $L(ref1) s ^ZAA02GVBUSER("CODE","DEFAULTS","RFF",0,ENT)=ref1
.
                if $L(incr1) {  
                if (incr1="C") { //do nothing, this is default
                }
                elseif (incr1="V") { 
                        s ^MSCG("MNGCR","VIS",ENT)=1
                }
                elseif (incr1="Q") { 
                        s ^MSCG("MNGCR","QTY",ENT)=1
                }
                elseif (incr1="S") { 
                        s ^MSCG("MNGCR","SCH",ENT)=1
                }
                }
                s ENT=+$O(^PRMG(ENT))
         }    
        
         if ($L(M("fld-RFF"))) {  
                w "Saved. "
         }
         else {  
                w $$makeErrMsg("Required data is missing, not saved.")   
         } 
 q
 
makeErrMsg(txt) 
        q "<font color='red'>"_txt_"<font>"      
 
WriteOutNoPermission(usr,action)
  s action=$G(action) s usr=$G(usr)
  w "<font color='steelblue' face='verdana' title='"_usr _" - "_action_"'><br>Access denied. <br>Please verify your security settings.</font>"
  q
.
ST ;ZAA02Gweb 
 N (%,RLC)
  
 W "<!DOCTYPE HTML>",!
 W "<html>",!
 W "<head>",!
 W "<meta http-equiv=""X-UA-Compatible"" content=""IE=9"">",!
 D WRITESTYLES
 W "</head>",!
.
 s oneBox=""
 s PageTitle="Referrals Match Setup"
.
 W "<body onload='showCurrentConfig();' >",!
 w "<div class='hdr1'>"_PageTitle_"  </div>",!
 W "<div style='display:none;' id='rlcBox'>"_RLC_"</div>" ,!
.
 w " <div class='btn' style='float:right'>&nbsp  &nbsp  <button class='btn' id='save1' onclick='SaveThis()'>  &nbsp Save Settings &nbsp </button>",!
 W " &nbsp &nbsp <div class='res2' id='resVals'>  </div></div>",!
.
 w "<div class='hdr3'>Select a rule for adding referrals"_"</div>",!
.
        d OptionMatchList(.arr)
        s oneBox="<div class='s5'><table>"
        s oneBox=oneBox_$$MakeDropdown2("fld-RFF",.arr," ","  ")
        s oneBox=oneBox_"</table></div>"
  W oneBox,!
    
 w "<div class='hdr3'>Select method to increment number completed </div>",!
        s oneBox="<div class='s5'><table>"
        d IncrementByList(.arr)
        s oneBox=oneBox_$$MakeDropdown2("fld-INCR",.arr,"  ","  ")
        s oneBox=oneBox_"</table></div>"
    W oneBox,!
 
 s msg=" &nbsp &nbsp Note: When 'Use Scheduling' is selected the number of completed "
 s msg=msg_"<br> &nbsp &nbsp will be incremented <b>only</b> when a referral is added to an appointment. "
 
 W "<div class='curr'>"_msg_"</div>",!
 
 w "<div class='hdr3'>Enable Entity Specific Referrals </div>",!
        s oneBox="<div class='s5'><table>"
        k arr
        s arr(1)=""_$C(9)_"Referrals are not entity specific"
        s arr(2)="1"_$C(9)_"Referrals are per Entity"
        
        s oneBox=oneBox_$$MakeDropdown2("fld-ENTSP",.arr,"  ","  ")
        s oneBox=oneBox_"</table></div>"
    W oneBox,!
 
    
 W "<br>",!
 W "<div class='hdr2'>  Entity Specific </div>",!
 W "<div class='sand' id='groupEntity'>" , !
.
 s ENT=+$O(^PRMG(""))
 while (ENT) { 
        w "<div class='res'>Entity "_ENT_"</div>",!
                d OptionMatchList(.arr)
                s arr(0)=""_$C(9)_" "
                s oneBox="<div class='s5'><table>"
                s oneBox=oneBox_$$MakeDropdown2("fld-RFF="_ENT,.arr,"Rule for adding referrals","  ",200)
                s oneBox=oneBox_"</table></div>"
                W oneBox,!
    
                s oneBox="<div class='s5'><table>"
                d IncrementByList(.arr)
                s arr(0)=""_$C(9)_" "
                s oneBox=oneBox_$$MakeDropdown2("fld-INCR="_ENT,.arr,"Increment completed","  ",200)
                s oneBox=oneBox_"</table></div>"
        W oneBox,!
.
        s ENT=+$O(^PRMG(ENT))
 }
 
 W "</div>",!
.
 w "<br>"
 //W "<div class='curr' id='currDisp'> cur disp</div>",!
.
 W "</body>",!
 
 D WRITESCRIPT
.
WRITESCRIPT 
 
 W "<script src='/premier/ZAA02Gaautil/shared/js/jquery.min.js'></script>",! 
 W "<script>",!
.
SaveThis
 W " function SaveThis() {              " ,!
 W "    var res=getModel2();    ",! 
 W "    var out=sendData('SAVE^ZAA02GREFMATCHSET',res); ", !
 W "    alert(out);     showRes(out) ;  ",!
 W "    showCurrentConfig() ;   ",!
 W "    } ", !
.
getModel2
 w " function getModel2(){  ",!
 w "    var longString=''; var model = {};  ",!
 w "    $('[get-this]').each(function(i){    ",!
 w "        var key = $(this).attr('get-this');    ",!
 w "        var keyValue;   //get value for each type of control                                                                                        ",!
 W "        if ( $(this).prop('type')=='input') {keyValue=$(this).val(); }                                              ",! 
 W "        if ( $(this).prop('type')=='text') {keyValue=$(this).val(); }                                               ",! 
 W "        if ( $(this).prop('type')=='textarea') {keyValue=$(this).val(); }                                           ",! 
 W "        if ( $(this).prop('type')=='password') {keyValue=$(this).val(); }                                           ",! 
 W "        if ( $(this).prop('type')=='select-one') {keyValue=$(this).val(); }                                         ",! 
 W "        if ( $(this).prop('type')=='checkbox'){keyValue=$(this).is(':checked') ;}                           ",! 
 W "        if ( $(this).prop('type')=='radio' ) {keyValue=$(this).is(':checked') ;}                            ",! 
        //check if type is unsupported
        //W "      alert($(this).prop('type') + '\n' + keyValue) ;    ",! 
 W "        model[key] = keyValue;    ",!
 w "    }); " ,!
 w "    return JSON.stringify(model) ",!
 w " };    ",!
.
showRes 
  W "   function showRes(vals) { " 
  W "   document.getElementById('resVals').innerHTML=vals;  ", !
  W "   ; }  ", !
.
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
 W "    req.open(""POST"", href, false);",!
.
 W "    var ses=document.getElementById('rlcBox').innerHTML;  ", !
 W "    req.setRequestHeader('SES',ses) ; ", !
 W "    if (args)",!
 W "       {                                    ",!
 W "        req.send(args);             ",!
 W "       }                                    ",!
 W "    else req.send(null);    ",!
 W "    return response;",!
 W "   }",! 
 
showCurrentConfig
 W " function showCurrentConfig() { "
 //W " var res = callCache('GETCURRENT2^ZAA02GREFMATCHSET','','','','','','',''); ", !
 //W " document.getElementById('currDisp').innerHTML = res;   ",!
 W " res = callCache('GETCURRENT^ZAA02GREFMATCHSET','','','','','','',''); ", !
 W " loadCurrent(res); ", !
 W " } "
.
loadCurrent
 W "  function loadCurrent(res) {  "                            //
 W "   var arr=res.split(String.fromCharCode(9));       ", !
 W "   for ( var i=0;i < arr.length; i++ ) {            ", !
 W "   var tg= arr[i].split(':')[0] ;           ", !
 W "   var vl= arr[i].split(':')[1] ;  // alert(tg + '\n' + vl);        ", !
 W "   if (tg.length>0) { document.getElementById(tg).value = vl;}              } ", !
 W " } "
.
.
 W "</script>",!
.
 Q
 
END //THE END 
  
  
.
WRITESTYLES 
 W "<style type='text/css'>", !
 W "table {font-family:Verdana;font-size:small;border-collapse:collapse;}",!
 W "button.btn { background-color:WhiteSmoke; font-family:arial; color:steelblue;} "
 
 W "div.hdr1 {font-family: Verdana; text-align:center;line-height:40px;color:steelblue; font-size:medium;}",!
 W "div.hdr2 {font-family: Verdana;  background-color: whitesmoke ; text-align:center;color:steelblue; font-size:medium; padding:6px;}",!
 W "div.hdr3 {font-family: Verdana; color:steelblue;  font-size: small ; font-weight:bold; padding:10px;}",!
 W "div.res {font-family: Verdana; color:green;  font-size: small ; padding:10px;}",!
 W "div.res2 {font-family: Verdana; color:green;  font-size: small ; display:inline-block;}",!
 W "div.curr {font-family: Verdana;  font-size:small;padding:4px 4px 4px 10px;}",!
 W "div.s5 {padding:2px 2px 2px 20px;}",!
 W "div.sand {display:block; background-color: whitesmoke ; overflow:auto;padding:2px 12px 12px 12px;}",! 
.
 W " </style>"
 q
 
.
MakeDropdown2(id,M,title,title2,w)  //as a grid row, w is a width of the left title column
 n (id,vals,title,title2,M,w)
 s title2=$G(title2)  s w=$G(w)
 s oneLine=""
 if ($L(w)) s w=" width="_w_"px"
        s oneLine="<tr id='r-"_id_"'><td"_w_">"_title_"</td><td><select get-this='"_id_"' id='"_id_"' value='"_id_"'>"
                s k=""
                s k=$O(M(k))
                while '(k="")
                {       
                        s vl=M(k)
                        s desc=$P(vl,$C(9),2)
                        s vl=$P(vl,$C(9),1)
                        s oneLine=oneLine_"<option value='"_vl_"'>"_desc_"</option>"
                        s k=$O(M(k))
                }
.
        s oneLine=oneLine_"</select>"_title2_"</td></tr>"
 q oneLine
 
MakeChecks(id,M,title,title2,w)  //as a grid row
 n (id,vals,title,title2,M,w)
 s title2=$G(title2) s w=$G(w)
 s oneLine=""
 if ($L(w)) s w=" width="_w_"px"
        s oneLine="<tr id='r-"_id_"'><td"_w_">"_title_"</td><td>"
                s k=""
                s k=$O(M(k))
                while '(k="")
                {       
                        s vl=M(k)
                        s desc=$P(vl,$C(9),2)
                        s vl=$P(vl,$C(9),1)
                        s dataID=id_":"_vl  // each checkbox is tagged with "fieldID:fieldValue "
                        s oneLine=oneLine_"<input type='checkbox' get-this='"_dataID_"' id='"_dataID_"'>"_desc_" "
                        s k=$O(M(k))
                }
.
        s oneLine=oneLine_" "_title2_"</td></tr>"
 q oneLine
.
.
OptionMatchList(arr)            //1 to 9
    k arr
    s arr(1)="0"_$C(9)_"0 &nbsp Do not add automatically"
    s arr(2)="1"_$C(9)_"1 &nbsp Add always, no match required "
    s arr(3)="2"_$C(9)_"2 &nbsp Match Procedure only"
    s arr(4)="3"_$C(9)_"3 &nbsp Match Diagnosis only"
    s arr(5)="4"_$C(9)_"4 &nbsp Match Procedure or Diagnosis"
    s arr(6)="5"_$C(9)_"5 &nbsp Match Procedure and Diagnosis"
    s arr(7)="6"_$C(9)_"6 &nbsp Match Provider"
    s arr(8)="7"_$C(9)_"7 &nbsp Match Department"
    s arr(9)="8"_$C(9)_"8 &nbsp Match all"
        q 
.
IncrementByList(arr)    
    k arr
    s arr(2)="C"_$C(9)_" One per Charge  "
    s arr(3)="V"_$C(9)_" One per Day ( by Visit )"
    s arr(4)="Q"_$C(9)_" Charge Quantity "
    s arr(5)="S"_$C(9)_" Use Scheduling "
        q 
.
