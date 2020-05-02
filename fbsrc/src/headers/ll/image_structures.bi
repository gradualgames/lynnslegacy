Type LLSystem_ImageHandle As uInteger

Type LLSystem_FaceType

  As Integer x, y, w, h

  strength   As Integer  
  invincible As Integer  
  impassable As Integer  

End Type


Type LLSystem_FrameShell

  faces As Integer
  face As LLSystem_FaceType Ptr

  sound As Integer
  vol As Integer
  chan As Integer

  uni_sound as byte

End Type


Type LLSystem_ImageHeader


  filename As String

  As Integer x, y, x_off, y_off
  
  arraysize As Integer 

  image As Short Ptr

  frame As LLSystem_FrameShell Ptr  
  frames As Integer
  


End Type




Declare Sub LLSystem_CachePictureFiles( pth As String )

Declare Function LLSystem_ImageDeref    ( index As Integer ) As LLSystem_ImageHeader Ptr

Declare Function LLSystem_ImageDerefName( index As String, isInStr As Integer = 0 ) As LLSystem_ImageHandle

Declare Sub      LLSystem_ClearImageCache  ()

