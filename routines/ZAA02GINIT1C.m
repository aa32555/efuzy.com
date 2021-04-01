ZAA02GINIT1 ;PG&A,ZAA02G-CONFIG,2.25,O.S. PARAMETERS  (DSM);18FEB91 8:29A [ 09/20/97  10:12 AM ]
 ;Copyright (C) 1985,7 Patterson, Gray and Assoc., Inc.
 S OS="DSM" W !!,"***> Initializing Operating System Parameters ... ",OS
 S ^ZAA02G("OS")=OS
 S ^("ECHO-ON")="U 0:(:::::1)"
 S ^("ECHO-OFF")="U 0:(::::1)"
 S ^("TERM-ON")="U 0:(::::589888::::$C(1,5,6,7,8,9,10,11,12,13,14,16,18,20,21,22,23,24,26,28,29,30,31)) S ZAA02G(1)=ZAA02G(1)+1"
 S ^("TERMST")="S ZF=$S($ZB\256:$C(27,$ZB\256),$ZB=27:$C(27,0),1:$C($ZB#256))"
 S ^("TERM-OFF")="S ZAA02G(1)=ZAA02G(1)-1 U:'ZAA02G(1) 0:(:::::524353:::$C(13,27))"
 S ^("ERROR")="$ZT"
 S ^("ERRORR")="$ZE"
 S ^("WRAP-ON")="U:'ZAA02G(1) 0:^ZAA02G(""MARGIN"")"
 S ^("WRAP-OFF")="U 0:0"
 S ^("PAD")=$C(0)
 S ^("INIT")="K ZAA02G W:$D(^ZAA02G($I))=0 !!,""Device not defined to the Toolkit - Use ^ZAA02GDEV"",!! Q:$D(^($I))=0  S ZAA02G=^($I),ZAA02G(1)=0,ZAA02G(""T"")=^(""TERMST""),ZAA02GP=^(0,ZAA02G,""P"") X ""F ZAA02GI=0:1:5 I $D(^(ZAA02GI)) X ^(ZAA02GI)"" W ZAA02G(""SET"") K ZAA02GI,ZAA02G(""SET"")"
 I $P($ZV," ",3)>3.9 S ^ZAA02G("EXT")="$TR"
 Q
