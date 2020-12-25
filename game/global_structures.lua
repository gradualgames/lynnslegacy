require("game/constants")
require("game/engine_enums")
require("game/box_structures")
require("game/image_structures")
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

-- Type load_menuImage
function create_load_menuImage()
--
  local load_menuImage = {}
--   img( menu_MAX ) As LLSystem_ImageHeader Ptr
  load_menuImage.img = {}
  for i = 0, menu_MAX - 1 do
    load_menuImage.img[i] = create_LLSystem_ImageHeader()
  end
--
  return load_menuImage
-- End Type
end

-- Type ll_mainmenu
function create_ll_mainmenu()
--
  local ll_mainmenu = {}
--   selectedItem As Integer
  ll_mainmenu.selectedItem = 0
--   menuImages As load_menuImage
  ll_mainmenu.menuImages = create_load_menuImage()
--   menuNames( menu_MAX ) As String
  ll_mainmenu.menuNames = {}
  for i = 0, menu_MAX - 1 do
    ll_mainmenu.menuNames[i] = ""
  end
--
--
  return ll_mainmenu
-- End Type
end

function create_ll_system()
  local ll_system = {}
  -- Type ll_system
  --
  --
  --
  --   as integer fontBG, fontFG
  ll_system.fontBG = 0
  ll_system.fongFG = 0
  --   font as LLSystem_ImageHeader Ptr
  ll_system.font = create_LLSystem_ImageHeader()
  --
  --   locationChanged as integer
  --
  --   dbgString As String
  --
  --   minimapFloor as integer
  ll_system.minimapFloor = 0
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
  ll_system.menu = create_ll_mainmenu()
  --
  --   savImages As load_savImage
  ll_system.savImages = create_load_savImage()
  --
  --   dir_hint As Byte Ptr
  ll_system.dir_hint = {[0] = "up", "right", "down", "left"}
  --
  --   do_hud As Integer
  --
  --   now As Byte Ptr
  ll_system.now = nil
  --
  --   hud As load_hudImage
  ll_system.hud = create_load_hudImage()
  --
  --   t_rect As boxcontrol_type
  ll_system.t_rect = create_boxcontrol_type()
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
  --NOTE: We are going to directly use this to store the
  --love2d Source object for music.
  ll_system.sng = nil
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
  ll_system.seq = nil
  --NOTE: We introduce seqi because seq was basically a pointer
  --to the current sequence in an allocated array of sequences. We
  --can't operate that way with Lua, so we need to have this index
  --alongside seq.
  ll_system.seqi = 0
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
  ll_system.do_chap = 0
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
  ll_system.miniMap = create_LL_MiniMapType()
  --
  --   tilesDisabled As Integer
  ll_system.tilesDisabled = 0
  --
  -- End Type
  return ll_system
end

-- Type load_savImage
function create_load_savImage()
--
  local load_savImage = {}
--   img( 2 ) As LLSystem_ImageHeader Ptr
  load_savImage.img = {}

--
  return load_savImage
-- End Type
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
