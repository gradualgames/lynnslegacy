require("game/load/loadxml")
require("game/animation")
require("game/cache")

function create_vector()
  local vector = {}
  vector.x = 0
  vector.y = 0
  return vector
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
  --   walk_hold             As Double
  --   walk_speed            As Double
  --   walk_length           As Integer
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

-- Loops over the enemies of the current room and spawns them
function set_up_room_enemies(enemies)
    -- Dim As Integer setup
    --
    --
    -- For setup = 0 To enemies - 1
  for setup = 1, #enemies do
    --   '' cycle thru these enemies
    --
    --   With enemy[setup]
    local enemy = enemies[setup]
    --
    --     If .spawn_cond <> 0 Then
    --
    --       If .spawn_info->wait_n > 0 Then
    --
    --         If LLObject_SpawnWait( Varptr( enemy[setup] ) ) <> 0 Then
    --
    --           '' done waiting
    --
    --           LLSystem_CopyNewObject( enemy[setup] )
    LLSystem_ObjectLoad(enemy)
    --
    --         Else
    --           Dim As String oldid
    --
    --           oldid = enemy[setup].id
    --
    --           LLSystem_ObjectDeepCopy( enemy[setup], *LLSystem_ObjectDeref( LLSystem_ObjectDerefName( "data\object\null.xml" ) ) )
    --           enemy[setup].id = oldid
    --
    --         End If
    --
    --       Else
    --
    --         LLSystem_CopyNewObject( enemy[setup] )
    --
    --       End If
    --
    --     Else
    --
    --     '' if regular then spawn
    --       LLSystem_CopyNewObject( enemy[setup] )
    --
    --     End If
    --
    --     '' setting a couple last vars
    --     .num = setup
    --
    --     If .spawn_cond <> 0 Then
    --
    --       If LLObject_SpawnKill( Varptr( enemy[setup] ) ) <> 0 Then
    --         '' all conditions met to kill
    --
    --         __make_dead  ( Varptr( enemy[setup] ) )
    --         __cripple  ( Varptr( enemy[setup] ) )
    --
    --         If(                                     _
    --             ( .unique_id = u_chest         ) Or _
    --             ( .unique_id = u_bluechest     ) Or _
    --             ( .unique_id = u_bluechestitem ) Or _
    --             ( .unique_id = u_ghut          ) Or _
    --             ( .unique_id = u_button        ) Or _
    --             ( .unique_id = u_gbutton       )    _
    --           ) Then
    --           .current_anim = 1
    --
    --         End If
    --
    --
    --         .seq_release = 0
    --
    --         .spawn_kill_trig = -1
    --
    --
    --         if .unique_id = u_biglarva then
    --           LLObject_ShiftState( Varptr( enemy[setup] ), 3 )
    --
    --         end if
    --
    --         if .unique_id = u_ghut then
    --           LLObject_ShiftState( Varptr( enemy[setup] ), 3 )
    --
    --         end if
    --
    --       End If
    --
    --     End If
    --
    --   End With
    --
    --   #IfDef LL_LOGRoomEnemySetup
    --     LLSystem_Log( "Initialized room["& llg( this_room ).i &"] enemy " & setup, "set_up_room_enemies.txt" )
    --
    --   #EndIf
    --
    -- Next
  end
end

-- Loads an object and its images from xml and spr files. Assumes that
-- objectLoad.id has been initialized with the relative path of an object
-- xml file.
function LLSystem_ObjectLoad(objectLoad)
  --   Dim As Integer op1, op2, i, it, itt
  --   Dim As String dblquote = """"""
  --
  --   op1 = ( objectLoad.id = "" )
  --   op2 = ( Dir( objectLoad.id ) = "" )
  --
  --   If op1 Or op2 Then
  --
  --     Return 0
  --
  --   End If
  --
  --   Dim As xml_type Ptr clean_up
  --
  --
  --   clean_up = xml_Load( objectLoad.id )
  --
  --
  --   #IfDef LL_OBJECTLOADPROGRESS
  --     LLSystem_Log( "XML loaded.", "objectload.txt" )
  --
  --   #EndIf
  --
  --   objectLoad.flash_time = .02
  --   objectLoad.flash_length = 30
  --
  --   objectLoad.hit_sound = sound_enemyhit
  --   objectLoad.dead_sound = sound_enemykill
  --
  --
  --   LLSystem_ObjectFromXML( clean_up, objectLoad )
  LLSystem_ObjectFromXML(objectLoad)
  --
  --   #IfDef LL_OBJECTLOADPROGRESS
  --     LLSystem_Log( "Object extracted from XML.", "objectload.txt" )
  --
  --   #EndIf
  --
  --   xml_Destroy( clean_up )
  --
  --   #IfDef LL_OBJECTLOADPROGRESS
  --     LLSystem_Log( "Destroyed XML tree.", "objectload.txt" )
  --
  --   #EndIf
  --
  --
  --   For i = 0 To objectLoad.anims - 1
  --
  --     For it = 0 To objectLoad.anim[i]->frames - 1
  --
  --       For itt = 0 To objectLoad.animControl[i].frame[it].concurrents - 1
  --
  --         With objectLoad.animControl[i].frame[it].concurrent[itt]
  --           '' one day...
  --           '' .char.location = V2_Add( objectLoad.location, V2_Subtract( .origin, V2_Scale( .char->perimeter, .5 ) ) )
  --           ''
  --           '' hehe dreams come true through hard work and diligence.
  --
  -- '          .char->x_origin = objectLoad.coords.x + .origin.x - ( .char->perimeter.x * .5 )
  -- '          .char->y_origin = objectLoad.coords.y + .origin.y - ( .char->perimeter.y * .5 )
  -- '          .char->coords.x = .char->x_origin
  -- '          .char->coords.y = .char->y_origin
  --
  --           .char->coords = V2_Add( objectLoad.coords, V2_Subtract( .origin, V2_Scale( .char->perimeter, .5 ) ) )
  --
  --           .char->x_origin = .char->coords.x
  --           .char->y_origin = .char->coords.y
  --
  --         End With
  --
  --       Next
  --
  --     Next
  --
  --   Next
  --
  --   objectLoad.funcs.active_state = 0
  --   objectLoad.current_anim = 0
  --   objectLoad.frame = 0
  --
  --   objectLoad.maxhp = objectLoad.hp
  --   objectLoad.switch_room = -1
  --
  --   LLObject_UniqueCheck( objectLoad )
  --
  --
  --
  --   Return 1
end

-- Loads enemy xml and sprite image files. Assumes enemy.id has at least
-- been initialized with the relative path of an object xml file.
function LLSystem_ObjectFromXML(enemy)

  -- Load enemy properties defined in enemy's object xml.
  log.debug("Loading enemy xml.")
  local enemyXml = getObjectXml(enemy.id)
  log.debug("Loading enemy sprite sheets.")
  local spriteXml = ensureTable(enemyXml.sprite)

  for spriteKey, spriteValue in pairs(spriteXml) do
    if spriteValue.filename then
      log.debug(" spriteValue.filename: "..spriteValue.filename)
      local fixedFileName = string.gsub(spriteValue.filename, "\\", "/")
      log.debug(" fixedFileName: "..fixedFileName)
      local anim = getImageHeader(fixedFileName)
      local animControl = create_LLObject_ImageHeader()
      if spriteValue.rate then
        log.debug(" spriteValue.rate: "..spriteValue.rate)
        animControl.rate = tonumber(spriteValue.rate)
      end
      if spriteValue.dir_frames then
        log.debug(" spriteValue.dir_frames: "..spriteValue.dir_frames)
        animControl.dir_frames = tonumber(spriteValue.dir_frames)
      end
      table.insert(enemy.anim, anim)
      table.insert(enemy.animControl, animControl)
    end
  end
  if enemyXml.fp then
    enemy.fpIndex = 1
    enemy.funcIndex = 1
    enemy.fp = {}
    local fp = {}
    fp.func = {}
    local fpXml = ensureTable(enemyXml.fp)
    for fpKey, fpValue in pairs(fpXml) do
      if fpValue.proc_id then
        local procIdXml = ensureTable(fpValue.proc_id)
        log.debug("  fpValue.proc_id: "..procIdXml[1])
        fp.procId = procIdXml[1]
      end
      if fpValue.func then
        local funcXml = ensureTable(fpValue.func)
        for funcKey, funcValue in pairs(funcXml) do
          log.debug("  funcValue: "..funcValue)
          if funcValue == "second_pause" then
            log.debug( "  Installing second_pause function.")
            table.insert(fp.func, second_pause)
          end
        end
      end
      table.insert(enemy.fp, fp)
    end
  end
end

function updateEnemies()
  for i, enemy in pairs(enemies) do
    if enemy.fp then
      local fp = enemy.fp[enemy.fpIndex]
      if fp.func then
        local func = fp.func
        if func[enemy.funcIndex] then
          if func[enemy.funcIndex](enemy) == 1 then
            --advance to next func of the current fp state
            enemy.funcIndex = enemy.funcIndex + 1
          end
        end
      end
    end
  end
end

-- -- Creates enemy animations from the sprite objects for each enemy. Should
-- -- be called after loadEnemies.
-- function createEnemyAnimations()
--   for i, enemy in pairs(enemies) do
--     enemy.animations = {}
--     for j, spriteObject in pairs(enemy.spriteObjects) do
--       if spriteObject.rate and spriteObject.dirFrames then
--         local spriteSheet = spriteObject.spriteSheet
--         local animation = newAnimation(spriteObject.image, spriteSheet.width,
--           spriteSheet.height, spriteObject.dirFrames, 1)
--         table.insert(enemy.animations, animation)
--       end
--     end
--   end
-- end

-- function updateEnemyAnimations()
--   for i, enemy in pairs(enemies) do
--     if #enemy.animations >=1 then
--       updateAnimation(enemy.animations[1])
--     end
--   end
-- end

function drawEnemies()
  for i, enemy in pairs(enemies) do
    local screenX, screenY = enemy.mapX - camera.x, enemy.mapY - camera.y
    -- if #enemy.animations >= 1 then
    --   drawAnimation(enemy.animations[1], screenX, screenY)
    -- end
  end
end

function second_pause(this)
  local timer = love.timer.getTime()

  if this.pause == 0 then
    this.pause = timer + 1
  end

  if timer >= this.pause then
    log.debug("secondPause completed for enemy: "..this.id)
    this.pause = 0
    return 1
  end

  return 0
end

function active_animate(this)
  local timer = love.timer.getTime()
  -- this->animating = 1
  this.animating = 1
  -- If LLObject_IncrementFrame( this ) <> 0 Then
  if LLObject_IncrementFrame(this) ~= 0 then
  --     this->frame -= 1
    this.frame = this.frame - 1
  --     this->frame_hold = Timer + this->animControl[this->current_anim].rate
    this.frame_hold = timer + this.animControl[this.current_anim].rate
  --     this->animating = 0
    this.animating = 0
  --     Return 1
    return 1
  --  End If
  end
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

function LLObject_CalculateFrame(this)
--( IIf( __THISCHAR__##.uni_directional = 0,
--__THISCHAR__##.frame + ( __THISCHAR__##.direction And 3 ) * __THISCHAR__##.animControl[__THISCHAR__##.current_anim].dir_frames,
--__THISCHAR__##.frame ) )
  if this.uni_directional == 0 then
    return this.frame + (this.direction % 4) * this.animControl[this.current_anim].dir_frames
  else
    return this.frame
  end
end

function LLObject_IgnoreDirectional(this)
--   With *( this )
--     If ( .animating <> 0 ) Then
  if this.animating ~= 0 then
--       Return -1
    return -1
--     End If
  end
--     If ( ( .uni_directional <> 0 ) ) Then
  if this.uni_directional ~= 0 then
-- '      If ( .unique_id <> u_mole ) ) Then
--         Return -1
    return -1
-- '      End If
--     End If
  end
--   End With
end

function LLObject_IncrementFrame(this)
  local timer = love.timer.getTime()
  -- '' Increments an object's frame, doesn't fail.
  -- '' Returns a finished state (1) when ".frame"
  -- '' meets the edge of its range, directional
  -- '' or non-diretcional.
  --
  -- Dim As Double tet
  -- With *( this )
  --   If .frame_hold = 0 Then
  if this.frame_hold == 0 then
  --     dim as integer frameTransfer
    local frameTransfer = 0
  --     frameTransfer = LLObject_CalculateFrame( this[0] )
    frameTransfer = LLObject_CalculateFrame(this)
  --     .animControl[.current_anim].frame[frameTransfer].sound_lock = 0
    this.animControl[this.current_anim].frame[frameTransfer].sound_lock = 0
  --     .frame += 1
    this.frame = this.frame + 1
  --     If .frame = IIf( LLObject_IgnoreDirectional( this ), .anim[.current_anim]->frames, .animControl[.current_anim].dir_frames ) Then
    if this.frame == (LLObject_IgnoreDirectional(this) and this.anim[this.current_anim].frames or this.animControl[this.current_anim].dir_frames) then
  --       Return 1
      return 1
  --     End If
    end
  --     With .animControl[.current_anim]
  --       tet = IIf( ( this->mad = 0 ) Or ( this->dead ), .rate, .rateMad )
    local tet = (this.mad == 0 or this.dead) and this.animControl.rate or this.animControl.rateMad
  --     End With
  --     .frame_hold = Timer + tet
    this.frame_hold = timer + tet
  --   End If
  end
  --   If Timer > .frame_hold Then .frame_hold = 0
  if timer > this.frame_hold then
    this.frame_hold = 0
  end
  -- End With
end
