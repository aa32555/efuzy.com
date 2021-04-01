ZAA02GSETUTILS1;;2018-07-09 13:23:07
 ; uses % var to get params
 ; writes out OK or error message
 ; runs from the webpage only
 q 
.
SETVAL ;ZAA02Gweb  param1 value, param2 address
 n (%)
 s val="" s addr="" s piece=""
 s val=$G(%("FORM","param1"))
 s addr=$G(%("FORM","param2"))
 s piece=$G(%("FORM","param3"))
 if $L(piece)=0  {
 
        ;NOT ALL GLOBALS ARE ALLOWED, LIST OF ALLOWED LOCATIONS BELOW
        ;check against allowed list of locations
        s ok=0 
        s allowed="^MSCG" 
        if (addr[allowed) s ok=1
 
        s allowed="^ZAA02GVBUSER(""CODE"",""DEFAULTS"""
        if (addr[allowed) s ok=1
.
        s allowed="^AAAA"
        if (addr[allowed) s ok=1
.
        if 'ok w "Location "_addr_" is not supported." q
 
        s @addr=val
        w "OK"
        q
        }
 else  {
        s ok=0 
        
        s allowed="^ZAA02GSETDICT" 
        if (addr[allowed) s ok=1
        
        s allowed="^ZAA02GSETPAGES" 
        if (addr[allowed) s ok=1
 
        s allowed="^AAAA"
        if (addr[allowed) s ok=1
.
        if 'ok w "Location "_addr_" is not supported." q
 
        s piece=$P(piece,"=",2) 
        n nval1 s nval1=""
        
        s nval1=$G(@addr)
        
        s $P(nval1,$C(9),piece)=val
        
        s @addr=nval1 
        w "OK"
        q
.
         
         } 
 
 q
 
SETFLAG ;ZAA02Gweb  param1 'ADD' or 'DEL', param2 address
 n (%)
 s val="" s addr=""
 s val=$G(%("FORM","param1"))
 s addr=$G(%("FORM","param2"))
 
 ;M ^DBG("ZAA02GSETTINGS3-SETFLAG",$H)=%
 ;w $H_" results are here."
 
 ;w " param1 : "_val ; =- either 'ADD' or 'DEL'
 ;w " param2 : "_addr ;
 
 ;check against allowed list of locations
 s ok=0 
 s allowed="^MSCG(" ; only subset of MSCG is allowed
 if (addr[allowed) s ok=1
 
 s allowed="^AAAA"
 if (addr[allowed) s ok=1
 
 s allowed="^DBG" ; 
 if (addr[allowed) s ok=1
.
 s allowed="^ZAA02GVBUSER(""CODE"",""DEFAULTS"""
 if (addr[allowed) s ok=1
 
 if 'ok w "Location "_addr_" is not supported." q
 
 if (val="DEL")  {
         zk @addr
 }
 elseif (val="ADD") { ; if value exists do not modify, if not - set to 1
         //if '($D(@addr)) s @addr=1  - no, always set to 1
         s @addr=1
 }
 
 w "OK"
 q
.
.
