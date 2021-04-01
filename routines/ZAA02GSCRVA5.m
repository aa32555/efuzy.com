ZAA02GSCRVA5 ;PG&A,ZAA02G-SCRIPT,2.10,VA MODULES INTERFACE ;;;14DEC94 4:13P;26NOV97  16:41
 ;
 Q
PRINT ; HERE ON PRINT LOGIC FROM ^ZAA02GSCRIPT
 I $D(@VDOC@("REV")),^("REV")["|" D PRINT1
 Q
PRINT1 S REF=$P(^("REV"),"\",2,9),TYP=+REF,PID=$P(REF,"|",2)
 I TYP=5 D SURG Q
 I TYP=4 D AMIE Q
 K PID,REF,DA Q
PRINTE S DONE=1,$P(@VDOC,"\",3)=0,PG=0 Q  ; USE TO CANCEL PRINT
 ;
SURG S DA=$P(REF,"|",3) Q:DA=""
 S GLOB="^SRF(DA,12)" D STORE
 Q
 ;
AMIE S DA=+$P(REF,"|",3) Q:DA=""
 S GLOB="^DVB(396.4,DA,""RES"")" D STORE Q
 ;
 ;  REMAINDER NOT USED IN SA
 S ST=$P(^DVB(396.3,$P(^DVB(396.4,DA,0),"^",2),0),"^",18) Q:ST="R"
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
 ;
DT(dt) Q:dt="" "" Q 200+$P(dt,"/",3)*100+dt*100+$P(dt,"/",2)
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
 ;
 ;
DRUG ;  MEDICATIONS MACRO
 N (ZAA02G,ZAA02GP,REFRESH,INP,MC,ADDR,ZAA02GSCR,ZAA02GSCRP,DIR,DOC,ZAA02GWPD)
DR1 S MC="" Q:$P(ZAA02GSCRP,";",3)'=1
 S A=$TR(INP("MR"),"-"),A=$O(^DPT("SSN",A,"")) Q:A=""
 S MC=A,REFRESH=1
 S (A,B)="" F  S A=$O(^PS(55,MC,5,A)) Q:A=""  F  S B=$O(^PS(55,MC,5,A,1,"B",B)) Q:B=""  S A(B)=""
 S A="" F  S A=$O(A(A)) Q:A=""  S B=$E($P($G(^PSDRUG(A,0)),"^"),1,60) S:B]"" B(B)=""
 S Y="10,4\RLHS\1",Y(0)="15\EX\B\TO" D ^ZAA02GPOP S:X[";EX" X=""  S MC=$E(X)_$TR($E(X,2,99),"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 Q
