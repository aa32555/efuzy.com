ZAA02GFAXU ;PG&A,ZAA02G-FAX,1.36,UTILITIES;29NOV95 4:44P;;;Thu, 29 Jan 2015  14:49
 ;Copyright (C) 1991-1994 Patterson, Gray and Associates Inc.
SUSPEND S S=$D(^ZAA02GFAXC("SUSPEND"))+2
 K Y S YY=$S('$D(ZAA02G(9)):"Do you want to \SUSPEND\RESUME\ Modem Activity\Yes\No\Completed\no change\MODEM ACTIVITY SUSPENDED",1:@ZAA02G(9)@(32)),Y(0)="\EX",Y="15,15\KRHLY\1"
 S Y(1)="*",Y(2)="*"_$P(YY,"\")_$P(YY,"\",S)_$P(YY,"\",4),Y(3)="*",Y(4)=$P(YY,"\",5),Y(5)=$P(YY,"\",6)
 D ^ZAA02GFAXU2 S X=X=4&(X'[";EX") K Y S Y="30,16\RW3\1\\\"_$P(YY,"\",8-X) I X=1 S:S=2 ^ZAA02GFAXC("SUSPEND")="" K:S=3 ^ZAA02GFAXC("SUSPEND")
 D ^ZAA02GFAXU2 K X,Y,S Q
 ;
SETBAUD I ^ZAA02G("OS")="MSM" U DV:(:::::::$S(BAUD=2400:8347,1:8350)) Q  ;8347
 I ^ZAA02G("OS")="DTM" Q:DV>399  U DV:(SPEED=BAUD) Q
 I ^ZAA02G("OS")="PSM" U DV:(:::$S(BAUD=2400:43544,1:60952)) Q
 Q
 ; Cache - NT  $zu(102,"mode command")
 ;
SET S:'$D(DV) DV=16 G SETBAUD
 ;
TDATE S DT=$H D DATE,TIME S:DT["." DTM=$P(DT,".",1,2)_" "_TM S:DT["/" DTM=$P(DT,"/",1,2)_" "_TM Q
TIME S TM=$P($H,",",2),H=TM\3600,TM=TM#3600\60,TM=$E(H+100,2,3)_":"_$E("0"_TM,$L(TM),3) Q
 ;         
DATE S K=DT>21608+305+DT,YR=4*K+3\1461,D=K*4+3-(1461*YR)+4\4,MT=5*D-3\153,D=5*D-3-(153*MT)+5\5,MT=MT+2,YR=MT\12+YR+40,MT=MT#12+1,K="/",DT=MT
 S:$S($D(^ZAA02G("DATEF")):^("DATEF"),1:0) K=DT,DT=D,D=K,K="." S DT=YR*100+DT*100+D,DT=$E(DT,4,5)_K_$E(DT,6,7)_K_$E(DT,2,3),YR=YR-100 K K,D Q
 ;
DEDATE S H=$P($H,",",2)\90+($H*1000) S X=H\1000 D CAL Q
 ;
CAL S m=X,o=$S(m<21609:14915,1:-21609),m=m+o,y=4*m+3\1461,d=m*4+7-(1461*y)\4,m=5*d-3\153,d=5*d+2-(153*m)\5,m=m+3 S:m>12 m=m-12,y=y+1 S y=$S(o=14915:y+1800,1:y+1900)
 S:ZAA02G("d") D=$E(0,d<10)_d_"."_$E(0,m<10)_m S:ZAA02G("d")=0 D=$E(0,m<10)_m_"/"_$E(0,d<10)_d S D=D_$S(ZAA02G("d"):".",1:"/")_$S('$D(ln):$E(y,3,4),ln<10:$E(y,3,4),1:y) Q
 ;
DELAY S Y=$S('$D(ZAA02G(9)):"ECONOMY\DELAYED DIALING\Wait Until\Delay Until\Date\Time\use cursor keys to change\and Press RETURN to send",1:@ZAA02G(9)@(24))
 S %R=BL-8,Y="40\DLCW\1\ "_$S(X(9)="":$P(Y,"\"),1:$P(Y,"\",2))_" *\\*,    "_$S(X(9)="":$P(Y,"\",3),1:$P(Y,"\",4))_"-   *,*,   "_$P(Y,"\",5)_":*,   "_$P(Y,"\",6)_":*,*,"_$P(Y,"\",7)_"*" X "N X D ^ZAA02GFAXU2"
 D TIME S STM="",(MIND,DT)=+$H,TM=$TR(TM,":","")\10*10+550010 S:$E(TM,5)=6 TM=TM+40 S TMN=TM
 S ZF=33 F JJ=1:1:3 D:JJ=1 DTN D:JJ=2 TMN S JJ=$S(ZF=33:0,ZF=57:3,ZF=34&(JJ=1):JJ,ZF=13:JJ,1:JJ-1)
 K JJ,MIN,MIND,PAT,RND,TMN Q:ZF=57  S STM=$E(TM,3,4)*60+$E(TM,5,6)*60\90+(DT*1000) Q
DTN S %R=BL-4,%C=54,X=DT,MIN=MIND,IN=1,RND="D CAL",PAT="D" D CAL,DTM S DT=X Q
TMN S %R=BL-3,%C=54,X=TM,PAT="$E(X,3,4),"":"",$E(X,5,6)",IN=10,MIN=$S(DT>$H:0,1:TMN),RND="S:69[$E(X,5) X=X+$S($E(X,5)=9:-40,1:40) S:$E(X,3,6)=2400 X=550000 S:$E(X,3,6)=9950 X=552350" X RND D DTM S TM=X Q
DTM X ^ZAA02G("ECHO-OFF") W ZAA02G("HI") F J=1:1 W @ZAA02GP,@PAT R A#1 I A="" X ZAA02G("T") S ZF=$A(^ZAA02G(.3,ZAA02G,0),$F(^(0),ZF)) S X=X+$S(ZF=35:IN,X'>MIN:0,ZF=36:-IN,1:0) X RND Q:"13,33,34"[ZF  I ZF=57 S X="" Q
 X ^ZAA02G("ECHO-ON") Q
 ;
STATUS S YY=$S('$D(ZAA02G(9)):"FAX/MODEM STATUS\FAX/MODEM\PORT\JOBS QUEUED\Press RETURN\Active\Inactive\Available\Unavailable\Operations Suspended",1:@ZAA02G(9)@(4))
 S %R=BL-11,Y="10\DRLCY\1\"_$P(YY,"\")_"\\",Y(1)="*",Y(4)="*"_$P(YY,"\",2)_$J("",20-$L($P(YY,"\",2)))_"ZAA02G-FAX"_$J("",8)_$P(YY,"\",3)_$J("",10-$P(YY,"\",3)),Y(5)="*",X=^ZAA02GFAXC("FAX")
 S L=0,A=1 F K=0:1 S A=$O(^ZAA02GFAXQ(.9,A)) Q:A=""  S L=L+1
 S Y(3)="*",Y(2)="           *"_$P(YY,"\",4)_": "_L
 S M=6 F J=1:6:56 S F=$P(X,"\",J) I F'="" D ST1 S M=M+1
 S Y(M)="*" I $D(^ZAA02GFAXC("SUSPEND")) S M=M+1,Y(M)=$P(YY,"\",10)_"*"
 S Y(M+1)=$J($P(YY,"\",5),25),Y(0)="\EX" D ^ZAA02GFAXU2 K Y Q
ST1 S Y(M)="*"_F_$J("",19-$L(F)),NS=$S($ZV["M3":$ZN,1:$ZU(5))
 L ZAA02GFAX(NS,0):0 L  S Y(M)=Y(M)_$J($P(YY,"\",6+$T),7) O F::0 C:$T F S Y(M)=Y(M)_$J($P(YY,"\",9-$T),15)
 Q
 ;
RESTART L ZAA02GFAX(FAX):0 I  J ^ZAA02GFAXC L
 Q
PASSWD S %R=3,%C=1 W @ZAA02GP,ZAA02G("CS") S %R=10,%C=30 W ZAA02G("LO"),@ZAA02GP,"Password: ",ZAA02G("HI") S %C=40,LNG=12,UC=1,X=$S($D(^ZAA02GFAXC("PASS")):^("PASS"),1:"") W X X ^ZAA02GREAD
 S:X'="" ^ZAA02GFAXC("PASS")=X K:X="" ^ZAA02GFAXC("PASS") Q
 S %C=50 W @ZAA02GP,"INVALID PASSWORD" H 2 W @ZAA02GP,ZAA02G("CL") Q
 ;
SETUP ;
 D:$D(^ZAA02G(.1,ZAA02G,1))=0 UND^ZAA02GDEV4 Q:$D(^ZAA02G(.1,ZAA02G,1))=0  S XX=$C(13)_"F"_$C(9)_"9"_$C(127)_"R"_$C(126)_"2" F I=1:1:6 S XX=XX_ZAA02G($P("UK,DK,RK,LK,INK,DLK",",",I))_$E("ABCDGH",I)
 S B=^ZAA02G(.1,ZAA02G,2),(X1,X2)="" F I=1:1:22,25,26 S D=$P(B,"`",I) S:D'="" C="C=$C("_D_")",@C,C=C_$P("O;P;Q;U;N;I;J;5;3;Y;1;T;X;V;Z;6;K;4;E;W;7;M;;;L;8",";",I) S:D["," X2=X2_C S:D'["," X1=X1_C S:I=15 B=^(3)
 S XX=XX_X1_$C(8)_"R"_X2_$C(26,48,23,48,2,48,24)_"E"_$C(11)_"N",^ZAA02GFAXC(95,ZAA02G,4)=XX,^ZAA02GFAXC(95,ZAA02G,5)=^ZAA02G(.1,ZAA02G,5),^ZAA02GFAXC(95,ZAA02G,6)=^ZAA02G(.1,ZAA02G,6),^ZAA02GFAXC(95,ZAA02G,1)=^ZAA02G(.1,ZAA02G,1) X ^(1)
 Q
S2 S (XS,ZAA02G("uo"),ZAA02G("uf"),ZAA02G("ron"),ZAA02G("rof"),ZAA02G("gon"),ZAA02G("gof"),ZAA02G("fon"),ZAA02G("fof"))=$C(27),XSL=1 Q
S3 S XS=$C(27),(ZAA02G("fon"),ZAA02G("fof"))=$C(27,126),XSL=5,ZAA02G("gon")=$C(27,62,127,127,14),ZAA02G("gof")=$C(27,62,127,127,15),ZAA02G("ron")=$C(27,91,48,55,109),ZAA02G("rof")=$C(27,91,50,55,109),ZAA02G("uo")=$C(27,91,48,52,109),ZAA02G("uf")=$C(27,91,50,52,109)
 S FR="VT220",TO="P" D CHARSET^ZAA02GINIT2 Q
 ;
SCAN ; SCAN QUEUE AND INTERROGATE STATUS
 R "Filter (blank=no filter)-",F,! S JOBB="" F  S JOBB=$O(^ZAA02GFAXQ("DIR",JOBB)) Q:JOBB=""  D:F="" SCAN1 D:F'="" SCAN1:^(JOBB)[F
 Q
SCAN1 S B=^(JOBB),JOB=10000-JOBB W JOB,?7 F J=2,3,4,6,7 W $P(B,"\",J),"  "
 W ! I $D(^ZAA02GFAXI(JOB)) W "Compile image",!
 I $D(^ZAA02GFAXQ("SRC",JOB)) W "Source image",!
 R "Resend, Cancel, or Skip",C#1,! I C]"","Rr"[C G SCAN1R
 I C]"","Cc"[C G SCAN1C
 W ! Q
SCAN1R S:$P(B,"\",10)=7 $P(B,"\",33)=$P(B,"\",33)+1 S $P(B,"\",10)=$S($D(^ZAA02GFAXI(JOBB))#2:2,1:1),$P(B,"\",3)="READY",$P(B,"\",14)=1,FAX=$P(B,"\",23),$P(B,"\",30)="",QC=1 D S1^ZAA02GFAXQ W " Done",!! Q
SCAN1C I '$D(^ZAA02GFAXQ(.9,JOB)) W "not queued",!! Q
 S $P(B,"\",10)=9,$P(B,"\",3)="CANCEL" S:$P(B,"\",33) $P(B,"\",10)=7,$P(B,"\",3)="Sent-"_$P(B,"\",33) S ^ZAA02GFAXQ("DIR",10000-JOB)=B K ^ZAA02GFAXQ(.9,JOB) W "  CANCELED",!! Q
