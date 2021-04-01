ZAA02GSCRSRH ;PG&A;ZAA02G-SCRIPT;SUMTER REGIONAL HOSPITAL INTERFACE;;28APR99  09:31
 ; TEMPORARY INTERFACE TO SURGICAL PATH MACHINE
 ;
LKP S X=$TR(X,"?"),FX="" I X["," S FX=$P(X,",",2),X=$P(X,",") S:$E(FX)=" " FX=$E(FX,2,99)
 G:X_FX?." " LKP1 I X?1.NP,$L(X)>8 S FILE="^[DBASE]RNUM(""SSN"")" I X'["-" S X=X+1000000000,X=$E(X,2,4)_"-"_$E(X,5,6)_"-"_$E(X,7,10)
 I X?1.N,$L(X)<9 S X=+X,FILE="^[DBASE]RNUM(""AD"")"
 I X'?1.NP S FILE="^[DBASE]RNAM(0)"
 G:$G(FILE)="" LKP1 S RX=0 D LKPX,REFRESH I X[";EX"!(X="") S (INP("REV"),X)="" G LKP1
 S INP("REV")=$P(X,"|",3,4),X=$P(X,"|",3) D PUT S RX=2
LKP1 I 1 K FX,MRLK Q
LKPX K NEWA N:1 (X,FX,ZAA02G,ZAA02GP,FILE,DBASE,REFRESH,INP,NEWA) S Z=X_"z",Z1=X_"| " S:X="" Z1="@" I X?1.N.NP S (Z,Z1)=X ; S:X["-" Z1=$P(X,"-",1,2)_"-"_($P(X,"-",3)-1)
 S REFRESH="",Y="5,3\RHLGSD\1\Patients\         Name             SSAN#      Age  Sex    Admit    Acct#   "
 S Y(0)="\EX\\$S($L(S1):$J("""""""",10),1:^[DBASE]RPT(S3,""N""));20`$G(^[DBASE]RPT(S3,""SSN""));11`$$AGE^ZAA02GSCRSRH;3`$G(^(""S""));1`$ZD($P($G(^[DBASE]ADT(-S4)),""^"",17));8`$P($G(^(-S4)),""^"",7);9\"_Z1_"\\\"_Z
 ; W !,Y(0) R CCC
 D LOOK,POP Q
 ;
PUT S opi=10,opi(1)="PDSP;DOB;"""_$ZD(^[DBASE]RPT(X,"B"))_"""",opi(2)="PDSP;PATIENT;"""_^("N")_"""",dt=$G(^("SSN")) S:dt="" dt=$G(^("NU"))
 S opi(3)="PDSP;MR;"""_dt_"""",dt=-$P(INP("REV"),"|",2),dt=$G(^[DBASE]ADT(dt)),x=$P(dt,"^",17)
 S opi(4)="PDSP;ADMIT;"""_$S($L(x):$ZD(x),1:"\")_"""",x=$P(dt,"^",19)
 I $L(x) S opi(5)="PDSP;DISCH;"""_$ZD(x)_"""",opi(8)="PDSP;UNIT;"""""
 E   S opi(5)="PDSP;DISCH;""\""",opi(8)="PDSP;UNIT;"""_$P(dt,"^",13)_""""
 S opi(6)="PDSP;PT;"""_$P(dt,"^",8)_"""",opi(7)="PDSP;ACCT;"""_$P(dt,"^",7)_""""
 S x=$P(dt,"^",14),x=$G(^[DBASE]ZQD("SDMDA",+x,"MD")),opi(9)="PDSP;ADMITDR;"""_x_""""
 S x=$P(dt,"^",15),x=$G(^[DBASE]ZQD("SDMDA",+x,"MD")),opi(10)="PDSP;CONSULTANT;"""_x_""""
 K dt,x X op Q
AGE() N x S x=$G(^("B")) Q:x="" ""  Q $H-x\365.25
 ;
REFRESH Q:$G(REFRESH)=""  G AP0^ZAA02GFORM4
POP D ^ZAA02GPOP Q
 ;
LOOK S ZAA02GPOPALT="D LOOKT^ZAA02GSCRSRH" Q
LOOKT1 ;S S=$P(TO,""|""),S1=$P(TO,""|"",2),S2=$P(TO,""|"",3) F jj=1:1 S:S2="""" S=$O(@FILE@(S))  S:jj=999 TO="""" S:S="""" TO="""" S:S]TEN TO=""""  Q:TO=""""  S:$L(S) S2=$O(@FILE@(S,S2)) I $L(S2) S TO=S_""|""_S2 Q
 ;
LOOKT S S=$P(TO,"|"),S2=$P(TO,"|",2),S3=$P(TO,"|",3),S4=$P(TO,"|",4) I FILE["NUM" G LOOKT5:FILE["SSN" S S4=-S4 G LOOKT4
LOOKT2 I S2="" S S=$O(@FILE@(S)) S:S="" TO="" S:S]TEN TO="" G:TO="" LOOKT3
 I S3="" S S2=$O(@FILE@(S,S2)) G:S2="" LOOKT2 I FX'="" G:$E(S2,1,$L(FX))'=FX LOOKT2
 I S4="" S S3=$O(@FILE@(S,S2,"P",S3)) G:S3="" LOOKT2
 I S4="",$D(^[DBASE]RPT(S3,"ADT"))=0 S S1="",TO=S_"|"_S2_"|"_S3_"|?" Q
 S S1=S4,S4=$O(^[DBASE]RPT(S3,"ADT",S4)) G:S4="" LOOKT2 S TO=S_"|"_S2_"|"_S3_"|"_S4 Q
LOOKT3 Q
LOOKT4 S S4=$O(@FILE@(S,S4)) I S4="" S TO="" G LOOKT3
 S S1="",S4=^(S4),S3=+$G(^[DBASE]ADT(S4)) G:'S3 LOOKT3 S S4=-S4,TO=S_"|"_S2_"|"_S3_"|"_S4 Q
LOOKT5 S S3=$O(@FILE@(S,S3)) I S3="" S TO="" G LOOKT3
 S S1="",S4=$O(^[DBASE]RPT(S3,"ADT",S4)) G:S4="" LOOKT5 S TO=S_"|"_S2_"|"_S3_"|"_S4 Q
 ; 
 ; called from footer of report
DTTMX N (DTTM) S D=$H D DATE
 S TM=$P($H,",",2)\60,DTTM=DT_"  "_$E(TM\60+100,2,3)_":"_$E(TM#60+100,2,3) Q
 ;
DATE S K=D>21608+305+D,Y=4*K+3\1461,D=K*4+3-(1461*Y)+4\4,M=5*D-3\153,D=5*D-3-(153*M)+5\5,M=M+2,Y=M\12+Y-60,M=M#12+1,Y=Y+100*100+M*100+D,DT=$E(Y,6,7)_"-"_$P("JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEV",",",+$E(Y,4,5))_"-"_$E(Y,2,3) Q
 ;
 ; OBTAINS PATIENT INFO FOR MEDSPEAK INTERFACE
GET S DBASE="SUR,SYS" ;,X=$G(^[DBASE]RNUM("AD",ACCT,1)),dt=^[DBASE]ADT(X)
 K X S X=$G(INP("MR")) I X]"" S X=$O(^[DBASE]RNUM("SSN",X,"")) I X S x=$O(^[DBASE]RPT(X,"ADT","")) I x F  S X(x)="",x=$O(^(x)) q:x=""
 Q:$D(X)<2  S X=$O(X("")),dt=$G(^[DBASE]ADT(-X)) Q:dt=""
 S x=$P(dt,"^",17),INP("ADMIT")=$S($L(x):$ZD(x),1:"\"),x=$P(dt,"^",19) I $L(x) S INP("DISCH")=$ZD(x),INP("UNIT")=""
 E   S INP("DISCH")="\",INP("UNIT")=$P(dt,"^",13)
 S INP("PT")=$P(dt,"^",8),x=$P(dt,"^",14),x=$G(^[DBASE]ZQD("SDMDA",+x,"MD")),INP("ADMITDR")=x
 S x=$P(dt,"^",15),x=$G(^[DBASE]ZQD("SDMDA",+x,"MD")),INP("CONSULTANT")=x
 K dt,x Q
 ; S INP("DOB")=$ZD(^[DBASE]RPT(X,"B"))_"""",INP("PATIENT")=^("N"),INP("MR")=^("SSN")) S:INP("MR")="" INP("MR")=$G(^("NU"))S opi(3)="PDSP;MR;"""_dt_"""",dt=-$P(INP("REV"),"|",2),dt=$G(^[DBASE]ADT(dt))
