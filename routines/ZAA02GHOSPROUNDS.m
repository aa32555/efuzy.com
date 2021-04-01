ZAA02GHOSPROUNDS ; Hosptial Rounds Custom Report;2017-02-14 10:14:01
 ; ADS Corp. Copyright
 ;
VB
 N (B,EZ,HANDLE,HANDLE2,P2,USER,X)
 ;
 S B=""
 S D1=":"
 S D2="^"
 S D3=","
 S D4="/"
 S IO=$I
 S OPZ=USER
 S PR=$S(P2["=":P2,1:+P2) I PR="0",$I'[":" S PR=$I
 S Q="1"
 S S=""
 S s=$P(X,"|",7)
 S VAL=$P(X,"|",6)
 ;
 ; Date Range
 S DATES=$E(s)
 S DATE1="",DATE2=9999999999
 I DATES="S" D
 . S DTF=$TR($P($P($P(s,D1),D2,2),D3),"_")
 . S DTF=$P(DTF,D4,3)_$P(DTF,D4)_$P(DTF,D4,2)
 . S DTF=$$DG^IDATE(DTF,1)
 . I $E(DTF)<2 S DTF=$E(DTF,3,8)
 . S DATE1=DTF
 . S DTT=$TR($P($P($P(s,D1),D2,2),D3,2),"_")
 . S DTT=$P(DTT,D4,3)_$P(DTT,D4)_$P(DTT,D4,2)
 . S DTT=$$DG^IDATE(DTT,1)
 . I $E(DTT)<2 S DTT=$E(DTT,3,8)
 . S DATE2=DTT
 ;
 ; Provider
 S PRS=$E($P(s,D1,2))
 I PRS'="A" D
 . S TMP=$P($P(s,D1,2),D2,2)
 . F I=1:1:$L(TMP,D3) S PRV($P(TMP,D3,I))=""
 ;
 ; Place of Service
 S PLS=$E($P(s,D1,3))
 I PLS'="A" D
 . S TMP=$P($P(s,D1,3),D2,2)
 . F I=1:1:$L(TMP,D3) S PLC($P(TMP,D3,I))=""
 ;
 ; Sort by
 S SORT=$E($P(s,D1,4))
 ;
 ;Special Field A
 S SFA=$E($P(s,D1,5))
 I SFA'="A" D
 . S TMP=$P($P(s,D1,5),D2,2)
 . F I=1:1:$L(TMP,D3) S SFA($P(TMP,D3,I))=""
 ;
 ; Source List
 S SLIST=$P($P(s,D1,6),D2,2)
 S $P(SA,D1,4)=SLIST
 S HDRSLIST=""
 I SLIST'="" S HDRSLIST="  ( using list: "_SLIST_"   "_$TR($P(^LIST(SLIST),":",1,3),":","  ")_" )"
 ;
 ; Object List
 S OLIST=$P($P($P(s,D1,7),D2,2),D3)
 I OLIST]"" S OLIST=$$UPPER^COMM(OLIST)
 S $P(SA,D1,5)=OLIST
 S $P(SA,D1,38)=$P($P($P(s,D1,7),D2,2),D3,2)
 I OLIST'="",VAL'="RUN" S FLAG=0 D  I FLAG Q
 . I $D(^LIST(OLIST)),VAL'="Q=2,R=6" S B="2|Object List "_OLIST_" already exists.  Replace list?|36|Report|6=1,7=0",FLAG=1 Q
 . I $P(SA,D1,38)?." " S B="99|Object List description required.|16|Report|1=0" S FLAG=1 Q
 I OLIST'="",VAL="RUN" D SET^LIST("",OLIST)
 ;
 I VAL=""!(VAL="Q=2,R=6") S B="||RUN||" Q
 I VAL'="RUN" S B="99|Invalid System Response|16|Report|1=0" Q
 I OLIST'="" D SRCOBJ^LIST("ZAA02GHOSPROUNDS",SA) I $G(LISTER)]"" W !,LISTER Q
 ;
 ; Get Data
 K ^SORT($J)
 D EZ^ZAA02GVBAS
 S (TOTAL,DATA,SUB1,SUB2,SUB3,SUB4)="" S K="" F  S K=$O(^HOSP(K)) Q:'K  D
 . S K1="" F  S K1=$O(^HOSP(K,K1)) Q:'K1  D
 .. I SLIST]"",'$$CHKLST(SLIST,K,K1) Q
 .. S DATA=$G(^HOSP(K,K1))
 .. S SUB1=$P(DATA,":",2) I SUB1="" S SUB1="Missing"
 .. S SUB2=$P(DATA,":",3) I SUB2="" S SUB2="Missing"
 .. S SUB3=$$ROOM(K,K1) I SUB3="" S SUB3="Missing"
 .. ;S SUB3=$P(DATA,":",4) I SUB3="" S SUB3="Missing"
 .. S SUB4=$P(DATA,":",5) I SUB4="" S SUB4="Missing"
 .. S SUBSFA=$$SFIELD(K,"A") I SUBSFA="" S SUBSFA="Missing"
 .. I DATES="S",(SUB4<DTF)!(SUB4>DTT) Q
 .. I PLS="I"&('$D(PLC(SUB2)))!(PLS="E"&($D(PLC(SUB2)))) Q
 .. I PRS="I"&('$D(PRV(SUB1)))!(PRS="E"&($D(PRV(SUB1)))) Q
 .. I SFA="I"&('$D(SFA(SUBSFA)))!(SFA="E"&($D(SFA(SUBSFA)))) Q
 .. I SORT="D" S ^SORT($J,SUB4,K,K1)=SUB1_":"_SUB3_":"_SUB2
 .. I SORT="P" S ^SORT($J,SUB1,K,K1)=SUB3_":"_SUB4_":"_SUB2
 .. I SORT="R" S ^SORT($J,SUB3,K,K1)=SUB1_":"_SUB4_":"_SUB2
 .. S TOTAL=TOTAL+1
 .. I OLIST]"" D WR^LIST(OLIST,"",K,K1)
 ;
 ; Screen
 I '$D(^SORT($J)) Q 
 S HEADERSEL=0,PAGEX=-1,PAGE=0
 S (DATA,SUB2,SUB3,SUB4,ROOM,PROV,DOADATE,K,K1)=""
 S SUB1="" F  S SUB1=$O(^SORT($J,SUB1)) Q:SUB1=""  D
 . S SUB5="" F  S SUB5=$O(^SORT($J,SUB1,SUB5)) Q:SUB5=""  D
 .. S SUB6="" F  S SUB6=$O(^SORT($J,SUB1,SUB5,SUB6)) Q:SUB6=""  D
 ... S DATA=$G(^SORT($J,SUB1,SUB5,SUB6))
 ... F I=2:1:4 S SUB="SUB"_I, @SUB=$P(DATA,":",I-1)
 ... I SORT="D" S DOADATE=SUB1 S PROV=SUB2 S ROOM=SUB3
 ... I SORT="P" S PROV=SUB1 S DOADATE=SUB3 S ROOM=SUB2
 ... I SORT="R" S ROOM=SUB1 S DOADATE=SUB3 S PROV=SUB2
 ... S POS=$P(SUB4," ") S K=SUB5 S K1=SUB6
 ... S POS=$S(POS="Missing":"No Place Entered",POS'="Missing":$P(^PSG(POS),":",2))
 ... S ROOM=$S(ROOM="Missing":"No Room Enered",1:ROOM)
 ... S (PROC,DG1,DG2,DG3,DG4,TREZ,TR,PDATE)=""
 ... S TREZ=$P($$TRG(K,K1),":"),TR=$P($$TRG(K,K1),":",2)
 ... I TR D
 .... S TRDATA=$G(^TRG(TREZ,TR))
 .... S PROC=$P(TRDATA,":",6) I PROC S PROC=$P(^INPC(PROC),":")
 .... S PDATE=$ZDATE($P(TRDATA,":",1))
 .... S SDATE=$$SUB^IDATE($P($P(TRDATA,":",16),","),0)
 .... S DG1=$P(TRDATA,":",22),DG2=$P(TRDATA,":",23),DG3=$P($P(TRDATA,":",21),"^"),DG4=$P($P(TRDATA,":",21),"^",2)
 .... F I=1:1:4 S DG="DG"_I I @DG S @DG=$P(^INDG(@DG),":")
 ... S PAGEX=PAGEX+1
 ... D PRINT
 ... I PAGEX=8 S PAGEX=0
 I (OLIST]"")!(SLIST]"") D LISTL^LIST("ZAA02GHOSPROUNDS",SLIST,OLIST)
 Q
PRINT
 I (('PAGE)!(PAGEX=8)) D HEADERSEL
 W "Account: ",?7,K_"/"_K1,?35,"Room : ",?42,$$ROOM(K,K1) I PROC]"" W ?65,"Date of serv: ",SDATE, " -------->" I PROC]"" W ?100,"|Proc : ",PROC," ",$E($P(^PCG(PROC),":",3),0,15)
 W !
 W "Name   : ",?9,$$NAME(K,K1),?35,"Place: ",?42,$E(POS,0,20),?65,"FIN         : ",$E($$NOTES(K,K1),0,20) I DG1'=""  W ?100,"|Diag1: ",DG1," ",$E($P(^DGG(DG1),":",2),0,15)
 W !
 W "DOB    : ",?9,$$DATECONV(7,$$DOB(K,K1)),?35,"DOA  : ",?42,$$DATECONV(7,DOADATE),?65,"Type of Pat : ",$S($$SFIELD(K,"A")="V":"VMF",1:"Admit") I DG2'=""  W ?100,"|Diag2: ",DG2," ",$E($P(^DGG(DG2),":",2),0,15)
 W !
 W "Age    : ",?9,$$AGE($$DOB(K,K1)),?35,"Prov : ",?42,$E($$PRV(PROV),0,20),?65, "Type of Adm : ",$S($$SFIELD(K,"B")="C":"Consult",$$SFIELD(K,"B")="I":"Inpatient",$$SFIELD(K,"B")="O":"Observation",1:"No Info") I DG3'=""  W ?100,"|Diag3: ",DG3," ",$E($P(^DGG(DG3),":",2),0,15)
 W !
 W "Ins    : ",?9,$E($$INS(K,K1),0,20),?35,"Ref  : ",?42,$E($$REF(K,K1),0,20),?65, "Consultants : ",$E($$MISC(K),0,20) I DG4'=""  W ?100,"|Diag4: ",DG4," ",$E($P(^DGG(DG4),":",2),0,15)
 W ! W:$D(^PTG(K,K1,"USRFRM","DRNOTES",1)) "Notes  : ",$E(^PTG(K,K1,"USRFRM","DRNOTES",1),0,120)
 W !
 S $P(U,"-",130)="" W U,!
 Q
HEADER(HDRLEFT,HDRCENT) ; Print Header
 N DATE
 I 'PAGE D
 . S DATE=$$DG^IDATE(+$H)
 . S DATE=$E(DATE,5,6)_D4_$E(DATE,7,8)_D4_$E(DATE,3,4)
 . S ENT=$P($G(^PRMG(TEZ,1)),D1,2)
 . S $P(HDR(1)," ",133)=""
 . S $E(HDR(1),1,$L(DATE))=DATE
 . S $E(HDR(1),66-($L(ENT)\2),66-($L(ENT)\2)+$L(ENT))=ENT
 . S $E(HDR(1),124,130)=" (c) ADS"
 . S $E(HDR(2),1,9)="Oper: "_OPZ
 . S $P(HDR(2)," ",133)=""
 . S TMP="Hospital Rounds Report"_HDRSLIST
 . S $E(HDR(2),66-($L(TMP)\2),66-($L(TMP)\2)+$L(TMP))=TMP
 . S $P(HDR(4),"_",133)=""
 . S HDR(5)="Sorted by: "_$S(SORT="P":"Provider Code      ",SORT="D":"Date of Admission  ",SORT="R":"Room                ")_"                                                                                  Total Patients: "_$J($G(TOTAL),3)
 . S $P(HDR(6),"_",133)=""
 . E  S $P(HDR(7),"_",133)=""
 I PAGE W #
 S PAGE=PAGE+1
 S $E(HDR(2),125-$L(PAGE),131)=" Page: "_PAGE
 S HDR(3)="",$P(HDR(3)," ",133)=""
 S $E(HDR(3),1,$L(HDRLEFT))=HDRLEFT
 S $E(HDR(3),66-($L(HDRCENT)\2),66-($L(HDRCENT)\2)+$L(HDRCENT))=HDRCENT
 S $E(HDR(2),136,999)=""
 S X="" F  S X=$O(HDR(X)) Q:X=""  W HDR(X),!
 I 'HEADERSEL D
 . W !!,?1,"1. Date of Admission",?32,": " W:DATE1 "From "_$$DATECONV(7,DATE1)_" Thru "_$$DATECONV(7,DATE2)," " W:'DATE1 "All Dates"
 . W !!,?1,"2. Provider",?32,": " W:PRS="A" "All" I PRS'="A" W:PRS="I" "Selected " W:PRS="E" "Excluded " S X="" F  S X=$O(PRV(X)) Q:X=""  W X," "
 . W !!,?1,"3. Place of Service",?32,": " W:PLS="A" "All" I PLS'="A" W:PLS="I" "Selected " W:PLS="E" "Excluded " S X="" F  S X=$O(PLC(X)) Q:X=""  W X," "
 . W !!,?1,"4. Special Field A",?32,": " W:SFA="A" "All" I SFA'="A" W:SFA="I" "Selected " W:SFA="E" "Excluded " S X="" F  S X=$O(SFA(X)) Q:X=""  W X," "
 . W !!,?1,"5. Sorted by",?32,":"," "_$S(SORT="P":"Provider Code",SORT="D":"Date of Admission",SORT="R":"Room")
 . W !!," 6. Consultants",?32,":",?34,"Misc "
 . W !!," 7. FIN",?32,":",?34,"Notes "
 . W !!," 8. Type of Pat(Special Field A):",?34,"V -> VMF",!
 . W !!," 9. Type of Adm(Special Field B):",?34,"C -> Consult",!,?34,"I -> Inpatient",!,?34,"O -> Observation"
 . S HEADERSEL=1 D HEADERSEL
 Q
CHKLST(SLIST,K,K1)
 N (SLIST,K,K1)
 S TYP=$$LTYPE^LIST(SLIST)
 I TYP="A" Q $$IN^LIST(SLIST,"",K,K1)
 S NM=$P(^PTG(K,K1),":",3)
 I (NM="")!(TYP="G") S NM=$P(^GRG(K),":",7)
 S NM=$TR(NM," ")
 S NM=$E($P(NM,",",1)_"    ",1,5)_$E($P(NM,",",2),1)
 I TYP="Z" D
 . S ZP=$P(^PTG(K,K1),":",7)
 . I ZP="" S ZP=$P(^GRG(K),":",11)
 . S NM=" "_ZP_NM
 . Q
 Q $$IN^LIST(SLIST,NM,K,K1) 
SFIELD(K,F)
 N T,T1
 S T1=$S(F="A":9,F="B":10,F="C":11)
 S T=$P($G(^GRG(1,K)),":",T1)
 Q T
INS(K,K1)
 N T,T1,T2,T3,INS
 I $D(^PTG(K,K1,0)) S T=$G(^PTG(K,K1,0)) S T1=$P($G(T),":") S T2=$G(^GRG(K,T1)) S T3=$P(T2,":",3) S INS=$P(^ING(T3),":",2) Q INS
 I $D(^GRG(K,0)) S T=$G(^GRG(K,0)) S T1=$P($G(T),":") S T2=$G(^GRG(K,T1)) S T3=$P(T2,":",3) S INS=$P(^ING(T3),":",2)
 I '$D(^GRG(K,0)) S INS="No Ins Entered"
 Q INS
 ;
NAME(K,K1)
 N T
 S T=$P($G(^PTG(K,K1)),":",3)
 S:T="" T=$P($G(^GRG(K)),":",7)
 Q T
SEX(K,K1)
 N T
 S T=$P(^PTG(K,K1),":",10)
 Q T 
DOB(K,K1)
 N T
 S T=$P(^PTG(K,K1),":",12)
 Q T 
AGE(R)
 Q:$L(R)<6 ""
 N DD,YY,MM,TY,TM,TD,Y,M,D,T
 I R?1.2N1"/"1.2N1"/"1.4N S MM=$P(R,"/",1),DD=$P(R,"/",2),YY=$P(R,"/",3)
 E  S:$L(R)=8 YY=$E(R,1,4),MM=$E(R,5,6),DD=$E(R,7,8) S:$L(R)=6 YY=$E(R,1,2),MM=$E(R,3,4),DD=$E(R,5,6)
 S T=$ZD($H),TM=$P(T,"/",1),TD=$P(T,"/",2),TY=$P(T,"/",3)
 S:$L(YY)=2 YY=1900+YY S:$L(TY)=2 TY=1900+TY S Y=TY-YY,M=TM-MM,D=TD-DD
 S:D<0 M=M-1 S:M<0 Y=Y-1 I Y<0 S Y=100+Y
 Q Y
PRV(PROV)
 N T
 I PROV="Missing" S T="No Prov Entered" Q T
 S T=PROV S T=$P(^PVG(T),":",2)
 Q T
REF(K,K1)
 N T
 S T=$P(^PTG(K,K1),":",16) I T'="" S T=$P(^RFG(T),":",2)
 I T="" S T="No Ref Entered"
 Q T
TRG(K,K1)
 N T,T1,T2,T3
 S MAXTR=0,MAXE=0
 S T="" F  S T=$O(^INTR(T)) Q:T=""  D
 . S T2="" F  S T2=$O(^INTR(T,K,T2)) Q:T2=""  D
 .. I 'MAXTR S MAXTR=T2
 .. I $G(^INTR(T,K,T2))'="P" Q
 .. S MAXE=T I MAXTR<T2 S MAXTR=T2
 Q MAXE_":"_MAXTR
NOTES(K,K1)
 N T
 S T=$P($G(^PTG(K,K1)),":",18)
 S:T="" T="No Info"
 Q T
MISC(K) 
 N T
 S T=$P($G(^GRG(K)),":",19)
 S:T="" T="No Info"
 Q T
HEADERSEL
 I 'DATE1 D HEADER("All Dates of Admission","") Q
 D HEADER("DOA From "_$$DATECONV(7,DATE1)_" Thru "_$$DATECONV(7,DATE2),"")
 Q
ROOM(K,K1) 
 N T
 S T=$P($G(^PTG(K,K1)),":",27)
 S:T="" T="No Info"
 Q T
 Q
DATECONV(MODE,DATE)
 N DAY,LEN,MONTH,OUT,YEAR
 S OUT=""
 S LEN=$L(DATE)
 I MODE=1 D
 . I LEN=5 D
 .. S OUT=$TR($ZD(DATE),"/")
 .. S YEAR=$E(OUT,5,8)
 .. I $L(OUT)=6 S OUT=$E(OUT,1,4)_$S($L(YEAR)=4:YEAR,YEAR<50:20_YEAR,1:19_YEAR)
 . I LEN=6!(LEN=8) D
 .. S DAY=$E(DATE,LEN-1,LEN)
 .. S MONTH=$E(DATE,LEN-3,LEN-2)
 .. S YEAR=$E(DATE,1,LEN-4)
 .. I YEAR<100 S YEAR=$S(YEAR<50:20,1:19)_YEAR
 .. S OUT=MONTH_DAY_YEAR
 I MODE=2!(MODE=5) D
 . S OUT=$TR(DATE,"/")
 . I OUT?." " Q
 . S YEAR=$E(OUT,5,8)
 . I MODE=2,YEAR<2000 S YEAR=$E(YEAR,3,4)
 . I MODE=5 S YEAR=$E(YEAR,3,4)
 . S OUT=YEAR_$E(OUT,1,4)
 I MODE=3 D
 . S OUT=$$JUL^IDATE(DATE)
 I MODE=4 D
 . S YEAR=$E(DATE,1,2),MONTH=$E(DATE,3,4),DAY=$E(DATE,5,6)
 . S OUT=MONTH_DAY_$S(YEAR<50:20,1:19)_YEAR
 I MODE=6 D
 . S YEAR=$E(DATE,1,4),MONTH=$E(DATE,5,6),DAY=$E(DATE,7,8)
 . S OUT=MONTH_DAY_YEAR
 I MODE=7 D
 . I LEN=5 D
 .. S OUT=$TR($ZD(DATE),"/")
 .. S YEAR=$E(OUT,5,8)
 .. I $L(OUT)=6 S OUT=$E(OUT,1,4)_$S($L(YEAR)=4:YEAR,YEAR<50:20_YEAR,1:19_YEAR)
 . I LEN=6!(LEN=8) D
 .. S DAY=$E(DATE,LEN-1,LEN)
 .. S MONTH=$E(DATE,LEN-3,LEN-2)
 .. S YEAR=$E(DATE,1,LEN-4)
 .. I YEAR<100 S YEAR=$S(YEAR<50:20,1:19)_YEAR
 .. S OUT=MONTH_"/"_DAY_"/"_YEAR
 I MODE=8 D
 . S OUT=$TR($ZD(DATE),"/")
 . S YEAR=$E(OUT,5,8),MONTH=$E(OUT,1,2),DAY=$E(OUT,3,4)
 . I $L(OUT)=6 S OUT=$E(OUT,1,4)_$S($L(YEAR)=4:YEAR,YEAR<50:20_YEAR,1:19_YEAR)
 . S OUT=YEAR_MONTH_DAY
 I MODE=9 D
 . I $L(DATE)=6 S DATE=19_DATE
 . S YEAR=$E(DATE,1,4),MON=+$E(DATE,5,6),DAY=$E(DATE,7,8)
 . S MON=$S(MON=1:"Jan",MON=2:"Feb",MON=3:"Mar",MON=4:"Apr",MON=5:"May",MON=6:"Jun",MON=7:"Jul",MON=8:"Aug",MON=9:"Sept",MON=10:"Oct",MON=11:"Nov",MON=12:"Dec",1:"")
 . S OUT=MON_" "_DAY_" "_YEAR
 I MODE=10 D
 . I $L(DATE)=6 S DATE=19_DATE
 . S YEAR=$E(DATE,1,4),MON=+$E(DATE,5,6),DAY=$E(DATE,7,8)
 . I MON'?2N S MON="0"_MON 
 . I DAY'?2N S DAY="0"_DAY
 . S OUT=YEAR_"-"_MON_"-"_DAY
 Q OUT
