ZAA02 
         G BEG
SCRN 
                K  N  S $ET="G ERR^ZAA02" W # D INIT,IN S %QUIT=0
                X ^ZAA02G("WRAP-OFF")
START
        ;
        ;
        ; W $$c(75,1,1,"hello") H 5
        Q:%QUIT
        S Y="1,1\TLRH\1\ "_red_"        AA "_" UTILS            "_e_"\\"
        S Y=Y_" *,"
        S Y=Y_$$GETSEQ(1)_")         Globals          ,"        ;3
        S Y=Y_$$GETSEQ(2)_")         Tables           ,"                ;2
        S Y=Y_$$GETSEQ(3)_") ,"                 ;4
        S Y=Y_$$GETSEQ(4)_") ,"         ;5
        S Y=Y_"*," 
        S Y=Y_$$GETSEQ(5)_")         Quit         ,"_"*"                        ;7
        S Y=Y_" *, *, *, *, *, *, *, *, *, *,*, *, *, *, *, *, *"
        D ZAA02 D CLR
        I X=3 D GETMAPPING
        I X=2 K  G ^ZAA02GEDGE
        I X'=2,X'=3,X'=4,X'=5,X'=6,X'=7 D MSG("Not Allowed!")
        I X=7 S %QUIT=1 G END
        Q
GETMAPPING
        Q:%QUIT
        N (%QUIT) D IN
        i '$$GetList^ZAA01("%data") D MSG("No Definition Routines") G START
        S Y="1,1\TLRH\1\Tables\\"
        S Y=Y_" *,",C=1
        s %a="" f  s %a=$o(%data(%a)) q:%a=""  d
        . S C=C+1
        . S M=%a
        . S R=$P(%data(%a),":")
        . S G=$P(%data(%a),":",2)
        . S S=$P(%data(%a),":",4)
        . S D=$P(%data(%a),":",5)
        . F I=1:1:$L($P(%data(%a),":",3),"|") D
        .. S P(M,I,"NAME")=$P($P($P(%data(%a),":",3),"|",I),"(")
        .. S P(M,I,"REQ")=$P($P($P($P(%data(%a),":",3),"|",I),"(",2),")")
        .. I P(M,I,"REQ")="O" S P(M,I,"REQ")="Optional"
        .. I P(M,I,"REQ")="R" S P(M,I,"REQ")="Required"
        .. S P(M,I,"S")=$P(S,"|",I)
        .. M C(M,C,"P")=P,C(M,C,"R")=R,C(M,C,"S")=S,C(M,C,"G")=G
        .. S C(M,C,"D")=D,C(M,C,"M")=M
        .. S DD(C)=M
        . S Y=Y_$$GETSEQ(C-1)_") "_$E(D,1,20)_"::"_G_","
        S Y=Y_"*,"   
        S Y=Y_$$GETSEQ(C+1)_") "_"Go Back,"_"*"                 ;6
        S Y=Y_" *, *, *, *, *, *, *, *, *, *,*, *, *, *, *, *, *"
        D ZAA02 I '$D(DD(X)) G START
LP1     S %MAP=DD(X),M=DD(X) S %R=1,%C=1 D TITLE(""_bold_r_C(M,X,"D")_e_$J(C(M,X,"G"),10),.%R,.%C)
        F I=1:1:$O(P(M,""),-1) D
        . S %R=%R+1,%C=7 W @ZAA02GP,I_")"_" ["_r_P(M,I,"REQ")_e_"] ",P(M,I,"NAME"),":" S P(M,I,"ROW")=%R,P(M,I,"COL")=$L(I_")"_" ["_P(M,I,"REQ")_"] "_P(M,I,"NAME"))
        F CI=1:1:$O(P(M,""),-1) S %R=P(M,CI,"ROW"),%C=(7+P(M,CI,"COL")+1) W @ZAA02GP,$E("                                ",1,45-%C)
LP0     S CI=1
LP      Q:%QUIT  S %RL=$G(%RL,1) S %R=P(M,CI,"ROW"),%C=%C+1 W @ZAA02GP R CC#%RL S IN=$G(IN)_CC
        K BUK,BUKC S BUKC=0 S BUK=""
        I P(M,CI,"S")]"" S A=IN F  S A=$O(@P(M,CI,"S")@(A)) Q:A=""!(BUKC>(7-$O(P(M,""),-1)))  S BUKC=BUKC+1 S BUK=BUK_$$GETSEQ(BUKC)_") "_A_",",BUKC(BUKC)=A
        I BUK]"",P(M,CI,"S")]""  S %R=%R+$O(P(M,""),-1),%C=$G(%C) S Y=%C_"\CL\"_1_"\"_blue_yellowlbg_P(M,CI,"NAME")_e_"\\"_blue_"A) START OVER"_e_","_blue_"B) NO SELECTION"_e_","_blue_"C) SUBMIT"_e_","_""_$E(BUK,1,$L(BUK)-1) D ZAA02
        I BUK]"",P(M,CI,"S")]"",X=1 S %C=(7+P(M,CI,"COL")) G LP
        I BUK]"",P(M,CI,"S")]"",X=2 S %RL=99999 G LP
        I BUK]"",P(M,CI,"S")]"",X=3 S IN=$G(IN)_CC,CC="" D  G SS
        . I $TR(IN,$C(13,10,9)_" ")="",P(M,CI,"REQ")="Required" D MSG("The field is required. Please type something") G LP1
        I BUK]"",P(M,CI,"S")]"",X>3 S X=X-2
        I BUK]"",P(M,CI,"S")]"",X S %R=P(M,CI,"ROW"),%C=(7+P(M,CI,"COL"))+1 D  
        . S IN=BUKC(X-1)
        . W @ZAA02GP,$TR($J($L(IN),0,$L(IN)),"0.","  ")
        . W @ZAA02GP,IN S %C=%C+$L(IN)-1 W @ZAA02GP R CC#1
SS      I CC=""  S P(M,CI,"RESULT")=IN I $D(P(M,CI+1)) S CI=CI+1,%C=%C-$L(IN) S IN="" G LP
        I CC]"" G LP
        S %R=%R+1,%C=1 D TITLE(bold_"Example:"_e,.%R,.%C)
        S A="" F  S A=$O(P(M,A)) Q:A=""  S %R=%R+1,%C=0 W @ZAA02GP W:A=1 cyan_"K"_e_" "_magenta_"DATA"_e_" " W cyan_"S"_e_" "_magenta_"DATA"_e_"("_green_""""_P(M,A,"NAME")_""""_e_")="_green_""""_P(M,A,"RESULT")_""""_e
        S %R=%R+1,%C=0 W @ZAA02GP S ^AHM=ZAA02GP W cyan_"S"_e_" "_magenta_"STATUS"_e_"="_cyan_"$$"_e_red_"Get"_e_"^ZAA("_cyan_"$NA"_e_"("_magenta_"DATA"_e_"),"_green_""""_%MAP_""""_e_")"
        S %R=%R+1,%C=0 W @ZAA02GP,cyan_"I"_e_" "_magenta_"STATUS"_e_" "_cyan_"ZW"_e_" "_magenta_"DATA"
        S %R=%R+1,%C=0
            W @ZAA02GP,cyan_"E"_e_"  "_cyan_"S"_e_" "_magenta_"REASON"_e_"="_cyan_"$P"_e_"("_magenta_"STATUS"_e_","_green_"""`"""_e_",2)"
BK      Q:%QUIT  K DATA
        S A="" F  S A=$O(P(M,A)) Q:A=""  S DATA(P(M,A,"NAME"))=P(M,A,"RESULT")
        K ST S ST=$$Get^ZAA($na(DATA),%MAP)
        N A,B,C,O,Z S O="" K Z S Z=0
        S A="" F  S A=$O(DATA(A)) Q:A=""  D
        . I $G(DATA(A))]"" M B(M,A)=DATA(A) S Z=Z+1,Z(M,Z)=A Q
        S A="" F  S A=$O(DATA(A)) Q:A=""  D
        . I $G(DATA(A))="" M C(M,A)=DATA(A) S Z=Z+1,Z(M,Z)=A Q
        S SPACES=" " S $P(SPACES," ",80)=" " S FC=1
        S O="" I ST S A="" F   S A=$O(Z(M,A)) Q:A=""  I Z(M,A)'="PARAMS" S O=O_","_$$GETSEQ(A)_") "_Z(M,A)_$E(SPACES,1,30-$L(Z(M,A)))_"=  """ S:$L($G(DATA(Z(M,A))))>30 O=O_$E($TR($G(DATA(Z(M,A))),",","."),1,30)_"""" S:$L($G(DATA(Z(M,A))))<=30 O=O_$TR($G(DATA(Z(M,A))),",",".")_""""
        I ST S O=$E(O,2,$L(O))
        I 'ST S O=$E($P(ST,"`",2),1,70)
        S %R=%R+1
BKB     S %C=1 W @ZAA02GP S Y="5\CL\"_1_"\"_bluelbg_yellow_"STATUS:"_+ST_e_"\\"_O D ZAA02 X ^ZAA02G("WRAP-OFF")
        S %X=X 
        I $D(Z(M,%X)) D CLR D 
        . I Z(M,%X)="PARAMS" Q
        . S SS=$E((Z(M,%X)_"="_green_""""_DATA(Z(M,%X))),1,80-6)_""""_e
        . S %C=1 W @ZAA02GP S Y="5\B\"_1_"\"_SS_"\\"_$E(SPACES,1,30)_$$GETSEQ(1)_") View Notes"_$E(SPACES,1,30)_","_$E(SPACES,1,30)_$$GETSEQ(2)_") Add Notes "_$E(SPACES,1,30)_","_$E(SPACES,1,30)_$$GETSEQ(3)_") Go Back"_$E(SPACES,1,30)_",*,*,*,*,*,*,*,*,*,*,*" S %R=30 W @ZAA02GP D ZAA02
        I X=3 D CLR S %R=1,%C=1 W @ZAA02GP G BK
        I $D(Z(M,%X)) D MSG("YOU SELECTED "_" "_X)
        Q:%QUIT
        I $D(Z(M,%X)) G GETMAPPING
        I '$D(Z(M,%X)) D CLR G GETMAPPING 
        Q 
INIT D INITX^ZAA02GDEV Q
IN D IN^ZAA02GDEV Q
CUP(N) Q $C(27)_"["_N_"A"
CDN(N) Q $C(27)_"["_N_"B"
CRT(N) Q $C(27)_"["_N_"C"
CLT(N) Q $C(27)_"["_N_"D"
NLN(N) Q $C(27)_"["_N_"E" ;NEXT LINE  moves cursor to beginning of line n lines down
PLN(N) Q $C(27)_"["_N_"F" ;PREV LINE  moves cursor to beginning of line n lines down
SCL(N) Q $C(27)_"["_N_"G" ;moves cursor to column n
SPO(N,M) Q $C(27)_"["_N_";"_M_"H" ; moves cursor to row n column m
SAV(N) Q $C(27)_"["_N_"s" ; saves the current cursor position at N 0..7
RST(N) Q $C(27)_"["_N_"u" ; restores the cursor to the last saved position at N 0..7
CLR     I $G(clrsall)="" M ZAA02G=^ZAA02G(0,"VT220") D INIT,IN  
                W clrsall 
                Q
TITLE(V,%R,%C)
        N L S L=$L(V)
        N U S U="=" S $P(U,"=",L)="="
        W @ZAA02GP,V S %R=%R+1 W @ZAA02GP,bold,$E(U,1,L),e
        Q
MSG(X,Y,Z,A,B,C)
        I $G(ZAA02GP)="" D INIT,IN
        D CLR
        N U S U=" " S $P(U," ",80)=" "
        S X=$E(X_U,1,60)
        F %R=3:1:23 F %C=10:1:70 W @ZAA02GP,yellow_" "_e
        F %R=8:1:15 F %C=10:1:70 W @ZAA02GP,yellow_bluelbg_" "_e
        S %R=9,%C=10 W @ZAA02GP,yellow_bluelbg,$J(X,60-$L(X)),e S %R=24,%C=1 W @ZAA02GP 
        I $G(Y)]"" S %R=10,%C=10 W @ZAA02GP,yellow_bluelbg,$J(Y,60-$L(Y)),e S %R=24,%C=1 W @ZAA02GP
        I $G(Z)]"" S %R=11,%C=10 W @ZAA02GP,yellow_bluelbg,$J(Z,60-$L(Z)),e S %R=24,%C=1 W @ZAA02GP
        I $G(A)]"" S %R=12,%C=10 W @ZAA02GP,yellow_bluelbg,$J(A,60-$L(A)),e S %R=24,%C=1 W @ZAA02GP
        I $G(B)]"" S %R=13,%C=10 W @ZAA02GP,yellow_bluelbg,$J(B,60-$L(B)),e S %R=24,%C=1 W @ZAA02GP
        I $G(C)]"" S %R=14,%C=10 W @ZAA02GP,yellow_bluelbg,$J(C,60-$L(C)),e S %R=24,%C=1 W @ZAA02GP
        I $G(Y)="",$G(Y)="",$G(Y)="",$G(Y)="",$G(Y)="" D
        . S %R=15,%C=10 W @ZAA02GP,bluelbg,$J("Press any key to continue",65-$L("Press any key to continue")),e S %R=24,%C=1 W @ZAA02GP
        . R CCCCCC#1
        . D CLR
        Q
ERR D MSG($ZSTATUS) S $ET="" Q:$G(%QUIT)  G ^ZAA02 Q
END Q
BEG G BEGX^ZAA02GDEV
OTH G OTH^ZAA02GDEV
GETSEQ(X) Q X
        I '$D(%SEED) N I,C F I=49:1:57,65:1:90,97:1:122  S C=$G(C)+1 S %SEED(C)=$C(I)
        I X<=61 Q %SEED(X)
        Q X
 ; https://www.lihaoyi.com/post/BuildyourownCommandLinewithANSIescapecodes.html
c(ColorCode,resetBeefore,resetAfter,message) 
                N O1,O2,O3,C
                S C=$C(27)
                S (O1,O2,O3)=""
                I $G(resetBeefore) S O1=C_"[0m"
                S O2=C_"[38;5;"_ColorCode_"m"
                I $G(resetAfter) S O3=C_"[0m"
                Q O1_O2_message_O3
                ;
        ;       
