Option Explicit
 

 
#Include "..\headers\ll.bi"
#Include "..\headers\replacer\replacer_declares.bi"

Dim Shared As ll_system ll_global

Function get_words_to_replace( ByRef replacerData As replacer_DataType ) As Integer
  
  Function = -1
  
  If Dir( "src\replacer\words.xml" ) = "" Then
    Return 0
    
  Else
  
    Dim As xml_type Ptr load_data
    load_data = xml_Load( "src\replacer\words.xml" )
    
    
    If xml_TagValueEx( replacerData.fromWord, load_data, "replacer->source" ) = 0 Then
      Return 0
      
    End If
    
    If xml_TagValueEx( replacerData.toWord, load_data, "replacer->target" ) = 0 Then
      Return 0
      
    End If
    

  End If
  
End Function


Function stretch_to_find_word( f As Any Ptr, w As String, n As Integer = 0 ) As Integer
  
  If Len( w ) = 0 Then Return 0
  If n = Len( w ) Then Return -1
  
  If w[n] = CPtr( uByte Ptr, f )[n] Then
    Return stretch_to_find_word( f, w, n + 1 )' = 0 Then Return 0
    
  Else
    Return 0
    
  End If

  
End Function


Function scan_file( wordData As replacer_DataType, file_handle As easy_vector ) As Integer
  
  Dim As Integer i
  
  
  Dim As Any Ptr end_addr
  end_addr = Varptr( file_handle.dat[file_handle.elements - 1] ) 
  Do While end_addr > Varptr( file_handle.dat[i] )
    '' is in address bounds?
  
    If wordData.fromWord[0] = file_handle.dat[i] Then
      '' leftmost char of search string matches current char in file
      
      If stretch_to_find_word( Varptr( file_handle.dat[i] ), wordData.fromWord ) <> 0 Then 
        Function = -1
        


        Dim As Integer old_size, sz, diff
        Dim As uByte Ptr src, dst
        Dim As Integer j

        old_size = file_handle.elements
        
        
        If Len( wordData.fromWord ) < Len( wordData.toWord ) Then
          '' new word is bigger than old one.
          
          diff = Len( wordData.toWord ) - Len( wordData.fromWord )
          
          file_handle.elements += diff
          file_handle.dat = Reallocate( file_handle.dat, file_handle.elements )

          src = ( file_handle.dat + i ) + Len( wordData.fromWord )
          dst = src + diff
          sz = old_size - ( i + Len( wordData.fromWord ) )
          
          MemCpy( dst, src, sz )   

          src = StrPtr( wordData.toWord )
          dst = file_handle.dat + i
          sz = Len( wordData.toWord ) 

          MemCpy( dst, src, sz )

          i += Len( wordData.toWord ) - 1
          
        ElseIf Len( wordData.fromWord ) > Len( wordData.toWord ) Then
          
          diff = Len( wordData.fromWord ) - Len( wordData.toWord )
        
          file_handle.elements -= diff
          file_handle.dat = Reallocate( file_handle.dat, file_handle.elements )
          
          dst = file_handle.dat + i
          src = ( dst + diff )
          sz = old_size - ( i + diff )
          
          MemCpy( dst, src, sz )

          src = StrPtr( wordData.toWord )
          dst = file_handle.dat + i
          sz = Len( wordData.toWord ) 

          MemCpy( dst, src, sz )
          
          i += Len( wordData.toWord ) - 1
          
        Else

          src = StrPtr( wordData.toWord )
          dst = file_handle.dat + i
          sz = Len( wordData.toWord ) 

          MemCpy( dst, src, sz )
          
          i += Len( wordData.toWord ) - 1
                  
        End If
        
      End If 

    End If

    end_addr = Varptr( file_handle.dat[file_handle.elements - 1] )
    i += 1
    
  Loop

End Function


