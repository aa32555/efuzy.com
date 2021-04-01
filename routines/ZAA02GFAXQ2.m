ZAA02GFAXQ2 ;PG&A,ZAA02G-FAX,1.36,EDIT PHONEBOOK/RESEND;14SEP91  21:55;5SEP95 8:18A [ 08/22/96   9:32 AM ];;Tue, 26 Jun 2018  09:33
 ;Copyright (C) 1991-1994, Patterson, Gray and Associates Inc.
 ;
POP S Y=";16,13,38,PD;16,57,21,PDN;17,13,38,PD;20,15,1,PD1;21,15,1,PD1;20,27,1,PD1;21,27,1,PD1;20,47,1,PD3;21,47,1,PD2;20,62,1,PD2;21,62,1,PD3;20,72,1,PD4;21,72,1,PD5",TB=$C(2,1,0,3,2,1,0,5,4,3,2,1,0)
 S NE=$L(Y,";")-1,(OD,D)="",R=0 K X
 D REF
P4 F C=1:1:NE S D=$P(Y,";",C+1),%C=$P(D,",",2),LNG=$P(D,",",3),RD=$P(D,",",4),%R=+D,X=X(C),FNC="EX,HL,PD",RX=0 W @ZAA02GP D @RD S X(C)=X D:FNC["HL" HL S C=C+$S(FNC="EX":99,FNC="PD":99,RX=2:0,14[RX:-2,RX=3:$A(TB,C),1:0) S:C<0 C=0
 W ZAA02G("ROF") G:C>50 END S X=X(2)_"`"_X(1)_"`" F J=4:1:13 S X=X_X(J)_"`"
 S X=X_X(3),D=$TR(X(1),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ") K:D'=OD&$L(OD) ^ZAA02GFAXP(OD) S:D'="" ^ZAA02GFAXP(D)=X K K G POP
END K X,D,OD,K Q
PD X ^ZAA02GREAD S X=$TR(X,"\","") Q
PDZ D PDS X ^ZAA02GREAD I ESC S X=$S(RX=" ":" ",1:"*") W X I X="*" S:B1<11 RX=3 F CC=B1:1:B2 I C'=CC,X(CC)'="" S D=$P(Y,";",CC+1),%R=+D,%C=$P(D,",",2) W @ZAA02GP," " S X(CC)=""
 K B1,B2 Q
PD1 S B1=4,B2=7 D PDZ
 Q
PD2 D PDS X ^ZAA02GREAD I ESC S X=$S(RX=" ":" ",1:"*") W X
 Q
PD3 S CHR="YNPynp " X ^ZAA02GREAD I ESC S:X?1L X=$C($A(X)-32) W X
 Q
PD4 S CHR="ABCDabcd " X ^ZAA02GREAD I ESC S:X?1L X=$C($A(X)-32) W X
 Q
PD5 S CHR="479 " X ^ZAA02GREAD I ESC S:X?1L X=$C($A(X)-32) W X
 Q
PDS S TRM=" !#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~" Q
 ;
PDN S CHR="0123456789,W -" X ^ZAA02GREAD Q
 ;
HL D HLP S C=C-1 G REF
HLP S D=X(1) D HLP1 Q:D[";EX"  I $L(D)>1 S OD=D,D=^ZAA02GFAXP(D)
 S X(1)=$P(D,"`",2),X(2)=$P(D,"`"),X(3)=$P(D,"`",13) F J=3:1:12 S X(J+1)=$P(D,"`",J)
 Q
HLP1 N (ZAA02G,ZAA02GP,BL,D) S D=$TR(D,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ"),%R=BL-9,Y="4\DLHCS\1\PhoneBook\\",Y(0)="8\EX\^ZAA02GFAXP\$P(^(TO),$C(96),2);26`$P(^(TO),$C(96),13);25`$P(^(TO),$C(96));18R\"_D_"\\\"_D_"~" D ^ZAA02GFAXU2 S D=X Q
REF S %R=12,%C=2,B="",$P(B,ZAA02G("HL"),76)="" W @ZAA02GP,ZAA02G("LO"),ZAA02G("RON"),ZAA02G("L"),@ZAA02GP,ZAA02G("G1"),ZAA02G("TLC"),B,ZAA02G("TRC") F %R=%R+1:1:22 W @ZAA02GP,ZAA02G("G1"),ZAA02G("VL"),ZAA02G("G0"),$J("",75),ZAA02G("G1"),ZAA02G("VL"),ZAA02G("G0")
 S %R=%R+1 W @ZAA02GP,ZAA02G("G1"),ZAA02G("BLC"),B,ZAA02G("BRC"),ZAA02G("G0")
 S %C=10,%R=12 W @ZAA02GP,$P(Y,";") S ZAA02Gs=1
 I '$D(^ZAA02GFAXC("SCR",ZAA02Gs,0,ZAA02G,1)) S ZAA02GGLOB="^ZAA02GFAXC(""SCR"")",ZAA02GROUT="^ZAA02GFAXS1" D ^ZAA02GINTSCR
 W $P(^(1),"SUBJECT:",2,9) F I=2:1 Q:$D(^(I))=0  W ^(I)
 S %R=13,%C=4 W @ZAA02GP,ZAA02G("LO"),ZAA02G("RON"),"PHONEBOOK EDIT - Press HELP key for listings - make selection - Edit" S %R=14 W @ZAA02GP,"entry and press TAB to save, EXIT to not save, Clear & TAB to Delete"
 W ZAA02G("HI"),ZAA02G("ROF") F B=1:1:NE S D=$P(Y,";",B+1),%C=$P(D,",",2),LNG=$P(D,",",3),%R=+D W @ZAA02GP S:'$D(X(B)) X(B)="" W X(B),$J("",LNG-$L(X(B)))
 Q
T K X S BL=22 D POP Q
RESEND D SEL^ZAA02GFAXS Q:ZF="EX"  Q:X=""
RES1 S JOB=10000-X,B=^ZAA02GFAXQ("DIR",X) I $D(^ZAA02GFAXI(JOB))+$D(^ZAA02GFAXQ("SRC",JOB))=0 S MESS=1 G CAN1^ZAA02GFAXQ
 I '$D(RERROR) S X=$P(B,"\",4) D NUM Q:X=""  Q:X[";EX"  S:X'="" $P(B,"\",4)=X
 K ^ZAA02GFAXQ("DIR",10000-JOB,0) I $P(B,"\",9)>1 D PAGES Q:X[";EX"
 S:$P(B,"\",10)=7 $P(B,"\",33)=$P(B,"\",33)+1 S $P(B,"\",10)=$S($D(^ZAA02GFAXI(JOB))#2:2,1:1),$P(B,"\",3)="READY",$P(B,"\",14)=1,FAX=$P(B,"\",23),$P(B,"\",30)="",$P(B,"\",23)="",QC=1
 I $P(B,"\",37)["Interfax"!($P(B,"\",37)["Softlinx") S $P(B,"\",38,40)="",$P(B,"\",10)=1,$P(B,"\",3)="Resend" S:$D(^ZAA02GFAXI(JOB,1)) $P(^(1),",",3)=""
 D S1^ZAA02GFAXQ Q:$D(TFM)  S MESS=3 G CAN1^ZAA02GFAXQ
NUM S Y=$S('$D(ZAA02G(9)):"RESEND\Resend to",1:@ZAA02G(9)@(9)),%R=BL-5,Y="35\LHCD\1\ "_$P(Y,"\")_" #"_JOB_" *\\*,  "_$P(Y,"\",2)_":     *,*,",LNG=30,Y(0)="\EX" X "N B D ^ZAA02GFAXU2" Q
PAGES K Y,X S X="",Y(1)="All" F Y=1:1:$P(B,"\",9) S Y(Y+1)=Y
 S Y=$S('$D(ZAA02G(9)):"Resend Pages: (use SELECT key)",1:@ZAA02G(9)@(33)),%R=BL-4,Y="30\LCDM1AY\9\ "_Y_" \\*,    *,*,",Y(0)="\EX\" X "N B D ^ZAA02GFAXU2" Q:X[";EX"
 Q:","_X[",1,"  S ^ZAA02GFAXQ("DIR",10000-JOB,0)="S x="""_X_""" D PAGEX^ZAA02GFAXQ2" Q
PAGEX F X=1:1:$L(x,",") I $P(x,",",X) S PGN=$P(x,",",X)-1,x(PGN)=""
 F X=1:1:PGN S:'$D(x(X)) PG(X)=""
 S PG=x-1 K x Q
 ;
RERROR ; RESEND FAXES IN ERROR
 S xX="",TFM=1,BL=22,RERROR=1  F  S xX=$O(^ZAA02GFAXQ("DIR",xX)) I ^(xX)["ERROR"!(^(xX)["Fail-O") W !!!!,^(xX),!,"Resend (Y or N)-" R CC#1 I CC="Y" S X=xX D RES1 W " - resent",!
 Q
