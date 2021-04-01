ZAA02GSCRWR ;PG&A,ZAA02G-SCRIPT,2.10,SELECT A TRANSCRIPT-VIA HTML;31OCT94  13:35;;;13SEP2006  08:23
 ;Copyright (C) 1992, Patterson, Gray & Associates, Inc.
ZAA02GSCR ; ZAA02GWEB
SET D NAMESPACE,SETUP^ZAA02GSCRVW D ALL Q
 Q
ESPQ ; ZAA02GWEB
 I $D(RLC) D check^ZAA02GVBW Q:$t
 D SETUP^ZAA02GSCRVW
 S DOC=$G(%("FORM","DATA")) K %("FORM") I DOC S (AUT,DUZC)=USER D AUTS^ZAA02GVBTER1
 G ES1
 ;
ES I $D(RLC) D check^ZAA02GVBW Q:$t
 D SETUP^ZAA02GSCRVW
ES1 S ES=USER,HTML=0 I $D(^ZAA02GSCR("PROV",0,ES)) S ES=^(ES)
 I $D(%("FORM")) G FSEL ; THIS ALL HAS TO BE CHANGED TO WORK WITH ONLY ES
 G ESP
 G ALL
 ;
 ; HEAD2 FOR XML
HEAD ;<HTML><HEAD><TITLE>TRANSCRIPT SELECTION</TITLE><script language="JavaScript">function changeScreenSize(w,h){window.resizeTo( w,h)}</script></HEAD><BODY onload="changeScreenSize(760,630)">
 ;<H2><center>Medical Reports</h2>Select individual report or headings for a search</center><p><TABLE CELLPADDING=1 CELLSPACING=0 BORDER=1 NOBRK><TR>
HEAD2 ;<?xml version="1.0" encoding="UTF-8"?><?xml-stylesheet type="text/xsl" href="/es.xsl" ?>
 ;
 ;
BEG ;
BBB S:'$D(TOP) TOP=3 I HTML W $P($T(HEAD),";",2,9),$P($T(HEAD+1),";",2,9)
 E  W $P($T(HEAD2),";",2,9),!
R4 S DX="AY",(DOC,CC)="",MM="",YY=$S($D(YX):YX,$G(@ZAA02GSCR@("PARAM","TR"))]"":^("TR"),1:"Job#,7\Patient,13\Acc #,6\Prov,8\Refr,6\Proc1,6\Proc2,6\DOS,8,/\Date,8,/\Time,5,:\SC,2\TR#,3\St,2\")
 I HTML F I=1:1:13 S Y=$P(YY,"\",I) W "<TH ALIGN=CENTER WIDTH="_$P("8,27,7,5,5,5,5,10,8,5,5,5,5",",",I)_"%><A HREF=""FIELD^ZAA02GSCRWR?"_I_""">",$P(Y,","),"</A>"
 I 'HTML S TYPE="text/xml" W "<Es><HEADING>" D  W "</HEADING>",!
 . F I=1:1:13 S Y=$P(YY,"\",I) W "<F",I," NAME=""",$P(Y,","),"""/>"
 ;
 S:'$D(SDIR) SDIR="@ZAA02GSCR@(""DIR"",99)" I $D(OFP) D FP
R5 K PAG,IN
 I HTML W "</TR>"
TOP S I="",PP=0,NE=50
LEV S CN=0 K IA
LEV1 I '$D(FP) S (II,I)=$O(@SRC@(I)) G ASK:I="" X E G:'$T LEV1 S CN=CN+1,IA(CN)=II I CN=1,'$D(PAG(PP)) S PAG(PP)=I
LEV2 I $D(FP) S:I="" FP=$O(@SRC) G:I="" ASK:FP="",ASK:FP]EP S (II,I)=$O(@SRC@(I)) G LEV2:I="" X E G:'$T LEV2 S CN=CN+1,IA(CN)=II,IB(CN)=FP I CN=1,'$D(PAG(PP)) S PAG(PP)=FP_","_I
 G LEV3:'$D(@SDIR@(II)) I $D(FIND) S:$S($D(FP):$P(FIND,",",3)](FP_I),1:$P(FIND,",",3)>I) $P(FIND,",")=CN+1 I $P($G(FIND),",",2)>PP G LEV1:CN<NE S PP=PP+1 G LEV
 S Y=$TR(^(II)," ~") I HTML W "<tr>" D  W "</TR>",!
 . F III=1:1:13 D
 .. W "<TD ALIGN=",$P("LEFT,CENTER,RIGHT",",",$E("1132222112222",III)),">" W:III=1*0 "<A NAME="""_$P(Y,"`",2)_""">"
 .. I III=2 W:$G(ES) "<A HREF="""_$G(RLC)_"/ZAA02GSELE^ZAA02GSCRWR.RTF?"_(10000000-II)_""">" W:'$G(ES) "<A HREF=""/ZAA02GSEL^ZAA02GSCRWR.RTF?"_(10000000-II)_""">"
 .. W $S($P(Y,"`",III)="":"-",1:$P(Y,"`",III)) W:III=2 "</A>"
 I 'HTML W "<Data " D  W " link=""ZAA02GSELE^ZAA02GSCRWR.RTF?"_(10000000-II)_"""/>",!
 . F III=1:1:13 W "F",III,"=""",$P(Y,"`",III),""" "
 G LEV1:CN<NE S CN=NE+1 S:$O(@SRC@(I))="" CN=$S('$D(FP):NE,$O(@SRC)="":NE,$O(@SRC)]EP:NE,1:CN) G ASK
LEV3 K IA(CN),IB(CN) S CN=CN-1 G LEV1
 ;
ASK I HTML W "</TABLE>",! I CN=0 W "<P><center>Search found no records"
 I 'HTML W "</Es>"
 W:0 "SRC:",SRC,"<BR>SDIR:",SDIR,"<BR>E:",E,"<BR>FP:",$G(FP),"<BR>",! K PAG Q
 Q
A3 S X=$D(@SDIR@(0)) G A1
A0 W @ZAA02GP,$S($D(INX(OJ)):ZAA02G("LO")_$TR(^(OJ),"`~","  ")_ZAA02G("HI"),1:$TR(^(OJ),"`~","  "))
A1 S %R=TOP+J+1,OJ=IA(J) I $D(CCT) S C=CC K CCT G A4:C'="",A5
 D @DX R C#1:to G:'$T E I C'="" G A4
A5 X ZAA02G("T") S C=$E(XX,$F(XX,ZF)) R CC#1:0 S:$T CCT=J#2 I C'="",$T(@C)'="" G @C
 W *7 G A1
A4 S:C?1L C=$C($A(C)-32) G @$S(C=" ":"B",C="E":"E",C="N":"O",C="P":"P",C="F":6,C="S":7,C="I":"G",C="X":"X",C'?1N:"ERR",1:"SEL")
AY W @ZAA02GP,ZAA02G("RON"),$TR(^(OJ),"`~","  "),ZAA02G("ROF") Q
 ;
A S J=$S(J>1:J-1,1:N) G A0
G G:'$D(INX) A0 X $S($D(INX(OJ)):"K INX(OJ)",1:"S INX(OJ)=1")
B S J=$S(J<N:J+1,1:1) G A0
O G:CN-1'=NE ERR S PP=PP+1 G LEV
P I PP S PP=PP-1,I=PAG(PP) S:I["," FP=$P(I,","),I=$P(I,",",2) S I=I-1 G LEV
 G A1
Q I PP G TOP
 G A1
 ;
Y G HLP^ZAA02GSCRTR2
X D:$G(TRANS)["mp" EDITCTR^ZAA02GSCRTR2 G A1
E K OFP,FIND G EXIT
 ;
ERR W *7 G A1
DISP S DOC=$P(FLN,"?",2) S A=.03 F  S A=$O(@ZAA02GSCR@("TRANS",10000000-DOC,A)) Q:A=""  S B=^(A) W $S(B[$C(1):$P(B,$C(1),4),1:B),!
 Q
 ;
FP S FP=$P(OFP,$C(1)),SRC=$P(OFP,$C(1),2),EP=$P(OFP,$C(1),3),E=$P(OFP,$C(1),4),M=$P(OFP,$C(1),5),OC=$P(OFP,$C(1),6) K:FP="" FP Q
SEL S:C C=10-C
SEL1 F I=J+1:1:N I IA(I)[C,$E(IA(I),$L(IA(I)))=C S J=I G A0
 I J<1 S J=1 G A1
 S J=0 G SEL1
 ;
F ;
FOUND S DOC=OF*IA(J)+OF1,FIND=","_PP_","_$G(IB(J))_IA(J)
 I '$D(@ZAA02GSCR@("TRANS",DOC)) D ARCH^ZAA02GSCRAT G R4
 S X=^(DOC) I $P(ZAA02GSCRP,";",3)'=1,"U"'[$P(^(DOC,.011),"`",21) D PROTGEN^ZAA02GSCRVW1 G:DOC="" R4
 I '$D(COPY) L @ZAA02GSCR@("TRANS",DOC):0 G:'$T BUSY I '$D(TRANS) L  I $P(X,"`",13)["H" G BUSY
EXIT I $D(M),+M K OFP
 K A,AB,I,II,TOP,NE,CN,IA,IB,PAG,PP,TJ,OC,L,OJ,OF,OF1,FP,EP,E,l,u,SM,M,MM,CC,CCT,DX,SDIR,YX,XE,to K:$G(DOC)="" OFP X ZAA02G("ECHO-ON") Q
BUSY S %C=1,%R=TOP,Y="18,10\RL\1\\\Transcript is currently being edited.  Try*,again in a few minutes.*,*,                  PRESS RETURN     "
 W @ZAA02GP,ZAA02G("CS") D POP G R4
POP N (ZAA02G,ZAA02GP,Y) G ^ZAA02GPOP
ACCT S SRC="^ZAA02GACT(ID,""TRANS"")",E="S II=10000000-I I 1",OF=-1,OF1=10000000,EP="zzzzz" G BEG
ALL S SRC="""DIR"",99)" G ALT
RV S SRC="""DIR"",12,""R"")" G ALT ;11
MAMMO S SRC="""DIR"",12,TSU)",XE="S:E'["",12,"" E=E_""I $D(@ZAA02GSCR@(""""DIR"""",12,""""M"""",II))""" G ALT
UL S SRC="""DL"",1)" G ALT
INC S SRC="""DIR"",12,""I"")" G ALT
ESP S SRC="""DIR"",48,ES)" S SRC="@ZAA02GSCR@("_SRC,E="S:I<0 II=-I I 1",OF=-1,OF1=10000000,EP="zzzzz" G BEG
PV S SRC="""DIR"",4,PRV)" G ALT
MR S SRC="""DIR"",3,MR)" G ALT
TR S SRC="""DIR"",11,TR)",TR=$TR(TRANS,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ") ;10
ALT S SRC="@ZAA02GSCR@("_SRC,E="I 1",OF=-1,OF1=10000000,EP="zzzzz" G BEG
7 S DX="A"_$E($S($D(AUT):"YSYYYYYYY",1:"YXZFUESY"),$F("YXZFUESY",$E($G(DX),2)))_"^ZAA02GSCRTR1" S:DX["AY" DX="AY" G A3
 ;
ZAA02GSELE ; ZAA02Gweb
 W $P($T(DATA),";",2,99),$G(%("FORM","DATA")),$P($T(DATA+1),";",2,9) Q
 ;
DATA ;<html><title>Medics Premier - Electronic Signature</title><FRAMESET rows="*,40" BORDER="0" FRAMEBORDER="0"><FRAME src="ZAA02GSEL^ZAA02GSCRWR.RTF?
 ;" scrolling="no"><FRAME src="buttons^ZAA02Gscrwr" scrolling="no"></FRAMESET></html>
BUTTONS ; ZAA02Gweb
 W $P($T(DATA1),";",2,99),$P($G(%("REFERER:")),"?",2),$P($T(DATA1+1),";",2,9) Q
 ;
DATA1 ;<form action="ESPQ^ZAA02GSCRWR?
 ;" method="post" target="_top"><center><INPUT TYPE="submit" value="Sign Report" > <input type="button" value="Back" OnClick="javascript:history.go(-1)"></center></form>
 ;
 ;
 ;
ZAA02GSEL ; ZAA02Gweb entry point
 g RTF
 D NAMESPACE S DOC=$G(%("FORM","DATA")) D SETUP^ZAA02GSCRVW S ZAA02GWPD=ZAA02GSCR_"(""TRANS"",DOC)",DVP="" D REVERS^ZAA02GWPPC1
 W "<HTML><HEAD><TITLE>REPORT - "_DOC_"</TITLE></HEAD><BODY><H3>MEDICAL REPORT - "_DOC_"</H3>",!
 ; w "<font color=""#ff0000"">This data is for demonstration purposes only - Not valid patient data</font><p>"
 S A=$O(@ZAA02GSCR@("TRANS",DOC,.03))
 I A,$G(^(A))[$C(1) S A=.03 F  S A=$O(^(A)) Q:A=""  S C=$S(^(A)[$C(1):$P(^(A),$C(1),4),1:^(A)) D WRX
 Q
WRX I C[$C(27) F B=1:1:4 S F=ZAA02G($P("uo,uf,ron,rof",",",B)),J=$P("<U>,</U>,<B>,</B>",",",B) F T=2:1:$L(C,F) S C=$P(C,F)_J_$P(C,F,2,255)
 W C,"<BR>",!
 Q
 ;
RTF S DOC=$G(%("FORM","DATA")),TYPE="application/rtf"  D ONLYRTF^ZAA02GVBTER S LL=B
 Q
 ;
NOMAP ; ZAA02Gweb entry
 W "NOT VALID LOCATION" q
MAP ; ZAA02Gweb entry
 W $G(URL) q
FIELD ; ZAA02Gweb entry
 S FLD=$G(%("FORM","DATA")) W "<HTML><HEAD><TITLE>FIELD SELECTION</TITLE></HEAD><BODY><FONT SIZE=4><B>Medical Record Search</B></FONT> - Enter partial or full text to search for in one or more fields<p>"
 W "<form action=""FSEL^ZAA02GSCRWR"" method=""POST""><table border=0 cellspacing=0 cellpadding=0>"
 F J=1:1:6,8:1:11 W "<tr><td>",$P("Job #,Patient,MR #,Provider,Referrer,Procedure,,Date,Time,Site,Transcriptionist",",",J),"&nbsp;</td><td><input type=""text"" size=30 name=""F"_J_""">"
 W "<tr><td><td><input type=""submit"" value=""search""></table></form>"
 Q
FSEL ; ZAA02Gweb entry
 D:0 NAMESPACE M A=%("FORM")
 S OC=0,(E,FP,SRC)="",u="ABCDEFGHIJKLMNOPQRSTUVWXYZ",l="abcdefghijklmnopqrstuvwxyz"
 I $G(A("F1")) S EP="z",FP=+A("F1"),SRC="@ZAA02GSCR@(""TRANS"",FP)",OC=1,E="S I="""",II=10000000-"_FP_",SRC=""@ZAA02GSCR@(""""DIR"""",99)"" I $D(@SRC@(II))" G F7
 F J=1,2,3,4,5,8,6,7,11,9,10 I $G(A("F"_J))]"" S K=$P(",2,3,4,5,6,6,,,11",",",J),M=A("F"_J) D F5
 I SRC="" K FP,EP G:E="" ZAA02GSCRWR S SRC="@ZAA02GSCR@(""DIR"",99)"
 S:E]"" E="S A=@ZAA02GSCR@(""DIR"",99,II) I "_$E(E,1,$L(E)-1)_" " X:$D(XE) XE S:E="" E="I 1"
F7 S:$D(FP) OFP=FP_$C(1)_SRC_$C(1)_EP_$C(1)_E_$C(1)_M_$C(1)_OC
 D SETUP^ZAA02GSCRVW G BEG
F5 S C=$TR(M,l_",.: ",u)
 I SRC="",K,$E(C)'="_" S SRC="@ZAA02GSCR@(""DIR"","_K_",FP)",FP=$P(C,"_"),EP=FP_"z",I=$L(FP),$P(C,"_")=$E("________________",1,I),FP=$E(FP,1,I-1)_$C($A(FP,I)-1,126) Q:C?."_"
 S:'K K=J I C["[" S E=E_"$P(A,""`"","_K_")["""_$TR(C,"_:/[","")_"""," Q
 F A=1:1:$L(C,"_") I ":/"'[$P(C,"_",A) S E=E_"$E($P(A,""`"","_K_"),"_$S(A>1:$L($P(C,"_",1,A-1)_11),1:1)_","_$L($P(C,"_",1,A))_")="""_$P(C,"_",A)_""","
 Q
TT S %("FORM","F2")="A" D FSEL Q
NAMESPACE I $D(^ZAA02GSQLC("webnamespace")) x ^("webnamespace")
 Q
