ZAA02GADS ;ZAA02GWP INTERFACE WITH ADS  ;2014-07-10 17:23:46
 S ZAA02GL=ZAA02G(1),ZAA02G(1)=1 X ^ZAA02G("TERM-OFF")
 I ^TRMG="DTM" S ^ZAA02GTMP($J,"TYPE")=$ZDEVTYPE,^ZAA02GTMP($J,"TAB")=$ZDEVIXXLATE
 ; saving translation tables codes into temporary global
 S NX=TL+1
 I B=18 D ^WWPP5
 I B=19 D DIC
 I B=20 D ENV
 I B=21 D ADSET
 S B=0,%R=2,%C=22   D RESET
 I ^TRMG="DTM" U $I:TYPE=^ZAA02GTMP($J,"TYPE") U $I:IXXLATE=^ZAA02GTMP($J,"TAB")
 S ZAA02G(1)=ZAA02GL-1 X ^ZAA02G("TERM-ON")
 X ^ZAA02G(.1,ZAA02G,1)
 ; retun the original translation table's codes
 G SCHG^ZAA02GWPVB
 Q
RESET N  D ^SET W DOF I TRM="IBM",$L($P(^TRMG($I,1),":",3))>5 W /COLOR(15,1)
 Q
ADSET ; set up default quetions for ADS interface
 N  D ^SET
 D HDR^BOX(5,76,21,23," ADS Setup ")
 D RD^BOX(5,76,22," Print Envelope for: {G}aurantor  {P}atient  {R}eferral  {T}ext  {O}ptional : ","GPRTO",1) Q:$ZB=Q  S ^ZAA02GADS("ENV")=A
 D RD^BOX(5,76,22," Print Entity Info.: {A}lways  {N}ever  {O}ptional : ","ANO",1) Q:$ZB=Q  S ^ZAA02GADS("ENT")=A
ADSET1 D RD^BOX(5,76,22," Printer Number [{1-99}]always   {O}ptional : ","",2) Q:$ZB=Q  S:A="" A="O" I A'="O",'$D(^LPT(A)) W *7 G ADSET1
 S ^ZAA02GADS("LPT")=A
 Q
ENV ; Print envelopes
 N   ;A,BL,B,C,DIR,I,J,M,N,X,U,XX,FK,%R,%C,DOC,E,NX,KEY,OPT,AD,T,CL22,CL23
 D ^SET
 I $D(^ZAA02GADS("ENV"))'=1 S ^ZAA02GADS("ENV")="O"
 I $D(^ZAA02GADS("ENT"))'=1 S ^ZAA02GADS("ENT")="O"
 I $D(^ZAA02GADS("LPT"))'=1 S ^ZAA02GADS("LPT")="O"
 D HDR^BOX(10,76,21,23," Print Envelope ")
ENV1 S OPT=^ZAA02GADS("ENV")
 I OPT="O" D RD^BOX(10,76,22," {G}uarantor Addr.  {P}atient Addr.  {R}eferral Addr.  {T}ext  {Q}uit : ","GPRTQ",1) Q:$ZB=Q!(A="Q")
 I OPT="O" S OPT=A
 F I=1:1:5 S AD(I)=""
 I OPT="G"!(OPT="P")  D ENV2  Q:$ZB=Q!(K="")  S T=^GRG(K) S AD(1)=$P($P(T,":",7),",",2)_" "_$P($P(T,":",7),",",1) S:$E(AD(1),1)=" " AD(1)=$E(AD(1),2,$L(AD(1))) S AD(2)=$P(T,":",8),AD(3)=$P(T,":",9),AD(4)=$P(T,":",10)_" "_$P(T,":",11)
 I OPT="P" D ENV3  Q:$ZB=Q  I K1>1 S T=^PTG(K,K1),AD(1)=$P($P(T,":",3),",",2)_" "_$P($P(T,":",3),",",1) S:$E(AD(1),1)=" " AD(1)=$E(AD(1),2,$L(AD(1))) S AD(2)=$P(T,":",4),AD(3)=$P(T,":",5),AD(4)=$P(T,":",6)_" "_$P(T,":",7)
 I OPT="R" D ENV2  Q:$ZB=Q  D ENV3 Q:$ZB=Q  S T=$P(^PTG(K,K1),":",16) I T'="",$D(^RFG(T)) S T=^(T) D TTL S AD(2)=$P(T,":",4),AD(3)=$P(T,":",5),AD(4)=$P(T,":",6)_" "_$P(T,":",7)
 I OPT="G"!(OPT="P")!(OPT="R"),AD(3)="" S AD(3)=AD(4),AD(4)=""
 I OPT="T" D ENV8
 I OPT="T" Q:$ZB=Q!(A="Q")
 S ENT=^ZAA02GADS("ENT")  D:OPT="T" HDR^BOX(10,76,21,23," Print Envelope ")
 I ENT="O" D RD^BOX(10,76,22," Print Entity Address [{Y/N}]: ","",1)  I A="Y" S ENT="A"
 S PRM="" I ENT="A",$D(EZ),EZ'="",$D(^PRMG(EZ,1)) S PRM=^(1)
 D ENV6
 Q
ENV2 S K="" D RD^BOX(10,76,22," Enter Account Number: ","",8) Q:A=""!($ZB=Q)
 I '$D(^GRG(A))!(A<100) W *7 G ENV2
 S K=A
 Q
ENV3 S K1=1 I $P(^GRG(K),":",2)>1 D RD^BOX(48,76,22,"Patient Number: ","",3) Q:$ZB=Q  S:A'="" K1=A I '$D(^PTG(K,K1)) W *7 G ENV3
 Q
ENV4 S X=26,Y=16+I,L=38  X XY W DON,I,". ",DOF S X=29 D ^RD S AD(I)=CH
 Q
ENV8 D HDR^BOX(25,70,15,23," Enter Text to Print on Envelope ") F I=1:1:5 S CH="" D ENV4 Q:$ZB=Q
 F I=1:1 D RD^BOX(25,70,22,"Enter  [{1-5}]update   [{C}]ontinue   [{Q}]uit: ","12345CQ",1) Q:$ZB=Q!(A="Q")!(A="C")  S I=A,CH=AD(I) D ENV4
 Q
ENV5 Q
ENV6 S PR=^ZAA02GADS("LPT") I PR="O" D RD^BOX(10,76,22," Enter Printer Number: ","",3) Q:$ZB=Q  S PR=A I A="" W *7 G ENV6
 I '$D(^LPT(PR)) W *7 G ENV6
 D ^PRNTR Q:ZVD>1  X USEPR X $P(^LPT(LPT,1),":",2)
 W ?1,$P(PRM,":",2),!?1,$P(PRM,":",3),!?1 W:$P(PRM,":",4)'="" $P(PRM,":",4),!?1,$P(PRM,":",5) W:$P(PRM,":",4)="" $P(PRM,":",5)
 W !!!!!! F I=1:1:5 W !?40,AD(I)
 X USEPR X $P(^LPT(LPT,1),":",4) W # X USEIO C:PR'=IO PR
 Q
TTL ; Extract referral name and titel
 N I,F,L,NM,N1,N2,TT S NM=$P(T,":",2),N1=$P(NM,",",2),N2=$P(NM,",",1) S:$E(N1,1)=" " N1=$E(N1,2,$L(N1))
 S TT=" MD: MD.: .MD: M.D: M.D.",F=0,L=""
 F I=1:1:5 S L=$P(TT,":",I),F=$F(N1,L) S:F'=($L(N1)+1) L="" I F=($L(N1)+1) S N1=$P(N1,L,1) Q
 S AD(1)=N1_" "_N2_L ; I F S AD(1)=AD(1)_L
 Q
DIC ; ADS dictionary for ZAA02GWP
 N A,BL,B,C,DIR,I,J,M,N,X,U,XX,FK,%R,%C,DOC,E,NX,KEY
 D ^SET K CL0,CL1,CL22,CL21,CL23,CLINE
 D HDR^BOX(10,73,21,23," ADS Dictionary ")
RD D RD^BOX(10,73,22," {G}uarantor info.  {P}atient info.  {I}nsurance info.  {Q}uit : ","GIPQ",1) Q:$ZB=Q!(A="Q")
 S INF=$S(A="G":"GRN",A="P":"PAT",A="I":"INS",1:0)
 Q:INF=0  S T=$T(@INF),HDR=$P(T,";",3),N=+$P(T,";",4) S Y1=3,Y2=19,YY=Y1
 D HDR^BOX(40,77,Y1-1,Y2+1,HDR)
 F I=1:1:N S T=$T(@INF+I) S X=41,Y=YY+I X XY W DOF,$P(T,";",3) S X=52 X XY W DON,$P(T,";",4) I I#(Y2-Y1-1)=0,I'=N S X=42,Y=Y2+1,YY=YY-(Y2-Y1-1) X XY W DOF,"Any Key to NextPage  ESC to Exit" R T#1  Q:$ZB=Q  D CLR^BOX(41,76,Y1+1,Y2)
 G RD
GRN ;;Guarantor Information;15
 ;;~ACCT;Account #
 ;;~ENT;Entity Name
 ;;~GN;Guarantor Name
 ;;~GA1;Guarantor First Address
 ;;~GA2;Guarantor Second Address
 ;;~GZP;Guarantor Zip Code
 ;;~GTL;Guarantor Tel #
 ;;~EMP;Guarantor Tel #
 ;;~MSCIN;Miscellaneous Inf.
 ;;~DTY;Today Date
 ;;~RCD;Recall Date
 ;;~ADM;Admission Date
 ;;~DSG;Discharge Date
 ;;~LPY;Date of Last Payment
 ;;~LST;Date of Last Statemnn
INS ;;Insurance Information;10
 ;;~MDCR;Medicare #
 ;;~MDCD;Medicaid #
 ;;~BLSH;Blueshield #
 ;;~BLGP;Blueshield Group #
 ;;~INS4;Insurance 4 #
 ;;~INS5;Insurance 5 #
 ;;~INS6;Insurance 6 #
 ;;~BAL;Total Balance
 ;;~CBAL;Total Collection Bal
 ;;~AGBAL;Aged Balance
PAT ;;Patient Information;28
 ;;~PNUM;Patient's Number
 ;;~PN;Patient's Name
 ;;~PA1;Patient's First Address
 ;;~PA2;Patient's Second Address
 ;;~PCS;Patient's City, State
 ;;~PZP;Patint's Zip Code
 ;;~PTL;Patient's Telephone #
 ;;~SSN;Patient's Soc. Sec. #
 ;;~SEX;Patient's Sex
 ;;~STM;Patient's Med. Rec. #
 ;;~BDT;Patient's Birthdate
 ;;~PV;Provider Name
 ;;~RF;Referral Name
 ;;~RFF;Referral First Name
 ;;~RFL;Referral Last Name
 ;;~RFA1;Referral's First Address
 ;;~RFA2;Referral's Second Address
 ;;~RFCS;Referral's City, State
 ;;~RFZP;Referral's Zip Code
 ;;~RFTL;Referral's Phone #
 ;;~DG;Primary Diagnosis
 ;;~AR;Accounts Receivable Class
 ;;~SPA;Special Field A
 ;;~SPB;Special Field B
 ;;~SPC;Special Field C
 ;;~NOTES;Notes
 ;;~NA1-~NA12;Notes Fields 1 to 12
 ;;~NB1-~NB12;Notes 1 Fields 1 to 12
