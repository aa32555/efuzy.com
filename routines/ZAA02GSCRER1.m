ZAA02GSCRER1 ;PG&A,ZAA02G-SCRIPT,2.10,ADD/EDIT REPORT - 2;21NOV94 7:58A;19MAR2002  22:12;;Thu, 14 DeC 2017  16:26
 ;Copyright (C) 1992, Patterson, Gray & Associates, Inc.
VAR S J=0 I RX=99 S RX=9998 Q
 G VAR3:X=""  G:$D(@ZAA02GSCR@(106,X))#2=0 VAR3 S A=$P(^(X,.03),"\",15,21) S:$P(A,"\")'="" J=J+1,opi(J)="PDSP;PROC1;A("_J_")",A(J)=$P(A,"\") S:$P(A,"\",2)'="" INP("NOTES")=$P(A,"\",2),J=J+1,opi(J)="PDSP;NOTES;INP(""NOTES"")"
 S:$P(A,"\",3)'="" J=J+1,opi(J)="PDSP;DIST;A("_J_")",A(J)=$P(A,"\",3)
 K:$E($G(INP("eS")),1,2)="YC" INP("eS") S:$P(A,"\",7)="Y" INP("eS")="YC" ; cosign
 I J S opi=J,SRF=rf,rf=ZAA02G("HI") x op S rf=SRF K SRF,A
 I 1 Q
VAR1 S J=0 I RX=99 S RX=9998 Q
 G VAR3:X=""  G:$D(@ZAA02GSCR@(106,X))#2=0 VAR3 S A=$P(^(X,.03),"\",15) S:A'="" J=J+1,opi(J)="PDSP;PROC2;A("_J_")",A(J)=A
 I J S opi=J,SRF=rf,rf=ZAA02G("HI") x op S rf=SRF K SRF,A
VAR3 I 1 Q         ;
SITE S SITEDIST=1 Q:X=""  I $D(@ZAA02GSCR@("PARAM","DIST",X)) S opi="PDSP;DIST;X" X op
 I 1 Q
NEW D SET I ZAA02GSCRP["W" D MAMMO^ZAA02GSCMR K TYPS Q:$D(editX)  I OSET]"",$O(@ZAA02GWPD@(.03))="",'$D(^(.0115,5)) S OSET=""
 G:OSET="" COPY I OT=REP!(OT="") G ALLV
 D RPTCHG^ZAA02GSCRSP I '$T G ALLV
 S A=.03 K @ZAA02GWPD@(A) F J=1:1 S A=$O(^(A)) Q:A=""  K ^(A)
 ;
COPY S NREP=0,CVT="" F IREP="",1:1:9 I $G(INP("TEMPLATE"_IREP))]"" D
 . S NREP=NREP+1,R=INP("TEMPLATE"_IREP),CVT(NREP)=R,CVT=CVT_($D(@ZAA02GSCR@(106,R,.0115,5))>0)
 G COPY2:'$D(HANDLE),COPY2:CVT'[1
 I CVT[0 F IREP=1:1:NREP I $E(CVT,IREP)=0 D
 . S R=CVT(IREP) N (R,ZAA02GSCR,ZAA02GWPD,ZAA02GSCRP,LC,UP) S DOC=R,DIR=106,PGMG=$G(@ZAA02GWPD@(.03)),B=""
 . D HEAD^ZAA02GVBTER,HEAD2^ZAA02GVBTER,TORTF^ZAA02GVBTER,HEAD3^ZAA02GVBTER ; CONVERSION
 . S RTF=B D SAVERTF^ZAA02GVBTER1
 S R=CVT(1) M @ZAA02GWPD@(.0115)=@ZAA02GSCR@(106,R,.0115)
 S (PGMG,@ZAA02GWPD@(.03))=$G(@ZAA02GSCR@(106,R,.0113),$G(@ZAA02GSCR@(106,R,.03)))
 S END="}",B=$O(@ZAA02GWPD@(.0115,""),-1) S:B<5 B=5 S ^(B)=$E($G(^(B)),1,$L($G(^(B)))-1)
 ; not used - footers comes from GETRTF
 ; I $P(PGMG,"\",13,14)'?.P S PGMG=$TR($P(PGMG,"\",13,14),"\","/") D
 . F J=1:1:4 S C=$P(PGMG,"/",J) I C]"",$D(@ZAA02GSCR@(110,C,.0115)) D
 .. S C=$G(^(.0115,5))_$G(^(6))_$G(^(7)) D
 ... I C["\pard" S C="\pard"_$P(C,"\pard",2,999) Q
 ... Q:C'[$C(13,10)  S C=$P(C,$C(13,10),$L(C,$C(13,10)))
 .. I J=4 S END=C Q
 .. S @ZAA02GWPD@(.0115,$P("1,3,2,4",",",J))="{\"_$P("headerf,footerf,header,footer",",",J)_C
 I $D(CVT(2)) F IREP=2:1:NREP D
 . S R=CVT(IREP) S B="\par " F J=5:1 Q:'$D(@ZAA02GSCR@(106,R,.0115,J))  S B=B_^(J)
 . I B["\pard" S B="\pard\par"_$P(B,"\pard",2,999),B=$E(B,1,$L(B)-1)
 . E  S B="report template - "_R_" contains bad format"
 . S E=$O(@ZAA02GWPD@(.0115,""),-1)+1 F J=1:500:$L(B) S ^(E)=$E(B,J,J+499),E=E+1
 S B=$O(@ZAA02GWPD@(.0115,""),-1) S:B<5 B=5 S ^(B)=^(B)_END
 G ALLV
COPY2 S C=0 I ZAA02GSCRP["I" S REP=@ZAA02GSCR@("PARAM","INSHDR"),REPD=ZAA02GSCR_"(110)" X:REP[":" $P(REP,":",2) I  S REP=$P(REP,":") D CPT
 S REPD=ZAA02GSCR_"(106)" F IREP="",1:1:9 I $G(INP("TEMPLATE"_IREP))]"" S REP=INP("TEMPLATE"_IREP) D CPT
 K IREP,REPD G ALLV
CPT K SA,EA I NREP=1 G CP
 I IREP<NREP F J="PVI","TR" S K=$O(@REPD@(REP,0,J,"")) I K S EA=$S($G(EA)="":K,EA>K:K,1:EA)
 I IREP>0 F J="PN","RFCS","RFCSZ","DS" S K=$O(@REPD@(REP,0,J,"")) I K S SA=$S($G(SA)="":K,SA<K:K,1:SA)
CP Q:'$D(@REPD@(REP))  K VAR,D,MCE,LIST S ALLVAR=$G(ALLVAR),B=""
 I REPD[106,'$D(@ZAA02GWPD@(.03)) S A=0 F J=1:1 S A=$O(@REPD@(REP,A)) Q:A=""  Q:A>.03  I $L(A)'=5 S D=$D(^(A)) S:D=1 @ZAA02GWPD@(A)=^(A) M:D>1 @ZAA02GWPD@(A)=@REPD@(REP,A)
 S (K,L)="" F J=1:1 S K=$O(@REPD@(REP,0,K)) Q:K=""  D:'$D(BT(K)) CP1 F J=1:1 S L=$O(@REPD@(REP,0,K,L)) Q:L=""  S VAR(L)=$S($D(VAR(L)):VAR(L)_","_K,1:K)
 S PGMG2=$G(@REPD@(REP,.03),$G(@REPD@(REP,.0113))) I PGMG2]"" S B=$TR($P(PGMG2,"\",13,14)_","_$P(PGMG2,"\",18),"\/",",,") F L=1:1:$L(B,",") S D=$P(B,",",L) I D'="",$O(@ZAA02GSCR@(110,D,0,""))'="" S K="" F J=1:1 S K=$O(^(K)) Q:K=""  D:'$D(BT(K)) CP1
 I ZAA02GSCRP["G" S D=@ZAA02GSCR@("PARAM","GETVAR") F L=1:1:$L(D,",") S K=$P(D,",",L) D:'$D(BT(K)) CP1
 D:ALLVAR]"" ^ZAA02GSCRVB S ALLVAR="",A=$O(@REPD@(REP,$G(SA,.03)))
 F J=1:1 S A=$O(@REPD@(REP,A)) Q:A=$G(EA)  S C=C+100,@ZAA02GWPD@(C)=C-100_$C(1,1,1)_$P(^(A),$C(1),4) I $D(VAR(A)) D CP2
 S @ZAA02GWPD@(C+100)=C_$C(1,1,1),^(C+200)=C+100_$C(1,1,1),C=C+200,J=$O(@ZAA02GWPD@(.03)) I J S $P(^(J),$C(1))=.03
 D:$D(MCE) CP^ZAA02GSCRCE X:$D(LIST) LIST K ALLVAR,VAR,D,B Q
ALLV D:$G(ALLVAR)]"" ^ZAA02GSCRVB S B=$D(@ZAA02GWPD@(.011,0)) F B="NORM","NOTE","STAT","eS","FAX" I $G(INP(B))="" K ^(B),INP(B)
 I DIR="TRANS",$G(INP("message"))]"" S B=INP("message") D  S B=$D(@ZAA02GWPD@(.011,0))
 . I B["Addendum to " S INP("STATUS")="A",J=+$P(B,"to ",2) I $D(@ZAA02GSCR@("TRANS",J))#2 D
 .. S Y=^(J) I $G(^(J,.011,"message"))'[DOC S ^("message")=$G(^("message"))_" Addendum in "_DOC
 .. S $P(Y,"`",14)=$TR($P(Y,"`",14),"C")_"C",@ZAA02GSCR@("TRANS",J)=Y,@ZAA02GSCR@("DIR",99,10000000-J)=Y
 S B="" F J=1:1 S B=$O(INP(B)) Q:B=""  I '$D(BT(B)) S ^(B)=INP(B)
 K BT Q
CP1 I $E(K)="$" Q
 I '$D(D(K)) S D(K)="" S:'$D(INP(K)) ALLVAR=ALLVAR_K_","
 Q
CP2 S L=$P(@ZAA02GWPD@(C),$C(1),4) F K=1:1:$L(VAR(A),",") S D=$P(VAR(A),",",K) I D'="" S T=$S($D(INP(D)):INP(D),1:"") D @$S($E(D)'="$":"F1",1:"F2")
 I L=" " K @ZAA02GWPD@(C) S C=C-100 Q
 S $P(@ZAA02GWPD@(C),$C(1),4)=L Q
F1 S W="~$"_D,J=T,F=$F(L,W),Y="" Q:F<2  I $E(L,F,F+1)?1"."1A S Y=$E(L,F,F+1),F=F+2 S:$E(L,F)?1A Y=Y_$E(L,F),F=F+1
 D:Y["LS" LIST^ZAA02GSCRVB D:Y["D" FCAL D:Y["d" FDT S:Y["CC"&(J]"") J="cc: "_J S W=W_Y S:Y["X" J=$TR(J,LC,UP) I Y["x" D LC^ZAA02GSCRVB
 I Y["R" S L=$E(L,0,F-$L(W)-1)_$J("",$L(W))_$E(L,F,9999),L=$E(L,0,F-$L(J)-1)_J_$E(L,F,9999)
 I Y["L" S B=$S(" "'[$E(L,F):$P($E(L,F,9999)," "),1:""),L=$S($E(L,F-$L(W),F-$L(W)+$L(J_B)-1)[$C(27):$E(L,1,F-$L(W)),1:L),L=$E(L,0,F-$L(W)-1)_$J("",$L(W_B))_$E(L,F+$L(B),9999),L=$E(L,0,F-$L(W)-1)_J_B_$E(L,F-$L(W)+$L(J_B),9999)
 I Y["C",$L(Y,"C")#2=0 S L=$E(L,0,F-$L(W)-1)_$J("",$L(W))_$E(L,F,9999),F=F-($L(W)+$L(J)+1\2),L=$E(L,0,F-1)_J_$E(L,F+$L(J),9999)
 I L[W S L=$E(L,0,F-$L(W)-1)_J_$E(L,F,9999)
 G:L[("~$"_D) F1 Q
F2 S MCE(D,C)="" Q
FCAL S:T?7N T=$E(T,4,5)_"/"_$E(T,6,7)_"/"_(1900+$E(T,1,3))
 S:T'="" J=$P("January,February,March,April,May,June,July,August,September,October,November,December",",",+T)_" "_(+$P(T,"/",2))_", "_$S($P(T,"/",3)<30:20,$P(T,"/",3)<100:19,1:"")_$P(T,"/",3) Q
FDT Q:T=""  Q:$L(T)>8  S T=$P(T,"/",1,2)_"/"_$S($P(T,"/",3)<30:20,$P(T,"/",3)<100:19,1:"")_$P(T,"/",3) Q
 ;
 ;
DIR I Y="" K @ZAA02GSCR@("DIR",99,10000000-DOC),@ZAA02GSCR@("TRANS",DOC) S $P(OSET,"`")=0
 I $G(TRTYPE)'<1,$D(ESREMOVE) S C=$G(@ZAA02GWPD@(.011,"eS")) D  S $P(Y,"`",13)=$TR($P(Y,"`",13),"EP")
 . I C]"" F A=2,3 S L=$P(C,"\",A) F J=1:1:$L(L,",") S K=$P(L,",",J) I K]"" K @ZAA02GSCR@("DIR",48,K,-(10000000-DOC))
 S:Y]"" @ZAA02GWPD=Y,@ZAA02GSCR@("DIR",99,10000000-DOC)=Y,$P(Y,"`")=0
 S Y=$TR(Y,LC_"~ ,-:.",UP),OSET=$TR(OSET,LC_"~ ,-:.",UP)
 F J=2:1:8,12 I $P(OSET,"`",J)'=$P(Y,"`",J) S A=$P(OSET,"`",J),L=$P(Y,"`",J),K=$P(",2,3,4,5,6,6,7,,,,11",",",J) K:A]"" @ZAA02GSCR@("DIR",K,$S(+A=A:A_" ",1:A),10000000-DOC) S:L]"" @ZAA02GSCR@("DIR",K,$S(+L=L:L_" ",1:L),10000000-DOC)=""
 F J="R","I","H" I $P(OSET,"`",13)[J K @ZAA02GSCR@("DIR",12,J,10000000-DOC)
 Q
 ;
SET G:OSET'="" SET1 S Y=+$G(@ZAA02GSCR@("DIR",98,YM_$E(DY+100,2,3))),DOC=$G(@ZAA02GSCR@("PARAM","NEXT"))-50 S:DOC<1 DOC=1 S:DOC<Y DOC=Y I Y=0 S DOC=$O(@ZAA02GSCR@("TRANS",9999999999),-1) S:'DOC DOC=1
 I $D(@ZAA02GSCR@("TRANS",DOC))'=3 F DOC=DOC:1 I $D(^(DOC))=0 L @ZAA02GSCR@("TRANS",DOC):0 I  Q
 S @ZAA02GSCR@("PARAM","NEXT")=DOC+1 S:Y=0 @ZAA02GSCR@("DIR",98,YM_$E(DY+100,2,3))=DOC
SET1 I INP("TEMPLATE")="",INP("REV")'="" S INP("TEMPLATE")=INP("REV"),INP("PROC1")=INP("PROC2"),INP("CONSULT")=INP("REV"),(INP("REV"),INP("PROC2"),INP("REV"))=""
 S (ds,DS)=$G(INP("DS")) S:$L($P(DS,"/",3))=4 $P(DS,"/",3)=$E($P(DS,"/",3),3,4)
 S ds=$S($P(ds,"/",3)<100:1900,1:0)+$P(ds,"/",3)*100+ds*100+$P(ds,"/",2),@ZAA02GSCR@("DIR",97,ds,DOC)=""
 S YY=",7,,Y\,30\,11\,3\,6\,15\,15\,8,,DS\,5\,5\,2\,3\,4" I $G(@ZAA02GSCR@("PARAM","TR"))]"" S YY=^("TR")
 S Y=$E(10000000+DOC,9-$P(YY,",",2),8) F J=1:1:12 S A=$P($P(YY,"\",J),",",2,4) S:A $P(Y,"`",J)=$E($S($P(A,",",3)]"":$G(@$P(A,",",3)),1:$G(INP($P(",PATIENT,MR,PROVIDER,CONSULT,PROC1,PROC2,DS,DT,TM,SITEC,TR",",",J))))_"~              ",1,A)
 S $P(Y,"`",13)=$E("T"_$TR($P($G(@ZAA02GWPD),"`",13),"T~ ")_"~  ",1,4) X:ZAA02GSCRP["R" @ZAA02GSCR@("PARAM","RSL")
 S J=$S($E($G(INP("eS")))="S":"A",1:"")_$S($G(INP("STAT")):"S",1:"")_$S($G(INP("NORM")):"N",1:"")_$S($G(INP("AUDIO"))]"":"D",1:"")
 S J=J_$S($TR($P($G(@ZAA02GSCR@(106,INP("TEMPLATE"),.0113),$G(@ZAA02GSCR@(106,INP("TEMPLATE"),.03))),"\",20),"N")]"":"T",1:"")_$S($G(INP("message"))["Addendum":"C",1:"")
 S $P(Y,"`",14)=J
 F J="CC1","CC2" I $G(INP(J))]"",$D(^RFG(INP(J))) S ^ZAA02GSCR("CC",INP(J),10000000-DOC)=""
 D DIR
 I $D(^ZAA02GSCR("PARAM","SETLOGIC")) X ^("SETLOGIC")
 K YY,BT S Y="" F J=1:1:$L(TMPL,",") S A=$P(TMPL,",",J),BT(A)="" S:$D(INP(A)) $P(Y,"`",J)=INP(A)
 S @ZAA02GWPD@(.011)=Y,(A,ALLVAR)="" F J=1:1 S A=$O(INP(A)) Q:A=""  I '$D(BT(A)),'$D(ALLVAR(A)) S ALLVAR=ALLVAR_A_","
 Q
