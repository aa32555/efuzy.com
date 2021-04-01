SYNC
        ;
        ;
        Q
        ;
ROUTES
        ;
        i $I(P)
        S @T@("pages",P,"path")="/sync"
        S @T@("pages",P,"name")="SyncShedule"
        S @T@("pages",P,"component")="SyncSchedule"
        S @T@("pages",P,"requiresAuth")="true"
        S @T@("pages",P,"type")="SALON"
        ;
        Q       
        ;
startSync(d,r,s)
        n st
        s st = $$Sync()
        S r("data","status")=$s(+st:"true",1:"false")
        S r("data","pid")=$p(st,":",2)
        q
        ;       
        
        ;
getSyncStatus(d,r,s)
        n st
        s st = $$CheckSync()
        S r("data","status")=$s(+st:"true",1:"false")
        S r("data","pid")=$p(st,":",2)
        Q
        ;
        ;
Sync()
        ;
        S SyncStatus = $$CheckSync()
        I SyncStatus Q SyncStatus
        J @("SyncShedul"_%GLOBAL_"Sync")
        Q "1"_":"_$ZCHILD
        ;
        ;
CheckSync() q $$chkProcess($TR(%GLOBAL,"^")_"Sync","")
        ;
        ;
        ;
        ;
chkProcess(processToChk, nameSpace ) ; //returns 1 if routine is running in the namespace, otherwise 0
 
 i $g(nameSpace)="" s nameSpace=$SYSTEM.SYS.NameSpace()  ; set to the current namespace if nothing is passed  in
 s isRunning=0
 s returnedPID=0
 s pidProcess="" s pidNamespace=""
 
 SET PID=""
        FOR I=1:1 {
        SET PID=$ORDER(^$JOB(PID))
        QUIT:PID="" 
        
                s pidRoutineName=$ZUTIL(67,5,PID)
                s pidNamespace=$ZUTIL(67,6,PID)
                s returnedPID = PID
                if (pidRoutineName=processToChk) if (nameSpace=pidNamespace) s isRunning=1 q
    }
    I 'isRunning S returnedPID=0
        q isRunning_":"_returnedPID
        Q
 
