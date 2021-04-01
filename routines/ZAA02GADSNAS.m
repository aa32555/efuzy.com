ZAA02GADSNAS ;ZAA02G Script interface for Nassau Radio.;27APR93  11:32;10JAN93 6:01P;;Fri, 17 Oct 2008  14:34
 N K,K1,GR,PT,T,LDT,PLC
 S K=X,K1=1 S:X["/" K=+X,K1=$P(X,"/",2)
 S LDT="",INP("PATIENT")="",INP("DOB")=""
 I K="" G LOAD
 S GR=$G(^GRG(K))    G:GR="" LOAD
 S PT=$G(^PTG(K,K1)) G:PT="" LOAD
 S T=$P(PT,":",3) S:T="" T=$P(GR,":",7) S INP("PATIENT")=T
 D SHOW
 S T=$P(PT,":",12) S:T?6N INP("DOB")=$E(T,3,4)_"/"_$E(T,5,6)_"/"_$E(T,1,2) S:T?8N INP("DOB")=$E(T,5,6)_"/"_$E(T,7,8)_"/"_$E(T,1,4)
 ; S T=$P(PT,":",14) S INP("DS")=$S(T?6N:$E(T,3,4)_"/"_$E(T,5,6)_"/"_$E(T,1,2),1:"*") ;MP
 ;
 ;  turned off as per docs request
 ;I $D(^STUDU) D
 . S S4="" F  S S4=$O(^STUDU(S4)) Q:S4=""  I $D(^STUDU(S4,K,K1)) Q
 . Q:S4=""  S PLC=$G(INP("SITEC")) D STUDY D:$D(REFRESH) AP0^ZAA02GFORM4 S:LDT[";EX" LDT=""
 ;
 I $D(INP("DT")) S INP("D")=$P("January,February,March,April,May,June,July,August,September,October,November,December",",",INP("DT"))_" "_$P(INP("DT"),"/",2)_", 19"_$P(INP("DT"),"/",3)
 ;
LOAD ;;
 S INP("CONSULT")=""
 S INP("REV")="" ; REV is used to store CONSULT2
 S INP("CC1")=""
 S INP("CC2")=""
 S INP("DS")="" ;MP changed from FDY
 S INP("PROC1")=""
 S INP("PROC2")=""
 S INP("MR")=X Q:K=""
 S PLC=$G(INP("SITEC"))
 ;;
 D NEWSTUDY Q:LDT'=""
 ;;
 D OLDSTUDY
 Q
 ;
OLDSTUDY N VISIT,A,DT,D D TDATE
 S (A,LDT)=""  I PLC'="" S LDT=$O(^STUD(K,K1,PLC,DT),-1)
 I LDT="",PLC'="" S:$O(^STUD(K,K1,PLC,DT),-1)>LDT LDT=$O(^(DT),-1)
 Q:PLC=""  Q:LDT=""
 S VISIT=^STUD(K,K1,PLC,LDT)
 S T=LDT S:T?8N INP("DS")=$E(T,5,6)_"/"_$E(T,7,8)_"/"_$E(T,3,4) S:T?6N INP("DS")=$E(T,3,4)_"/"_$E(T,5,6)_"/"_$E(T,1,2) ; MP changed FDY to DS
 S INP("PROC1")=$P(VISIT,":",1)
 S INP("PROC2")=$P(VISIT,":",3)
 S INP("CONSULT")=$P(VISIT,":",2) I INP("CONSULT")]"" D RPHONE
 ; S INP("REV")=$P(VISIT,":",4) ; 2nd consult
 S INP("CC1")=$P(VISIT,":",7)
 S INP("CC2")=$P(VISIT,":",8)
 Q
TDATE N K,Y,M D DATE^ZAA02GSCRER S DT=YM*100+$P(DT,"/",2)+1 Q
 ;
 ;;  THIS CODE CALLED FROM ID BLOCK
LOADN S:'$D(INP("DIST")) INP("DIST")="A" ; I $G(INP("PROVIDER"))="",TRANS="we"!(TRANS="le") S INP("PROVIDER")=$S(TRANS="we":"DW",1:"LF") q
 I $G(INP("PROVIDER"))="",$D(TRANS),TRANS]"",$D(^PVG($TR(TRANS,LC,UP))) S INP("PROVIDER")=$TR(TRANS,LC,UP)
 Q
RPHONE S T=INP("CONSULT") I T]"",$D(^RFG(T)),$P(^(T),":",8)]"" S INP("REV")=$P(^(T),":",8)
 Q
 ; not currently used
STUDY N:1 (ZAA02G,ZAA02GP,PLC,K,K1,REFRESH,LDT,INP) S Y="8,7\RLHSG1\1\STUDY: "_$G(INP("PATIENT"))_"\   DATE      SITE      PROCEDURE          REFERRAL         REPORT  ",REFRESH="",LX=""
 S Y(0)="10\EX\\$S(LS=S2:$J($C(34),4),1:$E(S2,5,6)_""/""_$E(S2,7,8)_""/""_$E(S2,1,4));10`S;4`$P(LX,"":"");15`$S($P(LX,"":"",4)="""":"""",1:$P($G(^RFG($P(LX,"":"",4))),"":"",2));17`$P(LX,"":"",9);8\"_PLC
 S ZAA02GS1="S S=$P(TO,""|""),S2=$P(TO,""|"",2),S3=$P(TO,""|"",3),S4=$P(TO,""|"",4)"
 S ZAA02GPOPALT=$P($T(LOOKT+(PLC="")),";",2,99)
 S X="" D ^ZAA02GPOP S LDT=X Q
 ;
LOOKT ;X ZAA02GS1 S LS=S2 F jj=1:1 S:S2="""" S4=$O(^STUDU(S4)) S:jj=999!'$L(S4) TO="""" Q:'$L(TO)  S:S3="""" S2=$O(^STUDU(S4,K,K1,S,S2),-1) I $L(S2) S S3=$O(^STUDU(S4,K,K1,S,S2,S3)) I $L(S3) S TO=S_""|""_S2_""|""_S3_""|""_S4,LX=^(S3) Q
 ;X ZAA02GS1 S LS=S2 F jj=1:1 S:S2="""" S4=$O(^STUDU(S4)) S:jj=999!'$L(S4) TO="""" Q:'$L(TO)  S:S2="""" S=$O(^STUDU(S4,K,K1,S)) I $L(S) S:S3="""" S2=$O(^STUDU(S4,K,K1,S,S2),-1) S:$L(S2) S3=$O(^STUDU(S4,K,K1,S,S2,S3)) I $L(S3) S TO=S_""|""_S2_""|""_S3_"|"_S4,L
 ;
NEWSTUDY N VISIT,A,DT,D I LDT["|" S PLC=$P(LDT,"|")
 I LDT="" D  Q:LDT=""  S LDT=S4_"|"_PLC_"|"_LDT_"|1"
 . D TDATE S (A,LDT,S4)=""  I PLC'="" D  Q
 .. F  S S4=$O(^STUDU(S4)) Q:S4=""  I $O(^(S4,K,K1,PLC,DT),-1) S LDT=$O(^STUDU(S4,K,K1,PLC,DT),-1) Q
 . S S5="" F  S S5=$O(^STUDU(S5)) Q:S5=""  F  S A=$O(^STUDU(S5,K,K1,A)) Q:A=""  S:$O(^STUDU(S5,K,K1,A,DT),-1)>LDT LDT=$O(^(DT),-1),PLC=A,S4=S5
 Q:PLC=""  Q:LDT=""  I S4="" S LDT="" Q
 S VISIT=^STUDU(S4,K,K1,PLC,$P(LDT,"|",3))
 S T=$P(LDT,"|",3) S:T?6N INP("DS")=$E(T,3,4)_"/"_$E(T,5,6)_"/"_$E(T,1,2) S:T?8N INP("DS")=$E(T,5,6)_"/"_$E(T,7,8)_"/"_$E(T,3,4) ; MP changed FDY to DS
 S INP("FDY")=LDT
 S INP("PROC1")=$P($G(^($P(LDT,"|",3),1)),":")
 S INP("CONSULT")=$P($G(^(1)),":",4)
 S INP("PROC2")=$P($G(^(2)),":")
 S INP("REV")=$P($G(^(2)),":",4) ; consult 2
 S INP("CC1")=$P(VISIT,":",9)
 S INP("CC2")=$P(VISIT,":",10)
 S INP("CC3")=$P(VISIT,":",11)
 Q
 ;
 ;  CODE BELOW CALLED BY RSL LOGIC WHEN REPORT IS CREATED
PROC F II=1,2 S A="PROC"_II I INP(A)]"",$D(^PCG(INP(A))) S $P(Y,"`",5+II)=$E($P(^(INP(A)),":",2)_"~       ",1,6)
 ; S $P(Y,"`",9)=$E($E($G(INP("DT"))_"            ",1,9)_$G(INP("TM"))_"~      ",1,14)
 Q
STUDU Q:$G(INP("FDY"))'["|"
 N I,J,K,K1 S J=INP("FDY"),K=$P($G(INP("MR")),"/"),K1=$P($G(INP("MR")),"/",2) S:K1="" K1=1
 I $L(J,"|")=3 F I=0,1 I $D(^STUDU(1,K,K1,$P(J,"|"),$P(J,"|",2),$P(J,"|",3)+I)) S $P(^($P(J,"|",3)+I),":",9)=DOC
 I $L(J,"|")=4 F I=0,1 I $D(^STUDU($P(J,"|"),K,K1,$P(J,"|",2),$P(J,"|",3),$P(J,"|",4)+I)) S $P(^($P(J,"|",4)+I),":",9)=DOC
 Q
STPROC D PROC,STUDU Q
 ;
SHOW Q:'$D(@ZAA02GSCR@("DIR",3,K_" "))  N X
SHOW0 D SHOW1 I $G(REFRESH)>0 D AP0^ZAA02GFORM4
 Q:X=""  Q:X["EX"  D SHOW3 S %R=3,%C=1 W @ZAA02GP,ZAA02G("CS") S REFRESH="3:24" D AP0^ZAA02GFORM4
 G:X=1 SHOW0 Q
SHOW3 N (ZAA02G,ZAA02GP,ZAA02GSCR,ZAA02GSCRP,X) S TL=5,ZAA02GWPD=ZAA02GSCR_"(""TRANS"",DOC)",DOC=10000000-X
 I $D(@ZAA02GSCR@("TRANS",DOC))<11 D ARCH^ZAA02GSCRAT Q:DOC=""  Q:'$D(@ZAA02GSCR@("TRANS",DOC))
 S ZAA02GWPB=ZAA02GWPD S TOPP=4,%R=3,%C=2 W @ZAA02GP,ZAA02G("RON"),$TR($G(@ZAA02GSCR@("TRANS",DOC)),"`~","  "),ZAA02G("ROF")
 S WO="",MG=76,NM=DOC,ZAA02GWPOPT="INQ,NC",HLPR="^ZAA02GSCRH" D ENTRY^ZAA02GWPV6
 S Y=$S($D(^ZAA02GFAXC):4,1:10)_",24\UHP5\*\\\SELECT ANOTHER REPORT,PRINT REPORT,"_$S($D(^ZAA02GFAXC):"FAX,",1:"")_"EXIT",Y(0)="\EX"
 S %R=24,%C=1 W @ZAA02GP,ZAA02G("CL") D ^ZAA02GPOP G PRINT^ZAA02GSCRAI:X=2,FAX^ZAA02GSCRAI:X=3&(Y["FAX") Q
SHOW1 S T=INP("PATIENT")_"  "_K N (ZAA02GSCR,ZAA02G,X,K,T,ZAA02GP,REFRESH) S REFRESH="",Y="8,4\RHLS\1\"_T_"\  JOB   DR  REFR PROC1 PROC2   DOS    DATE  TIME SC ST"
 S Y(0)="15\EX\@ZAA02GSCR@(""DIR"",3,K_"" "")\$$SHOW2^ZAA02GADSNAS(TO)\\Press RETURN to view report, EXIT to continue  *" D ^ZAA02GPOP
 Q
SHOW2(TO) N J,X,A S X="",A=$TR($G(@ZAA02GSCR@("DIR",99,TO)),"~")
 F J=1,4:1:11,13 S X=X_$E($P(A,"`",J)_"              ",1,$P("7,,,2,4,5,5,8,5,5,2,,4",",",J))_" "
 Q X_$S($G(@("^ZAA02GSCMD"_$P(ZAA02GSCR,"ZAA02GSCR",2)_"(""EXAM"",10000000-TO)"))["XXM":"  "_$G(ZAA02G("BO"))_"   ALERT   "_$G(ZAA02G("BF")),1:"")
