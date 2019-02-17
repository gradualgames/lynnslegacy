#IfNDef cha0sLISTS_BI
#Define cha0sLISTS_BI

  Enum
    list_reverse = -1
    list_dealloc = 1
    list_strlist = 2
  
    list_search_instr = -1
    
  End Enum
  
  
  #IfNDef Arg_Types
    Enum Arg_Types
    
      ARG_INT = 1
      ARG_UINT
      ARG_STR
      ARG_SNG
      ARG_DBL
      ARG_ULNG
      ARG_LNG
      ARG_PTR
    
    End Enum
    
  #EndIf
  
  Union list_value
    i As Integer
    ui As uInteger
    sn As Single
    s As String
    d As Double
    l As LongInt
    ul As uLongInt
    pnt As Any Ptr
    
  End Union
  
  Type list_type
    
    dat As list_value
    nxt As list_type Ptr  
    
  End Type
  
  
  Declare Function open_file_dialog( items As list_type Ptr, x As Integer = 1, y As Integer = 1 ) As Integer
  
  
  '' lists
  '' !!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  Declare Function length                   ( node As list_type Ptr ) As Integer                           
  Declare Sub      list_destroy                  ( node As list_type Ptr, dalloc As Integer = 0 )
  
  
  
  
  Declare Function list_Push Overload Alias "ListPush" ( node As list_type Ptr, value As Integer, id As Integer = ARG_INT ) As list_type Ptr
  Declare Function list_Push          Alias "ListPush" ( node As list_type Ptr, value As Single,  id As Integer = ARG_SNG ) As list_type Ptr
  Declare Function list_Push          Alias "ListPush" ( node As list_type Ptr, value As String,  id As Integer = ARG_STR ) As list_type Ptr
  Declare Function list_Push          Alias "ListPush" ( node As list_type Ptr, value As Double,  id As Integer = ARG_DBL ) As list_type Ptr
  Declare Function list_Push          Alias "ListPush" ( node As list_type Ptr, value As LongInt, id As Integer = ARG_LNG ) As list_type Ptr
  Declare Function list_Push          Alias "ListPush" ( node As list_type Ptr, value As Any Ptr, id As Integer = ARG_PTR ) As list_type Ptr
  
  Declare Function list_Cancel Overload Alias "ListCancel" ( m As list_type Ptr, l As list_type Ptr, value As Integer, id As Integer = ARG_INT ) As list_type Ptr
  Declare Function list_Cancel Overload Alias "ListCancel" ( m As list_type Ptr, l As list_type Ptr, value As Single, id As Integer = ARG_SNG ) As list_type Ptr
  Declare Function list_Cancel Overload Alias "ListCancel" ( m As list_type Ptr, l As list_type Ptr, value As String, id As Integer = ARG_STR ) As list_type Ptr
  Declare Function list_Cancel Overload Alias "ListCancel" ( m As list_type Ptr, l As list_type Ptr, value As Double, id As Integer = ARG_DBL ) As list_type Ptr
  Declare Function list_Cancel Overload Alias "ListCancel" ( m As list_type Ptr, l As list_type Ptr, value As LongInt, id As Integer = ARG_LNG ) As list_type Ptr
  Declare Function list_Cancel Overload Alias "ListCancel" ( m As list_type Ptr, l As list_type Ptr, value As Any Ptr, id As Integer = ARG_PTR ) As list_type Ptr
  
                                            
  Declare Function list_add Overload Alias "ListAdd" ( lst1 As list_type Ptr, lst2 As list_type Ptr, list_id As Integer, id As Integer = ARG_INT ) As list_type Ptr
  Declare Function list_add          Alias "ListAdd" ( lst1 As list_type Ptr, lst2 As list_type Ptr, list_id As Single , id As Integer = ARG_SNG ) As list_type Ptr
  Declare Function list_add          Alias "ListAdd" ( lst1 As list_type Ptr, lst2 As list_type Ptr, list_id As String , id As Integer = ARG_STR ) As list_type Ptr
  Declare Function list_add          Alias "ListAdd" ( lst1 As list_type Ptr, lst2 As list_type Ptr, list_id As Double , id As Integer = ARG_DBL ) As list_type Ptr
  Declare Function list_add          Alias "ListAdd" ( lst1 As list_type Ptr, lst2 As list_type Ptr, list_id As LongInt, id As Integer = ARG_LNG ) As list_type Ptr
  Declare Function list_add          Alias "ListAdd" ( lst1 As list_type Ptr, lst2 As list_type Ptr, list_id As Any Ptr, id As Integer = ARG_PTR ) As list_type Ptr
  
  Declare Function list_add_hooked Alias "ListAdd" ( lst1 As list_type Ptr, lst2 As list_type Ptr, list_id As Any Ptr, id As Integer ) As list_type Ptr
          
  
                                            
  Declare Function list_Append  Overload Alias "ListAppend" ( node As list_type Ptr, value As Integer, id As Integer = ARG_INT ) As list_type Ptr
  Declare Function list_Append           Alias "ListAppend" ( node As list_type Ptr, value As Single,  id As Integer = ARG_SNG ) As list_type Ptr
  Declare Function list_Append           Alias "ListAppend" ( node As list_type Ptr, value As String,  id As Integer = ARG_STR ) As list_type Ptr
  Declare Function list_Append           Alias "ListAppend" ( node As list_type Ptr, value As Double,  id As Integer = ARG_DBL ) As list_type Ptr
  Declare Function list_Append           Alias "ListAppend" ( node As list_type Ptr, value As LongInt, id As Integer = ARG_LNG ) As list_type Ptr
  Declare Function list_Append           Alias "ListAppend" ( node As list_type Ptr, value As Any Ptr, id As Integer = ARG_PTR ) As list_type Ptr
  
  
  Declare Function list_Pop Overload Alias "ListPop" ( node As list_type Ptr, ret As Integer,  id As Integer = ARG_INT )  As list_type Ptr
  Declare Function list_Pop          Alias "ListPop" ( node As list_type Ptr, ret As uInteger, id As Integer = ARG_UINT ) As list_type Ptr
  Declare Function list_Pop          Alias "ListPop" ( node As list_type Ptr, ret As String,   id As Integer = ARG_STR )  As list_type Ptr
  Declare Function list_Pop          Alias "ListPop" ( node As list_type Ptr, ret As Single,   id As Integer = ARG_SNG )  As list_type Ptr
  Declare Function list_Pop          Alias "ListPop" ( node As list_type Ptr, ret As Double,   id As Integer = ARG_DBL )  As list_type Ptr
  Declare Function list_Pop          Alias "ListPop" ( node As list_type Ptr, ret As LongInt,  id As Integer = ARG_LNG )  As list_type Ptr
  Declare Function list_Pop          Alias "ListPop" ( node As list_type Ptr, ret As uLongInt, id As Integer = ARG_ULNG ) As list_type Ptr
  Declare Function list_Pop          Alias "ListPop" ( node As list_type Ptr, ret As Any Ptr,  id As Integer = ARG_PTR )  As list_type Ptr
  
  
                                                 
  Declare Function list_Remove Overload Alias "ListRemove" ( node As list_type Ptr, v As Integer, id As Integer = ARG_INT ) As list_type Ptr
  Declare Function list_Remove          Alias "ListRemove" ( node As list_type Ptr, v As Single , id As Integer = ARG_SNG ) As list_type Ptr
  Declare Function list_Remove          Alias "ListRemove" ( node As list_type Ptr, v As String , id As Integer = ARG_STR ) As list_type Ptr
  Declare Function list_Remove          Alias "ListRemove" ( node As list_type Ptr, v As Double , id As Integer = ARG_DBL ) As list_type Ptr
  Declare Function list_Remove          Alias "ListRemove" ( node As list_type Ptr, v As LongInt, id As Integer = ARG_LNG ) As list_type Ptr
  Declare Function list_Remove          Alias "ListRemove" ( node As list_type Ptr, v As Any Ptr, id As Integer = ARG_PTR ) As list_type Ptr
                                                  
  Declare Function remove_hooked Alias "ListRemove" ( node As list_type Ptr, value As Any Ptr, id As Integer ) As list_type Ptr
  
  
  
  Declare Function list_search Overload Alias "ListSearch" ( node As list_type Ptr, v As Integer, strt As Integer = 0, id As Integer = ARG_INT ) As Integer
  Declare Function list_search Overload Alias "ListSearch" ( node As list_type Ptr, v As Single,  strt As Integer = 0, id As Integer = ARG_SNG ) As Integer
  Declare Function list_search Overload Alias "ListSearch" ( node As list_type Ptr, v As String,  strt As Integer = 0, id As Integer = ARG_STR ) As Integer
  Declare Function list_search Overload Alias "ListSearch" ( node As list_type Ptr, v As Double,  strt As Integer = 0, id As Integer = ARG_DBL ) As Integer
  Declare Function list_search Overload Alias "ListSearch" ( node As list_type Ptr, v As LongInt, strt As Integer = 0, id As Integer = ARG_LNG ) As Integer
  Declare Function list_search Overload Alias "ListSearch" ( node As list_type Ptr, v As Any Ptr, strt As Integer = 0, id As Integer = ARG_PTR ) As Integer
                                                                                                            
  Declare Function list_search_hooked Alias "ListSearch" ( node As list_type Ptr, v As Any Ptr, strt As Integer = 0, id As Integer ) As Integer
  
  
  
  
  
                                            
  Declare Sub      display_list Overload    ( node As list_type Ptr Ptr, value As Integer )
  Declare Sub      display_list             ( node As list_type Ptr Ptr, value As Single  )
  Declare Sub      display_list             ( node As list_type Ptr Ptr, value As String  )
  Declare Sub      display_list             ( node As list_type Ptr Ptr, value As Any Ptr )
                                            
                                            
  Declare Sub      list2bin     Overload    ( node As list_type Ptr, bina() As Integer,     pol As Integer = 0 ) 
  Declare Sub      list2bin                 ( node As list_type Ptr, bina   As Integer Ptr, pol As Integer = 0 ) 
  Declare Sub      list2bin                 ( node As list_type Ptr, bina() As Single,      pol As Integer = 0 ) 
  Declare Sub      list2bin                 ( node As list_type Ptr, bina   As Single Ptr,  pol As Integer = 0 ) 
  Declare Sub      list2bin                 ( node As list_type Ptr, bina() As String,      pol As Integer = 0 ) 
  Declare Sub      list2bin                 ( node As list_type Ptr, bina   As String Ptr,  pol As Integer = 0 ) 
  Declare Sub      list2bin                 ( node As list_type Ptr, bina() As Any Ptr,     pol As Integer = 0 ) 
  Declare Sub      list2bin                 ( node As list_type Ptr, bina   As Any Ptr Ptr, pol As Integer = 0 ) 
                                            
  Declare Sub      bin2list     Overload    ( bina() As Integer,     node As list_type Ptr )
  Declare Sub      bin2list                 ( bina   As Integer Ptr, node As list_type Ptr, sz As Integer ) 
  Declare Sub      bin2list                 ( bina() As Single,     node As list_type  Ptr )
  Declare Sub      bin2list                 ( bina   As Single Ptr, node As list_type  Ptr, sz As Integer )
  Declare Sub      bin2list                 ( bina() As String,     node As list_type  Ptr )
  Declare Sub      bin2list                 ( bina   As String Ptr, node As list_type  Ptr, sz As Integer )
  Declare Sub      bin2list                 ( bina() As Any Ptr,     node As list_type Ptr )
  Declare Sub      bin2list                 ( bina   As Any Ptr Ptr, node As list_type Ptr, sz As Integer )
                                            
                                            
  Declare Function list_files ( pth As String = ".", spec As String = "*.*", mask As Integer = 0 ) As list_type Ptr
                                                                                                            
  
  
  
  
  Declare Function list_node_value Overload ( l As list_type Ptr, n As Integer, id As Integer = 0 ) As Integer
  Declare Function list_node_value          ( l As list_type Ptr, n As Integer, id As String ) As String
  Declare Function list_node_value          ( l As list_type Ptr, n As Integer, id As Single ) As Single
  Declare Function list_node_value          ( l As list_type Ptr, n As Integer, id As Any Ptr ) As Any Ptr
  
  
  
  Declare Sub iterate_through_list( l As list_type Ptr, fp As Sub( l As list_type Ptr ) )                
  
  
  Declare Function push_sub_dirs( l As list_type Ptr, p As zString Ptr = 0 ) As list_type Ptr
  Declare Function push_dirs( p As zString Ptr = 0 ) As list_type Ptr
  Declare Function push_paths( p As zString Ptr = 0 )  As list_type Ptr
  
  
  Declare Function c_alloc( ls As list_type Ptr, sz As uInteger ) As Any Ptr
  Declare Function d_alloc( ls As list_type Ptr, pnt As Any Ptr ) As Any Ptr
  Declare Function r_alloc( ls As list_type Ptr, pnt As Any Ptr, sz As uInteger ) As Any Ptr
  
  
  
  Declare Function list_NodeAddress( l As list_type Ptr, i As Integer ) As list_type Ptr
  
  Declare Function membank_Length() As Integer
  Declare Function membank_Address() As Any Ptr
  
#EndIf '' cha0sLISTS_BI
