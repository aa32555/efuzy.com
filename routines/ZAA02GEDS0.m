%ZAA02GEDS0
ASK W pBL,tHI_rt_tLO_" has been changed.  Save these changes first? "_tHI
	S %R=bl+2,%C=lm+45+$L(rt),Y="RON\ROF\HL,EX\\3\NY\No;Yes",X=1 D ^ZAA02GEDYN I ZAA02GF="HL" D HELP G ASK
	I 'X!(ZAA02GF="EX") W pBL_tCL Q
SAVE W pBL_tLO_"Save routine: "_tHI_rt_tCL
	S %R=bl+2,%C=lm+13,Y="RON\ROF\HL,EX\\15\%ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 \\\\\\1",(OR,X)=rt D ^ZAA02GEDRS I ZAA02GF="HL" D HELP G SAVE
	Q:X=""!(ZAA02GF="EX")  S (rt,NR)=$P(X," ")
UPD I $D(@ugl@(0,"PRESAVE")),^("PRESAVE")]"" X ^("PRESAVE") E  Q
	I OR]"",NR'=OR S R=NR D LOCK^ZAA02GEDL1 I 'OK H 2 Q
	S rt=NR,$P(@gl,"`")=NR I OR]"",OR'=NR,rgl]"" K:$D(@rgl@(OR)) ^(OR)
	S OS=ZAA02G("OS"),CR="CK=CK+"_$P($T(@OS),";;",2),PD=$S($D(@sgl@(0,"FMT","COP"))#2:$P(^("COP"),"`",2),1:0),E=0 D END,DATE,MSG
	S IR=$S($D(@wgl@(0,rt)):^(rt),1:"3`0```0"),OV=$P(IR,"`",2),NV=OV+1 S:NV>IR NV=1 S $P(IR,"`",2)=NV
	K @wgl@(rt,NV) S (N,CK,ER,FL,NB,NL,LC)="" F I=0:0 D GET,PUT Q:S=""!(S>E)
	S:CK'=$P(IR,"`",9) $P(IR,"`",6)=DT,$P(IR,"`",9)=CK S sz=NB+PD,$P(IR,"`",3,5)=DE_"`"_NL_"`"_NB,$P(IR,"`",7,8)=DT_"`"_TID,@wgl@(0,rt)=IR,@wgl@(rt,NV)=$P(IR,"`",3,99),cx=0,dt=$P(DT,"\",2),$P(@gl,"`",5,7)=cx_"`"_sz_"`"_dt
	I ER W pBL_tHI_ER_tLO_" line"_$S(ER>1:"s",1:"")_" exceeded 255 bytes and was split"_tCL S %R=bl+2,%C=rm-12 W @ZAA02GP,"Press any key" R *C S bs=+@gl@(ts) D NP^ZAA02GED00
	I $D(@ugl@(0,"POSTSAVE")),^("POSTSAVE")]"" X ^("POSTSAVE")
	K pc,C,E,G,L,R,S,V,X,CK,CM,CR,DT,ER,FL,IR,LC,LN,NB,NL,NR,NV,OR,OS,OV,PC,PD,DATE W @ZAA02GP,tLO_tCL Q
GET K L,SB S (T,L)="",S=$O(@gl@(N+.9)),N=S\1 Q:S=""  G G2
G1 S S=$O(^(S)) Q:S=""!(S\1'=N)
G2 S L=L+1,SB(L)=S,L(L)=$S(S#1:$E($P(^(S),d,2),ct,511),1:$P(^(S),d,2)) G G1
PUT S CM=0,X=L(1) S:$TR(X," ","")="" L(1)="" I L(1)=""!($E(X)=ci) S CM=1 G P1
	S T=$P(X," "),X=$P(X," ",2,511),FC=$E($TR(X," ","")) F i=1:1:9-$L(T) Q:$E(X,i)'=" "
	S L(1)=T_" "_$E(X,i,511)
	F L=L:-1:1 Q:$TR(L(L)," ","")'=""
	S j=255 I FC'=";" F j=$L(L(L)):-1:0 I $E(L(L),j)'=" " S L(L)=$E(L(L),0,j) Q
P1 S (X,Ln)="",n=1
P2 I n>L D SAVLIN Q
	I Ln+$L(L(n))<256 S X=X_L(n),Ln=$L(X),n=n+1 G P2
	S Y=$E(L(n),1,255-Ln),X=X_Y,L(n)="<LNGTH> "_$E(L(n),255-Ln+1,511),ER=1 D SAVLIN,INSERT Q
SAVLIN S LC=LC+1,@wgl@(rt,NV,LC)=X I 'CM S:'FL&(T]"") FL=LC,DE=$P(X,";",2) S NL=NL+1,NB=NB+$L(X)+1,@CR
	S CH=$P(X," ")="<LNGTH>",X="",pc=pc-1 D:'pc MSG W $P("./"_tHI_"^"_tLO_$C(7),"/",CH+1) Q
INSERT N i,w,S,X,NI,NW,NX,Ln S w=rm-lm+1,S=SB(n),$P(@gl@(S),d,2)=$J("",ct-1)_Y F i=n+1:1:L K ^(SB(i))
	S NX=$O(@gl@(S\1+.9)),NW=S\1+1,NI=0,(X,Ln)="",i=n I $D(^(NW)) S ERi=1 Q
I1 I i>L D:X]"" INS S $P(@gl@(NX),d)=S,SF=1 Q
	I Ln+$L(L(i))'>w S X=X_L(i),Ln=$L(X),i=i+1 G I1
	S X=X_$E(L(i),1,w-Ln) D INS S X=$J("",ct-1)_$E(L(i),w-Ln+1,511),Ln=$L(X),i=i+1 G I1
INS S @gl@(NW+NI)=S_d_X,S=NW+NI,NI=NI+.1,X="" Q
MSG S pc=rm-lm-$L(rt)-20 W pBL,tLO_"Saving "_tHI_rt_tLO_" to "_tHI_"WORKFILE "_tLO_tCL Q
END N I,S S S="" F I=0:0 S S=$O(@gl@(S)) Q:S=""  I $P(^(S),d,2)]"" S E=S
	Q
DATE N m,d,y,o,H,M,S,T,X S X=$H,T=$P(X,",",2),DT=X*100000+T,o=$S(X<21609:14915,1:-21609),X=X+o,y=4*X+3\1461,d=X*4+7-(1461*y)\4,m=5*d-3\153,d=5*d+2-(153*m)\5 S m=m+3 S:m>12 m=m-12,y=y+1 S y=$S(o=14915:y+1800,y>99:y+1900,1:y)
	S H=T\3600,M=T#3600\60,S=T#60,X=$E(0,m<10)_m_"/"_$E(0,d<10)_d_"/"_$E(0,y<10)_y_"  "_$E(0,H<10)_H_":"_$E(0,M<10)_M,DT=DT_"\"_X Q
M3 ;;$ZX(X,1)
PSM ;;$ZX(X,1)
M11 ;;$ZC(X)
DTM ;;$ZCRC(X,1)
CCSM ;;$ZCRCX(X)
MSM ;;$ZCRC(X,1)
DSM ;;$L(X)
DSM4 ;;$L(X)
HELP S HN=1220 D ^ZAA02GEDH,RESTORE^ZAA02GED08(+REFRESH,$P(REFRESH,":",2)) Q
	;
	;