#Include "..\headers\ll.bi"
#Include "..\com\utility.bas"

'#CONSOLE OFF 

Dim Shared As LL_SYSTEM LL_Global

Screen 13

Sub work( target As String )

  Dim As Integer x, y
  Dim As String xs, ys
  
  Dim As fb_GfxImg Ptr myImg
  
  myImg = fb_ImgFromBMP( target )
  
  Put( 0, 32 ), myImg
  
  Line Input "WIDTH: " , xs
  Line Input "HEIGHT: ", ys
  
  x = Val( xs )
  y = Val( ys )
  
  If x < 1 Then x = myImg->w
  If y < 1 Then y = myImg->h
  
  If ( myImg->w / x ) = ( myImg->w \ x ) Then
    
    If ( myImg->h / y ) = ( myImg->h \ y ) Then
      
      Dim As Integer tiles_x, tiles_y, x_loop, y_loop, arraySize, frames
      Dim As Any Ptr tileImg
      
      Dim As Integer ff = FreeFile
        
      tiles_x = ( myImg->w / x )
      tiles_y = ( myImg->h / y )
      
      frames = tiles_x * tiles_y
      
      tileImg = ImageCreate( x, y )
      
      arraySize = ( ( x * y ) Shr 1 ) + 2 + 4
      
      Kill kfe( target ) & ".spr"
      Open kfe( target ) & ".spr" For Binary Access Write As ff
        
        Put #ff, , x
        Put #ff, , y
        Put #ff, , arraySize
        Put #ff, , frames
      
        For y_loop = 0 To y * ( tiles_y - 1 ) Step y
  
          For x_loop = 0 To x * ( tiles_x - 1 ) Step x
        
            Get myImg, ( x_loop, y_loop )-( x_loop + x - 1, y_loop + y - 1 ), tileImg
            
            Put #ff, , *Cast( uShort Ptr, tileImg ), arraySize
            
          Next
  
        Next
        
      Close ff
    
      ImageDestroy( tileImg )

    End If
    
  End If
  
  ImageDestroy( myImg )

End Sub


work( Command( 1 ) ) 
