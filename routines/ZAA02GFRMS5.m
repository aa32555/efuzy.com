ZAA02GFRMS5 ;PG&A,ZAA02G-FORM,2.62,;13FEB91 5:04P
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 S SCR="SAMPLE",SN=3 K ^ZAA02GDISP(SCR,SN) S ^ZAA02GDISP(SCR,SN)="1,3``SAMPLE-3`DISCHARGE ABSTRACT``````H`L`R``````"
 F i=0:1 S x=$T(@i) Q:x=""  S x=$P(x,";",2,999),^ZAA02GDISP(SCR,SN,$P(x,"~"))=$P(x,"~",2,999)
 F i=i+1:1 S x=$T(@i) Q:x=""  S x=$P(x,";",2,999),^ZAA02GDISP(SCR,SN,$P(x,"`"))=$P(x,"`",3,999),^($P(x,"`"),0)=$P(x,"`",2)
 I $S<5500 S $P(^ZAA02GDISP(SCR,SN,">DX"),"`",13)="N" I $S<5000 S $P(^(">RX"),"`",13)="N"
 G ^ZAA02GFRMS6
0 ;.02~1,3,2,4,5,6
2 ;>DX`SAMPLE-3`8`11`8,2`79`2`5`Y``^ZAA02GFORMS(PN,"DX")`Y`>DX```5``````DXN,`1,2;DX,DXREMARK,
3 ;>RX`SAMPLE-3`18`18`18,2`79`4`6`````>RX```6``````RXN,`1,2,3;RX,PDATE,RXPHY,
4 ;AGE`SAMPLE-3``PDEMO`2,47`$P(X,";",2)`3``````AGE`````````Y
5 ;ATTENDING`SAMPLE-3`Y`^ZAA02GFORMS(PN,"D")`4,47`$P(X,"\",3)`3`X?3N```^ZAA02GFORMS(100,X)``ATTENDING`20``3`````````5\YCHRLT\1\Attending Physicians
6 ;CONSULT`SAMPLE-3``^ZAA02GFORMS(PN,"D",1)`5,50``3`X?3N```^ZAA02GFORMS(100,X)``CONSULT`20``4```````V,2,V,1,5,C``30\YRCHLT\1\Consulting Physicians
7 ;DOB`SAMPLE-3``PDEMO`2,60`$P(X,";",3)`12``````DOB`````````Y
8 ;DOD`SAMPLE-3`Y`^ZAA02GFORMS(PN,"D")`4,20`$P(X,"\",1)`12``````DOD```1``````C
9 ;DX`>DX``^ZAA02GFORMS(PN,"DX",n(1))`8,14``7````^ZAA02GFORMS(99,X)``DX`30``501`````````40,9\YRHLT\1\ICD-9 Dx
10 ;DXN`>DX``n(1)`8,2``3`````S X=X_$S(X=1:"st",X=2:"nd",X=3:"rd",1:"th")`DXN`````````Y
11 ;DXREMARK`>DX``^ZAA02GFORMS(PN,"DX",n(1),1)`9,9``70``````DXREMARK```502```````V,2,V,1,5,W
12 ;PDATE`>RX``^ZAA02GFORMS(PN,"RX",n(1))`18,32`$P(X,"\",2)`12``````PDATE```602``````C
13 ;PNAME`SAMPLE-3``PNAME`2,10``20``````PNAME`````````Y
14 ;RX`>RX``^ZAA02GFORMS(PN,"RX",n(1))`18,5`$P(X,"\",1)`4````^ZAA02GFORMS(98,X)``RX`25``601`````````30,9\YRHLT\1\Procedure Codes
15 ;RXN`>RX``n(1)`18,2``1``````RXN```601``````Y
16 ;RXPHY`>RX``^ZAA02GFORMS(PN,"RX",n(1))`18,49`$P(X,"\",3)`3`X?3N``ATTENDING`^ZAA02GFORMS(100,X)``RXPHY`20``603`````````5,8\YRHLT\1\Rx Physician
17 ;SEX`SAMPLE-3``PDEMO`2,35`$P(X,";",1)`6``````SEX`````````Y
18 ;TOD`SAMPLE-3``^ZAA02GFORMS(PN,"D")`5,20`$P(X,"\",2)`5`X?2N1P2N,X<25,$E(X,5,6)<61`````TOD```2
