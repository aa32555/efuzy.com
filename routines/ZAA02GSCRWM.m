ZAA02GSCRWM ;  XFR WM FILES
 ;
A K ^ZAA02GSCG,^ZAA02GSCR(106,0) S (A,B,G)="",UCI="/usr/wp",UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ",LC="abcdefghijklmnopqrstuvwxyz"
 F J=1:1 S A=$O(^[UCI]WMT(1,A)) Q:A=""  W A," " D B
 Q
B G:A?1.2A1.N&("P1,P2,P3,P4,P5"'[A) C S C=$O(^[UCI]WMT(1,A,"")) Q:C=""  Q:$L(^(C))<40
 ; S G=G+1,^ZAA02GSCG(G)="",G=G+1,^ZAA02GSCG(G)="."_$TR(A,UP,LC) F J=1:1 S B=$O(^[UCI]WMT(1,A,B)) Q:B=""  S C=^(B) S G=G+1,^ZAA02GSCG(G)=$TR(C,"_><","")
 Q
 ;
C Q:A'?2A1.N  S C=$O(^[UCI]WMT(1,A,"")),H=$TR(A,UP,LC),I=$TR(^(C),"_>"),(^ZAA02GSCR(106,H),^ZAA02GSCR(106,H,.5))=.03_$C(1,1,1)_I,^(.03)="6\10\1\2\\\\\2\1\\\/FOOT\HEAD/FOOT\",^(.01)=65,^(.015)="VT220"
 S ^(.001)="|"_$J("",65)
 F J=1:1:13 S ^ZAA02GSCR(106,H,J/100+.5)=J-1/100+.5_$C(1,1,1)_$P($T(DATA+J),";",2,9)
 S B=J/100+.5 F J=1:1 S LB=B,B=$O(^[UCI]WMT(1,A,B)) Q:B=""  S C=^(B) S ^ZAA02GSCR(106,H,B)=LB_$C(1,1,1)_$TR(C,"_><","")
 S B=LB+1 F J=1:1:11 S ^ZAA02GSCR(106,H,B)=LB_$C(1,1,1)_$P($T(DATA1+J),";",2,9),LB=B,B=B+1
 Q
DATA ;
 ;                              ~$DS.D
 ;
 ;~$RFN.L
 ;~$RFA1.L
 ;~$RFA2.L
 ;~$RFCSZ.L
 ;                                    re: ~$PATIENT
 ;                                        ~$DOB ~$PXTR
 ;
 ;Dear Dr. ~$RFL.L,
 ;
 ;Examination of your patient reveals the following:
 ;
DATA1 ;
 ;*
 ;
 ;Thank you for referring this patient to us.
 ;
 ;                                    Yours truly,
 ;
 ;~$PVI12/~$TR.L                      ~$PL.LS12,M,K,G,C,Z,H,B
 ;~$CC1N
 ;~$CC2N
 ;~$CC3N
 ;
