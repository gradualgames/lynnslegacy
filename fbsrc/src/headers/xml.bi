Type xml_tool
  
  As String fileName
  original_copy As uByte Ptr
  As uInteger caret_pos, line_num, total_size
  
End Type

Type xml_type
  
  key As String
  eol As Integer
  list As list_type Ptr
  
End Type


Declare Function xml_StreamFile( nm As String ) As xml_tool Ptr
Declare Function xml_GetKey( p As xml_tool Ptr ) As String
Declare Sub xml_EatSpace( p As xml_tool Ptr )

Declare Function xml_Parse( ByVal p As xml_tool Ptr ) As xml_type Ptr

Declare Function xml_TagInside( p As xml_tool Ptr ) As String

Declare Function xml_UntilLF( p As xml_tool Ptr ) As String
Declare Function xml_UntilNextTag( p As xml_tool Ptr ) As String
Declare Function xml_UntilComment( p As xml_tool Ptr ) As String

Declare Function xml_Load( f As String ) As xml_type Ptr


Declare Sub xml_Destroy( x As xml_type Ptr )
Declare Function xml_TagValue( ByVal xml_Work As xml_type Ptr, path_to_value As String ) As String
Declare Function xml_PathTraverse( ByVal l As list_type Ptr, ByVal x As xml_type Ptr ) As String

Declare Sub xml_FileWrite( byval x As xml_type Ptr, f As Integer, concat As String = "" )

Declare Function xml_TagValueEx( assignmentString As String, ByVal xml_Work As xml_type Ptr, path_to_value As String ) As Integer

