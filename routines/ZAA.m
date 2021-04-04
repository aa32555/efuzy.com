ZAA 
	S ^ZAAG("SETTINGS","TABLES_PREFIX")="ZAA01D"
	G SCRN^ZAA02  Q 
BuildDefinitions D BuildDefinitions^ZAA01 Q 
Get(%ZZDATA,%ZZTABLE) Q $$Get^ZAA01(.%ZZDATA,.%ZZTABLE)
TestDefinitions D TestDefinitions^ZAA01 Q
GetRoutineList(routine,result) D GetRoutineList^ZAA01(routine,.result) Q
Link(routines) D Link^ZAA01(routines) Q
	;			 
	;	
	;