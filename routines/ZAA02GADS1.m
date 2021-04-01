ZAA02GADS1 ;08JUL92  18:44;8NOV94 12:28P;;;Fri, 12 Apr 2019  11:37
 ; ZAA02G SCRIPT Interface with ^ZAA02GWP ;10/01/91
 ; Load INP array with data
 ; Should NOT overwrite data already in INP(VAR)
 N (INP,ALLVAR,EZ,VDOC,DP,XDC)
 ;
 D p
 S (CC1G,CC2G,CC3G,RFG,GFG)="" ; D FNDRF
 S INP("PROVIDER")=$G(INP("PROVIDER"))
 S T=$G(INP("CONSULT")) S:T'="" RFG=$G(^RFG(T)) I $P(RFG,":",37)]"" S GFG=$G(^EMPG($P(RFG,":",37)))
 S T=$G(INP("CC1")) S:$P(T," ")'="" CC1G=$G(^RFG($P(T," ")))
 S T=$G(INP("CC2")) S:$P(T," ")'="" CC2G=$G(^RFG($P(T," ")))
 S T=$G(INP("CC3")) S:$P(T," ")'="" CC3G=$G(^RFG($P(T," ")))
 S T=$G(INP("FDY")) I $E(T)="W" S T=$P($E(T,2,999),","),study=$G(^WRKFLW($P(T,"|"),$P(T,"|",3),K,K1,$P(T,"|",4)))
 ;
 F I=1:1 S VAR=$P(ALLVAR,",",I) Q:VAR=""  D VAR
 Q
 ; I $G(INP("CC"))'="",$G(INP("CC1N"))_$G(INP("CC2N"))_$G(INP("CC3N"))="" K INP("CC")
 ; I $G(INP("CC"))'="",$G(INP("CC1N"))="",$G(INP("CC2F"))="",$G(INP("CC3F"))="" S INP("CC")=""
 ; I $G(INP("CC"))'="",$G(INP("CC1N"))="",$G(INP("CC2L"))="",$G(INP("CC3L"))="" S INP("CC")=""
 Q
VAR Q:VAR=""  Q:VAR'?1.AN  I $E(VAR,1,2)'="MT" Q:$T(@VAR)=""  D @VAR
 I $E(VAR,1,2)="MT" D MT
 I T=" " S INP(VAR)=" " Q
 S j=$TR(T," ",""),j=$E(j,$L(j)),INP(VAR)=$E(T,1,$L($P(T,j,1,$L(T,j)-1)_j))
 Q
 ;
DSL S T=$G(INP("DS")) S:T="" T=$G(INP("DT")) S:T]"" T=$P("January,February,March,April,May,June,July,August,September,October,November,December",",",T)_" "_(+$P(T,"/",2))_", "_$S($P(T,"/",3)<90:20,$P(T,"/",3)>100:"",1:19)_$P(T,"/",3) Q
DTY S T=$ZD($H) Q
FDYxx Q  ; INP("FDY") Film's date is being set in ^ZAA02GSCRADS
FNOxx Q  ; INP("FNO") Film's Number is being set in ^ZAA02GSCRADS
FNO I $D(INP("FNO")) S T=INP("FNO") Q  ;  or SJ compatiblility
 S T="" Q
FNB I $D(INP("FDY"))  S T=INP("FDY") I $P(T,"|",4)]"",$D(^STUDU($P(T,"|"),+INP("MR"),1,$P(T,"|",2),$P(T,"|",3))) S T=$P(^($P(T,"|",3)),":",14) Q
 S T="" Q
DX I $D(INP("FDY"))  S T=INP("FDY") I $P(T,"|",4)]"",$D(^STUDU($P(T,"|"),+INP("MR"),1,$P(T,"|",2),$P(T,"|",3),$P(T,"|",4))) S T=$P(^($P(T,"|",4)),":",3) I T]"" S T=$P($G(^DGG(T)),":",2) Q
 S T="" Q
DX1 S T=$G(INP("DIAG1")) Q:T=""  S T=$P($G(^DGG(T)),":",2) Q
DX2 S T=$G(INP("DIAG2")) Q:T=""  S T=$P($G(^DGG(T)),":",2) Q
DXW D study S T=$P(T,"`",2) Q:T=""  S T=$P($G(^DGG(T)),":",2) Q
 ;
XRN S T=$G(INP("SITEC")) Q:T=""  N J,L S L=$G(^PTG(K,K1,2)) F J=1:1:20 I $E($P(L,":",J))=$E(T) S T=$P(L,":",J) Q
 S:J=20 T="" Q
NO6 S T=$P($G(^PTG(K,K1,2)),":",6) S:T]"" T="ACC#: "_T Q
CASE S T=$G(INP("FDY")) I $E(T)'="W" S T="" Q
 S ss=$E(T,2,999),T="" F  S s1=$P(ss,","),ss=$P(ss,",",2,9) Q:s1=""  I $P($G(^WRKFLW($P(s1,"|"),$P(s1,"|",3),K,K1,$P(s1,"|",4))),"`",58)]"" S T=$P($P(^($P(s1,"|",4)),"`",58),"  ",2,9) Q:T]""
 Q
ANOTE S T=$G(INP("FDY")) I $E(T)'="W" S T="" Q
 S ss=$E(T,2,999),T="" F  S s1=$P(ss,","),ss=$P(ss,",",2,9) Q:s1=""  S sw=$G(^WRKFLW($P(s1,"|"),$P(s1,"|",3),K,K1,$P(s1,"|",4))) I sw]"" D
 . S sr=$P(sw,"`",24) I sr]"" S sr=$G(^ZAA02GSCH(1,"PARAM","XRES",sr)) I sr]"" S sa=$G(^ZAA02GSCH(1,"DET",sr,$P(s1,"|",3),$P($P(s1,"|",4),"-"),$P($P(s1,"|",4),"-",2))),sn=$P(sa,"`",21) I sn?3.N.E D
 .. N j F j=1:1:$L(sn)+1 I $E(sn,j)'?1N S T=T_" "_$E(sn,1,j-1) Q
 S:T]"" T="ACC#: "_$E(T,2,99) Q
 ;
ANTt S AA="" F  S AA=$O(^ZAA02GSCR("TRANS",AA),-1) Q:AA=""  S B=$P($G(^(AA,.011)),"`",9) I B]"" S K=+B,K1=$P(B,"\",2) S:K1="" K1=1 I $D(^(.011,"FDY")) S INP("FDY")=^("FDY") D ANOTE^ZAA02GADS1 I T]"" W T," - ",AA,"   " R CCC
 Q
ANOTE2 S T=$G(INP("FDY")) I $E(T)'="W" S T="" Q
 S ss=$E(T,2,999),T="" F  S s1=$P(ss,","),ss=$P(ss,",",2,9) Q:s1=""  S sw=$G(^WRKFLW($P(s1,"|"),$P(s1,"|",3),K,K1,$P(s1,"|",4))) I sw]"" D
 . S sr=$P(sw,"`",24) I sr]"" S sr=$G(^ZAA02GSCH(1,"PARAM","XRES",sr)) I sr]"" S sa=$G(^ZAA02GSCH(1,"DET",sr,$P(s1,"|",3),$P($P(s1,"|",4),"-"),$P($P(s1,"|",4),"-",2))),sn=$P(sa,"`",21) I sn]"" S T=T_" "_sn
 Q
ANOTEW S T=$G(INP("FDY")) I $E(T)'="W" S T="" Q
 S ss=$E(T,2,999),T="" F  S s1=$P(ss,","),ss=$P(ss,",",2,9) Q:s1=""  S sw=$G(^WRKFLW($P(s1,"|"),$P(s1,"|",3),K,K1,$P(s1,"|",4))),sn=$P(sw,"`",21) I sn]"" S T=T_" "_sn
 Q
 ;
 ;
ACCT S T=K Q
PNUM S T=$P(PTG,":",2) Q
PATIENTL ; low case version of PN
PN S T=$P(PTG,":",3) S:T="" T=$P(GR,":",7) S:T?." " T=$G(INP("PATIENT")) S T=$P(T,",",2)_" "_$P(T,",",1)_" " S:$E(T,1)=" " T=$E(T,2,$L(T)) S:T?." " T=$G(INP("PATIENT")) Q
PNM S T=$P(PTG,":",3) S:T="" T=$P(GR,":",7) S:T?." " T=$G(INP("PATIENT")) S:T?.E1","1A.E T=$P(T,",")_", "_$P(T,",",2,9) Q
PFN S T=$P(PTG,":",3) S:T="" T=$P(GR,":",7) S T=$P(T,",",2) S:$E(T)=" " T=$E(T,2,$L(T)) Q
PLN S T=$P(PTG,":",3) S:T="" T=$P(GR,":",7) S T=$P(T,",",1) S:$E(T)=" " T=$E(T,2,$L(T)) Q
PA1 S T=$P(PTG,":",4) S:T="" T=$P(GR,":",8) Q
PA2 S T=$P(PTG,":",5) S:T="" T=$P(GR,":",9) Q
PCS S T=$P(PTG,":",6) S:T="" T=$P(GR,":",10) S T=T_" " Q
PZP S T=$P(PTG,":",7) S:T="" T=$P(GR,":",11) Q
PCSZ S T=$P(PTG,":",6)_"  "_$P(PTG,":",7) I T?." " S T=$P(GR,":",10)_"  "_$P(GR,":",11)
 I $D(INP("PA2")),INP("PA2")="" S INP("PA2")=T,T=" "
 Q
PTL S T=$P(PTG,":",8) S:T="" T=$P(GR,":",12) Q
PWTL S T=$P(GR,":",15) Q
SSN S T=$P(PTG,":",9) Q
SSAN S T=$P(PTG,":",9) S:T?9N T=$E(T,1,3)_"-"_$E(T,4,5)_"-"_$E(T,6,9) Q
SEX S T=$P(PTG,":",10) Q
STM S T=$P(PTG,":",11) Q
STM2 D STM S:T]"" T="MR#: "_T Q
AGE S T=$$AGEF($P(PTG,":",12)) Q
BDT S T=$G(INP("DOB")) Q:T]""
 S T=$$DATE($P(PTG,":",12)) Q
DG S T=$P(PTG,":",17) Q
NOTES S T=$P(PTG,":",18) Q
APP S T="" I $G(K),$G(K1) S DT=$S($ZV["M3":$ZD($H,4),1:$TR($ZD($H,3),"-")) I $O(^APPG($G(EZ,1),K,K1,DT)) S T=$O(^(DT)) S T=(+$E(T,5,6))_"/"_(+$E(T,7,8))_"/"_$E(T,1,4)
 Q
 ;
PVBLOCK S T=INP("PROVIDER") I T]"",$G(^ZAA02GSCR(110,"PV-"_T,.0156))]"" S T=^(.0156) Q
PV S T=INP("PROVIDER") S:T]"" T=$P($G(^PVG(T)),":",2) Q
PV3 S T=INP("PROVIDER") S:T]"" T=$P($G(^PVG(T)),":",3) Q
PV23 S T=$G(INP("PROV2")) S:T]"" T=$P($G(^PVG(T),"::"_T),":",3) Q  ;2nd reader
PV12 S T=INP("PROVIDER") S:T]"" T=$P($G(^PVG(T)),":",12) Q
PVSN S T=INP("PROVIDER") S:T]"" T=$P($G(^PVG(T)),":",4) Q
PI ;
PVI S T=INP("PROVIDER") S:T]"" T=$$PVIlog($P($G(^PVG(T)),":",2)) Q
PVI3 S T=INP("PROVIDER") S:T]"" T=$$PVIlog($P($G(^PVG(T)),":",3)) Q
PVIlog(X) S X=$P($P($P(X,"MD"),"M.D."),"P.A.") S:X?.E1" DO" X=$E(X,1,$L(X)-3) S:X["," X=$S($L($P(X,",",2))<3:"",X[", ":$P(X,", ",2)_" ",1:$P(X,",",2)_" ")_$P(X,",") S X=$TR(X,"."," ")
 S:X["  " X=$P(X,"  ")_" "_$P(X,"  ",2,9)
 Q $E(X)_$E($P(X," ",2))_$E($P(X," ",3))
PVI23 S T=$G(INP("PROV2")) Q:T=""  S T="/"_$$PVIlog($P($G(^PVG(T)),":",3)) Q
PVI12 S T=INP("PROVIDER") S:T]"" T=$$PVIlog($P($G(^PVG(T)),":",12)) Q
PVTEL S T=INP("PROVIDER") S:T]"" T=$P($G(^ZAA02GSCR("PROV",T)),"\",7) Q:T'=""
 S T=INP("PROVIDER") S:T]"" T=$P($G(^PVG(T)),":",17) Q
PVA1 S T=INP("PROVIDER") S:T]"" T=$P($G(^PVG(T)),":",13) Q
PVA2 S T=INP("PROVIDER") S:T]"" T=$P($G(^PVG(T)),":",14) Q
PVCS S T=INP("PROVIDER") S:T]"" T=$P($G(^PVG(T)),":",15) Q
PVZP S T=INP("PROVIDER") S:T]"" T=$P($G(^PVG(T)),":",16) Q
PNPI S T=INP("PROVIDER") S:T]"" T=$P($G(^PVG(T)),":",24)
RF S T=$P(RFG,":",2) Q
RFN S T=$P(RFG,":",19) Q:T'?.P  S T=$P(RFG,":",2) D XNAME Q  ;NASSAU - 3/8/95 ADDED XNAME
RFN1 S T=$P(RFG,":",2),T=$P(T," ",2,9)_" "_$P(T," ") Q
RFF S T=$P($P(RFG,":",2),",",2),T=$$FFNM(T) Q
RFL S T=$P($P(RFG,":",2),",") Q
RFL1 S T=$P($P(RFG,":",2)," ") S:$P($P(RFG,":",2),",")="" T="" Q
RFA1 S T=$P(RFG,":",4) Q
RFA2 S T=$P(RFG,":",5) Q
RFCC S T=$P(RFG,":",1) Q
RFCS S T=$P(RFG,":",6) Q
RFZP S T=$P(RFG,":",7) Q
RFCSZ S T=$P(RFG,":",6)_"  "_$P(RFG,":",7) Q:T=""
 I $D(INP("RFA2")),INP("RFA2")="" S INP("RFA2")=T,T=" "
 Q
 I $D(INP("RFA2")),INP("RFA2")=""!($TR(T,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")=$TR(INP("RFA2"),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")) S INP("RFA2")=T,T=" "
 Q
RFTL S T=$P(RFG,":",8) S:T?10N T="("_$E(T,1,3)_") "_$E(T,4,6)_"-"_$E(T,7,10) Q
RFT S T=$P(RFG,":",20) Q
RFSP S T=$P(RFG,":",18) Q
RFGN S T=$P(RFG,":",20) S:T="" T=" " Q
RFGC S T=$P(RFG,":",37) Q
RFOT S T=$P(RFG,":",14) S:T="" T=" " Q
RFFAX S T=$TR($P(RFG,":",21),"AF") Q
 ;
CCX S T="cc: " Q
CC1N19 S T=$P(CC1G,":",2) S:$P(CC1G,":",19)'?.P T=$P(CC1G,":",19) S:T]"" T="copy to - "_T Q
CC1N S T=$P(CC1G,":",19) Q:T'?.P  S T=$P(CC1G,":",2) S:T="" T=$G(INP("CC1")) Q
CC1FL S T=$P(CC1G,":",2) D XNAME Q
CC1F S T=$P($P(CC1G,":",2),",",2),T=$$FFNM(T) Q
CC1L S T=$P($P(CC1G,":",2),",",1) Q
CC1A1 S T=$P(CC1G,":",4) Q
CC1A2 S T=$P(CC1G,":",5) Q:T]""  Q:ALLVAR["CC1C"  S INP("CC1A2")="",VAR="CC1CSZ" G CC1CSZ
CC1CS S T=$P(CC1G,":",6) Q
CC1ZP S T=$P(CC1G,":",7) Q
CC1CSZ S T=$P(CC1G,":",6)_"  "_$P(CC1G,":",7) I $D(INP("CC1A2")),INP("CC1A2")=""!(INP("CC1A2")=T) S INP("CC1A2")=T,T=" "
 Q
CC1TL S T=$P(CC1G,":",8) Q
CC1FAX S T=$TR($P(CC1G,":",21),"AF") Q
CC2N19 S T=$P(CC2G,":",2) S:$P(CC2G,":",19)]"!" T=$P(CC2G,":",19) S:T]"" T="copy to - "_T Q
CC2N S T=$P(CC2G,":",19) Q:T'?.P  S T=$P(CC2G,":",2) S:T="" T=$G(INP("CC2")) Q
CC2FL S T=$P(CC2G,":",2) D XNAME Q
CC2F S T=$P($P(CC2G,":",2),",",2),T=$$FFNM(T) Q
CC2L S T=$P($P(CC2G,":",2),",",1) Q
CC2A1 S T=$P(CC2G,":",4) Q
CC2A2 S T=$P(CC2G,":",5) Q
CC2CS S T=$P(CC2G,":",6) Q
CC2ZP S T=$P(CC2G,":",7) Q
CC2CSZ S T=$P(CC2G,":",6)_"  "_$P(CC2G,":",7) I $D(INP("CC2A2")),INP("CC2A2")=""!(INP("CC2A2")=T) S INP("CC2A2")=T,T=" "
 Q
CC2TL S T=$P(CC2G,":",8) Q
CC2FAX S T=$TR($P(CC2G,":",21),"AF") Q
CC3N S T=$P(CC3G,":",19) Q:T'?.P  S T=$P(CC3G,":",2) S:T="" T=$G(INP("CC3")) Q
CC3FM D CC3N S:T]"" T="films to: "_T Q
CC3FL S T=$P(CC3G,":",2) D XNAME Q
CC3F S T=$P($P(CC3G,":",2),",",2),T=$$FFNM(T) Q
CC3L S T=$P($P(CC3G,":",2),",",1) Q
CC3A1 S T=$P(CC3G,":",4) Q
CC3A2 S T=$P(CC3G,":",5) Q
CC3CS S T=$P(CC3G,":",6) Q
CC3ZP S T=$P(CC3G,":",7) Q
CC3CSZ S T=$P(CC3G,":",6)_"  "_$P(CC3G,":",7) I $D(INP("CC3A2")),INP("CC3A2")=""!(INP("CC3A2")=T) S INP("CC3A2")=T,T=" "
 Q
CC3TL S T=$P(CC3G,":",8) Q
CC3FAX S T=$TR($P(CC3G,":",21),"AF") Q
CC4N S T=$G(INP("CC4")) Q
CC5N S T=$G(INP("CC5")) Q
 ;
GFN S T=$P(GFG,":",2) Q:T'?.P  S T=$P(GFG,":",2) D XNAME Q
GFA1 S T=$P(GFG,":",3) Q
GFA2 S T=$P(GFG,":",8) Q
GFCS S T=$P(GFG,":",4) Q
GFZP S T=$P(GFG,":",5) Q
GFCSZ S T=$P(GFG,":",4)_"  "_$P(GFG,":",5) Q:T=""
 Q
 ;
PROC1T S T=$G(INP("PROC1")) G PROC12T
PROC2T S T=$G(INP("PROC2")) G PROC12T
PROC3T S T=$G(INP("PROC3")) G PROC12T
PROC4T S T=$G(INP("PROC4"))
PROC12T Q:T=""  I $D(^PCG(T)) S T=$P($G(^PCG(T)),":",2) Q
 S T=$P($G(^ZAA02GSCH($G(EZ,1),"PARAM","APP",T)),"|",2) Q
DEPT S T=$G(INP("PROC1")) Q:T=""  S T=$P($G(^PCG(T)),":",21) Q:T=""  S T=$P($G(^DPG(T)),":",1) Q
SITENM S T=$$V("SITEC") Q:T=""  S T=$P($G(^PSG(T)),":",2) Q
SITETEL S T=$$V("SITEC") Q:T=""  S T=$P($G(^PSG(T)),":",13) Q
SITEHDR1 S T=$$V("SITEC") Q:T=""  S T=$G(^PSGHDR(T,1)) Q
SITEHDR2 S T=$$V("SITEC") Q:T=""  S T=$G(^PSGHDR(T,2)) Q
SITEHDR3 S T=$$V("SITEC") Q:T=""  S T=$G(^PSGHDR(T,3)) Q
SITEHDR4 S T=$$V("SITEC") Q:T=""  S T=$G(^PSGHDR(T,4)) Q
SITEHDR5 S T=$$V("SITEC") Q:T=""  S T=$G(^PSGHDR(T,5)) Q
SITEHDR6 S T=$$V("SITEC") Q:T=""  S T=$G(^PSGHDR(T,6)) Q
SITEHDR7 S T=$$V("SITEC") Q:T=""  S T=$G(^PSGHDR(T,7)) Q
 ;
study I $D(study) S T=study Q
 S T=$G(INP("FDY")) I $E(T)="W" S T=$P($E(T,2,999),","),study=$G(^WRKFLW($P(T,"|"),$P(T,"|",3),K,K1,$P(T,"|",4)))
 Q
TECH I $G(INP("TECH"))]"" S T=INP("TECH") Q
 D study S T=$P($P(T,"`",14),"  ",2,9) Q
TECHC I $G(INP("TECH"))]"" S T=INP("TECH") Q
 D study S T=$P($P(T,"`",14),"  ") Q
ACC I $G(INP("ACC"))]"" S T=INP("ACC") Q
 D study S T=$P($P(T,"`",4),"  ") Q
APPT I $G(INP("APPT"))]"" S T=INP("APPT") Q
 D study S T=$P(T,"`",52) Q
APPTD I $G(INP("APPT"))]"" S T=INP("APPT")
 E  D study S T=$P(T,"`",52)
 S:T["  " T=$P(T,"  ",2,9) Q
 ;
V(X) Q:$D(INP(X)) INP(X) I $D(VDOC) Q:$D(@VDOC@(X)) @VDOC@(X)
 Q "??"
 ; header/footer only
ESMEI S T="~EC I 'PGP,$E($G(@VDOC@(""eS"")))=""S"" D ESMEI^ZAA02GSCRTI1" Q
ESMEI2 S T="~EC I 'PGP,$E($G(@VDOC@(""eS"")))=""S"" S NODATE=1 D ESMEI^ZAA02GSCRTI1" Q
 ;
DATE(X) Q:X="" ""  Q:$L(X)<7 $E(X,3,4)_"/"_$E(X,5,6)_"/"_19_$E(X,1,2) Q $E(X,5,6)_"/"_$E(X,7,8)_"/"_$E(X,1,4) Q
FNDRF S (RF,RFC,RFG)=""
 S RFC=$P(PTG,":",16) I RFC'="+",RFC'="",$D(^RFG(RFC)) S RFG=^RFG(RFC)
 Q
XNAME N x S:T["  " T=$P(T,"  ")_" "_$P(T,"  ",2,9) Q:T'[","
 F  Q:$E(T,$L(T))'=" "  S T=$E(T,1,$L(T)-1)
 S:T[", " T=$P(T,", ")_","_$P(T,", ",2,9) S:T[", " T=$P(T,", ")_","_$P(T,", ",2,9)
 I $P(T,",",3)]"" S T=$P(T,",",2)_" "_$P(T,",")_", "_$P(T,",",3,9) Q
 S x=$L($P(T,",",2)," ") I x>1,"MD"=$P($P(T,",",2)," ",x)!("M.D."=$P($P(T,",",2)," ",x)) S x=x-1
 S T=$P($P(T,",",2)," ",1,x)_" "_$P(T,",")_$S($P($P(T,",",2)," ",x+1)]"":", "_$P($P(T,",",2)," ",x+1),1:"")
 Q
XN(T) S:T["  " T=$P(T,"  ")_" "_$P(T,"  ",2,9) S:T'["," T=$P(T," ")_", "_$P(T," ",2,9) Q T
 ;
FFNM(NME) ; FIND FIRST NAME
 F j=1:1  Q:$E(NME)=""!($E(NME)'=" ")  S NME=$E(NME,2,$L(NME))
 S NME=$P(NME," ",1) k j
 Q NME
 ;
p S K=$G(INP("MR")),K1=1 I K["/" S K1=$P(K,"/",2),K=+K     ; Acct# may be blank
 S TEZ=$G(EZ,$G(^EZ($I))) S:'+TEZ TEZ=1
 S (GR,GR3,GR2,PTG)=""
 I K'="" S GR=$G(^GRG(K)),GR3=$G(^GRG(TEZ,K)),GR2=$G(^GRG(K,2)),PTG=$G(^PTG(K,K1))
 Q
AGEF(R) ; CALC AGE R => YYMMDD, YYYYMMDD or MM/DD/YY
 Q:$L(R)<6 ""
 N DD,YY,MM,TY,TM,TD,Y,M,D,T
 I R?1.2N1"/"1.2N1"/"1.4N S MM=$P(R,"/",1),DD=$P(R,"/",2),YY=$P(R,"/",3)
 E  S:$L(R)=8 YY=$E(R,1,4),MM=$E(R,5,6),DD=$E(R,7,8) S:$L(R)=6 YY=$E(R,1,2),MM=$E(R,3,4),DD=$E(R,5,6)
 S T=$ZD($H),TM=$P(T,"/",1),TD=$P(T,"/",2),TY=$P(T,"/",3)
 S:$L(YY)=2 YY=1900+YY S:$L(TY)=2 TY=1900+TY S Y=TY-YY,M=TM-MM,D=TD-DD
 S:D<0 M=M-1 S:M<0 Y=Y-1 I Y<0 S Y=100+Y
 Q Y
 ;
 ; MAMMO INSERTION ~$MTRC = followup where * fills in with months
 ; ^ZAA02GSCMD("DICT",1,14,9,"LET")="Message * months"
 ; MTRCF - inserts # months, MTRC is general recommendation text
MT N D,TSU,I,E,M,V I $D(DP),$D(XDC),$D(VDOC),$D(@VDOC@("DOC")),$D(@VDOC@("TSU")),$D(@VDOC@("ZAA02GSCM")) S M=$G(@VDOC@("ZAA02GSCM")),D=$G(@VDOC@("DOC")),TSU=$G(@VDOC@("TSU")) I D>0 D  Q
 . S T="" S E=$P($G(@M@("EXAM",D)),";",9,99) Q:E=""  S I=$E(VAR,3,9) I $L(I)=2 S V=$P($P(E,";"_I,2),";"),I=I_$E(V),I=$G(^ZAA02GSCMD("DICT",3,I)) I I]"" S T=$G(^ZAA02GSCMD("DICT",1,+I,$P(I,",",2),"LET"))
 . I $L(I)=3,E[I S V=$P($P(E,";"_I,2),";"),I=$G(^ZAA02GSCMD("DICT",3,I)) I I]"" S T=$G(^ZAA02GSCMD("DICT",1,+I,$P(I,",",2),"LET"))
 . I T["*" S T=$P(T,"*")_$P(V,",",2)_$P(T,"*",2,9)
 S T="" Q
 ;
 ; TEST FOR MT
TT S DP=1,XDC=1,VDOC="VDOC",VDOC("TSU")="M",VDOC("ZAA02GSCM")="^ZAA02GSCMD(""ST"",TSU)",m="",VAR="MTRCF"
 F  S m=$O(^ZAA02GSCMD("ST","M","EXAM",m)) Q:m=""  S VDOC("DOC")=m D MT w:T'="" T
 ;
CUST1 S n=$G(^ZAA02GSCR("PARAM","CUST1")) I n="" S T="" Q
 F  Q:n'["*"  S m=$P(n,"*",2) D
 . I m]"",$T(@m)]"" D @m I $G(T)]"" S n=$P(n,"*"_m_"*")_T_$P(n,"*"_m_"*",2,99) Q
 . S n=""
 S T=n Q
