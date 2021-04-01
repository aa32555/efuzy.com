%ZAA02GEDIN2 ;;%AA UTILS;1.24;INIT: SETUP EXECUTABLE EDITOR FOR ERROR RECOVERY;15MAY91  15:55
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
SETUP S ^ZAA02GEDER="X ^ZAA02GEDER(""ED"")" F I=1:1 S X=$T(DATA+I) Q:X=""  S S=$P(X," "),^ZAA02GEDER(S)=$P(X,";;",2,511)
        K I,S,X Q
DATA ;;
ED ;;X ^ZAA02GEDER("FI") Q:gl=""  X ^ZAA02GEDER("US") Q:TID=""  S R=$T(+0),TID="T-"_TID X ^ZAA02GEDER("ER"),^ZAA02GEDER("PR"),^ZAA02GEDER("LD"),^ZAA02GEDER("TG"),^ZAA02GEDER("EN") D ^ZAA02GED S TID=$E(TID,3,99)
ER ;;S OS=^%T("OS"),(X,ZAA02GERR)=$S(OS="PSM":%ER,1:$ZE),LT=$S(OS="PSM":$P($P($P(X,"..."),"> ",2),"^"),OS="MSM":$P($P(X,"^"),">",2),1:"")
PR ;;S PUT=^ZAA02GEDER("PU"),(bs,sz,M)="",X=$S($D(@ugl@(TID)):^(TID),1:"2`79`10``3"),lm=+X,rm=$P(X,"`",2),tb=+$P(X,"`",3),tl=$P(X,"`",5),bl=$P(X,"`",6),ct=tb+2,d=$C(1),W=rm-lm+1,r=tl,c=lm K @gl S @gl="`"_tl_"`"_lm_"`0`0`0"
LD ;;F I=1:1 S X=$T(+I) Q:X=""  S sz=sz+$L(X)+1,J=I*10000,T=$P(X," "),T=T_$J("",tb-$L(T)-2)_" ",X=$P(X," ",2,999) X PUT
PU ;;S P=W-$L(T),@gl@(J)=(J-10000+M)_d_T_$E(X,1,P),N=.1,M=0 F K=0:0 Q:P'<$L(X)  S @gl@(J+N)=(J+M)_d_$J("",ct-1)_$E(X,P+1,P+W-ct+1),M=N,N=N+.1,P=P+W-ct+1
EN ;;S @gl=R_"`"_r_"`"_c_"`"_bs_"`0`"_sz_"`(from MUMPS)" K ct,lm,rm,tb,rgl,ugl,I,J,K,M,N,O,P,R,T,W,X,PUT
US ;;S D=$S('$D(@ugl@("USER")):0,$I'=^("USER"):1,1:0),TID="" Q:D  S TID=$S(TID="":$I,TID?1"T-".E:$P(TID,"-",2),1:TID) Q:'$D(^%T("$I"))  R !,"User ID:" S O=$S($D(TID):TID,1:"") W !,"User ID" W:O'="" " (",O,")" R ": ",X Q:X=""  S TID=X
FI ;;S X=$S($D(^ZAA02GED)#2:^ZAA02GED,$D(^ZAA02GED)#2:^ZAA02GED,1:""),X=$P(X,";",2),gl=$P(X,"`") Q:gl=""  S gl=gl_"(TID)",ugl=$P(X,"`",2),rgl=$S($P(X,"`",8):$P(X,"`",7),1:"") I $D(ZAA02G(1)),ZAA02G(1) S ZAA02G(1)=1 X ^%T("ECHO-ON"),^%T("TERM-OFF"),^%T("WRAP-ON")
TG ;;S FT=$P(LT,"+"),FL=$P(LT,"+",2),(LT,LC,xs)="" X:FT]"" ^ZAA02GEDER("T1") X:FL ^ZAA02GEDER("T2") X:xs ^ZAA02GEDER("T3") K T,X,Y,FT,FL,LT,LC,i,xs Q
T1 ;;F i=0:0 S xs=$O(@gl@(xs)) Q:xs=""  S T=$P($P($P(^(xs),d,2)," "),"(") I T]"",T=FT S LT=T Q
T2 ;;F i=0:0 S xs=$O(@gl@(xs)) Q:'xs  I xs=(xs\1) S L=$P(^(xs),d,2) I $TR(L," ","")]"" S FL=FL-1 Q:'FL
T3 ;;S bs=xs,r=tl-1,c=lm F i=1:1:(bl-tl\2) S bs=+@gl@(bs),r=r+1 Q:'bs
        ;
