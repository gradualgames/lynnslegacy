Option Explicit


#Include "..\headers\utility.bi"
#Include "..\headers\ll\headers.bi"
#Include "..\headers\ll\object_control.bi"
#Include "..\headers\ll\gfx.bi"

Screen 19, , 2, 1
Width 100, 75

  Dim Shared As ll_system ll_global

  Dim Shared As zString Ptr convert_list( 20 ) => { _
    @"", _
    @"desert.map", _
    @"title.map", _
    @"inhouse.map", _
    @"moenia.map", _
    @"interport.map", _
    @"evernight.map", _
    @"ruins.map", _
    @"gelidus.map", _
    @"ignia.map", _
    @"arx.map" }


  #UnDef load_Seq
  Sub load_seq( ff As Integer, seqs As Integer, s As sequence_type Ptr, de As list_type Ptr, hijack As Integer = 0 )
    
    If seqs <> 0 Then
      
      Dim As Integer grab_seq, loop_ents, loop_commands, loop_command_ents
      
      s = c_alloc( de, Len( sequence_type ) * ( seqs + 1 ) )          
      
  
      For grab_seq = 0 To seqs - 1
  
        With s[grab_seq]
      
          Get #ff, , .ents
          
          .ent = c_alloc( de, Len( char_type Ptr ) * ( .ents + 1 ) )  
          .ent_code = c_alloc( de, Len( Integer ) * ( .ents + 1 ) )  
          
          For loop_ents = 0 To .ents - 1
            Get #ff, , .ent_code[loop_ents] 
            
          Next            
             
    
          Get #ff, , .commands
          
          .Command = c_alloc( de, Len( command_type ) * ( .commands + 1 ) )
          
          For loop_commands = 0 To .commands -1
            
            With .Command[loop_commands] 
              
              Get #ff, , .ents
              
              .ent = c_alloc( de, Len( command_data ) * ( .ents + 1 ) )
              
              For loop_command_ents = 0 To .ents -1
   
                With .ent[loop_command_ents]
      
                  Get #ff, , .active_ent 
                  Get #ff, , .start_func
                  .hold_func = .start_func
  
                  .text = load_h_string( ff )      
                  
                  Get #ff, , .walk_speed 
                  Get #ff, , .dest_y
                  Get #ff, , .dest_x
                  Get #ff, , .abs_x
                  Get #ff, , .abs_y
                  Get #ff, , .mod_y  
                  Get #ff, , .mod_x  

                  Dim As Integer mappy
                  Get #ff, , mappy
                  .to_map = *convert_list( mappy )



                  Get #ff, , .to_entry 
                  Get #ff, , .jump_count 
                  Get #ff, , .water_align
                  Get #ff, , .chap  
                  Get #ff, , .carries_all
                  Get #ff, , .nocam  
                  Get #ff, , .modify_direction   
                  Get #ff, , .seq_pause   
                  Get #ff, , .reserved_3   
                  Get #ff, , .reserved_4   
                  Get #ff, , .free_to_move   
                  Get #ff, , .display_hud   
                  Get #ff, , .reserved_7   
                  Get #ff, , .reserved_8   
                  Get #ff, , .reserved_9   
                  Get #ff, , .reserved_10  
                  
'                      quick_text( .start_func )
                  
                  
                End With
            
              Next
            
            End With
          
          Next
          
          If .commands = 0 Then .Command->ent = c_alloc( de, Len( command_data ) )
            
        End With
          
      Next
    
    Else
      s = c_alloc( de, Len( sequence_type ) )          
      s->ent = c_alloc( de, Len( char_type Ptr ) )          
      s->ent_code = c_alloc( de, Len( Integer ) )          
      s->Command = c_alloc( de, Len( command_type ) )          
    
      
    End If
         
         
  End Sub  
  


  #UnDef load_map
  Function load_map ( filename As String, bypass_errors As Integer = 0, hijack As Integer = 0 ) As map_type Ptr
    
    
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
  
              
              .id = load_h_string( o )
              
  
              '' the old way
  '            Get #o, , .id
  '            tmp_id = ""
  '            tmp_id = "modules\object\xmls\" 
  '            tmp_id += *convert_list( .id ) 
  '            tmp_id += ".xml"
  
  
              
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
  
  

  

        
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''



  Sub change_map_paths( l As list_type Ptr )

    Dim As String hl = l->dat.s
    ? "Loading " & hl & "... ";
    llg( map ) = load_map( hl, -1 ) 
    ? "done"
    ? "Saving " & hl & "... ";
    
    save_map( hl, llg( map ) )
    ? "done"
    
    destroy_map( llg( map ) ) 
    
    
  End Sub




  engine_init()

    
    
  Dim As list_type Ptr map_files, work_map
  Dim As Integer re
  Dim As Double t
  

  
    map_files = list_files( "data\map", "*.map" )
    
    re = open_file_dialog( map_files )
    
    If re = -1 Then
      engine_end()
      
    End If
    
    work_map = list_append( work_map, list_node_value( map_files, re, "" ) )
    
    t = Timer

    
    iterate_through_list( work_map, @change_map_paths )
  
    t = ( Timer - t )
    
    ? "Operation completed in " & t & " seconds."
    ?
    ? "Press Any Key to Exit."


    destroy( map_files, list_strlist )
    handle_refresh()

    Sleep
  


  engine_end( everythings_sweet )

