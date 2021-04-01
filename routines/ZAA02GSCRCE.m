ZAA02GSCRCE ;PG&A,ZAA02G-SCRIPT,2.10,GLOSSARY CHANGE EVERY;2JAN95 4:50P;;;21APR97  17:10
 ;Copyright (C) 1991, Patterson, Gray & Associates, Inc.
MCHANGE I $L(B)+CC>RM S NNB=SB_","_OW,REFO(.01)=SB,(OCC,OW)=1 Q
 S EE=$E(XX,$F(XX,ZF)) Q:"R"[EE
 W rm I B'="" S CC=CC+$L(B),%=$E(%,1,W)_B_$E(%,W+1,255),B=""
 D ST^@WPR S:$G(NNB)]"" NNB=$E($P($G(^(+NNB)),XF,4),$P(NNB,",",2),255)_" " S EE=$G(NNB)_$E(%,OW,CC-OCC+OW-1) D MC1,END
 S %R=CR,%C=CC+LM+1,%=$P(^(SB),XF,4) W @ZAA02GP Q
 ;
MC1 N U,N,B,C,A,CR S CR=30
 S UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ",LC="abcdefghijklmnopqrstuvwxyz",UU="*"_UU,L=$TR(UU,UP,LC),U=$TR(UU,LC,UP)
 S V=0,N=.03,I=$O(@ZAA02GWPD@(N)),LE=-N ; W *13,L,!,EE  R CCC
CH5 S:N=BOT V=0 S N=$O(^(N)) Q:N=""  S A=$P(^(N),XF,4),C=$C(1) S:N=TOP V=1 S:V V=V+1
 I A="" S LE=-N G CH5
 G:$TR(A,UP,LC)[L=0 CH5 I A[L S G=$E(A,1,$L($P(A,L))) F I=2:1:$L(A,L) S C=$P(A,L,I),G=G_EE_C
 I A[U S G=$E(A,1,$L($P(A,U))) F I=2:1:$L(A,U) S C=$P(A,U,I),G=G_$TR(EE,LC,UP)_C
 I C=$C(1) G CH5
 S A=$L(G,XS)-1*XSL,$P(^(N),XF,4)=G I $L(G)>(MG+A) S:'$D(REFO(LE)) REFO(LE)=N G CH5
 ; G:$S('$D(LE):0,1:$D(REFO(LE))) CH5 S REFO(LE)=N G CH5
 I V S %R=TL+V-2,%C=LM+2 W @ZAA02GP,G,XCL
 G CH5
END D:$D(REFO) REFO S WPR=OWPR K OWPR,UU,OW,EE,OCC,LE,NNB S:ZAA02G("T")["DO " ZAA02G("T")=$P(ZAA02G("T")," DO") W:WPR["I" sm Q
 ;
SCHANGE S:ZAA02G("T")'[" DO " ZAA02G("T")=ZAA02G("T")_" DO ^ZAA02GSCRCE",OWPR=WPR,WPR="ZAA02GWPV2I"
 S UU=$P($P($E(%,W+1,255)," "),"."),(U,UU)=U_UU,OW=W-1,OCC=CC K D,NNB,REFO Q
 ;
REFO N W,%,SB,B S (LTM,RTM)=0 F C=0:0 S C=$O(REFO("")) Q:C=""  S SB=REFO(C) K REFO(C) I $D(@ZAA02GWPD@(SB)) S %=$P(@ZAA02GWPD@(SB),XF,4),LTM=ML-1,RTM=MG-RM,W=0 D PASTE^ZAA02GWPV7
 K REFO D 960^ZAA02GWPV4 Q
 ;
CP ; from Insert Logic
 K REFO S MG=$S($D(@ZAA02GWPD@(.01)):^(.01),1:65) S %R=10,%C=35 W @ZAA02GP,"wait..."
 I '$D(ZAA02GSCM) S ZAA02GSCM="^ZAA02GSCMD" I $D(@ZAA02GSCM) D DATABASE^ZAA02GSCM
 S LEX="ORG" I $D(@ZAA02GSCM@("PARAM","LEX")) S LEX=^("LEX")
CPA S (G,A)="" F  S G=$O(MCE(G)) Q:G=""  S O=$TR(G,"$") F  S A=$O(MCE(G,A)) Q:A=""  S ADD=$G(MCE(G,A)),C=A,E=O,J="~$"_G K MCE(G,A) D CP1 I $O(MCE(G,""))="" K MCE(G)
 I $O(MCE(""))'="" G CPA
 K G,TF,O,ADD,MCE Q:'$D(REFO)
 N W,%,SB,Ze S XF=$C(1),CR=24,TL=3,BL=22,XFM=$C(1,1,1),(TOP,BOT)=0,XS=$E(ZAA02G("RON")),XSL=$L(ZAA02G("RON")),Ze="_"
 ; X "N (REFO) W  R CCC"
 F C=0:0 S C=$O(REFO("")) Q:C=""  S RTM=0,SB=+REFO(C),LTM=$P(REFO(C),",",2),W=LTM+1 K REFO(C) I $D(@ZAA02GWPD@(SB)) S %=$P(^(SB),XF,4) D PASTE^ZAA02GWPV7
 K LEX,REFO,TOP,BOT,TL,BL,XF,XS,XSL,Ze,RTM,LTM,TT,T,L,ADD Q
CP1 S TT="" F D=J_" ",J_":" I @ZAA02GWPD@(C)_" "[D G CPX
 F TT=".",",",";" S D=J_TT I @ZAA02GWPD@(C)_" "[D G CPX
 S C=$O(^(C)) Q:C=""  Q:$P(^(C),$C(1),4)?.P  G CP1
CPX I D["REFORM" S:'$D(REFO(C)) REFO(C)=C
 S L=$P(@ZAA02GWPD@(C),$C(1),4),(T,LTM)="",Z=$P(ADD,"~",2) I ADD["~"!($L(L_" ",D)>2) S MCE(G,A)=ADD
 I D[":" S N=$P($P(L,D,2)," "),LTM=$S(N["W":$L($P(L,D)),1:0),L=$P(L,D)_D_$P(L,D_N,2,9),D=D_" " S:".,"[$E(N,$L(N)) TT=$E(N,$L(N))
 S:L'[D L=L_" "
 ; MODIFIERS - 123456789-UWIS<>|=,.
 I  F W=1:1:$L(N) S:"1234567890-UWSI="[$E(N) @$S("=-UIS"[$E(N):"ADD=ADD_$E(N)",$E(N)="W":"REFO(C)=C_"",""_LTM",1:"Z=$E(N)") G:"><|"[$E(N) @("CPOR"_$F("><|",$E(N))) S N=$E(N,2,511)
 G:$G(MAMMO)="" CP2
 I $L(E)=3 G CP2:MAMMO'[E G CP1A
 F T=0:0:$L(MAMMO) S T=$F(MAMMO,";"_E,T) S:'T T="" G:'T CP2 I $S(Z="":$E(MAMMO,T+1)'?1N,Z=0:1,1:$E(MAMMO,T+1)=Z) S T=$E(MAMMO,T) Q
CP1B G:T="" CP2 S E=E_T
CP1A S T=$G(@ZAA02GSCM@("DICT",3,E)) G:T="" CP2 S T=$G(@ZAA02GSCM@("DICT",1,+T,$P(T,",",2),LEX,ADD["S"*2+(ADD["I")+1))_TT_" "
 I T["xx"!(ADD["=") S:ADD["=" Z="" S F=$F(MAMMO,";"_E_Z) I $E(MAMMO,F)="," S F=$P($E(MAMMO,F+1,255),";") S:F?1.N F=+F S T=$S(ADD["=":F_TT,1:$P(T,"xx")_F_$P(T,"xx",2,99))
 I T["~$$" D CPAD
CP1C I ADD]"" S:ADD["-"&(T'?." ") T="- "_T S:$G(REFO(C))[","&(ADD["-") $P(REFO(C),",",2)=$P(REFO(C),",",2)+2 S:ADD["U" T=$TR(T,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
CP2 ; I T'="" W C," C=",D," E=",E," T=",T," L=",?15,L," " R CCC,!
 S:T?.E1". " T=T_" "
 I $L(L)+$L(T)-$L(D)<MG S D=$E(D,3,99) D F1^ZAA02GSCRER1 S $P(@ZAA02GWPD@(C),$C(1),4)=L G:L?." " REM Q
 S N=$P(L,D) ;_$S(ADD["-":"- ",1:"")
 S J=$O(@ZAA02GWPD@(C)) S:J="" J=C+10 S J=$J(J-C/3,0,6),L=$P(L,D,2,99)
 I $L(N)+$L(L)=0 S $P(@ZAA02GWPD@(C),$C(1),4)=T Q
 I $L(N)+$L($P(T," ",1,2))<MG S N=N_$P(T," ",1,2),T=$P(T," ",3,99)
 S:N]"" $P(^(C),$C(1),4)=N S W=C I T'?." " S W=J+C,^(W)=C_$C(1,1,1)_T
 S:L'?." " ^(J+W)=W_$C(1,1,1)_L,W=J+W S C=$O(^(W)) I C S $P(^(C),$C(1))=W
 Q
CPOR2 ; > GET FIRST OCCURANCE USING LIST FROM L to R
 S T="" F T=2:1:$L(N) I MAMMO[(";"_E_$E(N,T)) S T=$E(N,T) Q
 G CP1B
CPOR3 ; < BOOLEAN LOGIC USING `!& AND DICT CODES (code:X X=0:ALL,1-5,9=Z)
 S (W,T)="",N=$E(N,2,99) F  D CPOR3A Q:N=""
 ; W !,MAMMO,!,W," ",@W," ",E," ",Z  R CCC
 I W]"",@W G CP1A
 S T="" G CP2
CPOR3A I $E(N)?1P G:"<>"[$E(N) CP0R3B S W=W_$E(N),N=$E(N,2,99) Q
 S F=$S(N?3AN.E:3,1:2),$P(F,",",2)=$S(F=3:"",1:"E1")_$S(Z:""""_Z_"""",Z=0:"""""",1:"P"),T=$E(N,1,+F),N=$E(N,F+1,99)
 I $E(N)=":" S $P(F,",",2)=""""_$E("12345678"_Z,$E(N,2))_"""",N=$E(N,3,99)
 S W=W_"(MAMMO_"";""?.E1"""_T_"""1"_$P(F,",",2)_".E)" Q
 I +F=3 S W=W_"(MAMMO_"";""?.E1"""_T_"""1"""_$S(F[",":$P(F,",",2),Z:Z,Z=0:"",1:";")_""".E)" Q
 S W=W_"(MAMMO_"";""?.E1"""_T_"""1E1"""_$S(F[",":$P(F,",",2),Z:Z,Z=0:"",1:";")_""".E)" Q
CP0R3B S W=W_"&($P(MAMMO,"""_T_","",2)"_$E(N) S N=$E(N,2,99) F  Q:$E(N)'?1N  S W=W_$E(N),N=$E(N,2,99)
 S W=W_")" Q
CPOR4 ; | GET ALL FROM LIST IN L to R ORDER
 S (LT,F)="" F W=2:1:$L(N)  F I=0:0:$L(MAMMO) S I=$F(MAMMO,";"_E_$E(N,W),I) S:'I I="" Q:'I  I $S(Z="":$E(MAMMO,I)'?1N,1:$E(MAMMO,I)=Z) S T=E_$E(N,W) D CPOR4A S F=F_T S:F?.E1". " F=F_" ",TT=""
 S T=$E(F,1,$L(F)-1)_TT_" " S:T?1.P T="" K LT,Lt G CP1C:T'="",CP2
CPOR4A S T=$G(@ZAA02GSCM@("DICT",3,T)) I T]"" S T=$G(@ZAA02GSCM@("DICT",1,+T,$P(T,",",2),LEX,ADD["S"*2+(ADD["I")+1))
 Q:T=""  I T["xx"!(ADD["=") S I=I+$L(Z) I $E(MAMMO,I)="," S B=$P($E(MAMMO,I+1,999),";") S:B?1.N B=+B S T=$S(ADD["=":B,1:$P(T,"xx")_B_$P(T,"xx",2,99))
 I T["~$$" D CPAD
 S (Lt,T)=T F B=1:1:$L(T," ") Q:$P(T," ",B)'=$P(LT," ",B)
 S T=$P(T," ",B,99) S:T["in the "&(LT["in the ") T=$P(T,"in the ",2,99) S T=T_" "
 I F]"" F B=0:1:$L(T," ")-1 I $P(T," ",$L(T," ")-B)'=$P(F," ",$L(F," ")-B) S:B F=$P(F," ",1,$L(F," ")-B)_" " Q
 S LT=Lt Q
CPAD F j=2:1:$L(T,"~$$") S MCE("$"_$P($TR($P(T,"~$$",j),":./\<","       ")," "),C)=$TR(ADD,"U-=","U")_"~"_Z
 ; W !,Z," ",J," ",T," ",j R CCC
 K j Q
REM S T=$P(^(C),$C(1)) K ^(C) S C=$O(^(C)) S:C $P(^(C),$C(1))=T
 ; I T>.03,$P(^(T),$C(1),4)?." " S C=T,T=$P(^(C),$C(1)) K ^(C) S C=$O(^(C)) S:C $P(^(C),$C(1))=T
 I C,T>.03,$P(^(T),$C(1),4)?." ",$P(^(C),$C(1),4)?." " S C=T,T=$P(^(C),$C(1)) K ^(C) S C=$O(^(C)) S:C $P(^(C),$C(1))=T
 Q
 ;
notes ;  modifiers
 ;
 ;
 ;
 ;
