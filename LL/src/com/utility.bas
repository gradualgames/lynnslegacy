Option Explicit

#Include "..\headers\ll.bi"


Function Cva ( f As uByte Ptr, l As Integer, start As Integer = 0 ) As String 

  '' originally by mjs; abridged
   
  Return fb_StrAllocTempDescF( f[start], l ) 
   
   
End Function 


Function load_h_string( ff As Integer ) As String

  Dim As uShort stln
  Get #ff, , stln

  If stln <> 0 Then 
    Redim st ( stln - 1 ) As uByte
    Get #ff, , st()
    Redim Preserve st( stln ) As uByte

    Return cva ( @st( 0 ), UBound( st ) + 1 )
    
  End If
  
  Return "" ' <--- need this?
  
End Function



Sub save_h_string( ff As Integer, s As String )

  Dim As uShort stln
  Dim As Integer wtf
  Dim As uByte plc

  stln = Len( s )

  If stln <> 0 Then 
    Put #ff, , stln 
    For wtf = 0 To Len( s ) - 1
    
      plc = s[wtf]
      Put #ff, , plc
      
    Next

  Else
    Put #ff, , stln 

  End If

  
End Sub


Function KillFilePath ( fname As String ) As String

  '' Modified code from the FreeBASIC compiler itself :) (Original Author: v1ctor)


  Dim p As Integer, lp As Integer = 0

  Do
    p = Instr ( lp + 1, fname, "\" ) '"

    If ( p = 0 ) Then
      Exit Do

    End If

    lp = p

  Loop

    If ( lp = 0 ) Then
      Function  = fname

    Else
      Function = Right ( fname, Len( fname ) - lp )
      
    End If

End Function 



Function KillFileExt ( fname As String ) As String

  '' Modified code from the FreeBASIC compiler itself :) (Original Author: v1ctor)

  Dim p As Integer, lp As Integer = 0

  Do
    p = Instr ( lp + 1, fname, "." )

    If ( p = 0 ) Then
      Exit Do

    End If                                                              

    lp = p

  Loop

    If ( lp = 0 ) Then
      Function  = fname

    Else
      Function = Left ( fname, lp - 1 )
      
    End If

End Function



Sub GfxPrint( ByRef text As String, ByVal x As Integer = 0, ByVal y As Integer = 0, ByVal col As Integer = 15, ByVal buffer As Any Ptr = 0 )

  '' everyone knows angelo wrote a lot of this :)
  '' i try to optimize


  Dim row As Integer, i As Integer
  Dim bits As uByte Ptr
  
'  Dim As Integer h_opt = fb_FontData.h-1, h_opt2
  
'  Select Case fb_FontData.h
'  
'    Case 8
'  
'      h_opt2 = 3
'      
'    Case 16
'    
'      h_opt2 = 4
'      
'  End Select
  
  
  For i = 0 To Len( text ) - 1

    bits = fb_FontData.Data + ( text[i] Shl 4 )
    
    Dim As Integer y_opt = y, x_opt = x + 7
    
    
    For row = 0 To 15 
      
      Line ( x_opt, y_opt )-( x, y_opt ), col, , *bits Shl 8

      y_opt += 1
      bits += 1

    Next row

    x += 8

  Next i

End Sub


Function uplf_box_bound( y As Integer, x As Integer ) As mat_int
  
  Dim As mat_int ret
  ret.x = (x Shl 3) - 8
  ret.y = (y Shl 3) - 8
  
  Return ret
  
End Function
  

Function btrt_box_bound( y As Integer, x As Integer ) As mat_int
  
  Dim As mat_int ret
  ret.x = x Shl 3
  ret.y = y Shl 3
  
  Return ret
  
End Function
  


Function file_ptr( nm As String ) As easy_vector

  Dim As easy_vector ret

  If nm = "" Then Return ret
  
  
  Dim As Integer f = FreeFile
  
  If Dir( nm ) = "" Then Return ret

    If Open( nm, For Binary, As f ) = 0 Then
      
      ret.elements = Lof( f )
      ret.dat = CAllocate( ret.elements )
      
      fb_fileget( f, 0, ByVal ret.dat, ret.elements )
      
      Close f
      
      Function = ret
    Else

    End If
    
  
End Function

Sub LLSystem_MemSwap( swap_1 As Any Ptr, swap_2 As Any Ptr, sz As uInteger )


  Dim swap_3 As uByte Ptr = CAllocate( sz )
  
  MemCpy swap_3, swap_1, sz
  MemCpy swap_1, swap_2, sz
  MemCpy swap_2, swap_3, sz

  Deallocate swap_3


End Sub


Sub fb_SwapMem( swap_1 As Any Ptr, swap_2 As Any Ptr, sz As uInteger )


  Dim swap_3 As uByte Ptr = CAllocate( sz )
  
  MemCpy swap_3, swap_1, sz
  MemCpy swap_1, swap_2, sz
  MemCpy swap_2, swap_3, sz

  Deallocate swap_3


End Sub






Function fb_ImgFromBMP( fileName As String ) As Any Ptr
  
  Dim As Any Ptr res
  Dim As String backupString = fileName
  
  If Dir( backupString ) = "" Then
    Return Cast( Any Ptr, 1 )
    
  End If
  
  
  Dim As Integer fileHandle = FreeFile 

  If Open( backupString, For Binary Access Read, As fileHandle ) = 0 Then

    Dim buff As uShort
    Get #fileHandle, , buff 
    If buff <> 19778 Then 
      Close #fileHandle
      Return Cast( Any Ptr, 2 )
      
    End If 
    
    Dim bmpwidth As uInteger, bmpheight As uInteger 
    Get #fileHandle, &H12 + 1, bmpwidth 
    Get #fileHandle, &H16 + 1, bmpheight
    
    Close #fileHandle
    
    res = ImageCreate( bmpwidth, bmpheight )
    Bload backupString, res
    
    Return res
  
  
  End If
  
End Function




    ''''''''''''''''                        (    in /  out     )
Sub ptrArray_Append( addressing As Any Ptr, ByRef max As Integer, size As uInteger )


  max += 1
  addressing = Reallocate( addressing, max * size )

  MemSet( addressing + ( ( max - 1 ) * size ), 0, size )


End Sub

    ''''''''''''''''                        (    in /  out     )
Sub ptrArray_Insert( addressing As Any Ptr, ByRef max As Integer, selected As Integer, size As uInteger )


  max += 1
  addressing = Reallocate( addressing, max * size )

  MemCpy( addressing + ( ( selected + 1 ) * size ), addressing + ( ( selected ) * size ), size * ( ( max ) - selected ) )
  MemSet( addressing + ( selected * size ), 0, size )


End Sub

    ''''''''''''''''                        (    in /  out     )
Sub ptrArray_Delete( ByRef addressing As Any Ptr, ByRef max As Integer, selected As Integer, size As uInteger )

  
  If selected >= max Then Exit Sub
  
  If selected = max - 1 Then
    max -= 1
    
  Else
    MemCpy( addressing + ( ( selected ) * size ), addressing + ( ( selected + 1 ) * size ), size * ( max - selected - 1 ) )
    max -= 1
    
  End If

  addressing = Reallocate( addressing, ( max ) * size )

End Sub

