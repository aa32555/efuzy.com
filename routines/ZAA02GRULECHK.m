ZAA02GRULECHK  ; Transaction Rule Checking Report ;2019-03-29 11:20:55;14FEB2014  13:04; ;
 ; ADS Corp. Copyright
 Q
RWEB G PREVIEW^ZAA02GVBW6R
VB
WEB ; ZAA02Gweb
 I $G(X)["|",$P(X,"|",6)="" S B="||RUN||" Q
 I $G(X)["|",$P(X,"|",6)="BRW" S B="URL:"_$C(9)_"*/premier/"_HANDLE_"/web^ZAA02Grulechk?"_HANDLE,^ZAA02GTVB(+HANDLE,"REPORT")=X Q
 S DATA=$G(^ZAA02GTVB(+$G(%("FORM","DATA")),"REPORT"))
 I DATA="" S DATA=X
 ;
 S LC="abcdefghijklmnopqrstuvwxyz",UC="ABCDEFGHIJKLMNOPQRSTUVWXYZ",WEB=1,WEBHANDLE=+$G(%("FORM","DATA"))
 S USER=$TR($P($P(DATA,"|"),$C(9)),LC,UC),P2=0,EZ=$P($P(DATA,"|"),$C(9),3)
 S $P(X,"|",6)="RUN",$P(X,"|",7)=$P(DATA,"|",7)
 ;
 N (B,EZ,HANDLE,HANDLE2,P2,USER,X,RLC)
 ;
 I '$D(RLC) S RLC=$J
 I '$D(HANDLE) S HANDLE=RLC
 S B=""
 S D1=":"
 S D2="^"
 S D3=","
 S D4="/"
 S (JOB,DEV,IO)=$I
 S OPZ=USER
 S PR=$S(P2["=":P2,1:+P2) I PR="0",$I'[":" S PR=$I
 S PRG="ZAA02GRULECHK"
 S Q="9"
 S S=""
 S s=$P(X,"|",7)
 S VAL=$P(X,"|",6)
 ;
 ; ******************************************
 ; *          S E L E C T I O N S           *
 ; ******************************************
 ;
 ; Entity
 S ENTERR=""
 S SAVLST=$P($P(s,D1),D2,2)
 S ENTLST=$TR(SAVLST,D3,D1)
 S (SELENT,ENTSEL)=$E($P(s,D1))
 D ^OPENT
 I ENTERR'="" S B="1|"_ENTERR_"|16|Report Error|1=0" Q
 F I=1:1:$L(ENTLST,D1) D
 . S TMP=$P(ENTLST,D1,I)
 . I TMP]"",$D(^TRG(TMP)) S ENT(TMP)=""
 I SELENT'="A" D
 . S TMP=""
 . F I=1:1 S TMP=$O(ENT(TMP)) Q:TMP=""  S ENTH(TMP)=""
 S MORE=0
 S TMP=""
 F I=0:1 S TMP=$O(ENT(TMP)) Q:TMP=""
 I I>1 S MORE=1
 S SELENT=SAVLST
 ;
 ; Dates
 S SORTD=$E($P(s,D1,2))
 S DTF=$P($P($P(s,D1,2),D2,2),D3)
 S DTF=$$DG^IDATE(DTF,1)
 S DTF=$TR(DTF,"/")
 S DTF=$E(DTF,5,8)_$E(DTF,1,2)_$E(DTF,3,4)
 S DTF=$$DG^IDATE(DTF,1)
 I $E(DTF)<2 S DTF=$E(DTF,3,8)
 S DTT=$P($P($P(s,D1,2),D2,2),D3,2)
 S DTT=$TR(DTT,"/")
 S DTT=$E(DTT,5,8)_$E(DTT,1,2)_$E(DTT,3,4)
 S DTT=$$DG^IDATE(DTT,1)
 I $E(DTT)<2 S DTT=$E(DTT,3,8)
 ;
 ; Rules
 S RULESEL=$P($P(s,":",3),"^",1)
 I RULESEL'="A" D
 . S RULELST=$P($P(s,":",3),"^",2)
 . F I=1:1:$L(RULELST,",") D
 .. S RULE=$P(RULELST,",",I)
 .. I RULE'="" S RULELST(RULE)=""
 . Q
 I RULESEL="I" M RULES=RULELST
 I RULESEL'="I" S EZ="" F  S EZ=$O(ENT(EZ)) Q:EZ=""  D
 . S RULE="" F  S RULE=$O(^CODERULES(EZ,RULE)) Q:RULE=""  D
 .. I RULESEL="E",$D(RULELST(RULE)) Q
 .. S RULES(RULE)=""
 . Q
 ;
 ;
 I VAL="" S B="||RUN||" Q
 I VAL'="RUN" S B="99|Invalid System Response|16|Report|1=0" Q
 ;
 ; *************************************
 ; *     R E P O R T     L O G I C     *
 ; *************************************
 ;  SORTD="S"
 ;  DTF=20170103
 ;  DTT=20170126
 ;  ENT(1)=""
 ;  ENT(2)=""
 ;  ENT(3)=""
 ;  ENT(4)=""
 ;
 S JOB=$J 
 K ^SORT(JOB)
 S ^SORT(JOB,"REP",1)=""
 D ADW^ZAA02GVBW6H2
 S MAXRULES=0
 S EZ="" F  S EZ=$O(ENT(EZ)) Q:EZ=""  D
 . S TR="" F  S TR=$$NXTTR^TRUTIL(EZ,TR,DTF,DTT,SORTD,"P") Q:TR=""  D
 .. S K=$P(^TRG(EZ,TR),":",3)
 .. D MAKEREP
 . Q
 D PRINT(MAXRULES)
 ;
 D REP^ZAA02GVBAARPT2(JOB)
 ;
 Q
 ;
 ;
MAKEREP
 N TRG,K1,STATUS,NM,AMOUNT,PAID,SEQ,SD,DG,INS,RULENO,RULELST
 S RULENO=0
 S TRG     = ^TRG(EZ,TR)
 S K1      = $P(TRG,":",7) I K1="" S K1=1
 S NM      = $P(^PTG(K,K1),":",3) S:NM="" NM=$P(^GRG(K),":",7) 
 S AMOUNT  = "$"_$J(($P(TRG,":",9)/100),0,2)
 S PAID    = "$"_$J(($P(TRG,":",10)/100),0,2)
 S SEQ     = $O(^SORT(JOB,"REP",""),-1)+1
 S SD      = $P($P(TRG,":",16),"^")
 I SD?8N   S SD = $ZD($ZDH($P($P(TRG,":",16),"^"),8))
 S DG      = $P(TRG,":",22) I DG]"",$D(^INDG(DG)) D
 . S DG    = $P(^INDG(DG),":")
 S INS     = +$P($P(TRG,":",44),",")
 I INS,$D(^GRG(K,INS)) D
 . S INS   = $P(^GRG(K,INS),":",3)
 E  S INS  = "No Ins."
 ;
 S RULE="" F  S RULE=$O(RULES(RULE)) Q:RULE=""  D
 . S MSG=$$SCRUB(K,TRG,TR,RULE,EZ,ADWFL)
 . I MSG'="" D
 .. S RULELST=$G(RULELST)_","_RULE
 .. S $P(^SORT(JOB,"REP",SEQ),"|",19+RULENO)=MSG
 .. S RULENO=RULENO+1
 .. I RULENO>MAXRULES S MAXRULES=RULENO
 . Q
 I 'RULENO Q
 S $E(RULELST,1)=""
 S $P(^SORT(JOB,"REP",SEQ),"|",18)=RULELST
 S $P(^SORT(JOB,"REP",SEQ),"|",1)=K_"/"_K1                                              ;Account
 S $P(^SORT(JOB,"REP",SEQ),"|",2)=TR                                                    ;Tr#
 S $P(^SORT(JOB,"REP",SEQ),"|",3)=NM                                                    ;Name
 S $P(^SORT(JOB,"REP",SEQ),"|",4)=SD                                                    ;Service Date
 S $P(^SORT(JOB,"REP",SEQ),"|",5)=$ZD($P(TRG,":"))                              ;Posting Date
 S $P(^SORT(JOB,"REP",SEQ),"|",6)=$P(^INPC($P(TRG,":",6)),":")  ;Procedure
 S $P(^SORT(JOB,"REP",SEQ),"|",7)=$P(TRG,":",27)                                ;Mod.
 S $P(^SORT(JOB,"REP",SEQ),"|",8)=$P(TRG,":",18)                                ;QTY
 S $P(^SORT(JOB,"REP",SEQ),"|",9)=$P(TRG,":",13)                                ;Provider
 S $P(^SORT(JOB,"REP",SEQ),"|",10)=$P(TRG,":",15)                               ;POS
 S $P(^SORT(JOB,"REP",SEQ),"|",11)=DG                                                   ;DG1
 S $P(^SORT(JOB,"REP",SEQ),"|",12)=AMOUNT                                               ;Amount
 S $P(^SORT(JOB,"REP",SEQ),"|",13)=PAID                                                 ;Paid
 S $P(^SORT(JOB,"REP",SEQ),"|",14)=$P(TRG,":",45)                               ;A/R
 S $P(^SORT(JOB,"REP",SEQ),"|",15)=INS                                                  ;Ins.
 S $P(^SORT(JOB,"REP",SEQ),"|",16)=$P(TRG,":",5)                                ;Dpt.
 S $P(^SORT(JOB,"REP",SEQ),"|",17)=$P(TRG,":",19)                               ;Flag
 Q      
 ;
 ; 
 ; *************************************
 ; *     R E P O R T     P R I N T     *
 ; *************************************
 ;
 ;
PRINT(RULES)
 ;
 ;
 S ^SORT(JOB,"TITLE")="Transaction Rule Check Report"
 S ^SORT(JOB,"USER")=USER
 S ^SORT(JOB,"PRGRM")=PRG 
 ;
 S $P(^SORT(JOB,"REP",1),"|",1)="Account"
 S $P(^SORT(JOB,"REP",1),"|",2)="Tr#"
 S $P(^SORT(JOB,"REP",1),"|",3)="Name"
 S $P(^SORT(JOB,"REP",1),"|",4)="Service Date"
 S $P(^SORT(JOB,"REP",1),"|",5)="Posting Date"
 S $P(^SORT(JOB,"REP",1),"|",6)="Procedure"
 S $P(^SORT(JOB,"REP",1),"|",7)="Mod."
 S $P(^SORT(JOB,"REP",1),"|",8)="QTY"
 S $P(^SORT(JOB,"REP",1),"|",9)="Provider"
 S $P(^SORT(JOB,"REP",1),"|",10)="POS"
 S $P(^SORT(JOB,"REP",1),"|",11)="DG1"
 S $P(^SORT(JOB,"REP",1),"|",12)="Amount"
 S $P(^SORT(JOB,"REP",1),"|",13)="Paid"
 S $P(^SORT(JOB,"REP",1),"|",14)="A/R"
 S $P(^SORT(JOB,"REP",1),"|",15)="Ins."
 S $P(^SORT(JOB,"REP",1),"|",16)="Dpt."
 S $P(^SORT(JOB,"REP",1),"|",17)="Flag"
 S $P(^SORT(JOB,"REP",1),"|",18)="Rules"
 F I=1:1:RULES S $P(^SORT(JOB,"REP",1),"|",18+I)="Message "_I
 ;
 q
 ;
 ;
SCRUB(ACCNT,TRG,TRN,RULE,EZ,ADWFL)
 N AA S AA="" b:TRN=256263&(RULE="cci")
 D CHECKRULE^ZAA02GVBW6H2(ACCNT,TRG,TRN,"","","",RULE)
 Q $$s($P($P(AA,"<td>",$L(AA,"<td>")),"</td>",1)) ;
 ;
 ;
s(s)
        i $tr(s,"""\/"_$c(8,9,10,13))=s q s
        i s["\"    s s=$$r(s,"\","\\")
        i s[""""   s s=$$r(s,"""","\""")
        i s["/"    s s=$$r(s,"/","\/")
        i s[$c(8)  s s=$$r(s,$c(8),"\b")
        i s[$c(10) s s=$$r(s,$c(10),"\n")
        i s[$c(13) s s=$$r(s,$c(13),"\r")
        i s[$c(9)  s s=$$r(s,$c(9),"\t")
        q s
        ;
        ;
r(s,f,t)
        i $tr(s,f)=s q s
        n o,i s o="" f i=1:1:$l(s,f)  s o=o_$s(i<$l(s,f):$p(s,f,i)_t,1:$p(s,f,i))
        q o
        ;
