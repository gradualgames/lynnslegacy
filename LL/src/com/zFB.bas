Option Explicit


#Include "zlib.bi"


#IfNDef memcpy
  Declare Function memcpy CDECL Alias "memcpy" (ByVal As Any Ptr, ByVal As Any Ptr, ByVal As Integer) As Any Ptr

#EndIf


#IfNDef z_Operations

  Enum z_Operations
  
    z_NULLARG
  
    z_STRTOSTR
    z_STRTOARRAY
    z_ARRAYTOSTR
    z_ARRAYTOARRAY
  
    z_Comp
    z_Decomp
    
  End Enum

#EndIf

#IfNDef FBArrayDim

  Type FBArrayDim
  
    Elements As Integer
    LBound As Integer
    UBound As Integer
  
  End Type

#EndIf

#IfNDef FBArray

  Type FBArray
  
    dat As Any Pointer
    pnt As Any Pointer
    sz As Integer
    Element_Len As Integer
    Dimensions As Integer
    DimTB( 15 ) As FBArrayDim '' 16 maximum??
  
  End Type 

#EndIf

#IfNDef VFile_Vector

  Type VFile_Vector
  
    sz As Integer
    dat As Any Ptr
    natural As Integer
    
  End Type

#EndIf

Private Function zLib_Compressor( ByRef infile As VFile_Vector, ByRef outfile As VFile_Vector, ByVal level As Integer = 9 ) As Integer


  Dim As Integer compresserror
  
  
  outfile.sz = infile.sz Shl 3
  outfile.dat = CAllocate( outfile.sz )

  compresserror = compress2( _ 
                             outfile.dat,          _ 
                             Varptr( outfile.sz ), _ 
                             infile.dat,           _ 
                             infile.sz,            _ 
                             level                 _
                           ) 

  If compresserror <> 0 Then 
    Return compresserror 

  End If 
  
  outfile.dat = Reallocate( outfile.dat, outfile.sz + 12 )
  
  memcpy( _ 
          outfile.dat + 12, _
          outfile.dat,      _
          outfile.sz        _
        )

  outfile.sz += 12
        
  Dim As uByte Ptr funnel = outfile.dat
        
  funnel[0] = Asc( "Z" )
  funnel[1] = Asc( "L" )
  funnel[2] = Asc( "I" )
  funnel[3] = Asc( "B" )
  
  *cptr( Integer Ptr, Varptr( funnel[4] ) ) = infile.sz
  *cptr( Integer Ptr, Varptr( funnel[8] ) ) = ( outfile.sz ) - 12
  

End Function


Private Function zLib_Decompressor( infile As VFile_Vector, outfile As VFile_Vector ) As Integer

  Dim uncompresserror As Integer 

  Dim As uInteger srclen, destlen  
  
  Dim As Integer ff = FreeFile
  
  Dim As uByte Ptr funnel = infile.dat
  
  If funnel[0] <> Asc( "Z" ) Then
    Return Z_DATA_ERROR
    
  End If

  If funnel[1] <> Asc( "L" ) Then
    Return Z_DATA_ERROR
    
  End If
  
  If funnel[2] <> Asc( "I" ) Then
    Return Z_DATA_ERROR
    
  End If
  
  If funnel[3] <> Asc( "B" ) Then
    Return Z_DATA_ERROR
    
  End If
  
  destLen = *cptr( Integer Ptr, Varptr( funnel[4] ) )
  srclen = *cptr( Integer Ptr, Varptr( funnel[8] ) )
  
  If srclen = 0 Then 
    Return Z_BUF_ERROR 
      
  End If 
  
  Redim source( ( srclen ) - 1 ) As uByte
  memcpy(                        _ 
          Varptr( source( 0 ) ), _
          Varptr( funnel[12] ),  _ 
          srclen                 _
        )
          
  
  
  If destLen <> 0 Then 
    outfile.dat = Reallocate( outfile.dat, destLen Shl 3 )
    
  End If
  
  uncompresserror = uncompress(                        _ 
                                outfile.dat,           _ 
                                Varptr( destLen ),     _ 
                                Varptr( source( 0 ) ), _ 
                                srclen                 _
                              ) 
  
  If uncompresserror <> 0 Then 
    Return uncompresserror 

  End If 
  
  If destLen <> 0 Then 
    outfile.dat = Reallocate( outfile.dat, destLen )
    outfile.sz = destLen 
    
  
  End If


End Function


Function _zLib_XXFlate Alias "_zLib_XXFlate" ( insrc As Any Ptr, outdest As Any Ptr, l As Integer = 9, operation As Integer, job As Integer ) As Integer


  Dim As VFile_Vector src, dest
  
  Dim As FBARRAY Ptr fb_ArrayDescriptor
  Dim As String Ptr fb_StringDescriptor
  Dim As String filename
  
  Dim As Integer ff

  
  Select Case operation
  
    '' fill source vector
    
    '' left hand string ops
    Case z_STRTOARRAY, z_STRTOSTR 
      '' load file into Vector.
      
      ff = FreeFile
      
      fb_StringDescriptor = Varptr( insrc )
      
      filename = *( fb_StringDescriptor )
      
      If Dir( filename ) = "" Then
        
        Return Z_STREAM_ERROR
        
      End If
      
      If Open( filename, For Binary Access Read, As ff ) <> 0 Then
        Return Z_STREAM_ERROR
         
      End If
      
      If Lof( ff ) = 0 Then
        Return Z_STREAM_ERROR
        
      End If
      
      src.sz = Lof( ff ) 
      src.dat = CAllocate( src.sz )
      
      get #ff, , *cptr( ubyte ptr, src.dat ), src.sz
'      fb_fileget( ff, 0, ByVal src.dat, src.sz )
      
      Close ff
      
      
    '' left hand array ops
    Case z_ARRAYTOSTR, z_ARRAYTOARRAY
      '' load array into Vector.

      fb_ArrayDescriptor = Varptr( insrc )
      
      If fb_ArrayDescriptor->dimensions = 0 Then
        '' invalid source.
        Return Z_STREAM_ERROR
        
      End If
      
      src.sz = fb_ArrayDescriptor->sz
      src.dat = CAllocate( src.sz )
      memcpy(                          _ 
              src.dat,                 _
              fb_ArrayDescriptor->dat, _
              src.sz                   _ 
            )
            
  End Select


  Dim As Integer res

  If job = z_Comp Then
    
    If l < 0 Or l > 9 Then
      Return -1
      
    End If
    
    res = zLib_Compressor( src, dest, l )
    
  ElseIf job = z_DeComp Then
    res = zLib_DeCompressor( src, dest )
  
  Else
    Return -1
    
  End If
  
  If res <> 0 Then 
    Return res
    
  End If
    

  Select Case operation
  
    '' fill source vector
    
    '' right hand string ops
    Case z_ARRAYTOSTR, z_STRTOSTR 
      '' load vector into file.
      
      ff = FreeFile
      
      fb_StringDescriptor = Varptr( outdest )
      filename = *( fb_StringDescriptor )
      
      If Open( filename, For Binary Access Write, As ff ) <> 0 Then
        Return Z_STREAM_ERROR
         
      End If
      
      put #ff, , *cptr( ubyte ptr, dest.dat ), dest.sz
      
      Close ff
      
      
    '' right hand array ops
    Case z_STRTOARRAY, z_ARRAYTOARRAY 
      '' load Vecotr into array.

      fb_ArrayDescriptor = Varptr( outdest )
      

      fb_ArrayDescriptor->sz = dest.sz
      fb_ArrayDescriptor->element_len = 1
      fb_ArrayDescriptor->dimensions = 1
      fb_ArrayDescriptor->dimtb( 0 ).elements = dest.sz
      fb_ArrayDescriptor->dimtb( 0 ).LBound = 0
      fb_ArrayDescriptor->dimtb( 0 ).UBound = dest.sz - 1
      
      Deallocate( fb_ArrayDescriptor->dat )
      fb_ArrayDescriptor->dat = CAllocate( dest.sz )
      
      memcpy( _ 
              fb_ArrayDescriptor->dat, _
              dest.dat,                _
              dest.sz                  _
            )
      
            
  End Select

  Deallocate( src.dat )
  Deallocate( dest.dat )
  
  
End Function


Function zLib_Error( e As Integer ) As String
  Return *zError( e )

End Function

