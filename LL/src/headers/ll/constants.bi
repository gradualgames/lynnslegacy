#IfNDef __LLCONSTANTS_BI__
  #Define __LLCONSTANTS_BI__
  
  #IfNDef FALSE
    Const As Integer FALSE = 0
    
  #EndIf
  
  #IfNDef TRUE
    Const As Integer TRUE = ( Not FALSE )
  
  #EndIf

  #IfNDef NULL
    Const As Integer NULL = 0
    
  #EndIf

  Const As Integer LL_EVENTS_MAX = 4096

  Const MAX_TEMP_ENEMIES As Integer = 90

  const as double conf_Box = 65536
  
  


#EndIf __LLCONSTANTS_BI__
