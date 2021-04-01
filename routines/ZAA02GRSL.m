ZAA02GRSL ;,,1.41;;;READ LONGSTRING UTILITY;19DEC91 9:43A
 ;;Copyright (C) Patterson, Gray and Associates, Inc.
INIT D:$D(ZAA02G)+$D(ZAA02GX)+$D(ZAA02GY)'=13 FUNC^ZAA02GDEV X ^ZAA02G("TERM-ON"),^ZAA02G("WRAP-OFF"),^ZAA02G("ECHO-OFF") D READ X ^ZAA02G("ECHO-ON"),^ZAA02G("TERM-OFF"),^ZAA02G("WRAP-ON") Q
READ N b,c,e,h,i,l,p,t,u,v,x,L,M,tR,tC S t=$P(Y,"\",3),b=$P(Y,"\",4),L=$P(Y,"\",5),M=$P(L,",",2),L=+L,v=$P(Y,"\",6),u=$P(Y,"\",10),X=X_$J("",L-$L(X)),h=$P(Y,"\")'=$P(Y,"\",2),(l,p)=1
 S ZAA02Gp=$P(ZAA02GP,"%")_"t"_$P(ZAA02GP,"%",2)_"t"_$P(ZAA02GP,"%",3),ZAA02Ge=$P(ZAA02GP,"%C")_(%C+L-1)_$P(ZAA02GP,"%C",2),tR=%R S:'M M=L S X=X_$J("",M-$L(X)+1) D:$D(ZAA02GFK) R24
 I $P(Y,"\",11)]"" W @ZAA02GP,$P(Y,"\",11) S %C=%C+$L($P(Y,"\",11)),ZAA02Ge=$P(ZAA02GP,"%C")_(%C+L-1)_$P(ZAA02GP,"%C",2)
 W @ZAA02GP,ZAA02G($P(Y,"\")) W:h $E(X,1,L),@ZAA02GP
RD R c#1 G:c="" FN S:u&(c?1L) c=$C($A(c)-32) G BRK:b[c,ERR:l>M,ERR:v]""&(v'[c) S X=$E(X,1,l-1)_c_$E(X,l+1,255),l=l+1 W:p=L @ZAA02GP,$E(X,l-L+1,l),*8 W:p'=L c S:p<L p=p+1 G RD
FN X ZAA02G("T") S ZAA02GF=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2) G @ZAA02GF:"RK,LK,IC,DC,RU,EF,CR"[ZAA02GF,CR:$F(t,ZAA02GF),ERR
ERR W *7 G RD
RK I l<(M+1) W:p<L ZAA02G("RT") W:p=L @ZAA02GP,$E(X,l-L+2,l+1),*8 S l=l+1 S:p<L p=p+1 G RD
 G CR:$F(t,"RK"),RD
LK I l>1 W:p>1 ZAA02G("L") W:p<2 @ZAA02GP,$E(X,l-1,l+L-2),@ZAA02GP S l=l-1 s:p>1 p=p-1 G RD
 G CR:$F(t,"LK"),RD
IC G:$E(X,M)'=" " ERR W " ",$E(X,l,l+L-p-1) S X=$E(X,1,l-1)_" "_$E(X,l,M-1),tC=%C+p-1 W @ZAA02Gp G RD
DC W $E(X,l+1,l+L-p+1) S X=$E(X,1,l-1)_$E(X,l+1,256)_" ",tC=%C+p-1 W @ZAA02Gp G RD
RU I l>1,p>1 S X=$E(X,1,l-2)_$E(X,l,256)_" ",l=l-1,tC=%C+p-1-(p>1) W:p=1 $E(X,l,L-1),@ZAA02GP W:p>1 *8,$E(X,l,l+L-p+1),@ZAA02Gp S:p>1 p=p-1 G RD
 W *7 G RD
EF S X=$E(X,0,l-1),X=X_$J("",M-$L(X)+1),tC=%C+p-1 W @ZAA02Gp,$J("",L-p+1),@ZAA02Gp G RD
CR S x=X I $E(X,$L(X))=" " F i=0:0 S i=$F(X," ",i) Q:'i  I $E(X,i,255)?." " S X=$E(X,1,i-2) Q
PAT G:X="" DONE I $L($P(Y,"\",7)) G:@$P(Y,"\",7) MAX G INV
MAX I $L($P(Y,"\",8)),X>$P(Y,"\",8) G INV
MIN I $L($P(Y,"\",9)),X<$P(Y,"\",9) G INV
DONE W @ZAA02GP,ZAA02G($P(Y,"\",2)),$E(x,1,L) K ZAA02Ge,ZAA02Gp Q
INV S X=x,l=1 W *7,@ZAA02GP G RD
BRK S ZAA02GF=c G CR
R24 N i,p,x,y,%R,%C S y=$P($T(FK),";;",2),x=""
 F i=1:1 S x=$P(ZAA02GFK,",",i) Q:x=""  S p=$F(ZAA02GY,x) I p S x=x_$P(y,",",$L($E(ZAA02GY,1,p-1),"\"))_", "
 S %R=24,%C=1 W @ZAA02GP,ZAA02G("CL") S %C=80-$L(x)-10\2 W @ZAA02GP,LO,"Functions: ",HI,$E(x,1,$L(x)-2) K ZAA02GFK Q
 Q
FK ;;A,,,,,,,,,,TAB,,,,ENTER,,,,,,,,,,,,,,ESC,,,,,RUB,UP,DOWN,RIGHT,LEFT,INS,DEL,PGDN,PGUP,BEG,SCROLL UP,SCROLL DN,INS LINE,DEL LINE,ERASE,TABSET,HELP,OTHER,COP/MOV,BLD/UND,FORMAT,END,FIND,REFORM,CUT,EXIT,LINEBEG,SELECT,HOME,,,LINEEND
T S %R=24,%C=1,Y="RON\ROF\EX\\5,10\\\\\1\Test Entry: ",X="ABCDEFGHIJ" D INIT Q
