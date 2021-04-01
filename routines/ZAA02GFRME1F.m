ZAA02GFRME1F ;PG&A,ZAA02G-FORM,2.62,FORMS EDITOR;13OCT94 9:51A
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
CTL F g=0:0 S g=$O(nv(g)) Q:g=""  S ^ZAA02GDISP(SCR,SN,g,0)=G(g)
 Q
 ;
 ;
ERASE K sp S a=$P(^ZAA02GDISP(SCR,SN),"`",10),a=$S(a[".":".",a["_":"_",1:" "),$P(sp,a,132)=""
 S ZAA02G1="" F %=0:0 S ZAA02G1=$O(^ZAA02GDISPL(SCR_"-"_SN,0,ZAA02G1)) Q:ZAA02G1=""  D:$D(^ZAA02G(0,ZAA02G1)) DISP
 Q
 ;
CONC S @ca,x=p_$E(sp,1,a) I ZAA02G1="VT220",sp[" " s x=p_$C(27)_"["_(+a)_"X"
 I $L(s(s))+$L(x)<254 S s(s)=s(s)_x
 E  S s=s+1,s(s)=x
 Q
 ;
DISP W:'$d(qt) "." I $D(^ZAA02GDISP(SCR,SN,.09)) S p0=^(.09),cp=^(.0901)
 S s=0,s(s)="",ca="p="_^ZAA02G(0,ZAA02G1,"P"),g=0 K D S (n,n(0),g,nv,pi,v)=0
 F I=1:1 Q:$D(^ZAA02GDISP(SCR,SN,I))=0  S Y=^(I),B=$P(Y,"`",3),%R=+B,%C=$P(B,",",2) D @$S($P(Y,"`",11)[">":"G",$P(Y,"`",13)]"":"LIST",1:"FIELD")
 F i=0:1:s S ^ZAA02GDISPL(SCR_"-"_SN,0,ZAA02G1,100+i)=s(i)
 F i=i+101:1 Q:'$D(^(i))  K ^(i)
 Q
 ;
FIELD Q:$P(Y,"`",5)["K"  S a=$P(Y,"`",12),a=$S(a:a+1,1:+$P(Y,"`",5)) D CONC Q
 ;
LIST D FIELD
 S k=I F ls=1:1:$P(Y,"`",14)-1 S I=.001*ls+k,%R=%R+1 D CONC
 S I=I\1
 Q
 ;
GI S $P(v,".",n)=n(n)
 S v=$P(v,".",1,n) F I=g_"01":1:nb(g) S Y=^ZAA02GDISP(SCR,SN,I) S:$P(Y,"`",11)'[">" pi=pi+1,%R=$A(p0,pi),%C=$A(cp,pi),@ca D @$S($P(Y,"`",11)[">":"G",$P(Y,"`",13)]"":"LIST",1:"FIELD")
 Q
 ;
G S g=I,n=n+1 I '$D(g(g)) S nb(g)=$P(Y,"`",7),g(g)=$P(Y,"`",5,13)
 F n(n)=1:1:+g(g) D GI
 S I=g,g=+$E(g,1,$L(g)-2),n=n-1,Y="" I n S v=$P(v,".",1,n)
 E  S v=0
 Q
 ;
