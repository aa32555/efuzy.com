ZAA02GFAXQP ;PG&A,ZAA02G-FAX,1.36,PRINT COPY;17AUG93 12:16P;;;18JAN99  14:55
 ;
A N (A,PTR) S DV=$P(PTR,"\"),Y=$P(PTR,"\",2)
 I DV]"",Y=""!(Y["ZAA02GFAXQP"),$D(^ZAA02GWP) S CP=1,PG="ALL",DOC="^ZAA02GFAXQ(""SRC"","_A_")",Y("XECUTE")="S HD="""_$S(Y="":"B^ZAA02GFAXQP",1:Y)_";*"",JOB="_A G QUEUE^ZAA02GWPP8
 I DV="",Y["ZAA02GFAXQP" Q
 G:Y]"" @Y Q:DV']""  O DV::0 E  Q
 U DV S JOB=A,APN=1 D B S A=.03,OFF=5 W !! F J=1:1 S A=$O(@DOC@(A)) W ?OFF,^(A),!
 C DV Q
 Q
B ; DEFAULT HEADER
 S:'$D(OFF) OFF=0 W *13,?OFF," ZAA02G-FAX Job: ",JOB,?OFF+22,"From: ",$E($P(^ZAA02GFAXQ("DIR",10000-JOB),"\",11),1,20),?OFF+60,$J("Pg "_APN_"/"_$P(^(10000-JOB),"\",9),10)
 W !?OFF," To: ",$E($P(^(10000-JOB),"\",13)_"  "_$P(^(10000-JOB),"\",32),1,50),?OFF+55,$J($P(^(10000-JOB),"\",4),15)
 W !?OFF," ",$P(^(10000-JOB),"\",3),?OFF+26,"Usage: ",$P(^(10000-JOB),"\",8),?OFF+45,$J("Sent: "_$P(^(10000-JOB),"\",7),25)
 W !?OFF F A=1:4:70 W "===="
 Q
C ; HEADER FOR CANON PRINTERS
 S:'$D(ZAA02G("d")) ZAA02G("d")=$S('$D(^("DATEF")):0,1:^("DATEF"))
 W *13,?4,"ZAA02G-FAX Job: ",JOB,?28,"Fax #: ",$P(^ZAA02GFAXQ("DIR",10000-JOB),"\",4),"  ",$P(^(10000-JOB),"\",5),?69,$J("PG "_APN_"/"_$P(^(10000-JOB),"\",9),10)
 W !,?4 I $P(^(10000-JOB),"\",3)'["Sen" W *27,"[7m ",$P(^(10000-JOB),"\",3)," ",*27,"[27m",*13
 E  W $P(^(10000-JOB),"\",3)
 D DATE W ?28,"Usage:",$P(^(10000-JOB),"\",8),?55,$J("Sent: "_$P($P(^(10000-JOB),"\",7)," ")_Y_$P($P(^(10000-JOB),"\",7)," ",2),24)
 W ! Q
 ;
D ; ALTERNATE LOGIC
 S DONE=1 Q
DATE S K=$P(^(10000-JOB),"\",28),K=K>21608+305+K,Y=4*K+3\1461,D=K*4+3-(1461*Y)+4\4,M=5*D-3\153,D=5*D-3-(153*M)+5\5,M=M+2,Y=M\12+Y+40,M=M#12+1,K="/" S:ZAA02G("d") K=M,M=D,D=K,K="." S Y=Y*100+M*100+D,DT=$E(Y,4,5)_K_$E(Y,6,7)_K_$E(Y,2,3),Y=Y-100 K K,M,D Q
 ;
