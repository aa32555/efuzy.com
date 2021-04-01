ZAA02GSCRCH4 ;mp@PGA;Jun00;ZAA02G-SCRIPT COLUMBIA - DOCUMENT IMPORT; ;24JUL2000  11:34
 ;06/14/2000; Mark Patterson ***NEW***
 ;06/16/2000;ns; Move out when done or w/errors. Build cross-ref
 ;06/21/2000;ns; Hard code SITEC="MR" for statistics
 ;             ; Use ^DI0U for provider name 
 ;07/21/2000;ns; Revise for unmatching records in our dictionary 
 ;              ^ZAA02GSCR(106 for 'PROC' and 'PR', module EXT3
 ;
 Q
DEBUG ; Enter here to write ZAA02G-Script record numbers to the screen
 S DEBUG=1
 D EXT
 Q
 ;
ERROR S B="B="_^ZAA02G("ERRORR"),@B,^ZAA02GSCRCHL("ERROR",$H)=B H 5 Q
 ;
 ;  INPUT DOCUMENT HEADER
 ;  1 TRANSCRIPTIONIST         10 COSIGNER/ONSITE DOC
 ;  2 PROVIDER #               11 REFERRAL
 ;  3 SITE/DEPART #            12 CC1
 ;  4 EXAM/REPORT TYPE         13 CC2
 ;  5 PATIENT NAME             14 CC3
 ;  6 HISTORY #                15 CC4
 ;  7 EXAM DATE                16 BODY
 ;  8 DICT DATE
 ;  9 TRANS DATE
 ;
EXT ;
 S WORK=$$BIG^%ZKlink_"cbay/work/"
 S ORIG=$$BIG^%ZKlink_"cbay/orig/"
 S DONE=$$BIG^%ZKlink_"cbay/done/"
 S CBAY=$$BIG^%ZKlink_"cbay/"
 S dbase=$p(^%ZTCP,"|")
 I dbase["test" S DBASE="/uci/test"
 I dbase["9000" S DBASE="/uci/live"
 S:$G(DEBUG)'=1 A=^ZAA02G("ERROR")_"=""ERROR^ZAA02GSCRCH4""",@A D DATABASE^ZAA02GSCRPW,PARAM^ZAA02GSCRPW S SEQN=""
 ;
EXT2 K NAME S SEQN=$O(^KZAA02GIF("TR",SEQN)) Q:SEQN=""  G:$G(^(SEQN)) EXT2 S ^(SEQN)=1,ERR=0
 S HALT=^KZAA02GIF(0,"HALT") Q:HALT
 s file=CBAY_SEQN o file:("R")
 ;I $D(^KZAA02GIF("TRDONE",SEQN)) D  G EXT2
 ;. K ^KZAA02GIF("TR",SEQN)
 ;. c file
 ;. S %=$zf(-1,"mv "_file_" "_DONE)
 ;****TEST- Remove LTR sets and checks, here and in EXT3
 ; after letters have been fixed 
 S LTR=0
 D EXT3
 ;
 ;***TEST*** - Remove this line after letters are fixed
 ;I LTR=1 S ^YNSKZAA02GIF("LTR",SEQN)="LTR" Q
 ;
 ; If errors - move to WORK file, remove from ^KZAA02GIF("TR"
 I ERR'=0 D  G EXT2
 . S errmsg=CBAY_"ERRFILE.DAT"
 . O errmsg:("NW")
 . U errmsg W ERR
 . S ^KZAA02GIF(2,SEQN)=ERR
 . S ^KZAA02GIF(4,INP("PROVIDER"),SEQN)=ERR
 . C errmsg
 . S %=$zf(-1,"cat "_file_" >> "_errmsg)
 . S %=$zf(-1,"mv "_file_" "_ORIG)
 . S %=$zf(-1,"mv "_errmsg_" "_file)
 . S %=$zf(-1,"mv "_file_" "_WORK)
 . K ^KZAA02GIF("TR",SEQN)
 ;
 S GLOB="^ZAA02GTMP($J)" K @GLOB S LN=2,$ZT="M11END^ZAA02GSCRCH4"
 S (L,B)="" F  U file R C S L=L_$TR(C,$C(9)," "),F=C="" D:$L(L)>80!F EXT1
M11END S $ZT="" S:$G(DEBUG)'=1 A=^ZAA02G("ERROR")_"=""ERROR^ZAA02GSCRCH4""",@A
 c file S @GLOB@(LN)=L,LN=LN+1,B=.03 I LN>1 F  S B=$O(@ZAA02GWPD@(B)) Q:B=""  I ^(B)["*" D EXTINS Q
 D EXT5
 ;L  S ^KZAA02GIF("TRDONE",SEQN)=$H_","_DOC
 ;S ^KZAA02GIF("ZAA02GS",DOC)=SEQN
 ;K ^KZAA02GIF("TR",SEQN)
 ;S mvfile=CBAY_SEQN
 ;S %=$zf(-1,"mv "_mvfile_" "_DONE)
 ;K ^KZAA02GIF("TR",SEQN)
 ;
 S ^KZAA02GIF("TR",SEQN)=""
 w "done-",SEQN q  ; temporary *** REMOVE THIS LINE WHEN TESTING DONE
 ;
 I DEBUG W !,"Done - ",SEQN
 H 1 G EXT2
 ;
EXTINS S C=$O(^(B)) S:C="" C=B+100,^(C)=B_$C(1,1,1) S D=$J(C-B/LN,0,4),J=$O(@GLOB@("")),$P(@ZAA02GWPD@(B),$C(1),4)=@GLOB@(J) F  S J=$O(@GLOB@(J)) Q:J=""  S @ZAA02GWPD@(B+D)=B_$C(1,1,1)_@GLOB@(J),B=B+D
 S $P(@ZAA02GWPD@(C),$C(1))=B Q
 ;
EXT1 F J=1:1:$L(L)\65 S C=$E(L,1,65),C=$P(C," ",1,$L(C," ")-1),L=$E(L,$L(C)+1,9999) S @GLOB@(LN)=C,LN=LN+1
 I F S:L'="" @GLOB@(LN)=L,L="",LN=LN+1 S @GLOB@(LN)="",LN=LN+1
 Q
 ;
 ; mr,sitec,patient,dob,ds,template,proc1,consult
 ; trans,prov,site,exam,patient,history,dos,dd,dt,cosign,consult,cc1,cc2,cc3,cc4 - document
 ;
EXT3 N A,F,L D DATE^ZAA02GSCRER,TMPL^ZAA02GSCRER
 S UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ",LC="abcdefghijklmnopqrstuvwxyz",TIME=$P($H,",",2),STMC=0,ZAA02GWPD="@ZAA02GSCR@(DIR,DOC)",DIR="TRANS"
 f j=1:1:15 u file r a s b=$p(a,": ",2,99) s:$e(b)=" " b=$e(b,2,99) s j(j)=b
 I j(4)["LTR" S LTR=1
 f j=9 s b=j(j) i b]"" s $p(j(j),"/",3)=$e($p(j(j),"/",3),3,4)
 ;
 S (INP("TR"),TRANS)=$tr(j(1),UP,LC),(OSET,OCOUNT,OT)="",INP("DD")=j(8),INP("DT")=j(9),INP("DS")=j(7),INP("TM")=TM,ZAA02G("RON")=$C(27)_"AAAA",XF=$C(1)
 ;
 S (INP("P1"),INP("SITEC"))=j(3),INP("DIST")=j(3),INP("PROC1")=j(4)
 ;
 S j(3)=$TR(j(3)," ","")
 S j(4)=$TR(j(4)," ","")
 S REP=j(3)_$TR(j(4),UP,LC)
 I REP["proc" S REP=j(3)_$E(j(4),1,2)
 S REP=$TR(REP,UP,LC)
 S INP("SITEC")="MR"
 S INP("CC1")=j(12),INP("CC2")=j(13)
 I j(14) S INP("CC3")=j(14) I j(15) S INP("CC4")=j(15)
 S (X,INP("PIN"))=j(6)
 ;
LOADX S X=$O(^[DBASE]MB02(" "_X,"")) I X="" S ERR="Error #16 - not a valid history #" Q
 S A=$G(^[DBASE]MB0(X,2)),INP("PATIENT")=$P(A,"|"),INP("MR")=$TR($P(A,"|",5)," ",""),D=$P(A,"|",3),DT="" D:D]"" DATE S INP("DOB")=DT,INP("REV")=$P(A,"|",2),INP("PIN")=X D AGE S INP("AGE")=T
 I X S K=$P($G(^[DBASE]MB8(X,"M"," "_INP("MR"),11)),"|",3) I K]"" S K=$P($G(^[DBASE]DI1T(K,1)),"|",6) S INP("LOC")="-"_K
 ;         
 I $G(INP("PATIENT"))="" S ERR="Error #25 patient name not found" Q
 ;
 S INP("CONSULT")=j(11),X=j(2)
 I $D(^ZAA02GSCR("PROV",+X))#2 S:X>0 X=+X_" "_$P(^(+X),"\",3) D PROVSET
 S X=+X S:$L(X)<3 X=$E(X+1000,2,4)
 I $D(^[DBASE]DI0U(" "_X,1)) S INP("PROVIDER")=+X_" "_$P(^(1),"|",2)
 ;
 S INP("PROC2")=""
 F A="PATIENT","DOB","PROC1","PROVIDER" S:INP(A)="" INP(A)="?"
 S:REP["ltr" REP="ltr",INP("DIST")=j(4)
 S:$D(^ZAA02GSCR(106,REP))=0 REP="cbay"
 S INP("TEMPLATE")=REP
 S PTYPE=1,PDEV="" ; THESE CAN BE CHANGED IN PARAM
 ;
 D NEW^ZAA02GSCRER1 Q
 ;
EXT5 S ODOC=DOC N A,DOC S DOC=ODOC,P=PTYPE S:0 INCOMP=1 D FILE^ZAA02GSCRER
 S DV=PDEV,INP("WORK")="",TRTYPE="" D STATS^ZAA02GSCRER2 D:P<3 DEFDV^ZAA02GSCRSP,PR2^ZAA02GSCRER2
 Q
 ;
EXT4(X) Q $E(X,5,6)_"/"_$E(X,7,8)_"/"_$E(X,3,4)
 ;
DATE S K=D>21608+305+D,Y=4*K+3\1461,D=K*4+3-(1461*Y)+4\4,M=5*D-3\153,D=5*D-3-(153*M)+5\5,M=M+2,Y=M\12+Y+1840,M=M#12+1,K="/",Y=Y*100+M*100+D,DT=$E(Y,5,6)_K_$E(Y,7,8)_K_$E(Y,1,4) Q
 ;
PROVSET ; SETUP PROVIDER NAME & INITIALS
 S T=$P($G(X)," ") Q:T=""  S (T,INP("DR"))=$P($G(^ZAA02GSCR("PROV",T)),"\",3)
 S T=$P(T,","),INP("DRI")=$E(T)_$E($P(T," ",2))_$E($P(T," ",3))
 ;
 I INP("PROC1")="LTR"!(INP("PROC1")="TNP") K INP("eS") Q
 ;
ES N Y,y I $S(+X=0:1,1:$E($P($G(^ZAA02GSCR("PROV",+X)),"\",19))'="Y") Q:'$D(INP("eS"))  S $P(INP("eS"),"\",2+$G(eSn))="" G ES1
 I 1 S $P(INP("eS"),"\",2+$g(eSn))=+X_$E($P(^(+X),"\",19),2,99)
ES1 S $P(INP("eS"),"\")=$S($P(INP("eS"),"\",2,3)?.P:"",1:"Y")
 Q
 ;              
AGE S T=$G(INP("DOB")) Q:T=""  D JULIAN Q:T=""  S tt=T,T=$S($D(INP("DT")):INP("DT"),1:$H) D:T["/" JULIAN S T=T-tt\365.25 K tt
 Q
 ; USED BY AGE CALCULATION
JULIAN S m=+T-3,d=$P(T,"/",2),y=$P(T,"/",3) I (m+d+y)<-2 S T="" Q
 S:y<100 y=y+1900 S o=$S(y<1900:-14917,1:21608),y=y>1999*100+$E(y,3,4) S:m<0 m=m+12,y=y-1 S T=1461*y\4,T=153*m+2\5+T+d+o K m,y,o,d Q
 Q
