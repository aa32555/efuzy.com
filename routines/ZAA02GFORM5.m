ZAA02GFORM5 ;PG&A,ZAA02G-FORM,2.62,Operators;11NOV94  01:34;;;03JUN97  15:23
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
CTL S ov=v,oi=I,og=g,ols=$G(ls),sox=X,tru=$T D @$S(opi?.N:"OPN",1:"PARSE") S:$D(sox) X=sox S I=oi,v=ov,g=og,ls=ols K oi,ov,og,ols,sox I tru
 K tru,opi Q
PARSE S (I,v)=$P(opi,";",2) S:v=""&$D(^ZAA02GDISP(SCR,SN,oi)) v=$P(^(oi),"`",11)_$S(ov:"."_ov,1:"")_$S($P(^(oi),"`",2)["ls":"."_(ls+1),1:"") S I=$P(v,".") G ER1:I="",ER1:'$D(^ZAA02GDISP(SCR,SN,I)) S (iv,I)=$P(^(I),"`",14),ls="" G:I="" ER1
 I $E($P(opi,";",2))=">",v["." S I=I*100
 I I<100 S:v["." ls=$P(v,".",2)-1,iv=ls*.001+I S (g,v)=0 G PARSE1
 S g=I\100,v=$S(v'[".":"",v?.E1".":ov,1:$P(v,".",2,99)) S:v="" v=1 S:v>$P(g(g),"`",2) $P(v,".")=$P(g(g),"`",2) I $D(li(I)) S ls=+$P(v,".",$L(I)-1\2+1),v=$P(v,".",1,$L(I)-1\2) S:ls ls=ls-1,iv=ls*.001+I S:v="" v=1
PARSE1 G ER1:$E(opi)="",ER1:$T(@$E(opi))="",@$E(opi)
 ;
OPN F opn=1:1:opi S opi=opi(opn) D PARSE
 S opi=opn K opn Q
C I opi="C" S RX=1E6,$P(ZAA02Gform,"~",2)="C",ed="" Q
CL I $E(opi,2,3)="L" G CLEAR^ZAA02GFORM0A
 G:$E(opi,2,4)="ALL" CALL^ZAA02GFORM5A ; set REFRESH to control refresh
 Q
 ;
N S k="ty(g)" D FETCH S j=$A(z,d) Q:j#16<4
 S z=$E(z,1,d-1)_$C(j-$S(j#16<12:4,1:12))_$E(z,d+1,999) D PUT
 S k="m(g)" D FETCH S h=","_z_",",j=","_I_"," I h[j S z=$P(h,j)_","_$P(h,j,2),z=$E(z,2,$L(z)-1) D PUT
 Q
 ;
L S k="LOAD1^ZAA02GFORM0" ; load & display
LDX N n,X,Y,nv,nb,p,ols,I,opi,sox,ov,oi,og,tru,dv,m S dc=$C(2) D @k Q
 ;
R G:$E(opi,2)="E" REFR S mr=12 G MR ;required
M S mr=4 ;mandatory
MR S k="ty(g)" D FETCH S j=$A(z,d)#16\4*4 Q:j=mr  ;mandatory or required
 S j=mr-j,z=$E(z,1,d-1)_$C($A(z,d)+j)_$E(z,d+1,999) D PUT
 S k="m(g)" D FETCH S z=$S(","_z_","[(","_I_","):z,z="":I,1:z_","_I) D PUT
 Q
 ;
D G:$E(opi,2)="S" DS ;deactivate
A S k="ty(g)" D FETCH,A1,PUT
 G:$E(opi,2)?1U @$E(opi,2) Q
A1 S j=$S($E(opi)="A":0,1:128) f d=$S('d:1,1:d):1:$S('d:$L(z),1:d) S z=$E(z,1,d-1)_$C($A(z,d)\256*256+($A(z,d)#128)+j)_$E(z,d+1,999)
 Q
 ;
FETCH I $P(opi,";",2)[".",v'=0 S d=k,k=$P(k,"g")_"g,v)" S:'$D(@k) @k=@d
 s z=$G(@k),d=I#100 Q
 ;
PUT I k[",",z=@($P(k,",")_")") K @k S k=$P(k,",")_")" S @k=z S @$P(k,"(")=k Q
 S @k=z I k[",",g,og=g,v=ov S @$P(k,"(")=k Q
 I g,k'[",",$O(@k@("")) S k=$E(k,1,$l(k)-1)_",v)" F v=0:0 S v=$O(@k) Q:v=""  S z=@k D A1 S @k=z
 Q
 ;
B G:$E(opi,2)="L" BL S RX=99_","_$S(g:g_","_I_","_v_","_ls,1:I) Q
BL 
 ;
F G:$E(opi,1,2)="FC" FC I g N n D GET
 K:$P(opi,";",3,99)="X" sox G @("F"_$E(opi,2)) ;fetch
FD X "S "_$P(opi,";",3,99)_"=$P($G(@e@(iv)),ee,$P(^ZAA02GDISP(SCR,SN,$P(^ZAA02GDISP(SCR,SN,I),""`"",11)),""`"",20)[""Y""+1)" Q  ;fetch displayed value
 Q
FS S c=$P(^ZAA02GDISP(SCR,SN,I),"`",10) I $E(c)="$" S k=$L($E(c,1,5),"$"),c=$P($P(c,"(",k,9),")",1,$L(c,")")-k)_")" S:c=")" c=$P($P($P(^(I),"`",10),"(",k,9),",")
 S @($P(opi,";",3,99)_"="_$S($D(@c):$P(^ZAA02GDISP(SCR,SN,I),"`",10),1:"""""")) Q
FT X $P(^ZAA02GDISP(SCR,SN,$P($P(opi,";",2),".")),"`",10)_" S "_$P(opi,";",3,99)_"=X" Q  ; fetch transform
 ;
I S @($P(opi,";",3,99))=$S($P(opi,";",2)?.N:$P(^ZAA02GDISP(SCR,SN,I),"`",11),1:I) Q
 ;
CALCN F n=1:1:$L(I)-1\2 S n(n)=+$P(v,".",n)
 Q
 ;
DV S (c,a)=0 I 'g G:$D(li(I)) DV0LS W p(0,I),@e@(iv) Q
 S c="" f  s c=$o(dp(g,c)) q:c=""  I dp(g,c)=v S a=c Q
 Q:'$T  I '$D(li(I)) W:$D(p(a,I)) p(a,I),@e@(I) Q
DV0LS I $D(li(I,a,0)) S c=ls*.001+I-li(I,a,0)*100 I c'<0,$D(li(I,a,c)) W p(a,.001*c+I),@e@(iv)
 Q
 ;
S G @("S"_$E(opi,2))
SC D DV S z=$P($S(ZAA02G["MSMPC COLOR":"44,41,42,43,46,45,40,47",ZAA02G["DTMPC COLOR":"31,79,47,111,63,95,15,113",1:""),",",$P(opi,";",3,99)) S:z="" z=$P(opi,";",3,99) Q:z=""
 S p=$S($D(li(I)):"p(a,.001*c+I)",1:"p(a,I)") I $D(@p) S:ZAA02G["MSM" @p=$C(27)_$P(@p,$C(27),2)_$C(27)_"["_z_"m" S:ZAA02G["DTM" @p=$C(255)_$P(@p,$C(255),2)_$C(255,66,z) D DV
 Q
 ;
P G:$E(opi,1,2)="PC" PC N D I g N n D GET I $G(@$P(g(g),"`",5))<n(n) S @$P(g(g),"`",5)=n(n)
 S @("X="_$P(opi,";",3,99))
 I ^ZAA02GDISP(SCR,SN,I_.2)["LIST",$P($P(^(I_.2),"`",3),",",6)["W",$L(X)>$P(^(I),"`",5) G P1
P0 G @("P"_$E(opi,2)) ;put
P1 N l,m,% S %=X,l=$P(^(I),"`",5) F ls=ls:1 Q:$L(%)'>l  S m=$F(%," ",l) S:'m m=$L(%)+2 S:$E(%,m)=" " m=$F(%_1,$E($TR($E(%,m,255)_1," ","")),m)-1 S X=$E(%,1,m-1),%=$E(%,m,255) D P0
 S X=% G P0
 ;
PD X $P(^ZAA02GDISP(SCR,SN,I),"`",4) S @e@(iv)=D,$P(@e,2,iv#100)=$E(D)'=ee ; put display
 I og=g,ov=v,oi=I,ols=ls S sox=$P(D,ee)
 I $E($P(opi,";"),3,4)["P" W ZAA02G("Z"),rf D DV W ZAA02G("Z"),ro
 Q:$E($P(opi,";"),3,4)'["S"  ;fall to PS
 ;
PS D:$P(opi,";")["T" PT ;put store value
 I $D(ZAA02G("NOPUT")),$P(^ZAA02GDISP(SCR,SN,I),"`",10)'["$P($P" S @($P(^(I),"`",10)_"=X") Q
 N opn,tru,opi,oi,ov,og,ols,sox X $P(^ZAA02GDISP(SCR,SN,I),"`",2) Q  ;note PUT always run on $P($P
 ;
GET D CALCN I $G(@$P(g(g),"`",4))<n(n)!ls N lp,ls S lp=n(n) D ^ZAA02GFORM8A,CALCN
 Q
 ;
PT X $P(^ZAA02GDISP(SCR,SN,$P(^ZAA02GDISP(SCR,SN,I),"`",11)),"`",10) Q
 ; X $P(^ZAA02GDISP(SCR,SN,$P($P(opi,";",2),".")),"`",15)_" S "_$P(opi,";",3,99)_"=X" Q
 ;
PC D GETCOUNT Q
FC D GETCOUNT Q
 ;
GETCOUNT B  Q
 Q
 ;
V X "S X="_$P(opi,";",3,99) I 1 X $P(^ZAA02GDISP(SCR,SN,I),"`",16) S @$P(opi,";",4)=$T       Q
 Q
 ;
X X "N opi,opn,t "_$P(opi,";",3,99) Q  ;eXecute
 ;
ER1 Q:$G(^ZAA02GDISP(0,"DEBUG"))'=1  W l24,"Invalid field name used in an operator - ",I R I Q
GC ;group count
GR ;remove a group
GI ;insert a group
REFR D AP0^ZAA02GFORM4 Q
DS S k="DISP^ZAA02GFORM0" G LDX
 ;
