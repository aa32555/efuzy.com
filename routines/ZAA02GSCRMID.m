ZAA02GSCRMID ;PG&A,ZAA02G-SCRIPT,1.96,MIDS LOOKUP ROUTINE;9NOV94 4:30P;;;10NOV98  11:15
 ;
 ;  LOOKUP PATIENT BY NAME
LKP G:$D(LDWN) LKP1 S RX=5
LKP2 S X=$TR(X,"?@"),FX="" S:X["," FX=$P(X,",",2),X=$P(X,",") G:X_FX="" LKP3 I X]"" S GLB=$S(X["@":"^[DBASE]MIDMRA(""E"")",1:"^[DBASE]MIDS(""B"")"),X=$TR(X,"@") ; I $D(@GLB@(X))=0,$E($O(@GLB@(X)),1,$L(X))'=X G LKP3
 D LKPX D REFRESH I X[";EX"!(X="") S X="" G LKP3
 G ^ZAA02GSCRMI2
LKP1 I 1 K FX Q
LKP3 S RX=0 I 1 K FX Q
 ;
LKAD ; LOOKUP PATIENT BY MR# OR SSAN
 Q:X=""  K FX I X=0 S INCOMP=0,RX=2 G LKAD0
 G:$D(LDWN) LKAD1 S RX=7 G:X?1.AP LKP2 I X?9N S:$D(^[DBASE]MIDS("E",X)) X=$O(^(X,"")) G:X'?9N LKAD0 S X=$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,9) Q
 S X=$TR(X,LC_"?",UP) ; I $D(^[DBASE]MIDS("D",X))>1,$O(^($O(^(X,""))))="" S X=$O(^[DBASE]MIDS("D",X,"")) G LKAD0
 S GLB="^[DBASE]MIDS(""D"")" D LKPX D REFRESH S:X[";EX" X="" I X="" S RX=0 G LKAD1
LKAD0 G ^ZAA02GSCRMI2
LKAD1 I 1 Q
 ;
LKAC ; LOOKUP PATIENT BY ACCOUNT #
 K FX S RX=6,X=$TR(X,LC_"?",UP) I $D(^[DBASE]MIDS("C",X))>1,$O(^($O(^(X,""))))="" S X=$O(^[DBASE]MIDS("C",X,"")) G LKAD0
 S GLB="^[DBASE]MIDS(""C"")" D LKPX D REFRESH S:X[";EX" X="" I X="" S RX=0 G LKAD1
 G LKAD0
 ;
LKCC ; LOOKUP CCs
 S PROVC="c"_($G(n(1))+2) G LKPV0
LKATT ; LOOKUP ATTENDING
 S PROVC="PROVA" G LKPV0
LKPV ; LOOKUP PROVIDER
 S PROVC="PROV"
LKPV0 S X=$TR(X,"?*+"),FX="" G:x0["+" LKPV1:$E(PROVC)="c",LKPVS2 G LKPV3:x0["?" S:X["," FX=$P(X,",",2),X=$P(X,",")
 G LKPV5:X_FX="",LKPV1:$D(LDWN) I $D(^[DBASE]MIDIC(1,"C",X)) S (INP(PROVC),X)=$O(^[DBASE]MIDIC(1,"C",X,"")),X=$P(^[DBASE]MIDIC(1,X,0),"^") G LKPV2
 I $D(^[DBASE]ZAA02GPROV(0,X))#2 S (INP(PROVC),X)=^(X),X=$S($D(^[DBASE]MIDIC(1,X,0)):$P(^(0),"^"),1:$G(^[DBASE]ZAA02GPROV(X))) G LKPV2
LKPV3 S GLB=x0,X=$TR(X,LC,UP) D LKPVX,REFRESH I X[";EX"!(X="") S X="",RX=0 G LKPV5
 I +X S INP(PROVC)=+X,X=$P(X,"|",2)
 E  S (X,INP(PROVC))=$P(X,"|",2)
LKPV2 S RX=1 I $D(^[DBASE]ZAA02GPROV(INP(PROVC)))=0!($G(x0)["*") K FX G LKPVS
LKPV1 I 1 K FX,PROVC Q
LKPV5 I 1 S INP(PROVC)="" K FX,PROVC Q
LKPVS S NN=X D LKPVS^ZAA02GSCRMI2 S X=NN D REFRESH K NN,PROVC,FX Q
 Q
LKPVS2 S INP(PROVC)=X G LKPVS
 ;
TYPE ; LOOKUP FOR PATIENT TYPE
 S X=$TR(X,"?") G TYPE2:X="",TYPE2:$D(LDWN),TYPE0:$O(^[DBASE]MIDIC(124,"B",X,"")),TYPE1:$O(^[DBASE]MIDIC(124,"C",X,"")) I $E($O(^[DBASE]MIDIC(124,"B",X_" ")),1,$L(X))'=X X "I 0" Q
 S X=$O(^[DBASE]MIDIC(124,"B",X_" ")) ; NEED TIE BREAKING HERE
TYPE0 S X=$O(^[DBASE]MIDIC(124,"B",X,"")) G TYPEHE
TYPE1 S X=$O(^[DBASE]MIDIC(124,"C",X,"")) G TYPEHE
TYPE2 I 1 Q
TYPEH S GLB="^[DBASE]MIDIC(124,""B"")" D TYPEX D REFRESH I X[";EX"!(X="") S X="" I 1 Q
TYPEHE S X=$P(^[DBASE]MIDIC(124,X,0),"^") I 1 Q
 ;
RTYPE() ; CALLED FROM REPORT TYPE IN ID BLOCK
 Q:$D(LDWN) "" Q:X="" "" I $O(^[DBASE]MIDIC(101,"C",X,0))=""  Q ""
 Q $P($G(^[DBASE]MIDIC(101,$O(^[DBASE]MIDIC(101,"C",X,0)),0)),"^")
 ;
REFRESH I REFRESH="" S X="" Q
 G AP0^ZAA02GFORM4
LKPX K NEWA N (DBASE,X,FX,ZAA02G,ZAA02GP,GLB,REFRESH,INP,NEWA) S Z=X_"z" S:X="" X="@" I X?1.N S Z=X
 S REFRESH="",Y="1,3\RHLGS\1\Patients\  Name            MR#     Age  Sex    Accnt#      Admit      Disch     Stat"
 S Y(0)="\EX,IL\\$$NAM^ZAA02GSCRMID;14`wmr;6`$$B^ZAA02GSCRMID;3`$P(^(0),""^"",4);1`$P(^(0),""^"",2);10R`$$D^ZAA02GSCRMID($P(^(0),""^"",7));8`$$D^ZAA02GSCRMID(+$G(^(2)));8`$$S^ZAA02GSCRMID($P(^(0),""^"",16));4\"_X_"| \\\"_Z
 S $P(Y(0),"\",6)="Return, Exit, Insert Line   *",GLBL="^[DBASE]MIDS"
 D LOOK
 Q:X[";EX"  S:X[";IL" X=$P(X,";"),NEWA=0 S X=$P(X,"|",2) Q
LKPVX N (DBASE,X,FX,ZAA02G,ZAA02GP,GLB,REFRESH) S REFRESH="",Y="10,6\RHLGS\1\Providers\  Name                  Hosp #     License #   MIDS   FAX "
 S Y(0)="\EX\\$S(TO:$P(^[DBASE]MIDIC(1,+TO,0),""^""),1:$P(TO,""|"",2));20`$S(TO:$P(^(0),""^"",2),1:"""");9`$P($G(^[DBASE]ZAA02GPROV($S(TO:+TO,1:$P(TO,""|"",2)),1)),$C(96),2);9`$S(TO:""Y"",1:"""");4`$S($P($G(^(1)),$C(96))[""AF"":""Y"",1:"""");3\"
 ;S Y(0)="\EX\\TO;20`$S(TO:$P(TO,""^"",2),1:"""");9`$P($G(^[DBASE]ZAA02GPROV($P(TO,""|"",2),1)),$C(96),2);9`$S(TO:""Y"",1:"""");4`$S($P($G(^[DBASE]ZAA02GPROV($P(TO,""|"",2),1)),$C(96))[""AF"":""Y"",1:"""");3\"
 S:X]"" Y(0)=Y(0)_$E(X,1,$L(X)-1)_$C($A(X,$L(X))-1)_"z\\\"_X_"z" I X="",GLB["?" S $P(Y(0),"\",5)="A"
 S ZAA02GPOPALT="D LKPVT^ZAA02GSCRMID" D ^ZAA02GPOP Q
LKPVT S S1=$P(TO,"|"),S=$P(TO,"|",2) S:S="" S=TO,S1=""
 I S1]"" S S1=$O(^[DBASE]MIDIC(1,"B",S,S1)) I S1]"" G LKPVT1
 S:GLB'["?" S1=$O(^[DBASE]MIDIC(1,"B",S)) S:S1="" S1="zzz" I S1]$O(^[DBASE]ZAA02GPROV(S)),$O(^(S))'="" S S=$O(^(S)),S1="" G LKPVT2
 I S1="zzz" S TO="" Q
 S S=S1,S1=$O(^[DBASE]MIDIC(1,"B",S,""))
LKPVT2 I S]TEN S TO="" Q
LKPVT1 S TO=S1_"|"_S Q
TYPEX N (DBASE,X,ZAA02G,ZAA02GP,GLB,REFRESH) S REFRESH="",Y="10,6\RHLGS\1\Patient Status",Y(0)="\EX\\$P(^[DBASE]MIDIC(124,$P(TO,""|"",2),0),""^"");20`$P(^(0),""^"",2);8",GLBL="^[DBASE]MIDIC(124)" D LOOK
 Q:X[";EX"  S X=$P(X,"|",2) Q
D(X) Q:X>0 $E(X,4,5)_"/"_$E(X,6,7)_"/"_($E(X,1,3)-200) Q ""
A() N x S x=$P(REC,"^",3) G AG1
B() N X S x=$P(^(0),"^",3)
AG1 Q:x="" ""  S x=$P(INP("DT"),"/",3)+300*100+INP("DT")*100+$P(INP("DT"),"/",2)-x Q $E(x,1,3)-100
S(X) Q:X]"" $P($G(^[DBASE]MIDIC(124,X,0)),"^") Q ""
NAM() S Nm=$P(^[DBASE]MIDS($P(TO,"|",2),0),"^")
 K:TM-1=TMM mr S lsmr=$G(mr),(wmr,mr)=$P(^(0),"^",6) I mr=lsmr S wmr="  ""   " Q wmr
 Q Nm
 ;
LOOK S ZAA02GPOPALT=$P($S(^ZAA02G("OS")="PSM":$T(LOOKT+1),1:$T(LOOKT)),";",2,99) S:$G(FX)]"" ZAA02GPOPALT=$P(ZAA02GPOPALT,"$L(S2)")_"$L(S2),$E($P(S,"""","""",2),1,$L(FX))=FX"_$P(ZAA02GPOPALT,"$L(S2)",2)
 S:$P(Y(0),"\",8)?1.N ZAA02GPOPALT=$TR(ZAA02GPOPALT,"]",">") D ^ZAA02GPOP K GLB,GLBL Q
LOOKT ;S S=$P(TO,""|""),S2=$P(TO,""|"",2) s:S2<1 mr=0 F jj=1:1 S:S2="""" S=$O(@GLB@(S)) I S'[""@"" S:S="""" TO="""" S:S]TEN TO="""" Q:TO=""""  S:$L(S) S2=$O(@GLB@(S,S2),-1) I $L(S2),$D(@GLBL@(S2)) S TO=S_""|""_S2 Q
 ;S S=$P(TO,""|""),S2=$P(TO,""|"",2) F jj=1:1 S:S2="""" S=$O(@GLB@(S)) S:S="""" TO="""" S:S]TEN TO=""""  Q:TO=""""  S:$L(S) S2=$ZO(@GLB@(S,S2)) I $L(S2),$D(@GLBL@(S2)) S TO=S_""|""_S2 Q
