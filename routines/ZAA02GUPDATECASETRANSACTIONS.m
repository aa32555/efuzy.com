ZAA02GUPDATECASETRANSACTIONS(TEZ,K,K1,CNUM) ;;2016-09-12 10:09:18
 ;Updates charges with given case to match case fields
 ;Parameters: entity ("0" if cases aren't entity specific on this system),acct#,pat#,case#
 ;Zach Pastore 2016/09/07
 I '$G(^MSCG("CASE","UPDATECHARGES")) Q
 S CASE=$G(^CASE(K,K1,TEZ,CNUM))
 I CASE="" Q
 I TEZ D UPDATE Q
 F  S TEZ=$O(^INTR(TEZ)) Q:TEZ=""  D UPDATE
 Q
UPDATE
 S TR="" F  S TR=$O(^INTR(TEZ,K,TR)) Q:TR=""  D
 . S REC=$G(^TRG(TEZ,TR))
 . I $P(REC,":",4)'="P" Q
 . I $P(REC,":",7)'=K1 Q
 . I $P(REC,":",72)'=CNUM Q
 . S $P(REC,":",29)=$S($P(CASE,":",22)="N":"",1:$P(CASE,":",22)) ;disability
 . N DTS S DTS=$P(CASE,":",23)
 . N I F I=1,2 S $P(DTS,",",I)=$$DG^IDATE($P(DTS,",",I))
 . S $P(REC,":",32)=$TR(DTS,",","^") ;disability dates
 . S DTS=$P(CASE,":",24)
 . F I=1,2 S $P(DTS,",",I)=$$DG^IDATE($P(DTS,",",I))
 . S $P(REC,":",28)=$TR(DTS,",","^") ;admission/discharge dates 
 . S $P(DTS,",",1)=$$DG^IDATE($P(CASE,":",25)) ;reason date
 . S $P(DTS,",",2)=$$DG^IDATE($P(CASE,":",26)) ;first consult date
 . S $P(REC,":",34)=DTS
 . N ACCSAME,TYP S (ACCSAME,TYP)=""
 . I $P(CASE,":",32)="Y" S TYP=TYP+1
 . I $P(CASE,":",33)="Y" S ACCSAME=ACCSAME+1
 . I $P(CASE,":",34)="Y" S TYP=TYP+2
 . I $P(CASE,":",35)="Y" S ACCSAME=ACCSAME+2
 . I $P(CASE,":",36)="Y" S TYP=TYP+4
 . S $P(REC,":",35)=TYP ;emergency,auto,employment
 . S $P(REC,":",36)=ACCSAME ;accident,same symptoms
 . S $P(REC,":",33)=$S($P(CASE,":",37)="N":"",1:$P(CASE,":",37)) ;reason
 . S ^TRG(TEZ,TR)=REC
 Q
