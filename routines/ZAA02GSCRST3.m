ZAA02GSCRST3 ;PG&A,ZAA02G-SCRIPT,2.10,STATS - DAILY;16MAY95 10:14A;;;03JAN2000  11:45
 ;
A S (CD,Dt)=$H,(A,SC,DT)="" D A3
A0 S SC=$O(@ZAA02GSCR@("STATS",YM,SC)) I SC="NA" G A0:$O(^(SC))'="",A0:$O(^(""))'="NA"
 I SC="" Q:'$D(@ZAA02GSCR@("STATS"))  Q:$O(^("STATS",0))>YM  S:A'="S" Dt=Dt-1 D A3 G A0
A1 D A3 S %R=3,%C=1 W @ZAA02GP,ZAA02G("CS"),ZAA02G("HI") S %R=1,%C=19 W @ZAA02GP,"DAILY STATS FOR - "_DT_"  AT  "_TM_"  SITE-"_SC
 S LF="LL="_$P(@ZAA02GSCR@("PARAM","BASIC"),"|",4),WF=$P(^("BASIC"),"|",2)
 S A="",E="+0",(DL,TT,ML,MT)=0,%R=24,%C=-40,UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ",LC="abcdefghijklmnopqrstuvwxyz" K T
 ; S A="" F J=1:1 S A=$O(@ZAA02GSCR@("PARAM","USER",A)) Q:A=""  I "Yy"[$P(^(A),"\",7) S T($TR(A,LC,UP))=""
 F J=1:1 S A=$O(@ZAA02GSCR@("STATS",YM,SC,"TR",A)) Q:A=""  I $D(^(A,"TOTAL",1)) D B
 S %R=%R+2 D:%R>23 NEXT W @ZAA02GP,"Tot",$J(DL,6,0),$J(TT/60,5,0),$J($S(TT<10:"-",1:DL*60\(TT+.1)),5),$J(ML,8,0),$J(MT/60,5,0),$J($S(MT<10:"-",1:ML*60\(MT+.1)),6)
 K T S A="",(DL,TT,ML,MT)=0 F J=1:1 S A=$O(@ZAA02GSCR@("STATS",YM,SC,"TYPE",A)) Q:A=""  I $D(^(A,A,1)) D C S T(-LL)=A,ML=ML+R
 S %R=%R+2 D:%C<40 NEXT W @ZAA02GP," ---Report Type Listing--- ",ML," today"
 S (J)="",%R=%R+1 F I=%R:1:22 S J=$O(T(J)) Q:J=""  S A=T(J) I $D(@ZAA02GSCR@("STATS",YM,SC,"TYPE",A,A,1)) D B
 W ZAA02G("LO"),ZAA02G("G1") S %C=40 F %R=3:1:23 W @ZAA02GP,ZAA02G("VL")
 W ZAA02G("G0")
A2 S %R=24,%C=10 W @ZAA02GP,"Press S to change Sites, NEXT/PREV to change day or EXIT ",ZAA02G("CL") R A#1 S:A?1L A=$C($A(A)-32) I A="S" G A0
 X ZAA02G("T") S C=$E(XX,$F(XX,ZF)) I C'="" S A=$S(C="O":"N",C="P":"P",C="E":"E",1:A)
 I A="N" S Dt=Dt+1 G A1:Dt'>CD S Dt=Dt-1 W *7 G A2
 I A="P" S Dt=Dt-1 G A1
 I A'="E" W *7 G A2
 K A,Z,C,E,S,B,L,DT,DL,MT,ML,Dt,CD,T Q
A3 D DATE S YM=$E(Y,2,5),YM=$S(YM<3000:200000,1:190000)+YM,DY=+$P(DT,"/",2) Q
 ;
B D C
 S Z=^(1),C="C="_$P(Z,"+",1,DY)_E Q:$L(C)=2  S Z=^(2),L="L="_$P(Z,"+",1,DY)_E,Z=^(3),W="W="_$P(Z,"+",1,DY)_E,Z=^(4),B="B="_$P(Z,"+",1,DY)_E,Z=^(5),S="S="_$P(Z,"+",1,DY)_E,Z=^(6),R="R="_$P(Z,"+",1,DY)_E,Z=^(7),T="T="_$P(Z,"+",1,DY)_E_"*.1"
 S @C,@L,@W,@B,@S,@R,@T,@LF,MT=MT+T,ML=ML+LL
 I LL S %R=%R+1 D:%R>23 NEXT W @ZAA02GP,$E(A,1,4),$J("",4-$L(A)),$J(DN,5,0),$J(DM/60,5,1),$J($S(DM<10:"-",1:DN*60\(DM+.1)),5),$J(LL,8,0),$J(T/60,5,0),$J($S(T<10:"-",1:LL*60\(T+.1)),6)
 Q
C S Z=^(1),C="C="_$P(Z,"+",DY)_E Q:$L(C)=2  S Z=^(2),L="L="_$P(Z,"+",DY)_E,Z=^(3),W="W="_$P(Z,"+",DY)_E,Z=^(4),B="B="_$P(Z,"+",DY)_E,Z=^(5),S="S="_$P(Z,"+",DY)_E,Z=^(6),R="R="_$P(Z,"+",DY)_E,Z=^(7),T="T="_$P(Z,"+",DY)_E_"*.1"
 S @C,@L,@W,@B,@S,@R,@T,@LF,DL=DL+LL,TT=TT+T,DN=LL,DM=T Q
NEXT S %R=3,%C=%C+41 W @ZAA02GP,ZAA02G("LO"),"TR  -----TODAY------  -----MONTH------" S %R=%R+1 W @ZAA02GP,"    LINES  HRS  RATE  LINES  HRS  RATE",ZAA02G("HI")
 S %R=%R+2 Q
 ;
DATE S K=Dt>21608+305+Dt,Y=4*K+3\1461,D=K*4+3-(1461*Y)+4\4,M=5*D-3\153,D=5*D-3-(153*M)+5\5,M=M+2,Y=M\12+Y+140,M=M#12+1,K="/" S:ZAA02G("d") K=M,M=D,D=K,K="." S Y=Y*100+M*100+D,DT=$E(Y,4,5)_K_$E(Y,6,7)_K_$E(Y,2,3) K K,M,D
 S TM=$P($H,",",2)\60,TM=$E(TM\60+100,2,3)_":"_$E(TM#60+100,2,3)  Q
 Q
