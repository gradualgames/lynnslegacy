require("game/load/loadxml")
require("game/animation")
require("game/cache")

-- Loads enemy xml and sprite image files from the current map.
function loadEnemies()

  for i = 1, map.rooms[curRoom].numEnemies do
    local roomEnemy = map.rooms[curRoom].enemies[i]
    local enemy = {}

    -- Initialize enemy properties not defined in xml here.
    enemy.pause = 0
    enemy.animating = 0
    enemy.frame = 0
    enemy.frame_hold = 0
    enemy.animControl = create_LLObject_ImageHeader()

    -- Load enemy properties defined in room xml here.
    log.debug("Enemy id: "..roomEnemy.id)
    enemy.id = roomEnemy.id
    log.debug("Enemy x: "..map.rooms[curRoom].enemies[i].xOrigin)
    enemy.mapX = map.rooms[curRoom].enemies[i].xOrigin
    log.debug("Enemy y: "..map.rooms[curRoom].enemies[i].yOrigin)
    enemy.mapY = map.rooms[curRoom].enemies[i].yOrigin

    -- Load enemy properties defined in enemy's object xml.
    log.debug("Loading enemy xml.")
    local enemyXml = getObjectXml(roomEnemy.id)
    log.debug("Loading enemy sprite sheets.")
    local spriteXml = ensureTable(enemyXml.sprite)
    enemy.spriteObjects = {}
    for spriteKey, spriteValue in pairs(spriteXml) do
      if spriteValue.filename then
        log.debug(" spriteValue.filename: "..spriteValue.filename)
        local fixedFileName = string.gsub(spriteValue.filename, "\\", "/")
        log.debug(" fixedFileName: "..fixedFileName)
        local spriteObject = getSpriteObject(fixedFileName)
        if spriteValue.rate then
          log.debug(" spriteValue.rate: "..spriteValue.rate)
          spriteObject.rate = tonumber(spriteValue.rate)
        end
        if spriteValue.dir_frames then
          log.debug(" spriteValue.dir_frames: "..spriteValue.dir_frames)
          spriteObject.dirFrames = tonumber(spriteValue.dir_frames)
        end
        table.insert(enemy.spriteObjects, spriteObject)
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

-- Creates enemy animations from the sprite objects for each enemy. Should
-- be called after loadEnemies.
function createEnemyAnimations()
  for i, enemy in pairs(enemies) do
    enemy.animations = {}
    for j, spriteObject in pairs(enemy.spriteObjects) do
      if spriteObject.rate and spriteObject.dirFrames then
        local spriteSheet = spriteObject.spriteSheet
        local animation = newAnimation(spriteObject.image, spriteSheet.width,
          spriteSheet.height, spriteObject.dirFrames, 1)
        table.insert(enemy.animations, animation)
      end
    end
  end
end

function updateEnemyAnimations()
  for i, enemy in pairs(enemies) do
    if #enemy.animations >=1 then
      updateAnimation(enemy.animations[1])
    end
  end
end

function drawEnemies()
  for i, enemy in pairs(enemies) do
    local screenX, screenY = enemy.mapX - camera.x, enemy.mapY - camera.y
    if #enemy.animations >= 1 then
      drawAnimation(enemy.animations[1], screenX, screenY)
    end
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

function create_vector()
  local vector = {}
  vector.x = 0
  vector.y = 0
  return vector
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
