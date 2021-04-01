ZAA02GFRME1E ;PG&A,ZAA02G-FORM,2.62,FORMS EDITOR;28SEP94  22:34
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
BEG K D,Y,A S (p,col)="",(n,n(0),home,rd)=0,v="",WI=^ZAA02GDISP(SCR,SN,.05) I WI]"" F %R=1:1:ZAA02G("R") S WI(%R)=$P(WI,"\",%R+1)
 S:WI]"" WI=1
 S e=$S($P(^ZAA02GDISP(SCR,SN),"`",14)="Y":"^ZAA02GF(JJ,",1:"e(")
 S A=">" F I=0:0 S A=$O(^ZAA02GDISP(SCR,SN,A)) Q:A'[">"  S I=$P(^(A),"`",14) I I,I<100 S A(I)=A
 S A="" F I=1:1 S A=$O(A(A)) Q:A=""  S (I,v)=A,Y=^(I) D G
 S ^ZAA02GDISP(SCR,SN,.09)=p,^(.0901)=col
 I WI]"" D WINDOW
 K WI,col,n,n(0),home,gdo,g,p,pi,rd,rmax,v,Y Q
 ;
G S g=I,n=n+1,Y(n)=Y,rd=$P(Y(n),"`",2)_"+"_rd,home="0+"_home,pi(g)=$L(p)
 F n(n)=1:1:+$P(Y(n),"`",5) S:n(n)>1 home=(home+rd)_"+"_$P(home,"+",2,99) S $P(v,".",n+1)=n(n) D SWPFD
 S I=g,g=$E(g,1,$L(g)-2),n=n-1,home=$P(home,"+",2,99),rd=$P(rd,"+",2,99),v=$P(v,".",1,n+1)
 Q
 ;
SWPFD F I=g_"01":1:$P(Y(n),"`",7) S $P(v,".",1)=I D GI
 I n(n)=1 S $P(^ZAA02GDISP(SCR,SN,g),"`",17)=$L(p)-pi(g)
 Q
 ;
GI S Y=^(I),B=$P(Y,"`",3),%C=$P(B,",",2),@("%R="_home_"+B"),B=$S($P(Y,"`",11)[">":0,1:%R) S:B p=p_$C(B),col=col_$C(%C) D GWI:WI&B,G:'B
 Q
 ;
GWI I $P(Y,"`",13)="" S WI(%R)=WI(%R)_v_"," Q
 F ls=1:1:$P(Y,"`",14) S $P(v,".",n+2)=ls,WI(%R)=WI(%R)_v_",",%R=%R+1
 S v=$P(v,".",1,n+1)
 Q
 ;
 ; 
 ;
WINDOW S (rmax,WI)="" F %R=1:1:ZAA02G("R") D CW:'$d(qt) W:'$d(qt) "."
 Q
 ;
CW S w0=1,w1(1)="",(dy0,dy)=0
 F II=1:1 S v=$P(WI(%R),",",II) Q:v=""  D PW0
 I w1(1)]"" F ii=1:1:w0 I ii<w0 S w1(ii)=w1(ii)_" X "_$S(w1(ii)["ZAA02GF":"^ZAA02GDISPL("""_SCR_"-"_SN_""",0,ZAA02G,",1:"^(")_(ii*.1+.2+%R)_")"
 S os=^ZAA02G("OS"),a="" F b=1:1 S a=$O(^ZAA02GDISPL(SCR_"-"_SN,0,a)) Q:a=""  D PUTW
 K dy,os,w0,w1,wop
 Q
 ;
PW0 s wop="" I v<100 S:v'["." (a,b)=v S:v["." ls=$P(v,".",2)-1,I=v\1,a=ls*.001+I,b="li("_I_",0,"_ls_")" S dy=0,w1="p(0,"_a_"),"_e_"0,0,"_b_")" G PW1
 S (a,I)=v\1,g=I\100,dy=($P(^ZAA02GDISP(SCR,SN,g),"`",6)'?1.N)
 S v=$P(v,".",2,99),ls=""
 I $L(v,".")>($L(I)-1\2) S ls=$P(v,".",$L(v,"."))-1,v=$P(v,".",1,$L(v,".")-1) S:$L(v,".")>2 v=$C(34)_v_$C(34) S a="li("_I_","_v_","_ls_")",I=ls*.001+I
 I v'[$C(34),$L(v,".")>2 S v=$C(34)_v_$C(34)
 S w1="p("_v_","_I_")" S:dy wop="W:$D("_w1_")" S w1=w1_","_e_g_",dp("_g_","_v_"),"_a_")"
 ;
PW1 I $L(w1(w0))+30+$L(w1_wop)>255 S w0=w0+1,w1(w0)="",dy0=0
 I 'dy S wop=$S(dy0:" W:'$d(qt) ",w1(w0)="":"W:'$d(qt) ",1:",")
 E  S:w1(w0)]"" wop=" "_wop S wop=wop_" "
 S w1(w0)=w1(w0)_wop_w1,dy0=dy
 Q
 ;
PUTW F c=1:1:w0 S ^ZAA02GDISPL(SCR_"-"_SN,0,a,c*.1+.1+%R)=w1(c) ; X:os="DTM" "S ^(c*.1+.1+%R)=$ZXECUTE(w1(c))"
 Q
