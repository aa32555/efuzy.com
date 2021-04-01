%ZAA02GEDGL ;;30APR96  16:21;Tue, 15 Sep 2015  16:38;SUBR: PARSE GLOBAL REFERENCE;Thu, 0
 ; ADS Corp. Copyright
 ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc.
 ;;All rights reserved.
CHK N A,B,C,F,I,J,R,S,T,Z,CL,CM,DA,DC K BS,ES,GN,GR S DA=127,DC=$C(DA),(E,CL,CM,GN)="",MX=99,(E,MN,NL,FLV)=0
 S GN=$TR($P(X,"("),"^",""),Z=$TR(GN,".") I GN=""!(Z'?.2"|"1A.31AN&(Z'?1"%".30AN)&(Z'?1"["1.20ANP1"]"1.31AN)) S E=1 Q
 S GN="^"_GN,GR=GN S:'$D(@GN) E=2
 S Z=$P(X,"(",2) Q:Z=""  S C=$E(Z,$L(Z)) I C=")" S Z=$E(Z,0,$L(Z)-1),CL=1
 I 'CL,$E(Z,$L(Z))'="," S Z=Z_","
 S GR=GR_"("_Z_$S(CL:")",1:"")
 D:Z["""" QUO Q:E=3  S NL=$L(Z,",") F I=1:1:NL S R=$P(Z,",",I) D BLD
 S MX=$S(CL:NL,1:99) I CL,$D(ES(NL)) F FLV=NL:-1:0 I '$D(ES(FLV)) S FLV=NL Q
QUO K T S (F,B,T)=0 F J=0:0 S F=$F(Z,"""",F) Q:F=0  S @$S(B:"T=T+1,T(T)=$E(Z,B+1,F-2),Z=$E(Z,1,B-1)_DC_$C(T)_$E(Z,F,9999),F=F-$L(T(T)),B=0",1:"B=F-1")
 S:B>0 E=3 Q
BLD S A=$P(R,":") S:A[DC T=$A($P(A,DC,2)),A=$P(A,$C(DA,T))_T(T)_$P(A,$C(DA,T),2) S BS(I)=A I R'[":" S ES(I)=A Q
 S A=$P(R,":",2) S:A[DC T=$A($P(A,DC,2)),A=$P(A,$C(DA,T))_T(T)_$P(A,$C(DA,T),2) S ES(I)=A
 Q
LIST N (ZAA02G,ZAA02GP,X,RQ,POP) S O=$G(^%T("OS"),$G(^ZAA02G("OS"),"M11")),T="INIT"_O I POP?1"[".E1"]" S UCI=$P(POP,"]")_"]",POP=$P(POP,"]",2)
 Q:$T(@T)=""  D @T
 S X=$S(POP[";":$P(POP,";"),X'?.1"%"1A.AN:"",1:X),(T,TO)=$S(X="":0,1:$TR($E(X,1,$L(X)-1)_$C($A(X,$L(X))-1),"`@/","Z90")_"z"),Y="Y="""_ALT_"""",@Y
 S:T'?."%"1A.AN (T,TO)="" X Y G:TO="" LISTE I X]"",TO](X_"~") G LISTE
 S ZAA02GPOPALT=ALT,Y="10\RHVLD\7\GLOBALS",Y(0)="15\EX\\TO\"_T_"\\\"_$S(X'="":X_"z",1:""),$P(Y(0),"\",7)=$P(POP,";",2)
 I X]"" S ZAA02GPOPALT=ZAA02GPOPALT_" S:TO]TEN TO=""""""""",Y=Y_" "_X_" - "_X_"~"
 D ^ZAA02GEDPO S X=$S(X[";EX":"",1:X),$P(POP,";",2)=X Q
LISTE S X="" W "...none found" H 1 Q
INITPSM S S=2,R="G",%J=$I D INIT^%DSET S $ZE="",ALT="S TO=$O(^UTILITY(""""G"""",TO))" Q
INITM11 S ALT="S TO=$E($O(^$G($C(94)_TO)),2,99)" Q
INITM3 S ALT="S TO=$O(^$G(TO))" Q
INITMSM S ALT="S:TO=0 TO="""""""" S TO=$O(@(""""^""""_$G(UCI)_TO))" Q
INITDTM S ALT="S:TO=0 TO=""""A"""" S TO=$O(@(""""^""""_TO))" Q
INITDSM4 S ALT="S:TO=0!($L(TO)=0) TO=""""A"""" S TO=$ZS(@(""""^""""_TO))" Q
HELP N (ZAA02G,ZAA02GP,POP) S Y="10,4\TRHLYW50D\1\Active Function Keys\Function Key          Action                  ",Y(0)="15\EX\" F J=2:1 S A=$P($T(HELP+J),";",2,9) Q:A=""  S Y($P(A,";"))=$E($P(A,";")_$J("",20),1,20)_$P(A,";",2)
 D ^ZAA02GEDPO Q
 ;Insert Character;Restore References
 ;Delete Character;Remove Reference Display
 ;Select Key;Select Piece(s) to Display
 ;Find Key;Expand String and show pieces
 ;Next/Previous;Page Forward and Backward
 ;Tab;Expand or Contract References
 ;Insert Line;Insert New node
 ;Delete Line;Delete Node Pointed to by Cursor
 ;Exit;Return to Global Selection
 ;Copy;Copy the Data at the Cursor Position
