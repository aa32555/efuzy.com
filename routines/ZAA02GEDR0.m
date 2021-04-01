%ZAA02GEDR0 ;;25NOV94  00:50;1.24;SUBR: COMPILE ROUTINES;Mon, 12 Apr 2010  09:41
 ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc.
 ;;All rights reserved.
ASK W pBL,tHI_rt_tLO_" has been changed.  Compile these changes first? "_tHI
 S %R=bl+2,%C=lm+48+$L(rt),Y="RON\ROF\EX\\3\NY\No;Yes",X=1 D ^ZAA02GEDYN I 'X!(ZAA02GF="EX") W pBL_tCL Q
ONE N s,pc,L,N,P,R,S,T,CP,GS,LI,OS,SF,GFR,CPY S R=rt,GFR=gl,IR=$S($D(@wgl@(0,R)):^(R),1:""),OS=ZAA02G("OS"),CPY=sgl_"(0,""FMT"",""COP"")",P=2,(PKG,PV,SF)="" I IR="" S s=$O(@gl@("")) S:s IR="``"_$P(@gl@(s),";",2,9)
 S i="",s=$P(gl,"(") f  s i=$o(@s@(i)) q:i=""  i i'=TID,$p(^(i),"`")=R K @s@(i)
 D FIRST S MSG=$P($T(MSG),";;",2) D @(OS_"INIT"),LINE G EXIT
MULT N i,s,pc,E,G,L,N,P,R,S,T,CP,GS,LI,OS,SF,ACT,CPY,GFI,GFR,SET,NL,ZAA02GF,MULT S OS=ZAA02G("OS"),MSG=$P($T(MSG),";;",2),MULT=1,SF=0
SEL S ACT="Compile Routines",SET="23" D ^ZAA02GEDRL G EXIT:'$D(GS),EXIT:'$D(@GS)
COMP N LI,CP S MSG=$P($T(MSG),";;",2) D @(OS_"INIT") S P=1,R="" F i=0:0 S R=$O(@GS@(R)) Q:R=""  S IR=^(R),V=$P(IR,"`",2) D FIRST,LINE
EXIT K CPY,HDR,INS,SAV,MSG,LOAD,TRIM,RTNH I $D(GS),GS]"" K @GS
 I $D(SF),SF S ZSR=SF
 Q
TAG Q:'$G(ZSR(1))  S X=ZSR(1)-NL,xs="",c=ZSR(2)+1
 F i=0:0 S xs=$O(@gl@(xs)) Q:'xs  I xs=(xs\1) S L=$P(^(xs),d,2) I $TR(L," ","")]"",$E(L)'=ci S X=X-1 Q:'X
 I xs S bs=xs,r=tl-1 F i=1:1:(bl-tl\2) S bs=+@gl@(bs),r=r+1 Q:'bs
 F i=0:1 Q:c<rm  S c=('i*ct)+c-rm+lm,r=r+1
 K i,xs Q
 Q
DTMINIT Q
CCSMINIT Q
M3INIT ;
MSMINIT ;
DSMINIT ;
DSM4INIT ;
M11INIT ;
PSMINIT S LOAD=$P($T(LOAD),";;",2),RTNH=$P($T(RTNH),";;",2),TRIM=$P($T(TRIM),";;",2),HDR=$P($T(HDR),";;",2),COP=$P($T(COP),";;",2),INS=$P($T(INS),";;",2),SAV=$P($T(SAV),";;",2)
 I OS="MSM",'$D(MULT) S SAV=$P($T(SAV1),";;",2),SAV2=$P($T(SAV2),";;",2)
 I OS="M11",'$D(MULT) S SAV=$P($T(SAV3),";;",2),SAV2=$P($T(SAV4),";;",2),SAV3=$P($T(SAV5),";;",2)
 Q
LINE S N=0,FL=1 X MSG,$P($T(LINEX),";",2,99)
 K J,K,L,N,S,T,X,FL,LI,OK,TL Q
LINEX ;ZR  F J=0:0 S S=$O(@GFR@(N\1+.9)),N=S\1,OK=1 X:S="" SAV Q:S=""  S X=$P(^(S),d,P) S:$E(X)=ci!($TR(X," ","")="") OK=0 I OK S:X'[" "&($O(^(S))\1=N) S=$O(^(S)),L=$P(^(S),d,P),(xX,X)=X_$E(L,$F(L,$E($TR(L," ","")))-1,511) X LOAD,TRIM X:FL RTNH X INS
LOAD ;;S NL=0,T=$P(X," "),TL=$L(T)+1,L=$P(X," ",2,511),L=$E(L,$F(L,$E($TR(L," ","")))-1,511) F J=0:0 S S=$O(^(S)) Q:S\1'=N  S L=L_$E($P(^(S),d,P),ct,ct+510-$L(L)-TL)
TRIM ;;S K=$L(L) I $E(L)'=";" F K=K:-1:0 Q:$E(L,K)'=" "
RTNH ;;I T]"" S $P(LI(1)," ;")=T X "F T=2:1:$L(L,"";"") S:$P(LI(1),"";"",T)="""" $P(LI(1),"";"",T)=$P(L,"";"",T)" S (L,T,FL,LI)="" X HDR,COP K LI,CPC
HDR ;;F J=0:0 S LI=$O(LI(LI)) Q:LI=""  ZI LI(LI) K LI(LI) S pc=pc-1,NL=NL+1 X:'pc MSG W "."
COP ;;F J=0:0 S LI=$O(CP(LI)) Q:LI=""  Q:$P(@GFR@(S),d,2)[CP(LI)  ZI CP(LI) K CP(LI) S NL=NL+1,pc=pc-1 X:'pc MSG W "."
INS ;;S L=$E(L,1,K) I T_L]"" ZI T_" "_L S pc=pc-1 X:'pc MSG W "."
SAV ;;ZS @R S:OS="PSM" ^UTILITY("R",R)="" S:$D(^ZAA02GEDLOG) ^ZAA02GEDLOG(+$H,R,$P($H,",",2))=""
SAV1 ;;ZS @R::1 S ZSR(1)=$ZA,J=$T(+$ZA),ZSR(2)=$ZB+9-$L($P(J," ")) X:$ZA SAV2 I ZSR(1)=0!(J="Y") S:$D(^ZAA02GEDLOG) ^ZAA02GEDLOG(+$H,R,$P($H,",",2))=""
SAV2 ;;S SF=$ZB W ZAA02G("F"),tHI,"Compiler error found",!!,"Line: +",ZSR(1),!!,tLO,$E(J,1,SF-1),tHI,$E(J,SF,511),!!,"NOTE: Other errors may exist",!!,"Do you want to compile this copy anyway (Y or N) " R J#1,! S SF=2 I J]"","yY"[J S J="Y" ZS @R W "...ZSaved"
SAV3 ;;ZS @R K SF X "F ll=0:1 S SF=$T(+ll) Q:'$L(SF)  S SF=$P(SF,"" "",2,99) X SAV3 I $L(SF) S SF=$ZU(62,1,SF) I $L(SF),SF'[""only in "" S SF(ll)=SF" X:$D(SF)>10 SAV2 S SF=2 S:$D(^ZAA02GEDLOG) ^ZAA02GEDLOG(+$H,R,$P($H,",",2))=""
SAV4 ;;W ZAA02G("F"),tHI,"Compiler error(s) found",!! S ll="" F  S ll=$O(SF(ll)) R:ll="" J#1 Q:ll=""  W "Line: +",ll,!,$T(+ll),!!,SF(ll),!!
SAV5 ;;F  Q:'$L(SF)  Q:" ."'[$E(SF)  S SF=$E(SF,2,999)
CCSM S %ZRD=$ZRD,%ZGD=$ZGD,%N="^"_R,(N,FL)="" D FETCH S $ZGD=%ZRD K @%N S @%N@($C(1),0)=$C(9)_T
CCSM2 S LT=T,@%N@(LT,0)=L,%J=1,pc=1
 F %J=%J:1 S $ZGD=%ZGD D FETCH G:S="" CCSME Q:T]""  S $ZGD=%ZRD,@%N@(LT,%J)=T_" "_L,pc=pc-1 X:'pc MSG W "."
 S $ZGD=%ZRD,@%N@(LT,%J)=$C(9)_T,pc=pc-1 X:'pc MSG W "." G CCSM2
CCSME S $ZGD=%ZRD,@%N@(LT,%J)=$C(9),$ZGD=%ZGD K %N,%L,%J,%I,%D,%T,%G,%ZRD,%ZGD Q
DTM K O S (O,N,FL)="",M=$D(MULT) W:'M ZAA02G("F") X:M MSG
 F I=0:0 D FETCH S:$L(T_L)>0 O=O_T_$C(9)_L_$C(10),T="" Q:S=""  I M S pc=pc-1 X:'pc MSG W "."
 X "ZS "_R_":O"_$S(M:"",1:":1") I $D(MULT)=0 S SF=1 W !!,"Press any key to continue..." R *X W ZAA02G("F")
 K O,N,CH Q
FETCH I FL,$O(LI("")) S LI=$O(LI("")),T=$P(LI(LI)," "),L=$P(LI(LI)," ",2,511) K LI(LI) Q
 I FL,$O(CP("")) S CP=$O(CP("")),T=$P(CP(CP)," "),L=$P(CP(CP)," ",2,511) K CP(CP) Q
F1 D GET Q:S=""  I 'FL,T]"" S $P(LI(1)," ;")=T,FL=1 S:$P(LI(1)," ;",2,9)="" $P(LI(1)," ;",2,9)=$P(L,";",2,10) G FETCH
 S L=$E(L,$F(L,$E($TR(L," ","")))-1,$L(L)),CH=$E(L),K=$L(L) I CH'=";" F K=$L(L):-1:0 Q:$E(L,K)'=" "
 S L=$E(L,0,K) G:$L(T_L)=0 F1 Q
GET S (T,L)="",S=$O(@GFR@(N+.9)),N=S\1 Q:S=""  G G2
G1 S S=$O(@GFR@(S)) Q:S=""!(S\1'=N)
G2 S X=$P(^(S),d,P) I S#1=0 G GET:X=""!($E(X)=ci) S T=$P(X," "),L=$P(X," ",2,511) G G1
 S L=L_$E(X,ct,511) G G1
MSG ;;W pBL_tLO_"Compiling "_tHI_R_tLO_" to "_tHI_"MUMPS "_tLO_tCL S pc=rm-$L(R)-21 Q
FIRST N G,P,M,X,TID K LI S (FL,LI)=0,LI(1)=" ;"
 F K="DES","MOD","FIL","TID","PKG","PV" I $D(@sgl@(0,"FMT",K)),^(K) S M=+^(K),P=$P(^(K),"`",2) S:'$D(LI(M)) LI(M)=" ;" D @K S:X]"" $P(LI(M),";",P)=X S:M>LI LI=M
 I $D(CPY),$D(@CPY)#2 F K=1:1:+@CPY S CP(K)=@CPY@(K)
 Q
DATE I X="" D DATE^ZAA02GEDS0 S X=DT
 S X=$P(X,"\",2),X=$P(X,"/",2)_$P("JAN/FEB/MAR/APR/MAY/JUN/JUL/AUG/SEP/OCT/NOV/DEC","/",+X)_$P(X,"/",3) Q
DES S X=$P(IR,"`",3) Q
MOD S X=$P(IR,"`",6) D DATE Q
FIL S X=$P(IR,"`",7) D DATE Q
TID S X=$P(IR,"`",8) Q
PKG S X=$S($D(PKG):PKG,1:"") Q
PV S X=$S($D(PX):PX,$D(PV):PV,1:"") Q
