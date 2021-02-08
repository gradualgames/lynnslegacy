require("game.engine_enums")
require("game.object_boss")
require("game.object_etc")
require("game.object_time")
require("game.object_gfx")
require("game.object_gfx_animation")
require("game.object_gfx_palette")
require("game.object_move")
require("game.object_sound")
require("game.object_states")
SLAXML = require('lib.SLAXML.slaxml')

-- Loads objectLoad xml and sprite image files. Assumes objectLoad.id has at least
-- been initialized with the relative path of an object xml file.
--NOTE: This code turned out differently from the original codebase due to the
--available XML libraries for Lua, but it accomplishes the same. My favorite
--thing about what happened here is several of the hundreds line long select
--cases turned into one-liners because of the ability to look up functions in
--the global table _G. :)
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
    objectLoad.funcs.current_func[objectLoad.funcs.active_state] = objectLoad.funcs.current_func[objectLoad.funcs.active_state] + 1
  end

  local function install_func(funcName)
    local func = _G[funcName]
    if func then
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
        objectLoad.anim[objectLoad.current_anim] = getImageHeader(text)
        objectLoad.animControl[objectLoad.current_anim] = create_LLObject_ImageHeader()
        --NOTE: In the original code, the animControl.frame array is filled
        --with blank frames, we need to do the same here.
        for i = 0, objectLoad.anim[objectLoad.current_anim].frames - 1 do
          objectLoad.animControl[objectLoad.current_anim].frame[i] = create_LLObject_FrameControl()
        end
      elseif path[3] == "dir_frames" then
        objectLoad.animControl[objectLoad.current_anim].dir_frames = tonumber(text)
      elseif path[3] == "rate" then
        objectLoad.animControl[objectLoad.current_anim].rate = tonumber(text)
      elseif path[3] == "madrate" then
        objectLoad.animControl[objectLoad.current_anim].rateMad = tonumber(text)
      elseif path[3] == "x_off" then
        objectLoad.animControl[objectLoad.current_anim].x_off = tonumber(text)
      elseif path[3] == "y_off" then
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
          for iterateSounds = 0, iif(objectLoad.anim[objectLoad.current_anim].frame[objectLoad.frame].uni_sound ~= 0, 3, 0) do
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
      elseif path[3] == "concurrent" then
        -- Select Case LCase( x->key )
        --
        --   Case "frame"
        if path[4] == "frame" then
        --
        --     #IfDef LL_OBJECTLOADPROGRESS
        --       LLSystem_Log( "Setting up concurrent on frame " & thr->dat.s & ".", "objectload.txt" )
        --
        --     #EndIf
        --
        --     objectLoad.frame = Val( LCase( thr->dat.s ) )
          objectLoad.frame = tonumber(text)
        --
        --     With objectLoad.animControl[objectLoad.current_anim].frame[objectLoad.frame]
          local with0 = objectLoad.animControl[objectLoad.current_anim].frame[objectLoad.frame]
        --       .concurrents += 1
          with0.concurrents = with0.concurrents + 1
        --
        --       #IfDef LL_OBJECTLOADPROGRESS
        --         LLSystem_Log( "Reallocating concurrent array.", "objectload.txt" )
        --
        --       #EndIf
        --
        --       .concurrent = Reallocate( .concurrent, .concurrents * Len( LLObject_FrameConcurrent ) )
        --
        --       #IfDef LL_OBJECTLOADPROGRESS
        --         If .concurrent = 0 Then
        --           LLSystem_Log( "Concurrent array: No memory to form!", "objectload.txt" )
        --
        --         End If
        --
        --         LLSystem_Log( "Initializing concurrent array.", "objectload.txt" )
        --
        --       #EndIf
        --
        --       MemSet( @.concurrent[.concurrents - 1], 0, Len( LLObject_FrameConcurrent ) )
          with0.concurrent[with0.concurrents - 1] = create_LLObject_FrameConcurrent()
        --
        --       #IfDef LL_OBJECTLOADPROGRESS
        --         LLSystem_Log( "Initialized concurrent array.", "objectload.txt" )
        --
        --       #EndIf
        --
        --     End With
        --
        --   Case "x"
        elseif path[4] == "x" then
        --
        --     #IfDef LL_OBJECTLOADPROGRESS
        --       LLSystem_Log( "Setting up concurrent's x.", "objectload.txt" )
        --
        --     #EndIf
        --
        --     With objectLoad.animControl[objectLoad.current_anim].frame[objectLoad.frame]
          local with0 = objectLoad.animControl[objectLoad.current_anim].frame[objectLoad.frame]
        --       .concurrent[.concurrents - 1].origin.x = Val( LCase( thr->dat.s ) )
          with0.concurrent[with0.concurrents - 1].origin.x = tonumber(text)
        --
        --     End With
        --
        --   Case "y"
        elseif path[4] == "y" then
        --
        --     #IfDef LL_OBJECTLOADPROGRESS
        --       LLSystem_Log( "Setting up concurrent's y.", "objectload.txt" )
        --
        --     #EndIf
        --
        --     With objectLoad.animControl[objectLoad.current_anim].frame[objectLoad.frame]
          local with0 = objectLoad.animControl[objectLoad.current_anim].frame[objectLoad.frame]
        --       .concurrent[.concurrents - 1].origin.y = Val( LCase( thr->dat.s ) )
          with0.concurrent[with0.concurrents - 1].origin.y = tonumber(text)
        --
        --     End With
        --
        --   Case "id"
        elseif path[4] == "id" then
        --
        --     #IfDef LL_OBJECTLOADPROGRESS
        --       LLSystem_Log( "Setting up concurrent's object.", "objectload.txt" )
        --
        --     #EndIf
        --
        --     With objectLoad.animControl[objectLoad.current_anim].frame[objectLoad.frame]
          local with0 = objectLoad.animControl[objectLoad.current_anim].frame[objectLoad.frame]
        --       .concurrent[.concurrents - 1].char = CAllocate( Len( char_type ) )
          with0.concurrent[with0.concurrents - 1].char = create_Object()
        --       .concurrent[.concurrents - 1].char->id = LCase( thr->dat.s )
          with0.concurrent[with0.concurrents - 1].char.id = text
        --
        --     End With
          --NOTE: The original codebase deferred actually loading the XML of concurrent
          --objects until deep copies are performed from a cache. In this codebase,
          --we cache xml and re-load the xml any time a "deep copy" is made, so we
          --load the concurrent xml right here instead.
          LLSystem_CopyNewObject(with0.concurrent[with0.concurrents - 1].char)
        --
        -- End Select
        end
      end
    elseif path[2] == "fp" then
      if path[3] == "proc_id" then
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
      elseif path[3] == "func" then
        objectLoad.funcs.func_count[objectLoad.funcs.active_state] = objectLoad.funcs.func_count[objectLoad.funcs.active_state] + 1
        local funcName = "__"..text
        install_func(funcName)
      elseif path[3] == "block_macro" then
        if text == "dead_block" then
          objectLoad.funcs.func_count[objectLoad.funcs.active_state] = objectLoad.funcs.func_count[objectLoad.funcs.active_state] + 6
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
          -- func_drop = CPtr( Any Ptr, @__do_flyback       ): inc_func
          install_func("__do_flyback")
          -- func_drop = CPtr( Any Ptr, @__second_pause     ): inc_func
          install_func("__second_pause")
          -- func_drop = CPtr( Any Ptr, @__return_idle      ): inc_func
          install_func("__return_idle")
        elseif text == "ice_block" then
          objectLoad.funcs.func_count[objectLoad.funcs.active_state] = objectLoad.funcs.func_count[objectLoad.funcs.active_state] + 3
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
        -- #Define LLObject_SoundLoad(__Sound__) _
        --   Case ###__Sound__: objectLoad.sound[objectLoad.sounds - 1] = __Sound__
        objectLoad.sound[objectLoad.sounds - 1] = _G[text]
      elseif path[3] == "vol" then
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
      local convertedValue = tonumber(text)
      if convertedValue == nil then
        objectLoad[attribute] = text
        local enum = _G[text]
        if enum then
          objectLoad[attribute] = enum
        end
      else
        objectLoad[attribute] = convertedValue
      end
    end
  end

  local startElement = function(name, nsURI, nsPrefix)
    table.insert(path, name)
    if name == "sprite" then
      objectLoad.current_anim = objectLoad.anims
      objectLoad.anims = objectLoad.anims + 1
    elseif name == "fp" then
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
      objectLoad.sounds = objectLoad.sounds + 1
    end
  end

  local closeElement = function(name, nsURI)
    table.remove(path)
    if name == "fp" then
      objectLoad.funcs.current_func[objectLoad.funcs.active_state] = 0
    end
  end

  local xmlData = getObjectXml(objectLoad.id)
  local parser = SLAXML:parser {
    startElement = startElement,
    attribute = function(name, value, nsURI, nsPrefix) end,
    closeElement = closeElement,
    text = text,
    comment = function(content) end,
    pi = function(target, content) end,
  }
  parser:parse(xmlData, {stripWhitespace = true})

  --Some attributes have different names from xml when they become part of
  --an objectLoad.
  if objectLoad.real_x ~= nil then objectLoad.perimeter.x = objectLoad.real_x end
  if objectLoad.real_y ~= nil then objectLoad.perimeter.y = objectLoad.real_y end
  --Case sensitivity made this necessary. The code always refers to isBoss
  --but xml has it all lowercase as isboss.
  if objectLoad.isboss ~= nil then objectLoad.isBoss = objectLoad.isboss end

end
