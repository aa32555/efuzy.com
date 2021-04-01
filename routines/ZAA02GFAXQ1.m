ZAA02GFAXQ1 ;PG&A,ZAA02G-FAX,1.36,QUEUE DOCUMENT;14SEP91  21:55;22MAR93 10:07A;;18JAN2006  14:59
 ;Copyright (C) 1991-1994, Patterson, Gray and Associates Inc.
 ;
POP S Y="ZAA02G-FAX;13,13,38,PD;13,57,21,PDN;14,13,38,PD;16,13,38,PD;16,57,21,PDN;17,13,38,PD;20,15,1,PD1;21,15,1,PD1;20,27,1,PD1;21,27,1,PD1;20,47,1,PD3;21,47,1,PD2;20,62,1,PD2;21,62,1,PD3;20,72,1,PD4;21,72,1,PD5",TB=$C(2,1,0,2,1,0,3,2,1,0,5,4,3,2,1,0)
 S NE=$L(Y,";")-1,D="",R=0
 D REF
P4 F C=1:1:NE S D=$P(Y,";",C+1),%C=$P(D,",",2),LNG=$P(D,",",3),RD=$P(D,",",4),%R=+D,X=X(C),FNC="EX,HL,PD",RX=0 W @ZAA02GP D @RD S X(C)=X D:FNC["HL" HL S C=C+$S(FNC="EX":99,FNC="PD":99,RX=2:0,14[RX:-2,RX=3:$A(TB,C),1:0) S:C<0 C=0
 W ZAA02G("ROF") Q
PD X ^ZAA02GREAD S X=$TR(X,"\","|") Q
PDZ D PDS X ^ZAA02GREAD I ESC S X=$S(RX=" ":" ",1:"*") W X I X="*" S:B1<11 RX=3 F CC=B1:1:B2 I C'=CC,X(CC)'="" S D=$P(Y,";",CC+1),%R=+D,%C=$P(D,",",2) W @ZAA02GP," " S X(CC)=""
 K B1,B2 Q
PD1 S B1=7,B2=10 D PDZ
 Q
PD2 D PDS X ^ZAA02GREAD I ESC S X=$S(RX=" ":" ",1:"*") W X
 Q
PD3 S CHR="YNPSJynpsj " X ^ZAA02GREAD I ESC S:X?1L X=$C($A(X)-32) W X
 Q
PD4 S CHR="ABCDabcd " X ^ZAA02GREAD I ESC S:X?1L X=$C($A(X)-32) W X
 Q
PD5 S CHR="1479 " X ^ZAA02GREAD I ESC S:X?1L X=$C($A(X)-32) W X
 Q
PDS S TRM=" !#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~" Q
 ;
PDN S CHR="0123456789,W -#*" X ^ZAA02GREAD Q
 ;
HL I C=4!(C=5)!(C=6) D HLP G REF
 I C=1!(C=2) S D=$S('$D(ZAA02G(9)):"FROM INFORMATION\The FROM name and FAX NUMBER will appear\on the cover page.  Enter your name and\fax number here.",1:@ZAA02G(9)@(8)) G HLX
 I C=3 S D=$S('$D(ZAA02G(9)):"SUBJECT\Enter the general topic presented in this\fax.  This will both appear on the cover page\and on the status screens.",1:@ZAA02G(9)@(19)) G HLX
 I 78910[C S D=$S('$D(ZAA02G(9)):"SCHEDULING CHOICES\REGULAR    sent as soon as possible\PRIORITY   sent before REGULAR\DELAYED    send at time/date specified\ECONOMY    delay unless another is sent",1:@ZAA02G(9)@(23)) G HLX
 I C=11 S D=$S('$D(ZAA02G(9)):"COVER SHEET OPTIONS\Y     Full Page Cover Sheet\P     Partial Page Cover Sheet\N     Cover Sheet omitted\S     Full Page with Skip Option",1:@ZAA02G(9)@(25)) G HLX
 I C=12 S D=$S('$D(ZAA02G(9)):"PAGE NUMBER OPTIONS\You may specify that the page numbers\be printed on the bottom of each\faxed page.  Enter Y or N.  (Blank=N)",1:@ZAA02G(9)@(26)) G HLX
 I C=13 S D=$S('$D(ZAA02G(9)):"BORDER OPTIONS\Enter a Y if you want to include a line\border around the text of the fax or\enter N to skip border.  (Blank=N)",1:@ZAA02G(9)@(27)) G HLX
 I C=14 S D=$S('$D(ZAA02G(9)):"FULL PAGE OPTIONS\Enter a Y if you want to force a full\size page at the remote fax.  Enter a\N to allow a variable length page.\    (Blank=Y)",1:@ZAA02G(9)@(28)) G HLX
 I C=15 S D=$S('$D(ZAA02G(9)):"FONT OPTIONS\This option not currently used.",1:@ZAA02G(9)@(29)) G HLX
 I C=16 S D=$S('$D(ZAA02G(9)):"FAX SPEED OPTIONS\The fax speed is a negotiated value between the\two fax machines.  You can specify the fastest\speed for ZAA02G-FAX to start with as follows:\    1=14400  4=4800  7=7200  9=9600   Blank=9600",1:@ZAA02G(9)@(31)) G HLX
 W *7 S C=C-1 Q
HLP S D=X(4) I $P($G(ZAA02GSCRP),";",3)=2 I $D(^RFG),$D(^RFAH) D  Q
 . D HLP2 Q:D=""
 . S D=$G(^RFG(D)),X(4)=$P(D,":",$S($L($P(D,":",19))>3:19,1:2)),X(5)=$P(D,":",21)
 . I $G(^ZAA02GSCR("PARAM","FAXTOF_LOGIC"))]"" S FAXTOF=X(5) X ^("FAXTOF_LOGIC") S X(5)=FAXTOF
 I $P($G(ZAA02GSCRP),";",3)=3 I $D(^ZAA02GPROV) D HLP3 Q:D=""  S X(4)=$G(^ZAA02GPROV(D)),X(5)=$P($G(^ZAA02GPROV(D,1)),"`") Q
 D HLP1 Q:D[";EX"  I $L(D)>1 S D=^ZAA02GFAXP(D),FAXTO(0)=D
HLPE S X(4)=$P(D,"`",2),X(5)=$P(D,"`"),X(6)=$P(D,"`",13) F J=3:1:20 S X(J+4)=$P(D,"`",J)
 Q
HLP1 N (ZAA02G,ZAA02GP,BL,D)
 S D=$TR(D,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ"),%R=BL-9,Y="4\DLHCS\1\PhoneBook\\",Y(0)="8\EX\^ZAA02GFAXP\$P(^(TO),$C(96),2);26`$P(^(TO),$C(96),13);25`$P(^(TO),$C(96));18R\"_D_"\\\"_D_"~" D ^ZAA02GFAXU2 S D=X Q
HLP2 N (ZAA02G,ZAA02GP,BL,D) S %R=BL-9,Y="10\RHLSC\1",Y(0)="\EX\\$P(TO,""|"",2);4`$P(^RFG($P(TO,""|"",2)),"":"",2);30`$P(^RFG($P(TO,""|"",2)),"":"",21);15\"_D_"\\\"_D_"z"
 S ZAA02GPOPALT=$P($T(LOOKP),";",2,99)
 D ^ZAA02GPOP S:X["|" X=$P(X,"|",2) S:X[";EX" X="" S D=X Q
 Q
LOOKP ;S S=$P(TO,""|""),S2=$P(TO,""|"",2) F jj=1:1 S:S2="""" S=$O(^RFAH(S)) S:S="""" TO="""" S:S]TEN TO=""""  Q:TO=""""  S:$L(S) S2=$O(^RFAH(S,S2),-1) I $L(S2),$D(^RFG(S2)) S TO=S_""|""_S2 Q
HLP3 N (ZAA02G,ZAA02GP,BL,D) S %R=BL-9,Y="10\RHLSC\1",Y(0)="\EX\^ZAA02GPROV\TO;20`$G(^ZAA02GPROV(TO));30`$P($G(^(TO,1)),$C(96));12\"_D_"\\\"_D_"z" D ^ZAA02GFAXU2 S:X[";EX" X="" S D=X Q
 ;
HLX D HL1 S C=C-1 G REF
HL1 N (ZAA02G,ZAA02GP,BL,D) S $P(D,"\",2,9)="\"_$TR($P(D,"\",2,9),"\",","),%R=BL-8,Y="20\DLHCW25\1\"_D_",",Y(0)="\EX\\\\"_$S('$D(ZAA02G(9)):"PRESS RETURN",1:$P(@ZAA02G(9)@(20),"`",7)) D ^ZAA02GFAXU2 Q
REF S %R=12,%C=2,B="",$P(B,ZAA02G("HL"),76)="" W @ZAA02GP,ZAA02G("LO"),ZAA02G("RON"),ZAA02G("L"),@ZAA02GP,ZAA02G("G1"),ZAA02G("TLC"),B,ZAA02G("TRC") F %R=%R+1:1:22 W @ZAA02GP,ZAA02G("G1"),ZAA02G("VL"),ZAA02G("G0"),$J("",75),ZAA02G("G1"),ZAA02G("VL"),ZAA02G("G0")
 S %R=%R+1 W @ZAA02GP,ZAA02G("G1"),ZAA02G("BLC"),B,ZAA02G("BRC"),ZAA02G("G0")
 S %C=10,%R=12 W @ZAA02GP,$P(Y,";") S ZAA02Gs=1
 I '$D(^ZAA02GFAXC("SCR",ZAA02Gs,0,ZAA02G,1)) S ZAA02GGLOB="^ZAA02GFAXC(""SCR"")",ZAA02GROUT="^ZAA02GFAXS1" D ^ZAA02GINTSCR
 F I=1:1 Q:$D(^(I))=0  W ^(I)
 W ZAA02G("HI"),ZAA02G("ROF") F B=1:1:NE S D=$P(Y,";",B+1),%C=$P(D,",",2),LNG=$P(D,",",3),%R=+D W @ZAA02GP S:'$D(X(B)) X(B)="" W X(B),$J("",LNG-$L(X(B)))
 Q
