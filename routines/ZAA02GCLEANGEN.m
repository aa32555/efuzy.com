ZAA02GCLEANGEN ;Clean General Images;04/07/2015 12:05:26
 S A="" F  S A=$O(^GIF(A)) Q:'A  D
 . S T="" F  S T=$O(^GIF(A,T)) Q:T=""  D
 .. S F="" F  S F=$O(^GIF(A,T,F)) Q:F=""  D:$D(^GIF(A,T,F))=1
 ... W !,A," ",T," ",F
 ... K ^GIF(A,T,F)
 K ^GIF("general")
 S ^GIF("general")=1
 K ^GIF("check")
