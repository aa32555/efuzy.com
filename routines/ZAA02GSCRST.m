ZAA02GSCRST ;PG&A,ZAA02G-SCRIPT,2.10,STATS;2DEC94 4:57P;;;Wed, 25 Feb 2015  16:54
 ;Copyright (C) 1984, Patterson, Gray & Associates, Inc.
C ;
 ;
IND S HD="I N D I V I D U A L   S T A T I S T I C S"
 S T1="TR",T2="Transcriptionist",CTX=$TR(TRANS,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ"),EX="I $P(CT,""-"")=CTX" G REPS
USER S HD="U S E R    S T A T I S T I C S" K CTX
 S T1="TR",T2="Transcriptionist",EX="I 1" G REPS
TRSITE I $P(ZAA02GSCRP,";",3)=2 G TECH
 S HD="TRANSCRIPTIONISTS/DEPARTMENT" K CTX
 S T1="TRS",T2="Transcriptionist",EX="I 1" G REPS
TECH S HD="TECHNOLOGISTS" K CTX
 S T1="TRS",T2="Technologist",EX="I 1" G REPS
COMP S HD="C O M P O S I T E   U S E R   S T A T I S T I C S" K CTX
 S T1="TR",T2="Transcriptionist",EX="I 2" G REPS
TYP S HD="R E P O R T   T Y P E    S T A T I S T I C S"
 S T1="TYPE",T2="",CT="TYPE",EX="I 1" G REPS
AD S HD="A D   H O C   R E P O R T I N G" G ^ZAA02GSCRSA
PROV S HD="P R O V I D E R     S T A T I S T I C S"
 S T1="PROV",T2="Provider",EX="I 1" G REPS
SITES S HD="S I T E    S T A T I S T I C S"
 S T1="SITEC",T2="Sites",EX="I 1" G REPS
FAX S HD="F A X   L O G",SNL=6,T1="" D SETUP Q:'$D(BEG)
 G FAXR^ZAA02GSCRFX1
FAXE S HD="F A X   E R R O R   L O G",SNL=6,T1="" D SETUP Q:'$D(BEG)
 G FAXER^ZAA02GSCRFX1
 ;
SETUP S %R=1,%C=18,C=48-$L(HD),C=$J("",C\2)_HD_$J("",C\2) W @ZAA02GP,ZAA02G("HI"),C,!!,ZAA02G("CS") D DATES I ZAA02Gform["C-TIMEOUT" K BEG Q
 Q:'$D(BEG)  S:'$D(END) END=DT S DV=0 I DEVICE>1 S:DEVICE=2 DV=$P(@ZAA02GSCR@("PARAM","BASIC"),"|",9) D:DEVICE=3!(DV="") GETPRNT^ZAA02GSCRSP I DV="" K BEG
 S %R=3,%C=1 W @ZAA02GP,ZAA02G("CS") Q
SETUP1 S BM=$P(BEG,"/",3)_$E(BEG,1,2),BD=$P(BEG,"/",2),EM=$P(END,"/",3)_$E(END,1,2),ED=$P(END,"/",2),BEG=$P(BEG,"/",1,3),END=$P(END,"/",1,3)
 S (TW,TL,TR,TM,LN)=0,PG=0,LNM=$S(DEVICE=1:20,DEVICE=1.1:50,1:55),OFF=$S(DEVICE=1:0,1:OFF),CONT="",LN=999,SITEC=$E(SC,2,9999)
 K RTYPE Q:$G(@ZAA02GSCR@("PARAM","REPORT TYPE"))=""  S RTYPE=^("REPORT TYPE") S Ct=$O(@RTYPE@(0)),RTYPE=$S(RTYPE["(":$E(RTYPE,1,$L(RTYPE)-1)_",",1:RTYPE_"(")_"Ct" I Ct]"",$D(^(Ct))=10 S RTYPE=RTYPE_",0"
 S RTYPE=RTYPE_")" Q
 ;
SITE ; SETUP SITE CODES
 K SITEC S (SITEC,A)="",%C=32,%R=9 W ZAA02G("HI")
 I T1'="SITEC",T1'="TRS"
 I  D FETCHS S B="" F J=1:1 S C=A,A=$O(@ZAA02GSCR@("STATS",A)) Q:A=""  F J=1:1 S B=$O(@ZAA02GSCR@("STATS",A,B)) Q:B=""  I B'="NA",'$D(SITEC(B)) S:%C>75 %C=32,%R=%R+1 W @ZAA02GP,B S SITEC=SITEC_","_B,%C=%C+2+$L(B),SITEC(B)=""
 I SITEC="" S SITEC="NA",SITEC("NA")="" W @ZAA02GP,"NA",ZAA02G("HI") Q
 S SITEC=$E(SITEC,2,9999),@ZAA02GSCR@("PARAM","SITEC")=C-1_"|"_SITEC W ZAA02G("HI") Q
FETCHS S:$D(@ZAA02GSCR@("PARAM","SITEC")) A=$P(^("SITEC"),"|"),SITEC=","_$P(^("SITEC"),"|",2) F J=2:1:$L(SITEC,",") S B=$P(SITEC,",",J) I B]"" S:%C>75 %C=32,%R=%R+1 W @ZAA02GP,B S SITEC(B)="",%C=%C+2+$L(B)
 Q
HEAD S PG=PG+1 I DEVICE=1 S LN=2,%R=3,%C=1 W @ZAA02GP,ZAA02G("CS") S %C=2 W @ZAA02GP,ZAA02G("LO"),"DATES: ",ZAA02G("HI"),BEG," - ",END S %C=35 W:SITEC'="NA" @ZAA02GP,ZAA02G("LO"),"SITE: ",ZAA02G("HI"),$E(SITEC,1,39) W !!
 I DEVICE>1 D TOP
 W ?9+OFF,"              # Chars    # Lines   # Reports  LN/Report   LN/Hour",!?9+OFF,"             ---------  ---------  ---------  ---------  ---------",! S LN=LN+2
 Q
TOP S LN=5 X:$D(HDRX) HDRX X:$D(B(4))+$D(LC)=2 "F AA=2:1:LC+B(4)*6 W !" W !?OFF,DT S AA=$P(@ZAA02GSCR@("PARAM","BASIC"),"|"),C=80-$L(AA) W ?C\2+OFF,AA,?73+OFF,"Page ",PG,! S C=80-$L(HD) W ?C\2+OFF,HD,!
 S AA="DATES: "_BEG_" - "_END S:SITEC'="NA" AA=AA_"   SITE: "_SITEC S C=80-$L(AA) W ?C\2+OFF,AA,!! Q
 ;
NEXT I DEVICE=1,PG>0 S %R=24,%C=20 W @ZAA02GP,"Press RETURN to continue - EXIT to quit " R C#1 X ZAA02G("T") S:$E(XX,$F(XX,ZF))="E" J=999 G HEAD:J'=999 Q
 W:LN'=999 # G HEAD
 ;
INIT S LF="LL="_$P(@ZAA02GSCR@("PARAM","BASIC"),"|",4),WF="CC="_$P(^("BASIC"),"|",2) Q
END I $D(TR),DEVICE=1,TR=0 S %R=10,%C=18 W @ZAA02GP,"No statistical data found for dates specified"
 I $D(TR),DEVICE=1 S %R=24,%C=34 W @ZAA02GP,"Press RETURN " R C#1
 I DEVICE>1,$E(DV)'=" " W #
DONE K TR,TL,TW,TM,W,L,R,B,C,S,LN,LNM,BEG,END,TYPE,REPORT,DEVICE,SITE,PG,T1,T2,OFF,CC,LL,WF,LF,ED,AA,SITEC,Ct,^ZAA02GTSCR($J),CTX Q
 ;
DATES S SCR="ZAA02GSCRIPT",(REPORT,DEVICE,SITE)=1,REFRESH="3:22",ZAA02Gform="0;;;N"
 D ^ZAA02GFORM,DATE^ZAA02GSCRER
 Q
TYPE S X=REPORT,%R=14,%C=31,Z="SUMMARY,DETAIL,GRAPH" D POP S REPORT=X Q
SITEC K YY S YY=1,X=SITE,Z=SITEC,%R=9,%C=31 I X["," F J=1:1:$L(X,",") S G=$P(X,",",J) S:G YY(G)=1
 S:$E(Z,$L(Z))="," Z=$E(Z,1,$L(Z)-1)
 S X=+X D POP S SITE=X,(X,G)="" F J=1:1 S G=$O(YY(G)) Q:G=""  S:YY(G) X=X_G_","
 S:X'="" SITE=X S SC="",X=SITE F J=1:1:$L(X,",") S G=$P(X,",",J) S:G SC=SC_","_$P(Z,",",G)
 W ZAA02G("HI") K YY Q
DEV S X=DEVICE,%R=16,%C=31,Z="TERMINAL,DEFAULT PRINTER,OTHER PRINTER" D POP S DEVICE=X Q
POP X ZAA02G("ECHO-OFF") S H=%C,G=$L(Z,","),R=%R
P1 S %R=R,%C=X-1*(R'=9+1)+H+$L($P(","_Z,",",1,X)),OX=X S:%C>74 %R=%C-H\43+R,%C=%C-H#43+H-1
 W @ZAA02GP,ZAA02G("RON")," ",$S('$G(YY(X)):$P(Z,",",X)_" ",1:ZAA02G("HI")_$P(Z,",",X)_"+"),ZAA02G("HI"),ZAA02G("ROF")
 R C#1 I C'="" G P1
 X ZAA02G("T") S F=$E(XX,$F(XX,ZF)),D=$E(1313,$F("CD7",F))-2 S:F=7&$D(YY) YY(X)=$G(YY(X))+1#2 K:$G(YY(X))=0 YY(X) S X=X+D-1#G+1 I "FAEB"[F S X=OX,RX=$S(F="E":99,F="A":-1,1:1) X ^ZAA02G("ECHO-ON") W:$D(YY)>1&('$D(YY(X))) @ZAA02GP,ZAA02G("ROF")," ",$P(Z,",",X)," " Q
 W @ZAA02GP,$S('$G(YY(OX)):" "_$P(Z,",",OX)_" ",1:ZAA02G("LO")_ZAA02G("RON")_" "_$P(Z,",",OX)_"+"),ZAA02G("HI") G P1
 ;
REPS S SNL=6 D SETUP G:'$D(BEG) DONE
 ;
REP G:REPORT["^" @REPORT I $D(%R),DEVICE>1 D QUEUE^ZAA02GSCRST1 G DONE
 D SETUP1,INIT S:T1="TRS" REPORT=2 I EX="I 2" D ^ZAA02GSCRST6 G DONE
 I REPORT=2,T1'="TYPE" D @$S(EX="I 1":"^ZAA02GSCRST5",1:"^ZAA02GSCRST1") G DONE
 I REPORT=3 D ^ZAA02GSCRST4 G DONE
 ;
SUMMARY S CT="" K ^ZAA02GTSCR($J)
 F SI=1:1:$L(SITEC,",") S SC=$P(SITEC,",",SI) F Y=BM:1:EM S:$E(Y,5,6)=13 Y=Y+88 F J=1:1 S CT=$O(@ZAA02GSCR@("STATS",Y,SC,T1,CT)) Q:CT=""  X EX S:$T ^ZAA02GTSCR($J,CT)=""
 S CT="" F J=1:1 S CT=$O(^ZAA02GTSCR($J,CT)) Q:CT=""  D REPT G DONE:J=999
 I TR D:LN>LNM NEXT G DONE:J=999 I '$D(CTX)!(CT["-") W ?22+OFF,"=========  =========  =========  =========  =========",!?14+OFF,"TOTAL",?20+OFF,$J(TW,11),$J(TL,11,0),$J(TR,11),$J(TL\TR,11),$J(TL*600\('TM+TM),11),!
 G END
REPT S (C,W,L,R,A,MN,TT,B,S)=0 F SI=1:1:$L(SITEC,",") S SC=$P(SITEC,",",SI) F M=BM:1:EM S B1=$S(M=BM:BD,1:1),B2=$S(M=EM:ED,1:31) D R1:B2'<B1
 Q:+TT=0
 ;
 D:LN+2>LNM NEXT Q:J=999
 W ?1+OFF,$E(CT,1,18) S Ct=CT I $L(CT)<4,$G(RTYPE)]"",$D(@RTYPE) W ?4+OFF,$E($P(@RTYPE,"^"),1,15)
 W ?20+OFF,$J(CC,11),$J(LL,11,0),$J(R,11),$J(LL\('R+R),11),$J(LL*600\('MN+MN),11),! S TM=TM+MN,TW=TW+CC,TL=TL+LL,TR=TR+R,LN=LN+1 Q
R1 I $D(@ZAA02GSCR@("STATS",M,SC,T1,CT))=0 S:$E(M,5,6)>12 M=M+87 Q
 F J=1:1 S A=$O(@ZAA02GSCR@("STATS",M,SC,T1,CT,A)) Q:A=""  D R2:A'="TOTAL"
 Q
R2 S Z=^(A,1),C="C="_$P(Z,"+",B1,B2)_"+"_C
 S Z=^(2),L="L="_$P(Z,"+",B1,B2)_"+"_L,Z=^(3),W="W="_$P(Z,"+",B1,B2)_"+"_W,Z=^(4),B="B="_$P(Z,"+",B1,B2)_"+"_B,Z=^(5),S="S="_$P(Z,"+",B1,B2)_"+"_S,Z=^(6),R="R="_$P(Z,"+",B1,B2)_"+"_R
 S Z=^(7),MN="MN="_$P(Z,"+",B1,B2)_"+"_MN,@C,@L,@W,@B,@S,@R,@MN,TT=TT+R,@LF,@WF Q
 ;
VB ;
 S $ZE="",P=$TR($P(X,"|",$P(X,"|",7)="RUN"+7),$C(9),"|")
 S SC=$TR($P(P,"|"),$C(0),","),BEG=$P(P,"|",2),END=$P(P,"|",3),T2=$P(P,"|",4),DET=$P(P,"|",5)
 S BEG=BEG_"/"_$$JULIAN^ZAA02GVBAS($$DTL^ZAA02GVBAS(BEG)),END=END_"/"_$$JULIAN^ZAA02GVBAS($$DTL^ZAA02GVBAS(END))
 S DEVICE=1.1,OFF=10,ZAA02GSCR="^ZAA02GSCR",ZAA02GSCRP=";;2",TYPE=1
 S T=$P(P,"|",5),TYPS=$F("PRSTG",$E(T))-1,T=$E($P(P,"|",4)),STATC="STAT"_$S(T="M":"S",1:"S")
 S Y="Provider,PROV\Site,SITEC\Report Type,TYPE\Transcriptionist,TR\Composite Transcriptionists,TR\Technologists,TRS\Ad Hoc,AH\Fax,FAXR^ZAA02GSCRFX1\Fax Errors,FAXER^ZAA02GSCRFX1"
 S T1=$P($P($P(Y,T2,2),",",2),"\"),REPORT=DET="Detail"+1
 S EX="I 1",HD=T2_" Report"
 I T1'["^",$G(@ZAA02GSCR@("PARAM","NOSITESTATS"))="Y" S SC="NA"
 S SC=","_SC D DATE^ZAA02GSCRER
 S B(2)=11,B(3)=.5,B(4)=.9
 I REPORT=2,T1="TR" S EX="I 3"
 I T1["^" S REPORT=T1,T1=""
 S DONE=1,TS="",DV=" "
 I P2>0 S DV=P2,%R=1,DEVICE=2 D REP S B="" Q
 D REP W # S B="" Q
