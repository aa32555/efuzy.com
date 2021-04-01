ZAA02GFRME1D ;PG&A,ZAA02G-FORM,2.62,FORMS EDITOR, PART 2;21NOV95 4:46P;;;01AUG96  17:52
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;from 1 row0`2 rown`3 row,column`4 last column`5 Display#`6 max#`7 tab stop`8 existence test`9 put group cnt`10 dense`11 group id`12 #mandatory`13 Local`14 order#`15 pre-remove`16 pre-ins`17 put $p
 ;to 1 existence test`2 #rows`3 row,column`4 last field#`5 display#`6 max #`7 max fd# display only;8 load ref;9 cnt ref`10 dense flag`11 id`12 #mandatory`13 load count`14 "G G"`15 pre-remove`16 pre-ins
 ;
G S Y=^ZAA02GDISP(SCR,SN,I) D:GG]"" GPINC^ZAA02GFRME1B D:FF]"" FPINC^ZAA02GFRME1B
 S CC=$P(Y,"`",8)_" ;`"_($P(Y,"`",2)-Y+1)_"`"_$P(Y,"`",3)_"`"_$P(Y,"`",23)_"`"_$P(Y,"`",5,6)_"`"_$P(Y,"`",20)_"```"_$S($P(Y,"`",10)="":"","yY"[$P(Y,"`",10):1,1:"")_"`"_$P(Y,"`",11,12)
 S $P(^(I+.2),"`",1)="G G ;",$P(CC,"`",19)="GO"
 S TYP=TYP_$C($P(Y,"`",23)=""*128+64) S:$P(Y,"`",7)="Y" T=T_I_","
 S gi=$L(I)-1\2+1,nve=$P(Y,"`",8),nvp=$P(Y,"`",9)
 S nv(I)=gi,nv=I,I=I_"00" D BI^ZAA02GFRME1B S bi=bi-1,I=nv,nv=$P(b,",",1,$L(b,",")-2)_")"
 I nvp]"" I $P(Y,"`",17)]"" S B=$P(Y,"`",17),nvp=$P(B,"X")_nvp_$P(B,"X",2,9)
 S $P(CC,"`",8)="ld("_$P(nv,xx,2) I $D(rgl),nvp]"" S nv=nvp
 S $P(CC,"`",9)=nv,^ZAA02GDISP(SCR,SN,I)=CC
 ;
 S B="F a("_gi_")=~ X ^ZAA02GDISP("""_SCR_""","_SN_",a("_gi_"))"
 S A="S nvl=+$G("_$P(CC,"`",8)_"),nv=+$G("_nv_")",C="F n("_gi_")=1:1:$S(nvl<nv:nvl,1:nv)"
 S:nvp]""&'$D(rgl) A=A_","_nvp_"=nv" S C=A_" "_C_" "_B,GF="F",GGFF="FF" D GGF
 ;
 S C=B,A="S nvl=$G("_$P(CC,"`",8)_")",gd=$P(Y,"`",gi>1+5)
 S B=",(nvp,"_$P(CC,"`",8)_")=$S("_$S(gi=1:"$G(ful):ful,",1:"")_$S(nvp]"":"nv<"_gd_":nv,",1:"")_"1:"_gd_") F n("_gi_")=nvl+1:1:nvp"
 I nvp]"" S A=A_",(nv,"_nv_")="_$S('$D(rgl):"$S(nvl:"_nv_",1:$G("_nvp_"))",1:"$G("_nvp_")")
 I nve]"" S C="X ^ZAA02GDISP("""_SCR_""","_SN_","_I_") Q:'$T  S:$G("_nv_")<n("_gi_") "_nv_"=n("_gi_") "_C
 I nvp_nve="" S A=A_","_nv_"="_$P(CC,"`",6)
 S C=A_B_" "_C
 S GF="G",GGFF="GG" D GGF
 W:'$d(qt) "." K gd,gi,CC,nvp Q
GGF I @GGFF=""!($L(@GGFF)+$L(C)<235) S @GGFF=@GGFF_C_" "
 E  D @(GF_"PINC^ZAA02GFRME1B") S @GGFF=C
 S @GF@(I)=@GF*.0001+(GF="F"*.01) D @(GF_"PINC^ZAA02GFRME1B")
 Q
 ;
