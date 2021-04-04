%ZAA02GEDKEY
KEYS S Y=(rm-76)_","_(tl+1)_"\THRLDYO~\2\EDITOR FUNCTIONS\ Function                Key Name ",Y(0)=(bl-tl)_"\CR,EX"
	N TR,BR,A1,A2,K,V,P,I S A1=@ZAA02G("G")@(.1,ZAA02G,5),A2=$P(^(6),"`",16,30)
	S J=0 F I=1:1 S T=$T(KEY+I) Q:T=""  I $P(T,";",3) S J=J+1,N=$P(T,";",4),V=$P(T,";",5),P=$P(T,";",6),X=$P(T,";",7) S:V]"" X=$P(@V,"`",P) S Y(J)=" "_N_$J(X,32-$L(N))_"~"
	S J=J+1,Y(J)="     (Press RETURN or EXIT)~" K A1,A2,I,J,K,N,P,T,V,X S REFRESH="" D ^ZAA02GEDPO K Y
	Q
KEY ;;
PD ;;1;Next Page;A1;1
PU ;;1;Previous Page;A1;2
FP ;;1;First Page;A1;3
GW ;;1;Jump to Beg-Of-Line;A2;5
GE ;;1;Jump to End-Of-Line;A2;10
SU ;;1;Swapline Up;A1;4
SD ;;1;Swapline Down;A1;5
XX ;;1;Insert Character;A2;8
YY ;;1;Delete Character;A2;9
IL ;;1;Insert Line;A1;6
DL ;;1;Delete Line;A1;7
EF ;;1;Erase to End-Of-Line;A1;8
ST ;;1;Tab Set/Clear;A1;9
OT ;;1;Other Options;A1;11
CP ;;1;Copy/Move;A1;12
GO ;;1;Find (String,Line,Etc.);A2;1
RE ;;1;Join Next Line;A2;2
CT ;;1;Cut Line;A2;3
HK ;;;Beginning of Line;A2;7
EX ;;1;Exit;A2;4
	;
	;