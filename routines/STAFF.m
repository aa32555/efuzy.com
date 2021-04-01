STAFF
	;
	; MODEL
	; SAVE NEW, UPDATE, LOG, PERMISSIONS, ETC. ;
	Q
	;
ROUTES
	K N I $I(H)
	S @T@("header","mainNav",H,"label")="Staff"
	I $I(N)
	S @T@("header","mainNav",H,"children",N,"label")="Staff list"
	S @T@("header","mainNav",H,"children",N,"to")="/staff/list"
	I $I(N)
	S @T@("header","mainNav",H,"children",N,"label")="Edit staff"
	S @T@("header","mainNav",H,"children",N,"to")="/staff/edit"
	I $I(N)
	S @T@("header","mainNav",H,"children",N,"label")="Add staff"
	S @T@("header","mainNav",H,"children",N,"to")="/staff/add/*"
	I $I(N)
	S @T@("header","mainNav",H,"children",N,"label")="Set staff working hours"
	S @T@("header","mainNav",H,"children",N,"to")="/staff/working_hours"
	;
	i $I(P)
	S @T@("pages",P,"path")="/staff/list"
	S @T@("pages",P,"name")="Staff"
	S @T@("pages",P,"childBreadcrump")="stafflist"
	S @T@("pages",P,"breadcrump")="staff"
	S @T@("pages",P,"component")="FUZPage"
	S @T@("pages",P,"requiresAuth")="true"
	S @T@("pages",P,"routine")="TREE^STAFF"
	S @T@("pages",P,"type")="SALON"
	;
	i $I(P)
	S @T@("pages",P,"path")="/staff/edit"
	S @T@("pages",P,"name")="Edit Staff"
	S @T@("pages",P,"childBreadcrump")="editstaff"
	S @T@("pages",P,"breadcrump")="staff"
	S @T@("pages",P,"subName")="StaffEdit"
	S @T@("pages",P,"component")="FUZPage"
	S @T@("pages",P,"requiresAuth")="true"
	S @T@("pages",P,"routine")="EDITALLTREE^STAFF"
	S @T@("pages",P,"type")="SALON"
	;
	i $I(P)
	S @T@("pages",P,"path")="/staff/edit/:id"
	S @T@("pages",P,"name")="Edit Single Staff"
	S @T@("pages",P,"childBreadcrump")="editstaff"
	S @T@("pages",P,"breadcrump")="staff"
	S @T@("pages",P,"component")="FUZPage"
	S @T@("pages",P,"requiresAuth")="true"
	S @T@("pages",P,"routine")="EDITTREE^STAFF"
	S @T@("pages",P,"type")="SALON"
	;
	i $I(P)
	S @T@("pages",P,"path")="/staff/add/:id"
	S @T@("pages",P,"name")="Add Staff"
	S @T@("pages",P,"childBreadcrump")="addstaff"
	S @T@("pages",P,"breadcrump")="staff"
	S @T@("pages",P,"component")="FUZPage"
	S @T@("pages",P,"requiresAuth")="true"
	S @T@("pages",P,"routine")="ADDTREE^STAFF"
	S @T@("pages",P,"type")="SALON" 
	;
	i $I(P)
	S @T@("pages",P,"path")="/staff/working_hours"
	S @T@("pages",P,"name")="Staff Hours"
	S @T@("pages",P,"childBreadcrump")="staffhours"
	S @T@("pages",P,"breadcrump")="staff"
	S @T@("pages",P,"component")="StaffHours"
	S @T@("pages",P,"requiresAuth")="true"
	S @T@("pages",P,"type")="SALON" 
	;
	;	
	;
	Q       
	;	
	;	
	;
onAfterModelSave
	N ID S ID=HOLDER("id")
	I $G(DATA("noRerouteAfterSave"))="true" Q
	S %J("dispatch","action")="app/changeRoute"
	S %J("dispatch","data")="/staff/list"
	Q
	;       
	;
Model(T)
	N R 
	;
	S T("F","title")="Add Staff"
	S T("F","editTitle")="Edit Staff"
	S T("F","multiIndex",1)="name"
	S T("F","searchIndex")=1
	;
	;
	;
	I $I(R) 
	S T("M",R,"model")="id"
	S T("M",R,"data","id")=""
	S T("M",R,"type")="number"
	S T("M",R,"is")="span"  
	S T("M",R,"props","rounded")="true"
	S T("M",R,"props","outlined")="true"
	S T("M",R,"props","label")="ID"
	S T("M",R,"props","lazy-rules")="true"
	S T("M",R,"props","style")="display:none;"
	S T("M",R,"rules","required")="true"
	S T("M",R,"props","disable")="true"
	;
	;
	I $I(R)
	S T("M",R,"is")="FUZImg"
	S T("M",R,"model")="image"
	S T("M",R,"data","image")="user.png"
	S T("M",R,"type")="view-image"
	S T("M",R,"props","imgProps","avatar")="true"
	S T("M",R,"props","imgProps","imageClass")="v1-image"
	S T("M",R,"props","imgProps","size")="100px"
	S T("M",R,"props","imgProps","font-size")="52px"
	s T("M",R,"props","imgProps","parentStyle")="width:350px;"
	s T("M",R,"props","imgProps","parentClass")="flex flex-center q-pa-md row"
	s T("M",R,"props","imgProps","label")="Staff photo"
	s T("M",R,"props","imgProps","labelStyle")="width:350px;"
	s T("M",R,"props","imgProps","labelClass")="text-grey text-center"
	s T("M",R,"props","imgProps","flat")="true"
	;
	;
	I $I(R) 
	S T("M",R,"model")="active"
	S T("M",R,"data","active")="true"
	S T("M",R,"type")="string"
	S T("M",R,"is")="q-toggle"      
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","disable")="true"
	S T("M",R,"props","label")="Active"
	S T("M",R,"rules","required")="true"    
	;
	;
	I $I(R) 
	S T("M",R,"model")="name"
	S T("M",R,"data","name")=""
	S T("M",R,"type")="string"
	S T("M",R,"is")="q-input"       
	S T("M",R,"props","rounded")="true"
	S T("M",R,"props","outlined")="true"
	S T("M",R,"props","label")="Staff name"
	S T("M",R,"props","lazy-rules")="true"
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"transformOnIndex")="V=$$ZCVT^SALON(V,""L"")"
	S T("M",R,"rules","required")="true"
	S T("M",R,"index")="true"
	;
	;
	I $I(R)
	S T("M",R,"type")="string"
	S T("M",R,"model")="title"
	S T("M",R,"data","title")=""
	S T("M",R,"is")="q-input"               
	S T("M",R,"props","type")="textarea"
	S T("M",R,"props","autogrow")="true"
	S T("M",R,"props","rounded")="true"
	S T("M",R,"props","outlined")="true"
	S T("M",R,"props","label")="Staff title"
	S T("M",R,"props","lazy-rules")="true"
	S T("M",R,"props","style")="width:350px;"
	;
	I $I(R) 
	S T("M",R,"model")="email"
	S T("M",R,"data","email")=""
	S T("M",R,"type")="email"
	S T("M",R,"is")="q-input"       
	S T("M",R,"props","rounded")="true"
	S T("M",R,"props","outlined")="true"
	S T("M",R,"props","label")="Email"
	S T("M",R,"props","lazy-rules")="true"
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"rules","required")="true"
	S T("M",R,"rules","email")="true"
	S T("M",R,"index")="true"
	;
	I $I(R) 
	S T("M",R,"type")="number"
	S T("M",R,"model")="serviceCommission"
	S T("M",R,"data","serviceCommission")=""
	S T("M",R,"is")="q-input"               
	S T("M",R,"props","type")="number"
	S T("M",R,"props","mask")="####.##"
	S T("M",R,"props","rounded")="true"
	S T("M",R,"props","outlined")="true"
	S T("M",R,"props","label")="Services commission"
	S T("M",R,"props","lazy-rules")="true"
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"rules","required")="true"
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZSelect"
	S T("M",R,"model")="fontColor"
	S T("M",R,"data","fontColor")="white"   
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Appointments text color"
	S T("M",R,"props","options",1)="white"
	S T("M",R,"props","options",2)="black"
	S T("M",R,"rules","required")="true"
	S T("M",R,"onInput")="updateColorPickerFont"
	;
	;
	I $I(R) 
	S T("M",R,"model")="gradient1color"
	S T("M",R,"data","gradient1color")="#6fb8e0"
	S T("M",R,"type")="string"
	S T("M",R,"is")="FUZColorPicker"
	S T("M",R,"props","label")="Appointments Gradient 1 Color" 
	S T("M",R,"props","fontColor")="white"
	S T("M",R,"props","style")="width:350px;color:white;"   
	;
	I $I(R) 
	S T("M",R,"model")="gradient2color"
	S T("M",R,"data","gradient2color")="#6fb8e0"
	S T("M",R,"type")="string"
	S T("M",R,"is")="FUZColorPicker"
	S T("M",R,"props","label")="Appointments Gradient 2 Color" 
	S T("M",R,"props","fontColor")="white"
	S T("M",R,"props","style")="width:350px;color:white;"   
	;
	;
	Q
	;
FillModel(T,ID)
	D FillModel^FUZNEW(.T,"STAFF",ID)
	N A,M S A="" F  S A=$O(T("M",A)) Q:A=""  S M(T("M",A,"model"))=A
	N V M V=T("M",M("fontColor"),"data","fontColor")
	I V="" Q
	;S T("M",M("color"),"props","style")="width:350px;color:"_V     
	Q       
	;
List(T)
	N R
	I $I(R)
	s T(R,"model")="image"
	S T(R,"component","is")="q-item-section"
	S T(R,"component","props","top")="true"
	S T(R,"component","props","side")="true"
	S T(R,"subComponent","is")="FUZImg"
	S T(R,"subComponent","props","imgProps","avatar")="true"
	S T(R,"subComponent","props","imgProps","imageClass")="v1-image"
	S T(R,"subComponent","props","imgProps","size")="75px"
	S T(R,"subComponent","props","imgProps","font-size")="52px"
	S T(R,"subComponent","props","imgProps","viewOnly")="true"
	S T(R,"subComponent","props","value")="insertValue"
	;
	I $I(R)
	s T(R,"model")="name"
	S T(R,"component","is")="q-item-section"
	S T(R,"subComponent","is")="q-item-label"
	S T(R,"subComponent","props","lines")="1"
	S T(R,"subSubComponent","is")="span"
	S T(R,"subSubComponent","props","class")="text-weight-medium"
	S T(R,"subSubComponent","insertValue")="true"
	S T(R,"subSubComponent","props","href")="javascript:void(0)"
	S T(R,"subSubComponent","props","toID")="/staff/edit/"
	S T(R,"subSubComponent","props","style")="cursor:pointer"
	;
	;
	I $I(R)
	s T(R,"model")="id"
	S T(R,"component","is")="q-item"
	S T(R,"subComponent","is")="div"
	S T(R,"component","props","top")="true"
	S T(R,"component","props","side")="true"
	S T(R,"subComponent","props","class")="text-grey-8 q-gutter-xs"
	S T(R,"subSubComponent","is")="FUZButtonGroup"
	S T(R,"subSubComponent","props","groupProps","size")="16px"
	S T(R,"subSubComponent","props","groupProps","flat")="true"
	S T(R,"subSubComponent","props","groupProps","dense")="true"
	S T(R,"subSubComponent","props","groupProps","round")="true"
	S T(R,"subSubComponent","props","groupProps","dropdown-icon")="more_vert"
	S T(R,"subSubComponent","props","groupProps","no-icon-animation")="true"
	S T(R,"subSubComponent","props","buttons",1,"title")="View"
	S T(R,"subSubComponent","props","buttons",1,"action")="routine"
	S T(R,"subSubComponent","props","buttons",1,"type")="STAFF"
	S T(R,"subSubComponent","props","buttons",1,"onClick")="ViewRecord^FUZNEW"
	S T(R,"subSubComponent","props","buttons",1,"props","clickable")="true"
	S T(R,"subSubComponent","props","buttons",1,"props","v-close-popup")="true"
	S T(R,"subSubComponent","props","buttons",2,"title")="Edit"
	S T(R,"subSubComponent","props","buttons",2,"action")="routine"
	S T(R,"subSubComponent","props","buttons",2,"type")="STAFF"
	S T(R,"subSubComponent","props","buttons",2,"onClick")="EditRecord^FUZNEW"
	S T(R,"subSubComponent","props","buttons",2,"props","clickable")="true"
	S T(R,"subSubComponent","props","buttons",2,"props","v-close-popup")="true"
	S T(R,"subSubComponent","props","buttons",3,"title")="Delete"
	S T(R,"subSubComponent","props","buttons",3,"action")="routine"
	S T(R,"subSubComponent","props","buttons",3,"type")="STAFF"
	S T(R,"subSubComponent","props","buttons",3,"onClick")="DeleteRecord^FUZNEW"
	S T(R,"subSubComponent","props","buttons",3,"props","clickable")="true"
	S T(R,"subSubComponent","props","buttons",3,"props","v-close-popup")="true"
	S T(R,"subSubComponent","props","src")="insertValue"
	Q       
	;
	;
	;
TREE(T)
	N R,C
	I $I(R),$I(C)
	S T("rows",R,"class")="row"
	S T("rows",R,"is")="div"
	S T("rows",R,"cols",C,"class")="col"
	S T("rows",R,"cols",C,"title")="Staff"
	S T("rows",R,"cols",C,"is")="FUZList"
	S T("rows",R,"cols",C,"props","type")="STAFF"
	S T("rows",R,"cols",C,"props","routine")="List^STAFF"
	S T("rows",R,"cols",C,"props","header")="Staff"
	S T("rows",R,"cols",C,"props","emptyListText")="No categories found, click this button to add a staff!"
	S T("rows",R,"cols",C,"props","orderable")="true"
	S T("rows",R,"cols",C,"props","skeleton",1,1,"type")="QToolbar"
	S T("rows",R,"cols",C,"props","skeleton",1,1,"height")="75px"
	S T("rows",R,"cols",C,"props","skeleton",1,1,"class")="col self-end"
	N I F I=2:1:13 D
	.S T("rows",R,"cols",C,"props","skeleton",I,1,"type")="QAvatar"
	.S T("rows",R,"cols",C,"props","skeleton",I,1,"size")="75px"
	.S T("rows",R,"cols",C,"props","skeleton",I,1,"class")="col-auto"
	.S T("rows",R,"cols",C,"props","skeleton",I,2,"type")="QToolbar"
	.S T("rows",R,"cols",C,"props","skeleton",I,2,"height")="75px"
	.S T("rows",R,"cols",C,"props","skeleton",I,2,"width")="95%"
	.S T("rows",R,"cols",C,"props","skeleton",I,2,"class")="col-11 self-start"
	;
	Q
	;
EDITTREE(T)
	N R,C
	I $I(R),$I(C)
	S T("rows",R,"class")="row"
	S T("rows",R,"is")="div"
	S T("rows",R,"cols",C,"class")="col"
	S T("rows",R,"cols",C,"title")="Edit Staff"
	S T("rows",R,"cols",C,"is")="FUZNew"
	S T("rows",R,"cols",C,"props","type")="STAFF"
	Q
	;
ADDTREE(T)
	N R,C
	I $I(R),$I(C)
	S T("rows",R,"class")="row"
	S T("rows",R,"is")="div"
	S T("rows",R,"cols",C,"class")="col"
	S T("rows",R,"cols",C,"title")="New Staff"
	S T("rows",R,"cols",C,"is")="FUZNew"
	S T("rows",R,"cols",C,"props","type")="STAFF"
	Q       
	;
EDITALLTREE(T)
	N R,C
	I $I(R),$I(C)
	S T("rows",R,"class")="row"
	S T("rows",R,"is")="div"
	S T("rows",R,"cols",C,"class")="flex flex-center col"
	S T("rows",R,"cols",C,"title")="Search Staff"
	S T("rows",R,"cols",C,"is")="FUZListSearchPage"
	S T("rows",R,"cols",C,"props","type")="STAFF"
	S T("rows",R,"cols",C,"props","routine")="List^STAFF"
	S T("rows",R,"cols",C,"props","label")="Search staff"
	S T("rows",R,"cols",C,"props","selectItems","avatar")="image"
	S T("rows",R,"cols",C,"props","selectItems","label")="name"
	S T("rows",R,"cols",C,"props","selectItems","caption",1)="description"
	Q
	;
getStaff(dd,r)
	n d m d=dd("data")
	I $G(d("startingDate"))]"" s date=$$ZDH^SALON(d("startingDate"))
	E  S date=+$H
	S S="" F  S S=$O(@%G@("STAFF","ORDER",S)) Q:S=""  D
	. S STAFF=@%G@("STAFF","ORDER",S)
	. I '$D(@%G@("STAFF","DATA",STAFF,"id")) Q
	. I $G(@%G@("STAFF","DATA",STAFF,"active"))'="true" Q
	. S CNT=($O(r("data","data","list",""),-1)+1)
	. M r("data","data","list",CNT,"name")=@%G@("STAFF","DATA",STAFF,"name")
	. F I=date:1:(date+6) I '$D(@%G@("STAFF","SCH","OFF",STAFF,I)) M r("data","data","list",CNT,"d"_(I-date))=@%G@("STAFF","SCH","BASE",STAFF,$$ZD^SALON(I,10))
	. F I=date:1:(date+6) I '$D(@%G@("STAFF","SCH","OFF",STAFF,I)) M r("data","data","list",CNT,"d"_(I-date))=@%G@("STAFF","SCH","DAY",STAFF,I)
	. S r("data","data","list",CNT,"id")=@%G@("STAFF","DATA",STAFF,"id")
	. S r("data","data","list",CNT,"color")=$g(@%G@("STAFF","DATA",STAFF,"color"))
	. S r("data","data","list",CNT,"comm")=$g(@%G@("STAFF","DATA",STAFF,"serviceCommission"))
	. M r("data","data","list",CNT,"image")=@%G@("STAFF","DATA",STAFF,"image")
	Q
	;
addWorkingHours(d,r)
	n ss s ss=$g(d("data","start"))
	n se s se=$g(d("data","end"))
	n day s day=$g(d("data","day"))
	n staff s staff=$g(d("data","staff"))
	i ss="" D Error^FUZ("Start time is required!") Q 
	i se="" D Error^FUZ("End time is required!") Q 
	i day="" D Error^FUZ("Day is required!") Q 
	i staff="" D Error^FUZ("Stylist is required!") Q 
	s ss=$$ZTH^SALON(ss)
	s se=$$ZTH^SALON(se)
	s day=$$ZDH^SALON(day)
	n lshift s lshift=$O(@%G@("STAFF","SCH","DAY",staff,day,""),-1)+1
	;
	;	
	;
	K @%G@("STAFF","SCH","OFF",staff,day)
	s @%G@("STAFF","SCH","DAY",staff,day,lshift,"start")=ss
	s @%G@("STAFF","SCH","DAY",staff,day,lshift,"end")=se
	q
	;
	;
addBlockHours(d,r)
	n ss s ss=$g(d("data","start")) i ss="" D Error^FUZ("Start time is required!") Q 
	n se s se=$g(d("data","end")) i se="" D Error^FUZ("End time is required!") Q 
	n day s day=$g(d("data","day")) i day="" D Error^FUZ("Day is required!") Q 
	n staff s staff=$g(d("data","staff")) i staff="" D Error^FUZ("Stylist is required!") Q
	n title s title=$g(d("data","title")) i title="" D Error^FUZ("Block description is required!") Q 
	n color s color=$g(d("data","color")) i color="" D Error^FUZ("Block color is required!") Q 
	n fontColor s fontColor=$g(d("data","fontColor")) i fontColor="" D Error^FUZ("Text color is required!") Q 
	s ss=$$ZTH^SALON(ss)
	s se=$$ZTH^SALON(se)
	s day=$$ZDH^SALON(day)
	n holder s holder=1
	n st s st=$$isStaffWorking(staff,day_","_ss,(day+1)_","_se,ss,se,.holder)
	i staff>0,'st D Error^FUZ("Cannot add blocked time. "_@%G@("STAFF","DATA",staff,"name")_" is already not working!") Q
	i staff=0,$d(holder)<11 D Error^FUZ("Cannot add blocked time. "_"No stylists are working on "_$$ZD^SALON(day)_"!") Q
	i staff=0 n s s s="" f  s s=$o(holder(s)) q:s=""  d
	. s apptID=$I(@%G@("EVENTS","COUNTER"))
	. s @%G@("EVENTS","BLOCKED-SLOTS",day,ss,apptID,"title")=title
	. s @%G@("EVENTS","BLOCKED-SLOTS",day,ss,apptID,"color")=color
	. s @%G@("EVENTS","BLOCKED-SLOTS",day,ss,apptID,"duration")=(se-ss)
	. s @%G@("EVENTS","BLOCKED-SLOTS",day,ss,apptID,"staff")=s
	. s @%G@("EVENTS","BLOCKED-SLOTS",day,ss,apptID,"fontColor")=fontColor
	e  d
	. s apptID=$I(@%G@("EVENTS","COUNTER"))
	. s @%G@("EVENTS","BLOCKED-SLOTS",day,ss,apptID,"title")=title
	. s @%G@("EVENTS","BLOCKED-SLOTS",day,ss,apptID,"color")=color
	. s @%G@("EVENTS","BLOCKED-SLOTS",day,ss,apptID,"duration")=(se-ss)
	. s @%G@("EVENTS","BLOCKED-SLOTS",day,ss,apptID,"staff")=staff
	. s @%G@("EVENTS","BLOCKED-SLOTS",day,ss,apptID,"fontColor")=fontColor
	;	
	;	
	;	
	q
	;
isStaffWorking(staff,start,end,ts,te,holder)
	n d,h
	s d("data","fetchInfo","start")=$$ZD^SALON(start,3)
	s d("data","fetchInfo","end")=$$ZD^SALON(end,3)
	s d("data","staffSelectedForView")="working"
	n O
	d GetResources^CALENDAR(.d,.O)  
	i staff>0,'$d(O("data","data","resources-list",staff)) q 0
	n shift,ss,se,i,f s f=0
	s shift="" f  s shift=$o(O("data","data","resources-list",staff,shift)) q:shift=""  d
	. s ss=(O("data","data","resources-list",staff,shift,"start")\60)
	. s se=(O("data","data","resources-list",staff,shift,"end")\60)
	. f i=ss+1:1:se-1 s h(i)=""
	f i=ts\60:1:te\60  i $d(h(i)) s f=1
	i $g(holder) m holder=O("data","data","resources-list")
	q f
	;	
	;	
	;
setShiftDetails(dd,r)
	n d m d=dd("data")
	n ss s ss=$g(d("shiftStart"))
	n se s se=$g(d("shiftEnd"))
	i ss="" s r("data","data","failStatus")="Please Set Shift Start Time!" q
	i se="" s r("data","data","failStatus")="Please Set Shift End Time!" q
	s ss=$$ZTH^SALON(ss)
	s se=$$ZTH^SALON(se)
	i se<=ss s r("data","data","failStatus")="Shift Start has to be earlier than Shift End!" q
	;
	n ss2 s ss2=$g(d("shift2Start"))
	n se2 s se2=$g(d("shift2End"))
	i ss2]"",se2="" s r("data","data","failStatus")="2nd Shift End needs to be set!" q
	i ss="",se2]"" s r("data","data","failStatus")="2nd Shift Start needs to be set!" q
	i ss2]"" s ss2=$$ZTH^SALON(ss2)
	i se2]"" s se2=$$ZTH^SALON(se2)
	i se2]"",ss2]"",se2<=ss2 s r("data","data","failStatus")="2nd Shift Start has to be earlier than Shift End!" q
	;
	i ss2]"",ss2<se s r("data","data","failStatus")="2nd Shift Start has to be later than 1st Shift End!" q
	;
	s day=($$ZDH^SALON(d("date"))+d("day"))
	;
	n staff s staff=d("staff")
	;
	i d("repeats")="false" d
	. i ss]"",se]"" d
	.. K @%G@("STAFF","SCH","OFF",staff,day)
	.. s @%G@("STAFF","SCH","DAY",staff,day,1,"start")=ss
	.. s @%G@("STAFF","SCH","DAY",staff,day,1,"end")=se
	.. s @%G@("STAFF","SCH","DAY",staff,day,1,"startReadable")=$$ZT^SALON(ss,4)
	.. s @%G@("STAFF","SCH","DAY",staff,day,1,"endReadable")=$$ZT^SALON(se,4)
	. i ss2]"",se2]"" d
	.. s @%G@("STAFF","SCH","DAY",staff,day,2,"start")=ss2
	.. s @%G@("STAFF","SCH","DAY",staff,day,2,"end")=se2
	.. s @%G@("STAFF","SCH","DAY",staff,day,2,"startReadable")=$$ZT^SALON(ss2,4)
	.. s @%G@("STAFF","SCH","DAY",staff,day,2,"endReadable")=$$ZT^SALON(se2,4)
	i d("repeats")="true" d
	. i ss]"",se]"" d
	.. K @%G@("STAFF","SCH","OFF",staff,day)
	.. s @%G@("STAFF","SCH","BASE",staff,$$ZD^SALON(day,10),1,"start")=ss
	.. s @%G@("STAFF","SCH","BASE",staff,$$ZD^SALON(day,10),1,"end")=se
	.. s @%G@("STAFF","SCH","BASE",staff,$$ZD^SALON(day,10),1,"startReadable")=$$ZT^SALON(ss,4)
	.. s @%G@("STAFF","SCH","BASE",staff,$$ZD^SALON(day,10),1,"endReadable")=$$ZT^SALON(se,4)
	. i ss2]"",se2]"" d
	.. s @%G@("STAFF","SCH","BASE",staff,$$ZD^SALON(day,10),2,"start")=ss2
	.. s @%G@("STAFF","SCH","BASE",staff,$$ZD^SALON(day,10),2,"end")=se2
	.. s @%G@("STAFF","SCH","BASE",staff,$$ZD^SALON(day,10),2,"startReadable")=$$ZT^SALON(ss2,4)
	.. s @%G@("STAFF","SCH","BASE",staff,$$ZD^SALON(day,10),2,"endReadable")=$$ZT^SALON(se2,4)
	i $g(d("remove"))="true" d
	. i d("repeats")="false" d
	.. k @%G@("STAFF","SCH","DAY",staff,day)
	.. s @%G@("STAFF","SCH","OFF",staff,day)=""
	. i d("repeats")="true" d
	.. k @%G@("STAFF","SCH","BASE",staff,$$ZD^SALON(day,10))
	.. s @%G@("STAFF","SCH","OFF",staff,day)=""
	.. k @%G@("STAFF","SCH","DAY",staff,day)
	q
	;
updateColorPickerFont(T)
	N A,M
	S A="" F  S A=$O(T("M",A)) Q:A=""  S M(T("M",A,"model"))=A
	N P
	S P=T("M",M("fontColor"),"data","fontColor") 
	I P="" Q
	;S T("M",M("color"),"props","style")="width:350px;color:"_P
	Q
	;	
	;