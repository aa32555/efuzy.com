ZAA02GSETPAGE ; ;2018-06-08 13:26:30
 ; ADS Corp. Copyright
 Q
.
START ;ZAA02Gweb 
 N (%,RLC)
 S hst1=$G(%("HOST:"))
 S IP=$G(%("ADDRESS"))
 
 S url1="setflag^ZAA02GSETUTILS1"
 S url2="setval^ZAA02GSETUTILS1"
 
 s ThisForm=$P($G(%("FORM","DATA")),"?",1)
 
 n handle, usr, connOK
 s handle=$P($G(%("FORM","DATA")),"?",2)
 s usr=$P($G(%("FORM","DATA")),"?",2)
 ;todotodo
 ;w "this is the handle and user: "_handle_"  "_usr
 ;go through^ZAA02GVBUSER("LOGON", usr) for today - piece 3; piece 6 is the handle, if logged-off:piece five is filled in
 ;if handle for today found and not logged off - connection is valid
 s connOK=1
 
 n isProtected
 s isProtected=0
  
 //get Protected list
 n ProtectedList s ProtectedList=";"_$G(^ZAA02GVBUSER("CODE","DEFAULTS","PROTECTED",0))_";" //semicolon separated
 if $F(ProtectedList,";START^ZAA02GSETPAGE?"_ThisForm_";")>0 s isProtected=1
 
 s debug=0
 if ($D(^DBG("ON"))) s debug=1
 
 W "<!DOCTYPE HTML>",!
 W "<head><meta http-equiv=""X-UA-Compatible"" content=""IE=9"">"
.
 d WRITESTYLE^ZAA02GSETUTILS(debug)
 
 d WRITECOMMONSCRIPT^ZAA02GSETUTILS
 d WRITESAVESETTINGSSCRIPT^ZAA02GSETUTILS(url1,url2)
.
 w "</head>"
.
 W "<body>",!
.
 i ($L(ThisForm)=0) {
         //w "<div class='hdr1' title='Error'>There is a problem with this page:</div>",!
         w "<div class='hdr1' title='Error'>Form name is missing.</div>",!
         q
 }
 if '(connOK) {
         w "<div class='hdr1' title='Error'>Page cannot be loaded: connection handle is invalid.</div>",!
         q
 }
.
 W "<div style='display:none;' id='rlcBox'>"_RLC_"</div>" ,!
 s fname="", note=""
 
 s fname=$P($G(^ZAA02GSETPAGES(ThisForm)),$C(9),1)
 s note=$P($G(^ZAA02GSETPAGES(ThisForm)),$C(9),2)
 w "<title>"_fname_"</title>", !
 
 w "<div class='hdr1' title='"_ThisForm_"'>"_fname_"</div>",!
 
 if (isProtected)  w "<div class='hdr3'>Not allowed to change: read only mode</div><br>",!
 if (isProtected) if (debug) s isProtected=0  w "<div class='hdr3'>Allowed for DBG mode only</div><br>",!
.
 
 if ($Length(note))
 {
 w "<div class='hdr2'>"_note_"</div><br>",!
 }
 
 W "<div style='display: none;' id='warning';  >",!
 W "<br> <font color='red'  size='2px'>*** Some entries could not be saved. See below for detail. Reload page to see current status. *** <br><br>"  ,!
 W "</font></div>", !
 
HTMLstart
 
        n i, gr, k, ln, tp1
        s gr="" s ln="" s tp=""
        s i="" s k=""
        s i=$O(^ZAA02GSETPAGES(ThisForm,i))
        
        if (i="")
        {
         //w "<div class='hdr1' title='Error'>There is a problem with this page:</div>",!
         w "<div class='hdr1' title='Error'>Form '"_ThisForm_"' has no data fields defined.</div>",!
         q
        }
        
  //show buttons
  
        if '(isProtected) W "<button onClick='ApplySettings()'>Save Settings </button>",! 
        //W "&nbsp&nbsp&nbsp<button class='dbg' onClick='window.location.reload()'>Reload </button>",! 
        W "<br><br>",!
.
        n EntSp 
        while '(i="")
        {
                 s gr=$P($G(^ZAA02GSETPAGES(ThisForm,i)),$C(9),1)
                 n cat s cat="" s cat=$P($G(^ZAA02GSETPAGES(ThisForm,i)),$C(9),2)
                 n grAddr s grAddr="" s grAddr="^ZAA02GSETPAGES("_ThisForm_","_i_")"
                 if (debug||(ThisForm="DICT")) {
                         if $L(cat)>0 W "<font color='green'>"_cat_"</font>"
                         w " <div class='ex3'>"_grAddr_"</div>"
                 }
                 
                 w "<table>"
                 
                 if ($D(^ZAA02GSETPAGES(ThisForm,i))=1) { 
                        W $$MakeGridTitle^ZAA02GSETUTILS2(gr) }
                 else {
                        
                        W $$MakeGridHeader^ZAA02GSETUTILS2(gr) }
                 
                 s k=""
                 s k=$O(^ZAA02GSETPAGES(ThisForm,i,k))
                 while '(k="")
                 {
                        s ln=$G(^ZAA02GSETPAGES(ThisForm,i,k))
                         
                        s title1=$P(ln,$C(9),1)
                        s ad1=$P(ln,$C(9),2) 
                        s tp=$P(ln,$C(9),3)
                        s lst1=$P(ln,$C(9),4)
                        s tg1="LN-"_i_"R"_k 
                         
                        s EntSp=+$P(ln,$C(9),5)
                         
                        n thisEnt n nxtEnt
                        s thisEnt=0 s nxtEnt=0
                        n tgL n adL s tgL="" s adL=""
                         
                        if ((tp="SEL")||(tp="DSEL")) ; prepare a list for dropdowns
                        { 
                                if (lst1="")
                                {       ;lst1 tag can be a parameter for GetSelectionArr^ZAA02GSETTINGS1
                                        ;if no tag for list provided: look for values in the page definition global under this node
                                        s lst1="^ZAA02GSETPAGES("""_ThisForm_""","_i_","_k_")"
                                                ;if nothing under this node go to level 0 
                                                ; example: if nothing under ^ZAA02GSETPAGES("AAAA",0,2) - look under ^ZAA02GSETPAGES("AAAA",0,0)
                                        if ($D(@(lst1))<11) 
                                        {
                                                s lst1="^ZAA02GSETPAGES("""_ThisForm_""","_i_",0)"
                                        }
                                }
                        }                        
                                
                        if (EntSp>0)
                        {
                                s nxtEnt=+$O(^PRMG(nxtEnt))
                                while (nxtEnt)
                                {
                                        s thisEnt=nxtEnt
                                        ;build grid line for this entity, modify address to add Entity index, make unique cell ID (tgL)
                                        s tgL=tg1_"-E-"_thisEnt
                                        s adL=$E(ad1,1,$L(ad1)-1)_","_thisEnt_")"
                                        
                                        ;if this is deletable value (or for all non-boolean values?) - show difference between 'not set' and '' (empty or null)
                                        ;so for DTXT and DSEL
                                        n oldval s oldval=$$GetVal^ZAA02GSETUTILS3(adL)
                                        ;find out if oldval is an empty string or does not exist, display differently
                                        
                                        if ((tp="DTXT")||(tp="DSEL")) if (oldval="") if (($D(@adL)=0)||($D(@adL)=10)) {s oldval="-not set-"}
                                        ;s ^DBG("zzzM")=oldval
                                        if (isProtected) s tp="READ"
                                        w $$MakeOneGridLine^ZAA02GSETUTILS2(title1,oldval,$$GetVal^ZAA02GSETUTILS3(adL),tgL,adL,thisEnt,tp,lst1), !
                                                
                                        s nxtEnt=+$O(^PRMG(nxtEnt))
                                }
                        }
                        else 
                        {
                                n oldval1 
                                s oldval1=$$GetVal^ZAA02GSETUTILS3(ad1)
                                ;s ^DBG("zzz")=oldval1
                                ;find out if oldval is an empty string or does not exist, display differently
                                if ((tp="DTXT")||(tp="DSEL")) if (oldval1="") if (($D(@ad1)=0)||($D(@ad1)=10)) {s oldval1="-not set-"}
                                
                                if (isProtected) s tp="READ"
                                W $$MakeOneGridLine^ZAA02GSETUTILS2(title1,oldval1,$$GetVal^ZAA02GSETUTILS3(ad1),tg1,ad1,0,tp,lst1),! 
                        }
.
                        s k=$O(^ZAA02GSETPAGES(ThisForm,i,k))
                 }
                 
                 w "</table><br>"
                 
                s i=$O(^ZAA02GSETPAGES(ThisForm,i))
        }
 
 W "<br>",!
.
 W "<p> <textarea class='ex4' id='res' rows='8' cols='80'> ...... </textarea> "  ,!
 W "</body>",!
.
HTMLend
 
 q
 
.
.
.
