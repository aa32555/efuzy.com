ZAA02GRSX 
INIT D:$D(ZAA02G)+$D(ZAA02GX)+$D(ZAA02GY)'=13 FUNC^ZAA02GDEV X ^ZAA02G("TERM-ON"),^ZAA02G("WRAP-OFF"),^ZAA02G("ECHO-OFF") D READ X ^ZAA02G("ECHO-ON"),^ZAA02G("TERM-OFF"),^ZAA02G("WRAP-ON") Q
READ S (a1,a0,tO)="",(l,p)=1,fL=+Y,dL=+$P($P(Y,"\"),",",2),p1=$P(Y,"\",2),p0=$P(Y,"\",3),vC=$P(Y,"\",4),fK=$P(Y,"\",5),sK=$P(Y,"\",6),pR=$P(Y,"\",7),uC=p1["F"
	S a1=$S(p1["H":ZAA02G("HI"),1:ZAA02G("LO"))_$S(p1["R":ZAA02G("RON"),1:"")_$S(p1["U":ZAA02G("UO"),1:""),a0=$S(p1["H"&(p0'["H"):ZAA02G("HI"),1:"")_$S(p1["R"&(p0'["R"):ZAA02G("ROF"),1:"")_$S(p1["U"&(p0'["U"):ZAA02G("UF"),1:"")
	S:dL<fL dL=fL S:vC?1"["1.E1"]" vC=$$EXPAND(vC) S:p1["T" tO=+$P(p1,"T",2) S:p1["S" X=$$STRIP(X) S X=X_$J("",dL-$L(X)+1)
	S pT=$P(ZAA02GP,"%C")_"tC"_$P(ZAA02GP,"%C",2),pE=$P(ZAA02GP,"%C")_(%C+fL-1)_$P(ZAA02GP,"%C",2) D:$D(ZAA02GFK) R24
	I pR]"" W @ZAA02GP,$S(p1["P":ZAA02G("HI"),1:ZAA02G("LO")),pR S %C=%C+$L(pR),pE=$P(ZAA02GP,"%C")_(%C+fL-1)_$P(ZAA02GP,"%C",2)
	W @ZAA02GP,a1 W:a1'=a0 $E(X,1,fL),@ZAA02GP
RD X "I 1" R:'tO c#1 R:tO c#1:tO G TIM:'$T,FN:c="" S:uC&(c?1L) c=$C($A(c)-32) G BRK:sK[c,ERR:l>dL,ERR:vC]""&(vC'[c) S X=$E(X,1,l-1)_c_$E(X,l+1,255),l=l+1 W:p=fL @ZAA02GP,$E(X,l-fL+1,l),*8 W:p'=fL c S:p<fL p=p+1 G RD
FN X ZAA02G("T") S ZAA02GF=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2) G @ZAA02GF:"RK,LK,IC,DC,RU,EF,CR"[ZAA02GF,CR:$F(fK,ZAA02GF),ERR
ERR W *7 G RD
RK I l<(dL+1) W:p<fL ZAA02G("RT") W:p=fL @ZAA02GP,$E(X,l-fL+2,l+1),*8 S l=l+1 S:p<fL p=p+1 G RD
	G CR:$F(fK,"RK"),RD
LK I l>1 W:p>1 ZAA02G("L") W:p<2 @ZAA02GP,$E(X,l-1,l+fL-2),@ZAA02GP S l=l-1 s:p>1 p=p-1 G RD
	G CR:$F(fK,"LK"),RD
IC G:$E(X,dL)'=" " ERR W " ",$E(X,l,l+fL-p-1) S X=$E(X,1,l-1)_" "_$E(X,l,dL-1),tC=%C+p-1 W @pT G RD
DC W $E(X,l+1,l+fL-p+1) S X=$E(X,1,l-1)_$E(X,l+1,256)_" ",tC=%C+p-1 W @pT G RD
RU I l>1,p>1 S X=$E(X,1,l-2)_$E(X,l,256)_" ",l=l-1,tC=%C+p-1-(p>1) W:p=1 $E(X,l,fL-1),@ZAA02GP W:p>1 *8,$E(X,l,l+fL-p+1),@pT S:p>1 p=p-1 G RD
	W *7 G RD
EF S X=$E(X,0,l-1),X=X_$J("",dL-$L(X)+1),tC=%C+p-1 W @pT,$J("",fL-p+1),@pT G RD
CR S tX=X S:p0["S" X=$$STRIP(X)
DONE W @ZAA02GP,a0,$E(tX,1,fL) K l,p,a0,a1,dL,fK,fL,p0,p1,pE,pR,pT,sK,tX,uC Q
INV S X=tX,l=1 W *7,@ZAA02GP G RD
BRK S ZAA02GF=c G CR
TIM S ZAA02GF=-1 G CR
R24 N i,p,x,y,%R,%C S y=$P($T(FK),";;",2),x=""
	F i=1:1 S x=$P(ZAA02GFK,",",i) Q:x=""  S p=$F(ZAA02GY,x) I p S x=x_$P(y,",",$L($E(ZAA02GY,1,p-1),"\"))_", "
	S %R=24,%C=1 W @ZAA02GP,ZAA02G("CL") S %C=80-$L(x)-10\2 W @ZAA02GP,LO,"Functions: ",HI,$E(x,1,$L(x)-2) K ZAA02GFK Q
	Q
FK ;;A,,,,,,,,,,TAB,,,,ENTER,,,,,,,,,,,,,,ESC,,,,,RUB,UP,DOWN,RIGHT,LEFT,INS,DEL,PGDN,PGUP,BEG,SCROLL UP,SCROLL DN,INS LINE,DEL LINE,ERASE,TABSET,HELP,OTHER,COP/MOV,BLD/UND,FORMAT,END,FIND,REFORM,CUT,EXIT,LINEBEG,SELECT,HOME,,,LINEEND
STRIP(X) I $E(X,$L(X))=" " F i=0:0 S i=$F(X," ",i) Q:'i  I $E(X,i,255)?." " S X=$E(X,1,i-2) Q
	Q X
EXPAND(X) S eT=$E(X,2,$L(X)-1),eS=" !""#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~" F eI=128:8:255 S eS=eS_$C(eI,eI+1,eI+2,eI+3,eI+4,eI+5,eI+6,eI+7)
	S:eT="" X=eS I eT]"" S X="" S:$L(eT)#2 eT=eT_$C(255) F eI=1:2:$L(eT) S X=X_$E(eS,$A(eT,eI)-31,$A(eT,eI+1)-31)
	K eI,eS,eT Q X
T S %R=24,%C=1,Y="10,20\HRST5\H\[azAZ09]\EX\?\Test Read: ",X="ABCDEFGHIJhijkl" D INIT Q
	;