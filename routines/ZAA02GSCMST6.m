ZAA02GSCMST6 ;PG&A,ZAA02G-MTS,1.20,REPORTS-STATS BY AGE;2DEC94 4:57P;06MAR2002  11:43;;Thu, 27 Jul 2017  10:49
C ;Copyright (C) 1995, Patterson, Gray & Associates, Inc.
 ;
REP1 D REP2 Q:J>900
 Q
REP2 D:LN>2 NEXT Q:J>900  F J=1:1:900 S CT=$O(^ZAA02GTSCM($J,T1,CT)) Q:CT=""  D REP3
 Q
REP3 D:LN+6>LNM NEXT Q:J>900  I DEVICE>1,T2'=9 W ! S LN=LN+1
 W ?3 W:T2=9 ?OFF W " ",CT,$J("",5-$L(CT))
 ; W T1," ",CT," ",TYPE," ",T2,!
 I CT'="TOTAL" D
 . I T1="REF" W $$REFNAME^ZAA02GSCMIF(CT)
 . I T1="PROV" W $$PROVNAM^ZAA02GSCMIF(CT)
 . I T1="SITEC" W $$SITENAM^ZAA02GSCMIF(CT)
 . I T1="TECH"
 I T2'=10 W ! S LN=LN+1
 S DD="DATA"_T2,(D5,D6)=0,FL=6,LM=$S(T2=13:9,1:8),LS=3 I T6 S LS=10,LM=13,FL=9 I $G(^ZAA02GSCMD("ST","M","PARAM","REPORT-BY-TYPE"))]"" S LM=11
 I DD="DATA5" I "M2,M3"[$P($G(@ZAA02GSCM@("PARAM","INPUT")),"\",12) S DD="DATA55"
 S (LT,N)="" F II=1:1 S LD=N,N=$P($T(@DD+II),";",2,99) Q:N=""  F TY=1,2 I $P("1,2,12",",",TYPE)[TY,$P(N,";")[TY D REP5,REP4 G:J>900 REPT
REPT Q
REP5 S T=$P(N,";",2),TT=$P(N,";",5,99),(D1,D2,D3)=0 Q:TT=""
 S F=$P(N,";",3) S:F]"" TY(TY,1)=F S:F="" F=TY(TY,1) S:T="" T=$P(LD,";",2)
 S L=$P(N,";",4) S:L]"" TY(TY,2)=L S:L="" L=TY(TY,2)
 F M=1:1 S SI=$P(TT,";",M) Q:SI=""  D
 . I SI["@ZAA02GSCM" S SI=$G(@SI)
 . S D="D"_M F J=1:1 S CD=$P(SI,",",J) Q:CD=""  S C=$G(^ZAA02GTSCM($J,T1,CT,CD)) F I=LS:1:LM S $P(@D,",",I)=$P(@D,",",I)+$P(C,"+",I)
 Q
REP4 I TT="" D:LN+3>LNM NEXT Q:J>900  W ?OFF+2,T,! S LN=LN+1 Q
 G:F="*" REP6
 D:LN>LNM NEXT Q:J>900  S:T=LT&(LT'="") T="  """ W ?OFF+3,T,?OFF+7 S LT=T
 S (D7,D8)=0 F I=LS:1:LM S D7=D7+$P(D1,",",I),D8=D8+$P(D2,",",I)
 S TT=0 W ?OFF+$S(T2=13:30,1:37) F I=LS:1:LM S @L W @F S TT=TT+D
 S D=TT I L'["/" W @F,! S LN=LN+1 Q
 S D1=D7,D2=D8,I=1 S @L W @F,! S LN=LN+1 Q
 ;
REP6 S TT=0 F I=LS:1:LM S @L,TT=TT+D
 Q
 ;
NEXT G NEXT^ZAA02GSCMST4
JJ(x) Q $S(x>1000:$J("",FL-1)_"-",1:x)
 ;
DATA1 ; INTERPRETATION
 ;2;;*;D5=D5+$P(D1,",",I);ABN,ABB,ABP,ABS,ABH,ABM,ABA,ABI,ABK
 ;1;Negative (1);$J(+D,FL);D=$P(D1,",",I);ABN
 ;2;;$J(D,FL,1)_"%";D=$P(D1,",",I)/(D5+.00001)*100;ABN
 ;12;Benign Finding (2);;;ABB
 ;12;Probably Benign (3);;;ABP
 ;12;Suspicious Abnormality (Low) (4a);;;ABS
 ;12;Suspicious (Intermediate) (4b);;;ABI
 ;12;Suspicious (Moderate) (4c);;;ABH
 ;12;Highly Sugg of Malignancy (5);;;ABM
 ;12;Known Malignancy (6);;;ABK
 ;12;Incomplete Findings (0);;;ABA
 ;12;Total;;;ABN,ABB,ABP,ABS,ABH,ABM,ABA,ABK,ABI
 ;
DATA2 ; RECOMMENDATION
 ;2;;*;D5=D5+$P(D1,",",I);RCN,RCD,RCA,RCB,RCE,RCR,RCJ,RCF,RCC,RCH,RCL,RCT,RCP,RCM,RCU,RCG,RCY,RCS,RCO,RCI,RCm
 ;1;Normal Interval;$J(+D,FL);D=$P(D1,",",I);RCN
 ;2;;$J(D,FL,1)_"%";D=$P(D1,",",I)/(D5+.00001)*100;RCN
 ;12;Decision to bx based on clinical;;;RCD
 ;12;Cyst Aspiration;;;RCA
 ;12;Consider biopsy;;;RCB
 ;12;Excisional biopsy;;;RCE
 ;12;Core biopsy (stereotactic);;;RCR
 ;12;U/S core biopsy;;;RCJ
 ;12;Follow up < 1 yr;;;RCF
 ;12;Clinical correlation;;;RCC
 ;12;Histology using core bx;;;RCH
 ;12;Core biopsy;;;RCL
 ;12;Take appropriate action;;;RCT
 ;12;Additional projections;;;RCP
 ;12;Magnification view;;;RCM
 ;12;Ultrasound;;;RCU
 ;12;Spot compression;;;RCG
 ;12;Cytologic analysis;;;RCY
 ;12;U/S fine needle aspiration;;;RCS
 ;12;Old films for comparison;;;RCO
 ;12;Galactogram;;;RCI
 ;12;MRI;;;RCm
 ;12;Total;;;RCN,RCD,RCA,RCB,RCE,RCR,RCJ,RCF,RCC,RCH,RCL,RCT,RCP,RCM,RCU,RCG,RCY,RCS,RCO,RCI,RCm
 ;
DATA3 ; BIOPSY REPORT           BREQ
 ;12;Total Biopsies;$J(+D,FL);D=$P(D1,",",I);FAB,FAH,FAM
 ;12;Cancers Found;$J(+D,FL);D=$P(D1,",",I);FAM
 ;12;Total Exams;$J(+D,FL);D=$P(D1,",",I);EXAMS
 ;12;Cancers/1000 Exam;$J(+D,FL,0);D=$P(D1,",",I)/($P(D2,",",I)+.00001)*1000;FAM;EXAMS
 ;12;Positive Biopsy Rate;$S(D="-":$J(D,FL),1:$J(+D,FL-1,0)_"%");D=$P(D2,",",I),D=$S(D=0:"-",1:$P(D1,",",I)/(D+.00001)*100);FAM;BREQ
 ;12;Biopsies per Cancer Found;$$JJ($J(D,FL,1));D=$P(D2,",",I)/($P(D1,",",I)+.00001);FAM;BREQ
 ;12;;*
 ;12;Number Biopsies Recommended;$J(+D,FL);D=$P(D1,",",I);BREQ
 ;12;Number Biopsies Followed Up;$J(+D,FL);D=$P(D1,",",I);FAB,FAD,FAH,FAL,FAM,FAR
 ;
DATA4 ; DETECTION
 ;12;Cancers found by Reason of Exam
 ;12;Screening;$J(+D,FL);D=$P(D1,",",I);XRA
 ;12;Repeat;;;XRrR
 ;12;Followup;;;XRrF
 ;12;Special View;;;XRrS
 ;12;Diagnostic;;;XRrD
 ;12;Other;;;XRrN
 ;12;Total;;;XRrT
 ;
DATA5 ;TYPE OF STUDY
 ;2;;*;D5=D5+$P(D1,",",I);TSB,TSL,TSR,TSS,TSF,TSA,TSO
 ;1;Screening;$J(+D,FL);D=$P(D1,",",I);TSS
 ;2;;$J(D,FL,1)_"%";D=$P(D1,",",I)/(D5+.00001)*100;TSS
 ;12;Diagnostic;;;TSL,TSR,TSB
 ;12;Addn Views;;;TSA
 ;12;Follow-up;;;TSF
 ;12;Review of outside study;;;TSO
 ;12;Total;;;TSB,TSL,TSR,TSS,TSA,TSF,TSO
 ;
DATA55 ;EXAMINATION REASON
 ;2;;*;D5=D5+$P(D1,",",I);RAS,RAP,RAF,RAA,RAO
 ;1;Screening;$J(+D,FL);D=$P(D1,",",I);RAS
 ;2;;$J(D,FL,1)_"%";D=$P(D1,",",I)/(D5+.00001)*100;RAS
 ;12;Diagnostic;;;RAP
 ;12;Addn Views;;;RAA
 ;12;Follow-up;;;RAF
 ;12;Review of outside study;;;RAO
 ;12;Total;;;RAS,RAP,RAF,RAA,RAO
 ;
DATA6 ; OVERVIEW
 ;2;;*;D5=D5+$P(D1,",",I);EXAMS
 ;1;Total Procedures;$J(+D,FL);D=$P(D1,",",I);EXAMS
 ;2;;$J(D,FL-1,0)_"%";D=$P(D1,",",I)/(D5+.00001)*100;EXAMS
 ;1;Asymptomatic Patients;$J(+D,FL,0);D=$P(D1,",",I)-$P(D2,",",I);EXAMS;IAA,IAB,IAD,IAE,IAI,IAK,IAL,IAN,IAP,IAW,IAX,RAP,TSB,TSR,TSL,TSA
 ;2;;$J(D,FL-1,0)_"%";D=$P(D1,",",I)-$P(D2,",",I)/($P(D1,",",I)+.00001)*100;EXAMS;IAA,IAB,IAD,IAE,IAI,IAK,IAL,IAN,IAP,IAW,IAX,RAP,TSB,TSL,TSR,TSA
 ;1;Negative findings;$J(+D,FL,0);D=$P(D1,",",I);ABN,ABB,ABP
 ;2;;$J(D,FL-1,0)_"%";D=$P(D1,",",I)/(D5+.00001)*100;ABN,ABB,ABP
 ;12;Abnormal findings;;;ABS,ABH,ABM,ABI,ABK
 ;12;;*
 ;12;Negative Assessment (1);;;ABN
 ;12;Benign Finding (2);;;ABB
 ;12;Probably Benign (3);;;ABP
 ;12;Suspicious Abnormality (4a);;;ABS
 ;12;Highly Suspicious (4b,4c);;;ABH,ABI
 ;12;Highly Sugg of Malignancy (5);;;ABM
 ;12;Known Malignancy (6);;;ABK
 ;12;Incomplete Findings (0);;;ABA
 ;12;;*
 ;12;Cancers Found;$J(+D,FL);D=$P(D1,",",I);FAM
 ;12;Cancers/1000 Mammograms;$J(+D,FL,0);D=$P(D1,",",I)/($P(D2,",",I)+.00001)*1000;FAM;EXAMS
 ;12;Total Biopsies;$J(+D,FL);D=$P(D1,",",I);FAB,FAH,FAM
 ;12;Positive Biopsy Rate;$S(D="-":$J(D,FL),1:$J(+D,FL-1,0)_"%");D=$P(D2,",",I),D=$S(D=0:"-",1:$P(D1,",",I)/(D+.00001)*100);FAM;BREQ
 ;12;Biopsies per Cancer Found;$$JJ($J(D,FL,1));D=$P(D2,",",I)/($P(D1,",",I)+.00001);FAM;BREQ
 ;12;;*
 ;12;False Negatives;$J(+D,FL);D=$P(D1,",",I);TY7
 ;12;True Negatives;$J(+D,FL);D=$P(D1,",",I);TY4,TY1
 ;12;False Positives;$J(+D,FL);D=$P(D1,",",I);TY5,TY6
 ;12;True Positives;$J(+D,FL);D=$P(D1,",",I);TY8,TY9,TY2,TY3
 ;12;Positive Predictive Value;$S(D="-":$J(D,FL),1:$J(+D,FL-1,0)_"%");D=$P(D1,",",I)+$P(D2,",",I),D=$S(D=0:"-",1:$P(D1,",",I)/(D+.00001)*100);TY8,TY9,TY2,TY3;TY5,TY6
 ;12;Negative Predictive Value;$S(D="-":$J(D,FL),1:$J(+D,FL-1,0)_"%");D=$P(D1,",",I)+$P(D2,",",I),D=$S(D=0:"-",1:$P(D1,",",I)/(D+.00001)*100);TY4,TY1;TY7
 ;12;Sensitivity (True Pos Rate);$S(D="-":$J(D,FL),1:$J(+D,FL-1,0)_"%");D=$P(D1,",",I)+$P(D2,",",I),D=$S(D=0:"-",1:$P(D1,",",I)/(D+.00001)*100);TY8,TY9,TY2,TY3;TY7
 ;12;Specificity (True Neg Rate);$S(D="-":$J(D,FL),1:$J(+D,FL-1,0)_"%");D=$P(D1,",",I)+$P(D2,",",I),D=$S(D=0:"-",1:$P(D1,",",I)/(D+.00001)*100);TY1,TY4;TY5,TY6
 ;12;Abnormal interpretation rate;$J(+D,FL-1,0)_"%";D=$P(D1,",",I)/($P(D2,",",I)+.00001)*100;ABS,ABH,ABM,ABI,ABK;EXAMS
 ;12;Recalls;$J(+D,FL);D=$P(D1,",",I);ABA,ABS,ABH,ABI,ABM
 ;12;Recall Rate;$J(+D,FL-1,0)_"%";D=$P(D1,",",I)/($P(D2,",",I)+.00001)*100;ABA,ABS,ABH,ABI,ABM;EXAMS
 ;12;;*
 ;12;Number Biopsies Recommended;$J(+D,FL);D=$P(D1,",",I);BREQ
 ;12;Number Pathology Results Entered;$J(+D,FL);D=$P(D1,",",I);FAB,FAD,FAH,FAL,FAM,FAR
 ;
 ;12;#Recommended minus #Results;$J(+D,FL);D=$P(D2,",",I)-$P(D1,",",I);FAB,FAD,FAH,FAL,FAM,FAR;BREQ
 ;12;Recalls;$J(+D,FL);D=$P(D1,",",I);XXR
 ;12;Recall Rate;$J(+D,FL-1,0)_"%";D=$P(D1,",",I)/($P(D2,",",I)+.00001)*100;XXR;EXAMS
 ;1
DATA7 ; OVERVIEW2
 ;2;;*;D5=D5+$P(D1,",",I);EXAMS
 ;1;Total Procedures;$J(+D,FL);D=$P(D1,",",I);EXAMS
 ;2;;$J(D,FL-1,0)_"%";D=$P(D1,",",I)/(D5+.00001)*100;EXAMS
 ;1;Negative findings;$J(+D,FL,0);D=$P(D1,",",I);ABN,ABB,ABP
 ;2;;$J(D,FL-1,0)_"%";D=$P(D1,",",I)/(D5+.00001)*100;ABN,ABB,ABP
 ;12;Abnormal findings;;;ABS,ABH,ABM,ABI,ABK
 ;12;;*
 ;12;Negative Assessment (1);;;ABN
 ;12;Benign Finding (2);;;ABB
 ;12;Probably Benign (3);;;ABP
 ;12;Suspicious (4);;;ABS,ABH,ABI
 ;12;Highly Sugg of Malignancy (5);;;ABM
 ;12;Known Malignancy (6);;;ABK
 ;12;Incomplete Findings (0);;;ABA
 ;12;;*
 ;12;Cancers Found;$J(+D,FL);D=$P(D1,",",I);FAM
 ;12;Cancers/1000 Mammograms;$J(+D,FL,0);D=$P(D1,",",I)/($P(D2,",",I)+.00001)*1000;FAM;EXAMS
 ;12;Total Biopsies;$J(+D,FL);D=$P(D1,",",I);FAB,FAH,FAM
 ;12;Positive Biopsy Rate;$S(D="-":$J(D,FL),1:$J(+D,FL-1,0)_"%");D=$P(D2,",",I),D=$S(D=0:"-",1:$P(D1,",",I)/(D+.00001)*100);FAM;BREQ
 ;12;Biopsies per Cancer Found;$$JJ($J(D,FL,1));D=$P(D2,",",I)/($P(D1,",",I)+.00001);FAM;FAH,FAM,FAB
 ;12;;*
 ;12;False Negatives;$J(+D,FL);D=$P(D1,",",I);TY7
 ;12;True Negatives;$J(+D,FL);D=$P(D1,",",I);TY4,TY1
 ;12;False Positives;$J(+D,FL);D=$P(D1,",",I);TY5,TY6
 ;12;True Positives;$J(+D,FL);D=$P(D1,",",I);TY8,TY9,TY2,TY3
 ;12;;*
 ;12;Number Biopsies Recommended;$J(+D,FL);D=$P(D1,",",I);BREQ
 ;12;Number Biopsies Followed Up;$J(+D,FL);D=$P(D1,",",I);FAB,FAD,FAH,FAL,FAM,FAR
 ;
DATA8 ; OVERVIEW3
 ;2;;*;D5=D5+$P(D1,",",I);EXAMS
 ;1;Total Procedures;$J(+D,FL);D=$P(D1,",",I);EXAMS
 ;2;;$J(D,FL-1,0)_"%";D=$P(D1,",",I)/(D5+.00001)*100;EXAMS
 ;1;Negative findings;$J(+D,FL,0);D=$P(D1,",",I);ABN,ABB,ABP
 ;2;;$J(D,FL-1,0)_"%";D=$P(D1,",",I)/(D5+.00001)*100;ABN,ABB,ABP
 ;12;Abnormal findings;;;ABS,ABH,ABM,ABI,ABK
 ;12;;*
 ;12;Negative Assessment (1);;;ABN
 ;12;Benign Finding (2);;;ABB
 ;12;Probably Benign (3);;;ABP
 ;12;Suspicious (4);;;ABS,ABH,ABI
 ;12;Highly Sugg of Malignancy (5);;;ABM
 ;12;Known Malignancy (6);;;ABK
 ;12;Incomplete Findings (0);;;ABA
 ;12;;*
 ;12;Cancers Found;$J(+D,FL);D=$P(D1,",",I);FAM
 ;12;Cancers/1000 Mammograms;$J(+D,FL,0);D=$P(D1,",",I)/($P(D2,",",I)+.00001)*1000;FAM;EXAMS
 ;12;Total Biopsies;$J(+D,FL);D=$P(D1,",",I);FAB,FAH,FAM
 ;12;Positive Biopsy Rate;$S(D="-":$J(D,FL),1:$J(+D,FL-1,0)_"%");D=$P(D2,",",I),D=$S(D=0:"-",1:$P(D1,",",I)/(D+.00001)*100);FAM;BREQ
 ;12;Biopsies per Cancer Found;$$JJ($J(D,FL,1));D=$P(D2,",",I)/($P(D1,",",I)+.00001);FAM;FAH,FAM,FAB
 ;12;;*
 ;12;False Negatives;$J(+D,FL);D=$P(D1,",",I);TY7
 ;12;True Negatives;$J(+D,FL);D=$P(D1,",",I);TY4,TY1
 ;12;False Positives;$J(+D,FL);D=$P(D1,",",I);TY5,TY6
 ;12;True Positives;$J(+D,FL);D=$P(D1,",",I);TY8,TY9,TY2,TY3
 ;12;;*
 ;12;Number Biopsies Recommended;$J(+D,FL);D=$P(D1,",",I);BREQ
 ;12;Number Biopsies Followed Up;$J(+D,FL);D=$P(D1,",",I);FAB,FAD,FAH,FAL,FAM,FAR
 ;
DATA9 ; PROCEDURES/PATHOLOGY 1
 ;2;;*;D5=D5+$P(D1,",",I);EXAMS
 ;1;Total Procedures;$J(+D,FL);D=$P(D1,",",I);EXAMS
 ;2;;$J(D,FL-1,0)_"%";D=$P(D1,",",I)/(D5+.00001)*100;EXAMS
 ;1;Number Biopsies Recommended;$J(+D,FL);D=$P(D1,",",I);BREQ
 ;2;;$J(D,FL-1,0)_"%";D=$P(D1,",",I)/(D5+.00001)*100;BREQ
 ;1;Number Benign;$J(+D,FL);D=$P(D1,",",I);FAB
 ;2;;$J(D,FL-1,0)_"%";D=$P(D1,",",I)/(D5+.00001)*100;FAB
 ;12;Number High Risk;$J(+D,FL);D=$P(D1,",",I);FAH
 ;12;Number Malignant;$J(+D,FL);D=$P(D1,",",I);FAM
 ;12;Not Biopsied;$J(+D,FL);D=$P(D1,",",I);FAD,FAP,FAR
 ;12;No Response;$J(+D,FL);D=$P(D1,",",I);FAL
 ;
 ;
DATA10 ; NUMBER OF EXAMS
 ;2;;*;D5=D5+$P(D1,",",I);EXAMS
 ;1;;$J(+D,FL);D=$P(D1,",",I);EXAMS
 ;2;;$J(D,FL-1,0)_"%";D=$P(D1,",",I)/(D5+.00001)*100;EXAMS
 ;
DATA11 ; PROCEDURES/PATHOLOGY 2
 ;2;;*;D5=D5+$P(D1,",",I);EXAMS
 ;1;Total Procedures;$J(+D,FL);D=$P(D1,",",I);EXAMS
 ;2;;$J(D,FL-1,0)_"%";D=$P(D1,",",I)/(D5+.00001)*100;EXAMS
 ;12;Number Biopsies Recommended;$J(+D,FL);D=$P(D1,",",I);BREQ
 ;12;Number Path Results entered;$J(+D,FL);D=$P(D1,",",I);FAB,FAM,FAH,FAD,FAP,FAR,FAL
 ;12;Path Results without Recomm;$J(+D,FL);D=$P(D1,",",I)-$P(D2,",",I);FAB,FAM,FAH,FAD,FAP,FAR,FAL;BREQ
 ;12;Number Benign;$J(+D,FL);D=$P(D1,",",I);FAB
 ;12;Number Malignant;$J(+D,FL);D=$P(D1,",",I);FAM,FAH
 ;12;Not Biopsied;$J(+D,FL);D=$P(D1,",",I);FAD,FAP,FAR
 ;12;No Response;$J(+D,FL);D=$P(D1,",",I);FAL
 ;
DATA13 ;PATIENT OUTCOME DATA
 ;1;Screening;$J(+D,FL);D=$P(D1,",",I);TSS
 ;2;;$J(D,FL-1,0)_"%";D=$P(D1,",",I)/(D7+.00001)*100;TSS
 ;12;Diagnostic;;;TSL,TSR,TSB,RAP
 ;1;Undifferentiated;$J(+D,FL);D=$P(D1,",",I)-$P(D2,",",I);EXAMS;TSS,TSB,TSL,TSR,RAS
 ;2;;$J(D,FL-1,0)_"%";D=$P(D1,",",I)-$P(D2,",",I)/(D7-D8+.00001)*100;EXAMS;TSS,TSB,TSL,TSR
 ;
 ;2;;$J(D,FL-1,0)_"%";D=$P(D1,",",I)-$P(D2,",",I)/(D5+.00001)*100;EXAMS;TSS,TSB,TSR,TSL
 ;
 ;
