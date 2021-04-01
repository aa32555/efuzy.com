ZAA02GSENDB ;PG&A,ZAA02G-SEND,1.36,KERMIT GLOBALS;8NOV95 10:54A;;;05SEP96  18:10
 ;Copyright (C) 1983, Patterson, Gray and Associates, Inc.
 ;
 G REMRCV:DIRECT="L",REMXMT
LOCXMT D SELECT I %N W !! U MODEM D LIST
 S %X="",CM=0 U MODEM D XFR R %XA:1 U 0 W:%N !!,"GLOBAL TRANSFER COMPLETED",! H 2 G EXIT
REMXMT W "Y",*13 X ECHOON S GSEL=SEL D SELECT X ECHOOFF W *20 G EXIT:%N=0 D LIST
 S %X="",CM=0 D XFR R %XA:0,%XA:1
EXIT K RT,J,N,RTA,CC,CO,C6,CT,%I,%A,%S Q
SELECT S CM=1,SFL=1 D CTINIT
 U 0 R !,"Single or Multiple globals (S or M) > ",S G:S'="M" READ
 S %N=1 X GSEL Q
CTINIT K CC S (CA,C6,CZ,%X1)="",(CL,CC,CF)=0,CC(CC)="",CQ=SQ,$P(CA,"X",71)="" S:SK]"" CQ=CQ_SK F J=0:1:31,127:1:159,255 S C6=C6_$C(J)
 I S8]" ","YN"'[S8 S CQ=CQ_S8_$C($A(S8)+128,$A(SQ)+128),$P(CA,"X",166)="" S:SK]"" CQ=CQ_$C($A(SK)+128) F J=128:1:255 S CZ=CZ_$C(J)
 S C6=C6_CQ Q
READ S %N=0 R !!,"Global> ^",%G Q:%G=""  G QUES:%G="?" D SYNTX I %T<0 W *7,"  Syntax Error." G READ
 I '$D(@%G) W *7,"  Not found." G READ
 S %N=-1 Q
SYNTX S:'($E(%G)="^") %G="^"_%G S %T=$S(%G'["(":0,$E(%G,$L(%G))=")":2,$P(%G,"(",2)]"":0,1:-1),%S=$P(%G,"(",2,99),%S=$P(%S,")"),%G=$P(%G,"(") Q
 ;
LIST I %N<0 D RDY Q
 S %GG=0 F %I=1:1 S %GG=$O(^UTILITY(%J,%GG)) Q:%GG=""  S %G="^"_%GG X:MODEM "U 0 W !!!,%GG,!" D SYNTX,RDY ;D ALL:LOS="PSM",RDY:LOS'="PSM"
 Q
ENTRY1 D SYNTX S %ST="I^ZAA02GSENDB"
RDY S %L=0,%K=9 F %I=1:1:10 S %I(%I)="",%A=$P(%S,",",%I) I %A'="" S:%A["*" %A=$P(%A,"*",1),%K=%I I %A'="" S:%I-1=%L %L=%I S:%A["""" %A=$P(%A,"""",2) S %I(%I)=%A
 S %S=%G_"(%I(1),%I(2),%I(3),%I(4),%I(5),%I(6),%I(7),%I(8),%I(9),%I(10)"
 S:%T>0 %T=%L S:%L=0 %L=1 I $L(%I(1)) S %A=$D(@($P(%S,",",1,%L)_")")) G:%A=0 I S %A=%I(%L) G J
II I $D(@%G)#10 S %D=@%G,%X=%G D:SFL>1 XFR S %X=%D,CM=1 S:SFL=1 %X=%X_$C(13,10) D XFR
I S (%I(%L),%A)=$O(@($P(%S,",",1,%L)_")")) I %A="" S %L=%L-1 G END:%T'<%L,I
J S %D=$D(^(%A)) G:%K=%L KK I %D=10 S %L=%L+1 G I
 I %D=11 D WRITE S %L=%L+1 Q:CF  G I
 D WRITE I CF S %ST="I^ZAA02GSENDB" Q
 S %A=$O(^(%I(%L))),%I(%L)=%A G:$L(%A) J S %L=%L-1 G END:%T'<%L,I
KK I $D(^(%A))#2 D WRITE Q:CF
 G I
 ;
END S %ST="END1^ZAA02GSENDB" I $D(CC(CC)),CC(CC)]"" S CF=CF+1
 Q
END1 S:'CF SDB="" I SDB="" K CC S %ST="ENTRY1^ZAA02GSENDB",CC=0,CC(CC)="" Q
 Q
ALL S %A=%G I $D(@%A)#10 S %X=%A,%Z=@%A D W2
ALL1 S %A=$ZZ(1,"","",@%A@("")) Q:%A=""  S %X=%A,%Z=@%A D W2 G ALL1
 ;
WRITE S %Z=^(%A) G:SFL<2 W2 S %X=%G_"(" F %I=1:1:%L S %B=%I(%I) D:%B["""" QUOTE S %X=%X_""""_%B_""","
 S %X=$E(%X,1,$L(%X)-1)_")" D XFR
W2 S %X=%Z D XFR I SFL=1 S %X=$C(13,10) D XFR
 Q
 ;
QUOTE F %II=1:2:$L(%B,"""")-1*2 S $P(%B,$C(34),%II)=$P(%B,$C(34),%II)_$C(34)
 Q
CTL S A=%X,(%X,%X1,%X2)="",M=$TR(A,"X"_C6," "_CA),(T,F)=0 I S8?1P,$TR(A,CZ,"")'=A G CTL1
 F i=2:1:$L(M,"X") S F=$F(M,"X",F),G=$A(A,F-1) S:$L(%X)+F-T>250 %X1(+%X1)=%X,%X2=%X2+$L(%X),%X1=%X1+1,%X="" S %X=%X_$E(A,T,F-2)_SQ_$C($S(CQ[$C(G):G,G\64#2:G-64,1:G+64)),T=F
 S:$L(%X)+$L($E(A,F,511))>250 %X1(+%X1)=%X,%X2=%X2+$L(%X),%X1=%X1+1,%X="" S %X=%X_$E(A,F,511),%X2=%X2+$L(%X) Q
CTL1 S M=$TR(M,CZ,CA),(T,F)=0
 F i=2:1:$L(M,"X") S F=$F(M,"X",F),G=$A(A,F-1) S:$L(%X)+F-T>250 %X1(+%X1)=%X,%X2=%X2+$L(%X),%X1=%X1+1,%X="" S %X=%X_$E(A,T,F-2)_$S(CZ[$C(G):S8,1:"")_$S(CQ[$C(G):SQ_$C(G#128),C6[$C(G):SQ_$C($S(G\64#2:G#64,1:G#64+64)),1:$C(G#128)),T=F
 S:$L(%X)+$L($E(A,F,511))>250 %X1(+%X1)=%X,%X2=%X2+$L(%X),%X1=%X1+1,%X="" S %X=%X_$E(A,F,511),%X2=%X2+$L(%X) Q
 ;
XFR S %X2=$L(%X),TBY=TBY+%X2,SBY=SBY+%X2 I $TR(%X,C6,"")'=%X D CTL
 D:$L(CC(CC))+4>SIZE XFR2 I SFL=2 S CC(CC)=CC(CC)_$E(10000+%X2,2,5)
 I %X1 S %X1(+%X1)=%X X "F %X1=0:1:%X1 S %X=%X1(%X1) D XFR1" S %X1=0 Q
XFR1 I SK]"",%X["         "!(%X["0000000") D XFR3
 S %=$L(%X)+$L(CC(CC))-SIZE I %'>0 S CC(CC)=CC(CC)_%X Q
 S %=$L(%X)-%,CC(CC)=CC(CC)_$E(%X,1,%) I $L($TR($E(CC(CC),SIZE-4,SIZE),CQ,""))'=5 S %C=0 F %B=SIZE:-1:SIZE-4 I CQ'[$E(CC(CC),%B),SK'=$E(CC(CC),%B-1) Q:%B=SIZE  S %=%B-SIZE+%,CC(CC)=$E(CC(CC),1,%B) Q
 D XFR2 S %X=$E(%X,%+1,9999) G XFR1
 Q
XFR2 S CC=CC+1,CC(CC)="",CF=CF+1 Q
XFR3 F %=1:1:3 S %X2=$P("                    ,          ,000000000",",",%) I %X[%X2 F F=2:1:$L(%X,%X2) S %X=$P(%X,%X2)_$E(%X2)_SK_$P("3 ,) ,(0",",",%)_$P(%X,%X2,2,999)
 Q
 ;
REMRCV X ECHOFN W "Y",*13 D RCV Q
LOCRCV U 0 W !,"Please answer the global selection questions from the remote site:",!!,ZAA02G("RON")
LOCR1 S D=MODEM,XT="I B[TR S J=200,A=B,B=""""",B="" D ENTRY^ZAA02GSEND1 W ZAA02G("ROF"),!!
 S DV=MODEM X LECHOFN U 0 W !!,"Wait for transmission to complete...",!!
 U MODEM W "Y",*13 D RCV
 U 0 W !,"Transmission completed",! Q
 ;
RENTRY S (%D,%L)=0,%ST="RENTRY1^ZAA02GSENDB"
RENTRY1 I %D=0 S %L=$O(@%G@(%L)) G:%L="" REND S %X=%L_$C(13,10) D XFR
 S %D=%D+1 X "ZL @%L S %X=$T(+%D)" I %X]"" D XFR S %X=$C(13,10) D XFR Q:CF  G RENTRY1
 S %D=0 G RENTRY1
REND S %ST="REND1^ZAA02GSENDB" I $D(CC(CC)),CC(CC)]"" S CF=CF+1
 Q
REND1 S:'CF SDB="" I SDB="" K CC S %ST="RENTRY^ZAA02GSENDB",CC=0,CC(CC)="" Q
 Q
FENTRY S %ST="FENTRY1^ZAA02GSENDB"
 I ^ZAA02G("OS")="MSM" S DEV=51,ZC="Z=$ZC" O 51:(%G:"R"::::"")
 I ^ZAA02G("OS")="DTM" S DEV=10,ZC="Z=$ZIOS" O 10:("R":%G)
 I ^ZAA02G("OS")="M11" S DEV=%G,ZC="Z=$L(ZT)" O DEV:("UR") S %ST="FENTRY2^ZAA02GSENDB" G FENTRY2
FENTRY1 U DEV R %X#255 S @ZC U 0 I $L(%X)!('Z) D XFR Q:CF  G FENTRY1
 C DEV G FEND
FENTRY2 U DEV S $ZT="FILETRAP",ZT="" R %X#255 U 0 D XFR Q:CF  G FENTRY2
FENTRY3 C DEV
FEND S %ST="FEND1^ZAA02GSENDB" I $D(CC(CC)),CC(CC)]"" S CF=CF+1
 Q
FEND1 S:'CF SDB="" I SDB="" K CC S %ST="FENTRY^ZAA02GSENDB",CC=0,CC(CC)="" Q
 Q
FILETRAP S ZT=$ZE I ZT'["ENDOFFILE" W !,ZT S PTR="SB7"
 G FENTRY3
 ;
XX S (SBY,TBY)=0,SIZE=255,SFL=0,FGLOB="GLOB",(RDB,FILE)=1 S SQ="#",S8="&",SK="~" D CTINIT,CTINIT^ZAA02GSENDE
 O 51:("C:\MSM\MSM.OVL":"R"::::"")
XX1 U 51 R A#78 U 0 Q:A=""
 S %X=A,SX=%X S CC=0,CC(CC)="" D XFR S RD=CC(CC)
 D RQ^ZAA02GSENDE W "." I SX'=RD W !,SX,!,RD,!,CC(CC),! R CCC
 G XX1
