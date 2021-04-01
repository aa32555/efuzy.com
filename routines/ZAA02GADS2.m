ZAA02GADS2 ;;12/12/97;Ver 2.11;MG; 23 Oct 97  11:30AM
 ;
 I ^TRMG="DTM" S ^ZAA02GTMP($J,"TYPE")=$ZDEVTYPE,^ZAA02GTMP($J,"TAB")=$ZDEVIXXLATE
 ; saving translation tables codes into temporary global
 N  D ^SET
 D DIC
 W DOF I TRM="IBM",$L($P(^TRMG($I,1),":",3))>5 W /COLOR(15,1)
 I ^TRMG="DTM" U $I:TYPE=^ZAA02GTMP($J,"TYPE") U $I:IXXLATE=^ZAA02GTMP($J,"TAB")
 ; retun the ZAA02G's original translation table's codes
 X ^ZAA02G(.1,ZAA02G,1)
 Q
DIC ; ADS dictionary for ZAA02G-SCRIPT
 S INF="PAT"
 S T=$T(@INF),HDR=$P(T,";",3),N=+$P(T,";",4) S Y1=3,Y2=19,YY=Y1
 D HDR^BOX(40,77,Y1-1,Y2+1,HDR)
 F I=1:1:N S T=$T(@INF+I) D DIC1
 Q
DIC1 S X=41,Y=YY+I X XY W DOF,$P(T,";",3) S X=52 X XY W DON,$P(T,";",4)
 I I#(Y2-Y1-1)=0,I'=N S X=42,Y=Y2+1,YY=YY-(Y2-Y1-1) X XY W DOF,"Any Key for Next Page ESC to Exit" R T#1  Q:$ZB=Q  D CLR^BOX(41,76,Y1+1,Y2)
 Q
 ;;
PAT ;; ADS DICTIONARY FOR ZAA02G-SCRIPT ;47
 ;;~ACCT;Account #
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
 ;;~DG;Primary Diagnosis
 ;;~NOTES;Notes
 ;;~PV;Provider Name
 ;;~RF;Referral Name
 ;;~RFF;Referral First Name
 ;;~RFL;Referral Last Name
 ;;~RFA1;Referral's First Address
 ;;~RFA2;Referral's Second Address
 ;;~RFCS;Referral's City, State
 ;;~RFZP;Referral's Zip Code
 ;;~RFTL;Referral's Phone #
 ;;~CC1N;Referral Name
 ;;~CC1F;Referral First Name
 ;;~CC1L;Referral Last Name
 ;;~CC1A1;Referral's First Address
 ;;~CC1A2;Referral's Second Address
 ;;~CC1CS;Referral's City, State
 ;;~CC1ZP;Referral's Zip Code
 ;;~CC1TL;Referral's Phone #
 ;;~CC2N;Referral Name
 ;;~CC2F;Referral First Name
 ;;~CC2L;Referral Last Name
 ;;~CC2A1;Referral's First Address
 ;;~CC2A2;Referral's Second Address
 ;;~CC2CS;Referral's City, State
 ;;~CC2ZP;Referral's Zip Code
 ;;~CC2TL;Referral's Phone #
 ;;~CC3N;Referral Name
 ;;~CC3F;Referral First Name
 ;;~CC3L;Referral Last Name
 ;;~CC3A1;Referral's First Address
 ;;~CC3A2;Referral's Second Address
 ;;~CC3CS;Referral's City, State
 ;;~CC3ZP;Referral's Zip Code
 ;;~CC3TL;Referral's Phone #
 ;
