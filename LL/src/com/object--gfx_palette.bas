Option Explicit
#Include "..\headers\ll.bi"

Function __big_color_up ( this As _char_type Ptr ) As Integer

  llg( dark ) = 1

  Dim As Integer cols
  
  shift_pal()

  
  Return 1
  


End Function



Function __color_down ( this As _char_type Ptr ) As Integer

  If llg( dark ) < 5 Then 
    If now_room().dark <> 0 Then
      llg( dark ) += 1
      
    End If
    
  End If

  Dim As Integer cols
  
  
  shift_pal()
  
  
  Return 1
  


End Function



Function __color_off ( this As _char_type Ptr ) As Integer

  Dim As Integer cols

  For cols = 0 To 255
  
  
    Palette cols, 0
    
  Next
  
  
  Return 1
 
End Function


Function __color_on ( this As _char_type Ptr ) As Integer


  Palette Using fb_Global.display.pal

  
  Return 1
 
End Function



Function __color_up ( this As _char_type Ptr ) As Integer

  If llg( dark ) > 0 Then llg( dark ) -= 1

  shift_pal()
  
  Return 1
  


End Function



Function __fade_to_black ( this As _char_type Ptr ) As Integer

  Dim As Integer cols, r, g, b, blackened, p

  If this->fade_timer = 0 Then
  
    For cols = 0 To 255
      
      Palette Get cols, r, g, b
      
      If r <> 0 Then r -= 4 
      If g <> 0 Then g - =4
      If  b <> 0 Then b -= 4
      
      If r < 0 Then r = 0
      If g < 0 Then g = 0
      If b < 0 Then b = 0
      
      p = Rgb ( b Shr 2, g Shr 2, r Shr 2 )
      
      Palette cols, p
    
    Next
  
    blackened = 1
  
    For cols = 0 To 255
    
      Palette Get cols, r, g, b
      blackened = blackened And ( (r = 0) And (g = 0) And (b = 0) )

    Next
    
    If llg( song )_fade <> 0 Then

      this->song_fade_count += 1

      Dim As Double tmp_val
      tmp_val = ( this->fade_out - this->song_fade_count ) '' 0-63
      tmp_val Shl= 3 '' 0 - 512
      tmp_val /= 5.12 '' close enough...
      LLMusic_SetVolume( CInt( tmp_val ) )
'        bass_setconfig( BASS_CONFIG_GVOL_MUSIC, tmp_val )
      
    End If

    this->fade_timer = Timer + this->fade_time

  End If
  
  If Timer >= this->fade_timer Then this->fade_timer = 0

  If blackened Then

    this->fade_out = 0
    this->song_fade_count = 0
  
    If llg( song )_fade <> 0 Then
      
      LLMusic_Stop()
  
    End If
    
   
    Return 1 
    
  End If


End Function



Function __fade_to_red ( this As _char_type Ptr ) As Integer


  Dim As Integer cols, r, g, b, allwhite, p
  

  If this->fade_timer = 0 Then
  
    allwhite = 1

      For cols = 0 To 255
    
        Palette Get cols, r, g, b
      
        If r <> 255 Then r += 2 
        If g <> 0 Then g - =4
        If  b <> 0 Then b -= 4
      
        If r > 255 Then r = 255
        If g < 0 Then g = 0
        If b < 0 Then b = 0
        
        p = Rgb ( b\4 , g\4 , r\4  )

     
        allwhite = allwhite And ( (g < 128) And (b < 128) )

        Palette cols, p

    
      Next
  

    this->fade_timer = Timer + this->fade_time

  Else
  
    If Timer >= this->fade_timer Then this->fade_timer = 0
    
  End If

  If allwhite Then Return 1
  


End Function



Function __fade_to_white ( this As _char_type Ptr ) As Integer


  Dim As Integer cols, r, g, b, p, allwhite  

  If this->fade_timer = 0 Then
    
    For cols = 0 To 255
    
    
      Palette Get cols, r, g, b
      
      If r <> 255 Then r += 4 
      If g <> 255 Then g + =4
      If  b <> 255 Then b += 4
      
      If r > 255 Then r = 255
      If g > 255 Then g = 255
      If b > 255 Then b = 255
      
        p = Rgb ( b \ 4, g \ 4, r \ 4  )
        
      
      Palette cols, p
    
    Next
  
    allwhite = 1
  
    For cols = 0 To 255
    
      Palette Get cols, r, g, b
  
      allwhite And = ( ( r >= 250 ) And ( g >= 250 ) And ( b >= 250 ) )
      
    
    Next

    this->fade_timer = Timer + this->fade_time

  Else
  
    If Timer >= this->fade_timer Then this->fade_timer = 0
    
  End If

  If allwhite <> 0 Then 

    For cols = 0 To 255
    
      Palette cols, Rgb( 63, 63, 63 )
    
    Next
    
    Return 1
    
  End If
  


End Function



Function __fade_up_to_color ( this As _char_type Ptr ) As Integer
  
  const as integer slices = 64

  If this->fade_timer = 0 Then

    Dim As Integer cols
  
    For cols = 0 To 255
      Palette cols,       Int( ( ( this->fade_count * ( 5 - (llg( dark ) * .63) )) / 5 ) * ( (fb_Global.display.pal[cols] Shr 0  And &hff)) / 64) Or _
                          Int( ( ( this->fade_count * ( 5 - (llg( dark ) * .63) )) / 5 ) * ( (fb_Global.display.pal[cols] Shr 8  And &hff)) / 64) Shl 8 Or _
                          Int( ( ( this->fade_count * ( 5 - (llg( dark ) * .63) )) / 5 ) * ( (fb_Global.display.pal[cols] Shr 16 And &hff)) / 64) Shl 16
    
    Next

    this->fade_count += 1

    If llg( song_fade ) <> 0 Then
      
      #IfDef ll_audio
      
        Dim As Double tmp_val
        
        tmp_val = slices' - this->fade_count
'        tmp_val = ( this->fade_count ) / 64 '' 0-1
        tmp_val *= (100 / slices) '' 0 - 100
        bass_setconfig( BASS_CONFIG_GVOL_MUSIC, tmp_val )
        
      #EndIf
       
       
      
    End If
      
      

    If this->fade_count = slices Then
      
      
      shift_pal()


      this->fade_count= 0
      Return 1
      
    End If  

    this->fade_timer = Timer + this->fade_time

  End If

  If Timer >= this->fade_timer Then this->fade_timer = 0
    


End Function



Function __flash ( this As _char_type Ptr ) As Integer

  Dim As Integer cols
  

  For cols = 0 To 255
  
  
    Palette cols, Rgb( 63, 63, 63 )
    
  Next
  
  static as double blehTimer
  
  if blehTimer = 0 then
    blehTimer = timer + .125
    
  end if
  
  if timer > blehTimer then
    blehTimer = 0
    return 1
    
  end if


  
  Return 0
 
End Function


Function __fade_down_to_color( this As _char_type Ptr ) As Integer


  Dim As Integer cols

  Static As Integer col_Get
  Static As palette_Data col_Store( 255 ), col_Inc( 255 )
  

  If col_Get = 0 Then
    
    For cols = 0 To 255
      
      With col_Inc( cols )

        .b = ( 255 - ( ( ( fb_Global.display.pal[cols] Shr 16 ) And &hFF ) Shl 2 ) ) / 64
        .g = ( 255 - ( ( ( fb_Global.display.pal[cols] Shr 8  ) And &hFF ) Shl 2 ) ) / 64
        .r = ( 255 - ( ( ( fb_Global.display.pal[cols]        ) And &hFF ) Shl 2 ) ) / 64
        
      End With

      With col_Store( cols )

        .r = 255
        .g = 255
        .b = 255

      End With
      
    Next
    
    col_Get = -1
    
  End If 
  
  If this->fade_timer = 0 Then

    For cols = 0 To 255
      
      With col_Store( cols )

        Palette cols, CInt( .r ), CInt( .g ), CInt( .b )

        .r -= col_Inc( cols ).r
        .g -= col_Inc( cols ).g
        .b -= col_Inc( cols ).b

      End With
      
    Next

    this->fade_count += 1
    this->fade_timer = Timer + this->fade_time

  End If

  If Timer >= this->fade_timer Then this->fade_timer = 0

  If this->fade_count = 64 Then
    
    shift_pal()
    
    this->fade_count= 0
    col_Get = 0
    
    Return 1
    
  End If  
  
  
  Return 0

 
End Function




Function __flash_down( this As _char_type Ptr ) As Integer

  
  Dim As Integer cols

  Static As Integer col_Get
  Static As palette_Data col_Store( 255 ), col_Inc( 255 )
  

  If col_Get = 0 Then
    
    For cols = 0 To 255
      
      With col_Inc( cols )

        .b = ( 255 - ( ( ( fb_Global.display.pal[cols] Shr 16 ) And &hFF ) Shl 2 ) ) / 16
        .g = ( 255 - ( ( ( fb_Global.display.pal[cols] Shr 8  ) And &hFF ) Shl 2 ) ) / 16
        .r = ( 255 - ( ( ( fb_Global.display.pal[cols]        ) And &hFF ) Shl 2 ) ) / 16
        
      End With

      With col_Store( cols )

        .r = 255
        .g = 255
        .b = 255

      End With
      
    Next
    
    col_Get = -1
    
  End If 
  
  
  For cols = 0 To 255
    
    With col_Store( cols )

      Palette cols, CInt( .r ), CInt( .g ), CInt( .b )

      .r -= col_Inc( cols ).r
      .g -= col_Inc( cols ).g
      .b -= col_Inc( cols ).b

    End With
    
  Next

  this->fade_count += 1


  If this->fade_count = 16 Then
    
    shift_pal()
    
    this->fade_count= 0
    col_Get = 0
    

    Return 1
    
  End If  
  
  Return 0

 
End Function



Function __flash_down_gray( this As _char_type Ptr ) As Integer


  Dim As Integer cols

  Static As Integer col_Get
  Static As palette_Data col_Store( 255 ), col_Inc( 255 )
  

  If col_Get = 0 Then
    
    For cols = 0 To 255

      Dim As Integer r, g, b, c
      
      b = ( fb_Global.display.pal[cols] Shr 16 ) And &hFF
      g = ( fb_Global.display.pal[cols] Shr 8  ) And &hFF
      r = ( fb_Global.display.pal[cols]        ) And &hFF

      c = r + g + b
      c = c \ 3

      
      
      With col_Inc( cols )

        .b = ( 255 - ( ( c ) Shl 2 ) ) / 16
        .g = ( 255 - ( ( c ) Shl 2 ) ) / 16
        .r = ( 255 - ( ( c ) Shl 2 ) ) / 16
        
      End With

      With col_Store( cols )

        .r = 255
        .g = 255
        .b = 255

      End With
      
    Next
    
    col_Get = -1
    
  End If 
  
  
  For cols = 0 To 255
    
    With col_Store( cols )

      Palette cols, CInt( .r ), CInt( .g ), CInt( .b )

      .r -= col_Inc( cols ).r
      .g -= col_Inc( cols ).g
      .b -= col_Inc( cols ).b

    End With
    
  Next

  If this->fade_count = 16 Then
    
'    shift_pal()
    
    this->fade_count= 0
    col_Get = 0
    
    Return __make_black_and_white( this )
    
  End If  

  this->fade_count += 1
  
  Return 0

 
End Function



Function __big_color_down ( this As _char_type Ptr ) As Integer

  llg( dark ) = 4

  Dim As Integer cols

  shift_pal()
  
  Return 1
  


End Function



Function __make_black_and_white ( this As _char_type Ptr ) As Integer
  
  
  '' iterate through colors
  '' take average ( ( r + g + b ) / 3 )
  '' set color ( rgb( avg, avg, avg ) )

  Dim As Integer i, r, g, b, c
  
  
  For i = 0 To 255
    
    Palette Get i, r, g, b
    
    r Shr= 2
    g Shr= 2
    b Shr= 2
    
    c = r + g + b
    c = c \ 3
    
    Palette i, Rgb( c, c, c )
  
  Next  
  
  
  Return 1
  


End Function



Function __black_text_on ( this As _char_type Ptr ) As Integer
  
  
  Dim As Integer i, r, g, b, c

  b = ( ( ( ( fb_Global.display.pal[247] Shr 16 ) And &hFF ) Shl 2 ) )
  g = ( ( ( ( fb_Global.display.pal[247] Shr 8  ) And &hFF ) Shl 2 ) )
  r = ( ( ( ( fb_Global.display.pal[247]        ) And &hFF ) Shl 2 ) )
        
  Palette 247, Rgb( r, g, b )
  
  Return 1
     


End Function





Function __fade_down_to_gray( this As _char_type Ptr ) As Integer


  Dim As Integer cols

  Static As Integer col_Get
  Static As palette_Data col_Store( 255 ), col_Inc( 255 )
  

  If col_Get = 0 Then
    
    For cols = 0 To 255
      
      Dim As Integer r, g, b, c
      
      b = ( fb_Global.display.pal[cols] Shr 16 ) And &hFF
      g = ( fb_Global.display.pal[cols] Shr 8  ) And &hFF
      r = ( fb_Global.display.pal[cols]        ) And &hFF

      c = r + g + b
      c = c \ 3

      
      With col_Inc( cols )

        .b = ( 255 - ( ( c ) Shl 2 ) ) / 64
        .g = ( 255 - ( ( c ) Shl 2 ) ) / 64
        .r = ( 255 - ( ( c ) Shl 2 ) ) / 64
        
      End With

      With col_Store( cols )

        .r = 255
        .g = 255
        .b = 255

      End With
      
    Next
    
    col_Get = -1
    
  End If 
  
  If this->fade_timer = 0 Then

    For cols = 0 To 255
      
      With col_Store( cols )

        Palette cols, CInt( .r ), CInt( .g ), CInt( .b )

        .r -= col_Inc( cols ).r
        .g -= col_Inc( cols ).g
        .b -= col_Inc( cols ).b

      End With
      
    Next

    this->fade_count += 1
    this->fade_timer = Timer + this->fade_time

  End If

  If Timer >= this->fade_timer Then this->fade_timer = 0

  If this->fade_count = 64 Then
    
    this->fade_count= 0
    col_Get = 0
    
    Return __make_black_and_white( this )
    
  End If  
  
  
  Return 0

 
End Function


Function __red_tint( this As _char_type Ptr ) As Integer


  Dim As Integer cols, r, g, b
  

  For cols = 0 To 255

    r = ( ( fb_Global.display.pal[cols] Shr 16 ) And &hFF )' Shl 2
    g = ( ( fb_Global.display.pal[cols] Shr 8  ) And &hFF )' Shl 2
    b = ( ( fb_Global.display.pal[cols]        ) And &hFF )' Shl 2
    
    g -= 64
'    b -= 64
    r -= 64
    
    g = IIf( g < 0, 0, g )
'    b = IIf( b < 0, 0, b )
    r = IIf( r < 0, 0, r )
    
'    r += 20
'    r = IIf( r > 255, 255, r )
  
    Palette cols, Rgb( r, g, b )

  Next

  Return 1

End Function



