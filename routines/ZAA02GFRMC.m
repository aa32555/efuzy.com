ZAA02GFRMC ;PG&A,ZAA02G-FORM,2.62,Copy a Screen;06DEC93  13:26
 ;Copyright (C) 1986, Patterson, Gray & Associates, Inc.
CTL D ^ZAA02GFRMC2 ;asks SCR(from,to) & SN(from,to).  Returns copy=SCR from_";"_SCR to, copy(SN from)=SN to, copy undefined if unsuccessful
 D SCR:$D(copy)
 Q
 ;
 Q
 ;
SCR S fromscr=$P(copy,";",1),toscr=$P(copy,";",2)
 I $D(copy("ALL")) D ALL
 I '$D(copy("ALL")) S sn="" F i=0:0 S sn=$O(copy(sn)) Q:sn=""  I $D(^ZAA02GDISP(fromscr,sn)) S tosn=copy(sn) D ONE
 H 3 Q
 ;
ALL S sn="" F i=1:1 S sn=$O(^ZAA02GDISP(fromscr,sn)) Q:sn=""  S tosn=sn D ONE
 Q
 ;
ONE I $D(^ZAA02GDISP(toscr,tosn)) W !,"Skipped ",toscr,"-",tosn,".  Already defined",*7 Q
 ; K ^ZAA02GDISP(toscr,tosn),^ZAA02GDISPL(toscr_"-"_tosn)
 S from="^ZAA02GDISP(fromscr,sn)",to="^ZAA02GDISP(toscr,tosn)" D COPY
 S $P(^ZAA02GDISP(toscr,tosn),"`",3)=toscr_"-"_tosn
 S fd=":",from=fromscr_"-"_sn,to=toscr_"-"_tosn F i=1:1 S fd=$O(^ZAA02GDISP(toscr,tosn,fd)) Q:fd=""  S:^(fd,0)=from ^(0)=to I $D(^ZAA02GSCHEMA),$E(fd)="^" S ^ZAA02GSCHEMA(0,$E(fd,2,99),to)=""
 S from="^ZAA02GDISPL(fromscr_""-""_sn)",to="^ZAA02GDISPL(toscr_""-""_tosn)" D COPY
 W !,"Copied ",fromscr,"-",sn," to ",toscr,"-",tosn,"."
 Q
 ;
 ;
COPY S f=0,f(0)=from,t(0)=to,s(0)="" I $D(@from)#10 S @to=@from
 F f=f:0 S s(f)=$O(@f(f)@(s(f))) D NODE I f<0 Q
 Q
 ;
NODE I s(f)="" K f(f),t(f),s(f) S f=f-1 Q
 I $D(@f(f)@(s(f)))#10 S @t(f)@(s(f))=@f(f)@(s(f))
 I $D(@f(f)@(s(f)))>1 S f(f+1)=$E(f(f),1,$L(f(f))-1)_",s("_f_"))",t(f+1)=$E(t(f),1,$L(t(f))-1)_",s("_f_"))",f=f+1,s(f)=""
 Q
