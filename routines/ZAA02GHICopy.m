ZAA02GHICopy        ; Copy transacations from TRG to ZAA02GHIC - for testing purposes;2017-07-10 13:58:02
        S FIELDS="1:3:4:5:6:7:9:13:14:15:16:17:18:21:22:23:26:44:45:70:73:"
        
.
ez      R !!,"Enter entity number: ",ez
        i ez<1!(ez>(^PRMG("Z")-1)) g ez
        ;
tr      R !!,"Enter transaction number: ",tr
        i tr="" g tr
        i '$d(^TRG(ez,tr)) w "  transaction does not exist" g tr
        s s=$g(^TRG(ez,tr))
        i $p(s,":",4)'="P" w "This is not a charge" g tr
        ;
prv     R !!,"Include Provider: ",prv 
        s t=$$yn(.prv)
        i 't g prv      
        ;
plc     R !!,"Include Place: ",plc
        s t=$$yn(.plc)
        i 't g plc
        ;
dia     R !!,"Include Diagnosis: ",dia
        s t=$$yn(.dia)
        i 't g dia
        ;
        s s1=""
        s date=$zd($h,8)
        f i=1:1:$l(FIELDS,":")  s pos=$p(FIELDS,":",i) d:pos>0
        .i prv="N",pos=13 q
        .i plc="N",pos=15 q
        .i dia="N",pos>20&(pos<24) q
        .s $p(s1,":",pos)=$p(s,":",pos) 
        // ^ZAA02GHIC(1,0,1,20160915,1)     
        s prv=$p(s1,":",13) s:prv="" prv=" "
        s plc=$p(s1,":",15) s:plc="" plc=" "
        s pos=""
        s pos=$zp(^ZAA02GHIC(ez,plc,prv,date,""))+1
        S $p(s1,":",1)=+$H
        s $p(s1,":",16)=$zd((+$h-5),8)
        s ^ZAA02GHIC(ez,plc,prv,date,pos)=s1
        
        q
        ;
yn(yn)
        s yn=$TR(yn,"yn","YN")
        i yn'="N"&(yn'="Y") q 0
        q 1
        
.
        
                
        
