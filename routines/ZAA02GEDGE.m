ZAA02GEDGE
INIT    W #
	;               
	D IN^ZAA02GDEV
	Q:$G(%QUIT)
	S Y="1,1\TLRH\1\AA M Utils -> "_red_" Global Editor"_e_"\\"
	S Y=Y_" *,"
	S Y=Y_$$GETSEQ^ZAA02(1)_") "_green_"New Entry"_e_","
	I $D(^ZAA02G("ZAA02GEDGE","RECENT")) N A,C S C=1 D  I 1
	. S A="" F  S A=$O(^ZAA02G("ZAA02GEDGE","RECENT",A),-1) Q:A=""  D
	. . I $D(C(^ZAA02G("ZAA02GEDGE","RECENT",A))) Q
	. . S C=C+1
	. . S Y=Y_$$GETSEQ^ZAA02(C)_") ^"_^ZAA02G("ZAA02GEDGE","RECENT",A)_","      
	. . S A(C)=A
	. . S C(^ZAA02G("ZAA02GEDGE","RECENT",A))=""
	S Y=Y_"*," 
	S Y=Y_$$GETSEQ^ZAA02($G(C,1)+1)_") Go Back,"_"*"                    ;7
	S Y=Y_" *, *, *, *, *, *, *, *, *, *,*, *, *, *, *, *, *"
BG1             ;
	;               
	D BEGX^ZAA02GDEV
	S X=X-1
	I X=1 S %XX="" G BG2
	I X>1,$D(A(X)) S X=A(X),%XX=^ZAA02G("ZAA02GEDGE","RECENT",X)
	I X>1,'$D(A(X)) G ^AA
BG2             ;
	;               
	D CLR^ZAA02
	D FUNC^ZAA02GEDDI 
	S loc=""
	S (eHI,tHI)=ZAA02G("HI"),(eLO,tLO)=ZAA02G("LO"),tCL=ZAA02G("CL")
	S ugl="^ZAA02G"
	S:'$D(lm) lm=2,rm=^ZAA02G("Col")-1,tl=3,bl=^ZAA02G("Row")-1,%R=bl+2,%C=lm-1,@("pBL="_ZAA02GP),sr=$S(ZAA02G("SR")="":0,1:1) S:$G(ZAA02G(132))="" rm=^ZAA02G("Col")-1  X $S(rm>^ZAA02G("Col"):$G(ZAA02G(132)),1:$G(ZAA02G(80)))
	D FILES^ZAA02GED,USER^ZAA02GED:$D(TID)=0 S ZAA02G("M")=$S($D(@ugl@(TID,"MENU")):^("MENU"),1:1)
	X ZAA02G("TON"),ZAA02G("WOF") W ZAA02G("Z"),ZAA02G("F") D EDIT
	X ZAA02G("TOF"),ZAA02G("WON") X:rm>^ZAA02G("Col") ZAA02G(80) W:sr @ZAA02G("CSR") S %R=^ZAA02G("Rol"),%C=1 W @ZAA02GP,ZAA02G("CS")
	K bl,lm,rm,sr,tl,SF,eHI,eLO,pBL,tCL,tHI,tLO,ZAA02G(80),ZAA02G(132),ZAA02G("TON"),ZAA02G("TOF"),ZAA02G("WON"),ZAA02G("WOF"),ZAA02G("EON"),ZAA02G("EOF") Q
EDIT 
	;               
	N (ZAA02G,ZAA02GP,ZAA02GX,ZAA02GY,TID,d,ci,bs,bl,ct,gl,lm,rm,rt,sr,tl,ts,SF,tCL,eHI,eLO,tHI,tLO,pBL,ugl,sgl,%XX)
	S Orm=rm,W=rm-lm+1,WW=W+2,DF=0,(r,fs)="",gls=0
GLOB 
	;               
	D IN^ZAA02GDEV K Usr W pBL_tLO_red_"Global "_green_"=>"_e_" ^"_tHI_tCL S X=$S($D(RQ):RQ,'$D(TID):"",$D(@ugl@(TID,"GREF")):$P(^("GREF"),$C(1),gls+1),1:"") I $G(%XX)]""  S X=%XX
	I $G(%XX)="",X]"" S ^ZAA02G("ZAA02GEDGE","RECENT",$I(^ZAA02G("ZAA02GEDGE","RECENT")))=X
	S %R=bl+2,%C=lm+$L("Global => ") I '$D(POP) S Y="RON\ROF\HL,PU,PD,EX,UK,DK\?\64\\\\\\\\1" D ^ZAA02GEDRS I ZAA02GF="HL" S HN=2321 D HELP G GLOB
	;I ZAA02GF="CR" S %R=1,%C=1 W # R "Exit?",%ANS#1 I (%ANS="Y"!(%ANS="y")) G EXIT
	I ZAA02GF="UK"!(ZAA02GF="DK") K RQ S gls=$G(gls)+$S(ZAA02GF="UK":1,1:-1)#10 G GLOB
	I ZAA02GF="?"!$D(POP) S:'$D(POP) POP=X W @ZAA02GP,$P(POP,";"),"?  wait...",ZAA02G("CL") D LIST^ZAA02GEDGL S ZAA02GF="" I X="" S %R=3,%C=1 W @ZAA02GP,ZAA02G("CS") K POP G GLOB 
	G:X=""!(ZAA02GF="EX") EXIT S RQ=X K ^ZAA02GEDTMP($J)
	I X="" G ^AA
	I X="^" G ^AA
	D ^ZAA02GEDGL I E,E'=2 G:X="" GLOB S E=$P("Global name error;;Unmatched quotation marks",";",E),%C=rm-$L(E) W @ZAA02GP,tHI_E H 3 G GLOB
	S:$D(TID) @ugl@(TID,"GREF")=X_$C(1)_$P($G(@ugl@(TID,"GREF")),$C(1),1,9) S SF=1,T="Global: "_GR D ^ZAA02GEDHD K E,T
	S D=$C(1),SB=0 F I=1:1:NL Q:$D(BS(I))=0  Q:BS(I)=""  S $P(SB,D)=I,$P(SB,D,I+1)=$S(BS(I)=+BS(I):BS(I),1:""""_BS(I)_"""")
	S CS=$C(0,1) F I=2:3:29,127:3:253 S CS=CS_$C(I,I+1,I+2)
	S CL=$L(CS),XS=$TR($J("",CL)," ",$C(1)),TR=3,BR=^ZAA02G("Row")-1,(PL,PG)=1,PG(1)=101,PG(PL,PG)=SB,DF=1 D ^ZAA02GEDGE1 G GLOB
EXIT 
	;               
	W:sr @ZAA02G("CSR") I rm>^ZAA02G("Col"),Orm=^ZAA02G("Col")-1 X ZAA02G(80) S rm=^ZAA02G("Col")-1
	K ^ZAA02GEDTMP($J) Q
HELP 
	;               
	D ^ZAA02GEDH I 'DF D RESTORE^ZAA02GED08(+REFRESH,$P(REFRESH,":",2)) K REFRESH Q
	Q
DEL 
	;               
	N %C S RS=US(NO),RL=$L(RS),(G,RF)=$S(RS="":GN,1:"^("_$TR(RS,D,",")_")") S:$E(G,1,2)="^(" $P(G,"(")=GN G:$D(@G)\10 DEL2
	I $D(@G) S ^ZAA02GEDTMP($J,G)=@G,%C=$S($L(RF)<26:27,1:$L(RF)+2)+3 W @ZAA02GP,tLO_"<deleted>"_tCL K @G
	K G,RF,RL,RS Q
DEL2 
	;               
	N %R F I=NO:1:CN I $E(US(I),0,RL)=RS,D[$E(US(I),RL+1) S RX=US(I),L=$L(RX)+(RX]""*3),%R=I+2,%C=$S(L<26:27,1:L+2)+3 W @ZAA02GP,tLO_"<delete?>"_tCL
	I RS]"" W pBL,*7,tLO_"Kill this node and its descendants?  Please confirm:"_tLO_tCL S %R=bl+2,%C=lm+52,Y="RON\ROF\EX\\3\NY\No;Yes",X=0 D READ^ZAA02GEDYN G:'X!(ZAA02GF="EX") DEL3
	I RS="" W pBL,*7,tLO_"Kill this "_tHI_"ENTIRE"_tLO_" global?  Please confirm:"_tLO_tCL S %R=bl+2,%C=lm+41,Y="RON\ROF\EX\\3\NY\No;Yes",X=0 D READ^ZAA02GEDYN G:'X!(ZAA02GF="EX") DEL3
	K @G,G,L,RF,RL,RX S:'$D(@GN) (PL,PG)=1 W pBL_tCL D PAGE^ZAA02GEDGE1 S:NO>CN NO=1 Q
DEL3 
	;               
	F I=NO:1:CN I $E(US(I),0,RL)=RS,D[$E(US(I),RL+1) S RX=$L(US(I)),%R=I+2,%C=$S(RX:RX+(RX>0*3),1:$L(GN))+3 W @ZAA02GP,tHI_UV(I)_tCL
	K I,L,RF,RL,RS,RX W pBL_tCL Q
	;
	;