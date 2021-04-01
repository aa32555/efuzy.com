ZAA02GINIT1 ;PG&A,ZAA02G-CONFIG,2.25,O.S. PARAMETERS  (M11);4AUG92 4:07P [ 09/20/97  10:12 AM ]
 ;Copyright (C) 1985,7 Patterson, Gray and Assoc., Inc.
 S OS="M11" W !!,"***> Initializing Operating System Parameters ... ",OS
 S ^ZAA02G("OS")=OS
 S ^("ECHO-ON")="U 0:(0:""T"":$C(8,9,24,127))"
 S ^("ECHO-OFF")="U 0:(0:""ST"":$C(8,9,24,127))"
 S ^("TERM-ON")="U 0:(0:""T"":$C(8,9,24,127)) S ZAA02G(1)=ZAA02G(1)+1"
 S ^("TERMST")="S ZF=$S($ZB?1C.E:$ZB,1:$C(0))"
 S ^("TERM-OFF")="S ZAA02G(1)=ZAA02G(1)-1 U:'ZAA02G(1) 0:(0:""C"":"""")"
 S ^("ERROR")="$ZT"
 S ^("ERRORR")="$ZE"
 S ^("WRAP-ON")="U:'ZAA02G(1) 0:^ZAA02G(""MARGIN"")"
 S ^("WRAP-OFF")="U 0:0"
 S ^("PAD")=$C(0)
 S ^("INIT")="K ZAA02G W:$D(^ZAA02G($I))=0 !!,""Device not defined to the Toolkit - Use ^ZAA02GDEV"",!! Q:$D(^($I))=0  S ZAA02G=^($I),ZAA02G(1)=0,ZAA02G(""T"")=^(""TERMST""),ZAA02GP=^(0,ZAA02G,""P"") X ""F ZAA02GI=0:1:5 I $D(^(ZAA02GI)) X ^(ZAA02GI)"" W ZAA02G(""SET"") K ZAA02GI,ZAA02G(""SET"")"
 S ^("EXT")="$TR"
 Q
