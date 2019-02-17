Option Explicit

#Include "..\headers\ll\headers.bi"


                 
Private Function xml_StreamFile( nm As String ) As xml_tool Ptr


  If nm = "" Then Return 0
  
  Dim As xml_tool Ptr ret
  Dim As Integer f = FreeFile
  
  If Dir( nm ) = "" Then Return 0

    If Open( nm, For Binary, As f ) = 0 Then
      
      ret = CAllocate( Len( xml_tool ) )
      
      ret->total_size    = Lof( f )
      ret->original_copy = CAllocate( ret->total_size )
      ret->line_num = 1
      
      fb_fileget( f, 0, ByVal ret->original_copy, ret->total_size )
      
      Close f
      
      ret->fileName = nm
      
      Function = ret
    Else
      Kill nm  
    End If
    
  
End Function
  

Private Sub xml_EatSpace( xml_Parser As xml_tool Ptr )


  Do
  
    Select Case As Const xml_Parser->original_copy[xml_Parser->caret_pos]
      
      Case Asc( " " )
        xml_Parser->caret_pos += 1
  
      Case 13 '' cr
        xml_Parser->caret_pos += 1
  
      Case 10 '' lf
        xml_Parser->caret_pos += 1
        xml_Parser->line_num += 1
        
      Case 0 '' null acceptable in xml??
        xml_Parser->caret_pos += 1
        
      Case Else
        Exit Sub
        
    End Select
  
  Loop


End Sub



Private Function xml_GetKey( xml_Parser As xml_tool Ptr ) As String

  Dim As String tmp
  Dim As Integer catch_error

  Do While ( xml_Parser->original_copy[xml_Parser->caret_pos] <> Asc( ">" ) )  
    Select Case xml_Parser->original_copy[xml_Parser->caret_pos]
    
      Case Asc( "<" ), Asc( "&" )
        catch_error = -1
      
      Case Else
    
        tmp += Chr( xml_Parser->original_copy[xml_Parser->caret_pos] )
        xml_Parser->caret_pos += 1
        
    End Select
    
  Loop

  If catch_error = -1 Then

    ? "Syntax Error: found """ & tmp & """."
    ? "On line " & xml_Parser->line_num
    
  End If

  xml_Parser->caret_pos += 1 '' ">"
        
  Return Trim( tmp )
  
End Function
  


Private Function xml_TagInside( xml_Parser As xml_tool Ptr ) As String

  Dim As String tmp
  Dim As Integer catch_error
  
  Do While ( xml_Parser->original_copy[xml_Parser->caret_pos] <> Asc( ">" ) )  
  
    Select Case xml_Parser->original_copy[xml_Parser->caret_pos]
    
      Case Asc( "<" ), Asc( "&" )
        catch_error = -1
        
      Case Else 
        tmp += Chr( xml_Parser->original_copy[xml_Parser->caret_pos] )
        
        xml_Parser->caret_pos += 1
        
    End Select
    
    
  Loop

  If catch_error = -1 Then

    ? "Syntax Error: found """ & tmp & """."
    ? "On line " & xml_Parser->line_num
    
  End If

  '' eat the closing bracket
  xml_Parser->caret_pos += 1
  
  Return Trim( tmp )
  
End Function
  
  

Private Function xml_UntilNextTag( xml_Parser As xml_tool Ptr ) As String

  Dim As String tmp
  
  Do While ( xml_Parser->original_copy[xml_Parser->caret_pos] <> Asc( "<" ) )  
    tmp += Chr( xml_Parser->original_copy[xml_Parser->caret_pos] )
    
    xml_Parser->caret_pos += 1
    
  Loop

  Return Trim( tmp )
  
End Function
  

Private Function xml_UntilLF( xml_Parser As xml_tool Ptr ) As String

  Dim As String tmp
  
  Do While ( xml_Parser->original_copy[xml_Parser->caret_pos] <> 10 )
    tmp += Chr( xml_Parser->original_copy[xml_Parser->caret_pos] )
    
    xml_Parser->caret_pos += 1
    
  Loop
  xml_Parser->line_num += 1

  Return Trim( tmp )
  
End Function
  

Private Function xml_UntilComment( xml_Parser As xml_tool Ptr ) As String

  Dim As String tmp
  
  '' ? Asc( "/" ) Shl 8 Or Asc ( "*" )
  '' 12074
  '' not endian friendly?
  
  Do While ( *cptr( uShort Ptr, ( xml_Parser->original_copy + xml_Parser->caret_pos ) ) <> 12074 )
    tmp += Chr( xml_Parser->original_copy[xml_Parser->caret_pos] )
    If xml_Parser->original_copy[xml_Parser->caret_pos] = 10 Then xml_Parser->line_num += 1
    
    xml_Parser->caret_pos += 1
    
    If *CPtr( uShort Ptr, ( xml_Parser->original_copy + xml_Parser->caret_pos ) ) = 10799 Then
      '' recursive /* /* */ */
      '' 
      '' better than c
      
      xml_Parser->caret_pos += 1
      tmp += xml_UntilComment( xml_Parser )
      
    End If
    
  Loop

  xml_Parser->caret_pos += 2

  Return Trim( tmp )
  
End Function
  
  


Private Function xml_Parse( ByVal xml_Parser As xml_tool Ptr ) As xml_type Ptr

  Dim As xml_type Ptr this_tag = CAllocate( Len( xml_type ) )
  
  this_tag->key = xml_GetKey( xml_Parser )

  Dim As String xml_comment, xml_closingtag
  

  Do

    xml_EatSpace( xml_Parser )
    
  
    If xml_Parser->original_copy[xml_Parser->caret_pos] = Asc( "<" ) Then
      xml_Parser->caret_pos += 1

      If xml_Parser->original_copy[xml_Parser->caret_pos] = Asc( "/" ) Then
        xml_Parser->caret_pos += 1

        '' tag end!!
        xml_closingtag = xml_TagInside( xml_Parser )
        
        If xml_closingtag <> this_tag->key Then
          ? "Syntax Error: Tag started with """ & this_tag->key & """ and ended with """ & xml_closingtag & """. (" & xml_Parser->line_num & "): " & xml_Parser->fileName
          
        End If
      
        
        '' return the tag info built until now
        Return this_tag
      
      Else
        '' tag within a tag

        this_tag->list = list_append( this_tag->list, xml_Parse( xml_Parser ) )
        
      End If
      
    ElseIf xml_Parser->original_copy[xml_Parser->caret_pos] = Asc( "/" ) Then
      xml_Parser->caret_pos += 1

      If xml_Parser->original_copy[xml_Parser->caret_pos] = Asc( "/" ) Then
        xml_Parser->caret_pos += 1

        xml_comment = xml_UntilLF( xml_Parser )
        

      ElseIf xml_Parser->original_copy[xml_Parser->caret_pos] = Asc( "*" ) Then
        xml_Parser->caret_pos += 1
        
        xml_comment = xml_UntilComment( xml_Parser )

        
      End If


    Else
      
      '' we got this tags value

      this_tag->list = list_append( this_tag->list, xml_UntilNextTag( xml_Parser ) )
      this_tag->eol = -1
      
    End If

  Loop  
  

End Function


Function xml_Load( f As String ) As xml_type Ptr
  
  
  Dim As xml_tool Ptr xml_Info = xml_StreamFile( f )
  
  If xml_Info = 0 Then Return 0
  
  xml_EatSpace( xml_Info )
  xml_Info->caret_pos += 1
  
  Dim As xml_type Ptr ret
  ret = xml_Parse( xml_Info )
  
  xml_Info->fileName = ""
  
  Deallocate xml_Info->original_copy
  xml_Info->original_copy = 0
  
  Deallocate xml_Info
  xml_Info = 0
  
  Return ret
  
  
End Function


Sub xml_Destroy( x As xml_type Ptr )
  
  If x = 0 Then Exit Sub
  
  Dim As Integer crawl
    
  If x->eol <> 0 Then

    x->list->dat.s = ""
    x->key = ""

    Deallocate( x )
    x = 0
    
  Else

    Dim As list_type Ptr thr = x->list
    For crawl = 0 To length( x->list ) - 1
      xml_Destroy( CPtr( xml_type Ptr, thr->dat.pnt ) )
      
      thr = thr->nxt
      
    Next

    list_destroy( x->list )
    x->key = ""
    
    Deallocate( x )
    x = 0
  
  End If
    
    
End Sub    


Private Function xml_PathTraverse( ByVal l As list_type Ptr, ByVal x As xml_type Ptr ) As String


  If x->eol Then
    Return x->list->dat.s
    
  End If


  Dim As String k = l->dat.s

  Dim As list_type Ptr thr = x->list 
  Dim As Integer i
  

  For i = 0 To length( thr ) - 1

    If LCase( k ) = LCase( CPtr( xml_type Ptr, thr->dat.pnt )->key ) Then
    
      Return xml_PathTraverse( l->nxt, CPtr( xml_type Ptr, thr->dat.pnt ) )
      
    End If

    thr = thr->nxt 
    
  Next
  
  Return "xml_TagValue(): Tag """ & k & """ not found."
  
End Function


Function xml_TagValue( ByVal xml_Work As xml_type Ptr, path_to_value As String ) As String

  Dim As list_type Ptr traverse
  Dim As String p = path_to_value
  Dim As Integer last = Instr( p, "->" )
  

  If last = 0 Then Return "<Syntax Error> Gave a bad path to xml_TagValue()"
  
  Do While last <> 0
    traverse = list_append( traverse, Left( p, last - 1 ) )
    p = Right( p, Len( p ) - ( Len( Left( p, last - 1 ) ) + 2 ) )
    last = Instr( p, "->" )
    
  Loop
  
  traverse = list_append( traverse, p )
  traverse = list_append( traverse, "" ) 
  
  If LCase( xml_Work->key ) = LCase( traverse->dat.s ) Then
  
    Function = xml_PathTraverse( traverse->nxt, xml_Work )
    
  Else
    
    Function = "<Syntax Error> Tag """ & traverse->dat.s & """ not found."
  
  End If
  
  
  list_destroy( traverse, list_strlist )

End Function


Private Function xml_PathTraverseEx( ByVal l As list_type Ptr, ByVal x As xml_type Ptr, s As String ) As Integer


  If x->eol Then
    s = x->list->dat.s
    Return -1
    
  End If


  Dim As String k = l->dat.s

  Dim As list_type Ptr thr = x->list 
  Dim As Integer i
  

  For i = 0 To length( thr ) - 1

    If LCase( k ) = LCase( CPtr( xml_type Ptr, thr->dat.pnt )->key ) Then
    
      Return xml_PathTraverseEx( l->nxt, CPtr( xml_type Ptr, thr->dat.pnt ), s )
      
    End If

    thr = thr->nxt 
    
  Next
  
  Return 0
  
End Function


Function xml_TagValueEx( assignmentString As String, ByVal xml_Work As xml_type Ptr, path_to_value As String ) As Integer

  Dim As list_type Ptr traverse
  Dim As String p = path_to_value
  Dim As Integer last = Instr( p, "->" )

  Do While last <> 0
    traverse = list_append( traverse, Left( p, last - 1 ) )
    p = Right( p, Len( p ) - ( Len( Left( p, last - 1 ) ) + 2 ) )
    last = Instr( p, "->" )
    
  Loop
  
  traverse = list_append( traverse, p )
  traverse = list_append( traverse, "" ) 
  
  If LCase( xml_Work->key ) = LCase( traverse->dat.s ) Then
  
    Function = xml_PathTraverseEx( traverse->nxt, xml_Work, assignmentString )
    
  Else
    
    Function = 0
  
  End If
  
  
  list_Destroy( traverse, list_strlist )

End Function


Sub xml_FileWrite( ByVal x As xml_type Ptr, f As Integer, concat As String = "" )

  '' x->key  ::  main tag

  '' x->eol  ::  (-1 = there are no sub tags, 0 = there are sub tags)
    ''
    '' if -1: 
    ''  x->list ::  list that contains one string, the tag value
    '' if 0: 
    ''  x->list ::  list that contains sub tags
    
    If x->eol = -1 Then


      Print #f, concat & "<" & x->key & "> "; _ 
                x->list->dat.s              ; _ 
                " </" & x->key & ">"
                
    Else

        Print #f, ""
        Print #f, concat & "<" & x->key & ">"
        Print #f, ""

        Dim As Integer crawl
        Dim As list_type Ptr thr = x->list

        For crawl = 0 To length( thr ) - 1
          xml_FileWrite( cptr( xml_type Ptr, thr->dat.pnt ), f, concat & "  " )
          
          thr = thr->nxt
          
        Next
          
        Print #f, ""
        Print #f, concat & "</" & x->key & ">"
        Print #f, ""
      
    
    End If
    
    
End Sub    
  
