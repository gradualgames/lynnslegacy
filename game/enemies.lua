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
  --   is_h_set              As uShort
  --
  --   spawn_d               As Integer
  --   is_d_set              As Integer
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
  --   y_origin              As Integer
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
  --     dest_x                As Integer
  --     dest_y                As Integer
  --
  --     sel_seq               As Integer
  --     seq                   As sequence_type Ptr
  --     seq_here              As Integer
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
  --     spawn_info As LLObject_ConditionalSpawn Ptr
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
  --   reserved_6            As Integer
  --
  -- End Type
  return object
end

-- Loads enemy xml and sprite image files from the current map.
function LLSystem_ObjectFromXML()

  for i = 1, map.rooms[curRoom].numEnemies do
    local roomEnemy = map.rooms[curRoom].enemies[i]
    local enemy = create_Object()

    -- Load enemy properties defined in room xml here.
    log.debug("Enemy id: "..roomEnemy.id)
    enemy.id = roomEnemy.id
    log.debug("Enemy x: "..map.rooms[curRoom].enemies[i].xOrigin)
    enemy.coords.x = map.rooms[curRoom].enemies[i].xOrigin
    log.debug("Enemy y: "..map.rooms[curRoom].enemies[i].yOrigin)
    enemy.coords.y = map.rooms[curRoom].enemies[i].yOrigin

    -- Load enemy properties defined in enemy's object xml.
    log.debug("Loading enemy xml.")
    local enemyXml = getObjectXml(roomEnemy.id)
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
    table.insert(enemies, enemy)
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
