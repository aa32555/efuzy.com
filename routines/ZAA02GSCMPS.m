ZAA02GSCMPS ;PG&A,ZAA02G-MTS,1.20,LETTERS PRINT FORMAT;30DEC94 2:52P [ 02/05/95   6:08 AM ]
 ;Copyright (C) 1995, Patterson, Gray & Associates, Inc.
 ;
BEG S %R=1,%C=20 W @ZAA02GP,ZAA02G("HI"),"         P R I N T    F O R M A T         ",!!,ZAA02G("CS")
 S OLD="6\11\.5\1\N\2\4\\1\2.5",OLD=$S($D(@ZAA02GSCR@("PARAM","REPORTS")):^("REPORTS"),1:OLD) I $D(DOC) S:'$D(@ZAA02GWPD@(.03)) ^(.03)=OLD S OLD=^(.03)
 S NEW=OLD
BEG1 S %R=4,%C=2 W @ZAA02GP,ZAA02G("CS"),ZAA02G("LO") I $D(DOC) W "Report: ",ZAA02G("HI"),DOC,ZAA02G("LO") W:$L(DOC)<30 "   [ ",ZAA02G("HI"),$E($P(@ZAA02GWPD,"\"),1,40),ZAA02G("LO")," ]" W !," Width: ",ZAA02G("HI"),@ZAA02GWPD@(.01)
 E  W "Default Settings for Reports",ZAA02G("HI")
DIS F I=1:1:16 S TT=$T(DATA+I),PP=$P(TT,"\",2),%R=$P(TT,"\",3),%C=$P(TT,"\",4),X=$P(TT,"\",5) W @ZAA02GP,ZAA02G("HI"),$J(I_") ",4),ZAA02G("LO"),X,$E("....................................",6,$P(TT,"\",7)-%C-$L(X)) D:$P(NEW,"\",PP)]"" DSPLY
 ;
SEL G:$D(EDV) SELECT S %R=24,%C=15 W @ZAA02GP,ZAA02G("LO"),"Type ",ZAA02G("HI"),"E",ZAA02G("LO")," to Edit format, ",ZAA02G("HI"),"C",ZAA02G("LO")," to Continue or ",ZAA02G("HI"),"Q",ZAA02G("LO")," to Quit ",ZAA02G("HI") R A#1 S:A?1L A=$C($A(A)-32) I A=""!($C(9)_"CQE"'[A) W *7,*8 G SEL
 I A="Q"!(A=$C(9)) S J=-1 G END
 I A'="E" S J=1 G END
SELECT S %R=24,%C=3 W @ZAA02GP,ZAA02G("LO"),"(Edit fields as needed - Press ",ZAA02G("HI"),"TAB",ZAA02G("LO")," to SAVE, ",ZAA02G("HI"),"EXIT",ZAA02G("LO")," to return without saving" W ")",ZAA02G("HI")
 X ZAA02G("ECHO-OFF") F J=$S($D(EDV):EDV,1:1):1:16 S TT=$T(DATA+J),%R=$P(TT,"\",6),%C=$P(TT,"\",7),S=1,RX=0 W @ZAA02GP D RD S:'S $P(NEW,"\",PP)=X I RX=1 S J=J-2 Q:J<0
 I J<0 G BEG1:J=-14,END
 Q:'$D(DOC)
FILE S:NEW'=OLD @ZAA02GWPD@(.03)=NEW
END X ZAA02G("ECHO-ON") K OLD,TT,NEW,PP,EDV Q
 ;
DSPLY S %R=$P(TT,"\",6),%C=$P(TT,"\",7) W @ZAA02GP,ZAA02G("HI"),$P(NEW,"\",PP) Q
SET S PP=$P(TT,"\",2),LNG=$P(TT,"\",9),CHR=$P(TT,"\",10),X=$P(NEW,"\",PP),X=X_$J("",LNG-$L(X)),L=1,S=0 Q
 ;
DATA ;\PIECE #\%R\%C\PROMPT\%R\%C\HELP\LENGTH\CHARS\
 ;\1\7\5\Lines/Inch (6 is normal)\7\65\61\4\0123456789.
 ;\2\8\5\Characters/Inch (add PS for Proportional Spacing)\8\65\62\8\0.123456789PSDRCO
 ;\3\9\5\Left Margin in Inches (1 normal)\9\65\63\5\0123456789.
 ;\4\10\5\Top Margin in Inches (1 normal)\10\65\64\5\1234567890.
 ;\8\11\5\If Right Justified: Specify length in inches\11\65\68\5\0.123456789
 ;\9\12\5\Top Margin of Page 2 through end (1 normal)\12\65\69\4\0123456789.
 ;\10\13\5\For Automatic Paging: Specify inches from bottom\13\65\70\5\.0123456789
 ;\11\14\5\Page Numbering: type 1st page # & T,B,R,L,C,A,X\14\65\71\10\0123456789-TBLRCAX,N
 ;\13\15\5\1st page Header/Footers (use / to delimit)\15\55\72\20
 ;\14\16\5\2+ page Header/Footers (use / to delimit)\16\55\72\20
 ;\18\17\5\Envelope (Label) Header\17\55\72\20
 ;\17\18\5\Distribution List (default)\18\55\\20\\\
 ;\23\19\5\Type of Letter (Referral,Patient,Other)\19\55\\1\RPO
 ;\24\20\5\Trigger on Code(s)\20\30\LOOKUPH\54\\LOOKUP
 ;\25\21\5\Except on Code(s)\21\30\LOOKUPH\54\\LOOKUP\
 ;\26\22\5\\22\30\\54\\\
 ;
RD R B#1 X ZAA02G("T") G RB:B="" D:S SET I CHR'="",CHR'[B G ER
 G ER:L>LNG W B S X=$E(X,1,L-1)_B_$E(X,L+1,99),L=L+1 G RD
RB S E=$E(XX,$F(XX,ZF)) I E'="",$T(@E)'="" G @E
ER W *7 G RD
D D:S SET G RD:L'>1 S L=L-1 W ZAA02G("L") G RD
C D:S SET G RD:L'<LNG W ZAA02G("RT") S L=L+1 G RD
R G:L=1 RD S X=$E(X,1,L-2)_" "_$E(X,L,99),L=L-1 W *8," ",*8 G RD
B S RX=2 G F
A S RX=1 G F
9 S RX=3,J=99
F Q:S  I $E(X)=" " S X=$E(X,2,99) G F
OUT I X?.E1" " S X=$E(X,1,$L(X)-1) G OUT
 I X]"",$P(TT,"\",11)?1.A D LOOKUP G:'$T ER
 W @ZAA02GP,X,ZAA02G("CL") K LNG,CHR,L,C,B Q
H D:S SET W $E(X,L+1,99)," " S X=$E(X,1,L-1)_$E(X,L+1,99)_" " W @ZAA02GP,$E(X,1,L-1) G RD
G D:S SET G:$E(X,LNG)'=" " ER W " ",$E(X,L,LNG-1) S X=$E(X,1,L-1)_" "_$E(X,L,LNG-1) W @ZAA02GP,$E(X,1,L-1) G RD
E S J=1,RX=1 Q
Y S HP=$P(TT,"\",8),EDV=J G ER:HP="" I HP?1.N D HELP^ZAA02GWPV9 S J=-12,RX=1 Q
 D LOOKUPH S J=-12,RX=1 G F
5 D:S SET S X=$E(X,0,L-1),CC=%C,%C=%C+L-1 W @ZAA02GP,$J("",LNG-L),@ZAA02GP S %C=CC,L=$L(X) K CC G RD
 ;
LOOKUP S Y=$TR(X,"()&!",",,,,") F JJ=1:1:$L(Y,",") S B=$P(Y,",",JJ) I B]"" G LOOKUP1:'$D(@ZAA02GSCMD@("XDIR",B))
 G LOOKUP1:X[",,",LOOKUP1:$L(X,"(")-$L(X,")")'=0,LOOKUP1:X["()",LOOKUP1:X[")("
 I 1 Q
LOOKUP1 X "I 0" Q
LOOKUPH D:S SET N (X,ZAA02G,ZAA02GP,ZAA02GSCR,B) S Y="25,6\RHLSDG\1",Y(0)="\EX\@ZAA02GSCM@(""XDIR"")\TO;5`$G(^(TO));30" D ^ZAA02GPOP S:X[";EX" S=0,X="" Q
