ZAA02GCFGSS
        n iSSref,fromAddress,practiceCode,apiKey,sessionKey,timeStamp,IP,Port,vt330Indent,ynEdit,dispName,cntr,entityName
        s iSSref = $na(^ZAA02GFAXC("SURESCRIPTS"))
        s dispName($i(cntr))="From Address"
        s dispName($i(cntr))="Practice Code"
        s dispName($i(cntr))="API Key"
        s dispName($i(cntr))="Session Key"
        s dispName($i(cntr))="Time Stamp"
        s dispName($i(cntr))="IP"
        s dispName($i(cntr))="Port"
        d DIR^ZAA02GCFG
        d sysInfo^ZAA02GCFG(.premVer,.entityName)
        d Load
        f
        {
                d vt330Display(.cntr,.dispName)
                w $$vt330XY(vt330Indent1,cntr+ySync+2)
                s Option=$$CH^ZAA02GCFG("E-Edit:S-Save:Q-Quit:A-Append Stunnel")
                i Option="E" d vt330Edit(cntr,.dispName)
                i Option="S" i $$YN^ZAA02GCFG("Save changes and exit?") d Save q
                i Option="Q" i $$YN^ZAA02GCFG("Discard changes and exit?") q
                i Option="A" i $$YN^ZAA02GCFG("Auto Append Stunnel; Are you sure?") d AUTOSSL^ZAA02GCFG("surescripts",Port,"n2nserver.medicscloud.com:443","yes")
        }
        q
.
vt330Display(cntr,dispName)
        n ZeroXY,dx,BP,CLS
        
        s vt330Indent1 = 4
        , vt330Indent2 = 24
        , ySync = 4
        
        s ZeroXY=$C(27)_"[0;0H"
        s dx="" f i=1:1:80 s dx=dx_" "
        s BP="" f I=1:1:24 s BP=BP_dx
        s CLS=ZeroXY_BP_ZeroXY
        s CRLF=$C(13,10)
        
        s cntr=0
        
        w CLS
        
        , "ZAA02GCFGSS - EMR Direct configuration" _ CRLF
        _ "Premier version: " _ premVer _ CRLF
        _ "Entity 1: " _ entityName _ CRLF
        
        , $$vt330XY(vt330Indent1,$i(cntr)+ySync)_"  "_dispName(cntr)_":"_$$vt330XY(vt330Indent2,cntr+ySync)_fromAddress
        _ $$vt330XY(vt330Indent1,$i(cntr)+ySync)_"  "_dispName(cntr)_":"_$$vt330XY(vt330Indent2,cntr+ySync)_practiceCode
        _ $$vt330XY(vt330Indent1,$i(cntr)+ySync)_"  "_dispName(cntr)_":"_$$vt330XY(vt330Indent2,cntr+ySync)_apiKey
        _ $$vt330XY(vt330Indent1,$i(cntr)+ySync)_"  "_dispName(cntr)_":"_$$vt330XY(vt330Indent2,cntr+ySync)_sessionKey
        _ $$vt330XY(vt330Indent1,$i(cntr)+ySync)_"  "_dispName(cntr)_":"_$$vt330XY(vt330Indent2,cntr+ySync)_timeStamp
        _ $$vt330XY(vt330Indent1,$i(cntr)+ySync)_"  "_dispName(cntr)_":"_$$vt330XY(vt330Indent2,cntr+ySync)_IP
        _ $$vt330XY(vt330Indent1,$i(cntr)+ySync)_"  "_dispName(cntr)_":"_$$vt330XY(vt330Indent2,cntr+ySync)_Port
.
        q
.
vt330Edit(cntr,dispName)
        s keyUp = $c(27,91,65)
        , keyDown = $c(27,91,66)
        , keyRight = $c(27,91,67)
        , keyF11 = $c(27,91,50,51,126)
        
        s endCntr=cntr
        , cntr=1
        
        //f cntr=1:1:cntr w $$vt330XY(vt330Indent1,cntr)_"  "_$g(dispName(cntr))_$$vt330XY(vt330Indent2,cntr),?80
        
        w $$vt330XY(vt330Indent1,cntr+ySync)_">"
        s cntr=1
        
        s input(1) = fromAddress
        , input(2) = practiceCode
        , input(3) = apiKey
        , input(4) = sessionKey
        , input(5) = timeStamp
        , input(6) = IP
        , input(7) = Port
        
        f
        {
                r *k s k=$key
                w $c(8,32,8)
                w $$vt330XY(vt330Indent1,cntr+ySync) _ " " _ $$vt330XY(vt330Indent2,cntr+ySync) _ input(cntr)
                i k=keyUp s cntr=cntr-1
                i k=keyDown s cntr=cntr+1
                i cntr<1 s cntr=1
                i cntr>endCntr s cntr=endCntr
                w $$vt330XY(vt330Indent1,cntr+ySync)_">"
                
                i (             (k=keyRight)
                        ||      (k=$c(13))
                )
                {
                        w $$vt330XY(vt330Indent1,cntr+ySync),?80
                        w $$vt330XY(vt330Indent1,cntr+ySync)_"> "_$g(dispName(cntr))_":"_$$vt330XY(vt330Indent2,cntr+ySync) r in
                        i in'=keyF11 s input(cntr)=in
                        w $$vt330XY(vt330Indent2,cntr+ySync) _ input(cntr) _ $$vt330XY(vt330Indent1,cntr+ySync)_">"
                }
                i $zcvt(k,"l")="s" q
.
        }
        
        s fromAddress = input(1)
        , practiceCode = input(2)
        , apiKey = input(3)
        , sessionKey = input(4)
        , IP = input(6)
        , Port = input(7)
        q
.
vt330XY(X = "", Y = "")
        i X="" s X=$X
        i Y="" s Y=$Y
        s $X=X
        s $Y=Y
        s XY = $C(27,91)_  Y _";"_  X _"H"
        q XY
        
Save
        d SUSPEND^ZAA02GCFG
        , MSTOP^ZAA02GCFG
        
        s @iSSref@("FROM")                      = fromAddress
        , @iSSref@("PRACTICE-CODE")     = practiceCode
        , @iSSref@("API-KEY")           = apiKey
        ;, @iSSref@("SESSION-KEY")      = sessionKey
        , @iSSref@("IP")                        = IP
        , @iSSref@("PORT")                      = Port
        
        d MSTART^ZAA02GCFG
        , UNSUSPEND^ZAA02GCFG
        
        q
        
Load
        s fromAddress           = $g(@iSSref@("FROM"))
        , practiceCode          = $g(@iSSref@("PRACTICE-CODE"))
        , apiKey                        = $g(@iSSref@("API-KEY"))
        , sessionKey            = $g(@iSSref@("SESSION-KEY"))
        , timeStamp                     = $g(@iSSref@("TIME-STAMP"))
        , IP                            = $g(@iSSref@("IP"))
        , Port                          = $g(@iSSref@("PORT"))
        
        q
        
        /*
        Example:
        
        ^ZAA02GFAXC("SURESCRIPTS","FROM")=from                    example "ravivenkataraman@medicscloud.com"
        ^ZAA02GFAXC("SURESCRIPTS","PRACTICE-CODE")=practice             example "VLA9YHKOIJB"
        ^ZAA02GFAXC("SURESCRIPTS","API-KEY")=apikey                example "ravivenkataraman"
        ^ZAA02GFAXC("SURESCRIPTS","SESSION-KEY")=session            example "A4D050B338AE7FBC763B4A938309F407BZ" 
        ^ZAA02GFAXC("SURESCRIPTS","TIME-STAMP")=from             example "2016-03-31T13:09:54"
        ^ZAA02GFAXC("SURESCRIPTS","IP")=from                           example "10.1.10.75" STUNNEL IP 
        ^ZAA02GFAXC("SURESCRIPTS","PORT")=from                   example "8097" STUNNEL configuration
.
.
        STUNNEL EXAMPLE:
        [SureScripts]
        accept = 8082
        connect = n2nserver.medicscloud.com:443
        client = yes
        */
.
