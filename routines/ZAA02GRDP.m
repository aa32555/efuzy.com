ZAA02GRDP 
INIT D:$D(ZAA02G)+$D(ZAA02GX)+$D(ZAA02GY)'=13 FUNC^ZAA02GDEV X ^ZAA02G("TERM-ON"),^ZAA02G("WRAP-OFF"),^ZAA02G("ECHO-OFF") D READ X ^ZAA02G("ECHO-ON"),^ZAA02G("TERM-OFF"),^ZAA02G("WRAP-ON") Q
STRIP(X) I $E(X,$L(X))=" " F i=0:0 S i=$F(X," ",i) Q:'i  I $E(X,i,255)?." " S X=$E(X,1,i-2) Q
	Q X
EXPAND(X) S eT=$E(X,2,$L(X)-1),eS=" !""#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~" F eI=128:8:255 S eS=eS_$C(eI,eI+1,eI+2,eI+3,eI+4,eI+5,eI+6,eI+7)
	S:eT="" X=eS I eT]"" S X="" S:$L(eT)#2 eT=eT_$C(255) F eI=1:2:$L(eT) S X=X_$E(eS,$A(eT,eI)-31,$A(eT,eI+1)-31)
	K eI,eS,eT Q X
READ ;N c,i,j,l,p,a0,a1,bC,cH,eR,fK,fL,p0,p1,pC,pR,pW,sK,tC,tO,tX,uC,vC,xP,ZF
	S (a1,a0,cH,eR,j,tO)="",fL=+Y,p1=$P(Y,"\",2),p0=$P(Y,"\",3),vC=$P(Y,"\",4),fK=$P(Y,"\",5),sK=$P(Y,"\",6),pR=$P(Y,"\",7),pW=$P(Y,"\",8),pC=$P(Y,"\",9),uC=p1["F",eR=p1["E"
	S a1=$S(p1["H":ZAA02G("HI"),1:ZAA02G("LO"))_$S(p1["R":ZAA02G("RON"),1:"")_$S(p1["U":ZAA02G("UO"),1:""),a0=$S(p1["H"&(p0'["H"):ZAA02G("HI"),1:"")_$S(p1["R"&(p0'["R"):ZAA02G("ROF"),1:"")_$S(p1["U"&(p0'["U"):ZAA02G("UF"),1:"")
	S:vC?1"["1.E1"]" vC=$$EXPAND(vC) S:p1["T" tO=+$P(p1,"T",2) S:p1["D" cH=$C(+$P(p1,"D",2)) S:cH="" cH="."
	S:p1["S" X=$$STRIP(X) S l=$L(X)+1,xP=$TR($J("",l-1)," ",cH),X=X_$J("",fL-$L(X)),xP=xP_$J("",fL-$L(xP)) S:p1'["E" l=1 S:'l l=1
	I pR]"" W @ZAA02GP,$S(p1["P":ZAA02G("HI"),1:ZAA02G("LO")),pR S %C=%C+$L(pR)
	S tC=%C,bC=%C+l-1 W @ZAA02GP,a1 W:a1'=a0 xP S %C=bC W @ZAA02GP
RD I 'tO R c#1
	E  R c#1:tO G:'$T TIM
	I c'="" S:uC&(c?1L) c=$C($A(c)-32) G BRK:sK[c,ERR:l>fL,ERR:vC]""&(vC'[c) D:eR ERA W cH S X=$E(X,1,l-1)_c_$E(X,l+1,255),l=l+1 G RD
FN X ZAA02G("T") S ZAA02GF=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2),eR=0 G @ZAA02GF:"RK,LK,IC,DC,RU,EF,CR"[ZAA02GF,CR:$F(fK,ZAA02GF),ERR
ERR W *7 G RD
ERA S (X,xP)=$J("",fL),eR=0,%C=tC W @ZAA02GP,$J("",fL),@ZAA02GP Q
RK I l>fL G CR:$F(fK,"RK"),RD
	S l=l+1 W ZAA02G("RT") G RD
LK I l'>1 G CR:$F(fK,"LK"),RD
	S l=l-1 W ZAA02G("L") G RD
RU G:l'>1 RD
RU1 S l=l-1 W ZAA02G("L")," ",ZAA02G("L") S X=$E(X,1,l-1)_" "_$E(X,l+1,256) G RD
EF S X=$E(X,0,l-1),tL=$L(X),xP=$E(xP,0,l-1),X=X_$J("",fL-$L(X)),xP=xP_$J("",fL-$L(xP)),%C=tC+l-1 W @ZAA02GP,$J("",fL-tL),@ZAA02GP
	S l=tL+1,%C=tC K tL G RD
BRK S ZAA02GF=c G CR
TIM S ZAA02GF=-1
CR S tX=X,j=j+1 S:p0["S" X=$$STRIP(X) I (pC'="")&(j>pC) S X="" G DONE
	G:(pW'="")&(X'=pW) INV
DONE S %C=tC W @ZAA02GP,a0,xP K c,i,j,l,p,a0,a1,bC,cH,eR,fK,fL,p0,p1,pC,pR,pW,sK,tC,tO,tX,uC,vC,xP,ZF Q
INV S X=tX,l=1 W *7,@ZAA02GP G RD
T1 K  S %R=24,%C=1,Y="5\PUFT30\HS\[AZ]\EX\?\Test Password: \\5",X="" D INIT W !! N ZAA02G,ZAA02GP,ZAA02GX,ZAA02GY W  Q
	;