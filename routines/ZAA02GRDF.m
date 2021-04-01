ZAA02GRDF ;PG&A,TOOLKIT I,1.45,READ UTILITY - FIELD;2014-07-10 17:23:46
 ;;Copyright (C) Patterson, Gray and Associates, Inc.
INIT D:$D(ZAA02G)+$D(ZAA02GX)+$D(ZAA02GY)'=13 FUNC^ZAA02GDEV X ^ZAA02G("TERM-ON"),^ZAA02G("WRAP-OFF"),^ZAA02G("ECHO-OFF") D READ X ^ZAA02G("ECHO-ON"),^ZAA02G("TERM-OFF"),^ZAA02G("WRAP-ON") Q
DSP(aon,X,aof) S %C=tC I fP="" W @ZAA02GP,aon,X Q
 S on=0,%C=tC W @ZAA02GP F i=1:1:fL S c=$E(X,i),p=$E(fP,i) W $S(on=0&(p=" "):aon,on=1&(p'=" "):aof,1:""),$S(p=" ":c,1:p) S on=p=" "
 W aon K c,i,p,on Q
STRIP(X) I $E(X,$L(X))=" " F i=0:0 S i=$F(X," ",i) Q:'i  I $E(X,i,255)?." " S X=$E(X,1,i-2) Q
 Q X
EXPAND(X) S eT=$E(X,2,$L(X)-1),eS=" !""#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~" F eI=128:8:255 S eS=eS_$C(eI,eI+1,eI+2,eI+3,eI+4,eI+5,eI+6,eI+7)
 S:eT="" X=eS I eT]"" S X="" S:$L(eT)#2 eT=eT_$C(255) F eI=1:2:$L(eT) S X=X_$E(eS,$A(eT,eI)-31,$A(eT,eI+1)-31)
 K eI,eS,eT Q X
READ N c,i,l,p,a0,a1,bC,eR,fC,fK,fL,fP,lC,lW,p0,p1,pR,sK,tC,tO,tX,uC,vC,vO,ZF
 S (a1,a0,eR,tO)="",fL=+Y,p1=$P(Y,"\",2),p0=$P(Y,"\",3),vC=$P(Y,"\",4),fK=$P(Y,"\",5),sK=$P(Y,"\",6),pR=$P(Y,"\",7),fP=$P(Y,"\",11),uC=p1["F",lW=p1["L",eR=p1["E"
 S fC=1 I fP]"" F fC=1:1 Q:$E(fP,fC)=" "
 S lC=fL I fP]"" F lC=fL:-1:1 Q:$E(fP,lC)=" "
 S a1=$S(p1["H":ZAA02G("HI"),1:ZAA02G("LO"))_$S(p1["R":ZAA02G("RON"),1:"")_$S(p1["U":ZAA02G("UO"),1:""),a0=$S(p1["H"&(p0'["H"):ZAA02G("HI"),1:"")_$S(p1["R"&(p0'["R"):ZAA02G("ROF"),1:"")_$S(p1["U"&(p0'["U"):ZAA02G("UF"),1:"")
 I vC["[" S vO=$P(vC,"[",1) S:vO'="" vC=$P(vC,vO,2) S:vC?1"["1.E1"]" vC=$$EXPAND(vC) S vC=vC_vO
 S:p1["T" tO=+$P(p1,"T",2) S X=X_$J("",fL-$L(X)),l=1 S:p1["E" l=$L($$STRIP(X))+1,l=1
 S:'l l=1 ;   I fP]"" F i=0:0 Q:$E(fP,l)'=" "!(l>fL)  S l=l+1
 I pR]"" W @ZAA02GP,$S(p1["P":ZAA02G("HI"),1:ZAA02G("LO")),pR S %C=%C+$L(pR)
 S tC=%C,bC=%C+l-1 D DSP(a1,$E(X,1,fL),a0) S %C=tC W @ZAA02GP
RD I 'tO R c#1
 E  R c#1:tO G:'$T TIM
 I c'="" S:uC&(c?1L) c=$C($A(c)-32) S:lW&(c?1U) c=$C($A(c)+32) G BRK:sK[c,ERR:l>fL,ERR:vC]""&(vC'[c) D:eR ERA W c S X=$E(X,1,l-1)_c_$E(X,l+1,255),l=l+1 G:fP="" RD D:$E(fP,l)'=" " POS G RD
FN X ZAA02G("T") S ZAA02GF=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2),eR=0 G @ZAA02GF:"RK,LK,IC,DC,RU,EF,CR"[ZAA02GF,CR:$F(fK,ZAA02GF),ERR
ERR W *7 G RD
POS I l<lC S l=l+1 Q:l>fL  G:$E(fP,l)'=" " POS N %C S %C=tC+l-1 W @ZAA02GP
 Q
ERA S X=$J("",fL),%C=tC,eR=0 D DSP(a1,X,a0) S %C=bC W @ZAA02GP Q
 I fP]"" D FPD(a1,X,a0) W @ZAA02GP Q
 W @ZAA02GP,$J("",fL),@ZAA02GP Q
RK I l>lC G CR:$F(fK,"RK"),RD
 S l=l+1 W ZAA02G("RT") G RD:fP=""!($E(fP,l)=" "),RK
LK I l'>fC G CR:$F(fK,"LK"),RD
 S l=l-1 W ZAA02G("L") G RD:fP=""!($E(fP,l)=" "),LK
IC I fP="" G ERR:$E(X,fL)'=" " S %C=tC+l-1 W " ",$E(X,l,fL-1),@ZAA02GP S X=$E(X,1,l-1)_" "_$E(X,l,fL-1)
 S %C=tC G RD
DC I fP="" S %C=tC+l-1 W $E(X,l+1,256)," ",@ZAA02GP S X=$E(X,1,l-1)_$E(X,l+1,256)_" "
 S %C=tC G RD
RU G:l'>fC RD
RU1 S l=l-1 W ZAA02G("L") I fP]"",$E(fP,l)'=" " G RU1
 W " ",ZAA02G("L") S X=$E(X,1,l-1)_" "_$E(X,l+1,256)
 G RD
EF S X=$E(X,0,l-1),tL=$L(X),X=X_$J("",fL-$L(X)) I fP="" S %C=tC+l-1 W @ZAA02GP,$J("",fL-tL),@ZAA02GP
 E  D DSP(a1,X,a0) S %C=tC+l-1 W @ZAA02GP
 S l=tL+1,%C=tC K tL G RD
BRK S ZAA02GF=c G CR
TIM S ZAA02GF=-1
CR S tX=X S:p0["S" X=$$STRIP(X)
PAT G:X="" DONE I $L($P(Y,"\",8)) X "I @$P(Y,""\"",8)" E  G INV
MAX I $L($P(Y,"\",9)),X>$P(Y,"\",9) G INV
MIN I $L($P(Y,"\",10)),X<$P(Y,"\",10) G INV
DONE D DSP(a0,$E(tX,1,fL),"") I fP]"" F i=1:1:$L(X) I $E(fP,i)'=" " S X=$E(X,0,i-1)_$E(fP,i)_$E(X,i+1,fL)
 K c,i,l,p,a0,a1,bC,eR,fC,fK,fL,fP,lC,lW,p0,p1,pR,sK,tC,tO,tX,uC,vC,vO,ZF Q
INV S X=tX,l=fC W *7,@ZAA02GP G RD
 ;
TEST W ZAA02G("F") S X="",%R=12,%C=12,Y="15\LU\S\\\\\X?5N" D ZAA02GRDF
