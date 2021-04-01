ZAA02GFORM0A ;PG&A,ZAA02G-FORM,2.62,DISPLAY DATA;17OCT94 2:28P;;;19FEB97  10:57
 ;Copyrght (C) 1986, Patterson, Gray & Associates, Inc.
 ;
 S nb=+^ZAA02GDISP(SCR,SN,.021)
 I $L(SNL,",")>2,$D(tab) D KEYIN I D]"" W p(g,I),D K key G LOAD2^ZAA02GFORM0
LOAD S tab="" S:$D(^(.09)) p=^(.09),cp=^(.0901)
KEY D KEYIN
 W:l23'="" l23E,ZAA02G("Z"),"       Key",rf D ^ZAA02GFORM1 G:RX=0 KEY
 I RX>100!(RX<0)!(X="") W:X'="" p(g,I),$E(sp,2,$L(X)+1) S nb=nb-1 G CANCEL:nb<^ZAA02GDISP(SCR,SN,.021) D:$P(Y,"`",5)["D" CLEAR1 G KEY
 I nb<$P(^ZAA02GDISP(SCR,SN,.021),",",2) S nb=nb+1 G KEY
 K keyr I 'key K key G LOAD2^ZAA02GFORM0
 K key S keyr=1 G LOAD2^ZAA02GFORM0
KEYR D CLEAR S nb=$P(^ZAA02GDISP(SCR,SN,.021),",",2) G LOAD
KEYIN K b,^ZAA02GF(JJ),ld
 W rf S X="",ty="ty(0)",I=nb,ca="p(g,I)="_ZAA02GP,(dv,g,v)=0,Y=^ZAA02GDISP(SCR,SN,I),B=$P(Y,"`",3),%R=+B,%C=$P(B,",",2),@ca,key=$P(Y,"`",5)["R",m(0)=+Y X:$D(keyr) $P(Y,"`",2) X ^ZAA02GDISP(SCR,SN,I_".2"),$P(Y,"`",4) S @e@(I)=D S $P(ty(g),$C(0),I+1)="" Q
 ;
CLEAR W l24
CLEAR1 I $D(^ZAA02GDISPL(SCR_"-"_SN,0,ZAA02G,100)) F J=100:1 Q:'$D(^(J))  W ^(J)
 Q
 ;
CANCEL S eq="C" K key,keyr G EXIT^ZAA02GFORM
 ;
DONLY S i="",(dv,v,n)=0 K dom,don F k=1:0 S i=$O(dog(i)),j(n)=1 q:i=""  I $L(+i)=1 D DO1 Q:i=""
 S dom(k)=0 ; X "N (dom,dog,g) W  R CCC"
 F dom=1:0 Q:'$D(dom(dom))  S do=dom(dom),I=+do,i=I_" " Q:do=0  D PAGE S dom=$S(j=5:-1,j=6:99,1:1)+dom X:j=7 "S j=$L($P(dom(dom-1),"" ""))+1 f dom=dom:1 Q:$L($P($G(dom(dom)),"" ""))<j" S:'dom dom=1
 K don,dom,g,do,ep Q
DO1 I dog(i)=2 S dom(k)=i_dv_" ",k=k+1 Q
 S n=n+1,n(n)=i F j(n)=1:1 S i=n(n) Q:j(n)>g(+i)  S $P(dv,".",n)=j(n),dom(k)=i_dv_" "_$S(j(n)=1:",",1:""),k=k+1 F I=1:1 S i=$O(dog(i)) Q:i=""  Q:i\100'=(+n(n))  S do(n)=i D DO1 S i=do(n)
 S n=n-1,dom(k-1)=$TR(dom(k-1),";","")_";",dv=$P(dv,".",1,n) Q
PAGES S i=I_" " D PAGE S RX=$S(j<5:1,1:-1) K i Q
PAGE S g=+i W l24,ZAA02G("RON")," Display Only ",$S(dog(i)=1:"Group",1:"Multiple")," ",ZAA02G("ROF"),"  Press NEXT, PREVIOUS, TAB, Cursor Keys, RETURN, or EXIT "
 X ^ZAA02G("ECHO-OFF") D LIST:dog(i)=2,GRP:dog(i)=1 W l24,ZAA02G("CL") X ^ZAA02G("ECHO-ON") Q
GRP D GSET S I=g*100+1,p=$S($D(p(dv,I)):p(dv,I),1:p(dv,$O(p(dv,I))))
GRD D RD I j=7,lp=+g(g) W *7 S j=1
 S:j=3 n(n)=g(g),j=2 I j>3 Q
 I j=1,n(n)+g(g)'>$P(g(g),"`",2) S lp=n(n)+g(g),lp=$S(lp+g(g)>$P(g(g),"`",2):$P(g(g),"`",2)-g(g)+1,1:lp) D GLIST G GRD
 I j=2,n(n)>1 S lp=n(n)-g(g),lp=$S(lp<1:1,1:lp) D GLIST G GRD
 W *7 G GRD
GRD1 X:n(n)>g(g)&$S(j=5:dom(dom)[",",1:dom(dom)[";") "S lp=1 D GLIST" Q
GLIST S x0=lp_";1",don(g,$S(dv?.n:0,1:$P(dv,".",1,n-1)))=lp D REFR^ZAA02GFORM8 S I=g Q
GSET S n=$L(g)\2+1,dv=$P(dom(dom)," ",2),lp=$S(dv?.n:0,1:$P(dv,".",1,n-1)),lp=$S($D(don(g,lp)):don(g,lp),1:1),n(n)=$P(dv,".",n)+lp-1,v=$P(v,".",1,n),$P(v,".",n)=n(n)
 Q  ;W *13,v,!,dv," ",dom," ",dom(dom) R CCC Q
LIST S g=g\100 D:g GSET W rf S Y=^ZAA02GDISP(SCR,SN,I),f=$P(Y,"`",4),lsr=$P(Y,"`",3),%C=$P(lsr,",",2),lsr=$S(g:li(I,dv),1:lsr),lsp=0,lsd=$P(Y,"`",14),lse=$P(Y,"`",15),Y=$P(^(I_".2"),"`",2),p=$S(g:p(dv,I),1:p(g,I))
LRD D RD S:j=3 lsp=lsd,j=2 I j>3 S lsp=0 D LISTD K lsd,ls,lse,lsr W sa Q
 I j=1,lsp+lsd<lse S lsp=lsp+lsd,lsp=$S(lsp+lsd>lse:lse-lsd,1:lsp) D LISTD G LRD
 I j=2,lsp>0 S lsp=lsp-lsd,lsp=$S(lsp<0:0,1:lsp) D LISTD G LRD
 W *7 G LRD
LISTD S %R=+lsr F ls=lsp:1:lsp+lsd-1 X Y,f W @ZAA02GP,D S %R=%R+1
 Q
 ;
RD W p R B#1:to G:B'="" RD X ZAA02G("T") S j=$E(xx,$F(xx,ZF)) I "1234E"'[j!(j="") W *7 G RD
 I 1234[j S j=$S(14[j:4,j=2:7,1:5) Q
 S j=$F(xx,ZF),j=$E(xx,j+1) I 1234'[j W *7 G RD
 S:j=4 j=6 Q
