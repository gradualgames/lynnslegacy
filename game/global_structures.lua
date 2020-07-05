require("game/object_structures")

function create_room_prop()
  local room_prop = {}
  -- Type room_prop
  --
  --
  --   As Integer i
  room_prop.i = 0
  --
  --   As Integer cx, cy '' camera loc
  room_prop.cx = 0
  room_prop.cy = 0
  --
  --
  -- End Type
  return room_prop
end

function create_ll_system()
  local ll_system = {}
  -- Type ll_system
  --
  --
  --
  --   as integer fontBG, fontFG
  --   font as LLSystem_ImageHeader Ptr
  --
  --   locationChanged as integer
  --
  --   dbgString As String
  --
  --   minimapFloor as integer
  --
  --   dungeonName As String
  --
  --   menu_ScreenSave As Any Ptr
  --
  --   sx As Integer
  --   sy As Integer
  --
  --   palx As Integer Ptr
  --
  --   menu As ll_mainmenu
  --
  --   savImages As load_savImage
  --
  --   dir_hint As Byte Ptr
  --
  --   do_hud As Integer
  --
  --   now As Byte Ptr
  --
  --   hud As load_hudImage
  --
  --   t_rect As boxcontrol_type
  --
  --   #IfDef ll_audio
  --     snds As Integer
  --     snd  As hsample Ptr
  --
  --     sng  As hmusic
  --   #Else
  --
  --     snds As Integer
  --     snd  As uInteger Ptr
  --
  --     sng  As uInteger
  --
  --
  --   #EndIf
  --
  --   #IfDef list_type
  --     f_mem As list_type Ptr
  --
  --   #EndIf
  --
  --   this_room As room_prop
  ll_system.this_room = create_room_prop()
  --
  --   map As map_type Ptr
  --   hero As _char_type
  ll_system.hero = create_Object()
  --   hero_only As main_char_type
  --
  --
  --   atk_key As b_data
  --   act_key As b_data
  --   conf_key As b_data
  --
  --   item_l_key As b_data
  --   item_r_key As b_data
  --
  --   weap_switch_key As b_data
  --
  --   u_key As b_data
  --   d_key As b_data
  --   l_key As b_data
  --   r_key As b_data
  --
  --   hero_dmg_calc As _char_type Ptr
  --
  --   song_fade As Integer
  --   song_lock As Integer
  --   song As Integer
  --   song_wait As Integer
  --
  --   seq As sequence_type Ptr
  --
  --
  --   #IfDef list_type
  --
  --     map_list As list_type Ptr
  --
  --   #EndIf
  --
  --   start_map As String
  --   start_entry As Integer
  --
  --   mouse_vanish As Integer
  --   mouse_timer As Double
  -- 	xxyxx as integer
  --   mouse_last_x As Integer
  --   mouse_last_y As Integer
  --
  --   As Integer mx, my, mb, mw
  --
  --
  --   fps As Integer
  --   fps_hold As Integer
  --   fps_lock As Double
  --   fps_top As Integer
  --
  --   scrn_ptr As uByte Ptr
  --   a_page As Integer
  --   v_page As Integer
  --
  --   cheeat As zString Ptr
  --
  --   do_chap As Integer
  --
  --   catch_dbg As Integer
  --
  --   dark As Integer
  --
  --   current_cam As char_type Ptr
  --
  --   box_entity As _char_type Ptr
  --
  --   miniMap As LL_MiniMapType
  --
  --   tilesDisabled As Integer
  --
  -- End Type
  return ll_system
end
