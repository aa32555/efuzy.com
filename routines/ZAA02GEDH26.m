%ZAA02GEDH26
	F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
	W "." G ^ZAA02GEDH27
D Q
	;;2330,1,26;~(Step 3)~.  Select the output device, and its left and right
	;;2330,1,27;margins.  Additional information regarding selection of
	;;2330,1,28;output device and margins is available under ~<Conventions>~. ;
	;;2501;Export Utility||40
	;;2501,0,"Conventions";2190
	;;2501,1,1;The Export Utility can be used to move source code, includ-
	;;2501,1,2;ing internal comments, from one AA UTILS environment to
	;;2501,1,3;another.  In some environments, this utility can be used to
	;;2501,1,4;create ASCII distribution files which can be loaded using
	;;2501,1,5;the Restore Routines Utilities provided with each of the
	;;2501,1,6;available PC implementations of MUMPS. ;
	;;2501,1,7;
	;;2501,1,8;~(Step 1)~.  From the Function menu, select Utility. ;
	;;2501,1,9;         From the Utility menu, select Export. ;
	;;2501,1,10;
	;;2501,1,11;~(Step 2)~.  Select the routines to be exported.  Additional
	;;2501,1,12;information regarding routine selection is provided under
	;;2501,1,13;~<Conventions>~. ;
	;;2501,1,14;
	;;2501,1,15;~(Step 3)~.  Select the export medium.  In most cases, the
	;;2501,1,16;export medium will be a global.  If so, enter the name of
	;;2501,1,17;the Global.  When the export is completed, move the global
	;;2501,1,18;to the new environment and restore it with AA UTILS. ;
	;;2501,1,19;
	;;2501,1,20;In some environments, the export medium may also be an
	;;2501,1,21;ASCII file.  If you select ASCII file, you will be asked
	;;2501,1,22;for the name (complete with path) of the file to be used. ;
	;;2501,1,23;If that file already exists, you will be notified of its
	;;2501,1,24;existence and asked if it should be overwritten. ;
	;;2501,1,25;
	;;2501,1,26;~(Step 4)~.  Select routine format.  You can export routines in
	;;2501,1,27;either source code or executable format.  Routines exported
	;;2501,1,28;as source code include internal comments and can be restored
	;;2501,1,29;only with the AA UTILS Import utility.  Routines exported
	;;2501,1,30;in executable form contain no internal comments and are
	;;2501,1,31;written in a format compatible with the destination
	;;2501,1,32;system's Restore Routine Utility. ;
	;;2501,1,33;
	;;2501,1,34;~(Step 5)~.  Enter comments.  You may enter a brief comment as
	;;2501,1,35;part of the export file header. ;
	;;2501,1,36;
	;;2501,1,37;Exporting of the selected routines will begin immediately,
	;;2501,1,38;and as it proceeds, the name of the routine being exported
	;;2501,1,39;will be displayed in the lower left corner of the screen. ;
	;;2501,1,40;When complete you will be returned to the Utility menu. ;
	;;2502;Import Utility||66
	;;2502,1,1;This utility loads routines into the AA UTILS routine data-
	;;2502,1,2;base from other AA UTILS systems.  It can also import from
	;;2502,1,3;from MUMPS, and ASCII files created by Routine Save Utili-
	;;2502,1,4;ties provided with most PC-DOS based MUMPS implementations. ;
	;;2502,1,5;Imported routines are placed directly into the workfile. ;
	;;2502,1,6;
	;;2502,1,7;~(Step 1)~.  From the Function menu, select Utilities. ;
	;;2502,1,8;         From the Utilities menu, select Import. ;
	;;2502,1,9;
	;;2502,1,10;~(Step 2)~.  Select the source of the routines to be imported. ;
	;;2502,1,11;Available sources include GLOBAL and MUMPS.  In some envir-
	;;2502,1,12;onments, an ASCII file option will also be provided. ;
	;;2502,1,13;
	;
	;