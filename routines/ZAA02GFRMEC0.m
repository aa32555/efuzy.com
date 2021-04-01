ZAA02GFRMEC0 ;PG&A,ZAA02G-FORM,2.62,;28MAR89 11:06A
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
FIELDS W:'$d(qt) ".fields." S q=q+1,^ZAA02GF($J,q)="S S e(I)=D W:X'=dc p(I),D Q",post=" D S"
 S q=q+1,^ZAA02GF($J,q)="DISP W:'$d(qt) rf S ca=""p(I)=""_ZAA02GP,gca=""p(v,I)=""_ZAA02GP,g=0,w=^ZAA02GDISP(SCR,SN,.05)]"""""
 S q=q+1,^ZAA02GF($J,q)=" K D S e=""e"",(n,n(0),g,nv,pi,v)=0"
 S s=0 F I=1:1 Q:'$D(^ZAA02GDISP(SCR,SN,I))  D F1
 I s S q=q+1,^ZAA02GF($J,q)=post
 S q=q+1,^ZAA02GF($J,q)=" Q"
 I $O(^ZAA02GDISP(SCR,SN,99)) S q=q+1,^ZAA02GF($J,q)="FIG S pi=pi+1,%R=$A(p,pi) S:%R %C=$A(cp,pi),@gca Q",q=q+1,^(q)="SG S @e@(I)=D W:X'=dc p(v,I),D Q",post=" D SG" F a=0:1 S b=$T(G+a),q=q+1,^ZAA02GF($J,q)=b Q:b=" Q"
 S s=0 F I=99:0 S I=$O(^ZAA02GDISP(SCR,SN,I)) Q:'I  D GROUP S I=g*100+99
 I list S q=q+1,^ZAA02GF($J,q)="LIST S Y=^ZAA02GDISP(SCR,SN,I),j=$P(^(I_"".2""),""`"",2)" F a=0:1:2 S b=" "_$P($T(LIST+a)," ",2,999),q=q+1,^ZAA02GF($J,q)=b
 Q
 ;
F1 S Y=^ZAA02GDISP(SCR,SN,I),a=$P(Y,"`",3),b=$P(^(I+.2),"  ;"),b=$S(b["G LIST":"D LIST",b?1"G G".E:"D G",1:b) I b[" G "!(b[" G:") W:'$d(qt) !!,SCR,"-",SN,"   FIELD ",$P(Y,"`",11)," MIGHT HAVE AN ILLEGAL 'GOTO'.  PLEASE CHECK."
 S c="" S:s c=post S c=c_" S I="_I_$S(b="D G":$S(I>99:",pi=pi+1",1:""),I>99:" D FIG",1:",%R="_(+a)_",%C="_$P(a,",",2)_",@ca")
 I b="D LIST" S list=1
 S q=q+1,^ZAA02GF($J,q)=c_" "_b
 S s=0 I b'="D LIST",b'="D G" S:$P(Y,"`",14)]"" q=q+1,^(q)=" "_$P(Y,"`",4),s=1
 W:'$d(qt) "." Q
 ;
GROUP S g=I\100,Y=^ZAA02GDISP(SCR,SN,g),fd="%"_$E($P(Y,"`",11),2,8),q=q+1,^ZAA02GF($J,q)=fd_" ;"
 S a=" S pi=pi+1,%R=$A(p,pi),%C=$A(cp,pi)",gg=$P(Y,"`",5,13)
 ; F I=+$P(gg,"`",3):1:$P($P(gg,"`",3),",",2) S q=q+1,^ZAA02GF($J,q)=a_" S I="_I_" "_$P(^ZAA02GDISP(SCR,SN,I)," ;"),q=q+1,^ZAA02GF($J,q)=" S @gca W:'$d(qt) p(v,I),D" I w S ^(q)=^(q)_" S @e@(I)=D"
 S q=q+1,^ZAA02GF($J,q)=" S v=$P(v,""."",1,n)",s=0
 F I=g_"01":1:$P(Y,"`",7) D F1
 S a=" Q" S:s a=post_a S q=q+1,^ZAA02GF($J,q)=a
 Q
 ;
GID S pi=pi+1,%R=$A(p,pi),%C=$A(cp,pi) Q
 S pi=pi+1,%R=$A(p,pi) S:%R %C=$A(cp,pi),@gca
 Q
 ;
G S Y=^ZAA02GDISP(SCR,SN,I),gn(I)="%"_$E($P(Y,"`",11),2,8)
 S g=I,n=n+1 I '$D(g(g)) S nb(g)=$P(Y,"`",4),g(g)=$P(Y,"`",5,13),tab(g)=^ZAA02GDISP(SCR,SN,g,3),ty(g)=^(4),m(g)=^(6)
 I  S:'$P(g(g),"`",2) @("$P(g(g),""`"",2)="_$P(g(g),"`",2)) S:$P(g(g),"`",8)'?.N @("$P(g(g),""`"",8)="_$P(g(g),"`",8)) I $P(g(g),"`",2)<g(g) S pi(g)=$P(Y,"`",17)_"`"_$P(g(g),"`"),$P(g(g),"`",1)=$P(g(g),"`",2)
 S e=$P(g(g),"`",9)_g_",v)" F n(n)=1:1:+g(g) S $P(v,".",n)=n(n) S:w dp(g,v)=v D @gn(g)
 I $D(pi(g)) S pi=$P(pi(g),"`",2)-g(g)*pi(g)+pi
 S I=g,g=+$E(g,1,$L(g)-2),n=n-1,Y="" I n S e=$P(g(g),"`",9)_g_",v)",v=$P(v,".",1,n)
 E  S e="e",v=0
 Q
LIST S:n li(I,v)=%R S f=$P(Y,"`",4),%R=%R-1
 S k=I F ls=0:1:$P(Y,"`",14)-1 X j,f S I=.001*ls+k,@e@(I)=D,%R=%R+1 W:X'=dc @ZAA02GP,D I w S:n @gca S:'n @ca S li(k,v,ls)=I
 S Y="",I=k Q
 ;
DISP W:'$d(qt) rf S ca="p(I)="_ZAA02GP,gca="p(v,I)="_ZAA02GP,g=0
 K D S e="e",(n,n(0),g,nv,pi,v)=0
 ;
 K ca,cp,gca,gn,lv,pi,v0,w S p="",(nb,nb(0))=^ZAA02GDISP(SCR,SN,.9),nv=($D(nv)>1)
 I ZAA02Gform<2,nb,$P(ZAA02Gform,";",2)'["N" G EDIT^ZAA02GFORM1
 G ECTL0^ZAA02GFORM:ZAA02Gform'>9,EXIT^ZAA02GFORM
