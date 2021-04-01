%ZAA02GEDIN1 ;;%AA UTILS;1.24;INIT: SETUP EXECUTABLE EDITOR;15MAY91  15:55
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
SETUP S $P(^ZAA02GED,";")="X ^ZAA02GED(""ED"") Q  " F I=1:1 S X=$T(DATA+I) Q:X=""  S S=$P(X," "),^ZAA02GED(S)=$P(X,";;",2,511)
        K I,S,X Q
DATA ;;
ED ;;X ^ZAA02GED("FI") Q:gl=""  X ^ZAA02GED("US") Q:TID=""  S TID="T-"_TID,R=$T(+0) X ^ZAA02GED("PR"),^ZAA02GED("LD") S $P(@gl,"`",6)=sz K ct,lm,rm,tb,rgl,ugl,I,J,K,M,N,O,P,R,T,W,X,PUT D ^ZAA02GED S TID=$E(TID,3,99)
PR ;;S (sz,M)="",X=$S($D(@ugl@(TID)):^(TID),1:"2`79`10"),lm=+X,rm=$P(X,"`",2),tb=+$P(X,"`",3),ct=tb+2,d=$C(1),W=rm-lm+1 K @gl S @gl=R_"`3`2`0`0``(from MUMPS)"
LD ;;S PUT=^ZAA02GED("PU") F I=1:1 S X=$T(+I) Q:X=""  S sz=sz+$L(X)+1,J=I*10000,T=$P(X," "),T=T_$J("",tb-$L(T)-2)_" ",X=$P(X," ",2,999) X PUT
PU ;;S P=W-$L(T),@gl@(J)=(J-10000+M)_d_T_$E(X,1,P),N=.1,M=0 F K=0:0 Q:P'<$L(X)  S @gl@(J+N)=(J+M)_d_$J("",ct-1)_$E(X,P+1,P+W-ct+1),M=N,N=N+.1,P=P+W-ct+1
US ;;S D=$S('$D(@ugl@("USER")):0,$I'=^("USER"):1,1:0),TID="" Q:D  S TID=$S(TID="":$I,TID?1"T-".E:$P(TID,"-",2),1:TID) Q:'$D(^%T("$I"))  R !,"User ID:" S O=$S($D(TID):TID,1:"") W !,"User ID" W:O'="" " (",O,")" R ": ",X Q:X=""  S TID=X
FI ;;S X=$S($D(^ZAA02GED)#2:^ZAA02GED,$D(^ZAA02GED)#2:^ZAA02GED,1:""),X=$P(X,";",2),gl=$P(X,"`") Q:gl=""  S gl=gl_"(TID)",ugl=$P(X,"`",2),rgl=$S($P(X,"`",8):$P(X,"`",7),1:"")
        ;
