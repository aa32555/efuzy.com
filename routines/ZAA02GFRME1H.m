ZAA02GFRME1H ;PG&A,ZAA02G-FORM,2.62,FORMS EDITOR, PART 2;18OCT94  02:00;;;08MAY96  19:35
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
TABLE S TY=TY+1,tp=$P($P(C,"`",25),"\"),a=$P(C,"`",12),tol=+a,tot="",(tref,tlkup)=$P(C,"`",9) I a'=tol S tot=$S(a?1.2N1"\".E:$P(a,"\",2,999),a?1.2N1",".E:$P(a,",",2,999),1:"")
 S a="",t0="X" S:tol tol=tol-A-1 S:tp'["H" a="P" S:tp["K" a=a_"K" S:tp["E" a=a_"E" S:tp["F" a=a_"F" S:tp["N" a=a_"N" S:tp["D" a=a_"D" S:tp["V" a=a_"V"
 S $P(^ZAA02GDISP(SCR,SN,I),"`",12)=tol*(tp'["H")_a
 S t1=$P($P(C,"`",25),"\",2,9)
 S tlkup=$S(tlkup'["(":tlkup,tlkup["@(X)":$P(tlkup,"@(X)"),tlkup["(X)":$P(tlkup,"("),1:$P(tlkup,",X)")_")"_$P(tlkup,",X)",2,9))
 S tt=$S(tp[1:1,tp[2:2,tp[3:3,1:0) D @("T"_tt)
 S tv=$S($P(C,"`",16)="":"G:X]"""" "_$S(tp["K":"KW",1:"KW:'$D("_tref_")"),tp["V":"G T1V",1:"G TV1")
 S $P(^ZAA02GDISP(SCR,SN,I),"`",16)=tv I $P(C,"`",16)]"" S $P(^(I),"`",17)=$P(C,"`",16)
 S a=$P(C,"`",23) S:a="" a="\RCL\1" S $P(a,"\",2)=$TR($P(a,"\",2),"SV","")_$S(tp["M":"V",1:"S")
 S a=a_"`"_tlkup_"`"_t0_"``"_tt_" "_tp I a["""\""" F tp=1:1 s a=$P(a,"""\""")_"$C(92)"_$P(a,"""\""",2,99) Q:a'["""\"""
 S ^ZAA02GDISP(SCR,SN,I_".1")=a K t0,t1,tol,tot,tp,tref,tt,tv,a,tlkup
 Q
 ;
T0 S B=$S(A["P":"sp",tp["F":"$S($E(X)=sdf:$E(X,2,99),1:X)_sp",1:"X_sp")
 S B="S D="_$S(A'?1.N1","1.N.E!($P(A,",",2)>A):"$E("_B_",1,$L(X)<"_+A_"+"_+A_")",1:"$S(X="""":$E(sp,1,"_(tp'["H"*tol+A+1)_"),1:$J(X,"_(+A)_","_$P(A,",",2)_"))")
 S:t1]"" t0=t1,tp=tp_"M" Q:'tol
 S E=$S(tot]"":tot,1:tref) I tp'["H" D TT
 S a=$P($P(C,"`",23),"\",7) S:'a a=+A S t0=t0_"_$J("""","_(a+1)_"-$L(X))_"_E
 Q
 ;
T1 S $P(^ZAA02GDISP(SCR,SN,I),"`",18)=$S(tp["0":tt_".0",1:tt),tref=$P(C,"`",17)
 ; S tv=$S($P(C,"`",16)="":"G:X]"""" T1V",tp["V":"G:X]"""" T1V",1:"G TV1")
 I tp[0 S $P(^(I),"`",20)=tref
 S:t1="" t1=tref
 S B=$S(A["P":"""",tp["F":"$S(X="""":"""",$E(X)=sdf:$E(X,2,99),1:"_t1_")",tp["D":"$S(X="""":"""",$D("_tref_")#2:"_t1_",1:"""")",1:"$S(X="""":"""",1:"_t1_")")
 S B="S D="_B_",D="_$S(A'?1.N1","1.N.E:"$E(D_sp,1,$L(D)<"_+A_"+"_+A_")",1:"$S(D="""":$E(sp,1,"_(A+1)_"),1:$J("_t1_","_$P(A,",",1,2)_"))")
 S a=$L(t1,"X"),t0=$P(t1,"X",1,a-1)_"S2"_$P(t1,"X",a) Q:tot=""  I tp'["H" S E=tot
 S t0="$E("_t0_"_$J("""","_(A+1)_"),1,"_(A+2)_")_"_tot
 Q
T3 ;
T2 D T1 S a=$P(C,"`",9) I a'["X)" W:'$d(qt) !,*7,"Field ",I," = ",$P(C,"`",11)," has a table lookup reference that is not in ",!,"the format ^GLOBAL(s0,s1,...,X) so it will not work correctly on table lookups!",*7
 Q
 ;
TT I tp["D"!(tp["F") S a=$S(tp["L":"$S(X="""":"""",$D("_tref_")#2:"_E_",1:"""")",1:"$S(X="""":"""",$D("_tref_")#2:$E("_E_",1,"_tol_"),1:"""")")
 E  S a=$S(tp["L":"$S(X="""":"""",1:"_E_")",1:"$S(X="""":"""",1:$E("_E_",1,"_tol_"))")
 S B=B_"_ee"_$S(tp["L":"_$E("_a_"_$J("""","_(tol+1)_"),1,"_(tol+1)_")",1:"_$J("_a_","_(tol+1)_")")
 Q
 ;
