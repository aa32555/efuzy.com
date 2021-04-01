LOG
        ;
        ;
        ;
        Q
ADD(T,ZTS,M)
        N ID S ID=$I(@%G@("LOG","COUNTER"))
        S @%G@("LOG","DATA",ID,"user")=%EMAIL
        S @%G@("LOG","DATA",ID,"account")=%ACCOUNT
        S @%G@("LOG","DATA",ID,"date")=$P(ZTS,",")
        S @%G@("LOG","DATA",ID,"time")=$P(ZTS,",",2)
        S @%G@("LOG","DATA",ID,"message")=M
        S @%G@("LOG","DATA",ID,"type")=T
        Q ID
        
        
        
