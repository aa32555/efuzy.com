ZAA02GPOPDO1 
BEG D:$D(ZAA02G)=0 INIT^ZAA02GDEV K X,Y
	S B="Apples,Apricots,Bananas,Grapes,Grapefruit,Melons,Oranges,Peaches,Strawberries,Tangerines" W ZAA02G("F")
	F I="60\BLRWH\1\Sample\\","50\TLWH\2\\\","9\RBLW\5\\\","8\TRWH\1\\\" S Y=I_B D ^ZAA02GPOP
	S Y="25,4\TLRW\3\Multiple Selection\\"_B S (X(3),X(5),X(7))="" D ^ZAA02GPOP K X
	X ^ZAA02G("WRAP-OFF") S %C=27,%R=11 W ZAA02G("HI"),@ZAA02GP,"THESE ARE 5 EXAMPLES OF PULL-DOWN OR POP-UP MENUS.",ZAA02G("LO") S %C=1,%R=13 F I=0:1:5 S %R=%R+1 W @ZAA02GP,$P($T(TEXT+I),";",2,9)
BEG1 R A W ZAA02G("F") S %R=20,%C=30 W @ZAA02GP,ZAA02G("LO"),"( You use the cursor keys, space bar, or first ",!?31,"character to move the selector - then press ",!?31,"RETURN to make the selection. )",ZAA02G("HI")
	F I=1,2 S %R=10,%C=32 W ZAA02G("UO"),@ZAA02GP,"POP-UP - REVERSE VIDEO - ",I," COLUMN",ZAA02G("UF") S Y="10\BLRH\"_I_"\Sample "_I_"\\"_B D POP
	S (%R,%C)=20 W @ZAA02GP,ZAA02G("CS")
	F I=1,3 S %R=10,%C=32 W ZAA02G("UO"),@ZAA02GP,"PULL-DOWN - REVERSE VIDEO - ",I," COLUMN",ZAA02G("UF") S Y="10\TLRH\"_I_"\\\Pick Fruit*,*,"_B D POP
	F I=1,2 S %R=10,%C=32 W ZAA02G("UO"),@ZAA02GP,"POP-UP - NORMAL VIDEO - ",I," COLUMN",ZAA02G("CL"),ZAA02G("UF") S Y="15\BLH\"_I_"\Pick One\\"_B D POP
	F I=2 S %R=10,%C=32 W ZAA02G("UO"),@ZAA02GP,"POP-UP - REVERSE VIDEO - NO LINES - ",I," COLUMN",ZAA02G("UF") S Y="15\RB\"_I_"\Pick One\\"_B D POP
	Q
	;
POP S %R=12,%C=32 W @ZAA02GP,"Y = """,$E(Y,1,40),"..." D ^ZAA02GPOP X ^ZAA02G("WRAP-OFF") Q
	;
TEXT ;They are implemented by first setting the variable Y
	;equal to a parameter string, and then calling ^ZAA02GPOP. ;
	;The selected value (1 thru number of items) will be
	;passed back in X. ;
	;
	;       Press RETURN to see how Y is used. ;
	;