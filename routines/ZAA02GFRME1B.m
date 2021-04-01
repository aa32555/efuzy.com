ZAA02GFRME1B ;PG&A,ZAA02G-FORM,2.62,FORMS EDITOR, PART 2 ;22SEP95 5:11P
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
SCAN F I=.59:0 D SCAN0 Q:'I  S I=I-.5
 F I=0,.01 I '$D(^ZAA02GDISP(SCR,SN,I)),$D(^(I+.0001)) S ^(I)=^(I+.0001) K ^(I+.0001)
 Q
SCAN0 S (M,T,TYP)="",G0=G,F0=F F II=1:1 S JJ=I,I=$O(^ZAA02GDISP(SCR,SN,I+.4)) Q:+I=0!(JJ+1<I)  D SCAN1 W:'$d(qt) "."
 S C=1,B="",T=T_(JJ+1),D=$P(T,","),J=JJ\100_"01" F J=+J:1:JJ S:D=J C=C+1,D=$P(T,",",C) S B=B_$C(D-J+32)
 S JJ=JJ\100,bi=0 I 'JJ S ^ZAA02GDISP(SCR,SN,.03)=B,^(.04)=TYP,$P(^(.06),"`",1)=$E(M,1,$L(M)-1)
 E  S ^ZAA02GDISP(SCR,SN,JJ,3)=B,^(4)=TYP,^(6)=$E(M,1,$L(M)-1)
 F GF="G","F" S GGFF=GF_GF,GF0=(GF="F"*.01),GF1=@(GF_0) D GF0:'JJ,GF1:JJ
 Q
 ;
SCAN1 S C=^ZAA02GDISP(SCR,SN,I),D=$P(C,"`",2),TY=0
 I $P(C,"`",11)[">" G ^ZAA02GFRME1D
 I $P(C,"`",11)?1"d"1.3N!(I\1'=I) S EE=D G SCAN2^ZAA02GFRME1C
 I $P(C,"`",21)'="" S B=$P(C,"`",21) G LIST^ZAA02GFRME1G
 I $P(C,"`",20)["K" S EE=D G SCAN2^ZAA02GFRME1C
 I $P(C,"`",20)["Y",$P(C,"`",20)'["S" S EE=D G SCAN2^ZAA02GFRME1C
 I $D(rgl) S EE=D G SCAN2^ZAA02GFRME1C
 D:'$D(A(D)) SET S EE=A(D) G SCAN2^ZAA02GFRME1C
 ;
GF0 D:@GGFF]"" @(GF_"PINC")
 Q:@GF=1  I @GF=2 S @GF=1,^ZAA02GDISP(SCR,SN,GF0)=^ZAA02GDISP(SCR,SN,.0001+GF0) K ^(.0001+GF0) F A=0:0 S A=$O(@GF@(A)) Q:'A  S:@GF@(A)=(.0001+GF0) @GF@(A)=GF0
 I @GF>1 S ^ZAA02GDISP(SCR,SN,GF0)="F a="_(GF0+.0001)_":.0001:"_(@GF-1*.0001+GF0)_" X ^ZAA02GDISP("""_SCR_""","_SN_",a)"
 Q
 ;
GF1 S X=^ZAA02GDISP(SCR,SN,@GF@(JJ))
 I @GGFF="",@GF>GF1 S @GF=@GF-1,@GGFF=^ZAA02GDISP(SCR,SN,@GF*.0001+GF0) K ^(@GF*.0001+GF0)
 S z=$S(@GF'=GF1:"GFX",$L($P(X,"F a"))+$L(@GGFF)-8+(@GGFF["~"*14)<235:"GFCONC",1:"GFX") D @z
 S ^ZAA02GDISP(SCR,SN,@GF@(JJ))=X
 Q
GFCONC S X=$P(X,"F a")_@GGFF,@GGFF="",a=$O(@GF@(JJ_"00")) I a\100=JJ S @GF@(a)=@GF@(JJ)
 Q
GFX I @GF>GF1 S X=$P(X,"~")_(GF1*.0001+GF0)_$S(GF1+1=@GF:",",1:":.0001:")_(@GF*.0001+GF0)_$P(X,"~",2,99)
 I @GF<GF1 S X=$P(X,")=~"),X=$P(X," F a(",$L(X," F a(")-1)
 I @GF=GF1 S X=$P(X," F a(")_$P(X,"~",2,99),a=$F(X,",a("),X=$E(X,1,a-3)_(GF1*.0001+GF0)_")"
 D:@GGFF]"" @(GF_"PINC") Q
 ;
BI S bi=bi+1,EE=xx I I>99 S b=EE D N S EE=b
 S EE=EE_bi_")" Q
 ;
N S a=I S:$L(a)#2 a="0"_a F n=1:1:$L(I)-1\2 S b=b_($E(a,n*2-1,n*2)*1000)_",n("_n_"),"
 Q
 ;
SET D BI S A(D)=EE S G1="S "_EE_"=$g("_D_") "
 I $L(GG)+$L(G1_EE)>235 D GPUT,GINC I 1
 S GG=GG_G1
 I $L(FF)+$L(EE_D)>235 D FPUT,FINC
 S FF=FF_"S "_D_"=$G("_EE_") "
 Q
 ;
GPINC D GPUT
GINC S GG="",G=G+1 Q
GPUT S ^ZAA02GDISP(SCR,SN,G*.0001)=GG Q
FPINC D FPUT
FINC S F=F+1,FF="" Q
FPUT S ^ZAA02GDISP(SCR,SN,F*.0001+.01)=FF Q
