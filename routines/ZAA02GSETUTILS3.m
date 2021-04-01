ZAA02GSETUTILS3;;2018-09-06 14:15:03
 ; no global vars required
 q
 
GETLIST(tag) ;VB ;from ^ZAA02GSETTINGS global, list  to show in Premier System Settings as "brower_item" in System Setings chr(9) separated
        
        n i,data
        s data="" 
        s i=""
        s i=$O(^ZAA02GSETTINGS(i))
                
        while '(i="")
        {
                s data=data_i_$CHAR(9)_$G(^ZAA02GSETTINGS(i))_$CHAR(230)
.
                s i=$O(^ZAA02GSETTINGS(i))
        }
                ;MAXSTRING limited
        q data
.
.
GetSelectionArr(tag, outarr) ; list of allowed values, array chr(9) delimited code-descr; 
 
 k outarr 
 ;format of the result example
 ;s outarr(0)="^STPXML6"_$C(9)_"^STPXML6"
 ;s outarr(1)="^STPXML"_$C(9)_"^STPXML"
.
 if tag["^"
 { ; build from that list
   ; format of the list is CODE Chr(9) Description
         m outarr=@tag
         q
 }
 
 if (tag="STPPROGRAMS")
 {
        n cnt,data,i1
        s data="" s cnt=0 s i1="ST"
        s i1=$O(^ROUTINE(i1))
        while '(i1="")
        {
                if ($F(i1,"STP"))=4
                {
                        s cnt=cnt+1
                        s outarr(cnt)="^"_i1_$C(9)_i1 // _"  descr "_$G(^ROUTINE(i1,0))
                }
                s i1=$O(^ROUTINE(i1))
                if cnt>200 s i1=""
        }
        q
 }
 elseif (tag="STPFORMS")
 {  ; list all of type "STP" in Custom Forms list
        n cnt,i1,x
        s cnt=0 s i1=""
        s i1=$O(^ZAA02GVBUSER("CUSTFORM",i1))
        while '(i1="")
        {
                s x=$P($G(^ZAA02GVBUSER("CUSTFORM",i1,"T")),":",3)
                if ((x="STP")||(x="RCPT"))
                {
                        s cnt=cnt+1
                        s outarr(cnt)=i1_$C(9)_i1 
                }
                s i1=$O(^ZAA02GVBUSER("CUSTFORM",i1))
                if cnt>200 s i1="" //exit if too many
        }
        q
.
 }
 
  elseif (tag="AISETS")
 {  ; list all AI new style views 
        n cnt,i1,x
        s cnt=0 s i1=""
        s i1=$O(^ZAA02GVBUSER("SYSTEM","ACCTINQ-SET",i1))
        while '(i1="")
        {
                s x=$P($G(^ZAA02GVBUSER("SYSTEM","ACCTINQ-SET",i1,"T")),":",3)
.
                        s cnt=cnt+1
                        s outarr(cnt)=i1_$C(9)_i1 
                
                s i1=$O(^ZAA02GVBUSER("SYSTEM","ACCTINQ-SET",i1))
                if cnt>300 s i1="" //exit if too many
        }
        q
.
 }
.
  elseif ($P(tag,"-",1)="FINCODE") // "FINCODE-PRP" or "FINCODE-RFD")
 {  ; finacial type PRP or RFD
        n cnt,type,a s cnt=0 
        s type=$P(tag,"-",2) 
        s a="" f  s a=$o(^FLG(a)) q:((a="")||(a="~#"))  d  // 
        . i type'="",$p(^FLG(a),":",3)'=type q
        . s cnt=cnt+1  s outarr(cnt)=a_$C(9)_a_" : "_$p(^FLG(a),":",2) 
        q
 }
 
 elseif (tag="INSXMLFORMS")
 {  ; list all of type "INSXML" in Custom Forms list
        n cnt,i1,x
        s cnt=0 s i1=""
        s i1=$O(^ZAA02GVBUSER("CUSTFORM",i1))
        while '(i1="")
        {
                s x=$P($G(^ZAA02GVBUSER("CUSTFORM",i1,"T")),":",3)
                if ((x="INSXML"))
                {
                        s cnt=cnt+1
                        s outarr(cnt)=i1_$C(9)_i1 
                }
                s i1=$O(^ZAA02GVBUSER("CUSTFORM",i1))
                if cnt>200 s i1="" //exit if too many
        }
        q
.
 }
.
 elseif (tag="AUTOPOSTSET")
 {  
        n cnt,i1,x
        s cnt=0 s i1=""
        s i1=$O(^ZAA02GVBUSER("POST","SET",i1))
        while '(i1="")
        {
                        s cnt=cnt+1
                        s outarr(cnt)=i1_$C(9)_i1 
.
                s i1=$O(^ZAA02GVBUSER("POST","SET",i1))
                if cnt>100 s i1="" //exit if too many
        }
        //add anesthesia sets at the end
        s i1=""
        s i1=$O(^ZAA02GVBUSER("POST","SETANS",i1))
        while '(i1="")
        {
                        s cnt=cnt+1
                        s outarr(cnt)=i1_$C(9)_i1_" (Anesth. Ent.)"
.
                s i1=$O(^ZAA02GVBUSER("POST","SETANS",i1))
                if cnt>100 s i1="" //exit if too many
        }
        q
.
 } 
 
 else   {       
        s outarr(0)="0"_$C(9)_"0 selected"
        s outarr(1)="1"_$C(9)_"1 selected"
        s outarr(2)="2"_$C(9)_"2 selected"
        s outarr(3)="3"_$C(9)_"3 selected"
        s outarr(4)="4"_$C(9)_"4 selected"
        s outarr(5)="5"_$C(9)_"5 selected"
        s outarr(6)="6"_$C(9)_"6 selected"
        s outarr(7)="7"_$C(9)_"7 selected"
        s outarr(8)="8"_$C(9)_"8 selected"
        s outarr(9)="9"_$C(9)_"9 selected"
        s outarr(10)="10"_$C(9)_"10 selected"
 }
 q 
.
SaveSysSetting(SettingKey, value) 
 i ($L(SettingKey)=0) q 0
 s ^ZAA02GVBUSER("CODE","DEFAULTS",SettingKey,0)=value
 q 1
.
GetSysSetting(Key,Ent) ;VB 
 s Ent=+$G(Ent)
 
 n s1, w1, res
 s w1="" s s1 ="" s res=""
 i $L(Key) 
        { 
                if (Ent=0) { s w1=$G(^ZAA02GVBUSER("CODE","DEFAULTS",Key,0))}
                else { s w1=$G(^ZAA02GVBUSER("CODE","DEFAULTS",Key,0,Ent)) }
        }
 s res=w1
 q res
 
.
GetVal(address)
 n vl
 s vl="" 
 i $L(address) s vl=$G(@address)
 q vl
.
GetValBool(address)
 n vl
 s vl=""
 i $L(address) s vl=$D(@address)
 q vl
.
 q
 
REPLACESTRING(longstring,find,replace)
 n (longstring,find,replace)
 s res="" s thispiece=""
 
 // copy what $REPLACE does
 if '$L(longstring) q ""
 if '$L(find) q longstring
.
 s L=$L(longstring,find)
 for i=1:1:L
 {
         s thispiece=$P(longstring,find,i)
         s res=res_thispiece
         if (i<L) s res=res_replace // not for the last one
 }
 q res
  
GetSysSwitch(Key,Ent) ;VB 
 s Ent=+$G(Ent)
 s Key=$G(Key)
 
 //Key comes in comma separated. example: "MNGR,QTY"  ->  ^MSCG("MNGCR","QTY") or  ^MSCG("MNGCR","QTY",2)
 n loc s loc="" n loc1 s loc1=""
 
 if (Ent=0) { s loc=Key } else { s loc=Key_","_Ent }
 
 n comma s comma=""""_","_""""
 s loc1=""""_$$REPLACESTRING(loc,",",comma)_""""
 
 n a s a="^MSCG("_loc1_")"
 
 n w1, res
 s w1="" s res=""
 s w1=$G(@(a))
 s res=w1
 q res
.
