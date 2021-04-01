ZAA02GRDT ;PG&A,TOOLKIT I,1.45,READ UTILITY - TIME;2SEP92 10:12A
 ;;Copyright (C) Patterson, Gray and Associates, Inc.
INIT D:$D(ZAA02G)+$D(ZAA02GX)+$D(ZAA02GY)'=13 FUNC^ZAA02GDEV X ^ZAA02G("TERM-ON"),^("WRAP-OFF"),^("ECHO-OFF") D READ X ^ZAA02G("ECHO-ON"),^("TERM-OFF"),^("WRAP-ON") Q
DSP(aon,X,aof) S on=0,%C=tC W @ZAA02GP F i=1:1:fL S c=$E(X,i),p=$E(fP,i) W $S(on=0&(p=" "):aon,on=1&(p'=" "):aof,1:""),$S(p=" ":c,1:p) S on=p=" "
 K c,i,p,on Q
ANS S h=$TR($P(X,":")," ",""),m=$TR($P(X,":",2)," ",""),s=$TR($P(X,":",3)," ",""),jT=""  Q:(h_m_s)=""  S jT=h*3600+(m*60)+s Q
CAL D:$P(X,"\")[":" ANS I $D(jT) S X=jT S:X>86399 (X,jT)=X-86400
CAL1 I X="" S X=$E("  :  :  ",1,fL) Q
 S h=X\3600,m=X#3600\60,s=X-(h*3600)-(m*60),X=$E($J(h,2)_":"_$E(0,m<10)_m_":"_$E(0,s<10)_s,1,fL) Q
FMT S h=$TR($P(X,":")," ",""),m=$TR($P(X,":",2)," ",""),s=$TR($P(X,":",3)," ",""),X=$E($E(0,h<10)_h_":"_$E(0,m<10)_m_":"_$E(0,s<10)_s,1,fL) Q
READ N c,h,l,m,p,s,a0,a1,dD,eX,fC,fK,fL,fP,jT,lC,mD,oD,p0,p1,pR,sK,tC,tO,tX,uC,yD,ZF
 S (a1,a0,tO)="",(l,p)=1,fL=8,p1=$P(Y,"\",2),p0=$P(Y,"\",3),fK=$P(Y,"\",5),sK=$P(Y,"\",6),pR=$P(Y,"\",7),fP=$E("  :  :  ",1,fL) S:p1["T" tO=+$P(p1,"T",2)
 S a1=$S(p1["H":ZAA02G("HI"),1:ZAA02G("LO"))_$S(p1["R":ZAA02G("RON"),1:"")_$S(p1["U":ZAA02G("UO"),1:""),a0=$S(p1["H"&(p0'["H"):ZAA02G("HI"),1:"")_$S(p1["R"&(p0'["R"):ZAA02G("ROF"),1:"")_$S(p1["U"&(p0'["U"):ZAA02G("UF"),1:"")
 F fC=1:1 Q:$E(fP,fC)=" "
 F lC=fL:-1:1 Q:$E(fP,lC)=" "
 D CAL,FMT I pR]"" W @ZAA02GP,$S(p1["P":ZAA02G("HI"),1:ZAA02G("LO")),pR S %C=%C+$L(pR)
 S tC=%C W @ZAA02GP D DSP(a1,X,a0) W @ZAA02GP
RD I 'tO R c#1
 E  R c#1:tO G:'$T TIM
 I c'="" G BRK:sK[c,ERR:l>fL,T:"tT"[c,ERR:c'?1N W c S X=$E(X,1,l-1)_c_$E(X,l+1,255),l=l+1 D:$E(fP,l)'=" " POS G RD
FN X ZAA02G("T") S ZAA02GF=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2) G @ZAA02GF:"RK,LK,RU,EF,CR"[ZAA02GF,CR:$F(fK,ZAA02GF),ERR
ERR W *7 G RD
POS I l<lC S l=l+1 Q:l>fL  G:$E(fP,l)'=" " POS N %C S %C=tC+l-1 W @ZAA02GP
 Q
T S ZAA02GF="" D TTIME,CAL,DSP(a1,X,a0) S l=fC,%C=tC+l-1 W @ZAA02GP G CR:ZAA02GF?1E,RD:"RK,LK,RU,CR"[ZAA02GF,CR:$F(fK,ZAA02GF),E
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
CR S tX=X D ANS I jT="" S X="" D DSP(a0,$J("",fL),"") G DONE
 G INV:h>24!(m>59)!(s>59)
MAX I $L($P(Y,"\",9)),jT>$P(Y,"\",9) G INV
MIN I $L($P(Y,"\",10)),jT<$P(Y,"\",10) G INV
BLD D CAL,DSP(a0,X,"")
DONE S:jT]"" X=jT_"\"_X K c,h,l,m,p,s,a0,a1,dD,eX,fC,fK,fL,fP,jT,lC,mD,oD,p0,p1,pR,sK,tC,tO,tX,uC,yD,ZF Q
INV S X=tX,l=fC W *7,@ZAA02GP G RD
TIM S ZAA02GF=-1,tX=X D ANS G BLD
TTIME S X="T"_$J("",fL-1),l=2 W @ZAA02GP,X,@ZAA02GP,ZAA02G("RT")
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
TCR S X=$TR(X," ","") I $L(X) S tX=$TR(X,"T0123456789",""),jT=$P($H,",",2) S:tX]"" @("jT="_jT_tX_($P(X,tX,2)*60))
 ;
 Q
TEST S %R=24,%C=1,Y="8\PT30\HS\\EX\?\Test : \\\\",X="" D INIT W !!,X,!! Q
 Q
