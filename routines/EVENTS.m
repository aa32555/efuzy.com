EVENTS
        ;
        ;
        ;
        Q
        ;
Model(T)
        N R 
        ;
        S T("F","title")="Events"
        S T("F","editTitle")="Edit Event"
        S T("F","multiIndex",1)="date:time"
        ;
        ;
        ;
        I $I(R) 
        S T("M",R,"model")="id"
        S T("M",R,"data","id")=""
        S T("M",R,"type")="number"
        S T("M",R,"rules","required")="true"
        ;
        I $I(R) 
        S T("M",R,"model")="active"
        S T("M",R,"type")="number"
        S T("M",R,"data","active")="true"
        S T("M",R,"rules","required")="true"
        ;
        I $I(R) 
        S T("M",R,"model")="client"
        S T("M",R,"data","client")=""
        S T("M",R,"type")="string"
        S T("M",R,"rules","required")="true"
        S T("M",R,"index")="true"
        ;
        I $I(R) 
        S T("M",R,"type")="date"
        S T("M",R,"model")="date"
        S T("M",R,"data","date")=""
        S T("M",R,"transformOnIndex")="V=$$ZDH^SALON(V)"
        S T("M",R,"rules","required")="true"
        S T("M",R,"index")="true"
        ;
        I $I(R) 
        S T("M",R,"type")="time"
        S T("M",R,"model")="time"
        S T("M",R,"data","time")=""
        S T("M",R,"transformOnIndex")="V=$$ZTH^SALON(V)"
        S T("M",R,"rules","required")="true"
        S T("M",R,"index")="true"
        ;
        I $I(R) 
        S T("M",R,"model")="staff"
        S T("M",R,"data","staff")=""
        S T("M",R,"type")="string"
        S T("M",R,"rules","required")="true"
        S T("M",R,"index")="true"
        ;
        I $I(R) 
        S T("M",R,"model")="location"
        S T("M",R,"data","location")=""
        S T("M",R,"type")="string"
        S T("M",R,"rules","required")="true"
        S T("M",R,"index")="true"
        ;
        I $I(R) 
        S T("M",R,"model")="service"
        S T("M",R,"data","service")=""
        S T("M",R,"type")="string"
        S T("M",R,"rules","required")="true"
        S T("M",R,"index")="true"
        ;
        I $I(R) 
        S T("M",R,"model")="serviceoption"
        S T("M",R,"data","serviceoption")=""
        S T("M",R,"type")="string"
        S T("M",R,"rules","required")="true"
        S T("M",R,"index")="true"
        ;
        I $I(R)
        S T("M",R,"type")="string"
        S T("M",R,"model")="notes"
        S T("M",R,"data","notes")=""
        ;
        I $I(R)
        S T("M",R,"type")="string"
        S T("M",R,"model")="discount1code"
        S T("M",R,"data","discount1code")=""
        S T("M",R,"index")="true"
        ;
        I $I(R)
        S T("M",R,"type")="string"
        S T("M",R,"model")="discount1type"
        S T("M",R,"data","discount1type")=""
        ;
        I $I(R)
        S T("M",R,"type")="string"
        S T("M",R,"model")="discount1value"
        S T("M",R,"data","discount1value")=""
        ;
        I $I(R)
        S T("M",R,"type")="string"
        S T("M",R,"model")="discount2id"
        S T("M",R,"data","discount2id")=""
        ;
        I $I(R)
        S T("M",R,"type")="string"
        S T("M",R,"model")="discount2type"
        S T("M",R,"data","discount2type")=""
        ;
        I $I(R)
        S T("M",R,"type")="string"
        S T("M",R,"model")="discount2value"
        S T("M",R,"data","discount2value")=""
        ;
        I $I(R)
        S T("M",R,"type")="string"
        S T("M",R,"model")="duration"
        S T("M",R,"data","duration")=""
        ;
        I $I(R)
        S T("M",R,"type")="string"
        S T("M",R,"model")="processing"
        S T("M",R,"data","processing")=""
        ;
        I $I(R)
        S T("M",R,"type")="string"
        S T("M",R,"model")="requested"
        S T("M",R,"data","requested")=""
        S T("M",R,"rules","required")="true"
        S T("M",R,"index")="true"
        ;
        I $I(R)
        S T("M",R,"type")="string"
        S T("M",R,"model")="parentid"
        S T("M",R,"data","parentid")=""
        S T("M",R,"rules","required")="true"
        S T("M",R,"index")="true"
        ;
        I $I(R)
        S T("M",R,"type")="string"
        S T("M",R,"model")="status"
        S T("M",R,"data","status")="booked"
        ;
        Q
