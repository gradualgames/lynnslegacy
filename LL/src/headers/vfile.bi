'#IncLib "vfile"


Type VFile_Vector

  dat As Any Ptr
  sz As Integer
  natural As Integer
  
End Type

Enum VFile_Arrays

  VF_NULL
  VF_BYTE
  VF_SHORT
  VF_INTEGER
  VF_LONGINT
  VF_SINGLE
  VF_DOUBLE


End Enum

Enum VFile_Errors

  VF_OK
  VF_HANDLE_USED
  VF_HANDLE_OUTOFRANGE
  VF_HANDLE_NOTALLOCATED
  VF_HANDLE_REJECTED
  
  VF_FILE_OVERRUN
  VF_FILE_STRINGTOOLARGE

End Enum


#Define declare_VFile_Open(x)                                                       _
                                                                                    _
  Declare Function VFile_Open Overload ( f() As x, ByVal h As Integer ) As Integer 

  declare_VFile_Open( uByte )
  declare_VFile_Open( uShort )
  declare_VFile_Open( uInteger )
  declare_VFile_Open( Single )
  declare_VFile_Open( Double )
  declare_VFile_Open( uLongInt )


#UnDef declare_VFile_Open

Declare Function VFile_Open Overload ( f As String, ByVal h As Integer ) As Integer
Declare Function VFile_Open Overload ( ByVal f As Any Ptr, ByVal l As Integer, ByVal h As Integer ) As Integer



#Define declare_VFile_Get(x)                                                                                   _
                                                                                                               _
  Declare Function VFile_Get Overload ( ByVal h As Integer, ByVal p As Integer = -1, ByRef u As x ) As Integer

  declare_VFile_Get( uByte )
  declare_VFile_Get( uShort )
  declare_VFile_Get( uInteger )
  declare_VFile_Get( Single )
  declare_VFile_Get( Double )
  declare_VFile_Get( uLongInt )

#UnDef declare_VFile_Get

Declare Function VFile_Get Overload ( ByVal h As Integer, ByVal p As Integer = -1, u As String ) As Integer
Declare Function VFile_Get Overload ( ByVal h As Integer, ByVal p As Integer = -1, u As VFile_Vector ) As Integer


#Define declare_VFile_GetArray(x)                                         _
                                                                          _
  Declare Function VFile_GetArray Overload ( u() As x, id As x ) As VFile_Vector

  declare_VFile_GetArray( uByte )
  declare_VFile_GetArray( uShort )
  declare_VFile_GetArray( uInteger )
  declare_VFile_GetArray( Single )
  declare_VFile_GetArray( Double )
  declare_VFile_GetArray( uLongInt )

#UnDef declare_VFile_GetArray


  


#Define declare_VFile_Put(x)                                                                                   _
                                                                                                               _
  Declare Function VFile_Put Overload ( ByVal h As Integer, ByVal p As Integer = -1, ByVal u As x ) As Integer 

  declare_VFile_Put( uByte )
  declare_VFile_Put( uShort )
  declare_VFile_Put( uInteger )
  declare_VFile_Put( Single )
  declare_VFile_Put( Double )
  declare_VFile_Put( uLongInt )
  
  
#UnDef  declare_VFile_Put

Declare Function VFile_Put Overload ( ByVal h As Integer, ByVal p As Integer = -1, u As String )
Declare Function VFile_Put Overload ( ByVal h As Integer, ByVal p As Integer = -1, u As VFile_Vector ) As Integer



Declare Function VFile_Save Overload ( ByVal h As Integer, u As zString Ptr )
Declare Function VFile_Save Overload ( ByVal h As Integer, u() As uByte )

Declare Function VFile_Close( ByRef h As Integer = -1 ) As Integer
Declare Function VFile_FreeFile() As Integer
Declare Function VFile_Seek( ByVal h As Integer, ByVal fp As Integer ) As Integer
Declare Function VFile_LOF( ByVal h As Integer ) As Integer
Declare Function VFile_EOF( ByVal h As Integer ) As Integer
declare Function VFile_LOC( ByVal h As Integer ) As Integer

#Define VF_Array(x)                               _
                                                  _
  Type <VFile_Vector> (                           _ 
                        Varptr( x( 0 ) ), _ 
                        ( UBound( x ) - LBound( x ) + 1 ) * Len( x( 0 ) ),      _
                        -1                        _ 
                      )
                      
                      