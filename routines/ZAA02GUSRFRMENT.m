ZAA02GUSRFRMENT ;;2014-07-10 17:23:46
ZAA02GUSRFRM ; User Form Entry;12/21/2011 16:58:45;12MAR2008  15:16; ; 30 Nov 20
 ; ADS Corp. Copyright
VB ;
 N (B,EZ,HANDLE,HANDLE2,P2,USER,X,WEB)
 ;
 S B=""
 S D1=":"
 S D2="^"
 S D3=","
 S D4="/"
 S (DEV,IO)=$I
 S OPZ=USER
 S PR=$S(P2["=":P2,1:+P2) I PR="0",$I'[":" S PR=$I
 S PRG="ZAA02GVBUSRFRM"
 S Q="1"
 S s=$P(X,"|",7)
 S VAL=$P(X,"|",6)
 S WEB=$G(WEB,0)
 ;
 ; Account
 S TMP=$P($P(s,D1,1),D2)
 S NO=1 S ACT=+$P(TMP,$C(230),NO),PAT=$P($P(TMP,$C(230),NO),"/",2) Q:'ACT  I $D(^GRG(ACT)) S K=ACT,K1=PAT
 I WEB S WEB=K_"/"_K1
 ;
 ; Form
 S FRM=$P($P(s,D1,2),D2,2)
 I WEB S WEB=WEB_"|"_FRM
 ;
 ;
 I VAL="" S B="||RUN||" Q
 I VAL'="RUN" S B="99|Invalid System Response|16|Report|1=0" Q
 ;
 S ZAA02GVB=1
 Q
RWEB G PREVIEW^ZAA02GVBW6R
WEB ; ZAA02Gweb
 I $G(X)["|",$P(X,"|",6)="" S B="||RUN||" Q
 I $G(X)["|",$P(X,"|",6)="BRW" S B="URL:"_$C(9)_"*/premier/"_HANDLE_"/web^ZAA02Gusrfrm?"_HANDLE,^ZAA02GTVB(+HANDLE,"REPORT")=X Q
 S DATA=$G(^ZAA02GTVB(+$G(%("FORM","DATA")),"REPORT"))
 I DATA="" S DATA=X
 ;
 S LC="abcdefghijklmnopqrstuvwxyz",UC="ABCDEFGHIJKLMNOPQRSTUVWXYZ",WEB=1,WEBHANDLE=+$G(%("FORM","DATA"))
 S USER=$TR($P($P(DATA,"|"),$C(9)),LC,UC),P2=0,EZ=$P($P(DATA,"|"),$C(9),3)
 S $P(X,"|",6)="RUN",$P(X,"|",7)=$P(DATA,"|",7) ;_$S('UF:"I:",1:"U^EMR")
 D VB
 S ACCT=$P(WEB,"|"),K=$P(ACCT,"/"),K1=$P(ACCT,"/",2),TABLE=$P(WEB,"|",2)
 S ND="" F  S ND=$O(^USRFRMG(TABLE,ND)) Q:ND=""  S DATA=^(ND) D
 . S TYPE=$P(DATA,":",2)
 W "<!DOCTYPE html PUBLIC ""-//W3C//DTD XHTML 1.0 Transitional//EN"" "
 W """http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"">",!
 W "<html xmlns=""http://www.w3.org/1999/xhtml"">",!
 W "<head><meta http-equiv=""Content-type"" content=""text/html;charset=UTF-8"" />",!
 W "<title>",$P(^USRFRMG(TABLE),":",2),"</title>",!
 W " <link rel=""stylesheet"" type=""text/css"" href=""../jquery-dist/jquery-ui-1.8.16.custom.css"" />",!
 W " <link rel=""stylesheet"" type=""text/css"" href=""../jquery-dist/jquery.multiselect.css"" />",!
 W " <link rel=""stylesheet"" type=""text/css"" href=""../jquery-dist/jquery.multiselect.filter.css"" />",!
 ; W " <link rel=""stylesheet"" type=""text/css"" href=""../jquery-dist/ui.multiselect.css"" />",!
 W " <script language=""javascript"" type=""text/javascript"" src=""../jquery-dist/jquery.js""></script>",!
 W " <script language=""javascript"" type=""text/javascript"" src=""../jquery-dist/jquery-ui-1.8.16.custom.min.js""></script>",!
 W " <script language=""javascript"" type=""text/javascript"" src=""../jquery-dist/jquery.multiselect.min.js""></script>",!
 W " <script language=""javascript"" type=""text/javascript"" src=""../jquery-dist/jquery.multiselect.filter.js""></script>",!
 ; W " <script language=""javascript"" type=""text/javascript"" src=""../jquery-dist/ui.multiselect.min.js""></script>",!
 W " <style type=""text/css"">.ui-dialog .ui-dialog-buttonpane .ui-dialog-buttonset { text-align: center; float: none; font-size:62.5%}"
 W " .ui-dialog-titlebar {font-size:82.5%} .ui-dialog-titlebar-close { display: none } .red { font-weight:bold; color:#CC0000 } </style>",!
 W "</head><body>",!
 W "<div id=""lookup"" style=""display:none;font-size:62.5%;padding:4px;""></div>",!
 W "</body>"
 W "  <script type=""text/javascript"">",!
 ;D J
 W "   </script>",!
 W "</html>",!
 Q
 Q
