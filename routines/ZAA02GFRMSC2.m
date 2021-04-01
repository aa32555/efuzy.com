ZAA02GFRMSC2 ;PG&A,ZAA02G-SCHEMA,2.62,Dictionary Maintenance - 2;7APR95 4:22P
 ;Copyright (C) 1984, Patterson, Gray and Associates, Inc.
 ;
CLR S %R=3,%C=1,G="^ZAA02GSCHEMA" W:'$D(qt) @ZAA02GP,ZAA02G("CS")
ENTER S %R=22,%C=10,PAT="X?1A.AN" W:'$D(qt) @ZAA02GP,ZAA02G("LO"),"Enter Starting ",ZAA02G("HI"),"Code",ZAA02G("LO"),": ",ZAA02G("HI"),ZAA02G("CS") S %C=33,X="" X ^ZAA02GREAD 
 S S=X G END:X=""
DISP S S1=S,%R=4,%C=10 W:'$D(qt) @ZAA02GP,"Code      Description" S %C=58 W:'$D(qt) @ZAA02GP,"Global Reference"
 S (T,K)=0,%R=6,%C=1 I $O(@G@(0))="" S %R=10,%C=26 W:'$D(qt) @ZAA02GP,"[ No Codes Found - Press RETURN ] " R A#1 S S1="Q" G CLR
D1 W:'$D(qt) @ZAA02GP,ZAA02G("CS") S A="Z="_ZAA02GP F %R=%R:1:20 S S1=$O(^(S1)) Q:S1=""  S K=K+1,%C=4,@A,Y=Z,X=^(S1),%C=58,@A,A(K)=Y_"      "_S1_$J("",10-$L(S1))_$P(X,"`")_Z_$P(X,"`",3)_Y,O(K)=S1 W:'$D(qt) ZAA02G("LO"),A(K),ZAA02G("HI"),"   ",K
 I $D(A)<10 S S=0 G DISP
DIS1 S M=S1 S:$O(@G@(M))="" M="" D SEL G:J="B" DISP I J="M" S T=T+1,%R=6,K=0,%C=1,A=$D(@G@(0)) K A G D1
 G ENTER:J="N"
 I J S S1=O(J) G END
 S S1=J
END K X,G,N,I,A,E,O,S,T,Y,F,C,J,K,H,M Q
SEL S %R=22,%C=10,I="",N="NQ" W:'$D(qt) @ZAA02GP,ZAA02G("LO"),"Type ",ZAA02G("HI") I M'="" W "M",ZAA02G("LO")," for more, " S N=N_"M"
 I T W "B",ZAA02G("LO")," for Beginning, " S N=N_"B"
 W:'$D(qt) ZAA02G("HI"),"N",ZAA02G("LO")," for a New Starting Point, ",ZAA02G("HI"),"Q",ZAA02G("LO")," to Quit" S %R=24,%C=10 W:'$D(qt) @ZAA02GP,ZAA02G("LO"),"[ To Edit Code: Type ",ZAA02G("HI"),"NUMBER",ZAA02G("LO")," or Move selector and Press ",ZAA02G("HI"),"RETURN ]" S %C=1,%R=7 W:'$D(qt) @ZAA02GP,*13
 S J=1,%C=25 X ^ZAA02G("ECHO-OFF")
A1 S %R=4+J,X=A(J) W:'$D(qt) ZAA02G("HI"),X,"==>",J
A2 R C#1 X ZAA02G("T") I C'="" S:A?1L A=$C($A(A)-32) I N[C S J=C G DONE
 I ZF=ZAA02G("UK") W:'$D(qt) ZAA02G("LO"),X,ZAA02G("HI"),"   ",J,*-1 S J=$S(J>1:J-1,1:K) G A1
 I C=" "!(ZF=ZAA02G("DK")) W:'$D(qt) ZAA02G("LO"),X,"   ",ZAA02G("HI"),J,*-1 S J=$S(J<K:J+1,1:1) G A1
 Q:ZF=$C(13)  I C'?1AN W *7 G A2
 I $D(A(I_C))=0 S I="" G A2:$D(A(C))=0
 W:'$D(qt) ZAA02G("LO"),X,"   ",ZAA02G("HI"),J S (J,I)=I_C G A1
DONE X ^ZAA02G("ECHO-ON") Q
 ;
UPDATE Q:$D(^ZAA02GSCHEMA(0,S1))=0
 S %R=20,%C=1 W:'$D(qt) @ZAA02GP,ZAA02G("HI"),ZAA02G("CS"),!,"         ZAA02G-FORME accesses this data item."
 S PROMPT="Do you want to re-compile the forms right now?  ",%R=%R+2,%C=10,X="Y",CHR="YyNn",LNG=1 X ^ZAA02GREAD S ACOMPILE=("Nn"'[X) I 'ACOMPILE W !,?10,"  (please re-compile later)." H 2 ;falls to compile
COMPILE K (qt,ACOMPILE,S1,ZAA02G,ZAA02GP) S SCRN="" ;needs ACOMPILE={0,1},S1=code
 F J=0:0 S SCRN=$O(^ZAA02GSCHEMA(0,S1,SCRN)) Q:SCRN=""  S SCR=$P(SCRN,"-"),SN=$P(SCRN,"-",2) D FIX1
 K A,ACOMPILE,SCRN,SCR,SN,ST Q
FIX1 S A="^"_S1 I $D(^ZAA02GDISP(SCR,SN,A))=0 K ^ZAA02GSCHEMA(0,S1,SCRN) Q
 S %R=24,%C=30 W:'$D(qt) @ZAA02GP,"updating form ",SCR,"-",SN
 S ST=^(A),SCHEMA=^ZAA02GSCHEMA(S1) D COPY K SCHEMA
 S ^ZAA02GDISP(SCR,SN,A)=ST I ACOMPILE S ACOMPILE="ED2" D ED1^ZAA02GFRME1 S ACOMPILE=1 I 1
 E  S ^ZAA02GSCHEMA(1,SCRN)=$H ;killed by ZAA02GFRME1
 Q
 ;
COPY S text=$S(ST="":"",1:"````Multiple Parameters```Pattern Match`Addntl Validation`Fetch Transform`Put Transform``Table Lookup Ref`Table Parameters & Mnemonic Ref.`Table Ref`Table Text Length & Text Ref.")
 D TEMPL
 F I=1:1:12 D COPY1
 K f1,from,text,t1,to
 Q
 ;
COPY1 S t1=$P(to,",",I),f1=$P(from,",",I)
 I $P(text,"`",f1)]"",$P(ST,"`",t1)'=$P(SCHEMA,"`",f1) S %R=20,%C=1 W:'$D(qt) @ZAA02GP,ZAA02G("Z"),ZAA02G("CS"),ZAA02G("LO"),"Form ",ZAA02G("HI"),SCR,"-",SN,ZAA02G("LO")," differs from ZAA02G-SCHEMA on: ",ZAA02G("HI"),$P(text,"`",f1)
 I  W !,?10,ZAA02G("LO"),"ZAA02G-FORM>",ZAA02G("HI"),$P(ST,"`",t1),!,?8,ZAA02G("LO"),"ZAA02G-SCHEMA>",ZAA02G("HI"),$P(SCHEMA,"`",f1),!,?40,"Use ZAA02G-SCHEMA's?  N" S X="N",%R=%R+3,%C=59,CHR="YyNn",LNG=1 X ^ZAA02GREAD S %R=20,%C=1 W:'$D(qt) @ZAA02GP,ZAA02G("CS") I "Nn"[X
 E  S $P(ST,"`",$P(to,",",I))=$P(SCHEMA,"`",$P(from,",",I))
 Q
TEMPL S to="2,4,5,6,16,10,15,21,9,25,17,12",from="3,4,7,8,9,10,11,5,13,14,15,16" Q
