fun jsonWrite(item) = item match {
    case is Array -> "[" ++ joinBy($ map jsonWrite($), ",") ++ "]"
    case is Object -> "{" ++ joinBy($ pluck ("\"" ++ $$ ++ "\":" ++
        ($ match {
            case is String -> "\"" ++ ($ replace "\"" with "\\\"") ++ "\""
            case is Object -> jsonWrite($)
            case is Array -> "[" ++ joinBy($ map jsonWrite($), ",") ++ "]"
            else -> $
        })),",") ++ "}"
    case is String -> "\"" ++ ($ replace "\"" with "\\\"") ++ "\""
    else -> $
}
