ZAA02GDED ;PG&A,ZAA02G-CONFIG,2.25,DATE CONVERSIONS;27DEC89 12:29P;;;20SEP97  10:13
 ;Copyright (C) 1989, Patterson, Gray & Associates, Inc.
FETCH S ZAA02G("d")=$S($D(^ZAA02G("DATEF")):^("DATEF"),1:0) Q
 ;
ANS N m,d,y,o D:'$D(ZAA02G("d")) FETCH I ZAA02G("d")=0 S m=+X-3,d=$P(X,"/",2),y=$P(X,"/",3)
 E  S d=+X,m=$P(X,"/",2)-3,y=$P(X,"/",3)
 Q:(m+d+y)<-2  S:y<100 y=y+1900 S o=$S(y<1900:-14916,y<2000:21608,1:58132),y=$E(y,3,4) S:m<0 m=m+12,y=y-1 S X=1461*y\4,X=153*m+2\5+X+d+o Q
 ;
CALW2 D CALN2 N M S M="Jan\Feb\Mar\Apr\May\Jun\Jul\Aug\Sep\Oct\Nov\Dec" I ZAA02G("d")=0 S X=$P(M,"\",+X)_" "_(+$P(X,"/",2))_", "_$P(X,"/",3) Q
 E  S X=(+X)_" "_$P(M,"\",$P(X,"/",2))_" "_$P(X,"/",3) Q
 ;
CALW3 D CALN4 N M S M="Jan\Feb\Mar\Apr\May\Jun\Jul\Aug\Sep\Oct\Nov\Dec" I ZAA02G("d")=0 S X=$P(M,"\",+X)_" "_(+$P(X,"/",2))_", "_$P(X,"/",3) Q
 E  S X=(+X)_" "_$P(M,"\",$P(X,"/",2))_" "_$P(X,"/",3) Q
 ;
CALW4 D CALN4 N M S M="January\February\March\April\May\June\July\August\September\October\November\December" I ZAA02G("d")=0 S X=$P(M,"\",+X)_" "_(+$P(X,"/",2))_", "_$P(X,"/",3) Q
 E  S X=(+X)_" "_$P(M,"\",$P(X,"/",2))_" "_$P(X,"/",3) Q
 ;
CALN2 Q:X'?5N.E  D:'$D(ZAA02G("d")) FETCH N m,d,y,o S X=+X,o=$S(X<21609:14915,1:-21609),X=X+o,y=4*X+3\1461,d=X*4+7-(1461*y)\4,m=5*d-3\153,d=5*d+2-(153*m)\5,m=m+3 S:m>12 m=m-12,y=y+1 S y=$S(o=14915:y+1800,1:y+1900),y=y#100
 I ZAA02G("d")=0 S X=$E(0,m<10)_m_"/"_$E(0,d<10)_d_"/"_$E(0,y<10)_y Q
 E  S X=$E(0,d<10)_d_"/"_$E(0,m<10)_m_"/"_$E(0,y<10)_y Q
 ;
CALN4 Q:X'?5N.E  D:'$D(ZAA02G("d")) FETCH N m,d,y,o S X=+X,o=$S(X<21609:14915,1:-21609),X=X+o,y=4*X+3\1461,d=X*4+7-(1461*y)\4,m=5*d-3\153,d=5*d+2-(153*m)\5,m=m+3 S:m>12 m=m-12,y=y+1 S y=$S(o=14915:y+1800,1:y+1900)
 I ZAA02G("d")=0 S X=$E(0,m<10)_m_"/"_$E(0,d<10)_d_"/"_y Q
 E  S X=$E(0,d<10)_d_"/"_$E(0,m<10)_m_"/"_y Q
