ZAA02GFAXINh ;PG&A,ZAA02G-FAX,1.36,GERMAN COVER INIT;21JUL92 1:23P
 ;Copyright (C) 1992, Patterson, Gray and Associates Inc.
 ;
INIT X XX F J=0:1 S A=$P($T(INIT1+J),";;",2) Q:A=""  F K=1:1 S B=$P(A,";",K) Q:B=""  S @("^ZAA02GFAXC(""FX"",2,+B)=$C("_$P(B,",",2,99)_")")
 Q
INIT0 S X=$P($T(INIT0+1),";;",2,99),C="S D="""",E=^(A) F I=1:1:$L(E) S D=D_$A(E,I)_"",""" X X Q
 ;;S A="",B=" ;" F J=1:1 S A=$O(^ZAA02GFAXC("FX",4,A)) ZI:A="" B Q:A=""  X C X:$L(B)+$L(D)>240 "ZI B S B="" ;""" W A," " S B=B_";"_A_","_$E(D,1,$L(D)-1)
 Q
INIT1 ;;1,0,0,104,71,6,110,160,166,67,3;2,0,0,104,71,6,110,160,166,67,3;3,0,0,104,71,206,58,101,58,52;4,0,0,104,71,206,58,101,58,52;5,0,0,104,71,206,58,101,58,52;6,0,0,104,71,206,58,101,58,52
 ;;7,0,0,104,71,142,109,128,4,5,76,209,144,29,96,138,6,106,36,16,16,85,56,54,212,46,157,14,13;8,0,0,104,71,142,109,128,4,5,76,209,144,29,96,138,6,106,170,112,18,40,48,196,206,156,14,13
 ;;9,0,0,104,71,142,109,128,4,5,76,209,144,29,96,138,6,106,42,224,36,80,6,196,206,146,14,13;10,0,0,104,71,142,109,128,4,5,76,209,144,29,96,138,6,106,42,48,72,161,10,40,27,107,58,52
 ;;11,0,0,104,71,142,77,130,104,34,27,70,118,32,27,70,54,4,116,13,40,24,202,134,167,67,3;12,0,0,104,71,142,77,130,104,34,27,70,118,32,27,70,54,24,8,13,40,2,194,22,233,208,0
 ;;13,0,0,104,71,142,77,130,104,34,27,70,118,32,27,70,54,29,113,68,3,94,65,217,58,29,26;14,0,0,104,71,142,77,130,104,34,27,70,118,32,27,70,54,29,9,84,11,186,64,217,38,29,26
 ;;15,0,0,104,71,142,77,130,104,34,27,70,118,32,27,70,54,2,105,68,11,74,64,216,62,29,26;16,0,0,104,71,142,77,130,104,34,27,70,118,32,27,70,54,6,57,68,11,90,160,108,57,29,26
 ;;17,0,0,104,71,142,77,130,104,34,27,70,118,32,27,70,182,28,201,136,54,244,160,108,37,29,26;18,0,0,104,71,142,77,130,104,34,27,70,118,32,27,70,182,28,201,136,20,180,33,108,34,29,26
 ;;19,0,0,104,71,142,77,130,104,34,27,70,118,32,27,70,118,141,112,68,10,138,67,217,136,116,104,0;20,0,0,104,71,142,77,130,104,34,27,70,118,32,27,70,118,133,16,16,136,52,44,216,224,116,104,0
 ;;21,0,0,104,71,142,77,130,104,34,27,70,118,32,27,70,118,133,16,16,16,16,105,48,216,214,116,104,0;22,0,0,104,71,142,77,130,104,130,26,37,178,3,212,40,193,22,10,89,16,16,38,24,108,85,58,52
 ;;23,0,0,104,71,142,77,130,104,130,26,37,178,3,212,40,193,22,20,169,16,16,38,16,16,182,58,29,26;24,0,0,104,71,142,77,130,104,130,26,37,178,3,212,40,193,22,4,169,33,76,80,54,121,58,52
 ;;25,0,0,104,71,142,77,130,104,130,26,37,178,3,212,40,193,22,4,145,67,164,192,217,170,116,104,0;26,0,0,104,71,142,77,130,104,34,27,70,118,32,27,70,54,129,32,16,16,45,48,216,214,116,104,0
 ;;27,0,0,104,71,142,77,130,104,34,27,70,118,32,27,70,182,64,232,16,16,13,152,179,45,233,208,0;28,0,0,104,71,142,77,130,104,34,27,70,118,32,27,70,54,135,45,18,8,14,101,35,210,161,1
 ;;29,0,0,104,71,142,77,130,104,34,27,70,118,32,27,70,54,135,45,21,104,67,216,68,58,52;30,0,0,104,71,142,77,130,104,34,27,70,118,32,27,70,118,1,21,37,200,67,216,120,58,52
 ;;31,0,0,104,71,142,77,130,104,34,27,70,118,32,27,70,118,6,53,40,72,129,178,229,116,104,0;32,0,0,104,71,142,77,130,104,34,27,70,118,32,27,70,246,67,24,16,16,90,168,128,178,125,58,52
 ;;33,0,0,104,71,142,77,130,104,34,27,70,118,32,27,70,246,35,192,8,13,100,133,176,93,58,52;34,0,0,104,71,142,77,130,104,34,27,70,118,32,27,70,246,33,88,16,16,42,72,13,101,235,116,104,0
 ;;35,0,0,104,71,142,77,130,104,34,27,70,118,32,27,70,246,64,176,33,232,80,12,148,45,210,161,1;36,0,0,104,71,142,77,130,104,34,27,70,118,32,27,70,118,67,144,33,168,80,58,148,205,211,161,1
 ;;37,0,0,104,71,142,77,130,104,34,27,70,118,32,27,70,118,35,40,16,16,20,136,26,202,198,154,14,13;38,0,0,104,71,142,77,130,104,130,18,42,168,96,131,18,42,178,3,65,131,96,67,37,80,59,75,58,52
 ;;39,0,0,104,71,142,77,130,104,130,18,42,168,96,131,18,42,178,29,130,14,1,134,2,65,237,204,233,208,0;40,0,0,104,71,142,77,130,104,130,18,42,168,96,131,18,42,178,29,161,128,50,160,88,112,187,116,58,52
 ;;41,0,0,104,71,142,77,130,104,130,18,42,168,96,131,18,42,178,113,132,10,66,134,162,64,237,82,233,208,0;42,0,0,104,71,206,58,101,58,52;43,0,0,104,71,206,58,101,58,52;44,0,0,104,71,206,58,101,58,52;45,0,0,104,71,6,110,160,166,67,3
 ;;46,0,0,104,71,6,110,160,166,67,3
