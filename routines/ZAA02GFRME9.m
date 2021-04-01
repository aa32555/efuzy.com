ZAA02GFRME9 ;PG&A,ZAA02G-FORM,2.62,FORMS EDITOR, PART 9;27DEC94 10:42A;;;14MAR95 4:08P
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
BEG X ^ZAA02G("ECHO-OFF") S VD=2,ON=5,A=1,%R=RS,%C=CS,Y=0 D ST I '$D(ACOMPILE) F J=1:0:99 S B=A R Z#1 X:$D(ex) ex D @$S(Z'="":"CHAR",1:"B") W:'$d(qt) CUR,%R," C",%C," ",@ZAA02GP
 W:'$d(qt) VIDOF,ZAA02G("G0") K VIDON,VIDOF,VD,VM,ON,Y,Z,TC,ZF,XX,CT,H,HD,HD1,WR,PNT X ^ZAA02G("ECHO-ON") Q
 ;
B X TC S (F,A)=$E(XX,$F(XX,ZF)) G:A PNT:$D(PNT) G:A @(A+ON) S A=B G @(1+ON):ZF=$C(7),CODE:ZF=$C(6),VIDEO:ZF=$C(22),VIDEO:ZF=$C(23),ERASE:ZF=$C(5),RUBOUT:ZF=$C(127)!(ZF=$C(8)),FORCE:ZF=$C(1),TAB:ZF=$C(9)
 S:$C(24,21,18)[ZF J=100 S:ZF=$C(13) %C=CS G:F="G" @(1+ON) G CODE:F="H",VIDEO:F="F",ERASE:F="I",PAINT:F="J"
 G:F?1A @("EX"_F) W:'$d(qt) *7 Q
1 S ON=5,VD=VD\2*2 G ST
2 S Y=$E(22253,B) D CHK W:'$d(qt) ZAA02G("G1"),CT(Y),ZAA02G("G0") G 7
3 S Y=$E(22261,B) D CHK W:'$d(qt) ZAA02G("G1"),CT(Y),ZAA02G("G0") G 8
4 S Y=$E(41344,B) D CHK W:'$d(qt) ZAA02G("G1"),CT(Y),ZAA02G("G0") G 9
5 S Y=$E(46544,B) D CHK W:'$d(qt) ZAA02G("G1"),CT(Y),ZAA02G("G0") G 10
 ;
6 S ON=0,VD=VD\2*2+1 G ST
7 S %C=%C-1+$G(C(%C-1)) Q
8 S %C=%C+1+$G(C(%C+1)) Q
9 S %R=%R+1+$G(R(%R+1)) Q
10 S %R=%R-1+$G(R(%R-1)) Q
 ;
CHK I $D(@ZAA02GG@(%R,%C)),+^(%C)'=Y,$P(^(%C),"`",2)#2 D F1 S ^(%C)=YY_VM,Y=YY,AA=%R_","_%C Q
 S ^(%C)=Y_VM D:$D(AA) F2 Q
F1 S C="" S:$D(@ZAA02GG@(%R-1,%C)) C=1 S:$D(@ZAA02GG@(%R+1,%C)) C=C_2 S:$D(@ZAA02GG@(%R,%C-1)) C=C_3 S:$D(^(%C+1)) C=C_4 S YY=$S(C=134:10,C=123:9,C=124:11,C=234:8,C=1234:7,C=13:5,C=14:6,C=23:3,C=12:4,C=34:2,1:1) Q
F2 S Z=%R_","_%C,%R=+AA,%C=$P(AA,",",2) K AA D F1 W:'$d(qt) @ZAA02GP,ZAA02G("G1"),CT(YY),ZAA02G("G0") S ^(%C)=YY_VM S %R=+Z,%C=$P(Z,",",2) W:'$d(qt) @ZAA02GP Q
CHAR G:Z="~" CODE W:'$d(qt) Z I Z=" ",VD<4 K @ZAA02GG@(%R,%C) D:$D(@ZAA02GG@(.2,%R,%C)) RECODE S A=1 S:%C<CE %C=%C+1 Q
 S @ZAA02GG@(%R,%C)=Z_"`"_(VD\2*2),A=1 S:%C<CE %C=%C+1 Q
 ;
CODE D CODE^ZAA02GFRME3,ST S B=1 Q
DEFALT D DEFALT^ZAA02GFRME3 Q
DEF1 D DEF1^ZAA02GFRME3 Q
RECODE D RECODE^ZAA02GFRME3 Q
ST D STATUS,STATUS1 Q
STATUS S VM="`"_VD W:'$d(qt) VIDOF,ZAA02G("LO"),STL,"Form: ",ZAA02G("HI"),GR,"  " I scope[">" W:'$d(qt) ZAA02G("LO"),"Group: ",ZAA02G("HI"),scope,$J("",18-$L(scope))
 E  W:'$d(qt) $J("",25)
 W:'$d(qt) ZAA02G("LO"),"Video Mode: ",ZAA02G("HI")
 S C=$S(VD#2:"LINE ",1:"TEXT ")_$S(VD\2#2:"",1:"HI ")_$S(VD\4#2:"REV ",1:"")_$S(VD\8#2:"UND ",1:"")_$S($D(PNT):"PAINT",1:"") W:'$d(qt) C Q
STATUS1 W:'$d(qt) STL1,ZAA02G("LO"),"Keys: ",ZAA02G("HI"),"SELECT,HELP-Field, ERASE-Line, BOLD-Video, FIND-Draw, REFORM-Paint, EXIT"
 W:'$d(qt) @ZAA02GP,VIDON Q
VIDEO X ^ZAA02G("ECHO-ON") W:'$d(qt) VIDOF,STL,"Enter Video Attributes (R,H,U) " S VD=VD#2+2 R C X ^ZAA02G("ECHO-OFF") F I=1:1:$L(C) S J=$E(C,I) S:J?1L J=$C($A(J)-32) S VD=VD+$S(J="R":4,J="H":-2,J="U":8,1:0)
 S VIDON=$S(VD\2#2:ZAA02G("LO"),1:ZAA02G("HI"))_$S(VD\4#2:ZAA02G("RON"),1:"")_$S(VD\8#2:ZAA02G("UO"),1:"") G ST
 ;
PAINT I $D(PNT) K PNT G ST
 W:'$d(qt) STL1,"PAINT VIDEO: Move cursor to paint screen" S PNT="" Q
PNT I $D(@ZAA02GG@(%R,%C)) S F=^(%C) I F'["0*" S $P(F,"`",2)=VD\2*2+($P(F,"`",2)#2),^(%C)=F D EXDS
 G @(A+5)
 ;
FORCE W:'$d(qt) *7 F I=1:1 R *ZF Q:ZF'=1  S Y=I#11+1 W:'$d(qt) ZAA02G("G1"),CT(Y),ZAA02G("G0"),@ZAA02GP S @ZAA02GG@(%R,%C)=Y_"`"_(VD\2*2+1),B=""
 W:'$d(qt) *7 G B
ERASE Q:$D(@ZAA02GG@(%R,%C))=0  K B S Z=%R_","_%C,b(Z)="" F I=1:1:4 S C=$P("1,2,6,7,8,10,11;1,3,4,7,8,9,11;4,5,6,7,9,10,11;2,3,5,7,8,9,10",";",I) F J=1:1:7 S X(I,$P(C,",",J))=""
 D E1 S %R=+Z,%C=$P(Z,",",2),B="" W:'$d(qt) @ZAA02GP K Z,X Q
E1 S B=$O(b("")) Q:B=""  S %R=+B,%C=$P(B,",",2) W:'$d(qt) @ZAA02GP," " K b(B),@ZAA02GG@(%R,%C)
E2 S %R=%R-1,%C=%C-1 F I=1:1:4 S X=%R+$E(1021,I),Y=%C+$E("0112",I) I $D(@ZAA02GG@(X,Y)),$D(X(I,+^(Y))) S b(X_","_Y)=""
 G E1
 ;
TAB S:%C+10<CE %C=%C+10 Q
EXA S J=100 Q
EXB ; INS LINE
 I $O(@ZAA02GG@(24,"")) W:'$d(qt) *7 Q
 S J=%R,WR=1 N %R,%C,scope S scope=0 F j=0:0 S scope=$O(@ZAA02GG) Q:scope=""  F JJ=23:-1:J I $D(@ZAA02GG@(JJ)) S %C=1,%R=JJ W:'$d(qt) @ZAA02GP,ZAA02G("CL") S %R=JJ+1 F %C="":0 S %C=$O(@ZAA02GG@(JJ,%C)) K:%C="" @ZAA02GG@(JJ),@ZAA02GG@(.2,JJ) Q:%C=""  S F=^(%C) D EXDL
 S scope=0,F="" F j=0:0 S F=$O(@ZAA02GG@(F)) Q:$E(F)'=">"  I $P(^(F),"`",3)'<J  S $P(^(F),"`",3)=$P(^(F),"`",3)+1_","_$P($P(^(F),"`",3),",",2)
 G EXDX
EXC ; DEL LINE
 I $D(@ZAA02GG@(.2,%R)) W:'$d(qt) *7 Q
 Q:$O(@ZAA02GG@(%R-1))=""  S J=%R,WR=1 N %R,%C F JJ=J+1:1:24 S %R=JJ-1,%C=1 K @ZAA02GG@(%R),@ZAA02GG@(.2,%R) W:'$d(qt) @ZAA02GP,ZAA02G("CL") I $D(@ZAA02GG@(JJ)) F %C="":0 S %C=$O(@ZAA02GG@(JJ,%C)) Q:%C=""  S F=^(%C) D EXDL
 G EXDX
EXD ; INS CHAR
 Q:$O(@ZAA02GG@(%R,%C-1))=""  D EXDJ I V>CE W:'$d(qt) *7 Q
 S F="",J=%C,WR=1 I ZAA02G("IN")'="" S WR=0 W:'$d(qt) ZAA02G("IN")
 F %C=%C-1:0 S %C=$O(@ZAA02GG@(%R,%C)) Q:'%C  S I=^(%C) X $S(F="":"K @ZAA02GG@(.2,%R,%C),@ZAA02GG@(%R,%C) W:WR @ZAA02GP,VIDOF,"" """,F["0*":"D EXDF",1:"S ^(%C)=F D:WR EXDS") S F=I I I]"" S:'$D(^(%C+1)) ^(%C+1)=""
 S %C=J G EXDX
EXDS S V=$P(F,"`",2) W:'$d(qt) @ZAA02GP,VD(+V),$S(V#2:CT(+F),1:$E(F_" ")) Q
EXDL X $S(F["0*":"D EXDF",1:"S @ZAA02GG@(%R,%C)=F D:WR EXDS") Q
EXDF S @ZAA02GG@(.2,%R,%C)=$P(F,"`",3),$P(^ZAA02GDISPL("~",$I,0,$P($P(F,"`",3),"\",2)),"`",3)=%R_","_%C W:'$d(qt) VIDOF S V=WR=0*%R F %R=%R+$S($P(F,"\",3):$P(F,"\",3)-1,1:0):-1:%R W:V'=%R @ZAA02GP,$P(F,"`") S @ZAA02GG@(%R,%C)=F
 Q
EXDJ S V=$O(@ZAA02GG@(%R,0)) F J=%C-1:0 Q:'$O(^(J))  S J=$O(^(J))
 S:$D(^(J)) V=J+$L($P(^(J),"`")) Q
EXE ; DEL CHAR
 Q:$O(@ZAA02GG@(%R,%C-1))=""  S WR=1 I ZAA02G("DL")'=""  S WR=0 W:'$d(qt) ZAA02G("DL")
 S J=%C F %C=%C:0 S I=%C,%C=$O(@ZAA02GG@(%R,%C)) X:%C-1'=I "K @ZAA02GG@(.2,%R,I),@ZAA02GG@(%R,I) W:WR VIDOF,"" """ Q:%C=""  S F=^(%C),%C=%C-1 X $S(F["0*":"D EXDF",1:"S ^(%C)=F D:WR EXDS") S %C=%C+1
 S %C=J G EXDX
EXDX W:'$d(qt) VIDON,ZAA02G("G0") Q
EXI W:'$d(qt) "EXI" Q
EXJ W:'$d(qt) "EXJ" Q
EXK G EXK^ZAA02GFRME3B
RUBOUT Q:%C=CS  D 7 W:'$d(qt) @ZAA02GP
 S Z=" " D CHAR
 G 7
