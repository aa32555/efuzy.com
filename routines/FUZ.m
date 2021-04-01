FUZ 
        ;
        ;
        ;
        Q
        ;
CheckAut()
        I $G(%G)]"",$G(%ACCOUNT)]"",$G(%EMAIL)]"",$G(%USER)]"" Q 1
        Q 0
        ;
ET 
        D BACK^%ETN
    K %J
        I $$CheckAut() S @("%J(""auth_status"")")="true"
        S HTTPRSP="^MI("":TEMP"",""HTTPERR"",$J,""JSON"")"
        D Error($ZE)
        S %J("mime")="application/json"
        S %J("header","Access-Control-Allow-Origin")="*"
        S %J("header","Access-Control-Allow-Headers")="Origin, X-Requested-With, Content-Type, Accept, auth, jwt"
        D ENCODE^MIWS("%J","^MI("":TEMP"",""HTTPERR"",$J,""JSON"")")
        D LOGERR^MIWS,SENDATA^MIWS
        S $ETRAP="Q:$ESTACK&$QUIT 0 Q:$ESTACK  S $ECODE="""" "
        Q
Success(M)
        S %J("FUZDialog","status")="true"
        S %J("FUZDialog","props","iconPath")="CheckMark"
        S %J("FUZDialog","props","iconWidth")="150"
        S %J("FUZDialog","props","iconHeight")="150"
        S %J("FUZDialog","props","message")=M
        S %J("FUZDialog","props","buttons","ok")="true"
        Q
        ;
Warning(M)
        S %J("FUZDialog","status")="true"
        S %J("FUZDialog","props","iconPath")="Warning"
        S %J("FUZDialog","props","iconWidth")="150"
        S %J("FUZDialog","props","iconHeight")="150"
        S %J("FUZDialog","props","message")=M
        S %J("FUZDialog","props","buttons","ok")="true"
        Q
        ;
WarningWithCallBack(M,C,D,L)
        S %J("FUZDialog","status")="true"
        S %J("FUZDialog","props","iconPath")="Warning"
        S %J("FUZDialog","props","iconWidth")="150"
        S %J("FUZDialog","props","iconHeight")="150"
        S %J("FUZDialog","props","message")=M
        S %J("FUZDialog","props","buttons","cancel")="true"     
        S %J("FUZDialog","props","buttons","run","label")=L
        S %J("FUZDialog","props","buttons","run","action")=C
        M %J("FUZDialog","props","buttons","run","data")=D
        Q
        ;
Error(M)
        S %J("FUZDialog","status")="true"
        S %J("FUZDialog","props","iconPath")="Alert"
        S %J("FUZDialog","props","iconWidth")="150"
        S %J("FUZDialog","props","iconHeight")="150"
        S %J("FUZDialog","props","message")=M
        S %J("FUZDialog","props","buttons","ok")="true"
        Q
        ;
