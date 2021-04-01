AADEBUG ;
                ;
                ;
                ;
        S %REPLAY=1
        M RQ=^REPLAY("Q")
        S RQ("body")=^REPLAY("Q","body")
        S RR="ARR"
        N (RQ,RR,%REPLAY)
        D API^SALON(.RQ,.RR)
        N A S A="" F  S A=$O(ARR(A)) Q:A=""  W ARR(A)
        Q
        ;
