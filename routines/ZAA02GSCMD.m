ZAA02GSCMD ;PG&A,ZAA02G-MTS,1.20,DICTIONARY OPS;30DEC94 4:14P;;;05JUL2000  17:36
 ;
C ;Copyright (C) 1995, Patterson, Gray & Associates, Inc.
 ;
GROUP S GRP="",%R=3,%C=1,DICT="@ZAA02GSCMD@(""DICT"")" W @ZAA02GP,ZAA02G("CS")
 S LEX="ORG" I $D(@ZAA02GSCM@("PARAM","LEX")) S LEX=^("LEX")
GROUP1 D GRP K ts Q:$D(M1)  Q:X[";EX"  I X[";IL"  D NGROUP G GROUP1
 S GRP=X,GRX=@DICT@(2,X) D CODE S %R=15,%C=1 W @ZAA02GP,ZAA02G("CS") G GROUP1
 ;
GRP ; N (X,FX,ZAA02G,ZAA02GP,GLB,REFRESH,INP,NEWA)
 S Y="1,3\RHLGSD"_$G(M1)_"\1\GROUPS\   Group                    Description/Instructions            BIRADS Active"
 S Y(0)=$D(M1)>0*10+8_"\EX,IL\@DICT@(2)\$P($$GRPX^ZAA02GSCMD(TO),""^"");20`$E($P(ts,""^""),21,99);39`$P(ts,""^"",2);4`$S($E($O(@ZAA02GSCM@(""XP"",$P(ts,""^"",4))),1,2)[$P(ts,""^"",4):""Yes"",1:"""");3\\\"_GRP
 S $P(Y(0),"\",6)="Return, Exit, Insert Line   *"
 I $D(M1) S $P(Y(0),"\",6)="Press the SELECT key to select more than one   *"
 G ^ZAA02GPOP
GRPX(X) S ts=@DICT@(1,@DICT@(2,TO)) Q ts
 ;
NGROUP W "NEW GROUP" R CCC Q
 ;
CODE ;
 S Y="1,15\RHLGSD\1\CODES - "_$$R($E(@DICT@(1,GRX),1,20))_"\Code               Description              NMD #          Text      "
 S Y(0)="\EX,IL,SE\@DICT@(1,GRX)\$P(@DICT@(1,GRX,TO),""^"",4);5`$P(^(TO),""^"",2);33`$P(^(TO),""^"",3)_""-""_$P(^(TO),""^"");5`$G(^(TO,LEX,1));23"
 S $P(Y(0),"\",6)="Return, Exit, Insert Code, Select  *"
 D ^ZAA02GPOP
 Q:X[";EX"  I X[";SE" D TEXT Q
 S:X[";IL" X=$P(X,";"),NEWA=0 Q
 ;
R(%) S I=$TR(%," ",""),I=$E(I,$L(I)) Q $E(%,1,$L($P(%,I,1,$L(%,I)-1)_I))
 ;
TEXT S C2=GRX_","_(+X),C1="" D ENTRY^ZAA02GSCMRC Q
 ;
DIR S DICT="@ZAA02GSCMD@(""DICT"")" K @DICT@(2),^(3) S A="" F J=1:1 S A=$O(@DICT@(1,A)) Q:A=""  S B=$E(^(A),1,20),C=$P(^(A),"^",4) S:$D(@DICT@(2,B)) B=B_"2" S @DICT@(2,B)=A I C]"" D:$D(@DICT@(3,C)) DIRE S ^(C)=A
 S (A,B)="" F J=1:1 S A=$O(@DICT@(1,A)) Q:A=""  F J=1:1 S B=$O(@DICT@(1,A,B)) Q:B=""   S C=$P(^(B),"^",4) I C]"" D:$D(@DICT@(3,C)) DIRE S ^(C)=A_","_B
 Q
DIRE W "DUPLICATE CODE FOR - ",C," ",^(C)," & ",A,! Q
 ;
LEX R "Enter Lexicon Code-",LX,! Q:LX=""  S GL="@ZAA02GSCMD@(""DICT"",1,CD,NB)",GLA="@ZAA02GSCMD@(""DICT"",1,CD,NB,OLX)",OLX=LX
 I $D(@ZAA02GSCMD@("DICT",1,101,1,1))=0 R "Copy from Lexicon Code - ",OLX,! Q:OLX=""  S GL=GLA
 S (CD,NB)=""  F  S CD=$O(@ZAA02GSCMD@("DICT",1,CD)) Q:CD=""  W CD," " F  S NB=$O(@ZAA02GSCMD@("DICT",1,CD,NB)) Q:NB=""  F J=1,2 I $D(@GL@(J)) S @GLA@(J)=^(J) K:GL'["OLX" @GL@(J)
 Q
 ;
DISP ; N (X,FX,ZAA02G,ZAA02GP,GLB,REFRESH,INP,NEWA)
 S DICT="@ZAA02GSCMD@(""DICT"")",REFRESH="",Y="1,3\RHLGS\1\Dictionary Codes\    Grouping           Code        Description                 NMD    Text "
 S LEX="ORG" I $D(@ZAA02GSCM@("PARAM","LEX")) S LEX=^("LEX")
 S Y(0)="\EX,IL\\$G(@DICT@(1,+TO));20`$P(@DICT@(1,+TO,$P(TO,""|"",2)),""^"");4`$P(^($P(TO,""|"",2)),""^"",2);30`$P(^($P(TO,""|"",2)),""^"",3);3`$G(^($P(TO,""|"",2),LEX,1));6"
 S $P(Y(0),"\",6)="Return, Exit, Insert Code   *"
 D LOOK
 Q:X[";EX"  S:X[";IL" X=$P(X,";"),NEWA=0 S X=$P(X,"|",2) Q
 ;
LOOK S ZAA02GPOPALT=$P($T(LOOKT),";",2,99) D ^ZAA02GPOP Q
LOOKT ;S S=$P(TO,""|""),S2=$P(TO,""|"",2) F jj=1:1 S:S2="""" S=$O(@DICT@(1,S)) S:S="""" TO="""" Q:TO=""""  S:$L(S) S2=$O(@DICT@(1,S,S2)) I $L(S2),$D(@DICT@(1,S2)) S TO=S_""|""_S2 Q
 ;
 ;
CODES ; ASSIGN LETTER CODES TO GROUPS AND CODES
 K G S A="" F J=1:1 S A=$O(@ZAA02GSCMD@("DICT",1,A)) Q:A=""  S G=$P(^(A),"^",4) D:G]"" CODES3 I G="" F L=65:1 S B=$E(^(A)) S:" "[B B="X" S B=B_$C(L) I '$D(G(B)) S G(B)=A,$P(^(A),"^",4)=B Q
 S C="" F J=1:1 S C=$O(@ZAA02GSCMD@("DICT",1,C)) Q:C=""  S CD=$P(^(C),"^",4) K G S A="" F J=1:1 S A=$O(@ZAA02GSCMD@("DICT",1,C,A)) Q:A=""  S G=$P(^(A),"^",4) D:G'="" CODES3 I G="" D CODES1
 Q
CODES1 S G=$TR($P(^(A),"^"),"{}") S:G["-" G=$P(G,"-",2) S:G?.E1"("1U1")" G=$E($P(G,"(",2)) I $L(G)>1,G'?.N W G," " Q
 Q:$D(G(G))  S G(G)="",$P(^(A),"^",4)=CD_G Q
 ; F L=65:1 S B=$E(^(A)) S:B="" B="X" S B=B_$C(L) I '$D(G(B)) S G(B)=A,$P(^(A),"^",4)=B Q
 Q
CODES3 I $D(G(G)) W "DUPLICATE CODES-",A," ",$G(C)," ",G,!,*7 Q
 S G(G)="" Q
 ;
COPYGRP ; COPY A GROUP TO ANOTHER AREA
 R "COPY GROUP-",A,!,"TO AREA-",B,! I $D(@ZAA02GSCMD@("DICT",1,B)) W "ALREADY DEFINED",! Q
 S @ZAA02GSCMD@("DICT",1,B)=@ZAA02GSCMD@("DICT",1,A)
 S (C,D,E,F)="" F  S C=$O(@ZAA02GSCMD@("DICT",1,A,C)) Q:C=""  S @ZAA02GSCMD@("DICT",1,B,C)=^(C),$P(^(C),"^",4)="" F  S D=$O(@ZAA02GSCMD@("DICT",1,A,C,D)) Q:D=""  F F=1,2 I $D(@ZAA02GSCMD@("DICT",1,A,C,D,F)) S @ZAA02GSCMD@("DICT",1,B,C,D,F)=^(F)
 Q
SEQ ; ASSIGN SEQUENCE NUMBERS TO GROUPS
 R !,"GROUP-",G,! Q:G=""  S A=G F J=1:1 S A=$O(@ZAA02GSCMD@("DICT",3,A)) Q:$E(A,1,2)'=G  S B=^(A) W A,?10,B,?17,$G(@ZAA02GSCMD@("DICT",1,+B,$P(B,",",2))),!
 G SEQ
SPELL S (A,B,E)=""
 F  S A=$O(@ZAA02GSCMD@("DICT",1,A)) Q:A=""  F  S B=$O(@ZAA02GSCMD@("DICT",1,A,B)) Q:B=""  F  S E=$O(@ZAA02GSCMD@("DICT",1,A,B,E)) Q:E=""  I $D(^(E,1)) S C=$TR($ZL(^(1)),"-.,()<>"," ") I C]"" F J=1:1:$L(C," ") S D=$P(C," ",J) I D]"",'$D(^ZAA02GWORD(D)) W D
 Q
BIOVAL ;VALIDATE BIOPSY RECOMMENDATION CODES
 N x,J S x="" F J=1:1:$L(X,",")+1 S x=$P(X,",",J) I x]"",+$G(@ZAA02GSCMD@("DICT",3,x))'=14!($L(x)'=3) Q
 I x=""
 Q
PATH ; ENTER NEW PATH CODES
 R "CODE-",C I $D(^ZAA02GSCMD("DICT",3,"L"_C)) W ?30,"defined",! G PATH
 R ?35,"Desc: ",D,! F J=99:1 I '$D(^ZAA02GSCMD("DICT",1,26,J)) Q
 S ^ZAA02GSCMD("DICT",1,26,J)=C_"^"_D_"^^L"_C G PATH
