FUZPage
        ;
        ;
        ;
        Q
        ;
getPageData(D,O)
        N DATA M DATA=D("data")
        N PAGE S PAGE=$$ZCVT^SALON(DATA("routine"),"U")  
        N OUT
        D @(PAGE_"(.OUT)")
        M O("data","page")=OUT
        Q
        ;
