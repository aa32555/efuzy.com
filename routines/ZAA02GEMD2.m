ZAA02GEMD2 ;;2018-06-13 13:08:15
 ; ADS Corp. Copyright
 
 ; display stored data, this is called from VB
 ; Dependencies:
 ;              WEBSET depends on P1,P2, HANDLE, EZ, USER
 ;              ZAA02GWEB calls read %("FORM","DATA")
 
 Q
WEBSET ;Set up, called from VB, use B to return data
 n cmd1
 s cmd1=$P(P2,$CHAR(9),1) ; RECV or RECON
 
 n cmd2
 s cmd2="&"_$P(P2,$CHAR(9),2)_"&"_$P(P2,$CHAR(9),3)_"&"_$P(P2,$CHAR(9),4)
 
 I P1="ZAA02GEMD2" D
 . S cmd=$P(P2,$CHAR(9),1) s fileNo=$P(P2,$CHAR(9),2) ; S B=cmd_$C(9)_fileNo Q
 . S B="URL:"_$C(9)_"*/premier/"_HANDLE_"/"_cmd1_"PRINTOUT^ZAA02GEMD2?"_HANDLE_cmd2
 . S ^ZAA02GTVB(+HANDLE,"REPORT",cmd1_"PRINTOUT")=P2_"|"_EZ_"|"_USER
 Q
 
RECVPRINTOUT ; ZAA02GWEB call from browser
 n selection,hndle
 s hndle=$P(%("FORM","DATA"),"&",1)
 s selection=$P(%("FORM","DATA"),"&",2)
 
 i ($G(^ZAA02GTVB(hndle,"REPORT","RECVPRINTOUT"))="")
 {d INVALIDHANDLE }
 else
 {d RECVOUT(selection)}
 q
 
RECONPRINTOUT ; ZAA02GWEB  call from browser
 n fileNo,ent,form,hndle
 s hndle=$P(%("FORM","DATA"),"&",1)
 s ent=$P(%("FORM","DATA"),"&",2)
 s form=$P(%("FORM","DATA"),"&",3)
 s fileNo=$P(%("FORM","DATA"),"&",4)
 i ($G(^ZAA02GTVB(hndle,"REPORT","RECONPRINTOUT"))="")
        { d INVALIDHANDLE }
 else
        { d RECONOUT(ent,form,fileNo) }
 q
 
INVALIDHANDLE ; write out
 w "Handle is invalid. Operation cannot be completed."
 q
 
RECONOUT(ent,form,fileNo)  ; write out the contents of ^MODRECHIST
 n nl, res, out, dttm,dt, no, len, fn1
 s nl=$CHAR(10)_$CHAR(13)
 s res="" s dt=""  s fn1=0
 s len=$L(fileNo,",")
 
 for i=1:1:len
 { 
    s fn1=$P(fileNo,",",i)
    s res=$G(^MODRECHIST(ent,form,fn1))
    
    if res="" { 
        w "<b>File #: "_fn1_" no data</b><p>", ! }
    else {
                s dttm=$P(res,":",1)
                s out=$ZD(dttm)_" "_$ZT($P(dttm,",",2))_" <p>"_$P(res,":",2)_nl
        w "<img src='info.gif'><p>"
                w "<b>File #: "_fn1_" "_out_"</b>", !
                w "<pre>",!
                s no=0 
                While '(no="") 
                {
                        s no=$O(^MODRECHIST(ent,form,$P(fileNo,",",i),no))
                        if '(no="") {
                                s dt=$G(^MODRECHIST(ent,form,$P(fileNo,",",i),no)) ;_nl
                                w "<div>"
                                w dt
                                w "</div>"
                        }
                }
        w "</pre>",!
    }
 }
 q
 
XBSPRINTOUT ; ZAA02GWEB  call from browser
 n fileNo,ent,hndle
 s hndle=$P(%("FORM","DATA"),"&",1)
 s ent=$P(%("FORM","DATA"),"&",2)
 s fileNo=$P(%("FORM","DATA"),"&",4)
 i ($G(^ZAA02GTVB(hndle,"REPORT","XBSPRINTOUT"))="")
        { d INVALIDHANDLE }
 else
        { d XBSOUT(ent,fileNo) }
 q
.
XBSOUT(ent,fileNo)  ; write out the contents of ^MODRECHIST
 n nl, res, out, dttm,dt, no, len, fn1
 s nl=$CHAR(10)_$CHAR(13)
 s res="" s dt=""  s fn1=0
 s len=$L(fileNo,",")
 
 for i=1:1:len
 { 
    s fn1=$P(fileNo,",",i)
    s res=$G(^EOBLHIST(ent,fn1))
    
    if res="" { 
        w "<b>File #: "_fn1_" no data</b><p>", ! }
    else {
                s dttm=$P(res,":",1)
                s out=$ZD(dttm)_" "_$ZT($P(dttm,",",2))_" <p>"_$P(res,":",2)_nl
        w "<img src='info.gif'><p>"
                w "<b>File #: "_fn1_" "_out_"</b>", !
                w "<pre>",!
                s no=0 
                While '(no="") 
                {
                        s no=$O(^EOBLHIST(ent,$P(fileNo,",",i),no))
                        if '(no="") {
                                s dt=$G(^EOBLHIST(ent,$P(fileNo,",",i),no)) ;_nl 
                                w "<div>"
                                w dt
                                w "</div>"
                        }
                }
        w "</pre>",!
    }
 }
 q
.
RECVOUT(selection) ; write out contents of ^EMDREP
                                ; 5 - item 5 
                                ; 1,1 - one most recent
                                ; 1,10 - ten most recent
                                ; 11,100 - one hundred files starting from 11th most recent
                                ; 12/12/2005-12/12/2007 - date range
                                
        if $L(selection,"-")>1 ; select by date range
        {
                n dt1, dt2
                s dt1=$P(selection,"-",1)
                s dt2=$P(selection,"-",2)
        
                d RECVOUTDATE(dt1,dt2)
                q
        }
 
        if $L(selection,",")>1
        {
                n start,qty
            s start=$P(selection,",",1) s qty=$P(selection,",",2)  ; 1,2 two most recent files
                
                D RECVOUTQTY(start,qty)
                q
        }
     
   if $L(selection,",")=1 ; no , or - delimiters; get one file out
        {
                d RECVOUTONEFILE(selection)
                q
        }
   q
   
RECVOUTDATE(dt1,dt2) ; format 12/12/2005 , 12/31/2011
        s prevZT=$ZT
        s $ZT="baddate"
        s dt1=$ZDATEH(dt1)
        s dt2=$ZDATEH(dt2)
        g gooddate
baddate
        s $ZT=prevZT
        w " No selection, invalid date range: "_dt1_"-"_dt2 q
gooddate
                n i,cnt,dt, nodata
                s cnt=0 s nodata=1
                s i=""
                s i=$O(^EMDREP(i),-1)
                
                while '(i="")
                {
                                s dt=$P($G(^EMDREP(i)),",",1)
 
                                if ((dt>=dt1) && (dt<=dt2))
                                {
                                  D RECVOUTONEFILE(i)
                                  s nodata=0
                                }
                                s cnt=cnt+1
                                s i=$O(^EMDREP(i),-1)
                }
                if nodata w "Report is empty. No data with current selection."
        q
 q 
 
RECVOUTQTY(start,qty)
 n i,cnt,printed
 s cnt=1 s printed=0
 s i=""
 s i=$O(^EMDREP(i),-1)
 while ('(i="") && (printed<qty))
 {
                if (cnt>=start) 
                { s printed=printed+1 
                  D RECVOUTONEFILE(i)
                }
                s cnt=cnt+1
                s i=$O(^EMDREP(i),-1)
 }
 q
  
RECVOUTONEFILE(fileNo) ; write out the contents of ^EMDREP for one file
 n nl
 s nl=$CHAR(10)_$CHAR(13)
 
 n res, out, dttm, dt
 s res="" s dt=""
 s dttm=$G(^EMDREP(fileNo))
 
 if dttm="" w "File #: "_fileNo_" no data" q
 
 
 s dt=" "_$P($G(^EMDREP(fileNo,0)),"|",1)_nl_" "_$P($G(^EMDREP(fileNo,0)),"|",2)_nl
 
 s out="<b>File #: "_fileNo_" "_$ZD(dttm)_" "_$ZT($P(dttm,",",2))_"</b> "_nl_dt_nl_nl
 
 W "<img src='reminder.gif'><p>"
 w out
 
 w "<pre>"
 n no
 s no=0 
        While '(no="") 
        {
                s no=$O(^EMDREP(fileNo,1,no))
                if '(no="") s dt=$G(^EMDREP(fileNo,1,no))
                w "<div>"
                w dt
                w "</div>"
        }
 w "</pre>"
 
 q
 
RECONTRUNC(ent,form,fileNo) ; returns string, truncate if close to 30000
 n nl
 s nl=$CHAR(10)_$CHAR(13)
 
 n res, out, dttm,dt
 s res="" s dt=""
 s res=$G(^MODRECHIST(ent,form,fileNo))
 if res="" q "no data" 
 
 s dttm=$P(res,":",1)
 s out=$ZD(dttm)_" "_$ZT($P(dttm,",",2))_" "_nl_$P(res,":",2)_nl
 
 n no
 s no=0 
        While '(no="") 
        {
                s no=$O(^MODRECHIST(ent,form,fileNo,no))
                if '(no="") s dt=$G(^MODRECHIST(ent,form,fileNo,no))_nl
                
                
                
                if ($LENGTH(out)+$LENGTH(dt)<28000)
                        { s out=out_dt}
                else
                    {
                          s out=out_nl_nl_" <<< TRUNCATED >>>"_$LENGTH(dt)
                          s no="" ;exit here
                    }
        }
 
 q out_nl_$LENGTH(out)
 q ""
 
 
