SERVICES
	;
	; MODEL
	; SAVE NEW, UPDATE, LOG, PERMISSIONS, ETC. ;
	Q
	;
ROUTES
	K N I $I(H)
	S @T@("header","mainNav",H,"label")="Services"
	I $I(N)
	S @T@("header","mainNav",H,"children",N,"label")="Services list"
	S @T@("header","mainNav",H,"children",N,"to")="/services/list"
	I $I(N)
	S @T@("header","mainNav",H,"children",N,"label")="Edit services"
	S @T@("header","mainNav",H,"children",N,"to")="/services/edit"
	I $I(N)
	S @T@("header","mainNav",H,"children",N,"label")="Add service"
	S @T@("header","mainNav",H,"children",N,"to")="/services/add/*"
	;
	;
	i $I(P)
	S @T@("pages",P,"path")="/services/list"
	S @T@("pages",P,"name")="Services"
	S @T@("pages",P,"childBreadcrump")="servicelist"
	S @T@("pages",P,"breadcrump")="services"
	S @T@("pages",P,"component")="FUZPage"
	S @T@("pages",P,"requiresAuth")="true"
	S @T@("pages",P,"routine")="TREE^SERVICES"
	S @T@("pages",P,"type")="SALON"
	;
	i $I(P)
	S @T@("pages",P,"path")="/services/edit"
	S @T@("pages",P,"name")="Edit Services"
	S @T@("pages",P,"childBreadcrump")="editservice"
	S @T@("pages",P,"breadcrump")="services"
	S @T@("pages",P,"subName")="ServiceEdit"
	S @T@("pages",P,"component")="FUZPage"
	S @T@("pages",P,"requiresAuth")="true"
	S @T@("pages",P,"routine")="EDITALLTREE^SERVICES"
	S @T@("pages",P,"type")="SALON"
	;
	i $I(P)
	S @T@("pages",P,"path")="/services/edit/:id"
	S @T@("pages",P,"name")="Edit Service"
	S @T@("pages",P,"childBreadcrump")="editservice"
	S @T@("pages",P,"breadcrump")="services"
	S @T@("pages",P,"component")="FUZPage"
	S @T@("pages",P,"requiresAuth")="true"
	S @T@("pages",P,"routine")="EDITTREE^SERVICES"
	S @T@("pages",P,"type")="SALON"
	;
	i $I(P)
	S @T@("pages",P,"path")="/services/add/:id"
	S @T@("pages",P,"name")="Add Service"
	S @T@("pages",P,"childBreadcrump")="addservice"
	S @T@("pages",P,"breadcrump")="services"
	S @T@("pages",P,"component")="FUZPage"
	S @T@("pages",P,"requiresAuth")="true"
	S @T@("pages",P,"routine")="ADDTREE^SERVICES"
	S @T@("pages",P,"type")="SALON"
	;
	;
	Q       
	;       
	;
onAfterModelSave
	I $G(DATA("noRerouteAfterSave"))="true" Q
	S %J("dispatch","action")="app/changeRoute"
	S %J("dispatch","data")="/services/list"
	Q
	;       
onBeforeModelSave
	N DATA M DATA=D("data")
	N PAGE S PAGE=$$ZCVT^SALON(DATA("type"),"U")
	N MODEL M MODEL=DATA("model")
	N FORM M FORM=DATA("form")
	N T
	S STATUS=0
	M T("M")=MODEL
	M T("F")=FORM
	N A,M
	S A="" F  S A=$O(T("M",A)) Q:A=""  S M(T("M",A,"model"))=A
	N P
	M P=T("M",M("category"),"data","category") 
	I '$D(P) D  Q
	. D Error^FUZ("Service category is required.")  
	S STATUS="OK"
	Q
	;
FillModel(T,ID)
	N A,M
	S A="" F  S A=$O(T("M",A)) Q:A=""  S M(T("M",A,"model"))=A
	;       
	S T("M",1,"model")="id"
	S T("M",1,"data","id")=ID
	;       
	N I
	S I=$G(@%G@("SERVICES","DATA",ID,"serviceOptions"))
	F P=2:1:I D
	. S LASTINDEX=$O(T("M",""),-1)
	. ;
	. K T("M",LASTINDEX)
	.;
	.S T("M",LASTINDEX,"type")="number"
	.S T("M",LASTINDEX,"model")="empty"
	.S T("M",LASTINDEX,"data","empty")=""
	.S T("M",LASTINDEX,"is")="FUZHeader"    
	.S T("M",LASTINDEX,"props","props","label")="Service option "_P
	.S T("M",LASTINDEX,"props","props","class")="text-h6"
	.S T("M",LASTINDEX,"props","props","style")="width:350px;"
	.S T("M",LASTINDEX,"props","disable")="true"
	. S LASTINDEX=$O(T("M",""),-1)+1
	.;
	. S T("M",LASTINDEX,"type")="number"
	. S T("M",LASTINDEX,"model")="empty"
	. S T("M",LASTINDEX,"data","empty")=""
	. S T("M",LASTINDEX,"is")="q-input"     
	. S T("M",LASTINDEX,"props","label")=""
	. S T("M",LASTINDEX,"props","disable")="true"
	. S LASTINDEX=$O(T("M",""),-1)+1
	. S T("M",LASTINDEX,"type")="number"
	. S T("M",LASTINDEX,"model")="empty"
	. S T("M",LASTINDEX,"data","empty")=""
	. S T("M",LASTINDEX,"is")="q-input"     
	. S T("M",LASTINDEX,"props","label")=""
	. S T("M",LASTINDEX,"props","disable")="true"
	. S LASTINDEX=$O(T("M",""),-1)+1
	.S T("M",LASTINDEX,"model")="serviceOption"_(P)_"name"
	.S T("M",LASTINDEX,"data","serviceOption"_(P)_"name")=""
	.S T("M",LASTINDEX,"type")="string"
	.S T("M",LASTINDEX,"is")="q-input"      
	.S T("M",LASTINDEX,"props","rounded")="true"
	.S T("M",LASTINDEX,"props","outlined")="true"
	.S T("M",LASTINDEX,"props","label")="Service option "_(P)_" name"
	.S T("M",LASTINDEX,"props","lazy-rules")="true"
	.S T("M",LASTINDEX,"props","style")="width:350px;"
	.S T("M",LASTINDEX,"rules","required")="true"
	.;
	.S LASTINDEX=$O(T("M",""),-1)+1
	.;
	.S T("M",LASTINDEX,"type")="string"
	.S T("M",LASTINDEX,"model")="serviceOption"_(P)_"desc"
	.S T("M",LASTINDEX,"data","description")=""
	.S T("M",LASTINDEX,"is")="q-input"              
	.S T("M",LASTINDEX,"props","type")="textarea"
	.S T("M",LASTINDEX,"props","autogrow")="true"
	.S T("M",LASTINDEX,"props","rounded")="true"
	.S T("M",LASTINDEX,"props","outlined")="true"
	.S T("M",LASTINDEX,"props","label")="Service option "_(P)_" description"
	.S T("M",LASTINDEX,"props","lazy-rules")="true"
	.S T("M",LASTINDEX,"props","style")="width:350px;"
	.;
	. S LASTINDEX=$O(T("M",""),-1)+1
	. s T("M",LASTINDEX,"is")="FUZImg"
	. S T("M",LASTINDEX,"model")="image"_(P)_""
	. S T("M",LASTINDEX,"data","image"_(P)_"")="placeholder-image.png"
	. S T("M",LASTINDEX,"type")="view-image"
	. S T("M",LASTINDEX,"props","imgProps","avatar")="true"
	. S T("M",LASTINDEX,"props","imgProps","imageClass")="v1-image"
	. S T("M",LASTINDEX,"props","imgProps","size")="100px"
	. S T("M",LASTINDEX,"props","imgProps","font-size")="52px"
	. s T("M",LASTINDEX,"props","imgProps","parentStyle")="width:350px;"
	. s T("M",LASTINDEX,"props","imgProps","parentClass")="flex flex-center q-pa-md row"
	. s T("M",LASTINDEX,"props","imgProps","label")="Service photo "_(P)
	. s T("M",LASTINDEX,"props","imgProps","labelStyle")="width:350px;"
	. s T("M",LASTINDEX,"props","imgProps","labelClass")="text-grey text-center"
	. s T("M",LASTINDEX,"props","imgProps","flat")="true"
	. S LASTINDEX=$O(T("M",""),-1)+1
	.;
	. ;
	.S T("M",LASTINDEX,"type")="number"
	.S T("M",LASTINDEX,"model")="serviceOption"_(P)_"Price"
	.S T("M",LASTINDEX,"data","serviceOption"_(P)_"Price")=""
	.S T("M",LASTINDEX,"is")="q-input"              
	.S T("M",LASTINDEX,"props","type")="number"
	.S T("M",LASTINDEX,"props","mask")="####.##"
	.S T("M",LASTINDEX,"props","rounded")="true"
	.S T("M",LASTINDEX,"props","outlined")="true"
	.S T("M",LASTINDEX,"props","label")="Service option "_(P)_" price"
	.S T("M",LASTINDEX,"props","lazy-rules")="true"
	.S T("M",LASTINDEX,"props","style")="width:350px;"
	.S T("M",LASTINDEX,"rules","required")="true"
	.;
	.S LASTINDEX=$O(T("M",""),-1)+1
	.;
	.S T("M",LASTINDEX,"type")="number"
	.S T("M",LASTINDEX,"model")="serviceOption"_(P)_"DiscountedPrice"
	.S T("M",LASTINDEX,"data","serviceOption"_(P)_"DiscountedPrice")=""
	.S T("M",LASTINDEX,"is")="q-input"              
	.S T("M",LASTINDEX,"props","type")="number"
	.S T("M",LASTINDEX,"props","mask")="####.##"
	.S T("M",LASTINDEX,"props","rounded")="true"
	.S T("M",LASTINDEX,"props","outlined")="true"
	.S T("M",LASTINDEX,"props","label")="Service option "_(P)_" discounted price"
	.S T("M",LASTINDEX,"props","lazy-rules")="true"
	.S T("M",LASTINDEX,"props","style")="width:350px;"
	.S T("M",LASTINDEX,"rules","required")="true"
	.;
	.S LASTINDEX=$O(T("M",""),-1)+1
	.;
	.S T("M",LASTINDEX,"type")="number"
	.S T("M",LASTINDEX,"model")="serviceOption"_(P)_"Duration"
	.S T("M",LASTINDEX,"data","serviceOption"_(P)_"Duration")=""
	.S T("M",LASTINDEX,"is")="q-input"      
	.S T("M",LASTINDEX,"props","type")="number"
	.S T("M",LASTINDEX,"props","mask")="#####"
	.S T("M",LASTINDEX,"props","rounded")="true"
	.S T("M",LASTINDEX,"props","outlined")="true"
	.S T("M",LASTINDEX,"props","label")="Service option "_(P)_" duration in mins"
	.S T("M",LASTINDEX,"props","lazy-rules")="true"
	.S T("M",LASTINDEX,"props","style")="width:350px;"
	.S T("M",LASTINDEX,"rules","required")="true"
	.S LASTINDEX=$O(T("M",""),-1)+1
	.;
	.;
	.S T("M",LASTINDEX,"type")="number"
	.S T("M",LASTINDEX,"model")="serviceOption"_(P)_"Processing"
	.S T("M",LASTINDEX,"data","serviceOption"_(P)_"Processing")=""
	.S T("M",LASTINDEX,"is")="q-input"      
	.S T("M",LASTINDEX,"props","type")="number"
	.S T("M",LASTINDEX,"props","mask")="#####"
	.S T("M",LASTINDEX,"props","rounded")="true"
	.S T("M",LASTINDEX,"props","outlined")="true"
	.S T("M",LASTINDEX,"props","label")="Service option "_(P)_" processing in mins"
	.S T("M",LASTINDEX,"props","lazy-rules")="true"
	.S T("M",LASTINDEX,"props","style")="width:350px;"
	.S T("M",LASTINDEX,"rules","required")="true"
	.;
	.S LASTINDEX=$O(T("M",""),-1)+1
	.S T("M",LASTINDEX,"type")="btn"
	.S T("M",LASTINDEX,"model")="serviceOptions"
	.S T("M",LASTINDEX,"data","serviceOptions")=(P)
	.S T("M",LASTINDEX,"is")="q-btn"                
	.S T("M",LASTINDEX,"props","color")="primary"
	.S T("M",LASTINDEX,"props","rounded")="true"
	.S T("M",LASTINDEX,"props","outlined")="true"
	.S T("M",LASTINDEX,"props","label")="+ Add service options"
	.S T("M",LASTINDEX,"onClick")="AddMoreServiceOptions"
	.S T("M",LASTINDEX,"props","lazy-rules")="true"
	.S T("M",LASTINDEX,"props","style")="width:350px;"
	D FillModel^FUZNEW(.T,"SERVICES",ID)
	Q
	;       
	;       
AddMoreServiceOptions(T)
	N A,M
	S A="" F  S A=$O(T("M",A)) Q:A=""  S M(T("M",A,"model"))=A
	N P
	S P=T("M",M("serviceOptions"),"data","serviceOptions")
	S T("M",M("serviceOptions"),"data","serviceOptions")=P+1
	S LASTINDEX=$O(T("M",""),-1)
	;
	K T("M",LASTINDEX)
	;
	S T("M",LASTINDEX,"type")="number"
	S T("M",LASTINDEX,"model")="empty"
	S T("M",LASTINDEX,"data","empty")=""
	S T("M",LASTINDEX,"is")="FUZHeader"     
	S T("M",LASTINDEX,"props","props","label")="Service option "_(P+1)
	S T("M",LASTINDEX,"props","props","class")="text-h6"
	S T("M",LASTINDEX,"props","props","style")="width:350px;"
	S T("M",LASTINDEX,"props","disable")="true"
	S LASTINDEX=$O(T("M",""),-1)+1
	;
	S T("M",LASTINDEX,"type")="number"
	S T("M",LASTINDEX,"model")="empty"
	S T("M",LASTINDEX,"data","empty")=""
	S T("M",LASTINDEX,"is")="q-input"       
	S T("M",LASTINDEX,"props","label")=""
	S T("M",LASTINDEX,"props","disable")="true"
	S LASTINDEX=$O(T("M",""),-1)+1
	;
	S T("M",LASTINDEX,"type")="number"
	S T("M",LASTINDEX,"model")="empty"
	S T("M",LASTINDEX,"data","empty")=""
	S T("M",LASTINDEX,"is")="q-input"       
	S T("M",LASTINDEX,"props","label")=""
	S T("M",LASTINDEX,"props","disable")="true"
	S LASTINDEX=$O(T("M",""),-1)+1
	;
	S T("M",LASTINDEX,"model")="serviceOption"_(P+1)_"name"
	S T("M",LASTINDEX,"data","serviceOption"_(P+1)_"name")=""
	S T("M",LASTINDEX,"type")="string"
	S T("M",LASTINDEX,"is")="q-input"       
	S T("M",LASTINDEX,"props","rounded")="true"
	S T("M",LASTINDEX,"props","outlined")="true"
	S T("M",LASTINDEX,"props","label")="Service option "_(P+1)_" name"
	S T("M",LASTINDEX,"props","lazy-rules")="true"
	S T("M",LASTINDEX,"props","style")="width:350px;"
	S T("M",LASTINDEX,"rules","required")="true"
	;
	S LASTINDEX=$O(T("M",""),-1)+1
	;
	S T("M",LASTINDEX,"type")="string"
	S T("M",LASTINDEX,"model")="serviceOption"_(P+1)_"desc"
	S T("M",LASTINDEX,"data","description")=""
	S T("M",LASTINDEX,"is")="q-input"               
	S T("M",LASTINDEX,"props","type")="textarea"
	S T("M",LASTINDEX,"props","autogrow")="true"
	S T("M",LASTINDEX,"props","rounded")="true"
	S T("M",LASTINDEX,"props","outlined")="true"
	S T("M",LASTINDEX,"props","label")="Service option "_(P+1)_" description"
	S T("M",LASTINDEX,"props","lazy-rules")="true"
	S T("M",LASTINDEX,"props","style")="width:350px;"
	;
	S LASTINDEX=$O(T("M",""),-1)+1
	;
	S T("M",LASTINDEX,"is")="FUZImg"
	S T("M",LASTINDEX,"model")="image"_(P+1)_""
	S T("M",LASTINDEX,"data","image"_(P+1)_"")="placeholder-image.png"
	S T("M",LASTINDEX,"type")="view-image"
	S T("M",LASTINDEX,"props","imgProps","avatar")="true"
	S T("M",LASTINDEX,"props","imgProps","imageClass")="v1-image"
	S T("M",LASTINDEX,"props","imgProps","size")="100px"
	S T("M",LASTINDEX,"props","imgProps","font-size")="52px"
	s T("M",LASTINDEX,"props","imgProps","parentStyle")="width:350px;"
	s T("M",LASTINDEX,"props","imgProps","parentClass")="flex flex-center q-pa-md row"
	s T("M",LASTINDEX,"props","imgProps","label")="Service photo "_(P+1)
	s T("M",LASTINDEX,"props","imgProps","labelStyle")="width:350px;"
	s T("M",LASTINDEX,"props","imgProps","labelClass")="text-grey text-center"
	s T("M",LASTINDEX,"props","imgProps","flat")="true"
	;       
	;       
	S LASTINDEX=$O(T("M",""),-1)+1
	;
	S T("M",LASTINDEX,"type")="number"
	S T("M",LASTINDEX,"model")="serviceOption"_(P+1)_"Price"
	S T("M",LASTINDEX,"data","serviceOption"_(P+1)_"Price")=""
	S T("M",LASTINDEX,"is")="q-input"               
	S T("M",LASTINDEX,"props","type")="number"
	S T("M",LASTINDEX,"props","mask")="####.##"
	S T("M",LASTINDEX,"props","rounded")="true"
	S T("M",LASTINDEX,"props","outlined")="true"
	S T("M",LASTINDEX,"props","label")="Service option "_(P+1)_" price"
	S T("M",LASTINDEX,"props","lazy-rules")="true"
	S T("M",LASTINDEX,"props","style")="width:350px;"
	S T("M",LASTINDEX,"rules","required")="true"
	;
	S LASTINDEX=$O(T("M",""),-1)+1
	;
	S T("M",LASTINDEX,"type")="number"
	S T("M",LASTINDEX,"model")="serviceOption"_(P+1)_"DiscountedPrice"
	S T("M",LASTINDEX,"data","serviceOption"_(P+1)_"DiscountedPrice")=""
	S T("M",LASTINDEX,"is")="q-input"               
	S T("M",LASTINDEX,"props","type")="number"
	S T("M",LASTINDEX,"props","mask")="####.##"
	S T("M",LASTINDEX,"props","rounded")="true"
	S T("M",LASTINDEX,"props","outlined")="true"
	S T("M",LASTINDEX,"props","label")="Service option "_(P+1)_" discounted price"
	S T("M",LASTINDEX,"props","lazy-rules")="true"
	S T("M",LASTINDEX,"props","style")="width:350px;"
	S T("M",LASTINDEX,"rules","required")="true"
	;
	S LASTINDEX=$O(T("M",""),-1)+1
	;
	S T("M",LASTINDEX,"type")="number"
	S T("M",LASTINDEX,"model")="serviceOption"_(P+1)_"Duration"
	S T("M",LASTINDEX,"data","serviceOption"_(P+1)_"Duration")=""
	S T("M",LASTINDEX,"is")="q-input"               
	S T("M",LASTINDEX,"props","type")="number"
	S T("M",LASTINDEX,"props","mask")="####.##"
	S T("M",LASTINDEX,"props","rounded")="true"
	S T("M",LASTINDEX,"props","outlined")="true"
	S T("M",LASTINDEX,"props","label")="Service option "_(P+1)_" duration in mins"
	S T("M",LASTINDEX,"props","lazy-rules")="true"
	S T("M",LASTINDEX,"props","style")="width:350px;"
	S T("M",LASTINDEX,"rules","required")="true"
	;
	S LASTINDEX=$O(T("M",""),-1)+1
	;
	S T("M",LASTINDEX,"type")="number"
	S T("M",LASTINDEX,"model")="serviceOption"_(P+1)_"Processing"
	S T("M",LASTINDEX,"data","serviceOption"_(P+1)_"Processing")=""
	S T("M",LASTINDEX,"is")="q-input"       
	S T("M",LASTINDEX,"props","type")="number"
	S T("M",LASTINDEX,"props","mask")="#####"
	S T("M",LASTINDEX,"props","rounded")="true"
	S T("M",LASTINDEX,"props","outlined")="true"
	S T("M",LASTINDEX,"props","label")="Service option "_(P+1)_" processing in mins"
	S T("M",LASTINDEX,"props","lazy-rules")="true"
	S T("M",LASTINDEX,"props","style")="width:350px;"
	S T("M",LASTINDEX,"rules","required")="true"
	S LASTINDEX=$O(T("M",""),-1)+1
	;       
	;
	S T("M",LASTINDEX,"type")="btn"
	S T("M",LASTINDEX,"model")="serviceOptions"
	S T("M",LASTINDEX,"data","serviceOptions")=(P+1)
	S T("M",LASTINDEX,"is")="q-icon"                
	S T("M",LASTINDEX,"props","color")="primary"
	S T("M",LASTINDEX,"props","name")="add"
	S T("M",LASTINDEX,"props","label")="+ Add service options"
	S T("M",LASTINDEX,"onClick")="AddMoreServiceOptions"
	S T("M",LASTINDEX,"props","size")="xl"
	S T("M",LASTINDEX,"props","lazy-rules")="true"
	S T("M",LASTINDEX,"props","style")="cursor:pointer;font-size: 64px;width:350px;"
	Q       
	;
	;
Model(T)
	N R 
	;
	S T("F","title")="Add Service"
	S T("F","editTitle")="Edit Service"
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
	S T("M",R,"model")="onlineBookingActive"
	S T("M",R,"data","onlineBookingActive")="true"
	S T("M",R,"type")="string"
	S T("M",R,"is")="q-toggle"      
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Enable online booking"
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
	S T("M",R,"props","label")="Service name"
	S T("M",R,"props","lazy-rules")="true"
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"transformOnIndex")="V=$$ZCVT^SALON(V,""L"")"
	S T("M",R,"rules","required")="true"
	S T("M",R,"index")="true"
	;
	;
	I $I(R)
	S T("M",R,"type")="string"
	S T("M",R,"model")="description"
	S T("M",R,"data","description")=""
	S T("M",R,"is")="q-input"               
	S T("M",R,"props","type")="textarea"
	S T("M",R,"props","autogrow")="true"
	S T("M",R,"props","rounded")="true"
	S T("M",R,"props","outlined")="true"
	S T("M",R,"props","label")="Service description"
	S T("M",R,"props","lazy-rules")="true"
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"rules","required")="true"
	S T("M",R,"index")="true"
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZListSearchMini"
	S T("M",R,"model")="category"
	S T("M",R,"data","category")=""         
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"rules","required")="true"
	S T("M",R,"props","type")="CATEGORIES"
	S T("M",R,"props","routine")="List^CATEGORIES"
	S T("M",R,"props","label")="Category"
	S T("M",R,"props","selectItems","avatar")="image"
	S T("M",R,"props","selectItems","label")="name"
	S T("M",R,"props","selectItems","caption",1)="description"
	;
	;
	I $I(R)
	S T("M",R,"type")="QIcon"
	S T("M",R,"model")="serviceOptions"
	S T("M",R,"data","serviceOptions")=0
	S T("M",R,"is")="q-icon"                
	S T("M",R,"props","name")="add"
	S T("M",R,"props","rounded")="true"
	S T("M",R,"props","outlined")="true"
	S T("M",R,"props","label")="+ Add service options"
	S T("M",R,"onClick")="AddMoreServiceOptions"
	S T("M",R,"props","lazy-rules")="true"
	S T("M",R,"props","style")="max-width:350px;cursor:pointer;"
	;       
	D AddMoreServiceOptions(.T)
	;
	s R=$O(T(""),-1)+1
	S T("M",R,"type")="QIcon"
	S T("M",R,"model")="serviceOptions"
	S T("M",R,"data","serviceOptions")=0
	S T("M",R,"is")="q-icon"                
	S T("M",R,"props","name")="add"
	S T("M",R,"props","rounded")="true"
	S T("M",R,"props","outlined")="true"
	S T("M",R,"props","label")="+ Add service options"
	S T("M",R,"onClick")="AddMoreServiceOptions"
	S T("M",R,"props","lazy-rules")="true"
	S T("M",R,"props","style")="max-width:350px;cursor:pointer;"
	Q
	;
List(T)
	N R
	I $I(R)
	s T(R,"model")="image1"
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
	S T(R,"subSubComponent","props","toID")="/services/edit/"
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
	S T(R,"subSubComponent","props","buttons",1,"type")="SERVICES"
	S T(R,"subSubComponent","props","buttons",1,"onClick")="ViewRecord^FUZNEW"
	S T(R,"subSubComponent","props","buttons",1,"props","clickable")="true"
	S T(R,"subSubComponent","props","buttons",1,"props","v-close-popup")="true"
	S T(R,"subSubComponent","props","buttons",2,"title")="Edit"
	S T(R,"subSubComponent","props","buttons",2,"action")="routine"
	S T(R,"subSubComponent","props","buttons",2,"type")="SERVICES"
	S T(R,"subSubComponent","props","buttons",2,"onClick")="EditRecord^FUZNEW"
	S T(R,"subSubComponent","props","buttons",2,"props","clickable")="true"
	S T(R,"subSubComponent","props","buttons",2,"props","v-close-popup")="true"
	S T(R,"subSubComponent","props","buttons",3,"title")="Delete"
	S T(R,"subSubComponent","props","buttons",3,"action")="routine"
	S T(R,"subSubComponent","props","buttons",3,"type")="SERVICES"
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
	S T("rows",R,"cols",C,"title")="Services"
	S T("rows",R,"cols",C,"is")="FUZList"
	S T("rows",R,"cols",C,"props","type")="SERVICES"
	S T("rows",R,"cols",C,"props","routine")="List^SERVICES"
	S T("rows",R,"cols",C,"props","header")="Services"
	S T("rows",R,"cols",C,"props","emptyListText")="No services found, click this button to add a service!"
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
	S T("rows",R,"cols",C,"title")="Edit Service"
	S T("rows",R,"cols",C,"is")="FUZNew"
	S T("rows",R,"cols",C,"props","type")="SERVICES"
	Q
	;
ADDTREE(T)
	N R,C
	I $I(R),$I(C)
	S T("rows",R,"class")="row"
	S T("rows",R,"is")="div"
	S T("rows",R,"cols",C,"class")="col"
	S T("rows",R,"cols",C,"title")="New Service"
	S T("rows",R,"cols",C,"is")="FUZNew"
	S T("rows",R,"cols",C,"props","type")="SERVICES"
	Q       
	;
EDITALLTREE(T)
	N R,C
	I $I(R),$I(C)
	S T("rows",R,"class")="row"
	S T("rows",R,"is")="div"
	S T("rows",R,"cols",C,"class")="flex flex-center col"
	S T("rows",R,"cols",C,"title")="Search services"
	S T("rows",R,"cols",C,"is")="FUZListSearchPage"
	S T("rows",R,"cols",C,"props","type")="SERVICES"
	S T("rows",R,"cols",C,"props","routine")="List^SERVICES"
	S T("rows",R,"cols",C,"props","label")="Search services"
	S T("rows",R,"cols",C,"props","selectItems","avatar")="image1"
	S T("rows",R,"cols",C,"props","selectItems","label")="name"
	S T("rows",R,"cols",C,"props","selectItems","caption",1)="description"
	Q
	;
	;
EXPANDSERVICES(T)
	N C,S
	M C=@%G@("CATEGORIES","ORDER")
	M S=@%G@("SERVICES","ORDER")
	;
	N CX,SX,A
	S A="" F  S A=$O(C(A)) Q:A=""  S CX(A)=C(A)
	S A="" F  S A=$O(S(A)) Q:A=""  S SX(A)=S(A)
	;
	N SERVICE,ID,SORDER,CORDER,O
	S SERVICE="" F  S SERVICE=$O(@%G@("SERVICES","DATA",SERVICE)) Q:SERVICE=""  D
	. I SERVICE="COUNTER" Q
	. S ID=@%G@("SERVICES","DATA",SERVICE,"id")
	. S SORDER=$G(SX(ID)) I SORDER="" Q
	. S CID=@%G@("SERVICES","DATA",SERVICE,"category","id")
	. S CORDER=$G(CX(CID)) I CORDER="" Q
	. S O(CORDER,"name")=@%G@("SERVICES","DATA",SERVICE,"category","name")
	. I @%G@("SERVICES","DATA",SERVICE,"onlineBookingActive")'="true" Q
	. S O(CORDER,"children",SORDER,"name")=@%G@("SERVICES","DATA",SERVICE,"name")
	. F I=1:1:@%G@("SERVICES","DATA",SERVICE,"serviceOptions") D
	. . S O(CORDER,"children",SORDER,"children",I,"name")=@%G@("SERVICES","DATA",SERVICE,"serviceOption"_I_"name")
	. . S O(CORDER,"children",SORDER,"children",I,"description")=@%G@("SERVICES","DATA",SERVICE,"serviceOption"_I_"desc")
	. . S O(CORDER,"children",SORDER,"children",I,"discount")=@%G@("SERVICES","DATA",SERVICE,"serviceOption"_I_"DiscountedPrice")
	. . S O(CORDER,"children",SORDER,"children",I,"duration")=@%G@("SERVICES","DATA",SERVICE,"serviceOption"_I_"Duration")
	. . S O(CORDER,"children",SORDER,"children",I,"price")=@%G@("SERVICES","DATA",SERVICE,"serviceOption"_I_"Price")
	. . S O(CORDER,"children",SORDER,"children",I,"sid")=@%G@("SERVICES","DATA",SERVICE,"id")
	. . S O(CORDER,"children",SORDER,"children",I,"cid")=@%G@("SERVICES","DATA",SERVICE,"category","id")
	. . S O(CORDER,"children",SORDER,"children",I,"cname")=@%G@("SERVICES","DATA",SERVICE,"category","name")
	. . m O(CORDER,"children",SORDER,"children",I,"image")=@%G@("SERVICES","DATA",SERVICE,"image"_I)
	;
	M T("services")=O
	;       
	;       
	Q
	;