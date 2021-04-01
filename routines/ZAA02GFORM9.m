ZAA02GFORM9 ;PG&A,ZAA02G-FORM,2.62,INSERT/DELETE GROUP;31OCT95 4:08P;;;25JUL96  12:50
 ;Copyright (C) 1994, Patterson, Gray & Associates, Inc.
 ;
CTL I 'del Q:$G(@$P(g(g),"`",5))'<$P(g(g),"`",2)
 I del Q:$G(@$P(g(g),"`",5))<n(n)
 I 1 X $P(^ZAA02GDISP(SCR,SN,$P(g(g),"`",7)),"`",del=0+15) I '$T K del Q
 N Y,I
 I $G(l23)'="" W l23,ZAA02G("RON"),"Wait...",ZAA02G("Z")
 S end=$G(@$P(g(g),"`",5))
 I end>$G(@$P(g(g),"`",4)) S lp=n(n),ful=end X ^ZAA02GDISP(SCR,SN,^ZAA02GDISP(SCR,SN,g,0)) S n(n)=lp
 K I,ful S b0="n("_n_")" F I=g*100+1:1:$P(g(g),"`",3) S Y=^ZAA02GDISP(SCR,SN,I) I $P(Y,"`",11)'[">" S Y=$P(Y,"`",10),Y=$P(Y,b0)_"?"_$P(Y,b0,2) S:$E(Y)="$" Y=$P(Y,"$P(",2),Y=$P(Y,"),")_")" I $L(Y)>1 S:'$D(I(Y)) I(Y)=""
 S b0="" F J=1:1 S b0=$O(I(b0)) Q:b0=""  D @$S(del:"DELETE",1:"INSERT")
 D SAME^ZAA02GFORM8 I $d(l23) W l23
 k b0,end,f,fto,frm,s,t,I Q
 ;
E ; function key
 I @e[1 S:n(n)>$G(@$P(g(g),"`",5)) @$P(g(g),"`",5)=n(n)
 G CTL
 ;
DELETE S nil=0,frm=$P(b0,"?")_"nx"_$P(b0,"?",2),fto=$P(b0,"?")_"nx-1"_$P(b0,"?",2) F nx=n(n)+1:1:end S $P(v,".",n)=nx-1 K @fto D COPY
 S frm=$P(b0,"?")_end_$P(b0,"?",2),fto=frm,nil=1,$P(v,".",n)=nx D KILL,COPY S @$P(g(g),"`",5)=end-1 Q
 ;
INSERT S nil=0,frm=$P(b0,"?")_"nx"_$P(b0,"?",2),fto=$P(b0,"?")_"nx+1"_$P(b0,"?",2) F nx=end:-1:n(n) S $P(v,".",n)=nx K @fto D COPY
 S frm=$P(b0,"?")_n(n)_$P(b0,"?",2),fto=frm,nil=1,$P(v,".",n)=nx-1 D KILL,COPY S @$P(g(g),"`",5)=end+1 S:@$P(g(g),"`",4)'>end @$P(g(g),"`",4)=end+1 Q
 ;
COPY S f=0,f(0)=frm,t(0)=fto,s(0)="" I $D(@frm)#10 S @fto=$S(nil:"",1:@frm)
 F f=f:0 S s(f)=$O(@f(f)@(s(f))) D NODE I f<0 Q
 Q
 ;
NODE I s(f)="" S f=f-1 Q
 S a=$D(@f(f)@(s(f))) I a#10 S @t(f)@(s(f))=$S(nil:"",1:@f(f)@(s(f)))
 I a>1 S f(f+1)=$E(f(f),1,$L(f(f))-1)_",s("_f_"))",t(f+1)=$E(t(f),1,$L(t(f))-1)_",s("_f_"))",f=f+1,s(f)=""
 Q
 ;
KILL K s S s=g D K2 S g="",$P(v,".",n)=n(n),t=v,f=$P(v,".",1,n-1) F a=1:1 S g=$O(s(g)) Q:g=""  D K3
 S g=s,v=t Q
K2 S s(g)="",t="" F a=0:0 S t=$O(g(t)) Q:t=""  S:$D(s(t\100)) s(t)=""
 Q
K3 S v=$P(t_".1.1.1.1",".",1,$L(g)+1\2) F a=0:0 K @e S v=$O(@e) Q:v=""  Q:$P(v,".",1,n-1)'=f
