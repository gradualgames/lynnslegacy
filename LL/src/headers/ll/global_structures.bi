Option Explicit

Type room_prop


  As Integer i

  As Integer cx, cy '' camera loc        


End Type


Type load_savImage

  img( 2 ) As LLSystem_ImageHeader Ptr

End Type

  
Type load_hudImage

  img( 8 ) As LLSystem_ImageHeader Ptr

End Type

Type palette_Data

  As Double r, g, b
  
  
End Type

Type b_data

  code As Integer
  
  in_ptr As Integer Ptr
  out_ptr As Integer Ptr
  
  in_sub As b_sub
  out_sub As b_sub
  
End Type


Type load_menuImage

  img( menu_MAX ) As LLSystem_ImageHeader Ptr

End Type

Type ll_mainmenu
  
  selectedItem As Integer
  menuImages As load_menuImage
  menuNames( menu_MAX ) As String
  
  
End Type

Type ll_system


  
  as integer fontBG, fontFG
  font as LLSystem_ImageHeader Ptr 
  
  locationChanged as integer
  
  dbgString As String
  
  minimapFloor as integer
  
  dungeonName As String
  
  menu_ScreenSave As Any Ptr 
  
  sx As Integer
  sy As Integer
  
  palx As Integer Ptr
   
  menu As ll_mainmenu

  savImages As load_savImage

  dir_hint As Byte Ptr

  do_hud As Integer
  
  now As Byte Ptr

  hud As load_hudImage

  t_rect As boxcontrol_type

  #IfDef ll_audio
    snds As Integer
    snd  As hsample Ptr
  
    sng  As hmusic
  #Else
  
    snds As Integer
    snd  As uInteger Ptr
  
    sng  As uInteger
  
    
  #EndIf
  
  #IfDef list_type
    f_mem As list_type Ptr
    
  #EndIf
  
  this_room As room_prop

  map As map_type Ptr
  hero As _char_type
  hero_only As main_char_type


  atk_key As b_data
  act_key As b_data
  conf_key As b_data
                 
  item_l_key As b_data
  item_r_key As b_data
                 
  weap_switch_key As b_data

  u_key As b_data
  d_key As b_data
  l_key As b_data
  r_key As b_data

  hero_dmg_calc As _char_type Ptr

  song_fade As Integer
  song_lock As Integer
  song As Integer
  song_wait As Integer

  seq As sequence_type Ptr
  

  #IfDef list_type

    map_list As list_type Ptr
    
  #EndIf
  
  start_map As String
  start_entry As Integer

  mouse_vanish As Integer
  mouse_timer As Double
	xxyxx as integer 
  mouse_last_x As Integer
  mouse_last_y As Integer
  
  As Integer mx, my, mb, mw

  
  fps As Integer
  fps_hold As Integer
  fps_lock As Double
  fps_top As Integer
  
  scrn_ptr As uByte Ptr
  a_page As Integer
  v_page As Integer
  
  cheeat As zString Ptr
  
  do_chap As Integer

  catch_dbg As Integer
  
  dark As Integer
  
  current_cam As char_type Ptr
  
  box_entity As _char_type Ptr
  
  miniMap As LL_MiniMapType
  
  tilesDisabled As Integer  
  
End Type




#IfDef __gmap__


  Type mouse_control
  
    x As Integer
    y As Integer
    w As Integer
    b As Integer
    
  End Type
  
  
  Type backup_type
  
    sel As Integer
    last_sel As Integer
    last_num As Integer
    
  End Type
    



  Type gmap_system 
    
    white_box( 4, 256 ) As Integer
    
    r_img As Integer Ptr Ptr
    b_img As Integer Ptr Ptr
    
    current_box As Sub
    
  
    mouse As mouse_control
    
    gmap_hwnd As Integer
    
  '  img_save As OPENFILENAMEW
  '  img_load As OPENFILENAMEW
  '
  '  map_save As OPENFILENAMEW
  '  map_load As OPENFILENAMEW
    
    start_color As Integer
    
    controls As Integer
    control As _control_type Ptr
    
    line_hold As Integer
    ln As vector
    
    hide As Integer
    
    grid As Integer
    hotkey As Integer
    layer As Integer
    refresh As Integer
    solo As Integer
    tile As Integer
    w_grid As Integer
    zooming As Integer
  
    mac_loc As mat_int
    
    map_area As mat_int
    map_loc As mat_int
    
    tile_loc As mat_int
  
    area_reflect As mat_int
    grid_mat As mat_int
    
    _state As Integer
    
    macros As Integer
    macro As Integer Ptr Ptr
    
    tele     As backup_type
    enem     As backup_type
    entr     As backup_type
    macr     As backup_type
             
    room     As backup_type
             
    state    As backup_type
    wheel    As backup_type
    ref      As backup_type

    seq      As backup_type
    seq_ents As backup_type
    ent_commands As backup_type
    blocks As backup_type
    
    active_seq As Integer
    
    skip_a_frame As Integer
    
    shifted As Integer
    blockshift As Integer
    
    smaller As mat_int
    bigger As mat_int
    
    tile_grasp As mat_int
    
    
    tel_state As Integer
    prev_room As Integer
    
    room_up_key   As b_data  
    room_down_key As b_data  
  
    zoom_key      As b_data  
    solo_key      As b_data  
    grid_key      As b_data  
    w_grid_key    As b_data  
    redim_key     As b_data  
    flood_key     As b_data  

    hide_key     As b_data  
  
    def_id As String
    
    state_addy As Sub( As Integer = 0 ) Ptr
    
    enemy_flash As Integer
    entry_flash As Integer
    
    
    seq_ptr As sequence_type Ptr
    ent_ptr As Integer Ptr
    
    block_state As Integer
    block_boxes As Sub Ptr
    
    enemy_box_state As Integer
    
    spawn_wait As backup_type
    spawn_kill As backup_type
    spawn_active As backup_type
    
    
  End Type
  

#EndIf