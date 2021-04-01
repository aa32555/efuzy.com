ZAA02GSCRMI2 ;PG&A,ZAA02G-SCRIPT,2.10,MIDS LOOKUP ROUTINE;9NOV94 4:30P;;;10NOV98  11:36
 ;
PUT N REC S REC=$G(^[DBASE]MIDS(X,0))
 ;
 S INP("ID")=X,opi=9,opi(5)="PDSP;AGE;"""_$$A_"""",opi(1)="PDSP;XMR;"""_$S(X=0:0,1:$P(REC,"^",6))_"""",opi(6)="PDSP;SEX;"""_$P(REC,"^",4)_"""",INP("DOB")=$$D($P(REC,"^",3))
 S opi(3)="PDSP;PATIENT;"""_$P($P(REC,"^"),"   ")_"""",dt=$P(REC,"^",16),dt=$S($D(NEWA):"",dt="":"",$D(^[DBASE]MIDIC(124,dt,0)):$P(^(0),"^"),1:""),opi(4)="PDSP;PROC2;"""_dt_""""
 S opi(2)="PDSP;TEMPLATE2;"""_$S($D(NEWA):0,1:$P(REC,"^",2))_"""",dt="" I $P($G(^[DBASE]MIDS(X,2)),"^")="" S dt=$P(REC,"^",12)
 E  S dt=$P(^(2),"^"),dt="("_$P("DIS,ADM,ADM,DIS,ADM,,ADM,ADM",",",$P(REC,"^",16))_": "_$E(dt,4,5)_"/"_$E(dt,6,7)_"/"_($E(dt,1,3)-200)_")"
 S:$D(NEWA) dt="" S opi(7)="PDSP;REV;"""_dt_""""
 S (INP("PROVA"),dt)=$P(REC,"^",8) S:dt="" (INP("PROVA"),dt)=$P(REC,"^",15)
 S dt=$S(dt="":"",$D(^[DBASE]MIDIC(1,dt,0)):$P(^(0),"^"),1:"") S:$D(NEWA) dt=$S(dt=$G(INP("PROVIDER")):dt,1:"") S opi(9)="PDSP;CONSULT;"""_dt_""""
 S dt=$P(REC,"^",13),dt=$S($D(NEWA):"",dt="":"",$D(^[DBASE]MIDIC(5,dt,0)):$P(^(0),"^"),1:""),opi(8)="PDSP;CONSULT2;"""_$P(dt,"(")_""""
 X op S IDX=2,ID=INP("PROVA") D FAXB^ZAA02GSCRER2
 I X'=0 s dt=","_$G(INP("SITEC"))_"," I ",CRA,SMI,SMR,CER,SJR,HCR,"[dt
 I  S HOSP=$P("SMY,1,2,3,4,5,6,SMY",",",$P(ZAA02GSCR,"ZAA02GSCR",2)+1) I HOSP]"" S MR=$P(REC,"^",6),AC=$P(REC,"^",2) I MR]"",AC]"",$D(^ORD(HOSP,MR,AC)) D ORD,REFRESH
 K dt,FX I 1 Q
 ;
D(X) Q:X>0 $E(X,4,5)_"/"_$E(X,6,7)_"/"_($E(X,1,3)-200) Q ""
A() N x S x=$P(REC,"^",3) G AG1
B() N X S x=$P(^(0),"^",3)
AG1 Q:x="" ""  S x=$P(INP("DT"),"/",3)+300*100+INP("DT")*100+$P(INP("DT"),"/",2)-x Q $E(x,1,3)-100
S(X) Q:X]"" $P($G(^[DBASE]MIDIC(124,X,0)),"^") Q ""
 ;
 ;
INDEX ; ADD INDEX TO ENTRIES IN ZAA02GPROV FILE
 S (A,B)=0 F J=1:1 S A=$O(^[DBASE]ZAA02GPROV(A)) Q:A=""  W A," ",^(A),!
 Q
 ;
 ;  PROVIDER DATABASE EDIT
LKPVS ; I x0["?" S REFRESH="",Y="5,3\RHGLS\1\",Y(0)="8\EX\^[DBASE]ZAA02GPROV\TO;20`$G(^[DBASE]ZAA02GPROV(TO));30\"_X_"\\\"_X_"~" D ^ZAA02GPOP Q:X[";EX"  S (NN,INP(PROVC))=X
LKPVS1 W *7 N (DBASE,ZAA02G,ZAA02GP,REFRESH,INP,NN,PROVC,TRTYPE,LC,UP) S (X,REFRESH)="",Y="1,3\RHLYWD\1\Physician Information\\",Y(2)=NN_"*"
 F J=1,3:1:10 S Y(J)=$P("*,*,*,Signature Name:  *,Fax #:           *,Fax Qualifier:   *,License #:       *,Report Download: *,Suppress Print:  *,*",",",J)
 F J=11:1:12 S Y(J)=$P(" (include ""AF"" on fax # for AutoFax)         *, (Qualifier - Site;Status;Type)*",",",J-10)
 S (X1,X2,X3,OX3,X4,OX5,X5,X6)="",(OX0,X0)=$TR(INP(PROVC),LC,UP) S:X0]"" X1=$G(^[DBASE]ZAA02GPROV(X0)),X2=$G(^[DBASE]ZAA02GPROV(X0,1)),(OX3,X3)=$P(X2,"`",2),X4=$P(X2,"`",3),(OX5,X5)=$P(X2,"`",4),X6=$P(X2,"`",5),X2=$P(X2,"`")
 S Y(4)=Y(4)_X1,Y(5)=Y(5)_X2,Y(6)=Y(6)_X4,Y(7)=Y(7)_X3,Y(8)=Y(8)_X5,Y(9)=Y(9)_X6 D ^ZAA02GPOP
LKPVS2 I OX0?1A.E S %R=5,%C=3,Y="30\HR\HRS\\DK,EX\",X=X0 D ^ZAA02GRDF S X0=$TR(X,LC,UP) G LKPVS3:ZAA02GF="EX"
LKPVS4 S %R=7,%C=20,Y="30\HR\HRS\\DK,EX\",X=X1 D ^ZAA02GRDF S X1=X G LKPVS3:ZAA02GF="EX",LKPVS3:$G(TRTYPE)<2
LKPVS4A S %R=8,%C=20,Y="30\HR\RS\\UK,DK,EX\",X=X2 D ^ZAA02GRDF S X2=X G:ZAA02GF="UK" LKPVS4
LKPVS4B S %R=9,%C=20,Y="30\HR\RS\\UK,DK,EX\",X=X4 D ^ZAA02GRDF S X4=X G:ZAA02GF="UK" LKPVS4A
LKPVS4C S %R=10,%C=20,Y="30\HR\RS\\UK,DK,EX\",X=X3 D ^ZAA02GRDF S X3=X G:ZAA02GF="UK" LKPVS4B
LKPVS4D S %R=11,%C=20,Y="30\HR\RS\\UK,EX\",X=X5 D ^ZAA02GRDF S X5=X G:ZAA02GF="UK" LKPVS4C
 S %R=12,%C=20,Y="30\HR\RS\\UK,EX\",X=X6 D ^ZAA02GRDF S X6=X G:ZAA02GF="UK" LKPVS4D
 ;
LKPVS3 I OX0'=X0,OX0]"" K ^[DBASE]ZAA02GPROV(OX0) K:OX3]"" ^[DBASE]ZAA02GPROV(0,OX3) K:OX5]"" ^[DBASE]ZAA02GPROV(.1,OX5,OX0)
 S INP(PROVC)=X0 S:X0'?1.N NN=X0 I X0="" S NN="" Q
 I OX0'=X0 S:OX3]"" ^[DBASE]ZAA02GPROV(0,OX3)=X0 S:OX5]"" ^[DBASE]ZAA02GPROV(.1,OX5,X0)=""
 S:X1_X2_X3_X4_X5]"" ^[DBASE]ZAA02GPROV(X0)=X1,^(X0,1)=X2_"`"_X3_"`"_X4_"`"_X5_"`"_X6 K:OX3'=X3&(OX3]"") ^[DBASE]ZAA02GPROV(0,OX3) S:X3]"" ^[DBASE]ZAA02GPROV(0,X3)=X0
 K:OX5'=X5&(OX5]"") ^[DBASE]ZAA02GPROV(.1,OX5,X0) S:X5]"" ^[DBASE]ZAA02GPROV(.1,X5,X0)=""
 Q
 ;
ORD N:1 (ZAA02G,ZAA02GP,HOSP,MR,INP,AC,REFRESH)
 S Y="5,7\RLHSG1D\1\ORDERS: "_$G(INP("PATIENT"))_" "_MR_"\  DATE     ORDER         PROCEDURE         PROVIDER      REPORT  ",REFRESH=""
 S Y(0)="10\EX\\$S(LS=S:$J($C(34),4),1:$E(S,5,6)_""/""_$E(S,7,8)_""/""_$E(S,3,4));8`S2;6`$P(^(S2),$C(96));20`$P(^(S2),$C(96),2);9`$P(^(S2),$C(96),3);10\"
 S ZAA02GPOPALT=$P($T(ORDT),";",2,99)
 S X="" D ^ZAA02GPOP
 S INP("ORDER")=HOSP_"|"_MR_"|"_AC_"|"_X
 Q
ORDT ;S S=$P(TO,""|""),S2=$P(TO,""|"",2),LS="""" S:S=0 S="""" F jj=1:1 S:S2="""" S=$O(^ORD(HOSP,MR,AC,S),-1) S:S="""" TO=""""  Q:TO=""""  S:$L(S) S2=$O(^ORD(HOSP,MR,AC,S,S2),-1) I $L(S2) S TO=S_""|""_S2 Q
 ;
REFRESH I REFRESH="" S X="" Q
 G AP0^ZAA02GFORM4
