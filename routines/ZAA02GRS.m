ZAA02GRS ;,,1.41;;;STRING INPUT;7JAN92 10:18A
 ;;Copyright (C) Patterson, Gray and Associates, Inc.
INIT D:$D(ZAA02G)+$D(ZAA02GX)+$D(ZAA02GY)'=13 FUNC^ZAA02GDEV X ^ZAA02G("TERM-ON"),^ZAA02G("WRAP-OFF"),^ZAA02G("ECHO-OFF") D READ X ^ZAA02G("ECHO-ON"),^ZAA02G("TERM-OFF"),^ZAA02G("WRAP-ON") Q
READ S ZAA02Gt=$P(Y,"\",3),ZAA02Gb=$P(Y,"\",4),ZAA02GL=$P(Y,"\",5),ZAA02Gv=$P(Y,"\",6),ZAA02Gu=$P(Y,"\",10),ZAA02Go=+$P(Y,"\",12),ZAA02Gh=$P(Y,"\")'=$P(Y,"\",2),ZAA02Gl=1
 S ZAA02Gs=X,X=X_$J("",ZAA02GL-$L(X)) D R24:$D(ZAA02GFK),EXP:ZAA02Gv?1"["1.E1"]" I $P(Y,"\",11)]"" W @ZAA02GP,$P(Y,"\",11) S %C=%C+$L($P(Y,"\",11))
 W @ZAA02GP,ZAA02G($P(Y,"\")) W:ZAA02Gh X,@ZAA02GP
RD X "I 1" F ZAA02Gi=1:1 R:'ZAA02Go ZAA02Gc#1 R:ZAA02Go ZAA02Gc#1:ZAA02Go G:'$T TIM Q:'$L(ZAA02Gc)  S:ZAA02Gu&(ZAA02Gc?1L) ZAA02Gc=$C($A(ZAA02Gc)-32) G BRK:ZAA02Gb[ZAA02Gc,ERR:ZAA02Gl>ZAA02GL,ERR:ZAA02Gv]""&(ZAA02Gv'[ZAA02Gc) W ZAA02Gc S X=$E(X,1,ZAA02Gl-1)_ZAA02Gc_$E(X,ZAA02Gl+1,255),ZAA02Gl=ZAA02Gl+1
 X ZAA02G("T") S ZAA02GF=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2) G @ZAA02GF:"RK,LK,IC,DC,RU,EF,CR"[ZAA02GF,CR:$F(ZAA02Gt,ZAA02GF),ERR
ERR W *7 G RD
RK I ZAA02Gl<ZAA02GL W ZAA02G("RT") S ZAA02Gl=ZAA02Gl+1 G RD
 G CR:$F(ZAA02Gt,"RK"),RD
LK I ZAA02Gl>1 W ZAA02G("L") S ZAA02Gl=ZAA02Gl-1 G RD
 G CR:$F(ZAA02Gt,"LK"),RD
IC G:$E(X,ZAA02GL)'=" " ERR W " ",$E(X,ZAA02Gl,ZAA02GL-1) S X=$E(X,1,ZAA02Gl-1)_" "_$E(X,ZAA02Gl,ZAA02GL-1) W @ZAA02GP,$E(X,1,ZAA02Gl-1) G RD
DC W $E(X,ZAA02Gl+1,256)," " S X=$E(X,1,ZAA02Gl-1)_$E(X,ZAA02Gl+1,256)_" " W @ZAA02GP,$E(X,1,ZAA02Gl-1) G RD
RU I ZAA02Gl>1 S X=$E(X,1,ZAA02Gl-2)_" "_$E(X,ZAA02Gl,256),ZAA02Gl=ZAA02Gl-1 W $C(8,32,8)
 G RD
EF S X=$E(X,0,ZAA02Gl-1),TLln=$L(X),X=X_$J("",ZAA02GL-$L(X)),ZAA02Gcx=%C,%C=%C+ZAA02Gl-1 W @ZAA02GP,$J("",ZAA02GL-TLln),@ZAA02GP S %C=ZAA02Gcx,ZAA02Gl=TLln+1 K ZAA02Gcx,TLln G RD
CR D STR
PAT G:X="" DONE I $L($P(Y,"\",7)) X "I "_$P(Y,"\",7) E  G INV
MAX I $L($P(Y,"\",8)),X>$P(Y,"\",8) G INV
MIN I $L($P(Y,"\",9)),X<$P(Y,"\",9) G INV
DONE W:ZAA02Gh @ZAA02GP,$S(ZAA02Gh:ZAA02G($P(Y,"\",2))_ZAA02Gx,1:ZAA02G($P(Y,"\",2))_X) K ZAA02Gb,ZAA02Gc,ZAA02Gh,ZAA02Gi,ZAA02Gl,ZAA02Gt,ZAA02Gu,ZAA02Gv,ZAA02Gx,ZAA02GL Q
INV S X=ZAA02Gx,ZAA02Gl=1 W *7,@ZAA02GP G RD
BRK S ZAA02GF=ZAA02Gc G CR
TIM D STR S ZAA02GF=-1 G DONE
STR S ZAA02Gx=X I $E(X,$L(X))=" " F ZAA02Gi=0:0 S ZAA02Gi=$F(X," ",ZAA02Gi) Q:'ZAA02Gi  I $E(X,ZAA02Gi,255)?." " S X=$E(X,1,ZAA02Gi-2) Q
 Q
R24 Q  N i,p,x,%R,%C,X,Y S Y=$P($T(FK),";;,2),X=""
 F i=1:1 S x=$P(ZAA02GFK,",",i) Q:x=""  S p=$F(ZAA02GY,x) I p S X=X_$P(Y,",",$L($E(ZAA02GY,1,p-1),"\"))_", "
 S %R=24,%C=1 W @ZAA02GP,ZAA02G("CL") S %C=80-$L(X)-10\2 W @ZAA02GP,LO,"Functions: ",HI,$E(X,1,$L(X)-2) K ZAA02GFK Q
 Q
FK ;;,,,,,,,,,,TAB,,,,ENTER,,,,,,,,,,,,,,ESC,,,,,RUB,UP,DOWN,RIGHT,LEFT,INS,DEL,PGDN,PGUP,BEG,SCROLL UP,SCROLL DN,INS LINE,DEL LINE,ERASE,TABSET,HELP,OTHER,COP/MOV,BLD/UND,FORMAT,END,FIND,REFORM,CUT,EXIT,LINEBEG,SELECT,HOME,,,LINEEND
EXP S eT=$E(ZAA02Gv,2,$L(ZAA02Gv)-1),eS=" !""#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~" F eI=128:8:255 S eS=eS_$C(eI,eI+1,eI+2,eI+3,eI+4,eI+5,eI+6,eI+7)
 S:eT="" ZAA02Gv=eS I eT]"" S ZAA02Gv="" S:$L(eT)#2 eT=eT_$C(255) F eI=1:2:$L(eT) S ZAA02Gv=ZAA02Gv_$E(eS,$A(eT,eI)-31,$A(eT,eI+1)-31)
 K eI,eS,eT Q
T S %R=24,%C=1,Y="RON\ROF\EX\\10\[AZ09]\\\\\Test field: \5",X=$P(Y,"\",12) W ZAA02G("LO") D INIT W "   {ZAA02GF=",ZAA02GF,"}"
