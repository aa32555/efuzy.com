ZAA02GLETTERHIST ; Download report files ;2016-11-22 10:39:59
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
.
ST ;ZAA02Gweb;
 N (%)
 s action="NDM" ;use DEMOGRAPHICS read permission
 S hst1=$G(%("HOST:"))
 S IP=$G(%("ADDRESS"))
 W "<div><font face='verdana' size='2'>"_$ZDATETIME($H,5)_"</font></div>" ,!
 
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
.
  s acct=$P(acct,"-",1)
  s PN=$P($G(^PTG(+acct,1)),":",3)
  if PN="" s PN=$P($G(^GRG(+acct)),":",7)
  
  s PageTitle=" Account Letters "
  s acct=$P(acct,"-",1)
.
  s tooltip="Letters printed for account "_acct_", Entity "_ent
  w "<div class='hdr1' title='"_tooltip_"'>"_PageTitle_"</div>",!
.
  if (acct="") s acct="not specified" 
  w "<div class='hdr2'>"_"Acct# "_acct_"  " _PN_"</div>",!
 
  if ent="" s ent="1"
  
  s h(1)="Date" s h(2)="Time" s h(3)="Letter" 
  s h(4)="Operator" 
  s h(5)="Prev. Let. Sequence"
  s h(6)="Curr Let. Sequence"
  s h(7)="Sp. Field A"
  s h(8)="Sp. Field B"
  s h(9)="Sp. Field C"
  
  // ; Date and time, Letter, Previous Letter Sequence, Current Let Seq, Special Field A, Special Field B, Special Field C
  //header row
  W "<table class='grd'>"
  W "<thead><th>"_h(1)_"</th><th>"_h(2)_"</th><th>"_h(3)_"</th><th>"_h(4)_"</th><th>"_h(5)_"</th>"
  W "<th>"_h(6)_"</th><th>"_h(7)_"</th><th>"_h(8)_"<th>"_h(9)_"</th></thead>"
  //data rows
  n r,c,dt s r="" s c=1 s dt=""
   for { 
         s r=$O(^LETACCTG(ent,acct,r))
         i r="" q
         s dt=^LETACCTG(ent,acct,r)
         w "<tr>"
         w "<td>"_$ZD($P(r,",",1))_"</td><td>"_$ZT($P(r,",",2))_"</td>"
         w "<td>"_$P(dt,":",1)_"</td><td>"_$P(dt,":",7)_"</td>"  //letter, operator
         w "<td>"_$P(dt,":",2)_"</td><td>"_$P(dt,":",3)_"</td>"
         w "<td>"_$P(dt,":",4)_"</td><td>"_$P(dt,":",5)_"</td><td>"_$P(dt,":",6)_"</td>"
         w "</tr>"
        }
  
  W "</table>"
  
styles 
 W "<!DOCTYPE HTML>",!
 W "<head><meta http-equiv=""X-UA-Compatible"" content=""IE=9"">"
 W "<style type='text/css'>"
 W "div{font-family:Verdana;font-size:small;}"
 W "td{font-family:Verdana;font-size:small;padding:4px;background-color:white;}"
 W "div.hdr1 {font-family: Verdana; text-align:center;line-height:40px;color:steelblue;padding:2px; width:100%;font-size:large;}",!
 W "div.hdr2 {font-family: Verdana; text-align:left;line-height:40px;color:salmon; width:100%;}",!
 W "table.grd {white-space:normal;background-color:lightsteelblue;}",!
 W "tr {font-family:Verdana; font-size:8pt;}",! 
 W "th {color:darkslategray;background-color:white;height:24pt;text-align:center;padding:2px 2px 2px 2px;}", !
 W "</style>"
 W "</head>"
 q
.
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
.
