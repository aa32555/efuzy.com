ZAA02GSENDC ;PG&A,ZAA02G-SEND,1.36,KERMIT PARAMETERS;11AUG94 1:37P
 ;Copyright (C) 1993, Patterson, Gray and Associates Inc.
 S DATA="DATA1",NE=17,NEW="",%R=1,%C=24 W @ZAA02GP,"  K E R M I T   P A R A M E T E R S  ",!!,ZAA02G("CS")
 S (OLD,NEW)=$S($D(@ZAA02GSENDG@("KERMIT")):^("KERMIT"),1:"1\13\240\999\1\240\10\15\N\N\Y\#\\~\0\0\8") D DIS S:OLD'=NEW @ZAA02GSENDG@("KERMIT")=NEW Q
 ;
DIS X ^ZAA02G("TERM-ON") S L="",$P(L,".",50)=""
 F I=1:1:NE S TT=$P($T(@DATA+I),";",2,99),PP=$P(TT,"\",2),%R=$P(TT,"\",3),%C=$P(TT,"\",4),X=$P(TT,"\",5) W @ZAA02GP,ZAA02G("HI"),$J(I_") ",4),ZAA02G("LO"),X,$E(L,6,$P(TT,"\",7)-%C-$L(X)) D:$P(NEW,"\",PP)]"" DSPLY
 S XY=^ZAA02G(.3),XX=^(.3,ZAA02G,0)
 ;
SEL S %R=24,B="Type *E* to Edit or press *EXIT KEY* to quit"
 S %C=80-$L(B)\2 W @ZAA02GP F J=1:2:8 W ZAA02G("LO"),$P(B,"*",J),ZAA02G("HI"),$P(B,"*",J+1)
 W " "
 R A#1 X ZAA02G("T") I A="",$P(XY,"\",$A(XX,$F(XX,ZF))+2)="EX" S A="Q"
 S:A?1L A=$C($A(A)-32) I A=""!($C(9)_"Q"_$P(B,"*",2)_$P(B,"*",4)'[A) W *7,*8 G SEL
 I A="Q"!(A=$C(9)) S J=-1 G END
 I A'=$P(B,"*",2) S J=1 G END
SELECT S %R=24,I=1,B="Edit fields as needed - Press *EXIT* to quit"
 S %C=80-$L(B)\2 W @ZAA02GP,*13,ZAA02G("CL"),@ZAA02GP,ZAA02G("LO"),"( " F J=1:2:8 W $P(B,"*",J),ZAA02G("HI"),$P(B,"*",J+1),ZAA02G("LO")
 W " )",ZAA02G("HI")
 X ^ZAA02G("ECHO-OFF") F J=1:1:NE S TT=$T(@DATA+J),%R=$P(TT,"\",6),%C=$P(TT,"\",7),S=1,RX=0 W @ZAA02GP D RD S:'S $P(NEW,"\",PP)=X I RX=1 S J=J-2 Q:J<0
 I J<0 G END
END X ^ZAA02G("ECHO-ON"),^ZAA02G("TERM-OFF") K NE,DATA,J,RX,L,XX,XY Q
 ;
DSPLY S %R=$P(TT,"\",6),%C=$P(TT,"\",7) W @ZAA02GP,ZAA02G("HI"),$P(NEW,"\",PP) Q
SET S PP=$P(TT,"\",2),LNG=$P(TT,"\",9),CHR=$P(TT,"\",10),X=$P(NEW,"\",PP),X=X_$J("",LNG-$L(X)),L=1,S=0 Q
 ;
DATA1 ;
 ;\1\3\5\Tx packet start char (decimal)\3\50\\2\0123456789
 ;\2\4\5\Tx packet end char (decimal or blank)\4\50\\2\0123456789
 ;\3\5\5\Tx packet max length\5\50\\4\0123456789
 ;\4\6\5\Tx packet timeout (seconds)\6\50\\2\0123456789
 ;\5\7\5\Rx packet start character\7\50\\2\0123456789
 ;\6\8\5\Rx packet max length\8\50\\4\0123456789
 ;\7\9\5\Rx timeout (seconds)\9\50\\2\0123456789
 ;\8\10\5\Error retry limit\10\50\\3\0123456789
 ;\9\11\5\Add Ctrl-Z to EOF (YN)\11\50\\1\YN
 ;\10\12\5\Trace Display (YN)\12\50\\1\YN
 ;\11\13\5\Attribute Packet (YN)\13\50\\1\YN
 ;\12\14\5\Control quote character\14\50\\1\
 ;\13\15\5\8th bit quote character (blank=off)\15\50\\1\
 ;\14\16\5\Compression character\16\50\\1\
 ;\15\17\5\Number of pad characters\17\50\\2\0123456789
 ;\16\18\5\Pad character (decimal)\18\50\\2\0123456789
 ;\17\19\5\Window size\19\50\\2\0123456789
 ;
DATA2 ;
 ;\1\4\5\1\4\40\\38\
 ;\2\6\5\2\6\40\\38\
 ;\3\7\5\3\7\40\\38\
 ;\12\8\5\4\8\65\\10\
 ;
RD R B#1 X ZAA02G("T") G RB:B="" D:S SET G ERR:B["\" I CHR'="",CHR'[B G ERR
 G ERR:L>LNG W B S X=$E(X,1,L-1)_B_$E(X,L+1,99),L=L+1 G RD
RB S E=$P(XY,"\",$A(XX,$F(XX,ZF))+2) I E'="",$T(@E)'="" G @E
ERR W *7 G RD
LK D:S SET G RD:L'>1 S L=L-1 W ZAA02G("L") G RD
RK D:S SET G RD:L'<LNG W ZAA02G("RT") S L=L+1 G RD
RU G:L=1 RD S X=$E(X,1,L-2)_" "_$E(X,L,99),L=L-1 W *8," ",*8 G RD
DK S RX=2 G CR
UK S RX=1 G CR
EX ;
TB S RX=3,J=99
CR Q:S  I $E(X)=" " S X=$E(X,2,99) G CR
OUT X:X[" " "F I=$L(X):-1:0 I $E(X,I)'="" "" S X=$E(X,1,I) Q" W @ZAA02GP,X,ZAA02G("CL") K LNG,CHR,L,C,B Q
DC D:S SET W $E(X,L+1,99)," " S X=$E(X,1,L-1)_$E(X,L+1,99)_" " W @ZAA02GP,$E(X,1,L-1) G RD
IC D:S SET G:$E(X,LNG)'=" " ERR W " ",$E(X,L,LNG-1) S X=$E(X,1,L-1)_" "_$E(X,L,LNG-1) W @ZAA02GP,$E(X,1,L-1) G RD
HP S HP=$P(TT,"\",8) G ERR
ER D:S SET S X=$E(X,0,L-1),CC=%C,%C=%C+L-1 W @ZAA02GP,$J("",LNG-L+1),@ZAA02GP S %C=CC,L=$L(X)+1 K CC G RD
 ;
