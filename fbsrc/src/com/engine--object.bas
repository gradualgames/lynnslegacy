#Include "..\headers\ll.bi"

'' Dependencies:
''
'' #Include "..\com\lists.bas"   '' (uses lists to enumerate files and directories)
'' #Include "..\com\utility.bas" '' (uses KillFileExt)

Option Explicit

'#Define LL_OBJECTLOADPROGRESS


Enum LLS_OBJ_HANDSHAKES


  LLS_OBJ_ADDRESOURCE
  LLS_OBJ_REMOVERESOURCE

  LLS_OBJ_GIVENAME
  LLS_OBJ_GIVEINDEX

  LLS_OBJ_CLOSE


End Enum 

#Define diffAddress(x) ( Varptr( d.##x ) <> Varptr( s.##x ) )
#Define diffAlloc(x) IIf( s.##x <> 0, ( d.##x <> s.##x ), -1 )




Sub LLSystem_ObjectRelease( objectDestroy As _char_type, debugString As String = "" )

  Dim As Integer i, j
  
  With objectDestroy
    
    clean_Deallocate( .sound )
    clean_Deallocate( .vol )
    
    
    With .funcs

      clean_Deallocate( .func_count )
      clean_Deallocate( .current_func )
      
      If .func <> 0 Then

        For i = 0 To .states - 1 
          clean_Deallocate( .func[i] )
        
        Next i
        
      End If

      clean_Deallocate( .func )

    End With

    
    If .animControl <> 0 Then
    
      For i = 0 To .anims - 1
        
        If .animControl[i].frame <> 0 Then
          For j = 0 To .anim[i]->frames - 1
            clean_Deallocate( .animControl[i].frame[j].concurrent ) 
    
          Next j
          
        End If
        
        clean_Deallocate( .animControl[i].frame )
      
      Next i

      clean_Deallocate( .animControl )
      
    End If


    clean_Deallocate( .anim )


    If .drop <> 0 Then 
      clean_Deallocate( .drop->anim )
      clean_Deallocate( .drop )

    End If
    
    If .projectile Then
      clean_Deallocate( .projectile->coords )
    
    End If

    clean_Deallocate( .projectile )

    
  End With


End Sub


Private Sub LLObject_UniqueCheck( c As char_type )
  
  #Define this_object(x) _
    

  #Define check_object_id(__x__)                                                _
                                                                                _
    If ( Right( .id, Len( ###__x__ & ".xml" ) ) = ( ###__x__ & ".xml" ) ) Then :_
      .unique_id = u_##__x__                                                   :_
      Exit Sub                                                                 :_
                                                                               :_
    End If                                                                     :_

  
  With c

    check_object_id( beamcrystal   )
    check_object_id( bluechest     )
    check_object_id( chest         )
    check_object_id( bluechestitem )
    check_object_id( gbutton       )
    check_object_id( button        )
    check_object_id( bshape        )
    check_object_id( gshape        )
    check_object_id( bush          )
    check_object_id( tguard        )
    check_object_id( bguard        )
    check_object_id( eguard        )
    check_object_id( cguard        )
    check_object_id( ltorch        )
    check_object_id( gtorch        )
    check_object_id( torch         )
    check_object_id( ibug          )
    check_object_id( beetle        )
    check_object_id( fbug          )
    check_object_id( gold          )
    check_object_id( silver        )
    check_object_id( crate_health  )
    check_object_id( charger       )
    check_object_id( health        )
    check_object_id( fkeydoor      )
    check_object_id( keydoor       )
    check_object_id( bardoor       )
    check_object_id( static        )
    check_object_id( pushrock      )
    check_object_id( menu          )
    check_object_id( savepoint     )
    check_object_id( crate         )
    check_object_id( grult         )
    check_object_id( ghut          )
    check_object_id( hotrock       )
    check_object_id( coldrock      )
    check_object_id( greyrock      )
    check_object_id( bombrock      )
    check_object_id( mole          )
    check_object_id( sign          )
    check_object_id( dyssius       )
    check_object_id( anger         )
    check_object_id( angerfireball )
    check_object_id( sparkle       )
    check_object_id( sterach       )
    check_object_id( swordie       )
    check_object_id( lynn          )
    check_object_id( slimeman      )
    check_object_id( antiwall2     )
    check_object_id( antiwall      )
    check_object_id( pmouth        )
    check_object_id( boss5_right   )
    check_object_id( boss5_left    )
    check_object_id( boss5_down    )
    check_object_id( boss5_crystal )

    check_object_id( pekkle_blue )
    check_object_id( pekkle_red )
    check_object_id( pekkle_grey )
    check_object_id( pekkle_red )
    check_object_id( pekkle_big )
    check_object_id( pekkle_bomb )

    check_object_id( goldblock )

    check_object_id( divine_ball )
    check_object_id( divine_bug )
    check_object_id( divine )

    check_object_id( kambot )
    check_object_id( auto )
    check_object_id( mech )
    check_object_id( godstat )
    check_object_id( haywire )
    check_object_id( biglarva )
    check_object_id( cell )
    check_object_id( statue )
    check_object_id( battleseed )
    check_object_id( healthguy )

    If .id = ( "data\object\ferus.xml" ) Then 
      .unique_id = u_ferus                    
      Exit Sub                                
                                              
    End If                                    
    
    check_object_id( steelstrider )

    check_object_id( core )

  End With
  
End Sub
          

Private Function LLSystem_ObjectLoad( objectLoad As _char_type ) As Integer


  Dim As Integer op1, op2, i, it, itt
  Dim As String dblquote = """"""
  
  op1 = ( objectLoad.id = "" )  
  op2 = ( Dir( objectLoad.id ) = "" )
  
  If op1 Or op2 Then
    
    Return 0
    
  End If
    
  Dim As xml_type Ptr clean_up


  clean_up = xml_Load( objectLoad.id )


  #IfDef LL_OBJECTLOADPROGRESS
    LLSystem_Log( "XML loaded.", "objectload.txt" )
    
  #EndIf

  objectLoad.flash_time = .02
  objectLoad.flash_length = 30
  
  objectLoad.hit_sound = sound_enemyhit
  objectLoad.dead_sound = sound_enemykill
  

  LLSystem_ObjectFromXML( clean_up, objectLoad )

  #IfDef LL_OBJECTLOADPROGRESS
    LLSystem_Log( "Object extracted from XML.", "objectload.txt" )
    
  #EndIf

  xml_Destroy( clean_up )

  #IfDef LL_OBJECTLOADPROGRESS
    LLSystem_Log( "Destroyed XML tree.", "objectload.txt" )
    
  #EndIf


  For i = 0 To objectLoad.anims - 1

    For it = 0 To objectLoad.anim[i]->frames - 1
    
      For itt = 0 To objectLoad.animControl[i].frame[it].concurrents - 1 
        
        With objectLoad.animControl[i].frame[it].concurrent[itt]
          '' one day...
          '' .char.location = V2_Add( objectLoad.location, V2_Subtract( .origin, V2_Scale( .char->perimeter, .5 ) ) )
          ''
          '' hehe dreams come true through hard work and diligence.

'          .char->x_origin = objectLoad.coords.x + .origin.x - ( .char->perimeter.x * .5 )
'          .char->y_origin = objectLoad.coords.y + .origin.y - ( .char->perimeter.y * .5 )
'          .char->coords.x = .char->x_origin 
'          .char->coords.y = .char->y_origin
          
          .char->coords = V2_Add( objectLoad.coords, V2_Subtract( .origin, V2_Scale( .char->perimeter, .5 ) ) )
          
          .char->x_origin = .char->coords.x
          .char->y_origin = .char->coords.y
        
        End With
        
      Next
      
    Next
    
  Next
  
  objectLoad.funcs.active_state = 0
  objectLoad.current_anim = 0
  objectLoad.frame = 0
  
  objectLoad.maxhp = objectLoad.hp  
  objectLoad.switch_room = -1

  LLObject_UniqueCheck( objectLoad )
  
  

  Return 1

  
End Function




Private Sub LLSystem_ObjectShallowCopy( d As _char_type, s As _char_type )

  
' id as string  
' spawns_id as string  
' to_map as string
  
  MemCpy( Varptr( d ), Varptr( s ), Len( _char_type ) )
'  d = s '' same.... but no warning =).
  
  Clear d.id       , 0, Len( String )
  Clear d.spawns_id, 0, Len( String )
  Clear d.to_map   , 0, Len( String )

  d.id = s.id
  d.spawns_id = s.spawns_id
  d.to_map = s.to_map
  
  Assert( diffAddress( id ) )
  Assert( diffAddress( spawns_id ) )
  Assert( diffAddress( to_map ) )

End Sub


Private Sub LLSystem_ObjectInitialCopy( d As _char_type, s As _char_type )


  Dim As Integer x_origin, y_origin, direction, chap, seq_here, ori_dir
  
  Dim As Integer spawn_cond
  
  Dim As sequence_type Ptr seq
  
  Dim As LLObject_ConditionalSpawn Ptr spawn_info
  

  x_origin = d.x_origin
  y_origin = d.y_origin
  direction = d.direction
  
  chap = d.chap
  
  seq_here = d.seq_here
  seq = d.seq
  
  spawn_cond = d.spawn_cond
  spawn_info = d.spawn_info
  
  ori_dir = d.ori_dir
  

  LLSystem_ObjectShallowCopy( d, s )


  d.x_origin = x_origin
  d.y_origin = y_origin
  d.direction = direction
  
  d.coords.x = x_origin
  d.coords.y = y_origin
  
  d.chap = chap
  
  d.seq_here = seq_here
  d.seq = seq
  
  d.spawn_cond = spawn_cond
  d.spawn_info = spawn_info
  
  d.ori_dir = ori_dir


End Sub


Sub LLSystem_ObjectDeepCopy( d As _char_type, s As _char_type )

  
' id as string  
' spawns_id as string  
' to_map as string
  
  Dim As Integer i, j, k
  
  #Define copy_Pointer(pnt,sz,elem)                 _
                                                    _
    If s.##pnt <> 0 Then                           :_
      d.##pnt = CAllocate( sz * Len( elem ) )      :_
      MemCpy( d.##pnt, s.##pnt, sz * Len( elem ) ) :_
                                                   :_
    End If                                                   
    
  #Define dbg_PrintSidebyside(x) ? d.##x, s.##x
  
  
  LLSystem_ObjectInitialCopy( d, s )
  
  copy_Pointer( sound, s.sounds, Integer )
  Assert( diffAlloc( sound ) )
  
  copy_Pointer( vol,   s.sounds, Integer )
  Assert( diffAlloc( vol ) )

  copy_Pointer( funcs.func_count,   s.funcs.states, Integer )
  Assert( diffAlloc( funcs.func_count ) )

  copy_Pointer( funcs.current_func, s.funcs.states, Integer )
  Assert( diffAlloc( funcs.current_func ) )
  
  d.funcs.func = CAllocate( s.funcs.states * Len( fp Ptr ) )
  
  For i = 0 To s.funcs.states - 1
    copy_Pointer( funcs.func[i], s.funcs.func_count[i], fp )  
    Assert( diffAlloc( funcs.func[i] ) )
  
  Next
   
  copy_Pointer( anim, s.anims, LLSystem_ImageHeader Ptr )
  Assert( diffAlloc( anim ) )

  copy_Pointer( animControl, s.anims, LLObject_ImageHeader )
  Assert( diffAlloc( animControl ) )
  
  If s.projectile Then
    
    copy_Pointer( projectile, 1, ll_entity_projectile )
    Assert( diffAlloc( projectile ) )

    copy_Pointer( projectile->coords, s.projectile->projectiles, vector )
    Assert( diffAlloc( projectile->coords ) )
    
  End If

  For i = 0 To s.anims - 1
    
    copy_Pointer( animControl[i].frame, s.anim[i]->frames, LLObject_FrameControl )
    Assert( diffAlloc( animControl[i].frame ) )
    
    For j = 0 To s.anim[i]->frames - 1
      
      If s.animControl[i].frame[j].concurrents > 0 Then
        copy_Pointer( animControl[i].frame[j].concurrent, s.animControl[i].frame[j].concurrents, LLObject_FrameConcurrent )
        Assert( diffAlloc( animControl[i].frame[j].concurrent ) )
        
        ''
        For k = 0 To s.animControl[i].frame[j].concurrents - 1

          With s.animControl[i].frame[j].concurrent[k]
          
            LLSystem_CopyNewObject( *.char )
          
          End With
        
        Next 
        
      End If
        
    Next
    
  Next
        

  d.drop = CAllocate( Len( _char_type ) )
  d.drop->anims = 3

  d.drop->anim = CAllocate( d.drop->anims * Len( LLSystem_ImageHeader Ptr ) )

  d.drop->anim[0] = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\helth.spr"  ) )
  d.drop->anim[1] = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\gold.spr"   ) )
  d.drop->anim[2] = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\silver.spr" ) )
  
  d.direction = d.ori_dir

  
  #IfNDef LL_Minimal

    If d.unique_id = u_angerfireball Then
      __anger_fireball_lock( Varptr( d ) )
      
    End If
    
    If d.unique_id = u_cell Then
      d.direction = int( rnd * 4 ) + 4
      
    End If
    
  #EndIf


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
  



Private Function LLSystem_ObjectGUARD( arg As LLS_OBJ_HANDSHAKES, carrier As Any Ptr = 0, stringSafety as string = "" ) As _char_type Ptr
  
  Static As _char_type Ptr obj_Atom
  Static As Integer objs 

  Dim As String Ptr objName = carrier
  Dim As Integer i
  Dim As uInteger objIndex = CInt( carrier )
  
  
  Select Case arg

    Case LLS_OBJ_ADDRESOURCE
      objs += 1
      
      obj_Atom = Reallocate( obj_Atom, objs * Len( char_type ) )
      MemSet( Varptr( obj_Atom[objs - 1] ), 0, Len( char_type ) )
      
      
      LLSystem_ObjectShallowCopy( obj_Atom[objs - 1], *CPtr( _char_type Ptr, carrier ) )
      
      
    Case LLS_OBJ_GIVENAME
    
      
      dim as string handShake = stringSafety 
      #ifdef __fb_linux__
        handShake = SlashSwitch( handShake )
      #endif
      
      For i = 0 To objs - 1
        
        If Trim( UCase( obj_Atom[i].id ) ) = Trim( UCase( handShake ) ) Then
          Return CPtr( Any Ptr, i )
          
        End If
      
      Next
    

    Case LLS_OBJ_GIVEINDEX
    
    
      If objIndex < objs Then  
    
        Return Varptr( obj_Atom[objIndex] )
        
      End If
      

    Case LLS_OBJ_CLOSE
      
      For i = 0 To objs - 1
        LLSystem_ObjectRelease     ( obj_Atom[i] )
        LLSystem_ClearObjectStrings( obj_Atom[i] )
        
      Next
      
      clean_Deallocate( obj_Atom )
    
  End Select
  

End Function

Sub LLSystem_ClearObjectStrings( objectClear As _char_type )

  objectClear.id        = ""
  objectClear.spawns_id = ""
  objectClear.to_map    = ""

End Sub

Private Function LLSystem_AddObjectToReserve( fileName As String ) As Integer


  Dim As _char_type objectSkeleton 
  
  objectSkeleton.id = fileName

  If LLSystem_ObjectLoad( objectSkeleton ) = 0 Then

    LLSystem_ClearObjectStrings( objectSkeleton )

    #IfDef LL_OBJECTLOADPROGRESS
      LLSystem_Log( "XML Extraction failed! Aborting.", "objectload.txt" )
      
    #EndIf
    
    quick_text( "XML Extraction failed on: " & filename )
    End
    
  End If

  LLSystem_ObjectGUARD( LLS_OBJ_ADDRESOURCE, Varptr( objectSkeleton ) )
  LLSystem_ClearObjectStrings( objectSkeleton )
  
  Return -1


End Function


Private Function LLSystem_CollectEnemyFiles( pth As String ) As list_type Ptr


  Dim As list_type Ptr EnemyFiles
  Dim As Integer i

  EnemyFiles = list_files( pth, "*.xml" )

  Return EnemyFiles


End Function


Private Sub LLSystem_CacheObjectFilesEx( l As list_type Ptr )


  #IfDef LL_OBJECTLOADPROGRESS
    LLSystem_Log( "Adding: " & l->dat.s, "objectload.txt" )
    
  #EndIf

  If LLSystem_AddObjectToReserve( l->dat.s ) = 0 Then
    #IfDef LL_OBJECTLOADPROGRESS
      LLSystem_Log( "Adding " & l->dat.s & "failed! Aborting.", "objectload.txt" )
      
    #EndIf
    quick_text( "Problem adding object to reserve: " & l->dat.s  )
    End
    
  End If

  #IfDef LL_OBJECTLOADPROGRESS
    LLSystem_Log( "Add Successful.", "objectload.txt" )
    LLSystem_Log( "", "objectload.txt" )
    
  #EndIf

End Sub


Sub LLSystem_CacheObjectFiles( pth As String )

  Dim As list_type Ptr objFiles

  #IfDef LL_OBJECTLOADPROGRESS
    LLSystem_Log( "Starting object caching operation.", "objectload.txt" )
    
  #EndIf

  objFiles = LLSystem_CollectEnemyFiles( pth )


  #IfDef LL_OBJECTLOADPROGRESS
    LLSystem_Log( "Files collected.", "objectload.txt" )
    
  #EndIf

  #IfDef LL_OBJECTLOADPROGRESS
    LLSystem_Log( "Iterating through files.", "objectload.txt" )
    LLSystem_Log( "", "objectload.txt" )
    
  #EndIf


  iterate_through_list( objfiles, ProcPtr( LLSystem_CacheObjectFilesEx ) )

  list_Destroy( objFiles, list_strlist )

  #IfDef LL_OBJECTLOADPROGRESS
    LLSystem_Log( "File list destroyed.", "objectload.txt" )
    
  #EndIf
  


End Sub


Function LLSystem_ObjectDeref( index As Integer ) As _char_type Ptr


  Return LLSystem_ObjectGUARD( LLS_OBJ_GIVEINDEX, CPtr( Any Ptr, index ) )


End Function 


Function LLSystem_ObjectDerefName( index As String ) As LLSystem_ObjectHandle

  Return Cast( LLSystem_ObjectHandle, LLSystem_ObjectGUARD( LLS_OBJ_GIVENAME, , index ) )


End Function 


Sub LLSystem_CopyNewObject( objectCopy As char_type )
  
  LLSystem_ObjectDeepCopy( objectCopy, *LLSystem_ObjectDeref( LLSystem_ObjectDerefName( objectCopy.id ) ) )
  

End Sub


Sub LLSystem_ClearObjectCache()

  LLSystem_ObjectGUARD( LLS_OBJ_CLOSE )


End Sub


'LLSystem_CacheObjectFiles( "..\..\data\object\" )
'
'
'LLSystem_ClearCache()
