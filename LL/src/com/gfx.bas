Option Explicit

#Include "..\headers\ll.bi"



Sub handle_fps()

  
  #IfDef __gmap__
    
    Const As Double fpsMult = 1, fpsDiv = 1 / fpsMult
    
  #Else
  
    Const As Double fpsMult = 64, fpsDiv = 1 / fpsMult

  #EndIf
    
  
  If Timer > llg( fps_lock ) Then

    llg( fps_hold ) = llg( fps ) * fpsMult
    llg( fps ) = 0
    llg( fps_lock ) = Timer + fpsDiv

    If llg( fps_hold ) > llg( fps_top ) Then
      llg( fps_top ) = llg( fps_hold )
      
    End If
    
  End If
    
  llg( fps ) += 1
  
End Sub


Function load_pal( filename As String, bypass_errors As Integer = 0 ) As Integer Ptr  


  Dim fp As Integer Ptr = CAllocate( 256 * Len ( Integer ) )

  Dim As Integer o = FreeFile, gc
  Dim As uByte rgbs(2)
  
  If bypass_errors = 0 Then
    If Dir( filename ) = "" Then 
'      engine_end( palette_is_missing, ExePath & "\" & filename )
      
    End If
    
  End If
  
  Open filename For Binary As #o


    If bypass_errors = 0 Then
      If Lof( o ) = 0 Then 
'        engine_end( palette_is_empty, filename )
      
      End If
      
    
    End If

    For gc = 0 To 255      
      Get #o,, rgbs()
      fp [gc] = Rgb( rgbs( 0 ) Shr 2, rgbs( 1 ) Shr 2, rgbs( 2 ) Shr 2 ) 

    Next

  Close

  Return fp
  
End Function


