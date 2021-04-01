ZAA02GSCRMS1 ;PG&A,ZAA02G-SCRIPT,2.10,PRINTER INTERFACE;22NOV94 1:31P;28APR2010  12:38;;Thu, 17 Feb 2011  11:23
 ; ADS Corp. Copyright
 ;Copyright (C) 1992, Patterson, Gray & Associates, Inc.
 ;
 ; CALLED FROM BACKGROUND PROCESS (ZAA02GWPPC) FOR EACH COPY PRINTED
 ;
PRINT S ZAA02GSCR=^ZAA02GWP(.9,DP,XDC,"ZAA02GSCR"),ZAA02GWPD="^ZAA02GWP(.9,DP,XDC,""DOC"")" I $D(skipopen) S RTN=skipopen
 I $D(^("PAGES")) G:^ZAA02GWP(.9,DP,XDC,"PAGES")="" P1 S PAGES=^("PAGES") G ^ZAA02GSCRFX3:$G(VDV)["MODEM",P4:PAGES'["*",P5
 I $D(^ZAA02GWP(.9,DP,XDC,"P3")),^("P3")]"" S ^("PROVIDER")=^("P3")
 S ^("PAGES")="",PGP=99,NOINIT=1,PAGES=0,^("VDV")=VDV
 S EXE="S PG(0)=""+""_$S(LN<0:LN+100,1:LN)_$G(PG(0)),PG(1)=""+""_$G(WW)_$G(PG(1))" K PG(0),PG(1) G P2
 ;
P1 I $D(VDV(1)),$D(PG(0)) I PG>2,PG(0)<VDV(1) S K="lp=-PG(1)+"_PG(1),@K,K="K=2"_PG(0),@K S @$S(lp/K'<.88:"PG=PG-1,^ZAA02GWP(.9,DP,XDC,""lpi"")=lp/K",1:"^ZAA02GWP(.9,DP,XDC,""lpi"")=1.2")
 ; ZT 6
 S ZAA02GID=^ZAA02GWP(.9,DP,XDC,"DIST"),(PAGES,^("PAGES"))=$G(PG)-1 I $G(^("DISTR"))="*" S OVD=1
 X:$D(@ZAA02GSCR@("PARAM","PRINTEXI")) ^("PRINTEXI")
 S ES=$E($P($G(^ZAA02GWP(.9,DP,XDC,"eS")),"\")) K DONE,done
 I $G(^ZAA02GWP(.9,DP,XDC,"FAX"))]"",$G(ES)'="Y",'$D(NOFAX) D ^ZAA02GSCRFX  ;SETS done(x) WITH PRINT SUPPRESSION
 I ZAA02GID]"",$D(@ZAA02GSCR@("PARAM","DIST",ZAA02GID)) D DISTR I $G(NOPRINT) S DONE=1 G CPR1
P5 I DOC["TRANS",$G(ES)'="Y" D
 . D CPR X:$D(@ZAA02GSCR@("PARAM","PRINTEX")) ^("PRINTEX")
 . I $E($G(@DOC@(.011,"FDY")))="W",$D(^ZAA02GSCR("EDI","PRO")) S ^ZAA02GSCR("EDI","DOC",+$P(DOC,""",""",2))="" J REP^ZAA02GVBTER3
 ; I $G(DONE)[2 S ^ZAA02GWP(.9,DP,XDC,"CPr")=$H Q
 ; FILE -  D FILE^ZAA02GSCRMS2
P4 I $D(^ZAA02GWP(.9,DP,XDC,"CPr")) D CPR
 S K="",CP=$P(^ZAA02GWP(.9,DP,XDC),"\",4) I $D(^(XDC,"GTITLE")) S K=$P(^("GTITLE"),"\",CP),Y=$P(K,"~"),^("TITLE")=$S(Y["*":"Copy for: "_$G(^($TR(Y,"*"))),Y["@":$G(^($TR(Y,"@"))),1:Y)
 K BIN,ENV S ^("TITLEB")=$S(K["~":$G(^("TITLEBC")),1:"") I $D(^("BINS")) S BIN=$P(^("BINS"),";",CP) I BIN=4 D ENV G P2
 S XFR=$P($G(^("XFR")),"`",CP) I $P(XFR,":")="REPORT" S XFR=$P(XFR,":",2) I $D(@ZAA02GSCR@(106,XFR,.03)) S @ZAA02GWPD@(.03)=^(.03) D SETUP^ZAA02GWPPC
 I $P(XFR,":")="D" D @$P(XFR,":",2)
P2 S (X,Z)="" I $D(@ZAA02GWPD@(.03)) S X=$P(^(.03),"\",13),Z=$P(^(.03),"\",14)
P3 I '$D(skipopen),$D(@ZAA02GWPD@(.0115)) S RTN="MEDPRT^ZAA02GVBTERP" Q
 I $D(skipopen) S RTN=skipopen Q
 S:Y["*" Y=$$SIT(Y) S:X["*" X=$$SIT(X)
 S Y=$P(X,"/") I Y'="",$D(@ZAA02GSCR@(110,Y)) S HD="STARTN^ZAA02GWPP4;*\@ZAA02GSCR@(DIR,DOC)`110`"_Y_"`"_$O(^(Y,.03))_"`1"
 S Y=$P(X,"/",2) I Y'="",$D(@ZAA02GSCR@(110,Y)) S FR="STARTN^ZAA02GWPP4;*C\@ZAA02GSCR@(DIR,DOC)`110`"_Y_"`"_$O(^(Y,.03))_"`1"
 I Z'="",$P(X,"/")'=$P(Z,"/") S $P(FR,"\")="PAGE2^ZAA02GSCRMS1;*C"
 Q
PAGE2 I $D(COVER),PG=1 D STARTN^ZAA02GWPP4 S NP=NP-1,PG="1 " Q
 D STARTN^ZAA02GWPP4 S X=$P($P(@ZAA02GWPD@(.03),"\",14),"/")_"/"_$P($P(^(.03),"\",13),"/",2),Z="" K HD,FR G P3 ; 2nd footer is used in Premier
 ;
CPR Q:'$D(@DOC)  S ^("IO")=$E($G(@DOC@(.011,"IO")),1,200)_",P"_$TR($H,",",":")_":"_DP
CPR1 Q:'$D(@DOC)  S K=$P(@DOC,"`",13),K=$E($TR(K,"P~ ")_"~   ",1,4),$P(@ZAA02GSCR@("DIR",99,10000000-$P(DOC,""",""",2)),"`",13)=K,$P(@DOC,"`",13)=K Q
DISTR K NC,BIN,TTL,CD S TNT=^(ZAA02GID),TDV=$P(TNT,"\",3),NC=$P(TNT,"\",2),XFR="",TC=0
 I $D(^(ZAA02GID,1))'=5 F Y=1:1:NC S K(Y)=$G(^(Y))
 S:$P(TNT,"\",5)="Y" ^ZAA02GWP(.9,DP,XDC,"COPYGR")=TDV
 S:$P(TNT,"\",4)]"" ^ZAA02GWP(.9,DP,XDC,"TITLEBC")=$P(TNT,"\",4)
 S ES=$E($P($G(^ZAA02GWP(.9,DP,XDC,"eS")),"\")) F Y=1:1:NC S NC=K(Y),K=$P(NC,"\",2) S:K="" K=DP S:$G(OVD) K=DP D TRDP,COND
 S K="" ; X "N (NC,K,DP,e,TC) W"
 F Y=1:1 S (TDV,K)=$O(NC(K)),NQ=XDC Q:K=""  D:K'=DP CPY S $P(^ZAA02GWP(.9,TDV,NQ),"\",3,4)=NC(K)_"\"_(K=DP),$P(^(NQ),"\",9)=0,^(NQ,"GTITLE")=TTL(K),^("BINS")=$TR(BIN(K),"ABE",124),^("CONDITIONS")=CD(K),^("XFR")=XFR(K)
 S:$D(NC(DP))<1 NOPRINT=1 S:'TC ^ZAA02GWP(.9,DP,XDC,"PAGES")=PG-1_"*" K K,TDV,TNT,BIN,TTL,NC,NQ,CD,XFR Q
COND S e=$P(NC,"\",4) I e]"" S E=$P(e,",") D COND1 Q:$T  S E=$P(e,",",2) I E]"" D COND1 Q:$T
 S E=$P(NC,"\",7) Q:E["N"&(ES'="")  I $S(E["E":0,ES="":E["O",ES="Y":E'["P",1:E["P") Q
 S:$P(NC,"\",6)'="" K=K_";"_$P(NC,"\",6) S:'$D(NC(K)) (NC(K),BIN(K),CD(K),TTL(K),XFR(K))=""
 S TC=TC+1,NC(K)=NC(K)+1,TTL(K)=TTL(K)_$P(NC,"\")_$S(Y=TDV:"~\",1:"\"),BIN(K)=BIN(K)_$P(NC,"\",3)_";",CD(K)=CD(K)_$P(NC,"\",4)_"`",XFR(K)=XFR(K)_$P(NC,"\",5)_"`"
 Q
COND1 I E="" Q
 I $G(^ZAA02GWP(.9,DP,XDC,E))]"",$D(done(^(E))) Q
 S E="$G(^("""_$P($P(E,"="),"'")_"""))"_$S(E?.E1"'=".E:"="""_$P(E,"=",2)_"""",E?.E1"=".E:"'="""_$P(E,"=",2)_"""",1:"=""""") I @E Q
 Q
 ;
TRDP I $G(^ZAA02GSCR("PARAM","DEVICE-TRANSLATION"))]"" S TDV=K X ^("DEVICE-TRANSLATION") S K=TDV
 Q
CPY N VDV L +ZAA02GWP("CONTROL")
 I K[";",$P(K,";")'="" D CPY2 G CPY1
 F NQ=0:1 I $O(^ZAA02GWP(.9,TDV,NQ))'?1.N S NQ=NQ+1 Q
CPY1 S E="",^ZAA02GWP(.9,TDV,NQ)=^ZAA02GWP(.9,DP,XDC) L -ZAA02GWP("CONTROL") S:K[";" $P(^ZAA02GWP(.9,TDV,NQ),"\",11)=$P(K,";",2) F J=1:1 S E=$O(^ZAA02GWP(.9,DP,XDC,E)) Q:E=""  S ^ZAA02GWP(.9,TDV,NQ,E)=^(E)
 M ^ZAA02GWP(.9,TDV,NQ,"DOC")=^ZAA02GWP(.9,DP,XDC,"DOC")
 ; K ^ZAA02GWP(.9,TDV,NQ,"PAGES")
 Q:DP=TDV  D:1 START^ZAA02GSCRSP Q
CPY2 S TDV=$P(K,";"),E=$P(K,";",2),J=$P($G(@ZAA02GSCR@("PARAM","BATCH",E)),"\",12) I $G(^(E))["NO DUPLICATES" X:J]"" J S NQ=E Q
 X:J]"" J S E=E_"_" F NQ=0:1 I '$D(^ZAA02GWP(.9,TDV,E_NQ)) S NQ=E_NQ Q
 Q
 ;
SIT(X) Q:'$D(^ZAA02GWP(.9,TDV,"SITEC")) ""
 Q $P(X,"*")_$G(^("SITEC"))_$P(X,"*",2,99)
ENV I $D(^ZAA02GWP(96,DP,3)) S B(6)=$P(^(3),"\",6),B(7)=$P(^(3),"\",7)
 S (X,Z)="",PGP="ENV",OZAA02GWPD=ZAA02GWPD I $D(@ZAA02GSCR@("PARAM","ENVELOPE")) S DOC=^("ENVELOPE"),PGP="ALL",ZAA02GWPD="@ZAA02GSCR@(110,DOC)",FL=$O(@ZAA02GWPD@(.03)) D SETUP^ZAA02GWPPC K ENV ; ENV header
 I $D(@ZAA02GSCR@("PARAM","LABELS")),^("LABELS")]"" X ^("LABELS") Q
 Q:PGP'="ENV"
ENV2 ; ADS REFERENCES
 S RFR="" I $D(^ZAA02GWP(.9,DP,XDC,"CONDITIONS")),$P(^("CONDITIONS"),"`",CP)]"" S RFR=$P(^("CONDITIONS"),"`",CP)
 I RFR="" S RFR="CONSULT" G ENV3:$D(^ZAA02GWP(.9,DP,XDC,"RFN"))&$D(^("RFCSZ"))
 G ENV1:'$D(^ZAA02GWP(.9,DP,XDC,RFR))
 S RFR=$P(^(RFR)," ") G ENV1:RFR="",ENV1:'$D(^RFG(RFR)) S RFR=^(RFR) D RFN S ^ZAA02GWP(.9,DP,XDC,"RFN")=T,^("RFA1")=$P(RFR,":",4)
 S ^("RFA2")=$P(RFR,":",5),^("RFCSZ")=$P(RFR,":",6)_" "_$P(RFR,":",7)
ENV3 S ENV="""RFN"",""RFA1"",""RFA2"",""RFCSZ"""
ENV1 Q
LABEL1 D ENV2 Q:'$D(ENV)  Q:'$D(^ZAA02GWP(.9,DP,XDC,"PN"))  S ^("BL")=" ",^("RE")=$C(8,8,8,8)_"RE: "_^("PN")
 F J=1:1:7 S ENV=ENV_","""_$P("BL,BL,BL,RE,DS,TR1,TR2",",",J)_""""
 Q
RFN S T=$TR($P(RFR,":",19),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ") Q:T'=""  S T=$P(RFR,":",2) S:T["," T=$P($P(T,","_$S(T[", ":" ",1:""),2)," ")_" "_$P(T,",")_$S(T[" ":" "_$P(T," ",$L(T," ")),1:"") Q
 ;
BOLD ; SCAN REPORT & BOLD STUDY & IMPRESSION
 D REVERS^ZAA02GWPPC1 Q:'$D(ZAA02G("ron"))  S K=.03,K1=ZAA02G("ron"),K2=ZAA02G("rof"),K3=0
BOLD0 F J=1:1 S K=$O(@ZAA02GWPD@(K)) G:K="" BOLDE I ^(K)[":",^(K)'[$C(27),^(K)'["TO:",^(K)'["RE:" Q
BOLD1 D BOLD2
 F J=1:1 S K=$O(@ZAA02GWPD@(K)) G:K="" BOLDE I $P(^(K),$C(1),4)?.5" "5.12A1":".E G:K3 BOLD3 S $P(^(K),$C(1),4)=K1_$P(^(K),$C(1),4) Q
 F J=1:1 S Y=K,K=$O(@ZAA02GWPD@(K)) Q:K=""  Q:$P(^(Y),$C(1),4)_$P(^(K),$C(1),4)=""  Q:$P(^(K),$C(1),4)?20." ".E  I $P(^(K),$C(1),4)[":" G BOLD1
 S ^(Y)=^(Y)_K2 G:K]"" BOLD0
BOLDE K K1,K2,K3 Q
BOLD2 S J=$L($E($P(^(K),$C(1),4),1,5)," ")-1,$P(^(K),$C(1),4)=$J("",J)_K1_$E($P($P(^(K),$C(1),4),":"),J+1,255)_":"_K2_$P(^(K),":",2,99) Q
BOLD3 D BOLD2 G BOLD0
UNDER D REVERS^ZAA02GWPPC1 Q:'$D(ZAA02G("uo"))  S K=.03,K1=ZAA02G("uo"),K2=ZAA02G("uf"),K3=1 G BOLD0
