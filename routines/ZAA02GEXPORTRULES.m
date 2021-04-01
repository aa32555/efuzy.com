ZAA02GEXPORTRULES ;Export code rules  ;2019-02-07 15:52:30;
 Q
ST ;  ZAA02Gweb
 s fn ="EXPORTRULES-"_$P($H,",",1)_".csv"
 d EXPORT^ZAA02GEXPORTRULES(fn)
 W !!!
 W "<div><font face='verdana' size='2'>"_$ZDATETIME($H,5) ,!
 w "<br><br>'"_fn_"' file created in report folder. "_"</div>"
 w "<br><br><a target='_blank' href='st^ZAA02Gdownload'>Go to 'Download Reports'</a>"
 q 
 
EXPORT(fn) 
 n rptFolder,resFile,delim,lnDelim,nm,val
 s delim=""""_","_"""" s lnDelim=$C(13)_$C(10)
 s rptFolder=$$GetReportsFolder^ZAA02GUTILS2() 
 s resFile=##class(%Library.File).%New(rptFolder_fn)
 d resFile.Open("WNS")
.
 ;header
 s hdr=""""_"Rule"_delim_"Description"_delim_"Message"_delim_"Flags"
 s hdr=hdr_delim_"Test acct`Specialty"_delim_"Filter"_delim_""""_lnDelim
 d resFile.Write(hdr)
        
 S nm="" s val=""
 s nm=$O(^CODERULES(1,nm)) 
 While '(nm="")
  { 
        s z1=$Q(^CODERULES(1,nm))
        s val=^CODERULES(1,nm)
                        
        s line=""""
        for i=1:1:6 {
                s line=line_$P(val,"|",i)_delim
        }
        s line=line_""""_lnDelim 
                
        d resFile.Write(line) 
        s nm=$O(^CODERULES(1,nm)) 
 }      
 
 d resFile.Close()
 q
.
