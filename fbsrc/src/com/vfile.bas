Option Explicit

#IfNDef memcpy
  Declare Function memcpy CDECL Alias "memcpy" (ByVal As Any Ptr, ByVal As Any Ptr, ByVal As Integer) As Any Ptr

#EndIf

#IfNDef memset
  Declare Function memset CDECL Alias "memset" (ByVal As Any Ptr, ByVal As Integer, ByVal As Integer) As Any Ptr
  
#EndIf


#IfNDef VFile_Virtual
  Type VFile_Virtual
    
    length As Integer
    cursor As Integer
    
    dat As Any Ptr
    
  End Type

#EndIf  


#IfNDef VFile_Vector
  Type VFile_Vector
  
    dat As Any Ptr
    sz As Integer
    natural As Integer
    
  End Type

#EndIf


#IfNDef VFile_Arrays
  Enum VFile_Arrays
  
    VF_NULL
    VF_BYTE
    VF_SHORT
    VF_INTEGER
    VF_LONGINT
    VF_SINGLE
    VF_DOUBLE
  
  
  End Enum

#EndIf

#IfNDef VFile_Errors
  Enum VFile_Errors
  
    VF_OK
    VF_HANDLE_USED
    VF_HANDLE_OUTOFRANGE
    VF_HANDLE_NOTALLOCATED
    VF_HANDLE_REJECTED
    
    VF_FILE_OVERRUN
    VF_FILE_STRINGTOOLARGE
  
  End Enum

#EndIf  

Dim Shared As Integer VFile_Handles

Redim Shared As Integer Vfile_OpenHandles( 0 )
Redim Shared As VFile_Virtual VFile_Internal( 0 )


#IfDef __FB_Win32__
  
  Dim Shared As Integer VFile_MutexHandle  
  
  VFile_MutexHandle = MutexCreate()
  
  #Define VFile_Lock()    MutexLock( VFile_MutexHandle )
  
  #Define VFile_UnLock()  MutexUnLock( VFile_MutexHandle )
  
  #Define VFile_Destroy() MutexDestroy( VFile_MutexHandle )
  
  
  
#EndIf

#IfDef __FB_Linux__
  
  Dim Shared As Integer VFile_MutexHandle  
  
  VFile_MutexHandle = MutexCreate()
  
  #Define VFile_Lock()    MutexLock( VFile_MutexHandle )
  
  #Define VFile_UnLock()  MutexUnLock( VFile_MutexHandle )
  
  #Define VFile_Destroy() MutexDestroy( VFile_MutexHandle )
  
  
  
#EndIf

#IfNDef VFile_Lock    
              
  #Define VFile_Lock()    :

#EndIf

#IfNDef VFile_UnLock  

  #Define VFile_UnLock()  :
              
#EndIf

#IfNDef VFile_Destroy 

  #Define VFile_Destroy() :

#EndIf

  
  







#Define build_VFile_Open(x)                                                                    _
                                                                                               _
  Function VFile_Open Overload ( f() As x, ByVal h As Integer ) As Integer                    :_
                                                                                              :_
    VFile_Lock()                                                                              :_
                                                                                              :_
    If h < 0 Then                                                                             :_
      VFile_UnLock()                                                                          :_
      Return VF_HANDLE_OUTOFRANGE                                                             :_
                                                                                              :_
    End If                                                                                    :_
                                                                                              :_
    Dim As Integer i                                                                          :_
                                                                                              :_
    For i = 0 To VFile_Handles - 1                                                            :_
                                                                                              :_
      If Vfile_OpenHandles( i ) = h Then                                                      :_
        VFile_UnLock()                                                                        :_
        Return VF_HANDLE_USED                                                                 :_
                                                                                              :_
      End If                                                                                  :_
                                                                                              :_
    Next                                                                                      :_
                                                                                              :_
    VFile_Handles += 1                                                                        :_
                                                                                              :_
    Redim Preserve VFile_Internal( VFile_Handles - 1 )                                        :_
    Redim Preserve VFile_OpenHandles( VFile_Handles - 1 )                                     :_
                                                                                              :_
    VFile_OpenHandles( VFile_Handles - 1 ) = h                                                :_
                                                                                              :_
                                                                                              :_
    Dim As Integer arraylbound = LBound( f )                                                  :_
    Dim As Integer arrayubound = UBound( f )                                                  :_
                                                                                              :_
    Dim As Integer arraysize = ( arrayubound - arraylbound ) + 1                              :_
                                                                                              :_
    VFile_Internal( VFile_Handles - 1 ).cursor = 0                                            :_
                                                                                              :_
    VFile_Internal( VFile_Handles - 1 ).length = arraysize * Len( x )                         :_
                                                                                              :_
    VFile_Internal( VFile_Handles - 1 ).dat = CAllocate( arraysize * Len( x ) )               :_
                                                                                              :_
    memcpy( VFile_Internal( VFile_Handles - 1 ).dat, Varptr( f( 0 ) ), arraysize * Len( x ) ) :_
                                                                                              :_
    VFile_Unlock()                                                                            :_
                                                                                              :_
  End Function



build_VFile_Open( uByte )
build_VFile_Open( uShort )
build_VFile_Open( uInteger )
build_VFile_Open( Single )
build_VFile_Open( Double )
build_VFile_Open( uLongInt )




Function VFile_Open Overload ( f As String, ByVal h As Integer ) As Integer

  VFile_Lock()
  
  If h < 0 Then
    VFile_UnLock() 
    Return VF_HANDLE_OUTOFRANGE
    
  End If
  
  Dim As Integer i

  For i = 0 To VFile_Handles - 1

    If Vfile_OpenHandles( i ) = h Then
      VFile_UnLock()
      Return VF_HANDLE_USED
      
    End If
  
  Next
  
  VFile_Handles += 1
  
  Redim Preserve VFile_Internal( VFile_Handles - 1 )
  Redim Preserve VFile_OpenHandles( VFile_Handles - 1 )
  
  VFile_OpenHandles( VFile_Handles - 1 ) = h

  Dim As Integer ff = FreeFile

  Open f For Binary As ff
  
    Dim As Integer arraysize = Lof( ff )
    Dim As uByte VF_Chunk( arraysize - 1 )
    
    Get #ff, , VF_Chunk()
    
    VFile_Internal( VFile_Handles - 1 ).cursor = 0
    
    VFile_Internal( VFile_Handles - 1 ).length = arraysize
    
    VFile_Internal( VFile_Handles - 1 ).dat = CAllocate( arraysize )
    
    memcpy( VFile_Internal( VFile_Handles - 1 ).dat, Varptr( VF_Chunk( 0 ) ), arraysize )
    
  Close ff
  
  VFile_UnLock()
  
End Function


Function VFile_Open Overload ( ByVal f As Any Ptr, ByVal l As Integer, ByVal h As Integer ) As Integer
  
  
  VFile_Lock()

  If h < 0 Then 
    VFile_UnLock()
    Return VF_HANDLE_OUTOFRANGE
    
  End If
  
  Dim As Integer i

  For i = 0 To VFile_Handles - 1

    If Vfile_OpenHandles( i ) = h Then
      VFile_UnLock()
      Return VF_HANDLE_USED
      
    End If
  
  Next
  
  VFile_Handles += 1
  
  Redim Preserve VFile_Internal( VFile_Handles - 1 )
  Redim Preserve VFile_OpenHandles( VFile_Handles - 1 )
  
  VFile_OpenHandles( VFile_Handles - 1 ) = h

  Dim As Integer arraysize = l
  
  VFile_Internal( VFile_Handles - 1 ).cursor = 0
  VFile_Internal( VFile_Handles - 1 ).length = arraysize
  VFile_Internal( VFile_Handles - 1 ).dat = CAllocate( arraysize )
  
  memcpy( VFile_Internal( VFile_Handles - 1 ).dat, f, arraysize )
  
  VFile_UnLock()
  
End Function






Private Function VFile_HandleAddress( h As Integer ) As Integer
  
  Dim As Integer i
  
  For i = 0 To VFile_Handles - 1                             
                                                             
    If h = VFile_OpenHandles( i ) Then
      VFile_UnLock()
      Return i
                                                             
    End If                                                   
                                                             
  Next                                                       

  VFile_UnLock()  
  Return -1
  
End Function



Sub VFile_FreeVector( v As VFile_Vector )
  
  If v.natural = 0 Then
    Deallocate( v.dat )
    
  End If
  
End Sub

  




#Define build_VFile_Get(x)                                                                               _
                                                                                                         _
  Function VFile_Get Overload ( ByVal h As Integer, ByVal p As Integer = -1, ByRef u As x ) As Integer  :_
                                                                                                        :_
    VFile_Lock()                                                                                        :_
                                                                                                        :_
    If h = 0 Then                                                                                       :_
      u = 0                                                                                             :_
      VFile_UnLock()                                                                                    :_
      Return VF_HANDLE_OUTOFRANGE                                                                       :_
                                                                                                        :_
    End If                                                                                              :_
                                                                                                        :_
    Dim As Integer VF_Active                                                                            :_
                                                                                                        :_
    VF_Active = VFile_HandleAddress( h )                                                                :_
                                                                                                        :_
                                                                                                        :_
    If VF_Active = -1 Then                                                                              :_
      u = 0                                                                                             :_
      VFile_UnLock()                                                                                    :_
      Return VF_HANDLE_NOTALLOCATED                                                                     :_
                                                                                                        :_
    End If                                                                                              :_
                                                                                                        :_
                                                                                                        :_
    With VFile_Internal( VF_Active )                                                                    :_
                                                                                                        :_
      If p <> -1 Then                                                                                   :_
                                                                                                        :_
        If p < 0 Then                                                                                   :_
          VFile_UnLock()                                                                                :_
          Return VF_FILE_OVERRUN                                                                        :_
                                                                                                        :_
        End If                                                                                          :_
                                                                                                        :_
        .cursor = p                                                                                     :_
                                                                                                        :_
      End If                                                                                            :_
                                                                                                        :_
                                                                                                        :_
      If .cursor > ( .length - Len( x ) ) Then                                                          :_
        u = 0                                                                                           :_
        VFile_UnLock()                                                                                  :_
        Return VF_FILE_OVERRUN                                                                          :_
                                                                                                        :_
      End If                                                                                            :_
                                                                                                        :_
      u = *cptr( x Ptr, Varptr( cptr( uByte Ptr, .dat )[.cursor] ) )                                    :_
                                                                                                        :_
      .cursor += Len( x )                                                                               :_
                                                                                                        :_
    End With                                                                                            :_
                                                                                                        :_
    VFile_UnLock()                                                                                      :_
                                                                                                        :_
  End Function

build_VFile_Get( uByte )
build_VFile_Get( uShort )
build_VFile_Get( uInteger )
build_VFile_Get( Single )
build_VFile_Get( Double )
build_VFile_Get( uLongInt )


Private Function VFile_Get_HString( ByRef h As VFile_Virtual, p As Integer, u As zString Ptr ) As Integer

  
  Dim As uShort slen

  slen = *cptr( uShort Ptr, Varptr( cptr( uByte Ptr, h.dat )[h.cursor] ) )
  
  If Len( *u ) > 65535 Then 
    Return VF_FILE_STRINGTOOLARGE
    
  End If
  
  If p <> -1 Then                                                         
                                                                          
    If p < 0 Then                                                         
      Return VF_FILE_OVERRUN                                              
                                                                          
    End If                                                                
                                                                          
    h.cursor = p                                                          
                                                                          
  End If                                                                  

  If ( h.cursor + slen + 2 ) > ( h.length - 1 ) Then
    Return VF_FILE_OVERRUN
  
  End If

  h.cursor += 2
  u = CAllocate( slen + 1 )
  
  memcpy(                                               _ 
          u,                                            _ 
          Varptr( cptr( uByte Ptr, h.dat )[h.cursor] ), _
          slen                                          _
        )
        
  
  h.cursor += Len( *u )
                                                                        
                                                                        
End Function

Function VFile_Get Overload ( ByVal h As Integer, ByVal p As Integer = -1, u As String ) As Integer
  
  VFile_Lock()

  Dim As Integer VF_Active
  
  VF_Active = VFile_HandleAddress( h )

  If VF_Active = -1 Then 
    u = ""
    VFile_UnLock()
    Return VF_HANDLE_NOTALLOCATED
    
  End If
  
  
  Dim As zString Ptr zres
  Dim As String res
  
  Dim As Integer VF_ErrorCheck
  

  VF_ErrorCheck = VFile_Get_HString( VFile_Internal( VF_Active ), p, zres )
  
  If VF_ErrorCheck <> 0 Then
  
    Select Case VF_ErrorCheck
    
      Case VF_FILE_STRINGTOOLARGE
        VFile_UnLock()
        Return VF_FILE_STRINGTOOLARGE
  
      Case VF_FILE_OVERRUN
        VFile_UnLock()
        Return VF_FILE_OVERRUN
        
    End Select
  
  End If
  
  u = *zres
  Deallocate( zres )
  VFile_UnLock()
  
End Function
  
Function VFile_Get Overload ( ByVal h As Integer, ByVal p As Integer = -1, ByRef u As VFile_Vector ) As Integer  
                                                                                                      
  VFile_Lock()                                                                                        
  
  
                                                                                                      
  If h = 0 Then                                                                                       
    If u.natural = 0 Then
      VFile_FreeVector( u )                                                                               
      
    End If
    VFile_UnLock()                                                                                    
    Return VF_HANDLE_OUTOFRANGE                                                                       
                                                                                                      
  End If                                                                                              
                                                                                                      
  Dim As Integer VF_Active                                                                            
                                                                                                      
  VF_Active = VFile_HandleAddress( h )                                                                
                                                                                                      
                                                                                                      
  If VF_Active = -1 Then                                                                              
    If u.natural = 0 Then
      VFile_FreeVector( u )                                                                               
      
    End If
    VFile_UnLock()                                                                                    
    Return VF_HANDLE_NOTALLOCATED                                                                     
                                                                                                      
  End If                                                                                              
                                                                                                      
                                                                                                      
  With VFile_Internal( VF_Active )                                                                    
                                                                                                      
    If p <> -1 Then                                                                                   
                                                                                                      
      If p < 0 Then                                                                                   
        VFile_UnLock()                                                                                
        Return VF_FILE_OVERRUN                                                                        
                                                                                                      
      End If                                                                                          
                                                                                                      
      .cursor = p                                                                                     
                                                                                                      
    End If                                                                                            
                                                                                                      
                                                                                                      
    If .cursor > ( .length - u.sz ) Then                                                              
      If u.natural = 0 Then
        VFile_FreeVector( u )                                                                               
        
      End If
      VFile_UnLock()                                                                                  
      Return VF_FILE_OVERRUN                                                                          
                                                                                                      
    End If                                                                                            
                                                                                                      
                                                                                                      
    memcpy(                                                                                            _
            u.dat,                                                                                     _
            Varptr( cptr( uByte Ptr, .dat )[.cursor] ),                                                _
            u.sz                                                                                       _
          )                                                                                           
                                                                                                      
    .cursor += u.sz                                                                                   
                                                                                                      
  End With                                                                                            
  
  If u.natural = 0 Then
    VFile_FreeVector( u )                                                                               
    
  End If
  VFile_UnLock()                                                                                      
                                                                                                      
End Function









#Define build_VFile_Put(x)                                                                                _
                                                                                                          _
  Function VFile_Put Overload ( ByVal h As Integer, ByVal p As Integer = -1, ByVal u As x ) As Integer   :_
                                                                                                         :_
    VFile_Lock()                                                                                         :_
                                                                                                         :_
    If h = 0 Then                                                                                        :_
      VFile_UnLock()                                                                                     :_
      Return VF_HANDLE_OUTOFRANGE                                                                        :_
                                                                                                         :_
    End If                                                                                               :_
                                                                                                         :_
    Dim As Integer VF_Active                                                                             :_
                                                                                                         :_
    VF_Active = VFile_HandleAddress( h )                                                                 :_
                                                                                                         :_
    If VF_Active = -1 Then                                                                               :_
      VFile_UnLock()                                                                                     :_
      Return VF_HANDLE_NOTALLOCATED                                                                      :_
                                                                                                         :_
    End If                                                                                               :_
                                                                                                         :_
                                                                                                         :_
    With VFile_Internal( VF_Active )                                                                     :_
                                                                                                         :_
                                                                                                         :_
      If p <> -1 Then                                                                                    :_
                                                                                                         :_
        If p < 0 Then                                                                                    :_
          VFile_UnLock()                                                                                 :_
          Return VF_FILE_OVERRUN                                                                         :_
                                                                                                         :_
        End If                                                                                           :_
                                                                                                         :_
        .cursor = p                                                                                      :_
                                                                                                         :_
      End If                                                                                             :_
                                                                                                         :_
      Dim As Integer size_requirement = ( .cursor + Len( x ) ), size_difference                          :_
                                                                                                         :_
                                                                                                         :_
      If size_requirement > .length - 1 Then                                                             :_
                                                                                                         :_
        size_difference = .length                                                                        :_
                                                                                                         :_
        .length += ( size_requirement - .length )                                                        :_
                                                                                                         :_
        .dat = Reallocate( .dat, .length )                                                               :_
                                                                                                         :_
        memset( Varptr( CPtr( uByte Ptr, .dat )[size_difference] ), 0, .length - size_difference )       :_                                                                                   :_
                                                                                                         :_
                                                                                                         :_
      End If                                                                                             :_
                                                                                                         :_
                                                                                                         :_
      *cptr( x Ptr, Varptr( cptr( uByte Ptr, .dat )[.cursor] ) ) = u                                     :_
                                                                                                         :_
      .cursor += Len( x )                                                                                :_
                                                                                                         :_
    End With                                                                                             :_
                                                                                                         :_
    VFile_UnLock()                                                                                       :_
                                                                                                         :_
                                                                                                         :_
  End Function  


build_VFile_Put( uByte )
build_VFile_Put( uShort )
build_VFile_Put( uInteger )
build_VFile_Put( Single )
build_VFile_Put( Double )
build_VFile_Put( uLongInt )







Function VFile_Put Overload ( ByVal h As Integer, ByVal p As Integer = -1, u As String )

  VFile_Lock()

  Dim As uShort slen = Len( u )

  If Len( u ) > 65535 Then 
    Return VF_FILE_STRINGTOOLARGE
    VFile_UnLock()    
  End If

  If h = 0 Then                                                               
    Return VF_HANDLE_OUTOFRANGE                                               
    VFile_UnLock()
                                                                              
  End If                                                                      
                                                                              
  Dim As Integer VF_Active
                                                                              
  VF_Active = VFile_HandleAddress( h )                                        
                                                                              
  If VF_Active = -1 Then                                                      
    Return VF_HANDLE_NOTALLOCATED                                             
    VFile_UnLock()
                                                                              
  End If                                                                      
                                                                              
                                                                              
  With VFile_Internal( VF_Active )                                            

    If p <> -1 Then                                                          
                                                                             
      If p < 0 Then                                                          
        Return VF_FILE_OVERRUN                                               
        VFile_UnLock()
                                                                             
      End If                                                                 
                                                                             
      .cursor = p                                                            
                                                                             
    End If                                                                   
  
    Dim As Integer size_requirement = ( .cursor + 2 + Len( u ) ), size_difference
    
    
    If size_requirement > .length - 1 Then
    
      size_difference = .length
      
      .length += ( size_requirement - .length )
      
      .dat = Reallocate( .dat, .length )
      
      memset(                                                     _
              Varptr( cptr( uByte Ptr, .dat )[size_difference] ), _
              0,                                                  _
              .length - size_difference                           _
            )
            
            
    End If
      
    *cptr( uShort Ptr, Varptr( cptr( uByte Ptr, .dat )[.cursor] ) ) = slen
    .cursor += 2
    
    memcpy(                                             _
            Varptr( cptr( uByte Ptr, .dat )[.cursor] ), _
            StrPtr( u ),                                          _
            Len( u )                                   _
          )
            
                                                                          
    .cursor += Len( u )
    
  End With
  
   VFile_UnLock()       
                                                                        
End Function



Function VFile_Put Overload ( ByVal h As Integer, ByVal p As Integer = -1, ByRef u As VFile_Vector ) As Integer  
                                                                                                      
  VFile_Lock()                                                                                        
                                                                                                      
  If h = 0 Then                                                                                       
    If u.natural = 0 Then
      VFile_FreeVector( u )                                                                               
      
    End If
    VFile_UnLock()                                                                                    
    Return VF_HANDLE_OUTOFRANGE                                                                       
                                                                                                      
  End If                                                                                              
                                                                                                      
  Dim As Integer VF_Active                                                                            
                                                                                                      
  VF_Active = VFile_HandleAddress( h )                                                                
                                                                                                      
                                                                                                      
  If VF_Active = -1 Then                                                                              
    If u.natural = 0 Then
      VFile_FreeVector( u )                                                                               
      
    End If
    VFile_UnLock()                                                                                    
    Return VF_HANDLE_NOTALLOCATED                                                                     
                                                                                                      
  End If                                                                                              
                                                                                                      
                                                                                                      
  With VFile_Internal( VF_Active )                                                                    
                                                                                                      
    If p <> -1 Then                                                                                   
                                                                                                      
      If p < 0 Then                                                                                   
        VFile_UnLock()                                                                                
        Return VF_FILE_OVERRUN                                                                        
                                                                                                      
      End If                                                                                          
                                                                                                      
      .cursor = p                                                                                     
                                                                                                      
    End If                                                                                            
                                                                                                      

    Dim As Integer size_requirement = ( .cursor + 2 + u.sz ), size_difference
    
    
    If size_requirement > .length - 1 Then
    
      size_difference = .length
      
      .length += ( size_requirement - .length )
      
      .dat = Reallocate( .dat, .length )
      
      memset(                                                     _
              Varptr( cptr( uByte Ptr, .dat )[size_difference] ), _
              0,                                                  _
              .length - size_difference                           _
            )
            
            
    End If
                                                                                                      
                                                                                                      
    memcpy(                                                                                            _
            Varptr( cptr( uByte Ptr, .dat )[.cursor] ),                                                _
            u.dat,                                                                                     _
            u.sz                                                                                       _
          )                                                                                           
                                                                                                      
    .cursor += u.sz                                                                                   
                                                                                                      
  End With                                                                                            
  
  If u.natural = 0 Then
    VFile_FreeVector( u )                                                                               
    
  End If
  VFile_UnLock()                                                                                      
                                                                                                      
End Function




Function VFile_Save Overload ( ByVal h As Integer, u As zString Ptr )
  
  VFile_Lock()
  
  Dim As Integer VF_CheckHandle = VFile_HandleAddress( h )
  
  If VF_CheckHandle = -1 Then
    VFile_UnLock()
    Return VF_HANDLE_NOTALLOCATED
    
  End If
  
  
  Dim As Integer ff = FreeFile
  
  Open *u For Binary As ff

    With VFile_Internal( VF_CheckHandle )  
      Put #ff, 0, *Cast( uByte Ptr, .dat ), .length
      
    End With
    
  Close ff
  
  VFile_UnLock()
  
End Function


Function VFile_Save Overload ( ByVal h As Integer, u() As uByte )
  
  VFile_Lock()
  
  Dim As Integer VF_CheckHandle = VFile_HandleAddress( h )
  
  If VF_CheckHandle = -1 Then
    VFile_UnLock()
    Return VF_HANDLE_NOTALLOCATED
    
  End If
  
  
  
  With VFile_Internal( VF_CheckHandle )  
    Redim u( .length - 1 )
    memcpy( _ 
            Varptr( u( 0 ) ), _
            .dat,             _
            .length           _
          )
            
    
  End With
  
  
  
  
  VFile_UnLock()
  
End Function



Private Sub VFile_CloseAll()
  
  Dim As Integer i
  
  For i = 0 To VFile_Handles - 1
  
    Deallocate( VFile_Internal( i ).dat )
    VFile_Internal( i ).dat = 0
    
  Next
  
  VFile_Handles = 0

  Redim VFile_Internal( 0 )
  Redim VFile_OpenHandles( 0 )
  
  
End Sub


Private Sub VFile_ShuffleOut( h As Integer )

  Dim As Integer i
  
  For i = h To VFile_Handles - 2
  
    memcpy(                                 _ 
            Varptr( VFile_Internal( h ) ),     _
            Varptr( VFile_Internal( h + 1 ) ), _
            Len( VFile_Virtual )            _
          )

    memcpy(                                    _ 
            Varptr( VFile_OpenHandles( h ) ),     _
            Varptr( VFile_OpenHandles( h + 1 ) ), _
            Len( VFile_Virtual )               _
          )
          
  Next
  
  Deallocate( VFile_Internal( h ).dat )
  VFile_Internal( h ).dat = 0
  
  If h <> 0 Then
    Redim Preserve VFile_Internal( h - 1 )
    Redim Preserve VFile_OpenHandles( h - 1 )
    
  End If
  
  VFile_Handles -= 1
  
End Sub



Function VFile_Close( ByRef h As Integer = -1 ) As Integer
  
  VFile_Lock()
  
  If h = -1 Then
    VFile_CloseAll()
    VFile_UnLock()

    Exit Function
    
  End If
  
  Dim As Integer VF_Active
  
  VF_Active = VFile_HandleAddress( h )
  
  If VF_Active = -1 Then
    VFile_UnLock()
    Return VF_HANDLE_NOTALLOCATED
    
    
  End If
  
  VFile_ShuffleOut( VF_Active )

  VFile_UnLock()
  
End Function
  

Function VFile_FreeFile() As Integer

  VFile_Lock()
  

  Dim As Integer h
  
  Do

    h += 1

    If h < 0 Then
      VFile_UnLock()
      Return -1
      
    End If
    
    If VFile_HandleAddress( h ) = -1 Then 
      VFile_UnLock()
      
      Return h
      
    End If
    
  Loop
  
  
End Function
  
    
Function VFile_Seek( ByVal h As Integer, ByVal fp As Integer ) As Integer
  
  VFile_Lock()
  
  If fp < 0 Then
    VFile_UnLock()
    Return VF_FILE_OVERRUN
    
  End If
  
  Dim As Integer VF_CheckHandle = VFile_HandleAddress( h )
  
  If VF_CheckHandle = -1 Then
    VFile_UnLock()
    Return VF_HANDLE_NOTALLOCATED
    
  End If
  
  If fp > ( VFile_Internal( VF_CheckHandle ).length - 1 ) Then
    VFile_UnLock()
    Return VF_FILE_OVERRUN
    
  End If
  
  VFile_Internal( VF_CheckHandle ).cursor = fp
  
  VFile_UnLock()
  
  
End Function
  
    
Function VFile_LOF( ByVal h As Integer ) As Integer
  
  VFile_Lock()
  
  Dim As Integer VF_CheckHandle = VFile_HandleAddress( h )
  
  If VF_CheckHandle = -1 Then
    VFile_UnLock()
    Return VF_HANDLE_NOTALLOCATED
    
  End If
  
  VFile_UnLock()
  Return VFile_Internal( VF_CheckHandle ).length
  
  
End Function
  
    
Function VFile_EOF( ByVal h As Integer ) As Integer

  VFile_Lock()
  
  Dim As Integer VF_CheckHandle = VFile_HandleAddress( h )
  
  If VF_CheckHandle = -1 Then
    VFile_UnLock()
    Return 0
    
  End If
  
  VFile_UnLock()
  Return ( VFile_Internal( VF_CheckHandle ).cursor > ( VFile_Internal( VF_CheckHandle ).length - 1 ) )
  
  
End Function

Function VFile_LOC( ByVal h As Integer ) As Integer
  
  VFile_Lock()
  
  Dim As Integer VF_CheckHandle = VFile_HandleAddress( h )
  
  If VF_CheckHandle = -1 Then
    VFile_UnLock()
    Return VF_HANDLE_NOTALLOCATED
    
  End If
  
  VFile_UnLock()
  Return VFile_Internal( VF_CheckHandle ).cursor
  
  
End Function
  
    
