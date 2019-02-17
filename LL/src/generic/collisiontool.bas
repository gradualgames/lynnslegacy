Option Explicit

#Include "fb_Global.bi"
#Include "tControl.bi"
#Include "..\headers\ll.bi"




Type collisionTool_Type

  currentImage As LLSystem_ImageHeader Ptr
  currentFrame As Integer
  currentFace As Integer
  
  
  _frames As Integer
  _faces As Integer
  

End Type

Dim Shared As ll_system LL_Global
Dim Shared collision_Global As collisionTool_Type 

Const As Integer locationX = 68
Const As Integer locationY = 54



Sub drawFrameFaces()
  
  Dim As Integer i 
  For i = 0 To collision_Global.currentImage->frame[collision_Global.currentFrame].faces - 1
    
    Dim As Integer randomColor = Int( Rnd * 256 )
  
    With collision_Global.currentImage->frame[collision_Global.currentFrame].face[i]
    
      Line( .x, .y )-Step( .w - 1, .h - 1 ), randomColor, b
    
    End With
  
  Next
  
  
End Sub



Function load_Callback( inControl As tControl_Type Ptr ) As Integer
  
  With collision_Global
  
    Dim As LLSystem_ImageHeader Ptr img
    fb_ScreenPause()
      
    Do
      
      Dim As String res
      
      Line Input "Picture Name: ", res
      fb_FreezeKey( sc_enter )
      
      img = LLSystem_ImageDeref( LLSystem_ImageDerefName( res, 1 ) )

      If res = "" Then

        fb_ScreenUnPause()

        Return 1
        
      End If
       
      
    Loop Until img
    
    .currentImage = img
    .currentFrame = 0
    
    tControl_Scroll( ._frames, Varptr( .currentFrame ), Varptr( .currentImage->frames ) )

    tControl_Scroll( ._faces, Varptr( .currentFace ), Varptr( .currentImage->frame[.currentFrame].faces ) )
    tControl_Vector( ._faces, Len( LLSystem_FaceType ), Varptr( .currentImage->frame[.currentFrame].face ) )
    
    
    WindowTitle "LL Collision Boxes - (" & kfp( img->filename ) & ")"
  
  
  End With
  
  Return 1


End Function


Function save_Callback( inControl As tControl_Type Ptr ) As Integer

  LLSystem_ImageSaveCollision( *collision_Global.currentImage )
  Return 1


End Function


Function saveBMP_Callback( inControl As tControl_Type Ptr ) As Integer

  dim as integer iFrame 
  dim as any ptr tempBuffer
  
  With collision_Global

    tempBuffer = imagecreate( .currentImage->frames * .currentImage->x, .currentImage->y )
    
    
    for iFrame = 0 to .currentImage->frames - 1
      put tempBuffer, ( iFrame * .currentImage->x, 0 ), varptr( .currentImage->image[.currentImage->arraysize * iFrame] )
      
    next
  
    bsave kfp( kfe( .currentImage->filename ) ) & ".bmp", tempBuffer
    
    imageDestroy( tempBuffer )
    
  end with
  
  Return 1


End Function




Function frame_Callback( inControl As tControl_Type Ptr ) As Integer
  
  With *inControl
    
    drawFrameFaces()
    
    If ( .message And TC_LEFTARROW ) Or ( .message And TC_RIGHTARROW ) Then

      With collision_Global

        tControl_Scroll( ._faces, Varptr( .currentFace ), Varptr( .currentImage->frame[.currentFrame].faces ) )
        tControl_Vector( ._faces, Len( LLSystem_FaceType ), Varptr( .currentImage->frame[.currentFrame].face ) )
        
      End With
      
    End If
  
  End With
  
  Function = 0
  

End Function


Private Sub face_HandleAtrributes()

  Static As Integer stren, invin, impas
  
  With collision_Global.currentImage->frame[collision_Global.currentFrame].face[collision_Global.currentFace]
    
    
    Locate locationY, 2
    
    ? "Attrib: +   -   R   C"
    
    If stren Or invin Or impas Then

      Locate locationY, 25
      ? "M"

      Locate locationY + 2, 16
      ? stren

      Locate locationY + 3, 16
      ? invin

      Locate locationY + 4, 16
      ? impas
    
    End If
    
    If fb_LeftClick Then
    
      If mouse_On8( locationY, 10 ) Then
        stren = .strength
        invin = .invincible
        impas = .impassable
        
      ElseIf mouse_On8( locationY, 14 ) Then
        stren = 0
        invin = 0
        impas = 0
        
      ElseIf mouse_On8( locationY, 18 ) Then
        .strength   = stren
        .invincible = invin
        .impassable = impas
        
      ElseIf mouse_On8( locationY, 22 ) Then
        .strength   = 0
        .invincible = 0
        .impassable = 0
        
      End If
      
    End If
    
    Locate locationY + 2
    ? "Strength:   "; .strength
    ? "Invincible: "; .invincible
    ? "Impassable: "; .impassable
    
    If fb_LeftClick Then
      
      If mouse_OnQuad8( locationY + 2, 1, locationY + 2, 15 ) Then
                        
        fb_ScreenPause()
        
          .strength = simpleQuery_Integer( locationY + 2, 13, SQ_ThresholdLevel( 10 ) Or SQ_threshold )
          
        fb_ScreenUnPause()
        
      End If
      
      If mouse_OnQuad8( locationY + 3, 1, locationY + 3, 15 ) Then
                        
        simpleQuery_BinarySwitch( .invincible )
        
      End If
      
      If mouse_OnQuad8( locationY + 4, 1, locationY + 4, 15 ) Then
                        
        simpleQuery_BinarySwitch( .impassable )
        
      End If
      
    End If
  
  End With


End Sub


Sub face_QuickFrameChange() Static

  With collision_Global

    If fb_Global.keyBuffer = "]" Then
      
      .currentFrame += 1
      If .currentFrame = .currentImage->frames Then
        .currentFrame = 0

        
      End If

      .currentFace = 0
      
    ElseIf fb_Global.keyBuffer = "[" Then

      .currentFrame -= 1
      If .currentFrame = -1 Then
        .currentFrame = .currentImage->frames - 1
        
      End If

      .currentFace = 0

    End If

    tControl_Scroll( ._faces, Varptr( .currentFace ), Varptr( .currentImage->frame[.currentFrame].faces ) )
    tControl_Vector( ._faces, Len( LLSystem_FaceType ), Varptr( .currentImage->frame[.currentFrame].face ) )

    
  End With

End Sub      

Sub face_HandleLocations()

  Static As Integer x, y, w, h
  
  Dim As Integer randomColor = Int( Rnd * 256 )

  With collision_Global.currentImage->frame[collision_Global.currentFrame].face[collision_Global.currentFace]

    Locate locationY - 2, 2
    
    ? "Frame:  +   -   R   C"
    
    If x Or y Or w Or h Then

      Locate locationY - 2, 25
      ? "M"

      Locate 1, locationX + 6
      ? x

      Locate 2, locationX + 6
      ? y

      Locate 3, locationX + 6
      ? w
    
      Locate 4, locationX + 6
      ? h
    
    End If
    
    If fb_LeftClick Then
    
      If mouse_On8( ( locationY - 2 ), 10 ) Then
        
        x = .x
        y = .y
        w = .w
        h = .h
        
      ElseIf mouse_On8( ( locationY - 2 ), 14 ) Then
        x = 0
        y = 0
        w = 0
        h = 0
        
      ElseIf mouse_On8( ( locationY - 2 ), 18 ) Then
        .x = x
        .y = y
        .w = w
        .h = h
        
      ElseIf mouse_On8( ( locationY - 2 ), 22 ) Then
        .x = 0
        .y = 0
        .w = 0
        .h = 0
        
      End If
      
    End If
  
    Line( .x, .y )-Step( .w - 1, .h - 1 ), randomColor, b
    
    Locate 1, locationX
    ? "x: " & .x
    Locate 2, locationX
    ? "y: " & .y
    Locate 3, locationX
    ? "w: " & .w
    Locate 4, locationX
    ? "h: " & .h
    
    If fb_Leftclick Then
                            
      If mouse_OnQuad( 0, 0, collision_Global.currentImage->x, collision_Global.currentImage->y ) Then
        
        If MultiKey( sc_control ) Then

          .w = fb_Global.mouse.x - .x + 1
          .h = fb_Global.mouse.y - .y + 1
        
        Else  
        
          .x = fb_Global.mouse.x
          .y = fb_Global.mouse.y
          
        End If

        If ( .x + .w ) >= collision_Global.currentImage->x Then
          .w -= ( .x + .w ) - collision_Global.currentImage->x
          
        End If

        If ( .y + .h ) >= collision_Global.currentImage->y Then
          .h -= ( .y + .h ) - collision_Global.currentImage->y
          
        End If
        
      End If
      
    End If
    
  End With



End Sub

Function face_Callback( inControl As tControl_Type Ptr ) As Integer


  face_QuickFrameChange()
  
  If *inControl->numPtr = 0 Then Exit Function

  face_HandleAtrributes()
  face_HandleLocations()

  Function = 0
  

End Function


Function img_WaitBack() As Integer

  Return collision_Global.currentImage <> 0 
  
End Function


tControl_Init( 10, locationX, "Load Picture", ProcPtr( load_Callback  ) )
tControl_Init( 24, locationX, "Save Picture", ProcPtr( save_Callback  ), ProcPtr( img_WaitBack ) )

tControl_Init( 26, locationX, "Export to BMP", ProcPtr( saveBMP_Callback  ), ProcPtr( img_WaitBack ) )

collision_Global._frames = tControl_Init( 16, locationX, "Frames", ProcPtr( frame_Callback ), ProcPtr( img_WaitBack ), TC_SELECT )
collision_Global._faces  = tControl_Init( 20, locationX, "Faces" , ProcPtr( face_Callback  ), ProcPtr( img_WaitBack ), TC_SELECT Or TC_RESIZE )


LLSystem_CachePictureFiles( "data\pictures" )


Screen 18, 8, 2

Dim As Integer x, y

Width 80, 60


fb_StartGlobal()

fb_Global.display.pal = load_Pal( "data\palette\ll.pal" )
Palette Using fb_Global.display.pal

WindowTitle "LL Collision Boxes"

Do
  
  
  Do
    fb_GetMouse()   
    fb_GetKey()   

    Sleep 5
    
    If fb_WindowKill() Then End
  
  Loop While fb_MouseOffScreen()

  
  View Screen( 0, 0 )-( 499, 399 )
  
    If collision_Global.currentImage Then
      
      With *collision_Global.currentImage

        Line( 0, 0 )-Step( .x - 1, .y - 1 ), 15, bf 
        Put( 0, 0 ), Varptr( .image[collision_Global.currentFrame * .arraysize] ), Trans
        
      End With
      
    End If
  
  View Screen

  tControl_Update()

  fb_ScreenRefresh()
  
  
Loop Until MultiKey( 1 ) Or fb_WindowKill()

Sub cleanUp() Destructor

  LLSystem_ClearImageCache()
  fb_CloseGlobal()
  
  
End Sub
