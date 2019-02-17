Type _LL_MiniMapRoomDoorType

  As vector_Integer location
  
  As Integer id '' Enum LLMINI_DOORTYPES
  
  As Integer codes
  As Integer Ptr code

End Type
Type LL_MiniMapRoomDoorType As _LL_MiniMapRoomDoorType


Type _LL_MiniMapRoomType
  
  As vector_Integer location
  
  As Integer floor
  
  As Integer doors
  door As LL_MiniMapRoomDoorType Ptr
  
  As Byte hasVisited

End Type
Type LL_MiniMapRoomType As  _LL_MiniMapRoomType


Type _LL_MiniMapType

  rooms As Integer
  room As LL_MiniMapRoomType Ptr

  As vector_Integer camera, location
  
End Type
Type LL_MiniMapType As _LL_MiniMapType




Type teleport_type

  x As Integer
  y As Integer
  w As Integer
  h As Integer
  to_room As Integer
  to_map As String
  
  dx As Integer
  dy As Integer
  dd As Integer

  to_song As Integer

  reserved( 19 ) As Integer
  

End Type

Type room_type

  x As Integer 
  y As Integer 
  parallax As Integer
'  para_img As image_header
  para_img As LLSystem_ImageHeader Ptr

  teleports As Integer
  teleport As teleport_type Ptr
  
  enemies As Integer
  enemy As _char_type Ptr

  temp_enemies As Integer
  temp_enemy( MAX_TEMP_ENEMIES - 1 ) As _char_type

  seq_here As Integer  
  seq As sequence_type Ptr

  #IfDef list_type
    manage_mem As list_type Ptr
    
  #EndIf
  
  dark As Integer
  now_dark As Integer

  song As Integer
  
  layout As Integer Ptr Ptr
  
  song_changes As Integer
  changes_to As Integer
  
  
  reserved( 17 ) As Integer

End Type


Type map_entry_type

  x As Integer
  y As Integer
  room As Integer 

  direction As Byte

  seq_here As Integer  
  seq As sequence_type Ptr

  reserved( 20 ) As Integer


End Type


Type map_type

  filename As String

  entries As Integer
  entry As map_entry_type Ptr

  rooms As Integer 
  room As room_type Ptr

  ref As Integer


  #IfDef list_type
    manage_mem As list_type Ptr
    
  #EndIf

  tileset As LLSystem_ImageHeader Ptr
  song As Integer
  
  isDungeon As Byte
  

End Type


