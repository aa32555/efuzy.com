%ZAA02GEDG0 ;;%AA UTILS;1.24;UTIL: PRINT GLOBAL LISTING;30MAY91  18:16
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
        N (ZAA02G,ZAA02GP,ZAA02GX,ZAA02GY,TID,d,ci,bl,bs,ct,gl,lm,rm,rt,sr,tl,ts,SF,tCL,eHI,eLO,tHI,tLO,pBL,ugl,sgl) S (r,fs)=""
GLO W pBL_tLO_"List Global: ^"_tHI_tCL S X=$S($D(@ugl@(TID,"GREF")):^("GREF"),1:"")
        S %R=bl+2,%C=lm+13,Y="RON\ROF\PU,PD,HL,EX\\40\\\\\\\\1" D ^ZAA02GEDRS I ZAA02GF="HL" S HN=2330 D ^ZAA02GEDH,RESTORE^ZAA02GED08(+REFRESH,$P(REFRESH,":",2)) G GLO
        Q:X=""!(ZAA02GF="EX")  D ^ZAA02GEDGL
        I E S E=$P("Global name error;Global does not exist;Unmatched quotation marks",";",E),%C=rm-$L(E) W @ZAA02GP,tHI_E H 3 G GLO
        S @ugl@(TID,"GREF")=X
DEV D ^ZAA02GEDDV G:'$D(DEV) EXIT S:DEV=0 SF=1
        I DEV'=0 U 0 S %R=bl+2,%C=lm-1 W @ZAA02GP,tLO,"Printing global "_tHI_GN_tCL
        K SB S LN=99,(CS,PG,END)="" F I=0:1:31,127:1:255 S CS=CS_$C(I)
        U DEV W:DEV=0 ZAA02G("F") F I=0:0 D FETCH,PRINT:'END Q:END  I ZAA02GF U 0 G EXIT
DONE D TRAIL U 0
EXIT I $D(DEV),DEV'=0 C DEV
        Q
FETCH I '$D(SB) S SB=0 I $D(@GN)#2 S RF=GN,V=@RF Q
        G NLV:'SB I SB(SB)]"",SB'>MX,$D(@G@(SB(SB)))\10 G NLV
ORD S (sb,SB(SB))=$O(@G@(SB(SB))) G:sb="" PLV
        I $D(ES(SB)),ES(SB)=+ES(SB) G PLV:sb'=+sb,PLV:sb>ES(SB),OR1
        I $D(ES(SB)),ES(SB)]"",sb]ES(SB) G PLV
OR1 I $D(^(sb))#2 D GETREF Q
NLV G:SB'<MX ORD S G=$S('SB:GN,SB=1:GN_"(",1:$E(G,1,$L(G)-1)_",") S:SB G=G_$S(+SB(SB)=SB(SB):SB(SB),1:""""_SB(SB)_"""")_")"
        S SB=SB+1,SB(SB)=$S($D(BS(SB)):BS(SB),1:"") G:SB(SB)="" ORD S DD=$D(@G@(SB(SB))) I DD#2 D GETREF Q
        G NLV
PLV S SB=SB-1 I 'SB S END=1 Q
        S G=$S(SB<2:GN,1:GN_"(") F I=1:1:SB-1 S G=G_$S(+SB(I)=SB(I):SB(I),1:""""_SB(I)_"""")_","
        S G=$S(SB=1:GN,1:$E(G,1,$L(G)-1)_")") G ORD
GETREF S RF=GN_$S('SB:"",SB=1:"(",1:$E(G,$L(GN)+1,$L(G)-1)_",") S:SB RF=RF_$S(+SB(SB)=SB(SB):SB(SB),1:""""_SB(SB)_"""")_")" S V=@(RF) Q
PRINT S REF=RF_$J("",25-$L(RF))_" """,L=$L(REF) S:L<26 L=26 S X="" G:V="" PR2
PR1 D PRF I X="" W """" Q
PR2 S LN=LN+1,ZAA02GF=0 D:LN'<ULP TRAIL,HDR Q:ZAA02GF  W !,?LM,REF,?LM+26,X S L=26,REF="" G PR1
PRF S D=W-L-1 I $TR(V,CS,"")="" S X=$E(V,1,D),V=$E(V,D+1,$L(V)) Q
        S M=$TR(V,CS,""),M=$TR(V,M,$J("",$L(M))),M=$TR(M,CS,$TR($J("",$L(CS))," ","X")),(F,T,X)="" F i=0:0 S F=$F(M,"X",F) Q:'F!(F>D)  S X=X_$E(V,T,F-2)_"<"_$A(V,F-1)_">",T=F
        S V=$E(V,T,$L(V)) I $L(X)>D S V=$E(X,D+1,$L(X))_V,X=$E(X,1,D)
        E  I $L(X)<D,V]"" S T=$L(X),X=X_$E(V,1,D-T),V=$E(V,D-T+1,$L(V))
        K M Q
TRAIL I 'PG S PG=1 Q
        I DEV=0 D PAUSE Q:ZAA02GF  W ZAA02G("F"),! S PG=PG+1 Q
        S Z="",$P(Z,$C(13,10),ULP+3-LN)="",LN=0 U DEV W Z,!!,?LM,"AA UTILS "_SW_" Copyright (C) 1990 PG&A",?RM-$L(PG)-4,"Page "_PG,# S PG=PG+1 K Z Q
HDR Q:ZAA02GF  U DEV W !,?LM,SITE,?(RM-$L(PDT)-8),"Printed "_PDT,!,?(RM-LM-$L(GR)-9\2+LM),"  Global: "_GR,!,?LM,$TR($J("",W)," ","=") S LN=3 Q
PAUSE S ZAA02GF=0,%R=24,%C=RM+(W>RM*52)-39\2 W !,@ZAA02GP,tLO_"Press "_tHI_"ANY KEY "_tLO_"to continue, "_tHI_"EXIT ",tLO_"to quit"_tHI
        R z#1 Q:z]""  X ZAA02G("T") S ZAA02GF=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2),ZAA02GF=ZAA02GF="EX" Q
        ;
