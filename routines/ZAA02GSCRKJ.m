ZAA02GSCRKJ ;PG&A,ZAA02G-SCRIPT,2.10,KILL JOBS;10JUN94 1:44P
C ;Copyright (C) 1991-1994, Patterson, Gray & Associates, Inc.
 ;
 S A=^ZAA02G("OS") I "DTM"[A G @A
 Q
DTM K JOB F J=1:1:32 S A=$ZJ(J) I $P(A,"|",5)?1.N.E S JOB(J)=$P(A,"|",2,10)_"|"_$ZIO($P(A,"|",5))
 S Y="1,3\RTHLGSD\1\Current System Users\#   Status   Routine    nsp    pdv   cdv   lines     name     port      "
 S Y(0)="\EX\JOB\TO;2`$P(JOB(TO),""|"");5`$P(JOB(TO),""|"",2);8`$P(JOB(TO),""|"",3);4`$P(JOB(TO),""|"",4);3`$P(JOB(TO),""|"",5);3`$P(JOB(TO),""|"",7);7`$P(JOB(TO),""|"",8);4`$P(JOB(TO),""|"",10);14"
 S $P(Y(0),"\",9)=9 I $D(LJ) S $P(Y(0),"\",7)=LJ
 D ^ZAA02GPOP I X[";EX" G END
 I X["TIMEOUT" S LJ=+X G DTM
 S j=+X K Y K JOB S Y="20,10\HL\1\\\*,Do you want to terminate Job "_j_"?*,*,No,Yes" D ^ZAA02GPOP
 I X=5 d terminate^%mhalt
END K JOB S %R=3,%C=1 W @ZAA02GP,ZAA02G("CS") Q
