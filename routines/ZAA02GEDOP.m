%ZAA02GEDOP ;;%AA UTILS;1.24;UTIL: PROGRAMMER OPTIONS;25JUN91  16:27
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
MENU S Y=(lm-1)_","_(bl+2)_"\H\HL,EX\Options: \\QUIT,MENUS,WIDTH,DISPLAY,EDITMODE"
        W pBL_tCL_tLO D ^ZAA02GEDPL I ZAA02GF="HL" S HN=1100 D ^ZAA02GEDH,RESTORE^ZAA02GED08(+REFRESH,$P(REFRESH,":",2)) G MENU
        G EXIT:X=1!(ZAA02GF="EX"),MEN:X=2,WID:X=3,DSP:X=4,INS:X=5,MENU
MEN S Y=(lm-1)_","_(bl+2)_"\H\EX\Menus: \"_$S(ZAA02G("M"):1,1:2)_"\NORMAL,HOT KEY" W pBL_tCL_tLO D ^ZAA02GEDPL G:ZAA02GF="EX" MENU
        I X=1 S @ugl@(TID,"MENU")=1,ZAA02G("M")=1 G MENU
        I X=2 S @ugl@(TID,"MENU")=0,ZAA02G("M")=0 G MENU
        G MENU
WID S Y=(lm-1)_","_(bl+2)_"\H\EX\Screen Width: \"_$S(rm<80:1,1:2)_"\80-COLUMN,132-COLUMN" W pBL_tCL_tLO D ^ZAA02GEDPL G:ZAA02GF="EX" MENU
        I X=1,$P(@ugl@(TID),"`",2)'=79 S $P(@ugl@(TID),"`",2)=79 D MG80^ZAA02GED09 G MENU
        I X=2,$P(@ugl@(TID),"`",2)'=131,ZAA02G(132)]"" S $P(@ugl@(TID),"`",2)=131 D MG132^ZAA02GED09 G MENU
        G MENU
DSP S Y=(lm-1)_","_(bl+2)_"\H\EX\Display Intensity: \"_($P(@ugl@(TID),"`",7)+1)_"\HIGH INTENSITY,LOW INTENSITY" W pBL_tCL_tLO D ^ZAA02GEDPL G:ZAA02GF="EX" MENU
        I X=1,$P(@ugl@(TID),"`",7) S $P(@ugl@(TID),"`",7)=0 D SETUP^ZAA02GED,NP^ZAA02GED00 G MENU
        I X=2,'$P(@ugl@(TID),"`",7) S $P(@ugl@(TID),"`",7)=1 D SETUP^ZAA02GED,NP^ZAA02GED00 G MENU
        G MENU
INS S Y=(lm-1)_","_(bl+2)_"\H\EX\Edit Mode: \"_$S('$D(im):1,1:2)_"\TYPEOVER,INSERT" W pBL_tCL_tLO D ^ZAA02GEDPL G:ZAA02GF="EX" MENU
        I X=1 K @ugl@(TID,"MODE"),im D MODE^ZAA02GED G MENU
        I X=2 S @ugl@(TID,"MODE")=1,im=1 D MODE^ZAA02GED G MENU
        G MENU
EXIT K X,Y Q
        ;
