ZAA02GSCRFL ;PG&A,ZAA02G-SCRIPT,2.10,FOLLOW-UP LETTERS;15MAY96 9:25A
 ;
LIST ; LIST FOLLOW-UP LETTERS TO PRINTER
 S Y="40,10\RLDV\2\Select Printer\\" S X="" F J=1:1 S X=$O(^ZAA02GWP(96,X)) Q:X=""  S Y=Y_X_","
 S Y=$E(Y,1,$L(Y)-1),Y(0)="\EX" D ^ZAA02GPOP Q:X[";EX"   S DV=X Q:DV=""  S %R=3 W @ZAA02GP,ZAA02G("CS") S %R=10,%C=20 W @ZAA02GP,"Follow-up Letter Listing is Queued to Printer ",DV H 1
 K Y S DOC="^REPORTS" S Y("XECUTE")="D L^ZAA02GSCRFL" D QUEUE^ZAA02GSCRSP K Y H 1 Q
L S (A,B,C,D)="" F I=1:1 S A=$O(^ZAA02GFLUP(A)) Q:A=""  S B=0 F J=1:1 S B=$O(^ZAA02GFLUP(A,B)) Q:B=""  F J=1:1 S C=$O(^ZAA02GFLUP(A,B,C)) Q:C=""  F J=1:1 S D=$O(^ZAA02GFLUP(A,B,C,D)) Q:D=""  D L1
 W !!# Q
L2 W "  SITE  TYPE   DR    PATIENT                         YY/MM   REPORT-#   LETTER",!! Q
L1 W:$Y>55 # D:$Y=0 L2 S F=^(D),E=$S(F]"":$G(^ZAA02GSCR("TRANS",+F,.011)),1:"") W ?3,A,?9,B,?14,$P(E,"`",7),?20,C,?27,$E($P(E,"`",8),1,25),?53,D\100,"/",$E(D,3,4),?61,+F,?72,$P(F,":",2),! Q
