ZAA02GINIT1 ;PG&A,ZAA02G-CONFIG,2.25,O.S. PARAMETERS  (MSM);15SEP94 10:35A [ 09/20/97  10:12 AM ]
 ;Copyright (C) 1985,7 Patterson, Gray and Assoc., Inc.
 S OS="MSM" W !!,"***> Initializing Operating System Parameters ... ",OS
 S ^ZAA02G("OS")=OS
 S ^("ECHO-ON")="U 0:(:::::1) S ZAA02G(1)=ZAA02G(1)\1"
 S ^("ECHO-OFF")="U 0:(::::1) S ZAA02G(1)=ZAA02G(1)+.01"
 S ^("TERM-ON")="U:'ZAA02G(1) 0:(0::::852032::::$C(0,1,2,4,5,6,7,8,9,10,11,12,13,14,16,18,20,21,22,23,24,25,26,28,29,31,127)) S ZAA02G(1)=ZAA02G(1)+1"
 S ^("TERMST")="S ZF=$S($ZB#256=27:$C(27,$ZB\256),$ZB>31&($ZB<127):$C(0),1:$C($ZB#256))"
 S ^("TERM-OFF")="S ZAA02G(1)=ZAA02G(1)-1 U:'ZAA02G(1) 0:(:::::524353:::$C(13))"
 S ^("ERROR")="$ZT"
 S ^("ERRORR")="$ZE"
 S ^("WRAP-ON")="U:'ZAA02G(1) 0:^ZAA02G(""MARGIN"")"
 S ^("WRAP-OFF")="U 0:0"
 S ^("8BIT")="S ZAA02G(""T"")=""S ZF=$S($ZB\256:$C(27,$ZB\256),$ZB=127:$C(27,126),$ZB=8:$C(127),$ZB>31:$C(0),1:$C($ZB#256)) X:$ZB=0 """"U 0:(::::1) R *ZF:0 U:ZAA02G(1)#1=0 0:(:::::1) S ZF=$S(ZF<1:$C(0),1:$C(27,ZF))"""""""
 S ^ZAA02G("INIT")="K ZAA02G W:$D(^ZAA02G($I))=0 !!,""Device not defined to the Toolkit - Use ^ZAA02GDEV"",!! Q:$D(^($I))=0  S ZAA02G=^($I),ZAA02G(1)=0,ZAA02G(""T"")=^(""TERMST""),ZAA02GP=^(0,ZAA02G,""P"") X ""F ZAA02GI=0:1:5 I $D(^(ZAA02GI)) X ^(ZAA02GI)"" K ZAA02GI W ZAA02G(""SET"")"
 S ^("EXT")="$TR"
 Q
