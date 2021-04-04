%ZAA02GEDGC
	N (ZAA02G,ZAA02GP,ZAA02GX,ZAA02GY,TID,d,ci,bl,bs,ct,gl,lm,rm,rt,sr,tl,ts,SF,tCL,eHI,eLO,tHI,tLO,pBL,ugl,sgl)
	S (GF,GT,r,fs)="",DSP=1
FROM W pBL_tCL S %R=bl+2,%C=lm-1,Y="RON\ROF\HL,EX\\"_(rm-18)_"\\\\\\Copy Global: ^\\1",X=GF S:$E(X)="^" X=$E(X,2,9999) D ^ZAA02GEDRS I ZAA02GF="HL" S HN=2310 D ^ZAA02GEDH,RESTORE^ZAA02GED08(+REFRESH,$P(REFRESH,":",2)) G FROM
	Q:X=""!(ZAA02GF="EX")  S GF=X
	D ^ZAA02GEDGL,BLDREF S GF=REF,GFR=BAS,GFL=NLV I E S E=$P("Global name error;Global does not exist;Unmatched quotation marks",";",E),%C=rm-$L(E) W @ZAA02GP,tHI_E H 3 G FROM
TO D GLT G EXIT:ZAA02GF="EX",FROM:ZAA02GF="UK"!(GT="") I GTL>GFL W *7 G TO
CPY K SB S END=0,pc=1 F I=0:0 D ONE Q:END
EXIT K D,E,I,V,X,Y,BS,CS,DD,DT,ES,EB,GN,GR,LM,LN,MX,NL,PG,RF,RM,SB,SW,BAS,GFL,GFR,GTR,GTL,NLV,REF Q
GLT N GN,GR,BS,ES,NL,MX
GLT2 W pBL_tCL S %R=bl+2,%C=lm-1,Y="RON\ROF\UK,HL,EX\\"_(rm-17)_"\\\\\\Copy to Global: ^",X=GT D ^ZAA02GEDRS I ZAA02GF="HL" S HN=2310 D ^ZAA02GEDH,RESTORE^ZAA02GED08(+REFRESH,$P(REFRESH,":",2)) G GLT2
	S GT=X Q:X=""!(ZAA02GF="EX")  D ^ZAA02GEDGL S GT=GR
	I E,E'=2 S E=$P("Global name error;;Unmatched quotation marks",";",E),%C=rm-$L(E) W @ZAA02GP,tHI_E H 3 G GLT
	D BLDREF S GT=REF,GTR=BAS,GTL=NLV S:GTR'["(" GTR=GTR_"(" Q
BLDREF S (REF,BAS)=GN,NLV=0 Q:'NL  S REF=REF_"(" F i=1:1:NL-(MX=99) D BLD
	S:MX<99 REF=$E(REF,1,$L(REF)-1)_")" S:'NLV&($E(BAS,$L(BAS))=",") NLV=NL-1
	K i,S,S1,S2 Q
BLD S S1=$S($D(BS(i)):BS(i),1:"") S:'NLV&(S1="") NLV=i-1 S:S1'=+S1 S1=""""_S1_""""
	S S=$S($D(ES(i)):ES(i),1:""),S2="" S:'NLV&(S]"")&(S'=BS(i)) NLV=i-1 I S]"",S'=BS(i) S S2=$S(S'=+S:""""_S_"""",1:S)
	S REF=REF_S1_$S(S2]"":":"_S2,1:"")_"," I 'NLV S:BAS'["(" BAS=BAS_"(" S BAS=BAS_S1_","
	Q
ONE I '$D(SB) S (SB,SBF)="",D=$C(1) I 'GFL,$D(@GN)#2 S RF=GN,V=@RF D PUT Q
	G NLV:'SB I SB(SB)]"",SB'>MX,$D(@G@(SB(SB)))\10 G NLV
ORD S (sb,SB(SB))=$O(@G@(SB(SB))) G:sb="" PLV
	I $D(ES(SB)),ES(SB)=+ES(SB) G PLV:sb'=+sb,PLV:sb>ES(SB),OR1
	I $D(ES(SB)),ES(SB)]"",sb]ES(SB) G PLV
OR1 I SB'<GFL,$D(^(sb))#2 S V=^(sb) D PUT Q
NLV G:SB'<MX ORD I 'SB S G=GN
	E  S S=SB(SB),$P(SBF,D,SB)=$$SUB(S),G=GN_"("_$TR(SBF,D,",")_")"
	S SB=SB+1,SB(SB)="" S:$D(BS(SB)) SB(SB)=BS(SB) G:SB(SB)="" ORD S DD=$D(@G@(SB(SB))) I SB'<GFL,DD#2 S V=^(SB(SB)) D PUT Q
	G NLV
PLV S SB=SB-1 I 'SB S END=1 Q
	S SBF=$P(SBF,D,0,SB-1),G=$S(SB>1:GN_"("_$TR(SBF,D,",")_")",1:GN) G ORD
PUT I 'SB S T=$P(GTR,"(")
	E  S T=GTR_$TR($P(SBF,D,GTL+1,SB),D,",") S:$P(T,"(",2)]""&($E(T,$L(T))'=",") T=T_"," S T=T_$$SUB(SB(SB))_")"
	S @T=V,pc=pc-1 D:'pc&DSP MSG W:DSP "." Q
SUB(X) Q:+X=X X I X'["""" Q """"_X_""""
	S F=0 F I=0:0 S F=$F(X,"""",F) Q:'F  S X=$E(X,0,F-1)_""""_$E(X,F,$L(X)),F=F+1
	Q """"_X_""""
MSG I SB S RF=GFR_$S('GFL:"(",1:"") F i=GFL+1:1:SB S RF=RF_$S(+SB(i)=SB(i):SB(i),1:""""_SB(i)_"""")_","
	S:SB RF=$E(RF,1,$L(RF)-1)_")" W:DSP pBL_tLO_"Copying "_tHI_RF_tLO_tCL S pc=rm-$L(RF)-9 Q
COPY(GF,GT) Q:$D(GF)+$D(GT)'=2
	N (GF,GT,ZAA02G,ZAA02GP,ZAA02GX,ZAA02GY,DSP) S:'$D(DSP) DSP=0
	S X=GF D ^ZAA02GEDGL,BLDREF Q:E  S GF=REF,GFR=BAS,GFL=NLV D CPYTO Q:E
	K SB S END=0,pc=1 F I=0:0 D ONE Q:END
	Q
CPYTO N GN,GR,BS,ES,NL,MX
	S X=GT D ^ZAA02GEDGL Q:E  S GT=GR
	D BLDREF S GT=REF,GTR=BAS,GTL=NLV S:GTR'["(" GTR=GTR_"("
	Q
	;
	;