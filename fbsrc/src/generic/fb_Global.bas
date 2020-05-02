#Include "fb_Global.bi"

Extern fb_Global Alias "FB_GLOBAL" As fb_GlobalData

Dim Shared As fb_GlobalData fb_Global


'' :::
Sub fb_StartGlobal( globalData As fb_GlobalData Ptr )  


  With globalData->display
    ScreenInfo .w, .h, .depth, , , .refreshRate, .driver
    
    .page.working = 0
    .page.active = 1

    ScreenSet .page.working, .page.active
    
    .sizePreCalc = ( .w * .h * ( .depth Shr 3 ) )
    
  End With
  


End Sub


  

Sub fb_ScreenRefresh( globalData As fb_GlobalData Ptr ) 
  
  
  With globalData->display
  
    .page.active Xor= 1           
    .page.working Xor= 1
  
    ScreenSet .page.working, .page.active
    
    .bit8 = ScreenPtr
    
    ScreenLock
      Clear *.bit8, 0, .sizePreCalc
  
    ScreenUnlock
    
  End With


End Sub



Sub fb_CloseGlobal( globalData As fb_GlobalData Ptr )  

  globalData->keyBuffer = ""

  Deallocate( globalData->display.pal )

End Sub



Function simpleQuery_Integer( y As Integer, x As Integer, flags As uInteger )


  Dim As Integer res, release 
  Do
    
    Dim As String handler

    release = -1
    
    Locate y, x
    Line Input "?", handler
    res = Val( handler )
    
    If flags And SQ_POSITIVE Then
      If res < 0 Then release = 0
      
    End If
    
    If flags And SQ_THRESHOLD Then
      If res < 0 Then release = 0
      If res >= ( flags Shr 16 ) Then release = 0
      
    End If

    If release = 0 Then
      Locate y, x + 1    
      ? space( Len( Str( res ) ) ) 
      
    End If
    fb_FreezeKey( sc_enter )
    
    simpleQuery_Integer = res

  Loop While release = 0
  
End Function

Sub simpleQuery_BinarySwitch( value As Integer )

  value = IIf( value = 0, -1, 0 )

  fb_FreezeButton( sc_leftbutton )
  fb_ClearKey()
  
End Sub



