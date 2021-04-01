ZAA02GRPTSCHWSCR ; script for ZAA02GRPTSCHW page;2018-03-13 14:15:29
 Q
WRITESCRIPT 
.
 W "<link rel='stylesheet' href='/premier/JQUERY-DIST/JQUERY-UI-1.8.18.CUSTOM.CSS'> ", !
 W "<script src='/premier/ZAA02Gaautil/shared/js/jquery.min.js'></script>",! 
 W "<script src='/premier/ZAA02Gaautil/shared/js/jquery-ui.js'></script>",! 
.
 W "<script>",!
.
 w " function Hide(){ ",!
 w "         $('.collapse1').hide(); ",!
 w "     }; ",!
 w " function Show(){ ",!
 w "         $('.collapse1').show(); ",!
 w "     }; ",!
.
SaveThis
 W " function SaveThis() { var conf; " ,!
.
 W " if (getMode()=='EDIT') { ", !
 W "            conf=confirm('Apply changes?'); ", !
 W "            if (!conf) return; ", !
 W "    }  ", !
 
 W "    var res=getModel2();alert(res); ",! 
 W "    var res=sendData('SAVE^ZAA02GRPTSCHW',res); ", !
 W "    showRes(res) ;",!
 W "    showCurrentConfig() ;",!
 W "    MODE='VIEW'; showMode();} ", !
.
getModel2
 w " function getModel2(){  ",!
 w "    var longString=''; var model = {};  ",!
 w "    $('[get-this]').each(function(i){    ",!
 w "        var key = $(this).attr('get-this');    ",!
 w "        var keyValue='';   //get value for each type of control                                                                                     ",!
.
 W "        if ( $(this).prop('type')=='input') {keyValue=$(this).val(); }                                              ",! 
.
 W "        if ( $(this).prop('type')=='text') {keyValue=$(this).val(); }                                               ",! 
 W "        if ( $(this).prop('type')=='textarea') {keyValue=$(this).val(); }                                           ",! 
 W "        if ( $(this).prop('type')=='password') {keyValue=$(this).val(); }                                           ",! 
 W "        if ( $(this).prop('type')=='select-one') {keyValue=$(this).val(); }                                         ",! 
 W "        if ( $(this).prop('type')=='checkbox'){keyValue=$(this).is(':checked') ;}                           ",! 
 W "        if ( $(this).prop('type')=='radio' ) {keyValue=$(this).is(':checked') ;}                            ",! 
.
                                        //check if type is unsupported
 W "                            // alert(key + '\n' + '\n' + $(this).val()) ;    ",! 
 W "        model[key] = keyValue;    ",!
 w "    }); " ,!
 
        //add constants for page
 w "    model['PAGEMODE']= currPageMode();    " , !  
 w "    model['USER']= currUser();                      " , !  
 w "    model['RLC']= currRLC();                " , !  
.
 w "    return JSON.stringify(model) ",!
 w " };    ",!
.
clearAll
 w " function clearAll(){  ",!  //always keep USER and RLC values
 w "    $('[get-this]').each(function(i){    ",!
 w "        var key = $(this).attr('get-this'); var keep=false;   ",!
 W "        if ((key=='USER')|| (key=='RLC')) { keep=true;}  ;                                          ",! 
 W "        if (!keep) { ",!
 W "            if ( $(this).prop('type')=='input') {$(this).val(''); }                                                 ",! 
 W "            if ( $(this).prop('type')=='text') {$(this).val(''); }                                                  ",! 
 W "            if ( $(this).prop('type')=='textarea') {$(this).val(''); }                                              ",! 
 W "            if ( $(this).prop('type')=='password') {$(this).val(''); }                                              ",! 
 W "            if ( $(this).prop('type')=='select-one') {$(this).val(''); }                                            ",! 
 W "            if ( $(this).prop('type')=='checkbox'){$(this).prop('checked', false); }                        ",! 
 W "            if ( $(this).prop('type')=='radio' ) { $(this).prop('checked', false); }                                ",! 
 W "        } ; ", !
 w "    }); " ,!
 w " document.getElementById('groupNotes').innerHTML ='' ;",!
 w " showRunType(''); fillDefaults();  };    ",!
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
 W "    var ses=document.getElementById('rlcBox').innerHTML;  ", !
 W "    req.setRequestHeader('SES',ses) ; ", !
 W "    if (args)",!
 W "       {                                    ",!
 W "        req.send(args);             ",!
 W "       }                                    ",!
 W "    else req.send(null);    ",!
 W "    return response;",!
 W "   }",! 
.
getProcessStatus
 W " function getProcessStatus() { "
 W " var res = callCache('GETPROCESS^ZAA02GRPTSCHW','','','','','','',''); ", !
 W " document.getElementById('processRunStatus').innerHTML = res;   ",!
 W " } "
.
currPageMode
 W " function currPageMode() { var mode=0;", ! //returns 0 for reports, 1 for submission
 W " var x=document.getElementById('pageMode').innerHTML; ", !
 W " if (x=='SUBSCH') mode=1;",!
 W " return mode;} "
.
currUser
 W " function currUser() { ", ! 
 W " var x=document.getElementById('USER').value; ", !
 W " return x;} "
currRLC
 W " function currRLC() {  ", ! 
 W " var x=document.getElementById('RLC').value; ", !
 W " return x;} "
 
.
showCurrentConfig
 W " function showCurrentConfig() { "
 W " var mode=currPageMode(); ",  !
 W " var res = callCache('GETLIST^ZAA02GRPTSCHW',mode,'','','','','',''); ", !
 W " document.getElementById('currDisp').innerHTML = res;   ",!
 W " showPending();  document.getElementById('pendingBox').style.display='none';} "
 
showMode
 W " function showMode() { document.getElementById('MODE').value = MODE; ", !
 W " var el1=document.getElementById('editTag'); ", !
 W " switch(MODE) {             ", !
 W "    case 'VIEW':                    ", !
 W "    case 'EDIT':                    ", !
 W "            tg='';      ", !
 W "            document.getElementById('btnToggleDetail').style.display='block'; ",!
 W "            document.getElementById('fld0').style.background ='whitesmoke'; ",!
 W "            document.getElementById('fld0').style.borderWidth ='thin'; ",!
 W "            document.getElementById('fld0').readOnly = true ; ",!
 W "            el1.innerHTML =''; el1.style.backgroundColor='transparent'; ",!
 W "            document.getElementById('btnClear').style.visibility = 'hidden'; ",!
 W "            break;         ", !
 W "    case 'ADD':                     ", !
 W "            el=document.getElementById('btnToggleDetail');  ",!
 W "        el.style.display='none'; el.innerHTML='Hide Detail'; ", !
 W "            document.getElementById('groupDetail').style.display='block';           ", !
 W "            document.getElementById('fld0').style.background ='white'; ",!
 W "            document.getElementById('fld0').style.borderWidth ='thin'; ",!
 W "            document.getElementById('fld0').readOnly = false ; ",!
 W "            el1.innerHTML ='New Group';                     ", !
 W "            el1.style.backgroundColor='whitesmoke'; ",!
 W "            document.getElementById('btnClear').style.visibility = 'visible'; ",!
 W "            break;         ", !
 W "    default:                                ", !
 W "            tg='...';    break;         ", !
 W "            } "                                     , !
 W "    } ",!
 
getMode
 W " function getMode() { return MODE;} ",!
.
actOnClick
  W "   $(function() { " , !
  W "       $( '.calendar' ).datepicker(); ", !
  W "   }); ", !
.
 W " ",! //select row in grid
 W "      $( 'body' ).on( 'click', 'td.groupName', function() {         ",!
 W "        showGroup( $( this ).text() );                                              ",!
 W "      });           ",!
.
 W " ",! //select row in grid
 W "      $( 'body' ).on( 'click', 'td.oneReport', function() {         ",!
 W "        showOneReport( $( this ).text() );                                          ",!
 W "      });           ",!
.
 W " ",! //dropdown select
 W "      $('body').on('change','.selectGroup',function(){ "
 W "          showGroup($( this ).val()); "
 W "      });  "
.
 W " ",! //keyup
 W "      $('body').on('keyup','',function(){ "
 W "          checkRequired();  "
 W "      });  "
.
 W " ",! //mousedownp
 W "      $('body').on('mousedown','',function(){ "
 W "          checkRequired();  "
 W "      });  "
.
 
 W " ",! //dropdown select
 W "      $('body').on('change','#fld4-1',function(){ "
 W "          showRunType($( this ).val()); "
 W "      });  "
 W " ",! //dropdown select
 W "      $('body').on('change','#fld4-7',function(){ "
 W "          showMonthly($( this ).val()); "
 W "      });  "
.
runNow
 W " function runNow(group, ent) { "
 W " var res = callCache('RUNNOW^ZAA02GRPTSCHW',group,ent,currPageMode(),'','','',''); ", !
 W " document.getElementById('runOnceRes').innerHTML=res;  ", !
 W "  } "
.
deleteGroup
 W " function deleteGroup(group) { "
 W " if (!(confirm('\'' +group + '\' will be deleted' + '\n' +'Are you sure?'))) return; ", !
 W " var res = callCache('DELETEGROUP^ZAA02GRPTSCHW',group,currPageMode(),'','','','',''); ", !
 W " document.getElementById('runOnceRes').innerHTML=res;  ", !
 W " showCurrentConfig(); unselectRows(); ", !
 W "  } "
.
toggleStatus
 W " function toggleStatus(curr) {      "
 W " var req=1; if (curr=='1') req=0;   ", !
 W " var res = callCache('STARTSTOP^ZAA02GRPTSCHW',req,'','','','','',''); ", !
 W " document.getElementById('currStatus').value=res;  ", !
 W " showRunningStatus(res);  ", !
 W " alert('Status : ' + document.getElementById('currStatusLabel').textContent); } "
 
showRunningStatus
 W " function showRunningStatus(st) { "
 W " var s1='<font color=red> stopped </font>'; var s2='Start'; ", !
 W " if (st=='1') { s1='running'; s2='Stop'; }", ! 
 
 W " document.getElementById('currStatus').value=st;  ", !
 
 W " document.getElementById('currStatusLabel').innerHTML=s1; ", !
 W " document.getElementById('btnStartStop').innerHTML=s2; ", !
 W " } "
.
showOneReport
 W " function openRep(id) {  "
 W " var groupName = document.getElementById('thisGroup').innerHTML; ", !
 W " var rlc= document.getElementById('RLC').value; ", !
 W " var res = callCache('SETTEMP^ZAA02GRPTSCHW',rlc,groupName,id,currPageMode(),'','',''); ", !
 //W " alert('will open report settings \n report #:' + id + '\n group name: ' + groupName +  '\n rlc: ' + rlc + '\n\n' + 'temp id to use: ' + res);  ", !
 W " window.open('mwn^ZAA02Gvbw6r?report3s^ZAA02Gvbw6r?'+res,'Report_Settings','resizable=0,scrollbars=1,menubar=0,height=700,width=600') ", !
 W "  } "
.
deleteRep
 W " function deleteRep(id,descr) {  "
 W " var str1='Report'; if (currPageMode()) str1='Item'; conf=confirm(' ' + str1 +' \'' + descr + '\' will be deleted from the group.'); ", !
 W "            if (!conf) return; ", !
 W " var thisGroup =document.getElementById('thisGroup').innerHTML;   ", !
 W " var res = callCache('DELETEREP^ZAA02GRPTSCHW',thisGroup,id,currPageMode(),'','','',''); ", !
 W " showGroup(thisGroup); ", !
 W " document.getElementById('runOnceRes').innerHTML=res;  } "
.
moveRep
 W " function moveRep(up,id) {  "
 W " var thisGroup =document.getElementById('thisGroup').innerHTML;   ", !
 W " var res = callCache('MOVEREP^ZAA02GRPTSCHW',thisGroup,id,up,currPageMode(),'','',''); ", !
 W " showGroup(thisGroup); ", !
 W " document.getElementById('runOnceRes').innerHTML=res;  } "
.
suspendRep
 W " function suspendRep(id) {  "
 W " var thisGroup =document.getElementById('thisGroup').innerHTML;   ", !
 W " var newCheckState =document.getElementById('rep-chk-' + id).checked;   ", !
 W " var on=0;  if (newCheckState) on=1;", !
 W " var res = callCache('SUSPENDREP^ZAA02GRPTSCHW',thisGroup,id,on,currPageMode(),'','',''); ", !
 W " showGroup(thisGroup); ", !
 W " document.getElementById('runOnceRes').innerHTML=res;  } "
.
showPending
 W " function showPending() {  "
 W " var res = callCache('GETPENDING^ZAA02GRPTSCHW','','','','','','',''); ", !
 W " document.getElementById('pending').innerHTML=res;  ", !
 W "  } "
switchPageMode //todotodoto Clear Detail; Clear Report list in group; hide "show detail", change captions
 W " function switchPageMode() { "
 W " var newVal='SUBSCH'; var newTitle='Insurance'; str1='switch to Reports'; ", !
 W " if (currPageMode()) { newVal='RPTSCH'; str1='switch to Insurance'; newTitle='Reports'; } ", !
 w " document.getElementById('btnStartStop').innerHTML=str1; ", !
 W " document.getElementById('pageMode').innerHTML=newVal ; ", !
 W " document.getElementById('pageTitle').innerHTML=newTitle ; ", !
 W " showCurrentConfig(); unselectRows(); fillDefaults(); clearAll(); showGroup('');", !
.
 W " document.getElementById('groupDetail').style.display = 'none';  ", !
 W " document.getElementById('btnToggleDetail').innerHTML='Show Detail';", !
 W " document.getElementById('btnToggleDetail').style.display='none'; ", !
 W " } ", !
togglePending
 W " function togglePending() {  var el; el=document.getElementById('pendingBox');  ",!
 W " if (el.style.display == 'none') { showPending(); el.style.display = 'inline-block'; return;} ", !
 W " el.style.display = 'none'; ", !
 W "  } "
 
toggleDetail
 W " function toggleDetail() {  var el; el=document.getElementById('groupDetail');  ",!
 W " if ((el.style.display == 'none')|| (el.style.display == '')) { ", !
 W "    el.style.display = 'block'; ", !
 W "    el=document.getElementById('btnToggleDetail'); el.innerHTML='Hide Detail'; } ", !
 W " else {      ", !
 W "    el.style.display = 'none'; el=document.getElementById('btnToggleDetail'); el.innerHTML='Show Detail'; }", !
 W "  } ", !
.
showGroup
 W " function showGroup(id) {  "
.
 W " if (id=='') { res='';}   ", !
 W " else { var res = callCache('GETDETAIL^ZAA02GRPTSCHW',id,currPageMode(),'','','','','') ;} ;", !
.
 W "    document.getElementById('thisGroup').innerHTML=id;  ", !
 W "    document.getElementById('oneGroupReports').innerHTML=res; ", !
 W "    document.getElementById('runOnceRes').innerHTML=''; ", !
 W "    selectRow(id); showRes(''); showOneGroup(id); MODE='VIEW'; showMode(); checkRequired(); } "
.
allHide
 W " function allHide() {  "
 W "    document.getElementById('r-fld4-5').style.display='none';  ", !
 W "    document.getElementById('r-fld4-6').style.display='none';  ", !
 W "    document.getElementById('r-fld4-7').style.display='none';  ", !
 W "    document.getElementById('r-fld4-8').style.display='none';  ", !
 W "    document.getElementById('r-fld4-9').style.display='none';  ", !
 W "    document.getElementById('r-fld4-10').style.display='none';  ", !
 W "    }", !
 
showMonthly
 W " function showMonthly(id) {  "
 W " switch(id) {               ", !
 W "  case '':                  ", !
 W "    document.getElementById('fld4-8').disabled =false;  document.getElementById('fld4-9').disabled=false;    ", !
 W "    break; ", !
 W "  default:                                  ", !
 W "    document.getElementById('fld4-8').disabled =true;  document.getElementById('fld4-9').disabled=true;    ", !
 W "    document.getElementById('fld4-8').value ='';  document.getElementById('fld4-9').value =''; ", ! 
 W "    break; } "
 W " ;} "
showRunType
 W " function showRunType(id) {  "
 W " switch(id) {               ", !
 W "  case '':  case 'O':                       ", !
 W "    allHide();  ", !
 W "    break; ", !
 W "  case 'D':                         ", !
 W "    allHide();  ", !
 W "    document.getElementById('r-fld4-5').style.display='';  ", !
 W "    break;         ", !
 W "  case 'W':                         ", !
 W "    allHide();  ", !
 W "    document.getElementById('r-fld4-5').style.display='';  ", !
 W "    document.getElementById('r-fld4-6').style.display='';  ", !
 W "    ;    break;                     ", !
 W "  case 'M':                         ", !
 W "    allHide();  ", !
 W "    document.getElementById('r-fld4-7').style.display='';  ", !
 W "    document.getElementById('r-fld4-8').style.display='';  ", !
 W "    document.getElementById('r-fld4-9').style.display='';  ", !
 W "    document.getElementById('r-fld4-10').style.display='';  ", !
 W "    ;    break;                     ", !
 W "  default:                                  ", !
 W "    ; alert(id);   break;         ", !
 W "    } "
 W " checkRequired(); " , !
 W " ;} "
.
fillChecks
        // mark checkboxes with id='fldID + value(i)' as checked; values are comma delimited
 W " function fillChecks(fldID,values) {  "
 W " if (values == null) return;    ",!
 W " if (values.length==0) return;    ",!
 W " var arr=values.split(',');      ", !
 W " for (i = 0; i < arr.length; i++) {  " ,!
 W "            var el=document.getElementById(fldID +':' +arr[i]); ", !
 W "            if (el != null) el.checked =true; ", !
 W "    } ", !
 W " }",!
.
showOneGroup //get from server by group name
 W " function showOneGroup(id) { clearAll(); if (id=='') { return; }"
 W " var res = callCache('GETONEGROUP^ZAA02GRPTSCHW',id,currPageMode(),'','','','',''); ", !
.
 W "   var arr=res.split(String.fromCharCode(9)); var runType='';     ", !
 W "   document.getElementById('fld0').value =arr[0];      ", !
 W "   document.getElementById('fld1').value =arr[1];      ", !
 W "   document.getElementById('fld2').value =arr[2];      ", !
 W "   var chkd=false; if (arr[3]=='1') chkd=true; document.getElementById('fld3').checked =chkd;      ", ! //checkbox
.
 W "   document.getElementById('fld8').value =arr[8];      ", !
.
 W "   if (arr[4].length>0) { var arr2=arr[4].split(String.fromCharCode(10));      ", !
 W "   document.getElementById('fld4-0').value =arr2[0];      ", !
.
 W "var notActive=' ***SUSPENDED*** '; if (chkd) notActive='' ; ", ! 
 W "   document.getElementById('groupNotes').innerHTML =notActive + arr2[0];      ", !
.
 W "   document.getElementById('fld4-1').value =arr2[1]; runType=arr2[1];      ", !
 W "   document.getElementById('fld4-2').value =arr2[2];      ", !
 W "   document.getElementById('fld4-3').value =arr2[3];      ", !
 W "   document.getElementById('fld4-4').value =arr2[4];      ", !
 W "   document.getElementById('fld4-5').value =arr2[5];      ", !
 W "   fillChecks('fld4-6',arr2[6]);    //document.getElementById('fld4-6').value =arr2[6];      ", !
 W "   document.getElementById('fld4-7').value =arr2[7];      ", !
 W "   document.getElementById('fld4-8').value =arr2[8];      ", !
 W "   document.getElementById('fld4-9').value =arr2[9];      ", !
 W "   fillChecks('fld4-10',arr2[10]);  // document.getElementById('fld4-10').value =arr2[10];      ", !
 W "  } ", !
.
 W "   if (arr[5].length>0) {var arr2=arr[5].split(String.fromCharCode(10));      ", !
 W "   document.getElementById('fld5-0').value =arr2[0];      ", !
 W "   document.getElementById('fld5-1').value =arr2[1];      ", !
 W "   document.getElementById('fld5-2').value =arr2[2];      ", !
 W "   document.getElementById('fld5-3').value =arr2[3];      ", !
 W "  } ", !
.
 W "   if (arr[6].length>0) {var arr2=arr[6].split(String.fromCharCode(10)); ", !
 W "   document.getElementById('fld6-0').value =arr2[0];      ", !
 W "   if (arr2[1]==undefined) arr2[1]=''; document.getElementById('fld6-1').value =arr2[1];      ", !
 W "  } ", !
.
 W "   if (arr[7].length>0) {var arr2=arr[7].split(String.fromCharCode(10));      ", !
 W "   document.getElementById('fld7-0').value =arr2[0];      ", !
 W "   if (arr2[1]==undefined) arr2[1]=''; document.getElementById('fld7-1').value =arr2[1];      ", !
 W "   if (arr2[2]==undefined) arr2[2]=''; document.getElementById('fld7-2').value =arr2[2];      ", !
 W "   showRunType(runType); } ", !
.
 W " } "
.
addGroup
.
 W " function addGroup() { ", !
 W "    var type=document.getElementById('fld4-1').value ; ",!
 W "    MODE='ADD'; showRunType(type); showMode(); showRes(''); "
 W "    for (k=0;k<3;k++) { ", !
 W "            var el = document.getElementById('fld'+k); el.value='';  ", ! 
 W "            document.getElementById('fld4-0').value='';   }  ",!
 W "    checkRequired();} "
.
.
selectRow
 W " function selectRow(id) { ", !
 W " unselectRows();", !
 W " var tbl=document.getElementById('tblGroups'); ",!
 W " var allRows= tbl.rows; ",!
 W " for (i=0;i<allRows.length;i++) { var r1=allRows[i]; if (r1.cells[0].innerHTML==id) r1.className='selected'; } ;",!
 W " } "
 
unselectRows 
 W " function unselectRows() { " ,!
 W " var tbl=document.getElementById('tblGroups'); ",!
 W " var allRows= tbl.rows; ",!
 W " for (i=0;i<allRows.length;i++) { allRows[i].className=''; } ;",!
 W " } ", !
.
 
fillDefaults
 W " function fillDefaults() { " , !
 W "            var dateobj =new Date();        ", !
 W "            function pad(n) {return n < 10 ? '0'+n : n;}  ", !
 W "            var today = pad(dateobj.getDate())+'/'+pad(dateobj.getMonth()+1)+'/'+dateobj.getFullYear(); ", !
 W " var arr1=today.split('/'); ", !
 W " if (arr1[0].length<2) {arr1[0]='0'+arr1[0];}       ", !
 W " if (arr1[1].length<2) {arr1[1]='0'+arr1[1];} ", !
 W " today=arr1[0]+'/'+arr1[1]+'/'+arr1[2];     ", !
 W "    document.getElementById('fld4-2').value= today ", !
 W "    document.getElementById('fld4-3').value='';  ", !
 W "    document.getElementById('fld4-4').value='7:00 am';   ", !
 W "    document.getElementById('fld5-0').value='F';  ", !
 W "    document.getElementById('fld5-2').value='0';  ", !
 W "    document.getElementById('fld5-3').value='0';  ", !
 W "    document.getElementById('fld6-0').value='X';  ", !
 W "    document.getElementById('fld7-0').value='X';  ", !
 W "    document.getElementById('fld8').value='1';  ", !
 W "    checkRequired();} ", !
.
checkRequired
 W " function checkRequired() {  " , !
 w " saveOn(); ",!
 W "    markReq('fld0');   ", !
 W "    markReq('fld4-2'); markReq('fld4-4');   ", !
 W "    markReq('fld5-1');   ", !
 W "    markReq('fld8');   ", !
.
 W " var runType=document.getElementById('fld4-1').value;", !
 W " switch(runType) {                  ", !
 W "  case '':                  ", !
 W "    markNR('fld4-2'); markNR('fld4-4');   ", !
 W "    break; ", !
 W "  case 'O':                         ", !
 W "    markNR('fld4-2'); markNR('fld4-4');   ", !
 W "    break;         ", !
 W "  case 'D':                         ", !
 W "    markReq('fld4-2'); markReq('fld4-4');  markReq('fld4-5');  ", !
 W "    break;         ", !
 W "  default:                                  ", !
 W "    ; break;         ", !
 W "    } "
.
 W " var tm = document.getElementById('fld4-4').value; res= validateTime(tm); markRED('r-fld4-4',!res);} ", !
.
saveOff
 W " function saveOff() { var btn =document.getElementById('btnSave'); " , ! 
 W " btn.disabled=true; btn.style.background ='gainsboro'; ",!
 W "     document.getElementById('saveStatus').innerHTML=''; }", !
saveOn
 W " function saveOn() {  var btn =document.getElementById('btnSave') ; " , ! 
 W " btn.style.background ='green';  ", !
 W " btn.disabled=false; ",!
 W "     document.getElementById('saveStatus').innerHTML=''; }", !
.
markReq
 W " function markReq(id) { var res=0; " , !  //returns 1 if required is empty, 0 if all OK
 W "    if (document.getElementById(id).value=='') { ", ! 
 W "    document.getElementById(id).style.background='skyblue';res=1;} ", !
 W "    else {document.getElementById(id).style.background='white'; res=0} ; ", !
 W "    if(res) saveOff(); ", !
 W "    return res; } ", !
markRED
 W " function markRED(id,invalid) {  " , !  //returns 1 if required is empty, 0 if all OK
 W "    if (invalid) {document.getElementById(id).style.background='salmon';} else {document.getElementById(id).style.background='none';} ", !
 W "    if (invalid) saveOff();; ", !
 W "     } ", !
markNR
 W " function markNR(id) {  " , !
 W "    document.getElementById(id).style.background='white'; ; ", !
 W "    } ", !
.
.
validateTime
 W " function validateTime(txt) ", !
 W "  { ", !
 W "    // regular expression to match required time format ", !
 W "    re = /^\d{1,2}:\d{2}[ ]?(([aA]|[pP])[mM])?$/; ", !                                                                      ///allow both 4:15am or 4:15 AM
 W "    re = /^(([1][012]:[012345]\d{1})|([0]?\d:[012345]\d{1}))[ ]?(([aA]|[pP])[mM])?$/; ", !  ///allow both 4:15am or 4:15 AM
                                                                                                                        //
 W "    if(txt != '' && !txt.match(re)) { ", !
 W "      //alert('Invalid time format: ' + txt); ", !
 W "      //form.starttime.focus(); ", !
 W "      return false; ", !
 W "    } ", !
.
 W "    return true; ", !
 W "  } ", !
.
.
 W "</script>",!
.
 Q
 
.
