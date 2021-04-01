ZAA02GSETUTILS2 ;;2018-07-06 14:29:03
 ; returns HTML strings for grids 
 ; no global vars required
 q
MakeGridTitle(Title)
 n resH n style1 
 s style1="grTitle1"
 
 if $L(Title)=0 s style1="grh2" q ""  
 s resH="<tr class='"_style1_"'><td>"_Title_"</td></tr>"
 q resH
.
MakeGridHeader(Title)
 n resH n style1 
 s style1="grh1"
 
 if $L(Title)=0 s style1="grh2" q ""  
.
 s resH="<tr class='"_style1_"'><td>"_Title_"</td><td>&nbsp&nbsp  &nbsp</td><td class='ex3'> Setting </td><td class='grEntH'>Ent.Sp</td></tr>"
 
 q resH
.
MakeGridLine(Descr,OldVal,NewVal,ID,Address,Ent,IsPwd)
 s IsPwd=+$G(IsPwd)
 s Ent=+$G(Ent)
 n res
 s res="<tr>"
 s res=res_"<td class='grC1' title='"_Address_"'> "_Descr_"</td>"
 //make text input box wider , max at 100
 n long1 s long1=8
 if $L(OldVal) s long1=($L(OldVal) + 2) 
 if ($L(OldVal)>10) s long1=($L(OldVal) + 10) 
 if ($L(OldVal)>20) s long1=($L(OldVal) + 20) 
 if long1>100 s long1=100
 s PwdType="" if IsPwd s PwdType=" type='password' "
 s res=res_"<td><input "_PwdType_" class='inputbox1' size='"_long1_"' id='"_ID_"' value='"_NewVal_"'></td>"
 s res=res_"<td class='setName'>"_ID_"</td>"
 s res=res_"<td class='ex5' > <div id='"_ID_"-Addr'>"_Address_"</div> </td> "
 ;s res=res_"<td class='grEnt'>"_"  Ent. "_Ent_"</td> </tr>"
 s clsEnt="grEnt0"  if (Ent>0)  {        s clsEnt="grEnt"  }
 s res=res_"<td class='"_clsEnt_"'>"_"  Ent. "_Ent_"</td> </tr>"
 q res
 
MakeGridLineReadOnly(Descr,OldVal,NewVal,ID,Address,Ent)
 s Ent=+$G(Ent)
 n res
 s res="<tr>"
 s res=res_"<td class='grC1' title='"_Address_"'> "_Descr_"</td>"
 s res=res_"<td class='grC2'>&nbsp&nbsp "_OldVal_"</td>"
 s res=res_"<td class='grColReadOnly'>&nbsp&nbsp "_" n/a "_"</td>"
                ;s res=res_"<td><input id='"_ID_"' value='"_NewVal_"'</td>"
 s res=res_"<td class='setNameRO'>"_ID_"</td>"
 s res=res_"<td class='ex5' > <div id='"_ID_"-Addr'>"_Address_"</div> </td>"
 s clsEnt="grEnt0"  if (Ent>0)  {        s clsEnt="grEnt"  }
 s res=res_"<td class='"_clsEnt_"'>"_"  Ent. "_Ent_"</td> </tr>"
 q res 
 
MakeGridLineDropdown(Descr,OldVal,NewVal,ID,Address,SelectionLisZAA02Gey,Ent,NoEmpty)
 s Ent=+$G(Ent)
 s NoEmpty=+$G(NoEmpty) // if set to 1 allow to add empty line
 n res, Dflt, arrList
 s res="<tr>"
 s res=res_"<td class='grC1' title='"_Address_"'> "_Descr_"</td>"
 //s res=res_"<td class='grC2'>&nbsp&nbsp "_OldVal_"</td>"
 s Dflt=NewVal
 d GetSelectionArr^ZAA02GSETUTILS3(SelectionLisZAA02Gey,.arrList)
        ;m ^DBG("arrList",AllowedListTag)=arrList
 s res=res_"<td>"_$$MakeDropdown(ID,.arrList,Dflt,,NoEmpty)_"</td>"
 s res=res_"<td class='setName'>"_ID_"</td>"
 s res=res_"<td class='ex5' > <div id='"_ID_"-Addr'>"_Address_"</div> </td>"
 ;s res=res_"<td class='grEnt'>"_"  Ent. "_Ent_"</td> </tr>"
 s clsEnt="grEnt0"  if (Ent>0)  {        s clsEnt="grEnt"  }
 s res=res_"<td class='"_clsEnt_"'>"_"  Ent. "_Ent_"</td> </tr>"
 q res
 
MakeDropdown(ID,arr,SelectedVal,OnChangeFunction,NoEmpty) 
 ; if SelectedVal is not found in the list it will be added to the list at the beginning
 ; also add an empty string 
 s NoEmpty=+$G(NoEmpty) // if set to 1 allow to add empty line
 s res="" s List=""
 n fnc s fnc=""
 if $L($G(OnChangeFunction)) s fnc=" onchange="_OnChangeFunction_" "
 s res="<select "_fnc_"class='selectClass' id='"_ID_"'>"
        n i,data,vl,desc, SEL, fnd
        s data="" s SEL="" s fnd=0
        s i=""
.
        s i=$O(arr(i))
        while '(i="")
        {
                s SEL=""
                s vl=$P($G(arr(i)),$C(9),1)
                if 'fnd if (vl=SelectedVal) {s SEL=" selected " s fnd=1} //select the first match in the list only
                s desc=$P($G(arr(i)),$C(9),2)
                s data=data_"<option value='"_vl_"'"_SEL_">"_desc_"</option>"
                s i=$O(arr(i))
        }
 s List=data
 i (fnd=0) s List="<option selected value='"_SelectedVal_"'>"_SelectedVal_"</option>"_List
 ;if there is none in the list - add an empty string to the beginning, only if allowed
 n hasEmpty s hasEmpty=0
 if ($F(List,"<option></option>")>0) s hasEmpty=1
 if ($F(List,"<option selected></option>")>0) s hasEmpty=1
 if ($F(List,"<option selected value=''></option>")>0) s hasEmpty=1
 if '(hasEmpty) if '(NoEmpty) s List="<option></option>"_List 
 s res=res_List_"</select>"
 q res
.
MakeGridLineBool(Descr,OldVal,NewVal,ID,Address,Ent) ;OldVal, NewVal: 0 or 1
 s Ent=+$G(Ent)
 n res
 s res="" s oldCell="" s newCell=""
 s vl2="" i (NewVal) s vl2="checked"
 s vl1="" i (OldVal) s vl1="checked"
 s oldCell="<input type='checkbox' "_vl1_" disabled> "
 s newCell="<input type='checkbox' id='"_ID_"' "_vl2_"> "
 
 s res= "<tr><td class='grC1'  title='"_Address_"'> "_Descr_"</td>"
 //s res=res_"<td class='grC2'  style='text-align:center;'>"_oldCell_"</td>"
 s res=res_"<td  style='text-align:center;'>"_newCell_"</td>"
 s res=res_"<td class='swName'>"_ID_"</td><td class='ex5' > <div id='"_ID_"-Addr'>"_Address_"</div>  </td>"
 ;s res=res_"<td class='grEnt'>"_"  Ent. "_Ent_"</td> </tr>"
 s clsEnt="grEnt0"  if (Ent>0)  {        s clsEnt="grEnt"  }
 s res=res_"<td class='"_clsEnt_"'>"_"  Ent. "_Ent_"</td> </tr>"
 q res
 
MakeOneGridLine(lineTitle,oldVal,newVal,tag,addr,thisEnt,thisType,lst1)
                n res s res=""
                s lst1=$G(lst1)
                
                ;all original tags start with "TBL..."
                if (thisType="EPWD") s tag="E"_tag ; allow empty value to be saved - nulls allowed
                if (thisType="ETXT") s tag="E"_tag ; allow empty value to be saved - nulls allowed
                if (thisType="DTXT") s tag="D"_tag ; empty value will delete this node
                if (thisType="DSEL") s tag="D"_tag ; empty value will delete this node
                         
                if ((thisType="SEL")||(thisType="DSEL"))
                        {
                    s noEmpty=0 
                    if (thisType="SEL") s noEmpty=1
                        s res=$$MakeGridLineDropdown(lineTitle,oldVal,newVal,tag,addr,lst1,thisEnt,noEmpty)     
                        }
                elseif ((thisType="")||(thisType="TXT")||(thisType="ETXT")|| (thisType="DTXT"))
                        {
                        s res=$$MakeGridLine(lineTitle,oldVal,newVal,tag,addr,thisEnt,0)
                        }
                
                elseif ((thisType="PWD")||(thisType="EPWD"))
                        {
                        s res=$$MakeGridLine(lineTitle,oldVal,newVal,tag,addr,thisEnt,1)
                        }
                elseif (thisType="EXIST")
                         { 
                         s res= $$MakeGridLineBool(lineTitle,oldVal,newVal,tag,addr,thisEnt)
                         }                       
                         
                elseif (thisType="READ")
                         { 
                         s res= $$MakeGridLineReadOnly(lineTitle,oldVal,newVal,tag,addr,thisEnt)
                         }
 q res
 
.
