Option Explicit

'#Include "..\headers\utility.bi"
'#Include "..\headers\lists.bi"
'#Include "..\headers\ll\headers.bi"

#Include "..\headers\ll.bi"

Dim Shared As Integer line_count, file_count, comment_count, white_count, partial

Dim As ll_system ll_global


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

Sub count_file_lines( l As list_type Ptr )


  Dim As String this_file = l->dat.s
  Dim As easy_vector file_handle = file_ptr( this_file )
  Dim As Integer i, ver, plock
  
  file_count += 1
  
  
  For i = 0 To file_handle.elements - 1
    
    ver = -1

    Do While file_handle.dat[i] = 0 Or file_handle.dat[i] = Asc( " " ) Or file_handle.dat[i] = 8
      If i = file_handle.elements - 1 Then Exit For 
      i += 1
    
    Loop
    
    If file_handle.dat[i] = 13 Then
      white_count += 1
      ver = 0
      
    ElseIf file_handle.dat[i] = 10 Then
      white_count += 1
      ver = 0
      

    ElseIf file_handle.dat[i] = Asc( "'" ) Then 
      comment_count += 1
      ver = 0

    ElseIf file_handle.dat[i] = Asc( "r" ) Or file_handle.dat[i] = Asc( "R" ) Then
      i += 1
      If i = file_handle.elements - 1 Then Exit For 
      
      If file_handle.dat[i] = Asc( "e" ) Or file_handle.dat[i] = Asc( "E" ) Then
        i += 1
        If i = file_handle.elements - 1 Then Exit For 
        
        If file_handle.dat[i] = Asc( "m" ) Or file_handle.dat[i] = Asc( "M" ) Then
          i += 1
          comment_count += 1
          ver = 0
          If i = file_handle.elements - 1 Then Exit For 
          
        End If
        
      End If

    End If
    
    If i = file_handle.elements - 1 Then Exit For 

    Do While file_handle.dat[i] <> 10
      If plock = 0 Then
        If ver <> 0 Then
          If file_handle.dat[i] = Asc( "'" ) Then
            partial += 1
            plock = -1
            
          ElseIf file_handle.dat[i] = Asc( "r" ) Or file_handle.dat[i] = Asc( "R" ) Then
            i += 1
            If i = file_handle.elements - 1 Then Exit For 
            
            If file_handle.dat[i] = Asc( "e" ) Or file_handle.dat[i] = Asc( "E" ) Then
              i += 1
              If i = file_handle.elements - 1 Then Exit For 
              
              If file_handle.dat[i] = Asc( "m" ) Or file_handle.dat[i] = Asc( "M" ) Then
                i += 1
                partial += 1
                plock = -1
                If i = file_handle.elements - 1 Then Exit For 
                
              End If
              
            End If
      
          End If
          
        End If
        
      End If
         
      i += 1
      If i = file_handle.elements - 1 Then Exit For  
    
    Loop

    If ver <> 0 Then line_count += 1    
    plock = 0
    
    
  Next
  
  Deallocate( file_handle.dat )


End Sub


Sub list_all_bas_files( l As list_type Ptr )

  Dim As String this_path = l->dat.s
  Dim As list_type Ptr recur
  
  recur = list_files( this_path, "*.bas" )
  
  iterate_through_list( recur, @count_file_lines )  
  
  list_Destroy( recur, list_strlist )
  

End Sub

Sub list_all_bi_files( l As list_type Ptr )

  Dim As String this_path = l->dat.s
  Dim As list_type Ptr recur
  
  recur = list_files( this_path, "*.bi" )
  iterate_through_list( recur, @count_file_lines )  
  
  list_Destroy( recur, list_strlist )


End Sub


Dim As list_type Ptr all_dirs

all_dirs = push_dirs()

iterate_through_list( all_dirs, @list_all_bas_files )
iterate_through_list( all_dirs, @list_all_bi_files )

list_Destroy( all_dirs )

? line_count & " line(s) of code in " & file_count & " file(s)."
? white_count & " line(s) of whitespace." 
? comment_count & " line(s) of comments." 

If partial <> 0 Then
  ? "In addition, " & partial & " line(s) had a comment after code."

End If

Sleep
