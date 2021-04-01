ZAA02GUTILS2 ;;2018-02-21 15:39:46
 ;
GetNamespaceFolder()
 n folder
 D INT^%DIR,NSP^%DIR 
 s folder=%SYSDIR
 q folder
 ;
GetPathDelim() 
    n UNIX,DELIM
        S UNIX=$S($ZV["UNIX":1,1:0),DELIM=$S(UNIX:"/",1:"\") 
        q DELIM
 ;
GetReportsFolder()
 n folder
 s folder=$$GetNamespaceFolder()
 if ($G(^MSCG("ADDSUBDIR"))) s folder=folder_"claims"_$$GetPathDelim()
 q folder
 ;
TranslateToFullPath(spFolder) //relative to the namespace folder, will not convert if starts with \\,  c:\, d:\ etc
 n (spFolder) s spFolder=$G(spFolder)
 s res=spFolder
.
 ;add \ or / at the end if not there
 s delim=$$GetPathDelim() 
 if '($E(spFolder,$L(spFolder))=delim) s spFolder=spFolder_delim
.
 if (($E(spFolder,2,2)=":") ! ($E(spFolder,1,2)="\\") ! ( spFolder[".." ) ) //assume it is already a full path if spFolder starts with \\ or *: 
        { 
                s res = ""   // spFolder  *** DO NOT ALLOW LOCATIONS THAT ARE NOT UNDER NAMESPACE ***
        }
 else 
        { 
                s res = $$GetNamespaceFolder()_spFolder ; navigate from namespace folder
        }
 q res
  ; 
