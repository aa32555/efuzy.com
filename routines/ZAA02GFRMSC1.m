ZAA02GFRMSC1 ;PG&A,ZAA02G-SCHEMA,2.62,Database Dictionary Edit;7APR95 4:26P
 ;Copyright (C) 1984, Patterson, Gray & Associates, Inc.
 ;
BEG S %R=3,%C=1 W:'$D(qt) @ZAA02GP,ZAA02G("CS")
 S B="" I $D(^ZAA02GSCHEMA(S1)) S B=^(S1)
 S (OLD,NEW)=B,%R=4,%C=2 W:'$D(qt) @ZAA02GP,ZAA02G("CS"),ZAA02G("LO"),"Dictionary Item: ",ZAA02G("HI"),S1 I $D(^(S1))=0 W "    (new code)"
DIS F I=1:1:16 S T=$P($T(@I),";",2,999),P=$P(T,"\",2),%R=$P(T,"\",3),%C=$P(T,"\",4),X=$P(T,"\",5) W:'$D(qt) @ZAA02GP,ZAA02G("HI"),$J(I_") ",4),ZAA02G("LO"),X,$E("....................................",1,28-%C-$L(X)) D:$P(NEW,"`",P)]"" DSPLY
 ;
SEL S %R=24,%C=5 W:'$D(qt) @ZAA02GP,ZAA02G("LO"),"Type ",ZAA02G("HI"),"E",ZAA02G("LO"),"dit item, ",ZAA02G("HI"),"D",ZAA02G("LO"),"elete code, ",ZAA02G("HI"),"L",ZAA02G("LO"),"ist Forms, ",ZAA02G("HI"),"R",ZAA02G("LO"),"ecompile Forms, or ",ZAA02G("HI"),"Q",ZAA02G("LO"),"uit ",ZAA02G("HI")
 R A#1 S:A?1L A=$C($A(A)-32) I A=""!("DQLER"'[A) W *7,*8 G SEL
 I A="Q" S J=-1 K NEW,OLD,T Q
 I A="D" G DELETE
 I A="R" S ACOMPILE=1 G COMPILE^ZAA02GFRMSC2
 I A="L" G LIST^ZAA02GFRMSC3
SELECT S %R=24,%C=1 W:'$D(qt) @ZAA02GP,ZAA02G("CL"),$J("",20),ZAA02G("HI"),"Here to Continue ==>"
 X ^ZAA02G("ECHO-OFF") F J=1:1:16 S T=$P($T(@J),";",2,999),%R=$P(T,"\",6),%C=$P(T,"\",7),S=1,RX=0 W:'$D(qt) @ZAA02GP D RD S:'S $P(NEW,"`",P)=X I RX=1 S J=J-2 Q:J<0
 I J<0  K NEW,OLD,T Q
 S %R=24 W:'$D(qt) @ZAA02GP,"wait" 
FILE X ^ZAA02G("ECHO-ON") I NEW'=OLD S ^ZAA02GSCHEMA(S1)=NEW I $P(NEW,"`",3,18)'=$P(OLD,"`",3,18) D UPDATE^ZAA02GFRMSC2 Q
 K T,NEW,OLD Q
 ;
DELETE W:'$D(qt) @ZAA02GP,ZAA02G("CL") I $D(^ZAA02GSCHEMA(0,S1))>1 W:'$D(qt) ZAA02G("HI"),"Sorry, in use!" R A:2 I 1
 E  W:'$D(qt) ZAA02G("LO"),"Do you want to delete this code (",ZAA02G("HI"),"Y or N",ZAA02G("LO"),") ",ZAA02G("HI") R A#1 I A'="","Yy"[A S J=1 K ^ZAA02GSCHEMA(S1) W "...deleted" H 1
 S J=1 K NEW,OLD,T Q
 ;
DSPLY S %R=$P(T,"\",6),%C=$P(T,"\",7) W:'$D(qt) @ZAA02GP,ZAA02G("HI"),$P(NEW,"`",P) Q
SET S P=$P(T,"\",2),LNG=$P(T,"\",9),CHR=$P(T,"\",10),MAX=$P(T,"\",11),MIN=$P(T,"\",12),X=$P(NEW,"`",P),X=X_$J("",LNG-$L(X)),L=1,S=0 Q
PSET F I=1:1 S A=$P($T(@I),";",2,999) Q:A=""  S A(I)=$P(A,"\",2)_"\"_$P($P($P(A,"\",5),"["),"(")
 Q
 ;
DATA ;\PIECE #\%R\%C\PROMPT\%R\%C\INPUT ROUT\LENGTH\CHARS\MAX\MIN\INDEX
1 ;\1\5\2\Description\5\32\\47\
2 ;\2\6\2\Title of Item\6\32\\47\
3 ;\6\7\2\Type (Text,Num.,Date)\7\32\\1\TND
4 ;\3\9\2\Reference [^XX(S1,S2)]\9\32\\47\
5 ;\4\10\2\$Piece - i.e $P(X,",",2)\10\32\\47\
6 ;\7\11\2\Length of data\11\32\\5\0123456789,
7 ;\5\12\2\Multiple parameters\12\32\\47\
8 ;\12\13\2\Alias Codes\13\32\\47
9 ;\8\15\2\Pattern Match  [X?5N]\15\32\\47
10 ;\9\16\2\Addntl Validation\16\32\\47
11 ;\10\17\2\Fetch Transform\17\32\\47
12 ;\11\18\2\Put Transform\18\32\\47\
13 ;\14\20\2\Table Param. & Mnemonic\20\32\\47
14 ;\13\21\2\  "   Lookup Reference\21\32\\47\
15 ;\15\22\2\  "   Reference\22\32\\47
16 ;\16\23\2\  "   Text Length & Ref.\23\32\\47
RD R B#1 X ZAA02G("T") G RB:B="" D:S SET I CHR'="",CHR'[B G ER
 G ER:L>LNG W B S X=$E(X,1,L-1)_B_$E(X,L+1,99),L=L+1 G RD
RB G UP:ZF=ZAA02G("UK"),DN:ZF=ZAA02G("DK"),TB:ZF=$C(9),CR:ZF=$C(13)
 D:S SET G RT:ZF=ZAA02G("RK"),LT:ZF=ZAA02G("LK"),IN:ZF=ZAA02G("INK"),DL:ZF=ZAA02G("DLK"),127:ZF=$C(127)!(ZF=$C(8)),RE:ZF=ZAA02G("CL")
ER W *7 G RD
LT G RD:L'>1 S L=L-1 W:'$D(qt) ZAA02G("L") G RD
RT G RD:L'<LNG W:'$D(qt) ZAA02G("RT") S L=L+1 G RD
127 G:L=1 RD S X=$E(X,1,L-2)_" "_$E(X,L,99),L=L-1 W *8," ",*8 G RD
FUN R A G:A'=1 ER
DN S RX=2 G CR
UP S RX=1 G CR
TB S J=20 S RX=3
CR I $E(X)=" " S X=$E(X,2,99) G CR
 F L=0:0 S L=$F(X," ",L) Q:L'>0  I $E(X,L,99)?." " S X=$E(X,1,L-2) Q
 G OUT:X=""
OUT K LNG,CHR,L,C,B Q
DL W $E(X,L+1,99)," " S X=$E(X,1,L-1)_$E(X,L+1,99)_" " W:'$D(qt) @ZAA02GP,$E(X,1,L-1) G RD
IN G:$E(X,LNG)'=" " ER W " ",$E(X,L,LNG-1) S X=$E(X,1,L-1)_" "_$E(X,L,LNG-1) W:'$D(qt) @ZAA02GP,$E(X,1,L-1) G RD
RE S X=$E(X,0,L-1),CC=%C,%C=%C+L-1 W:'$D(qt) @ZAA02GP,$J("",LNG-L),@ZAA02GP S %C=CC,L=$L(X) K CC G RD
 ;
