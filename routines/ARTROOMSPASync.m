ARTROOMSPASync
        ;
        ;
        D SyncShedul
        Q
DBG
        b  d SyncShedul
        q
        ;
SyncShedul
        I $ZF(-1,"node "_$$GetSyncerPath())
        D AutoSync("^ARTROOMSPA","ARTROOMSPA")
        q
        ;
GetSyncerPath() q ##class(%File).ManagerDirectory()_$SYSTEM.SYS.NameSpace()_"\"_"ARTROOMSPA"_"\autoShedulSync.js"
        ;
AutoSync(%GLOBAL,PATH)
        K FILES S FILES=$NA(FILES)
        S FILES("Path")=$$getReportPath(PATH)
        D GETFILES(FILES)
        B
        S FILE="" F  S FILE=$O(FILES(FILE)) Q:FILE=""  D Process(FILES(FILE,"FP"))
        Q
        ;
getReportPath(PATH)
        Q ##class(%File).ManagerDirectory()_$SYSTEM.SYS.NameSpace()_"\"_PATH_"\Reports\"        
        ;
GETFILES(d) ; Path, EX (*.dat)
        i '$d(@d@("Path")) q 
        n a,p,e,i,c,f,w
        s p=@d@("Path"),e=$g(@d@("EX"),"*")
        k @d 
        s a=$zse(p_e) f  q:a=""  d
        . s f=$p(a,"\",$l(a,"\"))
        . s w=1
        . i $tr(f,".")="" s w=0
        . i $tr(f,".")=f  s w=0
        . s:w c=$o(@d@(""),-1)+1
        . s:w @d@(c,"FP")=a
        . s:w @d@(c,"FN")=f
        . s:w @d@(c,"EX")=$p(a,".",$l(a,"."))
        . s a=$zse("")
        q
        ;
        ;
 
Process(FILE)
         S (CNT)=0
         S STREAM=##class(%FileCharacterStream).%New()
         S STREAM.Filename=FILE
         S TYPE="",NREC=""
         F  D  Q:STREAM.AtEnd
         . S REC=NREC_STREAM.ReadLine()
         . I $E(REC)="""",$E(REC,$L(REC))="""",REC[""",""" S NREC=""  D  I 1
         .. S REC=$$PIPEME(REC)
         .. S CNT=CNT+1
         .. I CNT=1 S TYPE=$$GETTYPE(REC),HEADER=REC Q 
         .. I TYPE="" Q ;ZT 1
         .. D ProcessRec(REC,TYPE,HEADER)
         . E  S NREC=NREC_REC_$C(10)
         I TYPE]"" H 1 C FILE D ##class(%File).Delete(FILE)
        Q
        ;
        ;
GETTYPE(R)
        I R["Invoice Date|Invoice No.|Invoice Status|Client Name|Client ID|Client Mobile|Channel|Staff|Transaction|Item|Item Type|Barcode / ID|SKU|Category / Group|Brand|Cost Price|Gross Sales|Discounts|Discount Type|Refunds|Net Sales|" Q "SALESLOG"
        I R="Payment Date|Payment No.|Invoice Date|Invoice No.|Client|Client ID|Staff|Transaction|Method|Amount" Q "PAYMENTS"
        I R="Client ID|First Name|Last Name|Name|Blocked|Block Reason|Appointments|No Shows|Total Sales|Outstanding|Gender|Mobile Number|Telephone|Email|Accepts Marketing|Address|Area|City|State|Post Code|Date of Birth|Added|Last Appointment|Note|Referral Source" Q "CLIENTS"
        I R="Ref #|Channel|Created Date|Created By|Client|Service|Scheduled Date|Time|Duration|Staff|Price|Status" Q "APPOINTMENTS"
        Q ""
        ;
ProcessRec(R,T,H)
        i T="SALESLOG" D SALESLOG(R,H) Q
        i T="PAYMENTS" D PAYMENTS(R,H) Q
        I T="CLIENTS"  D CLIENTS(R,H) Q
        I T="APPOINTMENTS" D APPOINTMENTS(R,H) Q
        Q
        ;
        ;
PAYMENTS(R,H)
        N D 
        N I F I=1:1:$L(H,"|") S D($P(H,"|",I))=$P(R,"|",I)
        I $G(D("Invoice No."))="" Q
        K @%GLOBAL@("PAYMENT","DATA",D("Invoice No."),D("Payment No."))
        M @%GLOBAL@("PAYMENT","DATA",D("Invoice No."),D("Payment No."))=D
        ;
        N INVDT S INVDT=$ZDTH(D("Payment Date"),3,1)
        S @%GLOBAL@("PAYMENT","DATE",$ZD(INVDT,8),D("Invoice No."),D("Payment No."))=""
        ;
        Q
        ;
APPOINTMENTS(R,H)
        N I,D F I=1:1:$L(H,"|") S D($P(H,"|",I))=$P(R,"|",I)
        I $G(D("Ref #"))="" Q
        I (D("Status")="New"!(D("Status")="Completed")) D
        . K @%GLOBAL@("APPOINTMENTS","DATA",D("Ref #"))
        . M @%GLOBAL@("APPOINTMENTS","DATA",D("Ref #"))=D
        . ;
        . N ID S ID=$O(@%GLOBAL@("CLIENT","NAME:INV",D("Client"),""),-1) I ID="" S ID="*"
        . ;
        . S @%GLOBAL@("APPOINTMENTS","DATA",D("Ref #"),"Client ID")=ID
        . ;
        . N DATE S DATE =$ZDH(D("Scheduled Date"),3)
        . N TIME S TIME =$ZTH(D("Time"))
        . S @%GLOBAL@("APPOINTMENTS","DATETIME:INV",DATE,TIME,D("Ref #"))=""
        . S STAFF=D("Staff") I STAFF="" Q
        . I '$D(@%GLOBAL@("STAFF","DATA",D("Staff"))) D
        .. S @%GLOBAL@("STAFF","DATA",D("Staff"),"ID")=D("Staff")
        .. S @%GLOBAL@("STAFF","DATA",D("Staff"),"Name")=D("Staff")
        .. S NEXT = $O(@%GLOBAL@("STAFF","SETTINGS","ORDER",""),-1)+1
        .. S @%GLOBAL@("STAFF","SETTINGS","ORDER",NEXT)=D("Staff")
        ;
        ;
        I D("Status")="Canceled" D
        . K @%GLOBAL@("APPOINTMENTS","DATA",D("Ref #"))
        . M @%GLOBAL@("APPOINTMENTS","DATA",D("Ref #"))=D
        . ;
        . N ID S ID=$O(@%GLOBAL@("CLIENT","NAME:INV",D("Client"),""),-1) I ID="" S ID="*"
        . ;
        . S @%GLOBAL@("CANCELED-APPOINTMENTS","DATA",D("Ref #"))=""
        . ;
        . N DATE S DATE =$ZDH(D("Scheduled Date"),3)
        . N TIME S TIME =$ZTH(D("Time"))
        . S @%GLOBAL@("APPOINTMENTS","DATETIME:INV",DATE,TIME,D("Ref #"))=""
        . S STAFF=D("Staff") I STAFF="" Q
        . I '$D(@%GLOBAL@("STAFF","DATA",D("Staff"))) D
        .. S @%GLOBAL@("STAFF","DATA",D("Staff"),"ID")=D("Staff")
        .. S @%GLOBAL@("STAFF","DATA",D("Staff"),"Name")=D("Staff")
        
        Q       
        ;
SALESLOG(R,H)
        N D 
        N I F I=1:1:$L(H,"|") S D($P(H,"|",I))=$P(R,"|",I)
        I $G(D("Invoice No."))="" Q
        I $G(D("Invoice Status"))'="Completed"  Q
        I $G(D("Appointment Reference number"))="" S D("Appointment Reference number")="*"
        K @%GLOBAL@("INVOICE","DATA",D("Invoice No."),D("Appointment Reference number"))
        M @%GLOBAL@("INVOICE","DATA",D("Invoice No."),D("Appointment Reference number"))=D
        I '$D(@%GLOBAL@("CLIENT","DATA",D("Client ID"),"Added")) D
        . S @%GLOBAL@("CLIENT","DATA",D("Client ID"),"Added")=$ZD(+$H,5)
        . S @%GLOBAL@("CLIENT","DATA",D("Client ID"),"Name")=D("Client Name")
        . S @%GLOBAL@("CLIENT","DATA",D("Client ID"),"LAST_INVOICE")=D("Invoice No.")
        ;
        N INVDT S INVDT=$ZDTH(D("Invoice Date"),3,1)
        S @%GLOBAL@("INVOICE","DATE",$ZD(INVDT,8),D("Invoice No."),D("Appointment Reference number"))=""
        ;
        Q
        ;
MIG N A S A="" F  S A=$O(@%GLOBAL@("INVOICE","DATA",A)) Q:A=""  D
        . S B="" F  S B=$O(@%GLOBAL@("INVOICE","DATA",A,B)) Q:B=""  D
        .. S ID = @%GLOBAL@("INVOICE","DATA",A,B,"Client ID")
        .. I ID]"" S @%GLOBAL@("CLIENT","DATA",ID,"LAST_INVOICE")=A
        Q
        
        
        ;
CLIENTS(R,H)
        N D
        N I F I=1:1:$L(H,"|") S D($P(H,"|",I))=$P(R,"|",I)
        I $G(D("Client ID"))="" Q
        ;K @%GLOBAL@("CLIENT","DATA",D("Client ID"))
        M @%GLOBAL@("CLIENT","DATA",D("Client ID"))=D
        S @%GLOBAL@("CLIENT","NAME:INV",D("Name"),D("Client ID"))=""
        Q
        ;
        ;
DDD B  D AutoSync^AR("^AR","Artroom") Q 
        ;
        ;
PIPEME(STR) 
         N I,QUAL,ON,NSTR,FSTR
         S QUAL="""",ON=0,NSTR="",FSTR="" F I=1:1:$L(STR) D
         . S STR=$TR(STR,"|",";")
         . I $E(STR,I)'=QUAL,'ON S NSTR=NSTR_$TR($E(STR,I),",","|") Q
         . I $E(STR,I)=QUAL,'ON S ON=1 S NSTR=NSTR_$E(STR,I) Q
         . I $E(STR,I)'=QUAL,ON S NSTR=NSTR_$E(STR,I) Q
         . I $E(STR,I)=QUAL,ON S ON=0 S NSTR=NSTR_$E(STR,I)
         F I=1:1:$L(NSTR,"|") D
         . I $E($P(NSTR,"|",I),1)=QUAL,$E($P(NSTR,"|",I),$L($P(NSTR,"|",I)))=QUAL S FSTR=FSTR_"|"_$E($P(NSTR,"|",I),2,$L($P(NSTR,"|",I))-1) Q
         . S FSTR=FSTR_"|"_$P(NSTR,"|",I)
         I $ZV["M11" S FSTR=$REPLACE(FSTR,"""""","""")  Q $E(FSTR,2,9999)
         F I=2:1:$L(FSTR,"""""") S FSTR=$P(FSTR,"""""")_$C(3)_$P(FSTR,"""""",2,999)
         S FSTR=$TR(FSTR,$C(3),"""")
         S FSTR=$TR(FSTR,$C(0,1,2,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31),"")
         Q $E(FSTR,2,9999)
         ;
