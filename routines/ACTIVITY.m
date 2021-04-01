ACTIVITY
        ;
        ;
        ;
        Q
        ;
ROUTES
        I $I(H)
        S @T@("header","mainNav",H,"label")="Activity"
        S @T@("header","mainNav",H,"to")="/activity"
        ;
        ;
        i $I(P)
        S @T@("pages",P,"path")="/activity"
        S @T@("pages",P,"name")="Activity"
        S @T@("pages",P,"component")="Activity"
        S @T@("pages",P,"requiresAuth")="true"
        S @T@("pages",P,"routine")=""
        S @T@("pages",P,"type")="SALON"
        ;
        Q
 
getStatsLog(dd,rr,s)
        n r s r="r"
        n d m d=dd("data")
        n last s last=$g(d("last"))
        s dir=-1
        n a,b,c,d
        s c=$p(last,","),d=$p(last,",",2)
        s @r@("last")=c_","_d
        s count=0
        I '$D(@%GLOBAL@("REPLIES:TS")) s @r@("last")=c_","_d q 
        i $QS($Q(@$NA(@%GLOBAL@("REPLIES:TS",c,d)),-1),1)'="REPLIES:TS" s @r@("last")=c_","_d q
        ;
        N A,a S A=$NA(@%GLOBAL@("REPLIES:TS",c,d)) F  S A=$Q(@A,dir) Q:$QS(A,1)'="REPLIES:TS"  q:count>10  D
        . s count=count+1
        . s a=$qs(A,4) i a="" q 
        . s c=$qs(A,2)
        . s d=$qs(A,3)
        . s ref  = $o(@%GLOBAL@("INVOICE","DATA",a,"")) i ref="" q
        . s name = @%GLOBAL@("INVOICE","DATA",a,ref,"Client Name")
        . s staff = @%GLOBAL@("INVOICE","DATA",a,ref,"Staff")
        . s time  = $ZT($P($ZDTH(@%GLOBAL@("INVOICE","DATA",a,ref,"Invoice Date"),3,1),",",2),4)
        . s @r@("last")=c_","_d
        . s counter = $o(@r@("list",""),-1)+1
        . ;
        . s @r@("list",counter,"name")=name
        . s @r@("list",counter,"staff")=staff
        . s paid=$$getPayment^FEEDBACK(a)
        . s @r@("list",counter,"paid")=$p(paid,":")
        . s @r@("list",counter,"method")=$p(paid,":",2)
        . s TZc = $SYSTEM.Util.UTCtoLocalWithZTIMEZONE(c_","_d)
        . s @r@("list",counter,"rcvd")=$zd(TZc,12)_", "_$zd(TZc,7)_" "_$ZT($p(TZc,",",2),4)
        . s @r@("list",counter,"time")=$zd($ZDTH(@%GLOBAL@("INVOICE","DATA",a,ref,"Invoice Date"),3,1),12)_", "_$zd($ZDTH(@%GLOBAL@("INVOICE","DATA",a,ref,"Invoice Date"),3,1),7)_"  "_time
        . s @r@("list",counter,"id")=@%GLOBAL@("INVOICE","DATA",a,ref,"Client ID")
        . s @r@("list",counter,"status")=$g(@%GLOBAL@("SMS","INVOICE:STATUS",a),"Not Sent")
        . s @r@("list",counter,"reply")=$g(@%GLOBAL@("REPLIES:TS",c,d,a))
        . s @r@("list",counter,"stars")=+$g(@%GLOBAL@("INVOICE:RATING",a))
        . I $D(@%GLOBAL@("REPLIES:TS:RETENTION",c,d,a)) s @r@("list",counter,"stars")=""
        . s @r@("donotSend","ID-"_@%GLOBAL@("INVOICE","DATA",a,ref,"Client ID"))="true"
        . i $g(@%GLOBAL@("doNotSend","ID-"_@%GLOBAL@("INVOICE","DATA",a,ref,"Client ID")))]"" d 
        .. s @r@("donotSend","ID-"_@%GLOBAL@("INVOICE","DATA",a,ref,"Client ID"))=$g(@%GLOBAL@("doNotSend","ID-"_@%GLOBAL@("INVOICE","DATA",a,ref,"Client ID")))
        . s item="" f  s item=$o(@%GLOBAL@("INVOICE","DATA",a,item)) q:item=""  d
        .. s @r@("list",counter,"item",$o(@r@("list",counter,"item",""),-1)+1)=$g(@%GLOBAL@("INVOICE","DATA",a,item,"Item"))
        zk r
        m rr("data","data")=r
        Q
        ;
        ;
