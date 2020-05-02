#Include "..\headers\ll.bi"

'' Dependencies:
''
'' #Include "..\com\lists.bas"   '' (uses lists to enumerate files and directories)
'' #Include "..\com\utility.bas" '' (uses KillFileExt)


'#Define LL_IMAGELOADPROGRESS

Enum LLS_IMG_HANDSHAKES


  LLS_IMG_ADDRESOURCE
  LLS_IMG_REMOVERESOURCE

  LLS_IMG_GIVENAME
  LLS_IMG_GIVENAMEINSTR
  LLS_IMG_GIVEINDEX

  LLS_IMG_CLOSE


End Enum 


Sub LLSystem_ImageRelease( image_tag As LLSystem_ImageHeader )

  '' image_tag needs deallocated:
  ''
  '' .image
  ''
  '' if .frame[iterate].faces <> 0 then
  '' 
  ''   .frame[iterate].face
  ''
  '' end if
  ''
  '' .frame
  
  Dim As Integer i
  
  With image_tag
    
    .filename = ""
    
    clean_Deallocate( .image )
    
    For i = 0 To .frames - 1
      
      With .frame[i]

        clean_Deallocate( .face )
      
      End With
    
    Next
    
    clean_Deallocate( .frame )
    
  End With


End Sub


Function LLSystem_ImageLoad( image_tag As LLSystem_ImageHeader ) As Integer

  
  Dim As Integer o = FreeFile, i, get_frames, get_faces


  With image_tag

    #IfDef LL_IMAGELOADPROGRESS
      LLSystem_Log( "Loading: " & .filename, "imageload.txt" )
      
    #EndIf

    If Dir ( .filename ) = "" Then
      '' file doesn't exist. 
      #IfDef LL_IMAGELOADPROGRESS
        LLSystem_Log( .filename & " doesn't exist!", "imageload.txt" )
        
      #EndIf
      Return 0
      
    End If
  
    If Open( Trim( .filename ), For Binary Access Read, As o ) = 0 Then
    
      Get #o, , .x
      Get #o, , .y
      Get #o, , .arraysize
      Get #o, , .frames
      
      #IfDef LL_IMAGELOADPROGRESS
        LLSystem_Log( "Loaded image header.", "imageload.txt" )
        
      #EndIf

      .image = CAllocate( .frames * .arraysize * Len ( Short )  )

      #IfDef LL_IMAGELOADPROGRESS
        LLSystem_Log( "Loaded image pixel data.", "imageload.txt" )
        
      #EndIf
      
      Get #o, , *.image, .frames * .arraysize
          
      Close o
      
    End If

    .frame = CAllocate( Len ( LLSystem_FrameShell ) * ( .frames ) )

    If Dir ( kfe( .filename ) + ".col" ) <> "" Then 

      #IfDef LL_IMAGELOADPROGRESS
        LLSystem_Log( "Loading collision data.", "imageload.txt" )
        
      #EndIf

      o = FreeFile
      If Open( kfe( .filename ) + ".col", For Binary Access Read, As o ) = 0 Then

        For get_frames = 0 To .frames - 1

          With .frame[get_frames]
          
            Get #o, , .faces

            .face = CAllocate( Len( LLSystem_FaceType ) * ( .faces ) )
            
            For get_faces = 0 To .faces - 1
              
              With .face[get_faces]

                Get #o, , .x  
                Get #o, , .y
                Get #o, , .w
                Get #o, , .h
                Get #o, , .strength
                Get #o, , .invincible
                Get #o, , .impassable
                
              End With
              
            Next
            
          End With

        Next

        Close o
      
      End If
      
    End If

  End With

  #IfDef LL_IMAGELOADPROGRESS
    LLSystem_Log( "", "imageload.txt" )
    
  #EndIf
  
  Return -1

End Function


Sub LLSystem_ImageSaveCollision( image_tag As LLSystem_ImageHeader )

  
  Dim As Integer o = FreeFile, put_frames, put_faces, confirmReal


  With image_tag

    o = FreeFile
    If Open( kfe( .filename ) + ".col", For Binary Access Write, As o ) = 0 Then

      For put_frames = 0 To .frames - 1

        With .frame[put_frames]
        
          Put #o, , .faces

          For put_faces = 0 To .faces - 1
            
            With .face[put_faces]
              
              confirmReal = -1
              Put #o, , .x  
              Put #o, , .y
              Put #o, , .w
              Put #o, , .h
              Put #o, , .strength
              Put #o, , .invincible
              Put #o, , .impassable
              
            End With
            
          Next
          
        End With

      Next

      Close o
      
      If confirmReal = 0 Then Kill kfe( .filename ) + ".col"
    
    End If

  End With

End Sub


Private Sub LLSystem_ImageShallowCopy( d As LLSystem_ImageHeader, s As LLSystem_ImageHeader )

'  filename As String
'
'  As Integer x, y
'  
'  arraysize As Integer 
'
'  image As Short Ptr
'
'  frame As LLSystem_FrameShell Ptr  
'  frames As Integer

  d.filename = s.filename

  d.x = s.x
  d.y = s.y

  d.arraysize = s.arraysize 
  
  d.image = s.image 

  d.frame = s.frame
  d.frames = s.frames 



End Sub

private function SlashSwitch( stringy as string ) as string
  
  dim as string res = stringy
  
  dim as integer iStr
  
  for iStr = 0 to len( res ) - 1
    if res[iStr] = asc( "\" ) then '' "
      res[iStr] = asc( "/" )
      
    end if
    
  next
  
  return res
  
end function
  
  

Private Function LLSystem_ImageGUARD( arg As LLS_IMG_HANDSHAKES, carrier As Any Ptr = 0, stringSafety as string = "" ) As LLSystem_ImageHeader Ptr
  
  Static As LLSystem_ImageHeader Ptr img_Atom
  Static As Integer images 

'  Dim As String Ptr imgName = carrier
  Dim As Integer i
  Dim As uInteger imgIndex = CInt( carrier )
  
  
  Select Case arg

    Case LLS_IMG_ADDRESOURCE
      images += 1
      
      img_Atom = Reallocate( img_Atom, images * Len( LLSystem_ImageHeader ) )
      memset( Varptr( img_Atom[images - 1] ), 0, Len( LLSystem_ImageHeader ) )
      
      
      LLSystem_ImageShallowCopy( img_Atom[images - 1], *CPtr( LLSystem_ImageHeader Ptr, carrier ) )
      
      
    Case LLS_IMG_GIVENAME
    
      dim as string handShake = stringSafety 
      #ifdef __fb_linux__
        handShake = SlashSwitch( handShake )
      #endif
      
      For i = 0 To images - 1
        
        If Trim( UCase( img_Atom[i].filename ) ) = Trim( UCase( handShake ) ) Then
          Return CPtr( Any Ptr, i )
          
        End If
      
      Next
      Return CPtr( Any Ptr, -1 )
    

    Case LLS_IMG_GIVENAMEINSTR
    
      dim as string handShake = stringSafety 
      #ifdef __fb_linux__
        handShake = SlashSwitch( handShake )
      #endif
      
      
      For i = 0 To images - 1
        
        If Instr( Trim( UCase( img_Atom[i].filename ) ), Trim( UCase( handShake ) ) ) Then
          Return CPtr( Any Ptr, i )
          
        End If
      
      Next
      Return CPtr( Any Ptr, -1 )
    

    Case LLS_IMG_GIVEINDEX
    
    
      If imgIndex < images Then  
    
        Return Varptr( img_Atom[imgIndex] )
        
      End If
      

    Case LLS_IMG_CLOSE
      
      For i = 0 To images - 1
        LLSystem_ImageRelease( img_Atom[i] )
        
      Next
      
      clean_Deallocate( img_Atom )
    
  End Select
  

End Function

Private Function LLSystem_AddImageToReserve( fileName As String ) As Integer


  Dim As LLSystem_ImageHeader imageSkeleton 
  
  imageSkeleton.fileName = fileName

  If LLSystem_ImageLoad( imageSkeleton ) = 0 Then
    #IfDef LL_IMAGELOADPROGRESS
      LLSystem_Log( "Loading " & fileName & " failed! Aborting.", "imageload.txt" )
      
    #EndIf
    quick_text( "Loading " & fileName & " failed!" )
    imageSkeleton.fileName = ""
    
    End 
    Return 0
    
  End If

  LLSystem_ImageGUARD( LLS_IMG_ADDRESOURCE, Varptr( imageSkeleton ) )
  imageSkeleton.fileName = ""
  
  Return -1


End Function


Private Function LLSystem_CollectPictureFiles( pth As String ) As list_type Ptr


  Dim As list_type Ptr pictureDirs, pictureFiles, thr
  Dim As Integer i


  #IfDef LL_IMAGELOADPROGRESS
    LLSystem_Log( "Collecting all directories.", "imageload.txt" )
    
  #EndIf
  
  pictureDirs = push_dirs( pth )
  
  thr = pictureDirs 

  #IfDef LL_IMAGELOADPROGRESS
    LLSystem_Log( "Collecting all files in the directories.", "imageload.txt" )
    
  #EndIf
  For i = 0 To length( pictureDirs ) - 1

    pictureFiles = list_add( pictureFiles, list_files( thr->dat.s, "*.spr" ), " " )
    
    thr = thr->nxt
  
  Next
  
  #IfDef LL_IMAGELOADPROGRESS
    LLSystem_Log( "Destroying directory list.", "imageload.txt" )
    
  #EndIf
  list_Destroy( pictureDirs, list_strlist )

  Return pictureFiles


End Function


Private Sub LLSystem_CachePictureFilesEx( l As list_type Ptr )


  #IfDef LL_IMAGELOADPROGRESS
    LLSystem_Log( "Adding: " & l->dat.s, "imageload.txt" )
    
  #EndIf

  If LLSystem_AddImageToReserve( l->dat.s ) = 0 Then

    #IfDef LL_IMAGELOADPROGRESS
      LLSystem_Log( "Adding " & l->dat.s & " failed! Aborting.", "imageload.txt" )
      
    #EndIf
    quick_text( "Problem adding image to reserve: " & l->dat.s  )
    End
    
    
  End If

End Sub


Sub LLSystem_CachePictureFiles( pth As String )

  Dim As list_type Ptr picFiles
  pth = pth + "\"

  #IfDef LL_IMAGELOADPROGRESS
    LLSystem_Log( "Starting image caching operation.", "imageload.txt" )
    
  #EndIf
  
  picFiles = LLSystem_CollectPictureFiles( pth )

  #IfDef LL_IMAGELOADPROGRESS
    LLSystem_Log( "Iterating through pictures.", "imageload.txt" )
    LLSystem_Log( "", "imageload.txt" )
    
  #EndIf

  iterate_through_list( picfiles, ProcPtr( LLSystem_CachePictureFilesEx ) )
  
  #IfDef LL_IMAGELOADPROGRESS
    LLSystem_Log( "Destroying picture list.", "imageload.txt" )
    
  #EndIf
  list_destroy( picFiles, list_strlist )


End Sub


Function LLSystem_ImageDeref( index As Integer ) As LLSystem_ImageHeader Ptr

  If index > -1 Then
    Return LLSystem_ImageGUARD( LLS_IMG_GIVEINDEX, CPtr( Any Ptr, index ) )
    
  End If


End Function 


Function LLSystem_ImageDerefName( index As String, isInStr As Integer = 0 ) As LLSystem_ImageHandle

  Return IIf( isInStr, CuInt( LLSystem_ImageGUARD( LLS_IMG_GIVENAMEINSTR, , index ) ), CuInt( LLSystem_ImageGUARD( LLS_IMG_GIVENAME, , index ) ) )


End Function 


'Function LLObject_AnimDeref

Sub LLSystem_ClearImageCache()

  LLSystem_ImageGUARD( LLS_IMG_CLOSE )


End Sub


'LLSystem_CachePictureFiles( "..\..\data\pictures\" )
'
'
'LLSystem_ClearCache()


