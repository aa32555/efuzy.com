ZAA02GSQAD1 ;ADS; CLIENT DATABASE DUMP;20MAR98  14:02;;29MAY98  10:46
 ;
CLIENT D HEAD ;ZAA02Gweb
 F J=65:1:90 W "<a href=""client1^ZAA02GSQAD1?"_$C(J)_""">"_$C(J)_"</A> "
 Q
HEAD D TDATE^ZAA02GWEBH($H)  ; ZAA02Gweb
 W "<H2><CENTER>ADS CLIENT DATABASE</H2>",$G(DTMA),"<P>",!
 Q
 ;
CLIENT1 D HEAD ; ZAA02Gweb
 S C=$P($P($G(%("COMMAND"))," ",2),"?",2) W "<TABLE BORDER CELLPADDING=5>"
 W "<TR><TH><FONT SIZE=4>Client</th><th><font size=4>Contact</th><th><font size=4>ST</th><th><font size=4>Phone</th><th><font size=4>Modem</th></tr><tr></tr>"
 S A=C F  S A=$O(^["/usr/ml"]ADS(A)) Q:A=""  Q:$E(A)'=C  S E=$O(^(A,"")) I E]""  S E=$g(^["/usr/ml"]SUPPG(E)) d
 . W "<TR><TD VALIGN=""TOP""><a href=""client2^ZAA02Gsqad1?"_A_""">"_A_"</A></TD><TD>"_$P(E,":",2)_"&nbsp;</TD><TD>"_$P(E,":",4)_"&nbsp;</TD><TD>"_$P(E,":",3)_"&nbsp;</td>"
 . W "<TD>"_$P(E,":",8)_"&nbsp;</td></tr>"
 W "</TABLE>" Q
 ;
CLIENT2 ; ZAA02Gweb
 S C=$P($P($G(%("COMMAND"))," ",2),"?",2)
 W "<center><h1>",C,"</h1>"
 W "<TABLE BORDER CELLPADDING=5>"
 W "<TR><TH><FONT SIZE=4>Client</th><th><font size=4>Contact</th><th><font size=4>??</th><th><font size=4>Phone</th><th><font size=4>Modem</th></tr><tr></tr>"
 S A=C F  S A=$O(^["/usr/ml"]TLG(A)) Q:A=""  Q:$E(A)'=C  S E=^(A) d
 . W "<TR><TD VALIGN=""TOP""><a href=""client2^ZAA02Gsqlad1?"_A_""">"_A_"</A></TD><TD>"_$P(E,":",2)_"&nbsp;</TD><TD>"_$P(E,":",4)_"&nbsp;</TD><TD>"_$P(E,":",3)_"&nbsp;</td>"
 . W <TD>"_$P(E,":",8)_"&nbsp;</td></tr>"
 W "</TABLE>" Q
 ;
DUMP1 S A=$P($P($G(%("COMMAND"))," ",2),"?",2) ; ZAA02Gweb
 W "<a href=""/ads""><img src=""gotop.gif"" align=left></a><h2><center>",A,"</h2>"
 S OA=A S:$E(A)'="^" A=$P($G(^ZAA02GSQLD("MEDICAL",A)),"`",2),A="^T"_A S B=A W "<TABLE>"
 F J=1:1:1000 S B=$Q(@B) Q:B=""  W "<a href=""dump2^MED3GL?"_OA_","_J_""">"_B_"</A><BR><DIV>",$E($G(@B),1,200),"</DIV><BR>",!
 W "</TABLE>" Q
DUMP2 S A=$P($P($G(%("COMMAND"))," ",2),"?",2) W "<BODY TEXT=""#000000"" BGCOLOR=""#ffffff"">" ;ZAA02Gweb
 W "<a href=""/ads""><img src=""gotop.gif"" align=left></a><h2><center>",A,"</center></h2>"
 S J=$P(A,",",2),OA=$P(A,","),A=$P($G(^ZAA02GSQLD("MEDICAL",OA)),"`",2),(A,B)="^T"_A
 F J=1:1:J S B=$Q(@B) Q:B=""
 I B="" Q
 W "<BR><CENTER><TABLE BORDER=1 bgcolor=""#9999FF""><TR><TH COLSPAN=3>"_B_"</TH></TR>" S E=$G(@B)
 F J=1:1:$L(E,"`") W "<TR><TD>",J,"</TD><TD>&nbsp; "_$G(^ZAA02GSQLD("MEDICAL",OA,0,2,J))_" </TD><TD>",$P(E,"`",J),"</TD></TR>",!
 W "</table>" Q
 ;
USER ;ZAA02GWEB
 W "<h3><center>" ; ZAA02Gweb
 w "<hr><table border=1 cellpadding=3><TR><TH colspan=4><CENTER><font size=5>User Table<P><FONT SIZE=3>",$$DTM($H),"<br>&nbsp;</th></tr>"
 W "<tr><th>Session ID</th><th>User</th><th>Logon</th><th>Last Activity</th></tr>"
 S A="" F  S A=$O(^open(A)) q:A=""  W "<tr><td>",A,"</td><td>",$G(^(A)),"</td><td>&nbsp;",$$DTM($g(^(A,0))),"</td><td>&nbsp;",$$DTM($g(^(1))),"</td></tr>"
 W "</table><a href=""/ads""><img src=""gotop.gif""></a>"
 q
DTM(X) N K,Y,D,M Q:X="" ""  S T=$P(X,",",2) S:T<0 X=X-1,T=T+86400 S:T>86400 X=X+1,T=T-86400
 S K=X+306,Y=4*K+3\1461,D=K*4+3-(1461*Y)+4\4,M=5*D-3\153,D=5*D-3-(153*M)+5\5,M=M+2,Y=M\12+Y-60,M=M#12+1,DT=1900+Y*100+M*100+D
 S D=$P("Mon,Tue,Wed,Thu,Fri,Sat,Sun",",",X+3#7+1)_", "_D_" "_$P("Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec",",",M)_" "_(1900+Y)
 S M=T\60,M=$E(M\60+100,2,3)_":"_$E(M#60+100,2,3)_":"_$E(T#60+100,2,3) Q D_" "_M
 ;
