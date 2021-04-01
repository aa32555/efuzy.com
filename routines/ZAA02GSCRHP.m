ZAA02GSCRHP ;PG&A,ZAA02G-SCRIPT,2.10,HELP MESSAGES;18AUG95 11:42A;;;20FEB2006  08:58
 ;Copyright (C) 1984, Patterson, Gray & Associates, Inc.
 ;
 ;  HELP CODE FROM ID BLOCK
REPHP G REPMHM:ZAA02GSCRP["X",REPMH
REPER G REPM
 ;
REPM D REPM1 G REFRESH
REPMH S SVX=X D REPM2 S:X'["EX" RX=1,$P(Y,"`",13)=$TR($P(Y,"`",13),"K","") S:X["TB" RX=9 S:X[";EX" X=SVX,RX=0 K SVX G REFRESH
 ; next 2 sections set for multilevel lookup with HELP key & entries
REPMHM D REPMH2 G REFRESH
REPMH2 N (%R,REFRESH,ZAA02G,ZAA02GP) S Y="15,7\YRHLO31W200\1\REPORT TEMPLATE LOOKUP INSTRUCTIONS",Y(0)="\EX",Y(1)=" ",Y(2)="ZAA02G-SCRIPT provides 7 types of lookups for a report:",Y(3)=" ",Y(4)="    knee      - exact match lookup for report titled ""knee"""
 S Y(5)="    kne       - all entries starting with ""kne"" for site",Y(6)="    *         - lists all reports for site",Y(7)="    ?kne      - all entries for site & CPT beginning with ""kne"""
 S Y(8)="    ?         - all entries for site & CPT"
 S Y(9)="    @         - all entries in system",Y(10)="    @abc      - all entries in system starting with ""abc"""
 S Y(11)="",Y(12)="(you can specify the SITE by adding "":XX"" where XX is site code,",Y(13)=" and you can do a partial lookup on any level - ie ""ab.f.n"")"
 G POP
 ;
REPM2M N (%R,REFRESH,ZAA02G,ZAA02GP,X,OXX,ZAA02GSCR,ZAA02GSCRP,TYPE,SC,CPT) S:'$D(CPT) CPT=0 D:'$D(@ZAA02GSCR@(106,0)) RB106^ZAA02GSCRRD S OXX=X S:X="" B="z",A=0 S:X]"" A=X,B=X_"~" S:A="" A=0 S X=""
 I OXX[".",$L(OXX)<25 S A=$P(OXX,"."),B=A_"~",ZAA02GPOPALT=$P($T(LOOKT),";",2,99) F je=1:1:$L(OXX,".") S B(je)=$P(OXX,".",je),C(je)=$L(B(je))
 S Y="15,3\RHLSTO14\1\Report Templates"_$S(TYPE=1:"",TYPE=2:" - SITE: "_SC,1:" - SITE: "_SC_", PROC: "_CPT)_"\\"
 S Y(0)="\EX,SE,TB\"_ZAA02GSCR_$S(TYPE=1:"(106,0)",TYPE=2:"(106,0,0,SC)",1:"(106,0,0,SC,0,CPT)")_"\$E(TO,1,60)"_$S(ZAA02GSCRP'["F":"_$J("""",15-$L(TO))_$E($G(^(TO)),1,60)",1:"")_"\"_A_"\\\"_B
 G POP
LOOKT ;F jj=1:1 S TO=$O(@TQN@(TO)) S:TO]TEN TO="""" Q:TO=""""  X ""F M=1:1:je I $E($P(TO,""""."""",M),1,C(M))'=B(M) Q"" E  Q
 ;
REPVAL ; used from validation field of ID block
 S SC=$S($D(SITE):SITE,$D(INP("SITEC")):INP("SITEC"),1:"")
 I X[":" S (SITE,SC)=$TR($P(X,":",2),LC,UP),X=$P(X,":") I $D(SCR),$D(SN),$D(^ZAA02GDISP(SCR,SN,"SITE")) S opi="PDP;SITE;SC" X op
 I X?1.E1"-",$O(@ZAA02GSCR@(106,0,X))="" S OT=OT_" ",X=$TR(X,"-")
 I $D(@ZAA02GSCR@(106,0,X)),$E($O(@ZAA02GSCR@(106,0,X)),1,$L(X))'=X Q
 S TYPE=$S(ZAA02GSCRP'["X":1,X["*":2,X["?":3,X["@":1,1:2),X=$TR(X,"*@?",""),RX=0 S:TYPE>1 TYPE=$S(SC="":1,$G(CPT)="":2,1:TYPE) D REPM2M S RX=$S(X[";TB":9,X[";EX":0,1:3) D:$D(SCR) REFRESH S:X=0 X=""
 I X'[";EX" S X=$P(X,";") Q  ;X=$E(X,1,+$P(Y,"`",5)) S:X[" " %=$TR(X," ",""),%=$E(%,$L(%)),X=$E(X,1,$L($P(X,%,1,$L(X,%)-1)_%)) Q
 Q:'$D(ee)  S X=$S($G(I)]"":$P($G(e(I)),ee),1:"") I 1 Q
 ;
REPM1 N (%R,REFRESH,ZAA02G,ZAA02GP) S Y="15\RHCL\1\\\The name specified was not a valid Report*,*,Edit name or Press the HELP key for a list.*" G POP
REPM2 N (%R,REFRESH,ZAA02G,ZAA02GP,X,ZAA02GSCR,ZAA02GSCRP) D:'$D(@ZAA02GSCR@(106,0)) RB106^ZAA02GSCRRD S Y="15,3\RHLST\1\Report Templates\\"
 S Y(0)="\EX\"_ZAA02GSCR_"(106,0)\$E(TO,1,60)"_$S(ZAA02GSCRP'["F":"_$J("""",20-$L(TO))_$E($G(^(TO)),1,60)",1:"")_"\0"
POP S REFRESH="",%R=%R+1 G ^ZAA02GPOP
REFRESH I $G(REFRESH)="" K REFRESH Q
 S tt=+REFRESH,td=$P(REFRESH,":",2) G AP0^ZAA02GFORM4
 ;
HELP S:HP'=2 HP=2 S HLPR="^ZAA02GSCRH" G HELP^ZAA02GWPV9
 K HLP S:$D(HP) HLP=HP N (HLP,ZAA02G,ZAA02GP,XX,MC,MCL,BL,TL) S:'$D(BL) BL=22 S:'$D(TL) TL=2 D ^ZAA02GWPH
 Q
HLPR D HELP S NX=BL-10 D REFR^ZAA02GWPVB Q
 ;
SHELP ;SCREEN HELP FOR ID BLOCK
 Q:'$D(Y)  D SHELP1,REFRESH Q
SHELP1 S YY=Y N (ZAA02G,ZAA02GP,REFRESH,YY,%R,%C,ZAA02GSCR) S YY=$P(YY,"`",11),REFRESH="",Y(0)="\EX" I $D(@ZAA02GSCR@("HELP",YY)) S Y="10,"_(%R+1)_"\RHLW99\1\",Y(0)="15\EX\@ZAA02GSCR@(""HELP"",YY)\\.03"
 E  I $T(@YY)]"" S Y="\CRHLY\1\ID BLOCK HELP: "_YY D @YY
 E  S Y="\CRHL\1\ID BLOCK HELP: "_YY_"\\*,Sorry - no help available"
 D ^ZAA02GPOP Q
 Q
MR F J=1:1:9 S Y(J)=$S(J=2:"Enter:   ",1:$J("",9))_$P("*\Account #    66547*\Last*         SMITH\Last,First*   SMITH,J\Med Rec#*     M12345\=DOB         =2/12/56*\LAST=DOB     S=2/15/56*\0  -  free text patient*\*","\",J)
 Q
RMACRO ; MACRO ENTRY FOR ADDITIONAL REPORTS
 G RMACRO^ZAA02GSCRMC
 ;
DHP ; HELP MESSAGES FOR DISTRIBUTION LIST SCREEN
 S YY=$E("DH"_$P(Y,"`",11),1,8) D DHP1,REFRESH Q
DHP1 N (ZAA02G,ZAA02GP,REFRESH,YY,%R,%C) S YY=$P($T(@YY),";",2,99) I YY="" S YY="Sorry - No Help Available"
 S REFRESH="",Y=%C_","_(%R+1)_"\RHLW99O21\1\\\"_YY,Y(0)="\EX\" D ^ZAA02GPOP Q
 Q
DHORIGT ;ORIGINAL TITLE,,(optional),,This text can be inserted in the original copy with a ~$GTITLE.
DHCOPIES ;# OF COPIES,,(REQUIRED),,Enter # of lines that are active below.
DHTITLE ;TITLE,,(optional),,This text can be inserted in document,with a ~$TITLE.  Use *xxx to have title,take on other variables (ie *cc1).
DHBIN ;BIN SELECTION,,(optional),,A - Bin 1,B - Bin 2,E - Envelope
DHPRINTE ;PRINTER ASSIGNMENT,,(optional),,Overrides the selected or,default printers
DHCONDIT ;CONDITION    (optional),,This copy can be made conditional on the,existence or value of a report variable.,Examples:,, CC1        prints copy if CC1 exists, SITEC=CH   prints copy if site equal CH
DHES ;ELECTRONIC SIGNATURE PRINTING OPTIONS,,P     - print before signature,A     - print when signed (default),OP/OA - same as P or A when ES is on,E     - prints in all cases,N     - suppress print if ES is on,,if ES is off - all print but OA & OP
DHXFR ;Transfer Parameters  (optional),,to force Faxed report - format =,   FAX;fax #;delay;preamble/conclusion;,   header 2+/footer;cover option;FAXTO,,to change report settings =,   REPORT:(report template)
