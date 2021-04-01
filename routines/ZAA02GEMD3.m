ZAA02GEMD3 ;;2016-04-13 16:54:23
 ; ADS Corp. Copyright
 Q
VB ; 
 W "00034|OK||not supported in non-web mode00005|END|"
 Q
 
WEB ; ZAA02Gweb
 N v,z,url,url2,url3,hst1
 
 I $G(X)["|",$P(X,"|",6)="" S B="||RUN||" Q
 I $G(X)["|",$P(X,"|",6)="BRW" 
 {
  S B="URL:"_$C(9)_"*/premier/"_HANDLE_"/web^ZAA02GEMD3?"_HANDLE
  S ^ZAA02GTVB(+HANDLE,"REPORT")=X
  Q
 }
 
 S DATA=$G(^ZAA02GTVB(+$G(%("FORM","DATA")),"REPORT"))
 
 i $L(DATA)=0 
 {  
    S B="This is browser only report. ***END REPORT***" q
 }  ; if did not come from web do not continue
 
 S $P(X,"|",6)="RUN",$P(X,"|",7)=$P(DATA,"|",7)
 
 N D1,D2,D3,D4,D5,s,dtf,dtt
 S D1=":"
 S D2="^"
 S D3=","
 S D4="/"
 S D5="|"
 S S=""
 S s=$P(X,"|",7)
 ;
 ; Dates
 S dtf=$TR($P($P($P(s,D1),D2,2),D3),"_")
 S dtt=$TR($P($P($P(s,D1),D2,2),D3,2),"_")
 
 W "<img src='reminder.gif'><p>"
 W "<p>Page loaded: "_$ZDATETIME($H,5) ,!
 W "<p>"
 D RECVOUTDATE^ZAA02GEMD2(dtf,dtt) ; format 12/12/2005 , 12/31/2011
 
 Q
 
 
