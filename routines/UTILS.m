UTILS ;
        ;
        ;
        ;
        Q
        ;
ResizeJPEG(id,table,name)
        ;data:image/jpeg;base64,
        
        
        
GetUtilsPath() q ##class(%File).ManagerDirectory()_$SYSTEM.SYS.NameSpace()_"\"_"utils"_"\"
UID() q $p($SYSTEM.Util.CreateGUID(),"-")
DecodeBase64(str) q $system.Encryption.Base64Decode(str)
EncodeBase64(str) q $system.Encryption.Base64Encode(str)
ReadFileInChunks(file,holder,delete)
        N CNT S CNT=0
        N STREAM,REC
        S STREAM=##class(%FileCharacterStream).%New()
        S STREAM.Filename=file
        F  D  Q:STREAM.AtEnd
        . S REC=STREAM.Read(15000)
        . S CNT=CNT+1
        . S holder(CNT)=REC
        I $G(delete) H 0.1 C file D ##class(%File).Delete(file)
        Q
 
        
