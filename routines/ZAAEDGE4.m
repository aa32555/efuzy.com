%ZAAEDGE4 ;
 N c,m,r,c1,c2,fk,sc,p1,p2,xc,xp,xr S xr=%R,xc=%C,xp=P,m=1,m(m)=P,m(m,1)=%C,sc=0
 W pBL_tLO_"Delete What? "_tCL,@ZAAP,tLO G DC
RD R c#1 I c]"" W *7 G RD
 X ZAA("T") S fk=$P(ZAAY,"\",$A(ZAAX,$F(ZAAX,ZF))+2) G:"RU,DC,RK,LK,CR,EX"[fk @fk G RD
RU ;
RK ;
DC I %C>LC G RD:xp=MNL,RD:'$L(X(xp+1)) D NEWL S m=m+1,m(m)=xp,%C=FC W @ZAAP
 G:%C>$L(X(xp)) RD S c=$E(X(xp),%C-FC+1),m(m,2)=%C,%C=%C+1 W $S(CS[c:".",c=" ":".",1:c) G RD
LK G:m=1&(%C'>xc) EX W ZAA("L")_tHI_$TR($E(X(xp),%C-FC),CS,xs)_ZAA("L")_tLO
 S %C=%C-1 I %C<FC G RD:m=1 S m=m-1,xp=+m(m),%R=%R-1 D:%R<TR SCRUP S %C=LC W @ZAAP,tHI_$TR($E(X(xp),%C-FC+1),CS,xs)_tLO,@ZAAP
 S m(m,2)=%C-1 W @ZAAP G RD
CR G:m=1&(%C=xc) EX I m=1 S p1=m(1),c1=m(1,1),c2=m(1,2),X(p1)=$E(X(p1),1,c1-FC)_$E(X(p1),c2-FC+2,9999) G CR1
 S p1=m(1),c1=m(1,1),X(p1)=$E(X(p1),0,c1-FC),p2=m(m),c2=m(m,2),X(p2)=$E(X(p2),c2-FC+2,WW) F i=2:1:(m-1) S p1=m(i),X(p1)=""
CR1 S p1=m(1),L=$L(X(p1)),p2=p1+1
CR2 G:'$D(X(p2)) EX S X(p1)=X(p1)_$E(X(p2),0,WW-L),X(p2)=$E(X(p2),WW-L+1,9999),L=$L(X(p1)) I L<WW S p2=p2+1 G CR2
 S p1=p1+1 G CR2
EX I sc S %R=TR,%C=FC,xp=P-(xr-TR) F I=xp:1:xp+NR-1 W @ZAAP,tHI_tCL_$TR(X(I),CS,xs) S %R=%R+1
 E  S %R=xr,xp=m(1),c1=m(1,1) F i=1:1 S %C=c1 W @ZAAP,tCL_tHI_$TR($E(X(xp),c1-FC+1,WW),CS,xs) S %R=%R+1,xp=xp+1,c1=FC Q:%R>BR  S:'$D(X(xp)) X(xp)=""
 S %R=xr,%C=xc W pBL_tCL_tHI Q
NEWL I xp<MNL S xp=xp+1 D:%R=BR SCRDN S:%R<BR %R=%R+1 S:%C>LC %C=%C-FC S:%C-1>$L(X(xp)) %C=$L(X(xp))+FC-1 Q
 W *7 S:$L(X(xp))>W X(xp)=$E(X(xp),1,W) Q
SCRUP S %R=TR,sc=sc-1 N %R,%C,c1 I sr S %R=TR,%C=FC,c1=$S($D(m(m,1)):m(m,1),1:1) W @ZAAP,@ZAA("IL"),tHI_$TR($E(X(xp),0,c1-1),CS,xs)_tLO_$E(X(xp),c1,WW) Q
 S %R=BR,%C=FC W @ZAAP,@ZAA("DT") S %R=TR,c1=$S($D(m(m,1)):m(m,1),1:1) W @ZAAP,@ZAA("IL"),@ZAAP,tHI_$TR($E(X(xp),0,c1-1),CS,xs)_tLO_$TR($E(X(xp),c1,WW),CS,xs) Q
SCRDN Q:P=MNL  S %R=BR,sc=sc+1 N %R,%C I sr S %R=BR,%C=1 W @ZAAP,!,$TR(X(xp),CS,xs) Q
 S %R=TR,%C=FC W @ZAAP,@ZAA("DT") S %R=BR W @ZAAP,@ZAA("IL"),@ZAAP,tHI_$TR(X(xp),CS,xs)_tLO Q
