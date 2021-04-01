FUZLIST
        ;
        ;
        ;
        Q
        ;
GetList(D,O)
        N DATA M DATA=D("data")
        N TYPE S TYPE=DATA("type")
        N ROUTINE S ROUTINE=DATA("routine")
        S DATA("search")=$$ZCVT^SALON(DATA("search"),"L")
        N T K T D @(ROUTINE_"(.T)")
        N B K B D @("Model^"_TYPE_"(.B)")
        M O("data","definition")=T
        N SI S SI=$G(B("F","searchIndex"))
        S SI=$G(B("F","multiIndex",SI)) I SI="" Q 
        I $G(B("F","indexX"))]"" X B("F","indexX")
        I '$D(@%G@(TYPE,"INDEX",SI)) Q
        N A,C
        S A=""
        I DATA("search")]"" S A=$O(@%G@(TYPE,"INDEX",SI,DATA("search")),-1)
        F  S A=$O(@%G@(TYPE,"INDEX",SI,A)) Q:A=""  D
        . S ORDER=$G(@%G@(TYPE,"ORDER",@%G@(TYPE,"DATA",$O(@%G@(TYPE,"INDEX",SI,A,"")),"id")))
        . I ORDER="" S ORDER=$I(@%G@(TYPE,"HIGHEST-ORDER"))
        . I DATA("search")]"",A[DATA("search") M O("data","list",ORDER)=@%G@(TYPE,"DATA",$O(@%G@(TYPE,"INDEX",SI,A,""))) Q
        . I DATA("search")="" M O("data","list",ORDER)=@%G@(TYPE,"DATA",$O(@%G@(TYPE,"INDEX",SI,A,"")))
        Q
        ;
saveOrderedList(D,O)
        N DATA M DATA=D("data")
        N TYPE S TYPE=DATA("type")
        N LIST M LIST=DATA("list")
        K @%G@(TYPE,"ORDER")
        N A,C S A="" F  S A=$O(LIST(A)) Q:A=""  D
        . S @%G@(TYPE,"ORDER",LIST(A))=A
        S O("data","status")="true"
        Q
        ;
updateSingle(D,O)
        N TYPE S TYPE=D("data","type")
        M O("data","updated")=@%G@(TYPE,"DATA",D("data","id"))
        Q
        ;
