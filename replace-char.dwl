%dw 2.3
output application/json
fun filterString(str) =str replace /[^\u0600-\u06FF\w\d\s!@#$%&*()-_=+,>?'';\}{|]/  
 with ("\$")
fun filterObj(obj) = obj mapObject ((value, key, index) -> (key) : if ((value) is String) filterString(value) else if ((value) is Array) (value) map (filterObj($)) else if ((value) is Object) filterObj(value)  else value)
---
if (payload is Object) filterObj(payload) else if (payload is Array) payload map (filterObj($)) else payload
