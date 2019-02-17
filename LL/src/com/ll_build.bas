Option Explicit

#Include "..\headers\ll.bi"

'#Define LL_LOGMAPLOADPROGRESS


Sub LLSystem_Log( x As String, f As String = "log.txt" )

  Dim As Integer ff = FreeFile
  Open f For Append As #ff 
  Print #ff, x                     
  Close #ff                        


End Sub
  
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'' # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
''  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'' structure building 
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'' # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
''  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''



      Sub seq_id( seqs As Integer, s As sequence_type Ptr, e As char_type Ptr )
      
        Dim As Integer grab_seq, loop_ents
      
        For grab_seq = 0 To seqs - 1
        
          For loop_ents = 0 To s[grab_seq].ents - 1
            
            If s[grab_seq].ent_code[loop_ents] = -1 Then 
          
              s[grab_seq].ent[loop_ents] = @llg( hero )
              
            Else
            
              s[grab_seq].ent[loop_ents] = @e[s[grab_seq].ent_code[loop_ents]]
              
            End If
      
          Next            
      
        Next
      
      End Sub
      
      
      Sub load_seqV( ff As Integer, seqs As Integer, s As sequence_type Ptr, de As list_type Ptr, t As String, i As Integer )
      
        If seqs <> 0 Then
          
          Dim As Integer grab_seq, loop_ents, loop_commands, loop_command_ents
            
            s = CAllocate( Len( sequence_type ) * ( seqs ) )          
            #IfDef LL_LOGMAPLOADPROGRESS
              
              LLSystem_Log( "Sequence().addy: " & s )
              
            #EndIf
          
          s->seq_type = t
          #IfDef LL_LOGMAPLOADPROGRESS
            
            LLSystem_Log( "Sequence().type: " & t )
            
          #EndIf
          s->seq_index = i
          #IfDef LL_LOGMAPLOADPROGRESS
            
            LLSystem_Log( "Sequence().index: " & i )
            LLSystem_Log( "" )
            
          #EndIf
      
          For grab_seq = 0 To seqs - 1
      
            With s[grab_seq]
          
              VFile_Get ff, , .ents
              #IfDef LL_LOGMAPLOADPROGRESS
                
                LLSystem_Log( "Sequence(" & grab_seq & ").ents: " & .ents )
                LLSystem_Log( "" )
                
              #EndIf
              
              .ent = CAllocate( Len( char_type Ptr ) * ( .ents + 1 ) )  
              .ent_code = CAllocate( Len( Integer ) * ( .ents + 1 ) )  
              
              For loop_ents = 0 To .ents - 1
                VFile_Get ff, , .ent_code[loop_ents] 
                #IfDef LL_LOGMAPLOADPROGRESS
                  
                  LLSystem_Log( "Sequence(" & grab_seq & ").ent_code(" & loop_ents & "): " & .ents )
                  
                #EndIf
                
              Next            
                 
              #IfDef LL_LOGMAPLOADPROGRESS
                
                LLSystem_Log( "" )
                
              #EndIf
        
              VFile_Get ff, , .commands
              #IfDef LL_LOGMAPLOADPROGRESS
                
                LLSystem_Log( "Sequence(" & grab_seq & ").commands: " & .commands )
                LLSystem_Log( "" )
                
              #EndIf
              
              .Command = CAllocate( Len( command_type ) * ( .commands ) )
              
              For loop_commands = 0 To .commands -1
                
                With .Command[loop_commands] 
                  
                  VFile_Get ff, , .ents
                  #IfDef LL_LOGMAPLOADPROGRESS
                    
                    LLSystem_Log( "Sequence(" & grab_seq & ").command(" & loop_commands & ").ents: " & .ents )
                    
                  #EndIf
                  
                  .ent = CAllocate( Len( command_data ) * ( .ents + 1 ) )
                  
                  For loop_command_ents = 0 To .ents -1
       
                    With .ent[loop_command_ents]

          
                      VFile_Get ff, , .active_ent 
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Sequence(" & grab_seq & ").command(" & loop_commands & ").ent(" & loop_command_ents & ").active_ent: " & .active_ent )
                        
                      #EndIf

                      VFile_Get ff, , .ent_state
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Sequence(" & grab_seq & ").command(" & loop_commands & ").ent(" & loop_command_ents & ").ent_state: " & .ent_state )
                        
                      #EndIf

                      .hold_state = .ent_state
      
                      VFile_Get ff, , .text
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Sequence(" & grab_seq & ").command(" & loop_commands & ").ent(" & loop_command_ents & ").text: " & .text )
                        
                      #EndIf
                      
                      
                      VFile_Get ff, , .walk_speed 
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Sequence(" & grab_seq & ").command(" & loop_commands & ").ent(" & loop_command_ents & ").walk_speed: " & .walk_speed )
                        
                      #EndIf


                      VFile_Get ff, , .dest_y
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Sequence(" & grab_seq & ").command(" & loop_commands & ").ent(" & loop_command_ents & ").dest_y: " & .dest_y )
                        
                      #EndIf


                      VFile_Get ff, , .dest_x
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Sequence(" & grab_seq & ").command(" & loop_commands & ").ent(" & loop_command_ents & ").dest_x: " & .dest_x )
                        
                      #EndIf


                      VFile_Get ff, , .abs_x
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Sequence(" & grab_seq & ").command(" & loop_commands & ").ent(" & loop_command_ents & ").abs_x: " & .abs_x )
                        
                      #EndIf


                      VFile_Get ff, , .abs_y
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Sequence(" & grab_seq & ").command(" & loop_commands & ").ent(" & loop_command_ents & ").abs_y: " & .abs_y )
                        
                      #EndIf


                      VFile_Get ff, , .mod_y  
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Sequence(" & grab_seq & ").command(" & loop_commands & ").ent(" & loop_command_ents & ").mod_y: " & .mod_y )
                        
                      #EndIf


                      VFile_Get ff, , .mod_x  
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Sequence(" & grab_seq & ").command(" & loop_commands & ").ent(" & loop_command_ents & ").mod_x: " & .mod_x )
                        
                      #EndIf
      

                      VFile_Get ff, , .to_map
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Sequence(" & grab_seq & ").command(" & loop_commands & ").ent(" & loop_command_ents & ").to_map: " & .to_map )
                        
                      #EndIf

      
                      VFile_Get ff, , .to_entry 
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Sequence(" & grab_seq & ").command(" & loop_commands & ").ent(" & loop_command_ents & ").to_entry: " & .to_entry )
                        
                      #EndIf


                      VFile_Get ff, , .jump_count 
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Sequence(" & grab_seq & ").command(" & loop_commands & ").ent(" & loop_command_ents & ").jump_count: " & .jump_count )
                        
                      #EndIf


                      VFile_Get ff, , .water_align
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Sequence(" & grab_seq & ").command(" & loop_commands & ").ent(" & loop_command_ents & ").water_align: " & .water_align )
                        
                      #EndIf


                      VFile_Get ff, , .chap  
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Sequence(" & grab_seq & ").command(" & loop_commands & ").ent(" & loop_command_ents & ").chap: " & .chap )
                        
                      #EndIf


                      VFile_Get ff, , .carries_all
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Sequence(" & grab_seq & ").command(" & loop_commands & ").ent(" & loop_command_ents & ").carries_all: " & .carries_all )
                        
                      #EndIf


                      VFile_Get ff, , .nocam  
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Sequence(" & grab_seq & ").command(" & loop_commands & ").ent(" & loop_command_ents & ").nocam: " & .nocam )
                        
                      #EndIf


                      VFile_Get ff, , .modify_direction   
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Sequence(" & grab_seq & ").command(" & loop_commands & ").ent(" & loop_command_ents & ").modify_direction: " & .modify_direction )
                        
                      #EndIf


                      VFile_Get ff, , .seq_pause   
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Sequence(" & grab_seq & ").command(" & loop_commands & ").ent(" & loop_command_ents & ").seq_pause: " & .seq_pause )
                        
                      #EndIf


                      VFile_Get ff, , .reserved_3   
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Sequence(" & grab_seq & ").command(" & loop_commands & ").ent(" & loop_command_ents & ").reserved_3: " & .reserved_3 )
                        
                      #EndIf


                      VFile_Get ff, , .reserved_4   
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Sequence(" & grab_seq & ").command(" & loop_commands & ").ent(" & loop_command_ents & ").reserved_4: " & .reserved_4 )
                        
                      #EndIf


                      VFile_Get ff, , .free_to_move   
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Sequence(" & grab_seq & ").command(" & loop_commands & ").ent(" & loop_command_ents & ").free_to_move: " & .free_to_move )
                        
                      #EndIf


                      VFile_Get ff, , .display_hud   
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Sequence(" & grab_seq & ").command(" & loop_commands & ").ent(" & loop_command_ents & ").display_hud: " & .display_hud )
                        
                      #EndIf


                      VFile_Get ff, , .fadeTime   
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Sequence(" & grab_seq & ").command(" & loop_commands & ").ent(" & loop_command_ents & ").fadeTime: " & .fadeTime )
                        
                      #EndIf


'                      VFile_Get ff, , .reserved_7   
'                      #IfDef LL_LOGMAPLOADPROGRESS
'                        
'                        LLSystem_Log( "Sequence(" & grab_seq & ").command(" & loop_commands & ").ent(" & loop_command_ents & ").reserved_7: " & .reserved_7 )
'                        
'                      #EndIf
'
'
'                      VFile_Get ff, , .reserved_8   
'                      #IfDef LL_LOGMAPLOADPROGRESS
'                        
'                        LLSystem_Log( "Sequence(" & grab_seq & ").command(" & loop_commands & ").ent(" & loop_command_ents & ").reserved_8: " & .reserved_8 )
'                        
'                      #EndIf


                      VFile_Get ff, , .reserved_9   
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Sequence(" & grab_seq & ").command(" & loop_commands & ").ent(" & loop_command_ents & ").reserved_9: " & .reserved_9 )
                        
                      #EndIf


                      VFile_Get ff, , .reserved_10  
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Sequence(" & grab_seq & ").command(" & loop_commands & ").ent(" & loop_command_ents & ").reserved_10: " & .reserved_10 )
                        LLSystem_Log( "" )
                        
                      #EndIf
                      
                      
                    End With
                
                  Next
                
                End With
              
              Next
                
            End With
              
          Next
        Else

          #IfDef __gmap__

            s = CAllocate( Len( sequence_type ) )
            s->ent = CAllocate( Len( char_type Ptr ) )           
            s->ent_code = CAllocate( Len( Integer ) )           
            s->Command = CAllocate( Len( command_type ) )           
            
          #EndIf
                
        
          
        End If

             
             
      End Sub  
      
      
      
      Sub LLSystem_LoadMiniMap( map_Active As map_type Ptr, minimap_Filename As String )
        
        Dim As Integer i, ff = FreeFile
        llg( minimap ).room = CAllocate( map_Active->rooms * Len( LL_MiniMapRoomType ) )
        
        
        
        If Dir( minimap_Filename ) = "" Then
          quick_text( "MiniMap file definition not found. (" & minimap_Filename & ")" )   
          
        End If
        
        Open minimap_Filename For Binary As ff
         
          For i = 0 To map_Active->rooms - 1
            
            With llg( minimap ).room[i]

              Get #ff, , .location.x
              Get #ff, , .location.y
              Get #ff, , .floor
              
            End With
            
          Next
          
        Close ff
           
        
      
      
      End Sub
      
      
      Function load_mapV( buffer() As uByte, bypass_errors As Integer = 0 ) As map_type Ptr
      
        Dim As map_type Ptr lmap = CAllocate( Len ( map_type ) ) 
          
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
          o = VFile_FreeFile, ff = FreeFile, res, loop_spawns
      
        
        Dim As String paraFilename, tileFilename
        
        VFile_Open( buffer(), o )
        
          If VFile_LOF( o ) = 0 Then 
          
            If bypass_errors = 0 Then
'              engine_end( map_file_empty, "" )
              
            Else
            
              Return 0
              
            End If
            
          End If
      
            
          '' map->filename
          VFile_Get o, , lmap->filename 
          #IfDef LL_LOGMAPLOADPROGRESS
            
            LLSystem_Log( "Filename: " & lmap->filename )
            
          #EndIf
          
          If Instr( lmap->filename, "moenia" ) <> 0 Then
            lmap->isDungeon = -1
            llg( dungeonName ) = "Moenia"
            
          End If
          
          If Instr( lmap->filename, "gelidus" ) <> 0 Then
            lmap->isDungeon = -1
            llg( dungeonName ) = "Gelidus"
            
          End If
          
          If Instr( lmap->filename, "icefield" ) <> 0 Then
            lmap->isDungeon = -1
            llg( dungeonName ) = "Ice Field"
            
          End If
          
          If Instr( lmap->filename, "ignia" ) <> 0 Then
            lmap->isDungeon = -1
            llg( dungeonName ) = "Ignia"
            
          End If
          
          If Instr( lmap->filename, "arx" ) <> 0 Then
            lmap->isDungeon = -1
            llg( dungeonName ) = "Arx"
            
          End If
          
          If Instr( lmap->filename, "nerme" ) <> 0 Then
            lmap->isDungeon = -1  
            llg( dungeonName ) = "Nerme"
            
          End If
          
          If Instr( lmap->filename, "divius" ) <> 0 Then
            lmap->isDungeon = -1
            llg( dungeonName ) = "Divius"
            
          End If
          
          '' add checks for all dungeons here
           

          VFile_Get o, , lmap->entries
          #IfDef LL_LOGMAPLOADPROGRESS
            
            LLSystem_Log( "Entries: " & lmap->entries )
            
          #EndIf
      
          
          If lmap->entries = 0 Then 
            If bypass_errors = 0 Then
'              engine_end( map_has_no_entries, "" )
              
            End If
          End If
            
      
          lmap->entry = CAllocate( ( 1 + lmap->entries ) * Len ( map_entry_type ) )
      
      
          ''  map->rooms
          VFile_Get o, , lmap->rooms
          #IfDef LL_LOGMAPLOADPROGRESS
            
            LLSystem_Log( "Rooms: " & lmap->rooms )
            
          #EndIf


          
          If lmap->rooms = 0 Then 
            If bypass_errors = 0 Then
'              engine_end( map_has_no_rooms, "" )
              
            End If
            
          End If
      
      
          ''  map->tileset.filename
          VFile_Get o, , tileFilename
          #IfDef LL_LOGMAPLOADPROGRESS
            
            LLSystem_Log( "Tileset Filename: " & tileFilename )
            LLSystem_Log( "" )
            
          #EndIf
      
          ''  map->room []
          lmap->room = CAllocate( ( 1 + lmap->rooms ) * Len ( room_type ) )   
          
      
          For loop_rooms = 0 To lmap->rooms- 1
          
            With lmap->room[loop_rooms]
      
              VFile_Get o, , .x
              #IfDef LL_LOGMAPLOADPROGRESS
                
                LLSystem_Log( "Room(" & loop_rooms & ").x: " & .x )
                
              #EndIf

              VFile_Get o, , .y
              #IfDef LL_LOGMAPLOADPROGRESS
                
                LLSystem_Log( "Room(" & loop_rooms & ").y: " & .y )
                
              #EndIf

              VFile_Get o, , .parallax
              #IfDef LL_LOGMAPLOADPROGRESS
                
                LLSystem_Log( "Room(" & loop_rooms & ").parallax: " & .parallax )
                
              #EndIf
              
        
              If .parallax Then 
      
                ''  map->tileset.filename
                VFile_Get o, , paraFilename
                If paraFilename <> "" Then
                  
                  .para_img = LLSystem_ImageDeref( LLSystem_ImageDerefName( paraFilename ) )
                    
                End If
      
              End If
        
        
      
              VFile_Get o, , .dark
              #IfDef LL_LOGMAPLOADPROGRESS
                
                LLSystem_Log( "Room(" & loop_rooms & ").dark: " & .dark )
                
              #EndIf


              VFile_Get o, , .teleports
              #IfDef LL_LOGMAPLOADPROGRESS
                
                LLSystem_Log( "Room(" & loop_rooms & ").teleports: " & .teleports )
                
              #EndIf


              VFile_Get o, , .song
              #IfDef LL_LOGMAPLOADPROGRESS
                
                LLSystem_Log( "Room(" & loop_rooms & ").song: " & .song )
                
              #EndIf

      
              VFile_Get o, , .song_changes
              #IfDef LL_LOGMAPLOADPROGRESS
                
                LLSystem_Log( "Room(" & loop_rooms & ").song_changes: " & .song_changes )
                
              #EndIf

      
              VFile_Get o, , .changes_to
              #IfDef LL_LOGMAPLOADPROGRESS
                
                LLSystem_Log( "Room(" & loop_rooms & ").changes_to: " & .changes_to )
                
              #EndIf

      

      
              VFile_Get o, , VF_Array( .reserved )
              #IfDef LL_LOGMAPLOADPROGRESS
                
                LLSystem_Log( "Room(" & loop_rooms & ").reserved(): read" )
                LLSystem_Log( "" )
                
              #EndIf
        
                          
              .teleport = CAllocate( Len ( teleport_type ) * ( .teleports + 1 ) )
        
      
              For loop_teleports = 0 To .teleports - 1 
              
                With .teleport[loop_teleports]

                    
                  VFile_Get o, , .x
                  #IfDef LL_LOGMAPLOADPROGRESS
                    
                    LLSystem_Log( "Room(" & loop_rooms & ").teleport(" & loop_teleports & ").x: " & .x )
                    
                  #EndIf


                  VFile_Get o, , .y
                  #IfDef LL_LOGMAPLOADPROGRESS
                    
                    LLSystem_Log( "Room(" & loop_rooms & ").teleport(" & loop_teleports & ").y: " & .y )
                    
                  #EndIf


                  VFile_Get o, , .w
                  #IfDef LL_LOGMAPLOADPROGRESS
                    
                    LLSystem_Log( "Room(" & loop_rooms & ").teleport(" & loop_teleports & ").w: " & .w )
                    
                  #EndIf


                  VFile_Get o, , .h
                  #IfDef LL_LOGMAPLOADPROGRESS
                    
                    LLSystem_Log( "Room(" & loop_rooms & ").teleport(" & loop_teleports & ").h: " & .h )
                    
                  #EndIf


                  VFile_Get o, , .to_room 
                  #IfDef LL_LOGMAPLOADPROGRESS
                    
                    LLSystem_Log( "Room(" & loop_rooms & ").teleport(" & loop_teleports & ").to_room: " & .to_room )
                    
                  #EndIf

                  
                  VFile_Get o, , .to_map
                  #IfDef LL_LOGMAPLOADPROGRESS
                    
                    LLSystem_Log( "Room(" & loop_rooms & ").teleport(" & loop_teleports & ").to_map: " & .to_map )
                    
                  #EndIf

                  
                  VFile_Get o, , .dx
                  #IfDef LL_LOGMAPLOADPROGRESS
                    
                    LLSystem_Log( "Room(" & loop_rooms & ").teleport(" & loop_teleports & ").dx: " & .dx )
                    
                  #EndIf


                  VFile_Get o, , .dy
                  #IfDef LL_LOGMAPLOADPROGRESS
                    
                    LLSystem_Log( "Room(" & loop_rooms & ").teleport(" & loop_teleports & ").dy: " & .dy )
                    
                  #EndIf


                  VFile_Get o, , .dd
                  #IfDef LL_LOGMAPLOADPROGRESS
                    
                    LLSystem_Log( "Room(" & loop_rooms & ").teleport(" & loop_teleports & ").dd: " & .dd )
                    
                  #EndIf


                  VFile_Get o, , .to_song
                  #IfDef LL_LOGMAPLOADPROGRESS
                    
                    LLSystem_Log( "Room(" & loop_rooms & ").teleport(" & loop_teleports & ").to_song: " & .to_song )
                    
                  #EndIf


                  VFile_Get o, , VF_Array( .reserved )
                  #IfDef LL_LOGMAPLOADPROGRESS
                    
                    LLSystem_Log( "Room(" & loop_rooms & ").teleport(" & loop_teleports & ").reserved: read" )
                    LLSystem_Log( "" )
                    
                  #EndIf
                  
                  
                End With
      
                
              Next
      
              
              VFile_Get o, , .seq_here
              #IfDef LL_LOGMAPLOADPROGRESS
                
                LLSystem_Log( "Room(" & loop_rooms & ").seq_here: " & .seq_here )
                LLSystem_Log( "" )
                
              #EndIf
              '' get seq
              
              load_seqV( o, _ 
                         .seq_here, _ 
                         .seq, _ 
                         lmap->manage_mem, _
                         "room", _ 
                         loop_rooms )
        
        
        
              VFile_Get o, , .enemies
              #IfDef LL_LOGMAPLOADPROGRESS
                
                LLSystem_Log( "Room(" & loop_rooms & ").enemies: " & .enemies )
                
              #EndIf
      
              #IfDef __gmap__
                .enemy = CAllocate( ( .enemies + 1 ) * Len ( char_type ) )
                
              #Else
                .enemy = CAllocate( ( .enemies ) * Len ( char_type ) )
                
              #EndIf
      
      
      
              For loop_enemies = 0 To .enemies - 1 
      
      
                With .enemy[loop_enemies] 
      
      
                  VFile_Get o, , .x_origin
                  #IfDef LL_LOGMAPLOADPROGRESS
                    
                    LLSystem_Log( "Room(" & loop_rooms & ").enemy(" & loop_enemies & ").x_origin: " & .x_origin )
                    
                  #EndIf


                  VFile_Get o, , .y_origin
                  #IfDef LL_LOGMAPLOADPROGRESS
                    
                    LLSystem_Log( "Room(" & loop_rooms & ").enemy(" & loop_enemies & ").y_origin: " & .y_origin )
                    
                  #EndIf
      
                  
                  VFile_Get o, , .id
                  #IfDef LL_LOGMAPLOADPROGRESS
                    
                    LLSystem_Log( "Room(" & loop_rooms & ").enemy(" & loop_enemies & ").id: " & .id )
                    
                  #EndIf
                  
                  
                  VFile_Get o, , .direction
                  #IfDef LL_LOGMAPLOADPROGRESS
                    
                    LLSystem_Log( "Room(" & loop_rooms & ").enemy(" & loop_enemies & ").direction: " & .direction )
                    
                  #EndIf


                  VFile_Get o, , .seq_here
                  #IfDef LL_LOGMAPLOADPROGRESS
                    
                    LLSystem_Log( "Room(" & loop_rooms & ").enemy(" & loop_enemies & ").seq_here: " & .seq_here )
                    
                  #EndIf


                  VFile_Get o, , .spawn_h
                  #IfDef LL_LOGMAPLOADPROGRESS
                    
                    LLSystem_Log( "Room(" & loop_rooms & ").enemy(" & loop_enemies & ").spawn_h: " & .spawn_h )
                    
                  #EndIf


                  VFile_Get o, , .is_h_set
                  #IfDef LL_LOGMAPLOADPROGRESS
                    
                    LLSystem_Log( "Room(" & loop_rooms & ").enemy(" & loop_enemies & ").is_h_set: " & .is_h_set )
                    
                  #EndIf


                  VFile_Get o, , .chap
                  #IfDef LL_LOGMAPLOADPROGRESS
                    
                    LLSystem_Log( "Room(" & loop_rooms & ").enemy(" & loop_enemies & ").chap: " & .chap )
                    
                  #EndIf


                  VFile_Get o, , .spawn_d
                  #IfDef LL_LOGMAPLOADPROGRESS
                    
                    LLSystem_Log( "Room(" & loop_rooms & ").enemy(" & loop_enemies & ").spawn_d: " & .spawn_d )
                    
                  #EndIf


                  VFile_Get o, , .is_d_set
                  #IfDef LL_LOGMAPLOADPROGRESS
                    
                    LLSystem_Log( "Room(" & loop_rooms & ").enemy(" & loop_enemies & ").is_d_set: " & .is_d_set )
                    
                  #EndIf


                  VFile_Get o, , .reserved_5
                  #IfDef LL_LOGMAPLOADPROGRESS
                    
                    LLSystem_Log( "Room(" & loop_rooms & ").enemy(" & loop_enemies & ").reserved_5: " & .reserved_5 )
                    LLSystem_Log( "" )
                    
                  #EndIf
      
                  
                  '' get seq
'                  If .seq_here < 512 Then
                  
                    load_seqV( o, _ 
                               .seq_here, _ 
                               .seq, _ 
                               lmap->manage_mem, _
                               "enemy", _
                               loop_enemies )
                              
'                  End If


                  VFile_Get o, , .spawn_cond
                  #IfDef LL_LOGMAPLOADPROGRESS
                    
                    LLSystem_Log( "Room(" & loop_rooms & ").enemy(" & loop_enemies & ").spawn_cond: " & .spawn_cond )
                    LLSystem_Log( "" )
                    
                  #EndIf

                  If .spawn_cond <> 0 Then
                    .spawn_info = CAllocate( Len( LLObject_ConditionalSpawn ) )

                    VFile_Get o, , .spawn_info->wait_n
                    #IfDef LL_LOGMAPLOADPROGRESS
                      
                      LLSystem_Log( "Room(" & loop_rooms & ").enemy(" & loop_enemies & ").spawn_info->wait_n: " & .spawn_info->wait_n )
                      LLSystem_Log( "" )
                      
                    #EndIf
                    .spawn_info->wait_spawn = CAllocate( Len( LLObject_SpawnSwitch ) * ( .spawn_info->wait_n + 1 ) ) 

                    For loop_spawns = 0 To .spawn_info->wait_n - 1
                      VFile_Get o, , .spawn_info->wait_spawn[loop_spawns].code_index
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Room(" & loop_rooms & ").enemy(" & loop_enemies & ").spawn_info->wait_spawn(" & loop_spawns & ").code_index: " & .spawn_info->wait_spawn[loop_spawns].code_index )
                        LLSystem_Log( "" )                                                                                                                                                             
                                                                                                                                                                                                       
                      #EndIf                                                                                                                                                                           
                                                                                                                                                                                                       
                      VFile_Get o, , .spawn_info->wait_spawn[loop_spawns].code_state                                                                                                                   
                      #IfDef LL_LOGMAPLOADPROGRESS                                                                                                                                                            
                                                                                                                                                                                                       
                        LLSystem_Log( "Room(" & loop_rooms & ").enemy(" & loop_enemies & ").spawn_info->wait_spawn(" & loop_spawns & ").code_state: " & .spawn_info->wait_spawn[loop_spawns].code_state )
                        
                      #EndIf
                    
                    Next
                    
                    VFile_Get o, , .spawn_info->kill_n
                    #IfDef LL_LOGMAPLOADPROGRESS
                      
                      LLSystem_Log( "Room(" & loop_rooms & ").enemy(" & loop_enemies & ").spawn_info->kill_n: " & .spawn_info->kill_n )
                      LLSystem_Log( "" )
                      
                    #EndIf
                    .spawn_info->kill_spawn = CAllocate( Len( LLObject_SpawnSwitch ) * ( .spawn_info->kill_n + 1 ) ) 
                    
                    For loop_spawns = 0 To .spawn_info->kill_n - 1
                      VFile_Get o, , .spawn_info->kill_spawn[loop_spawns].code_index
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Room(" & loop_rooms & ").enemy(" & loop_enemies & ").spawn_info->kill_spawn(" & loop_spawns & ").code_index: " & .spawn_info->kill_spawn[loop_spawns].code_index )
                        LLSystem_Log( "" )                                                                                                                                                             
                                                                                                                                                                                                       
                      #EndIf                                                                                                                                                                           
                                                                                                                                                                                                       
                      VFile_Get o, , .spawn_info->kill_spawn[loop_spawns].code_state                                                                                                                   
                      #IfDef LL_LOGMAPLOADPROGRESS                                                                                                                                                            
                                                                                                                                                                                                       
                        LLSystem_Log( "Room(" & loop_rooms & ").enemy(" & loop_enemies & ").spawn_info->kill_spawn(" & loop_spawns & ").code_state: " & .spawn_info->kill_spawn[loop_spawns].code_state )
                        
                      #EndIf
                    
                    Next
                    
                    VFile_Get o, , .spawn_info->active_n
                    #IfDef LL_LOGMAPLOADPROGRESS
                      
                      LLSystem_Log( "Room(" & loop_rooms & ").enemy(" & loop_enemies & ").spawn_info->active_n: " & .spawn_info->active_n )
                      LLSystem_Log( "" )
                      
                    #EndIf
                    .spawn_info->active_spawn = CAllocate( Len( LLObject_SpawnSwitch ) * ( .spawn_info->active_n + 1 ) ) 
                    
                    For loop_spawns = 0 To .spawn_info->active_n - 1
                      VFile_Get o, , .spawn_info->active_spawn[loop_spawns].code_index
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Room(" & loop_rooms & ").enemy(" & loop_enemies & ").spawn_info->active_spawn(" & loop_spawns & ").code_index: " & .spawn_info->active_spawn[loop_spawns].code_index )
                        LLSystem_Log( "" )
                        
                      #EndIf

                      VFile_Get o, , .spawn_info->active_spawn[loop_spawns].code_state
                      #IfDef LL_LOGMAPLOADPROGRESS
                        
                        LLSystem_Log( "Room(" & loop_rooms & ").enemy(" & loop_enemies & ").spawn_info->active_spawn(" & loop_spawns & ").code_state: " & .spawn_info->active_spawn[loop_spawns].code_state )
                        
                      #EndIf
                    
                    Next
                  
                  End If
                  
          
          
                  .coords.x = .x_origin
                  .coords.y = .y_origin
      
                  .ori_dir = .direction
                  
                End With
        
              Next
                                                                                                                          
              .layout = CAllocate( ( 3 ) * Len ( Integer Ptr ) )
              
              Dim As Integer room_elem = ( _ 
                                           .x * ( .y + 1 ) + 1 _ '' y + 1 means extra row of padding.
                                         )                       '' doesnt matter why! it's necessary to avoid
                                                                 '' a bunch of crap checks.
                                       
                                       
              Redim As uShort quickbuf ( room_elem )
        
              For get_n_cpy = 0 To 2
        
                .layout[get_n_cpy] = CAllocate( ( UBound ( quickbuf ) + 1 ) * Len ( Integer ) + 4096 )
          
                res = VFile_Get( o, , VF_Array( quickbuf ) )
                If res <> 0 Then
                  quick_text( "[Quickbuf()] VFile_Get(): " & res )
                  
                End If
                #IfDef LL_LOGMAPLOADPROGRESS
                  
                  LLSystem_Log( "Room(" & loop_rooms & ").layer(" & get_n_cpy & "): read" )
                  
                #EndIf
      
                For file_shrink = 0 To ( room_elem )
                  .layout[get_n_cpy][file_shrink] = quickbuf( file_shrink )
                
                Next     
          
              Next

              #IfDef LL_LOGMAPLOADPROGRESS
                
                LLSystem_Log( "" )
                
              #EndIf
        
           
            End With
        
          Next
      
      
          For loop_entries = 0 To lmap->entries - 1 
            
            With lmap->entry[loop_entries]
            
              VFile_Get o, , .x
              #IfDef LL_LOGMAPLOADPROGRESS
                
                LLSystem_Log( "Entry(" & loop_entries & ").x: " & .x )
                
              #EndIf


              VFile_Get o, , .y
              #IfDef LL_LOGMAPLOADPROGRESS
                
                LLSystem_Log( "Entry(" & loop_entries & ").y: " & .y )
                
              #EndIf


              VFile_Get o, , .room
              #IfDef LL_LOGMAPLOADPROGRESS
                
                LLSystem_Log( "Entry(" & loop_entries & ").room: " & .room )
                
              #EndIf


              VFile_Get o, , .direction
              #IfDef LL_LOGMAPLOADPROGRESS
                
                LLSystem_Log( "Entry(" & loop_entries & ").direction: " & .direction )
                
              #EndIf


              VFile_Get o, , .seq_here
              #IfDef LL_LOGMAPLOADPROGRESS
                
                LLSystem_Log( "Entry(" & loop_entries & ").seq_here: " & .seq_here )
                
              #EndIf

        
              VFile_Get o, , VF_Array( .reserved )
              #IfDef LL_LOGMAPLOADPROGRESS
                
                LLSystem_Log( "Entry(" & loop_entries & ").reserved(): read" )
                LLSystem_Log( "" )
                
              #EndIf
        
        
              load_seqV( o, _ 
                         .seq_here, _ 
                         .seq, _ 
                         lmap->manage_mem, _
                         "entry", _
                         loop_entries )        
      
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
      
      
        VFile_Close( o )

        #IfDef LL_LOGMAPLOADPROGRESS
          
          LLSystem_Log( "" )
          LLSystem_Log( "" )
          LLSystem_Log( "" )
          LLSystem_Log( "" )
          LLSystem_Log( "" )
          LLSystem_Log( "" )
          
        #EndIf
        
        If tileFilename = "" Then 
          If bypass_errors = 0 Then
'            engine_end( no_map_tileset, "" )
            
          End If
          
        End If
        
        If Dir( tileFilename ) = "" Then 
          If bypass_errors = 0 Then
'            engine_end( map_tileset_not_found, lmap->filename & ", " & tileFilename )
            
          End If
          
        End If
        
        lmap->tileset = LLSystem_ImageDeref( LLSystem_ImageDerefName( tileFilename ) )
        
        If lmap->isDungeon <> 0 Then  
          llg( minimap ) = LLMiniMap_LoadMiniMap( kfe( lmap->filename ) & ".mni", lmap->rooms ) 
          
        End If
      
        Return lmap
      
        
      End Function  

      
      Function LLSystem_LoadMap( s As String, a As Integer = 0 ) As map_type Ptr
      
        Dim As uByte map_memory()
        
          zLib_DeCompress( s, map_memory() )
          Return load_mapV( map_memory(), a )
          
        
      End Function
      
      
      
      
      Sub load_entrypoint()
  
        llg( start_map ) = "data\map\title.map"
        llg( start_entry ) = 0
          
      End Sub    

#IfDef __gmap__


  Sub del_room_enemies( enemies As Integer, enemy As char_type Ptr )
  
    Dim As Integer setup
  
  
    For setup = 0 To enemies - 1
      LLSystem_ObjectRelease( enemy[setup] )
  
    Next
    
    
  End Sub


#EndIf

#IfDef ll_main


  Sub del_room_enemies( enemies As Integer, enemy As char_type Ptr )
  
    Dim As Integer setup
  
  
    For setup = 0 To enemies - 1
      LLSystem_ObjectRelease( enemy[setup] )
  
    Next
    
    
  End Sub
  
  

  Function ctor_hero( l As char_type Ptr = 0 ) As char_type Ptr
  
    Dim As Integer pass
  
    If l = 0 Then
      l = CAllocate( Len( char_type ) )
      pass = Not 0
    
    End If
  
  
    With *l
  
  
      
      l->id = "data\object\lynn.xml"
      
      LLSystem_CopyNewObject( *l )

      l->dead_sound = sound_lynn_die
      
      .num = -1
      
      .hp = 6
      .maxhp = 6
      
      llg( hero_only ).weapon = -1
      llg( hero_only ).has_weapon = -1

      llg( hero_only ).hasCostume( 0 ) = -1
      llg( hero ).fade_time = .003
      
    End With
  
    If pass <> 0 Then
      Return l
      
    End If
    
  
  End Function

#EndIf

        
      
      
      Sub load_status_images( t As load_savImage Ptr )
      
        With *t
          
            .img( 0 ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\lynnstatus1.spr" ) )
            .img( 1 ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\lynnstatus2.spr" ) )
            .img( 2 ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\lynnstatus3.spr" ) )
            
          
        End With
      
      End Sub  
      
      
      Sub load_menu()
        
        
          With llg( menu ).menuImages
            .img( menu_blankspace      ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\blankspace.spr"                    ) )
            .img( menu_bridge          ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\bridge.spr"                        ) )
            .img( menu_bridge_select   ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\bridge_select.spr"                 ) )
            .img( menu_bridge2         ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\bridge2.spr"                       ) )
            .img( menu_bridge2_select  ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\bridge2_select.spr"                ) )
            .img( menu_bridge3         ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\bridge3.spr"                       ) )
            .img( menu_bridge3_select  ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\bridge3_select.spr"                ) )
            .img( menu_blank           ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\item_blank.spr"                    ) )
            .img( menu_blank_select    ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\item_blank_select.spr"             ) )
            .img( menu_flare           ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\flare.spr"                         ) )
            .img( menu_flare_select    ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\flare_select.spr"                  ) )
            .img( menu_full_background ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\full_background.spr"               ) )
            .img( menu_heal            ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\heal.spr"                          ) )
            .img( menu_heal_select     ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\heal_select.spr"                   ) )
            .img( menu_ice             ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\ice.spr"                           ) )
            .img( menu_ice_select      ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\ice_select.spr"                    ) )
            .img( menu_idol            ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\idol.spr"                          ) )
            .img( menu_idol_select     ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\idol_select.spr"                   ) )
            .img( menu_mace            ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\mace.spr"                          ) )
            .img( menu_mace_select     ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\mace_select.spr"                   ) )
            .img( menu_menu_select     ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\menu_select.spr"                   ) )
            .img( menu_regen           ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\regen.spr"                         ) )
            .img( menu_regen_select    ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\regen_select.spr"                  ) )
            .img( menu_resume_select   ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\resume_select.spr"                 ) )
            .img( menu_sapling         ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\sapling.spr"                       ) )
            .img( menu_sapling_select  ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\sapling_select.spr"                ) )
            .img( menu_square_cursor   ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\square_cursor.spr"                 ) )
            .img( menu_star            ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\star.spr"                          ) )
            .img( menu_star_select     ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\star_select.spr"                   ) )
            .img( menu_cougar          ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\outfits\cougar\icon.spr"           ) )
            .img( menu_lynnity         ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\outfits\lynnity\icon.spr"          ) )
            .img( menu_ninja           ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\outfits\ninja\icon.spr"            ) )
            .img( menu_standard        ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\icon.spr"                          ) )
            .img( menu_cougar_select   ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\outfits\cougar\icon_select.spr"    ) )
            .img( menu_lynnity_select  ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\outfits\lynnity\icon_select.spr"   ) )
            .img( menu_ninja_select    ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\outfits\ninja\icon_select.spr"     ) )
            .img( menu_standard_select ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\icon_select.spr"                   ) )
            .img( menu_bikini          ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\outfits\swimsuit\icon.spr"         ) )
            .img( menu_bikini_select   ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\outfits\swimsuit\icon_select.spr"  ) )
            .img( menu_rknight         ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\outfits\redknight\icon.spr"        ) )
            .img( menu_rknight_select  ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\outfits\redknight\icon_select.spr" ) )
            
          End With
          
          With llg( menu )
          
            .menuNames( menu_bridge_select   ) = "Some old scraps."
            .menuNames( menu_flare_select    ) = "Flare Powder."
            .menuNames( menu_ice_select      ) = "Ice Powder."
            .menuNames( menu_idol_select     ) = "An ancient treasure."
            .menuNames( menu_regen_select    ) = "Adrenaline Booster."
            .menuNames( menu_heal_select     ) = "Healing Symbol."

            .menuNames( menu_sapling_select  ) = "A small sapling."
            .menuNames( menu_mace_select     ) = "My old mace."
            .menuNames( menu_star_select     ) = "Handcrafted 0wnage."

            .menuNames( menu_standard_select ) = "Normal outfit."           
            .menuNames( menu_cougar_select   ) = "Mew..."                  
            .menuNames( menu_lynnity_select  ) = "Tight Leather." 
            .menuNames( menu_ninja_select    ) = "..."                      
            .menuNames( menu_bikini_select   ) = "Not very practical..."
            .menuNames( menu_rknight_select  ) = "Regenerative power."

            .menuNames( menu_menu_select     ) = "Back to title screen."
            .menuNames( menu_resume_select   ) = "Back to the game."
            
          End With
          
          
      
      End Sub
      
      Sub load_hud( h As load_hudImage Ptr )
        
        With *h

          .img( 0 ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\hud\HUD_health.spr"  ) )
          .img( 1 ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\hud\HUD_items.spr"   ) )
          .img( 2 ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\hud\cash.spr"        ) )
          .img( 3 ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\hud\cashnumbers.spr" ) )
          .img( 4 ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\hud\fullbar.spr"     ) )
          .img( 5 ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\hud\key.spr"         ) )
          .img( 6 ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\hud\key2.spr"        ) )

          .img( 7 ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\hud\materials2.spr"   ) )
          .img( 8 ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\hud\materials3.spr"   ) )
          
        End With
          
      End Sub

    #IfDef __gmap__      

      Sub gmap_init()
      
      
        fb_Global.display.pal = load_pal( "data\palette\ll.pal" )
        Palette Using fb_Global.display.pal
        
        Width 100, 75
      
        
        make_null_map()  
      
        gmg( map_area.x ) = 512
        gmg( map_area.y ) = 384
        
        
      
        gmg( def_id ) = "roamer"  
        
        
        llg( dir_hint ) = CAllocate( ( Len( uByte ) * 4 ) )
      
        llg( u_key.code ) = sc_up
        llg( r_key.code ) = sc_right
        llg( d_key.code ) = sc_down
        llg( l_key.code ) = sc_left
                          
        llg( dir_hint[0] ) = llg( u_key.code )
        llg( dir_hint[1] ) = llg( r_key.code )
        llg( dir_hint[2] ) = llg( d_key.code )
        llg( dir_hint[3] ) = llg( l_key.code )
        
        
        
        gmg( room_down_key ) = init_bin_obj( sc_leftbracket, @room_down_key_in_sub )  
        gmg( room_up_key )   = init_bin_obj( sc_rightbracket, @room_up_key_in_sub )  
        
        gmg( zoom_key )      = init_bin_obj( sc_z, @zoom_key_in_sub )  
        gmg( solo_key )      = init_bin_obj( sc_s, @solo_key_in_sub )  
        gmg( grid_key )      = init_bin_obj( sc_g, @grid_key_in_sub )  
        gmg( w_grid_key )    = init_bin_obj( sc_w, @w_grid_key_in_sub )  
        gmg( redim_key )     = init_bin_obj( sc_d, @redim_key_in_sub )  
        gmg( flood_key )     = init_bin_obj( sc_o, @flood_key_in_sub )  
        
        gmg( hide_key )     = init_bin_obj( sc_h, @hide_key_in_sub )  
        
        ScreenInfo llg( sx ), llg( sy )
          gmg( mac_loc ).x = ( llg( sx ) - 132 )
          gmg( mac_loc ).y = ( llg( sy ) - 124 )
        
        ScreenSet 0,1
        
      
        Line( 0, 0 )-( 31, 31 ), 15, bf
        
        Get( 0, 0 )-( 7 , 7  ), Varptr( gmg( white_box( 0, 0 ) ) )
        Get( 0, 0 )-( 15, 15 ), Varptr( gmg( white_box( 1, 0 ) ) )
        Get( 0, 0 )-( 31, 31 ), Varptr( gmg( white_box( 2, 0 ) ) )
      
        Scope
      
          Dim As uByte Ptr blck
          Dim As Integer blacken  
        
          Get( 0, 0 )-( 15, 15 ), @gmg( white_box( 3, 0 ) )
        
          
          blck = CPtr( uByte Ptr, @gmg( white_box( 3, 0 ) ) )
        
          For blacken = 4 To ( 16 * 16 ) - 1 Step 2
            
            blck[blacken] = 0
            
          Next
                                                 
          
          Get( 0, 0 )-( 31, 31 ), @gmg( white_box( 4, 0 ) )
        
        
          blck = CPtr( uByte Ptr, @gmg( white_box( 4, 0 ) ) )
        
          For blacken = 4 To ( 32 * 32 ) - 1 Step 2
            
            blck[blacken] = 0
            
          Next
      
        End Scope                                         
      
        Cls
        
        gmg( tile_loc.x ) = llg( sx ) - 256
        gmg( tile_loc.y ) = 0 
      
        '' MEMCHANGE
        gmg( r_img ) = CAllocate( 3 * Len( Integer Ptr ) )
        gmg( b_img ) = CAllocate( 3 * Len( Integer Ptr ) )
        
        Scope
        
          Dim As Integer layer_
        
            For layer_ = 0 To 2
              gmg( r_img[layer_] ) = CAllocate( llg( sx ) * llg( sy ) * Len( Integer ) )
              gmg( b_img[layer_] ) = CAllocate( llg( sx ) * llg( sy ) * 4 * Len( Integer ) )
              
            Next
            
        End Scope
      
        
      
        set_gmap_controls()
        
        load_previous()
        
      
        WindowTitle "gMap Editor"
      
        gmg( macros ) = 1
        gmg( macro ) = CAllocate( 4 )
        gmg( macro )[0] = CAllocate( 36 * Len( Integer ) )

'        llg( a_page ) = 0
'        llg( v_page ) = 1
      
      
        gmg( refresh ) = -1
      
        gmg( state_addy ) = CAllocate( s_NUM_OF_STATES * 4 )


        gmg( state_addy )[s_redimension]             = ProcPtr( redimension_room               )
        gmg( state_addy )[s_load_map]                = ProcPtr( gload_map                      )
        gmg( state_addy )[s_rooms]                   = ProcPtr( handle_rooms                   )
        gmg( state_addy )[s_entries]                 = ProcPtr( handle_entries                 )
        gmg( state_addy )[s_macros]                  = ProcPtr( handle_macros                  )
        gmg( state_addy )[s_walkables]               = ProcPtr( handle_walkable                )
        gmg( state_addy )[s_enemies]                 = ProcPtr( handle_enemies                 )
        gmg( state_addy )[s_teleports]               = ProcPtr( handle_teleports               )
        gmg( state_addy )[s_ice]                     = ProcPtr( handle_ice                     )
        gmg( state_addy )[s_save_map]                = ProcPtr( handle_save                    )
        gmg( state_addy )[s_layer_0]                 = ProcPtr( handle_layer                   )
        gmg( state_addy )[s_layer_1]                 = ProcPtr( handle_layer                   )
        gmg( state_addy )[s_layer_2]                 = ProcPtr( handle_layer                   )
        gmg( state_addy )[s_zoom]                    = ProcPtr( handle_zoom                    )
        gmg( state_addy )[s_walk_grid]               = ProcPtr( handle_walk_grid               )
        gmg( state_addy )[s_tile_grid]               = ProcPtr( handle_grid                    )
        gmg( state_addy )[s_parallax]                = ProcPtr( handle_parallax                )
        gmg( state_addy )[s_solo]                    = ProcPtr( handle_solo                    )
        gmg( state_addy )[s_flood_fill]              = ProcPtr( handle_flood_fill              )
        gmg( state_addy )[s_layer_fill]              = ProcPtr( handle_fill                    )
        gmg( state_addy )[s_quit]                    = ProcPtr( handle_quit                    )
        gmg( state_addy )[s_sequence]                = ProcPtr( handle_sequences               )
        gmg( state_addy )[s_sequence_entities]       = ProcPtr( handle_sequence_entities       )
        gmg( state_addy )[s_sequence_commands]       = ProcPtr( handle_sequence_commands       )
        gmg( state_addy )[s_sequence_command_blocks] = ProcPtr( handle_sequence_command_blocks )
        gmg( state_addy )[s_parallax_image]          = ProcPtr( handle_parallax_image          )
        gmg( state_addy )[s_load_tiles]              = ProcPtr( handle_tileset_load            )
                                                                                              
        
        gmg( block_boxes ) = CAllocate( Len( Sub ) * 2 )
        
        gmg( block_boxes )[0] = ( @command_block_box ) 
        gmg( block_boxes )[1] = ( @command_block_box2 ) 
        
        
      
    
      End Sub
      
      
      
    #EndIf  

      
      
      





      

      
      


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'' # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
''  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'' saving structures...
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'' # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
''  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

      Sub save_seq( ff As Integer, n As Integer, s As sequence_type Ptr )
      
        Dim As Integer grab_seq, loop_code_ents, loop_commands, loop_command_ents
      
        For grab_seq = 0 To n - 1
      
          Put #ff, , s[grab_seq].ents
          
          For loop_code_ents = 0 To s[grab_seq].ents -1
      
            Dim As Integer code' = s[grab_seq].ent_code[loop_code_ents]
            code = s[grab_seq].ent_code[loop_code_ents]
      
          
            Put #ff, , code
      
            
          Next
      
      
          Put #ff, , s[grab_seq].commands
          
      
          For loop_commands = 0 To s[grab_seq].commands -1
          
            Put #ff, , s[grab_seq].Command[loop_commands].ents
            
            
      
            For loop_command_ents = 0 To s[grab_seq].Command[loop_commands].ents -1
            
              Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].active_ent 
              Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].ent_state
      
              save_h_string( ff, s[grab_seq].Command[loop_commands].ent[loop_command_ents].text )
      
              Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].walk_speed 
              Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].dest_y  
              Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].dest_x  
              Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].abs_x
              Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].abs_y
              Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].mod_y  
              Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].mod_x  

              save_h_string( ff, s[grab_seq].Command[loop_commands].ent[loop_command_ents].to_map )

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

              Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].fadeTime
'              Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].reserved_7   
'              Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].reserved_8   
              Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].reserved_9   
              Put #ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].reserved_10  
              
            Next
            
          Next
          
        Next
      
      
      End Sub
      
      
      Sub save_seqV( ff As Integer, n As Integer, s As sequence_type Ptr )
      
        Dim As Integer grab_seq, loop_code_ents, loop_commands, loop_command_ents
      
        For grab_seq = 0 To n - 1
      
          VFile_Put ff, , s[grab_seq].ents
          
          For loop_code_ents = 0 To s[grab_seq].ents -1
      
            Dim As Integer code' = s[grab_seq].ent_code[loop_code_ents]
            code = s[grab_seq].ent_code[loop_code_ents]
      
          
            VFile_Put ff, , code
      
            
          Next
      
      
          VFile_Put ff, , s[grab_seq].commands
          
      
          For loop_commands = 0 To s[grab_seq].commands -1
          
            VFile_Put ff, , s[grab_seq].Command[loop_commands].ents
            
            
      
            For loop_command_ents = 0 To s[grab_seq].Command[loop_commands].ents -1
            
              VFile_Put ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].active_ent 
              VFile_Put ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].ent_state
      
              VFile_Put ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].text
      
              VFile_Put ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].walk_speed 
              VFile_Put ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].dest_y  
              VFile_Put ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].dest_x  
              VFile_Put ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].abs_x
              VFile_Put ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].abs_y
              VFile_Put ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].mod_y  
              VFile_Put ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].mod_x  

              VFile_Put ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].to_map

              VFile_Put ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].to_entry 
              VFile_Put ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].jump_count 
              VFile_Put ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].water_align
              VFile_Put ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].chap  
              VFile_Put ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].carries_all
              VFile_Put ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].nocam  
              VFile_Put ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].reserved_1   
              VFile_Put ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].reserved_2   
              VFile_Put ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].reserved_3   
              VFile_Put ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].reserved_4   
              VFile_Put ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].reserved_5   
              VFile_Put ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].reserved_6   
'              VFile_Put ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].reserved_7   
              VFile_Put ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].fadeTime   
'              VFile_Put ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].reserved_8   
              VFile_Put ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].reserved_9   
              VFile_Put ff, , s[grab_seq].Command[loop_commands].ent[loop_command_ents].reserved_10  
              
            Next
            
          Next
          
        Next
      
      
      End Sub
      
      
      
      Sub save_mapV ( filename As String, smap As map_type Ptr )
      
        Dim As Integer o = VFile_FreeFile
        Dim As Integer loop_rooms, loop_enemies, loop_teleports, cpy_n_put, file_shrink, loop_entries, loop_spawns
        
        Dim As uByte startbuf( 0 )
        
        VFile_Open( startbuf(), o )
        
        
'        Open filename For Binary As o
      
'          save_h_string( o, filename )
          VFile_Put o, , filename
        
          VFile_Put o, , smap->entries
          VFile_Put o, , smap->rooms
        
'          VFile_Put o, , smap->tileset.filename
          VFile_Put o, , smap->tileset->filename
          
          For loop_rooms = 0 To smap->rooms - 1
      
            With smap->room[loop_rooms]
        
              Redim As uShort quickbuf( .x * ( .y + 1 ) + 1 )
            
              VFile_Put o, , .x
              VFile_Put o, , .y
              VFile_Put o, , .parallax
        
              If .parallax Then 
'                VFile_Put o, , .para_img.filename
                VFile_Put o, , .para_img->filename
                
              End If
              
              VFile_Put o, , .dark
              VFile_Put o, , .teleports
              VFile_Put o, , .song
              VFile_Put o, , .song_changes
              VFile_Put o, , .changes_to
              VFile_Put o, , VF_Array( .reserved )
        
              
              For loop_teleports = 0 To .teleports - 1 
                
                With .teleport[loop_teleports]

                  VFile_Put o, , .x
                  VFile_Put o, , .y
                  VFile_Put o, , .w
                  VFile_Put o, , .h
                  VFile_Put o, , .to_room
                  
                  VFile_Put o, , .to_map
                  
                  VFile_Put o, , .dx
                  VFile_Put o, , .dy
                  VFile_Put o, , .dd
                  VFile_Put o, , .to_song
                  VFile_Put o, , VF_Array( .reserved )
                  
                End With
                
              Next
              
              VFile_Put o, , .seq_here
              save_seqV( o, .seq_here, .seq )
              
          
              VFile_Put o, , .enemies
              
              For loop_enemies = 0 To .enemies - 1 
                
                With .enemy[loop_enemies]
                
                  .coords.x = .x_origin
                  .coords.y = .y_origin
          
                  VFile_Put o, , .x_origin
                  VFile_Put o, , .y_origin
      
                  VFile_Put o, , .id
                  
                  VFile_Put o, , .direction
                  VFile_Put o, , .seq_here
                  VFile_Put o, , .spawn_h
                  VFile_Put o, , .is_h_set
                  VFile_Put o, , .chap
                  VFile_Put o, , .spawn_d
                  VFile_Put o, , .is_d_Set
                  VFile_Put o, , .reserved_5
                  
                  save_seqV( o, .seq_here, .seq )
                  

                  VFile_Put o, , .spawn_cond
                  If .spawn_cond <> 0 Then
                    

                    VFile_Put o, , .spawn_info->wait_n
                    For loop_spawns = 0 To .spawn_info->wait_n - 1
                      VFile_Put o, , .spawn_info->wait_spawn[loop_spawns].code_index
                      VFile_Put o, , .spawn_info->wait_spawn[loop_spawns].code_state
                    
                    Next
                    
                    VFile_Put o, , .spawn_info->kill_n
                    For loop_spawns = 0 To .spawn_info->kill_n - 1
                      VFile_Put o, , .spawn_info->kill_spawn[loop_spawns].code_index
                      VFile_Put o, , .spawn_info->kill_spawn[loop_spawns].code_state
                    
                    Next
                    
                    VFile_Put o, , .spawn_info->active_n
                    For loop_spawns = 0 To .spawn_info->active_n - 1
                      VFile_Put o, , .spawn_info->active_spawn[loop_spawns].code_index
                      VFile_Put o, , .spawn_info->active_spawn[loop_spawns].code_state
                    
                    Next
                  
                  End If

                  
                  
                End With
      
                
              Next
          
              For cpy_n_put = 0 To 2 
          
                For file_shrink = 0 To .x * ( .y + 1 ) 
                  quickbuf( file_shrink ) = .layout[cpy_n_put][file_shrink]
                Next     
              
                VFile_Put o, , VF_Array( quickbuf )
                
              Next
           
            End With
            
          Next
      
          For loop_entries = 0 To smap->entries - 1 
          
            With smap->entry[loop_entries]
          
              VFile_Put o, , .x
              VFile_Put o, , .y
              VFile_Put o, , .room
              VFile_Put o, , .direction
              VFile_Put o, , .seq_here
        
              VFile_Put o, , VF_Array( .reserved )
              
              save_seqV( o, .seq_here, .seq )
              
            End With
            
          Next
            
          '' All in!
          
          Redim As uByte savbuf( 0 )
          ''
          
          VFile_Save( o, savbuf() )
          
          zLib_Compress( savbuf(), filename, 9 )
          
        Close
        
      End Sub 












''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'' # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
''  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'' structure destruction
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'' # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
''  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''




      
      Private Sub LLSystem_DestroyObjectArray( enemies As Integer, enemy As char_type Ptr, debugString As String = "" )
                   
        Dim As Integer clear_out, clrSeq
      
      
        For clear_out = 0 To enemies - 1
          
          For clrSeq = 0 To enemy[clear_out].seq_here - 1 
            sequence_Destroy( enemy[clear_out].seq[clrSeq] )
            
          Next
          
          clean_Deallocate( enemy[clear_out].seq )
          
            LLSystem_ObjectRelease     ( enemy[clear_out], debugString & clear_out )
'            LLSystem_ClearObjectStrings( enemy[clear_out] )
            
      
        Next
        
        
      End Sub
      
      
          
      Sub sequence_Destroy( sequenceDestroy As sequence_type )
        
        Dim As Integer i, j
        
        With sequenceDestroy  
        
          clean_Deallocate( .ent )
          clean_Deallocate( .ent_code )
          
          
          For i = 0 To .commands - 1
          
            With .Command[i]
              
              For j = 0 To .ents - 1 
                
                With .ent[j]
              
                  .text = ""
                  .to_map =""
                  
                End With
                
              Next
  
              clean_Deallocate( .ent )
            
            End With
          
          Next
          
          .seq_type = ""
          
          clean_Deallocate( .Command )
          
        End With
      
      End Sub

      
      Sub map_Destroy( m As map_type Ptr )
      
      
        If m = 0 Then 
          Exit Sub
          
        End If

        
        Dim As Integer d_rooms, d_enemies, anim_out, d_frames, d_para, seq_out, entry_out, tel
      
        For d_rooms = 0 To m->rooms - 1
      
          With m->room[d_rooms]
      
            LLSystem_DestroyObjectArray( .temp_enemies, Varptr( .temp_enemy( 0 ) ) )
            
            If .enemy <> 0 Then
            
              LLSystem_DestroyObjectArray( .enemies, .enemy, "enemy " )
        
            End If
            
            clean_Deallocate( .enemy )
            
            For tel = 0 To .teleports - 1 
              .teleport[tel].to_map = ""
            
            Next
            clean_Deallocate( .teleport )
            
            For seq_out = 0 To .seq_here - 1
              sequence_Destroy( .seq[seq_out] )
              
            Next
            
            clean_Deallocate( .seq )
            
            clean_Deallocate( .layout[0] )
            clean_Deallocate( .layout[1] )
            clean_Deallocate( .layout[2] )

            clean_Deallocate( .layout )
            
           
          End With
      
        Next
        
        clean_Deallocate( m->room )
      
        For entry_out = 0 To m->entries - 1
        
          For seq_out = 0 To m->entry[entry_out].seq_here - 1
            sequence_Destroy( m->entry[entry_out].seq[seq_out] )
            
          Next
          
          clean_Deallocate( m->entry[entry_out].seq )
        
        Next

        clean_Deallocate( m->entry )
        
        m->filename = ""

        minimap_destroy( llg( minimap ) )

        clean_Deallocate( m )
        
      
      End Sub  
      

 
      Sub destroy_box( b As boxcontrol_type Ptr )
        

        If b = 0 Then Exit Sub
        
        Dim As Integer i
        For i = 0 To b->internal.numoflines - 1
          b->ptrs.row[i] = ""
          
        Next
        
        clean_Deallocate( b->ptrs.row )
        
      
      End Sub
      
      #ifdef ll_main
        Function make_box( txt As String, a_lock As Integer, clr As Short, invis As Short, auto As Double, x As Short, y As Short, spd As Integer ) As boxcontrol_type
        
          Dim As boxcontrol_type box
          Dim As boxcontrol_type Ptr b = @box
  
            box.ptrs.box  = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\textbox.spr"  ) )
            box.ptrs.Next = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\textdown.spr" ) )
            'box.ptrs.mask = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\emptybox.spr" ) )
  
          init_box( txt, b ) 
        
          b->layout.speed = .021813
        
          If a_lock = 0 Then 
                                            
            llg( hero_only ).action_lock = -1
        
            
          End If
          
          b->internal.lastFG = llg( fontFG )
          
          If clr <> 0 Then 
  
            dim as integer shake
            shake = clr
            __set_font_fg( cast( any ptr, shake ) )
            
          End If
        
        
          If invis <> 0 Then 
          
            b->layout.invis = -1
            
          End If
        
          If auto <> 0 Then 
          
            b->internal.auto = -1
            b->internal.autosleep = auto
            
          End If
        
        
          If x <> 0 Then 
          
            b->layout.x_loc = x
            
          End If
        
          If y <> 0 Then 
          
            b->layout.y_loc = y
            
          End If
        
          If spd <> 0 Then 
              
            if spd = conf_Box then
              b->internal.confBox = TRUE
              
            else
              b->layout.speed = spd / 1000
              
            end if
            
          End If
        
        
        
          b->activated = TRUE
          b->internal.state = TEXTBOX_REGULAR
          
          Return box
          
        End Function
        
      #endif
      
      private function parseText( textToParse as string ) as string
      
        dim as string res
        dim as integer c

        do
          
          if textToParse[c] = asc( "{" ) then
            '' special token
            dim as string tok
            dim as integer c2

            do
            
              tok += " "
              
              tok[c2] = textToParse[c + c2]
              
              c2 += 1
              if tok[c2-1] = asc( "}" ) then exit do
              
            loop
            
            if ucase( tok ) = "{HEALTHPRICE}" then
              res += str( healthFormula )
            
            end if
            
            if ucase( tok ) = "{HEALTHNOW}" then
              res += str( llg( hero ).maxhp )
            
            end if
            
            if ucase( tok ) = "{HEALTHUP}" then
              res += str( llg( hero ).maxhp + 1 )
            
            end if
            
            if ucase( tok ) = "{NEWLINE}" then
              res += "{NEWLINE}"
            
            end if
            
            c += c2
            
          end if 
          
          res += chr( textToParse[c] )
          c += 1
          
          if c = len( textToParse ) then exit do

        loop
        
        return res
      
      end function
      
      Sub init_box( ByVal text As String, b As boxcontrol_type Ptr ) 
        
        dim as string tempBuffer

        tempBuffer = parseText( text )

        Redim As String words( 0 ), lines( 0 )
      
        Scope
      
          Dim As Integer word_num, parse_loc
          Dim As Integer p_char
              
            For parse_loc = 0 To Len( tempBuffer ) - 1
          
              Redim Preserve words( word_num )
          
              p_char = tempBuffer[parse_loc]
          
              words( word_num ) += Chr( p_char )
              If p_char = Asc( " " ) Then word_num += 1
          
            Next
      
        End Scope
        
        
        Scope
      
          Dim As String msgline
          Dim As Integer wordindex, lineindex 
          Dim As Integer getoutflag
        
            Do
          
              If wordindex - 1 <> UBound( words ) Then
                '' not past the last word
          
                If ( Len( msgline ) + Len( words( wordindex ) ) < 36 ) and ( words( wordindex ) <> "{NEWLINE} " ) Then
                  '' the message length is less than 36 if we add this word
          
                  msgline += words( wordindex )
                  wordindex += 1
                  
                Else
                  '' the message would exceed box width, start a new line
                  if words( wordindex ) = "{NEWLINE} " then
                    wordindex += 1
                    
                  end if
          
                  Redim Preserve lines( lineindex ) 
          
                  lines( lineindex ) = msgline
                  lineindex += 1
          
                  msgline = ""
                
                End If
          
              Else
                '' past the last word... close it up.
          
                Redim Preserve lines( lineindex )
          
                lines( lineindex ) = msgline
                getoutflag = Not 0    
          
          
              End If
          
            Loop Until getoutflag
        
      
        End Scope  
      
      
        b->internal.numoflines = UBound( lines ) + 1
      
        b->ptrs.row = CAllocate( ( b->internal.numoflines ) * Len( String ) )
      
      
        Scope
      
          Dim As Integer stuff_lines
          Dim As Integer leng, diff
        
          For stuff_lines = 0 To b->internal.numoflines - 1
            
            leng = Len( lines( stuff_lines ) )
            diff = 38 - leng
            
        
            Scope
        
              Dim As uByte lin_msg( 36 )
              MemSet( @lin_msg( 0 ), 0, 37 ) '' <---- ?? fb doesn't clear it...
              
              Dim As Integer put_ch
              
                For put_ch = 0 To leng - 1
                
                  lin_msg( put_ch + ( diff \ 2 ) ) = lines( stuff_lines )[put_ch]
                  
                Next
            
                b->ptrs.row[stuff_lines] = cva( @lin_msg( 0 ), 37 )
              
            End Scope
        
          Next
      
        End Scope
        
      
      End Sub
      
      


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'' # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
''  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'' "binary object" structures
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'' # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
''  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

      
      

      Sub bin_obj( b As b_data )
        
        
        With b
        
          If .code <> 0 Then
          
            If *.in_ptr = 0 Then
            
              *.out_ptr = 0
              *.in_ptr = Not 0
              
              If .in_sub <> 0 Then
              
                .in_sub( .in_ptr, .out_ptr )
                
              End If
              
            End If
            
          Else
          
            If *.out_ptr = 0 Then
            
              *.in_ptr = 0
              *.out_ptr = Not 0
              
              If .out_sub <> 0 Then
              
                .out_sub( .in_ptr, .out_ptr )
                
              End If
              
            End If
          
          End If
          
        End With
        
      End Sub   


      Sub BinObj_destroy( BinObjDestroy As b_data )
      
        With BinObjDestroy 
        
          clean_Deallocate( .in_ptr )
          clean_Deallocate( .out_ptr )
        
        End With
      
      End Sub
        
      Function init_bin_obj( c As Integer = 0, isp As b_sub = 0, osp As b_sub = 0 ) As b_data
      
        Dim t As b_data
        
        With t

          .code = c

          .in_ptr  = CAllocate( Len( Integer ) )
          .out_ptr = CAllocate( Len( Integer ) )

          .in_sub = isp
          .out_sub = osp
        
        End With
        
        Return t
        
        
      End Function 




Sub minimap_destroy( minimap_local As LL_MiniMapType )

  Dim As Integer i, j

  If minimap_local.room <> 0 Then
  
    For i = 0 To llg( map )->rooms - 1 
      
      For j = 0 To minimap_local.room[i].doors - 1
      
        clean_Deallocate( minimap_local.room[i].door[j].code )
      
      Next
      
      clean_Deallocate( minimap_local.room[i].door ) 
    
    Next
  
    clean_Deallocate( minimap_local.room )
    
  End If
  

End Sub



Sub LLMiniMap_SaveMiniMap( minimap_Local As LL_MiniMapType, fileName As String )


  Dim As Integer ff = FreeFile
  
  Dim As Integer i, j, k
  
  Open fileName For Binary As #ff
    
    With minimap_Local
      For i = 0 To .rooms - 1
      
        With .room[i]
          
          Put #ff, , .location.x
          Put #ff, , .location.y
          Put #ff, , .floor

          Put #ff, , .doors
          
          For j = 0 To .doors - 1
            
            With .door[j]
            
              Put #ff, , .location.x
              Put #ff, , .location.y
              Put #ff, , .codes
              
              For k = 0 To .codes - 1
                
                Put #ff, , .code[k]
              
              Next
              
              Put #ff, , .id
            
            End With
          
          Next
        
        End With
      
      Next
      
    End With  
  
  Close #ff

       
End Sub


Function LLMiniMap_LoadMiniMap( fileName As String, rooms As Integer ) As LL_MiniMapType
  
  
  Dim As LL_MiniMapType res

  Dim As Integer ff = FreeFile
  
  Dim As Integer i, j, k
  
  Open fileName For Binary As #ff
    
    With res
      
      .room = CAllocate( rooms * Len( LL_MiniMapRoomType ) )
      For i = 0 To rooms - 1
      
        With .room[i]
          
          Get #ff, , .location.x
          Get #ff, , .location.y
          Get #ff, , .floor

          Get #ff, , .doors
          
          .door = CAllocate( .doors * Len( LL_MiniMapRoomDoorType ) )
          For j = 0 To .doors - 1
            
            With .door[j]
            
              Get #ff, , .location.x
              Get #ff, , .location.y
              Get #ff, , .codes
              
              If .codes > 0 Then

                .code = CAllocate( .codes * Len( Integer ) )
                For k = 0 To .codes - 1
                  Get #ff, , .code[k]
                
                Next
                
              End If
              
              Get #ff, , .id
            
            End With
          
          Next
        
        End With
      
      Next
      
    End With  
  
  Close #ff
  
  Return res
       
End Function
