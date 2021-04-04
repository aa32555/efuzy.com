ZAA02GINTRM
CCSM F n=2,3 I $D(^ZAA02G(.1,T,n))#2 S x=^(n) X "F i=1:1:$L(x,""`"") S y=$P(x,""`"",i) S:y[""91,"" y=$P(y,""91,"")_$P(y,""91,"",2) S $P(x,""`"",i)=y" S ^(n)=x
	F n="UK","DK","LK","RK","INK","DLK" S y=^ZAA02G(0,T,n) S:y["[" y=$P(y,"[")_$P(y,"[",2) S ^(n)=y
	D FIXUP K c,i,j,k,m,n,p,y,X G SETX
	;
MSM G:T["MSMPC" 1
DSM4 ;
DSM F n=2,3 S x=^ZAA02G(.1,T,n) X "F i=1:1:$L(x,""`"") S y=$P(x,""`"",i) D ONEMAP S $P(x,""`"",i)=y" S ^ZAA02G(.1,T,n)=x
	F n="UK","DK","LK","RK","INK","DLK" S X=^ZAA02G(0,T,n),y="" X "F j=1:1:$L(X) S $P(y,"","",j)=$A(X,j)" D ONEMAP S y="y=$C("_y_")",@y,^(n)=y
1 D FIXUP K c,i,j,k,m,n,p,x,y,z,X G SETX
ONEMAP Q:+y'=27  Q:$L(y,",")<3  S y=$P(y,",",2,999) S:"O[?"[$C(+y) y=$P(y,",",2,999) S:+y @$S($C(+y)?1AP:"y=+y-65+17#64",1:("y=$C("_y_")+20")),y="27,"_y Q
	;
DTM S r="176,177,178,179,180,185,186,187,188,191,192,193,194,195,196,197" F m=1:1:$L(r,",") F y=1:1:$L(r,",") S r($C($P(r,",",m),$P(r,",",y)))=""
	S xlat=$S($D(^ZAA02G("XLAT",1)):^(1),1:""),lx="" I xlat'="" S lx=$E(xlat,$L(xlat)-1,$L(xlat))
	S m="S r=""r=$C(""_y_"")_$C(2)"",@r",p="S:xlat'[r (lxx,lx)=$O(r(lx)) S:xlat[r lxx=$F(xlat,r),lxx=$E(xlat,lxx,lxx+1) S:xlat'[r xlat=xlat_$C($L(r)-1)_r_lxx"
	F n=2,3 I $D(^ZAA02G(.1,T,n))#2 S x=^(n) X "F i=1:1:$L(x,""`"") S y=$P(x,""`"",i) I $L(y) X m I $L(r)>2,$A(r)<160 X p S $P(x,""`"",i)=$A(lxx)_"",""_$A(lxx,2)" S ^(n)=x
	F n="UK","DK","LK","RK","INK","DLK" S r=^ZAA02G(0,T,n)_$C(2) I $L(r)>2,$A(r)<160 X p S ^(n)=lxx
	S ^ZAA02G("XLAT",1)=xlat K xlat,l,r,i,n,y,lx,lxx,m,p D FIXUP G SETX
M3 G SETX
PSM G SETX
M11 G SETX
GTM G SETX
	;
SETX S X=$C(0,13,13,9,9,27,27,27,127,32),(X1,X2)="" F I=1:1:6 S X=X_^ZAA02G(0,T,$P("UK,DK,RK,LK,INK,DLK",",",I))_$C(32+I)
	I $D(^ZAA02G(.1,T,2))=0 W *7,!?8,"Function keys for ",T," not initialized" ; G END
	I $D(^ZAA02G(.1,T,2)) S B=^(2) F I=1:1:35 S D=$P(B,"`",I) S:I=15 B=^(3) I D'="" S C="C=$C("_D_")",@C,C=C_$C(I+38) S:D["," X2=X2_C S:D'["," X1=X1_C
	S X=X_X1_$C(8,32)_X2,^ZAA02G(.3,T,0)=X S:$D(^ZAA02G(.3))#2=0 ^ZAA02G(.3)="ER\\\\\\\\\\TB\\\\CR\\\\\\\\\\\\\\ES\\\\\RU\UK\DK\RK\LK\IC\DC\PD\PU\FP\SU\SD\IL\DL\EF\ST\HL\OT\CP\BO\FM\EK\GO\RE\CT\EX\GW\SE\HK\XX\YY\GE\HO\ZZ\WW"
	I $D(^ZAA02G(.1,T,7)),$L($P(^(7),"\"))>3,^(7)'["ZAA02G(""C"")" S $P(^(7),"\")="S ZAA02G(""C"")=132 "_$P(^(7),"\"),$P(^(7),"\",2)="S ZAA02G(""C"")=80 "_$P(^(7),"\",2)
END K B,C,D,I,X,X1,X2,^ZAA02GWP(95,T),^ZAA02GNOTE("DEV",T),^ZAA02GDISP(95,T),^ZAA02GCALC(95,T) Q
	;
FIXUP S M=0,(H,^ZAA02G(0,T,M))="",A=99
	F I=1:1 S A=$O(^(A)) Q:A=""  S D=^(A) D FIX1 S Y=",ZAA02G("""_A_""")="_E S:$L(H)+$L(Y)>240 ^(M)="S "_$E(H,2,511),M=M+1,H="" S H=H_Y
	S:H'="" ^(M)="S "_$E(H,2,511) K ^(M+1),M,H,D,E,J,Y Q
FIX1 I $L(D)>40 S E="^("""_A_""")" Q
	S E="" I $E(D)'="$" F J=1:1:$L(D) S E=E_$A(D,J)_","
	I E="" D:D["""" FIX2 S E=""""_D_"""" Q
	S E="$C("_$E(E,1,$L(E)-1)_")" Q
FIX2 F J=1:1:$L(D,"""")-1 S E=E_$P(D,"""",J)_""""""
	S D=E_$P(D,"""",J+1) Q
	;
UPDATE ;
	;
	;
DTMFIX Q:$G(^ZAA02G("OS"))'="DTM"  S OS="DTM",t=$G(^ZAA02G("XLAT")) K ^ZAA02G("XLAT"),^ZAA02GWP(95) S ^ZAA02G("XLAT")=t,t="" F  S t=$O(^ZAA02G(0,t)) Q:t=""  D DTMF1
	S ^ZAA02GWP(103,"DTMFIX")=$H
	Q
DTMF1 S A="VT220T,VT220,VT100W,VT100,3151,3164,3153,WYSE30,WYSE60,WY60AT,WYSE75,DTMPC,DTMPC COLOR,",T=$F(A,t_",") Q:T<1  S T=$L($E(A,1,T),","),A=$P(",VT,01,16A,02A,13,13C,13D,06,18,08,16,D2,D2",",",T),T=t D @("ENT^ZAA02GINT"_A)
	D DTM Q
	;