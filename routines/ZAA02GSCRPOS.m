ZAA02GSCRPOS ; ZAA02G-Script Posting Interface;2014-07-10 17:23:46;15AUG2002  16:31
 ; ADS Corp. Copyright
 Q
 ;
START ; Start process
 S ENT=$G(^MSCG("ZAA02GSCR","POS","ENTITY")) ; entity
 I 'ENTITY W !,"Entity not defined" Q
 S JOB=""
 F  S JOB=$O(^ZAA02GSCR("X",JOB)) Q:JOB=""  D
 . S ZAA02GDATA=$G(^ZAA02GSCR("TRANS",JOB))
 . S TRANS=$G(^ZAA02GSCR("TRANS",JOB,.011,"TR"))
 . I TR Q
 . S ES=$G(^ZAA02GSCR("TRANS",JOB,.011,"eS"))
 . I $P(ES,"\")'="S" Q
 . S K=+$P(ZAA02GDATA,"`",3)
 . I 'K Q
 . S (DOA,DXP,FLAG)=""
 . S LINE=.03
 . F  S LINE=$O(^ZAA02GSCR("TRANS",JOB,LINE)) Q:LINE=""  D  I FLAG=11 Q
 .. S DATA=$P($G(^ZAA02GSCR("TRANS",JOB,LINE)),$C(1),4)
 .. S FIND=$F(DATA,"DXP:")
 .. I FIND,'(FLAG#10) S DXP=$TR($E(DATA,FIND,9999)," "),FLAG=FLAG+1
 .. S FIND=$F(DATA,"DOA:")
 .. I FIND,FLAG<10 S DOA=$TR($E(DATA,FIND,9999)," "),FLAG=FLAG+10
 . K DG S DG=$P(DXP,"-")
 . K PC S PC=$P(DXP,"-",2)
 . S L=$L(DG,",") F I=1:1:L S DG(I)=$P(DG,",",I)
 . S L=$L(PC,";") F I=1:1:L S PC(I)=$P(PC,";",I)
 . D POST
 Q
 ;
POST ; Post procedures
 K PCLIST
 S PV=$P($P(ZAA02GDATA,"`",4),"~")
 S QTY=1
 S RF=$P($P(ZAA02GDATA,"`",5),"~")
 S (I,PC)=""
 F  S PC=$O(PC(PC)) Q:PC=""  D
 . I '$D(^PCG(PC,"EXP")) S I=$O(PCLIST(""),-1)+1,PCLIST(I)=PC,I=I+1
 . E  S LIST=^PCG(PC,"EXP") D
 .. S J=1 F I=I:1 I $P(LIST,":",J)]"" S PCLIST(I)=$P(LIST,":",J),J=J+1
 F  S PC=$O(PCLIST(PC)) Q:PC=""  D
 .
 Q
