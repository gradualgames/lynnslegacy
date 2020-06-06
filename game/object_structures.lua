require("game/matrices")

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

function create_Object()
  local object = {}
  -- Type char_type
  --
  --
  --   dmg As ll_entity_damage
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
  object.current_anim = 1
  --
  --   d_gold                As Integer
  --   d_health              As Integer
  --   d_silver              As Integer
  --
  --   ice_weak              As Integer
  --   total_dead            As Integer
  --   dead_sound            As Integer
  --   dead_sound_vol        As Integer
  --   dead_hold             As Double
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
  --
  --   fire_weak             As Integer
  --
  --
  --   frame                 As Integer
  object.frame = 1
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
  --   dead                  As Integer
  --
  --
  --   heal_me               As Integer
  --
  --
  --
  --   isBoss As Integer
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
  --   death_state           As Integer
  --   fire_state            As Integer
  --   hit_state             As Integer
  --   ice_state             As Integer
  --   jump_state            As Integer
  --   proj_state            As Integer
  --   reset_state           As Integer
  --   stun_state            As Integer
  --   thaw_state            As Integer
  --   thrust_state          As Integer
  --
  --
  --     '' anims
  --
  --   dead_anim             As Integer
  --   expl_anim             As Integer
  --   proj_anim             As Integer
  --
  --
  --
  --
  --   hit                   As Integer
  --
  --   hit_sound             As Integer
  --   hit_sound_vol         As Integer
  --
  --   hurt                  As Integer
  --
  --
  --
  --   id                    As String
  object.id = ""
  --
  --   impassable            As Integer
  --
  --   invincible            As Integer
  --   invisible             As Integer
  --
  --   is_psfing             As Integer
  --   is_pushing            As Integer
  --
  --   jump_count            As Integer
  --   jump_counter          As Integer
  --   jump_lock             As Integer
  --   jump_time             As Double
  --   jump_timer            As Double
  --
  --   key                   As Integer
  --   key_door              As Integer
  --
  --   last_cycle_ice         As Integer
  --
  --   light_sensitive       As Integer
  --
  --   line_lock             As Integer
  --   line_sight            As Integer
  --
  --   mace_weak             As Integer
  --
  --   mad                   As Integer
  --   mad_walk_speed        As Double
  --
  --   mod_lock              As Integer
  --   momentum              As dir_type
  --   momentum_history      As dir_type
  --
  --   money                 As Integer
  --
  --   moveBackwards         As Integer
  --
  --   moving                As Integer
  --
  --
  --   must_align            As Integer
  --
  --   n_gold                As Integer
  --   n_silver              As Integer
  --
  --   no_cam                As Integer
  --
  --   num                   As Integer
  --
  --   on_ice                As Integer
  --
  --   ori_dir               As Integer
  object.ori_dir = 0
  --
  --   pause                 As Single
  object.pause = 0
  --   pause_hold            As Integer
  --
  --   placed                As Integer                        '0 = norm, pos = top, neg = bottom
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
  --
  --   shifty                As Integer
  --   shifty_lock           As Integer
  --   shifty_state          As Integer
  --
  --   slide_hold            As Double
  --
  --   song_fade_count       As Integer
  --
  --   sound                 As Integer Ptr
  --   sounds                As Integer
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
  --
  --   state_shift           As Integer
  --
  --   sticky_chase          As Integer
  --
  --   strength              As Integer
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
  --   unique_id             As Integer
  --
  --   unstoppable_by_tile   As Integer
  --   unstoppable_by_object As Integer
  --   unstoppable_by_screen As Integer
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
  --   walk_length           As Integer
  object.walk_length = 9
  --   walk_steps            As Double
  --
  --
  --   x_origin              As Integer
  object.x_origin = 0
  --   y_origin              As Integer
  object.y_origin = 0
  --
  --   yet_spawned           As Integer
  --
  --
  --
  --   vol As Integer Ptr
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
  --     dest_y                As Integer
  --
  --     sel_seq               As Integer
  --     seq                   As sequence_type Ptr
  object.seq = {}
  --     seq_here              As Integer
  object.seq_here = 0
  --     seq_paused            As Integer
  --     seq_release           As Integer
  --
  --
  --
  --   '' ==========================
  --   '' Eliminate/change these.
  --   '' ==========================
  --
  --     elite                 As Integer
  --     frame_check           As Integer
  --
  --     melt                  As Integer
  --
  --     menu_lock             As Integer
  --     menu_sel              As Integer
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
  --     fly_hold              As Integer
  --     fly_length            As Integer
  --     fly_speed             As Double
  --     fly_timer             As Double
  --     fly As vector
  --
  --
  --
  --     spawn_wait_trig As Integer
  --     spawn_kill_trig As Integer
  --     spawn_active_trig As Integer
  --
  --
  --     proj_style As LLPROJECTILE_STYLES
  --     projectile As ll_entity_projectile Ptr
  --
  --
  --
  --
  --   '' ==========================
  --
  --
  --
  --   drop                  As _char_type    Ptr
  --   dropped               As Integer
  --
  --
  --
  --   cur_expl              As Integer
  --
  --   explosions            As Integer
  --
  --   expl_delay            As Double
  --   expl_timer            As Double
  --   expl_x_off            As Integer
  --   expl_x_size           As Integer
  --   expl_y_off            As Integer
  --   expl_y_size           As Integer
  --   explosion( 63 )       As mat_expl
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
  --     fade_out              As Integer
  --     fade_time             As Double
  --     fade_timer            As Double
  --
  --
  --     flash_count           As Integer
  --     flash_length          As Integer
  --     flash_time            As Double
  --     flash_timer           As Double
  --
  --
  --   '' ==========================
  --
  --
  --   psycho As Integer
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
  imageHeader.frame = create_LLObject_FrameControl()
  --   As Double rate, rateMad
  imageHeader.rate = 0
  imageHeader.rateMad = 0
  return imageHeader
end
