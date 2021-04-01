ZAA02GFRME5 ;PG&A,ZAA02G-FORM,2.62,FORMS EDITOR, PART 5;28DEC93 9:59A
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
EDIT S %C=4
E0 W:'$d(qt) ZAA02G("LO") S H=HD F I=1:1:NE S %R=$P(DD,",",I),A=$P(H,";",I) S:A="*" H=HD1,A=$P(H,";",I) W:'$d(qt) @ZAA02GP,A,$E("................................",1,EC-$L(A))
 W:'$d(qt) ZAA02G("HI") Q:$D(ST)=0
E1 S II=1
E5 S %C=EC+5 F I=1:1:NE S %R=$P(DD,",",I) W:'$d(qt) @ZAA02GP,$P(ST,"`",$P(SD,",",I))," "
 Q:$D(QTF)  S %R=24,%C=2 W:'$d(qt) @ZAA02GP,ZAA02G("LO"),"Move to bottom when done (or press ",ZAA02G("HI"),"TAB",ZAA02G("LO"),"), ",ZAA02G("HI"),"EXIT",ZAA02G("LO")," to cancel, ",ZAA02G("HI"),"COPY",ZAA02G("LO")," to copy, or ",ZAA02G("HI"),"HELP"
 S %C=EC+5,RX=6 F II=II:1:NE S %R=$P(DD,",",II) D READ S II=II+$S(14[RX:-2,RX=7:22,RX>7:100,1:0) S:II<0 II=0,RX=6
 S %R=24,%C=1 W:'$d(qt) @ZAA02GP,ZAA02G("CS") I II>100 G E6:RX=9 S II=II-100 D:RX=8 @HELP D:RX=88 @COPY G E5
 Q
E6 Q
 ;
EDIT1 W:'$d(qt) ZAA02G("LO"),ZAA02G("RON"),STL1,STL,"     DATA DEFINITION - Fill in appropriate attributes.                         " S %R=ZAA02G("R")-1,%C=56 W:'$d(qt) @ZAA02GP,"Id: ",ZAA02G("HI"),CD S %C=72 W:'$d(qt) @ZAA02GP,ZAA02G("LO"),"R",ZAA02G("HI"),RR S %C=76 W:'$d(qt) @ZAA02GP,ZAA02G("LO"),"C",ZAA02G("HI"),CC
 S PL="................................."
 S H=HD,%R=23,RX=6
 F II=1:1:NE S A=$P($S(II>11:HD1,1:HD),";",II),%R=%R+1,%C=1 W:'$d(qt) @ZAA02GP,ZAA02G("LO"),II," ",A,$E(PL,1,EC-$L(A)) S %C=EC+3 W:'$d(qt) ZAA02G("HI"),@ZAA02GP,$J("",49),@ZAA02GP,$P(ST,"`",$P(SD,",",II)) I %R=24 D READ D @$S(14[RX:"E2",RX=7:"E3",RX>7:"E8",1:"E4")
 S %R=23,%C=1 W:'$d(qt) @ZAA02GP,ZAA02G("ROF"),ZAA02G("CS") Q
E2 S %R=22,II=II-3 S:II<-1 II=-1,RX=6 Q
E3 S II=99 Q
E4 S %R=22,II=II-1 Q
E8 I RX=8 D @HELP S II=II-2,%R=22 Q
 I RX=88 D @COPY S II=II-2,%R=22 Q
 S ST="",II=99 Q
 ;
READ I $D(PST),PST[(","_II_",") Q
 I '$P(LL,",",II) S RX=6 Q
 W:'$d(qt) @ZAA02GP R B#1 I B="" X ZAA02G("T") S ZC=$A(ZF) I ZC S RX=$S(ZC=13:6,ZC=9:7,ZF=ZAA02G("UK"):1,ZF=ZAA02G("DK"):3,ZF=ZAA02G("LK"):4,1:0) Q:RX  D RSET G RB
 G:B="?" HELP D RSET S X=B_$E(X,2,99),L=L+1 G CR:+LNG=1
RD R B#+LNG-L X ZAA02G("T") S ZC=$A(ZF) I B'="" S X=$E(X,1,L)_B_$E(X,L+$L(B)+1,99),L=L+$L(B)
RB S ZF=$P(^ZAA02G(.3),"\",$A(^(.3,ZAA02G,0),$F(^(0),ZF))+2) G CR:ZC=0 I ZF'="",$T(@ZF)'="" G @ZF
ER W:'$d(qt) *7,@ZAA02GP S L=0 G RD
LK I L S L=L-1 W:'$d(qt) ZAA02G("L") G RD
 S RX=4 G DONE
RK S L=L+1 I L<LNG W:'$d(qt) ZAA02G("RT") G RD
CR S RX=6 G DONE
TB S RX=7 G DONE
EX S RX=9 G DONE
RU G:L=0 RD S X=$E(X,1,L-1)_" "_$E(X,L+1,99),L=L-1 W:'$d(qt) *8," ",*8 G RD
EF S X=$E(X,1,L)_$J("",LNG-L+1) W:'$d(qt) $J("",LNG-L+1),@ZAA02GP,$E(X,1,L) G RD
DK S RX=3 G DONE
UK S RX=1 G DONE
DONE F L=0:0 S L=$F(X," ",L) Q:L'>0  I $E(X,L,99)?." " S X=$E(X,1,L-2) Q
 I X["`" G ER
 I LNG["*",X?.E1L.E S X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ") W:'$d(qt) @ZAA02GP,X
 S $P(ST,"`",D)=X Q
DC W:'$d(qt) $E(X,L+2,99)," " S X=$E(X,1,L)_$E(X,L+2,99)_" " W:'$d(qt) @ZAA02GP,$E(X,1,L) G RD
IC G:$E(X,LNG)'=" " ER W:'$d(qt) " ",$E(X,L+1,LNG-1) S X=$E(X,1,L)_" "_$E(X,L+1,LNG-1) W:'$d(qt) @ZAA02GP,$E(X,1,L) G RD
HL ;
HELP I $D(HELP)=0 W:'$d(qt) " HELP NOT AVAILABLE" H 2 W:'$d(qt) @ZAA02GP,X,ZAA02G("CL") G READ
 S RX=8 Q
CP I $D(COPY)=0 W:'$d(qt) " COPY NOT AVAILABLE" H 2 W:'$d(qt) @ZAA02GP,X,ZAA02G("CL") G READ
 S RX=88 Q
RSET S L=0,D=$P(SD,",",II),X=$P(ST,"`",D),LNG=$P(LL,",",II),X=X_$J("",LNG-$L(X)) Q
 ;
