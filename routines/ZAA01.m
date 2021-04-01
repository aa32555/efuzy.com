ZAA01
	;
	D BuildDefinitions
	;
	Q
	;
GetList(TableDefinitions)
	i $d(@TableDefinitions) q 0 ;                                 
	N R 
	D GetRoutineList^ZAA(^ZAAG("SETTINGS","TABLES_PREFIX")_"*",.R)
	N D S A="" F  S A=$O(R(A)) Q:A=""  D @("^"_A)
	;s @TableDefinitions@("PatientCustomData")="Map^ZAA01D01:^PACUS:ACCESSION(R)|SEQUENCE(O):^PACUS:Patient Custom Data"
	;s @TableDefinitions@("PatientDemographics")="Map^ZAA01D02:^PADEM:ACCESSION(R):^PADEM:Patient Demographics"
	q 1
	;
BuildDefinitions;
	n %a,%b,%data,%DATA 
	i '$$GetList("%data") q
	s %a="" f  s %a=$o(%data(%a)) q:%a=""  d
	. k ^ZAA01G("MAP","DEF","RAW",%a)
	. S ^ZAA01G("MAP","DEF","RAW",%a)=%data(%a)
	. i '$$LoadData($na(%data(%a))) q
	. i '$$Process($na(%data(%a))) q
	q 
	;
LoadData(%d)
	n %r,%l,%i,%a,%k
	i '$d(@%d)              q 0
	s @%d=$p(@%d,":")
	i $t(@@%d)=""   q 0
	s %r=$p(@%d,"^",2)
	s %l=$p(@%d,"^")
	f %i=2:1 s %a=$p($t(@%l+%i^@%r),";",2,999) q:$$ZCVT($$TRIM($t(@%l+%i^@%r)),"L")="q"  d
	. i $tr(%a,"- "_$c(9))="" q
	. s %a=$$merge(%a,$c(9))
	. s %a=$$genparse(%a,$c(9),"""","|")
	. f %k=1:1:$l(%a,"|") s $p(%a,"|",%k)=$$TRIM($p(%a,"|",%k))
	. s @%d@($o(@%d@(""),-1)+1)=%a
	q 1
	;
ZCVT(STR,T)
	S T=$$LOW^MIWS(T)
	I T="l" Q $$LOW^MIWS(STR)
	I T="u" Q $$UP^MIWS(STR)
	Q       
	;
Process(%d)
	s @%d=$p(@%d,":")
	n %File,%Field,%G,%D1,%D2,%i
	n %P1,%P2,%I1,%I2,%I3,%I4,%I5,%Func,%a,%b,%Type,%g
	s %g=$NA(^ZAA01G("MAP","DEF","RAW"))
	s %a="" f  s %a=$o(@%d@(%a)) q:%a=""  d
	. s %Type=$qs(%d,1)
	. s %Field=$p(@%d@(%a),"|") q:%Field="FieldName"
	. s %G=$p(@%d@(%a),"|",2)
	. k %D,%i f %i=1:1:$l($p(@%d@(%a),"|",3)," ") d
	.. s %D="%D"_%i s @%D=$p($p(@%d@(%a),"|",3)," ",%i) s:@%D="BLNK" @%D=" "
	.. i @%D]"" s @%g@(%Type,"Fields",%Field,%D)=@%D
	. k %P,%i f %i=1:1:$l($p(@%d@(%a),"|",4)," ") d
	.. s %P="%P"_%i s @%P=$p($p(@%d@(%a),"|",4)," ",%i)
	.. i @%P]"" s @%g@(%Type,"Fields",%Field,%P)=@%P
	. k %I,%i f %i=1:1:8 d
	.. s %I="%I"_%i s @%I=$p(@%d@(%a),"|",4+%i)
	.. i @%I]"" s @%g@(%Type,"Fields",%Field,%I)=@%I
	.. i @%I]"",'$d(@%g@(%Type,"Params",@%I)) s @%g@(%Type,"Params",@%I)="" 
	. i %G]"" s @%g@(%Type,"Fields",%Field,"%G")=%G
	q 1
	;
Get(%sg,%st)
	n %sp,%sf,%zval,%zi,%zii,%tmp,%G,%I,%P,%D,%str,%ZAUT1STATUS,%zzg
	s %ZAUT1STATUS=1
	K %sp M %sp=@%sg K @%sg
	f %i=1:1:10 f %zii="%I","%D","%P" s %tmp=%zii_%i n @%tmp
	s %G=$NA(^ZAA01G("MAP","DEF","RAW")),@%G@(%st)=$P(@%G@(%st),":")
	I $T(@("OnBeforeGet^"_$P(@%G@(%st),"^",2)))]"" D @("OnBeforeGet^"_$P(@%G@(%st),"^",2)_"(.%sp)")
	i '%ZAUT1STATUS q %ZAUT1STATUS
	s %sf="" f  s %sf=$o(@%G@(%st,"Fields",%sf)) q:%sf=""  d
	. k %zval m %zval=@%G@(%st,"Fields",%sf)
	. s %zzg=$G(%zval("%G"))
	. f %i="%I","%D","%P" d
	.. k %tmp s %tmp="s "_%i_"=$tr($o(%zval("""_%i_"999""),-1),"_""""_%i_""")" x %tmp
	.. s %tmp="f %zii=1:1:"_%i_" k %tmp s %tmp="_""""_%i_"""_"_"%zii"_" s @%tmp=$G(%zval("_""""_%i_"""_"_"%zii"_"))" x %tmp
	. k %str s %str=$$fs(%I,%D,.%sp) x %str k %zval
	n %a s %a="" f  s %a=$o(%sp(%a)) q:%a=""  i $e(%a)'="[",%a'="PARAMS" s @%sg@("PARAMS",%a)=%sp(%a)
	I $T(@("OnAfterGet^"_$P(@%G@(%st),"^",2)))]"" D @("OnAfterGet^"_$P(@%G@(%st),"^",2)_"(%sg)")
	q %ZAUT1STATUS
fs(%I,%D,%sp)
	i %I'?1n.n!(%D'?1n.n) q ""
	n %p,%i,%d,%g,%t,%zi,%zii,%tmp s (%p,%i,%d,%g,%t)=""
	f %zi=1:1:%D d
	. S:(@("%D"_%zi)'="NULL"&(@("%P"_%zi)'="NULL")) %p=%p_"$p(",%d=%d_"%D"_%zi_",%P"_%zi_")," q
	. S:(@("%D"_%zi)="NULL"&(@("%P"_%zi)="NULL")) %p="",%d=""
	f %zi=1:1:%I d  
	. i $tr(@("%I"_%zi),"[]")'=@("%I"_%zi) d
	.. s %sp(@("%I"_%zi))=$tr(@("%I"_%zi),"[]")
	. s %i=%i_"%sp("_"%I"_%zi_")"_","
	s %g="@%zzg@" f %zii="%i","%p","%d" k %tmp s %tmp="s "_%zii_"=$e("_%zii_",1,$l("_%zii_")-1)" x %tmp
	i %p="",%d="",$d(@(%g_"("_%i_")"))>1 q ("m @%sg@(%sf)="_%g_"("_%i_")")  
	q ("s @%sg@(%sf)=$s($g("_%g_"("_%i_"))]"""":"_%p_"("_%g_"("_%i_")"_$s(%d="":")",1:","_%d)_",1:"""")")
	;
	;
replace(%s,%f,%t)
	i $tr(%s,%f)=s q %s
	n %o,%i s %o="" f %i=1:1:$l(%s,%f)  s %o=%o_$s(%i<$l(%s,%f):$p(%s,%f,%i)_t,1:$p(%s,%f,%i))
	q %o
	;
merge(%str,%v)
	i '$l(%str) q %str
	i $l(%v)'=1     q %str
	i $tr(%str,%v)=%str q %str
	n %a,%b,%c,%i,%o s %b=0,%c=0,%o="" 
	f %i=1:1:$l(%str) d
	. i $e(%str,%i)'=%v s %c=0 s %o=%o_$e(%str,%i) q
	. i '%c,$e(%str,%i)=%v  s %c=1 s %o=%o_$e(%str,%i) q
	q %o
	;
genparse(%str,%d,%q,%n)
	n %i,%o,%c,%t s %c=0,%o=""
	i '$l(%str) q %str
	i $tr(%str,%d)=%str q %str
	f %i=1:1:$l(%str) s %t=$e(%str,%i) d
	. i %t=%q,'%c s %c=1 q
	. i %t=%q,%c s %c=0 q
	. i %t'=%q,%t'=%d,%t'=%n s %o=%o_%t
	. i %t=%d,%c s %o=%o_%d
	. i %t=%d,'%c s %o=%o_%n
	. i %t=%n s %o=%o_"$c("_$a(%t)_")"
	q %o
TRIM(STR)       Q $$ltrim($$rtrim(STR))
	;
rtrim(str) ;
	i '$l(str) q str
	i $e(str,$l(str))'=" " q str
	n i f i=$l(str):-1:1 q:$e(str,i)'=" "  d
	. i $e(str,i)=" " s $e(str,i)=""
	q str
	;
	;
ltrim(str) ;
	i '$l(str) q str
	i $e(str)'=" " q str
	n i f i=1:1:$l(str) q:$e(str,i)'=" "  d
	. i $e(str,i)=" " s $e(str,i)="" s i=i-1
	q str  
	;
RunTest
	N A,DATA
	I '$$GetList("DATA") S ($X,$Y)=0 Q
	S A="" F  S A=$O(DATA(A)) Q:A=""  D
	. W "Testing: "_A H 2 
	. D @("TestMany^"_$P($P(DATA(A),"^",2),":"))
	Q 
	;
GetRoutineList(routine,result)
	N %ZR K result,%ZR
	do SILENT^%RSEL(routine,"CALL")
	M result=%ZR
	K %ZR
	Q
	;
Link(routines)
	N R,RTN
	D GetRoutineList(routines,.R)
	N A S A="" F  S A=$O(R(A)) Q:A=""  D
	. S RTN=A
	. I $E(RTN)="%" S $E(RTN)="_"
	. ZL RTN
	Q