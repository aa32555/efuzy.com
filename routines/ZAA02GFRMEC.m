ZAA02GFRMEC ;PG&A,ZAA02G-FORM,2.62,;17MAY90 10:44A
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
CTL D INIT
 W:'$d(qt) ".fetch." S lc=0 D FP
 W:'$d(qt) ".put." S lc=.01 D FP
 D POST
 D PREEDIT
 D ^ZAA02GFRMEC0
 D ZI K ^ZAA02GF($J)
 Q
 ;
INIT K ^ZAA02GF($J) S q=0,w=(^ZAA02GDISP(SCR,SN,.05)]""),list=0
 S p=$P(^ZAA02GDISP(SCR,SN),"`",18) I $E(p)="^" S p=$E(p,2,99),$P(^(SN),"`",18)=p
 S q=q+1,^ZAA02GF($J,q)=p_" ; ZAA02G-FORM DISPLAY MODULE for FORM "_SCR_"-"_SN_"  "_$H
 S q=q+1,^(q)="CTL D F0 G DISP"
 W:'$d(qt) *13,"Creating ^",p
 Q
 ;
FP K l,etest S l=lc,t=$S(l=0:"F",1:"P") F a=l:.0001 Q:'$D(^ZAA02GDISP(SCR,SN,a))  S b=a*100000,l(b)=" "_^ZAA02GDISP(SCR,SN,a)
 S l=$O(l("")),l(l)=t_0_l(l),l(b+9)=" Q"
 F lc=l:10:a-.0001*100000 D FP1
 S b=$S(t="F":10,1:1010),a=t_"0 D "_t_b I a=l(l) S l(l)=t_"0 "_$P(l(b)," ",2,999) F lc=l:0 S lc=$O(l(lc)) Q:lc>b  K l(lc)
 F a=0:10 Q:'$O(l(a))  I $D(l(a+1)),$D(l(a+9)) K l(a+9)
 S lc="" F a=0:0 S lc=$O(l(lc)) Q:lc=""  S q=q+1,^ZAA02GF($J,q)=l(lc)
 I $D(etest) F a=0:0 S a=$O(etest(a)) Q:'a  S q=q+1,^ZAA02GF($J,q)="T"_a_" "_etest(a),q=q+1,^(q)=" Q"
 K l,etest Q
 ;
FP1 Q:l(lc)'[" X ^ZAA02GDISP("  S a=$P(l(lc)," X ^ZAA02GDISP(",1) Q:a=""
 I t="F" S b=$P(l(lc),a_" X ^ZAA02GDISP("_$C(34)_SCR_""","_SN_",",2),c=+b I $D(^ZAA02GDISP(SCR,SN,c)),c>.999,$P(^(c),"`")'=" ;" S l(lc)=a_" D T"_c_" S:$T "_$P(b,"S:$T ",2),etest(c)=$P(^(c),"`") Q
 S b=$P(a," F ",$L(a," F ")) I b="" W:'$d(qt) !,"ERROR:  CALL PG&A" *CRASH
 I b?1"n(".E S save=l(lc),beg=$P($P(l(lc)," X ^ZAA02GDISP(",2),".",2)*10,l(lc)=a_" D "_t_beg,l(beg)=t_beg_l(beg),l(beg-1)=" Q",l(beg+1)=" Q" Q
 S beg=$P(b,"=",2)*100000,end=+$P(b,".",$L(b,"."))*10,l(beg-1)=" Q",l(beg)=t_beg_l(beg),l(end+1)=" Q"
 S l(lc)=$P(l(lc),"F "_b)_"D "_t_beg
 Q
 ;
EXIST I $D(^ZAA02GDISP(SCR,SN,b)),$P(^(b),"`")'=" ;" S c=$P(^(b)," ;")
 Q
POST S a="DONE D P0" S:$P(^ZAA02GDISP(SCR,SN),"`",17)]"" a=a_" "_$P(^(SN),"`",17) S q=q+1,^ZAA02GF($J,q)=a,q=q+1,^(q)=" Q"
 Q
 ;
PREEDIT Q:^ZAA02GDISP(SCR,SN,.01997)=""  S q=q+1,^ZAA02GF($J,q)="PREEDIT "_^(.01997),q=q+1,^ZAA02GF($J,q)=" Q"
 Q
 ;
ZI S q=q+1,^ZAA02GF($J,q)="zEND ;",os=^ZAA02G("OS") G DTM:os="DTM",CCSM:os="CCSM"
 S os=^ZAA02G("OS"),a=$S(os="PSM":"^UTILITY(""R"",p)",os["DSM"!(os["MSM"):"^ (p)",os="M11":"^ROUTINE(p)")
 S a="I '$D("_a_") ZR  ZI ^ZAA02GF($J,1),^(q) ZS @p" X a
 X "ZR  ZL @p ZR +2:zEND ZI ^ZAA02GF($J,1):+1 ZR +1 F a=2:1:q ZI ^(a):+(a-1) I a=q ZS @p"
 K os Q
 ;
DTM S a=$ZRS(p) I a]"" F i=1:1:$L(a,$C(10)) I $P(a,$C(10),i)["zEND" Q
 S b="" F j=1:1:q S $P(b,$C(10),j)=^ZAA02GF($J,j)
 I a]"" S b=b_$C(10)_$P(a,$C(10),i,999)
 ZS @p:b ZD @p:"S" Q
 ;
CCSM F i=1:1:q S x=^ZAA02GF($J,i),L=$P(x," ",2,999) X "N (L,Y) D ^%CP" S ^ZAA02GF($J,i)=$P(x," ")_" "_Y
 S %GLB="^ZAA02GF($J)",%NAM=p N (%GLB,%NAM) D ^%RSAVE Q
