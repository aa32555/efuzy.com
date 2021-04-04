%ZAA02GEDL1
LOAD K NOLOCK S SF=0,RTX="" D RTN I R]"" S GT=gl,SF=1 D @$S(GFR="OS":"MUMPS",1:"FILE")
EXIT W pBL_tCL D:SF SETUP^ZAA02GED,NP^ZAA02GED00 K R,V,X,Y,T,OK,GFI,GFR,GT,SF,MSG,SRC,RTX Q
FILE I $D(@ugl@(0,"PRELOAD")),^("PRELOAD")]"" X ^("PRELOAD") E  Q
	I rgl]"",$D(rt),rt]"",rt'=R K @rgl@(rt)
	D GL I $D(@ugl@(0,"POSTLOAD")),^("POSTLOAD")]"" X ^("POSTLOAD")
	Q
GL N pc,I,J,M,N,P,S,T,W,X,OK,MSG,PUT K @GT S MSG=$P($T(MSG),";;",2,9),PUT=$P($T(PUT),";;",2,9),W=rm-lm+1,(M,S)=""
	X MSG F I=1:1 S S=$O(@GFR@(S)) Q:S=""  S X=^(S),J=I*10000,T="" S:X]""&($E(X)'=ci) T=$P(X," "),T=T_$J("",tb-$L(T)-2)_" ",X=$P(X," ",2,999) X PUT
	S (sz,dt)="" I $D(@GFR)#2 S X=@GFR,sz=$P(X,"`",3),dt=$P($P(X,"`",5),"\",2) K X
	S rt=R,cx=0,@GT=rt_"`"_tl_"`"_lm_"`0`0`"_sz_"`"_dt Q
MUMPS N OS S OS=ZAA02G("OS") I '$$EXIST(R) K:rgl]"" @rgl@(R) W pBL_tLO,"Routine "_tHI_R_tLO_" does not exist"_tCL,*7 S %R=bl+2,%C=rm-24 W @ZAA02GP,"press any key to continue" R *X S SF=0 Q
	I rgl]"",$D(rt),rt]"",rt'=R K @rgl@(rt)
	D OS Q
OS N pc,I,J,K,M,N,O,P,T,W,X,DT,OK,MSG,OST,OSX,PUT,SRC K @GT
	S OST=$S(OS="DTM":"DTM",1:"OTH"),OSX=$P($T(@OST),";;",2,9),PUT=$P($T(PUT),";;",2,9),MSG=$P($T(MSG),";;",2,9),REM=$P($T(REM),";;",2)
	S PD=$S($D(@sgl@(0,"FMT","COP"))#2:$P(^("COP"),"`",2),1:0),SRC="MUMPS",W=rm-lm+1,M=0,sz=PD
	X MSG,OSX S rt=R,cx=0,dt="",@GT=rt_"`"_tl_"`"_lm_"`0`0`"_sz_"`" Q
DTM ;;S O=$ZRSOURCE(R) F I=1:1:$L(O,$C(10)) S X=$TR($P(O,$C(10),I),$C(9)," "),J=I*10000,T=$P(X," "),sz=sz+$L(T),T=T_$J("",tb-$L(T)-2)_" ",X=$P(X," ",2,999),X=$E(X,$F(X,$E($TR(X," ","")))-1,511),sz=sz+$L(X)+2 X PUT
OTH ;;X REM ZL @R F I=1:1 S X=$T(+I) Q:X=""  S sz=sz+$L(X)+1,J=I*10000,T=$P(X," "),T=T_$J("",tb-$L(T)-2)_" ",X=$P(X," ",2,999) X PUT
REM ;;I OS="CCSM" ZR
PUT ;;S P=W-$L(T),@GT@(J)=(J-10000+M)_d_T_$E(X,1,P),N=.1,M=0,pc=pc-1 X:'pc MSG W "." F K=0:0 Q:P'<$L(X)  S @GT@(J+N)=(J+M)_d_$J("",ct-1)_$E(X,P+1,P+W-ct+1),M=N,N=N+.1,P=P+W-ct+1
	Q
MSG ;;S pc=rm-$L(SRC)-$L(R)-13 W pBL_tLO_"Loading "_tHI_R_tLO_" from "_tHI_SRC_tLO_tCL Q
EXIST(N) N D I OS="MSM"!(OS["DSM") S D=$D(^ (N))>0 Q D
	I OS="DTM" S D=$L($ZRSOURCE(N))>0 Q D
	I OS="PSM" S D=$D(^UTILITY("R",N))>0 Q D
	I OS="M3" S D=$ZM(2,"R",N)]"" Q D
	I OS="M11" S D=$D(^ROUTINE(N))>0 Q D
	I OS="CCSM" S %ZGD=$ZGD,$ZGD=$ZRD,D=$D(@("^"_R)),$ZGD=%ZGD K %ZGD Q D>0
	Q 1
RTN S (GFI,GFR,R)="",%R=bl+2,%C=lm-1,Y="RON\ROF\HL,EX\\25\?%<>+-ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz0123456789/\\\\\Load routine: \\1",X=RTX D ^ZAA02GEDRS
	I ZAA02GF="HL" S HN=1210 D ^ZAA02GEDH,RESTORE^ZAA02GED08(+REFRESH,$P(REFRESH,":",2)) G RTN
	I X=""!(ZAA02GF="EX") S ZAA02GF="EX" Q
	S (R,RTX)=X W tCL D RTN1 G:R="" RTN Q
RTN1 G ONE:R?1A.AN!(R?1"%"1A.AN),^ZAA02GEDL2
ONE D LOCK I 'OK S R="" Q
	S Y=1,X="MUMPS",Y(Y)="MPS" S:$D(@wgl@(R)) X=X_",WORKFILE",Y=Y+1,Y(Y)="WRK" S:$D(@wgl@(R,2)) X=X_",BACKUP",Y=Y+1,Y(Y)="BKP" S:$D(@agl@(R)) X=X_",ARCHIVE",Y=Y+1,Y(Y)="ARC"
	S Y=(lm+25)_","_(bl+2)_"\H\EX\Load from: \\"_X W tLO D ^ZAA02GEDPL G:ZAA02GF'="EX" @Y(X) K X,Y K:rgl]"" @rgl@(R) S R="" Q
WRK S SRC="WORKFILE ",GFI=wgl_"(0)",GFR=wgl_"(R,V)",V=$P(@GFI@(R),"`",2) Q
ARC S SRC="ARCHIVE ",GFI=agl_"(0)",GFR=agl_"(R,V)",V=$P(@GFI@(R),"`",2) Q
BKP S (X,Y)="",T=+@wgl@(0,R),C=$P(^(R),"`",2) F I=1:1:T-1 S C=C-1 S:C=0 C=T Q:$D(@wgl@(R,C))[0  S X=X_","_$P($P(^(C),"`",5),"\",2),Y=Y+1,Y(Y)=C
	S Y=(lm-1)_","_(bl+2)_"\H\EX\Load backup: \\"_$E(X,2,99) W tLO D ^ZAA02GEDPL I ZAA02GF="EX" K C,I,T,X,Y K:rgl]"" @rgl@(R) S R="" Q
	S SRC="BACKUP ",GFI=wgl_"(0)",GFR=wgl_"(R,V)",V=Y(X) K C,I,T,X,Y Q
MPS S SRC="MUMPS",GFR="OS",GFI="" Q
LOCK D LKCHK Q:OK  S %R=bl+2,%C=rm-24-$L(U) W @ZAA02GP,tLO_"Already owned by "_$S(U?1.N:"device ",U["$":"device ",1:"user ")_tHI_U S OK=0 Q
LKCHK S OK=1,U="?" Q:$D(NOLOCK)!(rgl="")  L @rgl@(R):1 E  S OK=0 Q
	S @rgl@(R)=TID Q
	;
	;