ZAAEDGE ;
INIT D FUNC^ZAAEDDI S (eHI,tHI)=ZAA("HI"),(eLO,tLO)=ZAA("LO"),tCL=ZAA("CL")
        S:'$D(lm) lm=2,rm=79,tl=3,bl=22,%R=bl+2,%C=lm-1,@("pBL="_ZAAP),sr=$S(ZAA("SR")="":0,1:1) S:$G(ZAA(132))="" rm=79 ;X $S(rm>79:ZAA(132),1:ZAA(80))
        D FILES^ZAAED,USER^ZAAED:$D(TID)=0 S ZAA("M")=$S($D(@ugl@(TID,"MENU")):^("MENU"),1:1)
        X ZAA("TON"),ZAA("WOF") W ZAA("Z"),ZAA("F") D EDIT
        X ZAA("TOF"),ZAA("WON") X:rm>79 ZAA(80) W:sr @ZAA("CSR") S %R=24,%C=1 W @ZAAP,ZAA("CS")
        I $G(ZAA("OS"))="M3" S I=$ZM(20,$J,$J_" - M3-Lite Terminal")
        K bl,lm,rm,sr,tl,SF,eHI,eLO,pBL,tCL,tHI,tLO,ZAA(80),ZAA(132),ZAA("TON"),ZAA("TOF"),ZAA("WON"),ZAA("WOF"),ZAA("EON"),ZAA("EOF") Q
EDIT N (ZAA,ZAAP,ZAAX,ZAAY,TID,d,ci,bs,bl,ct,gl,lm,rm,rt,sr,tl,ts,SF,tCL,eHI,eLO,tHI,tLO,pBL,ugl,sgl)
        S Orm=rm,W=rm-lm+1,WW=W+2,DF=0,(r,fs)="",gls=0
GLOB K Usr W pBL_tLO_"Edit Global: ^"_tHI_tCL S X=$S($D(RQ):RQ,'$D(TID):"",$D(@ugl@(TID,"GREF")):$P(^("GREF"),$C(1),gls+1),1:"")
        S %R=bl+2,%C=lm+13 I '$D(POP) S Y="RON\ROF\HL,PU,PD,EX,UK,DK\?\64\\\\\\\\1" D ^ZAAEDRS I ZAAF="HL" S HN=2321 D HELP G GLOB
        I ZAAF="UK"!(ZAAF="DK") K RQ S gls=$G(gls)+$S(ZAAF="UK":1,1:-1)#10 G GLOB
        I ZAAF="?"!$D(POP) S:'$D(POP) POP=X W @ZAAP,$P(POP,";"),"?  wait...",ZAA("CL") D LIST^ZAAEDGL S ZAAF="" I X="" S %R=3,%C=1 W @ZAAP,ZAA("CS") K POP G GLOB
        G:X=""!(ZAAF="EX") EXIT S RQ=X K ^ZAAEDTMP($J)
        D ^ZAAEDGL I E,E'=2 G:X="" GLOB S E=$P("Global name error;;Unmatched quotation marks",";",E),%C=rm-$L(E) W @ZAAP,tHI_E H 3 G GLOB
        S:$D(TID) @ugl@(TID,"GREF")=X_$C(1)_$P($G(@ugl@(TID,"GREF")),$C(1),1,9) S SF=1,T="Global: "_GR D ^ZAAEDHD K E,T
        S D=$C(1),SB=0 F I=1:1:NL Q:$D(BS(I))=0  Q:BS(I)=""  S $P(SB,D)=I,$P(SB,D,I+1)=$S(BS(I)=+BS(I):BS(I),1:""""_BS(I)_"""")
        I $G(ZAA("OS"))="M3" S I=$ZM(20,$J,$J_" - ^"_X_" - M3-Lite Terminal")
        S CS=$C(0,1) F I=2:3:29,127:3:253 S CS=CS_$C(I,I+1,I+2)
        S CL=$L(CS),XS=$TR($J("",CL)," ",$C(1)),TR=3,BR=22,(PL,PG)=1,PG(1)=101,PG(PL,PG)=SB,DF=1 D ^ZAAEDGE1 G GLOB
EXIT W:sr @ZAA("CSR") I rm>79,Orm=79 X ZAA(80) S rm=79
        K ^ZAAEDTMP($J) Q
HELP D ^ZAAEDH I 'DF D RESTORE^ZAAED08(+REFRESH,$P(REFRESH,":",2)) K REFRESH Q
        Q
DEL N %C S RS=US(NO),RL=$L(RS),(G,RF)=$S(RS="":GN,1:"^("_$TR(RS,D,",")_")") S:$E(G,1,2)="^(" $P(G,"(")=GN G:$D(@G)\10 DEL2
        I $D(@G) S ^ZAAEDTMP($J,G)=@G,%C=$S($L(RF)<26:27,1:$L(RF)+2)+3 W @ZAAP,tLO_"<deleted>"_tCL K @G
        K G,RF,RL,RS Q
DEL2 N %R F I=NO:1:CN I $E(US(I),0,RL)=RS,D[$E(US(I),RL+1) S RX=US(I),L=$L(RX)+(RX]""*3),%R=I+2,%C=$S(L<26:27,1:L+2)+3 W @ZAAP,tLO_"<delete?>"_tCL
        I RS]"" W pBL,*7,tLO_"Kill this node and its descendants?  Please confirm:"_tLO_tCL S %R=bl+2,%C=lm+52,Y="RON\ROF\EX\\3\NY\No;Yes",X=0 D READ^ZAAEDYN G:'X!(ZAAF="EX") DEL3
        I RS="" W pBL,*7,tLO_"Kill this "_tHI_"ENTIRE"_tLO_" global?  Please confirm:"_tLO_tCL S %R=bl+2,%C=lm+41,Y="RON\ROF\EX\\3\NY\No;Yes",X=0 D READ^ZAAEDYN G:'X!(ZAAF="EX") DEL3
        K @G,G,L,RF,RL,RX S:'$D(@GN) (PL,PG)=1 W pBL_tCL D PAGE^ZAAEDGE1 S:NO>CN NO=1 Q
DEL3 F I=NO:1:CN I $E(US(I),0,RL)=RS,D[$E(US(I),RL+1) S RX=$L(US(I)),%R=I+2,%C=$S(RX:RX+(RX>0*3),1:$L(GN))+3 W @ZAAP,tHI_UV(I)_tCL
        K I,L,RF,RL,RS,RX W pBL_tCL Q
        ;
