ZAA02GFRMM4 ;PG&A,ZAA02G-FORM,2.62,MAINTENANCE - XPORT;8DEC95 9:20A;;;03JUN2004  13:55
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
 ; Scans screen series and prepares for export
 ;
T1 S gl=X,%R=3,%C=1 W:'$D(qt) @ZAA02GP,ZAA02G("CS"),! G T1A:SCR="ALL" S scr="" F J=1:1 S scr=$O(SCR(scr)) G:scr="" DONE D T2
 Q
T1A S scr=99 F J=1:1 S scr=$O(^ZAA02GDISP(scr)) G:scr="" DONE D T2
 ;
T2 G:$D(SCR(scr))>1 T2A S sn="" F J=1:1 S sn=$O(^ZAA02GDISP(scr,sn)) Q:sn=""  D T3
 Q
T2A S sn="" F J=1:1 S sn=$O(SCR(scr,sn)) Q:sn=""  D T3
 Q
 ;
T3 W:$X>65 ! W ?$X+19\20*20+5,scr,"-",sn S @gl@(scr,sn)=$H,@gl@(scr,sn,0)=^ZAA02GDISP(scr,sn) I $D(^ZAA02GDISP(scr,sn,.02)) S @gl@(scr,sn,0,.02)=^(.02)
 S a=":" F i=0:0 S a=$O(^ZAA02GDISP(scr,sn,a)) Q:a=""  S @gl@(scr,sn,0,a)=^(a),%R="" F i=0:0 S %R=$O(^ZAA02GDISP(scr,sn,a,%R)) Q:%R=""  S @gl@(scr,sn,0,a,%R)=^(%R)
 S ss=scr_"-"_sn S @gl@(scr,sn,1)=^ZAA02GDISPL(ss)
 S a=0 F i=0:0 S a=$O(^ZAA02GDISPL(ss,a)) Q:+a'=a  S @gl@(scr,sn,1,a)=^(a)
 S a="" F i=0:0 S a=$O(^ZAA02GDISPL(ss,">",a)) Q:a=""  S %R=^(a) D DECODE S @gl@(scr,sn,1,">",a)=b
 S a=">" F i=0:0 S a=$O(^ZAA02GDISPL(ss,a)) Q:a=""  S %R="" F i=0:0 S %R=$O(^ZAA02GDISPL(ss,a,%R)) Q:%R=""  S %C="" F i=0:0 S %C=$O(^ZAA02GDISPL(ss,a,%R,%C)) Q:%C=""  S @gl@(scr,sn,1,a,%R,%C)=$TR(^(%C),$C(1),"*")
 Q
 ;
DONE K scr,sn,gl Q
 ;
 ;
REBUILD S SCR=0,SN="",gl=X S %R=3,%C=1 W:'$D(qt) @ZAA02GP,ZAA02G("CS") S %C=30,%R=6 W:'$D(qt) @ZAA02GP,ZAA02G("HI"),"WAIT WHILE RESTORING"
 F i=0:0 S SCR=$O(@gl@(SCR)) Q:SCR=""  D SCR
 G DONE
 ;
SCR S ACOMPILE="BUILD" F i=0:0 S SN=$O(@gl@(SCR,SN)) Q:SN=""  S ss=SCR_"-"_SN D C1,BUILD^ZAA02GFRME1
 Q
 ;
C1 K ^ZAA02GDISP(SCR,SN),^ZAA02GDISPL(ss) S a="",^ZAA02GDISP(SCR,SN)=@gl@(SCR,SN,0)
 F i=0:0 s a=$O(@gl@(SCR,SN,0,a)) Q:a=""  S ^ZAA02GDISP(SCR,SN,a)=^(a),%R="" F i=0:0 S %R=$O(@gl@(SCR,SN,0,a,%R)) Q:%R=""  S ^ZAA02GDISP(SCR,SN,a,%R)=^(%R)
 S a="",^ZAA02GDISPL(ss)=@gl@(SCR,SN,1) F i=0:0 s a=$O(@gl@(SCR,SN,1,a)) Q:+a'=a  S ^ZAA02GDISPL(ss,a)=^(a)
 S a="" F i=0:0 s a=$O(@gl@(SCR,SN,1,">",a)) Q:a=""  S %R=^(a) D CODE S ^ZAA02GDISPL(ss,">",a)=b
 S a=">" F i=0:0 S a=$O(@gl@(SCR,SN,1,a)) Q:a=""  S %R="" F i=0:0 S %R=$O(@gl@(SCR,SN,1,a,%R)) Q:%R=""  S %C="" F i=0:0 S %C=$O(@gl@(SCR,SN,1,a,%R,%C)) Q:%C=""  S ^ZAA02GDISPL(ss,a,%R,%C)=^(%C)
 Q
 ;
DECODE S b="" F i=1:1:$L(%R) S b=b_$C($A(%R,i)+32)
 Q
CODE S b="" F i=1:1:$L(%R) S b=b_$C($A(%R,i)-32)
 Q
