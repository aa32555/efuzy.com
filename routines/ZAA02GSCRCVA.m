ZAA02GSCRCVA ;PG&A,ZAA02G-SCRIPT,2.10,CHARLESTON VA ROUTINES;;;14DEC94 4:13P
 ;
DA ; SHOW DA TYPES VERSUS REPORT TEMPLATE
 S A=0 F J=1:1 S A=$O(^DVB(396.4,A)) Q:A'?1.N  S C=$P(^(A,0),"^",3) I $D(^DVB(396.6,C,0)) S B=+$P(^(0),"^",7) W B,?10 W:$D(^ZAA02GSCR(106,"a"_B)) ^("a"_B) W !
 Q
PRINT ; HERE ON PRINT LOGIC FROM ^ZAA02GSCRIPT
 I $D(@VDOC@("REV")),^("REV")["|" D PRINT1
 Q
PRINT1 S REF=$P(^("REV"),"\",2,9),TYP=+REF,PID=$P(REF,"|",2)
 I TYP=4 D AMIE Q
 I TYP=1 D GMR Q
 K PID,REF,DA Q
PRINTE S DONE=1,$P(@VDOC,"\",3)=0,PG=0 Q  ; USE TO CANCEL PRINT
 ;
AMIE S DA=$P($P(REF,"|",3),",",2) Q:DA=""
 S ST=$P(^DVB(396.3,$P(^DVB(396.4,DA,0),"^",2),0),"^",18) Q:ST="R"  S GLOB="^DVB(396.4,DA,""RES"")" D STORE
 S A=$$NX("^DVB(396.4)",DA,".04","C") ; set status = "C"
 ; S $P(^DVB(396.4,DA,0),"^",4)="C",R=$P(^(0),"^",3),^DVB(396.4,"APS",PID,R,"C",DA)="" K ^DVB(396.4,"APS",PID,R,"O",DA)
 I $D(@VDOC@("P3")) S $P(^DVB(396.4,DA,0),"^",7)=^("P3")
 I $D(@VDOC@("DS")) S $P(^DVB(396.4,DA,0),"^",6)=$$DT(@VDOC@("DS"))
AMIEML S U="^",REQDA=$P(^DVB(396.4,DA,0),"^",2),DFN=$P(^DVB(396.3,REQDA,0),"^"),REQDT=$P(^(0),"^",2),PNAM=$P(^DPT(DFN,0),"^"),SSN=$P(^(0),"^",9)
 S XMDUZ=.5,XMB="DVBA C 2507 DA READY",XMB(1)=PNAM,XMB(2)=SSN,Y=REQDT X ^DD("DD") S XREQDT=Y,XMB(3)=XREQDT D ^XMB K XMB,XREQDT,DFN,SSN,PNAM
 Q
AMT S XMDUZ=6565,DA=16933 D AMIEML W $G(XMZ) Q
 ;
FM ; Fileman indexing logic below
NX(F,DA,Y,X) ; UPDATE FIELD Y WITH VALUE X IN ITEM DA OF FILE F
 ;  Y=FIELD #, DA=LFN, F=^DD VALUE
 N dd,nx,j,U Q:'$D(@F@(0)) 0 S dd=+$P(^(0),"^",2) Q:'$D(^DD(dd,Y,0)) 0
 S nx=X,f=$P(^(0),"^",4),U="^" I $D(@F@(DA,$P(f,";")))#2 S X=$P(^($P(f,";")),"^",+$P(f,";",2)) I X]"" Q:nx=X 1 F j=0:0 S j=$O(^DD(dd,Y,1,j))  Q:j=""  I $D(^(j,2)) X ^(2)
 I nx]"" S $P(@F@(DA,$P(f,";")),"^",+$P(f,";",2))=nx,X=nx F j=0:0 S j=$O(^DD(dd,Y,1,j)) Q:j=""  I $D(^(j,1)) X ^(1) 
 Q 1
GMR S ODA=$P(REF,"|",3) Q:ODA=""  ; ^DGPT DA
 S DA=$O(^GMR(128,"AB",PID,1,9999999-($P(^DGPT(ODA,0),"^",2)\1),0)) I DA,$P(^GMR(128,DA,0),"^",11)'=ODA S DA=0
 I 'DA L +^GMR(128,0) S $P(^GMR(128,0),"^",3)=$P(^GMR(128,0),"^",3)+1,$P(^(0),"^",4)=$P(^(0),"^",4)+1,DA=$P(^(0),"^",3) L -^GMR(128,0) S ^GMR(128,DA,0)="",^("ACT")=""
 S X=1,A=$$NX("^GMR(128)",DA,".01",X) ; report type = DS
 S A=$$NX("^GMR(128)",DA,".02",PID) ; PLFN
 S X=$P($G(^DGPT(ODA,0)),"^",2),A=$$NX("^GMR(128)",DA,".07",X) ; admit date
 S X=$P($G(^DGPT(ODA,70)),"^"),A=$$NX("^GMR(128)",DA,".08",X) ; discharge date
 S A=$$NX("^GMR(128)",DA,".09","R") ; set URGENCY = "R"
 S X=$G(@DOC@(.011,"STATS")),LF=$P(@ZAA02GSCR@("PARAM","BASIC"),"|",4) F J=1:1:7 S @$E("CLWBSRT",J)=$P(X,",",J)
 S @("X="_LF),A=$$NX("^GMR(128)",DA,".1",X) ; line count
 S A=$$NX("^GMR(128)",DA,".11",ODA) ; PTF pointer
 S A=$$NX("^GMR(128)",DA,".14",1) ; upload flag = 1
 S DUZ=$P($G(@DOC@(.011)),"`",6),A=$$NX("^GMR(128)",DA,"1.01",DUZ) ; dictator duz
 S X=$G(@VDOC@("PROVIDER")) S:DUZ'="" X="" S A=$$NX("^GMR(128)",DA,"1.02",X) ; dictator free text name
 S X=$G(@VDOC@("DD")),A=$$NX("^GMR(128)",DA,"1.03",$$DT(X)) ; DD
 S X=$G(@VDOC@("TR")),A=$$NX("^GMR(128)",DA,"1.05",X) ; transcriptionist's DUZ ???
 S X=$G(@VDOC@("DT")),A=$$NX("^GMR(128)",DA,"1.06",$$DT(X)) ; DT
 S DUZ=$G(@VDOC@("P4")),A=$$NX("^GMR(128)",DA,"1.09",DUZ) ; attending duz
 S X=$G(@VDOC@("PROC2")) S:DUZ'="" X="" S A=$$NX("^GMR(128)",DA,"1.1",X) ; attending free text name
 S X=$G(@VDOC@("DT")),A=$$NX("^GMR(128)",DA,"1.19",$$DT(X)) ; release date
 K DUZ S GLOB="^GMR(128,DA,""TEXT"")" D STORE
 Q
 ;
DT(dt) Q:dt="" "" Q 200+$P(dt,"/",3)*100+dt*100+$P(dt,"/",2)
LOAD ;HERE BEFORE EDIT
 S TYP=+$P($G(INP("REV")),"\",2,9)
 I TYP=4  S A=$P($P(INP("REV"),"|",3),",",2) Q:A=""  S GLOB="^DVB(396.4,"_A_",""RES"")" L +^DVB(396.4,A,0):0 G:'T BUSY D:$D(@GLOB) FETCH Q
 I TYP=1  S ODA=$P(INP("REV"),"|",3) I ODA S DA=$O(^GMR(128,"AB",+$P(INP("REV"),"|",2),1,9999999-($P(^DGPT(ODA,0),"^",2)\1),0)) I DA,$P(^GMR(128,DA,0),"^",11)=ODA S GLOB="^GMR(128,"_DA_",""TEXT"")" L +^GMR(128,DA,0):0 G:'T BUSY D:$D(@GLOB) FETCH Q
 Q
LOCK D BUSY S LOCK=1 Q
FILE ;HERE AFTER EDIT
 S TYP=+$P($G(INP("REV")),"\",2,9)
 I TYP=4 S A=$P($P(INP("REV"),"|",3),",",2) Q:A=""  L -^DVB(396.4,A,0)
 I TYP=1 L -^GMR(128,DA,0)
 K ODA,DA,TYP Q
 ;
STORE ; STORE DOC TO GLOB IN FILEMAN WP FORMAT
 I '$D(XS) S XS=$C(27),XSL=5 I $D(@ZAA02GWPD@(.015)) S ZAA02G=^(.015),XS=$E(^ZAA02G(0,ZAA02G,"UO")),XSL=$L(^("UO"))
 S A=.03 F J=1:1 S A=$O(@ZAA02GWPD@(A)) Q:A=""  S B=$P(^(A),$C(1),4) D STOR1
 S A=$G(@VDOC@("DT")) I A]"" S A=200+$P(A,"/",3)*100+A*100+$P(A,"/",2)
 S J=J-1,@GLOB@(0)="^^"_J_"^"_J_"^"_A
 Q
STOR1 F L=1:1:$L(B,XS) S B=$P(B,XS)_$E($P(B,XS,2,99),XSL,255)
 S @GLOB@(J,0)=B Q
 Q
FETCH ; FETCH DOC FROM FILEMAN GLOB TO ZAA02GWPD
 S A=.03 F J=1:1 S A=$O(@ZAA02GWPD@(A)) Q:A=""  K ^(A)
 S L=$P(@GLOB@(0),"^",3),A=.03,B=0 F J=1:1:L S B=B+10,@ZAA02GWPD@(B)=A_$C(1,1,1)_@GLOB@(J,0),A=B
 Q
BUSY N (ZAA02G,ZAA02GP) S Y="20,10\RLYH\1\",Y(1)="Transcript File is BUSY by a DHCP user*",Y(2)="*",Y(3)="PRESS RETURN*",Y(0)="\EX\" D ^ZAA02GPOP Q
 ;
GMRF ; ^GMR(128) FORMAT RECORD
 ; 0)
 ;REPORT TYPE^PATIENT^^VALUE^FLAG^PARENT^ADMIT^DISCH^URGNCY^LINES^
 ;   1          2        4     5    6     7     8     9      10
 ;PTF #^TREATING SPEC^IRT #^CAP UPLOAD
 ; 11      12          13      14
 ; ACT)
 ;DICTATOR ID^FREE TEXT DICTATOR^DD^SIGN DT^TRANS ID^DT^VERIFY ID^
 ;     1              2           3      4     5      6     7
 ;VERIFY DT^ATTENDING ID^ATTENDING NAME^COSIGN DT^REJECT DT^AMEND ID^
 ;    8           9          10           11        12         13
 ;AMEND DT^AMEND SIGN^ARCH DT/TM^SIGN BY^SIGN MODE^TRANS REL DT^
 ;  14       15            16        17    18        19
 ;COSIGN ID^COSIGN MODE
 ;    20       21
 Q
