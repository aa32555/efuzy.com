FEEDBACK        
	;
	;
	;
	Q
ROUTES
	I $I(H)
	S @T@("header","mainNav",H,"label")="Feedback"
	S @T@("header","mainNav",H,"to")="/feedback"
	;
	;	
	i $I(P)
	S @T@("pages",P,"path")="/feedback"
	S @T@("pages",P,"name")="Feedback"
	S @T@("pages",P,"component")="Feedback"
	S @T@("pages",P,"requiresAuth")="true"
	S @T@("pages",P,"routine")=""
	S @T@("pages",P,"type")="SALON"
	;
	Q       
	;	
	;
getStats(dd,rr,s)
	n r s r="r"
	n d m d=dd("data")	
	s counter=$i(counter)
	s @r@("latestDate")=$ZD($H)
	d 
	. s @r@("list",counter,"name")="Ahmed A"
	. s @r@("list",counter,"staff")="Solimar"
	. s @r@("list",counter,"time")="11:49AM"
	. s paid="100.00:Credit Card"
	. s @r@("list",counter,"rejected")="true"
	. s @r@("list",counter,"paid")=$p(paid,":")
	. s @r@("list",counter,"method")=$p(paid,":",2)
	. s @r@("list",counter,"id")=1
	. s @r@("list",counter,"invoiceId")=1
	. s @r@("list",counter,"status")="delivered"
	. s @r@("list",counter,"reply",1,"MESSAGE")="Thank you for an awesome service"
	. s @r@("list",counter,"reply",1,"TIME")=$ZD($H)
	. zk @r@("list",counter,"reply")
	. s @r@("list",counter,"stars")=5
	. s @r@("list",counter,"donotsend")=0
	. s @r@("list",counter,"item",1)="Long Haircut"
	. s @r@("donotSend","ID-"_1)="false"
	zk r
	m rr("data","data")=r
	q
	;			
	;				
	;					
	;						
	;							
	;								
	;									
	;										
	;											
	;												
	;														
getStats2(dd,rr,s)
	n r s r="r"
	n d m d=dd("data")
	n dt,dh
	i $g(d("date"))]"" s dh=$zd($zdh(d("date"),5),8)
	i dh]"" s dt=$zd($zdh(dh,8),12)_", "_$zd($zdh(dh,8),7)
	i dh="" zt 1
	s @r@("latestDate")=dt
	i dh="" q 
	n a,b s a="" f  s a=$o(@%GLOBAL@("INVOICE","DATE",dh,a)) q:a=""  d
	. s ref  = $o(@%GLOBAL@("INVOICE","DATE",dh,a,"")) i ref="" q
	. s name = @%GLOBAL@("INVOICE","DATA",a,ref,"Client Name")
	. s staff = @%GLOBAL@("INVOICE","DATA",a,ref,"Staff")
	. s time  = $ZT($P($ZDTH(@%GLOBAL@("INVOICE","DATA",a,ref,"Invoice Date"),3,1),",",2),4)
	. s counter = $o(@r@("list",""),-1)+1
	. s @r@("list",counter,"name")=name
	. s @r@("list",counter,"staff")=staff
	. s @r@("list",counter,"time")=time
	. s paid=$$getPayment(a)
	. ;
	. I $g(@%GLOBAL@("REJECTED",a))]"" s @r@("list",counter,"rejected")=@%GLOBAL@("REJECTED",a)
	. s @r@("list",counter,"paid")=$p(paid,":")
	. s @r@("list",counter,"method")=$p(paid,":",2)
	. s @r@("list",counter,"id")=@%GLOBAL@("INVOICE","DATA",a,ref,"Client ID")
	. s @r@("list",counter,"invoiceId")=a
	. s @r@("list",counter,"status")=$g(@%GLOBAL@("SMS","INVOICE:STATUS",a),"Not Sent")
	. m @r@("list",counter,"reply")=@%GLOBAL@("INVOICE:REPLY",a)
	. zk @r@("list",counter,"reply")
	. s @r@("list",counter,"stars")=+$g(@%GLOBAL@("INVOICE:REPLY",a,1,"MESSAGE"))
	. s @r@("list",counter,"donotsend")=+$g(@%GLOBAL@("INVOICE:REPLY",a))
	. s @r@("donotSend","ID-"_@%GLOBAL@("INVOICE","DATA",a,ref,"Client ID"))="true"
	. i $g(@%GLOBAL@("doNotSend","ID-"_@%GLOBAL@("INVOICE","DATA",a,ref,"Client ID")))]"" d 
	.. s @r@("donotSend","ID-"_@%GLOBAL@("INVOICE","DATA",a,ref,"Client ID"))=$g(@%GLOBAL@("doNotSend","ID-"_@%GLOBAL@("INVOICE","DATA",a,ref,"Client ID")))
	. s item="" f  s item=$o(@%GLOBAL@("INVOICE","DATE",dh,a,item)) q:item=""  d
	.. s @r@("list",counter,"item",$o(@r@("list",counter,"item",""),-1)+1)=$g(@%GLOBAL@("INVOICE","DATA",a,item,"Item"))
	zk r
	m rr("data","data")=r
	q
	;
getPayment(INVOICE)
	I $G(INVOICE)="" Q ""
	I '$D(@%GLOBAL@("PAYMENT","DATA",INVOICE)) Q ""
	n type,amt s type="" s amt=0
	n a s a="" f  s a=$o(@%GLOBAL@("PAYMENT","DATA",INVOICE,a)) q:a=""  d
	. s amt=amt+$g(@%GLOBAL@("PAYMENT","DATA",INVOICE,a,"Amount"))
	. s type($g(@%GLOBAL@("PAYMENT","DATA",INVOICE,a,"Method")))=""
	n a s a="" f  s a=$o(type(a)) q:a=""  s type=$g(type)_","_a
	q $j(amt,0,2)_":"_$e(type,2,$l(type))
	;
	;
	;