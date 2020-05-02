Option Explicit


#Include "..\headers\utility.bi"
#Include "..\headers\ll\headers.bi"
#Include "..\headers\ll\object_control.bi"
#Include "..\headers\ll\gfx.bi"

Screen 19, , 2, 1
Width 100, 75

  Dim Shared As ll_system ll_global
  Dim Shared As zString Ptr CONVERT_LIST( 90 ) => { _ 
                                                    _ 
    @"lynn", _
    @"roamer", _
    @"salamander", _
    @"gcopter", _
    @"gbandit", _
    @"leech", _
    @"nightg", _
    @"beetle", _
    @"blackg", _
    @"bat", _
    @"globe", _
    @"rcopter", _
    @"mole", _
    @"launcher", _
    @"tguard", _
    @"fbug", _
    @"ibug", _
    @"wbug", _
    @"poltergeist", _
    @"istrider", _
    @"abug", _
    @"vguard", _
    @"cell", _
    @"bguard", _
    @"eguard", _
    @"cguard", _
    @"kambot", _
    @"mech", _
    @"sludge", _
    @"spawn", _
    @"statue", _
    @"auto", _
    @"grolle", _
    @"haywire", _
    @"floorgun", _
    @"pushrock", _
    @"raylynn", _
    @"squirrel", _
    @"null", _
    @"gull", _
    @"raynpc", _
    @"raycrate", _
    @"menu", _
    @"bush", _
    @"coldrock", _
    @"hotrock", _
    @"greyrock", _
    @"bombrock", _
    @"torch", _
    @"ghut", _
    @"static", _
    @"grult", _
    @"gtorch", _
    @"ltorch", _
    @"savepoint", _
    @"rupert", _
    @"npc1", _
    @"npc2", _
    @"npc3", _
    @"portalw", _
    @"richard", _
    @"npcf1", _
    @"npcf2", _
    @"npcf3", _
    @"towntrig", _
    @"chest", _
    @"bluechest", _
    @"keydoor", _
    @"fkeydoor", _
    @"button", _
    @"bluechestitem", _
    @"bardoor", _
    @"sapling", _
    @"seedfloat", _
    @"gold", _
    @"beaminvis", _
    @"batdoor", _
    @"pglobe", _
    @"enviro", _
    @"worker", _
    @"consign", _
    @"barricade", _
    @"crate", _
    @"crate_health", _
    @"invis_damage", _
    @"sparkle", _
    @"bshape", _
    @"walllaser", _
    @"gshape", _
    @"charger", _
    @"gbutton"_
  }

      
      Sub change_map_picture_paths( l As list_type Ptr )
        
        Dim As String this_filename = l->dat.s, chop_filename
        
        
        llg( map ) = load_map( this_filename, -1 )
        ? llg( map )->tileset.filename
        
        chop_filename = Right( llg( map )->tileset.filename, Len( llg( map )->tileset.filename ) - 4 ) 
        chop_filename = "data\pictures" & chop_filename
        llg( map )->tileset.filename = chop_filename
        
        
        Dim As Integer i
        For i = 0 To llg( map )->rooms - 1
          If llg( map )->room[i].parallax <> 0 Then
          
            chop_filename = Right( llg( map )->room[i].para_img.filename, Len( llg( map )->room[i].para_img.filename ) - Len( "pics" ) ) 
            chop_filename = "data\pictures" & chop_filename
            llg( map )->room[i].para_img.filename = chop_filename
            
            
          End If
          
        Next
        
        save_map( this_filename, llg( map ) )
      
        destroy_map( llg( map ) )
        llg( map ) = 0
        
        
      End Sub

  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
        
      Sub change_map_enemy_paths( l As list_type Ptr )
        
        Dim As String this_filename = l->dat.s, chop_filename
        
        
        llg( map ) = load_map( this_filename, -1 )
        
        
        Dim As Integer i, j
        For i = 0 To llg( map )->rooms - 1
        
          For j = 0 To llg( map )->room[i].enemies - 1


            chop_filename = Right( llg( map )->room[i].enemy[j].id, Len( llg( map )->room[i].enemy[j].id ) - Len( "modules\object\xmls" ) ) 
            chop_filename = "data\object" & chop_filename                                             
            llg( map )->room[i].enemy[j].id = chop_filename
            
          Next

        Next
        save_map( this_filename, llg( map ) )
      
        destroy_map( llg( map ) )
        llg( map ) = 0
        
        
      End Sub
        
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''






#UnDef load_map
      Function load_map ( filename As String ) As map_type Ptr
        
        #IfNDef bypass_errors
          Dim As Integer bypass_errors = -1
          
        #EndIf
        Dim As map_type Ptr lmap = c_alloc( llg( f_mem ), Len ( map_type ) ) 
          
        Dim As Integer _ 
          loop_rooms, _ 
          loop_enemies, _ 
          loop_teleports, _ 
          get_n_cpy, _
          file_shrink, _ 
          loop_entries, _ 
          loop_ents, _ 
          loop_commands, _ 
          loop_command_ents, _ 
          o = FreeFile
      
        If Dir ( filename ) = "" Then 
        
          If bypass_errors = 0 Then
            engine_end( map_doesnt_exist, filename )
            
          Else
            Return 0
            
          End If
          
        End If
          
        
        Open filename For Binary As #o
      
          If Lof(o) = 0 Then 
          
            If bypass_errors = 0 Then
              engine_end( map_file_empty, filename )
              
            Else
            
              Return 0
              
            End If
            
          End If
      
            
          '' map->filename
          lmap->filename = load_h_string( o )
          
          
          Get #o, , lmap->entries
          If lmap->entries = 0 Then 
            If bypass_errors = 0 Then
              engine_end( map_has_no_entries, filename )
              
            End If
          End If
            

          lmap->entry = c_alloc( lmap->manage_mem, ( 1 + lmap->entries ) * Len ( map_entry_type ) )
      
      
          ''  map->rooms
          Get #o, , lmap->rooms
          
          If lmap->rooms = 0 Then 
            If bypass_errors = 0 Then
              engine_end( map_has_no_rooms, filename )
              
            End If
            
          End If
      
      
          ''  map->tileset.filename
          lmap->tileset.filename = load_h_string( o )
      
          ''  map->room []
          lmap->room = c_alloc( lmap->manage_mem, ( 1 + lmap->rooms ) * Len ( room_type ) )   
          
      
          For loop_rooms = 0 To lmap->rooms- 1
          
            With lmap->room[loop_rooms]
      
              Get #o, , .x
              Get #o, , .y
              Get #o, , .parallax
              
        
              If .parallax <> 0 Then 
      
                ''  map->tileset.filename
                .para_img.filename = load_h_string( o )
                If .para_img.filename <> "" Then
                  load_image( .para_img, bypass_errors )
                  
                End If
      
              End If
        
        
      
              Get #o, , .dark
        
              Get #o, , .teleports
              Get #o, , .song
              Get #o, , .reserved() 
        
                          
              .teleport = c_alloc( .manage_mem, Len ( teleport_type ) * ( .teleports + 1 ) )
        
      
      
      
              For loop_teleports = 0 To .teleports - 1 
                Get #o, , .teleport[loop_teleports]
      
                
              Next

              
              Get #o, , .seq_here
              '' get seq 
      
              load_seq( o, _ 
                        .seq_here, _ 
                        .seq, _ 
                        lmap->manage_mem )
        
        
        
              Get #o, , .enemies
      
        
              .enemy = c_alloc( .manage_mem, ( 1 + .enemies ) * Len ( char_type ) )
      
      
      
              For loop_enemies = 0 To .enemies - 1 
      
      
                With .enemy[loop_enemies] 
      
      
                  Get #o, , .x_origin
                  Get #o, , .y_origin

                  Dim As Integer i
                  i = 0      
                  
                  Get #o, , i
                  .id = ""
                  .id = "data\object\" 
                  .id += *convert_list( i ) 
                  .id += ".xml"
      
      
                  
                  Get #o, , .direction
                  Get #o, , .seq_here
                  Get #o, , .spawn_h
                  Get #o, , .is_h_set
                  Get #o, , .chap
                  Get #o, , .reserved_3
                  Get #o, , .reserved_4
                  Get #o, , .reserved_5
      
                  
                  '' get seq
                  If .seq_here < 512 Then
                  
                    load_seq( o, _ 
                              .seq_here, _ 
                              .seq, _ 
                              lmap->manage_mem )
                              
                  End If
                  
          
          
                  .x = .x_origin
                  .y = .y_origin
                  .ori_dir = .direction
                  
                End With
        
              Next
                                                                                                                          
              .layout = c_alloc( .manage_mem, ( 4 ) * Len ( Integer Ptr ) )
              
              Dim As Integer room_elem = ( _ 
                                           .x * ( .y + 1 ) + 1 _ 
                                         )
           
                                       
                                       
              Redim As uShort quickbuf ( room_elem )
        
              For get_n_cpy = 0 To 2
        
                .layout[get_n_cpy] = c_alloc( .manage_mem, ( UBound ( quickbuf ) + 1 ) * Len ( Integer ) )
          
                Get #o, , quickbuf ()
      
      '          memcpy( @.layout[get_n_cpy][0], @quickbuf( 0 ), ( UBound ( quickbuf ) + 1 ) * Len ( Integer ) )
        
                For file_shrink = 0 To ( room_elem )
                  .layout[get_n_cpy][file_shrink] = quickbuf( file_shrink )
                
                Next     
          
              Next
        
           
            End With
        
          Next
      
      
          For loop_entries = 0 To lmap->entries - 1 
            
            With lmap->entry[loop_entries]
            
              Get #o, , .x
              Get #o, , .y
              Get #o, , .room
              Get #o, , .direction
              Get #o, , .seq_here
        
              Get #o, , .reserved()
        
        
              load_seq( o, _ 
                        .seq_here, _ 
                        .seq, _ 
                        lmap->manage_mem )        
      
            End With
            
          Next
      
      
          For loop_rooms = 0 To lmap->rooms- 1
      
            With lmap->room[loop_rooms]
      
              seq_id( .seq_here, _ 
                      .seq, _ 
                      .enemy )
        
              For loop_enemies = 0 To .enemies - 1 
              
                With .enemy[loop_enemies]
              
                  seq_id( .seq_here, _ 
                          .seq, _ 
                          lmap->room[loop_rooms].enemy )
                          
                End With
                        
              Next
      
            End With
      
          Next
      
          For loop_entries = 0 To lmap->entries - 1 
          
            With lmap->entry[loop_entries]
          
              seq_id( .seq_here, _ 
                      .seq, _ 
                      lmap->room[.room].enemy )
      
            End With      
      
          Next
      
      
        Close
        
        If lmap->tileset.filename = "" Then 
          If bypass_errors = 0 Then
            engine_end( no_map_tileset, filename )
            
          End If
          
        End If
        
        If Dir( ExePath & "\" & lmap->tileset.filename ) = "" Then 
          If bypass_errors = 0 Then
            engine_end( map_tileset_not_found, lmap->filename & ", " & ExePath & "\" & lmap->tileset.filename )
            
          End If
          
        End If
        
        load_image( lmap->tileset, bypass_errors )
        
      
        Return lmap
      
        
      End Function  
  


        

  engine_init()

    
    
  Dim As list_type Ptr map_files
  Dim As Integer re
  Dim As Double t
  

  
    map_files = list_files( "data\map", "*.map" )
    re = open_file_dialog( map_files )
    
    t = Timer

    If re = -1 Then
    
    Else

      llg( map ) = load_map( list_node_value( map_files, re, "" ) )
      save_map( list_node_value( map_files, re, "" ), llg( map ) ) 
      
    End If
      
    
'    iterate_through_list( map_files, @change_map_enemy_paths )
'    iterate_through_list( map_files, @change_map_picture_paths )
  
    destroy( map_files, list_strlist )
    
    t = ( Timer - t )
    
    ? "Operation completed in " & t & " seconds."
    ?
    ? "Press Any Key to Exit."

    handle_refresh()
    Sleep
  


  engine_end( everythings_sweet )

