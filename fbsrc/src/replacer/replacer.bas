Option Explicit

#Include "..\headers\ll\headers.bi"
#Include "..\headers\replacer\replacer_declares.bi"

Screen 13

Sub edit_file( l As list_type Ptr )

  Dim As replacer_DataType wordData  
  
  If get_words_to_replace( wordData ) = 0 Then
    End
    
  End If

  Dim As easy_vector file_Work
  file_Work = file_ptr( l->dat.s )
  
  If scan_file( wordData, file_Work ) <> 0 Then

    Kill l->dat.s
  
    Dim As Integer ff = FreeFile
    Open l->dat.s For Binary As ff
      Put #ff, , *Cast( uByte Ptr, file_Work.dat ), file_Work.elements 
      
    Close  
    
  End If
  
  Deallocate file_Work.dat
  
  
End Sub



Dim As list_type Ptr files_to_search
Dim As Double t

  t = Timer

  files_to_search = list_files( "src\com", "*.bas" )
  ? length( files_to_search )
  iterate_through_list( files_to_search, @edit_file )

  list_Destroy( files_to_search, list_strlist )
  
  t = ( Timer - t )
  
  ? "Operation completed in " & t & " seconds."
  Sleep 200
  
