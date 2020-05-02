#Include "gmap_macros.bi"
#Include "gmap_structs.bi"


Declare Sub gmap_init()
Declare Sub gmap_input()
Declare Sub gmap_history()
Declare Sub gmap_gfx() 



Declare Sub new_map_init()
Declare Sub load_previous()
Declare Sub set_gmap_controls()

Declare Sub grid_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
Declare Sub w_grid_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
Declare Sub redim_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
Declare Sub room_down_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
Declare Sub room_up_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
Declare Sub solo_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
Declare Sub flood_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
Declare Sub zoom_key_in_sub( ip As Integer Ptr, op As Integer Ptr )


Declare Sub new_room_init()
Declare Sub make_null_map()




Declare Function cursor_on_tiles() As Integer 
Declare Sub clear_layer_ice ( l As Integer )


Declare Sub blit_box_core()

Declare Sub ctrl_exceptions ()


Declare Sub entry_box()
Declare Sub regular_box()
Declare Sub macro_box()
Declare Sub enemy_box()
Declare Sub teleport_box()






Declare Sub blit_map_img ()
Declare Sub clear_layers ()
Declare Sub calc_map ()
Declare Sub update_cam_g()
Declare Sub store_map ()
Declare Sub Block2x ( img As Any Ptr, newimg As Any Ptr, w As Integer = 16, h As Integer = 16 ) 
Declare Sub blit_tiles ()
Declare Sub make_null_room( r As room_type Ptr, flg As uInteger )
Declare Function cursor_on_map() As Integer
Declare Function get_selected_tile() As Integer
Declare Sub draw_macro_grid(  )
Declare Sub show_selected_tile()
Declare Sub get_selected_layer()
Declare Sub macro_wall()
Declare Sub blit_para_img ()
Declare Sub blit_walk_grid ()
Declare Sub blit_grid ()
Declare Sub blit_text ()
Declare Sub blit_enemies()



Declare Sub get_room_dark_input()
Declare Sub get_room_song_input()

Declare Sub get_entry_dir_input()
Declare Sub get_entry_room_input()

Declare Sub get_enemy_dir_input()
Declare Sub get_enemy_name_input()
Declare Sub get_enemy_spawn_input()
Declare Sub get_enemy_flux_input()

Declare Sub get_tele_room_input()
Declare Sub get_tele_song_input()

Declare Sub get_block_slave_input()
Declare Sub get_block_func_input()
Declare Sub get_block_loop_input()
Declare Sub get_block_map_input()
Declare Sub get_block_entry_input()
Declare Sub get_block_hud_input()
Declare Sub get_block_lock_input()
Declare Sub get_block_chap_input()
Declare Sub get_block_carry_input()
Declare Sub get_block_cam_input()
Declare Sub get_block_dir_input()
Declare Sub get_block_pause_input()
Declare Sub get_block_absx_input()
Declare Sub get_block_absy_input()
Declare Sub get_block_destx_input()
Declare Sub get_block_desty_input()
Declare Sub get_block_boxx_input()
Declare Sub get_block_boxy_input()
declare Sub get_block_walkspeed_input()
Declare Sub get_tele_map_input()
Declare Sub get_block_text_input()
Declare Sub get_entity_code_input()
Declare Sub old_teleport_box()




Declare Sub timedmodify( x As Integer, y As Integer )
Declare Function flood_fill( x As Integer, y As Integer, c As Integer, indices_checked() As Integer )
Declare Sub get_default_name_input()
Declare Function active_sequence() As Integer
Declare Function active_sequence_address() As sequence_type Ptr
Declare Sub sequence_box()
Declare Sub entity_box()
Declare Sub wheel_change( s As Integer )
Declare Sub command_box()
Declare Function active_sequence_count() As Integer
Declare Sub manage_array( p As Any Ptr Ptr, l As Any Ptr, size As Integer, statick As Integer, dynamick As Integer, start As Integer, up_sub As Sub( p As Any Ptr ) = 0, down_sub As Sub( p As Any Ptr ) = 0 )
Declare Sub command_block_box()
Declare Sub erase_sequence_memory()
Declare Sub handle_neW_enemy( p As Any Ptr = 0 )
Declare Sub handle_less_enemy( p As Any Ptr = 0 )
Declare Sub handle_more_entry( p As Any Ptr = 0 )
Declare Sub handle_less_entry( p As Any Ptr = 0 )
Declare Sub change_block_box()
Declare Sub command_block_box2()
Declare Sub change_block_box2()





Declare Sub allocate_sequence_nodes( a As Any Ptr )
Declare Sub allocate_command_blocks( a As Any Ptr )




Declare Sub gload_map                     ( arg As Integer = 0 )  
Declare Sub redimension_room              ( arg As Integer = 0 )  
Declare Sub handle_entries                ( arg As Integer = 0 )  
Declare Sub handle_rooms                  ( arg As Integer = 0 )  
Declare Sub handle_macros                 ( arg As Integer = 0 )  
Declare Sub handle_walkable               ( arg As Integer = 0 )  
Declare Sub handle_enemies                ( arg As Integer = 0 )  
Declare Sub handle_teleports              ( flg As Integer = 0 )  
Declare Sub handle_ice                    ( arg As Integer = 0 )  
Declare Sub handle_save                   ( arg As Integer = 0 )  
Declare Sub handle_layer                  ( arg As Integer = 0 )  
Declare Sub handle_zoom                   ( arg As Integer = 0 )  
Declare Sub handle_walk_grid              ( arg As Integer = 0 )  
Declare Sub handle_grid                   ( arg As Integer = 0 )  
Declare Sub handle_parallax               ( arg As Integer = 0 )  
Declare Sub handle_solo                   ( arg As Integer = 0 )  
Declare Sub handle_flood_fill             ( arg As Integer = 0 )  
Declare Sub handle_fill                   ( arg As Integer = 0 )  
Declare Sub handle_quit                   ( arg As Integer = 0 )  
Declare Sub handle_sequences              ( arg As Integer = 0 )  
Declare Sub handle_sequence_entities      ( arg As Integer = 0 )  
Declare Sub handle_sequence_commands      ( arg As Integer = 0 )  
Declare Sub handle_sequence_command_blocks( arg As Integer = 0 )  
Declare Sub handle_parallax_image         ( arg As Integer = 0 )
Declare Sub handle_tileset_load           ( arg As Integer = 0 )

Declare Function map_QuadAddress( x As Integer, y As Integer ) As uByte Ptr

Declare Sub      map_ToggleQuad( x As Integer, y As Integer )


Declare Sub blit_WalkableLine()
Declare Sub toggle_walkable_line()

Declare Sub enemy_spawn_box()
Declare Sub toggle_enemy_spawn_cond()

Declare Sub get_entity_spawn_wait()
Declare Sub get_entity_spawn_kill()
Declare Sub enemy_wait_up()

Declare Sub get_entity_spawn_active()


Declare Sub enemy_wait_down()
Declare Sub enemy_kill_up()
Declare Sub enemy_kill_down()
Declare Sub enemy_active_up()
Declare Sub enemy_active_down()

Declare Sub get_entity_wait_code_index()
Declare Sub get_entity_active_code_index()
Declare Sub get_entity_kill_code_index()

Declare Sub toggle_entity_wait_code_state()
Declare Sub toggle_entity_kill_code_state()
Declare Sub toggle_entity_active_code_state()
Declare Sub toggle_spawn_box()

Declare Sub gMapEngine_BlitLayer( lyr As Integer, holder As Any Ptr = 0, flag As Integer = -1, rs_x As Integer = 0, rs_y As Integer = 0 )

Declare Sub get_block_align_input()
Declare Sub hide_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
Declare Sub get_room_song_changes()
Declare Sub get_room_changes_to()
Declare Sub TextControl_Destroy( controlDismantle As _control_type )                                                                                                       
Declare Sub set_ctrl ( c As _control_type, _x As Integer = -1, _y As Integer = -1, _name As String = "", _state As Integer = -1, _e_sel As Integer Ptr = 0, _e_num As Integer Ptr = 0, _lm As Integer = -1, _ad As Integer = -1 )



Declare Function ctrl_l_click    ( _ctrl As _control_type )
Declare Function ctrl_r_click    ( _ctrl As _control_type )
                                                          
Declare Function ctrl_X_click    ( _ctrl As _control_type )
Declare Function ctrl_plus_click ( _ctrl As _control_type )
                                                          
                                                          
Declare Sub show_ctrl_elements   ( _ctrl As _control_type, _element As Integer )
Declare Sub show_sel_elements    ( _ctrl As _control_type, _element As Integer )

Declare Sub show_sel_ctrl        ( _ctrl As _control_type )

Declare Sub do_ctrl              ( _ctrl As _control_type )
 
 
Declare Sub show_ctrls ( As Integer, As _control_type Ptr )
Declare Sub sense_ctrls ( As Integer, As _control_type Ptr )


