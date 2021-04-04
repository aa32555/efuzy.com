ZAA02GRDD  
INIT D:$D(ZAA02G)+$D(ZAA02GX)+$D(ZAA02GY)'=13 FUNC^ZAA02GDEV X ^ZAA02G("TERM-ON"),^("WRAP-OFF"),^("ECHO-OFF") D READ X ^ZAA02G("ECHO-ON"),^("TERM-OFF"),^("WRAP-ON") Q
DSP(aon,X,aof) S on=0,%C=tC W @ZAA02GP F i=1:1:fL S c=$E(X,i),p=$E(fP,i) W $S(on=0&(p=" "):aon,on=1&(p'=" "):aof,1:""),$S(p=" ":c,1:p) S on=p=" "
	K c,i,p,on Q
ANS S mD=+X-3,dD=$P(X,"/",2),yD=$P(X,"/",3),X="" Q:(mD+dD+yD)<-2  I $E(yD,1)=" " S X=$H D CAL S yD=$P(X,"/",3)
	S yD=yD+$S(yD<30:2000,yD<100:1900,1:0),oD=$S(yD<1900:-14916,1:21608),yD=yD>1999*100+$E(yD,3,4) S:mD<0 mD=mD+12,yD=yD-1 S jD=1461*yD\4,jD=153*mD+2\5+jD+dD+oD Q
	;
CAL I 'jD S X=$E("  /  /    ",1,fL) Q
	S jD=jD>21608+305+jD,yD=4*jD+3\1461,dD=jD*4+3-(1461*yD)+4\4,mD=5*dD-3\153,dD=5*dD-3-(153*mD)+5\5,mD=mD+2,yD=mD\12+yD+1840,mD=mD#12+1
	S X=$E(0,mD<10)_mD_"/"_$E(0,dD<10)_dD_"/"_$S(fL=8:$E(yD,3,4),1:yD) Q
READ N c,l,p,a0,a1,dD,eX,fC,fK,fL,fP,jD,lC,mD,oD,p0,p1,pR,sK,tC,tO,tX,uC,yD,ZF
	S (a1,a0,tO)="",(l,p)=1,fL=+Y,p1=$P(Y,"\",2),p0=$P(Y,"\",3),fK=$P(Y,"\",5),sK=$P(Y,"\",6),pR=$P(Y,"\",7),fP=$E("  /  /    ",1,fL)
	F fC=1:1 Q:$E(fP,fC)=" "
	F lC=fL:-1:1 Q:$E(fP,lC)=" "
	S a1=$S(p1["H":ZAA02G("HI"),1:ZAA02G("LO"))_$S(p1["R":ZAA02G("RON"),1:"")_$S(p1["U":ZAA02G("UO"),1:""),a0=$S(p1["H"&(p0'["H"):ZAA02G("HI"),1:"")_$S(p1["R"&(p0'["R"):ZAA02G("ROF"),1:"")_$S(p1["U"&(p0'["U"):ZAA02G("UF"),1:"")
	S:p1["T" tO=+$P(p1,"T",2) S jD=+X D:'X!(X?5N.E) CAL
	I pR]"" W @ZAA02GP,$S(p1["P":ZAA02G("HI"),1:ZAA02G("LO")),pR S %C=%C+$L(pR)
	S tC=%C W @ZAA02GP D DSP(a1,X,a0) W @ZAA02GP
RD I 'tO R c#1
	E  R c#1:tO G:'$T TIM
	I c'="" G BRK:sK[c,ERR:l>fL,T:"tT"[c,ERR:c'?1N W c S X=$E(X,1,l-1)_c_$E(X,l+1,255),l=l+1 D:$E(fP,l)'=" " POS G RD
FN X ZAA02G("T") S ZAA02GF=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2) G @ZAA02GF:"RK,LK,RU,EF,CR"[ZAA02GF,CR:$F(fK,ZAA02GF),ERR
ERR W *7 G RD
POS I l<lC S l=l+1 Q:l>fL  G:$E(fP,l)'=" " POS N %C S %C=tC+l-1 W @ZAA02GP
	Q
T S ZAA02GF="" D TDATE,DSP(a1,X,a0) S l=fC,%C=tC+l-1 W @ZAA02GP G CR:ZAA02GF?1E,RD:"RK,LK,RU,CR"[ZAA02GF,CR:$F(fK,ZAA02GF),E
RK I l>lC G CR:$F(fK,"RK"),RD
	S l=l+1 W ZAA02G("RT") G RD:fP=""!($E(fP,l)=" "),RK
	;
LK I l'>fC G CR:$F(fK,"LK"),RD
	S l=l-1 W ZAA02G("L") G RD:fP=""!($E(fP,l)=" "),LK
RU G:l'>fC RD
RU1 S l=l-1 W ZAA02G("L") I $E(fP,l)'=" " G RU1
	W " ",ZAA02G("L") S X=$E(X,1,l-1)_" "_$E(X,l+1,256)
	G RD
EF S X=$E(X,0,l-1),tL=$L(X),X=X_$J("",fL-$L(X)) D DSP(a1,X,a0) S %C=tC+l-1 W @ZAA02GP
	I fP="" S %C=tC+l-1 W @ZAA02GP,$J("",fL-tL),@ZAA02GP
	S l=tL+1,%C=tC K tL G RD
BRK S ZAA02GF=c
CR S tX=X D ANS I 'jD S X="" D DSP(a0,$J("",10),"") G DONE
MAX I $L($P(Y,"\",9)),jD>$P(Y,"\",9) G INV
MIN I $L($P(Y,"\",10)),jD<$P(Y,"\",10) G INV
BLD S X=jD,xX=jD D CAL I X'=tX S X=tX G ERR
	D DSP(a0,X,"")
DONE S:xX X=xX_"\"_X K c,l,p,a0,a1,dD,eX,fC,fK,fL,fP,jD,lC,mD,oD,p0,p1,pR,sK,tC,tO,tX,uC,xX,yD,ZF Q
INV S X=tX,l=fC W *7,@ZAA02GP G RD
TIM S ZAA02GF=-1,tX=X D ANS G BLD
TDATE S X="T"_$J("",fL-1),l=2 W @ZAA02GP,X,@ZAA02GP,ZAA02G("RT")
TR F i=1:1 R c#1 Q:'$L(c)  G TBR:sK[c,TER:l>fL!(l=2&("+-"'[c))!(l>2&("0123456789"'[c)) W c S X=$E(X,1,l-1)_c_$E(X,l+1,255),l=l+1
	X ZAA02G("T") S ZAA02GF=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2) G @("T"_ZAA02GF):"RK,LK,IC,DC,RU,EF,CR"[ZAA02GF,TCR:$F(fK,ZAA02GF)
TER W *7 G TR
TRK I l<fL W ZAA02G("RT") S l=l+1 G TR
	G TCR:$F(fK,"RK"),TR
TLK I l>1 W ZAA02G("L") S l=l-1 G TR
	G TCR:$F(fK,"LK"),TR
TIC G:$E(X,fL)'=" " TER W " ",$E(X,l,fL-1) S X=$E(X,1,l-1)_" "_$E(X,l,fL-1) W @ZAA02GP,$E(X,1,l-1) G TR
TDC W $E(X,l+1,256)," " S X=$E(X,1,l-1)_$E(X,l+1,256)_" " W @ZAA02GP,$E(X,1,l-1) G TR
TRU I l>1 S X=$E(X,1,l-2)_" "_$E(X,l,256),l=l-1 W ZAA02G("L")," ",ZAA02G("L")
	G TCR:l<2,TR
TEF S X=$E(X,0,l-1),ln=$L(X),X=X_$J("",fL-$L(X)),C=%C,%C=%C+l-1 W @ZAA02GP,$J("",fL-l+1),@ZAA02GP S %C=C,l=ln G TCR:l<2,TR
TBR S ZAA02GF=c
TCR S X=$TR(X," ","") I $L(X) S tX=$TR(X,"T0123456789",""),jD=+$H S:tX]"" @("jD="_jD_tX_(+$P(X,tX,2)))
	D CAL Q
	;
TEST K  S %R=24,%C=1,Y="10\PT30\HS\\EX\?\Test : ",X="39812" D INIT W !! N ZAA02G,ZAA02GP,ZAA02GX,ZAA02GY W X,!! Q
	;