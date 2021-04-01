ZAA02GFRMS1 ;PG&A,ZAA02G-FORM,2.62,SAMPLER, PART 2;25JUL86 12:21A
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
BEG S SCR="SAMPLE",SN=1 K ^ZAA02GDISP(SCR,SN),^ZAA02GDISPL(SCR_"-"_SN) S ^ZAA02GDISP(SCR,SN)="``SAMPLE-1`SAMPLE ROLODEX FILE``````H`L`UH" F I=0:1 S A=$P($T(A+I),";",2,99) Q:A=""  S ^ZAA02GDISP(SCR,SN,$P(A,"`",11))=A
 S ^(.02)="1:1:8"
 S ^ZAA02GDISPL(SCR_"-"_SN)="\\12/30/85" F I=0:1 S A=$P($T(C+I),";",2,255) Q:A=""  S ^ZAA02GDISPL(SCR_"-"_SN,$P(A,","))=$P(A,",",2,255)
 G ^ZAA02GFRMS2
A ;`^ZAA02GFORMS(1,1)`9,26`X`30``````ADDRESS```4```````V,2,,,4
 ;`^ZAA02GFORMS(1)`11,26`$P(X,"\",8)`20``````CITY```5
 ;Y`^ZAA02GFORMS(1)`8,26`$P(X,"\",3)`30``````LAST```3
 ;`^ZAA02GFORMS(1)`7,54`$P(X,"\",2)`2``````MI```2
 ;`^ZAA02GFORMS(1)`7,26`$P(X,"\",1)`20``^ZAA02GFORMS("H","NAME");W````NAME```1
 ;`^ZAA02GFORMS(1,5)`12,26`X`37``````REMARKS```8```````V,3,,,6,W
 ;`^ZAA02GFORMS(1)`11,50`$P(X,"\",9)`2`X?2U`````STATE```6`````````
 ;`^ZAA02GFORMS(1)`11,57`$P(X,"\",10)`6`X?5N`````ZIP```7
 ;
C ;21,$.!$/"$0"$1"$2"$3"$4"$5"$6"$7"$8"$9"$:"$;"$<"$="$>"$?"$@"$A"$B"$C"$D"$E"$F"$G"$H"$I"$J"$K"$L"$M"$N"$O"$P"$Q"$R"$S"$T"$U"$V"$W"$X"$Y"$Z"$["$\"$]"$^"$_"$`#%.$%`$&.$&`$'.$'`$(.$(`$).$)`$*.$*`$+.$+`$,.$,`$-.$-`$..$.A!.B".C".D#.L!.M".N".O#.`$/.$/A&
 ;22,/B#/C!/D%/L&/M#/N!/O%/`$0.&0/"00"01"02"03"04"05"06"07"08"09"0:"0;"0<"0="0>"0?"0@"0A"0B%0C&0D"0E"0F"0G"0H"0I"0J"0K"0L"0M%0N&0O"0P"0Q"0R"0S"0T"0U"0V"0W"0X"0Y"0Z"0["0\"0]"0^"0_"0`%
 ;41,&1F&2i&3r&4s&5t&OM&P.&QI&R.'1L'2a'3s'4t(1A(2d(3d(4r(5e(6s(7s*1C*2i*3t*4y*NS*Ot*TZ*UI*VP+1R+2e+3m+4a+5r+6k+7s
 ;61,"4!"5""6""7""8""9"":"";""<""="">""?""@""A""B""C""D""E""F""G""H""I""J""K""L""M""N""O""P""Q""R""S""T""U""V""W""X""Y""Z""[""\""]""^""_""`""a""b""c""d##1!#2"#3"#4"#5"#6"#7"#8"#9"#:"#;"#<"#="#>"#?"#@"#A"#B"#C"#D"#E"#F"#G"#H"#I"#J"#K"#L"#M"#N"#O"#P"
 ;62,#Q"#R"#S"#T"#U"#V"#W"#X"#Y"#Z"#["#\"#]"#^"#_"#`"#a"#b##d$$b$$d$%b$%d$&b$&d$'b$'d$(b$(d$)b$)d$*b$*d$+b$+d$,b$,d%-b$.b%
 ;121,22 23R24 26 27O28 2: 2;L2< 2> 2?O2@ 2B 2CD2D 2F 2GE2H 2J 2KX2L 2P 2QF2R 2T 2UI2V 2X 2YL2Z 2\ 2]E2^ 
 ;
