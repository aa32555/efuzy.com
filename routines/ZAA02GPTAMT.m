ZAA02GPTAMT ; Download report files ;2017-06-01 16:45:14
 ; ADS Corp. Copyright
 q
 
IsHandleValid(usr,hndl)
        s ok=0
 
        ;go through^ZAA02GVBUSER("LOGON", usr) for today - piece 3; piece 6 is the handle, if logged-off:piece five is filled in
        ;if handle for today found and not logged off - connection is valid
        n a s a ="" n val
        if ($G(usr)="") q 0
        if ($G(hndl)="") q 0
        s a=$O(^ZAA02GVBUSER("LOGON",usr,a))
                while '(a="") {
                s val=$G(^ZAA02GVBUSER("LOGON",usr,a))
                if $P(val,",",5)="" if $P(val,",",6)=hndl if $P(val,",",3)=$P($h,",",1) s ok=1 
                s a=$O(^ZAA02GVBUSER("LOGON",usr,a))
        }
 q ok   
 
IsPermissionOK(usr,action)
 n res s res=0
 if (usr="")|| (action="") s res=0 q res
 if ($P($G(^OPG(usr,action)),":",1)) s res=1 
 q res
 
ST ;ZAA02Gweb;
 N (%)
 s action="NDM" ;use DEMOGRAPHICS read permission
 S hst1=$G(%("HOST:"))
 S IP=$G(%("ADDRESS"))
 
 S LC="abcdefghijklmnopqrstuvwxyz",UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 n data s data=$G(%("FORM","DATA"))
 s data=$TR($P(data,$C(9)),LC,UP)
 
 n cnt,TrNo,x,acct,pt,hndl,usr,ent
 s TrNo=0 s x="" s acct="" s hndl="" s usr="" s ent=1
 
 s cnt=$L(data,"&")
 for i=1:1:cnt {
         s x=$P(data,"&",i)
         
         if (x["TRNO=") { s TrNo=$E(x,$L("TRNO=")+1,$L(x))}
         if (x["ACCOUNTNO=") { s acct=$E(x,$L("ACCOUNTNO=")+1,$L(x))}
         if (x["HNDL=") { s hndl=$E(x,$L("HNDL=")+1,$L(x))}
         if (x["OP=") { s usr=$E(x,$L("OP=")+1,$L(x))}
         if (x["ENT=") { s ent=$E(x,$L("ENT=")+1,$L(x))}
 }
  if '($$IsHandleValid(usr,hndl)) w $$EXPIRED q
  if '($$IsPermissionOK(usr,action)) w $$DENIED(action) q
 
  s acct=$P(acct,"-",1)
  s PN=$P($G(^PTG(+acct,1)),":",3)
  if PN="" s PN=$P($G(^GRG(+acct)),":",7)
  
  s PageTitle="Medicare PT Payment"
  s acct=$P(acct,"-",1)
 
  if (acct="") s acct="not specified" 
 
  n m1,m2,max1,max2,entities s (m1,m2,max1,max2,entities)=""
  s max=+$G(^MSCG("PTAMT","MAX"))
  s entities=$G(^MSCG("PTAMT","ENT"))
 
  D WRITEOUTSTYLES
  W "<div><font face='verdana' size='2'>"_$ZDATETIME($H,5)_"</font></div>" ,!
 
  w "<div class='hdr1' title='Entity: "_entities_"'>"_"Acct# "_acct_"  " _PN_"</div>",!
 
  if ent="" s ent="1"
  
   n amt s amt=0
   if $L(entities)>0 { 
        for jj =1:1:$L(entities,",")
        { 
                s ent=$p(entities,",",jj)
                i ent'="" s amt=amt+($$PTAMT^FUNCT(ent,acct))
        }
        s amt=$J(amt/100,0,2)
   }
   else { 
                s amt=$$PTAMT^FUNCT(ent,acct)
                s amt=$J(amt/100,0,2)
   }
 
   s m1="Therapy amount used for current year"
   s m2=amt
   if max>0  
                { 
                        s max1="Current Medicare Cap"
                        s max2=" $ "_$J(max,0,2)
                }       
 
        W "<table align='center'>",!
        W "<tr><td>"_m1_"</td><td>   "_max1_"</td></tr>"
        W "<tr><td> $ "_m2_"</td><td>"_max2_"</td></tr>"
        W "</table>",!
        
        Q
        
WRITEOUTSTYLES 
 W "<!DOCTYPE HTML>",!
 W "<head><meta http-equiv=""X-UA-Compatible"" content=""IE=9"">"
 W "<style type='text/css'>"
 W "table {font-family:Verdana;font-size:small;border-collapse:collapse; margins:20px;}"
 W "td {border:0px solid rgb(200,200,200); text-align:center; padding:12px 30px 12px 30px;} ", !
 
 W "div.hdr1 {font-family: Verdana; text-align:center;line-height:30px;color:steelblue;padding:2px; width:100%;font-size:small;}",!
 W "div.hdr2 {font-family: Verdana; text-align:left;line-height:30px;width:100%;font-size:small;}",!
 W "</style>"
 W "</head>"
 q
 
EXPIRED()
  n res 
  s res= "<font color='steelblue' face='verdana'><br>Your session has expired.</font>"
  q res
 
DENIED(action) 
 s action=$G(action)
 n res s res=""
 s res="<font color='steelblue' face='verdana'><br>Access denied. <br>Please verify your security settings.</font>"
 s res=res_"<br><font color='steelblue' size='2' face='verdana'><br>&nbsp &nbsp Program: "_action_" </font>"
 q res
 
