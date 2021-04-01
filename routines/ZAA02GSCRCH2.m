ZAA02GSCRCH2 ;PG&A,ZAA02G-SCRIPT,2.10,COLUMBIAN NEW PATIENT LOOKUP;;;;31AUG99  15:22
 ;
LOAD ;LOADS INP ARRAY FOR ID WITH PATIENT INFO. GIVEN INTERNAL #
 S (INP("LOC"),INP("ENC"))="",X=+$P(PAT,"|",2),K=$P(PAT,"|",4)_","_$P(PAT,"|",3) S:$L(K)>1 INP("ENC")=K
 D LOADX I X S K=$P($G(^[DBASE]MB8(X,"M"," "_INP("MR"),11)),"|",3) I K]"" S K=$P($G(^[DBASE]DI1T(K,1)),"|",6) S INP("LOC")="-"_K
 S K=0 F J=1:1 S A=$P("MR,PATIENT,DOB,REV,LOC",",",J) Q:A=""  I $D(INP(A)) S K=K+1,opi(K)="PDSP;"_$P("MR,PATIENT,DOB,CONSULT2,LOC",",",J)_";INP("""_A_""")"
 S K=K+1,opi(K)="PDP;ENC;$P($G(INP(""ENC"")),"","")"
 S opi=K,SRF=rf,rf=ZAA02G("HI") x:K op S rf=SRF K SRF,A
 I 1 S RX=4 Q
 Q
LOADX N (ZAA02G,X,INP,DBASE) S A=$G(^[DBASE]MB0(X,2)),INP("PATIENT")=$P(A,"|"),INP("MR")=$TR($P(A,"|",5)," ",""),D=$P(A,"|",3),DT="" D:D]"" DATE S INP("DOB")=DT,INP("REV")=$P(A,"|",2),INP("PIN")=X
 Q
 ;
LOOKUP ; LOOKUP IN THE HSI PATIENT FILE BY NAME
 I X="" W "Enter starting letters" H 2 G LOOKE
 S X=$TR(X,LC_"?",UP),PT=$P(X,",",2),PAT=$P(X,","),REFRESH=1 G:PAT="" LOOKE  N FILE S FILE="^[DBASE]MB1"
 ; I $E($O(^[DBASE]MB1(PAT)),1,$L(PAT))'=PAT G LOOKE
 ; I PT'="" S i=PAT F jj=1:1 S i=$O(^[DBASE]MB1(i)) Q:i=""   Q:$E($O(^[DBASE]MB1(i)),1,$L(PAT))=PAT&($E($P(i,",",2),1,$L(PT))=PT)  I $E($O(^[DBASE]MB1(i)),1,$L(PAT))'=PAT G LOOKE
 S ZAA02GPOPALT="D LOOKT^ZAA02GSCRCH2"
 D LOOK1 S tt=+REFRESH,td=$P(REFRESH,":",2) D AP0^ZAA02GFORM4
 I EAT[";EX" S X="" G LOOKE
 S X=$P(PAT,"|",2) D LOAD S X=INP("PATIENT")
LOOKE K i,jj,PAT Q
 ;
LOOK1 N:1 (FILE,ZAA02GPOPALT,DBASE,ZAA02G,ZAA02GP,PAT,PT,REFRESH) S Y="1,3\RLHSG1\1\PATIENT LOOKUP\   NAME            CHART#     DOB        SSAN       EXAM     ENCNTR#   PHYS"
 S Y(0)="\EX,IL\\$P($G(^[DBASE]MB0($P(TO,""|"",2),2)),""|"");16`$E($P($G(^(2)),""|"",5),2,9);6R`$$DOB^ZAA02GSCRCH2($P($G(^(2)),""|"",3));8`$P($G(^(2)),""|"",4);9`$$DOB^ZAA02GSCRCH2(-$P(TO,""|"",3));8`$P(TO,""|"",4);6R`$P(TO,""|"",5);4\"
 I PAT?1" "2.N S Y(0)=Y(0)_" "_($E(PAT,2,99)-1)_"{\\\"_PAT_"{"
 E  S Y(0)=Y(0)_PAT_"\\\"_PAT_"z"
 S $P(Y(0),"\",6)="Return, Exit, Insert Line  *"
 D ^ZAA02GPOP S:X[";IL" X=$P(X,"|",1,2) S PAT=X Q
 ;
LOOKT S S=$P(TO,"|"),S2=$P(TO,"|",2),S3=$P(TO,"|",3),S4=$P(TO,"|",4)
LOOKT1 I S2="" F jj=1:1:999  S:jj=999 TO="" S S=$O(@FILE@(S)) S:S="" TO="" S:S]TEN TO="" Q:TO=""  Q:PT=""  I $E($P(S,",",2),1,$L(PT))=PT Q
 Q:TO=""  I S3="" S S4="" F  S S2=$O(@FILE@(S,+S2)) G:S2="" LOOKT1 I $L(S2),$D(^[DBASE]MB0(S2,2)) Q
 I '$D(^[DBASE]ENa(+S2)) S TO=S_"|"_S2_"||?" Q
 I S4="" S:S3'="" S2=S2_"," S S3=$O(^[DBASE]ENa(+S2,S3)) G:S3="" LOOKT1 I +S2'=S2 G:-S3+30<$H LOOKT1
 S S4=$O(^[DBASE]ENa(+S2,S3,S4)) G:S4="" LOOKT1 S TO=S_"|"_S2_"|"_S3_"|"_S4_"|"_$TR($P($G(^[DBASE]DI1D($P($G(^[DBASE]ENV(S4,31)),"|",7),1)),"|",17)," ") Q
 ;         
LOOKUPN ; LOOKUP BY EITHER CHART # OR SSAN
 ; I X["+" G LOOKUPN^ZAA02GSCRCHM
 S X=$TR(X,"@+") I X?1"M"1.N S X=$E(X,2,7) Q
 I X=0 S INCOMP=0,RX=1 Q
 I X="OO" S RX=1 Q
 I X?1.AP D LOOKUP S X=$G(INP("MR")),RX=4 Q
 N FILE S FILE="^[DBASE]"_$S(X?1.AP:"MB1",X?9N:"MB3",1:"MB02")
 S PAT=$S(X?9N:X,1:" "_($E(X,1,9))),PT=""
LKN1 S ZAA02GPOPALT="D LOOKT^ZAA02GSCRCH2",REFRESH=1
 D LOOK1 S tt=+REFRESH,td=$P(REFRESH,":",2) D AP0^ZAA02GFORM4
 D:PAT'[";EX" LOAD S X=INP("MR") K i,jj,PAT Q
 ;
REFRESH I REFRESH="" S X="" Q
 G AP0^ZAA02GFORM4
 ;
DOB(D) Q:D<10 "" N (D,ZAA02G) D DATE Q DT
DATE S K=D>21608+305+D,Y=4*K+3\1461,D=K*4+3-(1461*Y)+4\4,M=5*D-3\153,D=5*D-3-(153*M)+5\5,M=M+2,Y=M\12+Y+1840,M=M#12+1,K="/",Y=Y*100+M*100+D,DT=$E(Y,5,6)_K_$E(Y,7,8)_K_$E(Y,1,4) Q
 ;
LKCC ; LOOKUP CCs
 S PROVC="c"_($G(n(1))+2) G LKPV
 ;
LKPV ; LOOKUP PROVIDER
 S X=$TR(X,"?*+"),FX="" G:x0["+" LKPVS2 G LKPV3:x0["?" S:X["," FX=$P(X,",",2),X=$P(X,",") G LKPV5:X_FX="",LKPV7:X
 D LKPV6 G:$T LKPV2
LKPV3 S GLB=x0,X=$TR(X,LC,UP),RX=0 D LKPVX,REFRESH I X[";EX"!(X="") G LKPV5
 I +X S X=+$E($P(^[DBASE]DI1D(+X,1),"|",17),2,9)_" "_$P(X,"|",2)
 E  S X=$P(X,"|",2)
LKPV2 S RX=1 D PROVSET I $S($G(x0)["*":1,$P(X," ")="":0,1:$D(@ZAA02GSCR@("PROV",$P(X," ")))=0) K FX G LKPVS
 I 1 K FX Q
LKPV5 I 1 S (X,INP("DR"),INP("DRI"))=""  K FX Q
LKPVS S NN=X D LLPVS S X=NN D REFRESH K NN,FX Q
LKPV6 I $D(@ZAA02GSCR@("PROV",+X))#2 S:X>0 X=+X_" "_$P(^(+X),"\",3)
 Q
LKPV7 S X=+X S:$L(X)<3 X=$E(X+1000,2,4) I $D(^[DBASE]DI0U(" "_X,1)) S X=+X_" "_$P(^(1),"|",2) G LKPV2
 K FX D LKPV6 G LKPV2
LKPVS2 D LKPV6 G LKPVS
 ;
LKPVX N (DBASE,ZAA02GSCR,X,FX,ZAA02G,ZAA02GP,GLB,REFRESH) S REFRESH="",Y="10,6\RHLGS\1\Providers\  Name                      #      HSI    FAX    ES  "
 S Y(0)="\EX\\$S(TO:$P(^[DBASE]DI1D(+TO,1),""|"",23),1:$P(TO,""|"",2));20`$S(TO:$P(^(1),""|"",17),1:"""");9`$S(TO:""Y"",1:"""");4`$S($P($G(@ZAA02GSCR@(""PROV"",S2)),$C(92),8)[""AF"":"" Y"",1:"""");3`"
 S Y(0)=Y(0)_"$S($P($G(^(S2)),$C(92),19)[""Y"":"" Y"",1:"""");3\"
 S:X]"" Y(0)=Y(0)_$E(X,1,$L(X)-1)_$C($A(X,$L(X))-1)_"z\\\"_X_"z" I X="",GLB["?" S $P(Y(0),"\",5)="A"
 S ZAA02GPOPALT="D LKPVT^ZAA02GSCRCH2" D ^ZAA02GPOP Q
LKPVT S S1=$P(TO,"|"),S=$P(TO,"|",2),S2="" S:S="" S=TO,S1=""
 I S1]"" S S1=$O(^[DBASE]DIBD(S,S1)) I S1]"" S S2=$TR($P($G(^(S1,1)),"|",5)," ") G LKPVT1
 S:GLB'["?" S1=$O(^[DBASE]DIBD(S)) S:S1="" S1="zzz" I S1]$O(@ZAA02GSCR@("PROV",S)),$O(^(S))'="" S S=$O(^(S)),(S1,S2)="" G LKPVT2
 I S1="zzz" S TO="" Q
 S S=S1,S1=$O(^[DBASE]DIBD(S,"")),S2=" " I S1 S S2=$TR($P($G(^(S1,1)),"|",5)," ")
LKPVT2 I S]TEN S TO="" Q
LKPVT1 S:S2="" S2=" " S TO=S1_"|"_S I FX]"",$E($P(S,",",2),1,$L(FX))'=FX G LKPVT
 Q
 ;
 ;  PROVIDER DATABASE EDIT
LLPVS ;
LLPVS1 N (ZAA02G,ZAA02GP,ZAA02GSCR,REFRESH,INP,NN,TRTYPE,LC,UP) S (X,REFRESH)="",Y="1,3\RHLYWD\1\Physician Information\\",Y(2)=NN_"*"
 F J=1,3:1:11 S Y(J)=$P("*,*,*,Signature Name:  *,Fax #:           *,Fax Qualifier:   *,Electronic Sign: *,*, (include ""AF"" on fax # for AutoFax)         *, (Qualifier - Site;Status;Type)*, (ES - Y/N;cosigner(s))",",",J)
 S (X1,X2,X3,X4)="",X0=$TR(NN,LC,UP) S:X0>0 X0=+X0 S OX0=X0 S:X0]"" X2=$G(@ZAA02GSCR@("PROV",X0)),X1=$P(X2,"\",3),X3=$P(X2,"\",18),X4=$P(X2,"\",19),X2=$P(X2,"\",8) S Y(4)=Y(4)_X1,Y(5)=Y(5)_X2,Y(6)=Y(6)_X3,Y(7)=Y(7)_X4 D ^ZAA02GPOP
LLPVS2 I OX0?1A.E S %R=5,%C=3,Y="30\HR\HRS\\DK,EX\",X=X0 D ^ZAA02GRDF S X0=$TR(X,LC,UP) G LLPVS3:ZAA02GF="EX"
LLPVS4 S %R=7,%C=20,Y="30\HR\HRS\\UK,DK,EX\",X=X1 D ^ZAA02GRDF S X1=X G LLPVS2:ZAA02GF="UK",LLPVS3:ZAA02GF="EX",LLPVS3:$G(TRTYPE)<2
LLPVS5 S %R=8,%C=20,Y="30\HR\RS\\UK,DK,EX\",X=X2 D ^ZAA02GRDF S X2=X G:ZAA02GF="UK" LLPVS4
LLPVS6 S %R=9,%C=20,Y="30\HR\RS\\UK,DK,EX\",X=X3 D ^ZAA02GRDF S X3=X G:ZAA02GF="UK" LLPVS5
LLPVS7 S %R=10,%C=20,Y="30\HR\RS\\UK,EX\",X=X4 D ^ZAA02GRDF S X4=X G:ZAA02GF="UK" LLPVS6
LLPVS3 I X1="",OX0]"" K @ZAA02GSCR@("PROV",OX0) S NN="" Q
 I OX0'=X0 S:X0]"" ^(X0)=@ZAA02GSCR@("PROV",OX0) K ^(OX0) S NN=X0
 I X0]"" S $P(@ZAA02GSCR@("PROV",X0),"\",3)=X1,$P(^(X0),"\",8)=X2,$P(^(X0),"\",18)=X3,$P(^(X0),"\",19)=X4
 Q
 ;
PROVSET ; SETUP PROVIDER NAME & INITIALS
 S T=$P($G(X)," ") Q:T=""  S (T,INP("DR"))=$P($G(@ZAA02GSCR@("PROV",T)),"\",3)
 S T=$P(T,","),INP("DRI")=$E(T)_$E($P(T," ",2))_$E($P(T," ",3))
 D ES K T Q
 ;
ES N Y,y I $S(+X=0:1,1:$E($P($G(@ZAA02GSCR@("PROV",+X)),"\",19))'="Y") Q:'$D(INP("eS"))  S $P(INP("eS"),"\",2+$G(eSn))="" G ES1
 I 1 S $P(INP("eS"),"\",2+$g(eSn))=+X_$E($P(^(+X),"\",19),2,99)
ES1 S $P(INP("eS"),"\")=$S($P(INP("eS"),"\",2,3)?.P:"",1:"Y")
 S id=$E($P(INP("eS"),"\")),opi="PDP;ES;id" X op K id Q
 ;
