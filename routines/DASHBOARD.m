	;	
DASHBOARD
	;
	;
	;
	Q
	;
ROUTES
	I $I(H)
	S @T@("header","mainNav",H,"label")="Dashboard"
	S @T@("header","mainNav",H,"to")="/dashboard"
	;
	;
	i $I(P)
	S @T@("pages",P,"path")="/dashboard"
	S @T@("pages",P,"name")="Dashboard"
	S @T@("pages",P,"component")="Dashboard"
	S @T@("pages",P,"requiresAuth")="true"
	S @T@("pages",P,"routine")=""
	S @T@("pages",P,"type")="SALON"
	;	
	Q       
	;	
	;
getSourcesPie(dd,rr,s)
	n r s r="r"
	n d m d=dd("data")
	n dur s dur=$g(d("duration")) 
	i dur="" s dur=30
	i dur="*" s dur=9999
	n clients s clients=0
	;^AR("INVOICE","DATA",32599,"32CC8C2C","Channel")="Offline"
	n R,dh,a,b,count,channel,staff,dailySales s count=0
	;s dh=($zd(+$H-dur,8)-0.1) f  s dh=$o(@%GLOBAL@("INVOICE","DATE",dh)) q:dh=""  d
	. s a="" f  s a=$o(@%GLOBAL@("INVOICE","DATE",dh,a)) q:a=""  d
	.. s ref="" f  s ref=o(@%GLOBAL@("INVOICE","DATE",dh,a,ref)) q:ref=""  d
	... s channel=@%GLOBAL@("INVOICE","DATA",a,ref,"Channel")
	... s staff=@%GLOBAL@("INVOICE","DATA",a,ref,"Staff")
	... ;i '$$ISUSERADMIN(%USER),$$GETSTAFFFROMUSER(%USER)'= staff Q
	... s id=@%GLOBAL@("INVOICE","DATA",a,ref,"Client ID")
	... s amt=@%GLOBAL@("INVOICE","DATA",a,ref,"Total Sales")
	... s staffSales(staff)=$g(staffSales(staff))+amt
	... ;s dailySales("'"_$zd($zdh(dh,8),3)_"'")=$g(dailySales("'"_$zd($zdh(dh,8),3)_"'"))+amt
	... ;s monthlySales("'"_$p($zd($zdh(dh,8),3),"-",1,2)_"'")=$g(monthlySales("'"_$p($zd($zdh(dh,8),3),"-",1,2)_"'"))+amt
	... i '$d(clients(id)) d
	.... s clients=clients+1 
	.... s added=$g(@%GLOBAL@("CLIENT","DATA",id,"Added"))
	.... ;i added]"",+added s added=$zdh(added,3)
	.... i added="" s added=+$h
	.... i added<(+$h-dur) s clients("_EXISTING_")=$g(clients("_EXISTING_"))+1 s staff(staff,"Existing")=$g(staff(staff,"Existing"))+1
	.... i added>=(+$h-dur) s clients("_NEW_")=$g(clients("_NEW_"))+1 s staff(staff,"New")=$g(staff(staff,"New"))+1
	.... s clients(id)=""
	.... i channel="" q
	.... s R(channel)=$g(R(channel))+1
	;	
	m @r@("channel")=R
	s @r@("totalClients")=$g(clients,0)
	s @r@("totalNewClients")=$g(clients("_NEW_"))
	s @r@("totalExistingClients")=$g(clients("_EXISTING_"))
	n a,b s a="",scnt=0 f  s a=$o(staff(a)) q:a=""  d
	. s scnt=scnt+1
	. s @r@("staffSources",scnt,"name")=a
	. m @r@("staffSources",scnt,"data")=staff(a)
	n a,b s a="",scnt=0 f  s a=$o(staffSales(a)) q:a=""  d
	. s scnt=scnt+1
	. s @r@("staffSales",scnt,1)=a
	. s @r@("staffSales",scnt,2)=$j(staffSales(a),0,2)
	; 
	m @r@("dailySales")=dailySales
	m @r@("monthlySales")=monthlySales
	zk r
	m rr("data","data")=r
	;
	q    
	;	
	;	
getStarsLineChart(dd,rr,s)
	n r s r="r"
	n d m d=dd("data")
	n dur s dur=$g(d("duration")) 
	i dur="" s dur=30
	i dur="*" s dur=9999
	q
	n date,inv,DAY,count,star,totstara s count=0,totstars=0
	s date=($zd(+$h-dur,8)-0.1)
	f  s date=$o(@%GLOBAL@("INVOICE","DATE",date)) q:date=""  d
	. s inv="" f  s inv=$o(@%GLOBAL@("INVOICE","DATE",date,inv)) q:inv=""  d
	.. s ref=$o(@%GLOBAL@("INVOICE","DATA",inv,""))
	.. ;i '$$ISUSERADMIN(%USER),$$GETSTAFFFROMUSER(%USER)'= @%GLOBAL@("INVOICE","DATA",inv,ref,"Staff") Q
	.. s star=+$g(@%GLOBAL@("INVOICE:REPLY",inv,1,"MESSAGE"))
	.. i star>5 s star=5
	.. I star D
	... s totstars=totstars+star
	... s $p(DAY(date),":")=$p($g(DAY(date)),":")+star
	... s $p(DAY(date),":",2)=$p($g(DAY(date)),":",2)+1
	... s count=count+1
	n dt s dt="" f  s dt=$o(DAY(dt)) q:dt=""  d
	.;s @r@("Stars","'"_$ZD($zdh(dt,8),3)_"'")=$j(($p(DAY(dt),":")/($p(DAY(dt),":",2) * 5))*5,0,2)
	I count>0 s @r@("TotalStars")=(totstars/(count*5))*5
	E  s @r@("TotalStars")=0
	zk r
	m rr("data","data")=r
	;
	q
	;
getStarsLineChartByStaff(dd,rr,s)
	n r s r="r"
	n d m d=dd("data")
	n dur s dur=$g(d("duration")) 
	i dur="" s dur=30
	i dur="*" s dur=9999
	n date,inv,DAY,count,star,totstara s count=0,totstars=0
	q
	. s date=($zd(+$h-dur,8)-0.1) f  s date=$o(@%GLOBAL@("INVOICE","DATE",date)) q:date=""  d
	. s inv="" f  s inv=$o(@%GLOBAL@("INVOICE","DATE",date,inv)) q:inv=""  d
	.. s star=+$g(@%GLOBAL@("INVOICE:REPLY",inv,1,"MESSAGE"))
	.. i star>5 s star=5
	.. s ref=$o(@%GLOBAL@("INVOICE","DATA",inv,"")) i ref="" q
	.. s staff=@%GLOBAL@("INVOICE","DATA",inv,ref,"Staff") i staff="" q
	.. ;i '$$ISUSERADMIN(%USER),$$GETSTAFFFROMUSER(%USER)'=staff q
	.. I star D
	... s totstars=totstars+star
	... s $p(DAY(staff,date),":")=$p($g(DAY(staff,date)),":")+star
	... s $p(DAY(staff,date),":",2)=$p($g(DAY(staff,date)),":",2)+1
	... s count=count+1
	n st,dt,ct,D s ct=0 s st="" f  s st=$o(DAY(st)) q:st=""  d
	.s dt="" f  s dt=$o(DAY(st,dt)) q:dt=""  d
	.. ;i st'["andra",st'["ason" q 
	.. ;s D("Stars",st,$zdh(dt,8))=$j(($p(DAY(st,dt),":")/($p(DAY(st,dt),":",2) * 5))*5,0,2)
	;
	n I,A,S S A="" F  S A=$O(D("Stars",A)) Q:A=""  D
	. F I=(+$h-dur):1:+$H D
	.. I $D(D("Stars",A,I)) S S(A,"'"_$ZD(I,3)_"'")=D("Stars",A,I) Q
	.. ;I $O(D("Stars",A,I),-1)]"",D("Stars",A,$O(D("Stars",A,I),-1))]"" S S(A,"'"_$ZD(I,3)_"'")=D("Stars",A,$O(D("Stars",A,I),-1)) Q
	.. ;S S(A,"'"_$ZD(I,3)_"'")=0
	;
	n a s a="" f  s a=$o(S(a)) q:a=""  d
	. k OBJ
	. S OBJ("name")=a
	. M OBJ("data")=S(a)
	. m @r@("Stars",$o(@r@("Stars",""),-1)+1)=OBJ
	zk r
	m rr("data","data")=r
	q
	;       
	;