ZAA02GFORM ;PG&A,ZAA02G-FORM,2.62,SET-UP;21NOV95 4:07P;;;23AUG96  18:00
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
SETUP I '$D(ZAA02Gform) S ZAA02Gform=$S($D(SINGLE):0,'$D(NEW):1,NEW:1,1:2)
 E  S A=$P(ZAA02Gform,";",2) S:ZAA02Gform["~" ZAA02Gform=$P(ZAA02Gform,"~") I A]"",A["Q"!(A["S") S $P(ZAA02Gform,";")=A["Q"*2+(A["S"*3)+8
 I $P(ZAA02Gform,";")["#"!$D(^ZAA02GDISP(0,"#")) S $P(ZAA02Gform,";")=$TR($P(ZAA02Gform,";"),"#","")_"#"
 I $D(SNL)=0 S A="",SNL="" F I=1:1 S A=$O(^ZAA02GDISP(SCR,A)) Q:A=""  S SNL=SNL_A_","
 I SNL'="",$E(SNL,$L(SNL))'="," S SNL=SNL_","
 D INIT^ZAA02GDEV:'$D(ZAA02G),UND^ZAA02GFORM3:$D(^ZAA02GDISP(95,ZAA02G,4))=0 S ee=$S("CCSM^MSM"[^ZAA02G("OS"):$C(0),1:$C(127))
 S sdf=$S($D(sdf):sdf,$D(^ZAA02GDISP(0,"sdf")):^("sdf"),1:"*"),xx=^ZAA02GDISP(95,ZAA02G,4) X ^(1) S:$D(snb)=0 snb=1 S %R=23,%C=1,X="X="_ZAA02GP,@X,l23=X_ZAA02G("Z")_ZAA02G("CL"),%R=24,X="X="_ZAA02GP,@X,l24=X_ZAA02G("Z")_ZAA02G("CL")
 S %R=24,%C=20,X="X="_ZAA02GP,@X,m24=l23_l24_X_"[ Edit fields - tab to bottom when done ]",%R=23,%C=70,X="X="_ZAA02GP,@X,l23E=X_ZAA02G("Z")_ZAA02G("CL")
 S %R=23 F I=1:1:3 S %C=$P("70,72,74",",",I),X="X="_ZAA02GP,@X,md(I)=X_ZAA02G("RON")_$P("T,D,M",",",I)_ZAA02G("Z")
 I $P(ZAA02Gform,";",4)="N" S (l23,l23E,l24,m24)="" F I=1:1:3 S md(I)=""
 S op="G ^ZAA02GFORM5",(eq,tsl,RX)="" F JJ=$J:.01 I '$D(^ZAA02GF(JJ,"local")) K ^ZAA02GF(JJ) Q
 X ^ZAA02G("TERM-ON"),^ZAA02G("WRAP-OFF") G ^ZAA02GFORM0
 ;
EXIT G:$D(keyr) KEYR^ZAA02GFORM0A S $P(ZAA02Gform,"~",2)=SCR_"-"_SN_"-"_eq
 K A,B,C,D,E,ECTL,I,REFRESH,RX,X,SNL,SCR,SN,W,Y,Z,l,ln,md,tab,snb,dog,cat,ep,ro,wi,sp,tx,ty,dm,xx,rf,sa,lm,mg,le,a,b,c,d,dc,dn,dp,dv,e,ed,ee,eg,eq,er,f,g,go,i,j,k,l23,l24,to,ex
 I $D(wide),JJ'["." X $P(^ZAA02G(.1,ZAA02G,7),"\",2) K wide
 K li,lp,ls,m,m24,n,nb,nv,nvl,og,oi,oiv,ols,op,opi,ov,p,r0,tlj,tsl,tss,tv,twl,v,w,wo,x0,x1,x9,xi,xt,z,^ZAA02GF(JJ),bn,ld,JJ
 X ^ZAA02G("TERM-OFF"),^ZAA02G("WRAP-ON") Q
 ;
ECTL0 S X=0 D ECTL S:eq="Q" eq="C" G BR
 ;
ECTL S ECTL=$S($D(ECTL):ECTL,$D(^ZAA02GDISP(0,"ECTL")):^("ECTL"),1:"") S:$P(ECTL,"`",1,7)?.P ECTL="Edit`Quit`Cancel`Save`Next`#`Menu`EQCSN#M`"_$P(ECTL,"`",9)
 S a=$S($P(ZAA02Gform,";",2)["N"!'nb(0):$P(ECTL,"`",2),X:$P(ECTL,"`",1)_"`"_$P(ECTL,"`",3,4),1:$P(ECTL,"`",1,2)) S:$P(ZAA02Gform,";",3)'="" a=a_"`"_$P($TR(ZAA02Gform,",","`"),";",3)
 S:$P(SNL,",",snb+1)'="" a=a_"`"_$P(ECTL,"`",5) S:$P(SNL,",",2)]"" a=a_"`"_$P(ECTL,"`",6,7)
 S X=$L(a,"`"),C=""
 W l23,l24 G:'$P(ECTL,"`",9) A0 K Y S Y=X*2+$L(a)+2\-2+40_",24\YHU"_$S(^ZAA02G("MENU"):"",1:"Q")_"\*",Y(0)=X F J=1:1:X S Y(J)=$P(a,"`",J) S:Y(J)="" Y(J)="*"
 S:a["`N" X=$L($P(a,"`N"),"`")+1_"*" I X'["*" S:a["`S" X="3*"
 S:X["*" $P(Y(0),"\",7)=+X D POP1^ZAA02GFORM4 I RX=9998 S eq="C-TIMEOUT" Q
 S eq=$E(Y(X)),%C=+Y K Y G A3:eq'="#" W @ZAA02GP,"Enter Screen #: ",ZAA02G("CL") F J=1:1 R X#(SNL?.E2N.E+1) G:X="" ECTL S eq=$S($P(ZAA02Gform,";")["#":","_SNL[(","_X_","),1:$P(SNL,",",+X)) W:'eq *7,*8 W:$L(X)=2 *8 I eq S eq=+X G A3
A0 W ZAA02G("LO"),$J("",X*2+$L(a)\-2+38),"Type" F I=1:1:X S eq=$P(a,"`",I),C=C_$E(eq) I eq'="" W $S(I=1:"",I=X:" or",1:",")," ",ZAA02G("HI"),$E(eq),ZAA02G("LO"),$E(eq,2,9)
 W " ",ZAA02G("HI")
A1 R eq#1:to I '$T S eq="C-TIMEOUT" Q
 X ZAA02G("T") I $E(xx,$F(xx,ZF))="Z" D CALC^ZAA02GFORM0 G ECTL
A2 I eq]"" W ZAA02G("L") I ^ZAA02G("MENU") R a#1 X ZAA02G("T") I ZF'=$C(13),ZF'=ZAA02G("D") S eq=a G A2:eq]"" W " ",ZAA02G("L") G A1
 S:eq?1L eq=$C($A(eq)-32) I $S(eq?1.N:$S($P(ZAA02Gform,";")["#":","_SNL'[(","_eq_","),1:$P(SNL,",",eq)="")!($P(SNL,",",2)=""),"#"[eq:1,1:C'[eq) W *7 G A1
A3 S:eq'?1.N&($P(ECTL,"`",8)[eq) eq=$E("EQCSN#M",$F($P(ECTL,"`",8),eq)-1) Q
 ;
EDIT S RX=0,I=1,ty="ty(0)",m="m(0)" X ^ZAA02GDISP(SCR,SN,.01997) W ZAA02G("LO"),m24,ZAA02G("LO") S I=$S(RX[",":$P(RX,",",2),1:1+RX) D ^ZAA02GFORM1
DONE K ln S RX=RX\1 I $P(^ZAA02GDISP(SCR,SN),"`",19)]"" X $P(^(SN),"`",19) G:'$T ED
 S eq=$S(RX=9998:"C-TIMEOUT",$P(ZAA02Gform,"~",2)["C":"C",1:"") I $E(eq)="C" W sa G EXIT
 S eq="N" I ZAA02Gform S X=1 D ECTL G EXIT:$E(eq)="C",EDIT:eq="E"
 W sa I m(0) S X="F I="_m(0)_" I $E(@e@(I))=ee S a=I Q",a=0 X X I a W *7 S I=$P(a,"."),Y=^ZAA02GDISP(SCR,SN,I),ln=$P(Y,"`",5),ert=1 D ERREP^ZAA02GFORM1 G DONE
 I ^ZAA02GDISP(SCR,SN,.01998)]"" S I=1 X ^(.01998) G:'$T ED
 S a=$P(^ZAA02GDISP(SCR,SN),"`",18) I a]"" D DONE^@a I 1
 E  X ^ZAA02GDISP(SCR,SN,.01999)
BR G EDIT:"E"=eq,MENU:"M"=eq,N:eq?1N,EXIT:eq'="N" S snb=snb+1 G ^ZAA02GFORM0:$P(SNL,",",snb)'="",EXIT
 ;
ED S ert=4,I=$S(RX[",":$P(RX,",",2),1:I),I=$S('$D(^ZAA02GDISP(SCR,SN,I)):1,I'?1.N:1,I=0:1,1:I),Y=^(I) D ERREP^ZAA02GFORM1 G DONE
N S snb=$S($P(ZAA02Gform,";")["#":$L($P(","_SNL,","_eq_","),","),1:eq) G ^ZAA02GFORM0
 ;
MENU S w=0 F i=1:1:$L(SNL,",")-($E(SNL,$L(SNL))=",") S X=$P(SNL,",",i),(X,Y(i))=$S($P(ZAA02Gform,";")["#":X_$J("",3-$L(X)),1:"")_$P(^ZAA02GDISP(SCR,X),"`",4),$P(w,0,$L(X))=""
 S Y(i+1)="*",Y(i+2)="Cancel",Y(0)=i+2,Y=ZAA02G("C")-$L(w)-5_","_(ZAA02G("R")-4-i)_"\TRY"_$S(^ZAA02G("MENU"):"",1:"Q")_"\1",$P(Y(0),"\",7)=snb D MENU^ZAA02GFORM4 I X=+Y(0) K Y S eq="Q" G EXIT
 S (snb,eq)=X K Y G ^ZAA02GFORM0
 ;
