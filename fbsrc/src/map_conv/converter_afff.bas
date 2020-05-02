Option Explicit


#Include "..\headers\utility.bi"
#Include "..\headers\ll\headers.bi"
#Include "..\headers\ll\object_control.bi"
#Include "..\headers\ll\gfx.bi"

Screen 19, , 2, 1
Width 100, 75

  Dim Shared As ll_system ll_global

  Dim Shared As zString Ptr convert_list( 10 ) => { _
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



  Sub change_map_paths( l As list_type Ptr )

    Dim As String hl = l->dat.s
    ? "Loading " & hl & "... ";
    llg( map ) = load_map( hl ) 
    ? "done"
    ? "Saving " & hl & "... ";
    
    save_map( hl, llg( map ) )
    ? "done"
    
    destroy_map( llg( map ) ) 
    
    
  End Sub
        
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''




  #UnDef load_Seq
  Sub load_seq( ff As Integer, seqs As Integer, s As sequence_type Ptr, de As list_type Ptr, haha As Integer = 0 )
  
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
                  
                      quick_text( .text )
                  
                  
                  
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
  


  #UnDef save_seq
  Sub save_seq( ff As Integer, n As Integer, s As sequence_type Ptr, lols As Integer = 0 )
  
    Dim As Integer grab_seq, loop_code_ents, loop_commands, loop_command_ents
  
    For grab_seq = 0 To n - 1
  
      Put #ff, , s[grab_seq].ents
      
      For loop_code_ents = 0 To s[grab_seq].ents -1
  
        Dim As Integer code
        code = s[grab_seq].ent_code[loop_code_ents]
  
      
        Put #ff, , code
  
        
      Next
  
  
      Put #ff, , s[grab_seq].commands
      
  
      For loop_commands = 0 To s[grab_seq].commands -1
      
        Put #ff, , s[grab_seq].Command[loop_commands].ents
        
        
  
        For loop_command_ents = 0 To s[grab_seq].Command[loop_commands].ents -1
        
          Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].active_ent 
          Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].start_func
  
  
          save_h_string( ff, s[grab_seq].Command[loop_commands].ent[loop_command_ents].text )
  
          Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].walk_speed 
          Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].dest_y  
          Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].dest_x  
          Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].abs_x
          Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].abs_y
          Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].mod_y  
          Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].mod_x  
          save_h_string( ff, s[grab_seq].Command[loop_commands].ent[loop_command_ents].to_map )
'          Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].to_map  
          Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].to_entry 
          Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].jump_count 
          Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].water_align
          Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].chap  
          Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].carries_all
          Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].nocam  
          Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].reserved_1   
          Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].reserved_2   
          Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].reserved_3   
          Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].reserved_4   
          Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].reserved_5   
          Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].reserved_6   
          Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].reserved_7   
          Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].reserved_8   
          Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].reserved_9   
          Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].reserved_10  
          
        Next
        
      Next
      
    Next
  
  
  End Sub
  




  engine_init()

    
    
  Dim As list_type Ptr map_files, work_map
  Dim As Integer re
  Dim As Double t
  

  
    map_files = list_files( "data\map", "*.map" )
    
    t = Timer

    
    iterate_through_list( map_files, @change_map_paths )
  
    t = ( Timer - t )
    
    ? "Operation completed in " & t & " seconds."
    ?
    ? "Press Any Key to Exit."


    destroy( map_files, list_strlist )
    handle_refresh()

    Sleep
  


  engine_end( everythings_sweet )

