ZAA02GSCRTR1 ;PG&A,ZAA02G-SCRIPT,2.10,SELECT A TRANSCRIPT;31OCT94  13:32;;;Mon, 07 DeC 2009  10:13
 ;Copyright (C) 1992, Patterson, Gray & Associates, Inc.
6 S %R=TOP+1,%C=1 W @ZAA02GP,ZAA02G("CS"),ZAA02G("HI") S SM=$TR(MM,"- ","_`") S:'$D(OC) M=SM
 D:$D(SETM) SETM
 W $TR(M,"`"," ") S %C=$S($D(OC):OC,1:$L($P(SM,"`"))+2),u="ABCDEFGHIJKLMNOPQRSTUVWXYZ",l="abcdefghijklmnopqrstuvwxyz"
F1 W @ZAA02GP R C#1 I C'="" S C=$TR(C,l_" ",u_"_"),F="",M=$E(M,1,%C-1)_C_$E(M,%C+1,255) W C S D=0 G F4
 X ZAA02G("T") S F=$E(XX,$F(XX,ZF)),D="D"=F*-2 G F2:F="E",F3:F="F",F4:"CD"[F,F6:F="A",F8:F="B" I F=9 S D=0,%C=$F(SM_"`","`",%C)-1 S:%C>$L(SM) %C=0 G F4
 I "RH"[F S:F="R" %C=%C-1 G:$E(SM,%C)'="_" F4 S D=$F($TR(SM,":/","``"),"`",%C) S:'D D=255 S M=$E(M,1,%C-1)_$E(M,%C+1,D-2)_"_"_$E(M,D-1,255) W @ZAA02GP,$E(M,%C,D-2)
 G F1
F4 S %C=%C+D#$L(SM)+1 G:$E(SM,%C)'="_" F4
 G F1
F2 K OC,FP,EP,OFP,ME G:$D(SETM) E^ZAA02GSCRTR S:$D(OSRC) SRC=OSRC,E=OE K OSRC,OE
 G R5^ZAA02GSCRTR
F3 D:$D(SETM) SETM I SRC'["ZAA02GSCM"+1 S:'$D(OSRC) OSRC=SRC,OE=E S OC=0,(E,FP,SRC)=""
 ;  E  S:$D(OSRC) SRC=OSRC,E=OE S OC=0,ME=E_" ",E="" S:$G(OSRC)="" OSRC=SRC,OE=ME
 I +M S EP="z",FP=+M,SRC="@ZAA02GSCR@(""TRANS"",FP)",OC=1,E="S I="""",II=10000000-"_FP_",SRC=""@ZAA02GSCR@(""""DIR"""",99)"" I $D(@SRC@(II))" D:0 ARCHT^ZAA02GSCRAT G F7
 F J=1,2,3,4,5,8,6,7,11,9,12,13 I $P(M,"`",J)'=$P(SM,"`",J) S K=$P(",2,3,4,5,6,6,7,,,,11",",",J) D
 . S C=$TR($P(M,"`",J),l_",.: ",u)
 . ; I J=8,C?2N1P2N1P2N S A=$P(C,"/",3)_$P(C,"/")_$P(C,"/",2) I $D(@ZAA02GSCR@("DIR",98,A))  S SRC="@ZAA02GSCR@(""DIR"",99,FP)",EP=^(A),FP=0,A=$O(@ZAA02GSCR@("DIR",98,A)) S:A'="" FP=^(A) S EP=10000000-EP,FP=10000000-FP needs work
 . S:'OC OC=$L($P(M,"`",1,J-1))+2 I SRC="",K,$E(C)'="_" S SRC="@ZAA02GSCR@(""DIR"","_K_",FP)",FP=$P(C,"_"),EP=FP_"z",I=$L(FP),$P(C,"_")=$E("________________",1,I),FP=$E(FP,1,I-1)_$C($A(FP,I)-1,126) Q:C?."_"
 . S:'K K=J I C["[" S E=E_"$P(A,""`"","_K_")["""_$TR(C,"_:/[","")_"""," Q
 . F A=1:1:$L(C,"_") I ":/"'[$P(C,"_",A) S E=E_"$E($P(A,""`"","_K_"),"_$S(A>1:$L($P(C,"_",1,A-1)_11),1:1)_","_$L($P(C,"_",1,A))_")="""_$P(C,"_",A)_""","
 I SRC="" K FP,EP G F2:E="" S SRC="@ZAA02GSCR@(""DIR"",99)"
 S:E]"" E="S A=$TR($G(@ZAA02GSCR@(""DIR"",99,II)),""abcdefghijklmnopqrstuvwxyz"",""ABCDEFGHIJKLMNOPQRSTUVWXYZ"") I "_$E(E,1,$L(E)-1)_" " X:$D(XE) XE S:E="" E="I 1" I $D(FP)=0,E'="I 1" S FP="",EP="zzzzz"
 I $G(OSRC)["ZAA02GSCM" S E=E_" I $D(@OSRC@(10000000-I))"
F7 W ZAA02G("ROF") I $D(TESTF) S %R=23,%C=1 W @ZAA02GP,SRC,"  ",$G(FP),"  ",$G(EP),"  ",$G(E) R C
 S:$D(FP) OFP=FP_$C(1)_SRC_$C(1)_EP_$C(1)_E_$C(1)_M_$C(1)_OC G R5^ZAA02GSCRTR
F6 S %C=1 G F1
F8 S %C=$L(SM) G F1
SETM S $P(M,"`",+SETM)=$E($P(SETM,",",2)_"______________",1,$L($P(M,"`",+SETM))) Q
 ;
AX S F=OF*IA(J)+OF1,D=^(II) W @ZAA02GP,ZAA02G("RON"),$TR($P(D,"`",1,3),"`~","  "),ZAA02G("ROF")," ",ZAA02G("CL"),ZAA02G("RON"),"REPORT: "
 I $D(@ZAA02GSCR@("TRANS",F,.011))#2=0,$D(@SDIR@(0))'=3 W ZAA02G("ROF") Q
 S D=$P(^(.011),"`",3,4) S:$P(ZAA02GSCRP,";",3)=1 D=$P(^(.011),"`",9) S C=$S($P(D,"`")="":"",$D(@ZAA02GSCR@(106,$P(D,"`")))#2:^($P(D,"`")),1:""),X=$S($P(D,"`",2)="":"",$D(@ZAA02GSCR@(106,$P(D,"`",2)))#2:^($P(D,"`",2)),1:""),F=$S(C]""+(X]"")=2:20,1:40)
 W:C]"" $E(C,1,F),ZAA02G("ROF")," ",ZAA02G("RON") W:X]"" $E(X,1,F)
 S X=$D(@SDIR@(0)) W ZAA02G("ROF") Q
AZ S F=OF*IA(J)+OF1,D=^(II) W @ZAA02GP,ZAA02G("RON"),$TR($P(D,"`",1,3),"`~","  ")
 S D=$$AZX($G(@ZAA02GSCR@("TRANS",F,.011,"IO")),"P") I $D(@SDIR@(0))'=3
 S:D="" D="(NOT PRINTED)"
 W:$L(D)>30 @ZAA02GP W ZAA02G("ROF")," ",ZAA02G("CL"),ZAA02G("RON"),"PRINTED: ",$E(D,1,67),ZAA02G("ROF") K D Q
AZX(D,T) I D'[T Q ""
 F F=2:1:$L(D,",") S X=$P(D,",",F) I X[T S X=$TR(X,T,""),D(-X,+$P(X,":",2))=$G(D(-X,+$P(X,":",2)))+1
 S (D,X,F)="" F  S X=$O(D(X)) Q:X=""  S D=D_$$DT(-X)_" " F  S F=$O(D(X,F)) Q:F=""  S D=D_$$DTX(F)_$S(D(X,F)>1:"("_D(X,F)_") ",1:"") Q:$L(D)>70
 Q D
AF S F=OF*IA(J)+OF1,D=^(II) W @ZAA02GP,ZAA02G("RON"),$TR($P(D,"`",1,3),"`~","  ")
 S D=$$AZX($G(@ZAA02GSCR@("TRANS",F,.011,"IO")),"F") I $D(@SDIR@(0))'=3
 S:D="" D="(NOT FAXED)"
 W ZAA02G("ROF")," ",ZAA02G("CL"),ZAA02G("RON"),"FAXED: ",D
 K D W ZAA02G("ROF") Q
AU N LF,WF,L S F=OF*IA(J)+OF1,D=^(II) W @ZAA02GP,ZAA02G("RON"),$TR($P(D,"`",1,3),"`~","  "),ZAA02G("ROF")," ",ZAA02G("CL"),ZAA02G("RON"),"LN: "
 S LF="LL="_$P(@ZAA02GSCR@("PARAM","BASIC"),"|",4),WF="CC="_$P(^("BASIC"),"|",2)
 K D S D=$G(@ZAA02GSCR@("TRANS",F,.011,"STATS")) I $D(@SDIR@(0))'=3,'D W "(NOT COMPUTED UNTIL PRINTED)",ZAA02G("ROF") Q
 S R=1,C=+D,L=$P(D,",",2),W=$P(D,",",3),B=$P(D,",",4),S=$P(D,",",5),@LF,@WF,T=$P(D,",",7) W $E(LL_"     ",1,4),"CHARS: ",$E(CC_"      ",1,6),"MIN: ",$E($J(T*.1,0,1)_"     ",1,5)," LN/HR: ",$E($J(LL/(T+.01)*600,0,0)_"    ",1,4)
 K D,W,B,S,T W ZAA02G("ROF") Q
AE S F=OF*IA(J)+OF1,D=^(II) W @ZAA02GP,ZAA02G("RON"),$TR($P(D,"`",1,3),"`~","  "),ZAA02G("ROF")," ",ZAA02G("CL"),ZAA02G("RON"),"EDIT HISTORY: "
 K D S D=$G(@ZAA02GSCR@("TRANS",F,.011,"eD")) S:D="" D=$G(^("LOCKED"))
 I $D(@SDIR@(0))'=3,D="" W "(no information)",ZAA02G("ROF") Q
 W $P(D,","),$S(D["TO":"",1:"UM="),$P(D,",",2) I $P(D,",",3)'="" W " - ",$$DTXY($P(D,",",3,4))
 K D W ZAA02G("ROF") Q
AS S F=OF*IA(J)+OF1,D=^(II) W @ZAA02GP,ZAA02G("RON"),$TR($P(D,"`",1,3),"`~","  "),ZAA02G("ROF")," ",ZAA02G("CL"),ZAA02G("RON"),"ES: "
 K D S D=$G(@ZAA02GSCR@("TRANS",F,.011,"eS")) I $D(@SDIR@(0))'=3,D="" W "(no information)",ZAA02G("ROF") Q
 S X=$$ASI($P(D,"\",2))_" "_$$ASI($P(D,"\",3))
 I $D(@SDIR@(0))'=3 W X,ZAA02G("ROF") K F,D Q
ASI(x) I $P($G(ZAA02GSCRP),";",3)=1 Q $S(x="":"",$D(^VA(200,+x,0)):$P(^(0),","),1:"??")_" "_$S(x="":"",x'["*":"(none)",1:$$DT($P(x,"*",2)))
 I 24[$P($G(ZAA02GSCRP),";",3) Q $S(x="":"",$D(@ZAA02GSCR@("PROV",$P(x,"*"))):$P(^($P(x,"*")),"\",3),1:"??")_" "_$S(x="":"",x'["*":"(none)",1:$$DTXY($TR($P(x,"*",2),"-",",")))
 Q "not available"
DT(x) I x<1 Q "(queued)"
 N D S K=x>21608+305+x,y=4*K+3\1461,D=K*4+3-(1461*y)+4\4,m=5*D-3\153,D=5*D-3-(153*m)+5\5,m=m+2,y=m\12+y+140,m=m#12+1,D=y*100+m*100+D,K=$E(D,4,5)_"/"_$E(D,6,7)_"/"_$E(D,2,3) K x,m,y Q K
DTX(x) Q $S(x=0:"",1:x\3600_":"_$E(x#3600\60+100,2,3)_" ")
DTXY(x) Q $$DT(x)_" "_$$DTX(+$P(x,",",2))
