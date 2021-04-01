%ZAA02GEDC1 ;;%AA UTILS;1.24;UTIL: POCKET CALC;03MAY91  11:41
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
MODE S %R=TR+4,%C=FC+2 W @ZAA02GP,tLO," MODE SELECTION " S %R=%R+1
        F I=1:1:5 S %R=%R+1,J=$P("Display,Fixed Dec.,",",",I) W @ZAA02GP,J,$J("",16-$L(J))
        S %R=TR+5,%C=FC+14 F I=1:1:2 S %R=%R+1 W @ZAA02GP,$S(@("ZAA02G"_I):"ON ",1:"OFF")
        S %R=TR+5,%C=FC+14 F I=1:1:2 S A="ZAA02G"_I,%R=%R+1 F J=@A:1 W @ZAA02GP,$S(J#2:"ON ",1:"OFF") R B#1 Q:B=""  S @A=J+1#2
        S:'DF ZAA02G1=0 W tLO D FACE^ZAA02GEDC W tHI,ZAA02GK S ZAA02GJ=$S(ZAA02G2:"$J(AC,12,2)",1:"$J(AC,12)") Q
FNC S %R=TR+3,%C=FC+2,FS="SQRT,N.LOG,EXP,SINE,COS,DEG to RAD,RAD to DEG",J=1
        W tLO F I=1:1:7 S %R=TR+I+3,FN=$P(FS,",",I) W @ZAA02GP,"   ",FN,$J("",14-$L(FN))
F1 S %R=TR+J+3,%C=FC+3,FN=$P(FS,",",J) W @ZAA02GP,tHI_"=>"_ZAA02G("RON")_FN_$J("",12-$L(FN))_ZAA02G("ROF"),@ZAA02GP
        S A=EN D @$P("SQRT,LN,EXP,SIN,COS,DTR,RTD",",",J) S:EN>1E11 EN=" overflow" S:$L(EN)>12 EN=$E(EN,1,12) W ZAA02GQ,$J(EN,12)
        W @ZAA02GP S FK="" R B#1 I B="" X ZAA02G("T") S FK=$P(ZAA02GY,"\",$A(ZAA02GX,$F(ZAA02GX,ZF))+2) G:FK="CR" F2 I FK="EX" S EN="0." G F2
        S EN=A,FK=$S(B=" ":"DK",B="E":"EX",1:FK) W tLO_"  "_FN_$J("",12-$L(FN)) S J=$S(FK="UK":J-1,FK="DK":J+1,1:J) S:J>7 J=1 S:J<1 J=7 G F1
F2 W ZAA02GQ,$J(EN,12),tLO D FACE^ZAA02GEDC W tHI,ZAA02GK Q
LN S %F=EN,(%E,%D)=0 Q:EN'>0  F I=1:1 Q:%F<1  S %F=.5*%F,%D=%D+1
        F I=1:1 Q:%F'<.5  S %F=2*%F,%D=%D-1
        S %F=(%F-.707107)/(%F+.707107),%E=%F*%F,EN=$J((((.598979*%E+.961471)*%E+2.88539)*%F+%D-.5)*.693147,1,6) K %E,%F,%D Q
EXP S %E=0,%B=1.4427*EN\1+1 Q:%B>90  S %E=.693147*%B-EN,%A=.00132988-(.000141316*%E),%A=((%A*%E-.00830136)*%E+.0416574)*%E,%E=(((%A-.166665)*%E+.5)*%E-1)*%E+1,%A=2 S:%B'>0 %A=.5,%B=-%B F %I=1:1:%B S %E=%A*%E
        S EN=$J(%E,1,6) K %A,%B,%I,%E Q
SIN S %E=EN F I=1:1 S:%E<-1.570796 %E=-3.14159265-%E Q:%E'>3.14159265  S %E=%E-6.2831853
        S %D=%E,%Y=%E,%B=1,%A=-1 F %F=3:2:11 S %B=%B*(%F-1)*%F,%D=%D*%E*%E,%Y=%D/%B*%A+%Y,%A=-%A
        S EN=$J(%Y,1,5) K %E,%D,%F,%A,%B,%Y Q
COS S %E=EN+1.570796 F I=1:1 S:%E<-1.570796 %E=-3.14159265-%E Q:%E'>3.14159265  S %E=%E-6.2831853
        S %D=%E,%Y=%E,%B=1,%A=-1 F %F=3:2:11 S %B=%B*(%F-1)*%F,%D=%D*%E*%E,%Y=%D/%B*%A+%Y,%A=-%A
        S EN=$J(%Y,1,5) K %E,%D,%F,%A,%B,%Y Q
DTR S EN=EN/57.29577951 Q
RTD S EN=EN*57.29577951 Q
SQRT S %Y=0 Q:EN'>0  S %Y=EN+1/2 F I=1:1 S %F=%Y,%Y=EN/%F+%F/2 Q:%Y'<%F
        S EN=%Y K %Y,%F Q
HELP I DF S (PR,PC,%C)=1,%R=0 F I=2:1:25 S %R=%R+1,J=$P($T(HELP+I),";;",2,9) W @ZAA02GP,J,$J("",%R<12*25+54-$L(J))
        W ZAA02GK Q
        ;;                         ZAA02GPC QUICK REFERENCE GUIDE
        ;;
        ;;Operators      Addition     + and RETURN key       Division     / key
        ;;               Subtraction  - key                  Equals       = and , key
        ;;               Multiply     * and X key            Percent      % key
        ;;
        ;;Clear          Press C once to clear current entry
        ;;               Press C twice to clear entire calculation
        ;;
        ;;Mark Up/Down   Use the % key to calculate mark-up
        ;;               mark-down problems as follows:
        ;;                 300 [-] 15 [%]  yields  255
        ;;                 65  [+] 35 [%]  yields  87.75
        ;;
        ;;Mode           Display ON - displays result on screen
        ;;               Fixed Dec. ON - rounding to 2 places
        ;;
        ;;Functions      Move to function and press RETURN
        ;;
        ;;Constants      To repeat constant calculations, first
        ;;               enter constant, operator, operand and
        ;;               [=], then to repeat, enter operand
        ;;               followed by [=] for each calculation
        ;;
        ;
