ONLINEBOOKINGCUSTOMIZATION ;
	;
	;
	;
	Q
	;
ROUTES
	I $I(N)
	S @T@("header","mainNav",H,"children",N,"label")="Online booking customizations list"
	S @T@("header","mainNav",H,"children",N,"to")="/onlinebookingcustomization/list"
	;
	;
	i $I(P)
	S @T@("pages",P,"path")="/onlinebookingcustomization/list"
	S @T@("pages",P,"name")="Online booking customizations"
	S @T@("pages",P,"childBreadcrump")="customizationlist"
	S @T@("pages",P,"breadcrump")="onlinebookingcustomization"
	S @T@("pages",P,"component")="FUZPage"
	S @T@("pages",P,"requiresAuth")="true"
	S @T@("pages",P,"routine")="TREE^ONLINEBOOKINGCUSTOMIZATION"
	S @T@("pages",P,"type")="SALON"
	;
	i $I(P)
	S @T@("pages",P,"path")="/onlinebookingcustomization/edit"
	S @T@("pages",P,"name")="Edit Online booking customizations"
	S @T@("pages",P,"childBreadcrump")="editcustomization"
	S @T@("pages",P,"breadcrump")="onlinebookingcustomization"
	S @T@("pages",P,"subName")="ServiceEdit"
	S @T@("pages",P,"component")="FUZPage"
	S @T@("pages",P,"requiresAuth")="true"
	S @T@("pages",P,"routine")="EDITALLTREE^ONLINEBOOKINGCUSTOMIZATION"
	S @T@("pages",P,"type")="SALON"
	;
	i $I(P)
	S @T@("pages",P,"path")="/onlinebookingcustomization/edit/:id"
	S @T@("pages",P,"name")="Edit Service"
	S @T@("pages",P,"childBreadcrump")="editcustomization"
	S @T@("pages",P,"breadcrump")="onlinebookingcustomization"
	S @T@("pages",P,"component")="FUZPage"
	S @T@("pages",P,"requiresAuth")="true"
	S @T@("pages",P,"routine")="EDITTREE^ONLINEBOOKINGCUSTOMIZATION"
	S @T@("pages",P,"type")="SALON"
	;
	i $I(P)
	S @T@("pages",P,"path")="/onlinebookingcustomization/add/:id"
	S @T@("pages",P,"name")="Add Service"
	S @T@("pages",P,"childBreadcrump")="addcustomization"
	S @T@("pages",P,"breadcrump")="onlinebookingcustomization"
	S @T@("pages",P,"component")="FUZPage"
	S @T@("pages",P,"requiresAuth")="true"
	S @T@("pages",P,"routine")="ADDTREE^ONLINEBOOKINGCUSTOMIZATION"
	S @T@("pages",P,"type")="SALON"
	;
	;
	Q       
	;
onAfterModelSave
	I $G(DATA("noRerouteAfterSave"))="true" Q
	S %J("dispatch","action")="app/changeRoute"
	S %J("dispatch","data")="/onlinebookingcustomization/list"
	Q
UpdateAvatarPreview(T)
	N A,M
	S A="" F  S A=$O(T("M",A)) Q:A=""  S M(T("M",A,"model"))=A 
	S T("M",M("avatarPreview"),"props","isCircle")=$s(T("M",M("isCircleAvatar"),"data","isCircleAvatar")="Yes":"true",1:"false")
	S T("M",M("avatarPreview"),"props","circleColor")=T("M",M("circleColorAvatar"),"data","circleColorAvatar")
	S T("M",M("avatarPreview"),"props","accessoriesType")=T("M",M("accessoriesTypeAvatar"),"data","accessoriesTypeAvatar")
	S T("M",M("avatarPreview"),"props","clotheType")=T("M",M("clotheTypeAvatar"),"data","clotheTypeAvatar")
	S T("M",M("avatarPreview"),"props","clotheColor")=T("M",M("clotheColorAvatar"),"data","clotheColorAvatar")
	S T("M",M("avatarPreview"),"props","eyebrowType")=T("M",M("eyebrowTypeAvatar"),"data","eyebrowTypeAvatar")
	S T("M",M("avatarPreview"),"props","eyeType")=T("M",M("eyeTypeAvatar"),"data","eyeTypeAvatar")
	S T("M",M("avatarPreview"),"props","facialHairColor")=T("M",M("facialHairColorAvatar"),"data","facialHairColorAvatar")
	S T("M",M("avatarPreview"),"props","facialHairType")=T("M",M("facialHairTypeAvatar"),"data","facialHairTypeAvatar")
	S T("M",M("avatarPreview"),"props","graphicType")=T("M",M("graphicTypeAvatar"),"data","graphicTypeAvatar")
	S T("M",M("avatarPreview"),"props","hairColor")=T("M",M("hairColorAvatar"),"data","hairColorAvatar")
	S T("M",M("avatarPreview"),"props","mouthType")=T("M",M("mouthTypeAvatar"),"data","mouthTypeAvatar")
	S T("M",M("avatarPreview"),"props","skinColor")=T("M",M("skinColorAvatar"),"data","skinColorAvatar")
	S T("M",M("avatarPreview"),"props","topType")=T("M",M("topTypeAvatar"),"data","topTypeAvatar")
	S T("M",M("avatarPreview"),"props","topColor")=T("M",M("topColorAvatar"),"data","topColorAvatar")
	Q
	;
FillModel(T,ID)
	D FillModel^FUZNEW(.T,"ONLINEBOOKINGCUSTOMIZATION",ID)
	N A,M
	S A="" F  S A=$O(T("M",A)) Q:A=""  S M(T("M",A,"model"))=A
	S T("M",M("avatarPreview"),"props","isCircle")=$s(T("M",M("isCircleAvatar"),"data","isCircleAvatar")="Yes":"true",1:"false")
	S T("M",M("avatarPreview"),"props","circleColor")=T("M",M("circleColorAvatar"),"data","circleColorAvatar")
	S T("M",M("avatarPreview"),"props","accessoriesType")=T("M",M("accessoriesTypeAvatar"),"data","accessoriesTypeAvatar")
	S T("M",M("avatarPreview"),"props","clotheType")=T("M",M("clotheTypeAvatar"),"data","clotheTypeAvatar")
	S T("M",M("avatarPreview"),"props","clotheColor")=T("M",M("clotheColorAvatar"),"data","clotheColorAvatar")
	S T("M",M("avatarPreview"),"props","eyebrowType")=T("M",M("eyebrowTypeAvatar"),"data","eyebrowTypeAvatar")
	S T("M",M("avatarPreview"),"props","eyeType")=T("M",M("eyeTypeAvatar"),"data","eyeTypeAvatar")
	S T("M",M("avatarPreview"),"props","facialHairColor")=T("M",M("facialHairColorAvatar"),"data","facialHairColorAvatar")
	S T("M",M("avatarPreview"),"props","facialHairType")=T("M",M("facialHairTypeAvatar"),"data","facialHairTypeAvatar")
	S T("M",M("avatarPreview"),"props","graphicType")=T("M",M("graphicTypeAvatar"),"data","graphicTypeAvatar")
	S T("M",M("avatarPreview"),"props","hairColor")=T("M",M("hairColorAvatar"),"data","hairColorAvatar")
	S T("M",M("avatarPreview"),"props","mouthType")=T("M",M("mouthTypeAvatar"),"data","mouthTypeAvatar")
	S T("M",M("avatarPreview"),"props","skinColor")=T("M",M("skinColorAvatar"),"data","skinColorAvatar")
	S T("M",M("avatarPreview"),"props","topType")=T("M",M("topTypeAvatar"),"data","topTypeAvatar")
	S T("M",M("avatarPreview"),"props","topColor")=T("M",M("topColorAvatar"),"data","topColorAvatar")
	;	
	Q       
	;
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
	S T("M",R,"transformOnIndex")="V=$ZCVT(V,""L"")"
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
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZSelect"
	S T("M",R,"model")="isCircleAvatar"
	S T("M",R,"data","isCircleAvatar")="Yes"
	s T("M",R,"onChange")="UpdateAvatarPreview"             
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Is avatar cirle?"
	S T("M",R,"props","options",1)="Yes"
	S T("M",R,"props","options",2)="No"
	;
	I $I(R) 
	S T("M",R,"model")="circleColorAvatar"
	S T("M",R,"data","circleColorAvatar")="#6fb8e0"
	S T("M",R,"type")="string"
	S T("M",R,"is")="FUZColorPicker"
	S T("M",R,"props","label")="Avatar Circle Color" 
	S T("M",R,"props","fontColor")="white"
	S T("M",R,"props","style")="width:350px;color:white;"
	s T("M",R,"onChange")="UpdateAvatarPreview"             
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZSelect"
	S T("M",R,"model")="accessoriesTypeAvatar"
	S T("M",R,"data","accessoriesTypeAvatar")="Kurt"                
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Avatar accessory type?"
	S T("M",R,"props","options",1)="Blank"
	S T("M",R,"props","options",2)="Kurt"
	S T("M",R,"props","options",3)="Prescription01"
	S T("M",R,"props","options",4)="Prescription02"
	S T("M",R,"props","options",5)="Round"
	S T("M",R,"props","options",6)="Sunglasses"
	S T("M",R,"props","options",7)="Wayfarers"
	s T("M",R,"onChange")="UpdateAvatarPreview"     
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZSelect"
	S T("M",R,"model")="clotheTypeAvatar"
	S T("M",R,"data","clotheTypeAvatar")="BlazerShirt"              
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Avatar clothes types?"
	S T("M",R,"props","options",1)="BlazerShirt"
	S T("M",R,"props","options",2)="BlazerSweater"
	S T("M",R,"props","options",3)="CollarSweater"
	S T("M",R,"props","options",4)="GraphicShirt"
	S T("M",R,"props","options",5)="Hoodie"
	S T("M",R,"props","options",6)="Overall"
	S T("M",R,"props","options",7)="ShirtCrewNeck"
	S T("M",R,"props","options",8)="ShirtScoopNeck"
	S T("M",R,"props","options",9)="ShirtVNeck"
	s T("M",R,"onChange")="UpdateAvatarPreview"     
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZSelect"
	S T("M",R,"model")="clotheColorAvatar"
	S T("M",R,"data","clotheColorAvatar")="Black"           
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Avatar clothes color?"
	S T("M",R,"props","options",1)="Black"
	S T("M",R,"props","options",2)="Blue01"
	S T("M",R,"props","options",3)="Blue02"
	S T("M",R,"props","options",4)="Blue03"
	S T("M",R,"props","options",5)="Gray01"
	S T("M",R,"props","options",6)="Gray02"
	S T("M",R,"props","options",7)="Heather"
	S T("M",R,"props","options",8)="PastelBlue"
	S T("M",R,"props","options",9)="PastelGreen"
	S T("M",R,"props","options",10)="PastelOrange"
	S T("M",R,"props","options",11)="PastelRed"
	S T("M",R,"props","options",12)="PastelYellow"
	S T("M",R,"props","options",13)="Pink"
	S T("M",R,"props","options",14)="Red"
	S T("M",R,"props","options",15)="White"
	s T("M",R,"onChange")="UpdateAvatarPreview"     
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZSelect"
	S T("M",R,"model")="eyebrowTypeAvatar"
	S T("M",R,"data","eyebrowTypeAvatar")="Angry"           
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Avatar eyebrow type?"
	S T("M",R,"props","options",1)="Angry"
	S T("M",R,"props","options",2)="AngryNatural"
	S T("M",R,"props","options",3)="Default"
	S T("M",R,"props","options",4)="DefaultNatural"
	S T("M",R,"props","options",5)="FlatNatural"
	S T("M",R,"props","options",6)="RaisedExcited"
	S T("M",R,"props","options",7)="RaisedExcitedNatural"
	S T("M",R,"props","options",8)="SadConcerned"
	S T("M",R,"props","options",9)="SadConcernedNatural"
	S T("M",R,"props","options",10)="UnibrowNatural"
	S T("M",R,"props","options",11)="UpDown"
	S T("M",R,"props","options",12)="UpDownNatural"
	s T("M",R,"onChange")="UpdateAvatarPreview"     
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZSelect"
	S T("M",R,"model")="eyeTypeAvatar"
	S T("M",R,"data","eyeTypeAvatar")="Close"               
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Avatar eye type?"
	S T("M",R,"props","options",1)="Close"
	S T("M",R,"props","options",2)="Cry"
	S T("M",R,"props","options",3)="Default"
	S T("M",R,"props","options",4)="Dizzy"
	S T("M",R,"props","options",5)="EyeRoll"
	S T("M",R,"props","options",6)="Happy"
	S T("M",R,"props","options",7)="Hearts"
	S T("M",R,"props","options",8)="Side"
	S T("M",R,"props","options",9)="Squint"
	S T("M",R,"props","options",10)="Surprised"
	S T("M",R,"props","options",11)="Wink"
	S T("M",R,"props","options",12)="WinkWacky"
	s T("M",R,"onChange")="UpdateAvatarPreview"     
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZSelect"
	S T("M",R,"model")="facialHairColorAvatar"
	S T("M",R,"data","facialHairColorAvatar")="Auburn"              
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Avatar facial hair color?"
	S T("M",R,"props","options",1)="Auburn"
	S T("M",R,"props","options",2)="Black"
	S T("M",R,"props","options",3)="Blonde"
	S T("M",R,"props","options",4)="BlondeGolden"
	S T("M",R,"props","options",5)="Brown"
	S T("M",R,"props","options",6)="BrownDark"
	S T("M",R,"props","options",7)="PastelPink"
	S T("M",R,"props","options",8)="Platinum"
	S T("M",R,"props","options",9)="Red"
	S T("M",R,"props","options",10)="SilverGray"
	s T("M",R,"onChange")="UpdateAvatarPreview"     
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZSelect"
	S T("M",R,"model")="facialHairTypeAvatar"
	S T("M",R,"data","facialHairTypeAvatar")="BeardMedium"          
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Avatar facial hair type?"
	S T("M",R,"props","options",1)="Blank"
	S T("M",R,"props","options",2)="BeardMedium"
	S T("M",R,"props","options",3)="BeardLight"
	S T("M",R,"props","options",4)="BeardMagestic"
	S T("M",R,"props","options",5)="MoustacheFancy"
	S T("M",R,"props","options",6)="MoustacheMagnum"
	s T("M",R,"onChange")="UpdateAvatarPreview"     
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZSelect"
	S T("M",R,"model")="graphicTypeAvatar"
	S T("M",R,"data","graphicTypeAvatar")="Bat"             
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Avatar graphic type?"
	S T("M",R,"props","options",1)="Bat"
	S T("M",R,"props","options",2)="Cumbia"
	S T("M",R,"props","options",3)="Deer"
	S T("M",R,"props","options",4)="Diamond"
	S T("M",R,"props","options",5)="Hola"
	S T("M",R,"props","options",6)="Pizza"
	S T("M",R,"props","options",7)="Resist"
	S T("M",R,"props","options",8)="Selena"
	S T("M",R,"props","options",9)="Bear"
	S T("M",R,"props","options",10)="SkullOutline"
	S T("M",R,"props","options",11)="Skull"
	s T("M",R,"onChange")="UpdateAvatarPreview"     
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZSelect"
	S T("M",R,"model")="hairColorAvatar"
	S T("M",R,"data","hairColorAvatar")="Auburn"            
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Avatar hair color?"
	S T("M",R,"props","options",1)="Auburn"
	S T("M",R,"props","options",2)="Black"
	S T("M",R,"props","options",3)="Blonde"
	S T("M",R,"props","options",4)="BlondeGolden"
	S T("M",R,"props","options",5)="Brown"
	S T("M",R,"props","options",6)="BrownDark"
	S T("M",R,"props","options",7)="PastelPink"
	S T("M",R,"props","options",8)="Platinum"
	S T("M",R,"props","options",9)="Red"
	S T("M",R,"props","options",10)="SilverGray"
	s T("M",R,"onChange")="UpdateAvatarPreview"     
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZSelect"
	S T("M",R,"model")="mouthTypeAvatar"
	S T("M",R,"data","mouthTypeAvatar")="Concerned"         
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Avatar mouth type?"
	S T("M",R,"props","options",1)="Concerned"
	S T("M",R,"props","options",2)="Default"
	S T("M",R,"props","options",3)="Disbelief"
	S T("M",R,"props","options",4)="Eating"
	S T("M",R,"props","options",5)="Grimace"
	S T("M",R,"props","options",6)="Sad"
	S T("M",R,"props","options",7)="ScreamOpen"
	S T("M",R,"props","options",8)="Serious"
	S T("M",R,"props","options",9)="Smile"
	S T("M",R,"props","options",10)="Tongue"
	S T("M",R,"props","options",11)="Twinkle"
	S T("M",R,"props","options",12)="Vomit"
	s T("M",R,"onChange")="UpdateAvatarPreview"     
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZSelect"
	S T("M",R,"model")="skinColorAvatar"
	S T("M",R,"data","skinColorAvatar")="Tanned"            
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Avatar skin color?"
	S T("M",R,"props","options",1)="Tanned"
	S T("M",R,"props","options",2)="Yellow"
	S T("M",R,"props","options",3)="Pale"
	S T("M",R,"props","options",4)="Light"
	S T("M",R,"props","options",5)="Brown"
	S T("M",R,"props","options",6)="DarkBrown"
	S T("M",R,"props","options",7)="Black"
	s T("M",R,"onChange")="UpdateAvatarPreview"     
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZSelect"
	S T("M",R,"model")="topTypeAvatar"
	S T("M",R,"data","topTypeAvatar")="NoHair"              
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Avatar top type?"
	S T("M",R,"props","options",1)="NoHair"
	S T("M",R,"props","options",2)="Eyepatch"
	S T("M",R,"props","options",3)="Hat"
	S T("M",R,"props","options",4)="Hijab"
	S T("M",R,"props","options",5)="Turban"
	S T("M",R,"props","options",6)="WinterHat1"
	S T("M",R,"props","options",7)="WinterHat2"
	S T("M",R,"props","options",8)="WinterHat3"
	S T("M",R,"props","options",9)="WinterHat4"
	S T("M",R,"props","options",10)="LongHairBigHair"
	S T("M",R,"props","options",11)="LongHairBob"
	S T("M",R,"props","options",12)="LongHairBun"
	S T("M",R,"props","options",13)="LongHairCurly"
	S T("M",R,"props","options",14)="LongHairCurvy"
	S T("M",R,"props","options",15)="LongHairDreads"
	S T("M",R,"props","options",16)="LongHairFrida"
	S T("M",R,"props","options",17)="LongHairFro"
	S T("M",R,"props","options",18)="LongHairFroBand"
	S T("M",R,"props","options",19)="LongHairNotTooLong"
	S T("M",R,"props","options",20)="LongHairShavedSides"
	S T("M",R,"props","options",21)="LongHairMiaWallace"
	S T("M",R,"props","options",22)="LongHairStraight"
	S T("M",R,"props","options",23)="LongHairStraight2"
	S T("M",R,"props","options",24)="LongHairStraightStrand"
	S T("M",R,"props","options",25)="ShortHairDreads01"
	S T("M",R,"props","options",26)="ShortHairDreads02"
	S T("M",R,"props","options",27)="ShortHairFrizzle"
	S T("M",R,"props","options",28)="ShortHairShaggyMullet"
	S T("M",R,"props","options",29)="ShortHairShortCurly"
	S T("M",R,"props","options",30)="ShortHairShortFlat"
	S T("M",R,"props","options",31)="ShortHairShortRound"
	S T("M",R,"props","options",32)="ShortHairShortWaved"
	S T("M",R,"props","options",33)="ShortHairSides"
	S T("M",R,"props","options",34)="ShortHairTheCaesar"
	S T("M",R,"props","options",35)="ShortHairTheCaesarSidePart"
	s T("M",R,"onChange")="UpdateAvatarPreview"     
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZSelect"
	S T("M",R,"model")="topColorAvatar"
	S T("M",R,"data","topColorAvatar")="Tanned"             
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Avatar top color?"
	S T("M",R,"props","options",1)="Black"
	S T("M",R,"props","options",2)="Blue01"
	S T("M",R,"props","options",3)="Blue02"
	S T("M",R,"props","options",4)="Blue03"
	S T("M",R,"props","options",5)="Gray01"
	S T("M",R,"props","options",6)="Gray02"
	S T("M",R,"props","options",7)="Heather"
	S T("M",R,"props","options",8)="PastelBlue"
	S T("M",R,"props","options",9)="PastelGreen"
	S T("M",R,"props","options",10)="PastelOrange"
	S T("M",R,"props","options",11)="PastelRed"
	S T("M",R,"props","options",12)="PastelYellow"
	S T("M",R,"props","options",13)="Pink"
	S T("M",R,"props","options",14)="Red"
	S T("M",R,"props","options",15)="White"
	s T("M",R,"onChange")="UpdateAvatarPreview"     
	;
	I $I(R) 
	S T("M",R,"model")="avatarPreview"
	S T("M",R,"data","avatarPreview")=""
	S T("M",R,"type")="string"
	S T("M",R,"is")="avataaars"     
	S T("M",R,"props","style")="width:350px;height:340px"
	S T("M",R,"props","isCircle")="true"
	S T("M",R,"props","circleColor")="#6fb8e0"
	S T("M",R,"props","accessoriesType")="Kurt"
	S T("M",R,"props","clotheType")="BlazerShirt"
	S T("M",R,"props","clotheColor")="Black"
	S T("M",R,"props","eyebrowType")="Angry"
	S T("M",R,"props","eyeType")="Close"
	S T("M",R,"props","facialHairColor")="Auburn"
	S T("M",R,"facialHairType")="Blank"
	S T("M",R,"props","graphicType")="Bat"
	S T("M",R,"hairColor")="Auburn"
	S T("M",R,"props","mouthType")="Concerned"
	S T("M",R,"props","skinColor")="Tanned"
	S T("M",R,"props","topType")="NoHair"
	S T("M",R,"props","topColor")="Black"
	;
	;
	N I F I=1:1:3 D CreateAvatarForStep(I,.R,.T)
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
	N P B
	s DATA("model",M("id"),"data","id")=T("M",M("name"),"data","name") 
	;
	S STATUS="OK"
	Q
	;       
. ;
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
	S T(R,"subSubComponent","props","toID")="/onlinebookingcustomization/edit/"
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
	S T(R,"subSubComponent","props","buttons",1,"type")="ONLINEBOOKINGCUSTOMIZATION"
	S T(R,"subSubComponent","props","buttons",1,"onClick")="ViewRecord^FUZNEW"
	S T(R,"subSubComponent","props","buttons",1,"props","clickable")="true"
	S T(R,"subSubComponent","props","buttons",1,"props","v-close-popup")="true"
	S T(R,"subSubComponent","props","buttons",2,"title")="Edit"
	S T(R,"subSubComponent","props","buttons",2,"action")="routine"
	S T(R,"subSubComponent","props","buttons",2,"type")="ONLINEBOOKINGCUSTOMIZATION"
	S T(R,"subSubComponent","props","buttons",2,"onClick")="EditRecord^FUZNEW"
	S T(R,"subSubComponent","props","buttons",2,"props","clickable")="true"
	S T(R,"subSubComponent","props","buttons",2,"props","v-close-popup")="true"
	S T(R,"subSubComponent","props","buttons",3,"title")="Delete"
	S T(R,"subSubComponent","props","buttons",3,"action")="routine"
	S T(R,"subSubComponent","props","buttons",3,"type")="ONLINEBOOKINGCUSTOMIZATION"
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
	S T("rows",R,"cols",C,"title")="Online booking customizations"
	S T("rows",R,"cols",C,"is")="FUZList"
	S T("rows",R,"cols",C,"props","type")="ONLINEBOOKINGCUSTOMIZATION"
	S T("rows",R,"cols",C,"props","routine")="List^ONLINEBOOKINGCUSTOMIZATION"
	S T("rows",R,"cols",C,"props","header")="Online booking customizations"
	S T("rows",R,"cols",C,"props","emptyListText")="No online booking customizations found, click this button to add a customization!"
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
	S T("rows",R,"cols",C,"props","type")="ONLINEBOOKINGCUSTOMIZATION"
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
	S T("rows",R,"cols",C,"props","type")="ONLINEBOOKINGCUSTOMIZATION"
	Q       
	;
EDITALLTREE(T)
	N R,C
	I $I(R),$I(C)
	S T("rows",R,"class")="row"
	S T("rows",R,"is")="div"
	S T("rows",R,"cols",C,"class")="flex flex-center col"
	S T("rows",R,"cols",C,"title")="Search onlinbookincustomizations"
	S T("rows",R,"cols",C,"is")="FUZListSearchPage"
	S T("rows",R,"cols",C,"props","type")="ONLINEBOOKINGCUSTOMIZATION"
	S T("rows",R,"cols",C,"props","routine")="List^ONLINEBOOKINGCUSTOMIZATION"
	S T("rows",R,"cols",C,"props","label")="Search online booking customizations"
	S T("rows",R,"cols",C,"props","selectItems","label")="name"
	S T("rows",R,"cols",C,"props","selectItems","caption",1)="description"
	Q
	;
	;
GetMOdelForStep(D,O)
	S D("data","type")="ONLINEBOOKINGCUSTOMIZATION"
	S D("data","id")="template"
	N RS D getSimpleModelData^FUZNEW(.D,.RS)
	N M M M=RS("data","model")
	N STEP S STEP=D("data","step")
	S O("data","page","bgColor1")=$S($G(M("gradient1-"_STEP))]"":M("gradient1-"_STEP),1:M("gradient1-"_1))
	S O("data","page","bgColor2")=$S($G(M("gradient2-"_STEP))]"":M("gradient2-"_STEP),1:M("gradient2-"_1))
	S O("data","page","bgImage")=$S($G(M("bgImage"_STEP))]"":M("bgImage"_STEP),1:M("bgImage"_1))
	S O("data","page","bgType")=$S($G(M("bgType"_STEP))]"":M("bgType"_STEP),1:M("bgType"_1))
	S O("data","page","step")=STEP
	S O("data","page","stepBackgroundColor")=$S($G(M("stepBackgroundColor"_STEP))]"":M("stepBackgroundColor"_STEP),1:M("stepBackgroundColor"_1))
	S O("data","page","prompt")=$S($G(M("prompt"_STEP))]"":M("prompt"_STEP),1:M("prompt"_1))
	S O("data","page","avatarProps","isCircle")=$s(($S($G(M("isCircleAvatar"_STEP))]"":M("isCircleAvatar"_STEP),1:M("isCircleAvatar")))="Yes":"true",1:"false")
	S O("data","page","avatarProps","circleColor")=$S($G(M("circleColorAvatar"_STEP))]"":M("circleColorAvatar"_STEP),1:M("circleColorAvatar"))
	S O("data","page","avatarProps","accessoriesType")=$S($G(M("accessoriesTypeAvatar"_STEP))]"":M("accessoriesTypeAvatar"_STEP),1:M("accessoriesTypeAvatar"))
	S O("data","page","avatarProps","clotheType")=$S($G(M("clotheTypeAvatar"_STEP))]"":M("clotheTypeAvatar"),1:M("clotheTypeAvatar"))
	S O("data","page","avatarProps","clotheColor")=$S($G(M("clotheColorAvatar"_STEP))]"":M("clotheColorAvatar"_STEP),1:M("clotheColorAvatar"))
	S O("data","page","avatarProps","eyebrowType")=$S($G(M("eyebrowTypeAvatar"_STEP))]"":M("eyebrowTypeAvatar"_STEP),1:M("eyebrowTypeAvatar"))
	S O("data","page","avatarProps","eyeType")=$S($G(M("eyeTypeAvatar"_STEP))]"":M("eyeTypeAvatar"_STEP),1:M("eyeTypeAvatar"))
	S O("data","page","avatarProps","facialHairColor")=$S($G(M("facialHairColorAvatar"_STEP))]"":M("facialHairColorAvatar"_STEP),1:M("facialHairColorAvatar"))
	S O("data","page","avatarProps","facialHairType")=$S($G(M("facialHairTypeAvatar"_STEP))]"":M("facialHairTypeAvatar"_STEP),1:M("facialHairTypeAvatar"))
	S O("data","page","avatarProps","graphicType")=$S($G(M("graphicTypeAvatar"_STEP))]"":M("graphicTypeAvatar"_STEP),1:M("graphicTypeAvatar"))
	S O("data","page","avatarProps","hairColor")=$S($G(M("hairColorAvatar"_STEP))]"":M("hairColorAvatar"_STEP),1:M("hairColorAvatar"))
	S O("data","page","avatarProps","mouthType")=$S($G(M("mouthTypeAvatar"_STEP))]"":M("mouthTypeAvatar"_STEP),1:M("mouthTypeAvatar"))
	S O("data","page","avatarProps","skinColor")=$S($G(M("skinColorAvatar"_STEP))]"":M("skinColorAvatar"_STEP),1:M("skinColorAvatar"))
	S O("data","page","avatarProps","topType")=$S($G(M("topTypeAvatar"_STEP))]"":M("topTypeAvatar"_STEP),1:M("topTypeAvatar"))
	S O("data","page","avatarProps","topColor")=$S($G(M("topColorAvatar"_STEP))]"":M("topColorAvatar"_STEP),1:M("topColorAvatar"))
	I $T(@("STEP"_STEP))]"" D @("STEP"_STEP)
	s O("status")="true"
	Q
	;
CreateAvatarForStep(STEP,R,T)
	I $I(R)
	S T("M",R,"type")="radio"
	S T("M",R,"model")="bgType"_STEP
	S T("M",R,"data","bgType"_STEP)="gradient"
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"options",1,"label")="Background as a gradient step "_STEP
	S T("M",R,"options",1,"val")="gradient"
	S T("M",R,"options",2,"label")="Background as an image step "_STEP
	S T("M",R,"options",2,"val")="img"
	;
	I $I(R) 
	S T("M",R,"model")="gradient1-"_STEP
	S T("M",R,"data","gradient1-"_STEP)=""
	S T("M",R,"type")="string"
	S T("M",R,"is")="FUZColorPicker"
	S T("M",R,"props","label")="Background gradient 1 color step "_STEP
	S T("M",R,"props","fontColor")="white"
	S T("M",R,"props","style")="width:350px;color:white;"   
	;
	I $I(R) 
	S T("M",R,"model")="gradient2-"_STEP
	S T("M",R,"data","gradient2-"_STEP)=""
	S T("M",R,"type")="string"
	S T("M",R,"is")="FUZColorPicker"
	S T("M",R,"props","label")="Background gradient 2 color step"_STEP 
	S T("M",R,"props","fontColor")="white"
	S T("M",R,"props","style")="width:350px;color:white;"   
	;
	I $I(R) 
	S T("M",R,"model")="stepBackgroundColor"_STEP
	S T("M",R,"data","stepBackgroundColor"_STEP)=""
	S T("M",R,"type")="string"
	S T("M",R,"is")="FUZColorPicker"
	S T("M",R,"props","label")="Stepper background color step"_STEP 
	S T("M",R,"props","fontColor")="white"
	S T("M",R,"props","style")="width:350px;color:white;"   
	;
	I $I(R) 
	S T("M",R,"model")="bgImage"_STEP
	S T("M",R,"data","bgImage"_STEP)=""
	S T("M",R,"type")="string"
	S T("M",R,"is")="q-input"       
	S T("M",R,"props","rounded")="true"
	S T("M",R,"props","outlined")="true"
	S T("M",R,"props","label")="Background image step"_STEP
	S T("M",R,"props","lazy-rules")="true"
	S T("M",R,"props","style")="width:350px;"
	;
	I $I(R) 
	S T("M",R,"model")="prompt"_STEP
	S T("M",R,"data","prompt"_STEP)=""
	S T("M",R,"props","type")="textarea"
	S T("M",R,"type")="string"
	S T("M",R,"props","autogrow")="true"
	S T("M",R,"is")="q-input"       
	S T("M",R,"props","rounded")="true"
	S T("M",R,"props","outlined")="true"
	S T("M",R,"props","label")="Prompt for step "_STEP 
	S T("M",R,"props","lazy-rules")="true"
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"rules","required")="true"
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZSelect"
	S T("M",R,"model")="accessoriesTypeAvatar"_STEP
	S T("M",R,"data","accessoriesTypeAvatar"_STEP)=""               
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Avatar accessory type?"
	S T("M",R,"props","options",1)="Blank"
	S T("M",R,"props","options",2)="Kurt"
	S T("M",R,"props","options",3)="Prescription01"
	S T("M",R,"props","options",4)="Prescription02"
	S T("M",R,"props","options",5)="Round"
	S T("M",R,"props","options",6)="Sunglasses"
	S T("M",R,"props","options",7)="Wayfarers"
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZSelect"
	S T("M",R,"model")="clotheTypeAvatar"_STEP
	S T("M",R,"data","clotheTypeAvatar"_STEP)=""            
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Avatar clothes types?"
	S T("M",R,"props","options",1)="BlazerShirt"
	S T("M",R,"props","options",2)="BlazerSweater"
	S T("M",R,"props","options",3)="CollarSweater"
	S T("M",R,"props","options",4)="GraphicShirt"
	S T("M",R,"props","options",5)="Hoodie"
	S T("M",R,"props","options",6)="Overall"
	S T("M",R,"props","options",7)="ShirtCrewNeck"
	S T("M",R,"props","options",8)="ShirtScoopNeck"
	S T("M",R,"props","options",9)="ShirtVNeck"
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZSelect"
	S T("M",R,"model")="clotheColorAvatar"_STEP
	S T("M",R,"data","clotheColorAvatar"_STEP)=""           
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Avatar clothes color?"
	S T("M",R,"props","options",1)="Black"
	S T("M",R,"props","options",2)="Blue01"
	S T("M",R,"props","options",3)="Blue02"
	S T("M",R,"props","options",4)="Blue03"
	S T("M",R,"props","options",5)="Gray01"
	S T("M",R,"props","options",6)="Gray02"
	S T("M",R,"props","options",7)="Heather"
	S T("M",R,"props","options",8)="PastelBlue"
	S T("M",R,"props","options",9)="PastelGreen"
	S T("M",R,"props","options",10)="PastelOrange"
	S T("M",R,"props","options",11)="PastelRed"
	S T("M",R,"props","options",12)="PastelYellow"
	S T("M",R,"props","options",13)="Pink"
	S T("M",R,"props","options",14)="Red"
	S T("M",R,"props","options",15)="White"
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZSelect"
	S T("M",R,"model")="eyebrowTypeAvatar"_STEP
	S T("M",R,"data","eyebrowTypeAvatar"_STEP)=""           
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Avatar eyebrow type?"
	S T("M",R,"props","options",1)="Angry"
	S T("M",R,"props","options",2)="AngryNatural"
	S T("M",R,"props","options",3)="Default"
	S T("M",R,"props","options",4)="DefaultNatural"
	S T("M",R,"props","options",5)="FlatNatural"
	S T("M",R,"props","options",6)="RaisedExcited"
	S T("M",R,"props","options",7)="RaisedExcitedNatural"
	S T("M",R,"props","options",8)="SadConcerned"
	S T("M",R,"props","options",9)="SadConcernedNatural"
	S T("M",R,"props","options",10)="UnibrowNatural"
	S T("M",R,"props","options",11)="UpDown"
	S T("M",R,"props","options",12)="UpDownNatural"
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZSelect"
	S T("M",R,"model")="eyeTypeAvatar"_STEP
	S T("M",R,"data","eyeTypeAvatar"_STEP)=""               
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Avatar eye type?"
	S T("M",R,"props","options",1)="Close"
	S T("M",R,"props","options",2)="Cry"
	S T("M",R,"props","options",3)="Default"
	S T("M",R,"props","options",4)="Dizzy"
	S T("M",R,"props","options",5)="EyeRoll"
	S T("M",R,"props","options",6)="Happy"
	S T("M",R,"props","options",7)="Hearts"
	S T("M",R,"props","options",8)="Side"
	S T("M",R,"props","options",9)="Squint"
	S T("M",R,"props","options",10)="Surprised"
	S T("M",R,"props","options",11)="Wink"
	S T("M",R,"props","options",12)="WinkWacky"
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZSelect"
	S T("M",R,"model")="facialHairColorAvatar"_STEP
	S T("M",R,"data","facialHairColorAvatar"_STEP)=""               
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Avatar facial hair color?"
	S T("M",R,"props","options",1)="Auburn"
	S T("M",R,"props","options",2)="Black"
	S T("M",R,"props","options",3)="Blonde"
	S T("M",R,"props","options",4)="BlondeGolden"
	S T("M",R,"props","options",5)="Brown"
	S T("M",R,"props","options",6)="BrownDark"
	S T("M",R,"props","options",7)="PastelPink"
	S T("M",R,"props","options",8)="Platinum"
	S T("M",R,"props","options",9)="Red"
	S T("M",R,"props","options",10)="SilverGray"
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZSelect"
	S T("M",R,"model")="facialHairTypeAvatar"_STEP
	S T("M",R,"data","facialHairTypeAvatar"_STEP)=""                
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Avatar facial hair type?"
	S T("M",R,"props","options",1)="Blank"
	S T("M",R,"props","options",2)="BeardMedium"
	S T("M",R,"props","options",3)="BeardLight"
	S T("M",R,"props","options",4)="BeardMagestic"
	S T("M",R,"props","options",5)="MoustacheFancy"
	S T("M",R,"props","options",6)="MoustacheMagnum"
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZSelect"
	S T("M",R,"model")="graphicTypeAvatar"_STEP
	S T("M",R,"data","graphicTypeAvatar"_STEP)=""           
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Avatar graphic type?"
	S T("M",R,"props","options",1)="Bat"
	S T("M",R,"props","options",2)="Cumbia"
	S T("M",R,"props","options",3)="Deer"
	S T("M",R,"props","options",4)="Diamond"
	S T("M",R,"props","options",5)="Hola"
	S T("M",R,"props","options",6)="Pizza"
	S T("M",R,"props","options",7)="Resist"
	S T("M",R,"props","options",8)="Selena"
	S T("M",R,"props","options",9)="Bear"
	S T("M",R,"props","options",10)="SkullOutline"
	S T("M",R,"props","options",11)="Skull"
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZSelect"
	S T("M",R,"model")="hairColorAvatar"_STEP
	S T("M",R,"data","hairColorAvatar"_STEP)=""             
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Avatar hair color?"
	S T("M",R,"props","options",1)="Auburn"
	S T("M",R,"props","options",2)="Black"
	S T("M",R,"props","options",3)="Blonde"
	S T("M",R,"props","options",4)="BlondeGolden"
	S T("M",R,"props","options",5)="Brown"
	S T("M",R,"props","options",6)="BrownDark"
	S T("M",R,"props","options",7)="PastelPink"
	S T("M",R,"props","options",8)="Platinum"
	S T("M",R,"props","options",9)="Red"
	S T("M",R,"props","options",10)="SilverGray"
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZSelect"
	S T("M",R,"model")="mouthTypeAvatar"_STEP
	S T("M",R,"data","mouthTypeAvatar"_STEP)=""             
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Avatar mouth type?"
	S T("M",R,"props","options",1)="Concerned"
	S T("M",R,"props","options",2)="Default"
	S T("M",R,"props","options",3)="Disbelief"
	S T("M",R,"props","options",4)="Eating"
	S T("M",R,"props","options",5)="Grimace"
	S T("M",R,"props","options",6)="Sad"
	S T("M",R,"props","options",7)="ScreamOpen"
	S T("M",R,"props","options",8)="Serious"
	S T("M",R,"props","options",9)="Smile"
	S T("M",R,"props","options",10)="Tongue"
	S T("M",R,"props","options",11)="Twinkle"
	S T("M",R,"props","options",12)="Vomit"
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZSelect"
	S T("M",R,"model")="skinColorAvatar"_STEP
	S T("M",R,"data","skinColorAvatar"_STEP)=""             
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Avatar skin color?"
	S T("M",R,"props","options",1)="Tanned"
	S T("M",R,"props","options",2)="Yellow"
	S T("M",R,"props","options",3)="Pale"
	S T("M",R,"props","options",4)="Light"
	S T("M",R,"props","options",5)="Brown"
	S T("M",R,"props","options",6)="DarkBrown"
	S T("M",R,"props","options",7)="Black"
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZSelect"
	S T("M",R,"model")="topTypeAvatar"_STEP
	S T("M",R,"data","topTypeAvatar"_STEP)=""               
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Avatar top type?"
	S T("M",R,"props","options",1)="NoHair"
	S T("M",R,"props","options",2)="Eyepatch"
	S T("M",R,"props","options",3)="Hat"
	S T("M",R,"props","options",4)="Hijab"
	S T("M",R,"props","options",5)="Turban"
	S T("M",R,"props","options",6)="WinterHat1"
	S T("M",R,"props","options",7)="WinterHat2"
	S T("M",R,"props","options",8)="WinterHat3"
	S T("M",R,"props","options",9)="WinterHat4"
	S T("M",R,"props","options",10)="LongHairBigHair"
	S T("M",R,"props","options",11)="LongHairBob"
	S T("M",R,"props","options",12)="LongHairBun"
	S T("M",R,"props","options",13)="LongHairCurly"
	S T("M",R,"props","options",14)="LongHairCurvy"
	S T("M",R,"props","options",15)="LongHairDreads"
	S T("M",R,"props","options",16)="LongHairFrida"
	S T("M",R,"props","options",17)="LongHairFro"
	S T("M",R,"props","options",18)="LongHairFroBand"
	S T("M",R,"props","options",19)="LongHairNotTooLong"
	S T("M",R,"props","options",20)="LongHairShavedSides"
	S T("M",R,"props","options",21)="LongHairMiaWallace"
	S T("M",R,"props","options",22)="LongHairStraight"
	S T("M",R,"props","options",23)="LongHairStraight2"
	S T("M",R,"props","options",24)="LongHairStraightStrand"
	S T("M",R,"props","options",25)="ShortHairDreads01"
	S T("M",R,"props","options",26)="ShortHairDreads02"
	S T("M",R,"props","options",27)="ShortHairFrizzle"
	S T("M",R,"props","options",28)="ShortHairShaggyMullet"
	S T("M",R,"props","options",29)="ShortHairShortCurly"
	S T("M",R,"props","options",30)="ShortHairShortFlat"
	S T("M",R,"props","options",31)="ShortHairShortRound"
	S T("M",R,"props","options",32)="ShortHairShortWaved"
	S T("M",R,"props","options",33)="ShortHairSides"
	S T("M",R,"props","options",34)="ShortHairTheCaesar"
	S T("M",R,"props","options",35)="ShortHairTheCaesarSidePart"
	;
	I $I(R)
	S T("M",R,"type")="select"
	S T("M",R,"is")="FUZSelect"
	S T("M",R,"model")="topColorAvatar"_STEP
	S T("M",R,"data","topColorAvatar"_STEP)=""              
	S T("M",R,"props","style")="width:350px;"
	S T("M",R,"props","label")="Avatar top color?"
	S T("M",R,"props","options",1)="Black"
	S T("M",R,"props","options",2)="Blue01"
	S T("M",R,"props","options",3)="Blue02"
	S T("M",R,"props","options",4)="Blue03"
	S T("M",R,"props","options",5)="Gray01"
	S T("M",R,"props","options",6)="Gray02"
	S T("M",R,"props","options",7)="Heather"
	S T("M",R,"props","options",8)="PastelBlue"
	S T("M",R,"props","options",9)="PastelGreen"
	S T("M",R,"props","options",10)="PastelOrange"
	S T("M",R,"props","options",11)="PastelRed"
	S T("M",R,"props","options",12)="PastelYellow"
	S T("M",R,"props","options",13)="Pink"
	S T("M",R,"props","options",14)="Red"
	S T("M",R,"props","options",15)="White"
	;
	Q
	;
STEP1
	S O("data","page","actionButtons",1,"type")="primary"
	S O("data","page","actionButtons",1,"onClick")="showPhoneNumberInput"
	S O("data","page","actionButtons",1,"iconName")="add"
	S O("data","page","actionButtons",1,"iconClass")=""
	S O("data","page","actionButtons",1,"text")="Click here to enter phone number"
	S O("data","page","actionButtons",1,"align")="left"
	;
	S O("data","page","animationPath")="animations/14482-welcome-onboard.json"
	S O("data","page","animationLoop")="false"
	S O("data","page","showAnimation")="true"
	;
	S O("data","page","prompt")=$$r^SALON(O("data","page","prompt"),"{salon}",$G(@%G@("SALONPROFILE","DATA",%ACCOUNT,"name")))
	;
	Q
	;
STEP2
	k ^AHM M ^AHM=RES
	n phone s phone=RES("data","phone") 
	S %EMAIL="onlinebooking@hairsalonsystems.com"
	n code I '$$SENDVERIFICATION(phone,.code)       
	S O("data","page","actionButtons",1,"type")="primary"
	S O("data","page","actionButtons",1,"onClick")="showPhoneVerfificationInput"
	S O("data","page","actionButtons",1,"iconName")="code"
	S O("data","page","actionButtons",1,"iconClass")=""
	S O("data","page","actionButtons",1,"text")="Click here to enter verification code"
	S O("data","page","actionButtons",1,"align")="right"
	S O("data","page","animationPath")="animations/18430-welcome-white.json"
	S O("data","page","animationLoop")="false"
	S O("data","page","showAnimation")="true"
	S O("data","page","prompt")=$replace(O("data","page","prompt"),"{phone}",phone)
	Q
	;
STEP3
	k ^AHM M ^AHM=RES
	;n phone s phone=RES("data","phone") 
	;S %EMAIL="onlinebooking@hairsalonsystems.com"
	;n code I '$$SENDVERIFICATION(phone,.code)      
	S O("data","page","actionButtons",1,"type")="primary"
	S O("data","page","actionButtons",1,"onClick")="showPhoneVerfificationInput"
	S O("data","page","actionButtons",1,"iconName")="code"
	S O("data","page","actionButtons",1,"iconClass")=""
	S O("data","page","actionButtons",1,"text")="Click here to enter verification code"
	S O("data","page","actionButtons",1,"align")="right"
	S O("data","page","animationPath")="animations/18430-welcome-white.json"
	S O("data","page","animationLoop")="false"
	S O("data","page","showAnimation")="true"
	;S O("data","page","prompt")=$replace(O("data","page","prompt"),"{phone}",phone)
	Q
	;
SENDVERIFICATION(number,code)
	N M,MD,OM 
	s code=($R(9000)+999)
	D getModel^FUZNEW(.M,.MD,"SMS","",.OM)
	S OM("phone")="+1"_$TR(number,"()- ")
	S OM("message")="Your verification code is "_code
	S @%G@("SMS-VERIFICATION",OM("phone"),"code")=code
	S @%G@("SMS-VERIFICATION",OM("phone"),"expires")=$P($H,",",2)+(60*60)
	D saveModel^FUZNEW(.MD,"SMS",.OM)
	Q $$Send^SMS(.OM)       
	;	
	;
Step1(d,r,s)
	i $tr(d("number"),"()- ")'?10n s @r@("status")="Invalid phone number. Please try again!" q
	n number s number="+1"_$tr(d("number"),"()- ")
	s sms("number")=number
	s sms("invoice")=$tr(##class(%SYSTEM.Util).CreateGUID(),"-") 
	s sms("message")="Your verification code is "_$e(sms("invoice"),1,4)
	i +$$SendText(.sms,salon) D  I 1
	. S @%GLOBAL@("PHONE-VERIFY",+$h,number,"code")=1234 ;$e(sms("invoice"),1,4)
	. s @r@("status")="true" 
	e  s @r@("status")="Unable to send verification code at the moment, please try again later!" q
	q
	;
	;
VerifyPhone(d,r,s)
	n number s number="+1"_$tr(d("number"),"()- ")
	n code s code=d("code")
	i $ZCVT(@%GLOBAL@("PHONE-VERIFY",+$h,number,"code"),"L")=$ZCVT(code,"L") d  I 1
	. s @%GLOBAL@("PHONE-VERIFIED",+$h,number)=""
	. s @r@("status")="true"
	. s newClient="true"
	. n a s a="" f  s a=$o(@%GLOBAL@("CLIENT","DATA",a)) q:a=""  d
	.. i newClient="true",$G(@%GLOBAL@("CLIENT","DATA",a,"Mobile Number"))=("+1 "_d("number")) s newClient="false"
	. s @r@("newClient")=newClient
	e  s @r@("status")="Invalid verification code entered, please try again!"
	q       
	;	
	;
SendText(sms,salon)
	i sms("number")="" q 0
	n httprequest,Tsc,resp
	s httprequest=##class(%Net.HttpRequest).%New()
	s httprequest.SSLConfiguration="SMSClient"
	s httprequest.Https=1
	s httprequest.Server="api.twilio.com"
	s httprequest.Username="ACd4e8541d2ee020c60f50ecbc9b3e655f"
	s httprequest.Password="031fab99e892e2c1b6d224b6d40546bc"
	n outNumber s outNumber=^FUZACCOUNTID(%ACCOUNT,"SMS_PHONE")
	d httprequest.InsertFormData("From",outNumber)
	d httprequest.InsertFormData("To",sms("number"))
	d httprequest.InsertFormData("Body",sms("message"))
	d httprequest.InsertFormData("StatusCallback","http://efuzy.com/statuscallback%5Ear?invoice="_sms("invoice")_"&global="_$ZCVT($G(%GLOBAL),"O","URL")_"&")
	s Tsc=httprequest.Post("/2010-04-01/Accounts/"_"ACd4e8541d2ee020c60f50ecbc9b3e655f"_"/Messages.json/")
	i +Tsc s resp=httprequest.HttpResponse.Data.ReadLine() d
	. I $p($p(resp,"""sid"": """,2),""",")]"" d
	.. S @%GLOBAL@("SMS","SID:INVOICE",$p($p(resp,"""sid"": """,2),""","))=sms("invoice")
	.. S @%GLOBAL@("SMS","INVOICE:STATUS",sms("invoice"))=$p($p(resp,"""status"": """,2),""",")
	;
	q httprequest.HttpResponse
	;       
	;	
	;	
	;	
	;