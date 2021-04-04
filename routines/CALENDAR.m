CALENDAR        ;
	;
	;
	;
	Q
	;
ROUTES  
	I $I(H)
	S @T@("header","mainNav",H,"label")="Calendar"
	S @T@("header","mainNav",H,"to")="/Calendar"    
	;
	;
	i $I(P)
	S @T@("pages",P,"path")="/calendar"
	S @T@("pages",P,"name")="Calendar"
	S @T@("pages",P,"childBreadcrump")="calendar"
	S @T@("pages",P,"breadcrump")="calendar"
	S @T@("pages",P,"component")="Calendar"
	S @T@("pages",P,"requiresAuth")="true"
	S @T@("pages",P,"type")="SALON" 
	Q
	;
GetResources(d,O)
	n res,START,END,date,REF,DT,TM,S,s,SAVED
	n CNT,day,SHIFT,STARTTIME,ENDTIME,WORKING,LASTBH
	S res=$NA(O("data","data"))     
	S END=$G(d("data","fetchInfo","end")) I END="" Q
	S START=$G(d("data","fetchInfo","start"))  I START="" Q
	N STAFFTYPE S STAFFTYPE=d("data","staffSelectedForView")
	N SELECTEDSTAFFT M SELECTEDSTAFFT=d("data","viewStaff")
	N SELECTEDSTAFF,A I $D(SELECTEDSTAFFT) S A="" F  S A=$O(SELECTEDSTAFFT(A)) Q:A=""  S SELECTEDSTAFF(SELECTEDSTAFFT(A))=""
	;
	S END=$$ZDH^SALON(END,5)
	S START=$$ZDH^SALON(START,5)
	N DT,TM,REF,STAFF
	S DT=START-0.1
	F  S DT=$O(@%G@("EVENTS","INDEX","date",DT)) Q:DT=""  Q:DT>END  D
	. D 
	.. S REF="" F  S REF=$O(@%G@("EVENTS","INDEX","date",DT,REF)) Q:REF=""  D
	... I DT>(END-1) Q
	... I $G(@%G@("EVENTS","DATA",REF,"status"))="Canceled" Q
	... S STAFF=@%G@("STAFF","DATA",@%G@("EVENTS","DATA",REF,"staff"),"id")
	... I STAFF]"" S STAFF(STAFF,$$ZD^SALON(DT,10))=""
	;
	N DONE
	F date=START:1:END-1 D
	. s day=$$ZD^SALON(date,10)
	. S S="" F  S S=$O(@%G@("STAFF","ORDER",S)) Q:S=""  D
	.. S s=@%G@("STAFF","ORDER",S)
	.. I STAFFTYPE="selected",'$D(SELECTEDSTAFF(s)) Q
	.. I STAFFTYPE="selected",$D(SELECTEDSTAFF(s)) S STAFF(s,$$ZD^SALON(date,10))=""
	.. I STAFFTYPE="all" S STAFF(s,$$ZD^SALON(date,10))=""
	.. ;I $D(DONE(s)) Q
	.. I '$D(STAFF(s)),$D(@%G@("STAFF","SCH","OFF",s,date)) Q
	.. I '$D(STAFF(s)),'$D(@%G@("STAFF","SCH","BASE",s,day)),'$D(@%G@("STAFF","SCH","DAY",s,date)) Q
	.. I $G(DONE(s)) S CNT=DONE(s)
	.. E  S CNT=($O(@res@("resources",""),-1)+1)
	.. I '$D(@%G@("STAFF","DATA",s,"id")) Q
	.. S SAVED=0
	.. S SHIFT="",WORKING=0 F  S SHIFT=$O(@%G@("STAFF","SCH","DAY",s,date,SHIFT)) Q:SHIFT=""  D
	... ;
	... S STARTTIME=$G(@%G@("STAFF","SCH","DAY",s,date,SHIFT,"start"))
	... ;I STARTTIME="" S STARTTIME=$G(@%G@("STAFF","SCH","BASE",s,day,1,"start"))
	... S ENDTIME=$G(@%G@("STAFF","SCH","DAY",s,date,SHIFT,"end"))
	... ;I ENDTIME="" S ENDTIME=$G(@%G@("STAFF","SCH","BASE",s,day,1,"end"))
	... ;I $G(@%G@("STAFF","SCH","BASE",s,day,2,"end"))]"" S ENDTIME=@%G@("STAFF","SCH","BASE",s,day,1,"end")
	... ;I $G(@%G@("STAFF","SCH","DAY",s,date,2,"end"))]"" S ENDTIME=@%G@("STAFF","SCH","DAY",s,date,2,"end")
	... I STARTTIME]"" S STARTTIME=$$ZT^SALON(STARTTIME,2)
	... I ENDTIME]"" S ENDTIME=$$ZT^SALON(ENDTIME,2)
	... I STARTTIME]"",ENDTIME]"" S DONE(s)=CNT,SAVED=1 D  i 1
	.... S LASTBH=$O(@res@("resources",CNT,"businessHours",""),-1)+1
	.... S @res@("resources",CNT,"businessHours",LASTBH,"startTime")=STARTTIME
	.... S @res@("resources",CNT,"businessHours",LASTBH,"endTime")=ENDTIME
	.... S LAST=$O(@res@("resources",CNT,"businessHours",LASTBH,"daysOfWeek",""),-1)+1
	.... S @res@("resources",CNT,"businessHours",LASTBH,"daysOfWeek",LAST)=day
	.... S WORKING=1
	.... S @res@("resources-list",@%G@("STAFF","DATA",s,"id"),LASTBH,"start")=$G(@%G@("STAFF","SCH","DAY",s,date,SHIFT,"start"))
	.... S @res@("resources-list",@%G@("STAFF","DATA",s,"id"),LASTBH,"end")=$G(@%G@("STAFF","SCH","DAY",s,date,SHIFT,"end"))
	.... D SETRES
	.. I 'WORKING D
	... I $D(STAFF(s,day)),'$D(@%G@("STAFF","SCH","OFF",s,date)) S DONE(s)=CNT,SAVED=1 D
	.... S LASTBH=$O(@res@("resources",CNT,"businessHours",""),-1)+1
	.... S @res@("resources",CNT,"businessHours",LASTBH,"startTime")="00:00"
	.... S @res@("resources",CNT,"businessHours",LASTBH,"endTime")="00:00"
	.... S LAST=$O(@res@("resources",CNT,"businessHours",LASTBH,"daysOfWeek",""),-1)+1
	.... S @res@("resources",CNT,"businessHours",LASTBH,"daysOfWeek",LAST)=day
	.... D SETRES
	... E  I $D(STAFF(s,day)),$D(@%G@("STAFF","SCH","OFF",s,date)),SAVED=1 S DONE(s)=CNT D
	.... S LASTBH=$O(@res@("resources",CNT,"businessHours",""),-1)+1
	.... S @res@("resources",CNT,"businessHours",LASTBH,"startTime")="00:00"
	.... S @res@("resources",CNT,"businessHours",LASTBH,"endTime")="00:00"
	.... S LAST=$O(@res@("resources",CNT,"businessHours",LASTBH,"daysOfWeek",""),-1)+1
	.... S @res@("resources",CNT,"businessHours",LASTBH,"daysOfWeek",LAST)=day
	.... D SETRES
	I '$D(@res@("resources")) D
	. S CNT=1
	. S @res@("resources",CNT,"id")="0"
	. S @res@("resources",CNT,"title")=""
	. S @res@("resources",CNT,"businessHours","startTime")="00:00"
	. S @res@("resources",CNT,"businessHours","endTime")="00:00"
	. S @res@("resources",CNT,"order")=1
	q
	;
SETRES
	S @res@("resources",CNT,"id")=@%G@("STAFF","DATA",s,"id")
	S @res@("resources",CNT,"title")=@%G@("STAFF","DATA",s,"name")
	S @res@("resources",CNT,"order")=S
	m @res@("resources",CNT,"image")=@%G@("STAFF","DATA",s,"image")
	s @res@("resources",CNT,"staffColor")=@%G@("STAFF","DATA",s,"gradient1color")
	s @res@("resources",CNT,"textColor")=@%G@("STAFF","DATA",s,"fontColor")
	Q
	;
GetEvents(d,O)
	N START,END,res,PRINT
	S res=$NA(O("data","data"))
	S START=d("data","start")
	S END=d("data","end")
	N STAFFTYPE S STAFFTYPE=d("data","staffSelectedForView")
	N SELECTEDSTAFFT M SELECTEDSTAFFT=d("data","viewStaff")
	N SELECTEDSTAFF,A 
	I $D(SELECTEDSTAFFT) S A="" F  S A=$O(SELECTEDSTAFFT(A)) Q:A=""  S SELECTEDSTAFF(SELECTEDSTAFFT(A))=""
	S END=$$ZDH^SALON(END,5)
	S START=$$ZDH^SALON(START,5)
	S PRINT=($G(d("data","print"))="true")
	N DT,TM,REF
	S DT=START-0.1
	F  S DT=$O(@%G@("EVENTS","INDEX","date",DT)) Q:DT=""  Q:DT>END  D
	. D 
	.. S REF="" F  S REF=$O(@%G@("EVENTS","INDEX","date",DT,REF)) Q:REF=""  D
	... ;
	... I DT>(END-1) Q
	... S TM=$$ZTH^SALON(@%G@("EVENTS","DATA",REF,"time"))
	... I $G(@%G@("EVENTS","DATA",REF,"status"))="canceled" Q
	... I STAFFTYPE="selected",'$D(SELECTEDSTAFF(@%G@("EVENTS","DATA",REF,"staff"))) Q
	... S CNT=$O(@res@("events",""),-1)+1
	... S @res@("events",CNT,"id")=REF
	... S @res@("events",CNT,"title")=@%G@("CLIENTS","DATA",@%G@("EVENTS","DATA",REF,"client"),"name")_" - " ;_@%G@("SERVICES","DATA",REF,"Service")
	... S @res@("events",CNT,"extendedProps","name")=@%G@("CLIENTS","DATA",@%G@("EVENTS","DATA",REF,"client"),"name")
	... S @res@("events",CNT,"start")=$$ZDT^SALON(DT_","_TM,3,5)
	... S @res@("events",CNT,"end")=$$ZDT^SALON((DT_","_(TM+(@%G@("EVENTS","DATA",REF,"duration")*60))),3,5)
	... S @res@("events",CNT,"resourceId")=@%G@("EVENTS","DATA",REF,"staff")
	... ;
	... S @res@("events",CNT,"editable")="true"
	... S @res@("events",CNT,"droppable")="true"
	... S @res@("events",CNT,"resourceEditable")="true"
	... S @res@("events",CNT,"extendedProps","start")=$$ZT^SALON(TM,4)
	... S @res@("events",CNT,"extendedProps","end")=$$ZDT^SALON((DT_","_(TM+(@%G@("EVENTS","DATA",REF,"duration")*60))),3,5)
	... S @res@("events",CNT,"extendedProps","service")=@%G@("EVENTS","DATA",REF,"service")
	... S @res@("events",CNT,"extendedProps","notesIcon")="false"
	... I $G(@%G@("EVENTS","DATA",REF,"notes"))]"" S @res@("events",CNT,"extendedProps","notesIcon")="true"
	... S @res@("events",CNT,"extendedProps","requestedIcon")="false"
	... I $G(@%G@("EVENTS","DATA",REF,"requested"))="true" S @res@("events",CNT,"extendedProps","requestedIcon")="true"
	... S @res@("events",CNT,"extendedProps","onlineBookingIcon")="false"
	... I $G(@%G@("EVENTS","DATA",REF,"onlinebooking"))="true" S @res@("events",CNT,"extendedProps","onlineBookingIcon")="true"
	... s @res@("events",CNT,"extendedProps","notes")=$G(@%G@("EVENTS","DATA",REF,"notes"))
	... s d("apptID")=REF d getAppt(.d,$na(@res@("events",CNT,"extendedProps"))) D
	.... S @res@("events",CNT,"textColor")=@%G@("STAFF","DATA",@%G@("EVENTS","DATA",REF,"staff"),"fontColor")
	.... i @%G@("EVENTS","DATA",REF,"status")="completed" ; S @res@("events",CNT,"classNames",1)="bg-FUZ-light-grey"
	.... i @%G@("EVENTS","DATA",REF,"status")="canceled" ; S @res@("events",CNT,"classNames",1)="bg-ns" 
	... S @res@("events",CNT,"extendedProps","status")=@%G@("EVENTS","DATA",REF,"status")
	... S @res@("events",CNT,"extendedProps","statusColor1")=@%G@("STATUSCUSTOMIZATION","DATA",@%G@("EVENTS","DATA",REF,"status"),"gradient1color")
	... S @res@("events",CNT,"extendedProps","statusColor2")=@%G@("STATUSCUSTOMIZATION","DATA",@%G@("EVENTS","DATA",REF,"status"),"gradient2color")
	... S @res@("events",CNT,"extendedProps","staffColor1")=@%G@("STAFF","DATA",@%G@("EVENTS","DATA",REF,"staff"),"gradient1color")
	... S @res@("events",CNT,"extendedProps","staffColor2")=@%G@("STAFF","DATA",@%G@("EVENTS","DATA",REF,"staff"),"gradient2color")
	... S @res@("events",CNT,"extendedProps","time")=$tr($$ZT^SALON(TM,4)_" - "_$$ZT^SALON((TM+(@%G@("EVENTS","DATA",REF,"duration")*60)),4),"APM")
	... S @res@("events",CNT,"extendedProps","textColor")=@%G@("STAFF","DATA",@%G@("EVENTS","DATA",REF,"staff"),"fontColor")
	... S @res@("events",CNT,"display")="auto"
	... S @res@("events",CNT,"overlap")="true"
	... S @res@("events",CNT,"extendedProps","print")=$s(PRINT:"true",1:"false")
	... I PRINT S (@res@("events",CNT,"extendedProps","textColor"),@res@("events",CNT,"textColor"))="black"
	S DT=START-0.1
	F  S DT=$O(@%G@("EVENTS","BLOCKED-SLOTS",DT)) Q:DT=""  Q:DT>END  D
	. S TM="" F  S TM=$O(@%G@("EVENTS","BLOCKED-SLOTS",DT,TM)) Q:TM=""  D
	.. S REF="" F  S REF=$O(@%G@("EVENTS","BLOCKED-SLOTS",DT,TM,REF)) Q:REF=""  D
	... I STAFFTYPE="selected",'$D(SELECTEDSTAFF(@%G@("EVENTS","BLOCKED-SLOTS",DT,TM,REF,"staff"))) Q
	... S CNT=$O(@res@("events",""),-1)+1
	... S @res@("events",CNT,"id")=REF
	... S @res@("events",CNT,"display")="background"
	... S @res@("events",CNT,"backgroundColor")=@%G@("EVENTS","BLOCKED-SLOTS",DT,TM,REF,"color")
	... S @res@("events",CNT,"textColor")=@%G@("EVENTS","BLOCKED-SLOTS",DT,TM,REF,"fontColor")
	... S @res@("events",CNT,"borderColor")=@%G@("EVENTS","BLOCKED-SLOTS",DT,TM,REF,"color")
	... S @res@("events",CNT,"title")=@%G@("EVENTS","BLOCKED-SLOTS",DT,TM,REF,"title")
	... S @res@("events",CNT,"start")=$$ZDT^SALON(DT_","_TM,3,5)
	... S @res@("events",CNT,"end")=$$ZDT^SALON((DT_","_(TM+(@%G@("EVENTS","BLOCKED-SLOTS",DT,TM,REF,"duration")))),3,5)
	... S @res@("events",CNT,"resourceId")=@%G@("EVENTS","BLOCKED-SLOTS",DT,TM,REF,"staff")
	... S @res@("events",CNT,"overlap")="true"
	... S @res@("events",CNT,"resourceEditable")="false"
	... S @res@("events",CNT,"durationEditable")="false"
	... S @res@("events",CNT,"startEditable")="false"
	... S @res@("events",CNT,"editable")="false"
	... S @res@("events",CNT,"extendedProps","time")=$tr($$ZT^SALON(TM,4)_" - "_$$ZT^SALON(((TM+(@%G@("EVENTS","BLOCKED-SLOTS",DT,TM,REF,"duration")))),4),"APM")
	... S @res@("events",CNT,"classNames",1)="appBlockCard"
	... S @res@("events",CNT,"textColor")=@%G@("EVENTS","BLOCKED-SLOTS",DT,TM,REF,"fontColor")
	... S @res@("events",CNT,"extendedProps","textColor")=@%G@("EVENTS","BLOCKED-SLOTS",DT,TM,REF,"fontColor")
	... S @res@("events",CNT,"extendedProps","print")=$s(PRINT:"true",1:"false")
	... I PRINT D 
	.... S @res@("events",CNT,"textColor")="black"
	.... S @res@("events",CNT,"extendedProps","textColor")="black"
	K ^AHM
	M ^AHM=@res
	Q
	;
getAppt(d,r,s)
	N ID S ID=$G(d("apptID")) I ID="" s @r@("status")="false" Q
	K APPT
	i '$d(@%G@("EVENTS","DATA",ID)) s @r@("status")="false" q
	M APPT=@%G@("EVENTS","DATA",ID)
	s @r@("name")=@%G@("CLIENTS","DATA",@%G@("EVENTS","DATA",ID,"client"),"name")
	s @r@("booked")=APPT("created")
	s @r@("service")=@%G@("SERVICES","DATA",APPT("service"),"name")_" - "_@%G@("SERVICES","DATA",APPT("service"),"serviceOption"_APPT("serviceoption")_"name")
	s @r@("price")=$g(APPT("price"))
	s @r@("time")=APPT("time")
	s @r@("date")=APPT("date")
	s @r@("staff")=APPT("staff")
	;
	s @r@("day")=$$ZD^SALON($$ZDH^SALON(APPT("date")),12)
	s @r@("status")="true"
	s @r@("notes")=APPT("notes")
	s @r@("notesIcon")="false"
	s @r@("requestedIcon")="true"
	s @r@("onlineBookingIcon")="true"
	s @r@("newClient")="true"
	i $G(APPT("notes"))]"" D
	. S @r@("notesIcon")="true"
	. S @r@("notes")=APPT("notes")
	i $G(APPT("requested"))="true" s @r@("requestedIcon")="true"
	i $G(APPT("onlinebooking"))="true" s @r@("onlineBookingIcon")="true" 
	q
	;