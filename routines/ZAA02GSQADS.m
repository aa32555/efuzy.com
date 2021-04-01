ZAA02GSQADS ;ZAA02GSQL;ADS OBJECTS;;;13AUG2007  14:48
 ;
 Q
 ;
TT S x="^PTG(300)" F JJ=1:0:100  S x=$Q(@x) Q:x=""  I $S($QL(x)=2:1,1:0) I  S A=$$DEMO2(x),JJ=JJ+1 ; ZAA02GWEB
 Q
FORM ; ZAA02GWEB
 S X="" F I=0:1 S A=$P($T(DATA2+I),";",2,99) I $E(A)'=";" Q:A=""  D:A["*" FILL W A,!
 Q
 ;
POST ; ZAA02GWEB
 ; W "<PRE>" W  Q
 I $G(%("FORM","name"))="TEST" W "<PRE>" w  q
 I $G(%("FORM","name"))
 I $G(%("FORM","ID")) S A="^PTG("_%("FORM","ID")_",1)" G:'$D(@A) UNDEF S A=$$DEMO2(A)
 W "TRY AGAIN" q
UNDEF W "NOT FOUND" Q
 ;
 ;
 ; MEDICS II  - 20
DEMO2(x) N R,X,I,A,D,E,F,G S D=@x,R="",K=$QS(x,1),K1=$QS(x,2),G=$G(^GRG(K)) S:K1>1 K=K_"/"_K1 S P(9)=K
 F I=1:1 S E=$P("3,4,6,7,8,9,13,16,18",",",I) Q:E=""  S F=$P("1,4,5,7,17,8,13,15,19",",",I) S P(F)=$P(D,":",E)
 F I=1:1 S E=$P("7,8,10,11,12,15",",",I) Q:E=""  S F=$P("1,4,5,7,17,19",",",I) I '$L($G(P(F))) S P(F)=$P(G,":",E)
 F I=1:1 S E=$P("12",",",I) Q:E=""  S F=$P("10",",",I) S P(F)=$$DT($P(D,":",E))
 F I=1:1 S E=$P("28,10",",",I) Q:E=""  S F=$P("11,12",",",I) S E=$P(D,":",E),P(F)=$P($P(",Single,Married\?,Male,Female","\",I),",",$F($P("SM\MF","\",I),E))
 I $G(P(13))]"" S P(14)=$P($G(^PVG(P(13))),":",2)
 I $G(P(15))]"" S P(16)=$P($G(^RFG(P(15))),":",2)
 S X="" F I=0:1 S A=$P($T(DATA1+I),";",2,99) I $E(A)'=";" Q:A=""  D:A["*" FILL W A,!
 W "<p>&nbsp;<p>",!
 ; I P15'="" w P1,!,D,! R CCC
 Q 1
 ;
DT(X) Q:X="" ""  Q:$L(X)<7 $E(X,3,4)_"/"_$E(X,5,6)_"/"_19_$E(X,1,2) Q $E(X,5,6)_"/"_$E(X,7,8)_"/"_$E(X,1,4) Q
 ;
FILL S A=$P(A,"*")_$G(P(+$P(A,"*",2)))_$E($P(A,"*",2,99),$L(+$P(A,"*",2))+1,999)
 G:A["*" FILL Q
 ;
DATA1 ;<table border=0 cellspacing=0 cellpadding=3 width=750><tr bgcolor=#99ccCC align=top>
 ;<td width=350>&nbsp;<font face=arial,helvetica size=4>
 ;; NAME SECTION
 ;<b>*1</b></td>
 ;<td bgcolor=white width=400 align=center><font face=arial,helvetica size=4><b>Account #:&nbsp </b>*9</td>
 ;</tr>
 ;<tr bgcolor=#99ccCC><td colspan=2>
 ;<table border=0 cellspacing=0 cellpadding=0 width=750 bgcolor=#dcdcdc>
 ;; ADDRESS SECTION
 ;<tr><td width=200 valign=top>
 ;<table border=0 cellspacing=0 cellpadding=3 width=100%><tr><td>
 ;<font face=arial,helvetica size=2><b>*2&nbsp *3<br>*4<br>*5,&nbsp *6&nbsp *7</b>
 ;<p>
 ;; SOCIAL SECURITY #  SECTION
 ;<b>SSN:&nbsp </b>*8<br><b>DOB:&nbsp </b>*10<br></font>
 ;</td></tr></table>
 ;</td>
 ;; PHONE/FAX/WORK/EMAIL/ID/ SECTION
 ;<td valign=top width=150>
 ;<table border=0 cellspacing=0 cellpadding=3 size=100%>
 ;<tr><td>
 ;<font face=arial,helvetica size=2><b>Phone:&nbsp </b>*17<br>
 ;<b>Work:&nbsp </b>*18<br><b>Fax:&nbsp </b>(   )   -     <br><b>Email:&nbsp </b><br><b>ID1:&nbsp </b>CH0000001<br><b>ID2:&nbsp </b>
 ;</td></tr></table>
 ;</td>
 ;; ACCOUNT/SEX/MARITAL SECTION
 ;<td bgcolor=white width=250 align=center>
 ;<table border=0 cellspacing=0 cellpadding=3 width=100%><tr><td>
 ;<font face=arial,helvetica size=2><b>Sex:&nbsp </b>*12<br><FONT COLOR=RED><b>Marital:&nbsp </b>*11<p><b>Doctor:&nbsp<br></FONT>
 ;<b>Referring:&nbsp </b>*15  *16<p><b><FONT COLOR=RED>Status:&nbsp </b></font>
 ;</td></tr></table>
 ;</td></tr></table>
 ;; NEXT TABLE
 ;<img src=ads/clear.gif width=1 height=3><br>
 ;<table border=0 cellspacing=0 cellpadding=6 width=100% bgcolor=white>
 ;<tr><td>
 ;<font face=arial,helvetica size=2 COLOR=RED><b>Balance:&nbsp</b>$270.00</td>
 ;<td><font face=arial,helvetica size=2 COLOR=RED><b>Ins:&nbsp</b>$270.00</td>
 ;<td><font face=arial,helvetica size=2 COLOR=RED><b>Guar:&nbsp</b>$0.00</td>
 ;<td><font face=arial,helvetica size=2 COLOR=RED><b>Coll:&nbsp</b>$0.00</td>
 ;<td><font face=arial,helvetica size=2 COLOR=RED><b>Unap:&nbsp</b>$0.00</td>
 ;</tr></table>
 ;<p>
 ;; PRE LAST TABLE HERE
 ;<table border=0 cellspacing=0 cellpadding=0 width=100% bgcolor=white><tr><td>
 ;<table border=0 cellspacing=3 cellpadding=3 width=100% bgcolor=white>
 ;<tr bgcolor=#dcdcdc><td>
 ;<font face=arial,helvetica size=2><b>Ins Co</td>
 ;<td><font face=arial,helvetica size=2><b>Name</b></td>
 ;<td><font face=arial,helvetica size=2><b>Policy</td>
 ;<td><font face=arial,helvetica size=2><b>Group</td>
 ;<td><font face=arial,helvetica size=2><b>Plan</td>
 ;<td><font face=arial,helvetica size=2><b>Copay</td>
 ;<td><font face=arial,helvetica size=2><b>Deduct</td>
 ;<td><font face=arial,helvetica size=2><b>Asg</td>
 ;<td><font face=arial,helvetica size=2><b>Start</td>
 ;<td><font face=arial,helvetica size=2><b>End</td>
 ;<td><font face=arial,helvetica size=2><b>Holder</td>
 ;<td><font face=arial,helvetica size=2><b>Relation</td></tr>
 ;<tr bgcolor=white><td><font face=arial,helvetica size=1 COLOR=RED>NAWC</td>
 ;<td><font face=arial,helvetica size=1 COLOR=RED>Nature Work Company</td>
 ;<td><font face=arial,helvetica size=1 COLOR=RED>NC1234-2</td>
 ;<td><font face=arial,helvetica size=1 COLOR=RED>NC100002</td>
 ;<td><font face=arial,helvetica size=1 COLOR=RED>NC000002</td>
 ;<td><font face=arial,helvetica size=1 COLOR=RED>$10.00</td>
 ;<td><font face=arial,helvetica size=1 COLOR=RED>$0.00</td>
 ;<td><font face=arial,helvetica size=1 COLOR=RED>N</td>
 ;<td><font face=arial,helvetica size=1 COLOR=RED>05/01/98</td>
 ;<td><font face=arial,helvetica size=1 COLOR=RED>05/01/99</td>
 ;<td><font face=arial,helvetica size=1 COLOR=RED>Guarantor:<BR>Aachi, Mama</td>
 ;<td><font face=arial,helvetica size=1 COLOR=RED>Self
 ;</td></tr></table>
 ;</td></tr></table>
 ;<p>
 ;; PRE FOOTER
 ;<font face=arial,helvetica size=2 COLOR=RED><b>Date of Account: &nbsp</b>04/16/98&nbsp &nbsp &nbsp &nbsp &nbsp <b>
 ;Comment: &nbsp</b>Guarantor is mother. Relationship should be Child.</font><P>
 ;<table border=0 cellpadding=3 cellspacing=0 width=100% bgcolor=#FFFFCC>
 ;<tr><td><font face=arial,helvetica size=2 COLOR=RED><b>Last Charge:&nbsp</b>05/05/98</td>
 ;<td><font face=arial,helvetica size=2 COLOR=RED><b>Last Payment:&nbsp</b>05/05/98</td>
 ;<td><font face=arial,helvetica size=2 COLOR=RED><b>Last Ins. Payment:&nbsp</b>&nbsp</td>
 ;<td><font face=arial,helvetica size=2 COLOR=RED><b>Last Statement:&nbsp</b>&nbsp</td></tr></table>
 ;<img src=ads/clear.gif width=1 height=3><br>
 ;<table border=0 cellpadding=3 cellspacing=0 width=100% bgcolor=#FFFFCC>
 ;<tr><td><font face=arial,helvetica size=2 COLOR=RED><b>Special 1:&nbsp</b>CT</td>
 ;<td><font face=arial,helvetica size=2 COLOR=RED><b>Special 2:&nbsp</b>UR</td>
 ;<td><font face=arial,helvetica size=2 COLOR=RED><b>Special 3:&nbsp</b></td>
 ;</tr></table><p>
 ;<font face=arial,helvetica size=2>*19</font>
 ;</td><tr></table>
 ;
DATA2 ;<html><head><title>Patent Inquiry</title></head><STYLE TYPE="text/css"><!--A:link { text-decoration: none }A:visited { text-decoration: none }--></STYLE>
 ;</HEAD><BODY bGCOLOR=WHITE link=#223377 vlink=#223377><TABLE border=0 cellPadding=0 cellSpacing=0 width=600>
 ;<TR><TD><IMG src=d1100.gif><td width=400 align=right><font face=arial size=6 color=green><b>PATIENT INFORMATION</b></font></TD></TR></TBODY></TABLE>
 ;<font face=arial,helvetica size=2>Back to Main Page</a><p><hr size=1 width=600 color=green align=left noshade><p>
 ;<table width=600 border=0 cellpadding=0 cellspacing=0>
 ;<tr><td align=center bgcolor=#404090><font face=arial,helvetica size=2 color=white><b>Patient Information Summary</b></font></td></tr>
 ;<tr><td><font face=arial,helvetica size=2><P>This <b>Patient Information Lookup</b> provides you an opportunity to
 ; examine your confidential medical information that is stored on the computer system for this medical practice.<P>In order to access this record, you are required to enter your last name and account
 ; number.  Your account number is a private number that is only available from your doctor's office.
 ;<br></td></tr></table>
 ;<p><table width=600 border=0 cellspacing=0 cellpadding=3><form method="POST" action="POST^ZAA02GSQADS"><input type="hidden" name="file" value="repo">
 ;<input type="hidden" name="record" value="">Last Name: <input type="text" name="name">  &nbsp;  &nbsp;  Account #: <input type="text" name="ID"><input type="submit" value="Get info"><p><caption align=left>
 ;</td></tr></table></form>
