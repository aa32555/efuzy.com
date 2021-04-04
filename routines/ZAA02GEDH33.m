%ZAA02GEDH33
	F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
	W "." G ^ZAA02GEDH34
D Q
	;;14110;Intrinsic Function:  $PIECE||29
	;;14110,0,"SET $PIECE(DATE,DEL,2)";"31"
	;;14110,1,1;~<Syntax:>~
	;;14110,1,2;  $PIECE(E1,E2)     ...where E1 and E2 yield strings
	;;14110,1,3;  $P(E1,E2,I3)      ...where I3 is an integer
	;;14110,1,4;  $P(E1,E2,I3,I4)   ...where I4 is an integer
	;;14110,1,5;
	;;14110,1,6;~<Examples:>~
	;;14110,1,7;  $P("12/31/90","/",2)  "31"
	;;14110,1,8;  $P("76A666","6",1,4)  "76A66"
	;;14110,1,9;  $P("ABCDEF","CD",2)   "EF"
	;;14110,1,10;  $P(ST,",",2)          "" if ST contains no comma
	;;14110,1,11;  $P(ST,",")            ST if ST contains no comma
	;;14110,1,12;
	;;14110,1,13;~<Explanation:>~  $PIECE takes from string E1, that substring
	;;14110,1,14;which lies between two specified occurrences of a particular
	;;14110,1,15;dividing string (or delimiter), E2.  The resulting substring
	;;14110,1,16;begins immediately after the (I3-1)th occurrence of the
	;;14110,1,17;delimiter and ends immediately before the (I4)th occurrence. ;
	;;14110,1,18;I4 is assumed to equal I3 if I4 is not specified, while I3
	;;14110,1,19;is assumed to have a value of 1 if it is not specified. ;
	;;14110,1,20;
	;;14110,1,21;NOTE:  the $PIECE syntax can occur on the left side of the
	;;14110,1,22;"=" sign in a SET command argument, as in the following ex-
	;;14110,1,23;ample:
	;;14110,1,24;
	;;14110,1,25;  If DATE = "12//90" and DEL = "/", then the statement
	;;14110,1,26;
	;;14110,1,27;             ~<SET $PIECE(DATE,DEL,2)="31">~
	;;14110,1,28;
	;;14110,1,29;will result in DATE = "12/31/90". ;
	;;14120;Intrinsic Function:  $QUERY||15
	;;14120,1,1;~<Syntax:>~
	;;14120,1,2;  $QUERY(VN)         ...where VN is a variable name
	;;14120,1,3;  $Q(VN)
	;;14120,1,4;
	;;14120,1,5;~<Examples:            Results>~
	;;14120,1,6;  If an array contains nodes A(3), A(8), A(8,3,7), A(9)
	;;14120,1,7;  $Q(A)              "A(3)"
	;;14120,1,8;  $Q(A(3))           "A(8)"
	;;14120,1,9;  $Q(A(8))           "A(8,3,7)"
	;;14120,1,10;  $Q(A(9,1))         ""
	;;14120,1,11;
	;;14120,1,12;~<Explanation:>~  $QUERY returns the next subscripted VN (in
	;;14120,1,13;collated sequence) that has a value.  If no subscripted
	;;14120,1,14;variable within the array follows VN, a null value is
	;;14120,1,15;returned. ;
	;;14130;Intrinsic Function:  $RANDOM||10
	;;14130,1,1;~<Syntax:>~
	;;14130,1,2;  $RANDOM(I1)       ...where I1 is an integer
	;;14130,1,3;
	;;14130,1,4;~<Examples:           Results>~
	;;14130,1,5;  $R(2)             0 or 1
	;;14130,1,6;  $R(100)           Integer between 0 and 100
	;;14130,1,7;
	;;14130,1,8;~<Explanation:>~  $RANDOM returns an integer in the range 0
	;;14130,1,9;through I1 minus one.  Each integer value has equal prob-
	;;14130,1,10;ability of occurrence. ;
	;;14140;Intrinsic Function:  $SELECT||19
	;;14140,1,1;~<Syntax:>~
	;;14140,1,2;  $SELECT(T1:E1,T2:E2...Tn:En)
	;;14140,1,3;                        ...where T1 is a truth expression
	;;14140,1,4;                        and E1 is a value expression
	;;14140,1,5;
	;;14140,1,6;~<Examples:               Results>~
	;;14140,1,7;  $S(A=3:5,1:0)         5 if A = 3, otherwise 0
	;;14140,1,8;  $S(X=7:"HI",1:"BYE")  "BYE" if X does not equal 7
	;;14140,1,9;  $S(Z=1:1,Z<0:0,1:2)   0 if Z is negative
	;;14140,1,10;
	;;14140,1,11;~<Explanation:>~  $SELECT evaluates the left-hand expression in
	;;14140,1,12;each of a series of expression pairs, one at a time, in left
	;
	;