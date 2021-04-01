ZAA02GSETUTILS4;;2016-06-10 13:18:40
 ; no global vars required
 q
 
DeleteSettingAndPage(SettingKey) ; delete setting, delete page
 s SettingKey=$G(SettingKey)
 n PageTag s PageTag=""
 s PageTag=$P($P($G(^ZAA02GSETTINGS(SettingKey)),$C(9),2),"?",2)
 
 k ^ZAA02GSETPAGES(PageTag)
 k ^ZAA02GSETTINGS(SettingKey)
 n msg s msg="" 
 s msg="Setting deleted: "_SettingKey_" page deleted: "_PageTag
 q msg
.
DeletePageAndSettings(PageTag) ; delete page, and delete setting
 k ^ZAA02GSETPAGES(PageTag)
 ;example ^ZAA02GSETTINGS("AUTOPOST") = "Posting / Charges"_$c(9)_"START^ZAA02GSETPAGE?AUTOPOST"_$c(9)_"Autopost Sets"  
 ;find in ^ZAA02GSETTINGS and delete this entry
 n i n tp s i="" s tp="" n msg s msg="" n del s del=""
 
 s i=$O(^ZAA02GSETTINGS(i)) 
 while '(i="")
 { 
        s tp=$P($P($G(^ZAA02GSETTINGS(i)),$C(9),2),"?",2)
        s del=i 
        s i=$O(^ZAA02GSETTINGS(i)) //get next
        if (tp=PageTag) { k ^ZAA02GSETTINGS(del) s msg=msg_del_" , "}
 } 
 q "Page deleted: "_PageTag_" setting deleted: "_msg
 
CreateSettingsPageFromDict(DictTag,PageTag,PageTitle,PageComments,SettingsCategory,SettingsTitle) ; create page, create setting, copy from DICT with this tag
        
        n i, gr, ln, cat, include, hasItems, i1,l1
        s gr="" s ln="" s i="" s hasItems=0 
        
        s i=$O(^ZAA02GSETDICT(i))
        if (i="")
        {
         q "no DICT"
        }
 
        n resDel s resDel=$$DeletePageAndSettings(PageTag)              //kill old page
        
        s include=0 
        while '(i="")
        {                                                                                                               //^ZAA02GSETDICT(0) = "Statement Program"_$c(9)_"STP" 
                s gr=$P($G(^ZAA02GSETDICT(i)),$C(9),1)                                      //header if exists
                s cat="" s cat=$P($G(^ZAA02GSETDICT(i)),$C(9),2)            //tag
                        
                s include=0 
                
                //if only one item need exact match    
                
                if $F(DictTag,",")=0 
                {
                        if (cat=DictTag) s include=1 
                        if (DictTag="*") s include=1 //will copy all!
                }
                else    
                {   s l1=$L(DictTag,",") //"AUTOPOST,STP,DEMO"
                        s include=0
                        for i1=1:1:l1
                        {
                                if ($P(DictTag,",",i1)=cat) s include=1 
                        }
                }
                        
                if include //found root of a matching tag 
                {
                 s hasItems=1
                 m ^ZAA02GSETPAGES(PageTag,i)=^ZAA02GSETDICT(i)
                 s ^ZAA02GSETPAGES(PageTag,i)=gr
                 
                }
                
                s i=$O(^ZAA02GSETDICT(i))
        }
        
        ;if (hasItems)                  ;no, add always..
        ;{      //set page title and comments
                s ^ZAA02GSETPAGES(PageTag)=PageTitle_$C(9)_PageComments 
                //add to settings       
                s ^ZAA02GSETTINGS(PageTag)=SettingsCategory_$C(9)_"START^ZAA02GSETPAGE?"_PageTag_$C(9)_SettingsTitle 
.
        ;}
 
        q "Page created:"_PageTag_"   from DICT:"_DictTag
.
AddToDictPage(tag) ; add this page items to the DICT dictionary page; test only - copy from pages to dictionary
 n i s i="" n last s last=""
 if tag="DICT" q
 s i=$O(^ZAA02GSETPAGES(tag,""))
 while '(i="")
 {
        s last=$O(^ZAA02GSETDICT(""),-1)
        M ^ZAA02GSETDICT(last+1)=^ZAA02GSETPAGES(tag,i)
        s ^ZAA02GSETDICT(last+1)=$G(^ZAA02GSETDICT(last+1))_$C(9)_tag
        s i=$O(^ZAA02GSETPAGES(tag,i))
 }
 q
.
AddNewToDictionary(DictEntry,Rows,SelListItems) ; add this page items to the DICT dictionary page; test only - copy from pages to dictionary
 //ZAA02GSETDICT(33)=DictEntry
 //ZAA02GSETDICT(33,1)=row1
 //0:0 sel item 0;1:here item 1;2:this is another item, value is 2;choice:description of choice
 //ZAA02GSETDICT(33,1,0)=sel list item 1
 //ZAA02GSETDICT(33,1,1)=sel list item 2
 //ZAA02GSETDICT(33,2)=row2
.
 
 n last s last="" n l1,l2,l3,l4,l5,l6 s (l1,l2,l3,l4,l5,l6)=""
 s last=$O(^ZAA02GSETDICT(""),-1) + 1 //new Dict index
 s ^ZAA02GSETDICT(last)=DictEntry
.
 s l1=$P(Rows,"<<<230>>>",1)
 s l2=$P(Rows,"<<<230>>>",2)
 s l3=$P(Rows,"<<<230>>>",3)
 s l4=$P(Rows,"<<<230>>>",4)
 s l5=$P(Rows,"<<<230>>>",5)
 s l6=$P(Rows,"<<<230>>>",6)
 
 if $L(l1) s ^ZAA02GSETDICT(last,1)=l1
 if $L(l2) s ^ZAA02GSETDICT(last,2)=l2
 if $L(l3) s ^ZAA02GSETDICT(last,3)=l3
 if $L(l4) s ^ZAA02GSETDICT(last,4)=l4
 if $L(l5) s ^ZAA02GSETDICT(last,5)=l5
 if $L(l6) s ^ZAA02GSETDICT(last,6)=l6
 
 n i s i=1 n c s c=$L(SelListItems,";") n p1,p2 s (p1,p2)=""
 for i=1:1:c
 {
         s p1=$P($P(SelListItems,";",i),":",1)
         s p2=$P($P(SelListItems,";",i),":",2)
         if $L(p1) s ^ZAA02GSETDICT(last,1,i-1)=p1_$C(9)_p2
 }
 q "Added ^ZAA02GSETDICT("_last_") :"_$C(10,13)_DictEntry
.
.
MoveDictItemUpDn(DisplayedType,Indx,UpOrDn)
 ;;DisplayedType,Indx,UpOrDn (1 or -1)
 n res n tmp s tmp=""
 
 if UpOrDn>=0 s UpOrDn=1
 if UpOrDn<0 s UpOrDn=-1 
 
 d RenumberDictItems //renumber, integers only starting at 1
 m tmp=^ZAA02GSETDICT(Indx)
 
 if ((DisplayedType=" ") || (DisplayedType=""))
        {
        if (UpOrDn=-1) //up
        { 
                if (Indx>1.5) m ^ZAA02GSETDICT(Indx-1.5)=tmp k ^ZAA02GSETDICT(Indx) 
        }
        if (UpOrDn=1) //dn
        { 
                m ^ZAA02GSETDICT(Indx+1.5)=tmp k ^ZAA02GSETDICT(Indx)
        }
        
 }
 else 
 {  n nxtUp,dt,done
    s nxtUp="" s dt="" s done=0
    
    s nxtUp=Indx
    while '(done)
    {   
        s nxtUp=$O(^ZAA02GSETDICT(nxtUp),UpOrDn) 
                s dt=$G(^ZAA02GSETDICT(nxtUp)) 
                if (nxtUp="") s done=1 //no more items
                if ($P(dt,$C(9),2)= DisplayedType) 
                        {
                                s done=1 //found the one to go in front
                                m ^ZAA02GSETDICT(nxtUp+((UpOrDn)*0.5))=tmp
                                k ^ZAA02GSETDICT(Indx)
                        }
    }
 }
.
 d RenumberDictItems 
 s res="will move node ^ZAA02GSETDICT("_Indx_")  "_dir_" within category: "_DisplayedType
 q res
 
RenumberDictItems
 n DictTemp s DictTemp=$G(^ZAA02GSETDICT)
        s i="" s newIndx=0
        s i=$O(^ZAA02GSETDICT(i))
        while '(i="")
        {
                s newIndx=newIndx+1
                m DictTemp(newIndx)=^ZAA02GSETDICT(i)
                s i=$O(^ZAA02GSETDICT(i))
        }
        k ^ZAA02GSETDICT
        m ^ZAA02GSETDICT=DictTemp
 q
