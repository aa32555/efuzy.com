ZAA02GFAXS ;PG&A,ZAA02G-FAX,1.36,STATUS SCREEN;25JAN93  01:47;23SEP96 12:03P;;Thu, 22 Jan 2009  09:20
 ;Copyright (C) 1991-1994, Patterson, Gray and Associates Inc.
 ;
POP K CNT S P3="P3",DR="DIR" S:'$D(EX) EX="I Y]"""",$P(Y,""\"")'=ZAA02G(3)"
 I TYP=1,$D(^ZAA02GSCR) D JB S LE=2,WD=78,IP="7R,7,13RS,9,16,7,11",IPX="1,4,5,14,32,3,8",NY=15,Y="Job #\Status\Fax #\To\Patient\Doc #\Fax Time",PX="P3A",FN=LE+15 G POP1
 I TYP=1!(TYP=6&$D(^ZAA02GSCR)) D JB S LE=2,WD=78,IP="7R,3R,7R,8,11RS,5,9,11,5,2R",IPX="1,2,3,4,5,14,33,8,9,10",NY=10,Y="Job #\Usr\Doc#\Status\Fax #\To\Company\Fax Time\Usage\Pg",PX="P3A",FN=LE+25 G POP1
 I TYP=2 S LE=2,WD=78,IP="5R,3R,7,15R,11,11,5,4R,4R,2R",IPX="1,24,4,5,7,8,9,27,30,31",NY=11,Y="Job #\Prt\Status\Fax #\Queue Time\Fax Time\Usage\Conv\Line\#R",PX="P3A",FN=LE+18
 I TYP=3 S DT=$H D:'$D(YR) DATE^ZAA02GFAXU S LE=2,WD=78,IP="10,4R,4R,4R,4R,4R,4R,4R,4R,4R,4R,4R,4R,5R",NY=12,Y="Descript.\Jan\Feb\Mar\Apr\May\Jun\Jul\Aug\Sep\Oct\Nov\Dec\",P3="P3E"
 I TYP=4 S LE=2,WD=78,IP="5R,6,15R,13,11,15,5",IPX="1,4,5,6,8,23,22",NY=10,NY=13,Y="Job #\Status\Fax #\Remote ID\Fax Time\Capabilities\Rsult",PX="P3A",FN=LE+13
 I TYP=5 S LE=2,WD=78,IP="5R,7,15R,11,34",IPX="1,4,5,7,32",NY=14,Y="Job #\Status\Fax #\Queue Time\Error",PX="P3C",FN=LE+14,DR="ERR",EX="I 0" K PG
 I TYP=6 S LE=2,WD=78,IP="5R,8,9,15,35",IPX="1,4,14,33,32",NY=15,Y="Job #\Status\Contact\Company\Subject",PX="P3A",FN=LE+41
POP1 S Y=$S($D(ZAA02G(9)):@ZAA02G(9)@(NY),1:Y)_$S(TYP=3:YR,1:""),XC="F %C=",NE=$L(IP,","),D=LE,sp=$J("",36) F J=1:1:NE-1 S D=D+$P(IP,",",J)+1,XC=XC_D_","
 S XC=$E(XC,1,$L(XC)-1)_" X D",%R=NX-2,%C=LE,B="",$P(B,ZAA02G("HL"),WD-1)="",D="W @ZAA02GP,ZAA02G(""TI"")",VL=ZAA02G("G1")_ZAA02G("VL")_ZAA02G("G0") W @ZAA02GP,ZAA02G("LO"),ZAA02G("RON"),ZAA02G("L"),@ZAA02GP,ZAA02G("G1"),ZAA02G("TLC"),B,ZAA02G("TRC") X XC
 S %C=LE,%R=%R+1 W @ZAA02GP,ZAA02G("VL"),ZAA02G("G0") F J=1:1:NE S D=$P(Y,"\",J),L=$P(IP,",",J),M=L+$L(D)\2 W $J(D,M),$J("",L-M),VL
 S %R=%R+1,D="W @ZAA02GP,ZAA02G(""X"")" W @ZAA02GP,ZAA02G("G1"),ZAA02G("LI"),B,ZAA02G("RI") X XC
 S SR=%R K:35[TYP PG S:$D(PG)>2 P=PG(PG) S:$D(PG)<3 PG=1,PG(PG)="",P=-999999999 D P2
 S %R=%R+1,D="W @ZAA02GP,ZAA02G(""BI"")" W @ZAA02GP,ZAA02G("G1"),ZAA02G("BLC"),B,ZAA02G("BRC") X XC S %C=80 W @ZAA02GP,ZAA02G("G0"),ZAA02G("ROF"),ZAA02G("CS"),ZAA02G("RON")
 I SEL<0 G END
 X ^ZAA02G("ECHO-OFF")
P1 D JB S A="" I SEL=0 S %C=1,%R=24 W @ZAA02GP R A#1:356[TYP*99+10 X ZAA02G("T") I '$T!(A=" ") S P=PG(PG) G P4
 I SEL>0,SEL(SEL) S %R=SE(SEL),%C=FN,J=SEL(SEL),D=$J($TR($P(^ZAA02GFAXQ("DIR",J),"\",4)," -,",""),15) W @ZAA02GP,ZAA02G($S($D(JB(J)):"RON",1:"ROF")),D R A#1 X ZAA02G("T") W @ZAA02GP,ZAA02G($S($D(JB(J)):"ROF",1:"RON")),D
 S ZF=$P(^ZAA02G(.3),"\",$A(^ZAA02G(.3,ZAA02G,0),$F(^(0),ZF))+2) S:A'=""&("SNPEF"[A) ZF=$P(",SE,PU,PD,EX,GO",",",$F("SPNEF",A)) I "OT,CR,EX"[ZF W ZAA02G("ROF") X ^ZAA02G("ECHO-ON") G END
 I ZF="PU" G P1:PG=1 S PG=PG-1,P=PG(PG) G P4
 I ZF="PD" G P1:Y="" S PG=PG+1,PG(PG)=P G P4
 I ZF="SE" D SELECT G POP
 I ZF="GO" D FIND G POP
 I "LK,RK"[ZF D SELX G POP
 G P1:SEL<1 I ZF="DK"!(A=" ") S SEL=SEL+1 S:SEL=SE SEL=1 G P1
 I ZF="UK" S SEL=SEL-1 S:SEL=0 SEL=SE-1 G P1
 G P1
P4 S %R=SR D P2 G P1
 ;
END K sp,NE,SE,PG,IP,WD,B,VL,D,FN,EX,JB,P3,PX,IPX,NY,Y,CNT Q
P2 K SE S %C=LE,SE=1 F %R=%R+1:1:BL D @P3
 Q
P3 S Y="" S:$O(^ZAA02GFAXQ(DR,P))]"" P=$O(^(P)),Y=^(P) X EX S:$T CNT=$G(CNT)+1,Y="" G:$T P3:$G(CNT)+$G(CNTX)<300 K:'$T CNT I SEL>0,Y'="" S SEL=1,SE(SE)=%R,SEL(SE)=P,SE=SE+1
 W @ZAA02GP W:P]"" $S(Y]""&$D(JB(P)):ZAA02G("ROF"),1:ZAA02G("RON")) W VL G @PX
P3A S:Y]"" Y=10000-P#100000_"\"_$E(Y,1,320) F J=1:1:NE S L=$P(IP,",",J),D=$P(Y,"\",$P(IPX,",",J)) W $S(L["R":$E($J($TR(D," -,",""),99),100-L,99),1:$E(D_sp,1,+L)),VL
 Q
P3C S:Y]"""" Y=$S($D(^ZAA02GFAXQ("DIR",P)):^(P),1:""),$P(Y,"\",31,32)=$E($TR(^ZAA02GFAXQ(DR,P),$C(6),""),1,35) G P3A
P3E F M=EX'="DEST"+1:1:4 S (L,Y)="" D @("P3E"_M) S %R=%R+1
 S Y=$S($O(^(P))]"":" ",1:""),%R=%R-1 I Y=""!(%R>20) F %R=%R+1:1:BL D P3E4
 Q
P3E1 D P3E5 S L=$P(P,"-"),L=$S($D(^ZAA02GFAXC("STATS",0,L)):^(L),1:"") W @ZAA02GP,VL,$J("",10),L,$J("",66-$L(L)),VL Q
P3E2 D:EX'="DEST" P3E5 D P3E6 G P3E4
P3E3 D P3E5,P3E6
P3E4 W @ZAA02GP,VL S:Y]" " T="T="_$P(Y,"+",1,12)_"+0",@T,Y=L_"+"_Y,$P(Y,"+",14)=T F J=1:1:NE S L=$P(IP,",",J),D=$P(Y,"+",J) W:L["R" $J($E(D,1,+L),+L) W:L'["R" $E(D_sp,1,+L) W VL
 Q
P3E5 S:$O(^ZAA02GFAXC("STATS",YR,EX,P))]"" P=$O(^(P)) Q
P3E6 I P'<0 S:P'=".1" Y=^ZAA02GFAXC("STATS",YR,EX,P),L=$E($P(P,"-"),1,15)_"-"_$P(P,"-",2) I SEL>0,Y'="" S SEL=1,SE(SE)=%R,SEL(SE)=L,SE=SE+1
 Q
SEL S SEL=$O(^ZAA02GFAXQ("DIR",""))]"",EX="I 0" D POP S X=$S($D(SEL(SEL)):SEL(SEL),1:"") K SEL Q
FIND K CNTX Q:TYP=3  S X="",Y="40\CRHLUD\1\Search Facility\\Find:*,*,",%R=BL-8,Y(0)="\EX" D ^ZAA02GFAXU2 Q:X["EX"  Q:X=""
 S EX="I Y]"""",$TR(Y,""ABCDEFGHIJKLMNOPQRSTUVWXYZ"",""abcdefghijklmnopqrstuvwxyz"")'["""_$TR(X,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")_"""",CNTX=-1000,OEX=EX Q
SELECT G:TYP=3 SELECT1 S Y="40\CRHLUD\1\"_$S('$D(ZAA02G(9)):"Status Options\\Complete List,Individual List,*,Normal Display,Subject Display,Local Fax Info,Remote Fax Info,Error Info",1:@ZAA02G(9)@(16)),%R=BL-8,Y(0)="\EX" D ^ZAA02GFAXU2 Q:X["EX"
SELX1 S EX=$S(X=1:"I 0",X=2:"",X=8:"",1:EX) K:EX="" EX S TYP=$S(X=4:1,X=5:6,X=6:2,X=7:4,X=8:5,1:TYP) S:TYP=3 EX="FAX" Q
SELX S X=$E($P("67 854,54 678",",",ZF="LK"+1),TYP) G SELX1
SELECT1 S YY=$S('$D(ZAA02G(9)):"Statistics Options\\Listed by Fax#,Listed by Initiator,Totals\Data",1:@ZAA02G(9)@(17))
 S Y="40\CRHLUD\1\"_$P(YY,"\",1,3),%R=BL-7,Y(0)="\EX",X=0 F J=1:1 S X=$O(^ZAA02GFAXC("STATS",X)) Q:X=""  S Y=Y_","_(1900+X)_" "_$P(YY,"\",4)
 K YY D ^ZAA02GFAXU2 Q:X["EX"
 S:X<4 EX=$S(X=1:"DEST",X=2:"INIT",1:"FAX") S:X>3 YR=$P($P(Y,"\",6),",",X)-1900 Q
 ;
JB K JB S B="" F J=1:1:999 S B=$O(^ZAA02GFAXQ(.9,B)) Q:B=""  S JB(10000-B)=""
 Q
