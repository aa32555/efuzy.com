ZAA02GRPTSCHW;;2018-08-06 12:43:45
 ; ADS Corp. Copyright
 q
.
SETTEMP ; ZAA02Gweb 
 s rlc=$G(%("FORM","param1"))
 s grp=$G(%("FORM","param2"))
 s report=$G(%("FORM","param3"))
 s mode=$G(%("FORM","param4"))
 s AA="RPTSCHW"
 if mode s AA="SUBSCHW"
.
 s id=$P($H,",",2)  
 if ($D(^ZAA02GTVB(+rlc,"RPTSCHW",id))) s id=$O(^ZAA02GTVB(+rlc,"RPTSCHW",""),-1) + 1 
 SET ^ZAA02GTVB(+rlc,"RPTSCHW",id)=grp_"`"_report_"`"_mode
 w id
 q
 
isProcessRunning()
 s processRunning="<font color='red'>ZAA02GVBREP is not running</font>"
 if $$chkProcess^ZAA02GUTILS("ZAA02GVBREP","") s processRunning="ZAA02GVBREP is running"
 q processRunning
.
WriteOutNoPermission(usr,action)
  s action=$G(action) s usr=$G(usr)
  w "<font color='steelblue' face='verdana' title='"_usr _" - "_action_"'><br>Access denied. <br>Please verify your security settings.</font>"
  q
.
READONLY ; ZAA02Gweb  //list all groups
 d WRITESTYLES
 W "<body>"
 w "<div class='hdr1'>Scheduled Reports </div>",!
 d GETLIST
 w "<div class='hdr1'>Scheduled Insurance  </div>",!
 s %("FORM","param1")=1
 d GETLIST
 w "<style> td {font-size:small;} td.h1 {display:table-cell;} div.hdr1 {color:coral;font-size:medium;} </style> ",!
 w "</body>",!
 q
.
READONLY2 ; ZAA02Gweb  //list all groups
 w "<div class='titleLog2'>Insurance </div>",!
 s %("FORM","param1")=1
 d GETLIST
 s %("FORM","param1")=0
 w "<div class='titleLog2'>Reports</div>",!
 d GETLIST
 q
.
.
.
DELETEREP ; ZAA02Gweb 
 n res,grp,id
 s res="", grp="", id=""
 s grp=$G(%("FORM","param1"))
 s id=$G(%("FORM","param2"))
 s mode=+$G(%("FORM","param3"))
 
 if (('$L(grp)) ||('$L(id))) w " Parameters missing" q
 if mode { 
        s AA="^SUBSCH"
        if '($G(@AA@("GRP",grp,id))) w " Task "_id_" not found in the group." q
 }
 else { 
        s AA="^RPTSCH"
        if '($G(@AA@("GRP",grp,id))) w " Report "_id_" not found in the group." q
 }
 s report=$P($G(@AA@("GRP",grp,id)),"`",3)
 s X="||||"_grp_"|"_report
 w "<font color=red>*** NOT IMPLEMENTED ***</font>"
 q
 
 s res=$$SetDelRpt^ZAA02GVBREP()
 w "deleted: "_res
 q
.
MOVEREP ; ZAA02Gweb 
 n res,grp,up,id,tmp,GLB s res="", grp="", up="", id="", GLB=""
 s grp=$G(%("FORM","param1"))
 s id=$G(%("FORM","param2"))
 s up=$G(%("FORM","param3"))
 s mode=+$G(%("FORM","param4"))
 s GLB="^RPTSCH" if mode s GLB="^SUBSCH"
 
 if (('$L(grp)) ||('$L(id))) w " Parameters missing" q
 if '($G(@GLB@("GRP",grp,id))) w " Report not found in the group" q
 if ($ZABS(up)='1) w " Parameters invalid" q
.
 s new=$O(@GLB@("GRP",grp,id),up) 
 if (new="") w "Cannot move "_$S((up=-1):"up",(up=1):"down",1:", error") q
.
 m tmp=@GLB@("GRP",grp,new)                                     
 k @GLB@("GRP",grp,new) m @GLB@("GRP",grp,new)=@GLB@("GRP",grp,id)      
 k @GLB@("GRP",grp,id)  m @GLB@("GRP",grp,id)=tmp
 w " "
 q
.
SUSPENDREP ; ZAA02Gweb 
 n res,grp,up,id,tmp s res="", grp="", up="", id=""
 s grp=$G(%("FORM","param1"))
 s id=$G(%("FORM","param2"))
 s on=$G(%("FORM","param3"))
 if (('$L(grp)) ||('$L(id))) w " Parameters missing" q
.
 s mode=+$G(%("FORM","param4"))
 if mode { 
        if '($G(^SUBSCH("GRP",grp,id))) w " Task not found in the group" q
        s $P(^SUBSCH("GRP",grp,id),"`",5)=on
        w " "_$S(on:"Task enabled",1:"Task suspended") 
        }
 else {  
        if '($G(^RPTSCH("GRP",grp,id))) w " Report not found in the group" q
        s $P(^RPTSCH("GRP",grp,id),"`",5)=on
        w " "_$S(on:"Report enabled",1:"Report suspended")
 }
 q
 
GETPENDING ; ZAA02Gweb  writes out current configuration in a table
 w "<div style='float:left;position:relative;top:0;'>",!
 w $$getPending("^RPTSCH","Reports")
 w "</div>",!
 w "<div>  </div>",!
 w "<div style='float:left;position:relative;top:0;margin-left:2px;margin-top:10px;'>",!
 w $$getPending("^SUBSCH","Insurance")
 w "</div>",!
 q
 
getPending(type,title) ; ZAA02Gweb  writes out current configuration in a table
 n res,op,val,oth,row1
 s res="", op="", val="", row1=""
 s AA=type s X=""
 s res=$$GetPending^ZAA02GVBREP()
 s res=$$REPLACE^ZAA02GUTILS(res,$C(9),"</td><td>")
 s res=$$REPLACE^ZAA02GUTILS(res,$C(10),"</td><td>")
 s res=$$REPLACE^ZAA02GUTILS(res,$C(230),"</td></tr><tr><td>")
 s res="<table class='list'><tr><th>"_title_"</th></tr><tr><td>"_res_"</td></tr></table>"
 q res  
.
.
GETLIST ; ZAA02Gweb  writes out current configuration in a table
 n res,op,val,oth,row1                          //mode 0 = report, 1 = insurance
 s res="" s X=""
 s AA="^RPTSCH" 
 s mode=+$G(%("FORM","param1"))
 if mode s AA="^SUBSCH"
 s res=$$GetList^ZAA02GVBREP()
 s res=$$REPLACE^ZAA02GUTILS(res,$C(9),"</td><td class='h1'>") //h1 hide cels
 s res=$$REPLACE^ZAA02GUTILS(res,$C(10),"<br>")
 s res=$$REPLACE^ZAA02GUTILS(res,$C(235),"</td></tr><tr><td class='groupName'>")
 s res="<table id='tblGroups' class='list'><tr><td class='groupName'>"_res_"</td></tr></table>"
 w res
 q  
 
GETONEGROUP ; ZAA02Gweb  writes out current configuration into a table
 n res,op,val,oth,row1
 s res="", op="", val="", row1=""
 s itm=$G(%("FORM","param1"))
 s AA="^RPTSCH" s X="||||"_itm
 
 s mode=+$G(%("FORM","param2"))
 if mode s AA="^SUBSCH"
 if itm=""{  s res="" }
 else { s res=$$GetList^ZAA02GVBREP() }
 w res
 q  
.
GETDETAIL ; ZAA02Gweb  writes out current configuration in a table
 n res,op,val,oth,row1
 s res="", op="", val="", row1=""
 s itm=$G(%("FORM","param1"))
 if ($L(itm)=0) w "Missing params." Q
 s P2=itm s AA="^RPTSCH"
.
 s mode=+$G(%("FORM","param2"))
 if mode s AA="^SUBSCH"
.
 s res=$$GetDetail^ZAA02GVBREP()
 //remove the last delimiter 
 if $E(res,$L(res))=$C(235) s res=$E(res,1,($L(res)-1))
 
 for i=1:1:$L(res,$C(235))  { 
        s row(i)=$P(res,$C(235),i)
        for j =1:1:$L(row(i),$C(9)) { 
                s row(i,j)=$P(row(i),$C(9),j)
        }
 }
.
 s numRows= $O(row(""),-1)
 s numCols= $O(row(numRows,""),-1)
.
 if (res="") w "No items in the group" q
 
 s headerR="<tr><td class='noborder' colspan=12> Items in this group</td></tr>"
.
 s res="<table class='list'>"_headerR
         for i=1:1:numRows {
            s res=res_"<tr>"
                s ischecked="" if (row(i,6)=1) s ischecked=" checked "
                s repID=row(i,1) s repName=row(i,2)
                s res=res_"<td hidden>"_row(i,1)_"</td>"  
                s res=res_"<td title='"_row(i,5)_"'>"_row(i,2)_"</td>"
                s res=res_"<td><img title='Open report' onclick='openRep("_repID_")' height='16' src='bullist.png'></td>"
                s res=res_"<td><img title='move up un the group' onclick='moveRep(-1,"_repID_")' height='10' src='up2.png'></td>"
                s res=res_"<td><img title='move down in the group' onclick='moveRep(1,"_repID_")' height='10' src='down2.png'></td>"
                s res=res_"<td><input "_ischecked_" type='checkbox' title='uncheck to suspend' id='rep-chk-"_repID_"' onclick='suspendRep("_repID_")'></input></td>"
                s res=res_"<td><button class='redX' title='delete from group' onclick='deleteRep("_repID_","""_repName_""")' height='12' >&times</button></td>"
                s res=res_"</tr>"
         }      
         
 s res=res_"</table>"
 w res
 q   
 
RUNNOW ; ZAA02Gweb  
 n itm,ent,res
 s grp=$G(%("FORM","param1"))
 s ent=$G(%("FORM","param2"))
 s mode=+$G(%("FORM","param3"))
 if '$L(grp) w "<font color='red'>Nothing selected.</font>" Q
 s AA="^RPTSCH"
 if mode s AA="^SUBSCH"
.
 j RPTONCE1^ZAA02GVBREP(ent,grp,AA,0)
 w " started group '"_grp_"'"
 q 
.
DELETEGROUP ; ZAA02Gweb  
 n grp,X,AA,res
 s grp=$G(%("FORM","param1"))
 s mode=+$G(%("FORM","param2"))
 s AA="^RPTSCH"
 if mode s AA="^SUBSCH"
.
 w "<font color=red>*** NOT IMPLEMENTED ***</font>"
 q
.
 if '$L(grp) w $$makeErrMsg("Not deleted: nothing selected.") Q
 s X="||||"_grp
 s res=$$SetDelete^ZAA02GVBREP()
 if (res'=1) w $$makeErrMsg("Error: "_grp_" not deleted.") Q                    
 w " Group '"_grp_"' deleted." q
 q 
.
STARTSTOP ; ZAA02Gweb  //1 to start, 0 to stop
 n st,AA,P2,res,OK
 s st=$G(%("FORM","param1"))
 s mode=+$G(%("FORM","param2"))
 s AA="^RPTSCH" if mode s AA="^SUBSCH"
 s P2=st
 s OK=$$SetRun^ZAA02GVBREP 
 s res=$G(@AA@("RUN"))
 w res
 q 
 
SAVE ;ZAA02Gweb     
.
 w "<font color=red><b>*** 'Save' NOT IMPLEMENTED ***</b></font>"
 q
.
                                                //todotodo
         n M,val,type,action,record s M="" s val="" s type=""
         if ($L($G(%("BODY"))))=0 w "Missing params." Q
         d GetModel^ZAA02GUTILS(.M,%("BODY"))
         s cnt=+$O(^RPTSCHW(""),-1)
         s cnt=cnt+1
         
         s hndl=$G(M("RLC"))
         s AA="^RPTSCH"
         if $G(M("PAGEMODE")) s AA ="^SUBSCH"
     s T=$C(9)
.
         s USER=$G(M("USER"))
         s EZ=$G(M("fld8"))
         s active="0" if ($G(M("fld3"))="true") s active ="1"
         s descr=$G(M("fld4-0"))
         s dtStart=$G(M("fld4-2"))
         s dtEnd=$G(M("fld4-3"))
         s tm=$G(M("fld4-4"))
         
         //convert time to '4:15 AM' format for save 
         //can be entered as 4:11, or 4:11am  or 12:33pm - convert
         s tm1 =$P(tm,":",1) s tm2 =$E($P(tm,":",2),1,2) s ampm ="AM" s tm =$TR(tm,"p","P") if $P(tm,":",2)["P" s ampm="PM"
         s tm=tm1_":"_tm2_" "_ampm
         
         //k ^LK1("M")
         //M ^LK1("M")=M
         
         s z=0
         //if $G(M("fld4-1"))=""  s z=1 
         //if $G(M("fld4-1"))="O" s z=1
         //if $G(M("fld4-1"))="D" s z=1
         //if $G(M("fld4-1"))="W" s z=1
         //if $G(M("fld4-1"))="M" s z=1
         
        //these must send delimiters even when no data
                s X=USER_T_hndl_T_EZ_"|SETP|RPTSCH|GROUP|"_$G(M("fld0"))_"|"_active_T 
                s X=X_descr_$C(10)_$G(M("fld4-1"))_$C(10)_dtStart_$C(10)_dtEnd_$C(10)_tm_$C(10)_$G(M("fld4-5"))
                s X =X_$C(10)
                if ($G(M("fld4-1"))="W") {
                        s X =X_$$CollectChecks(.M,"fld4-6")   //collect field fld4-6:1 value false, or true if checked
                }
                s X =X_$C(10)
                if ($G(M("fld4-1"))="M") {
                        s X =X_$G(M("fld4-7"))_$C(10)_$G(M("fld4-8"))_$C(10)_$G(M("fld4-9"))_$C(10)_$$CollectChecks(.M,"fld4-10")   //collect field fld4-6:1 value false or true if checked
                }
                else { 
                        s X =X_$C(10)_$C(10)_$C(10)   //collect field fld4-6:1 value false or true if checked
                }
                s X =X_$C(10)
                
                s X =X_$C(9)_$G(M("fld5-0"))_$C(10)_$G(M("fld5-1"))_$C(10)_$G(M("fld5-2"))_$C(10)_$G(M("fld5-3"))       //  output
.
        //these below must NOT send delimiters without data 
            s entpiece="" s dtpiece=""
            
        s entpiece=$G(M("fld6-0"))_$C(10)_$G(M("fld6-1"))                                                       //  entity
            if ($G(M("fld6-0"))="X") s entpiece="X"   //no delimiters attached
            
                s X =X_$C(9)_entpiece                                                                                                                   
.
                s dtpiece=$G(M("fld7-0"))_$C(10)_$G(M("fld7-1"))_$C(10)_$G(M("fld7-2"))         //      dates selection
                if ($G(M("fld7-0"))="X") s dtpiece="X"    //no delimiters attached
.
                s X =X_$C(9)_dtpiece                                                                                                                    
.
         s msg ="Group '"_$G(M("fld0"))_"' saved."
         if ($G(M("MODE"))="ADD") { s msg ="New group created: "_"'"_$G(M("fld0"))_"'"}
         
         if ( $L($G(M("fld0")))) {  
                s res=$$SetGroup^ZAA02GVBREP()
                if (res)  w msg
                if ('res) w $$makeErrMsg("Not saved")
         }
         else {  
                w $$makeErrMsg("Required data is missing, not saved.")   
         } 
 q
CollectChecks(M,match)  //returns values of checked items, comma separated
  s res=""                              //match "fld3-1" tg="fld3-1:" 
  s tg=$G(match)
                s k=""
                s k=$O(M(k))
                while '(k="") { 
                        if ($P(k,":",1)=tg) {           
                                s vl=M(k)
                                if (($E(vl,1,1)="t") || ($E(vl,1,1)="T")) { 
                                    s res= res_$E(k,$L(tg)+2,$L(k))_","
                                }
                        }
                s k=$O(M(k))
                }
 if ( $E(res,$L(res),$L(res))="," ) s res=$E(res,1,$L(res)-1)
 q res
 
makeErrMsg(txt) 
        q "<font color='red'>"_txt_"<font>"      
 
ST2 ;ZAA02Gweb
 s MODE="SUBSCH"
ST ;ZAA02Gweb 
 N (%,ReconFiles,RLC,MODE)
 s title1="Insurance"
 
 if ($L($G(MODE))=0) s MODE="RPTSCH" s title1="Reports"
 
 s PageTitle=title1
  
 W "<!DOCTYPE HTML>",!
 W "<html>",!
 W "<head>",!
 W "<meta http-equiv=""X-UA-Compatible"" content=""IE=9"">",!
 D WRITESTYLES
 W "</head>",!
.
 s usr  = $P($G(^ZAA02GVBUSER("WEB-LOGON",+$H,+$G(RLC)\1)),",",3)
.
.
 s perm=MODE
 if '$L(usr)||'($P($G(^OPG(usr,perm)),":",1)) D WriteOutNoPermission(usr,perm) Q
.
 W "<body onload='showCurrentConfig();fillDefaults();' >",!
.
 //w "***** RLC "_RLC_"****"
 //w "<br>***** "_usr_"****"
 W "<div hidden id='rlcBox'>"_RLC_"</div>" ,!
.
 s pageModeDisp = "<div id='pageMode' get-this='PAGEMODE' style='color:red;'>"_MODE_"</div>" 
 s pageModeDisp = pageModeDisp_"<button style='position:absolute;top:2px;width:140px;' id='btnStartStop' onclick='switchPageMode()'> switch </button>"
 w "<div style='position:fixed;top:0px;right:80px;'>"_pageModeDisp_"</div>", !
.
 s currStatus=0 s btnCaption="Start" s status="<font color='red'> off </font>"
 if $G(^RPTSCH("RUN")) s currStatus=1 s status="on" s btnCaption="Stop"
 
 s status2="<font color='red'> off </font>"
  if $G(^SUBSCH("RUN")) s status2="on" 
.
.
 W "<div><font face='verdana' size='2'>"_$ZDATETIME($H,5)_"</font></div>" ,!
 W "<div>", !
 w "<font face='verdana' size='2'>SUBSCH: <label id='currStatusLabel2'>"_status2_"</label>", !
 W "&nbsp &nbsp <font face='verdana' size='2'>RPTSCH: <label id='currStatusLabel'>"_status_"</label>", !
 
 W "<input hidden id='currStatus' value="_currStatus_"> </div>" ,!
.
 s processRunning=$$isProcessRunning
 
 W " <div id='processRunStatus' class='inl'>"_processRunning_"</div>",!
.
 s str1="Scheduled Tasks -  "
 w "<div class='hdr1'>"_str1_"<span id='pageTitle' class='hdr2'>"_PageTitle_"</span>"
.
 W "  &nbsp ",!
 W "  <button class='pgOpen'  onclick='togglePending()'> <img title='See pending' src='reminder.gif' width=16> see waiting to run </button>",!
 W "</div>",!
 
 W "<div class='pending' id='pendingBox'>" , !
 W "<div class='greenTitle'>Groups waiting to run <button style='float:right' onclick='togglePending()'>close</button></div>",!
 W "<div class='oneGroup' id='pending'></div>",!
 W "</div>",!
 
 s grp="<div class='greenTitle' id='thisGroup'></div>"
 s btn="<button onclick=runNow(document.getElementById('thisGroup').innerHTML,1)>Run Now</button>"
 s btnD="<button onclick=deleteGroup(document.getElementById('thisGroup').innerHTML,1)>Delete Group</button>"
 s btnN="<button onclick=addGroup()>New Group</button>"
 s res1="<div class='greenTitle' id='runOnceRes'></div>" 
.
 s grayBox= "<div class='gray'>"
 s grayBox=grayBox_"<table><tr><td colspan=4>"_grp_"</td></tr><tr><td>"_btn_"</td><td>"_btnD_"</td><td>"_btnN_"</td><td>"_res1_"</td></tr></table>"
 s grayBox=grayBox_"<table><tr><td colspan='5' id='oneGroupReports'><td></tr></table>"
 s grayBox=grayBox_"</div>"
.
 W "<table><tr><th align='left'> &nbsp All Scheduled Groups </th></tr><tr><td style='vertical-align:top;'><div class='curr' id='currDisp'></div></td><td style='vertical-align:top;'>"_grayBox_"</td></tr></table>",!
.
 w "<div class='descr' id='groupNotes'></div>",!
 
 W "<br>" ,!
 W "<button hidden class='pgOpen' id='btnToggleDetail' onclick='toggleDetail();'>Show Detail</button>",!
 W "<div class='cool' id='groupDetail'>" , !
.
 W "<table id='addNew' class='onerecord'>",!
 W "<tr><th align='center' colspan=4 id='editTag'> </th></tr>",!
.
 s t(0)="Name"  s ro(0)=""
 s t(1)="Operator"              s ro(1)=" readonly class='rdonly' "
 s t(2)="Date Created"  s ro(2)=" readonly class='rdonly' "
 s t(3)="Active"                s ro(3)=""
 
 //text
 w "<tr><td>"
         W t(0)_"</td><td> <input size=40 "_ro(0)_" get-this='fld0' id='fld0'>",!
 //checkbox
        s fld="fld3"
        W t(3)_" <input type='checkbox'"_ro(3)_" get-this='"_fld_"' id='"_fld_"'>"
 W "<button onClick='clearAll()' id='btnClear' style='float:right;'> Clear fields</button></td></tr>",!
 
 //fields with fields inside
 //s F=4 s numF=11 s t(F)="Schedule"            d WriteSection(F,numF,t(F))
 D WriteSection4
 D WriteSection5
 D WriteSection6
 D WriteSection7
 
 s t(8)="Run as Entity"
 s i=8 s fld="fld"_i s fldTitle=t(i) 
 W "<tr><td>"_fldTitle_"</td><td> <input get-this='"_fld_"' id='"_fld_"'></td></tr>",!
.
 //this are hidden
 W "<tr hidden><td>logged in user</td><td> <input readonly class='rdonly' id='USER' value='"_usr_"'></td></tr>",!
 W "<tr hidden><td>RLC</td><td> <input readonly class='rdonly' id='RLC' value='"_RLC_"'></td></tr>",!
.
 for i=1:1:2 { 
        s fld="fld"_i 
        s fldTitle=t(i)
 W "<tr hidden><td>"_fldTitle_"</td><td> <input "_ro(i)_" get-this='"_fld_"' id='"_fld_"'></td></tr>",!
 }
.
 W "<tr hidden><td>mode<br>view/edit/add</td><td> <input readonly class='rdonly' get-this='MODE' id='MODE' value='VIEW'></td></tr>",!
.
 W "</table>",!
 
 w "<br>"
 w " &nbsp  &nbsp  <button class='btn' id='btnSave' onclick='SaveThis()'>  &nbsp Save Group &nbsp </button> <span id='saveStatus'>OK</span>",!
 
 W "<div class='res' id='resVals'> after save results</div>",!
 w "</div>"
 W "</body>",!
 D WRITESCRIPT^ZAA02GRPTSCHWSCR
 q 
 
 
WriteSection(F,numF,title)  //as table
 n (F,numF,title,id)
 s oneBox=""
        s oneBox="<div><table>"
                for k=0:1:numF-1{
                        s id="fld"_F_"-"_k
                        if ((F=4)&& (k=1)) { 
                                s oneBox=oneBox_$$MakeDropdown(id,"N:<none>"_$C(9)_"D:Daily"_$C(9)_"W:Weekly"_$C(9)_"M:Monthly"_$C(9)_"O:Once","Type")
                        }
                        else { 
                                s oneBox=oneBox_$$MakeTextbox(id,"text"_id)
                        }
                }
        s oneBox=oneBox_"</table></div>"
    W "<tr><td>"_title_"</td><td>"_oneBox_"</td></tr>",!
 q
WriteSection4  //as table
 n (F,title,id)
 s oneBox=""
        s oneBox="<div class='s4'><table>"
        s oneBox=oneBox_$$MakeTextarea("fld4-0","Notes")
        s oneBox=oneBox_$$MakeDropdown("fld4-1",": -- not scheduled -- "_$C(9)_"D:Daily"_$C(9)_"W:Weekly"_$C(9)_"M:Monthly"_$C(9)_"O:Once","Run")
        s oneBox=oneBox_$$MakeTextbox("fld4-2","Start Date",,,"calendar")
        s oneBox=oneBox_$$MakeTextbox("fld4-3","End Date",,,"calendar")
        s oneBox=oneBox_$$MakeTextbox("fld4-4","Run at"," example: '4:15 am'")
        s oneBox=oneBox_$$MakeTextbox("fld4-5","Every"," day/week ")
 
    d WeekDays(.arr)
        s oneBox=oneBox_$$MakeChecks("fld4-6",.arr," On "," ")
.
.
        d MonthDays(.arr)
        s oneBox=oneBox_$$MakeDropdown2("fld4-7",.arr," ","  ")
.
    d FirstToLast(.arr)
    s arr(0)=""
        s oneBox=oneBox_$$MakeDropdown2("fld4-8",.arr," on "," ")
    
    d WeekDays(.arr)
    s arr(0)=""
        s oneBox=oneBox_$$MakeDropdown2("fld4-9",.arr," "," ")
.
        d Months(.arr)
        s oneBox=oneBox_$$MakeChecks("fld4-10",.arr," in "," ")
.
        s oneBox=oneBox_"</table></div>"
    W "<tr><td>Schedule</td><td>"_oneBox_"</td></tr>",!
 q
WriteSection5  //as table
 n (F,title,id)
 s oneBox=""
        s oneBox="<div class='s5'><table>"
        s oneBox=oneBox_$$MakeDropdown("fld5-0","F:File"_$C(9)_"P:Printer","Output")
        s oneBox=oneBox_$$MakeTextbox("fld5-1","File/printer id"," file name, or printer #",24 )
        s oneBox=oneBox_$$MakeDropdown("fld5-2","0:no"_$C(9)_"1:yes","Overwrite Excel File")
        s oneBox=oneBox_$$MakeDropdown("fld5-3","0:no"_$C(9)_"1:yes","Overwrite output File")
.
        s oneBox=oneBox_"</table></div>"
    W "<tr><td>Output</td><td>"_oneBox_"</td></tr>",!
 q
WriteSection6  //as table
 n (F,title,id)
 s oneBox=""
        s oneBox="<div class='s6'><table>"
        s oneBox=oneBox_$$MakeDropdown("fld6-0","X:Use saved report options"_$C(9)_"A:All Entities"_$C(9)_"I:Include List"_$C(9)_"E:Exclude List","Entity to use")
        s oneBox=oneBox_$$MakeTextbox("fld6-1","Include/Exclude list"," comma delimited list" )
.
        s oneBox=oneBox_"</table></div>"
    W "<tr><td>Entity Selection</td><td>"_oneBox_"</td></tr>",!
 q
 
WriteSection7  //as table
 n (F,title,id)
 s oneBox=""
        s oneBox="<div class='s7'><table>"
        s oneBox=oneBox_$$MakeDropdown("fld7-0","X:Use saved report options"_$C(9)_"S:Service"_$C(9)_"P:Posting","Dates")
        s oneBox=oneBox_$$MakeTextbox("fld7-1","From "," date",,"calendar" )
        s oneBox=oneBox_$$MakeTextbox("fld7-2","Through "," date",,"calendar" )
.
        s oneBox=oneBox_"</table></div>"
    W "<tr><td>Dates Selection</td><td>"_oneBox_"</td></tr>",!
 q
.
 
MakeDropdown(id,vals,title,title2)  //as a grid row
 n (id,vals,title,title2)
 s title2=$G(title2)
 s oneLine=""
        s oneLine="<tr id='r-"_id_"'><td>"_title_"</td><td><select get-this='"_id_"' id='"_id_"' value='"_id_"'>"
                for k=1:1:$L(vals,$C(9)){
                        s vl=$P(vals,$C(9),k)
                        s desc=$P(vl,":",2)
                        s vl=$P(vl,":",1)
                        s oneLine=oneLine_"<option value='"_vl_"'>"_desc_"</option>"
                }
        s oneLine=oneLine_"</select>"_title2_"</td></tr>"
 q oneLine
.
MakeDropdown2(id,M,title,title2)  //as a grid row
 n (id,vals,title,title2,M)
 s title2=$G(title2)
 s oneLine=""
        s oneLine="<tr id='r-"_id_"'><td>"_title_"</td><td><select get-this='"_id_"' id='"_id_"' value='"_id_"'>"
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
.
MakeChecks(id,M,title,title2)  //as a grid row
 n (id,vals,title,title2,M)
 s title2=$G(title2)
 s oneLine=""
        s oneLine="<tr id='r-"_id_"'><td>"_title_"</td><td width='200px'>"
                s k=""
                s k=$O(M(k))
                while '(k="")
                {       
                        s vl=M(k)
                        s desc=$P(vl,$C(9),2)
                        s vl=$P(vl,$C(9),1)
                        s dataID=id_":"_vl      // each checkbox is tagged with "fieldID:fieldValue "
                        s oneLine=oneLine_"<input type='checkbox' get-this='"_dataID_"' id='"_dataID_"'>"_desc_" "
                        s k=$O(M(k))
                }
.
        s oneLine=oneLine_" "_title2_"</td></tr>"
 q oneLine
  
MakeTextbox(id,title,title2,size, type)  //as a grid row
    n (id,title,title2,size, type)
    s type=$G(type) s tp=""
    if ($L(type)) s tp="class='"_type_"'"
    s size=$G(size) if +size=0 s size=12
        s title2=$G(title2)     
        s oneLine=""
        s oneLine=oneLine_"<tr id='r-"_id_"'><td>"_title_"</td><td><input "_tp_" get-this='"_id_"' id='"_id_"' value='' size="_size_">"_title2_"</td></tr>"
        q oneLine
        
MakeTextarea(id,title,title2)  //as a grid row
    n (id,title,title2)
        s title2=$G(title2)     
        s oneLine=""
        s oneLine=oneLine_"<tr id='r-"_id_"'><td>"_title_"</td><td><textarea get-this='"_id_"' id='"_id_"' value='"_id_"'></textarea>"_title2_"</td></tr>"
        q oneLine
.
FirstToLast(mDays)      //1 to , and '*'
    k mDays
    s mDays(1)="1"_$C(9)_"first"
    s mDays(2)="2"_$C(9)_"second"
    s mDays(3)="3"_$C(9)_"third"
    s mDays(4)="4"_$C(9)_"fourth"
    s mDays(5)="*"_$C(9)_"last"
        q 
WeekDays(mDays)         //1 to 7
    k mDays
    s mDays(1)="1"_$C(9)_"Monday"
    s mDays(2)="2"_$C(9)_"Tuesday "
    s mDays(3)="3"_$C(9)_"Wednesday"
    s mDays(4)="4"_$C(9)_"Thursday"
    s mDays(5)="5"_$C(9)_"Friday"
    s mDays(6)="6"_$C(9)_"Saturday"
    s mDays(7)="7"_$C(9)_"Sunday"
        q 
.
Months(mDays)           // 1 to 12
    k mDays
        f i=1:1:12                      s mDays(i)=i_$C(9)_$p($zd($zdh(i_"/1/2017"),9)," ")
        q 
.
MonthDays(mDays)        // 1 to 28, and '*'
    k mDays
    s mDays(0)=""_$C(9)_" -- By the day of the week -- "
    s mDays(1)="1"_$C(9)_" On the first day of the month "
    s mDays(2)="2"_$C(9)_" On the second day of the month "
    s mDays(3)="3"_$C(9)_" On the third day of the month "
    for i=4:1:28                s mDays(i)=i_$C(9)_" On the "_i_"th day of the month "
    s mDays(29)="*"_$C(9)_"On the last day of the month"
    q 
    
WRITESTYLES 
 W "<style type='text/css'>", !
 W " .common {font-family:Verdana;font-size:xsmall;color:red;}",!
 W "table {font-family:Verdana;font-size:xsmall;border-collapse:collapse;}",!
 W "button.btn {height:25px; background-color:forestgreen; font-family:Verdana; color:whitesmoke;} ",!
.
 W "span.hdr2 {font-family: Verdana; text-align:center;color:coral; font-weight:bold;}",!
 
 W "div.hdr1 {font-family: Verdana; text-align:center;line-height:40px;color:steelblue; font-size:medium;}",!
 W "div.res {font-family: Verdana; color:green; font-size:xsmall;padding:10px;}",!
 W "div.curr {font-family: Verdana; color:steelblue; font-size:xsmall;padding:10px;}",!
 
 W "div.gray {display:block; background-color:whitesmoke; overflow:auto;padding:10px 12px 12px 12px;}",! 
 W "div.descr {display:block; background-color: whitesmoke ; margin-left:12px; width:90%; overflow:auto;padding:2px 12px 12px 12px;}",! 
 W "div.pending {display:block; background-color: whitesmoke ; margin-left:12px;margin-bottom:20px;  overflow:auto;padding:2px 12px 12px 12px;}",! 
 W "div.cool {display:none; overflow:auto;padding:2px 12px 12px 12px;}",! 
 W "div.oneGroupReports {display:block; background-color:powderblue;overflow:auto;padding:2px 12px 12px 12px;}",! 
 W "div.inl {float:left;}",!
.
 W ".s5 ,.s7 {background-color:gainsboro; }",! 
 W ".s4 ,.s6 {background-color:whitesmoke; }",! 
 W "div.greenTitle {font-family: Verdana; color: forestgreen ; font-weight:bold; font-size:small;padding:2px;}",!
 
 W "td.groupName:hover", !
 W "{", !
 W "   cursor:pointer;color: forestgreen ;  ", !
 W "}", !
 
  W "td.oneReport:hover", !
 W "{", !
 W "   cursor:pointer;background-color:powderblue;", !
 W "}", !
.
 W "td.h1 {display:none; }",!
 
 
 W "table.list { color:steelblue; } ", !
 W "table.list td {border:1px solid gainsboro ; padding:2px 12px 2px 12px; word-wrap: break-word;} ", !
 W "table.list td.noborder {border:0px; padding:4px;}",!
.
 W "table.onerecord th, td {border:white; padding:4px;}",!
 W "tr.selected {background-color: ghostwhite ; color:forestgreen; font-weight:bold; }",!
 W "textarea {width:400px;rows:4;font-family: Verdana;}",!
 W "button.redX {background: none; color:rgb(200,0,0); padding:0; border:none; cursor:pointer; font-size:14pt; }        ",!
.
 W "button.pgOpen, button.pgOpen:focus, button.pgOpen:active {  ",!
 W "    background: none;       ",!
 W "    border-top: 0;  ",!
 W "    border-right: 0;        ",!
 W "    border-bottom: 0px solid #00F;  ",!
 W "    border-left: 0 ;        ",!
 W "    padding:0;      ",!
 W "    color: steelblue; font-weight:bold;font-family:Verdana; ",!
 W "    outline: none;  ",!
 W "    cursor: pointer;        ",!
 W "}   ",!
 W "img {border:0}",!
 W " .rdonly { text-align:center; background-color:gainsboro;border:0;} ", !
.
 W "th {color:steelblue;}",!
.
 W ".ui-datepicker { font-size: 9pt !important; }", ! //overwrite jquery font size for datepicker, default is too large
.
 W " </style>"
 
.
 q
 
