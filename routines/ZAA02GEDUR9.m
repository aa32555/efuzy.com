%ZAA02GEDUR9 ;;%AA UTILS;1.24;UTIL: PRINT RELEASE REPORT;16MAY91  11:51
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
        N (ZAA02G,ZAA02GP,ZAA02GX,ZAA02GY,TID,d,ci,bl,ct,gl,lm,rm,rt,sr,tl,SF,agl,pgl,sgl,ugl,tCL,tHI,tLO,pBL,PKG,PV)
DEV D ^ZAA02GEDDV G:'$D(DEV) EXIT
SRC S PKR=@pgl@(PKG,PV),PX=PV S:$P(PKR,"`",4)="" PX=PX_"p" S SRC=PKG_" v"_PX,CPL=0 I $D(@pgl@(PKG,PV,0)) S CPL=$P(^(0),"`",2)
        S TYP=4,GS="^ZAA02GEDSEL($J)",GFI=pgl_"(PKG,PV,1)",TYP=4,(DTC,CNT,SIZ,X)="" K @GS D LOAD^ZAA02GEDRL1,CHCK,PRINT
EXIT U 0 I $D(DEV),DEV'=0 C DEV
        I $D(GS),GS]"",$D(@GS) K @GS
        Q
CHCK S LV=$P(PKR,"`",5) I LV="",$P(PKR,"`",4)="" S LV=$P(@pgl@(PKG),"`",4)
        Q:LV=""  Q:$D(@pgl@(PKG,LV))=0  U 0 S %R=bl+2,%C=lm-1 W @ZAA02GP,tLO,"Comparing "_tHI_SRC_tLO_" to last version "_tCL
        S R="" F I=0:0 S R=$O(@pgl@(PKG,LV,1,R)) Q:R=""  S V=$P(^(R),"`",2) I '$D(@GS@(R)),$D(@agl@(R,V)) S Z="-1`"_V_"`"_^(V),@GS@(R)=Z
        Q
PRINT U 0 S %R=bl+2,%C=lm-1 W @ZAA02GP,tLO,"Printing "_tHI_"Release Report"_tLO_" for "_tHI_SRC_tLO_tCL
        U DEV S LN=99,(PG,TB,TL,TR,R)="" F I=0:0 S R=$O(@GS@(R)) Q:R=""  S X=^(R) D ONE
        S LN=LN+1 D:LN>ULP TRAIL,HDR W !?LM,"---------------------  -----  ------"
        S LN=LN+1 D:LN>ULP TRAIL,HDR W !?LM,"Total routines: ",TR,$J(TL,12-$L(TR)),$J(TR*CPL+TB,8)
        D TRAIL U 0 Q
ONE S ST=$P(X,"`"),RV=$P(X,"`",2),DE=$E($P(X,"`",3),0,RM-LM-56),NL=$P(X,"`",4),NB=$P(X,"`",5),MD=$P($P(X,"`",6),"\",2)
        I ST="" S ST=$S(RV=1:2,1:"") I LV]"",$D(@pgl@(PKG,LV,1,R)) S ST=$S($P(^(R),"`",2)=RV:0,1:1)
        S:ST'<0 TB=TB+NB,TL=TL+NL,TR=TR+1 S LN=LN+1 D:LN>ULP TRAIL,HDR W !?LM,R,$J(RV,12-$L(R)),"  " I ST="" W "Unknown"
        E  W $P("Deleted;       ;Changed;New    ",";",ST+2)
        W $J(NL,7),$J(NB+CPL,8),$J(MD,17),"  ",DE Q
TRAIL I PG S Z="",$P(Z,$C(13,10),ULP+3-LN)="" U DEV W Z,!!,?LM,"AA UTILS "_SW_"  Copyright (C) 1990 PG&A",?RM-$L(PG)-5,"Page "_PG,# S LN=0
        Q
HDR W !,?LM,SITE,?(RM-$L(PDT)-8),"Printed "_PDT
        W !,?LM,"Release Report",?RM-$L(SRC)-9,"Package: ",SRC
        W !,?LM,$TR($J("",W)," ","=")
        W !,?LM,"Routine  Ver  Status   Lines   Bytes  Last Modified    Description",!?LM,$TR($J("",W)," ","=") S PG=PG+1,LN=5 Q
        ;
