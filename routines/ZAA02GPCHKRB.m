ZAA02GPCHKRB ;;2016-02-01 13:28:32;04/13/2015 16:45:36;03FEB2012  12:10;MG;01JUL2002  0
 ; ADS Corp. Copyright
 ;
 ; REBUILD ^PCHK FROM ^TRG TO ADD MISSING ENTRIES
 N EZ,K,TR,S,CHK,DT,CNT,TCNT
 S DT=$H,TCNT=0
 M ^OLDPCHK(DT)=^PCHK
 S EZ="" F  S EZ=$O(^TRG(EZ)) Q:'EZ  S CNT(EZ)=0 D  D ETOTAL(EZ,CNT(EZ))  
 . S TR="" F  S TR=$O(^TRG(EZ,TR)) Q:'TR  S S=^(TR) I $E($P(S,":",16),3)="P" D
 .. S CHK=$P(S,":",28) I CHK="" Q
 .. S K=$P(S,":",3)
 .. I $D(^PCHK(CHK,EZ,K,TR)) Q
 .. I '$D(^PCHK(CHK)) S (^NEWPCHK(DT,CHK),^PCHK(CHK))=""
 .. S (^NEWPCHK(DT,CHK,EZ,K,TR),^PCHK(CHK,EZ,K,TR))=""
 .. S CNT(EZ)=CNT(EZ)+1,TCNT=TCNT+1
 .. W !,"Check: ",CHK,$C(9),"Entity: ",EZ,$C(9),"Account: ",K,$C(9),"Tr# ",TR," added"
 W !!,"Total Transactions added: ",TCNT
 Q
ETOTAL(E,T) ;
 W !!,"Total Transactions added for Entity ",E,": ",T,!!
 Q
  
