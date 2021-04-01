ZAA02GFRME1 ;PG&A,ZAA02G-FORM,2.62,FORMS EDITOR, PART 2 ;12OCT94 1:21P;;;06MAY2004  15:35
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
BUILD S DC="~",GR=SCR_"-"_SN,scope=GR,ZAA02GS="^ZAA02GDISPL",ZAA02GG="^ZAA02GDISPL(""~"",$I,scope)"
 I $D(^ZAA02GDISPL("~",$I)) D CONTIN G:'$D(SCR) EXIT
 I '$D(ACOMPILE) D ^ZAA02GFRME4 G:'$D(ST) EXIT
 D ^ZAA02GFRME8,CYN G:A'="Y" WEXIT
 S $P(^ZAA02GDISP(SCR,SN),"`",3)=GR,A="" F I=1:1 S A=$O(^ZAA02GDISPL("~",$I,0,A)) Q:A=""  S B=^(A),C=^(A,0),^ZAA02GDISP(SCR,SN,A)=B,$P(^(A),"`",11)=A,^(A,0)=C
 D ^ZAA02GFRME1A D WINDO,^ZAA02GFRME7 K ^ZAA02GDISPL("~",$I) I $O(^ZAA02GDISP(SCR,SN,">~"))]"" D COMPILE
 G WEXIT
 ;
CONTIN I $S($D(^ZAA02GDISPL("~",$I))#10=0:1,1:^($I)'=GR) K ^($I) Q
 W:'$d(qt) !!
 W:'$d(qt) GR," is currently in the scratch work space.",!
CC W:'$d(qt) *13,"Do you want to continue with it?  (Y or N) " R a#1 I "YyNn"'[a W:'$d(qt) *7 G CC
 I "Nn"[a K ^ZAA02GDISPL("~",$I)
 Q
 ;
EDIT D ^ZAA02GFRME4 G:'$D(ST) EXIT Q:$O(^ZAA02GDISP(SCR,SN,">~"))=""
ED1 K ST D EDIT^ZAA02GFRME2,CYN G:A'="Y" WEXIT
ED2 I '$d(qt) D
 . W ZAA02G("F") I $P(^ZAA02GDISP(SCR,SN),"`",5)="Y" X $P(^ZAA02G(.1,ZAA02G,7),"\") S wide=1
 . I $D(^ZAA02GDISPL(SCR_"-"_SN,0,ZAA02G,0)) F %R=1:1:22 W:$D(^(%R)) ^(%R),^(%R+.1)
 . E  I $D(^ZAA02GDISPL(SCR_"-"_SN,0,ZAA02G,1)) F I=1:1 Q:$D(^(I))=0  W ^(I)
 D ^ZAA02GFRME1A,WINDO,COMPILE
 G WEXIT
 ;
WINDO F WI=0:1:9 K ^ZAA02GDISP(SCR,SN,+(.05_WI))
 S WI="" F I=1:1 Q:$D(^ZAA02GDISP(SCR,SN,I))=0  I $P(^(I),"`",23)]"" S WI=WI_I_","
 S:WI="" WI=1 ; WI=$P(^ZAA02GDISP(SCR,SN),"`",13)
 I WI]"" S WI=WI_"\",I=$D(^ZAA02GDISP(SCR,SN,0)) F I=.9:0 S I=$O(^(I)) Q:I>99!('I)  I $P(^(I),"`",11)'[">" D W1
 S ^ZAA02GDISP(SCR,SN,.05)=WI Q
 ;
W1 S A=$P(^(I),"`",3),B=$P(^(I),"`",21) S:B="" $P(WI,"\",A+1)=$P(WI,"\",A+1)_I_","
 I B]"" F ls=1:1:$P(B,",",2) S $P(WI,"\",A+ls)=$P(WI,"\",A+ls)_I_"."_ls_","
 Q
 ;
COMPILE S %R=23,%C=1 W:'$d(qt) @ZAA02GP,"Compiling Field Data...",ZAA02G("CS"),! S xx=$P(^ZAA02GDISP(SCR,SN),"`",14)_" "
 S xx=$S("Yy"[$E(xx):"^ZAA02GF(JJ,",1:"b(") I xx["^",$O(^ZAA02GDISP(SCR,SN,">"))[">" S xx=xx_"0,"
 K rgl S:"Yy"[$E($P(^ZAA02GDISP(SCR,SN),"`",7)_" ") rgl=""
 K A,G,F S (bi,ni)=0,DF=$P(^ZAA02GDISP(SCR,SN),"`",13),(F,G)=1,(GG,FF)=""
 S A="" F J=1:1 S A=$O(^ZAA02GDISP(SCR,SN,A)) Q:A>.019  K ^(A)
 D SCAN^ZAA02GFRME1B,^ZAA02GFRME1F:$D(nv)>1
 K A,B,C,D,F,F0,FF,G,G0,G1,GF,GF0,GF1,GG,GGFF,Y,L,WI,EE,T,TY,TYP,JJ,b,bi,g,gi,gn,gx,nv,nvc
 S b=.01997 F a=15,16,17 S ^ZAA02GDISP(SCR,SN,b)=$P(^ZAA02GDISP(SCR,SN),"`",a),b=b+.00001
 S:'$D(^ZAA02GDISP(SCR,SN,0)) ^(0)=";" S:'$D(^(.01)) ^(.01)=";"
 S ^ZAA02GDISP(SCR,SN,.01999)=$S(^ZAA02GDISP(SCR,SN,.01999)]"":"X ^(.01) "_^(.01999),1:^(.01))
 D ^ZAA02GFRME1E,DITTO,ERASE^ZAA02GFRME1F K ^ZAA02GSCHEMA(1,SCR_"-"_SN)
 ; I $P(^ZAA02GDISP(SCR,SN),"`",18)]"" D ^ZAA02GFRMEC
 I ^ZAA02G("OS")="DTM" D DTM
 K xx Q
 ;
DITTO S I=$D(^ZAA02GDISP(SCR,SN,1))
 F I=.999:0 S I=$O(^ZAA02GDISP(SCR,SN,I)) Q:'I  I $P(^(I),"`",11)'[">",$P(^(I),"`",8)]"" S A=$P(^(I),"`",8) I 'A D DC
 Q
 ;
DC I $D(^(A)) S B=$P(^(A),"`",14),$P(^(I),"`",8)=B Q
 W:'$d(qt) !,ZAA02G("Z"),"Field ",ZAA02G("HI"),$P(^(I),"`",11),ZAA02G("Z")," dittos to non-existent field ",ZAA02G("HI"),A,ZAA02G("Z"),".  Press RETURN" R *A Q
 Q
 ;
DTM Q  S a="" F b=0:0 S a=$O(^ZAA02GDISP(SCR,SN,a)) Q:a'<.02  I ^(a)]"" S ^(a)=$ZXECUTE(^(a))
 F I=.9:0 S I=$O(^ZAA02GDISP(SCR,SN,I)) Q:'I  D DTMFD
 Q
 ;
DTMFD I I["." S:^(I)'["$A" $P(^(I),"`")=$ZXECUTE($P(^(I),"`")) Q
 S $P(^(I+.2),"`",1)=$ZXECUTE($P(^(I+.2),"`"))
 I $P(^(I),"`",11)'[">" F a=2,15,16,17 S $P(^(I),"`",a)=$ZXECUTE($P(^(I),"`",a))
 S I=I+.1 I $D(^(I)) F a=3 S $P(^(I),"`",a)=$ZXECUTE($P(^(I),"`",a))
 S I=I+.5 Q
 ;
ACOMPILE S Y="45,15\HRL\1\Recompile Options\\*,Complete (Including Graphics),Logic Only",Y(0)="\EX",xt="" D UTIL^ZAA02GFORM4 Q:X=""  Q:X[";EX"  S ACOMPILE=$S(X=2:"BUILD",1:"ED2")
 S:SN SN=SN-1 S:SCR="" SCR=99
 F i=0:0 S:SN="" SCR=$O(^ZAA02GDISP(SCR)) Q:SCR=""  F i=0:0 S SN=$O(^ZAA02GDISP(SCR,SN)) Q:SN=""  D AC
 K ACOMPILE Q
 ;
AC K (qt,ACOMPILE,SCR,SN,ZAA02G,ZAA02GP,ZAA02GID,ZID,i),^ZAA02GDISPL("~",$I) D @ACOMPILE S i=0 Q
 ;
CYN S A="Y" Q:$D(ACOMPILE)  S %R=23,%C=1 W:'$d(qt) @ZAA02GP,ZAA02G("LO"),"Do you want to",ZAA02G("HI")," SAVE & COMPILE ",ZAA02G("LO"),"the changes (",ZAA02G("HI"),"Y",ZAA02G("LO")," or ",ZAA02G("HI"),"N",ZAA02G("LO"),") - ",ZAA02G("CS") R A#1 S:A?1L A=$C($A(A)-32) I A'="Y" G CYN:A'="N"
 Q
WEXIT I '$d(qt) X:$D(wide) $P(^ZAA02G(.1,ZAA02G,7),"\",2)
EXIT K A,a,COL,ESC,II,NB,NE,NV,ROW,SC,SR,scope,wide Q
 Q
