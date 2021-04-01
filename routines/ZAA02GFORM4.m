ZAA02GFORM4 ;PG&A,ZAA02G-FORM,2.62,;28DEC94 9:45A;;;05NOV96  13:44
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
H17 I Y#2,$P(Y,"`",7)#2=0 D H I  G H17A
H17B S RX=0 D HELP^ZAA02GFORM3 G RET^@go
H17A S %R=$P(Y,"`",3),%C=$P(Y,",",2),%R=+%R D TABLE W ro Q:$D(kw)  G DONE
 ;
H K kw I $D(^ZAA02GDISP(SCR,SN,I_".1")),$P(^(I_".1"),"`")]"",$D(@$P(^(I+.1),"`",2))
 Q
H6 I Y#2,$P(Y,"`",7)#2=0 D H I  G H6A
H6B S RX=0 D HELP^ZAA02GFORM3 S %R=cr+ls-lp,%C=lm+2 W @ZAA02GP,ZAA02G("Z"),ro I 'RX W X,@ZAA02GP G D0^ZAA02GFORM6A
 W $P(X,"`",2) S ef=0,X=$P(X,"`") X xd,px S @e@(.001*ls+I)=D G 3^ZAA02GFORM6A:RX<0,OTH^ZAA02GFORM6A:RX>900,1^ZAA02GFORM6A
H6A S %R=cr+ls-lp,%C=lm+2 D TABLE W ro Q:$D(kw)  S %R=cr+ls-lp,%C=lm+2,ef=1,go="ZAA02GFORM6A" G DONE
 ;
TABLE S YY=Y,x0=X N Y S:'$D(kws) (kws,kwe)="" S tsl=^ZAA02GDISP(SCR,SN,I_".1"),tss=$P(tsl,"`",2),Y=$P(tsl,"`"),tst=+$P(tsl,"`",5)
 I 123[tst S ZAA02GPOPALT=$P($T(TABLEX+tst>1),";",2,99)
 I kws]"",$D(@tss@(kws)) S kws=$TR($S(+kws=kws:kws-1E-9,1:$E(kws,1,$L(kws)-1)_$C($A(kws,$L(kws))-1)_"~"),"`","_")
 I tst=0,$L($TR($P(tsl,"`",5),"KF",""))+2=$L($P(tsl,"`",5)) S ZAA02GPOPALT=$P($T(TABLEX+3),";",2,9)
 I '$D(ZAA02GPOPALT),$E($P(tsl,"`",3))'="X" S ZAA02GPOPALT=$P($T(TABLEX+2),";",2,9) S:'kws kw="" S (kwe,kws)=""
 I tst=0,kws="" ; S kws=" "
 S Y(0)="\EX\"_tss_"\"_$P(tsl,"`",3)_"\"_kws_"\\\"_kwe_"\"_to I $P(Y,"\",2)["C" S %R=%R+1 S:%R>12 $P(Y(0),"\")=%R-1,%R=1
 D POP K kws,kwe,Y S Y=YY K YY I X[";EX" S X=x0,RX="0,A" Q
 I 123[tst S X=$S(tst=1:@tss@(X),1:$P(X,"|",2)) K S,S2
 S RX=1 S:X["(new item)" X="",RX=0 Q
TABLEX ;S X=$O(@tss@(X)) S:X]TEN X="""" Q:X=""""  S S2=^(X)
 ;S S2=$P(X,""|"",2),X=$P(X,""|"") F jj=1:1 S:S2="""" X=$O(@tss@(X)) S:jj=999 X="""" S:X]TEN X=""""  Q:X=""""  S S2=$O(@tss@(X,S2)) I $L(S2) S X=X_""|""_S2 Q
 ;F jj=1:1 S X=$O(@tss@(X)) Q:X=""""  I $E(@tss@(X),1,$L(kw))=kw Q
 ;F jj=1:1 S X=$S(X=kws:kws_""(new item)"",X[""(new item)"":$O(@tss@(kws)),1:$O(@tss@(X))) Q:X=""""  Q
POP S REFRESH="" I $D(Y(0)),$P(Y(0),"\",3)]"" S $P(Y,"\",2)=$P(Y,"\",2)_"UO14"
 D POP1,AP0 K tt,td,REFRESH Q
POP1 G ^ZAA02GFORMP
 ;
 ;
KW S tsl=^ZAA02GDISP(SCR,SN,I_".1"),tss=$P(tsl,"`",2),tst=$P(tsl,"`",5) I $P(Y,"`",12)["K" D KW0 I  Q
 G:RX[",A" KW4 I $D(@$P(Y,"`",9)) Q:tst<1  S kw=X G KW6
 I tst<1
 I $P(Y,"`",12)["F" G FT^ZAA02GFORM3
 S ert=5 G KW4
 Q
KW0 S kw=X,kl=$L(kw) G:tst["M" KW8 S X=$O(@tss@(X)) I $D(@tss@(kw)) G KW1:$E(X,1,kl)'=kw,KW1:$P(Y,"`",12)["E",KW2
 I $E(X,1,kl)'=kw S X=kw K kw,kl W *7 G KW4
 I X]"",$E($O(@tss@(X)),1,kl)'=kw,$P(Y,"`",12)'["F" S kw=X G KW1
KW2 S X=kw,kws=kw,kwe=kw_"~" G @$S(go[6:"H6A",1:"H17A")
KW1 I tst<1 S X=kw Q
KW6 I tst=1 S X=@tss@(kw) K kw,kl Q
 S kl=$O(@tss@(kw,"")) I $O(^(kl))="" S X=$S(+tst=2:kl,1:+kl) K kl,kw Q
 G KW2
KW4 S RX=0 I 0
 Q
KW8 S X="" F kws=0:0 S X=$O(@tss@(X)) Q:X=""  I $E($G(@tss@(X)),1,kl)=kw S X=kw,kws=1 G H17A
 W *7 S X=kw K kw,kl,tsl G KW4
 Q
 ;
UTIL N:0 (ZAA02G,ZAA02GP,X,Y) G POP1
MENU G POP1
 ;
AP0 S REFRESH=$S('$G(REFRESH):"1:24:1:80",1:REFRESH),tt=+REFRESH,td=$P(REFRESH,":",2) K REFRESH
REFR W ZAA02G("Z") I $P(^ZAA02GDISP(SCR,SN),"`",13)="N" D REFRP
 K SNc D REFR1 K a,c,f,td,tf,tt,tw I 1 Q
REFR1 S f=$P(^ZAA02GDISP(SCR,SN),"`",3) F %R=tt:1:td I $D(^ZAA02GDISPL(f,0,ZAA02G,%R)),$S('$D(SNc(%R)):1,SNc(%R)=JJ:1,1:0) W ^(%R),^(%R+.1) I ^(%R+.2)]"",'$D(key) W rf X ^(%R+.2) W sa
 I $D(cr),$D(np),%R'<cr,tt'>(cr+np) D REFRV^ZAA02GFORM6A
 Q  ;W *13,SCR,"-",SN,"-",JJ," ",tt,">",td," ",$D(SNc) R CCC Q
REFRP N G,%C D REFRP1,REFRP2 S G=0 F  S G=$O(SNc(G)) Q:G=""  S SNc(0,SNc(G))=1
 N (tt,td,SNc) ; W   R CCC
 F %C=$J-.01:0:$J+.99 S %C=$O(^ZAA02GF(%C)) Q:%C=""  I $D(^ZAA02GF(%C,"local","SCR")),$D(SNc(0,%C)) D REFRL,REFR1
 Q
REFRP1 N SCR,SN F %C=$J-.01:0:$J+.99 S %C=$O(^ZAA02GF(%C)) Q:%C=""  I $D(^ZAA02GF(%C,"local","SCR")) S SCR=^("SCR") I $D(^("SN")) S SN=^("SN") D REFRP2
 S %C=JJ Q
REFRP2 S G=$P($G(^ZAA02GDISPL(SCR_"-"_SN)),"\",4) S:G="" G="1:22:1:80" I $P(G,":",3,4)="1:80" F G=+G:1:$P(G,":",2) S SNc(G)=%C
 Q
REFRL N tt,td S %="%C"  F  S %=$O(^ZAA02GF(%C,"local",%)) Q:%=""  S @%=^(%)
 Q
 ;
HEPOP N X,Y S %R=%R+1,a=$S(hs="":0,$D(@hs@(0)):@hs@(0),$D(@hs):@hs,1:0),Y=$S(hp]"":hp,1:"20\RHLC\1"),$P(Y,"\",2)=$P(Y,"\",2)_"W"_to,Y(0)=$S(%R>20:%R-5,1:"")_"\EX\"_$S(a:hs,1:"USERZ")_"\\0",$P(Y,"\",3)=$S('$P(Y,"\",3):1,1:$P(Y,"\",3))
 S:%R>20 %R=3 D POP Q
 ;
ER S ZF=X N Y,X S Y="25,14\RHLW"_to_"\1\\\ERROR CONDITION:*,*,"
 S Y=Y_$P("Mandatory Entry - Please fill in item\Mandatory Entry - Cannot proceed without it.\Invalid Characters\Invalid Entry\No entries starting with - "_ZF_"*,*,were found in Table","\",ert)_" * "
 I $D(USERMESS)>2 S $P(Y(0),"\",3,4)="USERMESS\USERMESS(X)"
 K ert D POP K USERMESS Q
 ;
DONE G:'RX RD S x0=X G:$P(Y,"`",6)="" D1 I @$P(Y,"`",6)
 E  S ert=4 G DER^@go
D1 I $P(Y,"`",17)="" G SAVE
 I $P(Y,"`",12)["V" X $P(Y,"`",17) G:'$T TERR G SAVE
 I 1 X $P(Y,"`",17) G:'$T TERR
SAVE G:go'="ZAA02GFORM6A" SAVE^@go G HS^ZAA02GFORM6A
RD G U1^@go
TERR S:er="" ert=4 G DER^@go
