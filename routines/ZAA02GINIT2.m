ZAA02GINIT2 ;PG&A,ZAA02G-CONFIG,2.25,TOOLKIT INIT - VERSION UPDATE;12AUG92 4:43P;;;24JUN98  12:33
 ;Copyright (C) 1985,6,7 Patterson, Gray and Assoc., Inc.
 Q
GETPARM S:'$D(^ZAA02G("EXT")) ^("EXT")="" S AA=^ZAA02G("ERROR")_"=""GETP1""",@AA,AA="",$P(AA,1,500)="" I ^ZAA02G("EXT")'["511" S ^("EXT")=^("EXT")_",511"
GETP1 Q
 ;
GETLIST Q:^ZAA02G("OS")'="PSM"  S A="ZAA02G"
GETLER W $ZE,! Q         S AA=^ZAA02G("ERROR")_"=""GETLER""",@AA
 F J=1:1 S A=$O(^UTILITY("R",A)) Q:A=""  Q:A]"ZAA02GZ"  W $J(A,10) D 1
 Q
1 S C=0,E=$E(A,1,4) X "ZL @A F K=1:1 S B=$T(+K) Q:B=""""  S C=C+$ZX(B)"
 S D(E)=$S($D(D(E)):D(E),1:0)+C W $J(C,10) Q
 ;
CHARSET ; EXTENDED CHARACTER SET TABLES
 K CA,CB,CD,CE S T=FR,cc=255 D SET Q:CH="*"  S CA=CH,CD=CI,T=TO,cc=32 D SET S CB=CH,CE=CI I TO="R",$D(DVP),+DVP=1 S T="P" D SET S CE=CI
 K:CA=CB!(CB="")!(CA="") CA,CB K:CD=CE!(CD="")!(CE="") CD,CE K CH,CI Q
SET S CH="*" G DEC:T["VT",IBM:T["PC",IBM:T="P",DEC:T="D",DEC:T["VT",DEC:T["WYSE75",DEC:T[3153,ROMAN:T="R",WYSE:T["WYSE",230:T[230,230:T["AMPEX+",TV:T["TV",IBM31:T["IBM31",NONE:T="N" K cc Q
DEC S CH=$C(161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,196,193,194,195,192,197,198,199,201,200,202,203,204,205,206,207,208,209,242,243,244,245,214,215,216,217,218,219,220)
 S CH=CH_$C(221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,210,211,212,213,246,247,248,249,250,251,252,253,254),CI=$C(108,113,107,120,106,109,110,119,117,118,116) Q
IBM S CH=$C(173,189,156,158,190,159,169,170,184,166,174,177,178,176,231,248,241,253,232,179,230,180,249,186,242,167,175,172,171,243,168,142,181,182,199,183,143,146,128,144,212,210,211,185,187,254,216,244,165,149,162,147,228,153,247,157,235,233,234,154)
 S CH=CH_$C(245,246,225,133,160,131,198,132,134,145,135,138,130,136,137,141,161,140,139,251,164,227,224,226,229,148,236,155,151,163,150,129,152,250),CI=$C(218,196,191,179,217,192,197,194,180,193,195) Q
ROMAN S CH=$C(184,191,175,cc,188,cc,189,186,cc,249,251,cc,cc,cc,cc,179,cc,cc,cc,cc,117,cc,46,cc,cc,250,253,247,248,cc,185,161,224,162,225,216,208,211,180,163,220,164,165,230,229,166,167,cc,182,202,198,194,234,206,cc,210,173,237,174,219)
 S CH=CH_$C(238,cc,222,200,196,192,226,204,212,215,181,201,197,193,205,217,213,209,221,cc,183,232,231,223,233,218,111,214,203,199,195,207,239,cc,cc,cc),CI=$C(124,45,124,124,124,124,43,45,124,45,124) Q
230 S CH="",CI=$C(70,75,71,74,72,69,73,78,76,79,77) Q
WYSE S CH="",CI=$C(50,58,51,54,53,49,56,48,57,61,52) Q
TV S CH="",CI=$C(102,107,103,106,104,101,105,110,108,111,109) Q
IBM31 S CH="",CI=$C(236,235,248,234,238,247,245,246,244) Q
NONE S CH="",CI=$C(43,45,43,124,43,43,43,45,124,45,124) Q
 ;
TEST ;
 S cc=255 D IBM S PP=CH D DEC S DD=CH D ROMAN S RR=CH F J=161:1:254 W !,J,?5,*J,?10,"P-" S P=$A($TR($C(J),DD,PP)),R=$A($TR($C(J),DD,RR)) W P,?20,"R-",R S X=$A($TR($C(P),PP,DD)) W:X'=J ?30,X
 F J=128:1:255 I PP[$C(J) W !,J,?10,"D-" S D=$A($TR($C(J),PP,DD)) W D,?18,*D S X=$A($TR($C(D),DD,PP)) W:X'=J ?25,X
 Q
T S cc=255 D IBM S PP=CH D DEC S DD=CH F J=1:1:$L(DD) S D=$E(DD,J) W:D'=$TR($TR(D,DD,PP),PP,DD) $A(D),"-",D,"-",$A($TR(D,DD,PP)),"  "
 W !! F J=1:1:$L(PP) S P=$E(PP,J) W:P'=$TR($TR(P,PP,DD),DD,PP) $A(P),"-",P,"-",$A($TR(P,PP,DD)),"  "
