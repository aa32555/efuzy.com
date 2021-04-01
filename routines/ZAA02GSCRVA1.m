ZAA02GSCRVA1 ;PG&A,ZAA02G-SCRIPT,2.10,VA LOOKUP ROUTINE;22NOV94 9:34A;;;04FEB97  20:46
 ;;Copyright (C) Patterson, Gray and Associates, Inc.
 ;
PROV ; LOOKUP PROVIDER BY NAME IN VA(200)
 I X?1.N,$D(^VA(200,X,0)) S X=$P(^(0),"^")_"|"_X G PRV0
 K REFRESH I X["+" S X=$TR(X,"+") S PID="",PNM=X G PRV1
 S GLB="^VA(200,"""_$S(X["@":"B",1:"AK.PROVIDER")_""")",PID="",X=$TR(X,"?@"),FX="" I X["," S FX=$P(X,",",2),X=$P(X,",") S:$E(FX)'=" " FX=" "_FX
 S RX=0 ; I '$D(HELP) G:X_FX?." " PRV1
 K HELP D PRV2,REFRESH I X[";EX" S X="" G PRV1
 I X="" X "I 0" K FX Q
PRV0 S PID=$P(X,"|",2),(PNM,X)=$P(X,"|"),RX=1 I PID,$D(^VA(200,PID,20)),$P(^(20),"^",2)]"" S PNM=$TR($P(^(20),"^",2,3),"^"," ")
PRV1 I 1 K FX Q
PRV2 N:1 (X,FX,ZAA02G,ZAA02GP,GLB,REFRESH,INP,NEWA) S Z=X_"z" S:X="" X="@" I X?1.N S Z=X
 S REFRESH="",Y="18,3\RHLSD\1\NEW PERSON FILE\",Y(0)="\EX\\$P(TO,""|"");20`$P(TO,""|"",2);5R\"_X_"| \@=all persons, +=free text\\"_Z
 D LOOK,^ZAA02GPOP S:X="@" X="" Q
 ;         
PROVH S HELP=X,X=$S(X["@":"@",1:"")
PROVX I X?1A3.N G AUTO^ZAA02GSCRVA2
 D PROV S:RX INP("P3")=PNM,INP("CONSULT")=PID Q:ZAA02GSCRP'["s"  S id=1 D ES Q
PROVHY S HELP=X,X=$S(X["@":"@",1:"")
PROVY D PROV S:RX INP("P4")=PID,INP("PROC2")=PNM Q:ZAA02GSCRP'["s"  S id=2 D ES Q
 ;
 ; ALTERNATE PROVIDER LOGIC  - PROBABLY NOT USED
 ;
PRV4 S A=$O(^VA(200,"B",X,"")) Q:A=""  I $O(^(A))'="" S NM=X D PRV5 G:X[";EX" PRV6 S A=$P(X,$C(1)),X=NM
 S INP("CONSULT")=A I $D(^VA(200,A,20)),$P(^(20),"^",2)]"" S INP("P3")=$P(^(20),"^",2)
 E  S NM=X D PRV7 G:X[";EX" PRV6 S $P(^VA(200,INP("CONSULT"),20),"^",2)=X,INP("P3")=X,X=NM
 S INPS("PROVIDER")=X,INPS("P3")=INP("P3"),INPS("CONSULT")=INP("CONSULT")
 D:$D(REFRESH) REFRESH I 1 Q
PRV6 D REFRESH I 0
 Q
 ;
PRV5 N (X,ZAA02G,ZAA02GP,NM,REFRESH) S REFRESH="",Y="24,3\RHLV\1",Y(0)="\EX\^VA(200,""B"",NM)\TO_$C(1,32,32,1)_$P(^VA(200,TO,0),""^"",9)" D ^ZAA02GPOP Q
 Q
PRV7 N (X,ZAA02G,ZAA02GP,REFRESH) S REFRESH=1,Y="20,5\RHLY\1\MISSING DATA\\",Y(1)=X_"*",Y(2)="*",Y(3)="Enter Signature Name*",Y(4)="*",Y(5)="(First Middle Last, M.D.)           *",Y(6)="*",Y(7)="",Y(0)="\EX\",X="",UC=1 D ^ZAA02GPOP Q
 ;
REFRESH Q:$G(REFRESH)=""  G AP0^ZAA02GFORM4
 ;
LOOK S ZAA02GPOPALT=$P($T(LOOKT),";",2,99) S:$G(FX)]"" ZAA02GPOPALT=$P(ZAA02GPOPALT,"$L(S2)")_"$L(S2),"""" """"_$P(S,"""","""",2)[FX"_$P(ZAA02GPOPALT,"$L(S2)",2)
 S:$P(Y(0),"\",8)?1.N ZAA02GPOPALT=$TR(ZAA02GPOPALT,"]",">")
 Q
LOOKT ;S S=$P(TO,""|""),S2=$P(TO,""|"",2) F jj=1:1 S:S2="""" S=$O(@GLB@(S))  S:jj=999 TO="""" S:S="""" TO="""" S:S]TEN TO=""""  Q:TO=""""  S:$L(S) S2=$O(@GLB@(S,S2)) I $L(S2) S TO=S_""|""_S2 Q
 ;
VAR S J=0 I RX=99 S RX=9998 Q
 Q:X=""  S A="" Q:'$D(@ZAA02GSCR@(106,X))  S A=$P(^(X,.03),"\",15,19)
 S INP("PROC1")=$P(A,"\") I INP("PROC1")="" S INP("PROC1")="NA"
 S:$P(A,"\",2)'="" J=J+1,opi(J)="PDSP;NOTES;A("_J_")",A(J)=$P(A,"\",2) S:$P(A,"\",3)'="" J=J+1,opi(J)="PDSP;DIST;A("_J_")",A(J)=$P(A,"\",3) S:$P(A,"\",5)'="" J=J+1,opi(J)="PDSP;SITEC;A("_J_")",A(J)=$P(A,"\",5)
 I J S opi=J,SRF=rf,rf=ZAA02G("HI") x op S rf=SRF,RX=3 K SRF
 K A I 1 Q
 ;
 ; SAME AS VAR BUT NO SITE & PROC1  UPDATE
VAR1 S J=0 I RX=99 S RX=9998 Q
 Q:X=""  S A="" Q:'$D(@ZAA02GSCR@(106,X))  S A=$P(^(X,.03),"\",15,19)
 ; S INP("PROC1")=$P(A,"\") I INP("PROC1")="" S INP("PROC1")="NA"
 S:$P(A,"\",2)'="" J=J+1,opi(J)="PDSP;NOTES;A("_J_")",A(J)=$P(A,"\",2) S:$P(A,"\",3)'="" J=J+1,opi(J)="PDSP;DIST;A("_J_")",A(J)=$P(A,"\",3)
 I J S opi=J,SRF=rf,rf=ZAA02G("HI") x op S rf=SRF,RX=3 K SRF
 K A I 1 Q
 ;
SAVE F A="NOTES","DIST","SITEC","PROC1","UNIT","PROVIDER","P3","CONSULT","PROC2","DD","TEMPLATE" S INPS(A)=$G(INP(A))
 Q
 ;   SITE USED BY SAN ANTONIO PRINT LOGIC
SITE I $D(^ZAA02GWP(.9,DP,XDC,"SITE"))=0 S SITE=$G(^("SITEC")) I SITE]"" S ^ZAA02GWP(.9,DP,XDC,"SITE")=$G(^ZAA02GSCR("PARAM","SITE",SITE))
 I $G(^ZAA02GWP(.9,DP,XDC,"PROC2"))]"" S ^("PROC2")=" "_^("PROC2")
 I $D(^ZAA02GWP(.9,DP,XDC,"P3")),^("P3")]"" S ^("PROVIDER")=^("P3")
 Q
 ; CHARLESTON
SITE1 I $D(^ZAA02GWP(.9,DP,XDC,"P3")),^("P3")]"" S ^ZAA02GWP(.9,DP,XDC,"PROVIDER")=^("P3")
 I $G(^ZAA02GWP(.9,DP,XDC,"PROC2"))]"" S ^("PROC2")=" / "_^("PROC2")
 ; I $D(^ZAA02GWP(.9,DP,XDC,"PROC2"))=0 S T=$G(^("P4")) I T]"",$D(^VA(200,T,20)),$P(^(20),"^",2)]"" S ^ZAA02GWP(.9,DP,XDC,"PROC2")=$P(^(20),"^",2)
 S ^ZAA02GWP(.9,DP,XDC,"SITE")="VAMC CHARLESTON"
 Q
RAD ; RADIOLOGY INTERFACE
 D RAD1,REFRESH G LKAD1^ZAA02GSCRVA
RAD1 N (X,ZAA02G,ZAA02GP,REFRESH) S REFRESH=1,Y="20,5\RHLY\1\MISSING DATA\\",Y(1)=X_"*",Y(2)="*",Y(3)="Enter Signature Name*",Y(4)="*",Y(5)="(First Middle Last, M.D.)           *",Y(6)="*",Y(7)="",Y(0)="\EX\",X="",UC=1 D ^ZAA02GPOP Q
 ;
ES ; from prov lookup
 N Y,y Q:'$T   I $S(+PID=0:1,1:$P($G(^VA(200,PID,7)),"^",2)'="Y") Q:'$D(INP("eS"))  S $P(INP("eS"),"\",id+1)="" G ES1
 S Y="",y="" F  S Y=$O(^VA(200,PID,8,"B",Y)) Q:Y=""  S y=","_Y_y
 I 1 S $P(INP("eS"),"\",id+1)=PID_y
ES1 S $P(INP("eS"),"\")=$S($P(INP("eS"),"\",2,3)?.P:"",1:"Y")
 S id=$E($P(INP("eS"),"\")),opi="PDP;ES;id" X op K id Q
ESALERT Q:'$D(^XTV)  S %R=22,%C=1 W @ZAA02GP N (A,INP) D DT^DICRW S U="^",XQA(A)="",XQAMSG="Report for "_$G(INP("PATIENT"))_" is ready for signature",XQAROU="AUT^ZAA02GSCRVW" D SETUP^XQALERT
 Q
