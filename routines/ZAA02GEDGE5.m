%ZAA02GEDGE5
IC S (p,xp)=P,xr=%R,xc=%C,(NC,sc)=0 W pBL_tHI_"Insert Text? "_tCL D MOVE I m=1,m(m)="" G EXIT
	S %R=xr,%C=xc W tLO
PO W @ZAA02GP
RD R C#1 I C="" X ZAA02G("T") S fk=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2) G @fk:"RU,CR,SE,EX"[fk,RD
	I NC'<ZC W *7 G RD
	W C S X(p)=X(p)_C,NC=NC+1,%C=%C+1 I %C>LC D NEWL G PO
	G RD
SE D ED G RD:ZAA02GF="EX" S X(p)=X(p)_c W @ZAA02GP,$TR(c,CS,xs) S %C=%C+1 I %C>LC S %C=FC D NEWL
	G PO
ED N %R,%C,X S %R=24,%C=15,dc=1,X="",Y="RON\ROF\EX\\3\\\255\0\\ASCII:  " D READ^ZAA02GEDRS S:ZAA02GF'="EX" c=$C(X)
	S %C=15 W @ZAA02GP,tLO_tCL Q
LK ;
RU G:p=xp&(%C'>xc) EX S %C=%C-1,NC=NC-1 I %C<FC S p=p-1,%R=%R-1 D:%R<TR SCRUP S %C=LC
	W @ZAA02GP,tCL,@ZAA02GP S X(p)=$E(X(p),0,%C-FC) G RD
CR S m=1,L=$L(X(p)) G REB
EX S m=1,p=xp,X(p)=$E(X(p),0,xc-FC),L=$L(X(p))
REB G:m(m)="" EXIT S:L'<WW p=p+1,X(p)="",L=0 S X(p)=X(p)_$E(m(m),0,WW-L),m(m)=$E(m(m),WW-L+1,$L(m(m))),L=$L(X(p))
	S:'$L(m(m)) m=m+1 G EXIT:'$D(m(m)),REB
EXIT I sc S %R=TR,%C=FC,p=P-(xr-TR) F I=p:1:p+NR-1 W @ZAA02GP,tHI_tCL_$TR(X(I),CS,xs) S %R=%R+1
	E  S %R=xr,p=xp,%C=xc F I=1:1 W @ZAA02GP,tCL_tHI_$TR($E(X(p),%C-FC+1,WW),CS,xs) S %R=%R+1,p=p+1,%C=FC Q:%R>BR  S:'$D(X(p)) X(p)=""
	W pBL_tHI_tCL S %R=xr,%C=xc,P=xp K m,p,fk,sc,xc,xp,xr,C,I,NC,ZC Q
MOVE S SZ=0 F I=1:1:MNL Q:'$D(X(I))  S SZ=SZ+$L(X(I))
	S m=1,m(1)=$E(X(xp),%C-FC+1,$L(X(xp))),X(xp)=$E(X(xp),0,%C-FC) W @ZAA02GP,tCL
	F I=xp+1:1 Q:'$D(X(I))  S m=m+1,m(m)=X(I) I %R<BR S %R=%R+1,%C=FC W @ZAA02GP,tCL
	S ZC=MSL-SZ K SZ Q
NEWL I p<MNL S %C=FC,p=p+1,X(p)="" D:%R=BR SCRDN S:%R<BR %R=%R+1 Q
	W *7 S:$L(X(p))>WW X(p)=$E(X(p),1,WW) Q
SCRUP S %R=TR,sc=sc-1 N %R,%C I sr S %R=TR,%C=FC W @ZAA02GP,@ZAA02G("IL") W:p=xp tHI_$TR($E(X(p),0,xc-FC),CS,xs)_tLO_$TR($E(X(p),xc-FC+1,WW),CS,xs)_tLO W:p>xp tLO_$TR(X(xp),CS,xs) Q
	S %R=BR,%C=FC W @ZAA02GP,@ZAA02G("DT") S %R=TR W @ZAA02GP,@ZAA02G("IL"),@ZAA02GP,tHI_$TR(X(xp),CS,xs)_tLO Q
SCRDN Q:p'<MNL  S %R=BR,sc=sc+1 N %R,%C I sr S %R=BR,%C=1 W @ZAA02GP,! Q
	S %R=TR,%C=FC W @ZAA02GP,@ZAA02G("DT") S %R=BR W @ZAA02GP,@ZAA02G("IL"),@ZAA02GP,tCL_tLO Q
	;
	;