ZAA02GSCRFX3 ;PG&A,ZAA02G-SCRIPT,2.10,FAX OPERATIONS - DIRECT PRINT;;;;30SEP2002  10:44
 ;Copyright (C) 1996, Patterson, Gray & Associates, Inc.
 ;
PRINT ; AUTOFAX LOGIC FROM PRINT DRIVER FOR MODEM TRANSFERS
 S DONE=0 N I,A,D,S,R G:'$D(@ZAA02GSCR@("PARAM","FAX")) NOFAX
 G:$L($P(^("FAX"),"\",1,2),"Y")'=3 NOFAX
 G QUEUE
NOFAX ;
 Q
 ;
QUEUE Q:$G(DVP)'["MODEM"  X $P(DVP,"\",18) Q:'$D(MODEM)
 S XDC="" F  S XDC=$O(^ZAA02GWP(.9,DP,XDC)) Q:XDC=""  I +$P(^(XDC),"\",9)'=5 S $P(^(XDC),"\",9)=5,DONE=DONE+1
 Q:'DONE
 S FAXPARAM="MODEM```PRINTER`"_MODEM_"``3````Y`````",FAXEXEC="S EXEC=""D PRINTX^ZAA02GSCRFX3"""
 K B,D S ZAA02GWPD="^ZAA02GTFAX($J)" K @ZAA02GWPD D QUEUE^ZAA02GFAXQ
 S ^ZAA02GFAXQ("SRC",JOB,0,0)=DP
 Q
 ;
 ;   enter here from fax driver
PRINTX S DP=^ZAA02GFAXQ("SRC",JOB,0,0),VDV="" N (DP,VDV)
 S VDV("FAX")=$S($D(^ZAA02GFAXC("FAXEXEC")):^("FAXEXEC"),1:"I 1"),XDC=$O(^ZAA02GWP(.9,DP,"")) D:XDC'="" CONT2^ZAA02GWPPC Q
 ;
SETFAX ; INDICATE FAX PENDING
 S ^("IO")=$E($G(@DOC@(.011,"IO")),1,200)_",F*",K=$E($TR($P(@DOC,"`",13),"F~ ")_"F~  ",1,4),$P(@DOC,"`",13)=K,$P(@ZAA02GSCR@("DIR",99,10000000-$P(DOC,""",""",2)),"`",13)=K Q
 ;
 ;
NOTES ; TO OPERATE OFFSITE PRINTERS USING MODEMS:
 ;
 ;  1.  Define printer with the name MODEMxxx.  Use standard setup.
 ;  2.  Setup ZAA02G("GETPRINTER") to set VDV="" if VDV["MODEM"
 ;  3.  Define distribution list with printer and any batch codes
 ;      as desired.
 ;  4.  Direct print to modem will queue directly, batches will delay
