ZAA02GFRMS7 ;PG&A,ZAA02G-FORM,2.62;
 S SCR="Z",SN=1 K ^ZAA02GDISP(SCR,SN) S ^ZAA02GDISP(SCR,SN)="``Z-1`NESTED 3 DEEP``````H`L`R``Y"
 F i=0:1 S x=$T(@i) Q:x=""  S x=$P(x,";",2,999),^ZAA02GDISP(SCR,SN,$P(x,"~"))=$P(x,"~",2,999)
 F i=i+1:1 S x=$T(@i) Q:x=""  S x=$P(x,";",2,999),^ZAA02GDISP(SCR,SN,$P(x,"`"))=$P(x,"`",3,999),^($P(x,"`"),0)=$P(x,"`",2)
 G ^ZAA02GFRMS8
0 ;.02~1,2
2 ;>BILLING`>PROC`4`4`4,24`78`2`6```^p(id,n(1),n(2),0)``>BILLING```20202``````BCN,`1,2;BILLCODE,UNITS,
3 ;>N`A-1`2`5`2,1`80`3`5`Y``?``>N`````````
4 ;>PROC`>VISIT`4`5`4,2`79`2`5```^p(id,n(1),0)``>PROC```202``````PN,`1,2;PROC,>BILLING,
5 ;>VISIT`Z-1`2`8`2,1`80`3`7`````>VISIT```2```````1,2;VDATE,>PROC,
6 ;BCN`>BILLING``n(3)`4,24``1``````BCN`````````Y
7 ;BILLCODE`>BILLING``^p(id,n(1),n(2),n(3))`4,35`$P(X,"\",1)`10``````BILLCODE```2020201
8 ;FIELD`A-1``TEST`1,8``10``````FIELD
9 ;PN`>PROC``n(2)`4,2``1``````PN`````````Y
10 ;PNAME`Z-1``^p(id)`1,14``30``````PNAME```1
11 ;PROC`>PROC``^p(id,n(1),n(2))`4,14``5``````PROC```20201
12 ;UNITS`>BILLING``^p(id,n(1),n(2),n(3))`4,52`$P(X,"\",2)`10``````UNITS```2020202
13 ;VDATE`>VISIT``^p(id,n(1))`3,13``12``````VDATE```201
