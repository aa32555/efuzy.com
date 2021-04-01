STYLISTS
        ;
        ; MODEL
        ; SAVE NEW, UPDATE, LOG, PERMISSIONS, ETC.
        Q
        ; Basic Info name, phone, email, etc. 
        ; Professional Experience
        ; About Me
        ; 
        ;
        ;
onAfterModelSave
        S %J("dispatch","action")="app/changeRoute"
        S %J("dispatch","data")="/profile/view"
        Q
        ;
Model(T)
        N R 
        ;
        S T("F","title")="Edit Profile"
        S T("F","editTitle")="Edit Profile"
        S T("F","multiIndex",1)="firstname"_":"_"lastname"
        S T("F","multiIndex",2)="phone"_":"_"firstname"_":"_"lastname"
        S T("F","searchIndex")=2
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
        s T("M",R,"props","imgProps","parentStyle")="width:38vw;max-width:800px;min-width:350px"
        s T("M",R,"props","imgProps","parentClass")="flex flex-center q-pa-md row"
        s T("M",R,"props","imgProps","label")="Profile photo"
        s T("M",R,"props","imgProps","labelStyle")="width:38vw;max-width:800px;min-width:350px"
        s T("M",R,"props","imgProps","labelClass")="text-grey text-center"
        s T("M",R,"props","imgProps","flat")="true"
        ;
        ;
        I $I(R)
        S T("M",R,"type")="string"
        S T("M",R,"model")="title"
        S T("M",R,"data","title")=""
        S T("M",R,"is")="q-input"               
        S T("M",R,"props","rounded")="true"
        S T("M",R,"props","outlined")="true"
        S T("M",R,"props","label")="Title"
        S T("M",R,"props","style")="width:30vw;max-width:800px;min-width:350px"
        S T("M",R,"rules","required")="true"
        S T("M",R,"index")="true"
        ;
        ;
        ;I $I(R)
        ;S T("M",R,"is")="FUZImg"
        ;S T("M",R,"model")="fartw"
        ;s T("M",R,"data","fartw")="fart.png"
        ;S T("M",R,"type")="view-image"
        ;S T("M",R,"props","imgProps","avatar")="true"
        ;S T("M",R,"props","imgProps","imageClass")="v1-image"
        ;S T("M",R,"props","imgProps","size")="200px"
        ;S T("M",R,"props","imgProps","font-size")="104px"
        ;
        I $I(R) 
        S T("M",R,"model")="email"
        S T("M",R,"data","email")=%EMAIL
        S T("M",R,"type")="string"
        S T("M",R,"is")="q-input"       
        S T("M",R,"props","rounded")="true"
        S T("M",R,"props","outlined")="true"
        S T("M",R,"props","label")="Email"
        S T("M",R,"props","lazy-rules")="true"
        S T("M",R,"props","style")="width:77vw;max-width:600px;display:none"
        S T("M",R,"props","disable")="true"
        S T("M",R,"rules","required")="true"
        S T("M",R,"index")="true"
        ;
        I $I(R) 
        S T("M",R,"model")="id"
        S T("M",R,"data","id")=%EMAIL
        S T("M",R,"type")="string"
        S T("M",R,"is")="span"  
        S T("M",R,"props","rounded")="true"
        S T("M",R,"props","outlined")="true"
        S T("M",R,"props","label")="ID"
        S T("M",R,"props","lazy-rules")="true"
        S T("M",R,"props","style")="width:77vw;;max-width:800px"
        S T("M",R,"rules","required")="true"
        S T("M",R,"props","disable")="true"
        ;
        I $I(R) 
        S T("M",R,"model")="name"
        S T("M",R,"data","name")=""
        S T("M",R,"type")="computed"
        S T("M",R,"computed")="updateName^STYLISTS"
        S T("M",R,"is")="span"
        S T("M",R,"props","style")="display:none;"
        S T("M",R,"index")="true"
        ;
        I $I(R) 
        S T("M",R,"model")="firstname"
        S T("M",R,"data","firstname")=""
        S T("M",R,"type")="string"
        S T("M",R,"is")="q-input"       
        S T("M",R,"props","rounded")="true"
        S T("M",R,"props","outlined")="true"
        S T("M",R,"props","label")="Firstname"
        S T("M",R,"props","lazy-rules")="true"
        S T("M",R,"props","style")="width:30vw;max-width:800px;min-width:350px"
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
        S T("M",R,"props","style")="width:30vw;max-width:800px;min-width:350px"
        S T("M",R,"rules","required")="true"
        S T("M",R,"index")="true"
        ;
        I $I(R)
        S T("M",R,"type")="radio"
        S T("M",R,"model")="sex"
        S T("M",R,"data","sex")="F"
        s T("M",R,"onInput")="UpdateStylistGender"
        S T("M",R,"props","style")="width:30vw;max-width:800px;min-width:350px"
        S T("M",R,"options",1,"label")="Male"
        S T("M",R,"options",1,"val")="M"
        S T("M",R,"options",2,"label")="Female"
        S T("M",R,"options",2,"val")="F"
        S T("M",R,"options",3,"label")="Other"
        S T("M",R,"options",3,"val")="O"
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
        S T("M",R,"props","style")="width:30vw;max-width:800px;min-width:350px"
        S T("M",R,"index")="true"
        S T("M",R,"transformOnIndex")="V=$tr(V,""()- "")"
        ;S T("M",R,"onChange")="CheckDuplicatePhone"
        ;S T("M",R,"unique")="true"
        S T("M",R,"rules","phone")="true"
        ;
        I $I(R)
        S T("M",R,"type")="string"
        S T("M",R,"model")="state"
        S T("M",R,"data","state")=""
        S T("M",R,"is")="q-input"               
        S T("M",R,"props","rounded")="true"
        S T("M",R,"props","outlined")="true"
        S T("M",R,"props","label")="State"
        S T("M",R,"props","style")="width:30vw;max-width:800px;min-width:350px"
        S T("M",R,"rules","required")="true"
        S T("M",R,"index")="true"
        S T("M",R,"props","mask")="AA"
        ;
        I $I(R)
        S T("M",R,"type")="string"
        S T("M",R,"model")="city"
        S T("M",R,"data","city")=""
        S T("M",R,"is")="q-input"               
        S T("M",R,"props","rounded")="true"
        S T("M",R,"props","outlined")="true"
        S T("M",R,"props","label")="City"
        S T("M",R,"props","style")="width:30vw;max-width:800px;min-width:350px"
        S T("M",R,"rules","required")="true"
        S T("M",R,"index")="true"
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
        S T("M",R,"props","style")="width:30vw;max-width:800px;min-width:350px"
        S T("M",R,"props","mask")="##/##/####"
        S T("M",R,"rules","date")="true"
        ;
        ;
        I $I(R) 
        S T("M",R,"type")="date"
        S T("M",R,"model")="stylistySince"
        S T("M",R,"data","stylistySince")=""
        S T("M",R,"is")="q-input"
        S T("M",R,"props","rounded")="true"
        S T("M",R,"props","outlined")="true"
        S T("M",R,"props","label")="I've been a stylist since"
        S T("M",R,"props","lazy-rules")="true"
        S T("M",R,"props","style")="width:30vw;max-width:800px;min-width:350px"
        S T("M",R,"props","mask")="##/##/####"
        S T("M",R,"rules","date")="true"
        ;
        I $I(R)
        S T("M",R,"type")="string"
        S T("M",R,"model")="Instagram"
        S T("M",R,"data","Instagram")=""
        S T("M",R,"is")="q-input"               
        S T("M",R,"props","rounded")="true"
        S T("M",R,"props","type")="url"
        S T("M",R,"props","outlined")="true"
        S T("M",R,"props","label")="Instagram link"
        S T("M",R,"props","lazy-rules")="true"
        S T("M",R,"props","style")="width:30vw;max-width:800px;min-width:350px"
        ;
        I $I(R)
        S T("M",R,"type")="radio"
        S T("M",R,"model")="license"
        S T("M",R,"data","license")="N"
        S T("M",R,"props","style")="width:30vw;max-width:800px;min-width:350px"
        S T("M",R,"options",1,"label")="I have a cosmotology license"
        S T("M",R,"options",1,"val")="Y"
        S T("M",R,"options",2,"label")="I do not have a Cosmotology License"
        S T("M",R,"options",2,"val")="N"        
        ;
        I $I(R)
        S T("M",R,"type")="radio"
        S T("M",R,"model")="jobStatus"
        S T("M",R,"data","jobStatus")="Y"
        S T("M",R,"props","style")="width:30vw;max-width:800px;min-width:350px"
        S T("M",R,"options",1,"label")="I'm currently working"
        S T("M",R,"options",1,"val")="N"
        S T("M",R,"options",2,"label")="I'm Lookging for a job"
        S T("M",R,"options",2,"val")="Y"
        ;
        ;
        I $I(R)
        S T("M",R,"type")="string"
        S T("M",R,"model")="aboutme"
        S T("M",R,"data","aboutme")=""
        S T("M",R,"is")="q-input"               
        S T("M",R,"props","type")="textarea"
        ;S T("M",R,"props","autogrow")="true"
        S T("M",R,"props","rounded")="true"
        S T("M",R,"props","outlined")="true"
        S T("M",R,"props","label")="About me"
        S T("M",R,"props","lazy-rules")="true"
        S T("M",R,"props","style")="width:77vw;min-width:300px;"
        ;
        I $I(R)
        S T("M",R,"type")="string"
        S T("M",R,"model")="workExperience"
        S T("M",R,"data","workExperience")=""
        S T("M",R,"is")="q-input"               
        S T("M",R,"props","type")="textarea"
        ;S T("M",R,"props","autogrow")="true"
        S T("M",R,"props","rounded")="true"
        S T("M",R,"props","outlined")="true"
        S T("M",R,"props","label")="Work Experience"
        S T("M",R,"props","lazy-rules")="true"
        S T("M",R,"props","style")="width:77vw;min-width:300px;"
        ;
        I $I(R)
        S T("M",R,"type")="string"
        S T("M",R,"model")="servicesProvided"
        S T("M",R,"data","servicesProvided")=""
        S T("M",R,"is")="q-input"               
        S T("M",R,"props","type")="textarea"
        ;S T("M",R,"props","autogrow")="true"
        S T("M",R,"props","rounded")="true"
        S T("M",R,"props","outlined")="true"
        S T("M",R,"props","label")="Services I perform (balayage, highlights, cuts, etc.)"
        S T("M",R,"props","lazy-rules")="true"
        S T("M",R,"props","style")="width:77vw;min-width:300px;"
        ;
        I $I(R)
        S T("M",R,"type")="string"
        S T("M",R,"model")="colorFamiliar"
        S T("M",R,"data","colorFamiliar")=""
        S T("M",R,"is")="q-input"               
        S T("M",R,"props","type")="textarea"
        ;S T("M",R,"props","autogrow")="true"
        S T("M",R,"props","rounded")="true"
        S T("M",R,"props","outlined")="true"
        S T("M",R,"props","label")="Color line(s) I am familiar with"
        S T("M",R,"props","lazy-rules")="true"
        S T("M",R,"props","style")="width:77vw;min-width:300px;"        
        ;
        I $I(R)
        S T("M",R,"type")="string"
        S T("M",R,"model")="education"
        S T("M",R,"data","education")=""
        S T("M",R,"is")="q-input"               
        S T("M",R,"props","type")="textarea"
        ;S T("M",R,"props","autogrow")="true"
        S T("M",R,"props","rounded")="true"
        S T("M",R,"props","outlined")="true"
        S T("M",R,"props","label")="Education"
        S T("M",R,"props","lazy-rules")="true"
        S T("M",R,"props","style")="width:77vw;min-width:300px;"
        ;
        I $I(R)
        S T("M",R,"type")="string"
        S T("M",R,"model")="langauages"
        S T("M",R,"data","langauages")=""
        S T("M",R,"is")="q-input"               
        S T("M",R,"props","type")="textarea"
        ;S T("M",R,"props","autogrow")="true"
        S T("M",R,"props","rounded")="true"
        S T("M",R,"props","outlined")="true"
        S T("M",R,"props","label")="Langauage(s) I speak"
        S T("M",R,"props","lazy-rules")="true"
        S T("M",R,"props","style")="width:77vw;min-width:300px;"
        ;       
        I $I(R)
        S T("M",R,"type")="string"
        S T("M",R,"model")="hobbies"
        S T("M",R,"data","hobbies")=""
        S T("M",R,"is")="q-input"               
        S T("M",R,"props","type")="textarea"
        ;S T("M",R,"props","autogrow")="true"
        S T("M",R,"props","rounded")="true"
        S T("M",R,"props","outlined")="true"
        S T("M",R,"props","label")="Hobbies"
        S T("M",R,"props","lazy-rules")="true"
        S T("M",R,"props","style")="width:77vw;min-width:300px;"
        ;
        I $I(R)
        S T("M",R,"type")="string"
        S T("M",R,"model")="daysAvailable"
        S T("M",R,"data","daysAvailable")=""
        S T("M",R,"is")="q-input"               
        S T("M",R,"props","type")="textarea"
        ;S T("M",R,"props","autogrow")="true"
        S T("M",R,"props","rounded")="true"
        S T("M",R,"props","outlined")="true"
        S T("M",R,"props","label")="Days I'm currently available for Work"
        S T("M",R,"props","lazy-rules")="true"
        S T("M",R,"props","style")="width:77vw;min-width:300px;"
        ;
        I $I(R)
        S T("M",R,"type")="string"
        S T("M",R,"model")="info"
        S T("M",R,"data","info")=""
        S T("M",R,"is")="q-input"               
        S T("M",R,"props","type")="textarea"
        ;S T("M",R,"props","autogrow")="true"
        S T("M",R,"props","rounded")="true"
        S T("M",R,"props","outlined")="true"
        S T("M",R,"props","label")="Any Additional Info"
        S T("M",R,"props","lazy-rules")="true"
        S T("M",R,"props","style")="width:77vw;min-width:300px;"
        ;
        ;
        ;
        F I=1:1:5 D 
        . I $I(R)
        . S T("M",R,"is")="FUZImg"
        . S T("M",R,"model")="fimage"_I
        . S T("M",R,"data","fimage"_I)=""
        . S T("M",R,"type")="view-image"
        . S T("M",R,"props","imgProps","avatar")="true"
        . S T("M",R,"props","imgProps","imageClass")="v1-image"
        . S T("M",R,"props","imgProps","size")="100px"
        . S T("M",R,"props","imgProps","font-size")="52px"      
        . s T("M",R,"props","imgProps","parentStyle")="width:30vw;max-width:800px;min-width:350px"
        . s T("M",R,"props","imgProps","parentClass")="flex flex-center q-pa-md row"
        . s T("M",R,"props","imgProps","label")="Featured Image "_I
        . s T("M",R,"props","imgProps","labelStyle")="width:30vw;max-width:800px;min-width:350px"
        . s T("M",R,"props","imgProps","labelClass")="text-grey text-center"
        . s T("M",R,"props","imgProps","flat")="true"
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
        S T(R,"subComponent","props","imgProps","size")="100px"
        S T(R,"subComponent","props","imgProps","font-size")="52px"
        S T(R,"subComponent","props","imgProps","viewOnly")="true"
        S T(R,"subComponent","props","value")="insertValue"
        ;
        I $I(R)
        s T(R,"model")="name"
        S T(R,"component","is")="q-item-section"
        S T(R,"subComponent","is")="a"
        S T(R,"subComponent","props","toID")="/stylists-/"
        S T(R,"subComponent","props","href")="javascript:void(0)"
        S T(R,"subSubComponent","is")="span"
        S T(R,"subSubComponent","props","class")="text-weight-medium text-h6"
        S T(R,"subSubComponent","insertValue")="true"
        ;
        ;I $I(R)
        ;S T(R,"component","is")="q-separator"
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
        S T(R,"subSubComponent","props","buttons",1,"type")="STYLISTS"
        S T(R,"subSubComponent","props","buttons",1,"onClick")="ViewRecord^FUZNEW"
        S T(R,"subSubComponent","props","buttons",1,"props","clickable")="true"
        S T(R,"subSubComponent","props","buttons",1,"props","v-close-popup")="true"
        S T(R,"subSubComponent","props","buttons",2,"title")="Edit"
        S T(R,"subSubComponent","props","buttons",2,"action")="routine"
        S T(R,"subSubComponent","props","buttons",2,"type")="STYLISTS"
        S T(R,"subSubComponent","props","buttons",2,"onClick")="EditRecord^FUZNEW"
        S T(R,"subSubComponent","props","buttons",2,"props","clickable")="true"
        S T(R,"subSubComponent","props","buttons",2,"props","v-close-popup")="true"
        S T(R,"subSubComponent","props","buttons",3,"title")="Delete"
        S T(R,"subSubComponent","props","buttons",3,"action")="routine"
        S T(R,"subSubComponent","props","buttons",3,"type")="STYLISTS"
        S T(R,"subSubComponent","props","buttons",3,"onClick")="DeleteRecord^FUZNEW"
        S T(R,"subSubComponent","props","buttons",3,"props","clickable")="true"
        S T(R,"subSubComponent","props","buttons",3,"props","v-close-popup")="true"
        S T(R,"subSubComponent","props","src")="insertValue"
        Q       
        ;
TREE(T)
        N R,C
        I $I(R),$I(C)
        S T("rows",R,"class")="row"
        S T("rows",R,"is")="div"
        S T("rows",R,"cols",C,"class")="col"
        S T("rows",R,"cols",C,"title")="Stylists"
        S T("rows",R,"cols",C,"is")="FUZList"
        S T("rows",R,"cols",C,"props","type")="STYLISTS"
        S T("rows",R,"cols",C,"props","routine")="List^STYLISTS"
        S T("rows",R,"cols",C,"props","header")="Stylist List"
        S T("rows",R,"cols",C,"props","skeleton",1,1,"type")="circle"
        S T("rows",R,"cols",C,"props","skeleton",1,1,"size")="150px"
        S T("rows",R,"cols",C,"props","skeleton",1,1,"class")="col-auto"
        N I F I=2:1:5 D
        .S T("rows",R,"cols",C,"props","skeleton",I,1,"type")="rect"
        .S T("rows",R,"cols",C,"props","skeleton",I,2,"type")="rect"
        Q
        ;
STYLISTTREE(T)
        N R,C
        I $I(R),$I(C)
        S T("rows",R,"class")="row"
        S T("rows",R,"is")="div"
        S T("rows",R,"cols",C,"class")="col"
        S T("rows",R,"cols",C,"title")="Stylist"
        S T("rows",R,"cols",C,"is")="FUZNew"
        S T("rows",R,"cols",C,"props","type")="STYLISTS"
        S T("rows",R,"cols",C,"props","view")="true"
        Q
UpdateStylistGender(T)
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
        N P B
        S P=T("M",M("phone"),"data","phone") 
        I P="" Q
        S P=$TR(P,"()- ")
        I $D(@%G@("STYLISTS","INDEX","phone",P)) D
        . D Warning^FUZ("Stylist already exists. Update existing instead. Stylist ID: "_@%G@("STYLISTS","INDEX","phone",P))
        . D FillModel(.T,@%G@("STYLISTS","INDEX","phone",P))
        . S T("F","title")="ID:"_@%G@("STYLISTS","INDEX","phone",P)
        Q
        ;
FillModel(T,ID)
        D FillModel^FUZNEW(.T,"STYLISTS",ID)
        N A,M S A="" F  S A=$O(T("M",A)) Q:A=""  S M(T("M",A,"model"))=A
        N V M V=T("M",M("image"),"data","image")
        K T("M",M("image"))
        S T("M",M("image"),"is")="FUZImg"
        S T("M",M("image"),"model")="image"
        M T("M",M("image"),"data","image")=V
        S T("M",M("image"),"type")="view-image"
        S T("M",M("image"),"props","imgProps","avatar")="true"
        S T("M",M("image"),"props","imgProps","imageClass")="v1-image"
        S T("M",M("image"),"props","imgProps","size")="100px"
        S T("M",M("image"),"props","imgProps","font-size")="52px"
        ;S T("M",M("image"),"props","imgProps","width")="34vw"  
        s T("M",M("image"),"props","imgProps","parentStyle")="width:38vw;max-width:800px;min-width:350px"
        s T("M",M("image"),"props","imgProps","parentClass")="flex flex-center q-pa-md row"
        s T("M",M("image"),"props","imgProps","label")="Profile photo"
        s T("M",M("image"),"props","imgProps","labelStyle")="width:38vw;max-width:800px;min-width:350px"
        s T("M",M("image"),"props","imgProps","labelClass")="text-grey text-center"
        s T("M",M("image"),"props","imgProps","flat")="true"
        Q
        ;
updateName(T)
        N A,M S A="" F  S A=$O(T("model",A)) Q:A=""  S M(T("model",A,"model"))=A
        N V S V=T("model",M("firstname"),"data","firstname")_" "_T("model",M("lastname"),"data","lastname")
        S T("model",M("name"),"data","name")=V
        Q
 
