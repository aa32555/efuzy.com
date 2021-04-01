ZAA02GSCRPS ;PG&A,ZAA02G-SCRIPT,2.10,PRINT FORMAT;21NOV94 2:14P;;;31DEC2003  11:49
 ;Copyright (C) 1984, Patterson, Gray & Associates, Inc.
 ;
BEG S %R=1,%C=20 W @ZAA02GP,ZAA02G("HI"),"         P R I N T    F O R M A T         ",!!,ZAA02G("CS")
 S OLD="6\11\.5\1\N\2\4\\1\2.5",OLD=$S($D(@ZAA02GSCR@("PARAM","REPORTS")):^("REPORTS"),1:OLD) I $D(DOC) S:'$D(@ZAA02GWPD@(.03)) ^(.03)=OLD S OLD=^(.03)
 S NEW=OLD
BEG1 S %R=3,%C=2 W @ZAA02GP,ZAA02G("CS"),ZAA02G("LO") I $D(DOC) W "Report: ",ZAA02G("HI"),DOC,ZAA02G("LO") W:$L(DOC)<30 "   [ ",ZAA02G("HI"),$E($P(@ZAA02GWPD,"\"),1,40),ZAA02G("LO")," ]" W !," Width: ",ZAA02G("HI"),@ZAA02GWPD@(.01)
 E  W "Default Settings for Reports",ZAA02G("HI")
DIS F I=1:1:17 S TT=$T(DATA+I),PP=$P(TT,"\",2),%R=$P(TT,"\",3),%C=$P(TT,"\",4),X=$P(TT,"\",5) W @ZAA02GP,ZAA02G("HI"),$J(I_") ",4),ZAA02G("LO"),X,$E("....................................",6,$P(TT,"\",7)-%C-$L(X)) D:$P(NEW,"\",PP)]"" DSPLY
 ;
SEL G:$D(EDV) SELECT S %R=24,%C=15 W @ZAA02GP,ZAA02G("LO"),"Type ",ZAA02G("HI"),"E",ZAA02G("LO")," to Edit format, ",ZAA02G("HI"),"C",ZAA02G("LO")," to Continue or ",ZAA02G("HI"),"Q",ZAA02G("LO")," to Quit ",ZAA02G("HI") R A#1 S:A?1L A=$C($A(A)-32) I A=""!($C(9)_"CQE"'[A) W *7,*8 G SEL
 I A="Q"!(A=$C(9)) S J=-1 G END
 I A'="E" S J=1 G END
SELECT S %R=24,%C=3 W @ZAA02GP,ZAA02G("LO"),"(Edit fields as needed - Press ",ZAA02G("HI"),"TAB",ZAA02G("LO")," to SAVE, ",ZAA02G("HI"),"EXIT",ZAA02G("LO")," to return without saving" W ")",ZAA02G("HI")
 X ZAA02G("ECHO-OFF") F J=$S($D(EDV):EDV,1:1):1:17 S TT=$T(DATA+J),%R=$P(TT,"\",6),%C=$P(TT,"\",7),S=1,RX=0 W @ZAA02GP D RD S:'S $P(NEW,"\",PP)=X I RX=1 S J=J-2 Q:J<0
 I J<0 G BEG1:J=-15,END
 Q:'$D(DOC)
FILE S:NEW'=OLD @ZAA02GWPD@(.03)=NEW
END X ZAA02G("ECHO-ON") K OLD,TT,NEW,PP,EDV Q
 ;
DSPLY S %R=$P(TT,"\",6),%C=$P(TT,"\",7) W @ZAA02GP,ZAA02G("HI"),$P(NEW,"\",PP) Q
SET S PP=$P(TT,"\",2),LNG=$P(TT,"\",9),CHR=$P(TT,"\",10),X=$P(NEW,"\",PP),X=X_$J("",LNG-$L(X)),L=1,S=0 Q
 ;
DATA ;\PIECE #\%R\%C\PROMPT\%R\%C\HELP\LENGTH\CHARS\
 ;\1\6\5\Lines/Inch (6 is normal)\6\65\61\4\0123456789.
 ;\2\7\5\Characters/Inch (add PS for Proportional Spacing)\7\65\62\8\0.123456789PSDRCO
 ;\3\8\5\Left Margin in Inches (1 normal)\8\65\63\5\0123456789.
 ;\4\9\5\Top Margin in Inches (1 normal)\9\65\64\5\1234567890.
 ;\8\10\5\If Right Justified: Specify length in inches\10\65\68\5\0.123456789
 ;\9\11\5\Top Margin of Page 2 through end (1 normal)\11\65\69\4\0123456789.
 ;\10\12\5\For Automatic Paging: Specify inches from bottom\12\65\70\5\.0123456789
 ;\11\13\5\Page Numbering: type 1st page # & T,B,R,L,C,A,X\13\65\71\10\0123456789-TBLRCAX,N
 ;\13\14\5\1st page Header/Footers (use / to delimit)\14\55\72\20\ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890./
 ;\14\15\5\Page 2+ Header/Last page Footer\15\55\72\20\ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890./
 ;\18\16\5\Envelope (Label) Header\16\55\72\20
 ;\15\17\5\Type of Report, Exam or Procedure Code\17\55\LOOKUPH\20\\LOOKUP\
 ;\16\18\5\Notes (default)\18\45\\39
 ;\17\19\5\Distribution List (default)\19\45\\5\1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ
 ;\19\20\5\Optional Site Code(s)\20\45\\39\ABCDEFGHIJKLMNOPQRSTUVWXYZ&,1234567890*
 ;\20\21\5\Tracking (M,U,S,D)\21\45\\3\
 ;\21\22\5\Signature Not Required (Y or N)\22\45\\1\YN
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
LOOKUP S B=$G(@ZAA02GSCR@("PARAM","REPORT TYPE")) Q:B=""  I $D(@$P(B,"\")@(X))
 Q
LOOKUPH D:S SET S B=$G(@ZAA02GSCR@("PARAM","REPORT TYPE")) Q:B=""  N (X,ZAA02G,ZAA02GP,ZAA02GSCR,B) S Y="30,6\RHLSD\2",Y(0)="\EX\"_B_"\TO" D ^ZAA02GPOP S:X[";EX" S=0,X="" Q
