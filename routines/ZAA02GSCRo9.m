ZAA02GSCRo9 ;PG&A,ZAA02G-SCRIPT,2.10,IMS lookup routine;6MAR95 3:15P
 ;
 ;  LOOKUP PATIENT BY NAME
LKP I X["+" S X=$TR(X,"+") Q
 S RX=3
LKP2 S OX=X,X=$TR(X,"?@"),FX="" S:X["," FX=$P(X,",",2),X=$P(X,",") G:X_FX="" LKP3 I X]"" S GLB=$S(OX["@":"^AMPI",1:"^APBF"),GLBL=$TR(GLB,"A")
 D LKPX D REFRESH I X[";EX"!(X="") S X="" G LKP3
 D PUT
LKP1 I 1 K FX Q
LKP3 S RX=0 I 1 K FX Q
 ;
LKAD ; LOOKUP PATIENT BY MR#
 Q:X=""  S RX=4 G:X?1.AP LKP2 I $D(^PBF(X)) D PUT I 1 Q
LKAD1 S RX=1 I 1 Q
 ;
 ;
LKATT ; LOOKUP REFERRAL
 S X=$TR(X,"?*+"),FX="" G:x0["+" LKAT1 S:X["," FX=$P(X,",",2),X=$P(X,",") G LKAT1:X_FX="" I $D(^ADF(X)) S X=$O(^ADF(X,"")) G LKAT2
 S GLB="^ADF" D LKPVX D REFRESH I X[";EX"!(X="") S X="",RX=0 G LKAT1
LKAT2 S RX=1,X=^DOC(X,1)
LKAT1 I 1 K FX Q
LKAT3 X "I 0" Q
 ;
 ;
REFRESH I REFRESH="" S X="" Q
 G AP0^ZAA02GFORM4
LKPX N:1 (X,FX,ZAA02G,ZAA02GP,GLB,GLBL,REFRESH,INP) S Z=X_"z" S:X="" X="@" I X?1.N S Z=X
 S REFRESH="",Y="1,3\RHLGS\1\Patients\      Name             Contrl #      Street            City        Age   Sex "
 S Y(0)="\EX,IL\\$G(^PBF($P(TO,""|"",2),1));20`$P(TO,""|"",2);8`$G(^(2));15`$G(^(3));12`$G(^(6));3`$G(^(7));2\"_X_"| \\\"_Z
 S $P(Y(0),"\",6)="Return, Exit  *"
 D LOOK
 Q:X[";EX"  S:X[";IL" X=$P(X,";"),NEWA=0 S X=$P(X,"|",2) Q
LKPVX N (X,FX,ZAA02G,ZAA02GP,GLB,REFRESH) S REFRESH="",Y="20,6\RHLGS\1\Providers\     Name                  City             #  ",Y(0)="\EX\\^DOC($P(TO,""|"",2),1);20`$G(^(3));15`$G(^(8));6\"_X_"\\\"_X_"z",GLBL="^DOC" D LOOK
 Q:X["EX;"  S X=$P(X,"|",2) Q
 ;
LOOK S ZAA02GPOPALT=$P($S(^ZAA02G("OS")="PSM":$T(LOOKT+1),1:$T(LOOKT)),";",2,99) S:$G(FX)]"" ZAA02GPOPALT=$P(ZAA02GPOPALT,"$L(S2)")_"$L(S2),$E($P(S,"""","""",2),1,$L(FX))=FX"_$P(ZAA02GPOPALT,"$L(S2)",2)
 S:$P(Y(0),"\",8)?1.N ZAA02GPOPALT=$TR(ZAA02GPOPALT,"]",">") D ^ZAA02GPOP K GLB,GLBL Q
LOOKT ;S S=$P(TO,""|""),S2=$P(TO,""|"",2) F jj=1:1 S:S2="""" S=$O(@GLB@(S)) I S'[""@"" S:S="""" TO="""" S:S]TEN TO=""""  Q:TO=""""  S:$L(S) S2=$O(@GLB@(S,S2),-1) I $L(S2),$D(@GLBL@(S2)) S TO=S_""|""_S2 Q
 ;S S=$P(TO,""|""),S2=$P(TO,""|"",2) F jj=1:1 S:S2="""" S=$O(@GLB@(S)) S:S="""" TO="""" S:S]TEN TO=""""  Q:TO=""""  S:$L(S) S2=$ZO(@GLB@(S,S2)) I $L(S2),$D(@GLBL@(S2)) S TO=S_""|""_S2 Q
 ;
PUT S opi=3,opi(1)="PDSP;DOB;"""_$G(^PBF(X,6))_"""",opi(2)="PDSP;PATIENT;"""_$G(^PBF(X,1))_"""",opi(3)="PDSP;CONSULT;"""_$P($G(^PBF(X,16)),"#",2)_"""" S:$G(INP("MR"))="" opi=4,opi(4)="PDSP;MR;"""_X_""""
 ; S opi=3,opi(1)="PDSP;DOB;"""_$G(^PBF(X,6))_"""",opi(2)="PDSP;PROC2;"""_$G(^PBF(X,7))_"""",opi(3)="PDSP;PATIENT;"""_$G(^PBF(X,1))_""""
 X op K dt Q
 ;
VAR F I=1:1 S VAR=$P(ALLVAR,",",I) Q:VAR=""  S T="",VAR="x"_VAR I $T(@VAR)]""  D @VAR S INP($E(VAR,2,99))=T
 Q
xSEX D GETGL S T=$G(@T@(7)) Q
xPN D GETGL S T=$G(@T@(1)) Q
xPADR D GETGL S T=$G(@T@(2))_" " Q
xPCSZ D GETGL S T=$G(@T@(3))_"  "_$G(^(4)) Q
xTEL D GETGL S T=$G(@T@(9)) Q
xMC D GETGL S T=$G(@T@(30))_" " Q
xMA D GETGL S T=$G(@T@(35))_" " Q
xRFN S T=$G(INP("CONSULT")) Q:T=""  S T=$O(^ADF(T,"")) Q:T=""  S T=$E($P(^DOC(T,1)," ",2))_" "_$P(^(1),",") Q
xRFO S T="" Q
xDR S T=$G(INP("PROVIDER")) Q:T=""  S T=$P($G(@ZAA02GSCR@("PROV",T)),"\",3) Q
GETGL S T=INP("MR") I T="" S T="XXX" Q
 I $D(^PBF(T)) S T="^PBF("_T_")" Q
 I $D(^MPI(T)) S T="^MPI("_T_")" Q
 S T="XXX" Q
GETP S:$G(INP("PROVIDER"))="" INP("PROVIDER")=$G(@ZAA02GSCR@("PARAM","SAVEPROV"))
 S INP("SITEC")="NA" Q
SAVEP S:X]"" @ZAA02GSCR@("PARAM","SAVEPROV")=X Q
