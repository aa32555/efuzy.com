CLIENTS
	;
	; MODEL
	; SAVE NEW, UPDATE, LOG, PERMISSIONS, ETC. ;
	Q
	;
ROUTES
	N N I $I(H)
	S @T@("header","mainNav",H,"label")="Clients"
	I $I(N)
	S @T@("header","mainNav",H,"children",N,"label")="Client list"
	S @T@("header","mainNav",H,"children",N,"to")="/clients/list"
	I $I(N)
	S @T@("header","mainNav",H,"children",N,"label")="Edit clients"
	S @T@("header","mainNav",H,"children",N,"to")="/clients/edit"
	I $I(N)
	S @T@("header","mainNav",H,"children",N,"label")="Add new client"
	S @T@("header","mainNav",H,"children",N,"to")="/clients/add/*"
	;
	;
	i $I(P)
	S @T@("pages",P,"path")="/clients/list"
	S @T@("pages",P,"name")="Clients"
	S @T@("pages",P,"childBreadcrump")="clientlist"
	S @T@("pages",P,"breadcrump")="clients"
	S @T@("pages",P,"component")="FUZPage"
	S @T@("pages",P,"requiresAuth")="true"
	S @T@("pages",P,"routine")="TREE^CLIENTS"
	S @T@("pages",P,"type")="SALON"
	;
	i $I(P)
	S @T@("pages",P,"path")="/clients/edit"
	S @T@("pages",P,"name")="Edit Clients"
	S @T@("pages",P,"childBreadcrump")="editclient"
	S @T@("pages",P,"breadcrump")="clients"
	S @T@("pages",P,"subName")="ClientEdit"
	S @T@("pages",P,"component")="FUZPage"
	S @T@("pages",P,"requiresAuth")="true"
	S @T@("pages",P,"routine")="EDITALLTREE^CLIENTS"
	S @T@("pages",P,"type")="SALON"
	;
	i $I(P)
	S @T@("pages",P,"path")="/clients/edit/:id"
	S @T@("pages",P,"name")="Edit Client"
	S @T@("pages",P,"childBreadcrump")="editclient"
	S @T@("pages",P,"breadcrump")="clients"
	S @T@("pages",P,"component")="FUZPage"
	S @T@("pages",P,"requiresAuth")="true"
	S @T@("pages",P,"routine")="EDITTREE^CLIENTS"
	S @T@("pages",P,"type")="SALON"
	;
	i $I(P)
	S @T@("pages",P,"path")="/clients/add/:id"
	S @T@("pages",P,"name")="Add Client"
	S @T@("pages",P,"childBreadcrump")="addclient"
	S @T@("pages",P,"breadcrump")="clients"
	S @T@("pages",P,"component")="FUZPage"
	S @T@("pages",P,"requiresAuth")="true"
	S @T@("pages",P,"routine")="ADDTREE^CLIENTS"
	S @T@("pages",P,"type")="SALON"
	;
	;       
	Q       
	;       
	;
onAfterModelSave
	I $G(DATA("noRerouteAfterSave"))="true" Q
	S %J("dispatch","action")="app/changeRoute"
	S %J("dispatch","data")="/clients/list"
	Q
	;       
	;
Model(T)
	N R 
	;
	S T("F","title")="Add Client"
	S T("F","editTitle")="Edit Client"
	S T("F","multiIndex",1)="phone"
	;S T("F","multiIndex",2)="phone"
	S T("F","searchIndex")=1
	;S T("F","indexX")="S SI=""firstname:lastname:phone"" I DATA(""search"")?1N.NN S SI=""phone"""
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
	I $I(R) 
	S T("M",R,"model")="name"
	S T("M",R,"data","name")=""
	S T("M",R,"type")="computed"
	S T("M",R,"computed")="updateName^CLIENTS"
	S T("M",R,"is")="span"
	S T("M",R,"props","style")="display:none;"
	S T("M",R,"index")="true"
	;       
	;
	I $I(R)
	S T("M",R,"is")="FUZImg"
	S T("M",R,"model")="image"
	S T("M",R,"data","image")="female.jpg"
	S T("M",R,"type")="view-image"
	S T("M",R,"props","imgProps","avatar")="true"
	S T("M",R,"props","imgProps","imageClass")="v1-image"
	S T("M",R,"props","imgProps","size")="100px"
	S T("M",R,"props","imgProps","font-size")="52px"
	;S T("M",M("image"),"props","imgProps","width")="34vw"  
	s T("M",R,"props","imgProps","parentStyle")="width:350px;"
	s T("M",R,"props","imgProps","parentClass")="flex flex-center q-pa-md row"
	s T("M",R,"props","imgProps","label")="Client photo"
	s T("M",R,"props","imgProps","labelStyle")="width:350px;"
	s T("M",R,"props","imgProps","labelClass")="text-grey text-center"
	s T("M",R,"props","imgProps","flat")="true"
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
	I $I(R) 
	S T("M",R,"model")="allowSms"
	S T("M",R,"data","allowSms")="true"
	S T("M",R,"type")="string"
	S T("M",R,"is")="q-toggle"      
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","disable")="false"
	S T("M",R,"props","label")="Allow Text Messages"
	S T("M",R,"rules","required")="true"
	;
	I $I(R) 
	S T("M",R,"model")="firstname"
	S T("M",R,"data","firstname")=""
	S T("M",R,"type")="string"
	S T("M",R,"is")="q-input"       
	S T("M",R,"props","rounded")="true"
	S T("M",R,"props","outlined")="true"
	S T("M",R,"props","label")="firstname"
	S T("M",R,"props","lazy-rules")="true"
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"transformOnIndex")="V=$$ZCVT^SALON(V,""L"")"
	S T("M",R,"rules","required")="true"
	S T("M",R,"index")="true"
	;
	I $I(R)
	S T("M",R,"type")="string"
	S T("M",R,"model")="lastname"
	S T("M",R,"data","lastname")=""
	S T("M",R,"is")="q-input"               
	S T("M",R,"props","rounded")="true"
	S T("M",R,"props","outlined")="true"
	S T("M",R,"props","label")="Lastname"
	S T("M",R,"props","lazy-rules")="true"
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"transformOnIndex")="V=$$ZCVT^SALON(V,""L"")"
	S T("M",R,"rules","required")="true"
	S T("M",R,"index")="true"
	;
	I $I(R)
	S T("M",R,"type")="number"
	S T("M",R,"model")="phone"
	S T("M",R,"data","phone")=""
	S T("M",R,"is")="q-input"       
	S T("M",R,"props","hint")="(123) 456-7890"      
	S T("M",R,"props","type")="tel"
	S T("M",R,"props","mask")="(###) ###-####"
	S T("M",R,"props","rounded")="true"
	S T("M",R,"props","outlined")="true"
	S T("M",R,"props","label")="Phone"
	S T("M",R,"props","lazy-rules")="true"
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"index")="true"
	S T("M",R,"transformOnIndex")="V=$tr(V,""()- "")"
	S T("M",R,"onChange")="CheckDuplicatePhone"
	S T("M",R,"unique")="true"
	S T("M",R,"rules","phone")="true"
	;
	I $I(R)
	S T("M",R,"type")="radio"
	S T("M",R,"model")="sex"
	S T("M",R,"data","sex")="F"
	s T("M",R,"onInput")="UpdateClientGender"
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"options",1,"label")="Male"
	S T("M",R,"options",1,"val")="M"
	S T("M",R,"options",2,"label")="Female"
	S T("M",R,"options",2,"val")="F"
	S T("M",R,"options",3,"label")="Other"
	S T("M",R,"options",3,"val")="O"
	;
	I $I(R) 
	S T("M",R,"type")="date"
	S T("M",R,"model")="birthday"
	S T("M",R,"data","birthday")=""
	S T("M",R,"is")="q-input"
	S T("M",R,"props","rounded")="true"
	S T("M",R,"props","outlined")="true"
	S T("M",R,"props","label")="Birthday"
	S T("M",R,"props","lazy-rules")="true"
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","mask")="##/##/####"
	S T("M",R,"rules","date")="true"
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZSelect"
	S T("M",R,"model")="source"
	S T("M",R,"data","source")="Phone"              
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Source"
	S T("M",R,"props","options",1)="Google"
	S T("M",R,"props","options",2)="Yelp"
	S T("M",R,"props","options",3)="Instagram"
	S T("M",R,"props","options",4)="Facebook"
	S T("M",R,"props","options",5)="Phone"
	S T("M",R,"props","options",6)="Walkin"
	S T("M",R,"props","options",7)="Other"
	;
	I $I(R)
	S T("M",R,"type")="string"
	S T("M",R,"model")="notes"
	S T("M",R,"data","notes")=""
	S T("M",R,"is")="q-input"               
	S T("M",R,"props","type")="textarea"
	S T("M",R,"props","autogrow")="true"
	S T("M",R,"props","rounded")="true"
	S T("M",R,"props","outlined")="true"
	S T("M",R,"props","label")="Notes"
	S T("M",R,"props","lazy-rules")="true"
	S T("M",R,"props","style")="width:350px;"
	;
	;
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
	S T(R,"subSubComponent","props","toID")="/clients/view/"
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
	S T(R,"subSubComponent","props","buttons",1,"type")="CLIENTS"
	S T(R,"subSubComponent","props","buttons",1,"onClick")="ViewRecord^FUZNEW"
	S T(R,"subSubComponent","props","buttons",1,"props","clickable")="true"
	S T(R,"subSubComponent","props","buttons",1,"props","v-close-popup")="true"
	S T(R,"subSubComponent","props","buttons",2,"title")="Edit"
	S T(R,"subSubComponent","props","buttons",2,"action")="routine"
	S T(R,"subSubComponent","props","buttons",2,"type")="CLIENTS"
	S T(R,"subSubComponent","props","buttons",2,"onClick")="EditRecord^FUZNEW"
	S T(R,"subSubComponent","props","buttons",2,"props","clickable")="true"
	S T(R,"subSubComponent","props","buttons",2,"props","v-close-popup")="true"
	S T(R,"subSubComponent","props","buttons",3,"title")="Delete"
	S T(R,"subSubComponent","props","buttons",3,"action")="routine"
	S T(R,"subSubComponent","props","buttons",3,"type")="CLIENTS"
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
	S T("rows",R,"cols",C,"title")="Clients"
	S T("rows",R,"cols",C,"is")="FUZList"
	S T("rows",R,"cols",C,"props","type")="CLIENTS"
	S T("rows",R,"cols",C,"props","routine")="List^CLIENTS"
	S T("rows",R,"cols",C,"props","header")="Clients"
	S T("rows",R,"cols",C,"props","emptyListText")="No clients found, click this button to add clients!"
	;S T("rows",R,"cols",C,"props","orderable")="true"
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
CLIENTTREE(T)
	N R,C
	I $I(R),$I(C)
	S T("rows",R,"class")="row"
	S T("rows",R,"is")="div"
	S T("rows",R,"cols",C,"class")="col"
	S T("rows",R,"cols",C,"title")="Client"
	S T("rows",R,"cols",C,"is")="FUZNew"
	S T("rows",R,"cols",C,"props","type")="CLIENTS"
	S T("rows",R,"cols",C,"props","view")="true"
	Q
	;
EDITTREE(T)
	N R,C
	I $I(R),$I(C)
	S T("rows",R,"class")="row"
	S T("rows",R,"is")="div"
	S T("rows",R,"cols",C,"class")="col"
	S T("rows",R,"cols",C,"title")="Edit Client"
	S T("rows",R,"cols",C,"is")="FUZNew"
	S T("rows",R,"cols",C,"props","type")="CLIENTS"
	Q
	;
ADDTREE(T)
	N R,C
	I $I(R),$I(C)
	S T("rows",R,"class")="row"
	S T("rows",R,"is")="div"
	S T("rows",R,"cols",C,"class")="col"
	S T("rows",R,"cols",C,"title")="New Client"
	S T("rows",R,"cols",C,"is")="FUZNew"
	S T("rows",R,"cols",C,"props","type")="CLIENTS"
	Q       
	;
EDITALLTREE(T)
	N R,C
	I $I(R),$I(C)
	S T("rows",R,"class")="row"
	S T("rows",R,"is")="div"
	S T("rows",R,"cols",C,"class")="flex flex-center col"
	S T("rows",R,"cols",C,"title")="Search Clients"
	S T("rows",R,"cols",C,"is")="FUZListSearchPage"
	S T("rows",R,"cols",C,"props","type")="CLIENTS"
	S T("rows",R,"cols",C,"props","routine")="List^CLIENTS"
	S T("rows",R,"cols",C,"props","label")="Search clients"
	S T("rows",R,"cols",C,"props","selectItems","avatar")="image"
	S T("rows",R,"cols",C,"props","selectItems","label")="name"
	S T("rows",R,"cols",C,"props","selectItems","caption",1)="phone"
	S T("rows",R,"cols",C,"props","selectItems","caption",2)="notes"
	Q
	;       
	;       
UpdateClientGender(T)
	N A,M
	S A="" F  S A=$O(T("M",A)) Q:A=""  S M(T("M",A,"model"))=A 
	I $D(T("M",M("image"),"data","image"))>1 Q
	I T("M",M("sex"),"data","sex")="F" S T("M",M("image"),"data","image")="female.jpg"
	I T("M",M("sex"),"data","sex")="M" S T("M",M("image"),"data","image")="male.png"
	I T("M",M("sex"),"data","sex")="O" S T("M",M("image"),"data","image")="other.jpg"
	Q
	;
CheckDuplicatePhone(T)
	N A,M
	S A="" F  S A=$O(T("M",A)) Q:A=""  S M(T("M",A,"model"))=A
	N P
	S P=T("M",M("phone"),"data","phone") 
	I P="" Q
	S P=$TR(P,"()- ")
	I $D(@%G@("CLIENTS","INDEX","phone",P)) D
	. D Warning^FUZ("Client already exists. Update existing instead. Client ID: "_@%G@("CLIENTS","INDEX","phone",P))
	. D FillModel^FUZNEW(.T,"CLIENTS",@%G@("CLIENTS","INDEX","phone",P))
	. S T("F","title")="ID:"_@%G@("CLIENTS","INDEX","phone",P)
	Q
	;
FillModel(T,ID)
	D FillModel^FUZNEW(.T,"CLIENTS",ID)
	q
	N A,M S A="" F  S A=$O(T("M",A)) Q:A=""  S M(T("M",A,"model"))=A
	N V M V=T("M",M("image"),"data","image")
	b
	K T("M",M("image"))
	S T("M",M("image"),"is")="FUZImg"
	S T("M",M("image"),"model")="image"
	M T("M",M("image"),"data","image")=V
	S T("M",M("image"),"type")="view-image"
	S T("M",M("image"),"props","imgProps","avatar")="true"
	S T("M",M("image"),"props","imgProps","imageClass")="v1-image"
	S T("M",M("image"),"props","imgProps","size")="200px"
	S T("M",M("image"),"props","imgProps","font-size")="104px"
	S T("M",M("image"),"props","imgProps","width")="250"    
	Q
	;
updateName(T)
	N A,M S A="" F  S A=$O(T("model",A)) Q:A=""  S M(T("model",A,"model"))=A
	N V S V=T("model",M("firstname"),"data","firstname")_" "_T("model",M("lastname"),"data","lastname")
	S T("model",M("name"),"data","name")=V
	Q
	;
	;
	;
getClients(dd,rr,s) b
	n r s r="r"
	n d m d=dd("data")
	n done s done=0
	N A S A="" F  S A=$O(@%GLOBAL@("CLIENT","DATA",A)) Q:A=""  Q:done  D
	. I 'A Q
	. S LASTINV=$g(@%GLOBAL@("CLIENT","DATA",A,"LAST_INVOICE"))
	. S LASTHERE="",LASTSTAFF="",LASTITEM=""
	. I LASTINV S LREF=$O(@%GLOBAL@("INVOICE","DATA",LASTINV,"")) I LREF]"" D
	.. S LASTHERE=$$ZD^SALON($$ZDTH^SALON(@%GLOBAL@("INVOICE","DATA",LASTINV,LREF,"Invoice Date"),3,1),1,4)
	.. S LASTSTAFF=@%GLOBAL@("INVOICE","DATA",LASTINV,LREF,"Staff")
	.. S LASTITEM=@%GLOBAL@("INVOICE","DATA",LASTINV,LREF,"Item")
	. I $G(d("searchText"))?1N.NN,$G(@%GLOBAL@("CLIENT","DATA",A,"Mobile Number"))]"",$G(d("searchText"))]"",$TR(@%GLOBAL@("CLIENT","DATA",A,"Mobile Number"),"()-+ ")[$$ZCVT^SALON(d("searchText"),"L") D  I 1
	.. S CNT=($O(@r@("list",""),-1)+1)
	.. D BuildClientlist
	. I $G(d("searchText"))]"",$$ZCVT^SALON(@%GLOBAL@("CLIENT","DATA",A,"Name"),"L")[$$ZCVT^SALON(d("searchText"),"L") D  I 1
	.. S CNT=($O(@r@("list",""),-1)+1)
	.. D BuildClientlist
	. E  I $G(d("searchText"))="" D
	.. S CNT=($O(@r@("list",""),-1)+1)
	.. I CNT>20 S done=1 Q
	.. I CNT<20 D BuildClientlist
	zk r
	m rr("data","data")=r
	q
BuildClientlist
	S @r@("list",CNT,"name")=@%GLOBAL@("CLIENT","DATA",A,"Name")
	S @r@("list",CNT,"id")=A
	S @r@("list",CNT,"value")=A
	S @r@("list",CNT,"label")=@%GLOBAL@("CLIENT","DATA",A,"Name")
	S @r@("list",CNT,"number")=$G(@%GLOBAL@("CLIENT","DATA",A,"Mobile Number"))
	S @r@("list",CNT,"lasthere")=LASTHERE
	S @r@("list",CNT,"lastitem")=LASTITEM
	S @r@("list",CNT,"laststaff")=LASTSTAFF
	S @r@("list",CNT,"invoice")=LASTINV
	S @r@("list",CNT,"referral")=$G(@%GLOBAL@("CLIENT","DATA",A,"Referral Source"))
	S @r@("list",CNT,"notes")=$G(@%GLOBAL@("CLIENT","DATA",A,"Note"))
	Q
	;
	q
	;
	;