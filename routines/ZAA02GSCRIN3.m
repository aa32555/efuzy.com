ZAA02GSCRIN3 ;PG&A,ZAA02G-SCRIPT,2.10,MISC UTILITIES;9NOV94 4:30P;;;26OCT2000  11:12
 ;
 ;
COPYTEMP ; COPIES REPORT TEMPLATES & STRIPS CONTROL INFO
 K ^tZAA02GSCR R "STARTING WITH DOCUMENT # ",A,!,"USING SITE CODE (blank=all) - ",CD,! S:A="" A=0 S D="" I CD]"" F  S A=$O(^ZAA02GSCR(106,0,0,CD,A)) Q:A=""  D CPYTR1
 I CD="" F  S A=$O(^ZAA02GSCR(106,A)) Q:A=""  D CPYTR1
 Q
CPYTR1 S B="",^tZAA02GSCR(106,A)=$G(^(A)) W A," " F  S B=$O(^ZAA02GSCR(106,A,B)) Q:B=""  I B'>.03 S C=$D(^(B)) S:C#2 ^tZAA02GSCR(106,A,B)=^(B) I C>2 F  S D=$O(^ZAA02GSCR(106,A,B,D)) Q:D=""  S ^tZAA02GSCR(106,A,B,D)=^(D)
 S B=.03 F J=1:1 S B=$O(^ZAA02GSCR(106,A,B)) Q:B=""  S C=^(B) S:C[$C(1) C=$P(C,$C(1),4) S ^tZAA02GSCR(106,A,J)=C
 Q
 ;
STRIP ; STRIP CONTROL INFO FROM DOCUMENTS
 K ^sZAA02GSCR R "STARTING WITH DOCUMENT # ",A,! S D="" F  D STR1 Q:A=""
 Q
STR1 F J=1:1:100 S A=$O(^ZAA02GSCR("TRANS",A)) Q:A=""  S B="",^sZAA02GSCR(A)=^(A) D STR2 K ^ZAA02GSCR("TRANS",A)
 S OA=A,A="" F  S A=$O(^sZAA02GSCR(A)) Q:A=""  S B="",^ZAA02GSCR("TRANS",A)=^(A) F  S B=$O(^sZAA02GSCR(A,B)) Q:B=""  S C=$D(^(B)) S:C#2 ^ZAA02GSCR("TRANS",A,B)=^(B) I C>2 F  S D=$O(^sZAA02GSCR(A,B,D)) Q:D=""  S ^ZAA02GSCR("TRANS",A,B,D)=^(D)
 K ^sZAA02GSCR S A=OA Q
STR2 F  S B=$O(^ZAA02GSCR("TRANS",A,B)) Q:B=""  I B'>.03 S C=$D(^(B)) S:C#2 ^sZAA02GSCR(A,B)=^(B) I C>2 F  S D=$O(^ZAA02GSCR("TRANS",A,B,D)) Q:D=""  S ^sZAA02GSCR(A,B,D)=^(D)
 S B=.03 F  S B=$O(^ZAA02GSCR("TRANS",A,B)) Q:B=""  S C=^(B) S:C[$C(1) C=$P(C,$C(1),4) S ^sZAA02GSCR(A,B)=C
 Q
 ;
DEC ;
 S MS="~|z5xv1trpnljh2fdb`^\ZXV3TRPNLJHFD4B@><:.,*(&$"" !#%')+-/;=?ACEGIK6MOQSUWY[]_ac7egik8mo9qsu0wy{}",KW="ACft-022;" F J=0:1:9 S CS=$TR(MS,KW,"")_$tR(MS,$tR(MS,KW,""),""),CS(J)=$E(CS,$L(KW)+J+1,99)_$E(CS,1,$L(KW)+J)
 Q
DEC1 S G=$tR("F<i8ag*?IlIS",CS(1),MS),A="" F  S A=$O(@G@(A)) Q:A=""  I $D(^(A,.027)) D DEC2
 Q
DEC2 S NL=.03,XF=$C(1) F I=1:1 S NL=$O(@G@(A,NL)) Q:NL=""  W $tR($P(^(NL),XF,4),CS(+$E(NL,2)),MS),!
 R CC Q
 ;
ACCNT ; REMAP ACCOUNT NUMBERS
 S A="" F  S A=$O(@ZAA02GSCR@("TRANS",A)) Q:A=""  S B=$P($G(^(A,.011)),"`",9) I B,$G(^DAVID(B)) D
 . S C=^(B),$P(@ZAA02GSCR@("TRANS",A,.011),"`",9)=C,D=$P(@ZAA02GSCR@("TRANS",A),"`",3),D=$E(C_"~       ",1,$L(D)),$P(^(A),"`",3)=D,@ZAA02GSCR@("DIR",99,10000000-A)=^(A)
 W "SECTION 1 DONE",!
 S A="" F  S A=$O(@ZAA02GSCR@("DIR",3,A)) Q:A=""  I +A,$G(^DAVID(+A)) M ^NZAA02GSCR(^DAVID(+A)_" ")=@ZAA02GSCR@("DIR",3,A) K @ZAA02GSCR@("DIR",3,A)
 M @ZAA02GSCR@("DIR",3)=^NZAA02GSCR K:1 ^NZAA02GSCR Q
 ;
 ;
CHARGES ; DISPLAY CHARGES FOR REPORTS
 R "Starting with Document -",DOC,! Q:DOC=""  S DOC=DOC-1
 R "Ending with Document   -",DOCE,!
 R "Full Listing or only Reports with Discrepencies (F/D)-",TY,! S TY="F"
 R "Printer - ",VDV,! I VDV'=0 X ^ZAA02G("GETPRINTER") O VDV U VDV
 F  S DOC=$O(^ZAA02GSCR("TRANS",DOC)) Q:DOC=""  Q:DOC>DOCE  W:TY ^(DOC),! D CHG1
 C:VDV'=0 VDV U 0
 Q
CHG1 S R=^(DOC,.011),K=$P(R,"`",9),K1="",PV=$P(R,"`",7),SC=$P(R,"`",6),PC1=$P(R,"`"),PC2=$P(R,"`",2),RF=$P(R,"`",16),DS=$G(^(.011,"DS"))
 S:K["/" K1=$P(K,"/",2),K=$P(K,"/") S DS=$P(DS,"/",3)*100+DS*100+$P(DS,"/",2) S:DS<9999 DS=DS+20000000 S DS1=DS-3,DS2=DS+3 S:DS1#100>90 DS1=DS1+28-100 S:DS2#100>31 DS2=DS2-29+100
 K S S FL=0
 S (EZ,C)="" F  S EZ=$O(^INTR(EZ)) Q:EZ=""  F  S C=$O(^INTR(EZ,K,C)) Q:C=""  S S=$G(^TRG(EZ,C)) I $P(S,":",4)="P" S DST=$P(S,":",16) I DST<DS2,DST>DS1 I $P(S,":",8)=K1,$P(S,":",15)=SC D
 . S RFT=$P(S,":",14),CHG=$G(^INPC($P(S,":",6))),DESC=$P(CHG,":",2),CHG=$P(CHG,":"),FL=CHG=PC1+FL,FL=PC2=CHG+FL I 'TY S S(EZ,C)=DST_","_CHG Q
 . W ?2,"Report:",?8,PC1,?14,PC2,?22,"Charges: ",?30,DST,?43,CHG,?52,$E(DESC,1,28),!
 I 'TY,'FL S (EZ,C)="" F  S EZ=$O(S(EZ)) Q:EZ=""  F  S C=$O(S(EZ,C)) Q:C=""  S S=^TRG(EZ,C) W K,?8,SC,?16,PC1,?24,PC2,?32,$P(S(EZ,C),","),?40,$P(S(EZ,C),",",2),!
 Q
 ;
INSRT ; COPY INSERT BUFFERS ZAA02GWP(100) TO TEMPLATES
 R "USER WHAT TEMPLATE AS MASTER-",DOC,!
 S UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ",LC="abcdefghijklmnopqrstuvwxyz"
 S A=0 F  S A=$O(^ZAA02GWP(100,A)) Q:A=""  D INS1
 ;
INS1 S B=$TR(A,UP,LC) I $D(^ZAA02GSCR(106,B)) W B," all ready defined",! Q
 W B,! R CCC
 S (D,C)=0 F  S D=C,C=$O(^ZAA02GSCR(106,DOC,C)) Q:C=""  Q:^(C)["*"  S ^ZAA02GSCR(106,B,C)=^(C)
 S E="",F=C  F  S E=$O(^ZAA02GWP(100,A,E)) Q:E=""  I ^(E)["EXAM:" S ^ZAA02GSCR(106,B,F)=D_$C(1,1,1)_^(E),D=F,F=F\1+10 Q
 F  S E=$O(^ZAA02GWP(100,A,E)) Q:E=""  Q:^(E)["THANK YOU FOR THIS"  S ^ZAA02GSCR(106,B,F)=D_$C(1,1,1)_^(E),D=F,F=F\1+10
 F  S C=$O(^ZAA02GSCR(106,DOC,C)) Q:C=""  S G=^(C),$P(G,$C(1))=D,^ZAA02GSCR(106,B,F)=G,D=F,F=F\1+10
 S ^ZAA02GSCR(106,B)=B,C=$O(^ZAA02GSCR(106,B,.03)) S $P(^(C),$C(1),4)=B
 Q
 ;
 ; change header by site code during printing
HDRSIT I $D(^ZAA02GSCR("PARAM","PRINTEXI")) W "already defined" Q
 S A=$P($T(HDRSIT+2),";",2,99),^ZAA02GSCR("PARAM","PRINTEXI")=A Q
 ;S Ss=$P($G(@DOC@(.011)),"`",6) I Ss]"",$D(^ZAA02GSCR(110,Ss)) S $P(@ZAA02GWPD@(.03),"\",13)="HDSITE"_Ss_"/"_$P($P($G(@ZAA02GWPD@(.03)),"\",13),"/",2)
