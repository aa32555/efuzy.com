ZAA02GUTILS ;;2018-06-15 13:32:04
 q
GetModel(Model, longstring)  ; parse JSON longstring into array
         n str,starZAA02Gey,endkey,value
         n sarr,earr,arrv,key,val,i
         s str = longstring
         s starZAA02Gey=0
         s endkey=1
         s value=0
         s sarr=0
         s earr=1
         s arrv=""
         s key=""
         s val=""
         f i=1:1:$l(str) d 
         . s v = $e(str,i)
         . i v = """",$e(str,i+1)'=":",'starZAA02Gey,endkey,'value                  s starZAA02Gey=1,endkey=0 q
         . i v = """",$e(str,i+1)=":",starZAA02Gey,'endkey,'value                   s starZAA02Gey=0,endkey=1 q
         . i v = ":",$e(str,i-1)="""",'starZAA02Gey,endkey,'value                   s value =1 q
         . i v = ",",$e(str,i+1)="""",'starZAA02Gey,endkey,value,'sarr,earr s val=$$prs(val),value=0,Model(key)=val,key="",val="" q
         . i v = "}",$e(str,i+1)="",'starZAA02Gey,endkey,value                              s val=$$prs(val),value=0,Model(key)=val,key="",val="" q
         . i v = "[",$e(str,i-1)=":",'starZAA02Gey,endkey,'sarr,earr                s sarr=1,earr=0 q 
         . i v = ",",'starZAA02Gey,endkey,sarr,'earr,arrv]""                                s arrv=$$prs(arrv),Model(key,($o(Model(key,""),-1)+1))=arrv,arrv="" q
         . i v = "]",($e(str,i+1)=","!($e(str,i+1)="}"))                                s arrv=$$prs(arrv),Model(key,($o(Model(key,""),-1)+1))=arrv,arrv="",sarr=0,earr=1 q
         . i starZAA02Gey,'endkey,'value,'sarr,earr  s key=key_v q
         . i 'starZAA02Gey,endkey,value,'sarr,earr   s val=val_v q
         . i 'starZAA02Gey,endkey,value,sarr,'earr   s arrv=arrv_v q
         q
r(s,f,t)
        i $tr(s,f)=s q s
        n o,i,l s l=$l(s,f),o="" f i=1:1:l  s o=o_$s(i<l:$p(s,f,i)_t,1:$p(s,f,i))
        q o
        ;
        ;
        
prs(s)
        i $tr(s,"""\/"_$c(8,9,10,13))=s q s
        i s["\\"    s s=$$r(s,"\\","\")
        i s["\"""   s s=$$r(s,"\""","""")
        i s["\/"    s s=$$r(s,"\/","/")
        i s["\b"        s s=$$r(s,"\b",$c(8))
        i s["\n"        s s=$$r(s,"\n",$c(10))
        i s["\r"        s s=$$r(s,"\r",$c(13))
        i s["\t"        s s=$$r(s,"\t",$c(9))
        i $e(s)="""",$e(s,$l(s))="""" s s=$e(s,2,$l(s)-1)
        q s
        ;
REPLACE(String,Value,NewValue)  q $$replace(String,Value,NewValue)
 ;
replace(s,f,t)
        i $tr(s,f)=s q s
        n o,i s o="" f i=1:1:$l(s,f)  s o=o_$s(i<$l(s,f):$p(s,f,i)_t,1:$p(s,f,i))
        q o
        ;
.
chkProcess(processToChk, nameSpace ) ; //returns 1 if routine is running in the namespace, otherwise 0
.
 i $g(nameSpace)="" s nameSpace=$SYSTEM.SYS.NameSpace()  ; set to the current namespace if nothing is passed  in
 s isRunning=0
 s pidProcess="" s pidNamespace=""
 
 SET PID=""
        FOR I=1:1 {
        SET PID=$ORDER(^$JOB(PID))
        QUIT:PID="" 
        
                s pidRoutineName=$ZUTIL(67,5,PID)
                s pidNamespace=$ZUTIL(67,6,PID)
                if (pidRoutineName=processToChk) if (nameSpace=pidNamespace) s isRunning=1 q
    }
        q isRunning
 Q
.
strJSON(g)  ;;call $$strJSON($NA(..your variable here..)); returns JSON string
        n %out s %out=""
        q:g=""  i '$d(@g) d  q %out
        .  s %out=%out_"{"_"""error"""_":"_"""Invalid global reference"""_"}"
        n l,c,t d  s l="",c=0 f  s l=$o(@g@(l)) q:l=""  d j2
        .  s %out=%out_$s($g(@g)]"":"{"_""""_$$s(@g)_""""_":"_"{",1:"{")
         s %out=%out_$s($g(@g)]"":"}}",1:"}")
        q %out
        ;
j(g) 
        n l,c s c=1 i $g(@g,$c(0))=$c(0)  s %out=%out_"{" s c=0
        i c  s %out=%out_"{"_""""_"_get"_""""_": "_""""_$$s(@g)_"""" s c=1
        s l="" f  s l=$o(@g@(l)) q:l=""  d j2 
         s %out=%out_"}"
        q
        ;
j1
        i $o(@g@(l,""))]"" d  d j(t)
        . k t s t=$s($e(g,$l(g))=")":$e(g,1,$l(g)-1)_","_""""_l_""""_")",1:g_"("""_l_""")")
        i $o(@g@(l,""))=""  s %out=%out_$s($g(@g@(l),$c(0))=$c(0):"null",1:""""_$$s(@g@(l))_"""")
        q
        ;
j2      
        s:c %out=%out_","  s %out=%out_""""_$$s($s($tr(l,".")?1n.n:""_l,1:l))_""""_":" s c=1 d j1
        q
        ;
.
s(s)
        i $tr(s,"""\/"_$c(8,9,10,13))=s q s
        i s["\"    s s=$$r(s,"\","\\")
        i s[""""   s s=$$r(s,"""","\""")
        i s["/"    s s=$$r(s,"/","\/")
        i s[$c(8)  s s=$$r(s,$c(8),"\b")
        i s[$c(10) s s=$$r(s,$c(10),"\n")
        i s[$c(13) s s=$$r(s,$c(13),"\r")
        i s[$c(9)  s s=$$r(s,$c(9),"\t")
        q s
        
 q
 
ListFilesInDir(dir,wildcards) ; returns list, including directories; $LENGTH($ZU(12,f,2))>0 indicates a directory
 n unix,delim,rs,cntr,fullpath
 s fullpath=1
 s lst=$LB("") s cntr=0
 s unix=$s($zv["UNIX":1,1:0)
 s delim=$s(unix:"/",1:"\")
 if ($e(dir,$l(dir))=delim) {
  s dir=$e(dir,1,($l(dir)-1))
 }
 s rs=##class(%ResultSet).%New()
 s rs.ClassName="%File"
 s rs.QueryName = "FileSet"
 d rs.Execute(dir,wildcards,"",0)
 while (rs.Next(.sc)) {
  if ($SYSTEM.Status.IsOK(sc)) {
   s name=rs.Data("Name")
   if (fullpath) {
     s cntr=cntr+1
         s $LIST(lst,cntr)=name
   } else {
    s lc="abcdefghijklmnopqrstuvwxyz""",uc="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    s name=$p($tr(name,lc,uc),$tr(dir,lc,uc),2)
    if ($e(name)=delim) {
     s name=$e(name,2,$l(name))
    }
    
    s cntr=cntr+1
        s $LIST(lst,cntr)=name
   }
    }
 else {
  q 
 }
 }
 q lst
 
UC(strToConvert)
 n lc,uc,res s lc="abcdefghijklmnopqrstuvwxyz",uc="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 s res=$tr($G(strToConvert),lc,uc)
 q res
 
LC(strToConvert)
 n lc,uc,res s lc="abcdefghijklmnopqrstuvwxyz",uc="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 s res=$tr($G(strToConvert),uc,lc)
 q res
.
WriteOutNoPermission(usr,action)
  s action=$G(action) s usr=$G(usr)
  w "<font color='steelblue' face='verdana' title='"_usr _" - "_action_"'><br>Access denied. <br>Please verify your security settings.</font>"
  q     
  
IsASP()
 n res
 s $ZT="errIsASP"
 s res= +$G(^["USER"]MSCG("ASPHOST"))
 q res
errIsASP
        s $ZT=""
        q 0
.
