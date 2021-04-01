ZAA02GSCRVA ;PG&A,ZAA02G-SCRIPT,2.10,VA LOOKUP ROUTINE;13DEC94 2:45P;;;20NOV96  07:54
 ;
 ;  LOOKUP PATIENT BY NAME
LKP S X=$TR(X,"?"),FX="" I X["," S FX=$P(X,",",2),X=$P(X,",") S:$E(FX)'=" " FX=" "_FX
 G:X_FX?." " LKP1
 S GLB="^DPT(""B"")",RX=0 D LKPX,REFRESH I X[";EX"!(X="") S X="" G LKP1
 D PUT S RX=2+$D(MRLK)
LKP1 I 1 K FX,MRLK Q
LKPX K NEWA N:1 (X,FX,ZAA02G,ZAA02GP,GLB,REFRESH,INP,NEWA) S Z=X_"z" S:X="" X="@" I X?1.N S Z=X
 S REFRESH="",Y="5,3\RHLGSD\1\Patients\         Name                 SSAN#      Age  Sex " ;      Admit      Disch    "
 S Y(0)="\EX\^DPT(""B"")\S;25`$P(^DPT(S2,0),""^"",9);10`$$AGE^ZAA02GSCRVA;3`$P(^(0),""^"",2);1\"_X_"| \\\"_Z
 D LOOK,POP S X=$P(X,"|",2) Q
 ;
PUT S dt=$P(^DPT(X,0),"^",3),opi=3,opi(1)="PDSP;DOB;"""_$E(dt,4,5)_"/"_$E(dt,6,7)_"/"_($E(dt,1,3)+1700)_"""",opi(2)="PDSP;PATIENT;"""_$P(^(0),"^")_""""
 S X=$P(^(0),"^",9),X=$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,9) S:X="--" X="000-00-0000" S opi(3)="PDSP;MR;"""_X_""""
 K dt X op Q
AGE() N x S x=$P($G(^(0)),"^",3)
 Q:x="" ""  S x=$P(INP("DT"),"/",3)+300*100+INP("DT")*100+$P(INP("DT"),"/",2)-x Q $E(x,1,3)-100
 ;
LKAD ; LOOKUP PATIENT BY SSAN
 Q:X=""  I X?9N S:$D(^DPT("SSN",X)) X=$O(^(X,"")) G:X'?9N LKAD0 S X=$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,9) Q
 I X?1A.AP S MRLK=0 G LKP
 I X?1.7N G RAD^ZAA02GSCRVA1 I $D(^RAO(75.1,X)) G RAD^ZAA02GSCRVA1
 S X=$TR(X,LC_"?",UP) I $D(^DPT("BS5",X))'=10 G LKAD1
 S NM=X D LKAD2 I X[";EX"!(X="") S X="" G LKAD1
LKAD0 D PUT S RX=3
LKAD1 I 1 Q
LKAD2 N:1 (X,ZAA02G,ZAA02GP,NM) S Y="10,17\RHLS\2",Y(0)="\EX\^DPT(""BS5"",NM)\$P(^DPT(TO,0),""^"")_""  ""_$P(^(0),""^"",9)\" D POP Q
 Q
REFRESH Q:$G(REFRESH)=""  G AP0^ZAA02GFORM4
POP D ^ZAA02GPOP Q  ; W *8,*8,*8,*8,*8,*8
 ;
LOOK S ZAA02GPOPALT=$P($T(LOOKT),";",2,99) S:$G(FX)]"" ZAA02GPOPALT=$P(ZAA02GPOPALT,"$L(S2)")_"$L(S2),"""" """"_$P(S,"""","""",2)[FX"_$P(ZAA02GPOPALT,"$L(S2)",2)
 S:$P(Y(0),"\",8)?1.N ZAA02GPOPALT=$TR(ZAA02GPOPALT,"]",">")
 Q
LOOKT ;S S=$P(TO,""|""),S2=$P(TO,""|"",2) F jj=1:1 S:S2="""" S=$O(@GLB@(S))  S:jj=999 TO="""" S:S="""" TO="""" S:S]TEN TO=""""  Q:TO=""""  S:$L(S) S2=$O(@GLB@(S,S2)) I $L(S2) S TO=S_""|""_S2 Q
 ;
 ;
