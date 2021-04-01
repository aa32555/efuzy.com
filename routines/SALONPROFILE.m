SALONPROFILE
        ;
        ; MODEL
        ; SAVE NEW, UPDATE, LOG, PERMISSIONS, ETC. ;
        Q
        ; Basic Info name, phone, email, etc. ;
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
onBeforeGetModel(DATA)
        N ID S ID=$G(DATA("id"))
        I ID]"",ID'="*",'$D(@%G@("SALONPROFILE","DATA",ID)) S DATA("id")="*"
        Q
        ;
Model(T)
        N R 
        ;
        S T("F","title")="Edit Profile"
        S T("F","editTitle")="Edit Profile"
        S T("F","multiIndex",1)="phone"
        S T("F","searchIndex")=1
        ;
        I $I(R)
        S T("M",R,"is")="FUZImg"
        S T("M",R,"model")="image"
        S T("M",R,"data","image")=""
        S T("M",R,"type")="view-image"
        S T("M",R,"props","imgProps","avatar")="true"
        S T("M",R,"props","imgProps","imageClass")="v1-image"
        S T("M",R,"props","imgProps","size")="100px"
        S T("M",R,"props","imgProps","font-size")="52px"
        ;S T("M",M("image"),"props","imgProps","width")="34vw"  
        s T("M",R,"props","imgProps","parentStyle")="width:30vw;max-width:800px;min-width:350px"
        s T("M",R,"props","imgProps","parentClass")="flex flex-center q-pa-md row"
        s T("M",R,"props","imgProps","label")="Salon Logo"
        s T("M",R,"props","imgProps","labelStyle")="width:38vw;max-width:800px;min-width:350px"
        s T("M",R,"props","imgProps","labelClass")="text-grey text-center"
        s T("M",R,"props","imgProps","flat")="true"
        ;
        I $I(R) 
        S T("M",R,"model")="email"
        S T("M",R,"data","email")=""
        S T("M",R,"type")="string"
        S T("M",R,"is")="q-input"       
        S T("M",R,"props","rounded")="true"
        S T("M",R,"props","outlined")="true"
        S T("M",R,"props","label")="Email"
        S T("M",R,"props","lazy-rules")="true"
        S T("M",R,"props","style")="width:30vw;max-width:800px;min-width:350px"
        S T("M",R,"rules","required")="true"
        S T("M",R,"index")="true"
        ;
        I $I(R) 
        S T("M",R,"model")="id"
        S T("M",R,"data","id")=%ACCOUNT
        S T("M",R,"type")="string"
        S T("M",R,"is")="span"  
        S T("M",R,"props","rounded")="true"
        S T("M",R,"props","outlined")="true"
        S T("M",R,"props","label")="ID"
        S T("M",R,"props","lazy-rules")="true"
        S T("M",R,"props","style")="width:30vw;max-width:800px;min-width:350px"
        S T("M",R,"rules","required")="true"
        S T("M",R,"props","disable")="true"
        ;
        ;
        I $I(R) 
        S T("M",R,"model")="name"
        S T("M",R,"data","name")=""
        S T("M",R,"type")="string"
        S T("M",R,"is")="q-input"       
        S T("M",R,"props","rounded")="true"
        S T("M",R,"props","outlined")="true"
        S T("M",R,"props","label")="Salon name"
        S T("M",R,"props","lazy-rules")="true"
        S T("M",R,"props","style")="width:30vw;max-width:800px;min-width:350px"
        S T("M",R,"rules","required")="true"
        S T("M",R,"index")="true"
        ;
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
        S T("M",R,"model")="jobStatus"
        S T("M",R,"data","jobStatus")="Y"
        S T("M",R,"props","style")="width:30vw;max-width:800px;min-width:350px"
        S T("M",R,"options",1,"label")="I'm currently hiring"
        S T("M",R,"options",1,"val")="N"
        S T("M",R,"options",2,"label")="I'm not hiring"
        S T("M",R,"options",2,"val")="Y"
        ;
        I $I(R)
        S T("M",R,"type")="string"
        S T("M",R,"model")="aboutme"
        S T("M",R,"data","aboutme")=""
        S T("M",R,"is")="q-input"               
        S T("M",R,"props","type")="textarea"
        S T("M",R,"props","autogrow")="true"
        S T("M",R,"props","rounded")="true"
        S T("M",R,"props","outlined")="true"
        S T("M",R,"props","label")="About Salon"
        S T("M",R,"props","lazy-rules")="true"
        S T("M",R,"props","style")="width:30vw;max-width:800px;min-width:350px"
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
        . S T("M",R,"props","style")="width:30vw;max-width:800px;min-width:350px"
        . s T("M",R,"props","imgProps","parentClass")="flex flex-center q-pa-md row"
        . s T("M",R,"props","imgProps","label")="Featured Image "_I
        . s T("M",R,"props","imgProps","labelStyle")="width:30vw;max-width:800px;min-width:350px"
        . s T("M",R,"props","imgProps","labelClass")="text-grey text-center"
        . s T("M",R,"props","imgProps","flat")="true"
        ;
        ;       
        Q
        ;
        ;
