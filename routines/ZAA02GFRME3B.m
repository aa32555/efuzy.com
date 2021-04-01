ZAA02GFRME3B ;PG&A,ZAA02G-FORM,2.62,FORMS EDITOR for GROUPS, PART 4;19NOV93 10:34A;;;05JAN95  10:46
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
 ;
UN Q:scope=GR  S scope=^ZAA02GDISPL("~",$I,0,scope,0)
 D UN2 Q
UN1 D UN S (CD,ST)="" G C4^ZAA02GFRME3
UN2 S put=2 D ^ZAA02GFRME3A
 I scope=GR S CS=1,RS=1,CE=$S($D(wide):132,1:80),RE=24 D LIMITS^ZAA02GFRME8 Q
 S ST=^ZAA02GDISPL("~",$I,0,scope) D RANGE,CLG
 Q
EXK I %R S %C=$O(@ZAA02GG@(.2,%R,%C)) I %C S CD=$P(^(%C),"\",2),ex="D STATUS1 K ex" W:'$d(qt) VIDOF,STL1,ZAA02G("LO"),"Field: ",ZAA02G("HI"),CD,ZAA02G("LO"),"   Press SELECT to select field",VIDON Q
EXK1 S %R=$O(@ZAA02GG@(.2,%R)) G EXK:%R S (%R,%C)=1,CD=$O(^ZAA02GDISPL("~",$I,scope)) S:CD="" CD=$O(^(0)) Q:CD=""  Q:$O(^(CD,""))=""  D SETSC S %R=0 G EXK1
SETSC Q:CD=scope  S scope=CD D STATUS^ZAA02GFRME9,UN2
 Q
 ;
G D INITG,FETCHG,EDIT1^ZAA02GFRME5 K HELP
 D @$S(ST'?."`":"RANGE",1:"UN"),C4^ZAA02GFRME3
 S @ZAA02GG@(.2,+ST,$P(ST,"`",3))=" \"_CD_"\"_VD,$P(ST,"`",3)=(+ST)_","_$P(ST,"`",3),^ZAA02GDISPL("~",$I,0,CD)=ST,A=$S($D(^(CD,0)):^(0),1:scope),^(0)=A,scope=CD
 Q
 ;
CLG S A=+$P(ST,"`",5),%C=CS W:'$d(qt) @ZAA02GP,ZAA02G("Z") F %R=RE+1:1:(RE-RS+1*A+RS-1) W:'$d(qt) @ZAA02GP,$J("",CE-CS+1)
 Q
RANGE F A=1:1:4 S @$P("RS`RE`CS`CE","`",A)=$P(ST,"`",A)
 S:CS["," CS=$P(CS,",",2) D LIMITS^ZAA02GFRME8 Q
 ;
INITG S LL="3,3,3,3,3,40,1*,40,40,20,1*,40,40,40",(DD,SD)="1,2,3,4,5,6,7,8,9,17,10,12,15,16",NE=14,EC=28
 S HD="Top Row;Bottom Row;First Column;Last Column;# of Groups to Display;Maximum # of Groups;Tab Stop (Y or N);Existence Test;Put Group Count Reference;Put Ref $P(X,...);Dense? (Y/N);*"
 S HD1=";;;;;;;;;;;Number Mandatory;Pre-Remove eXecute;Pre-Insert eXecute;" Q
 ;
FETCHG S ST=$S($D(^ZAA02GDISPL("~",$I,0,CD)):^(CD),1:RR_"``"_CC_"`80```Y")
 I $P(ST,"`",2) S ST=$P(ST,"`",1,2)_"`"_(+$P(ST,",",2))_"`"_$P(ST,"`",4,99) D RANGE,CLG
 S HELP="HELP1^ZAA02GFRMEA1" Q
 ;
