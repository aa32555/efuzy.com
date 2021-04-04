ZAA02GRDL  
INIT D:$D(ZAA02G)+$D(ZAA02GX)+$D(ZAA02GY)'=13 FUNC^ZAA02GDEV X ^ZAA02G("TERM-ON"),^ZAA02G("WRAP-OFF"),^ZAA02G("ECHO-OFF") D READ X ^ZAA02G("ECHO-ON"),^ZAA02G("TERM-OFF"),^ZAA02G("WRAP-ON") Q
EXPAND(X) S eT=$E(X,2,$L(X)-1),eS=" !""#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~" F eI=128:8:255 S eS=eS_$C(eI,eI+1,eI+2,eI+3,eI+4,eI+5,eI+6,eI+7)
	S:eT="" X=eS I eT]"" S X="" S:$L(eT)#2 eT=eT_$C(255) F eI=1:2:$L(eT) S X=X_$E(eS,$A(eT,eI)-31,$A(eT,eI+1)-31)
	K eI,eS,eT Q X
READ N c,i,l,p,a0,a1,bC,dL,eR,fK,fL,lW,p0,p1,pR,pT,sK,tC,tO,tX,uC,vC,vO,ZF
	S (a1,a0,eR)="",fL=+Y,dL=+$P($P(Y,"\"),",",2),p1=$P(Y,"\",2),p0=$P(Y,"\",3),vC=$P(Y,"\",4),fK=$P(Y,"\",5),sK=$P(Y,"\",6),pR=$P(Y,"\",7),uC=p1["F",lW=p1["L",eR=p1["E",tO=999999
	S a1=$S(p1["H":ZAA02G("HI"),1:ZAA02G("LO"))_$S(p1["R":ZAA02G("RON"),1:"")_$S(p1["U":ZAA02G("UO"),1:""),a0=$S(p1["H"&(p0'["H"):ZAA02G("LO"),1:"")_$S(p1["R"&(p0'["R"):ZAA02G("ROF"),1:"")_$S(p1["U"&(p0'["U"):ZAA02G("UF"),1:"")
	I vC["[" S vO=$P(vC,"[",1) S:vO'="" vC=$P(vC,vO,2) S:vC?1"["1.E1"]" vC=$$EXPAND(vC) S vC=vC_vO
	S:dL<fL dL=fL S:p1["T" tO=+$P(p1,"T",2) S X=X_$J("",dL-$L(X))
	S (l,p)=1,pT=$P(ZAA02GP,"%C")_"tC"_$P(ZAA02GP,"%C",2)
	I pR]"" W @ZAA02GP,$S(p1["P":ZAA02G("HI"),1:ZAA02G("LO")),pR S %C=%C+$L(pR)
	S bC=%C W @ZAA02GP,a1 S tX=$S(l<fL:$E(X,1,fL),1:$E(X,l-fL+1,l)),%C=%C+p-1 W tX,@ZAA02GP K tX S %C=bC
RD R c#1:tO G TIM:'$T,FN:c=""
	I c'="" S:uC&(c?1L) c=$C($A(c)-32) S:lW&(c?1U) c=$C($A(c)+32) G BRK:sK[c,ERR:l>dL,ERR:vC]""&(vC'[c) D:eR ERA S X=$E(X,1,l-1)_c_$E(X,l+1,255),l=l+1 W:p=fL @ZAA02GP,$E(X,l-p+1,l),ZAA02G("L") I p'=fL W c S p=p+1
	G RD
FN X ZAA02G("T") S ZAA02GF=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2) G @ZAA02GF:"RK,LK,IC,DC,RU,EF,CR"[ZAA02GF,CR:$F(fK,ZAA02GF),ERR
ERR W *7 G RD
ERA S X=$J("",fL),%C=bC,eR=0 W @ZAA02GP,X S %C=bC W @ZAA02GP Q
RK I l<dL W:p<fL ZAA02G("RT") W:p=fL @ZAA02GP,$E(X,l-fL+2,l+1),ZAA02G("L") S l=l+1 S:p<fL p=p+1 G RD
	G CR:$F(fK,"RK"),RD
LK I l>1 W:p>1 ZAA02G("L") W:p<2 @ZAA02GP,$E(X,l-1,l+fL-2),@ZAA02GP S l=l-1 s:p>1 p=p-1 G RD
	G CR:$F(fK,"LK"),RD
IC G:$E(X,dL)'=" " ERR W " ",$E(X,l,l+fL-p-1) S X=$E(X,1,l-1)_" "_$E(X,l,dL-1),tC=%C+p-1 W @pT G RD
DC W $E(X,l+1,l+fL-p+1)," " S X=$E(X,1,l-1)_$E(X,l+1,256)_" ",tC=%C+p-1 W @pT G RD
RU I l>1 S X=$E(X,1,l-2)_$E(X,l,256)_" ",l=l-1 S:p<fL p=fL S:p>l p=l S tC=%C+p-1 W @ZAA02GP,$E(X,l-p+1,l),@pT G RD
	; W:p=1 $E(X,l,fL-1),@ZAA02GP W:p>1 ZAA02G("L"),$E(X,l,l+fL-p+1),@pT S:p>1 p=p-1 G RD
	W *7 G RD
EF S X=$E(X,0,l-1),X=X_$J("",dL-$L(X)+1),tC=%C+p-1 W @pT,$J("",fL-p+1),@pT G RD
BRK S ZAA02GF=c G CR
TIM S ZAA02GF=-1
CR S tX=X S:p0["S" c=$TR(X," ",""),c=$E(c,$L(c)),X=$E(X,1,$L($P(X,c,1,$L(X,c)-1)_c))
PAT G:X="" DONE I $L($P(Y,"\",8)) X "I @$P(Y,""\"",8)" E  G INV
MAX I $L($P(Y,"\",9)),X>$P(Y,"\",9) G INV
MIN I $L($P(Y,"\",10)),X<$P(Y,"\",10) G INV
DONE W @ZAA02GP,a0,$E(tX,1,fL) K c,i,l,p,a0,a1,bC,dL,fK,fL,lW,p0,p1,pR,pT,sK,tO,tX,uC,vC,vO,ZF Q
INV S X=tX,l=1 W *7,@ZAA02GP G RD
	;
TEST W ZAA02G("F"),"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" S X="",%R=1,%C=12,Y="15,55\LU\S\\" D ZAA02GRDL W !,X
	;