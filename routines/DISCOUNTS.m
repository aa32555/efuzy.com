DISCOUNTS
        ;
        ;
        ;
        Q
        ;
ROUTES
        K N I $I(H)
        S @T@("header","mainNav",H,"label")="Discounts"
        I $I(N)
        S @T@("header","mainNav",H,"children",N,"label")="Discounts list"
        S @T@("header","mainNav",H,"children",N,"to")="/discounts/list"
        I $I(N)
        S @T@("header","mainNav",H,"children",N,"label")="Edit discounts"
        S @T@("header","mainNav",H,"children",N,"to")="/discounts/edit"
        I $I(N)
        S @T@("header","mainNav",H,"children",N,"label")="Add NEW discount"
        S @T@("header","mainNav",H,"children",N,"to")="/discounts/add/*"
        ;
        i $I(P)
        S @T@("pages",P,"path")="/discounts/list"
        S @T@("pages",P,"name")="Discounts"
        S @T@("pages",P,"childBreadcrump")="discountslist"
        S @T@("pages",P,"breadcrump")="discounts"
        S @T@("pages",P,"component")="FUZPage"
        S @T@("pages",P,"requiresAuth")="true"
        S @T@("pages",P,"routine")="TREE^DISCOUNTS"
        S @T@("pages",P,"type")="SALON"
        ;
        i $I(P)
        S @T@("pages",P,"path")="/discounts/edit"
        S @T@("pages",P,"name")="Edit Discounts"
        S @T@("pages",P,"childBreadcrump")="editdiscounts"
        S @T@("pages",P,"breadcrump")="discounts"
        S @T@("pages",P,"subName")="DiscountsEdit"
        S @T@("pages",P,"component")="FUZPage"
        S @T@("pages",P,"requiresAuth")="true"
        S @T@("pages",P,"routine")="EDITALLTREE^DISCOUNTS"
        S @T@("pages",P,"type")="SALON"
        ;
        i $I(P)
        S @T@("pages",P,"path")="/discounts/edit/:id"
        S @T@("pages",P,"name")="Edit Single Discounts"
        S @T@("pages",P,"childBreadcrump")="editdiscounts"
        S @T@("pages",P,"breadcrump")="discounts"
        S @T@("pages",P,"component")="FUZPage"
        S @T@("pages",P,"requiresAuth")="true"
        S @T@("pages",P,"routine")="EDITTREE^DISCOUNTS"
        S @T@("pages",P,"type")="SALON"
        ;
        i $I(P)
        S @T@("pages",P,"path")="/discounts/add/:id"
        S @T@("pages",P,"name")="Add Discounts"
        S @T@("pages",P,"childBreadcrump")="adddiscounts"
        S @T@("pages",P,"breadcrump")="discounts"
        S @T@("pages",P,"component")="FUZPage"
        S @T@("pages",P,"requiresAuth")="true"
        S @T@("pages",P,"routine")="ADDTREE^DISCOUNTS"
        S @T@("pages",P,"type")="SALON"         
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
        S %J("dispatch","data")="/discounts/list"
        Q
        ;       
        ;
Model(T)
        N R 
        ;
        S T("F","title")="Add Discount"
        S T("F","editTitle")="Edit Discount"
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
        S T("M",R,"model")="name"
        S T("M",R,"data","name")=""
        S T("M",R,"type")="string"
        S T("M",R,"is")="q-input"       
        S T("M",R,"props","rounded")="true"
        S T("M",R,"props","outlined")="true"
        S T("M",R,"props","label")="Discount name"
        S T("M",R,"props","lazy-rules")="true"
        S T("M",R,"props","style")="width:350px;"
        S T("M",R,"transformOnIndex")="V=$$ZCVT^SALON(V,""L"")"
        S T("M",R,"rules","required")="true"
        S T("M",R,"index")="true"
        ;
        ;
        I $I(R)
        S T("M",R,"type")="radio"
        S T("M",R,"model")="type"
        S T("M",R,"data","type")="percent"
        S T("M",R,"props","style")="width:350px;"
        S T("M",R,"options",1,"label")="Percent %"
        S T("M",R,"options",1,"val")="percent"
        S T("M",R,"options",2,"label")="Amount off"
        S T("M",R,"options",2,"val")="off"
        ;
        ;
        ;
        I $I(R)
        S T("M",R,"type")="number"
        S T("M",R,"model")="value"
        S T("M",R,"data","value")=""
        S T("M",R,"is")="q-input"       
        S T("M",R,"props","type")="number"
        S T("M",R,"props","rounded")="true"
        S T("M",R,"props","outlined")="true"
        S T("M",R,"props","label")="Discount Amount"
        S T("M",R,"props","lazy-rules")="true"
        S T("M",R,"props","style")="width:350px;"
        S T("M",R,"rules","required")="true"
        ;
        ;
        Q
        ;
List(T)
        N R
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
        S T(R,"subSubComponent","props","buttons",1,"type")="DISCOUNTS"
        S T(R,"subSubComponent","props","buttons",1,"onClick")="ViewRecord^FUZNEW"
        S T(R,"subSubComponent","props","buttons",1,"props","clickable")="true"
        S T(R,"subSubComponent","props","buttons",1,"props","v-close-popup")="true"
        S T(R,"subSubComponent","props","buttons",2,"title")="Edit"
        S T(R,"subSubComponent","props","buttons",2,"action")="routine"
        S T(R,"subSubComponent","props","buttons",2,"type")="DISCOUNTS"
        S T(R,"subSubComponent","props","buttons",2,"onClick")="EditRecord^FUZNEW"
        S T(R,"subSubComponent","props","buttons",2,"props","clickable")="true"
        S T(R,"subSubComponent","props","buttons",2,"props","v-close-popup")="true"
        S T(R,"subSubComponent","props","buttons",3,"title")="Delete"
        S T(R,"subSubComponent","props","buttons",3,"action")="routine"
        S T(R,"subSubComponent","props","buttons",3,"type")="DISCOUNTS"
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
        S T("rows",R,"cols",C,"title")="Discounts"
        S T("rows",R,"cols",C,"is")="FUZList"
        S T("rows",R,"cols",C,"props","type")="DISCOUNTS"
        S T("rows",R,"cols",C,"props","routine")="List^DISCOUNTS"
        S T("rows",R,"cols",C,"props","header")="Discounts"
        S T("rows",R,"cols",C,"props","emptyListText")="No categories found, click this button to add a discount!"
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
        S T("rows",R,"cols",C,"title")="Edit Discounts"
        S T("rows",R,"cols",C,"is")="FUZNew"
        S T("rows",R,"cols",C,"props","type")="DISCOUNTS"
        Q
        ;
ADDTREE(T)
        N R,C
        I $I(R),$I(C)
        S T("rows",R,"class")="row"
        S T("rows",R,"is")="div"
        S T("rows",R,"cols",C,"class")="col"
        S T("rows",R,"cols",C,"title")="New Discounts"
        S T("rows",R,"cols",C,"is")="FUZNew"
        S T("rows",R,"cols",C,"props","type")="DISCOUNTS"
        Q       
        ;
EDITALLTREE(T)
        N R,C
        I $I(R),$I(C)
        S T("rows",R,"class")="row"
        S T("rows",R,"is")="div"
        S T("rows",R,"cols",C,"class")="flex flex-center col"
        S T("rows",R,"cols",C,"title")="Search Discounts"
        S T("rows",R,"cols",C,"is")="FUZListSearchPage"
        S T("rows",R,"cols",C,"props","type")="DISCOUNTS"
        S T("rows",R,"cols",C,"props","routine")="List^DISCOUNTS"
        S T("rows",R,"cols",C,"props","label")="Search Discounts"
        S T("rows",R,"cols",C,"props","selectItems","avatar")="image"
        S T("rows",R,"cols",C,"props","selectItems","label")="name"
        S T("rows",R,"cols",C,"props","selectItems","caption",1)="description"
        Q
        ;
        ;
