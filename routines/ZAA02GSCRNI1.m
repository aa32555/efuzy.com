ZAA02GSCRNI1 ;PG&A,ZAA02G-SCRIPT,2.10,INCENTIVE PAY REPORT;;;;26JAN2000  17:11
C ;Copyright (C) 1991-1994, Patterson, Gray & Associates, Inc.
TYPE K Y,X S %R=3,%C=1 W @ZAA02GP,ZAA02G("CS") S Y(0)="\EX\",Y="5,4\RHLD\1\REPORT TYPE\\*,Detailed,Summary" D ^ZAA02GPOP Q:X[";EX"  Q:X=""  S TYP=X-1
 K X S Y="33,10\HLDS\2\Select Printer",Y(0)="\EX\^ZAA02GWP(96)\TO" D ^ZAA02GPOP Q:X[";EX"   S DV=X Q:DV=""
 S %R=3 W @ZAA02GP,ZAA02G("CS") S %R=10,%C=30 W @ZAA02GP,"Report is Queued to Printer ",DV H 1
 K Y S DOC="^REPORTS",Y("XECUTE")="D R^ZAA02GSCRNI1",Y("ZAA02GSCR")=ZAA02GSCR,Y("TYP")=TYP,Y("ID")=ID,Y("ZAA02GSCRP")=ZAA02GSCRP D QUEUE^ZAA02GSCRSP
 K Y,TYP,X,Z,DV,ID Q
R S ZAA02G("d")=0 D DATE^ZAA02GSCRER S UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ",LC="abcdefghijklmnopqrstuvwxyz"
 S TYP=@VDOC@("TYP"),ZAA02GSCR=@VDOC@("ZAA02GSCR"),ID=@VDOC@("ID"),ZAA02GSCRP=@VDOC@("ZAA02GSCRP")
 S ZAA02GSCRT=$S($D(@ZAA02GSCR@("PARAM","USER FILE")):^("USER FILE"),1:ZAA02GSCR)
 S B(1)=6,B(2)=11,B(3)=.6 D INIT^ZAA02GWPPC1 S LTM=B(3)*B(2)*$S($D(LMG):0,1:1) S:LTM<0 LTM=0
 D TYPE1:TYP=1,TYPE2:TYP=2 S DONE=1 Q
 ;
TYPE1 ; DETAILED
 S CT="",BB=@ZAA02GSCR@("INCENTD",ID),CC=$P(BB,"\"),CC=$G(@ZAA02GSCR@("PARAM","INCENT",CC)),REP=$P(CC,"|",2)
 F J=1:1 S CT=$O(@ZAA02GSCR@("INCENTD",ID,CT)) Q:CT=""  S AA=^(CT) I +AA D TYPE1A,REPORT W #
 Q
TYPE1A W !!!!,CT,?30,"INCENTIVE PAY REPORT",?71,DT,!?30,$P(BB,"\",2)," - ",$P(BB,"\",3),?71,TM,!!
 D TYPE1H
 S D="" F J=1:1 S D=$O(@ZAA02GSCR@("INCENTD",ID,CT,D)) Q:D=""  S DD=^(D) W:$L(D)=6 $E(D,3,4)_"/"_$E(D,5,6)_"/"_$E(D,1,2) W:$L(D)>6 $E(D,5,6)_"/"_$E(D,7,8)_"/"_$E(D,3,4) D TYPE1B
 F L=2:1:10 W ?$P(",8,15,21,29,38,43,51,56,63",",",L),"-----"
 W ! S DD=AA D TYPE1B W ! Q
TYPE1B S $P(DD,",",13)=$P(DD,",",6)-$P(DD,",",7),$P(DD,",",14)=$P(DD,",",13)-$P(DD,",",8),$P(DD,",",15)=$P(DD,",",1)+$P(DD,",",2)+$P(DD,",",11)+$P(DD,",",12)
 F L=2:1:10 S J=$P(DD,",",$P(",7,13,8,14,1,11,2,12,15",",",L)) W ?$P(",8,15,21,29,38,43,51,56,63",",",L),$J(J,5)
 W ! Q
TYPE1H G:$P(ZAA02GSCRP,";",3)=1 TYPE1HVA W !,"           VAC.  WORK  DOWN   TYPING  --TYPE A---  --TYPE B---  TOTAL",!
 W "  DATE     HRS    HRS  TIME    TIME    LINES  ADJ.  LINES  ADJ. LINES",! F J=1:1:6 W "-------------"
 W ! Q
TYPE1HVA W !,"                 DUTY  DOWN   TYPING  ROUTINE       X-RAY       TOTAL",!
 W "  DATE    LEAVE   HRS  TIME    TIME    LINES  ADJ.  LINES  ADJ. LINES",! F J=1:1:6 W "-------------"
 W ! Q
 ;
TYPE2 ; SUMMARY
 S CT="",BB=@ZAA02GSCR@("INCENTD",ID),CC=$P(BB,"\"),CC=$G(@ZAA02GSCR@("PARAM","INCENT",CC)),REP=$P(CC,"|",3)
 W !!!!?25,"INCENTIVE PAY SUMMARY REPORT",?71,DT,!?30,$P(BB,"\",2)," - ",$P(BB,"\",3),?71,TM,!!
 D TYPE2H K B,AA
 S (CTA,CT,AA,NB)="" F  S CT=$O(@ZAA02GSCR@("INCENTD",ID,CT)) Q:CT=""  I +^(CT) S NB=NB+1,L=$G(@ZAA02GSCRT@("PARAM","USER",$TR(CT,UP,LC))),L=$TR($P($P(L,"\",2)," ")_" "_$P(L,"\"),LC,UP) S:L=" " L=CT S AA(L)=CT
 F  S CTA=$O(AA(CTA)) Q:CTA=""  S CT=AA(CTA),DD=@ZAA02GSCR@("INCENTD",ID,CT) D TYPE2B
 F L=2:1:10 W ?$P(",18,24,31,38,44,51,57,64,72",",",L),$E(" -------",1,L>8+6)
 W ! S DD="",B(8)=B(8)\NB F L=2:1:10 S J=B(L) W ?$P(",18,24,31,38,44,51,57,64,72",",",L),$S(L<9:$J(J,6),L<10:$J(J,7),1:$J(J,7,2))
 W !# K NB,B,INP,CT,CTA,AA Q
TYPE2B W $E(CTA,1,30)
 F L=6,7,8 S:$P(DD,",",L) $P(DD,",",L)=$J($P(DD,",",L)/8,0,2)
 S $P(DD,",",13)=$P(DD,",",6)-$P(DD,",",7),$P(DD,",",14)=$J($P(DD,",",13)-$P(DD,",",8),0,2),$P(DD,",")=$P(DD,",")+$P(DD,",",11),$P(DD,",",2)=$P(DD,",",2)+$P(DD,",",12)
 S $P(DD,",",15)=$P(DD,",",1)+$P(DD,",",2) S:$P(DD,",",15) $P(DD,",",16)=$P(DD,",",2)/$P(DD,",",15)*100\1
 S $P(DD,",",17)=$J($P(DD,",",15)/$P(DD,",",14),0,1)
 S L=$P(CC,"|",8),J=$P(DD,",",15) I $P(DD,",",14)*8*$P(L,",")<J S J=J-($P(DD,",",14)*8*$P(L,",")),$P(DD,",",18)=J*$P(L,",",4)
 I $P(DD,",",14)*8*$P(L,",",2)<J S J=J-($P(DD,",",14)*8*$P(L,",",2)),$P(DD,",",18)=$P(DD,",",18)+J*$P(L,",",4)
 F L=2:1:10 S J=$P(DD,",",$P(",7,8,14,1,2,15,16,17,18",",",L)),B(L)=$G(B(L))+J W ?$P(",18,24,31,38,44,51,57,64,72",",",L),$S(L<9:$J(J,6),L<10:$J(J,7),1:$J(J,7,2))
 W ! Q  ; W ! W DD,!,CC,! Q
TYPE2H G:$P(ZAA02GSCRP,";",3)=1 TYPE2HVA W !,"                    VAC.  DOWN   PROD  TYPE   TYPE  LINES   %     AVG    INCENT",!
 W "TRANSCRIPTIONISTS   DAYS  TIME   DAYS    A     B    TOTAL   B     LINE     PAY",! F J=1:1:6 W "-------------"
 W ! Q
TYPE2HVA W !,"                   LEAVE  DOWN   PROD  TOTAL   NO.  LINES   %     AVG    INCENT",!
 W "TRANSCRIPTIONISTS   DAYS  TIME   DAYS  REG    XRAY  TOTAL  XRAY   LINE     PAY",! F J=1:1:6 W "-------------"
 W ! Q
 ;
REPORT Q:REP=""  S REPD=ZAA02GSCR_"(""INCENTR"")" K VAR S USR=$G(@ZAA02GSCRT@("PARAM","USER",$TR(CT,UP,LC))) I $P(USR,"\",6)'?.P S K=CC N CC S CC=K,$P(CC,"|",8)=$P(USR,"\",6)
 S (K,L)="" F J=1:1 S K=$O(@REPD@(REP,0,K)) Q:K=""  D:'$D(INP(K)) CP1 F J=1:1 S L=$O(@REPD@(REP,0,K,L)) Q:L=""  S VAR(L)=$S($D(VAR(L)):VAR(L)_","_K,1:K)
 S A=$O(@REPD@(REP,.03)) F J=1:1 S A=$O(@REPD@(REP,A)) Q:A=""  S B=^(A) W:0 B,! D:$D(VAR(A)) CP2 W:B'=" " B,!
 K VAR,REPD,INP Q
CP1 S T=0,C="x"_K D:$T(@C)'="" @C S INP(K)=T Q
xBEG S T=$P(BB,"\",2) Q
xEND S T=$P(BB,"\",3) Q
xNAME S T=$P(USR,"\",2)_" "_$P(USR,"\") Q
xLEAVE S T=+$P(DD,",",7) Q
xDUTY S T=+$P(DD,",",13) Q
xDOWN S T=+$P(DD,",",8) Q
xTYPING S T=+$P(DD,",",14) Q
xROUTINE S T=+$P(DD,",",1)+$P(DD,",",11) Q
xXRAY S T=+$P(DD,",",2)+$P(DD,",",12) Q
xTOTAL S T=+$P(DD,",",15) Q
xPBASE S T=+$P($P(CC,"|",8),",",1) Q   ; BOTTOM THRESHOLD
xPRATE S T=+$P($P(CC,"|",8),",",4) Q
xSBASE S T=+$P($P(CC,"|",8),",",2) Q   ; 2ND THRESHOLD = PBASE+SBASE
xSRATE S T=+$P($P(CC,"|",8),",",5) Q
xDAYS S T=+$P(DD,",",10) Q
 ;
CP2 I B["=" S L=B,C=$P($P(B,"="),"~$",2) I C?1.AN S B=$P(L,"=",2,9) D CP3 S L="INP(C)="_$TR(B," "),@L S B=" " Q
CP3 S L=B F K=1:1:$L(VAR(A),",") S D=$P(VAR(A),",",K) I D'="" S T=$S($D(INP(D)):INP(D),1:"") D @$S($E(D)'="$":"F1",1:"F2")
 S B=L Q
F1 S W="~$"_D,J=T,F=$F(L,W),Y="" Q:F<2  I $E(L,F,F+1)?1"."1A S Y=$E(L,F,F+1),F=F+2 S:$E(L,F)?1A Y=Y_$E(L,F),F=F+1
 D:Y["D" FCAL S:Y["CC"&(J]"") J="cc: "_J S W=W_Y S:Y["X" J=$TR(J,LC,UP) I Y["x" D LC^ZAA02GSCRVB
 I Y["R" S L=$E(L,0,F-$L(W)-1)_$J("",$L(W))_$E(L,F,999),L=$E(L,0,F-$L(J)-1)_J_$E(L,F,255)
 I Y["L" S B=$S(" "'[$E(L,F):$P($E(L,F,255)," "),1:""),L=$E(L,0,F-$L(W)-1)_$J("",$L(W_B))_$E(L,F+$L(B),999),L=$E(L,0,F-$L(W)-1)_J_B_$E(L,F-$L(W)+$L(J_B),999)
 I Y["C",$L(Y,"C")#2=0 S L=$E(L,0,F-$L(W)-1)_$J("",$L(W))_$E(L,F,999),F=F-($L(W)+$L(J)+1\2),L=$E(L,0,F-1)_J_$E(L,F+$L(J),999)
 I L[W S L=$E(L,0,F-$L(W)-1)_J_$E(L,F,999)
 G:L[("~$"_D) F1 Q
F2 S MCE(D,C)="" Q
FCAL S:T'="" J=$P("January,February,March,April,May,June,July,August,September,October,November,December",",",+T)_" "_(+$P(T,"/",2))_", "_$S($P(T,"/",3)<30:20,$P(T,"/",3)<100:19,1:"")_$P(T,"/",3) Q
