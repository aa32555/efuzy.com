ZAA02GSCRMI3 ;PG&A,ZAA02G-SCRIPT,2.10,MIDS UTILITIES;9NOV94 4:30P;;;07OCT98  16:31
 ;
 ;
RADINFO ; RADIOLOGY MACRO FOR ADDITIONAL INFORMATION
 N (ZAA02G,ZAA02GP,REFRESH,INP,LC,UP,MC,ZAA02GSCR,DOC) S (MC,X,REFRESH)="",Y="20,5\RHLYWD\1\Radiology Additional Information\\"
 F J=1:1:5 S Y(J)=$P("*,     Exam Reason: *,     Findings:    *,     RR ICD-9:    *,     RAD ICD-9:   *",",",J)
 S (X1,X2,X3,X4)="" I $G(INP("RADINFO"))]"" S X1=INP("RADINFO"),X2=$P(X1,"`",2),X3=$P(X1,"`",3),X4=$P(X1,"`",4),X1=$P(X1,"`")
 S Y(2)=Y(2)_X1,Y(3)=Y(3)_X2,Y(4)=Y(4)_X3,Y(5)=Y(5)_X4 D ^ZAA02GPOP
RADIN4 S %R=7,%C=40,Y="1\HR\HRS\\DK,EX\",X=X1 D ^ZAA02GRDF S X1=X G RADIN3:ZAA02GF="EX"
RADIN4A S %R=8,%C=40,Y="1\HR\RS\\UK,DK,EX\",X=X2 D ^ZAA02GRDF S X2=X G:ZAA02GF="UK" RADIN4
RADIN4B S %R=9,%C=40,Y="5\HR\RS\\UK,DK,EX\",X=X3 D ^ZAA02GRDF D RADICD G:ZAA02GF="" RADIN4B S X3=X G:ZAA02GF="UK" RADIN4A
RADIN4C S %R=10,%C=40,Y="5\HR\RS\\UK,EX\",X=X4 D ^ZAA02GRDF D RADICD G:ZAA02GF="" RADIN4C S X4=X G:ZAA02GF="UK" RADIN4B
RADIN3 I X1_X2_X3_X4]"" S INP("RADINFO")=X1_"`"_X2_"`"_X3_"`"_X4 S @ZAA02GSCR@("TRANS",DOC,.011,"RADINFO")=INP("RADINFO") Q
 K INP("RADINFO") K @ZAA02GSCR@("TRANS",DOC,.011,"RADINFO") Q
RADICD Q:X=""  I +X>0,$D(^ICD9(X)) Q
 I +X>0 S ZAA02GF="" Q
 D RADICDP I X[";EX" S (ZAA02GF,X)=""
 W ZAA02G("RON"),@ZAA02GP,$J("",5),@ZAA02GP,X Q
RADICDP N (X,ZAA02G,ZAA02GP) S Y="25,13\RHLDSG\1\ICD9 CODES\\",Y(0)="8\EX\^ICD9(""A"")\TO;35`$P(^ICD9(""A"",TO),$C(96));8\"_X_"\\\"_X_"|" D ^ZAA02GPOP I X]"",X'[";EX" S X=$P(^ICD9("A",X),"`")
 ;
 ;
ORD ; ORDER POP-UP
