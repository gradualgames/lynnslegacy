#Include "tControl.bi"
#Include "fb_Global.bi"
#Include "..\headers\utility.bi"

        

Dim Shared As tControl_Data controlManager => ( 0, 0, -1 )


Function tControl_Init( y As Integer, x As Integer,                       _ 
                        id As String,                                     _ 
                        callback As tControl_CallbackProc,                _ 
                        waitfor  As tControl_WaitbackProc = 0,            _ 
                        flg As uInteger = 0,                              _ 
                        tVector  As tControl_Data Ptr = @controlManager )
                       
                       
  
  Dim As Integer selectedControl
  selectedControl = tVector->controls
  
  tVector->controls += 1  
  tVector->control = Reallocate( tVector->control, tVector->controls * Len( tControl_Type ) )

  Clear tVector->control[tVector->controls - 1], 0, Len( tControl_Type )

  
  With tVector->control[selectedControl]

    .x = x
    .y = y
    
    .pixel_x = .x Shl 3 '' multiplied by text width
    .pixel_y = .y Shl 3 '' multiplied by text height

    .id = id

    If flg <> 0 Then
      .menuSelect = ( flg And TC_SELECT )
      .menuResize = ( flg And TC_RESIZE )
      
    End If
    
    If callback <> 0 Then
      .callback = callback
      
    End If

    If waitfor <> 0 Then
      .waitfor = waitfor
      
    End If
    
    .d_delay = .2

    .idLength_2 = Len ( .id )

    .idIsEven = IIf( ( .idLength_2 And 1 ) = 0, -1, 0 )

    .idLength_2 = .idLength_2 Shr 1
    
    .button.leftArrow.y = .y + 1
    .button.leftArrow.x = .x + ( .idLength_2 ) - 2
    
    .button.rightArrow.y = .y + 1
    .button.rightArrow.x = .x + ( .idLength_2 ) + 2 + .idIsEven
    
    .button.x.y = .y + 2
    .button.x.x = .x + ( .idLength_2 ) - 2
    
    .button.plus.y = .y + 2
    .button.plus.x = .x + ( .idLength_2 ) + 2 + .idIsEven

  End With
  
  Return selectedControl     

End Function       


Sub tControl_Scroll( selectedControl As Integer    , _ 
                     selPtr          As Integer Ptr, _ 
                     numPtr          As Integer Ptr, _ 
                     tVector As tControl_Data Ptr = @controlManager )

  With tVector->control[selectedControl]

    If .menuSelect Then

      .selPtr = selPtr
      .numPtr = numPtr
      
    End If

  End With

End Sub

Sub tControl_Vector( selectedControl As Integer    , _ 
                     elemSize        As Integer    , _ 
                     container       As Any Ptr Ptr, _ 
                     tVector As tControl_Data Ptr = @controlManager )
  
  With tVector->control[selectedControl]

    If .menuResize Then
      .elemSize = elemSize
      .container = container
      
    End If

  End With

End Sub


Private Sub tControl_Process( activeControl As tControl_Type ) Static


  Dim As Integer clr, mw
  clr = Color

  With activeControl
  
    If .waitfor <> 0 Then
      If .waitfor() = 0 Then Return
    
    End If
  
    If StrPtr( .id ) = 0 Then Exit Sub
    .message = 0
             
    If .menuSelect Or .menuResize Then 

      Locate .y + 1, .x + ( .idLength_2 ) - 1
      ? Trim ( Str ( *.selPtr ) )
  
      Locate .y - 1, .x + ( .idLength_2 ) - IIf( *.numPtr < 10, 0, 1 )
      ? Str ( *.numPtr )                                        

      If *.selPtr <> 0 Then If *.numPtr = 0 Then *.selPtr = 0
      
    End If
    
    Color 7                         

    Locate .y, .x  
    If StrPtr( .id ) Then 
      ? .id 
      
    End If
                                   
    Color clr 
  
    If .numPtr Then
      
      If fb_Global.mouse.x > -1 Then
  
        If fb_Global.mouse.w < mw Then
          .message Or= TC_RIGHTARROW
          
          *.selPtr = IIf( *.selPtr < *.numPtr - 1, *.selPtr + 1, 0 )
      
        ElseIf fb_Global.mouse.w > mw Then
          .message Or= TC_LEFTARROW
          
          *.selPtr = IIf( *.selPtr > 0, *.selPtr - 1, *.numPtr - 1 )
      
        End If
  
        mw = fb_Global.mouse.w
        
      End If
      
    End If
    
    If .menuSelect Then
  
      If *.numPtr < 2 Then '' gray them out.. can't move around on one 
        Color 7
  
      End If
  
      Locate .button.leftArrow.y, .button.leftArrow.x
      ? "<"
      
      Locate .button.rightArrow.y, .button.rightArrow.x
      ? ">"
  
      Color clr
      
  
      If fb_LeftClick Then
        
        If mouse_On8( .button.leftArrow.y, .button.leftArrow.x ) Then
        
          If *.numPtr > 0 Then
          
            If .d_timer = 0 Then
              .message Or= TC_LEFTARROW
              
              *.selPtr = IIf( *.selPtr > 0, *.selPtr - 1, *.numPtr - 1 )
              
              .d_timer = Timer + .d_delay
              
            Else
            
              If Timer >= .d_timer Then .d_timer = 0
      
            End If
            
          End If
          
        ElseIf mouse_On8( .button.rightArrow.y, .button.rightArrow.x ) Then
    
          If .d_timer = 0 Then
            .message Or= TC_RIGHTARROW

            *.selPtr = IIf( *.selPtr < *.numPtr - 1, *.selPtr + 1, 0 )
            
            .d_timer = Timer + .d_delay
            
          Else
          
            If Timer >= .d_timer Then .d_timer = 0
    
          End If
          
        Else
          .d_timer = 0

        End If
        
      End If
  
    End If
  
    If .menuResize Then
  
      If *.numPtr < 1 Then '' gray it out... can't delete 0  
        Color 7
  
      End If
  
      Locate .button.x.y, .button.x.x
      ? "X"
        
      Color clr
  
      Locate .button.plus.y, .button.plus.x
      ? "+"
        
      If fb_LeftClick Then 
      
        If mouse_On8( .button.x.y, .button.x.x ) Then

          If  *.numPtr > 0 Then
        
            hold_button( sc_leftbutton )
      
            ptrArray_Delete( *.container, *.numPtr, *.selPtr, .elemSize )
            If *.selPtr >= *.numPtr Then *.selPtr -= 1
            
            .message Or= TC_DELETE
            
          End If
          
        End If

        If mouse_On8( .button.plus.y, .button.plus.x ) Then
  
          hold_button( sc_leftbutton )
          
          ptrArray_Append( *.container, *.numPtr, .elemSize )
    
          .message Or= TC_ADD
        
        End If
        
      End If
  
      If fb_RightClick Then 
      
        If mouse_On8( .button.plus.y, .button.plus.x ) Then

          fb_Global.mouse.b Xor= sc_rightbutton
          hold_button( sc_rightbutton )
          
          ptrArray_Insert( *.container, *.numPtr, *.selPtr, .elemSize )
    
          .message Or= TC_INSERT
        
        End If
        
      End If
  
    End If
    
  End With
    

End Sub




Private Sub tControl_Display( tVector As tControl_Data Ptr ) Static

  '' show the controls at their locations with their numbers

  Dim As Integer show_c                                                

  For show_c = 0 To tVector->controls - 1

    With tVector->control[show_c]

      If .waitfor <> 0 Then
        If .waitfor() = 0 Then Continue For
      
      End If
 
      Locate .y, .x
  
      ? .id

      If .menuSelect Or .menuResize Then 

        If .numPtr Then

          If Len( Str ( *.numPtr ) ) = 1 Then
            Locate .y - 1, .x + ( .idLength_2 )
            ? Trim ( Str ( *.numPtr ) )
          
          Else
            Locate .y - 1, .x + ( .idLength_2 ) - 1
            ? Trim ( Str ( *.numPtr ) )
            
          End If

        Else
          Locate .y - 1, .x + ( .idLength_2 ) - 1
          ? Trim ( Str ( 0 ) )
          
        End If
        
      End If
      
    End With

  Next


End Sub  



Private Sub tControl_Observe( tVector As tControl_Data Ptr ) Static

  '' if a control was clicked, returns the index
  '' else, returns -1                                                

  tVector->control_selected = -1
                                                
  If fb_Global.mouse.x <> -1 Then
  
    Dim As Integer iterate

    For iterate = 0 To tVector->controls - 1 
      
      With tVector->control[iterate]

        If .waitfor <> 0 Then
          If .waitfor() = 0 Then Continue For
        
        End If

        If fb_Global.mouse.b And sc_leftbutton Then
        
          If mouse_OnQuad8( .y, .x, .y, .x + Len( .id ) - 1 ) Then

            tVector->control_selected = iterate

          End If

        End If
        
      End With
        
    Next
    
  End If
    

End Sub                                                


Private Sub tControl_Dispatch( tVector As tControl_Data Ptr ) Static
  
  Dim As Integer currentState = -1
  
  If tVector->control_selected > -1 Then
    
    currentState = tVector->control_selected 
    
  End If

  If currentState > -1 Then
    tControl_Process( tVector->control[currentState] )
    
  End If
  
  If fb_Global.mouse.x > -1 And fb_Global.mouse.b And sc_rightbutton Then
    currentState = -1
    
  End If
  
  With tVector->control[currentState]
  
    If currentState > -1 Then
  
      If .callback Then
  
        currentState = IIf( .callback( Varptr( tVector->control[currentState] ) ) <> 0, -1, currentState )
            
      End If
    
    End If
    
  End With

End Sub

Sub tControl_Update( tVector As tControl_Data Ptr ) Static


  tControl_Display( tVector )
  tControl_Observe( tVector )
  tControl_Dispatch( tVector )

  
End Sub
