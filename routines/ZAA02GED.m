%ZAA02GED ;;07NOV96  15:17;1.24;STARTUP;19JUL91  18:42
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
        N (ZAA02G,ZAA02GP,ZAA02GX,ZAA02GY,TID,ZAA02GERR) D FUNC^ZAA02GEDDI S tHI=ZAA02G("HI"),tLO=ZAA02G("LO"),tCL=ZAA02G("CL"),sr=$S(ZAA02G("SR")="":0,1:1)
        D FILES I sgl="" D ^ZAA02GEDIN,FILES Q:sgl=""
        W ZAA02G("Z"),ZAA02G("F") X ZAA02G("TON"),ZAA02G("WOF")
DSPL D:'$D(TID) USER G:'$D(TID) EXIT D SETUP,NP^ZAA02GED00  G:rt="" POP
EDIT W ROU I rt]"" W VERS,MODE S x=$D(@gl@(0)),%R=tl,%C=bl W:sr @ZAA02G("SR") W eLO D @$S('$D(im):"PO^ZAA02GED00",'im:"PO^ZAA02GED00",ZAA02G("ION")="":"PO^ZAA02GED22",1:"BG^ZAA02GED11") W:sr @ZAA02G("CSR") D SAVE,CHCK
POP W ROU,pBL_tLO_tCL D MENU G E:ZAA02GF="UK",EXIT:ZAA02GF="EX",@X
E G EDIT
S D SAVE,SAVE^ZAA02GEDS0,ROUT G POP
L D:cx ASK^ZAA02GEDS0 G:ZAA02GF="EX" POP D ^ZAA02GEDL1 G POP:ZAA02GF="EX" D ROUT G EDIT
C G:rt="" POP D ONE^ZAA02GEDR0 I $G(ZSR) D SETUP D:$D(ZSR(1)) TAG^ZAA02GEDR0 D NP^ZAA02GED00 K ZSR
        G POP
N D:cx ASK^ZAA02GEDS0 G POP:ZAA02GF="EX",NEW^ZAA02GED01
U D ^ZAA02GEDU0 G POP
O D ^ZAA02GEDOP G POP
Q G EXIT
c D:rt]"" ONE^ZAA02GEDR0 G EXIT
q D:cx ASK^ZAA02GEDR0 G EXIT
MENU S Y=(lm-1)_","_(bl+2)_"\H\UK,HL,SE,EX\Function:\\" I $E(TID,1,2)'="T-" S Y=Y_"QUIT,EDIT,SAVE,LOAD,COMPILE,NEW,UTILITIES,OPTIONS",YY="QESLCNUO" G MEN
        S Y=Y_"EDIT",YY="E" S:cx Y=Y_",COMPILE & QUIT",YY=YY_"c" S Y=Y_",OPTIONS,QUIT",YY=YY_"Oq"
MEN D ^ZAA02GEDPL G:ZAA02GF="SE" SE I ZAA02GF="HL" S HN=1 D ^ZAA02GEDH,RESTORE^ZAA02GED08(+REFRESH,$P(REFRESH,":",2)) G MENU
        S X=$E(YY,X) K YY Q
FILES S sgl=$S($D(^ZAA02GED)#2:"^ZAA02GED",$D(^ZAA02GED)#2:"^ZAA02GED",1:"") Q:sgl=""  S X=$P(@sgl,";",2),gl=$P(X,"`")_"(TID)",ugl=$P(X,"`",2),wgl=$P(X,"`",3),lgl=$P(X,"`",4),agl=$P(X,"`",5),pgl=$P(X,"`",6),rgl=$S($P(X,"`",8):$P(X,"`",7),1:"") Q
SETUP S ZAA02G("M")=$S($D(@ugl@(TID,"MENU")):^("MENU"),1:0) K im I $D(@ugl@(TID,"MODE")) S im=^("MODE")
        S:$D(@ugl@(TID))#2=0 @ugl@(TID)="2`79`10,20,30,40,50,60,70,80,90,100,110,120`12`3`22`0" S x=^(TID),lm=$P(x,"`"),rm=$P(x,"`",2),tb=$P(x,"`",3),ct=$P(x,"`",4),tl=$P(x,"`",5),bl=$P(x,"`",6),dx=$P(x,"`",7)
        S:$D(@gl)#2=0 @gl="`"_tl_"`"_lm_"`0`0`" S x=@gl,rt=$P(x,"`"),r=$P(x,"`",2),c=$P(x,"`",3),bs=$P(x,"`",4),cx=$P(x,"`",5),sz=$P(x,"`",6),dt=$P(x,"`",7)
        S d=$C(1),ci="/",fs="",eHI=$S(dx:tHI,1:tLO),eLO=$S(dx:tLO,1:tHI) K tbx F i=1:1:$L(tb,",") S t=$P(tb,",",i) I t,t<130 S tbx(t)=""
        S:r>bl r=tl S:ZAA02G(132)="" rm=79 X $S(rm>79:ZAA02G(132),1:ZAA02G(80)) S %R=bl+2,%C=lm-1,@("pBL="_ZAA02GP) D ROUT,VERS,MODE W ROU
        S %R=tl-1,%C=lm-1,Z="",$P(Z,ZAA02G("HL"),rm-lm+2)="" W @ZAA02GP,tLO_ZAA02G("G1")_ZAA02G("TLC")_Z_ZAA02G("TRC")
        S %R=bl+1,%C=lm-1 W @ZAA02GP,ZAA02G("BLC"),Z,ZAA02G("BRC")
        F %R=tl-1,bl+1 S t="" F i=0:0 S t=$O(tbx(t)) Q:t=""!(t>rm)  S %C=lm+t-1 W @ZAA02GP,$S(%R<tl:ZAA02G("TI"),1:ZAA02G("BI"))
        W ZAA02G("G0"),pBL,tCL S:c>rm c=rm K i,t,x,X,Y,Z Q
USER
        ; S AAAAAA=0 I $D(@sgl@(AAAAAA,"USER")),$I'=@sgl@(AAAAAA,"USER") Q
        ; I '$D(@ZAA02G("G")@("$I")) S TID=$I Q
         S %R=24,%C=1 W @ZAA02GP,tLO_"User's ID:" S %C=12,Y="RON\ROF\EX\\10",X=$S($D(TID):TID,1:"") S TID=1 ;D ^ZAA02GEDRS Q:X=""!(ZAA02GF="EX")  S TID=X Q
ROUT Q  S rt=2 S %R=tl-2,%C=lm-1,@("P="_ZAA02GP),ROU=P_tLO_"Routine: "_tHI_rt_tCL,%C=rm-40,@("P="_ZAA02GP),ROU=ROU_P_tLO_"Last saved: "_tHI_dt_tLO_$J("",19-$L(dt))_"Size: "_tHI_sz_tLO
        K D,P Q
VERS S %R=bl+2,%C=lm-1,@("P="_ZAA02GP) I '$D(ZAA02GERR) S VERS=P_tLO_" AA UTILS 1.21 (C) 1990 PG&A" K P Q
        S VERS=P_tLO_" ERROR: "_tHI_$E(ZAA02GERR,1,rm-lm-20) K ZAA02GERR,P Q
MODE S %R=bl+2,%C=rm-10,@("P="_ZAA02GP),MODE=P_tLO_$S($D(im):"Insert: ",1:"Typeover") S:$D(im) MODE=MODE_tHI_$S(im:"ON ",1:"OFF") S MODE=MODE_eLO K P Q
EXIT S %R=24,%C=1 W @ZAA02GP X ZAA02G("TOF"),ZAA02G("WON") I $D(rm),rm>79 X ZAA02G(80)
        K ZAA02G(80),ZAA02G(132),ZAA02G("M"),ZAA02G("TON"),ZAA02G("TOF"),ZAA02G("WON"),ZAA02G("WOF"),ZAA02G("EON"),ZAA02G("EOF"),ZAA02G("ION"),ZAA02G("IOF") L  Q
SAVE S x=$S($D(@gl@(ts)):+^(ts),1:0),$P(@gl,"`",2,5)=r_"`"_c_"`"_x_"`"_cx,(x,t)="" F i=0:0 S t=$O(tbx(t)) Q:t=""  S x=x_","_t
        S $P(@ugl@(TID),"`",3,4)=$E(x,2,$L(x))_"`"_($O(tbx(""))+2) K x,t Q
CHCK N E,L,N,S S E=$D(@gl@(0)),(E,L,S)=0,N=1 F i=0:0 S S=$O(^(S)) Q:S=""  S:+^(S)'=L E=1 Q:E  S L=S,N=N+1
        I E W pBL_$C(7)_tHI_"[PTRERR]"_tLO_" at line "_tHI_N_tLO_":  please save and reload routine."_tCL S %R=bl+2,%C=rm-12 W @ZAA02GP,"Press any key" R *E
        Q
SE I $D(@ugl@(0,"OTHER")) G OTHER^ZAA02GED08
        G MENU
INIT D FUNC^ZAA02GEDDI S tHI=ZAA02G("HI"),tLO=ZAA02G("LO"),tCL=ZAA02G("CL"),sr=$S(ZAA02G("SR")="":0,1:1) Q
        ;
