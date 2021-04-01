ZAA02GADSMR ;ZAA02G Script interface for MR # lookups/no study;27APR93  11:32;29DEC94 10:49A;;18JAN99  11:15
 N K,K1,GR,PT,T,LDT,PLC
A S:$O(^MK(X,"")) X=$O(^(""))
 S K=X,K1=1 S:X["/" K=+X,K1=$P(X,"/",2)
 S INP("PATIENT")=""
 S INP("DOB")=""
 I K="" G LOAD
 S GR=$G(^GRG(K))    G:GR="" LOAD
 S PT=$G(^PTG(K,K1)) G:PT="" LOAD
 S T=$P(PT,":",3) S:T="" T=$P(GR,":",7) S INP("PATIENT")=T
 S T=$P(PT,":",12) S:T?6N INP("DOB")=$E(T,3,4)_"/"_$E(T,5,6)_"/"_$E(T,1,2) S:T?8N INP("DOB")=$E(T,5,6)_"/"_$E(T,7,8)_"/"_$E(T,1,4)
 I $D(INP("DT")) S INP("D")=$P("January,February,March,April,May,June,July,August,September,October,November,December",",",INP("DT"))_" "_$P(INP("DT"),"/",2)_", "_$S($P(INP("DT"),"/",3)<90:20,1:19)_$P(INP("DT"),"/",3)
 ;
LOAD ;;
 S INP("CONSULT")=""
 S INP("REV")="" ; REV is used to store CONSULT2
 S INP("CC1")=""
 S INP("CC2")=""
 S INP("DS")="" ;MP changed from FDY
 S INP("PROC1")=""
 S INP("PROC2")=""
 S (INP("MR"),INP("ACT"))=X I $D(PT),$P(PT,":",11)]"" S (X,INP("MR"))=$P(PT,":",11)
 Q
LOOKUP ; LOOKUP IN THE ADS PATIENT FILE BY NAME
 S X=$TR(X,LC_"?",UP) D:X[" " STRIP S PATD=$P(X,"/",2),PAT=$P(X,"/"),PT=$E($P(PAT,",",2)),PAT=$E($P(PAT,","),1,5),REFRESH=1 S:PT'?1U PT="" G:PAT="" LOOKE
 I $E($O(^PK(PAT)),1,$L(PAT))'=PAT G LOOKE
 I PT'="" S i=PAT F jj=1:1 S i=$O(^PK(i)) Q:i=""   Q:$E($O(^PK(i)),1,$L(PAT))=PAT&($E(i,6)=PT)  I $E($O(^PK(i)),1,$L(PAT))'=PAT G LOOKE
 D LOOK1 S tt=+REFRESH,td=$P(REFRESH,":",2) D AP0^ZAA02GFORM4
 I PAT[";EX" S X="" Q
 S X=$TR($P(PAT,"|",2,3),"|","/") S:X_" "["/1 " X=$P(X,"/") D LOAD^ZAA02GSCRADS S X=INP("PATIENT")
LOOKE K i,jj,PAT Q
 ;
LOOK1 N:1 (ZAA02G,ZAA02GP,PAT,PT,REFRESH) S Y="13,7\RLHS\1\PATIENT LOOKUP\   NAME                    DOB          MR #  "
 S Y(0)="\EX\\$S($L($P(^PTG(S2,S3),"":"",3)):$P(^(S3),"":"",3),1:$P(^GRG(S2),"":"",7));23`$$DOB^ZAA02GSCRADS($P(^PTG(S2,S3),"":"",12));10`$P(^(S3),"":"",11);8R\"_PAT_"\\\"_PAT_"z"
 S ZAA02GS1="S S=$P(TO,""|""),S2=$P(TO,""|"",2),S3=$P(TO,""|"",3)"
 S ZAA02GPOPALT=$P($T(LOOKT),";",2,99)
 D ^ZAA02GPOP S PAT=X Q
 ;
LOOKT ;X ZAA02GS1 F jj=1:1 S:S2_S3="""" S=$O(^PK(S)) S:jj=999 TO="""" S:S]TEN TO=""""  Q:TO=""""  I $E(S,6)[PT S:S3="""" S2=$O(^PK(S,S2)) S:$L(S2) S3=$O(^PK(S,S2,S3)) I $L(S3),$D(^PTG(S2,S3)) S TO=S_""|""_S2_""|""_S3 Q
 ;
