ZAA02GFRME1G ;PG&A,ZAA02G-FORM,2.62,FORMS EDITOR, PART 2;9MAY95 4:20P
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
LIST S TY=TY+32 G LER:"HV"'[$P(B,","),LER:D'["(" S Z=$P(C,"`",20)
 S bls=0,(b,lref)=$S($P(B,",",7)["ls":D,1:$E(D,1,$L(D)-1)_"+ls)")
 S E=$P(B,",",4) S:+E=0 E=1 S bls=$S($D(A(D)):1,1:0)
 G:$D(rgl) L2
 D BI^ZAA02GFRME1B S b=$E(EE,1,$L(EE)-1)_"+ls)"
 S A="F ls="_bls_":1:"_($P(B,",",5)-1+bls)_" S "_b_"=$G("_lref_") Q:$O("_lref_")="""""
 I $L(A)+$L(GG)<240 S GG=$S(GG]"":GG_" "_A,1:A)
 E  D GPUT^ZAA02GFRME1B S G=G+1,GG=A
 D GPINC^ZAA02GFRME1B
L2 I $P(B,",",7)'["S",$P(B,",",7)'["K" G:$D(rgl) L1 S A="F ls="_bls_":1:"_($P(B,",",5)-1+bls) S:'$D(rgl) A=A_" S "_lref_"=$G("_b_")"
 E  D L0
 I $L(A)+$L(FF)<240 S FF=$S(FF]"":FF_" "_A,1:A)
 E  D FPUT^ZAA02GFRME1B S F=F+1,FF=A
 D FPINC^ZAA02GFRME1B ; I I<100 F J=E+bls:E:$P(B,",",5) S bi=bi+1,A($P(lref,"ls")_J_$P(lref,"ls",2))=b
L1 S bi=bi+$P(B,",",5)-bls K bls
 S E=$P(C,"`",4),B="G LIST S X="_$P(E,"X")_"$G("_b_")"_$P(E,"X",2,9),E=$P(E,"X")_b_$P(E,"X",2,9) G SCAN3^ZAA02GFRME1C
LER W:'$d(qt) !,*7,"Invalid List Parameters - Item ",$P(C,"`",14),". Press Return." R B,! G SCAN2^ZAA02GFRME1C
L0 S A="S k=0" ; I $P(B,",",8)]"" S A=A_","_$P(B,",",8,999)_"=0"
 S A=A_" F ls="_($P(B,",",5)-1+bls)_":-1:"_bls_" S:'k k=$S($G("_b_")="""":0,1:ls+1)" S:$P(B,",",7)["K" A=A_" K:'k "_lref S:'$D(rgl) A=A_" S:k "_lref_"=$G("_b_")"
 I $P(B,",",8)]"" S A=A_$S($D(rgl):" I 'ls!k",1:" I ls="_bls)_" S "_$P(B,",",8,999)_"=k"_$S($D(rgl):" Q",1:"")
 Q
