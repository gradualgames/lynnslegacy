require("game/object_structures")
require("game/lynn_structures")
require("game/map_structures")
require("game/sequence_structures")

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
  ll_system.sx = 320
  --   sy As Integer
  ll_system.sy = 200
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
  ll_system.now = {}
  --
  --   hud As load_hudImage
  ll_system.hud = create_load_hudImage()
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
  ll_system.snds = 0
  --     snd  As uInteger Ptr
  ll_system.snd = {}
  --
  --     sng  As uInteger
  ll_system.sng = 0
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
  ll_system.map = create_map_type()
  --   hero As _char_type
  ll_system.hero = create_Object()
  --   hero_only As main_char_type
  ll_system.hero_only = create_main_char_type()
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
  ll_system.song_fade = 0
  --   song_lock As Integer
  ll_system.song_lock = 0
  --   song As Integer
  ll_system.song = 0
  --   song_wait As Integer
  ll_system.song_wait = 0
  --
  --   seq As sequence_type Ptr
  ll_system.seq = create_sequence_type()
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
  ll_system.dark = 0
  --
  --   current_cam As char_type Ptr
  ll_system.current_cam = nil
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

-- Type load_hudImage
function create_load_hudImage()
--
  local load_hudImage = {}
--   img( 8 ) As LLSystem_ImageHeader Ptr
  load_hudImage.img = {[0] = create_LLSystem_ImageHeader(),
    create_LLSystem_ImageHeader(),
    create_LLSystem_ImageHeader(),
    create_LLSystem_ImageHeader(),
    create_LLSystem_ImageHeader(),
    create_LLSystem_ImageHeader(),
    create_LLSystem_ImageHeader(),
    create_LLSystem_ImageHeader()
  }
--
  return load_hudImage
-- End Type
end
