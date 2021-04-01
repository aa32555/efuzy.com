%ZAAEDGE1 ;;%ZAA-WORKS;Thu, 10 Jan 2013  11:31;UTIL: GLOBAL EDITOR, CONTROL;Tue, 11 Jan
 ; ADS Corp. Copyright
 ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc.
 ;;All rights reserved.
 X ZAA("EOF") S VV="V=$S(d:@G,1:tLO_""<ptr>"")",RE=1 D PAGE S NO=1
SELECT S %R=bl+2,%C=rm-76\2+1 W pBL_tCL,@ZAAP,tLO_"["_tHI_"NEXT, PREV, LEFT, RIGHT, TAB, INSERT, DELETE"_tLO_", "_tHI_"RETURN "_tLO_"to edit, "_tHI_"EXIT"_tLO_" to quit]"
ASK S %R=TR+NO-1,%C=1 W @ZAAP,tHI_"=>"_tLO
AS R C#1
 I C="" X ZAA("T") S ZAAF=$P(ZAAY,"\",$A(ZAAX,$F(ZAAX,ZF))+2) G:"UK,DK,RK,LK,PU,PD,CP,IL,DL,CR,HL,EX,GO,SE,TB,IC,DC,SD"[ZAAF @ZAAF W *7 G AS
 G DK:C=" ",WID:"<>"[C,RE1:C="-",RE2:C="+",AS
UK G:PG=1&(NO=1) AS W @ZAAP,"  " S NO=NO-1 G:NO'<1 ASK S NO=CN X:PG>1 "S PG=PG-1 D PAGE S NO=CN" G ASK
DK W @ZAAP,"  " S NO=NO+1 G:NO'>CN ASK S NO=1 G:'$D(PG(PL,PG+1)) ASK S PG=PG+1 D PAGE G ASK
RK G:MX>HL AS D RK1 G ASK
RK1 S PG(PL)=PG*100+NO,MX=MX+1,PL=PL+1,PG=1,PG(PL,1)=$S(US(NO)="":0,1:$L(US(NO),D)_D_US(NO)) D PAGE S NO=1 Q
LK G:MX<2!(HL<2) AS D LK1 G ASK
LK1 X:PL>1 "K PG(PL) S PL=PL-1" S PG=PG(PL)\100,MX=$S(MX>98:HL-1,1:MX-1) D PAGE S NO=PG(PL)#100 Q
TB I MX'<2!(HL'<2) F JJ=1:1 S OMX=MX D:MX'<2!(HL'<2) LK1 I MX=OMX K OMX G ASK
 F JJ=1:1 S OMX=MX D:MX'>HL RK1 I MX=OMX K OMX G ASK
PD G:'$D(PG(PL,PG+1)) AS S PG=PG+1 D PAGE S:NO>CN NO=CN G ASK
PU G:PG<2 AS S PG=PG-1 D PAGE G ASK
CR G:$D(US(NO))=0 AS S ACT="EDIT",RF=$S(US(NO)="":GN,1:GN_"("_$TR(US(NO),D,",")_")") I $D(@RF)#2=0,$D(^ZAAEDTMP($J,RF))=0 W *7 G AS
 D ^ZAAEDGE2 G SELECT
DL D DEL^ZAAEDGE G ASK
IL S ACT="INSERT",RF=$S('NO:GN,1:$S('$D(US(NO)):GN,US(NO)="":GN,1:"^("_$TR(US(NO),D,","))),(NEW,V)="" D ^ZAAEDGE2 G SELECT
CP G:$D(US(NO))=0 AS S ACT="COPY",RF=$S(US(NO)="":GN,1:GN_"("_$TR(US(NO),D,",")_")") I $D(@RF)#2=0 W *7 G AS
 D ^ZAAEDGE2 G SELECT
HL D HELP^ZAAEDGL,PAGE G ASK
DC G SELECT:$D(nlm) S nlm=31 D PAGE G SELECT
IC G SELECT:'$D(nlm) K nlm D PAGE G SELECT
RE1 S RE=-1 D PAGE G SELECT
RE2 S RE=1 D PAGE G SELECT
SD G:$D(US(NO))=0 AS S RF=$S(US(NO)="":GN,1:GN_"("_$TR(US(NO),D,",")_")") I $D(@RF)#2=0 W *7 G AS
 S %R=23,%C=1,V=@RF I RF'["ZAAVBC"&(RF'["ZAAWEBT") G AS
 W @ZAAP,ZAA("CS"),!,"1. Run this command  2. Filter by User - ",ZAA("CS") X ZAA("EON") R Y I "12"'[Y G SELECT
 I Y=2 W @ZAAP,ZAA("CS"),!,"Which User? (case sensitive) - ",ZAA("CS") R Usr K:Usr="" Usr G SELECT
 S %R=3 W @ZAAP,ZAA("CS")
 X "N (V,RF) S last=RF D:RF[""ZAAV"" lastcont^ZAAVBUT D:RF[""ZAAW"" last^ZAAWEBH"
 W !,"PRESS RETURN " R Y#1 D PAGE G SELECT
GO G:$D(US(NO))=0 AS S RF=$S(US(NO)="":GN,1:GN_"("_$TR(US(NO),D,",")_")") I $D(@RF)#2=0 W *7 G AS
 S %R=23,%C=1,V=@RF W @ZAAP,ZAA("CS"),!,"Delimiter? - ",ZAA("CS") X ZAA("EON") R Y S:Y?1.N Y=$C(Y) X ZAA("EOF")
 S %R=3 W @ZAAP,ZAA("CS"),RF S %R=4,%C=1,C=$L(V,Y) F RF=1:1:C W @ZAAP,ZAA("LO"),$J(RF,2),ZAA("HI")," ",$E($P(V,Y,RF),1,rm-%C),ZAA("CL") S %R=%R+1 S:%R>22 %R=4,%C=rm\(C\20+1)+%C
 S %R=24,%C=30 W @ZAAP,"PRESS RETURN " R Y#1 D PAGE G SELECT
SE S %R=23,%C=1 W @ZAAP,ZAA("CS"),!,"SHOW PIECE: Enter delimiter - ",ZAA("CS") X ZAA("EON") R Y I Y]"" X ZAA("EOF") W " and piece # (or #,#) " X ZAA("EON") R Z X ZAA("EOF")
 S:Y="" VV="V=$S(d:@G,1:tLO_""<ptr>"")",T=GR I Y]"" S:$L(Y)=1 Y=""""_Y_"""" S:Z="" Z=1 S VV="V=$S(d:$P(@G,"_Y_","_Z_"),1:tLO_""<ptr>"")",T="$P("_GR_","_Y_","_Z_")"
 S T="Global: "_T D ^ZAAEDHD,PAGE G SELECT
EX W @ZAAP,"  "
EXIT X ZAA("EON") K d,M,x,C,G,I,L,V,X,Y,BS,CN,DT,EB,ES,GN,GR,LN,MN,MX,NL,NO,RF,PG,RL,SB,SW,TS,US,UV,END,nlm Q
WID G:ZAA(132)="" AS
 I C="<",rm>79 X ZAA(80) S rm=79,T="Global: "_GR,W=rm-lm+1,WW=W+2 D ^ZAAEDHD,PAGE K T G SELECT
 I C=">",rm<80 X ZAA(132) S rm=131,T="Global: "_GR,W=rm-lm+1,WW=W+2 D ^ZAAEDHD,PAGE K T G SELECT
 G AS
PAGE N w,I,RL,LST K US,UV K PG(PL,PG+1) S w=W-29+$G(nlm),(CN,END)=0 D FIRST S HL=SB G:'END P2 D CLEAR Q
P1 D NEXT S:SB>HL HL=SB I END D CLEAR Q
P2 I CN=(BR-TR+1) S:SB PG(PL,PG+1)=SB_D_SBF Q
 S CN=CN+1,XF=$S(RF="":GN,1:"^("_$TR(SBF,D,",")_")"),RL=$S($D(nlm):0,$L(XF)<26:27,1:$L(XF)+2) S:$L(V)>(W-RL-4) V=$E(V,1,W-RL-4)_"..."
 S US(CN)=RF,UV(CN)=$S($D(nlm):"",1:$J("",RL-$L(XF)))_V,%R=TR+CN-1,%C=1 W @ZAAP,tLO_"  ",$S('$D(nlm):XF,1:"")_tHI_UV(CN)_tCL G P1
CLEAR S %C=1 F %R=CN+TR:1:BR W @ZAAP,tCL
 Q
FIRST S SB=+PG(PL,PG) S:SB>MX SB=MX S SBF=$P(PG(PL,PG),D,2,SB+1),G=$S(SB<1:GN,1:GN_"("_$TR($P(SBF,D,1,SB),D,",")_")")
 I PG=1,'SB,$D(@GN) S RF="",V=$S($D(@GN)#2:@GN,1:tLO_"<ptr>") Q
 I $D(@G) D GETREF Q
NEXT G NLV:'SB I $TR($P(SBF,D,SB),"""","")]"",$D(@G)\10 G NLV
ORD S sb=$O(@G,RE) G:sb="" PLV S $P(SBF,D,SB)=$$SUB(sb),G=GN_"("_$TR($P(SBF,D,1,SB),D,",")_")"
 I $G(Usr)]"",$QL(G)=4,$P($G(@G),$C(9))'=Usr G ORD
 I $D(ES(SB)),ES(SB)=+ES(SB) G PLV:sb'=+sb,PLV:sb>ES(SB),OR1
 I $D(ES(SB)),ES(SB)]"",sb]ES(SB) G PLV
OR1 D GETREF Q
NLV G:SB'<MX ORD S SB=SB+1,XB=$S($D(BS(SB)):BS(SB),1:""),$P(SBF,D,SB)=$$SUB(XB),G=GN_"("_$TR($P(SBF,D,1,SB),D,",")_")" G:XB="" ORD I $D(@G) D GETREF Q
 G NLV
PLV S:SB>0 SB=SB-1,SBF=$P(SBF,D,0,SB) I 'SB S END=1 S:$G(PG(PG))#100>CN PG(PG)=PG*100+CN Q
 S G=GN_"("_$TR($P(SBF,D,1,SB),D,",")_")" G ORD
SUB(X) I X?1N.E1A1N.E Q """"_X_""""
 Q:+X=X X I X'["""" Q """"_X_""""
 S F=0 F I=0:0 S F=$F(X,"""",F) Q:'F  S X=$E(X,0,F-1)_""""_$E(X,F,$L(X)),F=F+1
 Q """"_X_""""
GETREF S d=$D(@G)#2,@VV,RF=SBF Q:'d  Q:$TR(V,CS,"")=V
XX S X=V,M=$TR($E(V,1,W),CS,XS),(T,V)=""  ; ,M=$TR(V,CS,""),M=$S(M="":V,1:$TR(V,M,$J("",$L(M)))),M=$TR(M,CS,XS),(T,V)=""
 F F=0:0 S F=$F(M,$C(1),F) Q:'F  S V=V_$E(X,T,F-2)_"<"_$A(X,F-1)_">",T=F Q:$L(V)>w
 I F S V=$P(V,"<",1,$L(V,"<")-1)_"+" Q
 S V=V_$E(X,T,w-$L(V)+T) Q
