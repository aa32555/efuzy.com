ZAA02GDEV4 
EDIT S %C=8,%R=3 W @ZAA02GP,ZAA02G("CS"),ZAA02G("HI"),"Press the appropriate key to implement each of the following functions",!?3,"and then enter a short description of each key for the HELP screen.  You ",!
 W ?3,"may skip particular functions by just pressing RETURN, and you can move",!?3,"up or down with the cursor up and cursor down keys.  ",!
 W ZAA02G("LO"),!?3,"Function",?33,"Key Output",?59,"Description"
 S NE=28,NF=14,TP=9,EC=31,(ST(0),ST(1),SD(0),SD(1))="",II=0,DOTS=".............................",OS=^ZAA02G("OS") S:$D(^ZAA02G(.1,ZAA02G,2)) ST(0)=^(2) S:$D(^(3)) ST(1)=^(3) S:$D(^(5)) SD(0)=^(5) S:$D(^(6)) SD(1)=^(6)
E0 X ^ZAA02G("ECHO-OFF") F N0=1:NF:NE D EN
 S ^ZAA02G(.1,ZAA02G,2)=ST(0),^(3)=ST(1),^(5)=SD(0),^(6)=SD(1) X ^ZAA02G("ECHO-ON")
END S T=ZAA02G D @(^ZAA02G("OS")_"^ZAA02GINTRM") K T,ST,SD,TP,EC,II,NF,A,DOTS,ESC,NE X ^ZAA02G("TERM-OFF"),^ZAA02G("WRAP-ON") K ZAA02G Q
 ;
E1 S C="" F I=1:1:$L(ZF) S C=C_","_$A(ZF,I)
 S C=$E(C,2,99),J=$P($T(DATA+II),";",2),$P(ST(J>15),"`",J)=C W C,$J("",60-$L(C)-%C) I $L(ST(0),C)+$L(ST(1),C)>3 W *8,*8,"* "
E2 S %C=60,LNG=20 S X=$P(SD(J>15),"`",J) X ^ZAA02GREAD,^ZAA02G("ECHO-OFF") S $P(SD(J>15),"`",J)=X,%C=EC+3 Q
 ;
EN S %C=2,%R=TP,NN=$S(N0+NF-1>NE:NE,1:N0+NF-1) W @ZAA02GP,ZAA02G("CS")
 F I=N0:1:NN S %C=2,%R=I-1#NF+1+TP,A=$T(DATA+I),J=$P(A,";",2),A=$P(A,";",3) W @ZAA02GP,ZAA02G("LO"),A,$E(DOTS,1,EC-$L(A))," ",ZAA02G("HI"),$P(ST(J>15),"`",J) S %C=60 W @ZAA02GP,$P(SD(J>15),"`",J)
 S %C=EC+3 F II=N0:1:NN S %R=II-1#NF+1+TP D RD X $S(ZF=ZAA02G("UK"):"S II=II-2",ZF=ZAA02G("DK"):"S II=II",ZF=$C(13):"S II=II",1:"D E1") I II+1<N0 S:II<0 II=0 I N0>NF S %R=TP,%C=1 W @ZAA02GP,ZAA02G("CS") S N0=N0-NF-NF Q
 Q
 ;
RD W @ZAA02GP R E X ZAA02G("T") I OS="DTM",ZF=$C(27) R E:1 S ZF=ZF_E
 Q
 Q
 ;
DATA ;
 ;1;Next Screen
 ;2;Previous Screen
 ;3;First Screen
 ;4;Repeat
 ;5;Macro
 ;6;Insert Line
 ;7;Delete Line
 ;8;Erase Line/Para/End
 ;9;Tab Set/Clear
 ;10;Help Screen
 ;11;Other Options Menu
 ;12;Copy/Move/Insert
 ;13;Bold/Underline
 ;14;Format Line
 ;22;PF3
 ;15;PF4
 ;16;Find
 ;17;Reformat Paragraph
 ;18;Cut Line
 ;19;Exit
 ;20;PF1
 ;21;Select
 ;25;PF2
 ;26;PF5
 ;27;PF6
 ;28;PF7
 ;29;PF8
 ;30;PF9
