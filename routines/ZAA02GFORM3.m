ZAA02GFORM3 ;PG&A,ZAA02G-FORM,2.62,;28DEC94 9:44A;;;30JAN96  21:06
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
DOIT D Y
EXIT Q
 ;
Y B
 Q
 ;
NOHELP I go'["FORMD",$P(Y,"`",13)="" S USERZ(1)="Sorry, no help available" Q
 I go["FORMD" F J=1:1:9 S USERZ(J)=$P("DATE FIELD -  The format is:,,       MM/DD/YY"_$S(ln>8:"YY",1:"")_",,Allowable keys are:,,    1234567890,    T for today,    T+x or T-x for today +/- x",",",J) G NOHELPX:J=9
 F J=1:1:7 S USERZ(J)=$P("Current field is a multiple.;;Allowable keys are:;   Scroll Up or Down;   Prev, Next or 1st Screen;   Insert or Delete Character;   Insert or Delete Lines",";",J)
NOHELPX Q
 ;
UND D:$D(^ZAA02G(.1,ZAA02G,1))=0 UND^ZAA02GDEV4 Q:$D(^ZAA02G(.1,ZAA02G,1))=0  S X=$C(27)_1_$C(13)_"1"_$C(9)_"2"_ZAA02G("INK")_"I"_ZAA02G("DLK")_"J" F I=1:1:4 S X=X_ZAA02G($P("UK,DK,RK,LK",",",I))_(I+2)
 S B=^ZAA02G(.1,ZAA02G,2),E=^(5),Y="" F I=1:1:28 S:I=16 B=^(3),E=^(6) S D=$P(B,"`",I) I D'="" S A=$P("E1;E2;E3;B;C;D;F;A;;H;Z;U;;;L;;;;E4;W;;M;;;K;;Y;X",";",I) I A'="" S C="C=$C("_D_")",@C,X=X_C_A,Y=Y_$P(E,"`",I)_"`"
 S X=X_$C(127)_7_$C(26)_7_$C(8)_7,^ZAA02GDISP(95,ZAA02G,4)=X,^(5)=Y,^ZAA02GDISP(95,ZAA02G,1)=^ZAA02G(.1,ZAA02G,1)
 K Y,C,E,X Q
 ;
SCUPDN I Y#2=0 S A=$P(^ZAA02GDISP(SCR,SN,$P(Y,"`",11)),"`",17),k=0 G:A="" ER^@go G SCDNA:j="C",SCUPA
 G:j="C" SCDN
SCUP S A=$P(Y,"`",9) G:$P(Y,"`",18)[2 TR
SCUPA W:0 p,$J("",ln) S B=$S(X="":"",$D(@A):X,1:$O(@A)),(j,X)="" F a=1:1:100 S X=$O(@A) Q:X=""  Q:B=X  S j=X
 S X=j S:a=100 X=B I X]"",$P(Y,"`",18)=1 S X=@A
 G TO
SCDN S A=$P(Y,"`",9),k=$P(Y,"`",18) G:k[2 TR
SCDNA W:0 p,$E(sp,1,ln+1) S X=$O(@A) I X]"",$D(@A)#2,k=1 S X=@A
TO X $P(Y,"`",4) W p,ro,D S X=$P(D,ee) ;table output
 I $D(key),ln["D" D:X="" CLEAR1^ZAA02GFORM0A I X]"" X:0 $P(Y,"`",$P(Y,"`",17)]""+16) I  X $P(Y,"`",2) D REFR^ZAA02GFORM5
TR W p S l=0 G RD^@go
 ;
TO1 S go="ZAA02GFORM1" G TO
 ;
 ;T1 S X=@$P(Y,"`",18) Q
 ;
FT S i=X D FT1 S RX="0,A",k=X,X=i I k="Y" S:$P(Y,"`",12)'["D" X=sdf_X S RX=1
 K k,i Q
FT1 I $P(Y,"`",12)["FN" S X="Y" Q
 N Y S Y="30,12\RHL\1\\\Table item not found*,*,Enter "_$S($D(key):"a new item",1:"as free text")_"? (Y or N) * ",CHR="YN",UC=1,LNG=1,X="" G POP^ZAA02GFORM4
 ;
ERR S USERZ="ERROR CONDITION:  " S:$D(A)#2 USERZ=USERZ_A_". ",A=""
 S hi=$P(^ZAA02GDISP(SCR,SN,$P(Y,"`",11)),"`",7) I hi["/" S hi=$P(hi,"/",2)
 S RX=0 D DECODE W *7 X ho K hi,USERZ,hp,ho,hs
 I RX S @e@(I)=$P(X,"`",2),X=$P(X,"`"),@($P(Y,"`",10)_"=X")
 Q
 ;
HELP S hi=$P($P(^ZAA02GDISP(SCR,SN,$P(Y,"`",11)),"`",7),"/",1) I hi="" S hi=$G(formHELP) I hi="" D NOHELP
 D DECODE X ho k USERZ,ho,hi,hm,hs Q
 ;
DECODE I $P(Y,"`",13)="" S %R=$P(Y,"`",3),%C=+$P(%R,",",2),%R=+%R
 E  S %R=cr+ls-lp,%C=lm+W+1
 S ho=$P(hi,";",2),hs=$P(hi,";",1),hp=$P(hi,";",3)
 S ho=$S("Ww"[ho:"G HEPOP^ZAA02GFORM4","GgDd"[ho:"D "_hs,"Xx"[ho:"X "_hs,1:"W *7")
 Q
