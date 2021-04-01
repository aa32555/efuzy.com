ZAA02GHIC ;;2019-02-25 11:46:02
 ; ADS Corp. Copyright
 Q
ADD(ENT,REC)
 ;Add charge record to ^ZAA02GHIC in given entity
 ;Parameters:
 ; ENT  - entity
 ; REC  - charge transaction record
 N (ENT,REC)
 S P70=$P(REC,":",70)
 S $P(P70,"^",2)="P"
 S $P(REC,":",70)=P70
 I '$P(REC,":",43) S $P(REC,":",43)=""
 S PS=$P(REC,":",15)
 I PS="" S PS=-1
 S PV=$P(REC,":",13)
 I PV="" S PV=-1
 S DT=$$DG^IDATE(+$H)
 L +^ZAA02GHIC(ENT,PS,PV,DT)
 S CTR=$O(^ZAA02GHIC(ENT,PS,PV,DT,""),-1)+1
 S ^ZAA02GHIC(ENT,PS,PV,DT,CTR)=REC
 L -^ZAA02GHIC(ENT,PS,PV,DT)
 Q
