%ZAA02GEDUR5  
INIT N C,I,R,W,X,LC X ZAA02G("EON") S %R=TR,%C=FC,LC=FC+LNG-1,TX=1 D PAD
PO W @ZAA02GP
RD R C#LC-%C+1 I C]"" S C=$TR(C,"`",""),TX(TX)=$E(TX(TX),0,%C-FC)_C_$E(TX(TX),%C-FC+$L(C)+1,LNG),%C=%C+$L(C) G:%C>LC WRAP
FK X ZAA02G("T") S ZAA02GF=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2) G @ZAA02GF:"RK,LK,UK,DK,IC,DC,RU,EF,CR,TB,EX"[ZAA02GF,PO
UK G:TX=1 EX S TX=TX-1,%R=%R-1 G PO
DK G:TX=NT EX S TX=TX+1,%R=%R+1 G PO
RK G:TX=NT&(%C=LC) RD S %C=%C+1 S:%C>LC %C=FC,%R=%R+1,TX=TX+1 G PO
LK G:TX=1&(%C=FC) RD S %C=%C-1 S:%C<FC %C=FC+LNG-1,%R=%R-1,TX=TX-1 G PO
RU G:TX=1&(%C=FC) RD I %C=FC S %C=LC+1,TX=TX-1,%R=%R-1 W @ZAA02GP
	W *8,*32,*8 S TX(TX)=$E(TX(TX),0,%C-FC-1)_" "_$E(TX(TX),%C-FC+1,LNG),%C=%C-1 G RD
CR I TX<NT S %R=%R+1,TX=TX+1,%C=FC G PO
TB ;
EX X ZAA02G("EOF") F I=1:1:NT S X=TX(I) D STRP S TX(I)=X
	Q
EF S TX(TX)=$E(TX(TX),0,%C-FC) W tCL G PO
IC S X=$E(TX(TX),0,%C-FC)_" "_$E(TX(TX),%C-FC+1,LNG+1) I $E(X,LNG+1)=" "!(TX=NT) S TX(TX)=$E(X,1,LNG) W $E(X,%C-FC+1,LNG) G PO
	S TX(TX)=X D INSWRAP G PO
DC S TX(TX)=$E(TX(TX),0,%C-FC)_$E(TX(TX),%C-FC+2,LNG)_" " W $E(TX(TX),%C-FC+1,LNG) G PO
WRAP S L=$L(TX(TX)," ") I L=1!(TX=NT)!($E(TX(TX),LNG)=" ") S:TX=NT %C=LC S:TX<NT TX=TX+1,%R=%R+1,%C=FC G PO
	S W=$P(TX(TX)," ",L),TX(TX)=$P(TX(TX)," ",1,L-1),%C=FC+$L(TX(TX)) W @ZAA02GP,$J("",$L(W)+1) S TX(TX)=TX(TX)_$J("",LNG-$L(TX(TX)))
	S %R=%R+1,TX=TX+1,TX(TX)=W_$E(TX(TX),$L(W)+1,LNG),%C=FC W @ZAA02GP,W S %C=FC+$L(W) K W G RD
INSWRAP F I=1:1:NT S X=TX(I) D STRP S TX(I)=X
	I $L(TX(TX))'>LNG D PAD Q
	S X=TX,R=%R,C=%C
I1 I X=NT S TX(X)=$E(TX(X),1,LNG),%R=R,%C=C D PAD Q  ;Last line gets chopped
	I $L(TX(X))'>LNG S %R=R,%C=C D PAD Q
	S L=$L($E(TX(X),1,LNG)," "),W=$P(TX(X)," ",L,99),TX(X)=$P(TX(X)," ",1,L-1),L=$L(TX(X)),%C=FC+L W @ZAA02GP,$J("",LNG-L)
	S X=X+1,%R=%R+1,S=$S($E(TX(X))=" ":"",1:" "),TX(X)=W_S_TX(X),%C=FC W @ZAA02GP,$E(TX(X),1,LNG) G I1
PAD F I=1:1:NT S TX(I)=TX(I)_$J("",LNG-$L(TX(I)))
	Q
STRP N I F I=$L(X)-10:-10:0 Q:$E(X,I,511)'?." "
	F I=I+10:-1:0 Q:$E(X,I)'=" "
	S X=$E(X,1,I) Q
	;
	;