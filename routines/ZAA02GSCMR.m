ZAA02GSCMR ;PG&A,ZAA02G-MTS,1.00,MTS ENTRY;05JAN94  01:03;;;Mon, 09 Jul 2012  10:56
 ;Copyright (C) 1995, Patterson, Gray and Associates Inc.
 ;
MAMMO N TSU I $D(EDIT) D M1 Q
 F J="TEMPLATE","TEMPLATE2" I $G(INP(J))]"" S TSU=$TR($P($G(@ZAA02GSCR@(106,INP(J),.03)),"\",20),"YN","M") S:TSU'="" TSU(TSU)=1
 S TSU="" F  S TSU=$O(@ZAA02GSCMD@("ST",TSU)) Q:TSU=""  I '$D(TSU(TSU)),$D(@ZAA02GSCM@("EXAM",DOC)) S TSU(TSU)=-1
 S tsu="" F  S tsu=$O(TSU(tsu)) Q:tsu=""  D
 . S TSU=tsu I TSU(TSU)<0 S DELETE=1,@ZAA02GSCR@("TRANS",DOC,.011,"OLD-TRACKING-"_TSU)=$G(@ZAA02GSCM@("EXAM",DOC)) D M1 K DELETE Q
 . D M1
 Q
PREMIER D M1 Q
 ;
M7 S J=$G(TSU) N TSU S TSU=J G:$G(TS)'="" M1 I $G(INP("TRACK"))]"" S TSU=INP("TRACK"),TSU(TSU)="" D M1 G M8
 ; I $G(@ZAA02GSCR@(DIR,DOC))["MAMMO" G M1
M8 I OSET]"" S TSU="" F  S TSU=$O(@ZAA02GSCMD@("ST",TSU)) Q:TSU=""  I '$D(TSU(TSU)),$D(@ZAA02GSCM@("EXAM",DOC)) S DELETE=1,@ZAA02GSCR@("TRANS",DOC,.011,"OLD-TRACKING-"_TSU)=$G(@ZAA02GSCM@("EXAM",DOC)) D M1
 Q
M1 S:'$D(UP) UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ",LC="abcdefghijklmnopqrstuvwxyz"
 I '$D(EDIT),DOC>0 Q:$G(@ZAA02GSCR@("PARAM","MAMMOSTARTUP"))>DOC  Q:$D(@ZAA02GSCR@(DIR,DOC,.011,"NOMAMMO"))
 S PARAM=$G(@ZAA02GSCM@("PARAM","INPUT")) Q:PARAM=""
 I $D(EDIT)=0 I $G(TYPS)'=3 S TYPS="",P=$P(PARAM,"\",7,9) F J=1:1:3 S:$S($G(STMC)["A":"A",$D(STMC):"S",1:"AMS")[$P(P,"\",J)&$L($P(P,"\",J)) TYPS=TYPS_J
 S:$D(PREMIER) TYPS=2
M0 I TYPS="",'$D(DELETE),'$D(REBUILD) Q
 S DS=$G(INP("DS")) S:DS="" DS=INP("DT") S:$L(DS)=8 $P(DS,"/",3)=$P(DS,"/",3)<30*100+1900+$P(DS,"/",3) S $P(DS,"/",3)=$P(DS,"/",3)-1900,DST=$P(DS,"/",3)*100+DS*100+$P(DS,"/",2),(OMAMMO,MAMMO,ODST,OREC,OTSU)="",CTSU=TSU
 I DOC,$D(@ZAA02GSCM@("EXAM",DOC)) S OREC=^(DOC),(OMAMMO,MAMMO)=$P(OREC,";",9,99),ODST=$P(OREC,";",2),OTSU=$P(OREC,";",6) I OTSU="" S OTSU="?" I OMAMMO[";TS" S OTSU=$E($P(OMAMMO,";TS",2)) S:"RLBS"[OTSU OTSU="M"
 S:$G(NTSU)]"" TSU=NTSU
 D:MAMMO'[";AGE" AGE S AG=$P(MAMMO,";AGE,",2),AG=$S(AG<40:3,AG>80:8,1:AG\10)
 S INP("DST")=DST,NREC=""
 F J=1:1:5 S $P(NREC,";",J)=$G(INP($P("MR,DST,CONSULT,PROVIDER,SITEC",",",J)))
 S NREC=$TR(NREC,LC,UP)
 S:$D(DELETE) (TYPS,NREC,MAMMO)="" I $D(REBUILD) S (OMAMMO,OREC)="" G M4
M3 I TYPS[1 S ROUT="^ZAA02GSCMRP"_$P(PARAM,"\") D M2
 I TYPS[2 S ROUT="^ZAA02GSCMRE"_$P(PARAM,"\",2) D M2
 I TYPS[3 S ROUT="^ZAA02GSCMRB"_$P(PARAM,"\",3) D M2
M4 I MAMMO'[";TS" S MAMMO=MAMMO_";TS"_$TR(TSU,"R","m")
 ;   S TSU=$E($P(MAMMO,";TS",2)) S:"RLBSAFO"[TSU TSU="M" S TSU=$TR(TSU,"m","R")
 S $P(NREC,";",6)=TSU
 G:$G(EDIT)["A" ABORT^ZAA02GSCMR1
 I '$D(EDIT) D:'$D(DELETE) CLASS D STAT
 I $D(DELETE) D CANC K @ZAA02GSCM@("EXAM",DOC),INP("TRACK") G M5
 I $D(REBUILD),REBUILD'=9 S TYPS=2
 I DOC]"",MAMMO]"" K:OTSU'=TSU&(OTSU]"") @ZAA02GSCMD@("ST",OTSU,"EXAM",DOC) S @ZAA02GSCM@("EXAM",DOC)=$P(NREC_";;;;;;;;;",";",1,8)_";"_MAMMO
 I TYPS[2!(TYPS[3) D LETTERS ; the order of these lines is important
 I $G(INP("SITEC"))]"",'$D(@ZAA02GSCMD@("SITEC",INP("SITEC"))) S ^(INP("SITEC"))=""
 K TYPS,INP("DST") S A=$F("ANBPSMKIH",$E($P(MAMMO,";AB",2)))-2 S:A<0 A=0 S:A>6 A=$P("4b,4c",",",A-6)
 S INP("BIRADS")=A I DOC]"",'$D(@ZAA02GSCR@("PARAM","NOBIRADS")),$O(@ZAA02GSCR@("TRANS",DOC,.03)) S C=.03  F  S C=$O(^(C)) Q:C=""  I ^(C)["BIRADS CATEGORY" S B=$O(^(C)) S:B="" B=C+10,^(B)=C_$C(1,1,1) D
 . S ^(C)=$P(^(C),"BIRADS")_"BIRADS CATEGORY "_A_":",$P(@ZAA02GSCR@("TRANS",DOC,B),$C(1),4)=$$BIRADS(A)
 I $D(@ZAA02GSCR@("TRANS",DOC,.011)) S ^(.011,"TRACK")=TSU S:$D(INP("BIRADS")) ^("BIRADS")=INP("BIRADS")
 ; S ^MARK(1)=$P(NREC_";;;;;;;;;;",";",1,8)_MAMMO,^MARK(2)=$P(OREC_";;;;;;;;;;",";",1,8)_OMAMMO
M5 K ROUT,EXAM,DS,DST,OMAMMO,OREC,INC,ODST,YR,DM,J,TY,CANCEL,AA,NSTAT,OSTAT,STATT,DELETE,T1,II,TECHO,SITEO Q
 ;
M2 N TS
 I $D(PREMIER) S SCr="##" D @PREMIER D SAVE Q
 K SM,ST,SY,SR,SD,W,BLD S SCr=$E(ROUT,8,9),SP="",$P(SP,$S(ZAA02G["PC":".",1:" "),60)="",X=1 S:$O(@ZAA02GSCMD@("XDIR",SCr,2,""))="" BLD=1
 F J=1:1:$L(MAMMO,";") S A=$P(MAMMO,";",J) I A]"" S D=$P(A,","),W=0 S:D'["|" W=+$E(D,4),D=$E(D,1,3) I D]"",$D(^(D)) S D=$P(^(D),","),(ST(W,D),SM(W,D))=$P(A,",",2)
 D @ROUT I '$D(REBUILD),'$D(NOCLR) S %R=ROUT["RB"+2,%C=1 W @ZAA02GP,ZAA02G("CS")
 D:'$D(CANCEL) SAVE Q
 ;
BIRADS(X) S TY="Needs Additional Imaging Evaluation,Negative,Benign Finding,Probably Benign Finding - Short Interval Follow-Up Suggested,Suspicious Abnormality - Biopsy Should Be Considered"
 S TY=TY_",Highly Suggestive of Malignancy - Appropriate Action Should Be Taken,Known Biopsy-Proven Malignancy - Appropriate Action Should Be Taken"
 S:$D(@ZAA02GSCR@("PARAM","BIRADS")) TY=^("BIRADS") Q $P(TY,",",X+1)
 ;
SAVE K:0 SM S A=""
 F W=0:1:4 I $D(ST(W)) S X=$S(W:W,1:"") F J=1:1 S A=$O(ST(W,A)) Q:A=""  K SD(W,A) S I=$P($G(@ZAA02GSCMD@("XDIR",SCr,1,A),A),","),L=$L($P(MAMMO,";"_I_X),";")+1,$P(MAMMO,";",L)=I_X_$S($L(ST(W,A)):","_ST(W,A),1:"") I '$D(SM(W,A))
 F W=0:1:4 I $D(SD(W)) S X=$S(W:W,1:"") F J=1:1 S A=$O(SD(W,A)) Q:A=""  I $D(SM(W,A)) D SV0
 K ST,SD,P,SM Q
SV0 S I=$P($G(@ZAA02GSCMD@("XDIR",SCr,1,A),A),","),L=$L($P(MAMMO,";"_I_X),";")+1,MAMMO=$P(MAMMO,";",1,L-1)_$S($P(MAMMO,";",$L(I,";")+L,99)]"":";"_$P(MAMMO,";",$L(I,";")+L,255),1:"")
 Q
STAT K II,BR S Typ=$S(MAMMO[";RAS":10,MAMMO[";RAP":11,MAMMO[";RAA":12,MAMMO[";RAF":13,MAMMO[";TSF":13,MAMMO[";TSA":12,MAMMO[";TSS":10,"LRB"[$E($P(MAMMO,";TS",2)):11,1:13)
 S BR=$G(@ZAA02GSCM@("PARAM","BIOPSY CODES")) F J=1:1:$L(BR,",") S I=$P(BR,",",J) I I]"" S BR(I)=""
 I OMAMMO'="" S INC=-1,TECHO="NA" S:OMAMMO[";OBT," TECHO=$P($P(OMAMMO,";OBT,",2),";") S AA=$P(OREC,";",1,5)_";"_TECHO D
 . N TSU,DST S TSU=OTSU,DST=ODST,DM=DST#100,YR=DST\100 S:YR<9000 YR=YR+10000 S YR=YR+190000 Q:TSU="?"
 . F J=1:1:$L(OMAMMO,";") S I=$P(OMAMMO,";",J) I I]"" S II(I_";"_AA)=-1 S:$D(BR(I)) II("BREQ;"_AA)=-1
 . S II("EXAMS;"_AA)=-1 S I=$P(OREC,";",8) S:I'="" II(I_";"_AA)=-1
 . F J=1:1:5 D S7
 I NREC'="" S INC=1,TECHN="NA" S:MAMMO[";OBT," TECHN=$P($P(MAMMO,";OBT,",2),";") S AA=$P(NREC,";",1,5)_";"_TECHN D
 . S DM=DST#100,YR=DST\100 S:YR<9000 YR=YR+10000 S YR=YR+190000
 . ;I YR=201009 W MAMMO,"  ",DOC,! R CCC
 . S BR=0 F J=1:1:$L(MAMMO,";") S I=$P(MAMMO,";",J) I I]"" S II(I_";"_AA)=$G(II(I_";"_AA))+1 S:$D(BR(I)) BR=1
 . S:BR II("BREQ;"_AA)=$G(II("BREQ;"_AA))+1
 . S II("EXAMS;"_AA)=$G(II("EXAMS;"_AA))+1 S I=$P(NREC,";",8) S:I'="" II(I_";"_AA)=$G(II(I_";"_AA))+1
 . F J=1:1:5 D S7
 S II="" F  S II=$O(II(II)) Q:II=""  I II(II) S INC=II(II) D:INC'=0 S1
 Q
S1 S AA=$P(II,";",2,99),I=$P(II,";"),TY=$S($P(AA,";",5)]"":$P(AA,";",5),1:"NA") G:I'["|" S6 N W,WI S WI=I F W=1:1:$L(WI,"|") S I=$P(WI,"|",W) D S6
 Q
S6 S:INC>0 @ZAA02GSCM@("XP",I,DST,DOC)="" K:INC<0 @ZAA02GSCM@("XP",I,DST,DOC)
 S Ty=AG D  S Ty=Typ D
 . F N=1:1:5 S T=$P(AA,";",$P("4,3,5,5,5",",",N)),T=$S(N=4:"TOTAL",N=5:$S(INC<0:TECHO,1:TECHN),T="":"NA",1:T) D
 .. S $P(^(Ty),"+",DM)=$P($G(@ZAA02GSCM@("STATS",YR,$S(34[N:"NA",1:TY),$P("PROV,REF,SITEC,SITEC,TECH",",",N),T,I,Ty)),"+",DM)+INC
 Q
S7 S W=$P("MR,DST,REF,PROV,SITEC",",",J)
 S T1=$P(AA,";",J) I T1]"" K:INC<0 @ZAA02GSCM@("DIR",W,T1,DST,DOC) S:INC>0 @ZAA02GSCM@("DIR",W,T1,DST,DOC)="" Q
 ;
CLASS Q:TSU'="M"  S M=0 I MAMMO'[";ABA" D
 . I OMAMMO["ABA" S MAMMO=MAMMO_";OBB"
 . X $G(@ZAA02GSCM@("PARAM","STATS CLASSC")) S M=1+M+$E("-336000",$F("BHMRLD",$E($P(MAMMO,";FA",2))))
 S I="TY"_M,$P(NREC,";",8)=I Q
 ;
LETTERS S Ts=TSU N TSU S TSU=Ts Q:$D(EDIT)  K CANC I '$D(REBUILD) S T=DST D JULIANX I T+30+$G(@ZAA02GSCM@("PARAM","LETTER_CUTOFF"))<$H Q
 N DST,DS,MAMMO,DOC S MR=INP("MR"),D=+$H D DATE
 D CANC  I $D(DELETE)  Q
 S D="STUD",(B,C)="" F  S C=B,B=D,D=$Q(@D) Q:D=""
 S D=$QS(B,1)\1 Q:D=0  S DOC=$QS(B,3),TSU=$QS(B,2),MAMMO=$P(@B,";",9,99) D LET1
 ; I $QS(C,2)'="",$QS(B,1)\1'=($QS(C,1)\1),$QS(B,2)'=$QS(C,2),$D(^ZAA02GSCMD("ST","M","PARAM","ONELETTERLIMIT")) S D=$QS(C,1)\1,TSU=$QS(C,2),MAMMO=$P(@C,";",9,99),DOC=$QS(C,3) D LET1
 Q
LET1 N C,B S (DST,T)=D D JULIANX S dt=T
 D LINE
 S Ts=TSU I TSU'="M",$D(^ZAA02GSCMD("ST",TSU,"PARAM","USE_MAMMO_LETTERS")) S TSU="M"
 F JJ=1:1:90,99 I $P($G(@ZAA02GSCM@("PARAM","LETTERS",JJ)),"\")="Y" S C=^(JJ) S t="T"_JJ D QUEUE
 K JJ,dt,t Q
QUEUE S L=$P($P(C,"\",4),"/",2) I L'["FA"
 G:$P(C,"\",4)="" Q0
 F D=1:1:$L(L,",") S M=$P(L,",",D) D:M["_" Q5 I M]"",MAMMO[(";"_M) G Q1
 S L=$P($P(C,"\",4),"/") G:L="" Q0 F D=1:1:$L(L,",") S M=$P(L,",",D) D:M["_" Q5 I M]"",MAMMO[(";"_M) G Q0
Q1 Q
Q0 G Q2:L]""&($P(C,"\",3)["T") G Q21:$P(C,"\",3)["FORMULA" S D=$P(C,"\",3)+dt G Q3
Q21 S FORMULA=0,L=$G(@ZAA02GSCM@("PARAM","VRULESX")) Q:L=""  S A=+$P(MAMMO,"AGE,",2),@L Q:FORMULA<0  S D="D="_$P(C,"\",3)_"+dt",@D G Q3
Q2 I +$P(MAMMO,";"_M_",",2) S T=+$P(MAMMO,";"_M_",",2),D="D="_$P(C,"\",3)_"+dt",@D
Q3 D DATE I $P(C,"\",5) D Q4 S D=D+$P(C,"\",5) D DATE
Q4 Q:$D(@ZAA02GSCM@("LETHIST",MR,DST,t))  I t'="T99",D+180<$H Q
 S @ZAA02GSCM@("LETMR",MR,DST,t,Y)=DOC_"-"_Ts,@ZAA02GSCM@("LETTYP",t,Y,MR)=DST_","_DOC_","_$G(INP("SITEC"))_","_Ts
 Q
Q5 N D F D=1:1:$L(M,"_")+1 I $P(M,"_",D)]"",MAMMO'[(";"_$P(M,"_",D)) S D=0 Q
 S M=$S(D:"A",1:"") Q
 ;
REDO ; run standalone to rebuild letters for a site
 ; based upon Mammo, but rebuilds for linked tracking
 S TSU="" F  S TSU=$O(^ZAA02GSCMD("ST",TSU)) Q:TSU=""  W TSU," " D
 . S DOC="",ZAA02GSCM="^ZAA02GSCMD(""ST"",TSU)",ZAA02GSCMD="^ZAA02GSCMD",ZAA02GSCR="^ZAA02GSCR"
 . S REBUILD=1,CTSU=TSU
 . F  S DOC=$O(@ZAA02GSCMD@("ST",TSU,"EXAM",DOC),-1) Q:DOC=""  S OREC=^(DOC),INP("MR")=$P(OREC,";") D LETTERS
 Q
MRCHECK R "ACCNT-",MR,! Q:MR=""  S OREC=MR,MRCHECK=1
 W " note - this ignores any NO LINK flags",!
 S DOC="",ZAA02GSCM="^ZAA02GSCMD(""ST"",TSU)",ZAA02GSCMD="^ZAA02GSCMD",ZAA02GSCR="^ZAA02GSCR"
 D STUDIES N (STUD) W
 G MRCHECK
 ;
SS ; TEST STUDIES LOGIC FOR RECALL + REPEAT BIOPSY
 S D=+$H D DATE R "STOP ON EACH ACCOUNT?-Y/N ",A I A="Y" S TEST=1
 S MR="" F  S MR=$O(^ZAA02GSCMD("ST","M","LETMR",MR)) Q:MR=""  D
 . S OREC=MR,MRCHECK=1
 . S DOC="",ZAA02GSCM="^ZAA02GSCMD(""ST"",TSU)",ZAA02GSCMD="^ZAA02GSCMD",ZAA02GSCR="^ZAA02GSCR"
 . W !!,"MR-",MR D STUDIES,CORR
 Q
CORR N (STUD) S A="STUD"
 F  S A=$Q(@A) Q:A=""  D
 . S E=$E($P(@A,";TS",2)),B=$QS(A,1) Q:"RLBS"'[E  Q:B<100000
 . S C=A W:$G(TEST) !,B,"-",E,"  " S T=B\1 D JULIANX S ST=T
 . S G=0 F  S F=C,C=$Q(@C) Q:C=""  S D=$QS(C,1),T=D\1 D JULIANX Q:T-330>ST  D
 .. S G=1 W:$G(TEST) D,"-",T-ST,"  " I @C[";XXR",$P($G(^ZAA02GSCMD("ST",$QS(C,2),"EXAM",$QS(C,3))),";",9,99)[";XXR" D
 ... S DOC=$QS(C,3),OREC=@C,NREC=$P(OREC,";XXR")_$P(OREC,";XXR",2,9),^(DOC)=NREC D CORRS
 . I G,@A'[";XXR",$G(^ZAA02GSCMD("ST",$QS(A,2),"EXAM",$QS(A,3)))]"" S DOC=$QS(A,3),OREC=@A,NREC=OREC_";XXR",^(DOC)=NREC D CORRS
 . S A=F
 R:$G(TEST) CCC Q
CORRS F J=1:1:6 S @$P("MR,DST,REF,PROV,SITEC,TSU",",",J)=$P(OREC,";",J)
 S OTSU=TSU,ODST=DST,ZAA02GSCM="^ZAA02GSCMD(""ST"",TSU)" S AG=$P(NREC,";AGE,",2),AG=$S(+AG<40:3,AG>80:8,1:AG\10)
 S INP("DST")=DST,OMAMMO=$P(OREC,";",9,99),MAMMO=$P(NREC,";",9,99) D STAT Q
 ;
 ;
STUDIES K STUD S B=$P(OREC,";") S:B="" B=INP("MR")
 S Ts="" F  S Ts=$O(@ZAA02GSCMD@("ST",Ts)) Q:Ts=""  D
 . I '$D(MRCHECK),$D(@ZAA02GSCMD@("ST",Ts,"PARAM","NO_CANCEL")) Q
 . I '$D(MRCHECK),CTSU'=Ts,$D(@ZAA02GSCMD@("ST",Ts,"PARAM","NOT_LINKED")) Q
 . S TSU=Ts S (C,D,E)="" F  S C=$O(@ZAA02GSCM@("DIR","MR",B,C)) Q:C=""  F  S E=$O(@ZAA02GSCM@("DIR","MR",B,C,E)) Q:E=""  S F=$G(@ZAA02GSCM@("EXAM",E)) I F]"" D
 .. F  S D=$O(@ZAA02GSCM@("LETMR",B,C,D)) Q:D=""  S G=$O(^(D,"")) I +^(G)=E S F=F_" "_D
 .. S STUD(C_"."_$S(TSU="M":1,1:2),TSU,E)=F
 Q
 ; STILL NEED TO IMPLEMENT THE "ONE_LETTER_LIMIT" LOGIC
 ;
CANC N TSU K CANC D STUDIES
 I '$D(STUD) S CANC=1 Q
 S (C,D,E,Ts)="" F  S C=$O(STUD(C)) Q:C=""  F  S Ts=$O(STUD(C,Ts)) Q:Ts=""  D
 . S TSU=Ts I TSU'="M",$D(^ZAA02GSCMD("ST",TSU,"PARAM","USE_MAMMO_LETTERS")) S TSU="M"
 . F  S D=$O(@ZAA02GSCM@("LETMR",B,C\1,D)) Q:D=""  F  S E=$O(@ZAA02GSCM@("LETMR",B,C\1,D,E)) Q:E=""  D
 .. I TSU="M",CTSU'="M",C\10000-(E\10000)*8800+E-C>900 Q
 .. K ^(E),@ZAA02GSCM@("LETTYP",D,E,B)
 . I $O(@ZAA02GSCM@("LETMR",B,C\1,""))="" K @ZAA02GSCM@("LETMR",B,C\1)
 Q
 ;
LINE S yy=$G(@ZAA02GSCR@("TRANS",DOC,.011)),Ts=TSU N TSU S TSU=Ts
 S LINE="" F J=2:1:6,8 S $P(LINE,"`",J)=$E($P(yy,"`",$P(",8,9,7,16,1,,6",",",J))_"~              ",1,$P(",15,11,4,6,7,,6",",",J))
 S yy=DST+19000000
 S $P(LINE,"`",7)=$E(yy,5,6)_"/"_$E(yy,7,8)_"/"_$E(yy,1,4),$P(LINE,"`",9)=$E("0123456",$F("ANBPSMK",$E($P(MAMMO,";AB",2)))-1)
 I TSU'="M",$D(^ZAA02GSCMD("ST",TSU,"PARAM","USE_MAMMO_LETTERS")) S TSU="M"
 S @ZAA02GSCM@("LETMR",MR,DST)=LINE K yy Q
 ;
DATE S k=D>21608+305+D,Y=4*k+3\1461,d=k*4+3-(1461*Y)+4\4,m=5*d-3\153,d=5*d-3-(153*m)+5\5,m=m+2,Y=m\12+Y-60,m=m#12+1,Y=Y*100+m*100+d K d,m,k Q
JULIANX S y=T\10000,m=T#10000\100-3,d=T#100 G JULIAN1
JULIAN S m=+T-3,d=$P(T,"/",2),y=$P(T,"/",3) I (m+d+y)<-2 S T="" Q
JULIAN1 S:y<200 y=y+1900 S o=$S(y<1900:-14917,1:21608),y=y>1999*100+$E(y,3,4) S:m<0 m=m+12,y=y-1 S T=1461*y\4,T=153*m+2\5+T+d+o K m,y,o,d Q
 ;
AGE S AG="",T=$G(INP("DOB")) I T["/" D JULIAN S AG=T,T=DS D JULIAN S AG=T-AG\365.25,MAMMO=MAMMO_";AGE,"_AG Q
 Q
 ;
HL7TEST S DOC=1,CODES="TSB;ABN;RCN" D HL7 Q
 ;
HL7 ; FROM HL7 INTERFACE
 N (DOC,USER,TRANS,CODES,STSU)
 S USER=$G(USER,"VT") D INIT^ZAA02GVBMAMO
 S DIR="TRANS",ZAA02G=1,TRANS=$G(TRANS,USER) D DATE^ZAA02GSCRER,FETCH^ZAA02GSCRER
 S TSU=$G(STSU,TSU)
 S PREMIER="HL72^ZAA02GSCMR" D PREMIER^ZAA02GSCMR Q
 ;                 
HL72 S MAMMO=MAMMO_";"_CODES Q
 ;
ZZ K ^ZAA02GSCMD("ST","M","STATS") F  H 3 K B M B=^ZAA02GSCMD("ST","M","STATS") N (B) W
 Q
