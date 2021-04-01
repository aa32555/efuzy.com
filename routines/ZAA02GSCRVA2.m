ZAA02GSCRVA2 ;PG&A,ZAA02G-SCRIPT,2.10,VA LOOKUP ROUTINE - 2;22NOV94  21:55;;;15MAY98  11:09
 ;
 ;  LOOKUP PATIENT BY NAME - SUPPORTS DIFFERENT LOOKUP BY SITE
LKP S X=$TR(X,"?"),FX="" I X["," S FX=$P(X,",",2),X=$P(X,",") S:$E(FX)'=" " FX=" "_FX
 G:X_FX?." " LKP1
 S G="^DPT(""B"")",RX=0 D LKPX,REFRESH I X[";EX"!(X="") S X="" G LKP1
 D PUT S RX=2+$D(MRLK)
LKP1 I 1 K FX,MRLK,TYP,REF Q
LKPX K INCOMP,REF N:1 (X,FX,ZAA02G,ZAA02GP,G,INP,INCOMP,REF,TYP,REFRESH) S Z=X_"z" S:X="" X="@" I X?1.N S Z=X
 ;S TYP=$G(INP("SITEC")),TYP=$S(TYP="":3,TYP="DS":1,TYP="LAB":5,TYP="C&P":4,1:3)
 S:'$D(TYP) TYP=3
 S Y=TYP=3*10+1_",3\RHLGSD\1\Patients\        Name             SSAN#      Age  Sex "
 S Y=Y_$S(TYP=1:"   Admit       Disch    ds ",TYP=2:"   Exam      Req#   Proc",TYP=4:" Requested Exam           ",TYP=5:"   Date     Case#    Proc",1:"")
 S Y(0)="\EX,IL\\$S(ni=S2:""   """""",1:$P($G(^DPT(S2,0)),""^""));20`$P($G(^DPT(S2,0)),""^"",9);10`$$AGE^ZAA02GSCRVA;3`$P($G(^(0)),""^"",2);1"_$S(TYP'=3:"`$$REF^ZAA02GSCRVA2(TO);29",1:"")_"\"_X_"|0\\\"_Z
 S $P(Y(0),"\",6)="Return, Exit, Insert Line   *"
 D LOOK,POP I X[";IL" S X=$P(X,"|",2),INCOMP=0,REF="INCOMPLETE"_"\"_TYP_"|"_X Q
 S REF="" I X'="" S:TYP'=3 REF=$$REF(X)_"\"_TYP_"|"_$P(X,"|",2,3) S:TYP=2 $P(REF,"|",3)=+$TR($P(REF," ",2,8)," ") S X=$P(X,"|",2)
 ;
 Q
 ;
REF(x) I TYP=4 S x=$G(^DVB(396.4,+$P(x,"|",3),0)) Q $J($$DT($P(x,"^",6)),10)_" "_$J($P(x,"^"),7)_" "_$E($P($G(^DVB(396.6,$P(x,"^",3),0)),"^"),1,10)
 I TYP=2 Q $J($$DT($P($G(^RADPT($P(x,"|",2),"DT",+$P(x,"|",3),0)),"^")),10)_" "_$J($P($G(^("P",+$P($P(x,"|",3),",",2),0)),"^",11),7)_" "_$E($P($G(^RAMIS(71,+$P($G(^(0)),"^",2),0)),"^"),1,10)
 I TYP=1 Q $J($$DT($P($G(^DGPT(S3,0)),"^",2)),10)_$J($$DT($P($G(^(70)),"^")),12)_$$DCS
 I TYP=5 Q $J($$DT($P($G(^SRF(+$P(x,"|",3),0)),"^",9)),10)_" "_$J(+$P(x,"|",3),6)_" "_$E($S($D(^SRF(+$P(x,"|",3),"SR")):^("SR"),1:$P($G(^("OP")),"^")),1,11)
 Q ""
 ;
DT(dt) Q:dt="" "" Q $E(dt,4,5)_"/"_$E(dt,6,7)_"/"_($E(dt,1,3)+1700)
 ;
DCS() S dcs=$O(^GMR(128,"AB",S2,1,9999999-($P(^DGPT(S3,0),"^",2)\1),0)) I dcs,$P(^GMR(128,dcs,0),"^",11)=S3 Q " ds"
 Q "   "
 ;
PUTTEMP S opi=opi+1,opi(opi)="PDSP;TEMPLATE;"""_dt_"""" X op N X S X=dt D VAR1^ZAA02GSCRVA1 K dt Q
 ;
LKAD ; LOOKUP PATIENT BY SSAN OR NAME WITH OPTIONAL TYPE
 Q:X=""   I RX=99 S RX=9998 Q
 I $TR(X,"-")?9N S X=$TR(X,"-"),G="^DPT(""SSN"")" G LKAD0
 I X?2.3A3.N G AUTO
 I X?2.3A1":".E G AUTO
 I X?1A.AP S MRLK=0 G LKP
 S X=$TR(X,LC_"?",UP) I X?1A4N,$D(^DPT("BS5",X))=10 S G="^DPT(""BS5"")" G LKAD0
 G LKAD2
LKAD0 D LKPX,REFRESH I X[";EX"!(X="") G LKAD2
 D PUT S RX=3
LKAD1 I 1 K REF,TYP Q
LKAD2 S X="",RX=0 X "I 0" Q
 ;
POP S REFRESH="" D ^ZAA02GPOP S:X[";EX" X="" Q
REFRESH Q:$G(REFRESH)=""  G AP0^ZAA02GFORM4
 ;
LOOK S ZAA02GPOPALT=$P($T(LOOKT),";",2,99) S:$G(FX)]"" ZAA02GPOPALT=$P(ZAA02GPOPALT,"$L(S2)")_"$L(S2),"""" """"_$P(S,"""","""",2)[FX"_$P(ZAA02GPOPALT,"$L(S2)",2)
 S:$P(Y(0),"\",8)?1.N ZAA02GPOPALT=$TR(ZAA02GPOPALT,"]",">")
 S GF=$S(TYP=1:"S S3=$O(^DGPT(""B"",S2,S3)) I $L(S3)",TYP=2:$P($T(RADPT),";",2,99),TYP=4:$P($T(AMIE),";",2,99),TYP=5:$P($T(SURG),";",2,99),1:"I 1") ;W *13,GF,!,G,!
 Q
SURG ;S S3=$O(^SRF("B",S2,S3),-1) I S3
RADPT ;S S4=+$P(S3,",",2),S3=+S3 S:S4 S4=$O(^RADPT(S2,"DT",S3,"P",S4)) S:'S4 S3=$O(^RADPT(S2,"DT",S3)),S4=$O(^RADPT(S2,"DT",+S3,"P",0)) S:'S4 S3="" I S3 S S3=S3_","_S4
AMIE ;S S4=$P(S3,",",2),S3=$P(S3,",") S:S3="" S4=$O(^DVB(396.4,"APS",S2,S4)) I $L(S4) S S3=$O(^DVB(396.4,"APS",S2,S4,"C",S3)) I $L(S3) S S3=S3_","_S4
 ;
LOOKT ;S S=$P(TO,""|""),(ni,S2)=$P(TO,""|"",2),S3=$P(TO,""|"",3) F jj=1:1 S:S2="""" S=$O(@G@(S))  S TO=$S(jj=999:"""",S="""":"""",S]TEN:"""",1:TO)  Q:TO=""""  S:S3="""" S2=$O(@G@(S,S2)) I $L(S2) X GF I  S TO=S_""|""_S2_""|""_S3 Q
 ;
AUTO S RX=0 S TYP=$S($E(X,1,3)="RAD":2,$E(X,1,3)="SUR":5,$E(X,1,2)="CP":4,1:3),X=$S(X[":":$P(X,":",2),1:$E(X,TYP'=4+3,99)),G="^DPT(""SSN"")" G:X="" LKP1
 I X?1A.AP S MRLK=0 G LKP
 I X?1A4N,$D(^DPT("BS5",X))=10 S G="^DPT(""BS5"")" G AUTO2
 I TYP=2,$D(^RAO(75.1,X,0)) S REF=X,X=^(0),REF=$$DT($P(X,"^",18))_" "_REF_" "_$E($P($G(^RAMIS(71,+$P(X,"^",2),0)),"^"),1,10)_"\2|"_(+X)_"|"_REF,X=+X G AUTO1
 I TYP=5,$D(^SRF(X,0)) S REF=X,X=^(0),REF=$$DT($P(X,"^",9))_" "_REF_" "_$E($P($G(^("OP")),"^"),1,10)_"\5|"_(+X)_"|"_REF,X=+X G AUTO1
 I TYP=4,$D(^DVB(396.4,"B",X)) S REF=X,X=$O(^(X,0)),X=^DVB(396.4,X,0),REF=$$DT($P(X,"^",6))_" "_REF_" "_$E($P($G(^DVB(396.6,$P(X,"^",3),0)),"^"),1,10)_"\4|"_(+$G(^DVB(396.3,$P(X,"^",2),0)))_"|"_REF,X=$P(REF,"|",2) G AUTO1
 ;
AUTO2 D LKPX,REFRESH
 I X[";EX"!(X="") S X="" G LKP1
AUTO1 D PUT S RX=3 G LKP1
 ;
UNIT S UNIT="" Q:$G(REF)=""  I TYP=2 S UNIT=$P($G(^RAO(75.1,$P(REF,"|",3),0)),"^",22)
 I TYP=5 S UNIT=$P($G(^SRF(+$P(REF,"|",3),0)),"^",21)
 S:+UNIT UNIT=$P($G(^SC(+UNIT,0)),"^",2) Q
 Q
 I TYP=1 S UNIT=$P($G(^DGPT(+$P($G(REF),"|",3),535,0)),"^",3) S:UNIT UNIT=$P($G(^(UNIT,0)),"^",6)
 I TYP=4 S UNIT=+$P($G(^DVB(396.6,+$P(REF,"|",3),0)),"^",7)
 Q
 ;
PUT D UNIT S opi=5,opi(1)="PDSP;DOB;"""_$$DT($P($G(^DPT(X,0)),"^",3))_"""",opi(2)="PDSP;PATIENT;"""_$P($G(^(0)),"^")_""""
 S X=$P($G(^(0)),"^",9),X=$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,9) S:X="--" X="000-00-0000" S opi(3)="PDSP;MR;"""_X_""""
 S INP("REV")=$G(REF),opi(4)="PDP;REF;"""_$TR($P($G(REF),"\"),"""")_""""
 S opi(5)="PDSP;UNIT;"""_UNIT_"""" K UNIT
 K dt X op Q
 ;
 ; FORMAT OF "REV"
 ;     1     2    3      4
 ;    TITLE\TYPE|DATA1|DATA2
 ;    ONLY THE TITLE IS DISPLAYED ON THE ID BLOCK
 ;    DATA DEPENDS UPON TYPE
 ; TYP=1  DS
 ; TYP=2  RAD
 ; TYP=3
 ; TYP=4  AMIE
 ; TYP=5  SUR
 ; TYP=6  LAB
 ; TYP=7
