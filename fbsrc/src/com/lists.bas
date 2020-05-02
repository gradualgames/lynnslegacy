Option Explicit

#Include "..\headers\ll.bi"

Dim Shared As list_type Ptr mem_bank

Function remove_hooked( node As list_type Ptr, v As Any Ptr, id As Integer ) As list_type Ptr
  
  If ( node = 0 ) Or ( v = 0 ) Then Return 0
  
  
  Dim As list_type Ptr thr 
  Dim As Integer c, unit_length, i
  Dim As Any Ptr abstraction
  
  thr = node 
  
  Select Case As Const id
    
    Case ARG_INT, ARG_SNG, ARG_PTR
      unit_length = 2 '' ( 2 ^ 2 = 4 )
    
    Case ARG_DBL, ARG_LNG
      unit_length = 3 '' ( 2 ^ 3 = 8 )
      
      
  End Select

  abstraction = CAllocate( 1 Shl unit_length )

  Do While thr <> 0

    Select Case As Const id    
    
      Case ARG_INT
        
        If thr->dat.i <> *CPtr( Integer Ptr, @v ) Then                                  
        
          CPtr( Integer Ptr, abstraction )[ c ] = thr->dat.i   : c += 1 : abstraction = Reallocate( abstraction, ( ( c + 1 ) Shl unit_length ) )
          CPtr( Integer Ptr, abstraction )[ c ] = 0
                                                                  
        End If
        
      Case ARG_STR
        
        If thr->dat.s <> *CPtr( zString Ptr, @v ) Then
          CPtr( String Ptr, abstraction )[c] = thr->dat.s : c += 1 : abstraction = Reallocate( abstraction, ( ( c + 1 ) * Len( String ) ) )
          CPtr( Integer Ptr, abstraction )[ c ] = 0
                                                                  
        End If
        
      Case ARG_SNG
        
        If thr->dat.sn <> *CPtr( Single Ptr, @v ) Then
          CPtr( Single Ptr, abstraction )[ c ] = thr->dat.sn   : c += 1 : abstraction = Reallocate( abstraction, ( ( c + 1 ) Shl unit_length ) )
          CPtr( Integer Ptr, abstraction )[ c ] = 0
                                                                  
        End If
        
      Case ARG_PTR
        
        If thr->dat.pnt <> *CPtr( Any Ptr Ptr, @v ) Then
          CPtr( Any Ptr Ptr, abstraction )[ c ] = thr->dat.pnt : c += 1 : abstraction = Reallocate( abstraction, ( ( c + 1 ) Shl unit_length ) )
          CPtr( Integer Ptr, abstraction )[ c ] = 0
                                                                  
        End If
        
      Case ARG_DBL
        
        If thr->dat.d <> *CPtr( Double Ptr, @v ) Then
          CPtr( Double Ptr, abstraction )[ c ] = thr->dat.d    : c += 1 : abstraction = Reallocate( abstraction, ( ( c + 1 ) Shl unit_length ) )
          CPtr( Double Ptr, abstraction )[ c ] = 0
                                                                  
        End If
        
      Case ARG_LNG
        
        If thr->dat.l <> *CPtr( LongInt Ptr, @v ) Then
          CPtr( LongInt Ptr, abstraction )[ c ] = thr->dat.l   : c += 1 : abstraction = Reallocate( abstraction, ( ( c + 1 ) Shl unit_length ) )
          CPtr( LongInt Ptr, abstraction )[ c ] = 0
                                                                  
        End If
        
    End Select

    thr = thr->nxt    

  Loop

  Select Case As Const id    
  
    Case ARG_INT
      bin2list( CPtr( Integer Ptr, abstraction ), thr, c )
      
    Case ARG_STR
      bin2list( CPtr( String Ptr, abstraction ), thr, c )
      For i = 0 To c -1
        *CPtr( String Ptr, abstraction ) = ""
        
      Next
                                     
    Case ARG_SNG
      bin2list( CPtr( Single Ptr, abstraction ), thr, c )
      
    Case ARG_PTR
      bin2list( CPtr( Any Ptr Ptr, abstraction ), thr, c )
      
    Case ARG_DBL
'      bin2list( cptr( Double Ptr, abstraction ), thr, c )
      
    Case ARG_LNG
'      bin2list( cptr( LongInt Ptr, abstraction ), thr, c )
      
  End Select
  
  Deallocate abstraction
  
  list_destroy( node )
  Return thr
  
End Function
  

  
  
Sub list_destroy( node As list_type Ptr, dalloc As Integer = 0 )


  If node = 0 Then 
    Exit Sub
    
  End If

  If node->nxt <> 0 Then

    list_destroy( node->nxt, dalloc )
  
  
  End If
  
  If dalloc And list_dealloc Then

    Deallocate node->dat.pnt
    #IfDef ll_memcheck
      mem_bank = list_Remove( mem_bank, node->dat.pnt )
      
    #EndIf
    
    node->dat.pnt = 0
    
  End If

  node->nxt = 0  

  Deallocate node
  node = 0


End Sub


Function length( node As list_type Ptr ) As Integer
  

  If node = 0 Then Return 0

  Dim As list_type Ptr throw = node
  Dim As Integer cnt

    While throw->nxt <> 0
    
      throw = throw->nxt
      cnt += 1
    
    Wend
    
    cnt += 1
  
  Return cnt

  
End Function


Function list_add_hooked( lst1 As list_type Ptr, lst2 As list_type Ptr, list_id As Any Ptr, id As Integer ) As list_type Ptr
  
'  If ( lst1 = 0 ) Or ( lst2 = 0 ) Or ( list_id = 0 ) Then Return 0
  If ( list_id = 0 ) Then Return 0

  Dim As list_type Ptr cat_list, thr
  Dim As Integer i
  
  thr = lst1  
  For i = 0 To length( lst1 ) - 1

    Select Case As Const id    
    
      Case ARG_INT
        cat_list = list_append( cat_list, thr->dat.i )
        
      Case ARG_STR
        cat_list = list_append( cat_list, thr->dat.s )
        
      Case ARG_SNG
        cat_list = list_append( cat_list, thr->dat.sn )
        
      Case ARG_PTR
        cat_list = list_append( cat_list, thr->dat.pnt )
        
      Case ARG_DBL
        cat_list = list_append( cat_list, thr->dat.d )
        
      Case ARG_LNG
        cat_list = list_append( cat_list, thr->dat.l )
        
    End Select
    
    thr = thr->nxt

  Next

  thr = lst2
  For i = 0 To length( lst2 ) - 1

    Select Case As Const id    
    
      Case ARG_INT
        cat_list = list_append( cat_list, thr->dat.i )
        
      Case ARG_STR
        cat_list = list_append( cat_list, thr->dat.s )
        
      Case ARG_SNG
        cat_list = list_append( cat_list, thr->dat.sn )
        
      Case ARG_PTR
        cat_list = list_append( cat_list, thr->dat.pnt )
        
      Case ARG_DBL
        cat_list = list_append( cat_list, thr->dat.d )
        
      Case ARG_LNG
        cat_list = list_append( cat_list, thr->dat.l )
        
    End Select
    
    thr = thr->nxt

  Next
  
  Return cat_list

End Function    


Sub list2bin( node As list_type Ptr, bina() As Integer, pol As Integer = 0 ) 


  If node = 0 Then 
    Exit Sub
    
  End If
  
  
  Dim As Integer shift_opt = ( Abs( pol <> 0 ) * ( length( node ) - 1 ) ) 
  Dim As list_type Ptr throw = node
  Dim As Integer cnt = LBound( bina )
  Dim As Integer Ptr s, b
  
    If shift_opt > cnt Then
      b = @shift_opt
      s = @cnt
    Else
    
      b = @cnt
      s = @shift_opt
  
    End If


    While throw->nxt <> 0
    

      bina( *b - *s ) = throw->dat.i
          
      cnt += 1
    
      throw = throw->nxt

    Wend
    
    bina( *b - *s ) = throw->dat.i
        

    cnt += 1
  

End Sub

Sub list2bin( node As list_type Ptr, bina As Integer Ptr, pol As Integer = 0 ) 


  If node = 0 Then 
    Exit Sub
    
  End If
  

  Dim As Integer shift_opt = ( Abs( pol <> 0 ) * ( length( node ) - 1 ) ) 
  
  Dim As list_type Ptr throw = node
  Dim As Integer cnt

  Dim As Integer Ptr s, b
  
    If shift_opt > cnt Then
      b = @shift_opt
      s = @cnt
    Else
    
      b = @cnt
      s = @shift_opt
  
    End If

    While throw->nxt <> 0
    

      bina[*b - *s] = throw->dat.i
          
      cnt += 1
    
      throw = throw->nxt

    Wend
    
    bina[*b - *s] = throw->dat.i
        

    cnt += 1
  

End Sub

Sub list2bin( node As list_type Ptr, bina() As Single, pol As Integer = 0 ) 


  If node = 0 Then 
    Exit Sub
    
  End If

  Dim As Integer shift_opt = ( Abs( pol <> 0 ) * ( length( node ) - 1 ) ) 


  
  Dim As list_type Ptr throw = node
  Dim As Integer cnt = LBound( bina )
  Dim As Integer Ptr s, b
  
    If shift_opt > cnt Then
      b = @shift_opt
      s = @cnt
    Else
    
      b = @cnt
      s = @shift_opt
  
    End If


    While throw->nxt <> 0
    

      bina( *b - *s ) = throw->dat.sn
          
      cnt += 1
    
      throw = throw->nxt

    Wend
    
    bina( *b - *s ) = throw->dat.sn
        

    cnt += 1
  

End Sub

Sub list2bin( node As list_type Ptr, bina As Single Ptr, pol As Integer = 0 ) 


  If node = 0 Then 
    Exit Sub
    
  End If

  Dim As Integer shift_opt = ( Abs( pol <> 0 ) * ( length( node ) - 1 ) ) 


  
  Dim As list_type Ptr throw = node
  Dim As Integer cnt
  Dim As Integer Ptr s, b
  
    If shift_opt > cnt Then
      b = @shift_opt
      s = @cnt
    Else
    
      b = @cnt
      s = @shift_opt
  
    End If


    While throw->nxt <> 0
    

      bina[*b - *s] = throw->dat.sn
          
      cnt += 1
    
      throw = throw->nxt

    Wend
    
    bina[*b - *s] = throw->dat.sn
        

    cnt += 1
  

End Sub

Sub list2bin( node As list_type Ptr, bina() As String, pol As Integer = 0 ) 


  If node = 0 Then 
    Exit Sub
    
  End If


  Dim As Integer shift_opt = ( Abs( pol <> 0 ) * ( length( node ) - 1 ) ) 

  
  Dim As list_type Ptr throw = node
  Dim As Integer cnt = LBound( bina )
  Dim As Integer Ptr s, b
  
    If shift_opt > cnt Then
      b = @shift_opt
      s = @cnt
    Else
    
      b = @cnt
      s = @shift_opt
  
    End If


    While throw->nxt <> 0
    

      bina( *b - *s ) = throw->dat.s
          
      cnt += 1
    
      throw = throw->nxt

    Wend
    
      bina( *b - *s ) = throw->dat.s
        

    cnt += 1
  

End Sub


Sub list2bin( node As list_type Ptr, bina As String Ptr, pol As Integer = 0 ) 


  If node = 0 Then 
    Exit Sub
    
  End If


  Dim As Integer shift_opt = ( Abs( pol <> 0 ) * ( length( node ) - 1 ) ) 

  
  Dim As list_type Ptr throw = node
  Dim As Integer cnt
  Dim As Integer Ptr s, b
  
    If shift_opt > cnt Then
      b = @shift_opt
      s = @cnt
    Else
    
      b = @cnt
      s = @shift_opt
  
    End If


    While throw->nxt <> 0
    

      bina[*b - *s] = throw->dat.s
          
      cnt += 1
    
      throw = throw->nxt

    Wend
    
      bina[*b - *s] = throw->dat.s
        

    cnt += 1
  

End Sub


Sub list2bin( node As list_type Ptr, bina() As Any Ptr, pol As Integer = 0 ) 


  If node = 0 Then 
    Exit Sub
    
  End If


  Dim As Integer shift_opt = ( Abs( pol <> 0 ) * ( length( node ) - 1 ) ) 

  
  Dim As list_type Ptr throw = node
  Dim As Integer cnt = LBound( bina )
  Dim As Integer Ptr s, b
  
    If shift_opt > cnt Then
      b = @shift_opt
      s = @cnt
    Else
    
      b = @cnt
      s = @shift_opt
  
    End If


    While throw->nxt <> 0
    

      bina( *b - *s ) = throw->dat.pnt
          
      cnt += 1
    
      throw = throw->nxt

    Wend
    
      bina( *b - *s ) = throw->dat.pnt
        

    cnt += 1
  

End Sub


Sub list2bin( node As list_type Ptr, bina As Any Ptr Ptr, pol As Integer = 0 ) 


  If node = 0 Then 
    Exit Sub
    
  End If
  

  Dim As Integer shift_opt = ( Abs( pol <> 0 ) * ( length( node ) - 1 ) ) 
  

'  0 -1,-2
  
  Dim As list_type Ptr throw = node
  Dim As Integer cnt
  Dim As Integer Ptr s, b
  
    If shift_opt > cnt Then
      b = @shift_opt
      s = @cnt
    Else
    
      b = @cnt
      s = @shift_opt
  
    End If

    While throw->nxt <> 0
    

      bina[*b - *s] = throw->dat.pnt
          
      cnt += 1
    
      throw = throw->nxt

    Wend
    
      bina[*b - *s] = throw->dat.pnt
        

    cnt += 1
  

End Sub




Function list_Pop_hooked Alias "ListPop" ( node As list_type Ptr, ret As Any Ptr, id As Integer ) As list_type Ptr


  Dim As list_type Ptr kill_node = node
  
  Select Case id 

    Case ARG_INT
      *CPtr( Integer Ptr, @ret ) = kill_node->dat.i
    Case ARG_UINT
      *CPtr( uInteger Ptr, @ret ) = kill_node->dat.ui
    Case ARG_STR
      *CPtr( String Ptr, @ret ) = kill_node->dat.s
    Case ARG_SNG
      *CPtr( Single Ptr, @ret ) = kill_node->dat.sn
    Case ARG_DBL
      *CPtr( Double Ptr, @ret ) = kill_node->dat.d
    Case ARG_LNG
      *CPtr( LongInt Ptr, @ret ) = kill_node->dat.l
    Case ARG_ULNG
      *CPtr( uLongInt Ptr, @ret ) = kill_node->dat.ul
    Case ARG_PTR
      *CPtr( Any Ptr Ptr, @ret ) = kill_node->dat.pnt
      
  End Select

  node = kill_node->nxt
  Deallocate kill_node
  
  Return 0

       
End Function

Sub bin2list( bina() As Integer, node As list_type Ptr ) 


  If UBound( bina ) = 0 Then 
    Exit Sub
    
  End If

  list_destroy( node )


  Dim As Integer lp
    
    For lp = LBound( bina ) To UBound( bina )
    
      node = list_push( node, bina( lp ) )
      
    Next


End Sub

Sub bin2list( bina As Integer Ptr, node As list_type Ptr, sz As Integer ) 


  If ( bina ) = 0 Then 
    Exit Sub
    
  End If

  list_destroy( node )


  Dim As Integer lp
    
    For lp = 0 To sz - 1
    
      node = list_push( node, bina[lp] )
      
    Next


End Sub




Sub bin2list( bina() As Single, node As list_type Ptr ) 


  If UBound( bina ) = 0 Then 
    Exit Sub
    
  End If

  list_destroy( node )


  Dim As Integer lp
    
    For lp = LBound( bina ) To UBound( bina )
    
      node = list_push( node, bina( lp ) )
      
    Next


End Sub



Sub bin2list( bina As Single Ptr, node As list_type Ptr, sz ) 


  If ( bina ) = 0 Then 
    Exit Sub
    
  End If

  list_destroy( node )


  Dim As Integer lp
    
    For lp = 0 To sz - 1
    
      node = list_push( node, bina[lp] )
      
    Next


End Sub





Sub bin2list( bina() As String, node As list_type Ptr ) 


  If UBound( bina ) = 0 Then 
    Exit Sub
    
  End If

  list_destroy( node, list_strlist )


  Dim As Integer lp
    
    For lp = LBound( bina ) To UBound( bina )
    
      node = list_push( node, bina( lp ) )
      
    Next


End Sub


Sub bin2list( bina As String Ptr, node As list_type Ptr, sz ) 


  If ( bina ) = 0 Then 
    Exit Sub
    
  End If

  list_destroy( node, list_strlist )


  Dim As Integer lp
    
    For lp = 0 To sz - 1
    
      node = list_push( node, bina[lp] )
      
    Next
    


End Sub


Sub bin2list( bina() As Any Ptr, node As list_type Ptr ) 


  If UBound( bina ) = 0 Then 
    Exit Sub
    
  End If

  list_destroy( node )


  Dim As Integer lp
    
    For lp = LBound( bina ) To UBound( bina )
    
      node = list_push( node, bina( lp ) )
      
    Next


End Sub


Sub bin2list( bina As Any Ptr Ptr, node As list_type Ptr, sz ) 


  If ( bina ) = 0 Then 
    Exit Sub
    
  End If

  list_destroy( node )


  Dim As Integer lp
    
    For lp = 0 To sz - 1
    
      node = list_push( node, bina[lp] )
      
    Next


End Sub


Function list_search_hooked( node As list_type Ptr, v As Any Ptr, strt As Integer = 0, id As Integer ) As Integer


  If ( node = 0 ) Or ( v = 0 ) Then Return -1
  If strt >= length( node ) Then Return -1

  Function = -1

  Dim As list_type Ptr thr 
  Dim As Integer c, cond
  
  thr = node 
  For c = 0 To strt - 1
    thr = thr->nxt
  
  Next
  
  c = 0

  
  Do While thr <> 0

    Select Case As Const id    
    
      Case ARG_INT
        cond = ( thr->dat.i = *CPtr( Integer Ptr, v ) )
        
      Case ARG_STR
        If strt = -1 Then
          cond = ( thr->dat.s = *CPtr( zString Ptr, v ) )
          
        Else
          cond = ( Instr( thr->dat.s, *CPtr( zString Ptr, v ) ) <> 0 )
        
        End If
        
      Case ARG_SNG
        cond = ( thr->dat.sn = *CPtr( Single Ptr, v ) )
        
      Case ARG_PTR
        cond = ( thr->dat.pnt = v )
        
      Case ARG_DBL
        cond = ( thr->dat.d = *CPtr( Double Ptr, v ) )
        
      Case ARG_LNG
        cond = ( thr->dat.l = *CPtr( LongInt Ptr, v ) )
        
    End Select

    If cond Then
      
      Return c
      
      c+= 1

      
    End If

    thr = thr->nxt    
    
  Loop
  
End Function
  
  
Function list_node_value( l As list_type Ptr, n As Integer, id As Integer = 0 ) As Integer

  If l = 0 Then Exit Function
  
  Dim As list_type Ptr thr = list_NodeAddress( l, n )
  
  Return thr->dat.i

End Function  

    
Function list_node_value( l As list_type Ptr, n As Integer, id As String ) As String

  If l = 0 Then Exit Function
  
  Dim As list_type Ptr thr = list_NodeAddress( l, n )
  
  Return thr->dat.s

End Function  

    
Function list_node_value( l As list_type Ptr, n As Integer, id As Single ) As Single

  If l = 0 Then Exit Function
  
  Dim As list_type Ptr thr = list_NodeAddress( l, n )
  
  Return thr->dat.sn

End Function  

    
Function list_node_value( l As list_type Ptr, n As Integer, id As Any Ptr ) As Any Ptr

  If l = 0 Then Exit Function
  
  Dim As list_type Ptr thr = list_NodeAddress( l, n )
  
  Return thr->dat.pnt

End Function  


Function list_files ( pth As String = ".", spec As String = "*.*", mask As Integer = &h21 ) As list_type Ptr
  
  Dim As list_type Ptr l
  Dim filename As String
  filename = Dir( pth + "\" + spec, mask )
  
  Do
  
    If filename <> "" Then
      l = list_append( l, pth + "\" + filename )
      filename = Dir( "" )

    Else
      Exit Do
  
    End If  
      
  Loop

  Return l

End Function


Function list_Push_hooked Alias "ListPush" ( node As list_type Ptr, value As Any Ptr, id As Integer ) As list_type Ptr

  Dim As list_type Ptr new_node = CAllocate( Len( list_type ) )

    Select Case As Const id

      Case ARG_INT
        new_node->dat.i = *CPtr( Integer Ptr, @value )

      Case ARG_DBL
        new_node->dat.d = *CPtr( Double Ptr, @value )

      Case ARG_STR
        new_node->dat.s = *CPtr( String Ptr, @value )

      Case ARG_LNG
        new_node->dat.l = *CPtr( LongInt Ptr, @value )
        
      Case ARG_SNG
        new_node->dat.sn = *CPtr( Single Ptr, @value )

      Case ARG_PTR
        new_node->dat.pnt = *CPtr( Any Ptr Ptr, @value )

    End Select
  
    new_node->nxt = node
  
  Return new_node 
  
End Function



Function list_Cancel_hooked Alias "ListCancel" ( m As list_type Ptr, n As list_type Ptr, value As Any Ptr, id As Integer ) As list_type Ptr

  Dim As list_type Ptr thr = m, thrr = n, res'= CAllocate( Len( list_type ) )
  Dim As Integer m_vec, n_vec, conf
    Select Case As Const id

      Case ARG_INT
      Case ARG_DBL
      
      Case ARG_STR

        For m_vec = 0 To length( thr ) - 1
          conf And= 0
          For n_vec = 0 To length( thrr ) - 1
            
            If list_node_value( thr, m_vec, " " ) = list_node_value( thrr, n_vec, " " ) Then
              conf = -1

            End If

          Next
          If conf = 0 Then
            
            res = list_push( res, list_node_value( thr, m_vec, " " ) )
            
          End If
          
        Next
              
              
              
      
      Case ARG_LNG
      Case ARG_SNG
      Case ARG_PTR

    End Select
  
  Return res
  
End Function


Function list_Append_hooked Alias "ListAppend" ( node As list_type Ptr, value As Any Ptr, id As Integer ) As list_type Ptr
  
  If node = 0 Then
    Select Case As Const id
  
      Case ARG_INT
        node = list_Push( node, *CPtr( Integer Ptr, value ) )
  
      Case ARG_DBL
        node = list_Push( node, *CPtr( Double Ptr, value ) )
  
      Case ARG_STR
        node = list_Push( node, *CPtr( zString Ptr, value ) )
  
      Case ARG_LNG
        node = list_Push( node, *CPtr( LongInt Ptr, value ) )
        
      Case ARG_SNG
        node = list_Push( node, *CPtr( Single Ptr, value ) )
  
      Case ARG_PTR
        node = list_Push( node, value )
  
    End Select
    
    Return node
    
  End If

  Dim As Integer it
  Dim As list_type Ptr thr = node
  
  For it = 0 To length( thr ) - 2 
    thr = thr->nxt
    
  Next

  thr->nxt = CAllocate( Len( list_type ) )

  Select Case As Const id

    Case ARG_INT
      thr->nxt->dat.i = *CPtr( Integer Ptr, value )

    Case ARG_DBL
      thr->nxt->dat.d = *CPtr( Double Ptr, value )

    Case ARG_STR
      thr->nxt->dat.s = *CPtr( zString Ptr, value )

    Case ARG_LNG
      thr->nxt->dat.l = *CPtr( LongInt Ptr, value )
      
    Case ARG_SNG
      thr->nxt->dat.sn = *CPtr( Single Ptr, value )

    Case ARG_PTR
      thr->nxt->dat.pnt = value


  End Select
     
  Return node
  
End Function


Function c_alloc( ls As list_type Ptr, sz As uInteger ) As Any Ptr
  
  Dim As Any Ptr tmp 

    tmp = CAllocate( sz )
    
    ls = list_append( ls, tmp )
    
    #IfDef ll_memcheck
      mem_bank = list_append( mem_bank, tmp )
    
    #EndIf

    Return tmp

End Function

Function d_alloc( ls As list_type Ptr, pnt As Any Ptr ) As Any Ptr

  ls = list_Remove( ls, pnt )
  #IfDef ll_memcheck
    mem_bank = list_Remove( mem_bank, pnt )
    
  #EndIf
  Deallocate pnt
  Return ls
  
End Function



Function membank_Address() As Any Ptr

  Return mem_bank
  
End Function





Function r_alloc( ls As list_type Ptr, pnt As Any Ptr, sz As uInteger ) As Any Ptr


  Dim As Integer                _ 
    i = list_search( ls, pnt ), _ '' get the location of ptr on mem list
    j
  
  #IfDef ll_memcheck
    j = list_search( mem_bank, pnt ) '' get the location of ptr on global list
    
  #EndIf
  
  pnt = Reallocate( pnt, sz )
  
  If i = -1 Then
    ls = list_append( ls, pnt )
    
  Else
    list_NodeAddress( ls, i )->dat.pnt = pnt
    
  End If

  #IfDef ll_memcheck
    If j = -1 Then
      mem_bank = list_append( mem_bank, pnt )
      
    Else
      list_NodeAddress( mem_bank, j )->dat.pnt = pnt
      
    End If
    
  #EndIf
  
  Return pnt
    

End Function


Sub iterate_through_list( l As list_type Ptr, fp As Sub( l As list_type Ptr ) )
  
  If ( fp = 0 ) Or ( l = 0 ) Then Exit Sub
    
  Dim As Integer i
  
  Dim As list_type Ptr thr 
  thr = l
  
  For i = 0 To length( thr ) - 1
    
    fp( thr )
    thr = thr->nxt
    
  Next
  
End Sub



Function push_paths( p As zString Ptr )  As list_type Ptr
  
  Dim As list_type Ptr l

  Dim As String tm
  
  Dim As Integer retval

  tm = Dir( *p & "*", 16, @retval ) 
  Do
    If tm = "" Then Exit Do

    If tm <> "." Then

      If tm <> ".." Then

        If retval = 16 Then
          '' what the fsck is this?
          
          l = list_push( l, tm )
          
        End If

      End If

    End If
    
    tm = Dir( "", 16, @retval ) 
    

  Loop
  
  Return l


End Function



Private Function push_sub_dirs( l As list_type Ptr, p As zString Ptr = 0 ) As list_type Ptr

  Dim As list_type Ptr thr
  Dim As Integer d = length( l ), c, iter, stat, retval
  Dim As String tm

  deflect: 
  stat = length( l )

  Do

    Do 
  
      c = length( l )
  
      thr = l
    
      For iter = 0 To d - 1
        tm = Dir( thr->dat.s & "\*", 16, @retval ) 
    
      
        Do
          
          If tm = "" Then Exit Do
      
          If tm <> "." Then
    
            If tm <> ".." Then
              
              If retval = 16 Then
                '' silly...
                
                l = list_push( l, thr->dat.s & "\" & tm )
                
              End If
      
            End If
          End If
          
          tm = Dir( "", 16, @retval ) 
        
        Loop
        
        thr = thr->nxt
        
      Next
      
      d = length( l ) - c
      
    Loop While c <> length( l )
    
    
    If length( l ) <> stat Then
      Goto deflect
    
    Else
      Return l
      
    End If 
    
  Loop 
  


    
  
End Function  


Function push_dirs( p As zString Ptr = 0 ) As list_type Ptr
  

  Dim As list_type Ptr l, thr
  Dim As Integer iter
  
  If p = 0 Then p = @".\"

  l = push_paths( p )
  thr = l
  
  For iter = 0 To length( l ) - 1

    thr->dat.s = *p & thr->dat.s
    
    thr = thr->nxt
    
  Next

  l = push_sub_dirs( l, p )      
  l = list_push( l, Left( *p, Len( *p ) - 1 ) )
  
  Return l
  
  
End Function



Function list_NodeAddress( l As list_type Ptr, i As Integer ) As list_type Ptr

  If l = 0 Then Return 0

  Dim As Integer it
  Dim As list_type Ptr thr = l
  
  For it = 0 To i - 1
    thr = thr->nxt
    
  Next
  
  Return thr
  
End Function


Private Function list_StrCompare CDECL ( ByVal lh As Any Ptr, ByVal rh As Any Ptr ) As Integer

  Static As String Ptr lhs, rhs
  
  lhs = lh
  rhs = rh
  
  
  Select Case LCase( *lhs )
  
    Case Is > LCase( *rhs )
      Return -1
      
    Case Is < LCase( *rhs )
      Return 1
      
    Case Else
      Return 0
      
  End Select


End Function 

Function list_Sort( sortList As list_type Ptr ) As list_type Ptr

  Dim As list_type Ptr sortedList
  Dim As Integer listLength

  listLength = length( sortList )

  Dim As String holder( listLength - 1 )

  list2bin( sortList, holder() )
  
  
  qsort( Varptr( holder( 0 ) ), listLength, Len( String ), ProcPtr( list_StrCompare ) )
  
  bin2list( holder(), sortedList )
  
  list_destroy( sortList, list_strlist )
  
  
  Return sortedList
  

End Function


Function open_file_dialog( items As list_type Ptr, x As Integer = 1, y As Integer = 1 ) As Integer
  
  
  Dim As Integer mx, my, mb, mw
  Dim As Integer alternate
  
  
  Dim As Integer txt_ = 242
  Dim As Integer bg_ = 63
  Dim As Integer txthi_ = 244
  Dim As Integer bghi_ = 62
  Dim As Integer border_ = 243
  Dim As Integer top_ = 147
  
  Dim As Integer longest_string, i


  If items = 0 Then Return -1
  
  
  
  Dim As list_type Ptr thr = items
  For i = 0 To length( items ) - 1
    
    If Len( thr->dat.s ) > longest_string Then longest_string = Len( thr->dat.s )
    thr = thr->nxt
    
  Next
  
  items = list_Sort( items )

  Do  


    Color 15, top_
    Locate y, x
    
    ? space( longest_string + 6 )
  
    Locate y + 1, x
    ? space( longest_string + 6 )
  
    Locate y + 1, 1 + ( longest_string + 6 - Len( "click to load." ) ) \ 2 + x
    ? "click to load." 
  
    Locate y + 2, x
    ? space( longest_string + 6 )

    Color 15, bg_
    Locate y + 3, x
    ? space( longest_string + 6 )

        Color 15, border_
    Locate 3 + y,  x
    ? " "
    Locate 3 + y, ( longest_string + 6 ) + x - 1
    ? " "
  
    Color 15, 0

    
    thr = items
    For i = 0 To length( items ) - 1

      alternate = 0

      GetMouse( mx, my, mw, mb )
    
      Dim As mat_int char_loc
      char_loc.x = x + 1 + ( longest_string + 6 - Len( thr->dat.s ) ) \ 2
      char_loc.y = y + 3 + i
      
      char_loc.x Shl= 3
      char_loc.y Shl= 3

        Color 15, bg_
        Locate i + 4 + y, x
        ? space( longest_string + 6 )
        Color 15, border_
        Locate i + 4 + y,  x
        ? " "
        Locate i + 4 + y, ( longest_string + 6 ) + x - 1
        ? " "


      
      If mx > char_loc.x Then
        If my > char_loc.y Then
          If mx < char_loc.x + Len( thr->dat.s ) Shl 3 Then
            If my < char_loc.y + 8 Then
              
              Locate i + 4 + y, 1 + ( longest_string + 6 - Len( thr->dat.s ) ) \ 2 + x

              Color txthi_, bghi_
              ? thr->dat.s
              Color 15, 0
              
              If mb And sc_leftbutton Then
        
                      hold_button( sc_leftbutton )
                      Return i
              End If
            Else
              alternate = -1  
            End If
          Else
            alternate = -1  
          End If
        Else
          alternate = -1  
        End If
      Else
        alternate = -1  
      End If

      If alternate Then
        
        Color txt_, bg_
        Locate i + 4 + y, 1 + ( longest_string + 6 - Len( thr->dat.s ) ) \ 2 + x
        ? thr->dat.s

      End If
      
      thr = thr->nxt

      Sleep 1
      
    Next




    Color 15, bg_
    Locate i + 4 + y, x
    ? space( longest_string + 6 )

    Color 15, border_
    Locate i + 4 + y,  x
    ? " "
    Locate i + 4 + y, ( longest_string + 6 ) + x - 1
    ? " "

    
    Color 15, border_
    Locate i + 5 + y, x
    ? space( longest_string + 6 )
    Color 15, 0
  
    thr = items
    
'    handle_refresh()
    fb_ScreenRefresh()
      
  Loop Until MultiKey( sc_escape ) Or ( ( mb And sc_rightbutton ) And ( mx > -1 ) )
  
  hold_key( sc_escape )
  hold_button( sc_rightbutton )
  
  Return -1
  
End Function 
                                                                                                       
                                                                                                       