ZAA02GSQAD2 ;PROCEDURE CODE;2014-07-10 17:23:46;;;06JUL98  16:55
 ;
PROC ; ZAA02GWEB
 S P3="" f j=0:1:97 s P3=P3_"<option>Fee Set "_j
 F D=1:1 S A=$P($T(DATA1+D),";",2,9) Q:A=""  D:A["*" FILL W A,!
 Q
FILL S A=$P(A,"*")_$G(@("P"_$E($P(A,"*",2))))_$E($P(A,"*",2,99),2,999)
 Q
DATA1 ;
 ;<font face="arial,helvetica,geneva" size=6><center>
 ;Fee Set Editor<img src="ads_logo.gif" align="top" hspace=10 width=50></center><p><hr>
 ;<font size=3 color="#6600ff"><b>Instructions: </b> &nbsp;  <u>Read all instructions FIRST</u><UL><li>Part A<ol><li>Enter the start and end points of the procedure codes along with the fee sets that you want to edit.
 ;<li>Press SELECT to start EXCEL.  Edit as needed.
 ;</ol><li>Part B<ol>
 ;<li>Once you have edited the fee set(s), select the area that you want to store back in the database and COPY and PASTE them in the update box provided below.
 ;<li>Press UPDATE.</ol></ul><hr><font color="#000000">Part A - Fetch and Edit Fee Sets<center>
 ;<FORM METHOD="POST" ACTION="POST^ZAA02GSQAD2"><TABLE WIDTH=70% CELLSPACING=0 CELLPADDING=2 BORDER=0>
 ;<TR><TD>From Code:<TD><input type="text" name="from" value="*1" size=6>
 ;<td rowspan=2>Fee&nbsp;Sets:<p><font size=-1>(Select all that are needed)<td rowspan=2><select name="sets" size="6" multiple>*3</select>
 ;</tr><tr><td>To Code:<td><input type="text" name="to" value="*2" size=6>
 ;<tr><td><td><input type="submit" name="SELECT" value="Select to display values in Excel"></table></center><hr>Part B - Update Database - Paste Changes here<center>
 ;<textarea name="changed" rows=10 columns=150 value="*4"></textarea>
 ;<input type="submit" name="SAVE" value="Update with Changes"><hr>
 ;
POST ;ZAA02GWEB
 S %1="%(""FORM"")" I $D(%("WEBPUT")) S %1="^ZAA02GWEBPUT(CON,CNT,0)"
 G SAVE:$G(@%1@("SAVE"))]""
 S TYPE="application/msexcel"
 S from=$G(@%1@("from")),to=$G(@%1@("to"))
 k SET I $D(@%1@("sets")) S A="",SET(+$P(@%1@("sets"),"Set ",2))="" F  S A=$O(@%1@("sets",A)) Q:A=""  S SET(+$P(@%1@("sets",A),"Set ",2))=""
 W "<TABLE>"
 W "<tr><th>Code</th><th>Description</th>" S B="" F  S B=$O(SET(B)) Q:B=""  w "<th>Fee "_B_"</th>"
 W "</tr>"
 S A="" F  S:from]"" A=$g(^PCG(from)) D:A]""  S from=$o(^PCG(from)) q:from=""  q:from>to
 . W "<TR><TD>",from,"</td><td>",$P(A,":",2),"</td>"
 . S B="" F  S B=$O(SET(B)) Q:B=""  S:B<13 C=$P("7,14,16,18,20,30,31,32,33,34,35,36,37",",",B+1),C=$P(A,":",C)/100 S:B>12 C=$P($G(^PCG(from,"FEE"_(B>50+1))),":",B+1) W "<td>",C,"</td>"
 . W "</tr>"
 W "</TABLE>",!
 Q
SAVE W "Following Data is Saved"
 k SET I $D(@%1@("sets")) S A="",SET(+$P(@%1@("sets"),"Set ",2))="" F L=3:1 S A=$O(@%1@("sets",A)) Q:A=""  S SET(+$P(@%1@("sets",A),"Set ",2))=""
 W "<TABLE>"
 W "<tr><th>Code</th><th>Description</th>" S B="" F  S B=$O(SET(B)) Q:B=""  w "<th>Fee "_B_"</th>"
 W "</tr>"
 S A=$G(@%1@("changed")),D="" F  D:A]""  S D=$O(@%1@("changed",D)) q:D=""  S A=@%1@("changed",D)
 . w "<tr><td>" I $L(A,$C(9))'=L W "<font color=""#ff0000"">"
 . S CD=$P(A,$C(9)) W CD,"</td><td>",$p(A,$c(9),2),"</td>" I $L(A,$C(9))'=L W "<td>row was not accepted - no change made</td></TR>",! q
 . S B="" F I=3:1 S B=$O(SET(B)) Q:B=""  S C=$P(A,$C(9),I)*100 S:B<13 E=$P("7,14,16,18,20,30,31,32,33,34,35,36,37",",",B+1),$P(^PCG(CD),":",E)=C S:B>12 $P(^PCG(CD,"FEE"_(B>50+1)),":",B+1)=C W "<td>",C/100,"</td>"
 . W "</tr>",!
 W "</TABLE>",! I %1["^ZAA02GWEBPUT" K ^ZAA02GWEBPUT(CON,CNT)
 Q
