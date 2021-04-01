ZAA02GSCRBO ;PG&A,ZAA02G-SCRIPT,2.10,DOCUMENT BOLDING;2018-02-28 12:30:21;26APR95 9:58A;;25JAN2007  16:22
 ;Copyright (C) 1992, Patterson, Gray & Associates, Inc.
 ;
 ; CALLED FROM BACKGROUND PROCESS (ZAA02GSCRMS1) TO UNDERLINE OR BOLD
 ;
BOLD ; SCAN REPORT & BOLD PATIENT INFO & IMPRESSION
 ;     FORMAT ASSUMED: (only looks for Capitalized lines)
 ;        RE:  xxxxx          bolded until non-indented para
 ;        IMPRESSION:  xxxx    (same as RE:)
 ;
 D BOLDINIT
BOLD0 F  S K=$O(@ZAA02GWPD@(K)) G:K="" END I ^(K)["IMPRESSION: "!(^(K)["RE: ") Q
 F  S J=K,K=$O(@ZAA02GWPD@(K)) S:$P(^(J),$C(1),4)'="" $P(^(J),$C(1),4)=K1_$P(^(J),$C(1),4)_K2 G:K="" END Q:" "'[$E($P(^(K),$C(1),4))
 G BOLD0
END K K1,K2,K3 Q
BOLDINIT D REVERS^ZAA02GWPPC1 S K=.03,K1=$G(ZAA02G("ron")),K2=$G(ZAA02G("rof")) Q
BOLDX ; BOLD VERSION FOR ASSOCIATED
 ;    FORMAT ASSUMED
 ;       BOLD ALL LINES WITH CAPS ":"
 ;       BOLDS STUDY AND ENTIRE IMPRESSION ONLY
 D BOLDINIT
BOLDX0 F  S K=$O(@ZAA02GWPD@(K)) G:K="" END I $P(^(K),$C(1),4)?4.U1":".E!($P(^(K),$C(1),4)?4.U.UP) S $P(^(K),$C(1),4)=K1_$P(^(K),$C(1),4)_K2
 ;
 ;
BOLDM ; BOLD VERSION to underline study and bold impression
 ;    FORMAT ASSUMED
 ;       Underline/Bold STUDY: and IMPRESSION:, bold remainder of IMPRESSION
 ;       assumes study is all uppercase
 D BOLDINIT Q:'$D(ZAA02G("uo"))  F  S K=$O(@ZAA02GWPD@(K)) G:K="" END Q:^(K)["following:"
BOLDM0 F  S K=$O(@ZAA02GWPD@(K)) G:K="" END Q:$P(^(K),$C(1),4)?1.UP
BOLDM1 S $P(^(K),$C(1),4)=K1_ZAA02G("uo")_$P(^(K),$C(1),4)_ZAA02G("uf")_K2
 F  S K=$O(@ZAA02GWPD@(K)) G:K="" END I ^(K)["IMPRESSION:" S $P(^(K),$C(1),4)=K1_ZAA02G("uo")_"IMPRESSION:"_ZAA02G("uf")_$P(^(K),"IMPRESSION:",2) Q
 F  S Y=K,K=$O(@ZAA02GWPD@(K)) Q:K=""  I ($P(^(Y),$C(1),4)_$P(^(K),$C(1),4)="")!(^(K)["Thank you") S ^(Y)=^(Y)_K2 G BOLDM0:^(K)'["Thank you",END
 S ^(Y)=^(Y)_K2 G END
 ;
BOLDR ; BOLD VERSION FOR REGIONAL RADIOLOGY
 ;    FORMAT ASSUMED
 ;       STUDY CONTAINS ":"
 ;       BOLDS STUDY AND ENTIRE IMPRESSION ONLY
 D BOLDINIT
BOLDR0 F  S K=$O(@ZAA02GWPD@(K)) G:K="" END Q:^(K)[":"&(^(K)'["NAME:")&(^(K)'["DATE:")
BOLDR1 S $P(^(K),$C(1),4)=K1_$P($P(^(K),$C(1),4),":")_":"_K2_$P(^(K),":",2,99)
 F  S K=$O(@ZAA02GWPD@(K)) G:K="" END I ^(K)["IMPRESSION:"!(^(K)["CONCLUSION:") S $P(^(K),$C(1),4)=K1_$P(^(K),$C(1),4) Q
 F  S Y=K,K=$O(@ZAA02GWPD@(K)) Q:K=""  I ($P(^(Y),$C(1),4)_$P(^(K),$C(1),4)="")!(^(K)[":") S ^(Y)=^(Y)_K2 G BOLDR0:^(K)'[":",BOLDR1
 S ^(Y)=^(Y)_K2 G END
 ;
UNDERZ ; same as UNDER but no Dear and no ":"
 D BOLDINIT Q:'$D(ZAA02G("uo"))
UNDERZ0 F  S K=$O(@ZAA02GWPD@(K)) G:K="" END I $P(^(K),$C(1),4)?1U.UNP,^(K)'[":" D UNDERZ1 Q
 F  S K=$O(@ZAA02GWPD@(K)) G:K="" END I $P(^(K)," ")["IMPRESSION"!($P(^(K)," ")["CONCLUSION") D UNDER2 Q
 G UNDERZ0
UNDERZ1 S $P(^(K),$C(1),4)=ZAA02G("uo")_K1_$P(^(K),$C(1),4)_ZAA02G("uf")_K2
 S K=$O(@ZAA02GWPD@(K)) Q:K=""  I $P(^(K),$C(1),4)?1U.UNP,^(K)'[":" G UNDERZ1
 Q
UNDER ; UNDERLINES AND BOLDS UPPERCASE STUDY AND THE WORD IMPRESSION
 D BOLDINIT Q:'$D(ZAA02G("uo"))
 F  S K=$O(@ZAA02GWPD@(K)) G:K="" END I $P(^(K),$C(1),4)["Dear" Q
UNDER0 F  S K=$O(@ZAA02GWPD@(K)) G:K="" END I $P(^(K),$C(1),4)?1U.UNP D UNDER1 Q
 F  S K=$O(@ZAA02GWPD@(K)) G:K="" END I $P(^(K)," ")["IMPRESSION"!($P(^(K)," ")["CONCLUSION") D UNDER2 Q
 G UNDER0
UNDER1 S $P(^(K),$C(1),4)=ZAA02G("uo")_K1_$P(^(K),$C(1),4)_ZAA02G("uf")_K2 Q:$O(^(K))=""
 S K=$O(@ZAA02GWPD@(K)) G:$P(^(K),$C(1),4)?1U.UNP UNDER1 Q
UNDER2 S $P(^(K),$C(1),4)=ZAA02G("uo")_K1_$P($P(^(K),$C(1),4)," ")_ZAA02G("uf")_K2_" "_$P($P(^(K),$C(1),4)," ",2,99)
 Q
UNDBOLX ;UNDERLINE/BOLD XXXXXX: TEXT & PATIENT NAME FOLLOWING RE: OR PATIENT:
 D BOLDINIT Q:'$D(ZAA02G("uo"))
UNDBOLXO F J=1:1 S K=$O(@ZAA02GWPD@(K)) G:K="" END S J=$P(^(K),$C(1),4) I J[":" D @("UNDBOLX"_$S(J?.E1" RE: ".E:1,J?.E1"PATIENT:".E:2,J?1U.UP1":".E:3,1:4))
 Q
UNDBOLX1 S $P(^(K),$C(1),4)=$P(J,"RE: ")_"RE: "_K1_ZAA02G("uo")_$P(J,"RE: ",2)_K2_ZAA02G("uf") Q
UNDBOLX2 S $P(^(K),$C(1),4)=$P(J,"PATIENT: ")_"PATIENT: "_K1_ZAA02G("uo")_$P(J,"PATIENT: ",2)_K2_ZAA02G("uf") Q
UNDBOLX3 S $P(^(K),$C(1),4)=ZAA02G("uo")_K1_$P(J,":")_":"_ZAA02G("uf")_K2_$P(J,":",2,9) Q
UNDBOLX4 Q
 ;
UNDBOLW ;UNDERLINE/BOLD XXXXXX: ON LEFT EDGE + BOLDS ASSESSMENT: AND RECOMMENDATION:
 D BOLDINIT Q:'$D(ZAA02G("uo"))
UNDBOLWO F J=1:1 S K=$O(@ZAA02GWPD@(K)) G:K="" END S J=$P(^(K),$C(1),4) I J?1U.UP1":".E D @("UNDBOLW"_$S(J?1"RECOMMENDATION:".E:1,1:3))
 Q
UNDBOLW1 S Y="RECOMMENDATION:"
UNDBOLW4 S $P(^(K),$C(1),4)=$P(J,Y)_K1_Y_K2_$P(J,Y,2,9) Q
UNDBOLW3 S $P(^(K),$C(1),4)=ZAA02G("uo")_K1_$P(J,":")_":"_ZAA02G("uf")_K2_$P(J,":",2,9) I J["ASSESSMENT:" S Y="ASSESSMENT:" G UNDBOLW4
 Q
 ;
UNDBOL ; UNDERLINE/BOLD UPPERCASE STUDY AND BOLD EXAM & WORD IMPRESSION
 D BOLDINIT Q:'$D(ZAA02G("uo"))
UNDBOL0 F J=1:1 S K=$O(@ZAA02GWPD@(K)) G:K="" END S J=$P(^(K),$C(1),4) I J[":" D @("UNDBOL"_$S(J?.P1"Exam: ".E:1,J["IMPRESSION:":2,J["CONCLUSION:":2,J?1U.UP1":".E:3,1:4))
 Q
UNDBOL1 S $P(^(K),$C(1),4)=$P(J,"Exam: ")_"Exam: "_K1_$P(J,"Exam: ",2)_K2 Q
UNDBOL2 S $P(^(K),$C(1),4)=K1_$P(J,":")_":"_K2_$P(J,":",2,9) Q
UNDBOL3 S $P(^(K),$C(1),4)=ZAA02G("uo")_K1_$P(J,":")_":"_ZAA02G("uf")_K2_$P(J,":",2,9) Q
UNDBOL4 Q
 ;
BOLDN ; BOLD VERSION for Nassau Radiology
 D BOLDINIT
BOLDN0 F  S K=$O(@ZAA02GWPD@(K)) G:K="" END Q:^(K)[":"
BOLDN1 S $P(^(K),$C(1),4)=K1_$P($P(^(K),$C(1),4),":")_":"_K2_$P(^(K),":",2,99)
 F  S K=$O(@ZAA02GWPD@(K)) G:K="" END I ^(K)["IMPRESSION:"!(^(K)["CONCLUSION:") S $P(^(K),$C(1),4)=K1_$P(^(K),$C(1),4) Q
 F  S Y=K,K=$O(@ZAA02GWPD@(K)) Q:K=""  I ($P(^(Y),$C(1),4)_$P(^(K),$C(1),4)="")!(^(K)?.E1":".P) S ^(Y)=^(Y)_K2 G BOLDN0:^(K)'?.E1":".P,BOLDN1
 S ^(Y)=^(Y)_K2 G END
 ;
BOLDJ ; BOLD VERSION for Associated Radiologists
 ; BOLDS ALL HEADINGS: AND STUDY - DOESN'T BOLD TEXT AFTER HEADING
 D BOLDINIT
 F  S K=$O(@ZAA02GWPD@(K)) G:K="" END D @$S(^(K)?.E1.UP1":".E:"BOLDJ1",$P(^(K),$C(1),4)?3.U.UP:"BOLDJ2",1:"BOLDJ3")
BOLDJ1 F J=1:1:$L(^(K),":")-1 S L=$P(^(K),":",J) D BOLDJ0 S $P(^(K),":",J,J+1)=L_":"_K2_$P(^(K),":",J+1)
 Q
BOLDJ0 F I=$L(L):-1:2 I $A(L,I)<33,$A(L,I-1)<33 S L=$E(L,1,I)_K1_$E(L,I+1,99) Q
 Q
BOLDJ2 S $P(^(K),$C(1),4)=K1_$P(^(K),$C(1),4)_K2 Q
BOLDJ3 Q
 ;
BOLDV ; BOLD text after PATIENT:, EXAM:, CONCLUSION:/IMPRESSION:
 D BOLDINIT
 F  S K=$O(@ZAA02GWPD@(K)) G:K="" END I ^(K)["PATIENT:" S ^(K)=$P(^(K),":")_":"_K1_$P($P(^(K),":",2,99),"     ")_K2_$P($P(^(K),":",2,99),"     ",2,9) Q
 S K=$O(@ZAA02GWPD@(K)) G:K="" END I ^(K)["EXAM:" S ^(K)=$P(^(K),":")_":"_K1_$P($P(^(K),":",2,99),"     ")_K2_$P($P(^(K),":",2,99),"     ",2,9)
BOLDV0 F  S K=$O(@ZAA02GWPD@(K)) G:K="" END Q:^(K)["IMPRESSION:"!(^(K)["CONCLUSION:")
BOLDV1 S ^(K)=$P(^(K),":")_":"_K1_$P(^(K),":",2,99)
 F  S Y=K,K=$O(@ZAA02GWPD@(K)) Q:K=""  I ($P(^(Y),$C(1),4)_$P(^(K),$C(1),4)="")!(^(K)[":") S ^(Y)=^(Y)_K2 G BOLDV0:^(K)'[":",BOLDV1
 S ^(Y)=^(Y)_K2 G END
 ;
BOLDZ ; BOLD VERSION for Raritan Radiology
 D BOLDINIT
 F  S K=$O(@ZAA02GWPD@(K)) G:K="" END I ^(K)["PATIENT:" S $P(^(K),$C(1),4)=$P($P(^(K),$C(1),4),":")_":"_K1_$P($P(^(K),":",2,99),"     ")_K2_$P($P(^(K),":",2,99),"     ",2,9) Q
BOLDZ0 F  S K=$O(@ZAA02GWPD@(K)) G:K="" END Q:^(K)[":"&(^(K)?.E3.A1":".E)
BOLDZ1 S $P(^(K),$C(1),4)=K1_$P(^(K),$C(1),4)_K2
 F  S Y=K,K=$O(@ZAA02GWPD@(K)) Q:K=""  I ($P(^(Y),$C(1),4)_$P(^(K),$C(1),4)="")!(^(K)[":") S ^(Y)=^(Y)_K2 G BOLDZ0:^(K)'[":",BOLDZ1
 S ^(Y)=^(Y)_K2 G END
 ;
BOLDI ; BOLDS ONLY THE WORD IMPRESSION:
 D BOLDINIT
BOLDI1 F  S K=$O(@ZAA02GWPD@(K)) G:K="" END Q:^(K)["IMPRESSION:"
 S $P(^(K),$C(1),4)=K1_$P($P(^(K),$C(1),4),":")_":"_K2_$P(^(K),":",2,99) G BOLDI1
 ;
 ;BOLDI;Bolds only the word IMPRESSION
 ;BOLDN;Bolds line ending in ":", then entire IMPRESSION/CONCLUSION
 ;BOLDZ;Bolds name after PATIENT:, then entire ?.E3A1":".E paragraph
 ;BOLDV;Bolds text after PATIENT:/EXAM:/INPRESSION:/CONCLUSION:
 ;BOLDR;Bolds XXXXXXXX: and entire IMPRESSION/CONCLUSION
 ;BOLDM;Underline/bold study and word IMPRESSION:, bold remainder
 ;UNDBOL;Underline/bolds word Exam:, XXXXX: and IMPRESSION:
 ;UNDBOLX;Underline/bolds XXXXXX:, and text after RE:/PATIENT:
 ;UNDBOLW:Underline/bolds XXXXXX:, and bolds ASSESS/RECOMM:
 ;UNDER;Underline/bold XXXXXXXX line after Dear and IMPRESSION:/CONC
 ;UNDERZ; same as UNDER but no "Dear" search and no ":" on study
 ;
