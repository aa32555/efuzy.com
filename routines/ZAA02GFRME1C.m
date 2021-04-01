ZAA02GFRME1C ;PG&A,ZAA02G-FORM,2.62,FORMS EDITOR, PART 2;28DEC94 11:11A
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;ZAA02GSCHEMA 1 DESC`2 TITLE`3 REF`4 $PIECE`5 LIST`6 TYPE`7 LEN`8 PATTERN`9 VALIDATE`10 FETCH`11 PUT`12 DITTO`13 TABLE LOOKUP REF`14 TABLE PAR\MN`15 TABLE REF`16 OUTPUT LEN\TABLE TEXT
 ;from: 1 MANDATORY`2 REF`3 ROW,COL`4 $P`5 LEN`6 PAT`7 HELP/ERR`8 DITTO`9 TBL REF`10 FETCH TRANS`11 FD`12 TBL LEN CODE'13 TAB`14 ORDER#`15 PUT TRANS`16 VAL`17 TBL REF`18`19`20 DISPLAY ONLY`21 LIST`22 PROCESS ACK`23 TBL MENU`24 WINDOW`25 TBL PARA\MNE
 ;to: 1 TY`2 PUT TRANS`3 ROW,COL`4 DISPLAY CODE`5 LENGTH`6 PAT`7 HELP/ERR FLAG`8 DITTO`9 TBL REF`10 INT REF`11 FD`12 TBL LEN_"HK"`13 LIST ROUTINE`14 LIST DISPLAY`15 LIST MAX`16 VALIDATION`17 TBL USER VALIDATE`18 TB 1 FLAG`19 GRP TAG`20 INPUT DRIVER
 ;to +.1   1 tbl menu`2 tbl ref`3 tbl output code`4 key code
 ;to +.2 1 fetch transformation`2 list fetch transformation`3 list parameters
SCAN2 S E=$P(C,"`",4) I E["$P(",E["""" S B=$E($P(E,"""",2)),$P(^(I),"`",6)=$S($P(C,"`",6)'="":$P(C,"`",6)_",",1:"")_"X'["""_B_""""
 ; S E=$P(E,"X")_EE_$P(E,"X",2,9),Z=$P(C,"`",20),B="S X="_$S(Z["Y"&($E(D,1,2)'="n(")!(Z["K")!($D(rgl)):"$S($D("_D_")#10:"_E_",1:"""")",1:E)
 S B="S X="_$P(E,"X")_"$G("_EE_")"_$P(E,"X",2,9),E=$P(E,"X")_EE_$P(E,"X",2,9),Z=$P(C,"`",20)
SCAN3 S a=$P(C,"`",7),$P(^ZAA02GDISP(SCR,SN,I),"`",7)=$S(a="":0,$E(a)="/":2,$E(a,$L(a))="/":1,1:3),a=^(I)
 S $P(^(I),"`",12)=+$P(a,"`",12),^(I)=$P(^(I),"`",1,16),$P(^(I),"`",13)="",$P(^(I),"`",10)=E,$P(^(I),"`",15)=""
 I $P(C,"`",21)]"" S a=$P(C,"`",21),$P(^(I),"`",13)=$S($P(a,",",6)["C":"ZAA02GFORM6",1:"ZAA02GFORM2"),$P(^(I),"`",14)=$P(a,",",2),$P(^(I),"`",15)=$P(a,",",5)
 S:$P(C,"`",10)'="" B=B_" "_$P(C,"`",10) I I["." S $P(^(I),"`",14)=B
 E  S $P(^(I+.2),"`")=B
 S A=$L(E,")"),E="S "_$S(E["$P($P":"B="_$P($P(E,")",1,A-2),"(",2,9)_"),$P(B"_$P(E,")",A-1)_")=X,"_$P($P(E,")",1,A-2),"(",2,9)_")=B",1:E_"=X") S:$P(C,"`",15)'="" E=$P(C,"`",15)_" "_E
 S $P(^(I),"`",2)=E,A=$P(C,"`",5) S:"YN"'[Z $P(A,",")=+A_Z S:$P(C,"`",22)["C" A=A_"c" S $P(^ZAA02GDISP(SCR,SN,I),"`",5)=A
 S:$P(C,"`",22)="Y"!($P(C,"`",22)="C")!(A[",") TY=TY+16
 S $P(^(I),"`",21)=$S(A["C":"DT",A["E":"EC",A["P":"PW",$P(C,"`",24)]"":$P(C,"`",24),1:"RA")
 I $P(C,"`",9)]"" D ^ZAA02GFRME1H G SCAN3A
 S Y=$P(A,",",2)
 S B="S D="_$S(Z["Y":"ee_",1:"")_$S(A["P":"$E(sp,X'=""""+1,"_(A+1),A'[",":"$E(X_sp,1,$L(X)<"_+A_"+"_+A,Y>A:"$E(X_$E(sp,1,255-$L(X)),1,$L(X)<"_+A_"+"_+A,1:"$S(X="""":$E(sp,1,"_(A+1)_"),1:$J(X,"_+A_$S(Y="":"",1:","_+Y)_")")_")"
SCAN3A I $L(^ZAA02GDISP(SCR,SN,I))+$L(B)-$L($P(^(I),"`",4))>245 S ^(I+.07)=B,B="X ^ZAA02GDISP(SCR,SN,"_(I+.07)_")"
 S $P(^ZAA02GDISP(SCR,SN,I),"`",4)=B S:$P(C,"`")="Y" M=M_I_",",TY=TY+4 S:$P(C,"`")="R" M=M_I_",",TY=TY+4+8 S:$P(C,"`",13)="Y" T=T_I_","
 I I["." S Y=^(I),X=$P(Y,"`",3),^(I)=$P(Y,"`",14)_" "_$P(Y,"`",4)_$S(I<100:" S %R="_+$P(Y,"`",3)_",%C="_$P($P(Y,"`",3),",",2)_" W:'$d(qt) @ZAA02GP,D",1:" ;``"_$P(Y,"`",3))
 E  S:$P(C,"`",8) TY=TY+2 S $P(^(I),"`")=TY#16,TYP=TYP_$C(TY)
 I I'[".",$P(^(I+.2),"`")["G LIST" S a=$P(^(I+.2),"`"),$P(^(I+.2),"`")="G LIST",$P(^(I+.2),"`",2)=$P(a,"G LIST ",2,999),$P(^(I+.2),"`",3)=$P(C,"`",21)
 I I>99 S A=$S($D(^(I+.2)):$P(^(I+.2),"`"),1:""),$P(^(I),"`",19)=$S(A["G LIST":"LO",A:"GO",1:"WO")
 I I'["." S A=$P(^(I+.2),"`"),A=A_"  ;",$P(^(I+.2),"`")=A
 Q
 ;
