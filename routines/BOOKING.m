BOOKING ;
	;
	;
	;
	Q
	;
ROUTES
	I $I(H) K N 
	S @T@("header","mainNav",H,"label")="Booking"
	I $I(N)
	S @T@("header","mainNav",H,"children",N,"label")="Discounts"
	S @T@("header","mainNav",H,"children",N,"to")="/booking/discounts"
	I $I(N)
	S @T@("header","mainNav",H,"children",N,"label")="Online Booking"
	S @T@("header","mainNav",H,"children",N,"to")="/onlinebooking"
	;
	;I $I(P)
	;S @T@("pages",P,"path")="/onlinebooking"
	;S @T@("pages",P,"name")="Online Booking"
	;S @T@("pages",P,"component")="OnlineBooking"
	;S @T@("pages",P,"requiresAuth")="true"
	;S @T@("pages",P,"routine")=""
	;S @T@("pages",P,"type")="SALON"
	;
	I $I(P)
	S @T@("pages",P,"path")="/booking/discounts"
	S @T@("pages",P,"name")="Booking Discounts"
	S @T@("pages",P,"component")="BookingDiscounts"
	S @T@("pages",P,"requiresAuth")="true"
	S @T@("pages",P,"routine")=""
	S @T@("pages",P,"type")="SALON"
	Q
	;
bookAppointment(D,O)
	S OR=(D("data","override")="true")
	S ERROR=0 D verifyAppointment   
	S O("data","message")="GRANDTOTAL MATCH!"
	;
	N APP M APP=D("data","appointment")
	N APPS,WARN S WARN=0 D saveAppointment(.APP,"",.ERROR,.WARN,OR)
	I ERROR S O("data","status")="error",O("data","message")="Appointment did not save, an error occured!"
	I WARN,'ERROR S O("data","status")="warn",O("data","message")=WARN("MESSAGE") Q
	I 'WARN,'ERROR S O("data","status")="booked" D
	. S NDATE=APP("date")
	. S NTIME=APP("time")
	. S NSTAFF=@%G@("STAFF","DATA",APP("services",1,"staff","id"),"name")
	. D Notify^FCM("Appointment booked by staff: "_NDATE_" "_NTIME_" with "_NSTAFF,"URL","Appointment Notifications")
	Q
	;
saveAppointment(IN,ID,ERROR,WARN,OR)
	N M,MD
	I ID="" N PID S PID=IN("client","id")_"-"_$E($TR($$GUID^SALON(),"-"),1,4)
	I ID]"" N PID S PID=$P(ID,"-",1,2)
	N Start 
	S Start=$$ZTH^SALON(IN("time"))
	N end,length,day,staff,ss,se,holder,st
	S length=0
	N S,APP S S="" F  S S=$O(IN("services",S)) Q:S=""  D
	. K APP(S),day,staff,ss,se,holder,st
	. S Start=Start+length
	. S end=Start+(IN("services",S,"duration")*60)
	. S APP(S,"active")="true"
	. S APP(S,"client")=IN("client","id")
	. S APP(S,"location")=IN("location","id")
	. S APP(S,"staff")=IN("services",S,"staff","id")
	. S APP(S,"date")=IN("date")
	. S APP(S,"time")=$$ZT^SALON(Start,4)
	. S APP(S,"notes")=IN("notes")
	. S APP(S,"discount1code")=$G(IN("discount","code"))
	. S APP(S,"discount1type")=$G(IN("discount","type"))
	. S APP(S,"discount1value")=$G(IN("discount","value"))
	. S APP(S,"discount2id")=$G(IN("services",S,"discount","id"))
	. S APP(S,"discount2type")=$G(IN("services",S,"discount","type"))
	. S APP(S,"discount2value")=$G(IN("services",S,"discount","value"))
	. S APP(S,"duration")=IN("services",S,"duration")
	. S APP(S,"processing")=IN("services",S,"processing")
	. S APP(S,"requested")=IN("services",S,"requested")
	. S APP(S,"service")=IN("services",S,"service","id")
	. S APP(S,"serviceoption")=IN("services",S,"option","id")
	. S APP(S,"parentid")=PID
	. I ID="" S APP(S,"id")=PID_"-"_$E($TR($$GUID^SALON(),"-"),1,4)
	. S length=length+(IN("services",S,"duration")+IN("services",S,"processing")*60)
	. S staff=APP(S,"staff")
	. S day=$$ZDH^SALON(APP(S,"date"))
	. S ss=Start
	. S se=end
	. s holder=1
	. K st s st=$$isStaffWorking^STAFF(staff,day_","_ss,(day+1)_","_se,ss,se,.holder)
	. I staff>0,'st,'$G(OR) S WARN=1 S WARN("MESSAGE")=$S($G(WARN("MESSAGE"))="":"",1:WARN("MESSAGE")_", ")_@%G@("STAFF","DATA",staff,"name")_" is not available"
	I 'ERROR,'$G(WARN) N A S A="" F  S A=$O(APP(A)) Q:A=""  K MD,OM  D getModel^FUZNEW(.M,.MD,"EVENTS","",.OM) M OM=APP(A) D saveModel^FUZNEW(.MD,"EVENTS",.OM)
	Q
	;
getSalonLogo(D,O)
	M O("data","logo")=@%G@("SALONPROFILE","DATA",%ACCOUNT,"image")
	Q
	;
	;
verifyAppointment
	N APP M APP=D("data","appointment")
	N TABLE M TABLE=D("data","table")
	;
	I $G(APP("location","id"))=""  D Error^FUZ("Location is required!") S ERROR=1  Q
	I $G(APP("date"))=""  D Error^FUZ("Date is required!") S ERROR=1  Q
	I $G(APP("time"))=""  D Error^FUZ("Time is required!") S ERROR=1  Q
	I $G(APP("client","id"))=""  D Error^FUZ("Client is required!") S ERROR=1  Q
	;
	I '$D(@%G@("LOCATIONS","DATA",APP("location","id"))) D Error^FUZ("Valid location is required!") S ERROR=1  Q
	I '$D(@%G@("CLIENTS","DATA",APP("client","id"))) D Error^FUZ("Valid client is required!") S ERROR=1  Q 
	I $$ZT^SALON($$ZTH^SALON(APP("time")),4)'=APP("time")  D Error^FUZ("Valid time is required!=>"_APP("time")) S ERROR=1  Q
	I $$ZD^SALON($$ZDH^SALON(APP("date")))'=APP("date") D Error^FUZ("Valid date is required!") S ERROR=1  Q
	;
	S SERVICESVALID=1
	N SERVICE S SERVICE="" F  S SERVICE=$O(APP("services",SERVICE)) Q:SERVICE=""  Q:ERROR  D
	. M S=APP("services",SERVICE)
	. I $G(S("staff","id"))="" D Error^FUZ("Stylist is required!") S SERVICESVALID=0 S ERROR=1 Q
	. I $G(S("service","id"))="" D Error^FUZ("Service is required!") S SERVICESVALID=0  S ERROR=1 Q
	. I $G(S("option","id"))="" D Error^FUZ("Service option is required!") S SERVICESVALID=0  S ERROR=1 Q
	. ;
	. I '$D(@%G@("STAFF","DATA",S("staff","id"))) D Error^FUZ("Valid stylist is required!")  S SERVICESVALID=0 S ERROR=1  Q 
	. I '$D(@%G@("SERVICES","DATA",S("service","id"))) D Error^FUZ("Valid service is required!") S SERVICESVALID=0 S ERROR=1  Q 
	. I '$D(@%G@("SERVICES","DATA",S("service","id"),"serviceOption"_S("option","id")_"name")) D Error^FUZ("Valid service option is required!") S SERVICESVALID=0 S ERROR=1  Q
	. I $G(S("service","id"))<=0 D Error^FUZ("Service duration is required!") S SERVICESVALID=0 S ERROR=1  Q
	. ;
	I ERROR Q
	N GRANDTOTAL,GRANDTAX,GRANDDISCOUNT,GRANDPRICE,GRANDSUBTOTAL
	S (GRANDTOTAL,GRANDTAX,GRANDDISCOUNT,GRANDPRICE,GRANDSUBTOTAL)=0
	N TAX,PRICE,DISCOUNT,TAXEDAMOUNT,TOTALPRICE,SUBTOTAL
	N A S A="" F  S A=$O(APP("services",A)) Q:A=""  D
	. S (TAX,PRICE,DISCOUNT,TAXEDAMOUNT,TOTALPRICE,SUBTOTAL)=0
	. S TAX=$G(@%G@("LOCATIONS","DATA",APP("location","id"),"tax"))
	. S PRICE=APP("services",A,"option","price")
	. S GRANDPRICE=GRANDPRICE+PRICE
	. S DISCOUNT=((PRICE-APP("services",A,"option","discountedPrice")+$$GETDISCOUNT(PRICE,$NA(APP("services",A,"discount")))+$$GETDISCOUNT(PRICE,$NA(APP("discount")))))
	. S GRANDDISCOUNT=GRANDDISCOUNT+DISCOUNT
	. S TAXEDAMOUNT=(((PRICE-DISCOUNT)*TAX)/100) I TAXEDAMOUNT<0 S TAXEDAMOUNT=0
	. S GRANDTAX=GRANDTAX+TAXEDAMOUNT
	. S TOTALPRICE=(PRICE-DISCOUNT+TAXEDAMOUNT) I TOTALPRICE<0  S TOTALPRICE=0 
	. S GRANDTOTAL=GRANDTOTAL+TOTALPRICE
	. S SUBTOTAL=PRICE-DISCOUNT I SUBTOTAL<0 S SUBTOTAL=0
	. S GRANDSUBTOTAL=GRANDSUBTOTAL+SUBTOTAL
	;
	I $J(GRANDTOTAL,0,2)'=$J(TABLE("grandTotal"),0,2)  D Error^FUZ("Totals do not match!") S ERROR=1  Q
	;
	;
	Q       
GETDISCOUNT(v,r)
	I '$D(@r@("type")) q 0
	n id,type,val
	s type=@r@("type")
	s val=@r@("value")
	i type="percent" q ((v*val)/100)        
	i type="off" q val
	q 0
	;
moveEvent(d,r)
	s id=d("data","id")
	N M,MD,OM 
	D getModel^FUZNEW(.M,.MD,"EVENTS",id,.OM)
	;n date s date=$p($$zdth^SALON(d("data","start"),7,3),",")
	;n time s time=$p($$zdth^SALON(d("data","start"),7,3),",",2)
	S %DS=$P(d("data","start")," ",1,3)
	D INT^%DATE
	s date=%DN
	S %TS=$P(d("data","start")," ",4,5)
	D INT^%TI
	S time=%TN
	;	
	n staff s staff=d("data","staff")
	i staff="" s staff=OM("staff")
	s OM("staff")=staff
	s OM("date")=$$ZD^SALON(date)
	s OM("time")=$$ZT^SALON(time,4)
	N NAME,DATE,TIME
	S NAME=$$getApptName(id)
	S ODATE=@%G@("EVENTS","DATA",id,"date")
	S OTIME=@%G@("EVENTS","DATA",id,"time")
	S OSTAFF=@%G@("STAFF","DATA",@%G@("EVENTS","DATA",id,"staff"),"name")
	D saveModel^FUZNEW(.MD,"EVENTS",.OM)
	S NDATE=@%G@("EVENTS","DATA",id,"date")
	S NTIME=@%G@("EVENTS","DATA",id,"time")
	S NSTAFF=@%G@("STAFF","DATA",@%G@("EVENTS","DATA",id,"staff"),"name")
	s r("status")="moved"
	D Notify^FCM("Appointment moved: "_NAME_" from "_ODATE_" "_OTIME_" with "_OSTAFF_" to "_NDATE_" "_NTIME_" with "_NSTAFF,"URL","Appointment Notifications")
	q
	;
resizeEvent(d,r,s)
	s id=d("data","id")
	s len=((d("data","length")/1000)/60)
	N M,MD,OM 
	D getModel^FUZNEW(.M,.MD,"EVENTS",id,.OM)
	N ODUR,NDUR
	S ODUR=OM("duration")
	s OM("duration")=OM("duration")+len
	D saveModel^FUZNEW(.MD,"EVENTS",.OM)
	s r("status")="resized"
	S NDUR=OM("duration")
	N NAME,DATE,TIME
	S NAME=$$getApptName(id)
	S DATE=@%G@("EVENTS","DATA",id,"date")
	S TIME=@%G@("EVENTS","DATA",id,"time")
	D Notify^FCM("Appointment duration changed for "_NAME_" on "_DATE_" "_TIME_"  from: "_ODUR_" mins, to: "_NDUR_" mins","URL","Appointment Notifications")
	q
	;
getApptName(id)
	Q $G(@%G@("CLIENTS","DATA",@%G@("EVENTS","DATA",id,"client"),"name"))
	;
	;