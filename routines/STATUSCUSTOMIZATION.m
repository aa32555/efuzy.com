STATUSCUSTOMIZATION
        ;
        ;
        ;
        Q
        ;
ROUTES
        I $I(N)
        S @T@("header","mainNav",H,"children",N,"label")="Status Colors"
        S @T@("header","mainNav",H,"children",N,"to")="/statuscustomization/list"
        ;
        ;
        i $I(P)
        S @T@("pages",P,"path")="/statuscustomization/list"
        S @T@("pages",P,"name")="Status customizations"
        S @T@("pages",P,"childBreadcrump")="statuscustomization"
        S @T@("pages",P,"breadcrump")="statuscustomization"
        S @T@("pages",P,"component")="FUZPage"
        S @T@("pages",P,"requiresAuth")="true"
        S @T@("pages",P,"routine")="TREE^STATUSCUSTOMIZATION"
        S @T@("pages",P,"type")="SALON"
        ;
        i $I(P)
        S @T@("pages",P,"path")="/statuscustomizationn/edit"
        S @T@("pages",P,"name")="Edit Status customizations"
        S @T@("pages",P,"childBreadcrump")="statuscustomization"
        S @T@("pages",P,"breadcrump")="statuscustomization"
        S @T@("pages",P,"subName")="ServiceEdit"
        S @T@("pages",P,"component")="FUZPage"
        S @T@("pages",P,"requiresAuth")="true"
        S @T@("pages",P,"routine")="EDITALLTREE^STATUSCUSTOMIZATION"
        S @T@("pages",P,"type")="SALON"
        ;
        i $I(P)
        S @T@("pages",P,"path")="/statuscustomization/edit/:id"
        S @T@("pages",P,"name")="Edit Status"
        S @T@("pages",P,"childBreadcrump")="statuscustomization"
        S @T@("pages",P,"breadcrump")="statuscustomization"
        S @T@("pages",P,"component")="FUZPage"
        S @T@("pages",P,"requiresAuth")="true"
        S @T@("pages",P,"routine")="EDITTREE^STATUSCUSTOMIZATION"
        S @T@("pages",P,"type")="SALON"
        ;
        i $I(P)
        S @T@("pages",P,"path")="/statuscustomization/add/:id"
        S @T@("pages",P,"name")="Add Status"
        S @T@("pages",P,"childBreadcrump")="addcustomization"
        S @T@("pages",P,"breadcrump")="statuscustomization"
        S @T@("pages",P,"component")="FUZPage"
        S @T@("pages",P,"requiresAuth")="true"
        S @T@("pages",P,"routine")="ADDTREE^STATUSCUSTOMIZATION"
        S @T@("pages",P,"type")="SALON"
        ;
        ;
        Q
        ;
onAfterModelSave
        I $G(DATA("noRerouteAfterSave"))="true" Q
        S %J("dispatch","action")="app/changeRoute"
        S %J("dispatch","data")="/statuscustomization/list"
        Q       
        ;
Model(T)
        N R 
        ;
        S T("F","title")="Add Customization"
        S T("F","editTitle")="Edit Customization"
        S T("F","multiIndex",1)="name"
        S T("F","searchIndex")=1
        ;
        I $I(R) 
        S T("M",R,"model")="id"
        S T("M",R,"data","id")=""
        S T("M",R,"type")="string"
        S T("M",R,"is")="span"  
        S T("M",R,"props","rounded")="true"
        S T("M",R,"props","outlined")="true"
        S T("M",R,"props","label")="ID"
        S T("M",R,"props","lazy-rules")="true"
        S T("M",R,"rules","required")="true"
        S T("M",R,"props","disable")="true"
        ;
        ;
        I $I(R) 
        S T("M",R,"model")="active"
        S T("M",R,"data","active")="true"
        S T("M",R,"type")="string"
        S T("M",R,"is")="q-toggle"      
        S T("M",R,"props","style")="width:350px;"
        S T("M",R,"props","disable")="true"
        S T("M",R,"props","style")="display:none;"
        S T("M",R,"props","label")="Active"
        S T("M",R,"rules","required")="true"
        ;
        I $I(R) 
        S T("M",R,"model")="name"
        S T("M",R,"data","name")=""
        S T("M",R,"type")="string"
        S T("M",R,"is")="q-input"       
        S T("M",R,"props","rounded")="true"
        S T("M",R,"props","outlined")="true"
        S T("M",R,"props","label")="Template name"
        S T("M",R,"props","lazy-rules")="true"
        S T("M",R,"props","style")="width:350px;"
        S T("M",R,"transformOnIndex")="V=$$ZCVT^SALON(V,""L"")"
        S T("M",R,"rules","required")="true"
        S T("M",R,"index")="true"
        ;
        I $I(R) 
        S T("M",R,"model")="description"
        S T("M",R,"data","description")=""
        S T("M",R,"props","type")="textarea"
        S T("M",R,"type")="string"
        S T("M",R,"props","autogrow")="true"
        S T("M",R,"is")="q-input"       
        S T("M",R,"props","rounded")="true"
        S T("M",R,"props","outlined")="true"
        S T("M",R,"props","label")="Step Description"
        S T("M",R,"props","style")="width:350px;"
        S T("M",R,"rules","required")="true"
        ;
        I $I(R) 
        S T("M",R,"model")="gradient1color"
        S T("M",R,"data","gradient1color")="#6fb8e0"
        S T("M",R,"type")="string"
        S T("M",R,"is")="FUZColorPicker"
        S T("M",R,"props","label")="Gradient 1 Color" 
        S T("M",R,"props","fontColor")="white"
        S T("M",R,"props","style")="width:350px;color:white;"   
        ;
        I $I(R) 
        S T("M",R,"model")="gradient2color"
        S T("M",R,"data","gradient2color")="#6fb8e0"
        S T("M",R,"type")="string"
        S T("M",R,"is")="FUZColorPicker"
        S T("M",R,"props","label")="Gradient 2 Color" 
        S T("M",R,"props","fontColor")="white"
        S T("M",R,"props","style")="width:350px;color:white;"   
        ;
        Q
        ;
onBeforeModelSave
        N MODEL M MODEL=DATA("model")
        N FORM M FORM=DATA("form")
        N T
        S STATUS=0
        M T("M")=MODEL
        M T("F")=FORM
        N A,M
        S A="" F  S A=$O(T("M",A)) Q:A=""  S M(T("M",A,"model"))=A
        N P
        s DATA("model",M("id"),"data","id")=T("M",M("name"),"data","name") 
        S STATUS="OK"
        Q
        ;
List(T)
        N R
        I $I(R)
        s T(R,"model")="name"
        S T(R,"component","is")="q-item-section"
        S T(R,"subComponent","is")="q-item-label"
        S T(R,"subComponent","props","lines")="1"
        S T(R,"subSubComponent","is")="span"
        S T(R,"subSubComponent","props","class")="text-weight-medium"
        S T(R,"subSubComponent","insertValue")="true"
        S T(R,"subSubComponent","props","href")="javascript:void(0)"
        S T(R,"subSubComponent","props","toID")="/statuscustomization/edit/"
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
        S T(R,"subSubComponent","props","buttons",1,"type")="STATUSCUSTOMIZATION"
        S T(R,"subSubComponent","props","buttons",1,"onClick")="ViewRecord^FUZNEW"
        S T(R,"subSubComponent","props","buttons",1,"props","clickable")="true"
        S T(R,"subSubComponent","props","buttons",1,"props","v-close-popup")="true"
        S T(R,"subSubComponent","props","buttons",2,"title")="Edit"
        S T(R,"subSubComponent","props","buttons",2,"action")="routine"
        S T(R,"subSubComponent","props","buttons",2,"type")="STATUSCUSTOMIZATION"
        S T(R,"subSubComponent","props","buttons",2,"onClick")="EditRecord^FUZNEW"
        S T(R,"subSubComponent","props","buttons",2,"props","clickable")="true"
        S T(R,"subSubComponent","props","buttons",2,"props","v-close-popup")="true"
        S T(R,"subSubComponent","props","buttons",3,"title")="Delete"
        S T(R,"subSubComponent","props","buttons",3,"action")="routine"
        S T(R,"subSubComponent","props","buttons",3,"type")="STATUSCUSTOMIZATION"
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
        S T("rows",R,"cols",C,"title")="Statuscustomizations"
        S T("rows",R,"cols",C,"is")="FUZList"
        S T("rows",R,"cols",C,"props","type")="STATUSCUSTOMIZATION"
        S T("rows",R,"cols",C,"props","routine")="List^STATUSCUSTOMIZATION"
        S T("rows",R,"cols",C,"props","header")="Online booking customizations"
        S T("rows",R,"cols",C,"props","emptyListText")="No status customizations found, click this button to add a customization!"
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
        S T("rows",R,"cols",C,"title")="Edit Customization"
        S T("rows",R,"cols",C,"is")="FUZNew"
        S T("rows",R,"cols",C,"props","type")="STATUSCUSTOMIZATION"
        Q
        ;
ADDTREE(T)
        N R,C
        I $I(R),$I(C)
        S T("rows",R,"class")="row"
        S T("rows",R,"is")="div"
        S T("rows",R,"cols",C,"class")="col"
        S T("rows",R,"cols",C,"title")="New Customization"
        S T("rows",R,"cols",C,"is")="FUZNew"
        S T("rows",R,"cols",C,"props","type")="STATUSCUSTOMIZATION"
        Q       
        ;
EDITALLTREE(T)
        N R,C
        I $I(R),$I(C)
        S T("rows",R,"class")="row"
        S T("rows",R,"is")="div"
        S T("rows",R,"cols",C,"class")="flex flex-center col"
        S T("rows",R,"cols",C,"title")="Search Statuses"
        S T("rows",R,"cols",C,"is")="FUZListSearchPage"
        S T("rows",R,"cols",C,"props","type")="STATUSCUSTOMIZATION"
        S T("rows",R,"cols",C,"props","routine")="List^STATUSCUSTOMIZATION"
        S T("rows",R,"cols",C,"props","label")="Search online booking customizations"
        S T("rows",R,"cols",C,"props","selectItems","label")="name"
        S T("rows",R,"cols",C,"props","selectItems","caption",1)="description"
        Q
        ;
        ;
.
