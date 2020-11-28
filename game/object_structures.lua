require("game/matrices")

-- Type mat_expl
function create_mat_expl()
--
  local mat_expl = {}
--   As Integer x, y
  mat_expl.x = 0
  mat_expl.y = 0
--
--   frame As Integer
  mat_expl.frame = 0
--   frame_hold As Double
  mat_expl.frame_hold = 0.0
--   alive As Integer
  mat_expl.alive = 0
--   sound As Integer
  mat_expl.sound = 0
  --NOTE: Cloning the explosion sample for every explosion for
  --concurrent playback. This is not part of original LL source code.
  if ll_global ~= nil then
    mat_expl.sound_source = ll_global.snd[sound_explosion]:clone()
  end
--
  return mat_expl
-- End Type
end

function create_dir_type()
  -- Type dir_type
  local dir_type = {}
  --
  --   i( 7 ) As Double
  dir_type.i = {[0]=0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0}
  --
  -- End Type
  return dir_type
end

function create_e_funcs()
  local e_funcs = {}
  -- Type e_funcs
  --
  --   active_state As Integer
  e_funcs.active_state = 0
  --
  --   func As fp Ptr Ptr
  e_funcs.func = {}
  --
  --   current_func As Integer Ptr
  e_funcs.current_func = {}
  --
  --
  --   func_count   As Integer Ptr
  e_funcs.func_count = {}
  --   states As Integer
  e_funcs.states = 0
  --
  -- End Type
  return e_funcs
end

function init_object(object)
  --
  --
  --   dmg As ll_entity_damage
  object.dmg = create_ll_entity_damage()
  --
  --
  --   internalState as integer
  --
  --   animating             As Integer
  object.animating = 0
  --   anims                 As Integer
  object.anims = 0
  --
  --   hp                    As Integer
  --   maxhp                 As Integer
  --
  --   anim                  As LLSystem_ImageHeader Ptr Ptr
  object.anim = {}
  --
  --   animControl           As LLObject_ImageHeader Ptr
  object.animControl = {}
  --
  --   current_anim          As Integer
  object.current_anim = 0
  --
  --   d_gold                As Integer
  object.d_gold = 0
  --   d_health              As Integer
  object.d_health = 0
  --   d_silver              As Integer
  object.d_silver = 0
  --
  --   ice_weak              As Integer
  --   total_dead            As Integer
  --   dead_sound            As Integer
  object.dead_sound = 0
  --   dead_sound_vol        As Integer
  object.dead_sound_vol = 0
  --   dead_hold             As Double
  object.dead_hold = 0.0
  --
  --   degree                As Double
  --   sway                  As Double
  --   swaying               As Integer
  --
  --
  --   diag_chase            As Integer
  --   diag_thrust           As Integer
  --   direction             As Integer
  object.direction = 0
  --   far_reset_delay       As Double
  --
  --   '' needs a simple explosion display
  --   fireworks             As Integer
  object.fireworks = 0
  --
  --   fire_weak             As Integer
  --
  --
  --   frame                 As Integer
  object.frame = 0
  --   frame_hold            As Double
  object.frame_hold = 0
  --   high_frame            As Double
  --   low_frame             As Double
  --
  --
  --   froggy                As Integer
  --
  --   funcs                 As e_funcs
  object.funcs = create_e_funcs()
  --
  --   thrust                As Integer
  --
  --   switch_room           As Integer
  object.switch_room = -1
  --   dead                  As Integer
  object.dead = 0
  --
  --
  --   heal_me               As Integer
  object.heal_me = 0
  --
  --
  --
  --   isBoss As Integer
  object.isBoss = 0
  --   lose_time             As Integer
  --
  --
  --   grult_proj_trig       As Integer
  --   anger_proj_trig       As Integer
  --
  --
  --     '' states!!
  --
  --   attack_state          As Integer
  object.attack_state = 0
  --   death_state           As Integer
  object.death_state = 0
  --   fire_state            As Integer
  object.fire_state = 0
  --   hit_state             As Integer
  object.hit_state = 0
  --   ice_state             As Integer
  object.ice_state = 0
  --   jump_state            As Integer
  object.jump_state = 0
  --   proj_state            As Integer
  object.proj_state = 0
  --   reset_state           As Integer
  object.reset_state = 0
  --   stun_state            As Integer
  object.stun_state = 0
  --   thaw_state            As Integer
  object.thaw_state = 0
  --   thrust_state          As Integer
  object.thrust_state = 0
  --
  --
  --     '' anims
  --
  --   dead_anim             As Integer
  object.dead_anim = 0
  --   expl_anim             As Integer
  object.dead_anim = 0
  --   proj_anim             As Integer
  object.proj_anim = 0
  --
  --
  --
  --
  --   hit                   As Integer
  --
  --   hit_sound             As Integer
  object.hit_sound = 0
  --   hit_sound_vol         As Integer
  object.hit_sound_vol = 0
  --
  --   hurt                  As Integer
  object.hurt = 0
  --
  --
  --
  --   id                    As String
  --
  --   impassable            As Integer
  object.impassable = 0
  --
  --   invincible            As Integer
  object.invincible = 0
  --   invisible             As Integer
  object.invisible = 0
  --
  --   is_psfing             As Integer
  object.is_psfing = 0
  --   is_pushing            As Integer
  object.is_pushing = 0
  --
  --   jump_count            As Integer
  object.jump_count = 0
  --   jump_counter          As Integer
  object.jump_counter = 0
  --   jump_lock             As Integer
  object.jump_lock = 0
  --   jump_time             As Double
  object.jump_time = 0.0
  --   jump_timer            As Double
  object.jump_timer = 0.0
  --
  --   key                   As Integer
  --   key_door              As Integer
  --
  --   last_cycle_ice         As Integer
  object.last_cycle_ice = 0
  --
  --   light_sensitive       As Integer
  --
  --   line_lock             As Integer
  --   line_sight            As Integer
  --
  --   mace_weak             As Integer
  object.mace_weak = 0
  --
  --   mad                   As Integer
  --   mad_walk_speed        As Double
  --
  --   mod_lock              As Integer
  object.mod_lock = 0
  --   momentum              As dir_type
  object.momentum = create_dir_type()
  --   momentum_history      As dir_type
  object.momentum_history = create_dir_type()
  --
  --   money                 As Integer
  object.money = 0
  --
  --   moveBackwards         As Integer
  object.moveBackwards = 0
  --
  --   moving                As Integer
  object.moving = 0
  --
  --
  --   must_align            As Integer
  --
  --   n_gold                As Integer
  --   n_silver              As Integer
  --
  --   no_cam                As Integer
  object.no_cam = 0
  --
  --   num                   As Integer
  object.num = 0
  --
  --   on_ice                As Integer
  object.on_ice = 0
  --
  --   ori_dir               As Integer
  object.ori_dir = 0
  --
  --   pause                 As Single
  object.pause = 0
  --   pause_hold            As Integer
  --
  --   placed                As Integer                        '0 = norm, pos = top, neg = bottom
  object.placed = 0
  --
  --   pushable              As Integer
  --
  --   radius                As Double
  --
  --
  --
  --
  --
  --   return_trig           As Integer
  object.return_trig = 0
  --
  --   shifty                As Integer
  --   shifty_lock           As Integer
  --   shifty_state          As Integer
  --
  --   slide_hold            As Double
  --
  --   song_fade_count       As Integer
  object.song_fade_count = 0
  --
  --   sound                 As Integer Ptr
  object.sound = {}
  --   sounds                As Integer
  object.sounds = 0
  --
  --   spawn_x               As Integer
  --   spawn_y               As Integer
  --
  --   spawn_h               As uShort
  object.spawn_h = 0
  --   is_h_set              As uShort
  object.is_h_set = 0
  --
  --   spawn_d               As Integer
  object.spawn_d = 0
  --   is_d_set              As Integer
  object.is_d_set = 0
  --
  --   spawns_id             As String
  --
  --   star_weak             As Integer
  object.star_weak = 0
  --
  --   state_shift           As Integer
  object.state_shift = 0
  --
  --   sticky_chase          As Integer
  --
  --   strength              As Integer
  object.strength = 0
  --
  --
  --
  --   to_entry              As Integer
  --   to_map                As String
  --
  --   torch                 As Integer
  --
  --   touch_sequence        As Integer
  --
  --   trigger               As Integer
  --
  --   uni_directional       As Integer
  object.uni_directional = 0
  --   unique_id             As Integer
  object.unique_id = 0
  --
  --   unstoppable_by_tile   As Integer
  object.unstoppable_by_tile = 0
  --   unstoppable_by_object As Integer
  object.unstoppable_by_object = 0
  --   unstoppable_by_screen As Integer
  object.unstoppable_by_screen = 0
  --
  --   vision_field          As Integer
  --   side_vision As Integer
  --
  --
  --   vol_fade              As Integer
  --   vol_fade_lock         As Double
  --   vol_fade_time         As Double
  --   vol_fade_trig         As Integer
  --
  --   walk_buffer           As Integer
  object.walk_buffer = 0
  --   walk_hold             As Double
  object.walk_hold = 0
  --   walk_speed            As Double
  object.walk_speed = 0
  --   walk_length           As Integer
  object.walk_length = 9
  --   walk_steps            As Double
  object.walk_steps = 0.0
  --
  --
  --   x_origin              As Integer
  --   y_origin              As Integer
  --
  --   yet_spawned           As Integer
  --
  --
  --
  --   vol As Integer Ptr
  object.vol = {}
  --   sample_fade_lock As Integer
  --   sample_vol_store As Integer
  --
  --   #IfDef ll_audio
  --     playing_handle As hchannel
  --
  --   #Else
  --     playing_handle As uInteger
  --
  --   #EndIf
  --
  --
  --
  --   '' sequence crap
  --   '' ==========================
  --     action_sequence       As Integer
  --     chap                  As Integer
  object.chap = 0
  --     dest_x                As Integer
  object.dest_x = 0
  --     dest_y                As Integer
  object.dest_y = 0
  --
  --     sel_seq               As Integer
  --     seq                   As sequence_type Ptr
  object.seq = {}
  --NOTE: We introduce seqi because seq was basically a pointer
  --to the current sequence in an allocated array of sequences. We
  --can't operate that way with Lua, so we need to have this index
  --alongside seq.
  object.seqi = 0
  --     seq_here              As Integer
  object.seq_here = 0
  --     seq_paused            As Integer
  object.seq_paused = 0
  --     seq_release           As Integer
  object.seq_release = 0
  --
  --
  --
  --   '' ==========================
  --   '' Eliminate/change these.
  --   '' ==========================
  --
  --     elite                 As Integer
  --     frame_check           As Integer
  object.frame_check = 0
  --
  --     melt                  As Integer
  --
  --     menu_lock             As Integer
  object.menu_lock = 0
  --     menu_sel              As Integer
  object.menu_sel = 0
  --
  --     mini_boss             As Integer
  --
  --     orb_hac               As Integer
  --
  --     read_lock             As Integer
  --
  --     reset_delay           As Double
  --
  --     stun_return_trig      As Integer
  --
  --
  --   '' ==========================
  --   '' Eliminate/change these.
  --   '' ==========================
  --
  --     save                 ( 3 )   As save_dat
  --
  --     coords As Vector
  object.coords = create_vector()
  --
  --     spawn_cond As Integer
  object.spawn_cond = 0
  --     spawn_info As LLObject_ConditionalSpawn Ptr
  object.spawn_info = {}
  --
  --     perimeter As Vector
  object.perimeter = create_vector()
  --
  --
  --   '' Flyback information struct(s) suggestion:
  --   ''
  --   '' Operates with:
  --   ''
  --   '' Flyback information is held inside this struct. this struct contains
  --   '' various information about the object's flyback properties, speed, length, etc.
  --   ''
  --   ''
  --   ''   Type ll_entity_flyback
  --   ''
  --   ''     fly_count  As Integer
  --   ''     fly_hold   As Integer
  --   ''     fly_length As Integer
  --   ''     fly_speed  As Double
  --   ''     fly_timer  As Double
  --   ''     fly_vector as Vector
  --   ''
  --   ''   End Type
  --   ''
  --     fly_count             As Integer
  object.fly_count = 0
  --     fly_hold              As Integer
  object.fly_hold = 0
  --     fly_length            As Integer
  object.fly_length = 0
  --     fly_speed             As Double
  object.fly_speed = 0.0
  --     fly_timer             As Double
  object.fly_timer = 0.0
  --     fly As vector
  object.fly = create_vector()
  --
  --
  --
  --     spawn_wait_trig As Integer
  --     spawn_kill_trig As Integer
  --     spawn_active_trig As Integer
  --
  --
  --     proj_style As LLPROJECTILE_STYLES
  object.proj_style = 0
  --     projectile As ll_entity_projectile Ptr
  object.projectile = nil
  --
  --
  --
  --
  --   '' ==========================
  --
  --
  --
  --   drop                  As _char_type    Ptr
  --NOTE: Calling create_Object here would cause stack overflow,
  --this object is created in LLSystem_ObjectDeepCopy
  object.drop = nil
  --   dropped               As Integer
  object.dropped = 0
  --
  --
  --
  --   cur_expl              As Integer
  object.cur_expl = 0
  --
  --   explosions            As Integer
  object.explosions = 0
  --
  --   expl_delay            As Double
  object.expl_delay = 0.0
  --   expl_timer            As Double
  object.expl_timer = 0.0
  --   expl_x_off            As Integer
  object.expl_x_off = 0
  --   expl_x_size           As Integer
  object.expl_x_size = 0
  --   expl_y_off            As Integer
  object.expl_y_off = 0
  --   expl_y_size           As Integer
  object.expl_y_size = 0
  --   explosion( 63 )       As mat_expl
  object.explosion = {}
  for i = 0, 63 do object.explosion[i] = create_mat_expl() end
  --
  --
  --
  --
  --
  --   '' Explosion information struct(s) suggestion:
  --   ''
  --   '' Operates with:
  --   ''
  --   '' Explosion information is held inside this struct. this struct contains
  --   '' various information about the object's explosion dimensions, speed, size, etc.
  --   ''
  --   ''
  --   ''   Type ll_entity_explosion_properties
  --   ''
  --   ''     explosions  As Integer
  --   ''
  --   ''     expl_delay  As Double
  --   ''     expl_timer  As Double
  --   ''     expl_offset As Vector
  --   ''     expl_size   As Vector
  --   ''     explosion   As mat_expl Ptr
  --   ''
  --   ''   End Type
  --   ''
  --   ''
  --   ''   Type ll_entity_explosion
  --   ''
  --   ''     '' description of damaging entity.
  --   ''     '' 0 = no damage, 1 = room enemy, 2 = temporary room enemy, 3 = lynn
  --   ''     info As ll_entity_explosion_properties Ptr
  --   ''
  --   ''   End Type
  --
  --
  --
  --
  --
  --
  --
  --
  --   '' gfx stuff....
  --   '' ==========================
  --     fade_count            As Integer
  object.fade_count = 0
  --     fade_out              As Integer
  object.fade_out = 0
  --     fade_time             As Double
  object.fade_time = 0.0
  --     fade_timer            As Double
  object.fade_timer = 0.0
  --
  --
  --     flash_count           As Integer
  object.flash_count = 0
  --     flash_length          As Integer
  object.flash_length = 0
  --     flash_time            As Double
  object.flash_time = 0.0
  --     flash_timer           As Double
  object.flash_timer = 0.0
  --
  --
  --   '' ==========================
  --
  --
  --   psycho As Integer
  object.psycho = 0
  --
  --
  --
  --   reserved_2            As Integer
  --   reserved_3            As Integer
  --   reserved_4            As Integer
  --   reserved_5            As Integer
  object.reserved_5 = 0
  --   reserved_6            As Integer
  --
end

function create_Object()
  local object = {}
  -- Type char_type
  init_object(object)
  -- End Type
  return object
end

function create_LLObject_FrameConcurrent()
  local frameConcurrent = {}
  -- Type LLObject_FrameConcurrent
  --   is_relative As Integer
  frameConcurrent.is_relative = 0
  --   char As _char_type Ptr
  frameConcurrent.char = nil
  --   origin As vector
  frameConcurrent.origin = create_vector()
  -- End Type
end

function create_LLObject_FrameControl()
  local frameControl = {}
  -- Type LLObject_FrameControl
  --   sound_lock As Integer
  frameControl.sound_lock = 0
  --   concurrent As LLObject_FrameConcurrent Ptr
  frameControl.concurrent = create_LLObject_FrameConcurrent()
  --   concurrents As Integer
  frameControl.concurrents = 0
  --   As Double rate, rateMad
  frameControl.rate = 0
  frameControl.rateMad = 0
  -- End Type
  return frameControl
end

function create_LLObject_ImageHeader()
  local imageHeader = {}
  -- Type LLObject_ImageHeader
  --   As Integer x_off, y_off
  imageHeader.x_off = 0
  imageHeader.y_off = 0
  --   dir_frames As Integer
  imageHeader.dir_frames = 0
  --   cur_frame As Integer
  imageHeader.cur_frame = 0
  --   frame As LLObject_FrameControl Ptr
  imageHeader.frame = {}
  --   As Double rate, rateMad
  imageHeader.rate = 0
  imageHeader.rateMad = 0
  return imageHeader
end

-- '' Projectile information struct(s) suggestion:
-- ''
-- '' Operates with:
-- ''
-- '' Projectile information is held inside this struct. this struct contains
-- '' various information about the object's projectile's properties - speed, length, strength, etc.
-- ''
-- ''
--    Type ll_entity_projectile
function create_ll_entity_projectile()
--
  local ll_entity_projectile = {}
--      refreshTime       As Double
  ll_entity_projectile.refreshTime = 0.0
--
--      plock as byte
  ll_entity_projectile.plock = 0
--
--      projectiles   As Integer
  ll_entity_projectile.projectiles = 0
--      saveDirection As Integer
  ll_entity_projectile.saveDirection = 0
--      direction     As Integer
  ll_entity_projectile.direction = 0
--      length        As Integer
  ll_entity_projectile.length = 0
--      travelled     As Integer
  ll_entity_projectile.travelled = 0
--      invisible     As Integer
  ll_entity_projectile.invisible = 0
--      overChar      As Integer
  ll_entity_projectile.overChar = 0
--      sound         As Integer
  ll_entity_projectile.sound = 0
--      strength      As Integer
  ll_entity_projectile.strength = 0
--      active        As Integer
  ll_entity_projectile.active = 0
--      coords        As Vector Ptr
  ll_entity_projectile.coords = create_vector()
--
--      startVector As vector
  ll_entity_projectile.startVector = create_vector()
--      flightPath as vector
  ll_entity_projectile.flightPath = create_vector()
--
  return ll_entity_projectile
--    End Type
end

-- '' Damage information struct:
-- ''
-- '' Operates with:
-- '' Enum LL_DAMAGE_FLAGS
-- ''
-- '' Damage information is held inside this struct. this struct contains
-- '' various information about what the object was damaged by.
-- ''
-- Type ll_entity_damage
function create_ll_entity_damage()
  local ll_entity_damage = {}
--
--   '' description of damaging entity.
--   '' ( Enum LL_DAMAGE_FLAGS )
--   id As Integer
  ll_entity_damage.id = 0
--   ''
--   '' the number of whatever type you hit.
--   '' e.g. equals 2 when object is damaged by room enemy #2
--   index As Integer
  ll_entity_damage.index = 0
--   ''
--   '' if id = DF_XXXX_ENEMY_PROJ, then "specific" equals the projectile number.
--   '' elseif the enemy has multiple bounds, then "specific" is the bound touched.
--   '' else "spcific" is undefined.
--   specific As Integer
  ll_entity_damage.specific = 0
--
  return ll_entity_damage
-- End Type
end
