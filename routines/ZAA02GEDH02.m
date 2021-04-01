%ZAA02GEDH02 ;;%AA UTILS;1.21;(Subroutine);19JUL91  16:30
        ;;Copyright (C) 1990,91 Patterson, Gray & Associates, Inc. ;
        ;;All rights reserved. ;
        ;Loaded July 19, 1991 at 4:03 PM
        F I=1:1 S X=$T(D+I) Q:X=""  S S=$P(X,";",3),T=$P(X,";",4,99),@(GN_"("_S_")=T")
        W "." G ^ZAA02GEDH03
D Q
        ;;1000,1,2;screen environment designed exclusively for creating and
        ;;1000,1,3;editing MUMPS routines.  Included with the Editor is a Code
        ;;1000,1,4;Library function with which commonly used code can be stored
        ;;1000,1,5;and recalled when needed. ;
        ;;1000,1,6;
        ;;1000,1,7;While editing a routine, each programmer is provided a
        ;;1000,1,8;~<workspace>~.  Since this workspace is disk-based, there is no
        ;;1000,1,9;size limit and programmers can leave the Editor and return
        ;;1000,1,10;without fear of losing work in progress.  The Editor even
        ;;1000,1,11;remembers the position of the cursor so that it can begin
        ;;1000,1,12;at the same point when programmer returns to it. ;
        ;;1000,1,13;
        ;;1000,1,14;Each programmer can also configure the Routine Editor to
        ;;1000,1,15;satisfy his or her environmental preferences.  Such options
        ;;1000,1,16;include the intensity of the display, tab settings, 80 vs. ;
        ;;1000,1,17;132 column mode, and whether menus should be hot-keyed or
        ;;1000,1,18;require a carriage return when selecting an option. ;
        ;;1000,1,19;
        ;;1000,1,20;Additional information is available on the following
        ;;1000,1,21;topics.  SELECT and OPEN the topic of interest to you. ;
        ;;1000,1,22;
        ;;1000,1,23;~(Programmer Options:)~
        ;;1000,1,24;  ~<Options>~                making the environment work
        ;;1000,1,25;
        ;;1000,1,26;~(Routine Handling:)~
        ;;1000,1,27;  ~<Creating A Routine>~     starting from scratch
        ;;1000,1,28;  ~<Loading A Routine>~      getting it from MUMPS or AA UTILS
        ;;1000,1,29;  ~<Saving A Routine>~       where it goes and what happens
        ;;1000,1,30;  ~<Compiling A Routine>~    getting it back to MUMPS
        ;;1000,1,31;
        ;;1000,1,32;
        ;;1000,1,33;~(Routine Editing:)~
        ;;1000,1,34;  ~<Conventions>~            what AA UTILS expects
        ;;1000,1,35;  ~<Exiting the Editor>~     getting out
        ;;1000,1,36;  ~<Copy Text>~              copying text from anywhere
        ;;1000,1,37;  ~<Cut Line>~               breaking a line into two
        ;;1000,1,38;  ~<Delete Character>~       removing one or more characters
        ;;1000,1,39;  ~<Delete Line>~            removing a row of code or text
        ;;1000,1,40;  ~<Discard Text>~           discarding text from library
        ;;1000,1,41;  ~<Erase to EOL>~           erasing to the end-of-line
        ;;1000,1,42;  ~<Find/Replace String>~    replacing strings
        ;;1000,1,43;  ~<Find End-of-Routine>~    move cursor to end of the routine
        ;;1000,1,44;  ~<Find Line>~              move cursor to a specific line
        ;;1000,1,45;  ~<Find String>~            finding strings
        ;;1000,1,46;  ~<Insert Line>~            insert a new line
        ;;1000,1,47;  ~<Insert Text>~            insert text in a line (or toggle)
        ;;1000,1,48;  ~<Join Lines>~             join two lines
        ;;1000,1,49;  ~<Jump to BOL>~            move cursor to beginning of line
        ;;1000,1,50;  ~<Jump to EOL>~            move cursor to end of line
        ;;1000,1,51;  ~<Move Text>~              move text to a new location
        ;;1000,1,52;  ~<Other Options>~          use calculator or ASCII chart
        ;;1000,1,53;  ~<Recall Text>~            fetch text from library
        ;;1000,1,54;  ~<Save Text>~              save text to library
        ;;1000,1,55;  ~<Swapline Up>~            swap current line with previous
        ;;1000,1,56;  ~<Swapline Down>~          swap current line with next
        ;;1100;Programmer Options||51
        ;;1100,1,1;AA UTILS provides several options which can be easily
        ;
