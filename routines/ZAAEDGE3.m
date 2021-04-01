%ZAAEDGE3 ;;
INIT N c,dc,C,I,P,R,W,BR,FC,LC,NR,TR,XC,P1,P2,P3,P4 S TR=18,NR=6,BR=TR+NR-1,FC=lm-1,LC=rm+1,P=1,W=LC-FC+1,XC=MSL-(MNL-1*WW),dc=0,P1="P1="_ZAAP,%R=17,%C=68,@P1,P2=ZAA("G1")_ZAA("HL")_ZAA("HL")_ZAA("HL")_ZAA("G0")
 F P3="`","\","^",":","+","/","|",";"," " I $L(X(1),P3)>2 Q
 I sr S %R=TR,%C=BR W @ZAA("SR")
 S %R=TR,%C=FC
PO S c=$E(X(P),%C-FC+1) D DSP(c) W @ZAAP
RD R C#1 I C="" X ZAA("T") S ZAAF=$P(ZAAY,"\",$A(ZAAX,$F(ZAAX,ZF))+2) G @ZAAF:"RK,LK,UK,DK,IC,DC,RU,EF,CR,SE,TB,HL,EX"[ZAAF,RD
 I P=MNL,%C>XC W *7 G RD
 W C S X(P)=$E(X(P),0,%C-FC)_C_$E(X(P),%C-FC+2,$L(X(P)))
 S %C=%C+1 I %C>LC S %C=FC D NEWL
 G PO
SE D ED S X(P)=$E(X(P),0,%C-FC)_c_$E(X(P),%C-FC+2,$L(X(P)))
 W @ZAAP,$TR(c,CS,xs) ;D DSP(C) S %C=%C+1 I %C>LC S %C=FC D NEWL
 G PO
GO D GO1 G EX
GO1 N %R,%C,Y S %R=24,%C=1 W @ZAAP,"Delimiter? - ",ZAA("CS") X ZAA("ECHO-ON") R Y S:Y?.N Y=$C(Y) X ZAA("ECHO-OFF") S %R=21 W @ZAAP,ZAA("CS") F %R=1:1:$L(X(P),Y) W ZAA("LO"),%R,"-",ZAA("HI")," ",$P(X(P),Y,%R)," "
 R Y G PO
ED N %R,%C,X S %R=24,%C=1,dc=1,X=$S(c="":"",1:$A(c)),Y="RON\ROF\EX\\3\\\255\0\\ASCII:  \\1" D READ^ZAAEDRS Q:ZAAF="EX"  S c=$C(X)
 Q
DSP(Y) W P1,P-1*W+%C-FC+1,":" S P4=0 F dc=1:1:P-1 S P4=$L(X(dc),P3)-1+P4
 W P4+$L($E(X(P),1,%C-1),P3),P2
 I Y'="",CS[Y N %R,%C S %R=24,%C=1,dc=1 W @ZAAP,tLO_"ASCII:  "_tHI_$A(Y)_"  "
 E  I dc N %R,%C S %R=24,%C=1,dc=0 W @ZAAP,tCL
 Q
UK G:P=1 EX S P=P-1 I %R=TR D SCRUP G PO
 S %R=%R-1 G PO
DK I P=MNL!($L(X(P))<W) S %C=$L(X(P))+FC G PO
 D NEWL G PO
RK G:P=MNL&(%C=LC) RD S %C=%C+1 I %C>LC S %C=FC D NEWL
 S:%C+FC-1>$L(X(P)) %C=$L(X(P))+FC G PO
LK G:P=1&(%C=FC) RD S %C=%C-1 S:%C<FC %C=FC+W-1,%R=%R-1,P=P-1 D:%R<TR SCRUP G PO
TB S %C=%C+10 I $L(X(P))<WW,%C-FC+1>$L(X(P)) S %C=$L(X(P))+FC-1 G PO
 I %C>LC S %C=FC I P<MNL S %R=%R+1,P=P+1 I %R>BR D SCRDN S %R=BR
 S:%C>LC %C=FC S:%C-FC+1>$L(X(P)) %C=$L(X(P))+FC G PO
RU G RD:P=1&(%C=FC) I %C-FC<$L(X(P)) G DC
 I %C=FC S %C=LC+1,P=P-1,%R=%R-1 D:%R<TR SCRUP
 S %C=%C-1 W @ZAAP,tCL S X(P)=$E(X(P),0,%C-FC) G RD
IC D ^ZAAEDGE5 G PO
DC D ^ZAAEDGE4 G PO
HL S HN=2323 D HELP^ZAAEDGE2 G PO
CR ;
EX W:sr @ZAA("CSR") Q
EF W tCL S X(P)=$E(X(P),0,%C-FC),RR=%R,CC=%C F I=P+1:1:MNL Q:'$D(X(I))  I X(I)]"" S X(I)="",%R=%R+1,%C=FC W:%R'>BR @ZAAP,tCL
 S %R=RR,%C=CC K I,CC,RR G PO
NEWL I P<MNL S P=P+1 S:'$D(X(P)) X(P)="" D:%R=BR SCRDN S:%R<BR %R=%R+1 S:%C>LC %C=%C-FC S:%C-FC+1>$L(X(P)) %C=$L(X(P))+FC Q
 W *7 S:$L(X(P))>WW X(P)=$E(X(P),1,WW) Q
SCRUP N %R,%C I sr S %R=TR,%C=FC W @ZAAP,@ZAA("IL"),$TR(X(P),CS,xs) Q
 S %R=BR,%C=FC W @ZAAP,@ZAA("DT") S %R=TR W @ZAAP,@ZAA("IL"),@ZAAP,$TR(X(P),CS,xs) Q
SCRDN N %R,%C I sr S %R=BR,%C=FC W @ZAAP,!,$TR(X(P),CS,xs) Q
 S %R=TR,%C=FC W @ZAAP,@ZAA("DT") S %R=BR W @ZAAP,@ZAA("IL"),@ZAAP,$TR(X(P),CS,xs) Q
