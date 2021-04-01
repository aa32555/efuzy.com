ZAA02GSCRMI1 ;PG&A,ZAA02G-SCRIPT,2.10,MIDS SUBROUTINE;21DEC94 4:00P;;;29DEC98  12:41
 ;
TTRAN ;  LOG TRANSCRIPTION TO MED-REC
 S:'$D(TEST) A=^ZAA02G("ERROR")_"=""TTRANER^ZAA02GSCRMI1""",@A
TTRAN1 S (TT,T)=$O(^ZAA02GTRN("TRANS","")) Q:T=""  S X=^(T)
TTRAN3 I $P(X,"^",8)=0 D:$ZU(0)'["JMP" 3^%M D TRAN^MIDMRT(X) D:$ZU(0)'["JMP" 2^%M G TTRAN2 ;ST MARY'S
 D 4^%M,TRAN^MIDMRT(X),2^%M
TTRAN2 K ^ZAA02GTRN("TRANS",TT) G TTRAN1
TTRANER D:$ZU(0)'["JMP" 2^%M S ^ZAA02GTRN("ERROR",TT)=^ZAA02GTRN("TRANS",TT),^(TT,1)=$H_","_$ZE G TTRAN2
TTERTEST S (TT,T)=$O(^ZAA02GTRN("ERROR","")) Q:T=""  S X=^(T) G TTRAN3
 ;
VAR ; LOOKUP FOR DOCUMENT ~$ PARAMETERS
 F I=1:1 S VAR=$P(ALLVAR,",",I) Q:VAR=""  D VAR1
 Q
VAR1 Q:VAR=""  Q:$T(@VAR)=""  D @VAR S INP(VAR)=T
DR S T=$G(INP("PROV")) Q:T=""  S T=$G(^[DBASE]ZAA02GPROV(INP("PROV"))) S:T="" T=" " Q
ADMIT S T=$G(INP("ID")) Q:T=""  I T=0!($G(INP("TEMPLATE2"))="") S T="*" Q
 S T=$P($G(^[DBASE]MIDS(T,0)),"^",7) S:T]"" T=$E(T,4,5)_"/"_$E(T,6,7)_"/"_($E(T,1,3)+1700) Q
ATTEND S T=$G(INP("CONSULT")) Q:T=""  S T=$P(T,",",2)_" "_$P(T,",") Q
ADMT S T=$G(INP("ID")) Q:T=""  S T=$P($G(^[DBASE]MIDS(T,0)),"^",14) S:T]"" T=$E(T,1,2)_":"_$E(T,3,4) Q
DISCH S T=$G(INP("ID")) Q:T=""  S T=$P($G(^[DBASE]MIDS(T,2)),"^") S:T]"" T=$E(T,4,5)_"/"_$E(T,6,7)_"/"_($E(T,1,3)+1700) Q
SITE S T=$G(INP("SITEC")) Q:T=""  S T=$G(@ZAA02GSCR@("PARAM","SITE",T)) Q
 ;
 Q
 ;
 ; THE TRANS SECTION IS USED TO LOG TRANSACTIONS TO THE MIDS PROCESSOR
 ; FORMAT -
 ;          ACC#\ITEM\PROV\DDATE\TDATE\TRNID\DOC\HOSP\REFDATE
 ;          1      2    3    4     5     6    7   8      9
 ;
TRANS I $D(^ZAA02GFAXQ("COMPLETED"))>1 D COMPLETE^ZAA02GSCRFX2
 Q:DOC'["^ZAA02GSCR"
 ; if fax set - cancel printout of copy to faxed doc
 I $G(@VDOC@("FAX"))]"",$G(@DOC@(.011,"FAX"))]"" S T=^("FAX"),D=$G(@VDOC@("DIST")) I D]"" F TR=1:1:$L(T,"\") F J=1:1:6 I $P(T,"\",TR)]"",$G(@VDOC@($P("PROV,PROVA,c3,c4,c5,c6",",",J)))=$P(T,"\",TR) D
 . S Y=$D(@ZAA02GSCR@("PARAM","DIST",D,100)) F K=1:1 S Y=$O(^(Y)) Q:Y=""  I $P(^(Y),"\",4)=$P("DR,CONSULT,CC1,CC2,CC3,CC4",",",J) S @VDOC@("DONE-"_$P("DR,CONSULT,CC1,CC2,CC3,CC4",",",J))="" Q
 Q:DOC["^ZAA02GSCR2"
TRANSX S TR=@DOC@(.011),T="" F J=1:1:6 S $P(T,"^",J)=$P(TR,"`",$P("4,1,6,11,12,5",",",J))
 S $P(T,"^",3)=$G(^(.011,"PROV")),$P(T,"^",9)=$TR($G(^("DS")),")")
 F J=4,5,9 S D=$P(T,"^",J) S:D]"" $P(T,"^",J)=2_$P(D,"/",3)_$P(D,"/")_$P(D,"/",2)
 Q:+T=0  I ",7,70,71,72,73,74,"[(","_+$P(T,"^",2)_",") Q
 S $P(T,"^",7,8)=+$P(DOC,",""",2)_"^"_(DOC["ZAA02GSCR1"),T=$TR(T,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ") L +^ZAA02GTRN S (TR,^ZAA02GTRN(1))=$G(^ZAA02GTRN(1))+1,^ZAA02GTRN("TRANS",TR)=T L -^ZAA02GTRN Q:$D(SCAN)  J ^ZAA02GSCRMI1 Q
 ;
REFAX E  Q
 X $P(Y,"`",2) N R F R=1:1:8 I $D(REFAX(R)) S IDX=R,ID=$G(INP($P("PROV,PROVA,c3,c4,c5,c6,c7,c8",",",R))) I ID]"" D FAXB^ZAA02GSCRER2
 K IDX I 1 Q
 Q
SCAN ; PICKUP MISSED MRTE REPORTS
 S SCAN=1 R "STARTING WITH-",XX,! Q:XX=""  F  S XX=$O(@ZAA02GSCR@("TRANS",XX)) Q:XX=""  S DOC=ZAA02GSCR_"(""TRANS"","""_XX_""")" W DOC,! D TRANSX
 Q
SCANT ; ADD HOSP CODE TO ^ZAA02GTRN TO CONVERT OLD ENTRIES
 S A="" F  S A=$O(^ZAA02GTRN("TRANS",A)) Q:A=""  W A," " S B=^(A),DOC=$P(B,"^",7),DR=$P(B,"^",3) I $L(B,"^")<8 D SCANT1 I L="" K ^ZAA02GTRN("TRANS",A)
 Q
SCANT1 F L="^ZAA02GSCR","^ZAA02GSCR1","" Q:L=""   I $G(@L@("TRANS",DOC,.011,"PROV"))=DR Q
 S:L'="" $P(^ZAA02GTRN("TRANS",A),"^",8)=L[1
 Q
CCS ; PROCESS CC address on report
 S c=C+.00001 F j=1:1:6 I $G(@VDOC@("CC"_j_"A"))]"" S C(c)="",c=c+.00001 F k="","A","B","C","D" I $G(@VDOC@("CC"_j_k))]"" S C(c)=$S(k="":"cc: ",1:"    ")_@VDOC@("CC"_j_k),c=c+.00001
 K c Q
CCCT S cT=0 F j=1:1:6 I $G(@VDOC@("CC"_j_"A"))]"" S cT=cT+1 F k="","A","B","C","D" I $G(@VDOC@("CC"_j_k))]"" S cT=cT+1,LN=LN+1
 K:'cT cT
CCX1 S T="" F j=1:1:3 I $G(^("CC"_j))]"" S T=T_^("CC"_j)_"; "
 S ^("CCC1")=$S(T="":"",1:"CC:         "_$E(T,1,$L(T)-2))
CCX2 S T="" F j=4:1:6 I $G(^("CC"_j))]"" S T=T_^("CC"_j)_"; "
 S ^("CCC2")=$S(T="":"",1:"CC:         "_$E(T,1,$L(T)-2)) Q
 Q
 ;
LINK ; CHECK LINK STATUS AND SET FLAGS
 K LDWN Q:$D(TEST)  S A=^ZAA02G("ERROR")_"=""LINKERR^ZAA02GSCRMI1""",@A I $D(^[DBASE]MIDS)
 Q
LINKERR S LDWN=0 S %R=2,%C=23 W @ZAA02GP,ZAA02G("RON")," ADT Link is Down - Use free text ",ZAA02G("ROF") S ZE=$ZE Q
SETUP I $D(^ZAA02GMAIL),$D(ZAA02GID) S J=$D(ZAA02GID) D ^ZAA02GMANQ K:'J ZAA02GID I $D(ZAA02GM) S %R=24,%C=+ZAA02GM W @ZAA02GP,$P(ZAA02GM,";",2,9) K ZAA02GM
 I $G(INP("SITEC"))]"" S RX=1
 Q
REFDT ; REFERENCE DATE LOGIC - CALLED FROM ID BLOCK
 I $E($G(INP("SITEC")),3)="R" S opi=$G(INP("DD")) G REFDT2
 S opi="" G REFDT2:$G(INP("ID"))="",REFDT1:$G(INP("PROC2"))'["INPATIENT" I $G(INP("PROC1"))=1 S opi=$P($G(^[DBASE]MIDS(INP("ID"),0)),"^",7) G REFDT2 ; H&P
 I $G(INP("PROC1"))=3 S opi=$P($G(^[DBASE]MIDS(INP("ID"),2)),"^") G REFDT2 ; DS
REFDT2 S:opi>150000 opi=$E(opi,4,5)_"/"_$E(opi,6,7)_"/"_($E(opi,1,3)-200) S opi="PDSP;DS;"""_opi_"""" X op I 1 Q
REFDT1 S opi=$TR($P($G(INP("REV")),": ",2),")") G REFDT2
REFDTX S INP("PROC1")=X G REFDT
 ;
FAXID Q  ; NOT USED
 ;
