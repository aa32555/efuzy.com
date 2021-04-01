ZAA02GPOST ; Posting for ZAA02G-Script;2014-07-10 17:23:46;19MAR2003  10:27;
 ; ADS Corp. Copyright
 ; Requires TPSTOREP from /usr/y2c
 ; ^ZAA02GSCR("PARAM","ES-PRINTER")=S ^ZAA02GPOST("QUEUE",DOC)=""
 q
 ;
start ; start processing
 s $zt="^%ET"
 k ^SORT($j)
 ; for testing
 ;k ^ZAA02GSCR("TRANS",730,.011,"POST")
 ;s ^ZAA02GPOST("QUEUE",730)=""
 d ^SET
 I OPL<$P($G(^NPG("ZAA02GPOST")),":",2) W *7,!,"Insufficient Security Level" h 1 g MNUSP^MNU
 x CL22 w "Enter printer#: " r PR q:$ZB=Q
 i PR'="S",PR<1!(PR>(^LPT("Z")-1)) g start
 d ^PRNTR g:ZVD>1 MNUSP^MNU X USEPR
 d proc
 d report
 k ^SORT($j)
 w # c PR x USEIO
 g MNUSP^MNU
 ;
proc ; start queue processing
 n %,act,char,count,data,data1,err,i,job,len,msg,seq
 n tmp,trans,translst,user
 s %="`"
 s seq=1
 l +^ZAA02GPOST("run"):1 i '$t d msg("Already Running",0) q
 s job=""
 f  s job=$o(^ZAA02GPOST("QUEUE",job)) q:job=""  d
 . i $d(^ZAA02GSCR("TRANS",job,.011,"POST")) s data=^("POST") d  q
 .. s datetime=$p(data,%)
 .. s site=$p(data,%,4)
 .. s act=$p(data,%,5)
 .. s user=$p(data,%,6)
 .. s dxp=$p(data,%,7)
 .. s dos=$p(data,%,8)
 .. s date=$$DG^IDATE(+datetime),date=$e(date,5,6)_"/"_$e(date,7,8)_"/"_$e(date,1,4)
 .. f i=1:1 s data1=$p($p(data,%,2),";",i) q:data1=""  d
 ... s translst=""
 ... i $e(data1)="e" s err=$p(data1,"-",2),translst=""
 ... i $e(data1)="t" s err="",translst=$p(data1,"-",2)
 ... i translst d msg("Job "_job_" (DXP="_i_") already posted to trans "_translst_" [Site: "_site_", Account: "_act_", DOS: "_dos_"]",0)
 ... i 'translst d msg("Job "_job_" (DXP="_i_") already reported error(s) ("_err_") [Site: "_site_", Account: "_act_", DOS: "_dos_", Transcr: "_user_"]",0),msg("  DXP: "_dxp,0)
 .. k ^ZAA02GPOST("QUEUE",job)
 . s data=$g(^ZAA02GSCR("TRANS",job,.011)) ;i $p(data,"`",6)'="SK" k ^ZAA02GPOST("QUEUE",job) q  ; special change for SJRA
 . k data s flag("DXP:")=0,flag("DOA:")=0,line=.03
 . f  s line=$o(^ZAA02GSCR("TRANS",job,line)) q:line=""  d
 .. s data=^ZAA02GSCR("TRANS",job,line)
 .. i data?.e1l.e d tr(.data)
 .. s tmp=$s(data["DXP:":"DXP:",data["DOA:":"DOA:",1:"")
 .. i tmp="" q
 .. s flag(tmp)=1,data1=$p(data,tmp,2),data="",len=$l(data1)
 .. f i=1:1:len s char=$e(data1,i) i char'=" " s data=data_char
 .. s data(tmp)=data
 . s trans=""
 . i flag("DXP:") d
 .. s trans=$$post(job,$g(data("DXP:")),$g(data("DOA:")))
 .. ; t-transaction# or e-error``site`account`user`dxp data
 .. s site=$p(trans,%,3)
 .. s act=$p(trans,%,4)
 .. s user=$p(trans,%,5)
 .. s dxp=$p(trans,%,6)
 .. s dos=$p(trans,%,7)
 .. f i=1:1 s data=$p($p(trans,%),";",i) q:data=""  d
 ... i $e(data)="e" s err=$p(data,"-",2),translst=""
 ... i $e(data)="t" s err="",translst=$p(data,"-",2)
 ... i translst d msg("Job "_job_" (DXP="_i_") posted to trans "_translst_" [Site: "_site_", Account: "_act_", DOS: "_dos_"]",1)
 ... i 'translst d msg("Job "_job_" (DXP="_i_") reported error(s) ("_err_") [Site: "_site_", Account: "_act_", DOS: "_dos_", Transcr: "_user_"]",0),msg("  DXP: "_dxp,0)
 . i 'flag("DXP:") d msg("DXP data not found for document "_job,0)
 . k ^ZAA02GPOST("QUEUE",job)
 . ; $h`transaction#`errors`site`account`user`dxp data
 . i $d(^ZAA02GSCR("TRANS",job)) s ^(job,.011,"POST")=$h_"`"_trans
 l -^ZAA02GPOST("run")
 q
 ;
msg(message,type) ; save message
 n seq
 s seq=$g(^SORT($j,type))+1,^SORT($j,type)=seq
 s ^SORT($j,type,seq)=message
 q
 ;
post(job,dxp,doa) ; post data
 n %,act,ar,auto,count,dg,doac,dsb,emp,ent,EZ,i,items,K,K1,len
 n mod,op,OPER,out,pc,PRINTSW,ps,pv,qty,rf,rsn,S,tmp,TR,trans,user
 s %="`"
 i dxp?." " d msg("DXP data blank for document "_job,0)
 s len=$l(dxp,";")
 f count=1:1:len d
 . s trans=$p(dxp,";",count)
 . s dg=$p(trans,"-")
 . f i=1:1:4 s dg(i)=$p(dg,",",i)
 . s pc=$p($p(trans,"-",2),"$")
 . s mod=$e($p($p(trans,"$",2),"?"),1,2)
 . s qty=$p(trans,"?",2) i 'qty s qty=1
 . ;
 . s data=$g(^ZAA02GSCR("TRANS",job,.011))
 . d tr(.data)
 . s dos=$g(^ZAA02GSCR("TRANS",job,.011,"DS"))
 . s dos=$p(dos,"/",3)_$p(dos,"/")_$p(dos,"/",2)
 . s user=$p(data,%,5)
 . s ps=$p(data,%,6)
 . s pv=$p(data,%,7)
 . s act=$p(data,%,9) i '$p(act,"/",2) s $p(act,"/",2)=1
 . s rf=$p(data,%,16)
 . s op="SY"
 . ;
 . s ent=$o(^GRG(""))
 . s ar=$s(act="":"",ent="":"",1:$p($g(^GRG(ent,+act)),":",7))
 . s (auto,doac,dsb,emp,rsn)=""
 . i ar="FO"!(ar="NF")!(ar="WC") d
 .. s dsb="P",rsn="I",doac=doa
 .. i doac'?2n1"/"2n1"/"2n s doac=""
 .. i ar="FO"!(ar="NF") s auto="Y"
 .. i ar="WC" s emp="Y"
 . ;
 . s err=""
 . f i="act","ar","op","pc","ps","pv","qty","rf" i @i="" s tmp=i d tr(.tmp) d err(.tmp)
 . ; need entity allowed checks
 . i act]"",'$d(^GRG(+act)) d err("ACT")
 . i ar]"",'$d(^ARG(ar)) d err("AR")
 . i ar="SP" d err("AR/SP")
 . f i=1:1:4 i dg(i)]"",'$d(^DGG(dg(i))) d err("DG"_i)
 . i err="" f i=1:1:4 i dg(i)]"" s dg(i)=$p(^DGG(dg(i)),":",11)
 . i 'dos d err("DOS")
 . i op]"",'$d(^OPG(op)) d err("OP")
 . i pc]"",'$d(^PCG(pc)) d err("PC")
 . i pc]"",$d(^PCG(pc)),$p(^(pc),":",5)'="1" d err("PC/EZ")
 . i ps]"",'$d(^PSG(ps)) d err("PS")
 . i pv]"",'$d(^PVG(pv)) d err("PV")
 . i rf]"",'$d(^RFG(rf)) d err("RF")
 . i rf]"",$d(^RFG(rf))
 . i err]"" s out(count)="e-"_err_%_%_ps_%_act_%_user_%_dxp_%_dos q
 . ;
 . s S=+$h,$p(S,":",3)=+act,$p(S,":",7)=$p(act,"/",2)
 . s $p(S,":",6)=$p(^PCG(pc),":",25)
 . s $p(S,":",13)=pv
 . s $p(S,":",14)=rf
 . s $p(S,":",15)=ps
 . s $p(S,":",16)=dos
 . s $p(S,":",17)=op
 . s $p(S,":",18)=qty
 . s $p(S,":",21)=dg(3)_$s(dg(4)]"":"^",1:"")_dg(4)
 . s $p(S,":",22)=dg(1)
 . s $p(S,":",23)=dg(2)
 . s $p(S,":",27)=mod
 . s $p(S,":",29)=dsb
 . s $p(S,":",33)=rsn
 . s $p(S,":",34)=doac
 . s $p(S,":",35)=$s(auto="Y":2,emp="Y":4,1:"")
 . ;s $p(S,":",45)=ar
 . s K=+act,K1=$p(act,"/",2),OPER=op,PRINTSW=0,TEZ=ent
 . s AR=ar,DTE=$$DLI^IDATE(+$h),PROC=pc,SD=dos
 . k TR s ER=$$PROC^TPSTOREP(TEZ,K,K1,S,.TR)
 . s (sub,trans)="" f  s sub=$o(TR(sub)) q:sub=""  s trans=trans_$s(trans]"":",",1:"")_TR(sub)
 . s out(count)=$s(ER]"":"e-"_ER,1:"t-"_trans)
 . s $p(out(count),%,3,7)=ps_%_act_%_user_%_dxp_%_dos
 s (out,sub)="" f i=1:1 s sub=$o(out(sub)) q:sub=""  s tmp=$p(out,%),$p(out,%)=tmp_$s(tmp="":"",1:";")_$p(out(sub),%),$p(out,%,3,7)=$p(out(sub),%,3,7)
 q out
 ;
pset ; get price set (version 8)
 s (arg,pset)=""
 s t="" s:'ent="" t=$g(^GRG(ent,+act)) i t="" f i=1:1:^PRMG("Z")-1 s t=$g(^GRG(i,+act)) q:t'=""
 i t'="" s ar=$P(t,":",7)
 i ar'="" s arg=^ARG(ar) s:$D(^ARG(ar,ent)) arg=^(ent)
 s pset=$p(arg,":",4) q:pset'="I"
 s t=$G(^GRG(+act,2)) i t="" s pset=0 q
 s incd="" f pos=3,5,7,9 s incd=$p(t,":",pos) q:incd'=""
 i incd="" s pset=0 q
 s incd=$s(pos=3:"MDCR",pos=5:"MDCD",pos=7:"BLSH",1:incd)
 s pset=$p($g(^ING(incd)),":",23) s:pset="" pset=0
 q
 ;
tr(data) ; translate to upper case
 s data=$tr(data,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 q
 ;
err(msg) ; add message to error
 s err=err_$s(err]"":",",1:"")_msg
 q
 ;
report ; output report
 n sub
 w !,"ZAA02GSCRIPT Posting Report for " d ^%D w " " d ^%T
 w !!,"Errors/Messages:",!
 s sub="" f  s sub=$o(^SORT($j,0,sub)) q:sub=""  w !,^(sub)
 w !!,"Processed Successfully: ",!
 s sub="" f  s sub=$o(^SORT($j,1,sub)) q:sub=""  w !,^(sub)
 q
 ;
reprint ; reprint report
 n %,data,data1,date,datetime,dxp,err,i,job,msg
 n site,srchdate,translst,user
 k ^SORT($j)
 s %="`"
 r !!,"Reprint Report for +$H: ",srchdate
 i 'srchdate q
 r !,"Doc# to start with (enables quicker report): ",job
 d ^SET
 x CL22 w "Enter printer#: " r PR q:$ZB=Q
 i PR'="S",PR<1!(PR>(^LPT("Z")-1)) g start
 d ^PRNTR g:ZVD>1 MNUSP^MNU X USEPR
 f  s job=$o(^ZAA02GSCR("TRANS",job)) q:job=""  d
 . s data=$g(^ZAA02GSCR("TRANS",job,.011,"POST"))
 . i +data'=srchdate q
 . s datetime=$p(data,%)
 . s site=$p(data,%,4)
 . s act=$p(data,%,5)
 . s user=$p(data,%,6)
 . s dxp=$p(data,%,7)
 . s dos=$p(data,%,8)
 . s date=$$DG^IDATE(+datetime),date=$e(date,5,6)_"/"_$e(date,7,8)_"/"_$e(date,1,4)
 . f i=1:1 s data1=$p($p(data,%,2),";",i) q:data1=""  d
 .. s translst=""
 .. i $e(data1)="e" s err=$p(data1,"-",2),translst=""
 .. i $e(data1)="t" s err="",translst=$p(data1,"-",2)
 .. i translst d msg("Job "_job_" (DXP="_i_") already posted to trans "_translst_" [Site: "_site_", Account: "_act_", DOS: "_dos_"]",1)
 .. i 'translst d msg("Job "_job_" (DXP="_i_") already reported error(s) ("_err_") [Site: "_site_", Account: "_act_", DOS: "_dos_", Transcr: "_user_"]",0),msg("  DXP: "_dxp,0)
 d report
 k ^SORT($j)
 w # c PR x USEIO
 q
