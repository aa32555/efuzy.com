ZAA02GSCMEC ;PG&A,ZAA02G-MTS,1.95,ERROR PROCESSING;27SEP95 1:15P;;;31OCT2003  16:51
C ;Copyright (C) 1996, Patterson, Gray & Associates, Inc.
 ;
 U 0 D:'$D(ZAA02G("F")) FUNC^ZAA02GDEV W ZAA02G("ROF"),ZAA02G("UF"),ZAA02G("F") D HEAD S %R=1,%C=33 W @ZAA02GP,ZAA02G("LO"),"ZAA02G-MTS ERROR LOG" L
 S A="" S:$D(TRANS) A=TRANS S A=A_"\" S:$D(DOC) A=A_DOC S A=A_"\",B="B="_^ZAA02G("ERRORR"),@B Q:B["DSCON"
 I B'["INR"&(B'["INT") S C=$P($H,",",2),@ZAA02GSCMD@(109,+$H,C)=B_"\"_$I_"\"_A_"\"_$G(E)
 I  I B["SCRER" S A=$O(^(C,0)) F J=1:1 S A=$O(INP(A)) Q:A=""  S ^(A)=INP(A)
 I  I B["ZAA02GPOP" S A=$O(^(C,0)) F J=1:1 S A=$O(INP(A)) Q:A=""  S ^(A)=INP(A)
 S %C=13,%R=5 W ZAA02G("HI"),$G(rm),@ZAA02GP,"Dear User,",!!?18,"An error has occured in the ZAA02G-MTS software.  The",!
 W ?12,"message has been logged and your operation has been cancelled.",!
 W ?12,"If you continue to have difficulties, please notify the",!
 W ?12,"appropriate systems personnel.",!
 S %C=10,%R=20 W @ZAA02GP,ZAA02G("LO"),"Error Code: ",ZAA02G("HI"),$E(B,1,70)
 I B["WPV" D FIX
 S %R=12,%C=38 W @ZAA02GP,"Press RETURN to return to menu " R A#1 I A="S"!(A="s") D INTERR
 D FAXLOG G START
START S A=^ZAA02G("ERROR")_"=""^ZAA02GSCMEC""",@A K (ZAA02GPWD) K:0 (ZAA02G,ZAA02GP,ZAA02GX,ZAA02GY,XX,ZAA02GID,DIR,ZAA02GBUF,TRANS,ZAA02GSCR,ZAA02GSCM,ZAA02GSCMD,TSU,WORKT,TRTYPE,ZAA02GPWD) G ^ZAA02GSCM
 ;
HEAD W ZAA02G("F") S %R=1,%C=2 W ZAA02G("LO"),@ZAA02GP,ZAA02G("RON")," P ",ZAA02G("RT")," G ",ZAA02G("RT")," & ",ZAA02G("RT")," A " S %C=69 W @ZAA02GP," ZAA02G-SCRIPT ",ZAA02G("ROF"),!,ZAA02G("G1") S J=ZAA02G("HL"),J=J_J_J_J F I=1:1:20 W J
 W ZAA02G("G0") Q
 ;
FAXLOG D DATABASE Q:'$D(@ZAA02GSCM@("PARAM","FAX"))  S LOG=^("FAX") Q:$P(LOG,"\",7)'="Y"  Q:$P(LOG,"\",10)=""  S BASIC=^("BASIC")
 S (A,B,CNT)="" F J=1:1 S A=$O(@ZAA02GSCMD@(109,A)) Q:A=""  I $D(^(A))=10 F J=1:1 S B=$O(@ZAA02GSCMD@(109,A,B)) Q:B=""  S:$P(^(B),"\",6)'="Y" CNT=CNT+1
 Q:$P(LOG,"\",8)>CNT
 S WR="FAX",ZAA02GWPD="^ZAA02GTFAX($J)",FX=10 K @ZAA02GWPD S @ZAA02GWPD@(1)="ZAA02G-SCRIPT FAX LOG - "_CNT_" ERRORS",^(2)="",^(3)="  DATE     TIME     ERROR                         DEVICE      TR    DOC"
 D LOG Q:FX=10
 S FAXPARAM="ZAA02G-SCRIPT"_"``"_$P(BASIC,"|")_"`Support Staff`"_$P(LOG,"\",10)_"``1``Y```N`````ERLOG" D QUEUE^ZAA02GFAXQ Q
LIST D DATABASE S WR="WR" G LOG
DATABASE S ZAA02GSCM=$S($D(^ZAA02GSCM("ST",TSU,"PARAM","DATABASE")):^("DATABASE"),1:"^ZAA02GSCM") Q
LOG S (A,B,C)="" F J=1:1 S A=$O(@ZAA02GSCMD@(109,A)) Q:A=""  I $D(^(A))=10!(WR'="FAX") S:WR="FAX"&$O(^(A)) ^(A)=+$H D DATE S X="" D @WR F J=1:1 S B=$O(@ZAA02GSCMD@(109,A,B)) Q:B=""  S C=^(B) D TIME S X=$J(DT,8)_$J(TM,7)_" " D LOG1 D @WR
 Q
LOG1 S C=$TR(C,$C(2)," ") F K=1:1:5 S X=X_" "_$E($P(C,"\",K)_$J("",35),1,$P("33,10,4,6,6",",",K))
 Q
WR W X,! Q
FAX S:X]""&($P(C,"\",6)'="Y") $P(^(B),"\",6)="Y" S @ZAA02GWPD@(FX)=X,FX=FX+1 Q
DATE S K=A>21608+305+A,Y=4*K+3\1461,D=K*4+3-(1461*Y)+4\4,M=5*D-3\153,D=5*D-3-(153*M)+5\5,M=M+2,Y=M\12+Y+140,M=M#12+1,K="/" S:ZAA02G("d") K=M,M=D,D=K,K="." S Y=Y*100+M*100+D,DT=$E(Y,4,5)_K_$E(Y,6,7)_K_$E(Y,2,3) K K,M,D Q
TIME S TM=B\60,TM=$E(TM\60+100,2,3)_":"_$E(TM#60+100,2,3) Q
 ;
INTERR W !,B,! X ^ZAA02G("ECHO-ON") F JJ=1:1 W !,">>" R CC,! Q:CC=""  X CC
 X ^ZAA02G("ECHO-OFF") Q
 ;
FIX I '$D(FIX),$D(ZAA02GWPD) S FIX=1,D=.03,I=$D(@ZAA02GWPD@(A)) F I=1:1 S X=D,D=$O(^(D)) Q:D=""  I $G(^(D))[$C(1) S:+^(D)'=X $P(^(D),$C(1))=X
 K FIX Q
 ;
save D @("save"_^ZAA02G("OS"))
saveMSM S %2="S %1=$ZO(@%1)" G saveX
saveDTM S %2="S %1=$Q(@%1)" G saveX
saveX S %="%" F  S %=$O(@%) Q:%=""  S:$D(@%)#10 @ZAA02GSCMD@(109,+$H,C,%)=@% I $D(@%)>1 S %1=% F  X %2 Q:%1=""  S @ZAA02GSCMD@(109,+$H,C,%1)=@%1
 S:$D(@ZAA02GSCMD@(109,+$H,C,1,"%")) %=^("%") S:$D(^("%1")) %1=^("%1") S:$D(^("%2")) %2=^("%2") Q
 ;
savePSM Q
