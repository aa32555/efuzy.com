ZAA02GSQAS ;ZAA02GSQL;ADS SCHEMA PROCESSING;;;10FEB2000  15:52;26MAR98  17:21
 ;
 Q
 ; READ SCHEMA FILE IN FROM FLOPPY - STORE IN ^ZAA02GSQLA
LOAD K ^ZAA02GSQLA
 I ^ZAA02G("OS")="MSM" S F="SCHEMA",T="" O 51 U 51:(F:"R") S B="" F  U 51 R A U 0 D LOAD1 U 51 I $ZC C 51 U 0 G SCAN
 I ^ZAA02G("OS")'="MSM" S FILE="SCHEMA",T="",$ZT="LOADE^ZAA02GSQAS" O FILE U FILE S B="" F  U FILE R A U 0 D LOAD1 U FILE
LOADE U 0 W:$G(DB) "FINISHED INPUT - BEGINNING SCAN" S $ZT="" G SCAN
LOAD1 I A["%",$L($P(A,"%"),"""")#2 S A=$P(A,"%") I A?." " Q
LOAD2 I A["< " S A=$P(A,"< ")_"<"_$P(A,"< ",2,99) G LOAD2
 I B="",A'["<RECORD" D L5 Q
 S B=B_A I B["\""" F E=2:1:$L(B,"\""") S B=$P(B,"\""")_"`"_$P(B,"\""",2,99)
 I B["""" Q:$L(B,"""")#2'=1  F E=2:2:$L(B,"""") S $P(B,"""",E)=$TR($P(B,"""",E),"<>","??")
 I $L(B,"<")=$L(B,">") S L=1 S B=$TR(B,$C(9)," "),G=B,S=1 K TABLE D L1 S B=""
 Q
L1 S E=$P(B,"<",2) I $P(E," ",2,99)'?." " F  Q:$P(E," ",2)'=""  S $P(E," ",2,3)=$P(E," ",3)
 S E(L)=$P(E," ")_":"_$P(E," ",2),B="<"_$P(B,"<",3,999) F I=1:1:$L(B,">")-1 S A=$P(B,">",1,I)_">" I $L(A,"<")=$L(A,">") S B=$P(B,A)_$P(B,A,2,99) D L2 S I=0
 Q
L2 I $L(A,"<")>2 N B S B=A,L=L+1 D L1 S L=L-1 Q
 S A=$P($P(A,"<",2),">"),C=$P(A," "),A=$P(A," ",2,99) S:$L(A)>50 A=$E(A,1,50)
 W:$G(DB) L," ",E(L),?L*4+10,C,":",A,!
 I '$D(TABLE) S TABLE=$P(E(1),":",2),(FF,UU,KK)=1,(LF,LU,LK)=""
 I L=1 S:A]"" ^ZAA02GSQLA(TABLE,C)=A Q
 I L=2 S F=$P(E(2),":"),H=$P(E(2),":",2) S:F="FIELD"&(LF'=H) P=FF,FF=FF+1,LF=H,FFF=1 S:F="UNIQUE"&(LU'=H) P=UU,UU=UU+1,LU=H,UUU=1 S:F="KEY"&(LK'=H) P=KK,KK=KK+1,LK=H,KKK=1 Q:F="SECURITY"
 I L=2 S ^ZAA02GSQLA(TABLE,F,P)=H S:A]"" ^(P,S)=C_" "_A,S=S+1 Q
 I L=3 S ^ZAA02GSQLA(TABLE,F,P,S)=E(3) S:A]"" ^(S,1)=C_" "_A S S=S+1 Q
 S ^ZAA02GSQLA(TABLE,F,P,S)=E(4) S:A]"" ^(S,1)=C_" "_A S S=S+1 Q
 Q
L5 I A["<type " S T=$TR($P(A,"<type ",2),$C(9)_" ") Q
 I A["<enumMap " S TT=$P(A,"<enumMap ",2) Q
 I A["<enum "  S T1=$P($P(A,"<value ",2),">"),T2=$P($P($TR(A,""""),"<TAG ",2),">") S ^ZAA02GSQLD(0,"ENUM","MEDICAL",T)=TT,^(T,T1)=T2
 Q
 ;
 ;  scan ^ZAA02GSQLA to create ZAA02GSQL schema ^ZAA02GSQLD
 ;
SCAN S (A,B,C)="",XX="MEDICAL",LC="abcdefghijklmnopqrstuvwxyz",UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ",DB=$D(DEBUG) K:1 ^ZAA02GSQLD(XX)
 K LAB F  S A=$O(^ZAA02GSQLA(A)) Q:A=""  F  S B=$O(^ZAA02GSQLA(A,B)) Q:B=""  I B="UNIQUE" S J="" F  S J=$O(^ZAA02GSQLA(A,B,J)) Q:J=""  S D=^(J),C="" F  S C=$O(^ZAA02GSQLA(A,B,J,C)) Q:C=""  I ^(C)["TAG " S LAB(D)="^T"_$P(^(C)," ",2)
 F  S A=$O(^ZAA02GSQLA(A)) Q:A=""  W:DB !,A D S1
 D delchg
 F  S A=$O(^ZAA02GSQLD(XX,0,"INDEX",A)) Q:A=""  S B=^(A) I $P(B,",",2)="" S I=$P(B,",") D
 . I $D(^ZAA02GSQLD(XX,I)) S C=$P(^ZAA02GSQLD(XX,I),"`",2),TT=$P(^(I),"`",5),TT=$S(A=TT:"T"_C,1:A),$P(B,",",1,2)=TT_","_I,^ZAA02GSQLD(XX,0,"INDEX",$TR(A,LC,UP))=B,^ZAA02GSQLD(XX,0,"INDEX",A)=B
 S TT=0 F  S TT=$O(^ZAA02GSQLD(XX,TT)) Q:TT=""  S T=$P(^(TT),"`",2),B="T"_T,$P(^ZAA02GSQLD(XX,TT),"`",6)=$TR($P($G(^SCHTBL(0,B,0)),"~",4),"`",",") D
 . K ^ZAA02GSQLD(XX,TT,0,5) F  S A=$O(^ZAA02GSQLD(XX,TT,0,3,A)) Q:A=""  S B=^(A) I $P(B,"`",4)="" F C=5:1:$L(B,"`") S DD=$P(B,"`",C) S:DD]"" ^ZAA02GSQLD(XX,TT,0,5,DD,C-4,A)=""
 . F  S A=$O(^ZAA02GSQLD(XX,TT,0,3,A)) Q:A=""  S C=^(A),B=$P(C,"`"),TG=$P(C,"`",2),L="" W:DB C,! F DD=5:1 S CD=$P(C,"`",DD) D:CD="" MK1 Q:CD=""  D MK
 W:DB !!,"COMPLETED",! Q
delchg K ^ZAA02GSQLD("MEDICAL","DELETEDCHARGE") M ^ZAA02GSQLD("MEDICAL","DELETEDCHARGE")=^ZAA02GSQLD("MEDICAL","CHARGE") S ^ZAA02GSQLD("MEDICAL","DELETEDCHARGE")=$P($T(DATA+4),";",2,99),^("DELETEDCHARGE",0,1)=$P($T(DATA+3),";",2,99) K ^(3)
 S ^ZAA02GSQLD("MEDICAL",0,"INDEX","IdChg")="DELETEDCHARGE,,deletedCharge",^ZAA02GSQLD("MEDICAL",0,"TABLES","TdChg")="DELETEDCHARGE"
 K ^ZAA02GSQLD("MEDICAL","DELETEDCREDIT") M ^ZAA02GSQLD("MEDICAL","DELETEDCREDIT")=^ZAA02GSQLD("MEDICAL","CREDIT") S ^ZAA02GSQLD("MEDICAL","DELETEDCREDIT")=$P($T(DATA+2),";",2,99),^("DELETEDCREDIT",0,1)=$P($T(DATA+1),";",2,99) K ^(3)
 S ^ZAA02GSQLD("MEDICAL",0,"INDEX","IdCrd")="DELETEDCREDIT,,deletedCredit",^ZAA02GSQLD("MEDICAL",0,"TABLES","TdCrd")="DELETEDCREDIT"
 F I="DELETEDCHARGE","DELETEDCREDIT" S B=0 F  S B=$O(^ZAA02GSQLD("MEDICAL",I,B)) Q:B=""  D
 . S:B="ENTITY"!($E(B,1,4)="USER") L=^(B),$P(L,"`")="delete"_$P(L,"`"),^("DELETE"_B)=L F L=9,11 S C=$P(^(B),"`",L) S:C'="" $P(^(B),"`",L)=$P(C,"$C(96),")_"$C(96),21+"_$P(C,"$C(96),",2,99)
 F I="DELETEDCHARGE","DELETEDCREDIT" F J=10,11 S B=$P(",,,,,,,,,ID,DATE",",",J),^ZAA02GSQLD("MEDICAL",I,B)=B_$S(J=10:"`12`10",1:"`9`8")_"`0`0````"_$S(J=11:"$$DT($P(@X,$C(96),"_J_"))",1:"$P(@X,$C(96),"_J_")")
 Q
DATA ;
 ;S:x="" x="^TdCrd" F  S x=$Q(@x) I $S(x="":1,$QS(x,$QL(x))=1:1,1:0)
 ;deleteCredit`dCrd```IdCrd
 ;S:x="" x="^TdChg" F  S x=$Q(@x) I $S(x="":1,$QS(x,$QL(x))=1:1,1:0)
 ;deleteCharge`dChg```IdChg
MK S S=$P(^ZAA02GSQLD(XX,TT,CD),"`",2)=12,$P(^ZAA02GSQLD(XX,TT,CD),"`",10)=$S(B="UNIQUE":"^",1:"^")_TG_"("_$S(S:""" ""_",1:"")_"X,1)",L=L_","_$S(S:" ",1:"") Q
MK1 S L=$E(L,2,99),$P(^ZAA02GSQLD(XX,TT,0,3,A),"`",3)=L S:T=TG ^ZAA02GSQLD(XX,TT,0,4)=L
 Q
S1 S TB=$S($D(^ZAA02GSQLA(A,"TAG")):^("TAG"),1:A),TT=$TR(A,LC,UP),^ZAA02GSQLD(XX,TT)=A,^ZAA02GSQLD(XX,0,"TABLES","T"_TB)=TT D S1A
 F  S B=$O(^ZAA02GSQLA(A,B)) Q:B=""  D @$S(B="FIELD":"S2",B="UNIQUE":"S3",B="KEY":"S3",1:"S4")
 F LL=1:1 S B=$P("DateCreated,TimeCreated,DateModified,TimeModified,LogicalDelete,EntityNotUsable,UserCreated,UserModified",",",LL) Q:B=""  S D=LL-8,F=B D S2A S E=" "_$S(B["Date":"date",B["Time":"time",1:"char") D S6
 Q
S1A S (REF,KEY)="" I $O(^ZAA02GSQLA(A,"UNIQUE",1,"")) S R="" F  S R=$O(^(R)) Q:R=""  I ^(R)["FIELDREF" S KEY=KEY+1
 Q:'KEY  S KEY=$P($T(KEY),";",2,99) F Y=2:1:$L(KEY,"*") S KEY=$P(KEY,"*")_"T"_TB_$P(KEY,"*",2,9)
 S REF=$P(KEY,"`",2),KEY=$P(KEY,"`"),^ZAA02GSQLD(XX,TT,0,1)=KEY Q
S2 ; FIELD
 S D="" F  S D=$O(^ZAA02GSQLA(A,B,D)) Q:D=""  S F=^(D) D S2A
 Q
S2A S R=REF F Y=2:1:$L(R,"%") S R=$P(R,"%")_(D+8)_$P(R,"%",2,9)
 S FF=$TR(F,LC,UP),^ZAA02GSQLD(XX,TT,FF)=F_"`12``0`0````"_R,^ZAA02GSQLD(XX,TT,0,2,D+8)=FF
 S TYP="" F  S C=$O(^ZAA02GSQLA(A,B,D,C)) Q:C=""  S E=$G(^(C)) D @$S(E["SIZE ":"S5",E["TYPE ":"S6",E["VALIDATION:":"S9",1:"S7")
 I $P(^ZAA02GSQLD(XX,TT,FF),"`",3)="" S $P(^(FF),"`",3)=20
 Q
 ;
S3 ; UNIQUE,KEY
 S D="" F  S D=$O(^ZAA02GSQLA(A,B,D)) Q:D=""  S F=^(D),FF=$TR(F,LC,UP),DD=1 F  S C=$O(^ZAA02GSQLA(A,B,D,C)) Q:C=""  S E=$G(^(C)) D S8 ;NEEDS WORK
 Q
S4 I B="TAG" S $P(^ZAA02GSQLD(XX,TT),"`",2)=^(B) Q
 W:DB ?20,B,"  ",! Q
 Q
S8 I E["TAG " S TG=$P(E," ",2),$P(^ZAA02GSQLD(XX,TT,0,3,F),"`",1,2)=B_"`"_$S(TG=$P(^ZAA02GSQLD(XX,TT),"`",2):"T",1:"I")_TG,^ZAA02GSQLD(XX,0,"INDEX","I"_TG)=TT_",,"_F Q:B'="UNIQUE"  S:$P(^ZAA02GSQLD(XX,TT),"`",5)="" $P(^(TT),"`",5)="I"_TG Q
 I E["FIELDREF " S CD=$TR($P(E," ",2,9),LC_" ",UP),$P(^ZAA02GSQLD(XX,TT,0,3,F),"`",DD+4)=CD,DD=DD+1
 I E["CONDITION " S $P(^ZAA02GSQLD(XX,TT,0,3,F),"`",4)="CONDITION"
 Q
S9 S R=$P(^ZAA02GSQLD(XX,TT,FF),"`",9),T=$P(^(FF),"`",2),T=$S(T=12:""" ""_",1:"")
 S V="" F  S V=$O(^ZAA02GSQLA(A,B,D,C,V)) Q:V=""  S E=$TR(^(V),":"," "),F=$P(E," "),CD=$P(E," ",$L(E," ")) I F'["CONDITION" S:CD]"" CD=$S($D(LAB(CD)):LAB(CD),1:CD) D @$S(F["GENERALCODE":"S9C",F="EXISTSIN":"S9A",F["EXISTSINENTITY":"S9B",1:"S9E")
 Q
S9A S CD="$P($G("_CD_"($TR("_T_R_",LC,UP),1)),$C(96),10)" G S9F ;
S9B S CD="$P($G("_CD_"($TR("_T_R_",LC,UP),0,1)),$C(96),12)" G S9F ; entity specific (assuming 0)
S9C S CD="$P($G(^TgenCd("" "_$E(CD,2,9)_",$TR("_T_R_",LC,UP),0,1)),$C(96),12)" G S9F ; entity specific (assuming 0)
S9E I CD="",DB W !,E,"-",^(V) R CCC
 Q
S9F S $P(^ZAA02GSQLD(XX,TT,FF),"`",12)=CD Q
 ;
S5 S $P(^ZAA02GSQLD(XX,TT,FF),"`",3)=$P(E," ",2) Q  ;SIZE
S6 S S="12,string,12,int2,4,int2u,4,int4u,4,int4,4,real,2,time,12;5,date,9;8,varchar,12,entity,4;6,phone,12;15,resoureType,12;1,apptStatusType,12;1,boolean,5;1,binary,12;1,money,2;;2,sex,12;1,relationship,12;1,marriage,12;1"
 S TYP=$P(E," ",2) I $P(^ZAA02GSQLD(XX,TT,FF),"`",9)'["$$" S:TYP="time" $P(^ZAA02GSQLD(XX,TT,FF),"`",9)="$$TM("_$P(^ZAA02GSQLD(XX,TT,FF),"`",9)_")" S:TYP="date" $P(^ZAA02GSQLD(XX,TT,FF),"`",9)="$$DT("_$P(^ZAA02GSQLD(XX,TT,FF),"`",9)_")"
 I $D(^ZAA02GSQLD(0,"ENUM","MEDICAL",TYP)) D S6A
 S S=$P($E(S,$F(S,TYP)+1,999),","),$P(^ZAA02GSQLD(XX,TT,FF),"`",2)=+S S:$P(S,";",2)]"" $P(^ZAA02GSQLD(XX,TT,FF),"`",3)=$P(S,";",2) S:$P(S,";",3)]"" $P(^ZAA02GSQLD(XX,TT,FF),"`",4)=$P(S,";",3)
 Q
S6A S (A1,A2,A3)="" F  S A1=$O(^ZAA02GSQLD(0,"ENUM","MEDICAL",TYP,A1)) Q:A1=""  S A2=A2_A1,A3=A3_","_^(A1)
 S A1="$P("""_A3_""","","",+$F("""_A2_""","_$P(^ZAA02GSQLD(XX,TT,FF),"`",9)_"))",$P(^(FF),"`",11)=A1 Q
 ;
S7 W:DB ?30,E,"  ",! Q
 ;
 ;Description`type`max length`decimal`nullable`primary key`pk index transform`key start`key end ??`source`
KEY ;S:x="" x="^*" F  S x=$Q(@x) I $S(x="":1,$QS(x,$QL(x))=1:1,1:0)`$P(@X,$C(96),%)
 ;
 ;
RGD S XX="MEDICS",LC="abcdefghijklmnopqrstuvwxyz",UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 S A=99 F  S A=$O(^RGD(A)) Q:A=""  S B=^(A),T=$P("GUARANTOR,INSURANCE,PATIENT,TRANSACTIONS",",",+$P(B,"*",15)) D RGD1
 Q
RGD1 S C=$TR($P(B,"*"),LC_". ",UP_"__"),D=$P(B,"*")_"`"_$S($P(B,"*",5)="N":4,1:12)_"`"_$P(B,"*",2)_"`````" S:$P(B,"*",7) $P(D,"`",9)="$P(@X,"":"","_$P(B,"*",7)_")",^ZAA02GSQLD(XX,T,0,2,$P(B,"*",7))=C
 I $P(B,"*",8)'="" S ^ZAA02GSQLD(XX,T,0,2,+$P($P(B,"*",8),""":"",",2))=C,$P(D,"`",9)=$P(B,"*",8)
 S ^ZAA02GSQLD(XX,T,C)=D Q
RGD2 ;
 ;S:x="" x="^GRG" F  S x=$Q(@x) I $S(x="":1,$QS(x,$QL(x))=1:1,1:0)
 ;
