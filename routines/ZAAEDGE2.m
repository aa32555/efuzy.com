%ZAAEDGE2 ;;03JUN96  17:25;09MAY2003  10:44;UTIL: GLOBAL EDITOR, EDIT;22MAY97  16:52
 ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc.
 ;;All rights reserved.
BEG N i,I,M,V,X,Z,OF,OS,OV,VA,MNL,MSL,xs S OS=ZAA("OS"),MSL=$S(OS="M11":32760,OS="MSM":999,OS="M3":65535,OS="DTM":65530,1:255),MNL=$J(MSL/W+.5,0,0),xs=$TR($J("",$L(CS))," ",".")
 S OF=RF,(V,VA,OV)=$S($D(NEW):"",$D(@RF)#2:@RF,$D(^ZAAEDTMP($J,RF)):^(RF),1:""),Z="",$P(Z,ZAA("HL"),rm+2)="" D BLD S V=VA I ACT="COPY" S NEW=""
 S %R=15,%C=1 W @ZAAP,ZAA("CS"),tLO_ACT_" Reference"_ZAA("G1"),$P(Z,ZAA("HL"),1,rm-7-$L(ACT)),ZAA("G0")
 S %R=16,%C=1 W @ZAAP,tHI_RF,!,tLO_"Data"_ZAA("G1"),$P(Z,ZAA("HL"),1,rm-2),ZAA("G0")
 F I=1:1:X Q:I>6  I $D(X(I)) S %R=I+17,%C=1 W @ZAAP,tHI,$TR(X(I),CS,xs)
EDRF S %R=16,%C=1,Y="RON\ROF\DK,HL,EX\\"_(rm+1),X=RF D READ^ZAAEDRS G:ZAAF="EX" EXIT I ZAAF="HL" S HN=2322 D HELP G EDRF
 I RF["(",$E(X,$L(X))'=")" S X=X_")"
 S RF=X
EDVA D ^ZAAEDGE3 G EXIT:ZAAF="EX",EDRF:ZAAF="UK" D RES
SAVE I $D(NEW) G:RF="" EXIT S:$E(RF,1,2)["(" $P(RF,"(")=GN S:$D(@RF)#2=0 @RF=V,NEW=1,SFX=1 G EXIT
 G:RF=OF SAV2 S SFX=1 I $D(@RF)#2 S QUES="New reference already exists.  OK to overwrite?",X=0 D ASK G:'OK EDRF
 I $D(@OF)\10 S QUES="Old reference has descendants: data will be moved.",X=0 D ASK G:'OK EDRF
SAV2 S @RF=V I RF'=OF D MERGE S @RF=V G EXIT
 D GETVAL S RF=$S(US(NO)="":GN,1:"^("_$TR(US(NO),D,",")_")"),RL=$S($D(nlm):2,$L(RF)<26:27,1:$L(RF)+2) S:$L(V)>(W-RL-4) V=$E(V,1,W-RL-4)_"..." S UV(NO)=$S($D(nlm):"",1:$J("",RL-$L(RF)))_V
EXIT I $D(SFX),SFX D PAGE^ZAAEDGE1 S:NO>CN NO=1 S HLP=0
 I $D(HLP),HLP D PAGE^ZAAEDGE1
 E  F %R=TR+NO-1,15:1:22 S I=%R-TR+1,%C=1,RF=$S($D(US(I))=0:"",US(I)="":GN,1:"^("_$TR(US(I),D,",")_")") W @ZAAP,$S($D(US(I)):tLO_"  "_$S($D(nlm):"",1:RF)_tHI_UV(I)_tCL,1:tCL)
 S %R=23,%C=1 W @ZAAP,ZAA("CS")
 K OF,CTL,NEW,SFX Q
MERGE M @RF=@OF K @OF Q
ASK W pBL,tLO_QUES_"  Please confirm:"_tLO_tCL S %R=bl+2,%C=lm+$L(QUES)+17,Y="RON\ROF\EX\\3\NY\No;Yes" D READ^ZAAEDYN S OK=$S(ZAAF="EX":0,1:X) W pBL_tCL Q
HELP N %R,%C,RF D POS^ZAAEDH(3,17) F %R=3:1:17 S I=%R-3+1,%C=1,RF=$S($D(US(I))=0:"",US(I)="":GN,1:"^("_$TR(US(I),D,",")_")") W @ZAAP,$S($D(US(I)):tLO_"  "_RF_tHI_UV(I)_tCL,1:tCL)
 X ZAA("EOF") Q
BLD K X S X=0,CTL=1 G:$TR(V,CS,"")'=V B2 S CTL=0
B1 S X=X+1,X(X)=$E(V,1,WW),V=$E(V,WW+1,$L(V)) Q:V=""  G B1
B2 D PRF S X=X+1,X(X)=Y G B2:V'="" Q
B3 F I=X+1:1:MNL S X(I)=""
 K Y Q
PRF I $TR(V,CS,"")=V
 S Y=$E(V,1,WW),V=$E(V,WW+1,$L(V)) Q
 S V=$E(V,T,$L(V)) I $L(Y)>WW S V=$E(Y,WW+1,$L(Y))_V,Y=$E(Y,1,WW) K M Q
 I $L(Y)<WW,V'="" S T=$L(Y),Y=Y_$E(V,1,WW-T),V=$E(V,WW-T+1,$L(V))
 K M Q
RES S V="" F I=1:1:MNL Q:'$D(X(I))  S V=V_X(I)
 K X,I Q
GETVAL Q:$TR(V,CS,"")=V  S X=V,M=$TR($E(V,1,W),CS,XS),(T,V)="",w=W-27
 F F=0:0 S F=$F(M,$C(1),F) Q:'F  S V=V_$E(X,T,F-2)_"<"_$A(X,F-1)_">",T=F Q:$L(V)>w
 S V=V_$E(X,T,w-$L(V)) K w,F,M,T,X Q
