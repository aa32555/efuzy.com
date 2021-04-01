ZAA02GSCRLK ;PG&A,ZAA02G-SCRIPT,2.10,MISC LOOKUP ROUTINE;11NOV92  01:22
 ;
 ;  LOOKUP PATIENT BY NAME
LKP S X=$TR(X,"?"),NM=X G:X="" LKP1 I $D(^LISTN(X))=0,$E($O(^LISTN(X)),1,$L(X))'=X G LKP1
 S X=NM D LKPX I X[";EX"!(X="") S X="" G LKP1
 S dt=X+45000 D DATE S opi=2,opi(1)="PDS;DOB;"""_DT_"""",X=X+555000000,X=$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,9),opi(2)="PDS;MR;"""_X_"""",X=NM
 S RX=2 X op K dt,DT
LKP1 D:$D(REFRESH) REFRESH I 1 K NM Q
LKPX N:1 (X,ZAA02G,ZAA02GP,NM,REFRESH) S REFRESH="",Y="10\RHLV\2",Y(0)="\EX\^LISTN\$P(TO,""`"")_$C(1,32,32,1)_$P(TO,""`"",2)\"_X_"\\\"_X_"z" D ^ZAA02GPOP
 Q:X["EX;"  Q:X=""  S NM=$P(X,$C(1)),X=$P(X,$C(1),3) Q
 ;
GET K ^LISTN S A="" F J=1:1 S A=$O(^ZAA02GSCR("TRANS",A)) Q:A=""  I $D(^(A,.011)),$P(^(.011),"`",7)[" " S B=$P(^(.011),"`",7),^LISTN(B_"`"_A)="" W B," "
 Q
 ;
PROV ; LOOKUP PROVIDER BY NAME
 K REFRESH S X=$TR(X,LC_"?",UP) Q:X=""  S NM=$S($D(^DIC(16,"A6",X)):X,1:$O(^(X))) G:$E($O(^(NM)),1,$L(X))=X PRV0 S X=NM I $O(^($O(^DIC(16,"A6",X,""))))="" G PRV1
PRV0 D PRV2 I X[";EX"!(X="") S X=""
PRV1 S X=$P(X,",",2)_" "_$P(X,",")_$S($P(X,",",3)'="":" "_$P(X,",",3,9),1:""),RX=0
 D:$D(REFRESH) REFRESH I 1 K NM Q
PRV2 N:1 (X,ZAA02G,ZAA02GP,REFRESH) S REFRESH=1,Y="10\RHLS\1",Y(0)="\EX\^DIC(16,""A6"")\TO\"_X_"\\\"_X_"z" D ^ZAA02GPOP Q
 Q
REFRESH G AP0^ZAA02GFORM4
 ;
TN R X,! G LKP
TP R X,! G PROV
DATE S K=dt>21608+305+dt,y=4*K+3\1461,D=K*4+3-(1461*y)+4\4,M=5*D-3\153,D=5*D-3-(153*M)+5\5,M=M+2,y=M\12+y+140,M=M#12+1,K="/" S:ZAA02G("d") K=M,M=D,D=K,K="." S y=y*100+M*100+D,DT=$E(y,4,5)_K_$E(y,6,7)_k_$E(y,2,3) K K,M,D
 Q
 ;
LKAD ; LOOKUP PATIENT BY SSAN
 Q:X=""   Q:$D(^ZAA02GSCR("TRANS",X))=0
LKAD0 S dt=45000+X D DATE S opi=2,opi(1)="PDSP;PATIENT;"""_$P($P(^(X),"`",4),"~")_"""",opi(2)="PDSP;DOB;"""_DT_"""",X=555000000+X,RX=3 X op K dt
LKAD1 I 1 Q
 Q
