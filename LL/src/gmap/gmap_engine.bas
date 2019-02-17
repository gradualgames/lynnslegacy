Option Explicit


#Include "..\headers\ll.bi"



Sub set_up_room_enemies( enemies As Integer, enemy As _char_type Ptr )

  Dim As Integer setup
  
  For setup = 0 To enemies - 1
    '' cycle thru these enemies
    
    With enemy[setup]    

      LLSystem_CopyNewObject( enemy[setup] )
  
    End With
    
  Next
  
       
End Sub

Sub TextControl_Destroy( controlDismantle As _control_type )

  With controlDismantle
  
    .Name = ""  
  
  
  End With
  

End Sub

Sub set_gmap_controls()


  With gmap_global
                             
    .controls = s_NUM_OF_STATES
    .control = CAllocate( Len ( _control_type ) * .controls )



    set_ctrl .control[s_null]          , -1, -1, "null"             , s_null                                                                                                                
    
    set_ctrl .control[s_rooms]         , 34, 53, "Rooms"            , s_rooms, Varptr( llg( this_room.i ) ), Varptr( llg( map )->rooms ), 1, 1
    set_ctrl .control[s_teleports]     , 32, 57, "Teleports"        , s_teleports, Varptr( gmg( tele ).sel ), Varptr( now_room().teleports ), 1, 1
    set_ctrl .control[s_enemies]       , 33, 61, "Enemies"          , s_enemies, Varptr( gmg( enem.sel ) ), Varptr( now_room().enemies ), 1, 1
    set_ctrl .control[s_entries]       , 33, 65, "Entries"          , s_entries, Varptr( gmg( entr.sel ) ), Varptr( llg( map )->entries ), 1, 1
    
    
    set_ctrl .control[s_parallax]      , 32, 69, "Parallax?"        , s_parallax
    set_ctrl .control[s_parallax_image], 45, 69, "Load Para Image"  , s_parallax_image
    
    
    
    set_ctrl .control[s_walkables]     , 48, 57, "Walkables"        , s_walkables
    set_ctrl .control[s_ice]           , 51, 53, "Ice"              , s_ice
    
    
    set_ctrl .control[s_load_map]      , 48, 61, "Load .Map"        , s_load_map
    set_ctrl .control[s_save_map]      , 48, 65, "Save .Map"        , s_save_map
    
    
    
    set_ctrl .control[s_quit]          , 90, 52, "Quit"             , s_quit
    
    
    set_ctrl .control[s_load_tiles]    , -1, -1, "null"             , s_load_tiles
    
    
    
    set_ctrl .control[s_layer_0]       , 71, 37, "Layer 0"          , s_layer_0
    set_ctrl .control[s_layer_1]       , 71, 39, "Layer 1"          , s_layer_1
    set_ctrl .control[s_layer_2]       , 71, 41, "Layer 2"          , s_layer_2
    set_ctrl .control[s_macros]        , 69, 46, "Tile Macros"      , s_macros, Varptr( gmg( macr.sel ) ), Varptr( gmg( macros ) ), 1, 1
    
    
    set_ctrl .control[s_tile_pick]     , -1, -1, "null"             , s_tile_pick
    set_ctrl .control[s_redimension]   , 81, 37, "Room (D)imensions", s_redimension
    
    
    
    set_ctrl .control[s_zoom]          , 0 , 61, "(Z)oom"           , s_zoom
    set_ctrl .control[s_walk_grid]     , 0 , 63, "(W)alk Grid"      , s_walk_grid
    set_ctrl .control[s_solo]          , 0 , 65, "Layer (S)olo"     , s_solo
    set_ctrl .control[s_layer_fill]    , 0 , 67, "Layer Fill"       , s_layer_fill
    set_ctrl .control[s_flood_fill]    , 0 , 69, "Fl(o)od Fill"     , s_flood_fill
    set_ctrl .control[s_tile_grid]     , 0 , 71, "Tile (G)rid"      , s_tile_grid

    
    set_ctrl .control[s_sequence]      , 17, 59, "Sequences"        , s_sequence, Varptr( gmg( seq ).sel ), Varptr( now_room().seq_here ), 1, 1


    set_ctrl gmg( control )[s_sequence_entities], 17, 63, "Entities", s_sequence_entities, Varptr( gmg( seq_ents ).sel ), , 1, 1
    set_ctrl gmg( control )[s_sequence_commands], 17, 67, "Commands", s_sequence_commands, Varptr( gmg( ent_commands ).sel ), , 1, 1
    set_ctrl gmg( control )[s_sequence_command_blocks], 18, 71, "Blocks", s_sequence_command_blocks, Varptr( gmg( blocks ).sel ), , 1, 1
    
  
  
  End With


End Sub


Sub load_previous()

  If Dir( "gmap.ini" ) <> "" Then
    '' ini file here
    
    Dim As Integer ch = FreeFile

    Dim As String mp
    
    Open "gmap.ini" For Input As #ch
    
      Input #ch, mp
      
    Close #ch
    
    If Dir( "data\map\" & mp ) <> "" Then
      '' the ini file has a good map
       
  
      map_Destroy( llg( map ) )
    

      llg( map ) = LLSystem_LoadMap( "data\map\" & mp, -1 )

      new_map_init()      
      
      
    End If
    
  End If

End Sub  


Sub new_map_init()


  llg( this_room.i ) = 0
  With now_room()


    gmg( layer ) = 0
  
    set_ctrl gmg( control )[s_rooms], , , , , , Varptr( llg( map )->rooms )
    set_ctrl gmg( control )[s_entries], , , , , , Varptr( llg( map )->entries )

    gmg( ent_ptr ) = Varptr( now_room().seq_here )
    gmg( seq_ptr ) = now_room().seq
    
    gmg( room.last_sel ) = 0
    new_room_init()

    gmg( entr.sel ) = 0
    
  End With

End Sub



Sub new_room_init()
  
    
  del_room_enemies( llg( map )->room[gmg( room.last_sel )].enemies, llg( map )->room[gmg( room.last_sel )].enemy )
  set_up_room_enemies( now_room().enemies,   now_room().enemy   )

  gmg( ent_ptr ) = Varptr( now_room().enemy[gmg( enem ).sel].seq_here )

  set_ctrl gmg( control )[s_sequence], , , , , , gmg( ent_ptr )
  set_ctrl gmg( control )[s_teleports], , , , , , Varptr( now_room().teleports )
  set_ctrl gmg( control )[s_enemies], , , , , , Varptr( now_room().enemies )
  


  gmg( enem ).sel = 0
  gmg( enem ).last_sel  = gmg( enem.sel )
  gmg( enem ).last_num = now_room().enemies

  gmg( room ).last_sel  = llg( this_room ).i

  gmg( tele ).sel = 0
  gmg( tele ).last_sel  = gmg( tele ).sel
  gmg( tele ).last_num = now_room().teleports

  gmg( blocks ).sel = 0
  gmg( blocks ).last_sel = gmg( blocks ).sel
  
'  gmg( seq_ptr ) = now_room().seq
'
'  If active_sequence_count() <> -1 Then
'    gmg( seq ).last_num  = active_sequence_count()
'    
'  End If
'
'  If gmg( seq_ptr ) <> 0 Then
'    
'    gmg( seq_ents ).last_num  = selected_sequence().ents
'    gmg( ent_commands ).last_num  = selected_sequence().commands
'    gmg( blocks ).last_num = selected_command().ents
'    
'  End If
'

  gmg( seq_ptr ) = 0
  gmg( seq ).last_num = 0
  gmg( seq_ents ).last_num = 0
  gmg( ent_commands ).last_num = 0
  gmg( blocks ).last_num = 0

  erase_sequence_memory()

  llg( this_room.cx ) = 0
  llg( this_room.cy ) = 0
  
  gmg( refresh ) = -1

End Sub


Sub make_null_map()


  llg( map ) = CAllocate( Len( map_type ) )
  
  llg( map )->entry = CAllocate( Len( map_entry_type ) )
  llg( map )->room = CAllocate( Len( room_type ) )
  llg( map )->room->enemy = CAllocate( Len( room_type ) )
  llg( map )->room->teleport = CAllocate( Len( teleport_type ) )
  llg( map )->room->layout = CAllocate( Len( Integer ) * 3 )
  llg( map )->room->layout[0] = CAllocate( Len( Integer ) )
  llg( map )->room->layout[1] = CAllocate( Len( Integer ) )
  llg( map )->room->layout[2] = CAllocate( Len( Integer ) )

'  llg( map )->tileset->filename = "data\pictures\tiles\ruins.spr"  
  llg( map )->tileset = CAllocate( Len( LLSystem_ImageHeader Ptr ) )
  
  llg( map )->tileset = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\tiles\ruins.spr" ) )
  
  
End Sub



Function cursor_on_tiles() As Integer 


  If fb_Global.mouse.x > llg( sx ) - 256 Then


    If fb_Global.mouse.y > 0 Then 

  
      If fb_Global.mouse.x < llg( sx ) Then

    
        If fb_Global.mouse.y < 256 Then 

          Return Not 0
          
        End If
      End If
    End If
  End If
     
     
End Function




Sub clear_layer_ice ( l As Integer )

  
  Dim As Integer iter
  For iter = 0 To ( now_room().x ) * ( now_room().y )

    If l = -1 Then
      now_room().layout[0][iter] Or= tile_ice 
    Else
      now_room().layout[0][iter] And= 130815 '' bow to 1 and 0
    End If
    
  Next
  

End Sub














Sub gmap_input()

  fb_GetMouse()   
  fb_GetKey()   

  GetMouse fb_Global.mouse.x, fb_Global.mouse.y, fb_Global.mouse.w, fb_Global.mouse.b

  gmg( current_box ) = ProcPtr( regular_box )

  
  If gmg( _state ) = s_null Then 
  
    Select Case gmg( layer )
      Case 0
        gmg( _state ) = s_layer_0
  
      Case 1
        gmg( _state ) = s_layer_1
  
      Case 2
        gmg( _state ) = s_layer_2
        
    End Select
  
  
  End If
  
  If fb_Global.mouse.x < 0 Then
    gmg( hotkey ) = 0
    
  Else 
    gmg( hotkey ) = 1
    
  End If

  If ( fb_Global.mouse.b And sc_rightbutton ) Then

    If cursor_on_tiles Then
      '' right clicked tileset

      gmg( _state ) = s_load_tiles
      hold_button( sc_rightbutton )
      fb_Global.mouse.b = 0
      
    End If
  End If

  
  If ( fb_Global.mouse.b And sc_rightbutton ) Then
    '' right clicked

    If on_control( s_ice ) Then      
    
      '' on ice control, clear ice.
      
      Scope 
        Dim As String inpu
        ScreenSet 0, 0
        Cls
        Input "Clear ice? (Y/N) ", inpu
        If LCase( inpu ) = "y" Then
          clear_layer_ice ( 0 )
          
        Else
          Input "Full ice? (Y/N) ", inpu
          If LCase( inpu ) = "y" Then
            clear_layer_ice ( -1 )
            
          End If
        
          
        End If
        
        
      End Scope  
      
      
      

      hold_button( sc_rightbutton )
      
    End If
  
  End If


  If ( fb_Global.mouse.b And sc_leftbutton ) Then

    If cursor_on_tiles Then 
    
      If ( gmg( _state ) <> s_layer_0 ) And ( gmg( _state ) <> s_layer_0 ) And ( gmg( _state ) <> s_layer_0 ) And ( gmg( _state ) <> s_macros And gmg( _state ) <> s_flood_fill ) Then
        Select Case gmg( layer )
          Case 0
            gmg( _state ) = s_layer_0
      
          Case 1
            gmg( _state ) = s_layer_1
      
          Case 2
            gmg( _state ) = s_layer_2
            
        End Select
        
      End If
      
    End If

  End If


  If now_room().parallax <> 0 Then 
    '' sense for the open parallax image control

    Locate gmg( control )[s_parallax_image].y, gmg( control )[s_parallax_image].x
    ? gmg( control )[s_parallax_image].Name
    
    If ( fb_Global.mouse.b And sc_leftbutton ) Then 
      
      If on_control( s_parallax_image ) Then
        gmg( _state ) = s_parallax_image
              
      End If

    End If                                  
    
  End If


  If ( fb_Global.mouse.b And sc_leftbutton ) Then 

    If gmg( _state ) = s_macros Then

      If on_control( s_walkables ) Then
        
        If gmg( macros ) <> 0 Then
          handle_macros( -1 )
          
          hold_button( sc_leftbutton )
          
        End If
      
      End If

    End If

  End If                                  



  If gmg( hotkey ) <> 0 Then


    ''arrow key movement
    If Not ( sc_shift() ) And Not MultiKey( sc_control ) Then
    
      If MultiKey( llg( r_key.code ) ) Then llg( this_room.cx ) += 16: gmg( refresh ) = -1
      If MultiKey( llg( l_key.code ) ) Then llg( this_room.cx ) -= 16: gmg( refresh ) = -1
      If MultiKey( llg( u_key.code ) ) Then llg( this_room.cy ) -= 16: gmg( refresh ) = -1
      If MultiKey( llg( d_key.code ) ) Then llg( this_room.cy ) += 16: gmg( refresh ) = -1
  
    End If
  
    If MultiKey( sc_0 ) Then 

      gmg( layer ) = 0

      If ( gmg( _state ) = s_layer_0 ) Or ( gmg( _state ) = s_layer_1 ) Or ( gmg( _state ) = s_layer_2 ) Then 
        gmg( _state ) = s_layer_0
        
      End If

      gmg( refresh ) = -1

    End If
    
    If MultiKey( sc_1 ) Then 

      gmg( layer ) = 1

      If ( gmg( _state ) = s_layer_0 ) Or ( gmg( _state ) = s_layer_1 ) Or ( gmg( _state ) = s_layer_2 ) Then 
        gmg( _state ) = s_layer_1
        
      End If

      gmg( refresh ) = -1

    End If
    
    If MultiKey( sc_2 ) Then 

      gmg( layer ) = 2

      If ( gmg( _state ) = s_layer_0 ) Or ( gmg( _state ) = s_layer_1 ) Or ( gmg( _state ) = s_layer_2 ) Then 
        gmg( _state ) = s_layer_2
        
      End If

      gmg( refresh ) = -1

    End If
  
    If MultiKey( sc_control ) And MultiKey( sc_s ) Then 
      handle_save( -1 )
      gmg( _state ) = gmg( state.last_sel )


    End If

    With gmg( room_down_key )
      bin_obj( Type( MultiKey( .code ), .in_ptr, .out_ptr, .in_sub, .out_sub ) )
      
    End With
    With gmg( room_up_key )
      bin_obj( Type( MultiKey( .code ), .in_ptr, .out_ptr, .in_sub, .out_sub ) )
      
    End With
  

    With gmg( zoom_key )
      bin_obj( Type( MultiKey( .code ), .in_ptr, .out_ptr, .in_sub, .out_sub ) )
      
    End With

    If Not MultiKey( sc_control ) Then
      With gmg( solo_key )
        bin_obj( Type( MultiKey( .code ), .in_ptr, .out_ptr, .in_sub, .out_sub ) )
        
      End With
      
    End If
    
    With gmg( grid_key )
      bin_obj( Type( MultiKey( .code ), .in_ptr, .out_ptr, .in_sub, .out_sub ) )
      
    End With
    With gmg( w_grid_key )
      bin_obj( Type( MultiKey( .code ), .in_ptr, .out_ptr, .in_sub, .out_sub ) )
      
    End With
    With gmg( redim_key )
      bin_obj( Type( MultiKey( .code ), .in_ptr, .out_ptr, .in_sub, .out_sub ) )
      
    End With
    With gmg( flood_key )
      bin_obj( Type( MultiKey( .code ), .in_ptr, .out_ptr, .in_sub, .out_sub ) )
      
    End With

    With gmg( hide_key )
      bin_obj( Type( MultiKey( .code ), .in_ptr, .out_ptr, .in_sub, .out_sub ) )
      
    End With

  End If



  show_ctrls gmg( controls ), gmg( control )
  sense_ctrls gmg( controls ), gmg( control )

  
  ctrl_exceptions()




  If fb_Global.mouse.x <> -1 Then 
    '' the mouse is in the window.
  
    If fb_Global.mouse.b And sc_rightbutton Then 
      '' right-clicked.

      '' reset the state to idle.
      
      
      Select Case gmg( layer )
        Case 0
          gmg( _state ) = s_layer_0
        Case 1
          gmg( _state ) = s_layer_1
        Case 2
          gmg( _state ) = s_layer_2
          
      End Select
      
    End If
    
  End If
    

                                                            


  If ( gmg( enem ).sel <> gmg( enem ).last_sel ) Or ( gmg( entr ).sel <> gmg( entr ).last_sel ) Or llg( this_room ).i <> gmg( room ).last_sel Then
    erase_sequence_memory()

    
  End If



  Select Case gmg( _state )
  
    Case s_enemies
      gmg( ent_ptr ) = Varptr( now_room().enemy[gmg( enem ).sel].seq_here )
      gmg( seq_ptr ) = now_room().enemy[gmg( enem ).sel].seq

    Case s_entries
      gmg( ent_ptr ) = Varptr( llg( map )->entry[gmg( entr ).sel].seq_here )
      gmg( seq_ptr ) = llg( map )->entry[gmg( entr ).sel].seq
      
    
    Case s_sequence_entities, s_sequence_commands, s_sequence_command_blocks, s_sequence, s_save_map
    
    Case Else
      gmg( ent_ptr ) = Varptr( now_room().seq_here )
      gmg( seq_ptr ) = now_room().seq
    
      
    
  End Select

  set_ctrl gmg( control )[s_sequence], , , , , , gmg( ent_ptr )

  
  If gmg( seq_ptr ) <> 0 Then
  
    set_ctrl gmg( control )[s_sequence_entities], , , , , , Varptr( selected_sequence().ents )
    set_ctrl gmg( control )[s_sequence_commands], , , , , , Varptr( selected_sequence().commands )
  
    If selected_sequence().commands <> 0 Then
      set_ctrl gmg( control )[s_sequence_command_blocks], , , , , , Varptr( selected_command().ents )
      
    End If
    
  End If  




End Sub


Sub gmap_history()
  If gmg( _state ) <> s_teleports Then 
'        handle_teleports( -1 ) '' reset tel_state

    
  End If

  gmg( enem ).last_sel  = gmg( enem.sel )
  gmg( entr ).last_sel  = gmg( entr.sel )
  gmg( macr ).last_sel  = gmg( macr.sel )
  gmg( room ).last_sel  = llg( this_room ).i
  gmg( state ).last_sel = gmg( _state )
  gmg( tele ).last_sel  = gmg( tele ).sel

  gmg( seq ).last_sel  = gmg( seq ).sel
  gmg( seq_ents ).last_sel  = gmg( seq_ents ).sel
  gmg( ent_commands ).last_sel  = gmg( ent_commands ).sel
  gmg( blocks ).last_sel = gmg( blocks ).sel

  gmg( enem ).last_num = now_room().enemies
  gmg( entr ).last_num = llg( map )->entries
  gmg( macr ).last_num = gmg( macros )
  gmg( room ).last_num = llg( map )->rooms
  gmg( tele ).last_num = now_room().teleports



  If active_sequence_count() <> -1 Then
    gmg( seq ).last_num  = active_sequence_count()
    
  End If

  If gmg( seq_ptr ) <> 0 Then
    
    gmg( seq_ents ).last_num  = selected_sequence().ents
    gmg( ent_commands ).last_num  = selected_sequence().commands
    gmg( blocks ).last_num = selected_command().ents

  End If

  gmg( wheel ).last_sel = fb_Global.mouse.w



  
End Sub



Private Sub get_jump_room()

  Dim As Integer ene_ver
  
  Dim As String tmp_id

  Do
  
    Locate 54, 77
    ? space( 3 )

    ScreenSet 0, 0  
    Locate 54, 77, 1
    
  
    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < 0 Then ene_ver = 0
    If Val( tmp_id ) > llg( map )->rooms - 1 Then ene_ver = 0
    
  Loop Until ene_ver <> 0
  
  llg( this_room ).i = Val( tmp_id )
  new_room_init()

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope



End Sub


Sub blit_box_core()
  Dim As Integer hah
  hah = 0

  Locate 52, 63

  ? "tileset: " & kfe( kfp( llg( map )->tileset->filename ) )
                 
  Locate 53 + hah, 62
  ? Chr( 218 ) & String( 33, 196 ) & Chr( 191 )
  For hah = 1 To 18
    Locate 53 + hah, 62
    ? Chr( 179 ) & Space( 33 ) & Chr( 179 )
  Next
  Locate 53 + hah, 62
  ? Chr( 192 ) & String( 33, 196 ) & Chr( 217 )
  
  Locate 73, 63
  ? "fps:"; llg( fps_hold ), fb_Global.mouse.w
  
  

  Dim As String gMapCRPolish
  gMapCRPolish = "Current Room: " & llg( this_room ).i & space( 3 - Len( Str( llg( this_room ).i ) ) ) & Chr( 179 )

  
  setup_bounds( 54, 63, gMapCRPolish )
                 
  click_bounds( get_jump_room() )


  Locate 53, 63 + Len( gMapCRPolish ) - 1
  ? Chr( 194 )

  Locate 55, 62
  ? Chr( 195 )

  Locate 55, 63
  ? String( Len( gMapCRPolish ) - 1, 196 ) & Chr( 217 )
  
  
  Locate 54, 82
  
  If Fre \ 1048576 < 100 Then
    ? Fre \ 1024 & " k free " '& "(" & get_mem_bank_length & ") alloc'd"
    
  Else
    ? Fre \ 1048576 & " M free " '& "(" & get_mem_bank_length & ") alloc'd"
    
  End If
  
  Locate 73, 72
'    ? "Filename: " & kfp( llg( map )->filename )



  Locate 59, 17
  
  
  
  
  

End Sub


Sub ctrl_exceptions ()


  If gmg( _state ) <> s_parallax Then 
    
    If ( gmg( _state ) <> s_zoom ) And ( gmg( _state ) <> s_walk_grid ) And ( gmg( _state ) <> s_solo ) Then 
      do_ctrl gmg( control )[gmg( _state )]
      
    End If
    
  End If

             
  If now_room().parallax <> 0 Then
    
    do_ctrl gmg( control )[s_parallax]
    
  End If
             
             
  If gmg( zooming ) <> 0 Then
    
    do_ctrl gmg( control )[s_zoom]
    
  End If
             
             
  If gmg( w_grid ) <> 0 Then
    
    do_ctrl gmg( control )[s_walk_grid]
    
  End If
             
             
  If gmg( solo ) <> 0 Then
    
    do_ctrl gmg( control )[s_solo]
    
  End If
             
  If gmg( grid ) <> 0 Then
    
    do_ctrl gmg( control )[s_tile_grid]
    
  End If


End Sub




Sub blit_map_img ()

  If llg( map )->rooms = 0 Then Exit Sub

  If gmg( zooming ) <> 0 Then
    '' zoomed in version
    
    Put ( 0, 0 ), Varptr( gmg( b_img[0][0] ) ), Trans 
    Put ( 0, 0 ), Varptr( gmg( b_img[1][0] ) ), Trans 

  Else
    '' regular size
    
    Put ( 0, 0 ), Varptr( gmg( r_img[0][0] ) ), Trans 
    Put ( 0, 0 ), Varptr( gmg( r_img[1][0] ) ), Trans 
      
  End If       

       
End Sub


Sub clear_layers ()


  Dim As Integer c

    For c = 0 To 2    
      MemSet( Varptr( gmg( r_img[c][0] ) ), 0, ( gmg( map_area.x ) ) * ( gmg( map_area.y ) ) + 4 )
      
    Next


End Sub

Sub calc_map ()


  gmg( area_reflect.x ) = gmg( map_area.x ) \ ( Abs( gmg( zooming ) ) + 1 )
  gmg( area_reflect.y ) = gmg( map_area.y ) \ ( Abs( gmg( zooming ) ) + 1 )

  update_cam_g()
  
  With now_room()
  
    If .x < gmg( area_reflect.x ) \ 16 Then 
      gmg( grid_mat.x ) = .x 
    
    Else 
      gmg( grid_mat.x ) = gmg( area_reflect.x ) \ 16
    
    End If
    
    If .y < gmg( area_reflect.y ) \ 16 Then 
      gmg( grid_mat.y ) = .y 
    
    Else 
      gmg( grid_mat.y ) = gmg( area_reflect.y ) \ 16 
      
    End If
    
  End With


End Sub    



Sub update_cam_g()

  '' Shl 4 = 16 = ( tileset size )
  
  If llg( this_room.cx ) > ( now_room().x Shl 4 ) - gmg( area_reflect.x ) Then  
    llg( this_room.cx ) = ( now_room().x Shl 4 ) - gmg( area_reflect.x )  
  
  End If
   
                           
  If llg( this_room.cy ) > ( now_room().y Shl 4 ) - gmg( area_reflect.y ) Then
    llg( this_room.cy ) = ( now_room().y Shl 4 ) - gmg( area_reflect.y )      
    
  End If


  If llg( this_room.cx ) < 0 Then llg( this_room.cx ) = 0
  If llg( this_room.cy ) < 0 Then llg( this_room.cy ) = 0


End Sub





Sub store_map()

  Dim As Integer l_layer

  For l_layer = 0 To 2

    gMapEngine_BlitLayer( l_layer, Varptr( gmg( r_img[l_layer][0] ) ), ( Not gmg( solo ) ) Or ( l_layer = gmg( layer ) ), gmg( area_reflect.x ), gmg( area_reflect.y ) )

  Next

  If gmg( zooming ) <> 0 Then


    For l_layer = 0 To 2
  
      Block2x( Varptr( gmg( r_img[l_layer][0] ) ), Varptr( gmg( b_img[l_layer][0] ) ), gmg( area_reflect.x ), gmg( area_reflect.y ) )
      
    Next
    

  End If


End Sub



Sub Block2x ( img As Any Ptr, newimg As Any Ptr, w As Integer = 16, h As Integer = 16 ) 


  Dim As uShort Ptr lbf
  Dim As uByte Ptr imglook, newimglook

  Dim As Integer x, y, x2, y2, i, j

  Dim As Integer im_dex, im_dex2
  
  Dim As Integer b_opt, w_opt, y_opt
  
  imglook = img
  newimglook = newimg
  
  lbf = newimg     
                        
  lbf[0] = w Shl 4
  lbf[1] = h Shl 1


  w_opt = w Shl 1

  
  For y = 0 To (H - 1)

    For x = 0 To (W - 1)
      

      im_dex = (y_opt + x) + 4
      
      b_opt = (y_opt Shl 2) + (x Shl 1) + 4
      newimglook[b_opt]     =  imglook[im_dex]
      newimglook[b_opt + 1] =  imglook[im_dex]
      
      b_opt +=  w_opt 
      newimglook[b_opt]     =  imglook[im_dex]
      newimglook[b_opt + 1] =  imglook[im_dex]

      

     Next x

     y_opt += w

  Next y
  


End Sub



Sub blit_tiles ()


  Dim As Integer _ 
    c_tile     , _ 
    l_tileset_x, _ 
    l_tileset_y
      
    c_tile = 0
    

    For l_tileset_y = 0 To 240 Step 16
  
      For l_tileset_x = 0 To 240 Step 16
  
        Put( l_tileset_x + gmg( tile_loc.x ), l_tileset_y + gmg( tile_loc.y ) ), Varptr( llg( map )->tileset->image[c_tile * llg( map )->tileset->arraysize] )
        c_tile += 1
  
      Next
      
    Next
    

End Sub







Sub make_null_room( r As room_type Ptr, flg As uInteger )

  

  If Bit( flg, 0 ) = 0 Then
    '' no_alloc flag not set
    
    r = CAllocate( Len( room_type ) )
    
  End If


  With *r

'    .para_img.filename = ""
  
    .teleport = CAllocate( Len( teleport_type ) )
    .enemy    = CAllocate( Len( _char_type    ) )

    .layout   = CAllocate( Len( Integer Ptr   ) * 3 )
    .layout[0] = CAllocate( Len( Integer ) )
    .layout[1] = CAllocate( Len( Integer ) )
    .layout[2] = CAllocate( Len( Integer ) ) 
    
'    quick_text( .teleports )
    

  End With


End Sub  


Function cursor_on_map() As Integer


  If fb_Global.mouse.x > -1 Then
    If fb_Global.mouse.y > -1 Then
      If fb_Global.mouse.x < gmg( grid_mat.x ) Shl 4 * z_factor Then
        If fb_Global.mouse.y < gmg( grid_mat.y ) Shl 4 * z_factor Then 
'      If fb_Global.mouse.x < gmg( map_area ).x Then
'        If fb_Global.mouse.y < gmg( map_area ).y Then 
          Return Not 0
          
        End If
      End If
    End If
  End If

     
     
End Function




Function get_selected_tile() As Integer


  Dim As Integer _x, _y
  

    _x = fb_Global.mouse.x - ( llg( sx ) - 256 )


    _y = fb_Global.mouse.y - ( 0 )

  
    _x \= 16
    _y \= 16
  
    Return ( _y ) * 16 + _x 
    

End Function


Sub draw_macro_grid(  )

  Dim As Integer x_grid, y_grid




  Line ( gmg( mac_loc ).x, gmg( mac_loc ).y ) - ( gmg( mac_loc ).x + 96, gmg( mac_loc ).y + 96 ) , 15, b




  For y_grid = gmg( mac_loc ).x To ( gmg( mac_loc ).x + 96 ) Step 16 


    Line ( y_grid, gmg( mac_loc ).y )-( y_grid, ( gmg( mac_loc ).y + 96 ) ), 15, bf

    
  Next
  

  For x_grid = gmg( mac_loc ).y To ( gmg( mac_loc ).y + 96 ) Step 16 


    Line ( gmg( mac_loc ).x, x_grid )-( ( gmg( mac_loc ).x + 96) , x_grid ), 15, bf

    
  Next
  

End Sub


Sub show_selected_tile()


'  Line ( ( llg( sx ) - 256 ) + ( gmg( tile ) Mod ( 16 )) * 16, _ 
'(( gmg( tile ) \ 16 ) * 16 ) )- _ 
' ( ( llg( sx ) - 256 ) + ( gmg( tile ) Mod ( 16 )) * 16 + 15, _ 
'(( gmg( tile ) \ 16 ) * 16 ) + 15 ), 15, b

  Line ( ( llg( sx ) - 256 ) + ( gmg( tile ) And 15 ) Shl 4, _ 
(( gmg( tile ) Shr 4 ) Shl 4 ) )- _ 
 ( ( llg( sx ) - 256 ) + ( gmg( tile ) And 15 ) Shl 4 + 15, _ 
(( gmg( tile ) Shr 4 ) Shl 4 ) + 15 ), 15, b

End Sub


Sub get_selected_layer()
  
  Dim As Integer wtf( 2 ), omg, lol

  If fb_Global.mouse.x <> -1 Then
    
    If fb_Global.mouse.b And sc_leftbutton Then
      wtf( 0 ) = on_control( s_layer_0 )
      wtf( 1 ) = on_control( s_layer_1 )
      wtf( 2 ) = on_control( s_layer_2 )
      
    End If
    
    For lol = 0 To 2
      If wtf( lol ) Then omg = lol + 1
      
    Next
    
    
    
    
    

    Select Case omg
      Case 1
        gmg( layer ) = 0
        gmg( refresh ) = -1

      Case 2
        gmg( layer ) = 1
        gmg( refresh ) = -1

      Case 3
        gmg( layer ) = 2
        gmg( refresh ) = -1
        

    End Select
        
  End If


End Sub


Sub macro_wall()

  Dim As Integer top_wall, right_wall, bottom_wall, left_wall

  With now_room()

    For top_wall = 0 To .x - 1                                                                
      .layout[1][top_wall]                          = gmg( macro )[gmg( macr ).sel][2]                                     

      .layout[1][.x + top_wall]                     = gmg( macro )[gmg( macr ).sel][8] 
      .layout[1][.x + top_wall] Or= lowerleft
      .layout[1][.x + top_wall] Or= lowerright
                                                                                                                         
    Next                                                                                                                 
    For right_wall = 0 To .y - 1                                                              
      .layout[1][right_wall * .x + ( .x - 2 )]      = gmg( macro )[gmg( macr ).sel][15] 
      .layout[1][right_wall * .x + ( .x - 2 )] Or= upperleft
      .layout[1][right_wall * .x + ( .x - 2 )] Or= lowerleft
      
      .layout[1][right_wall * .x + ( .x - 1 )]      = gmg( macro )[gmg( macr ).sel][16]
                                                                                                                         
    Next                                                                                                                 
    For bottom_wall = 0 To .x - 1                                                             
      .layout[1][( ( .y - 2 ) * .x ) + bottom_wall] = gmg( macro )[gmg( macr ).sel][20]                            
      .layout[1][( ( .y - 2 ) * .x ) + bottom_wall] Or= upperleft
      .layout[1][( ( .y - 2 ) * .x ) + bottom_wall] Or= upperright

      .layout[1][( ( .y - 1 ) * .x ) + bottom_wall] = gmg( macro )[gmg( macr ).sel][26]                              
                                                                                                                       
    Next                                                                                                               
    For left_wall = 0 To .y - 1                                                             
      .layout[1][left_wall * .x]                    = gmg( macro )[gmg( macr ).sel][12] 

      .layout[1][left_wall * .x + 1 ]               = gmg( macro )[gmg( macr ).sel][13] 
      .layout[1][left_wall * .x + 1 ] Or= upperright
      .layout[1][left_wall * .x + 1 ] Or= lowerright
                                                                                                                    
    Next                                                                                                            
  
  
                                                                                                                  
    .layout[1][0]                            = gmg( macro )[gmg( macr ).sel][0]
    .layout[1][1]                            = gmg( macro )[gmg( macr ).sel][1]
    .layout[1][0 + .x]                       = gmg( macro )[gmg( macr ).sel][6] 

    .layout[1][1 + .x]                       = gmg( macro )[gmg( macr ).sel][7] 
    .layout[1][1 + .x] Or= lowerright


                                                                                                                     
    .layout[1][.x - 2]                       = gmg( macro )[gmg( macr ).sel][3]
    .layout[1][.x - 1]                       = gmg( macro )[gmg( macr ).sel][4] 

    .layout[1][.x - 2 + .x]                  = gmg( macro )[gmg( macr ).sel][9]
    .layout[1][.x - 2 + .x] Or= lowerleft

    .layout[1][.x - 1 + .x]                  = gmg( macro )[gmg( macr ).sel][10]


                                                                                                                    
    .layout[1][( .y - 2 ) * .x]              = gmg( macro )[gmg( macr ).sel][18]

    .layout[1][( .y - 2 ) * .x + 1]          = gmg( macro )[gmg( macr ).sel][19] 
    .layout[1][( .y - 2 ) * .x + 1] Or= upperright

    .layout[1][( .y - 1 ) * .x]              = gmg( macro )[gmg( macr ).sel][24] 

    .layout[1][( .y - 1 ) * .x + 1]          = gmg( macro )[gmg( macr ).sel][25]


                                                                                                           
    .layout[1][( .y - 2 ) * .x + ( .x - 2 )] = gmg( macro )[gmg( macr ).sel][21]
    .layout[1][( .y - 2 ) * .x + ( .x - 2 )] Or= upperleft

    .layout[1][( .y - 2 ) * .x + ( .x - 1 )] = gmg( macro )[gmg( macr ).sel][22] 

    .layout[1][( .y - 1 ) * .x + ( .x - 2 )] = gmg( macro )[gmg( macr ).sel][27]

    .layout[1][( .y - 1 ) * .x + ( .x - 1 )] = gmg( macro )[gmg( macr ).sel][28]

  End With
                                                                                                         
  gmg( refresh ) = -1 


End Sub


Sub blit_para_img ()

  Dim As vector_Integer rbound
  
  rbound.x = gmg( grid_mat ).x Shl 4
  rbound.y = gmg( grid_mat ).y Shl 4
  
  rbound.x = IIf( gmg( zooming ) <> 0, rbound.x Shl 1, rbound.x )
  rbound.y = IIf( gmg( zooming ) <> 0, rbound.y Shl 1, rbound.y )
  
  If now_room().parallax <> 0 Then

    View Screen( 0, 0 )-( ( rbound.x ) - 1, ( rbound.y ) - 1 ) 
      
      If now_room().para_img <> 0 Then
      
        
        If now_room().para_img->image <> 0 Then

          If gmg( zooming ) <> 0 Then

            Dim As Any Ptr myPic = ImageCreate( now_room().para_img->x Shl 1, now_room().para_img->y Shl 1 )
            Block2x( now_room().para_img->image, myPic, now_room().para_img->x, now_room().para_img->y )
        
            Put( 0 - ( llg( this_room.cx ) \ 12 ), 0 - ( llg( this_room.cy ) \ 12 ) ), myPic
            ImageDestroy( myPic )
            
          Else
          
            Put( 0 - ( llg( this_room.cx ) \ 12 ), 0 - ( llg( this_room.cy ) \ 12 ) ), now_room().para_img->image
          
          End If
          
        End If
        
      End If
      


    View Screen( 0, 0 )-( llg( sx ) - 1, llg( sy ) - 1 ) 

  End If


End Sub



Sub blit_walk_grid ()


  Dim As Integer _ 
    w_xgrid    , _
    w_ygrid
    

  If gmg( w_grid ) Then

    For w_ygrid = 0 To gmg( grid_mat.x ) * llg( map )->tileset->x * z_factor Step 8 * z_factor
      Line (w_ygrid, 0)-(w_ygrid -gmg( zooming ), gmg( grid_mat.y ) * llg( map )->tileset->y * z_factor ), 15, bf
      
    Next
    
    For w_xgrid = 0 To gmg( grid_mat.y ) * llg( map )->tileset->y * z_factor Step 8 * z_factor
      Line (0, w_xgrid)-(gmg( grid_mat.x ) * llg( map )->tileset->x * z_factor, w_xgrid-gmg( zooming ) ), 15, bf
      
    Next
  
'    For w_ygrid = 0 To gmg( grid_mat.x ) Shl 4 * z_factor Step 8 * z_factor
'      Line (w_ygrid, 0)-(w_ygrid -gmg( zooming ), gmg( grid_mat.y ) Shl 4 * z_factor ), 15, bf
'      
'    Next
'    
'    For w_xgrid = 0 To gmg( grid_mat.y ) Shl 4 * z_factor Step 8 * z_factor
'      Line (0, w_xgrid)-(gmg( grid_mat.x ) Shl 4 * z_factor, w_xgrid-gmg( zooming ) ), 15, bf
'      
'    Next
  
  End If
       
       
End Sub


Sub blit_grid ()


  Dim As Integer _ 
    w_xgrid    , _
    w_ygrid


  If gmg( grid ) Then

    For w_ygrid = 0 To gmg( grid_mat.x ) * llg( map )->tileset->x * z_factor Step 16 * z_factor
      Line ( w_ygrid, 0 )-( w_ygrid -gmg( zooming ), gmg( grid_mat.y ) * llg( map )->tileset->y * z_factor ), 15, bf
      
    Next
    
    For w_xgrid = 0 To gmg( grid_mat.y ) * llg( map )->tileset->y * z_factor Step 16 * z_factor
      Line( 0, w_xgrid )-( gmg( grid_mat.x ) * llg( map )->tileset->x *  z_factor, w_xgrid-gmg( zooming ) ), 15, bf
      
    Next
  
'    For w_ygrid = 0 To gmg( grid_mat.x ) Shl 4 * z_factor Step 16 * z_factor
'      Line ( w_ygrid, 0 )-( w_ygrid -gmg( zooming ), gmg( grid_mat.y ) Shl 4 * z_factor ), 15, bf
'      
'    Next
'    
'    For w_xgrid = 0 To gmg( grid_mat.y ) Shl 4 * z_factor Step 16 * z_factor
'      Line( 0, w_xgrid )-( gmg( grid_mat.x ) Shl 4 *  z_factor, w_xgrid-gmg( zooming ) ), 15, bf
'      
'    Next
  
  End If
  

End Sub




Sub blit_text ()


  Locate 36, 84 
  
    ? String( 4 - Len ( Str( now_room().x )), "0" ) & now_room().x & " / " +  String ( 4 - Len ( Str( now_room().y )), "0" ) + Str( now_room().y )


  If cursor_on_map Then 


    If ( llg( this_room.cx ) + fb_Global.mouse.x \ z_factor ) Mod ( 8 ) = 0 Then 
      Locate 52, 1
        
        ?  " x is aligned on 8. " '' if ll_cam_x is lined up
  
    End If
    
    If ( llg( this_room.cx ) + fb_Global.mouse.x \ z_factor ) Mod ( 16 ) = 0 Then 
      Locate 52, 1
        
        ? " x is aligned on 16." '' if ll_cam_x is lined up
  
    End If
  
  
    If ( llg( this_room.cy ) + fb_Global.mouse.y \ z_factor ) Mod ( 8 ) = 0 Then 
      Locate 53, 1
      
        ?  " y is aligned on 8. " '' if ll_cam_y is lined up
  
    End If
  
    If ( llg( this_room.cy ) + fb_Global.mouse.y \ z_factor ) Mod ( 16 ) = 0 Then 
      Locate 53, 1
        
        ? " y is aligned on 16." '' if ll_cam_y is lined up
  
    End If
  

    
    Scope
    
      Dim As String tidy_str
      
        tidy_str = ""
      
        tidy_str += "Map    x "
        tidy_str += String ( 4 - Len( Str( llg( this_room.cx ) + fb_Global.mouse.x \ z_factor ) ), "0" )
        tidy_str += Str( llg( this_room.cx ) + fb_Global.mouse.x \ z_factor)
        tidy_str += "   y "
        tidy_str += String ( 4 - Len( Str( llg( this_room.cy ) + fb_Global.mouse.y \ z_factor ) ), "0" )
        tidy_str += Str( llg( this_room.cy ) + fb_Global.mouse.y \ z_factor)
    
    
        Locate 55
        
          ? tidy_str
  
        
        tidy_str = ""
        
        tidy_str += "Tile   x "
        tidy_str += String ( 4 - Len( Str( ( llg( this_room.cx ) + fb_Global.mouse.x \ z_factor) \ 16 ) ), "0" )
        tidy_str += Str( ( llg( this_room.cx ) + fb_Global.mouse.x \ z_factor) \ 16)
        tidy_str += "   y "
        tidy_str += String ( 4 - Len( Str( ( llg( this_room.cy ) + fb_Global.mouse.y \ z_factor) \ 16 ) ), "0" )
        tidy_str += Str( ( llg( this_room.cy ) + fb_Global.mouse.y \ z_factor) \ 16)
      
        
        Locate 56

          ? tidy_str


    End Scope


    
    
  End If



End Sub




Sub gmap_gfx() 

  Static As Double w_flash, w_time, titlerefresh

  If titlerefresh = 0 Then
    WindowTitle "gMap Editor - " & kfp( llg( map )->filename )

    titlerefresh = Timer + .8
    
  End If
  
  If Timer > titlerefresh Then
    titlerefresh = 0
    
  End If

  If gmg( refresh ) <> 0 Then

    clear_layers()

    calc_map()
    store_map()
    
    '' lock until refresh is needed  
    gmg( refresh ) = 0
  
  End If

   '' parallax 
  blit_para_img()
  '' regular map layers
  blit_map_img ()
  

  '' helper grids
  blit_walk_grid()
  blit_grid()

  '' display the tileset
  blit_tiles()

  '' display text
  blit_text()

  blit_box_core()

  If gmg( current_box ) <> 0 Then
    gmg( current_box )()
    
  End If
  
  Select Case gmg( _state )
  
    Case s_macros
      
      Scope
      
        draw_macro_grid ()
      
      
        If gmg( shifted ) Then
      
          If gmg( blockshift ) Then 
            Line( ( ( gmg( smaller ).x ) * 16 ) +      gmg( tile_loc.x ), ( ( gmg( smaller ).y ) * 16 ) +      gmg( tile_loc.y ) )-_
                ( ( ( gmg( bigger ).x )  * 16 ) + 15 + gmg( tile_loc.x ), ( ( gmg( bigger ).y )  * 16 ) + 15 + gmg( tile_loc.y ) ), 15, b
      
          Else
            Line( ( ( gmg( tile_grasp ).x ) * 16 ) +      gmg( tile_loc.x ), ( ( gmg( tile_grasp ).y ) * 16 ) +      gmg( tile_loc.y ) )-_
                ( ( ( gmg( tile_grasp ).x ) * 16 ) + 15 + gmg( tile_loc.x ), ( ( gmg( tile_grasp ).y ) * 16 ) + 15 + gmg( tile_loc.y ) ), 15, b
      
          End If
      
        Else
          show_selected_tile
      
        End If
        
        Scope
      
          Dim As Integer _
            show_macrox, _ 
            show_macroy, _ 
            sx_opt = gmg( mac_loc ).x, _ 
            sy_opt = gmg( mac_loc ).y, _ 
            x_opt, _ 
            y_opt, _ 
            y_opt2
          
          For show_macroy = 0 To 5
          
            For show_macrox = 0 To 5
              Put ( sx_opt + x_opt, sy_opt + y_opt ), Varptr( llg( map )->tileset->image[( gmg( macro )[gmg( macr.sel )][( y_opt2 + show_macrox )] And 255 ) * llg( map )->tileset->arraysize] )
                                      
              x_opt += 16
          
            Next
      
            
            x_opt = 0
            y_opt += 16
            y_opt2 += 6
          
          Next
        
        End Scope


        If w_time = 0 Then
        
          w_flash Xor= 1
          w_time = Timer + .01
          
        End If
        If Timer > w_time Then w_time = 0
        
        
        If w_flash <> 0 Then
          Scope
          
            Dim As Integer drawycol, drawxcol
            
            Dim As Integer funfun
        
            For drawycol = 0 To ( 12 ) - 1
          
              For drawxcol = 0 To ( 12 ) - 1
          
                If  Bit ( gmg( macro )[gmg( macr.sel )][( drawxcol Shr 1 ) + ( drawycol Shr 1 ) * 6] , 16 - ( ( ( drawxcol And 1 ) + 1 ) + ( ( drawycol And 1 ) Shr 1 ) )   ) Then
                  Put ( drawxcol * 8 + gmg( mac_loc ).x , drawycol * 8 + gmg( mac_loc ).y ), Varptr( gmg( white_box( 0, 0 ) ) )
                      
                End If
          
              Next
          
            Next
        
          End Scope
          
        End If
        
      
        '' show what layer we're on
        Select Case gmg( layer )
          Case 0
            do_ctrl ( gmg( control )[s_layer_0] )
      
          Case 1
            do_ctrl ( gmg( control )[s_layer_1] )
      
          Case 2
            do_ctrl ( gmg( control )[s_layer_2] )
            
        End Select
        
      End Scope
      
    Case s_walkables
    
      
    Case s_teleports
    
      
    
    
    Case s_entries

    
      Scope
    
        If llg( map )->entries > 0 Then 
      
        
          View Screen ( 0, 0 )-( gmg( map_area.x ) - 1, gmg( map_area.y ) - 1 ) 
          
          
          
            If llg( map )->entry[gmg( entr.sel )].room = llg( this_room.i ) Then

            
              Dim As Integer blit_entries
              For blit_entries = 0 To llg( map )->entries - 1
          
          
                If llg( map )->entry[blit_entries].room = llg( this_room.i ) Then
            
                  If ( gmg( entry_flash ) Or gmg( entr.sel ) <> blit_entries ) Then
      
      
      
                    Scope
              
                      Dim As Integer funfun
                        funfun = 1 + Abs( gmg( zooming ) <> 0 )
              
                      Put ( ( llg( map )->entry[blit_entries].x - ( llg( this_room.cx ) ) ) * z_factor, _ 
                            ( llg( map )->entry[blit_entries].y - ( llg( this_room.cy ) ) ) * z_factor ), Varptr( gmg( white_box( funfun, 0 ) ) )
                        
                    End Scope
                    
                  End If 
                
                End If
                    
              Next
          
            End If
      
      
      
          View Screen ( 0, 0 )-( llg( sx ), llg( sy ) ) 
      
        End If
      
      
      End Scope
    
    
    
    
              
    
      
  End Select
  
  If gmg( hide ) = 0 Then
    blit_enemies()
    
  End If
  If gmg( zooming ) <> 0 Then
    Put ( 0, 0 ), Varptr( gmg( b_img[2][0] ) ), Trans 
       
  Else
    Put ( 0, 0 ), Varptr( gmg( r_img[2][0] ) ), Trans 
      
  End If       

  If gmg( _state ) =  s_ice Then
    
    Scope
      
      Dim As Integer funfun, drawycol, drawxcol
      funfun = Abs( gmg( zooming ) ) + 1
  
      For drawycol = 0 To ( gmg( grid_mat.y ) ) - 1
    
        For drawxcol = 0 To ( gmg( grid_mat.x ) ) - 1
    
          If  Bit ( now_room().layout[0][( ( drawxcol ) + ( llg( this_room.cx ) Shr 4  ) ) + ( ( ( drawycol ) + ( llg( this_room.cy ) Shr 4 ) ) * now_room().x  )] , 8 ) Then
            Put ( drawxcol * 16 * z_factor, drawycol * 16 * z_factor ), Varptr( gmg( white_box( funfun, 0 ) ) )
            
          End If
    
        Next
    
      Next
  
    End Scope
    
  End If
      
  
  If gmg( _state ) = s_walkables Then

    Dim As Integer funfun, drawycol, drawxcol
    funfun = Abs( gmg( zooming ) )

    For drawycol = 0 To ( gmg( grid_mat.y ) * 2 ) - 1
  
      For drawxcol = 0 To ( gmg( grid_mat.x ) * 2 ) - 1
  
        If Bit( _ 
                now_room().layout[gmg( layer )] _
                [ _
                  ( _ 
                    ( drawxcol Shr 1 ) _ 
                    + _ 
                    ( _ 
                      llg( this_room.cx ) shr 4 _ 
                    ) _ 
                  ) _ 
                  + _ 
                  ( _
                    ( _ 
                      ( drawycol Shr 1 ) _ 
                      + _ 
                      ( _ 
                        llg( this_room.cy ) shr 4 _ 
                      ) _ 
                    ) * now_room().x _ 
                  ) _ 
                ] , 16 - ( ( ( drawxcol And 1 ) + 1 ) + ( ( drawycol And 1 ) * 2 ) )   ) Then
                
          Put ( ( drawxcol Shl 3 ) * z_factor, ( drawycol Shl 3 ) * z_factor ), Varptr( gmg( white_box( funfun, 0 ) ) )
              
        End If
  
      Next
  
    Next

    If gmg( line_hold ) <> 0 Then
      
      blit_WalkableLine()  
    
    End If
    
  End If
  
  If gmg( _state ) = s_teleports Then
    
    
    Select Case gmg( tel_state )
    
      Case 0
        If now_room().teleports <> 0 Then
  

          View Screen( 0, 0 )-( gmg( map_area.x ) - 1, gmg( map_area.y ) - 1 ) 

            With now_room().teleport[gmg( tele ).sel]
          
              Line (( .x - ( llg( this_room.cx ) )) * z_factor, _ 
                    ( .y - ( llg( this_room.cy ) )) * z_factor ) -  _ 
                   (( .x + .w - ( llg( this_room.cx ) )) * z_factor, _ 
                    ( .y + .h - ( llg( this_room.cy ) )) * z_factor ) , Int( Rnd * 255 ), b
        
        
          
              If gmg( zooming ) Then
          
                Line (( .x - ( llg( this_room.cx ) )) * z_factor + 1, _ 
                      ( .y - ( llg( this_room.cy ) )) * z_factor + 1 ) -  _ 
                     (( .x + .w - ( llg( this_room.cx ) )) * z_factor - 1, _ 
                      ( .y + .h - ( llg( this_room.cy ) )) * z_factor - 1 ) , Int( Rnd * 255 ), b
        
          
              End If
              
            End With

          View Screen ( 0, 0 )-( llg( sx ), llg( sy ) ) 
          
        End If
        
        
      Case 2
            
        View Screen (0,0)-(gmg( map_area.x ) - 1,gmg( map_area.y ) - 1) 
          
          Scope
    
            Dim As Integer funfun = 1 + Abs( gmg( zooming ) <> 0 )

            With llg( map )->room[gmg( prev_room )].teleport[gmg( tele ).sel]
              Put (( .dx - ( llg( this_room.cx ) )) * z_factor, ( .dy - ( llg( this_room.cy ) )) * z_factor), Varptr( gmg( white_box( funfun, 0 ) ) )
              
            End With
              
          End Scope
    
    
    
        View Screen ( 0, 0 )-( llg( sx ), llg( sy ) ) 
        
        
      
    
      
        
    End Select
    
  End If
  
    
    
  
End Sub


Sub blit_enemies()

  If now_room().enemies = 0 Then Exit Sub
'  If gmg( _state ) = s_rooms Then Exit Sub ''heh.. ;/
  
  If gmg( _state ) <> s_enemies Then
    gmg( enemy_flash ) = -1
    
  End If

  View Screen ( 0,0 )-( gmg( map_area.x ) - 1, gmg( map_area.y ) - 1 ) 

    Dim As Integer blit_map_enemies
    Dim As Integer uni_calc
  
    For blit_map_enemies = 0 To now_room().enemies - 1
    
      
      
      
      With now_room().enemy[blit_map_enemies]


        uni_calc = 0
  
        If ( gmg( enemy_flash ) Or ( gmg( enem.sel ) <> blit_map_enemies ) ) And Len( .id ) <> 0  Then
          
          
          If .uni_directional = 0 Then
            uni_calc = ( ( .direction And 3 ) * .animControl[.current_anim].dir_frames * .anim[.current_anim]->arraysize )
            
          End If
                    
          If gmg( zooming ) Then
                     
                     
                     
            If ( .id = "data\object\invis_damage.xml" ) Or ( .id = "data\object\null.xml" ) Or ( .id = "data\object\goblintree.xml" ) Then
    
    
              Put (( .coords.x - ( llg( this_room.cx ) ) - .animControl[.current_anim].x_off ) * z_factor, _ 
                   ( .coords.y - ( llg( this_room.cy ) ) - .animControl[.current_anim].y_off ) * z_factor), Varptr( gmg( white_box( 4, 0 ) ) ), Trans 
    
            Else
                     
              Redim bloat_enemy( .anim[.current_anim]->arraysize * 2 ) As Integer 
      
              Block2x( Varptr( .anim[.current_anim]->image[uni_calc] ), Varptr( bloat_enemy( 0 ) ), .anim[.current_anim]->x, .anim[.current_anim]->y )
      
            
              Put (( .coords.x - ( llg( this_room.cx ) ) - .animControl[.current_anim].x_off ) * z_factor, _ 
                   ( .coords.y - ( llg( this_room.cy ) ) - .animControl[.current_anim].y_off ) * z_factor), bloat_enemy, Trans 
                  
            End If
            
          
          Else
          
            If ( .id = "data\object\invis_damage.xml" ) Or ( .id = "data\object\null.xml" ) Or ( .id = "data\object\goblintree.xml" ) Then
    
    
              Put (( .coords.x - ( llg( this_room.cx ) ) - .animControl[.current_anim].x_off ) * z_factor, _ 
                   ( .coords.y - ( llg( this_room.cy ) ) - .animControl[.current_anim].y_off ) * z_factor), Varptr( gmg( white_box( 3, 0 ) ) ), Trans 
    
            Else
              Put (( .coords.x - ( llg( this_room.cx ) ) - .animControl[.current_anim].x_off ) * z_factor, _               'uni_calc
                   ( .coords.y - ( llg( this_room.cy ) ) - .animControl[.current_anim].y_off ) * z_factor), Varptr( .anim[.current_anim]->image[uni_calc] ), Trans

                  
            End If
                
          End If
          
        End If
        
      End With
          
    Next
  


  View Screen (0,0)-(llg( sx ),llg( sy )) 

End Sub


Sub timedmodify( x As Integer, y As Integer )

  Static As Double tele_uk_delay, tele_rk_delay, tele_dk_delay, tele_lk_delay


  If MultiKey (sc_right) Then 
    If tele_rk_delay = 0 Then
      x += 1
      tele_rk_delay = Timer
      
    Else
      If Timer - tele_rk_delay >= .5 Then 
        tele_rk_delay = 0 
      End If
      
    End If
    
  Else
  
    tele_rk_delay = 0 
    
      
  End If



  If MultiKey (sc_left) Then 
    If tele_lk_delay = 0 Then
      x -= 1
      tele_lk_delay = Timer
      
    Else
      If Timer - tele_lk_delay >= .5 Then 
        tele_lk_delay = 0 
      End If
      
    End If
    
  Else
  
    tele_lk_delay = 0 
    
      
  End If

  If MultiKey (sc_up) Then 
    If tele_uk_delay = 0 Then
      y -= 1
      tele_uk_delay = Timer
      
    Else
      If Timer - tele_uk_delay >= .5 Then 
        tele_uk_delay = 0 
      End If
      
    End If
    
  Else
  
    tele_uk_delay = 0 
    
      
  End If


  If MultiKey (sc_down) Then 
    If tele_dk_delay = 0 Then
      y += 1
      tele_dk_delay = Timer
      
    Else
      If Timer - tele_dk_delay >= .5 Then 
        tele_dk_delay = 0 
      End If
      
    End If
    
  Else
  
    tele_dk_delay = 0 
    
      
  End If

End Sub




Function flood_fill( x As Integer, y As Integer, c As Integer, indices_checked() As Integer )

  
  

  If gmg( start_color ) = c Then Return -1


  Dim As Integer l_fill_loc = x
  Dim As Integer r_fill_loc = x
  
  Dim As Integer Ptr index_pointer

  index_pointer = Varptr( now_room().layout[gmg( layer )][y * now_room().x + x] )

  Do
  
    index_pointer[0] = c
    
    indices_checked( l_fill_loc, y ) = Not 0
    
    l_fill_loc -= 1
    index_pointer -= 1
    
    If indices_checked( l_fill_loc, y) Then 
      Exit Do

    Else
      If index_pointer[0] <> gmg( start_color ) Then 
        Exit Do

      Else
        If l_fill_loc < 0 Then 
          Exit Do
      
        End If  
      End If  
    End If  
  
  
  Loop

  l_fill_loc += 1

  index_pointer = Varptr( now_room().layout[gmg( layer )][y * now_room().x + x] )
  
  
  Do
  
    index_pointer[0] = c
    
    indices_checked( r_fill_loc, y ) = Not 0
    
    r_fill_loc += 1
    index_pointer += 1
    
    If indices_checked( r_fill_loc, y) Then
      Exit Do

    Else
      If index_pointer[0] <> gmg( start_color ) Then 
        Exit Do

      Else
        If r_fill_loc >= now_room().x Then 
          Exit Do
          
        End If  
      End If  
    End If  
  
  
  Loop
  
  r_fill_loc -= 1

  Dim As Integer crawl

  For crawl = l_fill_loc To r_fill_loc  
  
  
    If ( y > 0 ) Then
      If ( now_room().layout[gmg( layer )][( y - 1 ) * now_room().x + crawl] = gmg( start_color ) ) Then
        If ( Not ( indices_checked( crawl, y - 1 ) ) ) Then
          flood_fill( crawl, y - 1, c, indices_checked() )     
        
        End If
      End If
  

    End If



    If ( y < ( now_room().y - 1 ) ) Then  
    

      If ( now_room().layout[gmg( layer )][( y + 1 ) * now_room().x + crawl] = gmg( start_color ) ) Then 
        If ( Not ( indices_checked( crawl, y + 1 ) ) ) Then
          flood_fill( crawl, y + 1, c, indices_checked() )     
        
        End If
      End If
  
   
    End If


  Next

End Function



Function active_sequence() As Integer

  Select Case gmg( control )[s_sequence].e_num
  
    Case Varptr( now_room().seq_here )
      If llg( map )->rooms > 0 Then
        Return seq_room
        
      End If
  
    Case Varptr( now_room().enemy[gmg( enem ).sel].seq_here )
      
      If now_room().enemies > 0 Then
        Return seq_enemy
        
      End If
  
    Case Varptr( llg( map )->entry[gmg( entr ).sel].seq_here )
      If llg( map )->entries > 0 Then
        Return seq_entry
        
      End If
      
  End Select
  
End Function


Function active_sequence_count() As Integer

  Select Case gmg( control )[s_sequence].e_num
  
    Case Varptr( now_room().seq_here )
      If llg( map )->rooms > 0 Then
        Return now_room().seq_here
        
      End If
  
    Case Varptr( now_room().enemy[gmg( enem ).sel].seq_here )
      
      If now_room().enemies > 0 Then
        Return now_room().enemy[gmg( enem ).sel].seq_here
        
      End If
  
    Case Varptr( llg( map )->entry[gmg( entr ).sel].seq_here )
      If llg( map )->entries > 0 Then
        Return llg( map )->entry[gmg( entr ).sel].seq_here
        
      End If
      
  End Select
  
  Return -1
  
End Function



Function active_sequence_address() As sequence_type Ptr
  
  
  Select Case active_sequence()
  
    Case seq_room
      Return now_room().seq
  
    Case seq_enemy
      Return now_room().enemy[gmg( enem ).sel].seq
  
    Case seq_entry
'      quick_text( llg( map )->entry[gmg( entr ).sel].seq )
    
      Return llg( map )->entry[gmg( entr ).sel].seq
      
  End Select
  
End Function






Sub manage_array( p As Any Ptr Ptr, l As Any Ptr, size As Integer, statick As Integer, dynamick As Integer, start As Integer, up_sub As Sub( p As Any Ptr ) = 0, down_sub As Sub( p As Any Ptr ) = 0 )
  
  
  
  Dim As uByte Ptr q = *p
  Dim As Integer l_rot

  If statick <> dynamick Then
    
    If statick > dynamick Then
      
        
      For l_rot = start To statick -2

        MemCpy ( _ 
                 q + ( l_rot * size ),         _ 
                 q + ( ( l_rot + 1 ) * size ), _ 
                 size                          _ 
               )
        
      Next

      q = Reallocate( q, ( dynamick + 1 ) * size )
      
      If down_sub <> 0 Then
        down_sub( ( q + ( ( dynamick - 1 ) * size ) ) )
        
      End If
      
      
    Else
      
      
      q = Reallocate( q, ( dynamick + 1 ) * size )

      If gmg( control )[gmg( _state )].insertFlag <> 0 Then
        
        For l_rot = statick To start Step -1

          MemCpy ( _ 
                   q + ( ( l_rot + 1 ) * size ),         _ 
                   q + ( l_rot * size ), _ 
                   size                          _ 
                 )
        
        
        Next

        MemSet ( _ 
                 q + ( start * size ),         _ 
                 0, _ 
                 size                          _ 
               )
        
        
        gmg( control )[gmg( _state )].insertFlag = 0
        
        If up_sub <> 0 Then
          up_sub( ( q + ( start * size ) ) )
          
        End If

      Else
              
        MemSet                                 _
        (                                      _
          ( q + ( ( dynamick - 1 ) * size ) ), _
          0,                                   _
          size                                 _
        )

        If up_sub <> 0 Then
          up_sub( ( q + ( ( dynamick - 1 ) * size ) ) )
          
        End If
      
      End If


    
    End If  

  End If  
  
  *p = q

End Sub



Sub wheel_change( s As Integer )

  If fb_Global.mouse.w < gmg( wheel ).last_sel Then


    If s < *gmg( control )[gmg( _state )].e_num - 1 Then s += 1 Else s = 0

  ElseIf fb_Global.mouse.w > gmg( wheel ).last_sel Then


    If s > 0 Then s -= 1 Else s = *gmg( control )[gmg( _state )].e_num - 1
    If s < 0 Then s = 0
    
  End If

End Sub



Sub allocate_sequence_nodes( a As Any Ptr )

  Dim As sequence_type Ptr s = a
  
  s->ent = CAllocate( Len( char_type Ptr ) )
  s->ent_code = CAllocate( Len( Integer ) )
  s->Command = CAllocate( Len( command_type ) )
  
  gmg( seq_ptr ) = s - ( *( gmg( ent_ptr ) ) - ( gmg( seq ).sel + 1 ) )
  
  

End Sub  
  
  
Sub allocate_command_blocks( a As Any Ptr )

  Dim As command_type Ptr s = a
  
  s->ent = CAllocate( Len( command_data ) )
  

End Sub  
  
  
  
  

  
Sub handle_less_enemy( p As Any Ptr = 0 )

  erase_sequence_memory()
  
End Sub


Sub handle_new_enemy( p As Any Ptr = 0 )
  
  
  Dim As char_type Ptr q = p, r
  
  
  
  With *( q )
    .seq = CAllocate( Len( sequence_type ) )
    .seq->ent = CAllocate( Len( char_type Ptr ) )
    .seq->ent_code = CAllocate( Len( Integer ) )
    .seq->Command = CAllocate( Len( command_type ) )




  
    .id = "data\object\" & gmg( def_id ) & ".xml"
    
    LLSystem_CopyNewObject( *q )
    .num = now_room().enemies - 1 
    


    erase_sequence_memory()
    
    
  End With

  r = q - ( now_room().enemies - ( gmg( enem ).sel + 1 ) )

  gmg( ent_ptr ) = Varptr( ( r->seq_here ) )
  gmg( seq_ptr ) = r->seq
  


  set_ctrl gmg( control )[s_sequence], , , , , , gmg( ent_ptr )

  
  If gmg( seq_ptr ) <> 0 Then
  
    set_ctrl gmg( control )[s_sequence_entities], , , , , , Varptr( ( selected_sequence().ents ) )
    set_ctrl gmg( control )[s_sequence_commands], , , , , , Varptr( ( selected_sequence().commands ) )
  
    If selected_sequence().commands <> 0 Then
      set_ctrl gmg( control )[s_sequence_command_blocks], , , , , , Varptr( ( selected_command().ents ) ), 1, 1
      
    End If
    
  End If  


  
End Sub  
  
Sub handle_more_entry( p As Any Ptr = 0 )

  Dim As map_entry_type Ptr q = p
  erase_sequence_memory()
  
  q->room = llg( this_room.i )
  
End Sub


Sub handle_less_entry( p As Any Ptr = 0 )

  erase_sequence_memory()
  
End Sub  
  
  


Sub erase_sequence_memory()

  gmg( seq ).sel = 0
  gmg( seq ).last_sel = 0

  gmg( seq_ents ).sel = 0
  gmg( seq_ents ).last_sel = 0

  gmg( ent_commands ).sel = 0
  gmg( ent_commands ).last_sel = 0


End Sub




'Function map_QuadAddress( x As Integer, y As Integer ) As uByte Ptr
'
'  If x > ( now_room().x Shl 1 ) Then Return 0
'  If y > ( now_room().y Shl 1 ) Then Return 0
'  
'  Dim As Integer tx, ty
'  Dim As uByte Ptr res
'  
'  tx = x Shr 1
'  ty = y Shr 1
'  
'  res = Varptr( now_room().layout[gmg( layer )][ty * now_room().x + tx] )
'  
'  If ( y And 1 ) Then res += 2
'  If ( x And 1 ) Then res += 1
'  
'  Return res
'  
'
'End Function


Sub map_ToggleQuad( x As Integer, y As Integer )

  With now_room()

    If x >= ( .x Shl 1 ) Then Exit Sub
    If y >= ( .y Shl 1 ) Then Exit Sub
    
    Dim As Integer  _ 
      tx = x Shr 1, _ 
      ty = y Shr 1, _
                    _ 
      q = IIf( ( y And 1 ), ( IIf( ( x And 1 ), lowerright, lowerleft ) ), ( IIf( ( x And 1 ), upperright, upperleft ) ) )

    .layout[gmg( layer )][ty * .x + tx] Xor = q
    
  End With
      

End Sub


Sub blit_WalkableLine()

  Dim As vector ms, res, hyp
  Dim As Integer line_x = 0, line_y = 0, line_b = 0
  

  ms.x = ( fb_Global.mouse.x \ z_factor ) Shr 3
  ms.y = ( fb_Global.mouse.y \ z_factor ) Shr 3
  
  ms.x += llg( this_room ).cx Shr 3
  ms.y += llg( this_room ).cy Shr 3

  res = v2_CalcFlyback( gmg( ln ), ms )

  
  
  hyp = gmg( ln )
  '' crawl down hypotenuse, placing boxes
  

  If line_x <> ( hyp.x ) Then
    line_x = ( hyp.x )
    
  End If
  If line_y <> ( hyp.y ) Then
    line_y = ( hyp.y ) 
    
  End If
  
  line_b = 1
  
  Do
    
    If line_b <> 0 Then
      
      View Screen ( 0, 0 )-( gmg( grid_mat.x ) Shl 4 - 1, gmg( grid_mat.y ) Shl 4 - 1 ) 
        Put ( ( line_x * 8 ) - llg( this_room ).cx, ( line_y * 8 ) - llg( this_room ).cy ), Varptr( gmg( white_box( 0, 0 ) ) )
        
        
      View Screen ( 0, 0 )-( llg( sx ) - 1, llg( sy ) - 1 ) 

      
    End If

    line_b = 0
    
    Do
    
      hyp = V2_Subtract( hyp, res )
      
      
        If line_x <> Int( hyp.x ) Then
          line_x = Int( hyp.x )
          line_b += 1
          
        End If
        If line_y <> Int( hyp.y ) Then
          line_y = Int( hyp.y ) 
          line_b += 1
          
        End If


      
      If Abs( hyp.x - ms.x ) < 1 Then 
        If Abs( hyp.y - ms.y ) < 1 Then
          Exit Do
          
        End If
        
      End If
      
    Loop Until line_b <> 0
    
    
    
  Loop Until ( Abs( hyp.x - ms.x ) < 1 ) And ( Abs( hyp.y - ms.y ) < 1 )
  

  View Screen ( 0, 0 )-( gmg( grid_mat.x ) Shl 4 - 1, gmg( grid_mat.y ) Shl 4 - 1 ) 
    Put ( ( line_x * 8 ) - llg( this_room ).cx, ( line_y * 8 ) - llg( this_room ).cy ), Varptr( gmg( white_box( 0, 0 ) ) )
    
    
  View Screen ( 0, 0 )-( llg( sx ) - 1, llg( sy ) - 1 ) 


End Sub



Sub toggle_walkable_line()


  Dim As vector ms, res, hyp
  Dim As Integer line_x = 0, line_y = 0, line_b = 0
  

  ms.x = ( fb_Global.mouse.x \ z_factor ) Shr 3
  ms.y = ( fb_Global.mouse.y \ z_factor ) Shr 3
  
  ms.x += llg( this_room ).cx Shr 3
  ms.y += llg( this_room ).cy Shr 3

  res = v2_CalcFlyback( gmg( ln ), ms )

  
  
  hyp = gmg( ln )
  '' crawl down hypotenuse, placing boxes
  

  If line_x <> ( hyp.x ) Then
    line_x = ( hyp.x )
    
  End If
  If line_y <> ( hyp.y ) Then
    line_y = ( hyp.y ) 
    
  End If
  
  line_b = 1
  
  Do
    
    If line_b <> 0 Then
    
      map_ToggleQuad( line_x, line_y )
      
      
    End If

    line_b = 0
    
    Do
    
      hyp = V2_Subtract( hyp, res )
      
      
        If line_x <> Int( hyp.x ) Then
          line_x = Int( hyp.x )
          line_b += 1
          
        End If
        If line_y <> Int( hyp.y ) Then
          line_y = Int( hyp.y ) 
          line_b += 1
          
        End If


      
      If Abs( hyp.x - ms.x ) < 1 Then 
        If Abs( hyp.y - ms.y ) < 1 Then
          Exit Do
          
        End If
        
      End If
      
    Loop Until line_b <> 0
    
    
    
  Loop Until ( Abs( hyp.x - ms.x ) < 1 ) And ( Abs( hyp.y - ms.y ) < 1 )

  map_ToggleQuad( line_x, line_y )

End Sub