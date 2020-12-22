require("game/engine_enums")
require("game/object_boss")
require("game/object_etc")
require("game/object_time")
require("game/object--gfx")
require("game/object--gfx_animation")
require("game/object--gfx_palette")
require("game/object_move")
require("game/object_sound")
require("game/object_states")
SLAXML = require 'lib/SLAXML/slaxml'

-- Loads objectLoad xml and sprite image files. Assumes objectLoad.id has at least
-- been initialized with the relative path of an object xml file.
function LLSystem_ObjectFromXML(objectLoad)
  --   #Define func_drop objectLoad.funcs.func[objectLoad.funcs.active_state][objectLoad.funcs.current_func[objectLoad.funcs.active_state]]
  local function func_drop(func)
    local funcList = objectLoad.funcs.func[objectLoad.funcs.active_state]
    funcList[objectLoad.funcs.current_func[objectLoad.funcs.active_state]] = func
  end
--   #Define inc_func  objectLoad.funcs.current_func[objectLoad.funcs.active_state] += 1:
--                       If objectLoad.funcs.current_func[objectLoad.funcs.active_state] = objectLoad.funcs.func_count[objectLoad.funcs.active_state] Then
--                         objectLoad.funcs.current_func[objectLoad.funcs.active_state] = 0
  local function inc_func()
    --log.debug("inc_func called.")
    objectLoad.funcs.current_func[objectLoad.funcs.active_state] = objectLoad.funcs.current_func[objectLoad.funcs.active_state] + 1
    -- log.debug("objectLoad.funcs.current_func[objectLoad.funcs.active_state]: "..objectLoad.funcs.current_func[objectLoad.funcs.active_state])
    -- log.debug("objectLoad.funcs.func_count[objectLoad.funcs.active_state]: "..objectLoad.funcs.func_count[objectLoad.funcs.active_state])
    -- if objectLoad.funcs.current_func[objectLoad.funcs.active_state] == objectLoad.funcs.func_count[objectLoad.funcs.active_state] then
    --   log.debug("Resetting current_func to 1 for active state: "..objectLoad.funcs.active_state)
    --   objectLoad.funcs.current_func[objectLoad.funcs.active_state] = 1
    -- end
  end

  local function install_func(funcName)
    local func = _G[funcName]
    if func then
      log.debug("Installing func: "..funcName)
      func_drop(_G[funcName])
      -- func_drop(function(this)
      --   log.debug("Called: "..funcName.." on: "..this.id)
      --   return _G[funcName](this)
      -- end)
      inc_func()
    else
      log.debug("Installing no-op func for: "..funcName)
      func_drop(
        function(this)
          log.debug("TODO: Implement: "..funcName.." for: "..this.id)
          return 0
        end)
      inc_func()
    end
  end

  local path = {}

  local text = function(text, cdata)
    -- log.debug("Processing text: "..text)
    -- log.debug("At path:")
    -- for key, value in pairs(path) do
    --   log.debug(value)
    -- end
    text = string.gsub(text, "\\", "/")
    if path[2] == "sprite" then
      if path[3] == "anim_id" then
        -- Select Case LCase( thr->dat.s )
        --   Case "dead_anim"
        if text == "dead_anim" then
        --     .dead_anim = .current_anim
          objectLoad.dead_anim = objectLoad.current_anim
        --   Case "proj_anim"
        elseif text == "proj_anim" then
        --     .proj_anim = .current_anim
          objectLoad.proj_anim = objectLoad.current_anim
        --   Case "expl_anim"
        elseif text == "expl_anim" then
        --     .expl_anim = .current_anim
          objectLoad.expl_anim = objectLoad.current_anim
        --
        -- End Select
        end
      elseif path[3] == "filename" then
        --log.debug(" Processing sprite/filename: "..text)
        objectLoad.anim[objectLoad.current_anim] = getImageHeader(text)
        objectLoad.animControl[objectLoad.current_anim] = create_LLObject_ImageHeader()
        --NOTE: In the original code, the animControl.frame array is filled
        --with blank frames, we need to do the same here.
        for i = 0, objectLoad.anim[objectLoad.current_anim].frames - 1 do
          objectLoad.animControl[objectLoad.current_anim].frame[i] = create_LLObject_FrameControl()
        end
      elseif path[3] == "dir_frames" then
        --log.debug( " Processing sprite/dir_frames: "..text)
        objectLoad.animControl[objectLoad.current_anim].dir_frames = tonumber(text)
      elseif path[3] == "rate" then
        --log.debug( " Processing sprite/rate: "..text)
        objectLoad.animControl[objectLoad.current_anim].rate = tonumber(text)
      elseif path[3] == "x_off" then
        --log.debug( " Processing sprite/x_off: "..text)
        objectLoad.animControl[objectLoad.current_anim].x_off = tonumber(text)
      elseif path[3] == "y_off" then
        --log.debug( " Processing sprite/y_off: "..text)
        objectLoad.animControl[objectLoad.current_anim].y_off = tonumber(text)
      elseif path[3] == "sound" then
          -- Case "frame"
        if path[4] == "frame" then
          --   objectLoad.frame = Val( thr->dat.s )
          objectLoad.frame = tonumber(text)
          -- Case "uni_sound"
        elseif path[4] == "uni_sound" then
            -- objectLoad.anim[objectLoad.current_anim]->frame[objectLoad.frame].uni_sound = Val( thr->dat.s )
          objectLoad.anim[objectLoad.current_anim].frame[objectLoad.frame].uni_sound = tonumber(text)
          -- Case "index"
        elseif path[4] == "index" then
          log.debug( " Processing sprite/sound: "..text)
          -- With objectLoad.anim[objectLoad.current_anim]->frame[objectLoad.frame]
          local with0 = objectLoad.anim[objectLoad.current_anim].frame[objectLoad.frame]
          --
          --   #macro LLObject_FrameSoundLoad(__FrameSound__)
          --
          --     Case ###__FrameSound__
          --
          --       dim as integer iterateSounds, holdFrame
          local iterateSounds, holdFrame = 0, 0
          --
          --       holdFrame = objectLoad.frame
          holdFrame = objectLoad.frame
          --
          --       for iterateSounds = 0 to iif( objectLoad.anim[objectLoad.current_anim]->frame[objectLoad.frame].uni_sound, 3, 0 )
          for iterateSounds = 0, ((objectLoad.anim[objectLoad.current_anim].frame[objectLoad.frame].uni_sound ~= 0) and 3 or 0) do
          --
          --         objectLoad.anim[objectLoad.current_anim]->frame[objectLoad.frame].sound = __FrameSound__
            objectLoad.anim[objectLoad.current_anim].frame[objectLoad.frame].sound = _G[text]
          --         objectLoad.frame += objectLoad.animControl[objectLoad.current_anim].dir_frames
            objectLoad.frame = objectLoad.frame + objectLoad.animControl[objectLoad.current_anim].dir_frames
          --
          --       next
          end
          --
          --       objectLoad.frame = holdFrame
          objectLoad.frame = holdFrame
          --
          --   #endmacro
        elseif path[4] == "vol" then
          -- dim as integer iterateSounds, holdFrame
          local iterateSounds, holdFrame = 0, 0
          --
          --  holdFrame = objectLoad.frame
          holdFrame = objectLoad.frame
          --
          --  for iterateSounds = 0 to iif( objectLoad.anim[objectLoad.current_anim]->frame[objectLoad.frame].uni_sound, 3, 0 )
          for iterateSounds = 0, iif(objectLoad.anim[objectLoad.current_anim].frame[objectLoad.frame].uni_sound, 3, 0) do
          --
          --    objectLoad.anim[objectLoad.current_anim]->frame[objectLoad.frame].vol = Val( thr->dat.s )
            objectLoad.anim[objectLoad.current_anim].frame[objectLoad.frame].vol = tonumber(text)
          --    objectLoad.frame += objectLoad.animControl[objectLoad.current_anim].dir_frames
            objectLoad.frame = objectLoad.frame + objectLoad.animControl[objectLoad.current_anim].dir_frames
          --
          --  next
          end
          --
          --  objectLoad.frame = holdFrame
          objectLoad.frame = holdFrame
        end
      end
    elseif path[2] == "fp" then
      if path[3] == "proc_id" then
        --log.debug(" proc_id text: "..text)
--
--           #Define LLObject_ProcIDLoad(__Proc_ID__) _
--             Case ###__Proc_ID__: objectLoad.##__Proc_ID__ = objectLoad.funcs.active_state
--
--           Select Case LCase( thr->dat.s )
--
--             LLObject_ProcIDLoad( hit_state    )
--             LLObject_ProcIDLoad( attack_state )
--             LLObject_ProcIDLoad( death_state  )
--             LLObject_ProcIDLoad( fire_state   )
--             LLObject_ProcIDLoad( hit_state    )
--             LLObject_ProcIDLoad( ice_state    )
--             LLObject_ProcIDLoad( jump_state   )
--             LLObject_ProcIDLoad( proj_state   )
--             LLObject_ProcIDLoad( reset_state  )
--             LLObject_ProcIDLoad( stun_state   )
--             LLObject_ProcIDLoad( thaw_state   )
--             LLObject_ProcIDLoad( thrust_state )
--
--           End Select
        --NOTE: I think this one line is equivalent to the above select case.
        --In lua, we table["property"] is equivalent to table.property. We can
        --use the proc_id text directly from the xml to set it to the value of the
        --current active state, which is what is being done above.
        objectLoad[text] = objectLoad.funcs.active_state
        --log.debug(" active_state is: "..objectLoad[text])
      elseif path[3] == "func" then
        objectLoad.funcs.func_count[objectLoad.funcs.active_state] = objectLoad.funcs.func_count[objectLoad.funcs.active_state] + 1
        local funcName = "__"..text
        install_func(funcName)
      elseif path[3] == "block_macro" then
        if text == "dead_block" then
          objectLoad.funcs.func_count[objectLoad.funcs.active_state] = objectLoad.funcs.func_count[objectLoad.funcs.active_state] + 6
          --log.debug("Installing functions for block_macro 'dead_block'")
          -- func_drop = CPtr( Any Ptr, @__make_dead        ): inc_func
          install_func("__make_dead")
          -- func_drop = CPtr( Any Ptr, @__active_anim_dead ): inc_func
          install_func("__active_anim_dead")
          -- func_drop = CPtr( Any Ptr, @__dead_animate     ): inc_func
          install_func("__dead_animate")
          -- func_drop = CPtr( Any Ptr, @__cripple          ): inc_func
          install_func("__cripple")
          -- func_drop = CPtr( Any Ptr, @__active_anim_0    ): inc_func
          install_func("__active_anim_0")
          -- func_drop = CPtr( Any Ptr, @__infinity         ): inc_func
          install_func("__infinity")
        elseif text == "dead_drop_block" then
          objectLoad.funcs.func_count[objectLoad.funcs.active_state] = objectLoad.funcs.func_count[objectLoad.funcs.active_state] + 7
          --log.debug("Installing functions for block_macro 'dead_drop_block'")
          -- func_drop = CPtr( Any Ptr, @__make_dead        ): inc_func
          install_func("__make_dead")
          -- func_drop = CPtr( Any Ptr, @__active_anim_dead ): inc_func
          install_func("__active_anim_dead")
          -- func_drop = CPtr( Any Ptr, @__dead_animate     ): inc_func
          install_func("__dead_animate")
          -- func_drop = CPtr( Any Ptr, @__cripple          ): inc_func
          install_func("__cripple")
          -- func_drop = CPtr( Any Ptr, @__drop             ): inc_func
          install_func("__drop")
          -- func_drop = CPtr( Any Ptr, @__active_anim_0    ): inc_func
          install_func("__active_anim_0")
          -- func_drop = CPtr( Any Ptr, @__infinity         ): inc_func
          install_func("__infinity")
        elseif text == "fire_block" then
          objectLoad.funcs.func_count[objectLoad.funcs.active_state] = objectLoad.funcs.func_count[objectLoad.funcs.active_state] + 3
          --log.debug("Installing functions for block_macro 'fire_block'")
          -- func_drop = CPtr( Any Ptr, @__do_flyback       ): inc_func
          install_func("__do_flyback")
          -- func_drop = CPtr( Any Ptr, @__second_pause     ): inc_func
          install_func("__second_pause")
          -- func_drop = CPtr( Any Ptr, @__return_idle      ): inc_func
          install_func("__return_idle")
        elseif text == "ice_block" then
          objectLoad.funcs.func_count[objectLoad.funcs.active_state] = objectLoad.funcs.func_count[objectLoad.funcs.active_state] + 3
          --log.debug("Installing functions for block_macro 'ice_block'")
          -- func_drop = CPtr( Any Ptr, @__second_pause     ): inc_func
          install_func("__second_pause")
          -- func_drop = CPtr( Any Ptr, @__second_pause     ): inc_func
          install_func("__second_pause")
          -- func_drop = CPtr( Any Ptr, @__return_idle      ): inc_func
          install_func("__return_idle")
        end
      end
    elseif path[2] == "snd" then
      if path[3] == "index" then
        log.debug("Processing index tag.")
        -- #Define LLObject_SoundLoad(__Sound__) _
        --   Case ###__Sound__: objectLoad.sound[objectLoad.sounds - 1] = __Sound__
        objectLoad.sound[objectLoad.sounds - 1] = _G[text]
        log.debug("Looked up value: "..objectLoad.sound[objectLoad.sounds - 1].." for sound name: "..text)
      elseif path[3] == "vol" then
        log.debug("Processing vol tag.")
        -- objectLoad.vol[objectLoad.sounds - 1] =  Val( thr->dat.s )
        objectLoad.vol[objectLoad.sounds - 1] = tonumber(text) / 100
      end
    elseif path[2] == "proj_style" then
      objectLoad.proj_style = _G[text]
      objectLoad.projectile = create_ll_entity_projectile()
      if objectLoad.proj_style == PROJECTILE_FIREBALL then
        objectLoad.projectile.projectiles = 1
      elseif objectLoad.proj_style == PROJECTILE_ORB then
        objectLoad.projectile.projectiles = 2
      elseif objectLoad.proj_style == PROJECTILE_BEAM then
        objectLoad.projectile.projectiles = 2
      elseif objectLoad.proj_style == PROJECTILE_DIAGONAL then
        objectLoad.projectile.projectiles = 4
      elseif objectLoad.proj_style == PROJECTILE_CROSS then
        objectLoad.projectile.projectiles = 4
      elseif objectLoad.proj_style == PROJECTILE_8WAY then
        objectLoad.projectile.projectiles = 8
      elseif objectLoad.proj_style == PROJECTILE_SCHIZO then
        objectLoad.projectile.projectiles = 24
      elseif objectLoad.proj_style == PROJECTILE_SPIRAL then
        objectLoad.projectile.projectiles = 8
      elseif objectLoad.proj_style == PROJECTILE_SUN then
        objectLoad.projectile.projectiles = 128
      elseif objectLoad.proj_style == PROJECTILE_TRACK then
        objectLoad.projectile.projectiles = 1
      end
      objectLoad.projectile.coords = {}
      for i = 0, objectLoad.projectile.projectiles - 1 do
        objectLoad.projectile.coords[i] = create_vector()
      end
    elseif path[2] == "proj_invis" then
      objectLoad.projectile.invisible = tonumber(text)
    elseif path[2] == "proj_dur" then
      objectLoad.projectile.length = tonumber(text)
    elseif path[2] == "proj_over" then
      objectLoad.projectile.overChar = tonumber(text)
    elseif path[2] == "proj_sound" then
      objectLoad.projectile.sound = tonumber(text)
    elseif path[2] == "proj_str" then
      objectLoad.projectile.strength = tonumber(text)
    elseif #path == 2 then
      local attribute = path[2]
      --log.debug("Found attribute: "..attribute)
      local convertedValue = tonumber(text)
      if convertedValue == nil then
        --log.debug("Attribute string value: "..text)
        objectLoad[attribute] = text
        local enum = _G[text]
        if enum then
          --log.debug("Attribute was an enum, replacing with value: "..enum)
          objectLoad[attribute] = enum
        end
      else
        --log.debug("Attribute number value: "..text)
        objectLoad[attribute] = convertedValue
      end
    end
  end

  local startElement = function(name, nsURI, nsPrefix)
    table.insert(path, name)
    if name == "sprite" then
      log.debug("Processing sprite tag.")
      objectLoad.current_anim = objectLoad.anims
      objectLoad.anims = objectLoad.anims + 1
    elseif name == "fp" then
      --log.debug("Processing fp tag.")
      --NOTE: This chunk comes from a select statement higher up
      --in the FB code that performs allocation and counting. It
      --makes more sense here due to how we are processing the xml.
      --         .funcs.states += 1
      --
      --         .funcs.func_count   = Reallocate( .funcs.func_count,   .funcs.states * Len( Integer ) )
      --         .funcs.current_func = Reallocate( .funcs.current_func, .funcs.states * Len( Integer ) )
      --
      --         .funcs.func         = Reallocate( .funcs.func,         .funcs.states * Len( fp Ptr )  )
      --
      --         .funcs.active_state = .funcs.states - 1
      --
      --         .funcs.func_count[.funcs.active_state] = 0
      --         .funcs.current_func[.funcs.active_state] = 0
      objectLoad.funcs.active_state = objectLoad.funcs.states
      objectLoad.funcs.func[objectLoad.funcs.active_state] = {}
      objectLoad.funcs.func_count[objectLoad.funcs.active_state] = 0
      objectLoad.funcs.current_func[objectLoad.funcs.active_state] = 0
      objectLoad.funcs.states = objectLoad.funcs.states + 1
    elseif name == "snd" then
      log.debug("Processing snd tag.")
      objectLoad.sounds = objectLoad.sounds + 1
    end
  end

  local closeElement = function(name, nsURI)
    table.remove(path)
    if name == "fp" then
      --log.debug("fp tag closed, resetting current_func for that state.")
      objectLoad.funcs.current_func[objectLoad.funcs.active_state] = 0
    end
  end

  local xmlData = getObjectXml(objectLoad.id)
  -- Specify as many/few of these as you like
  local parser = SLAXML:parser{
    startElement = startElement, -- When "<foo" or <x:foo is seen
    attribute    = function(name,value,nsURI,nsPrefix) end, -- attribute found on current element
    closeElement = closeElement, -- When "</foo>" or </x:foo> or "/>" is seen
    text         = text, -- text and CDATA nodes (cdata is true for cdata nodes)
    comment      = function(content)                   end, -- comments
    pi           = function(target,content)            end, -- processing instructions e.g. "<?yes mon?>"
  }
  parser:parse(xmlData, {stripWhitespace=true})

  --Some attributes have different names from xml when they become part of
  --an objectLoad.
  if objectLoad.real_x ~= nil then objectLoad.perimeter.x = objectLoad.real_x end
  if objectLoad.real_y ~= nil then objectLoad.perimeter.y = objectLoad.real_y end

end
