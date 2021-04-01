ZAA02GFAXP ;PG&A,ZAA02G-FAX,1.36,PARAMETERS;25OCT95 3:17P;;;10JUN98  11:27
 ;Copyright (C) 1991-1994, Patterson, Gray and Associates Inc.
BEG1 N YY D GETY S OLD=$S($D(^ZAA02GFAXC("FAX")):^("FAX"),1:""),DATA="DATA1",NE=40 D GETY1,BEGX S:OLD'=NEW ^ZAA02GFAXC("FAX")=NEW G END
 ;
BEG2 N YY D GETY S $P(Y,"\")=$P(Y,"\",2),OLD="\\\1\.5\11\8.5\2\2\30\90\2\20\10\B",OLD=$S($D(^ZAA02GFAXC("CONFIG")):^("CONFIG"),1:OLD),DATA="DATA2",NE=18,OTXT="",TT=$P(OLD,"\",2) D TT S OTXT=TT D GETY2,BEGX,FTR S:NEW'=OLD ^ZAA02GFAXC("CONFIG")=NEW G END
BEG3 N YY D GETY S $P(Y,"\")=$P(Y,"\",3),OLD=$S($D(^ZAA02GFAXC("DEFLTS")):^("DEFLTS"),1:"P\N\N\Y\A\9\3"),DATA="DATA3",NE=7 D GETY3,BEGX S:NEW'=OLD ^ZAA02GFAXC("DEFLTS")=NEW G END
BEGX S %R=1,%C=20 W @ZAA02GP,$J("",44) S %C=82-$L($P(Y,"\"))\2 W @ZAA02GP,$P(Y,"\") S NEW=OLD,%R=3,%C=2 W @ZAA02GP,ZAA02G("CS"),ZAA02G("LO")
 S L=".................................................................",PX=0 G ^ZAA02GFAXP1
END K TT,SS,PP,YY,NEW,OLD,PX Q
GETY1 S YY=$S('$D(ZAA02G(9)):"Fax/Modem #* ($I value)\Deactivate #*\\Dialing Prefix (ATDTx)\Speaker (0 or 1)\",1:@ZAA02G(9)@(74))
 F J=1:1:10 S YY(J)=$TR(YY,"*",J)
 Q
GETY2 S YY(1)=$S('$D(ZAA02G(9)):"Site Name\Footer Message\Custom Logo File\Confirmation Device\Confirmation Routine\Top Margin (inches)\Left Margin (inches)\Page Length (inches)\Page Width (inches)\Site Phone#",1:@ZAA02G(9)@(72))
 S YY(2)=$S('$D(ZAA02G(9)):"Source File Retention (days)\Fax File Retention (days)\Error File Retention (days)\Directory Retention (days)\Maximum Background Jobs\Max Scan Threshold\Max # jobs to send per 1 dial\Cover Sheet Color (W or B)",1:@ZAA02G(9)@(73)) Q
 ;
GETY3 S YY(1)=$S('$D(ZAA02G(9)):"Cover Sheet (Y,N,P)\Page #s (Y,N)\Border (Y,N)\Full Page (Y,N)\Font (A,B,C,D,G)\Transmission Speed (1,4,7,9)\Retry Count",1:@ZAA02G(9)@(76))
 Q
GETY S Y=$S('$D(ZAA02G(9)):"F A X / M O D E M   P A R A M E T E R S\B A S I C   C O N F I G U R A T I O N\S Y S T E M   D E F A U L T S\Type *E*dit  or press *EXIT KEY* to quit\Edit fields as needed - Press *EXIT* to quit\",1:@ZAA02G(9)@(66)) Q
FTR S TXT="",TT=$P(NEW,"\",2) D TT S TXT=TT I TXT'=OTXT S %R=22,%C=5 W @ZAA02GP,"Wait." D INTZ^ZAA02GFAXIN1 D:TXT'="" FT^ZAA02GFAXD
 Q
TT S TT=$S(TT="":"",$E(TT)'="^":TT,$D(@TT)#2:@TT,1:"") Q
