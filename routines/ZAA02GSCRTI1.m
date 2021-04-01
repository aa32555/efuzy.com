ZAA02GSCRTI1 ;PG&A,ZAA02G-SCRIPT,2.10,TIFF PRINT;3JAN96 5:26P;;;28MAR2007  15:37
 ;
 Q
 ;
P ; TEST PRINTOUT
 K TDV R "Device-",VDV,! Q:VDV=""  I $D(^ZAA02G("GETPRINTER")) X ^("GETPRINTER")
 R "Image? (All)-",IM,!
 I ^ZAA02G("OS")="M3" O "PRINTER":(:VDV) U "PRINTER" S VDV="PRINTER"
 I ^ZAA02G("OS")="MSM" O VDV U VDV I ^ZAA02G("OS")="MSM" U VDV:(::::4096)
 S NM="" F I=1:1 S NM=$O(^ZAA02GSCR("SIGN",NM)) Q:NM=""  I IM=""!(NM=IM),NM'="eS" W:I=7 # S:I=7 I=0 W !!!,NM,!!,*27,"*t300R",*27,"*r1A" S A="" F  S A=$O(^ZAA02GSCR("SIGN",NM,A)) W:A="" *27,"*rB" Q:A=""  W *27,^(A)
 W # C VDV Q
 ;
T(NM) N A W *27,"*t300R",*27,"*r1A" S A="" F  S A=$O(^ZAA02GSCR("SIGN",NM,A)) Q:A=""  W *27,^(A)
 W *27,"*rB" Q
TR(NM) Q:+$G(DVP)'=4  I NM'="eS" I $D(^ZAA02GSCR("SIGN",NM))  W *27,"&f0S" D T(NM) W *27,"&f1S"
 W "   " G SIGN
ST(NM) N A W *27,"*t300R",*27,"*r1A" S A="" F  S A=$O(^SIGN(NM,A)) Q:A=""  W *27,^(A)
 W *27,"*rB" Q         ;
ESN(x,T) ;  doctors name,  es stamp,  date and time
 N y S y=$P(x,"*") W $S(y="":"",$D(@ZAA02GSCR@("PROV",y)):$P(^(y),"\",3),1:"??")
 W "   ",$G(XU) D TR("eS") W $G(XD)
 W $S(x="":"",x'["*":"",1:"     A: "_$$DTXY($TR($P(x,"*",2),"-",","))) Q
 ;
ESMEI ;  simple message with ES graphic & initials
 S x="" I '$G(@VDOC@("DOC")) S T="" D ESMei S:x]"" T="Electronically Signed - "_x Q
 N DOC,A,J S DOC=@VDOC@("DOC") D ESMei Q:x=""
 D TR("eS") W $G(XD),"     Electronically Signed - ",x Q
ESMei Q:$E($G(@ZAA02GSCR@("TRANS",DOC,.011,"eS")))'="S"
 S y=$p(^("eS"),"\",2),x=$p(y,"*") Q:x=""
 I $P($G(@ZAA02GSCR@("PROV",x)),"\",12)]"",$D(@VDOC@("DOC")) D
 . S A=$P(@ZAA02GSCR@("PROV",x),"\",12) D T(A)
 S x=$S($D(@ZAA02GSCR@("PROV",x)):$P(^(x),"\",3),$D(^PVG(x)):$P(^(x),":",3),1:"??")
 Q:$D(NODATE)  s x=x_"  "_$$DTXY($TR($P(y,"*",2),"-",",")) Q
 ;
ESMES(T) ;  simple message with ES graphic
 Q:'$G(@VDOC@("DOC"))  N DOC,A,J S DOC=@VDOC@("DOC")
 Q:$E($G(@ZAA02GSCR@("TRANS",DOC,.011,"eS")))'="S"
 D TR("eS") W !?4,"Electronically Signed" Q
 ;
ESM(T,N) ;  multiple date and times up to string limit
 Q:'$G(@VDOC@("DOC"))  N DOC S DOC=@VDOC@("DOC")
 S:'$D(N) N=0 W $$ESY(T,N),! Q
ESY(T,N) N A,J S A="" F J=.0172:.0001 Q:'$D(@ZAA02GSCR@("TRANS",DOC,J))  I $E($G(^(J,.011,"eS")))="S" S A=$$DT($TR($P(^("eS"),"*",2+$G(N)),"-",","))_"  "_A
 Q:$E($G(@ZAA02GSCR@("TRANS",DOC,.011,"eS")))'="S" "" S A=$$DTXY($TR($P(^("eS"),"*",2+$G(N)),"-",","))_" "_A
 S A="Electronically Signed - "_A S:$L(A)>T A="ES - "_$P(A," - ",2) Q A
 ;
ESX(T) N A,J S A="" F J=.0172:.0001 Q:'$D(@ZAA02GSCR@("TRANS",DOC,J))  I $E($G(^(J,.011,"eS")))="S" S A="A: "_$$DT($TR($P(^("eS"),"*",2),"-",","))_"  "_A
 Q:$E($G(@ZAA02GSCR@("TRANS",DOC,.011,"eS")))'="S" "" S A="A: "_$$DTXY($TR($P(^("eS"),"*",2),"-",","))_" "_A
 S A="Electronically Signed - "_A S:$L(A)>T A=$E(A,1,T),A=$P(A," A:",1,$L(A,"  A:")) Q A
ESY2() N T D DR^ZAA02GSCRCHM Q "     "_T
ESW() N T D DRI^ZAA02GSCRCHM Q "     "_T_"/"_$G(INP("TR"))_"    D: "_$G(INP("DD"))_"    T: "_$G(INP("DT"))
 ;
DT(x) I x<1 Q ""
 S K=x>21608+305+x,y=4*K+3\1461,D=K*4+3-(1461*y)+4\4,m=5*D-3\153,D=5*D-3-(153*m)+5\5,m=m+2,y=m\12+y+140,m=m#12+1,D=y*100+m*100+D,K=$E(D,4,5)_"/"_$E(D,6,7)_"/"_$E(D,2,3) K x,m,y Q K
DTX(x) Q $S(x=0:"",1:x\3600_":"_$E(x#3600\60+100,2,3)_" ")
DTXY(x) Q $$DT(x)_" "_$$DTX(+$P(x,",",2))
 ;
TEST S ZAA02GSCR="^ZAA02GSCR3" D ESN("135*57117-77900",4) Q
 ;
SIGN W *27,"&f0S",*27,"*t300R",*27,"*r1A" N L,M F A=1:1 S J=$P($T(DATA+A),";",2,99) Q:J=""  S L="" D  W *27,L
 . F M=1:2:$L(J) S L=L_$C($A(J,M)-32*64+$A(J,M+1)-32)
 W *27,"*rB",*27,"&f1S" Q
DATA ;
 ; J!B R!M Q R!7   /#]#_ &"    /#_#_#X  
 ; J!B R!M Q S!7   _#^   ' !"   #\     8  
 ; J!B R!M Q S!7  !P#^   ' !"  '"      8  
 ; J!B R!M Q S!7  !@#^   ' !"  >   _#_#X  
 ; J!B R!M Q R!7 !#@ !#^#_ #"  X !#@#^  
 ; J!B R!M Q R!7 "#@ #" #^   "!P #" #^  
 ; J!B R!M Q Q!7 "#@ #" #^   !#@ '#]  
 ; J!B R!M Q Q!7 "#@ #" #^   !#@ '#]  
 ; J!B R!M Q R!7 "#@ #" #^   "#@ ## #^  
 ; J!B R!M Q R!7 "#@ #" #^   "#@  #X#^  
 ; J!B R!M Q R!7 "#@ #" #^   "#@   ?#^  
 ; J!B R!M Q S!7 "#@ #" #^   %!P   ##P    
 ; J!B R!M Q S!7 +#@ !#_#_#X   X     ^    
 ; J!B R!M Q S!7  #@#^   ' X   >     ##@  
 ; J!B R!M Q S!7  #@#^   ' X   ##     !X  
 ; J!B R!M Q S!7 +#@ !#_#_#X    #X     >  
 ; J!B R!M Q R!7 "#@ #" #]   $ ?     '" 
 ; J!B R!M Q R!7 "#@ #" #]   $ ##P   #" 
 ; J!B R!M Q Q!7 "#@ #" #\   # ^   !# 
 ; J!B R!M Q Q!7 "#@ #" #\   # '#   # 
 ; J!B R!M Q P!7 "#@ #" #[   "#@  # 
 ; J!B R!M Q P!7 "#@ #" #[   "!P  # 
 ; J!B R!M Q P!7 "#@ #" #[   " P !# 
 ; J!B R!M Q P!7 "#@ #" #[   "!P !# 
 ; J!B R!M Q P!7 "#@ #" #[   "#P #" 
 ; J!B R!M Q S!7 !#@ !#^#_ &#      ##  '  
 ; J!B R!M Q S!7  !@#^   ' !#  _#_#_   >  
 ; J!B R!M Q S!7  !P#^   " !#  P#^   !!X  
 ; J!B R!M Q S!7   ^#^   ' !#  X     /#   
 ; J!B R!M Q R!7   '#]#_ &#  ?#_#_#\    
 ; J!B R!M R!7#U  
